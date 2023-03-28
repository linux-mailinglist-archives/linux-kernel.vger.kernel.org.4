Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13676CCBE7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 23:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjC1VIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 17:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjC1VIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 17:08:17 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33911982
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 14:08:09 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5458201ab8cso135109167b3.23
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 14:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680037689;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yEMybOAMhR2BrJ66abx6Qu/jbFLagXF2nowRYsGYL8c=;
        b=EzPX+DUkTqONw2e+LEoxeTPixjsCEZOEMPyve6JV41AUzYuoUy145eOTfe95y+SRRq
         EGYPHFAVH0zJhJ3Fl+y+vZro372KtZzb6MqiEQW2Zu9+13pRRsdIZtA00GDRPXs4D41/
         vGLc9z4nF5fpPpZoywVL6LIRGjFT/+UEYqH9MSwQqcBwq99/CzwXz5rv9pcM+JENVurl
         9TVDzeU0s7CjAOopLJn9hrGHRlwJfLdfmvM1SY+fz9nzPHcmq6Re+6rAx4RGpXmg7CWt
         tDjpJM5XIriGOAxuzb7wSQyfxuQhh6Q0O8qP0dV1AezktGrQlzkYXNmgrQdKsl/Vdu6v
         CILg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680037689;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yEMybOAMhR2BrJ66abx6Qu/jbFLagXF2nowRYsGYL8c=;
        b=keoTOm/aS4tEqwsVUn7stp+ctWzdD5H/QekuIRaNDRmtOjRb8ZQmERi2JllXDXuGYS
         5uoR0gnMJXZDq3cEKkiP64PzAKSv74T0HjIzYLMx3iJkfGY9+HF3N0S8LE0QaJHO+FuW
         ugvYS2+0ZMsHhJ6N4pbBvMhaLNtZMOJzDGOOYOvaKxxMyTB5fc68SDJvmIOPfB2/y19n
         /JyBHTCTnEhFAyrehdwL8xc36x3FDLSW5S8gu6THfGfQWO+iGm+IMXGKyjgVUfsTxlHU
         45QnaMjxU5S7xEX4kCewd3CHA4A5+OwDm7h/TqJzVRskQi6Nfr+J95/QQ0aySfEh5Qk0
         AcAw==
X-Gm-Message-State: AAQBX9e80CvU3H8ZToGRfV2HMDwkyCSsXFRgy/AbFW48CL0IPWgnuSUW
        zjVWvn4cqYxaFiNggm/VUtAqAadG
X-Google-Smtp-Source: AKy350ZYtZ19xEvj52mUGtVWwJjHpXiJgLnCit/RyFyf3jOo+9EnwqRi88hMxbtWYetXz1Sn6fPfDslR
X-Received: from posk.svl.corp.google.com ([2620:15c:2d4:203:3520:c82c:3bac:c87b])
 (user=posk job=sendgmr) by 2002:a81:b303:0:b0:545:621b:5076 with SMTP id
 r3-20020a81b303000000b00545621b5076mr8065474ywh.2.1680037689219; Tue, 28 Mar
 2023 14:08:09 -0700 (PDT)
Date:   Tue, 28 Mar 2023 14:07:54 -0700
Message-Id: <20230328210754.2745989-1-posk@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Subject: UMCG - how should we proceed? Should we?
From:   Peter Oskolkov <posk@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, bsegall@google.com,
        linux-kernel@vger.kernel.org, pjt@google.com, posk@google.com,
        posk@posk.io, joshdon@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter!

TL;DR: which approach, if any, should a UMCG implementation in the mainline kernel use?

Details:

We are rolling out internally a UMCG implementation copied below (with some
boilerplate omitted), so I would like to restart our discussion on the topic.

The implementation below is different from what we had earlier
(https://lore.kernel.org/lkml/20220120155517.066795336@infradead.org/)
in that it keeps UMCG state in the kernel rather than TLS.

While having UMCG state in TLS is _much_ better, as it makes state synchronization
between the userspace and the kernel much simpler, the whole page pinning
machinery in the link above looked very scary, honestly.

So if we are going to ever have something like UMCG in the mainline kernel, we need
to figure out the approach to use: the TLS-based one, something similar
to what we have now internally (details below), or something else. Or none at all...

While I would very much prefer to have it done your way (state in TLS), the page pinning
business was too much for me. If you can figure out a way to do it cleanly and reliably, great!

The main differences between what you had in the TLS patchset and what is below:

- per worker/server state not in TLS but in task_struct
- we keep a list of idle workers and a list of idle servers in mm
- worker wake events are delivered not to servers which ran the workers earlier,
  but to idle servers from the idle server list
- worker preemption happens not via a syscall (umcg_kick) but by hooking
  into sched_tick

None of the differences above are deal breakers; again, if the TLS/page pinning
approach is viable, we will gladly use it. 

Thanks,
Peter


I removed some boilerplate cruft from below; also removed some formatting,
hoping that bots won't try to apply the code to any tree.
This patch (before mutilation) applies to 5.15.


Signed-off-by: Peter Oskolkov <posk@google.com>

[...]
 arch/x86/entry/syscalls/syscall_64.tbl |    1 +
 fs/exec.c                              |    1 +
 include/linux/mm_types.h               |    5 +
 include/linux/sched.h                  |   62 ++
 include/linux/syscalls.h               |    6 +-
 include/linux/tracehook.h              |    2 +
 include/uapi/asm-generic/unistd.h      |    3 +
 include/uapi/linux/umcg.h              |   55 ++
 init/Kconfig                           |   22 +
 kernel/exit.c                          |    2 +
 kernel/fork.c                          |    5 +
 kernel/sched/Makefile                  |    1 +
 kernel/sched/core.c                    |   19 +-
 kernel/sched/sched.h                   |    2 +
 kernel/sched/umcg.c                    | 1106 ++++++++++++++++++++++++
 kernel/sys_ni.c                        |    1 +
[...]
 18 files changed, 1292 insertions(+), 7 deletions(-)
 create mode 100644 include/uapi/linux/umcg.h
 create mode 100644 kernel/sched/umcg.c

[...]

diff --git a/fs/exec.c b/fs/exec.c
index a098c133d8d7..dfa24bb99a97 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1840,6 +1840,7 @@ static int bprm_execve(struct linux_binprm *bprm,
 	current->fs->in_exec = 0;
 	current->in_execve = 0;
 	rseq_execve(current);
+	umcg_execve(current);
 	acct_update_integrals(current);
 	task_numa_free(current, false);
 	return retval;
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 7f8ee09c711f..de01510a6e06 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -560,6 +560,11 @@ struct mm_struct {
 
 		/* numa_scan_seq prevents two threads setting pte_numa */
 		int numa_scan_seq;
+#endif
+#ifdef CONFIG_UMCG
+		spinlock_t umcg_lock;
+		struct list_head umcg_idle_server_list;
+		struct task_struct *umcg_idle_workers;
 #endif
 		/*
 		 * An operation with batched TLB flushing is going on. Anything
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 2e1bec12c45c..0afad1bb55de 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -11,6 +11,7 @@
 
 #include <asm/current.h>
 
+#include <linux/atomic.h>
 #include <linux/pid.h>
 #include <linux/sem.h>
 #include <linux/shm.h>
@@ -1294,6 +1295,25 @@ struct task_struct {
 	unsigned long rseq_event_mask;
 #endif
 
+#ifdef CONFIG_UMCG
+	/* UMCG server/worker status; see kernel/sched/umcg.c. */
+	atomic_long_t			umcg_status;
+	/* Set if this is a worker. */
+	struct task_struct		*umcg_server;
+	union {
+		/* If this is a worker. */
+		struct task_struct	*umcg_next_idle_worker;
+		/* If this is a server. */
+		struct list_head	umcg_idle_server_list;
+	};
+	union {
+		u64		umcg_worker_id;     /* If this is a worker. */
+		atomic_long_t	umcg_worker_event;  /* If this is a server. */
+	};
+	/* Worker jiffies are used to decide when to preempt a running worker. */
+	u64			umcg_worker_jiffies;
+#endif
+
 	struct tlbflush_unmap_batch	tlb_ubc;
 
 	union {
@@ -2291,6 +2312,47 @@ static inline void rseq_syscall(struct pt_regs *regs)
 
 #endif
 
+#ifdef CONFIG_UMCG
+
+/* Whether sched_submit_work() should call umcg_wq_worker_sleeping(). */
+extern bool umcg_wq_work(struct task_struct *tsk);
+
+extern void umcg_notify_resume(void);
+extern void umcg_tick(struct task_struct *curr);
+
+/* Called by do_exit() in kernel/exit.c. */
+extern void umcg_handle_exit(void);
+
+/* Called by bprm_execve() in fs/exec.c. */
+extern void umcg_execve(struct task_struct *tsk);
+
+/* umcg_wq_worker_sleeping() is called in core.c by sched_submit_work(). */
+extern void umcg_wq_worker_sleeping(struct task_struct *tsk);
+
+#else  /* CONFIG_UMCG */
+
+static inline bool umcg_wq_work(struct task_struct *tsk)
+{
+	return false;
+}
+static inline void umcg_notify_resume(void)
+{
+}
+static inline void umcg_tick(struct task_struct *curr)
+{
+}
+static inline void umcg_execve(struct task_struct *tsk)
+{
+}
+static inline void umcg_handle_exit(void)
+{
+}
+static inline void umcg_wq_worker_sleeping(struct task_struct *tsk)
+{
+}
+
+#endif
+
 const struct sched_avg *sched_trace_cfs_rq_avg(struct cfs_rq *cfs_rq);
 char *sched_trace_cfs_rq_path(struct cfs_rq *cfs_rq, char *str, int len);
 int sched_trace_cfs_rq_cpu(struct cfs_rq *cfs_rq);

[...]

diff --git a/include/linux/tracehook.h b/include/linux/tracehook.h
index 2564b7434b4d..f1d5408fafec 100644
--- a/include/linux/tracehook.h
+++ b/include/linux/tracehook.h
@@ -179,6 +179,8 @@ static inline void set_notify_resume(struct task_struct *task)
  */
 static inline void tracehook_notify_resume(struct pt_regs *regs)
 {
+	umcg_notify_resume();
+
 	clear_thread_flag(TIF_NOTIFY_RESUME);
 	/*
 	 * This barrier pairs with task_work_add()->set_notify_resume() after

[...]

diff --git a/include/uapi/linux/umcg.h b/include/uapi/linux/umcg.h
new file mode 100644
index 000000000000..521d3851d793
--- /dev/null
+++ b/include/uapi/linux/umcg.h
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
+#ifndef _UAPI_LINUX_UMCG_H
+#define _UAPI_LINUX_UMCG_H
+
+#include <linux/types.h>
+
+/*
+ * UMCG: User Managed Concurrency Groups.
+ */
+
+/**
+ * enum umcg_event_type - types of worker events delivered to UMCG servers.
+ *
+ * Note: worker events are delivered as the lower three bits of umcg_task_id.
+ */
+enum umcg_event_type {
+	UMCG_WE_BLOCK	= 1,
+	UMCG_WE_WAKE	= 2,
+	UMCG_WE_WAIT	= 3,
+	UMCG_WE_EXIT	= 4,
+	UMCG_WE_TIMEOUT	= 5,
+	UMCG_WE_PREEMPT	= 6,
+};
+
+/**
+ * enum umcg_cmd - sys_umcg commands.
+ */
+enum umcg_cmd {
+	UMCG_REGISTER_WORKER	= 1,
+	UMCG_REGISTER_SERVER	= 2,
+	UMCG_UNREGISTER		= 3,
+	UMCG_WAKE		= 4,  /* Wakes one idle server. */
+	UMCG_WAIT		= 5,
+	UMCG_CTX_SWITCH		= 6,
+};
+
+/*
+ * Pass this flag with UMCG_WAIT command if this is a repeated wait
+ * due to a signal.
+ */
+#define UMCG_WAIT_FLAG_INTERRUPTED (1ULL)
+
+/*
+ * UMCG worker IDs must have the last 5 bits as zeroes to OR with
+ * worker events.
+ */
+#define UMCG_WORKER_ID_ALIGNMENT (32ULL)
+
+/*
+ * int sys_umcg(u64 flags, u64 cmd, pid_t next_tid, u64 abs_timeout,
+ *              u64 __user *events, int event_sz);
+ */
+
+#endif /* _UAPI_LINUX_UMCG_H */
diff --git a/init/Kconfig b/init/Kconfig
index 59ee786868ec..ef0e44e964c0 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1688,6 +1688,28 @@ config MEMBARRIER
 
 	  If unsure, say Y.
 
+config UMCG
+	bool "Enable User Managed Concurrency Groups API"
+	depends on 64BIT
+	depends on GOOGLE_SYSCALLS
+	default n
+	help
+	  Enable User Managed Concurrency Groups API, which form the basis
+	  for an in-process M:N userspace scheduling framework.
+	  At the moment this is an experimental/RFC feature that is not
+	  guaranteed to be backward-compatible.
+
+config UMCG_PREEMPT_JIFFIES
+	int "Interval at which running UMCG workers are preempted."
+	depends on UMCG
+	default 10
+	help
+	  Normally UMCG workers cooperatively "yield" their servers.
+	  However, UMCG worker preemption is needed in cases when
+	  the worker is waiting on a spinlock that a descheduled worker
+	  holds. In this case preempting a running worker gives the
+	  userspace scheduler a chance to run the lock-holding worker.
+
 config KALLSYMS
 	bool "Load all symbols for debugging/ksymoops" if EXPERT
 	default y
diff --git a/kernel/exit.c b/kernel/exit.c
index 91a43e57a32e..4c93a16aa355 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -743,6 +743,8 @@ void __noreturn do_exit(long code)
 	if (unlikely(!tsk->pid))
 		panic("Attempted to kill the idle task!");
 
+	umcg_handle_exit();
+
 	/*
 	 * If do_exit is called because this processes oopsed, it's possible
 	 * that get_fs() was left as KERNEL_DS, so reset it to USER_DS before
diff --git a/kernel/fork.c b/kernel/fork.c
index 38681ad44c76..57a6b8ed5b81 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1061,6 +1061,11 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	init_tlb_flush_pending(mm);
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) && !USE_SPLIT_PMD_PTLOCKS
 	mm->pmd_huge_pte = NULL;
+#endif
+#ifdef CONFIG_UMCG
+	INIT_LIST_HEAD(&mm->umcg_idle_server_list);
+	mm->umcg_idle_workers = NULL;
+	spin_lock_init(&mm->umcg_lock);
 #endif
 	mm_init_uprobes_state(mm);
 	hugetlb_count_init(mm);

[...]

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2bd9d8638f96..8284d64d5b2a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3944,8 +3944,7 @@ bool ttwu_state_match(struct task_struct *p, unsigned int state, int *success)
  * Return: %true if @p->state changes (an actual wakeup was done),
  *	   %false otherwise.
  */
-static int
-try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
+int try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 {
 	unsigned long flags;
 	int cpu, success = 0;
@@ -4227,6 +4226,12 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 	p->wake_entry.u_flags = CSD_TYPE_TTWU;
 	p->migration_pending = NULL;
 #endif
+#ifdef CONFIG_UMCG
+	p->umcg_worker_id = 0;
+	p->umcg_server = NULL;
+	INIT_LIST_HEAD(&p->umcg_idle_server_list);
+	atomic_long_set(&p->umcg_status, 0);
+#endif
 }
 
 DEFINE_STATIC_KEY_FALSE(sched_numa_balancing);
@@ -5224,6 +5229,7 @@ void scheduler_tick(void)
 		resched_latency_warn(cpu, resched_latency);
 
 	perf_event_task_tick();
+	umcg_tick(curr);
 
 #ifdef CONFIG_SMP
 	rq->idle_balance = idle_cpu(cpu);
@@ -6318,11 +6324,13 @@ void __noreturn do_task_dead(void)
 static inline void sched_submit_work(struct task_struct *tsk)
 {
 	unsigned int task_flags;
+	bool umcg_worker;
 
 	if (task_is_running(tsk))
 		return;
 
 	task_flags = tsk->flags;
+	umcg_worker = umcg_wq_work(tsk);
 	/*
 	 * If a worker went to sleep, notify and ask workqueue whether
 	 * it wants to wake up a task to maintain concurrency.
@@ -6331,12 +6339,15 @@ static inline void sched_submit_work(struct task_struct *tsk)
 	 * in the possible wakeup of a kworker and because wq_worker_sleeping()
 	 * requires it.
 	 */
-	if (task_flags & (PF_WQ_WORKER | PF_IO_WORKER)) {
+	if ((task_flags & (PF_WQ_WORKER | PF_IO_WORKER)) || umcg_worker) {
 		preempt_disable();
 		if (task_flags & PF_WQ_WORKER)
 			wq_worker_sleeping(tsk);
-		else
+		else if (task_flags & PF_IO_WORKER)
 			io_wq_worker_sleeping(tsk);
+
+		if (umcg_worker)
+			umcg_wq_worker_sleeping(tsk);
 		preempt_enable_no_resched();
 	}
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index ea8276376f45..8dfaa2699257 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3060,6 +3060,8 @@ static inline bool is_per_cpu_kthread(struct task_struct *p)
 extern void swake_up_all_locked(struct swait_queue_head *q);
 extern void __prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait);
 
+extern int try_to_wake_up(struct task_struct *tsk, unsigned int state, int wake_flags);
+
 #ifdef CONFIG_PREEMPT_DYNAMIC
 extern int preempt_dynamic_mode;
 extern int sched_dynamic_mode(const char *str);
diff --git a/kernel/sched/umcg.c b/kernel/sched/umcg.c
new file mode 100644
index 000000000000..9eb3b9d9f300
--- /dev/null
+++ b/kernel/sched/umcg.c
@@ -0,0 +1,1106 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * User Managed Concurrency Groups (UMCG).
+ */
+
+#include <linux/sched.h>
+#include <linux/syscalls.h>
+#include <linux/types.h>
+#include <linux/umcg.h>
+#include "sched.h"
+
+/* UMCG status values and flags. */
+enum {
+	UMCG_SERVER_ATTACHED	= 1UL,       /* Attached to a running worker. */
+	UMCG_SERVER_IDLE	= 2UL,       /* Nothing to do.                */
+	UMCG_SERVER_RUNNING	= 4UL,       /* Running on a CPU.             */
+	UMCG_SERVER_WAIT	= 8UL,       /* Waiting for a blocked worker. */
+
+	UMCG_WORKER_BLOCKED	= 0x010UL,   /* Off idle workers queue.  */
+	UMCG_WORKER_WAKING	= 0x020UL,   /* On idle workers queue.   */
+	UMCG_WORKER_SWAPPING	= 0x040UL,   /* On idle workers queue.   */
+	UMCG_WORKER_RUNNABLE	= 0x080UL,   /* Off idle workers queue.  */
+	UMCG_WORKER_RUNNING	= 0x100UL,   /* Running with a server attached. */
+
+	/* Can be ORed with SWAPPING and RUNNABLE.  */
+	UMCG_WORKER_TIMEOUT	= 0x200UL,   /* On idle workers queue.   */
+};
+
+#define UMCG_STATUS_RUNNING_MASK   (UMCG_SERVER_RUNNING | UMCG_WORKER_RUNNING)
+
+#define UMCG_WORKER_MASK \
+	(UMCG_WORKER_BLOCKED | UMCG_WORKER_WAKING | UMCG_WORKER_SWAPPING | UMCG_WORKER_RUNNABLE | UMCG_WORKER_RUNNING)
+
+#define UMCG_WARN(format, ...) \
+	pr_warn("%s:%d " format "\n", __func__, __LINE__, ##__VA_ARGS__)
+
+#define UMCG_WQ_DISABLE_BIT	(1UL)
+
+static bool umcg_worker(struct task_struct *tsk)
+{
+	return atomic_long_read_acquire(&tsk->umcg_status) & UMCG_WORKER_MASK;
+}
+
+bool umcg_wq_work(struct task_struct *curr)
+{
+	return (atomic_long_read_acquire(&curr->umcg_status) == UMCG_WORKER_RUNNING) &&
+		!(curr->umcg_worker_id & UMCG_WQ_DISABLE_BIT);
+}
+
+static void umcg_wq_work_disable(struct task_struct *curr)
+{
+	curr->umcg_worker_id |= UMCG_WQ_DISABLE_BIT;
+}
+
+static void umcg_wq_work_enable(struct task_struct *curr)
+{
+	curr->umcg_worker_id &= ~UMCG_WQ_DISABLE_BIT;
+}
+
+void umcg_execve(struct task_struct *tsk)
+{
+	struct task_struct *curr = current;
+
+	curr->umcg_server = NULL;
+	curr->umcg_worker_id = 0;
+	atomic_long_set_release(&curr->umcg_status, 0);
+}
+
+static void umcg_wake_server(struct task_struct *server, u64 umcg_worker_id,
+				enum umcg_event_type worker_event)
+{
+	u64 curr_status;
+
+	if (WARN_ON(!server))
+		goto kill;
+
+	/*
+	 * Note that umcg_wake_server() might be called from preempt-disabled
+	 * context, so here we just update the in-kernel event field and let
+	 * umcg_server_idle_loop deal with the userspace events buffer.
+	 */
+	if (atomic_long_xchg(&server->umcg_worker_event, umcg_worker_id | worker_event)) {
+		UMCG_WARN("bad event");
+		goto kill;
+	}
+
+	curr_status = atomic_long_cmpxchg(&server->umcg_status,
+				UMCG_SERVER_ATTACHED, UMCG_SERVER_RUNNING);
+
+	if (curr_status != UMCG_SERVER_ATTACHED) {
+		if (curr_status == 0)
+			return;  /* Exiting/killed. */
+		UMCG_WARN("bad status: 0x%llx", curr_status);
+		goto kill;
+	}
+
+	try_to_wake_up(server, TASK_NORMAL,
+			worker_event == (u64)UMCG_WE_WAIT ? WF_CURRENT_CPU : 0);
+	return;
+
+kill:
+	force_sig(SIGKILL);
+}
+
+static void umcg_enqueue_idle_worker(struct task_struct *worker)
+{
+	bool kill = false;
+
+	spin_lock(&worker->mm->umcg_lock);
+	if (unlikely(worker->umcg_next_idle_worker)) {
+		UMCG_WARN("task on the list; worker: %p", worker);
+		kill = true;
+	} else {
+		worker->umcg_next_idle_worker = worker->mm->umcg_idle_workers;
+		worker->mm->umcg_idle_workers = worker;
+	}
+	spin_unlock(&worker->mm->umcg_lock);
+
+	if (kill)
+		force_sig(SIGKILL);
+}
+
+static struct task_struct *umcg_dequeue_idle_worker(void)
+{
+	struct task_struct *curr = current;
+	struct task_struct *worker;
+
+	spin_lock(&curr->mm->umcg_lock);
+	worker = curr->mm->umcg_idle_workers;
+	if (worker) {
+		curr->mm->umcg_idle_workers =
+			READ_ONCE(worker->umcg_next_idle_worker);
+		WRITE_ONCE(worker->umcg_next_idle_worker, NULL);
+	}
+	spin_unlock(&curr->mm->umcg_lock);
+
+	return worker;
+}
+
+static void umcg_enqueue_idle_server(void)
+{
+	struct task_struct *server = current;
+	bool kill = false;
+
+	spin_lock(&server->mm->umcg_lock);
+	if (server->mm->umcg_idle_workers) {
+		/* Idle workers present, don't enqueue. */
+		u64 umcg_status = atomic_long_cmpxchg(&server->umcg_status,
+				UMCG_SERVER_IDLE, UMCG_SERVER_RUNNING);
+
+		if (WARN_ONCE(umcg_status != UMCG_SERVER_IDLE,
+				"Unexpected server status: 0x%llx\n", umcg_status)) {
+			kill = true;
+		}
+	} else if (unlikely(!list_empty(&server->umcg_idle_server_list))) {
+		UMCG_WARN("server on the list; server: %p\n", server);
+		kill = true;
+	} else {
+		list_add(&server->umcg_idle_server_list,
+				&server->mm->umcg_idle_server_list);
+	}
+	spin_unlock(&server->mm->umcg_lock);
+
+	if (kill)
+		force_sig(SIGKILL);
+}
+
+static bool umcg_wake_idle_server(void)
+{
+	struct task_struct *curr = current;
+	struct task_struct *server;
+
+	spin_lock(&curr->mm->umcg_lock);
+	server = list_first_entry_or_null(&curr->mm->umcg_idle_server_list,
+			struct task_struct, umcg_idle_server_list);
+	if (server)
+		list_del_init(&server->umcg_idle_server_list);
+	spin_unlock(&curr->mm->umcg_lock);
+
+	if (!server)
+		return false;
+
+	atomic_long_set_release(&server->umcg_status, UMCG_SERVER_RUNNING);
+
+	try_to_wake_up(server, TASK_NORMAL, 0);
+	return true;
+}
+
+static long umcg_register_worker(u64 flags, pid_t next_tid, u64 umcg_worker_id,
+					u64 __user *events, int event_sz)
+{
+	struct task_struct *curr = current;
+
+	if (flags || next_tid || (u64)events || event_sz)
+		return -EINVAL;
+
+	if (atomic_long_read_acquire(&curr->umcg_status))
+		return -EINVAL;
+
+	/* Must have the last 5 bits as zero. */
+	if (umcg_worker_id & (UMCG_WORKER_ID_ALIGNMENT - 1))
+		return -EINVAL;
+
+	WRITE_ONCE(curr->umcg_server, NULL);
+	WRITE_ONCE(curr->umcg_worker_id, umcg_worker_id);
+	WRITE_ONCE(curr->umcg_next_idle_worker, NULL);
+
+	atomic_long_set_release(&curr->umcg_status, UMCG_WORKER_BLOCKED);
+
+	/* Trigger UMCG_WE_WAKE. */
+	set_tsk_thread_flag(curr, TIF_NOTIFY_RESUME);
+	return 0;
+}
+
+static long umcg_register_server(u64 flags, pid_t next_tid, u64 abs_timeout,
+					u64 __user *events, int event_sz)
+{
+	struct task_struct *curr = current;
+
+	if (flags || next_tid || (u64)events || event_sz || abs_timeout)
+		return -EINVAL;
+
+	if (atomic_long_read_acquire(&curr->umcg_status))
+		return -EINVAL;
+
+	INIT_LIST_HEAD(&curr->umcg_idle_server_list);
+	atomic_long_set_release(&curr->umcg_worker_event, 0);
+	atomic_long_set_release(&curr->umcg_status, UMCG_SERVER_RUNNING);
+
+	/* Non-blocking: return immediately. */
+	return 0;
+}
+
+static long umcg_unregister(u64 flags, pid_t next_tid, u64 abs_timeout,
+				u64 __user *events, int event_sz)
+{
+	struct task_struct *curr = current;
+	struct task_struct *server;
+	u64 umcg_status = atomic_long_read_acquire(&curr->umcg_status);
+
+	if (fatal_signal_pending(curr)) {
+		/* Do an unconditional cleanup. */
+		if (umcg_worker(curr)) {
+			server = READ_ONCE(curr->umcg_server);
+			if (server)
+				put_task_struct(server);
+		}
+		atomic_long_set_release(&curr->umcg_status, 0);
+
+		return 0;
+	}
+
+	if (flags || next_tid || (u64)events || event_sz || abs_timeout || !umcg_status)
+		return -EINVAL;
+
+	if (umcg_status == UMCG_SERVER_RUNNING) {
+		atomic_long_set_release(&curr->umcg_status, 0);
+		return 0;
+	}
+
+	if (umcg_status != UMCG_WORKER_RUNNING)
+		return -EINVAL;
+
+	atomic_long_set_release(&curr->umcg_status, 0);
+	server = xchg(&curr->umcg_server, NULL);
+	WRITE_ONCE(curr->umcg_next_idle_worker, NULL);
+	if (WARN_ON(!server)) {
+		force_sig(SIGKILL);
+		return -EINVAL;
+	}
+
+	umcg_wake_server(server, curr->umcg_worker_id & ~UMCG_WQ_DISABLE_BIT,
+			UMCG_WE_EXIT);
+	/* Matches get_task_struct() in umcg_wake_worker(). */
+	put_task_struct(server);
+
+	curr->umcg_worker_id = 0;
+
+	return 0;
+}
+
+static int umcg_idle_loop(u64 abs_timeout);
+
+static int umcg_process_timedout_server(void)
+{
+	struct task_struct *curr = current;
+
+	spin_lock(&curr->mm->umcg_lock);
+	if (!list_empty(&curr->umcg_idle_server_list))
+		list_del_init(&curr->umcg_idle_server_list);
+	spin_unlock(&curr->mm->umcg_lock);
+
+	atomic_long_set(&curr->umcg_status, UMCG_SERVER_RUNNING);
+	return -ETIMEDOUT;
+}
+
+/*
+ * Wait until the worker is scheduled by the server or killed.
+ * Note that non-fatal signals do not break this loop.
+ */
+static void umcg_worker_wait(void)
+{
+	struct task_struct *curr = current;
+	u64 curr_status;
+
+	umcg_wq_work_disable(curr);  /* Avoid recursion. */
+	while (true) {
+		set_current_state(TASK_INTERRUPTIBLE);
+
+		/* Must check status after setting task state to INTERRUPTIBLE */
+		curr_status = atomic_long_read_acquire(&curr->umcg_status);
+		if ((curr_status & UMCG_STATUS_RUNNING_MASK) ||
+				fatal_signal_pending(curr))
+			break;
+
+		freezable_schedule();
+	}
+
+	__set_current_state(TASK_RUNNING);
+	umcg_wq_work_enable(curr);
+	WRITE_ONCE(curr->umcg_worker_jiffies, jiffies);
+}
+
+static int umcg_process_timedout_worker(u64 old_status)
+{
+	u64 prev_status = old_status;
+	struct task_struct *curr = current;
+
+	if (!(prev_status & (UMCG_WORKER_RUNNABLE | UMCG_WORKER_SWAPPING)))
+		goto kill;
+
+	prev_status = atomic_long_cmpxchg(&curr->umcg_status, old_status,
+			old_status | UMCG_WORKER_TIMEOUT);
+	if (prev_status == old_status)
+		goto wait;
+
+	/*
+	 * cmpxchg above could have failed because of two racing events:
+	 * (a) a server attaching to the worker and markign it RUNNING, and
+	 * (b) a server making SWAPPING -> RUNNABLE change.
+	 */
+	if (prev_status == UMCG_WORKER_RUNNING)
+		goto run;
+
+	if (prev_status != UMCG_WORKER_RUNNABLE)
+		goto kill;
+
+	/* The second attempt. */
+	prev_status = atomic_long_cmpxchg(&curr->umcg_status, prev_status,
+			UMCG_WORKER_RUNNABLE | UMCG_WORKER_TIMEOUT);
+
+	/* Could have raced with a server attaching. */
+	if (prev_status == UMCG_WORKER_RUNNING)
+		goto run;
+	else if (prev_status != UMCG_WORKER_RUNNABLE) {
+		/*
+		 * RUNNABLE can only become RUNNING concurrently; RUNNING workers
+		 * change their status only "inline", while running, so _this_
+		 * worker is guaranteed to be RUNNABLE at this point.
+		 */
+		UMCG_WARN("unexpected status 0x%llx", prev_status);
+		goto kill;
+	}
+
+wait:
+	if (prev_status != UMCG_WORKER_SWAPPING) {
+		/* SWAPPING workers are already on the list. */
+		umcg_enqueue_idle_worker(curr);
+		/* Serialize the enqueue above and the wake below. */
+		umcg_wake_idle_server();
+	}
+
+	umcg_worker_wait();  /* Wait for a server to schedule the worker. */
+	return -ETIMEDOUT;
+
+run:
+	WRITE_ONCE(curr->umcg_worker_jiffies, jiffies);
+	return 0;
+
+kill:
+	UMCG_WARN("bad status: 0x%llx", prev_status);
+	force_sig(SIGKILL);
+	return -EINVAL;
+}
+
+static int umcg_idle_loop(u64 abs_timeout)
+{
+	int ret;
+	struct hrtimer_sleeper timeout;
+	struct task_struct *curr = current;
+	const bool worker = umcg_worker(curr);
+	u64 umcg_status;
+
+	/* Elide workqueue handlers. */
+	if (worker)
+		umcg_wq_work_disable(curr);
+
+	if (abs_timeout) {
+		/*
+		 * CLOCK_REALTIME is used here for historical reasons (SwitchTo).
+		 * In the future we will pass an additional parameter
+		 * that specifies which clock to use, as suggested by peterz@.
+		 */
+		hrtimer_init_sleeper_on_stack(&timeout, CLOCK_REALTIME,
+				HRTIMER_MODE_ABS);
+
+		hrtimer_set_expires_range_ns(&timeout.timer, (s64)abs_timeout,
+				curr->timer_slack_ns);
+	}
+
+	while (true) {
+		set_current_state(TASK_INTERRUPTIBLE);
+
+		/* Must check status after setting task state to INTERRUPTIBLE */
+		umcg_status = atomic_long_read_acquire(&curr->umcg_status);
+
+		ret = 0;
+		if (umcg_status & UMCG_STATUS_RUNNING_MASK)
+			goto out;
+
+		ret = -EINTR;
+		if (signal_pending(curr)) {
+			set_tsk_thread_flag(curr, TIF_NOTIFY_RESUME);
+			goto out;
+		}
+
+		if (abs_timeout)
+			hrtimer_sleeper_start_expires(&timeout, HRTIMER_MODE_ABS);
+
+		if (!abs_timeout || timeout.task)
+			freezable_schedule();
+
+		umcg_status = atomic_long_read_acquire(&curr->umcg_status);
+
+		ret = 0;
+		if (umcg_status & UMCG_STATUS_RUNNING_MASK)
+			goto out;
+
+		ret = -ETIMEDOUT;
+		if (abs_timeout && !timeout.task)
+			goto out;
+	}
+
+out:
+	__set_current_state(TASK_RUNNING);
+
+	if (abs_timeout) {
+		hrtimer_cancel(&timeout.timer);
+		destroy_hrtimer_on_stack(&timeout.timer);
+	}
+
+	if (worker) {
+		umcg_wq_work_enable(curr);
+
+		if (ret == -ETIMEDOUT)
+			return umcg_process_timedout_worker(umcg_status);
+
+		WRITE_ONCE(curr->umcg_worker_jiffies, jiffies);
+	} else {
+		if (ret == -ETIMEDOUT)
+			return umcg_process_timedout_server();
+	}
+	return ret;
+}
+
+static int umcg_server_idle_loop(u64 abs_timeout, u64 __user *events, int event_sz)
+{
+	struct task_struct *curr = current;
+	u64 __user *next_event = events;
+	int ret;
+	u64 curr_event;
+
+	/* "1" is used for non-blocking polls. */
+	if (abs_timeout == 1)
+		ret = umcg_process_timedout_server();
+	else
+		ret = umcg_idle_loop(abs_timeout);
+
+	if (ret && (ret != -ETIMEDOUT))
+		return ret;
+
+	if (!event_sz)
+		return ret;
+
+	curr_event = atomic_long_xchg(&curr->umcg_worker_event, 0);
+	if (curr_event) {
+		if (put_user(curr_event, next_event))
+			return -EFAULT;
+		++next_event;
+		--event_sz;
+	}
+
+	/*
+	 * Sometimes we need to deliver two events, so we iterate until
+	 * event_sz > 1 and not until event_sz > 0.
+	 */
+	while (event_sz > 1) {
+		struct task_struct *worker = umcg_dequeue_idle_worker();
+		u64 worker_status, worker_id, event;
+		u64 extra_event = 0;
+
+		if (!worker)
+			break;
+
+		worker_status = atomic_long_xchg(&worker->umcg_status,
+				UMCG_WORKER_RUNNABLE);
+
+		if (worker_status == UMCG_WORKER_WAKING) {
+			struct task_struct *maybe_waiting_server;
+
+			event = (u64)UMCG_WE_WAKE;
+			/* RCU lock to prevent maybe_waiting_server exiting. */
+			rcu_read_lock();
+			maybe_waiting_server = READ_ONCE(worker->umcg_server);
+
+			if (maybe_waiting_server) {
+				u64 server_status = atomic_long_cmpxchg(
+						&maybe_waiting_server->umcg_status,
+						UMCG_SERVER_WAIT,
+						UMCG_SERVER_RUNNING);
+
+				if (server_status == UMCG_SERVER_WAIT) {
+					try_to_wake_up(maybe_waiting_server,
+							TASK_NORMAL, 0);
+				}
+			}
+			rcu_read_unlock();
+		} else if (worker_status == UMCG_WORKER_SWAPPING)
+			event = (u64)UMCG_WE_WAIT;
+		else if (worker_status ==
+				(UMCG_WORKER_RUNNABLE | UMCG_WORKER_TIMEOUT))
+			event = (u64)UMCG_WE_TIMEOUT;
+		else if (worker_status ==
+				(UMCG_WORKER_SWAPPING | UMCG_WORKER_TIMEOUT)) {
+			event = (u64)UMCG_WE_WAIT;
+			extra_event = (u64)UMCG_WE_TIMEOUT;
+		} else {
+			UMCG_WARN("%s:%d: Unexpected worker status: w %d s %llx",
+				__FILE__, __LINE__,
+				worker->pid, worker_status);
+			force_sig(SIGKILL);
+			return -EINVAL;
+		}
+
+		worker_id = READ_ONCE(worker->umcg_worker_id) & ~UMCG_WQ_DISABLE_BIT;
+		if (put_user(worker_id | event, next_event)) {
+			force_sig(SIGKILL);
+			return -EFAULT;
+		}
+
+		++next_event;
+		--event_sz;
+
+		if (extra_event != 0) {
+			if (put_user(worker_id | extra_event, next_event)) {
+				force_sig(SIGKILL);
+				return -EFAULT;
+			}
+
+			++next_event;
+			--event_sz;
+		}
+	}
+
+	if (next_event != events)
+		ret = 0;  /* Have results. */
+
+	if (event_sz > 0) {
+		if (put_user((u64)0, next_event)) {
+			force_sig(SIGKILL);
+			return -EFAULT;
+		}
+	}
+
+	return ret;
+}
+
+/**
+ * umcg_wakeup_allowed - check whether @current can wake @tsk.
+ *
+ * Currently a placeholder that allows wakeups within a single process
+ * only (same mm). In the future the requirement might be relaxed (securely).
+ */
+static bool umcg_wakeup_allowed(struct task_struct *tsk)
+{
+	WARN_ON_ONCE(!rcu_read_lock_held());
+
+	if (tsk->mm && tsk->mm == current->mm &&
+			(atomic_long_read(&tsk->umcg_status) != 0))
+		return true;
+
+	return false;
+}
+
+static long umcg_server_wait_for_worker(pid_t worker_tid)
+{
+	struct task_struct *worker;
+	struct task_struct *server = current;
+	u64 server_status, worker_status;
+	int ret = 0;
+
+	worker = find_get_task_by_vpid(worker_tid);
+	if (!worker)
+		return -ESRCH;
+
+	if (!umcg_wakeup_allowed(worker)) {
+		put_task_struct(worker);
+		return -EPERM;
+	}
+
+	server_status = atomic_long_xchg(&server->umcg_status, UMCG_SERVER_WAIT);
+	if (server_status != UMCG_SERVER_RUNNING) {
+		put_task_struct(worker);
+		UMCG_WARN("bad status: %llu", server_status);
+		force_sig(SIGKILL);
+		return -EINVAL;
+	}
+
+	worker_status = atomic_long_read_acquire(&worker->umcg_status);
+	if (worker_status != UMCG_WORKER_BLOCKED) {
+		put_task_struct(worker);
+		atomic_long_set_release(&server->umcg_status, UMCG_SERVER_RUNNING);
+		return 0;
+	}
+
+	if (xchg(&worker->umcg_server, get_task_struct(server)) != NULL) {
+		UMCG_WARN("bad worker state");
+		force_sig(SIGKILL);
+		return -EINVAL;
+	}
+
+	/* Pairs with atomic_long_xchg() in umcg_wq_worker_sleeping() */
+	smp_mb();
+
+	/* Check again. */
+	worker_status = atomic_long_read_acquire(&worker->umcg_status);
+	if (worker_status != UMCG_WORKER_BLOCKED) {
+		struct task_struct *server_now = xchg(&worker->umcg_server, NULL);
+
+		put_task_struct(worker);
+		if (server_now == server)
+			put_task_struct(server);
+		else if (server_now && (server_now != server)) {
+			/*
+			 * server_now can be NULL if the worker woke concurrently.
+			 * But if it is not equal to server/current, the userspace
+			 * screwed up.
+			 */
+			force_sig(SIGKILL);
+			return -EINVAL;
+		}
+		atomic_long_set_release(&server->umcg_status, UMCG_SERVER_RUNNING);
+		return 0;
+	}
+
+	while (true) {
+		if (signal_pending(server)) {
+			atomic_long_set_release(&server->umcg_status,
+					UMCG_SERVER_RUNNING);
+			ret = -EINTR;
+			goto out;
+		}
+
+		set_current_state(TASK_INTERRUPTIBLE);
+
+		/* Must check status after setting task state to INTERRUPTIBLE */
+		server_status = atomic_long_read_acquire(&server->umcg_status);
+
+		if (server_status == UMCG_SERVER_RUNNING)
+			goto out;
+
+		freezable_schedule();
+	}
+
+out:
+	__set_current_state(TASK_RUNNING);
+	if (xchg(&worker->umcg_server, NULL) == server)
+		put_task_struct(server);
+	put_task_struct(worker);
+	return ret;
+}
+
+static long umcg_wake(u64 flags, pid_t next_tid, u64 abs_timeout,
+			u64 __user *events, int event_sz)
+{
+	if (flags || next_tid || abs_timeout || (u64) events || event_sz)
+		return -EINVAL;
+
+	if (umcg_wake_idle_server())
+		return 0;
+
+	return -EAGAIN;
+}
+
+static long umcg_wait(u64 flags, pid_t next_tid, u64 abs_timeout,
+			u64 __user *events, int event_sz)
+{
+	struct task_struct *curr = current;
+	u64 curr_status;
+
+	curr_status = atomic_long_read_acquire(&curr->umcg_status);
+
+	if (curr_status == UMCG_SERVER_RUNNING) {
+		if (next_tid) {
+			if (event_sz || abs_timeout || events)
+				return -EINVAL;
+			if (flags && (flags != UMCG_WAIT_FLAG_INTERRUPTED))
+				return -EINVAL;
+			return umcg_server_wait_for_worker(next_tid);
+		}
+
+		/*
+		 * Idle server was woken, but then interrupted before it could
+		 * collect/process worker events. The server could have been
+		 * in the "run worker" mode, and thus having event_sz == 1.
+		 */
+		if (flags == UMCG_WAIT_FLAG_INTERRUPTED)
+			return umcg_server_idle_loop(abs_timeout, events, event_sz);
+
+		/* Threre is no use case for less than two event slots. */
+		if (event_sz < 2)
+			return -EINVAL;
+
+		if (flags != 0)
+			return -EINVAL;
+
+		if (atomic_long_xchg(&curr->umcg_worker_event, 0)) {
+			UMCG_WARN("bad event");
+			goto kill;
+		}
+
+		curr_status = atomic_long_xchg(&curr->umcg_status,
+				UMCG_SERVER_IDLE);
+
+		if (curr_status != UMCG_SERVER_RUNNING) {
+			UMCG_WARN("bad status: %llu", curr_status);
+			goto kill;
+		}
+
+		umcg_enqueue_idle_server();
+		return umcg_server_idle_loop(abs_timeout, events, event_sz);
+	} else if (curr_status == UMCG_SERVER_IDLE) {
+		if (flags != UMCG_WAIT_FLAG_INTERRUPTED)
+			return -EINVAL;
+		/* The wait was interrupted by a signal. */
+		return umcg_server_idle_loop(abs_timeout, events, event_sz);
+	} else if (curr_status == UMCG_SERVER_ATTACHED) {
+		if (flags != UMCG_WAIT_FLAG_INTERRUPTED)
+			return -EINVAL;
+		/* The wait was interrupted by a signal. */
+		return umcg_server_idle_loop(abs_timeout, events, event_sz);
+	} else if (curr_status == UMCG_WORKER_RUNNING) {
+		struct task_struct *server = READ_ONCE(curr->umcg_server);
+
+		/* The wait was interrupted by a signal. */
+		if (flags == UMCG_WAIT_FLAG_INTERRUPTED)
+			return 0;
+
+		if (flags != 0)
+			return -EINVAL;
+
+		if (events || event_sz || next_tid)
+			return -EINVAL;
+
+		if (server != xchg(&curr->umcg_server, NULL)) {
+			/* This can't happen, but we are extra catious. */
+			UMCG_WARN("bad worker state");
+			goto kill;
+		}
+		curr_status = atomic_long_xchg(&curr->umcg_status,
+				UMCG_WORKER_RUNNABLE);
+		if (curr_status != UMCG_WORKER_RUNNING) {
+			UMCG_WARN("bad status: %llx", curr_status);
+			put_task_struct(server);
+			goto kill;
+		}
+
+		umcg_wake_server(server, curr->umcg_worker_id & ~UMCG_WQ_DISABLE_BIT,
+				UMCG_WE_WAIT);
+		/* Matches get_task_struct() in umcg_wake_worker(). */
+		put_task_struct(server);
+		return umcg_idle_loop(abs_timeout);
+	} else if (curr_status == UMCG_WORKER_RUNNABLE) {
+		if (flags != UMCG_WAIT_FLAG_INTERRUPTED)
+			return -EINVAL;
+		/* The wait was interrupted by a signal. */
+		return umcg_idle_loop(abs_timeout);
+	} else if (curr_status == UMCG_WORKER_SWAPPING) {
+		if (flags != UMCG_WAIT_FLAG_INTERRUPTED)
+			return -EINVAL;
+		/* The wait was interrupted by a signal. */
+		return umcg_idle_loop(abs_timeout);
+	} else {
+		UMCG_WARN("bad status: 0x%llx", curr_status);
+		goto kill;
+	}
+
+kill:
+	force_sig(SIGKILL);
+	return -EINVAL;
+}
+
+static void umcg_wake_worker(struct task_struct *worker,
+		struct task_struct *server)
+{
+	u64 umcg_status;
+
+	/*
+	 * Assign the server before the status change: a RUNNING worker
+	 * must have a server assigned.
+	 *
+	 * get_task_struct() below matches put_task_struct() in
+	 * wq_worker_sleeping(), umcg_wait(), and umcg_ctx_switch().
+	 */
+	WRITE_ONCE(worker->umcg_server, get_task_struct(server));
+
+	/* Set jiffies to zero to avoid preemption. */
+	WRITE_ONCE(worker->umcg_worker_jiffies, 0);
+	umcg_status = atomic_long_xchg(&worker->umcg_status,
+			UMCG_WORKER_RUNNING);
+	if (umcg_status != UMCG_WORKER_RUNNABLE) {
+		UMCG_WARN("w %d bad status: %llx", worker->pid, umcg_status);
+		force_sig(SIGKILL);
+		return;
+	}
+
+	try_to_wake_up(worker, TASK_NORMAL, WF_CURRENT_CPU);
+}
+
+/*
+ * Allows server->worker or worker->worker context switching.
+ *
+ * In the future, we may allow server->server context switching.
+ */
+static long umcg_ctx_switch(u64 flags, pid_t next_tid, u64 abs_timeout,
+				u64 __user *events, int event_sz)
+{
+	struct task_struct *curr = current;
+	struct task_struct *next;
+	u64 curr_status;
+
+	if (flags)
+		return -EINVAL;
+
+	rcu_read_lock();
+	next = find_task_by_vpid(next_tid);
+	if (!next) {
+		rcu_read_unlock();
+		return -ESRCH;
+	}
+
+	if (!umcg_wakeup_allowed(next)) {
+		rcu_read_unlock();
+		return -EPERM;
+	}
+
+	curr_status = atomic_long_read_acquire(&curr->umcg_status);
+
+	if (curr_status == UMCG_WORKER_RUNNING) {
+		struct task_struct *server = READ_ONCE(curr->umcg_server);
+
+		if (events || event_sz) {
+			rcu_read_unlock();
+			return -EINVAL;
+		}
+
+		WRITE_ONCE(curr->umcg_server, NULL);
+		curr_status = atomic_long_xchg(&curr->umcg_status,
+				UMCG_WORKER_SWAPPING);
+		if (curr_status != UMCG_WORKER_RUNNING) {
+			put_task_struct(server);
+			UMCG_WARN("bad status: %llu", curr_status);
+			goto kill;
+		}
+
+		umcg_enqueue_idle_worker(curr);
+		umcg_wake_worker(next, server);
+
+		/* Matches get_task_struct() in umcg_wake_worker(). */
+		put_task_struct(server);
+		rcu_read_unlock();
+		umcg_wake_idle_server();  /* For the enqueued/curr worker. */
+		return umcg_idle_loop(abs_timeout);
+	}
+
+	if (curr_status == UMCG_SERVER_RUNNING) {
+		if (abs_timeout) {
+			rcu_read_unlock();
+			return -EINVAL;
+		}
+
+		curr_status = atomic_long_xchg(&curr->umcg_status,
+				UMCG_SERVER_ATTACHED);
+		if (curr_status != UMCG_SERVER_RUNNING) {
+			UMCG_WARN("bad status: %llu", curr_status);
+			goto kill;
+		}
+
+		umcg_wake_worker(next, curr);
+		rcu_read_unlock();
+		return umcg_server_idle_loop(abs_timeout, events, event_sz);
+	}
+
+	UMCG_WARN("bad status: %llu", curr_status);
+
+kill:
+	rcu_read_unlock();
+	force_sig(SIGKILL);
+	return -EINVAL;
+}
+
+SYSCALL_DEFINE6(gsys_umcg, u64, flags, u64, cmd, pid_t, next_tid,
+		u64, abs_timeout, u64 __user *, events, int, event_sz)
+{
+	switch (cmd) {
+	case UMCG_REGISTER_WORKER:
+		return umcg_register_worker(flags, next_tid, abs_timeout,
+						events, event_sz);
+	case UMCG_REGISTER_SERVER:
+		return umcg_register_server(flags, next_tid, abs_timeout,
+						events, event_sz);
+	case UMCG_UNREGISTER:
+		return umcg_unregister(flags, next_tid, abs_timeout,
+					events, event_sz);
+	case UMCG_WAKE:
+		return umcg_wake(flags, next_tid, abs_timeout,
+					events, event_sz);
+	case UMCG_WAIT:
+		return umcg_wait(flags, next_tid, abs_timeout,
+					events, event_sz);
+	case UMCG_CTX_SWITCH:
+		return umcg_ctx_switch(flags, next_tid, abs_timeout,
+					events, event_sz);
+	default:
+		return -EINVAL;
+	}
+}
+
+static void umcg_preempt(struct task_struct *curr)
+{
+	u64 prev_status;
+	struct task_struct *server = NULL;
+
+	server = xchg(&curr->umcg_server, NULL);
+	prev_status = atomic_long_cmpxchg(&curr->umcg_status,
+			UMCG_WORKER_RUNNING, UMCG_WORKER_RUNNABLE);
+	if (prev_status != UMCG_WORKER_RUNNING) {
+		UMCG_WARN("%s:%d: bad status: 0x%llx tid %u\n", __func__,
+				__LINE__, prev_status, curr->pid);
+		goto kill;
+	}
+
+	umcg_wake_server(server, curr->umcg_worker_id & ~UMCG_WQ_DISABLE_BIT,
+			UMCG_WE_PREEMPT);
+	/* Matches get_task_struct() in umcg_wake_worker(). */
+	put_task_struct(server);
+
+	umcg_worker_wait();  /* Wait for a server to schedule the worker. */
+	return;
+
+kill:
+	if (server)
+		put_task_struct(server);
+	WRITE_ONCE(curr->umcg_server, NULL);
+	force_sig(SIGKILL);
+}
+
+void umcg_notify_resume(void)
+{
+	struct task_struct *curr = current;
+	struct task_struct *maybe_waiting_server;
+	u64 curr_status;
+	u64 curr_jiffies;
+
+	if (!umcg_worker(curr))
+		return;
+
+	if (fatal_signal_pending(curr))
+		return;
+
+	curr_status = atomic_long_read_acquire(&curr->umcg_status);
+	curr_jiffies = READ_ONCE(curr->umcg_worker_jiffies);
+
+	if ((curr_status == UMCG_WORKER_RUNNING) && (curr_jiffies != 0) &&
+			((jiffies - curr_jiffies) >=
+				CONFIG_UMCG_PREEMPT_JIFFIES)) {
+		umcg_preempt(curr);
+		return;
+	}
+
+	/*
+	 * Runnable workers can be interrupted. Note that this only applies
+	 * to RUNNABLE workers in umcg_wait(); workers that become RUNNABLE
+	 * once they are taken off the idle worker queue are in
+	 * umcg_worker_wait() and will not return to the userspace until
+	 * they are scheduled by a server to run.
+	 */
+	if (curr_status != UMCG_WORKER_BLOCKED)
+		return;
+
+	/* RCU lock to prevent maybe_waiting_server exiting. */
+	rcu_read_lock();
+	/*
+	 * Read the server before changing the worker status, as after
+	 * the worker's status changes out of BLOCKED, a lot of concurrent
+	 * activity might happen.
+	 */
+	maybe_waiting_server = READ_ONCE(curr->umcg_server);
+
+	curr_status = atomic_long_xchg(&curr->umcg_status, UMCG_WORKER_WAKING);
+	if (curr_status != UMCG_WORKER_BLOCKED) {
+		rcu_read_unlock();
+		UMCG_WARN("bad status: %llu", curr_status);
+		force_sig(SIGKILL);
+		return;
+	}
+
+	/*
+	 * Enqueue the worker even if there is a waiting server, as the wakeup
+	 * event still needs to be delivered.
+	 */
+	umcg_enqueue_idle_worker(curr);
+	if (maybe_waiting_server) {
+		u64 server_status = atomic_long_cmpxchg(
+				&maybe_waiting_server->umcg_status,
+				UMCG_SERVER_WAIT,
+				UMCG_SERVER_RUNNING);
+
+		if (server_status == UMCG_SERVER_WAIT) {
+			try_to_wake_up(maybe_waiting_server, TASK_NORMAL,
+					WF_CURRENT_CPU);
+		}
+	} else {
+		umcg_wake_idle_server();
+	}
+	rcu_read_unlock();
+
+	umcg_worker_wait();  /* Wait for a server to schedule the worker. */
+}
+
+void umcg_wq_worker_sleeping(struct task_struct *curr)
+{
+	u64 prev_status;
+	struct task_struct *server = NULL;
+
+	prev_status = atomic_long_cmpxchg(&curr->umcg_status,
+			UMCG_WORKER_RUNNING, UMCG_WORKER_BLOCKED);
+	server = READ_ONCE(curr->umcg_server);
+	if (prev_status != UMCG_WORKER_RUNNING) {
+		UMCG_WARN("%s:%d: bad status: 0x%llx tid %u\n", __func__,
+				__LINE__, prev_status, curr->pid);
+		goto kill;
+	}
+	WRITE_ONCE(curr->umcg_server, NULL);
+
+	umcg_wake_server(server, curr->umcg_worker_id & ~UMCG_WQ_DISABLE_BIT,
+			UMCG_WE_BLOCK);
+	/* Matches get_task_struct() in umcg_wake_worker(). */
+	put_task_struct(server);
+
+	/* Trigger UMCG_WE_WAKE. */
+	set_tsk_thread_flag(curr, TIF_NOTIFY_RESUME);
+	return;
+
+kill:
+	if (server)
+		put_task_struct(server);
+	WRITE_ONCE(curr->umcg_server, NULL);
+	force_sig(SIGKILL);
+}
+
+void umcg_handle_exit(void)
+{
+	struct task_struct *curr = current;
+	u64 curr_status = atomic_long_read_acquire(&curr->umcg_status);
+
+	if (!curr_status)
+		return;
+
+	if (!umcg_unregister(0, 0, 0, NULL, 0))
+		return;
+
+	/* Normal unregister failed, do a hard cleanup. */
+	if (umcg_worker(curr)) {
+		struct task_struct *server = READ_ONCE(curr->umcg_server);
+
+		if (server && (curr_status == UMCG_WORKER_RUNNING))
+			put_task_struct(server);
+		else if (server)
+			UMCG_WARN("UMCG worker exiting in state 0x%llx",
+				curr_status);
+	}
+	atomic_long_set_release(&curr->umcg_status, 0);
+}
+
+void umcg_tick(struct task_struct *curr)
+{
+	if (umcg_wq_work(curr)) {
+		u64 curr_jiffies = READ_ONCE(curr->umcg_worker_jiffies);
+
+		if ((curr_jiffies != 0) && ((jiffies - curr_jiffies) >=
+					CONFIG_UMCG_PREEMPT_JIFFIES))
+			set_tsk_thread_flag(curr, TIF_NOTIFY_RESUME);
+	}
+}

[...]
