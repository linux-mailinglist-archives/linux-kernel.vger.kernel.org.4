Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3DDA5E9CFE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 11:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234627AbiIZJKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 05:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234486AbiIZJKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 05:10:44 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6913A159
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 02:10:42 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id a5-20020a17090aa50500b002008eeb040eso12178961pjq.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 02:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=4c6rsA/nj+c23v2pL8EFuT0jFlHDAIqFaKKXHCIq3T0=;
        b=VYqF48rXQrsaARUdMc7oQLC1cOOk8WAYwJtqdYenUUNGxHxOII7mbSGfI/5iP12/vB
         gkPtW0roD9QYEUoeTpZKPJElv5gbdBl4Wymy94NY5vbQAhHaqWtmNmDj2FIO+eSkkTYv
         5pSuzqhw1NuKJq0OODskkl3dL3iswXXxXSvZja6hiYJ/YzhQRBYVQXxiZAPy0++CEtZT
         Vz/KmpnlwGZVqA/k8du1ZxK2kpVIh/Uv8JlAGr6g1bRbvEZfji9gFHd2dwtJQyT/UHSk
         sYuj43DfsFqY0VtbgEvg39TjoI5nDMa+NSWQWsCQcV4yo1foy6wUdx0cvS1/xAA1V3N6
         FZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=4c6rsA/nj+c23v2pL8EFuT0jFlHDAIqFaKKXHCIq3T0=;
        b=F18AeVmq9J+Z3wmUnC+EkdLsHdJIQYcEdfU5lT31J9eATcmsvYTWlobvfG+bzxe3gC
         xN86fQPS37Ztse2vCBXco6zN2DoWrU3dSzeV6ZPy4mA3pAhWQECx5cz4tyCQG/H8X2Zx
         DYJpxnPc7TPZOnza1JE9RCmJzFOzCwfqueCARKugopoB7zQ4qFNIXrUvihkm/fGscf90
         qadu6XIUdUnGMvLZT3v6wIgVHyEOoCQwf2RaAWDDIzGYJr/CRjjB4wWeKkwg4EJoXkxv
         mjJTBox44Za7baea2AmtNaAOqj550CASGE4w12VfhODfPZruoY4Byavqx06YL/BODu88
         Tl0w==
X-Gm-Message-State: ACrzQf19vd7ys9QAZ1EsLSjFy6Eq5zmMB1TNCHj5VqAMQU/rcPJo8+F9
        ZvGI1WuuB5otBYNHcTIeZaq76A==
X-Google-Smtp-Source: AMsMyM7E7EZRWTnSrzkr3k8Aigg7dre7T8cfu0oIbNgzQXLcoHg8AW+DjGUt0mEMLzGGmypeBdEAiw==
X-Received: by 2002:a17:90b:4d8f:b0:202:6634:997e with SMTP id oj15-20020a17090b4d8f00b002026634997emr24167098pjb.237.1664183441624;
        Mon, 26 Sep 2022 02:10:41 -0700 (PDT)
Received: from R911R1VA-1UT.bytedance.net ([139.177.225.229])
        by smtp.gmail.com with ESMTPSA id om12-20020a17090b3a8c00b0020263b7177csm20826852pjb.3.2022.09.26.02.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 02:10:41 -0700 (PDT)
From:   hezhongkun <hezhongkun.hzk@bytedance.com>
To:     corbet@lwn.net, akpm@linux-foundation.org, mhocko@suse.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, wuyun.abel@bytedance.com,
        Zhongkun He <hezhongkun.hzk@bytedance.com>
Subject: [RFC] proc: Add a new isolated /proc/pid/mempolicy type.
Date:   Mon, 26 Sep 2022 17:10:33 +0800
Message-Id: <20220926091033.340-1-hezhongkun.hzk@bytedance.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhongkun He <hezhongkun.hzk@bytedance.com>

/proc/pid/mempolicy can be used to check and adjust the userspace task's
mempolicy dynamically.In many case, the application and the control plane
are two separate systems. When the application is created, it doesn't know
how to use memory, and it doesn't care. The control plane will decide the
memory usage policy based on different reasons.In that case, we can
dynamically adjust the mempolicy using /proc/pid/mempolicy interface.

Format of input:
----------------
<mode>[=<flags>][:<nodelist>]

Example
-------
set mempolicy:
 $ echo "interleave=static:0-3" > /proc/27036/mempolicy
 $ cat /proc/27036/mempolicy
 interleave=static:0-3
remove mempolicy:
+  $ echo "default" > /proc/27036/mempolicy

The following 6 mempolicy mode types：
"default" "prefer"  "bind" "interleave" "local" "prefer (many)"

The supported mode flags are:
"static" "relative"

nodelist         For example：0-3 or 0,1,2,3

Signed-off-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
---
 Documentation/filesystems/proc.rst |  40 +++++++++
 fs/proc/base.c                     |   2 +
 fs/proc/internal.h                 |   1 +
 fs/proc/task_mmu.c                 | 129 +++++++++++++++++++++++++++++
 include/linux/mempolicy.h          |   5 --
 mm/mempolicy.c                     |   2 -
 6 files changed, 172 insertions(+), 7 deletions(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index e7aafc82be99..fa7bc24c6a91 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -47,6 +47,8 @@ fixes/update part 1.1  Stefani Seibold <stefani@seibold.net>    June 9 2009
   3.10  /proc/<pid>/timerslack_ns - Task timerslack value
   3.11	/proc/<pid>/patch_state - Livepatch patch operation state
   3.12	/proc/<pid>/arch_status - Task architecture specific information
+  3.13  /proc/<pid>/mempolicy & /proc/<pid>/task/<tid>/mempolicy- Adjust
+                                                                the mempolicy
 
   4	Configuring procfs
   4.1	Mount options
@@ -2145,6 +2147,44 @@ AVX512_elapsed_ms
   the task is unlikely an AVX512 user, but depends on the workload and the
   scheduling scenario, it also could be a false negative mentioned above.
 
+3.13 /proc/<pid>/mempolicy & /proc/<pid>/task/<tid>/mempolicy- Adjust the mempolicy
+-----------------------------------------------------------------------------------
+When CONFIG_NUMA is enabled, these files can be used to check and adjust the current
+mempolicy.Please note that the effectively <pid>,<tid> is from userspace programs.
+
+Format of input:
+----------------
+<mode>[=<flags>][:<nodelist>]
+
+Example
+-------
+set mempolicy:
+ $ echo "interleave=static:0-3" > /proc/27036/mempolicy
+ $ cat /proc/27036/mempolicy
+ interleave=static:0-3
+
+remove mempolicy:
+  $ echo "default" > /proc/27036/mempolicy
+
+The following 6 mempolicy mode types are supported:
+"default"         Default is converted to the NULL memory policy, any existing non-default policy
+                  will simply be removed when "default" is specified.
+"prefer"          The allocation should be attempted from the single node specified in the policy.
+"bind"            Memory must come from the set of nodes specified by the policy.
+"interleave"      Page allocations be interleaved across the nodes specified in the policy.
+"local"           The memory is allocated on the node of the CPU that triggered the allocation.
+"prefer (many)"   The allocation should be preferrably satisfied from the nodemask specified in the policy.
+
+The supported mode flags are:
+
+"static"          A nonempty nodemask specifies physical node IDs.
+"relative"        A nonempty nodemask specifies node IDs that are relative
+                  to the set of node IDs allowed by the thread's current cpuset.
+
+nodelist         For example: 0-3 or 0,1,2,3
+
+Please see: Documentation/admin-guide/mm/numa_memory_policy.rst  for descriptions of memory policy.
+
 Chapter 4: Configuring procfs
 =============================
 
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 93f7e3d971e4..4dbe714b4e61 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3252,6 +3252,7 @@ static const struct pid_entry tgid_base_stuff[] = {
 	REG("maps",       S_IRUGO, proc_pid_maps_operations),
 #ifdef CONFIG_NUMA
 	REG("numa_maps",  S_IRUGO, proc_pid_numa_maps_operations),
+	REG("mempolicy",  S_IRUGO|S_IWUSR, proc_mempolicy_operations),
 #endif
 	REG("mem",        S_IRUSR|S_IWUSR, proc_mem_operations),
 	LNK("cwd",        proc_cwd_link),
@@ -3600,6 +3601,7 @@ static const struct pid_entry tid_base_stuff[] = {
 #endif
 #ifdef CONFIG_NUMA
 	REG("numa_maps", S_IRUGO, proc_pid_numa_maps_operations),
+	REG("mempolicy",  S_IRUGO|S_IWUSR, proc_mempolicy_operations),
 #endif
 	REG("mem",       S_IRUSR|S_IWUSR, proc_mem_operations),
 	LNK("cwd",       proc_cwd_link),
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 06a80f78433d..33ffbd79db58 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -300,6 +300,7 @@ extern const struct file_operations proc_pid_smaps_operations;
 extern const struct file_operations proc_pid_smaps_rollup_operations;
 extern const struct file_operations proc_clear_refs_operations;
 extern const struct file_operations proc_pagemap_operations;
+extern const struct file_operations proc_mempolicy_operations;
 
 extern unsigned long task_vsize(struct mm_struct *);
 extern unsigned long task_statm(struct mm_struct *,
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 4e0023643f8b..299276e19c52 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -2003,4 +2003,133 @@ const struct file_operations proc_pid_numa_maps_operations = {
 	.release	= proc_map_release,
 };
 
+#define MPOLBUFLEN 64
+/*
+ *Display task's  memory policy via /proc./
+ */
+static ssize_t mempolicy_read(struct file *file, char __user *buf,
+		size_t count, loff_t *ppos)
+{
+	struct task_struct *task = get_proc_task(file_inode(file));
+	char buffer[MPOLBUFLEN];
+	struct mempolicy *mpol;
+	size_t len = 0;
+
+	if (!task)
+		return -ESRCH;
+
+	task_lock(task);
+	mpol = task->mempolicy;
+	mpol_get(mpol);
+	task_unlock(task);
+
+	if (!mpol || mpol->mode == MPOL_DEFAULT)
+		goto out;
+
+	memset(buffer, 0, sizeof(buffer));
+	mpol_to_str(buffer, sizeof(buffer), mpol);
+	buffer[strlen(buffer)] = '\n';
+	len = simple_read_from_buffer(buf, count, ppos, buffer, strlen(buffer));
+
+out:
+	mpol_put(mpol);
+	put_task_struct(task);
+	return len;
+}
+
+/*
+ *Update nodemask of mempolicy according to task->mems_allowed.
+ */
+static int update_task_mpol(struct task_struct *task, struct mempolicy *mpol)
+{
+	nodemask_t tsk_allowed;
+	struct mempolicy *old = NULL;
+	int err = 0;
+
+	task_lock(task);
+	local_irq_disable();
+	old = task->mempolicy;
+
+	if (mpol)
+		nodes_and(tsk_allowed, task->mems_allowed, mpol->w.user_nodemask);
+	else
+		nodes_clear(tsk_allowed);
+
+	if (!nodes_empty(tsk_allowed)) {
+		task->mempolicy = mpol;
+		mpol_rebind_task(task, &tsk_allowed);
+	} else if (!mpol || mpol->mode == MPOL_LOCAL) {
+		/*default (pol==NULL), clear the old mpol;
+		 *local memory policies are not a subject of any remapping.
+		 */
+		task->mempolicy = mpol;
+	} else {
+		/*tsk_allowed is empty.*/
+		err = -EINVAL;
+	}
+
+	if (!err && mpol && mpol->mode == MPOL_INTERLEAVE)
+		task->il_prev = MAX_NUMNODES-1;
+
+	local_irq_enable();
+	task_unlock(task);
+
+	/*If successful, release old policy,
+	 * otherwise keep old and release mpol.
+	 */
+	if (err)
+		mpol_put(mpol);
+	else
+		mpol_put(old);
+
+	return err;
+}
+
+/*
+ *Modify task's memory policy via /proc.
+ */
+static ssize_t mempolicy_write(struct file *file, const char __user *buf,
+		size_t count, loff_t *ppos)
+{
+	char buffer[MPOLBUFLEN];
+	struct mempolicy *mpol = NULL;
+	struct task_struct *task;
+	int err = 0;
+
+	task = get_proc_task(file_inode(file));
+
+	if (!task)
+		return -ESRCH;
+
+	/*we can only change the user's mempolicy*/
+	if (task->flags & PF_KTHREAD || is_global_init(task)) {
+		err = -EPERM;
+		goto out;
+	}
+
+	memset(buffer, 0, sizeof(buffer));
+	if (count > sizeof(buffer) - 1)
+		count = sizeof(buffer) - 1;
+	if (copy_from_user(buffer, buf, count)) {
+		err = -EFAULT;
+		goto out;
+	}
+
+	err = mpol_parse_str(strstrip(buffer), &mpol);
+	if (err) {
+		err = -EINVAL;
+		goto out;
+	}
+	err = update_task_mpol(task, mpol);
+out:
+	put_task_struct(task);
+	return err < 0 ? err : count;
+}
+
+const struct file_operations proc_mempolicy_operations = {
+	.read		= mempolicy_read,
+	.write		= mempolicy_write,
+	.llseek		= default_llseek,
+};
+
 #endif /* CONFIG_NUMA */
diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index 668389b4b53d..a08f66972e6b 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -172,10 +172,7 @@ int do_migrate_pages(struct mm_struct *mm, const nodemask_t *from,
 		     const nodemask_t *to, int flags);
 
 
-#ifdef CONFIG_TMPFS
 extern int mpol_parse_str(char *str, struct mempolicy **mpol);
-#endif
-
 extern void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol);
 
 /* Check if a vma is migratable */
@@ -277,12 +274,10 @@ static inline void check_highest_zone(int k)
 {
 }
 
-#ifdef CONFIG_TMPFS
 static inline int mpol_parse_str(char *str, struct mempolicy **mpol)
 {
 	return 1;	/* error */
 }
-#endif
 
 static inline int mpol_misplaced(struct page *page, struct vm_area_struct *vma,
 				 unsigned long address)
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index b73d3248d976..a1ae6412e3ae 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2958,7 +2958,6 @@ static const char * const policy_modes[] =
 };
 
 
-#ifdef CONFIG_TMPFS
 /**
  * mpol_parse_str - parse string to mempolicy, for tmpfs mpol mount option.
  * @str:  string containing mempolicy to parse
@@ -3091,7 +3090,6 @@ int mpol_parse_str(char *str, struct mempolicy **mpol)
 		*mpol = new;
 	return err;
 }
-#endif /* CONFIG_TMPFS */
 
 /**
  * mpol_to_str - format a mempolicy structure for printing
-- 
2.25.1

