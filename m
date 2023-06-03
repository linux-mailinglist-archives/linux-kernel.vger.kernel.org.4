Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D87E3720DBE
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 06:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233160AbjFCEQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 00:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbjFCEQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 00:16:12 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23582E55
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 21:16:10 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:49232)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1q5IgR-0006Na-G1; Fri, 02 Jun 2023 22:16:07 -0600
Received: from ip68-110-29-46.om.om.cox.net ([68.110.29.46]:38754 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1q5IgP-006nGf-O9; Fri, 02 Jun 2023 22:16:07 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Mike Christie <michael.christie@oracle.com>, linux@leemhuis.info,
        nicolas.dichtel@6wind.com, axboe@kernel.dk,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        brauner@kernel.org
References: <20230601183232.8384-1-michael.christie@oracle.com>
        <20230602192254.GD555@redhat.com>
Date:   Fri, 02 Jun 2023 23:15:57 -0500
In-Reply-To: <20230602192254.GD555@redhat.com> (Oleg Nesterov's message of
        "Fri, 2 Jun 2023 21:22:55 +0200")
Message-ID: <87r0qt18qq.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1q5IgP-006nGf-O9;;;mid=<87r0qt18qq.fsf_-_@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.110.29.46;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX19yufjB2ZfpITwLNnmQrZZ68OnWeHNOYdM=
X-SA-Exim-Connect-IP: 68.110.29.46
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1140 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 14 (1.2%), b_tie_ro: 12 (1.0%), parse: 2.9 (0.3%),
         extract_message_metadata: 32 (2.8%), get_uri_detail_list: 13 (1.1%),
        tests_pri_-2000: 21 (1.8%), tests_pri_-1000: 3.9 (0.3%),
        tests_pri_-950: 1.89 (0.2%), tests_pri_-900: 1.54 (0.1%),
        tests_pri_-200: 1.26 (0.1%), tests_pri_-100: 33 (2.9%), tests_pri_-90:
        123 (10.8%), check_bayes: 117 (10.2%), b_tokenize: 28 (2.4%),
        b_tok_get_all: 18 (1.6%), b_comp_prob: 4.9 (0.4%), b_tok_touch_all: 61
        (5.3%), b_finish: 1.35 (0.1%), tests_pri_0: 886 (77.7%),
        check_dkim_signature: 1.35 (0.1%), check_dkim_adsp: 4.3 (0.4%),
        poll_dns_idle: 0.47 (0.0%), tests_pri_10: 1.98 (0.2%), tests_pri_500:
        12 (1.1%), rewrite_mail: 0.00 (0.0%)
Subject: [CFT][PATCH v3] fork, vhost: Use CLONE_THREAD to fix freezer/ps
 regression
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


When switching from kthreads to vhost_tasks two bugs were added:
1. The vhost worker tasks's now show up as processes so scripts doing
ps or ps a would not incorrectly detect the vhost task as another
process.  2. kthreads disabled freeze by setting PF_NOFREEZE, but
vhost tasks's didn't disable or add support for them.

To fix both bugs, this switches the vhost task to be thread in the
process that does the VHOST_SET_OWNER ioctl, and has vhost_worker call
get_signal to support SIGKILL/SIGSTOP and freeze signals. Note that
SIGKILL/STOP support is required because CLONE_THREAD requires
CLONE_SIGHAND which requires those 2 signals to be suppported.

This is a modified version of the patch written by Mike Christie
<michael.christie@oracle.com> which was a modified version of patch
originally written by Linus.

Much of what depended upon PF_IO_WORKER now depends on PF_USER_WORKER.
Including ignoring signals, setting up the register state, and having
get_signal return instead of calling do_group_exit.

Tidied up the vhost_task abstraction so that the definition of
vhost_task only needs to be visible inside of vhost_task.c.  Making
it easier to review the code and tell what needs to be done where.
As part of this the main loop has been moved from vhost_worker into
vhost_task_fn.  vhost_worker now returns true if work was done.

The main loop has been updated to call get_signal which handles
SIGSTOP, freezing, and collects the message that tells the thread to
exit as part of process exit.  This collection clears
__fatal_signal_pending.

The vhost tasks when it has been asked to exit runs until it has
no more work pending and then exits instead of sleeping.

Causing the other threads to stop feeding the vhost worker work and
having the vhost worker stop when it runs out of work should be enough
to avoid hangs in coredump rendezvous and when killing threads in a
multi-threaded exec.

The vhost thread is no longer guaranteed to be the last thread to
exit.  Which means it is possible a work item to be submitted after
the vhost work thread has exited.  If that happens the work item will
leak and vhost_worker_free will warn about the situtation.

Fixes: 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
Co-developed-by: Mike Christie <michael.christie@oracle.com>
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---

This fixes the ordering issue in vhost_task_fn so that get_signal
should not work.

This patch is a gamble that during process exit or de_thread in exec
work will not be commonly queued from other threads.

If this gamble turns out to be false the existing WARN_ON in
vhost_worker_free will fire.

Can folks test this and let us know if the WARN_ON fires?

Thank you.

 arch/x86/include/asm/fpu/sched.h |  2 +-
 arch/x86/kernel/fpu/context.h    |  2 +-
 arch/x86/kernel/fpu/core.c       |  2 +-
 drivers/vhost/vhost.c            | 24 +++-----
 include/linux/sched/task.h       |  1 -
 include/linux/sched/vhost_task.h | 16 ++----
 kernel/fork.c                    | 13 ++---
 kernel/signal.c                  |  4 +-
 kernel/vhost_task.c              | 99 ++++++++++++++++++++++----------
 9 files changed, 91 insertions(+), 72 deletions(-)

diff --git a/arch/x86/include/asm/fpu/sched.h b/arch/x86/include/asm/fpu/sched.h
index c2d6cd78ed0c..78fcde7b1f07 100644
--- a/arch/x86/include/asm/fpu/sched.h
+++ b/arch/x86/include/asm/fpu/sched.h
@@ -39,7 +39,7 @@ extern void fpu_flush_thread(void);
 static inline void switch_fpu_prepare(struct fpu *old_fpu, int cpu)
 {
 	if (cpu_feature_enabled(X86_FEATURE_FPU) &&
-	    !(current->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	    !(current->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		save_fpregs_to_fpstate(old_fpu);
 		/*
 		 * The save operation preserved register state, so the
diff --git a/arch/x86/kernel/fpu/context.h b/arch/x86/kernel/fpu/context.h
index 9fcfa5c4dad7..af5cbdd9bd29 100644
--- a/arch/x86/kernel/fpu/context.h
+++ b/arch/x86/kernel/fpu/context.h
@@ -57,7 +57,7 @@ static inline void fpregs_restore_userregs(void)
 	struct fpu *fpu = &current->thread.fpu;
 	int cpu = smp_processor_id();
 
-	if (WARN_ON_ONCE(current->flags & (PF_KTHREAD | PF_IO_WORKER)))
+	if (WARN_ON_ONCE(current->flags & (PF_KTHREAD | PF_USER_WORKER)))
 		return;
 
 	if (!fpregs_state_valid(fpu, cpu)) {
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index caf33486dc5e..1015af1ae562 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -426,7 +426,7 @@ void kernel_fpu_begin_mask(unsigned int kfpu_mask)
 
 	this_cpu_write(in_kernel_fpu, true);
 
-	if (!(current->flags & (PF_KTHREAD | PF_IO_WORKER)) &&
+	if (!(current->flags & (PF_KTHREAD | PF_USER_WORKER)) &&
 	    !test_thread_flag(TIF_NEED_FPU_LOAD)) {
 		set_thread_flag(TIF_NEED_FPU_LOAD);
 		save_fpregs_to_fpstate(&current->thread.fpu);
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index a92af08e7864..85948f40ddfe 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -236,6 +236,9 @@ void vhost_dev_flush(struct vhost_dev *dev)
 	struct vhost_flush_struct flush;
 
 	if (dev->worker) {
+		if (vhost_task_flush(dev->worker->vtsk))
+			return;
+
 		init_completion(&flush.wait_event);
 		vhost_work_init(&flush.work, vhost_flush_work);
 
@@ -256,7 +259,7 @@ void vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work)
 		 * test_and_set_bit() implies a memory barrier.
 		 */
 		llist_add(&work->node, &dev->worker->work_list);
-		wake_up_process(dev->worker->vtsk->task);
+		vhost_task_wake(dev->worker->vtsk);
 	}
 }
 EXPORT_SYMBOL_GPL(vhost_work_queue);
@@ -333,25 +336,14 @@ static void vhost_vq_reset(struct vhost_dev *dev,
 	__vhost_vq_meta_reset(vq);
 }
 
-static int vhost_worker(void *data)
+static bool vhost_worker(void *data)
 {
 	struct vhost_worker *worker = data;
 	struct vhost_work *work, *work_next;
 	struct llist_node *node;
 
-	for (;;) {
-		/* mb paired w/ kthread_stop */
-		set_current_state(TASK_INTERRUPTIBLE);
-
-		if (vhost_task_should_stop(worker->vtsk)) {
-			__set_current_state(TASK_RUNNING);
-			break;
-		}
-
-		node = llist_del_all(&worker->work_list);
-		if (!node)
-			schedule();
-
+	node = llist_del_all(&worker->work_list);
+	if (node) {
 		node = llist_reverse_order(node);
 		/* make sure flag is seen after deletion */
 		smp_wmb();
@@ -365,7 +357,7 @@ static int vhost_worker(void *data)
 		}
 	}
 
-	return 0;
+	return !!node;
 }
 
 static void vhost_vq_free_iovecs(struct vhost_virtqueue *vq)
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 537cbf9a2ade..e0f5ac90a228 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -29,7 +29,6 @@ struct kernel_clone_args {
 	u32 io_thread:1;
 	u32 user_worker:1;
 	u32 no_files:1;
-	u32 ignore_signals:1;
 	unsigned long stack;
 	unsigned long stack_size;
 	unsigned long tls;
diff --git a/include/linux/sched/vhost_task.h b/include/linux/sched/vhost_task.h
index 6123c10b99cf..f8cd7ba3ad04 100644
--- a/include/linux/sched/vhost_task.h
+++ b/include/linux/sched/vhost_task.h
@@ -2,22 +2,14 @@
 #ifndef _LINUX_VHOST_TASK_H
 #define _LINUX_VHOST_TASK_H
 
-#include <linux/completion.h>
 
-struct task_struct;
+struct vhost_task;
 
-struct vhost_task {
-	int (*fn)(void *data);
-	void *data;
-	struct completion exited;
-	unsigned long flags;
-	struct task_struct *task;
-};
-
-struct vhost_task *vhost_task_create(int (*fn)(void *), void *arg,
+struct vhost_task *vhost_task_create(bool (*fn)(void *), void *arg,
 				     const char *name);
 void vhost_task_start(struct vhost_task *vtsk);
 void vhost_task_stop(struct vhost_task *vtsk);
-bool vhost_task_should_stop(struct vhost_task *vtsk);
+void vhost_task_wake(struct vhost_task *vtsk);
+bool vhost_task_flush(struct vhost_task *vtsk);
 
 #endif
diff --git a/kernel/fork.c b/kernel/fork.c
index ed4e01daccaa..81cba91f30bb 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2336,16 +2336,16 @@ __latent_entropy struct task_struct *copy_process(
 	p->flags &= ~PF_KTHREAD;
 	if (args->kthread)
 		p->flags |= PF_KTHREAD;
-	if (args->user_worker)
-		p->flags |= PF_USER_WORKER;
-	if (args->io_thread) {
+	if (args->user_worker) {
 		/*
-		 * Mark us an IO worker, and block any signal that isn't
+		 * Mark us a user worker, and block any signal that isn't
 		 * fatal or STOP
 		 */
-		p->flags |= PF_IO_WORKER;
+		p->flags |= PF_USER_WORKER;
 		siginitsetinv(&p->blocked, sigmask(SIGKILL)|sigmask(SIGSTOP));
 	}
+	if (args->io_thread)
+		p->flags |= PF_IO_WORKER;
 
 	if (args->name)
 		strscpy_pad(p->comm, args->name, sizeof(p->comm));
@@ -2517,9 +2517,6 @@ __latent_entropy struct task_struct *copy_process(
 	if (retval)
 		goto bad_fork_cleanup_io;
 
-	if (args->ignore_signals)
-		ignore_signals(p);
-
 	stackleak_task_init(p);
 
 	if (pid != &init_struct_pid) {
diff --git a/kernel/signal.c b/kernel/signal.c
index 8f6330f0e9ca..0ac48c96ab04 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2861,11 +2861,11 @@ bool get_signal(struct ksignal *ksig)
 		}
 
 		/*
-		 * PF_IO_WORKER threads will catch and exit on fatal signals
+		 * PF_USER_WORKER threads will catch and exit on fatal signals
 		 * themselves. They have cleanup that must be performed, so
 		 * we cannot call do_exit() on their behalf.
 		 */
-		if (current->flags & PF_IO_WORKER)
+		if (current->flags & PF_USER_WORKER)
 			goto out;
 
 		/*
diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
index b7cbd66f889e..a82c45cb014d 100644
--- a/kernel/vhost_task.c
+++ b/kernel/vhost_task.c
@@ -12,58 +12,97 @@ enum vhost_task_flags {
 	VHOST_TASK_FLAGS_STOP,
 };
 
+struct vhost_task {
+	bool (*fn)(void *data);
+	void *data;
+	struct completion exited;
+	unsigned long flags;
+	struct task_struct *task;
+};
+
 static int vhost_task_fn(void *data)
 {
 	struct vhost_task *vtsk = data;
-	int ret;
+	bool dead = false;
+
+	for (;;) {
+		bool did_work;
+
+		if (!dead && signal_pending(current)) {
+			struct ksignal ksig;
+			/*
+			 * Calling get_signal can block in SIGSTOP,
+			 * and the freezer.  Or it can clear
+			 * fatal_signal_pending and return non-zero.
+			 */
+			dead = get_signal(&ksig);
+			if (dead)
+				set_bit(VHOST_TASK_FLAGS_STOP, &vtsk->flags);
+		}
+
+		/* mb paired w/ kthread_stop */
+		set_current_state(TASK_INTERRUPTIBLE);
+
+		did_work = vtsk->fn(vtsk->data);
+		if (!did_work) {
+			if (test_bit(VHOST_TASK_FLAGS_STOP, &vtsk->flags)) {
+				__set_current_state(TASK_RUNNING);
+				break;
+			}
+			schedule();
+		}
+	}
 
-	ret = vtsk->fn(vtsk->data);
-	complete(&vtsk->exited);
-	do_exit(ret);
+	complete_all(&vtsk->exited);
+	do_exit(0);
 }
 
+/**
+ * vhost_task_wake - wakeup the vhost_task
+ * @vtsk: vhost_task to wake
+ *
+ * wake up the vhost_task worker thread
+ */
+void vhost_task_wake(struct vhost_task *vtsk)
+{
+	wake_up_process(vtsk->task);
+}
+EXPORT_SYMBOL_GPL(vhost_task_wake);
+
 /**
  * vhost_task_stop - stop a vhost_task
  * @vtsk: vhost_task to stop
  *
- * Callers must call vhost_task_should_stop and return from their worker
- * function when it returns true;
+ * vhost_task_fn ensures the worker thread exits after
+ * VHOST_TASK_FLAGS_SOP becomes true.
  */
 void vhost_task_stop(struct vhost_task *vtsk)
 {
-	pid_t pid = vtsk->task->pid;
-
 	set_bit(VHOST_TASK_FLAGS_STOP, &vtsk->flags);
-	wake_up_process(vtsk->task);
+	vhost_task_wake(vtsk);
 	/*
 	 * Make sure vhost_task_fn is no longer accessing the vhost_task before
-	 * freeing it below. If userspace crashed or exited without closing,
-	 * then the vhost_task->task could already be marked dead so
-	 * kernel_wait will return early.
+	 * freeing it below.
 	 */
 	wait_for_completion(&vtsk->exited);
-	/*
-	 * If we are just closing/removing a device and the parent process is
-	 * not exiting then reap the task.
-	 */
-	kernel_wait4(pid, NULL, __WCLONE, NULL);
+	put_task_struct(vtsk->task);
 	kfree(vtsk);
 }
 EXPORT_SYMBOL_GPL(vhost_task_stop);
 
-/**
- * vhost_task_should_stop - should the vhost task return from the work function
- * @vtsk: vhost_task to stop
- */
-bool vhost_task_should_stop(struct vhost_task *vtsk)
+bool vhost_task_flush(struct vhost_task *vtsk)
 {
-	return test_bit(VHOST_TASK_FLAGS_STOP, &vtsk->flags);
+	if (!test_bit(VHOST_TASK_FLAGS_STOP, &vtsk->flags))
+		return false;
+
+	wait_for_completion(&vtsk->exited);
+	return true;
 }
-EXPORT_SYMBOL_GPL(vhost_task_should_stop);
+EXPORT_SYMBOL_GPL(vhost_task_flush);
 
 /**
- * vhost_task_create - create a copy of a process to be used by the kernel
- * @fn: thread stack
+ * vhost_task_create - create a copy of a task to be used by the kernel
+ * @fn: vhost worker function
  * @arg: data to be passed to fn
  * @name: the thread's name
  *
@@ -71,17 +110,17 @@ EXPORT_SYMBOL_GPL(vhost_task_should_stop);
  * failure. The returned task is inactive, and the caller must fire it up
  * through vhost_task_start().
  */
-struct vhost_task *vhost_task_create(int (*fn)(void *), void *arg,
+struct vhost_task *vhost_task_create(bool (*fn)(void *), void *arg,
 				     const char *name)
 {
 	struct kernel_clone_args args = {
-		.flags		= CLONE_FS | CLONE_UNTRACED | CLONE_VM,
+		.flags		= CLONE_FS | CLONE_UNTRACED | CLONE_VM |
+				  CLONE_THREAD | CLONE_SIGHAND,
 		.exit_signal	= 0,
 		.fn		= vhost_task_fn,
 		.name		= name,
 		.user_worker	= 1,
 		.no_files	= 1,
-		.ignore_signals	= 1,
 	};
 	struct vhost_task *vtsk;
 	struct task_struct *tsk;
@@ -101,7 +140,7 @@ struct vhost_task *vhost_task_create(int (*fn)(void *), void *arg,
 		return NULL;
 	}
 
-	vtsk->task = tsk;
+	vtsk->task = get_task_struct(tsk);
 	return vtsk;
 }
 EXPORT_SYMBOL_GPL(vhost_task_create);
-- 
2.35.3

