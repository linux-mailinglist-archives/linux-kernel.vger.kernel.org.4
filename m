Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622B2628ECD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 01:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237809AbiKOA7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 19:59:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237652AbiKOA7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 19:59:10 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2CA89FAC6;
        Mon, 14 Nov 2022 16:59:08 -0800 (PST)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.50.127])
        by linux.microsoft.com (Postfix) with ESMTPSA id C6E7720B83C2;
        Mon, 14 Nov 2022 16:59:07 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C6E7720B83C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1668473948;
        bh=jaIIhLZttVFC7Yx8esBsWniUFcDQgLnfPHrKFv8TLp8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C/Ccg68At7kbLjSwvYepsoo1N5cBI8LhmldHjSZDOxGWaqAxxHnzZUPlxsQ/9mIod
         AFRKH1N1cJmoVnX5hSplGoKjif09iH8n1CkE/IvVSiZ+H0EOgLEsX7QvB7wf7u7gE8
         n5HsS3ERBxYsfAUwKP9p6Kz1qbfvzlhOIcTsP4xI=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com, dcook@linux.microsoft.com,
        alanau@linux.microsoft.com
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 2/7] tracing/user_events: Track fork/exec/exit for mm lifetime
Date:   Mon, 14 Nov 2022 16:58:57 -0800
Message-Id: <20221115005902.30458-3-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221115005902.30458-1-beaub@linux.microsoft.com>
References: <20221115005902.30458-1-beaub@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During tracefs discussions it was decided instead of requiring a mapping
within a user-process to track the lifetime of memory descriptors we
should hook the appropriate calls. Do this by adding the minimal stubs
required for task fork, exec, and exit. Currently this is just a NOP.
Future patches will implement these calls fully.

Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 fs/exec.c                   |  2 ++
 include/linux/sched.h       |  5 +++++
 include/linux/user_events.h | 16 +++++++++++++++-
 kernel/exit.c               |  2 ++
 kernel/fork.c               |  3 +++
 5 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/fs/exec.c b/fs/exec.c
index a0b1f0337a62..75ca6fbd195c 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -64,6 +64,7 @@
 #include <linux/io_uring.h>
 #include <linux/syscall_user_dispatch.h>
 #include <linux/coredump.h>
+#include <linux/user_events.h>
 
 #include <linux/uaccess.h>
 #include <asm/mmu_context.h>
@@ -1842,6 +1843,7 @@ static int bprm_execve(struct linux_binprm *bprm,
 	current->fs->in_exec = 0;
 	current->in_execve = 0;
 	rseq_execve(current);
+	user_events_execve(current);
 	acct_update_integrals(current);
 	task_numa_free(current, false);
 	return retval;
diff --git a/include/linux/sched.h b/include/linux/sched.h
index ffb6eb55cd13..61ed2f9deb26 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -69,6 +69,7 @@ struct sighand_struct;
 struct signal_struct;
 struct task_delay_info;
 struct task_group;
+struct user_event_mm;
 
 /*
  * Task state bitmask. NOTE! These bits are also
@@ -1528,6 +1529,10 @@ struct task_struct {
 	union rv_task_monitor		rv[RV_PER_TASK_MONITORS];
 #endif
 
+#ifdef CONFIG_USER_EVENTS
+	struct user_event_mm		*user_event_mm;
+#endif
+
 	/*
 	 * New fields for task_struct should be added above here, so that
 	 * they are included in the randomized portion of task_struct.
diff --git a/include/linux/user_events.h b/include/linux/user_events.h
index 036b360f3d97..2abf05224be1 100644
--- a/include/linux/user_events.h
+++ b/include/linux/user_events.h
@@ -12,7 +12,21 @@
 #include <uapi/linux/user_events.h>
 
 #ifdef CONFIG_USER_EVENTS
-#else
+struct user_event_mm {
+};
 #endif
 
+static inline void user_events_fork(struct task_struct *t,
+				    unsigned long clone_flags)
+{
+}
+
+static inline void user_events_execve(struct task_struct *t)
+{
+}
+
+static inline void user_events_flush_task(struct task_struct *t)
+{
+}
+
 #endif /* _LINUX_USER_EVENTS_H */
diff --git a/kernel/exit.c b/kernel/exit.c
index 35e0a31a0315..f578ab3bf1c8 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -67,6 +67,7 @@
 #include <linux/io_uring.h>
 #include <linux/kprobes.h>
 #include <linux/rethook.h>
+#include <linux/user_events.h>
 
 #include <linux/uaccess.h>
 #include <asm/unistd.h>
@@ -173,6 +174,7 @@ static void delayed_put_task_struct(struct rcu_head *rhp)
 
 	kprobe_flush_task(tsk);
 	rethook_flush_task(tsk);
+	user_events_flush_task(tsk);
 	perf_event_delayed_put(tsk);
 	trace_sched_process_free(tsk);
 	put_task_struct(tsk);
diff --git a/kernel/fork.c b/kernel/fork.c
index 08969f5aa38d..8658e67d27b0 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -97,6 +97,7 @@
 #include <linux/scs.h>
 #include <linux/io_uring.h>
 #include <linux/bpf.h>
+#include <linux/user_events.h>
 
 #include <asm/pgalloc.h>
 #include <linux/uaccess.h>
@@ -2416,6 +2417,8 @@ static __latent_entropy struct task_struct *copy_process(
 
 	rseq_fork(p, clone_flags);
 
+	user_events_fork(p, clone_flags);
+
 	/* Don't start children in a dying pid namespace */
 	if (unlikely(!(ns_of_pid(pid)->pid_allocated & PIDNS_ADDING))) {
 		retval = -ENOMEM;
-- 
2.25.1

