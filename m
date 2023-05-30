Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C37387153C2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 04:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjE3Cj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 22:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjE3Cj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 22:39:27 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92BEBA8
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 19:39:24 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:59882)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1q3pGa-00GGMQ-9F; Mon, 29 May 2023 20:39:20 -0600
Received: from ip68-110-29-46.om.om.cox.net ([68.110.29.46]:46268 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1q3pGY-009iql-Cj; Mon, 29 May 2023 20:39:19 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     michael.christie@oracle.com
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux@leemhuis.info, nicolas.dichtel@6wind.com, axboe@kernel.dk,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        brauner@kernel.org
References: <20230523121506.GA6562@redhat.com>
        <87bkib6nxr.fsf@email.froward.int.ebiederm.org>
        <20230524141022.GA19091@redhat.com>
        <87ttw1zt4i.fsf@email.froward.int.ebiederm.org>
        <20230525115512.GA9229@redhat.com>
        <87y1lcxwcj.fsf@email.froward.int.ebiederm.org>
        <CAHk-=wj4DS=2F5mW+K2P7cVqrsuGd3rKE_2k2BqnnPeeYhUCvg@mail.gmail.com>
        <87cz2mrtnk.fsf@email.froward.int.ebiederm.org>
        <CAHk-=whsi9JFP-okH3jXHrA8rh8bMuuSt6ZgkmPwiDMAn437qA@mail.gmail.com>
        <87mt1pmezu.fsf@email.froward.int.ebiederm.org>
        <20230529111859.GA15193@redhat.com>
        <022f4de6-9eae-0a94-0f55-b84be4982fc3@oracle.com>
Date:   Mon, 29 May 2023 21:38:54 -0500
In-Reply-To: <022f4de6-9eae-0a94-0f55-b84be4982fc3@oracle.com> (michael
        christie's message of "Mon, 29 May 2023 11:09:27 -0500")
Message-ID: <87sfbeh7b5.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1q3pGY-009iql-Cj;;;mid=<87sfbeh7b5.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.110.29.46;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX189pROiZ/B8qoQfDWVxrtwfUF6kUhKICwA=
X-SA-Exim-Connect-IP: 68.110.29.46
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;michael.christie@oracle.com
X-Spam-Relay-Country: 
X-Spam-Timing: total 1150 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 5.0 (0.4%), b_tie_ro: 3.4 (0.3%), parse: 2.2
        (0.2%), extract_message_metadata: 17 (1.5%), get_uri_detail_list: 8
        (0.7%), tests_pri_-2000: 11 (0.9%), tests_pri_-1000: 1.99 (0.2%),
        tests_pri_-950: 1.06 (0.1%), tests_pri_-900: 0.86 (0.1%),
        tests_pri_-200: 0.72 (0.1%), tests_pri_-100: 19 (1.7%), tests_pri_-90:
        133 (11.6%), check_bayes: 129 (11.3%), b_tokenize: 23 (2.0%),
        b_tok_get_all: 20 (1.8%), b_comp_prob: 5 (0.5%), b_tok_touch_all: 76
        (6.6%), b_finish: 0.85 (0.1%), tests_pri_0: 941 (81.8%),
        check_dkim_signature: 0.65 (0.1%), check_dkim_adsp: 2.5 (0.2%),
        poll_dns_idle: 1.15 (0.1%), tests_pri_10: 3.1 (0.3%), tests_pri_500: 9
        (0.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 3/3] fork, vhost: Use CLONE_THREAD to fix freezer/ps
 regression
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

michael.christie@oracle.com writes:

> On 5/29/23 6:19 AM, Oleg Nesterov wrote:
>> On 05/27, Eric W. Biederman wrote:
>>>
>>> Looking forward I don't see not asking the worker threads to stop
>>> for the coredump right now causing any problems in the future.
>>> So I think we can use this to resolve the coredump issue I spotted.
>> 
>> But we have almost the same problem with exec.
>> 
>> Execing thread will wait for vhost_worker() while vhost_worker will wait for
>> .release -> vhost_task_stop().
>
> For this type of case, what is the goal or correct behavior in the end?
>
> When get_signal returns true we can code things like you mention below and
> clean up the task_struct. However, we now have a non-functioning vhost device
> open and just sitting around taking up memory and it can't do any IO.
>
> For this type of case, do we expect just not to crash/hang, or was this new
> exec'd thread suppose to be able to use the vhost device?

Looking at the vhost code, from before commit 6e890c5d5021 ("vhost: use
vhost_tasks for worker threads") exec effectively brakes the connection
with the vhost device.  Aka the vhost device permanently keeps a
connection to the mm that opened it.

Frankly I think the vhost code will misbehave in fascinating ways if you
actually try and use it after exec.

> I would normally say it probably wants to use the vhost device still. However,
> I don't think this comes up so just not hanging might be ok.

Yes we just need to not hang, and fail as gracefully after exec.

>> And even O_CLOEXEC won't help, do_close_on_exec() is called after de_thread().
>> 
>> Or suppose that vhost_worker's sub-thread forks a child with CLONE_FILES...
>
> You mean the vhost_task's task/thread doing a function that does a copy_process
> right? That type of thing is not needed. I can add a check in vhost_task_create
> for this so new code doesn't try to do it. I don't think it will come up that some
> code vhost is using will call kernel_thread/copy_process directly since those
> calls are so rare and the functions are not exported to modules.

Oleg was referring to the fact that during exec de_thread comes before
do_close_on_exec.

>> If we want CLONE_THREAD, I think vhost_worker() should exit after get_signal()
>> returns SIGKILL. Perhaps it should "disable" vhost_work_queue() somehow and
>> flush the pending works on ->work_list before exit, I dunno. But imo it should
>> not wait for the final fput().

In the long term I agree.  Exiting more or less immediately and leaving
the work to vhost_dev_flush looks like where the code needs to go.

For right now just to get us something before the final -rc I believe
the changes below with some testing are good enough.  We can handle
exec just like the coredump.  I have made those tests specific to the
vhost case for now so that there is no danger of trigger any other
funnies.

If someone does not set O_CLOEXEC or performs file descriptor passing we
might get a weird thread with an old mm.

I have also added in the needed changes to change a few additional
PF_IO_WORKER test to PF_USER_WORK.

Mike is there any chance you can test the change below?

From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Mon, 29 May 2023 19:13:59 -0500
Subject: [PATCH] fork, vhost: Use CLONE_THREAD to fix freezer/ps regression

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
__fatal_signal_pending.  This collection is not guaranteed to
clear signal_pending() so clear that explicitly so the schedule()
sleeps.

For now the vhost thread continues to exist and run work until the
last file descriptor is closed and the release function is called as
part of freeing struct file.  To avoid hangs in the coredump
rendezvous and when killing threads in a multi-threaded exec.  The
coredump code and de_thread have been modified to ignore vhost threads.

Remvoing the special case for exec appears to require teaching
vhost_dev_flush how to directly complete transactions in case
the the vhost thread is no longer running.

Removing the special case for coredump rendezvous requires either the
above fix needed for exec or moving the coredump rendezvous into
get_signal.

Fixes: 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/x86/include/asm/fpu/sched.h |  2 +-
 arch/x86/kernel/fpu/context.h    |  2 +-
 arch/x86/kernel/fpu/core.c       |  2 +-
 drivers/vhost/vhost.c            | 21 ++-----
 fs/coredump.c                    |  4 +-
 include/linux/sched/task.h       |  1 -
 include/linux/sched/vhost_task.h | 15 +----
 kernel/exit.c                    |  5 +-
 kernel/fork.c                    | 13 ++---
 kernel/signal.c                  |  8 ++-
 kernel/vhost_task.c              | 94 +++++++++++++++++++++-----------
 11 files changed, 91 insertions(+), 76 deletions(-)

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
index a92af08e7864..221d1b6c1be5 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -256,7 +256,7 @@ void vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work)
 		 * test_and_set_bit() implies a memory barrier.
 		 */
 		llist_add(&work->node, &dev->worker->work_list);
-		wake_up_process(dev->worker->vtsk->task);
+		vhost_task_wake(dev->worker->vtsk);
 	}
 }
 EXPORT_SYMBOL_GPL(vhost_work_queue);
@@ -333,25 +333,14 @@ static void vhost_vq_reset(struct vhost_dev *dev,
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
@@ -365,7 +354,7 @@ static int vhost_worker(void *data)
 		}
 	}
 
-	return 0;
+	return !!node;
 }
 
 static void vhost_vq_free_iovecs(struct vhost_virtqueue *vq)
diff --git a/fs/coredump.c b/fs/coredump.c
index ece7badf701b..88740c51b942 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -371,7 +371,9 @@ static int zap_process(struct task_struct *start, int exit_code)
 		if (t != current && !(t->flags & PF_POSTCOREDUMP)) {
 			sigaddset(&t->pending.signal, SIGKILL);
 			signal_wake_up(t, 1);
-			nr++;
+			/* The vhost_worker does not particpate in coredumps */
+			if ((t->flags & (PF_USER_WORKER | PF_IO_WORKER)) != PF_USER_WORKER)
+				nr++;
 		}
 	}
 
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
index 6123c10b99cf..837a23624a66 100644
--- a/include/linux/sched/vhost_task.h
+++ b/include/linux/sched/vhost_task.h
@@ -2,22 +2,13 @@
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
 
 #endif
diff --git a/kernel/exit.c b/kernel/exit.c
index 34b90e2e7cf7..edb50b4c9972 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -411,7 +411,10 @@ static void coredump_task_exit(struct task_struct *tsk)
 	tsk->flags |= PF_POSTCOREDUMP;
 	core_state = tsk->signal->core_state;
 	spin_unlock_irq(&tsk->sighand->siglock);
-	if (core_state) {
+
+	/* The vhost_worker does not particpate in coredumps */
+	if (core_state &&
+	    ((tsk->flags & (PF_IO_WORKER | PF_USER_WORKER)) != PF_USER_WORKER)) {
 		struct core_thread self;
 
 		self.task = current;
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
index 8f6330f0e9ca..2547fa73bde5 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1368,7 +1368,9 @@ int zap_other_threads(struct task_struct *p)
 
 	while_each_thread(p, t) {
 		task_clear_jobctl_pending(t, JOBCTL_PENDING_MASK);
-		count++;
+		/* Don't require de_thread to wait for the vhost_worker */
+		if ((t->flags & (PF_IO_WORKER | PF_USER_WORKER)) != PF_USER_WORKER)
+			count++;
 
 		/* Don't bother with already dead threads */
 		if (t->exit_state)
@@ -2861,11 +2863,11 @@ bool get_signal(struct ksignal *ksig)
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
index b7cbd66f889e..f3ce0fa6edd7 100644
--- a/kernel/vhost_task.c
+++ b/kernel/vhost_task.c
@@ -12,58 +12,90 @@ enum vhost_task_flags {
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
+		/* mb paired w/ kthread_stop */
+		set_current_state(TASK_INTERRUPTIBLE);
+
+		if (test_bit(VHOST_TASK_FLAGS_STOP, &vtsk->flags)) {
+			__set_current_state(TASK_RUNNING);
+			break;
+		}
+
+		if (!dead && signal_pending(current)) {
+			struct ksignal ksig;
+			/*
+			 * Calling get_signal will block in SIGSTOP,
+			 * or clear fatal_signal_pending, but remember
+			 * what was set.
+			 *
+			 * This thread won't actually exit until all
+			 * of the file descriptors are closed, and
+			 * the release function is called.
+			 */
+			dead = get_signal(&ksig);
+			if (dead)
+				clear_thread_flag(TIF_SIGPENDING);
+		}
+
+		did_work = vtsk->fn(vtsk->data);
+		if (!did_work)
+			schedule();
+	}
 
-	ret = vtsk->fn(vtsk->data);
 	complete(&vtsk->exited);
-	do_exit(ret);
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
 	kfree(vtsk);
 }
 EXPORT_SYMBOL_GPL(vhost_task_stop);
 
 /**
- * vhost_task_should_stop - should the vhost task return from the work function
- * @vtsk: vhost_task to stop
- */
-bool vhost_task_should_stop(struct vhost_task *vtsk)
-{
-	return test_bit(VHOST_TASK_FLAGS_STOP, &vtsk->flags);
-}
-EXPORT_SYMBOL_GPL(vhost_task_should_stop);
-
-/**
- * vhost_task_create - create a copy of a process to be used by the kernel
- * @fn: thread stack
+ * vhost_task_create - create a copy of a task to be used by the kernel
+ * @fn: vhost worker function
  * @arg: data to be passed to fn
  * @name: the thread's name
  *
@@ -71,17 +103,17 @@ EXPORT_SYMBOL_GPL(vhost_task_should_stop);
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
-- 
2.35.3
