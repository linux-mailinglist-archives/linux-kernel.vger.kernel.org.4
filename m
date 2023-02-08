Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBAEA68EC0C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 10:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbjBHJtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 04:49:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjBHJtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 04:49:23 -0500
Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E449A13DDF
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 01:49:21 -0800 (PST)
HMM_SOURCE_IP: 172.18.0.188:58042.1886889107
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-36.111.64.85 (unknown [172.18.0.188])
        by chinatelecom.cn (HERMES) with SMTP id D71532800AF;
        Wed,  8 Feb 2023 17:49:12 +0800 (CST)
X-189-SAVE-TO-SEND: +liuq131@chinatelecom.cn
Received: from  ([36.111.64.85])
        by app0023 with ESMTP id 445ad0df776c47cc8e5c8aff04e70ff5 for akpm@linux-foundation.org;
        Wed, 08 Feb 2023 17:49:19 CST
X-Transaction-ID: 445ad0df776c47cc8e5c8aff04e70ff5
X-Real-From: liuq131@chinatelecom.cn
X-Receive-IP: 36.111.64.85
X-MEDUSA-Status: 0
Sender: liuq131@chinatelecom.cn
From:   liuq <liuq131@chinatelecom.cn>
To:     akpm@linux-foundation.org
Cc:     agruenba@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, huyd12@chinatelecom.cn,
        liuq <liuq131@chinatelecom.cn>
Subject: [PATCH] pid: add handling of too many zombie processes
Date:   Wed,  8 Feb 2023 17:49:05 +0800
Message-Id: <20230208094905.373-1-liuq131@chinatelecom.cn>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a common situation that a parent process forks many child
processes to execute tasks, but the parent process does not execute
wait/waitpid when the child process exits, resulting in a large
number of child processes becoming zombie processes.

At this time, if the number of processes in the system out of
kernel.pid_max, the new fork syscall will fail, and the system will
not be able to execute any command at this time
(unless an old process exits)

eg:
[root@lq-workstation ~]# ls
-bash: fork: retry: Resource temporarily unavailable
-bash: fork: retry: Resource temporarily unavailable
-bash: fork: retry: Resource temporarily unavailable
-bash: fork: retry: Resource temporarily unavailable
-bash: fork: Resource temporarily unavailable
[root@lq-workstation ~]# reboot
-bash: fork: retry: Resource temporarily unavailable
-bash: fork: retry: Resource temporarily unavailable
-bash: fork: retry: Resource temporarily unavailable
-bash: fork: retry: Resource temporarily unavailable
-bash: fork: Resource temporarily unavailable

I dealt with this situation in the alloc_pid function,
and found a process with the most zombie subprocesses,
and more than 10(or other reasonable values?) zombie subprocesses,
so I tried to kill this process to release the pid resources.

Signed-off-by: liuq <liuq131@chinatelecom.cn>
---
 include/linux/mm.h |  2 ++
 kernel/pid.c       |  6 +++-
 mm/oom_kill.c      | 70 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 77 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8f857163ac89..afcff08a3878 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1940,6 +1940,8 @@ static inline void clear_page_pfmemalloc(struct page *page)
  * Can be called by the pagefault handler when it gets a VM_FAULT_OOM.
  */
 extern void pagefault_out_of_memory(void);
+extern void pid_max_oom_check(struct pid_namespace *ns);
+
 
 #define offset_in_page(p)	((unsigned long)(p) & ~PAGE_MASK)
 #define offset_in_thp(page, p)	((unsigned long)(p) & (thp_size(page) - 1))
diff --git a/kernel/pid.c b/kernel/pid.c
index 3fbc5e46b721..1a9a60e19ab6 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -237,7 +237,11 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
 		idr_preload_end();
 
 		if (nr < 0) {
-			retval = (nr == -ENOSPC) ? -EAGAIN : nr;
+			retval = nr;
+			if (nr == -ENOSPC) {
+				retval = -EAGAIN;
+				pid_max_oom_check(tmp);
+			}
 			goto out_free;
 		}
 
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 1276e49b31b0..18d05d706f48 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -1260,3 +1260,73 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
 	return -ENOSYS;
 #endif /* CONFIG_MMU */
 }
+
+static void oom_pid_evaluate_task(struct task_struct *p,
+	struct task_struct **max_zombie_task, int *max_zombie_num)
+{
+	struct task_struct *child;
+	int zombie_num = 0;
+
+	list_for_each_entry(child, &p->children, sibling) {
+		if (child->exit_state == EXIT_ZOMBIE)
+			zombie_num++;
+	}
+	if (zombie_num > *max_zombie_num) {
+		*max_zombie_num = zombie_num;
+		*max_zombie_task = p;
+	}
+}
+#define MAX_ZOMBIE_NUM 10
+struct task_struct *pid_max_bad_process(struct pid_namespace *ns)
+{
+	int max_zombie_num = 0;
+	struct task_struct *max_zombie_task = &init_task;
+	struct task_struct *p;
+
+	rcu_read_lock();
+	for_each_process(p)
+		oom_pid_evaluate_task(p, &max_zombie_task, &max_zombie_num);
+	rcu_read_unlock();
+
+	if (max_zombie_num > MAX_ZOMBIE_NUM) {
+		pr_info("process %d has %d zombie child\n",
+			task_pid_nr_ns(max_zombie_task, ns), max_zombie_num);
+		return max_zombie_task;
+	}
+
+	return NULL;
+}
+
+void pid_max_oom_kill_process(struct task_struct *task)
+{
+	struct oom_control oc = {
+		.zonelist = NULL,
+		.nodemask = NULL,
+		.memcg = NULL,
+		.gfp_mask = 0,
+		.order = 0,
+	};
+
+	get_task_struct(task);
+	oc.chosen = task;
+
+	if (mem_cgroup_oom_synchronize(true))
+		return;
+
+	if (!mutex_trylock(&oom_lock))
+		return;
+
+	oom_kill_process(&oc, "Out of pid max(oom_kill_allocating_task)");
+	mutex_unlock(&oom_lock);
+}
+
+void pid_max_oom_check(struct pid_namespace *ns)
+{
+	struct task_struct *p;
+
+	p = pid_max_bad_process(ns);
+	if (p) {
+		pr_info("oom_kill process %d\n", task_pid_nr_ns(p, ns));
+		pid_max_oom_kill_process(p);
+	}
+}
-- 
2.27.0

