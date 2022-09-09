Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8773B5B32AD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 11:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbiIIJBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 05:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbiIIJAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:00:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B0411212F;
        Fri,  9 Sep 2022 02:00:19 -0700 (PDT)
Date:   Fri, 09 Sep 2022 09:00:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662714018;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4hZhZaW0Eogn+qr+uNa/zbMd03hOfaVciaK8E/NIglI=;
        b=0dELF6rKVq6chQoFyuVbCmMuw1NXNo2k5ZzsDglQNmYqyzAkXTUYzECzeQiE3Y7K+3BKmr
        WHf7mLfWPQbEMf1jSfsQGKiaqEhwTV7ZPW/YyD3XMwyk4w+l79D2pX0i9YRhsxcIBC09lX
        HlFnFYFYVGQppsu3pcYqR79sxZReBub895X0QcNns3DuXzqRG/lc7zi+PsMbIRNimeHY+y
        7arHmaUWM/rETVRhEvvOosTNBSfWpSku7jKoasPw++yRgKFBWQ+EZV/lS3bE3o06G4Fa1P
        1mUwnCzrV5pIbjgl8SMHxF9QfJ8xMhtilbGVn5c1VfOfv2F/cF11szwas07xaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662714018;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4hZhZaW0Eogn+qr+uNa/zbMd03hOfaVciaK8E/NIglI=;
        b=qFpBnjtM1ck+lkhne7bdi87dgT++sOszJVG7UF/BMLd5jicORKcnxlDG6NKRJKVOrdDKiM
        Lp+vixFPzbn4dbBA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] freezer,sched: Rewrite core freezer logic
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220822114649.055452969@infradead.org>
References: <20220822114649.055452969@infradead.org>
MIME-Version: 1.0
Message-ID: <166271401698.401.16454330646670729110.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     f5d39b020809146cc28e6e73369bf8065e0310aa
Gitweb:        https://git.kernel.org/tip/f5d39b020809146cc28e6e73369bf8065e0310aa
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 22 Aug 2022 13:18:22 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 07 Sep 2022 21:53:50 +02:00

freezer,sched: Rewrite core freezer logic

Rewrite the core freezer to behave better wrt thawing and be simpler
in general.

By replacing PF_FROZEN with TASK_FROZEN, a special block state, it is
ensured frozen tasks stay frozen until thawed and don't randomly wake
up early, as is currently possible.

As such, it does away with PF_FROZEN and PF_FREEZER_SKIP, freeing up
two PF_flags (yay!).

Specifically; the current scheme works a little like:

	freezer_do_not_count();
	schedule();
	freezer_count();

And either the task is blocked, or it lands in try_to_freezer()
through freezer_count(). Now, when it is blocked, the freezer
considers it frozen and continues.

However, on thawing, once pm_freezing is cleared, freezer_count()
stops working, and any random/spurious wakeup will let a task run
before its time.

That is, thawing tries to thaw things in explicit order; kernel
threads and workqueues before doing bringing SMP back before userspace
etc.. However due to the above mentioned races it is entirely possible
for userspace tasks to thaw (by accident) before SMP is back.

This can be a fatal problem in asymmetric ISA architectures (eg ARMv9)
where the userspace task requires a special CPU to run.

As said; replace this with a special task state TASK_FROZEN and add
the following state transitions:

	TASK_FREEZABLE	-> TASK_FROZEN
	__TASK_STOPPED	-> TASK_FROZEN
	__TASK_TRACED	-> TASK_FROZEN

The new TASK_FREEZABLE can be set on any state part of TASK_NORMAL
(IOW. TASK_INTERRUPTIBLE and TASK_UNINTERRUPTIBLE) -- any such state
is already required to deal with spurious wakeups and the freezer
causes one such when thawing the task (since the original state is
lost).

The special __TASK_{STOPPED,TRACED} states *can* be restored since
their canonical state is in ->jobctl.

With this, frozen tasks need an explicit TASK_FROZEN wakeup and are
free of undue (early / spurious) wakeups.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://lore.kernel.org/r/20220822114649.055452969@infradead.org
---
 drivers/android/binder.c       |   4 +-
 drivers/media/pci/pt3/pt3.c    |   4 +-
 fs/cifs/inode.c                |   4 +-
 fs/cifs/transport.c            |   5 +-
 fs/coredump.c                  |   5 +-
 fs/nfs/file.c                  |   3 +-
 fs/nfs/inode.c                 |  12 +--
 fs/nfs/nfs3proc.c              |   3 +-
 fs/nfs/nfs4proc.c              |  14 +-
 fs/nfs/nfs4state.c             |   3 +-
 fs/nfs/pnfs.c                  |   4 +-
 fs/xfs/xfs_trans_ail.c         |   8 +-
 include/linux/freezer.h        | 245 +-------------------------------
 include/linux/sched.h          |  13 +-
 include/linux/sunrpc/sched.h   |   7 +-
 include/linux/wait.h           |  12 +-
 kernel/cgroup/legacy_freezer.c |  23 +--
 kernel/exit.c                  |   4 +-
 kernel/fork.c                  |   5 +-
 kernel/freezer.c               | 133 ++++++++++++-----
 kernel/futex/waitwake.c        |   8 +-
 kernel/hung_task.c             |   4 +-
 kernel/power/main.c            |   6 +-
 kernel/power/process.c         |  10 +-
 kernel/ptrace.c                |   2 +-
 kernel/sched/core.c            |   2 +-
 kernel/signal.c                |  14 +-
 kernel/time/hrtimer.c          |   4 +-
 kernel/umh.c                   |  20 +--
 mm/khugepaged.c                |   4 +-
 net/sunrpc/sched.c             |  12 +--
 net/unix/af_unix.c             |   8 +-
 32 files changed, 210 insertions(+), 395 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index c964d7c..50197ef 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -4247,10 +4247,9 @@ static int binder_wait_for_work(struct binder_thread *thread,
 	struct binder_proc *proc = thread->proc;
 	int ret = 0;
 
-	freezer_do_not_count();
 	binder_inner_proc_lock(proc);
 	for (;;) {
-		prepare_to_wait(&thread->wait, &wait, TASK_INTERRUPTIBLE);
+		prepare_to_wait(&thread->wait, &wait, TASK_INTERRUPTIBLE|TASK_FREEZABLE);
 		if (binder_has_work_ilocked(thread, do_proc_work))
 			break;
 		if (do_proc_work)
@@ -4267,7 +4266,6 @@ static int binder_wait_for_work(struct binder_thread *thread,
 	}
 	finish_wait(&thread->wait, &wait);
 	binder_inner_proc_unlock(proc);
-	freezer_count();
 
 	return ret;
 }
diff --git a/drivers/media/pci/pt3/pt3.c b/drivers/media/pci/pt3/pt3.c
index 0d51bdf..f6deac8 100644
--- a/drivers/media/pci/pt3/pt3.c
+++ b/drivers/media/pci/pt3/pt3.c
@@ -445,8 +445,8 @@ static int pt3_fetch_thread(void *data)
 		pt3_proc_dma(adap);
 
 		delay = ktime_set(0, PT3_FETCH_DELAY * NSEC_PER_MSEC);
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		freezable_schedule_hrtimeout_range(&delay,
+		set_current_state(TASK_UNINTERRUPTIBLE|TASK_FREEZABLE);
+		schedule_hrtimeout_range(&delay,
 					PT3_FETCH_DELAY_DELTA * NSEC_PER_MSEC,
 					HRTIMER_MODE_REL);
 	}
diff --git a/fs/cifs/inode.c b/fs/cifs/inode.c
index eeeaba3..54e6bfc 100644
--- a/fs/cifs/inode.c
+++ b/fs/cifs/inode.c
@@ -2326,7 +2326,7 @@ cifs_invalidate_mapping(struct inode *inode)
 static int
 cifs_wait_bit_killable(struct wait_bit_key *key, int mode)
 {
-	freezable_schedule_unsafe();
+	schedule();
 	if (signal_pending_state(mode, current))
 		return -ERESTARTSYS;
 	return 0;
@@ -2344,7 +2344,7 @@ cifs_revalidate_mapping(struct inode *inode)
 		return 0;
 
 	rc = wait_on_bit_lock_action(flags, CIFS_INO_LOCK, cifs_wait_bit_killable,
-				     TASK_KILLABLE);
+				     TASK_KILLABLE|TASK_FREEZABLE_UNSAFE);
 	if (rc)
 		return rc;
 
diff --git a/fs/cifs/transport.c b/fs/cifs/transport.c
index de7aece..eda09fb 100644
--- a/fs/cifs/transport.c
+++ b/fs/cifs/transport.c
@@ -757,8 +757,9 @@ wait_for_response(struct TCP_Server_Info *server, struct mid_q_entry *midQ)
 {
 	int error;
 
-	error = wait_event_freezekillable_unsafe(server->response_q,
-				    midQ->mid_state != MID_REQUEST_SUBMITTED);
+	error = wait_event_state(server->response_q,
+				 midQ->mid_state != MID_REQUEST_SUBMITTED,
+				 (TASK_KILLABLE|TASK_FREEZABLE_UNSAFE));
 	if (error < 0)
 		return -ERESTARTSYS;
 
diff --git a/fs/coredump.c b/fs/coredump.c
index 3d9054c..9ce59f2 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -402,9 +402,8 @@ static int coredump_wait(int exit_code, struct core_state *core_state)
 	if (core_waiters > 0) {
 		struct core_thread *ptr;
 
-		freezer_do_not_count();
-		wait_for_completion(&core_state->startup);
-		freezer_count();
+		wait_for_completion_state(&core_state->startup,
+					  TASK_UNINTERRUPTIBLE|TASK_FREEZABLE);
 		/*
 		 * Wait for all the threads to become inactive, so that
 		 * all the thread context (extended register state, like
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index d2bcd48..e8301a3 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -570,7 +570,8 @@ static vm_fault_t nfs_vm_page_mkwrite(struct vm_fault *vmf)
 	}
 
 	wait_on_bit_action(&NFS_I(inode)->flags, NFS_INO_INVALIDATING,
-			nfs_wait_bit_killable, TASK_KILLABLE);
+			   nfs_wait_bit_killable,
+			   TASK_KILLABLE|TASK_FREEZABLE_UNSAFE);
 
 	lock_page(page);
 	mapping = page_file_mapping(page);
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index b4e46b0..a6058f5 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -72,18 +72,13 @@ nfs_fattr_to_ino_t(struct nfs_fattr *fattr)
 	return nfs_fileid_to_ino_t(fattr->fileid);
 }
 
-static int nfs_wait_killable(int mode)
+int nfs_wait_bit_killable(struct wait_bit_key *key, int mode)
 {
-	freezable_schedule_unsafe();
+	schedule();
 	if (signal_pending_state(mode, current))
 		return -ERESTARTSYS;
 	return 0;
 }
-
-int nfs_wait_bit_killable(struct wait_bit_key *key, int mode)
-{
-	return nfs_wait_killable(mode);
-}
 EXPORT_SYMBOL_GPL(nfs_wait_bit_killable);
 
 /**
@@ -1331,7 +1326,8 @@ int nfs_clear_invalid_mapping(struct address_space *mapping)
 	 */
 	for (;;) {
 		ret = wait_on_bit_action(bitlock, NFS_INO_INVALIDATING,
-					 nfs_wait_bit_killable, TASK_KILLABLE);
+					 nfs_wait_bit_killable,
+					 TASK_KILLABLE|TASK_FREEZABLE_UNSAFE);
 		if (ret)
 			goto out;
 		spin_lock(&inode->i_lock);
diff --git a/fs/nfs/nfs3proc.c b/fs/nfs/nfs3proc.c
index 1597eef..2e75796 100644
--- a/fs/nfs/nfs3proc.c
+++ b/fs/nfs/nfs3proc.c
@@ -36,7 +36,8 @@ nfs3_rpc_wrapper(struct rpc_clnt *clnt, struct rpc_message *msg, int flags)
 		res = rpc_call_sync(clnt, msg, flags);
 		if (res != -EJUKEBOX)
 			break;
-		freezable_schedule_timeout_killable_unsafe(NFS_JUKEBOX_RETRY_TIME);
+		__set_current_state(TASK_KILLABLE|TASK_FREEZABLE_UNSAFE);
+		schedule_timeout(NFS_JUKEBOX_RETRY_TIME);
 		res = -ERESTARTSYS;
 	} while (!fatal_signal_pending(current));
 	return res;
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 3ed14a2..4553803 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -416,8 +416,8 @@ static int nfs4_delay_killable(long *timeout)
 {
 	might_sleep();
 
-	freezable_schedule_timeout_killable_unsafe(
-		nfs4_update_delay(timeout));
+	__set_current_state(TASK_KILLABLE|TASK_FREEZABLE_UNSAFE);
+	schedule_timeout(nfs4_update_delay(timeout));
 	if (!__fatal_signal_pending(current))
 		return 0;
 	return -EINTR;
@@ -427,7 +427,8 @@ static int nfs4_delay_interruptible(long *timeout)
 {
 	might_sleep();
 
-	freezable_schedule_timeout_interruptible_unsafe(nfs4_update_delay(timeout));
+	__set_current_state(TASK_INTERRUPTIBLE|TASK_FREEZABLE_UNSAFE);
+	schedule_timeout(nfs4_update_delay(timeout));
 	if (!signal_pending(current))
 		return 0;
 	return __fatal_signal_pending(current) ? -EINTR :-ERESTARTSYS;
@@ -7406,7 +7407,8 @@ nfs4_retry_setlk_simple(struct nfs4_state *state, int cmd,
 		status = nfs4_proc_setlk(state, cmd, request);
 		if ((status != -EAGAIN) || IS_SETLK(cmd))
 			break;
-		freezable_schedule_timeout_interruptible(timeout);
+		__set_current_state(TASK_INTERRUPTIBLE|TASK_FREEZABLE);
+		schedule_timeout(timeout);
 		timeout *= 2;
 		timeout = min_t(unsigned long, NFS4_LOCK_MAXTIMEOUT, timeout);
 		status = -ERESTARTSYS;
@@ -7474,10 +7476,8 @@ nfs4_retry_setlk(struct nfs4_state *state, int cmd, struct file_lock *request)
 			break;
 
 		status = -ERESTARTSYS;
-		freezer_do_not_count();
-		wait_woken(&waiter.wait, TASK_INTERRUPTIBLE,
+		wait_woken(&waiter.wait, TASK_INTERRUPTIBLE|TASK_FREEZABLE,
 			   NFS4_LOCK_MAXTIMEOUT);
-		freezer_count();
 	} while (!signalled());
 
 	remove_wait_queue(q, &waiter.wait);
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 9bab3e9..7e185f7 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -1314,7 +1314,8 @@ int nfs4_wait_clnt_recover(struct nfs_client *clp)
 
 	refcount_inc(&clp->cl_count);
 	res = wait_on_bit_action(&clp->cl_state, NFS4CLNT_MANAGER_RUNNING,
-				 nfs_wait_bit_killable, TASK_KILLABLE);
+				 nfs_wait_bit_killable,
+				 TASK_KILLABLE|TASK_FREEZABLE_UNSAFE);
 	if (res)
 		goto out;
 	if (clp->cl_cons_state < 0)
diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 41a9b6b..70706db 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -1908,7 +1908,7 @@ static int pnfs_prepare_to_retry_layoutget(struct pnfs_layout_hdr *lo)
 	pnfs_layoutcommit_inode(lo->plh_inode, false);
 	return wait_on_bit_action(&lo->plh_flags, NFS_LAYOUT_RETURN,
 				   nfs_wait_bit_killable,
-				   TASK_KILLABLE);
+				   TASK_KILLABLE|TASK_FREEZABLE_UNSAFE);
 }
 
 static void nfs_layoutget_begin(struct pnfs_layout_hdr *lo)
@@ -3193,7 +3193,7 @@ pnfs_layoutcommit_inode(struct inode *inode, bool sync)
 		status = wait_on_bit_lock_action(&nfsi->flags,
 				NFS_INO_LAYOUTCOMMITTING,
 				nfs_wait_bit_killable,
-				TASK_KILLABLE);
+				TASK_KILLABLE|TASK_FREEZABLE_UNSAFE);
 		if (status)
 			goto out;
 	}
diff --git a/fs/xfs/xfs_trans_ail.c b/fs/xfs/xfs_trans_ail.c
index d3a97a0..16fbf2a 100644
--- a/fs/xfs/xfs_trans_ail.c
+++ b/fs/xfs/xfs_trans_ail.c
@@ -602,9 +602,9 @@ xfsaild(
 
 	while (1) {
 		if (tout && tout <= 20)
-			set_current_state(TASK_KILLABLE);
+			set_current_state(TASK_KILLABLE|TASK_FREEZABLE);
 		else
-			set_current_state(TASK_INTERRUPTIBLE);
+			set_current_state(TASK_INTERRUPTIBLE|TASK_FREEZABLE);
 
 		/*
 		 * Check kthread_should_stop() after we set the task state to
@@ -653,14 +653,14 @@ xfsaild(
 		    ailp->ail_target == ailp->ail_target_prev &&
 		    list_empty(&ailp->ail_buf_list)) {
 			spin_unlock(&ailp->ail_lock);
-			freezable_schedule();
+			schedule();
 			tout = 0;
 			continue;
 		}
 		spin_unlock(&ailp->ail_lock);
 
 		if (tout)
-			freezable_schedule_timeout(msecs_to_jiffies(tout));
+			schedule_timeout(msecs_to_jiffies(tout));
 
 		__set_current_state(TASK_RUNNING);
 
diff --git a/include/linux/freezer.h b/include/linux/freezer.h
index 0621c5f..b303472 100644
--- a/include/linux/freezer.h
+++ b/include/linux/freezer.h
@@ -8,9 +8,11 @@
 #include <linux/sched.h>
 #include <linux/wait.h>
 #include <linux/atomic.h>
+#include <linux/jump_label.h>
 
 #ifdef CONFIG_FREEZER
-extern atomic_t system_freezing_cnt;	/* nr of freezing conds in effect */
+DECLARE_STATIC_KEY_FALSE(freezer_active);
+
 extern bool pm_freezing;		/* PM freezing in effect */
 extern bool pm_nosig_freezing;		/* PM nosig freezing in effect */
 
@@ -22,10 +24,7 @@ extern unsigned int freeze_timeout_msecs;
 /*
  * Check if a process has been frozen
  */
-static inline bool frozen(struct task_struct *p)
-{
-	return p->flags & PF_FROZEN;
-}
+extern bool frozen(struct task_struct *p);
 
 extern bool freezing_slow_path(struct task_struct *p);
 
@@ -34,9 +33,10 @@ extern bool freezing_slow_path(struct task_struct *p);
  */
 static inline bool freezing(struct task_struct *p)
 {
-	if (likely(!atomic_read(&system_freezing_cnt)))
-		return false;
-	return freezing_slow_path(p);
+	if (static_branch_unlikely(&freezer_active))
+		return freezing_slow_path(p);
+
+	return false;
 }
 
 /* Takes and releases task alloc lock using task_lock() */
@@ -48,23 +48,14 @@ extern int freeze_kernel_threads(void);
 extern void thaw_processes(void);
 extern void thaw_kernel_threads(void);
 
-/*
- * DO NOT ADD ANY NEW CALLERS OF THIS FUNCTION
- * If try_to_freeze causes a lockdep warning it means the caller may deadlock
- */
-static inline bool try_to_freeze_unsafe(void)
+static inline bool try_to_freeze(void)
 {
 	might_sleep();
 	if (likely(!freezing(current)))
 		return false;
-	return __refrigerator(false);
-}
-
-static inline bool try_to_freeze(void)
-{
 	if (!(current->flags & PF_NOFREEZE))
 		debug_check_no_locks_held();
-	return try_to_freeze_unsafe();
+	return __refrigerator(false);
 }
 
 extern bool freeze_task(struct task_struct *p);
@@ -79,195 +70,6 @@ static inline bool cgroup_freezing(struct task_struct *task)
 }
 #endif /* !CONFIG_CGROUP_FREEZER */
 
-/*
- * The PF_FREEZER_SKIP flag should be set by a vfork parent right before it
- * calls wait_for_completion(&vfork) and reset right after it returns from this
- * function.  Next, the parent should call try_to_freeze() to freeze itself
- * appropriately in case the child has exited before the freezing of tasks is
- * complete.  However, we don't want kernel threads to be frozen in unexpected
- * places, so we allow them to block freeze_processes() instead or to set
- * PF_NOFREEZE if needed. Fortunately, in the ____call_usermodehelper() case the
- * parent won't really block freeze_processes(), since ____call_usermodehelper()
- * (the child) does a little before exec/exit and it can't be frozen before
- * waking up the parent.
- */
-
-
-/**
- * freezer_do_not_count - tell freezer to ignore %current
- *
- * Tell freezers to ignore the current task when determining whether the
- * target frozen state is reached.  IOW, the current task will be
- * considered frozen enough by freezers.
- *
- * The caller shouldn't do anything which isn't allowed for a frozen task
- * until freezer_cont() is called.  Usually, freezer[_do_not]_count() pair
- * wrap a scheduling operation and nothing much else.
- */
-static inline void freezer_do_not_count(void)
-{
-	current->flags |= PF_FREEZER_SKIP;
-}
-
-/**
- * freezer_count - tell freezer to stop ignoring %current
- *
- * Undo freezer_do_not_count().  It tells freezers that %current should be
- * considered again and tries to freeze if freezing condition is already in
- * effect.
- */
-static inline void freezer_count(void)
-{
-	current->flags &= ~PF_FREEZER_SKIP;
-	/*
-	 * If freezing is in progress, the following paired with smp_mb()
-	 * in freezer_should_skip() ensures that either we see %true
-	 * freezing() or freezer_should_skip() sees !PF_FREEZER_SKIP.
-	 */
-	smp_mb();
-	try_to_freeze();
-}
-
-/* DO NOT ADD ANY NEW CALLERS OF THIS FUNCTION */
-static inline void freezer_count_unsafe(void)
-{
-	current->flags &= ~PF_FREEZER_SKIP;
-	smp_mb();
-	try_to_freeze_unsafe();
-}
-
-/**
- * freezer_should_skip - whether to skip a task when determining frozen
- *			 state is reached
- * @p: task in quesion
- *
- * This function is used by freezers after establishing %true freezing() to
- * test whether a task should be skipped when determining the target frozen
- * state is reached.  IOW, if this function returns %true, @p is considered
- * frozen enough.
- */
-static inline bool freezer_should_skip(struct task_struct *p)
-{
-	/*
-	 * The following smp_mb() paired with the one in freezer_count()
-	 * ensures that either freezer_count() sees %true freezing() or we
-	 * see cleared %PF_FREEZER_SKIP and return %false.  This makes it
-	 * impossible for a task to slip frozen state testing after
-	 * clearing %PF_FREEZER_SKIP.
-	 */
-	smp_mb();
-	return p->flags & PF_FREEZER_SKIP;
-}
-
-/*
- * These functions are intended to be used whenever you want allow a sleeping
- * task to be frozen. Note that neither return any clear indication of
- * whether a freeze event happened while in this function.
- */
-
-/* Like schedule(), but should not block the freezer. */
-static inline void freezable_schedule(void)
-{
-	freezer_do_not_count();
-	schedule();
-	freezer_count();
-}
-
-/* DO NOT ADD ANY NEW CALLERS OF THIS FUNCTION */
-static inline void freezable_schedule_unsafe(void)
-{
-	freezer_do_not_count();
-	schedule();
-	freezer_count_unsafe();
-}
-
-/*
- * Like schedule_timeout(), but should not block the freezer.  Do not
- * call this with locks held.
- */
-static inline long freezable_schedule_timeout(long timeout)
-{
-	long __retval;
-	freezer_do_not_count();
-	__retval = schedule_timeout(timeout);
-	freezer_count();
-	return __retval;
-}
-
-/*
- * Like schedule_timeout_interruptible(), but should not block the freezer.  Do not
- * call this with locks held.
- */
-static inline long freezable_schedule_timeout_interruptible(long timeout)
-{
-	long __retval;
-	freezer_do_not_count();
-	__retval = schedule_timeout_interruptible(timeout);
-	freezer_count();
-	return __retval;
-}
-
-/* DO NOT ADD ANY NEW CALLERS OF THIS FUNCTION */
-static inline long freezable_schedule_timeout_interruptible_unsafe(long timeout)
-{
-	long __retval;
-
-	freezer_do_not_count();
-	__retval = schedule_timeout_interruptible(timeout);
-	freezer_count_unsafe();
-	return __retval;
-}
-
-/* Like schedule_timeout_killable(), but should not block the freezer. */
-static inline long freezable_schedule_timeout_killable(long timeout)
-{
-	long __retval;
-	freezer_do_not_count();
-	__retval = schedule_timeout_killable(timeout);
-	freezer_count();
-	return __retval;
-}
-
-/* DO NOT ADD ANY NEW CALLERS OF THIS FUNCTION */
-static inline long freezable_schedule_timeout_killable_unsafe(long timeout)
-{
-	long __retval;
-	freezer_do_not_count();
-	__retval = schedule_timeout_killable(timeout);
-	freezer_count_unsafe();
-	return __retval;
-}
-
-/*
- * Like schedule_hrtimeout_range(), but should not block the freezer.  Do not
- * call this with locks held.
- */
-static inline int freezable_schedule_hrtimeout_range(ktime_t *expires,
-		u64 delta, const enum hrtimer_mode mode)
-{
-	int __retval;
-	freezer_do_not_count();
-	__retval = schedule_hrtimeout_range(expires, delta, mode);
-	freezer_count();
-	return __retval;
-}
-
-/*
- * Freezer-friendly wrappers around wait_event_interruptible(),
- * wait_event_killable() and wait_event_interruptible_timeout(), originally
- * defined in <linux/wait.h>
- */
-
-/* DO NOT ADD ANY NEW CALLERS OF THIS FUNCTION */
-#define wait_event_freezekillable_unsafe(wq, condition)			\
-({									\
-	int __retval;							\
-	freezer_do_not_count();						\
-	__retval = wait_event_killable(wq, (condition));		\
-	freezer_count_unsafe();						\
-	__retval;							\
-})
-
 #else /* !CONFIG_FREEZER */
 static inline bool frozen(struct task_struct *p) { return false; }
 static inline bool freezing(struct task_struct *p) { return false; }
@@ -281,35 +83,8 @@ static inline void thaw_kernel_threads(void) {}
 
 static inline bool try_to_freeze(void) { return false; }
 
-static inline void freezer_do_not_count(void) {}
-static inline void freezer_count(void) {}
-static inline int freezer_should_skip(struct task_struct *p) { return 0; }
 static inline void set_freezable(void) {}
 
-#define freezable_schedule()  schedule()
-
-#define freezable_schedule_unsafe()  schedule()
-
-#define freezable_schedule_timeout(timeout)  schedule_timeout(timeout)
-
-#define freezable_schedule_timeout_interruptible(timeout)		\
-	schedule_timeout_interruptible(timeout)
-
-#define freezable_schedule_timeout_interruptible_unsafe(timeout)	\
-	schedule_timeout_interruptible(timeout)
-
-#define freezable_schedule_timeout_killable(timeout)			\
-	schedule_timeout_killable(timeout)
-
-#define freezable_schedule_timeout_killable_unsafe(timeout)		\
-	schedule_timeout_killable(timeout)
-
-#define freezable_schedule_hrtimeout_range(expires, delta, mode)	\
-	schedule_hrtimeout_range(expires, delta, mode)
-
-#define wait_event_freezekillable_unsafe(wq, condition)			\
-		wait_event_killable(wq, condition)
-
 #endif /* !CONFIG_FREEZER */
 
 #endif	/* FREEZER_H_INCLUDED */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 9fc23a2..4c91efd 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -97,12 +97,19 @@ struct task_group;
 #define TASK_WAKING			0x00000200
 #define TASK_NOLOAD			0x00000400
 #define TASK_NEW			0x00000800
-/* RT specific auxilliary flag to mark RT lock waiters */
 #define TASK_RTLOCK_WAIT		0x00001000
-#define TASK_STATE_MAX			0x00002000
+#define TASK_FREEZABLE			0x00002000
+#define __TASK_FREEZABLE_UNSAFE	       (0x00004000 * IS_ENABLED(CONFIG_LOCKDEP))
+#define TASK_FROZEN			0x00008000
+#define TASK_STATE_MAX			0x00010000
 
 #define TASK_ANY			(TASK_STATE_MAX-1)
 
+/*
+ * DO NOT ADD ANY NEW USERS !
+ */
+#define TASK_FREEZABLE_UNSAFE		(TASK_FREEZABLE | __TASK_FREEZABLE_UNSAFE)
+
 /* Convenience macros for the sake of set_current_state: */
 #define TASK_KILLABLE			(TASK_WAKEKILL | TASK_UNINTERRUPTIBLE)
 #define TASK_STOPPED			(TASK_WAKEKILL | __TASK_STOPPED)
@@ -1716,7 +1723,6 @@ extern struct pid *cad_pid;
 #define PF_NPROC_EXCEEDED	0x00001000	/* set_user() noticed that RLIMIT_NPROC was exceeded */
 #define PF_USED_MATH		0x00002000	/* If unset the fpu must be initialized before use */
 #define PF_NOFREEZE		0x00008000	/* This thread should not be frozen */
-#define PF_FROZEN		0x00010000	/* Frozen for system suspend */
 #define PF_KSWAPD		0x00020000	/* I am kswapd */
 #define PF_MEMALLOC_NOFS	0x00040000	/* All allocation requests will inherit GFP_NOFS */
 #define PF_MEMALLOC_NOIO	0x00080000	/* All allocation requests will inherit GFP_NOIO */
@@ -1727,7 +1733,6 @@ extern struct pid *cad_pid;
 #define PF_NO_SETAFFINITY	0x04000000	/* Userland is not allowed to meddle with cpus_mask */
 #define PF_MCE_EARLY		0x08000000      /* Early kill for mce process policy */
 #define PF_MEMALLOC_PIN		0x10000000	/* Allocation context constrained to zones which allow long term pinning. */
-#define PF_FREEZER_SKIP		0x40000000	/* Freezer should not count it as freezable */
 #define PF_SUSPEND_TASK		0x80000000      /* This thread called freeze_processes() and should not be frozen */
 
 /*
diff --git a/include/linux/sunrpc/sched.h b/include/linux/sunrpc/sched.h
index acc6264..baeca2f 100644
--- a/include/linux/sunrpc/sched.h
+++ b/include/linux/sunrpc/sched.h
@@ -252,7 +252,7 @@ int		rpc_malloc(struct rpc_task *);
 void		rpc_free(struct rpc_task *);
 int		rpciod_up(void);
 void		rpciod_down(void);
-int		__rpc_wait_for_completion_task(struct rpc_task *task, wait_bit_action_f *);
+int		rpc_wait_for_completion_task(struct rpc_task *task);
 #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
 struct net;
 void		rpc_show_tasks(struct net *);
@@ -264,11 +264,6 @@ extern struct workqueue_struct *xprtiod_workqueue;
 void		rpc_prepare_task(struct rpc_task *task);
 gfp_t		rpc_task_gfp_mask(void);
 
-static inline int rpc_wait_for_completion_task(struct rpc_task *task)
-{
-	return __rpc_wait_for_completion_task(task, NULL);
-}
-
 #if IS_ENABLED(CONFIG_SUNRPC_DEBUG) || IS_ENABLED(CONFIG_TRACEPOINTS)
 static inline const char * rpc_qname(const struct rpc_wait_queue *q)
 {
diff --git a/include/linux/wait.h b/include/linux/wait.h
index b926eb9..14ad8a0 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -361,8 +361,8 @@ do {										\
 } while (0)
 
 #define __wait_event_freezable(wq_head, condition)				\
-	___wait_event(wq_head, condition, TASK_INTERRUPTIBLE, 0, 0,		\
-			    freezable_schedule())
+	___wait_event(wq_head, condition, (TASK_INTERRUPTIBLE|TASK_FREEZABLE),	\
+			0, 0, schedule())
 
 /**
  * wait_event_freezable - sleep (or freeze) until a condition gets true
@@ -420,8 +420,8 @@ do {										\
 
 #define __wait_event_freezable_timeout(wq_head, condition, timeout)		\
 	___wait_event(wq_head, ___wait_cond_timeout(condition),			\
-		      TASK_INTERRUPTIBLE, 0, timeout,				\
-		      __ret = freezable_schedule_timeout(__ret))
+		      (TASK_INTERRUPTIBLE|TASK_FREEZABLE), 0, timeout,		\
+		      __ret = schedule_timeout(__ret))
 
 /*
  * like wait_event_timeout() -- except it uses TASK_INTERRUPTIBLE to avoid
@@ -642,8 +642,8 @@ do {										\
 
 
 #define __wait_event_freezable_exclusive(wq, condition)				\
-	___wait_event(wq, condition, TASK_INTERRUPTIBLE, 1, 0,			\
-			freezable_schedule())
+	___wait_event(wq, condition, (TASK_INTERRUPTIBLE|TASK_FREEZABLE), 1, 0,\
+			schedule())
 
 #define wait_event_freezable_exclusive(wq, condition)				\
 ({										\
diff --git a/kernel/cgroup/legacy_freezer.c b/kernel/cgroup/legacy_freezer.c
index 0823679..1b6b218 100644
--- a/kernel/cgroup/legacy_freezer.c
+++ b/kernel/cgroup/legacy_freezer.c
@@ -113,7 +113,7 @@ static int freezer_css_online(struct cgroup_subsys_state *css)
 
 	if (parent && (parent->state & CGROUP_FREEZING)) {
 		freezer->state |= CGROUP_FREEZING_PARENT | CGROUP_FROZEN;
-		atomic_inc(&system_freezing_cnt);
+		static_branch_inc(&freezer_active);
 	}
 
 	mutex_unlock(&freezer_mutex);
@@ -134,7 +134,7 @@ static void freezer_css_offline(struct cgroup_subsys_state *css)
 	mutex_lock(&freezer_mutex);
 
 	if (freezer->state & CGROUP_FREEZING)
-		atomic_dec(&system_freezing_cnt);
+		static_branch_dec(&freezer_active);
 
 	freezer->state = 0;
 
@@ -179,6 +179,7 @@ static void freezer_attach(struct cgroup_taskset *tset)
 			__thaw_task(task);
 		} else {
 			freeze_task(task);
+
 			/* clear FROZEN and propagate upwards */
 			while (freezer && (freezer->state & CGROUP_FROZEN)) {
 				freezer->state &= ~CGROUP_FROZEN;
@@ -271,16 +272,8 @@ static void update_if_frozen(struct cgroup_subsys_state *css)
 	css_task_iter_start(css, 0, &it);
 
 	while ((task = css_task_iter_next(&it))) {
-		if (freezing(task)) {
-			/*
-			 * freezer_should_skip() indicates that the task
-			 * should be skipped when determining freezing
-			 * completion.  Consider it frozen in addition to
-			 * the usual frozen condition.
-			 */
-			if (!frozen(task) && !freezer_should_skip(task))
-				goto out_iter_end;
-		}
+		if (freezing(task) && !frozen(task))
+			goto out_iter_end;
 	}
 
 	freezer->state |= CGROUP_FROZEN;
@@ -357,7 +350,7 @@ static void freezer_apply_state(struct freezer *freezer, bool freeze,
 
 	if (freeze) {
 		if (!(freezer->state & CGROUP_FREEZING))
-			atomic_inc(&system_freezing_cnt);
+			static_branch_inc(&freezer_active);
 		freezer->state |= state;
 		freeze_cgroup(freezer);
 	} else {
@@ -366,9 +359,9 @@ static void freezer_apply_state(struct freezer *freezer, bool freeze,
 		freezer->state &= ~state;
 
 		if (!(freezer->state & CGROUP_FREEZING)) {
-			if (was_freezing)
-				atomic_dec(&system_freezing_cnt);
 			freezer->state &= ~CGROUP_FROZEN;
+			if (was_freezing)
+				static_branch_dec(&freezer_active);
 			unfreeze_cgroup(freezer);
 		}
 	}
diff --git a/kernel/exit.c b/kernel/exit.c
index 84021b2..ba683f8 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -374,10 +374,10 @@ static void coredump_task_exit(struct task_struct *tsk)
 			complete(&core_state->startup);
 
 		for (;;) {
-			set_current_state(TASK_UNINTERRUPTIBLE);
+			set_current_state(TASK_UNINTERRUPTIBLE|TASK_FREEZABLE);
 			if (!self.task) /* see coredump_finish() */
 				break;
-			freezable_schedule();
+			schedule();
 		}
 		__set_current_state(TASK_RUNNING);
 	}
diff --git a/kernel/fork.c b/kernel/fork.c
index 90c85b1..a1de2f5 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1420,13 +1420,12 @@ static void complete_vfork_done(struct task_struct *tsk)
 static int wait_for_vfork_done(struct task_struct *child,
 				struct completion *vfork)
 {
+	unsigned int state = TASK_UNINTERRUPTIBLE|TASK_KILLABLE|TASK_FREEZABLE;
 	int killed;
 
-	freezer_do_not_count();
 	cgroup_enter_frozen();
-	killed = wait_for_completion_killable(vfork);
+	killed = wait_for_completion_state(vfork, state);
 	cgroup_leave_frozen(false);
-	freezer_count();
 
 	if (killed) {
 		task_lock(child);
diff --git a/kernel/freezer.c b/kernel/freezer.c
index 45ab36f..4fad0e6 100644
--- a/kernel/freezer.c
+++ b/kernel/freezer.c
@@ -13,10 +13,11 @@
 #include <linux/kthread.h>
 
 /* total number of freezing conditions in effect */
-atomic_t system_freezing_cnt = ATOMIC_INIT(0);
-EXPORT_SYMBOL(system_freezing_cnt);
+DEFINE_STATIC_KEY_FALSE(freezer_active);
+EXPORT_SYMBOL(freezer_active);
 
-/* indicate whether PM freezing is in effect, protected by
+/*
+ * indicate whether PM freezing is in effect, protected by
  * system_transition_mutex
  */
 bool pm_freezing;
@@ -29,7 +30,7 @@ static DEFINE_SPINLOCK(freezer_lock);
  * freezing_slow_path - slow path for testing whether a task needs to be frozen
  * @p: task to be tested
  *
- * This function is called by freezing() if system_freezing_cnt isn't zero
+ * This function is called by freezing() if freezer_active isn't zero
  * and tests whether @p needs to enter and stay in frozen state.  Can be
  * called under any context.  The freezers are responsible for ensuring the
  * target tasks see the updated state.
@@ -52,41 +53,40 @@ bool freezing_slow_path(struct task_struct *p)
 }
 EXPORT_SYMBOL(freezing_slow_path);
 
+bool frozen(struct task_struct *p)
+{
+	return READ_ONCE(p->__state) & TASK_FROZEN;
+}
+
 /* Refrigerator is place where frozen processes are stored :-). */
 bool __refrigerator(bool check_kthr_stop)
 {
-	/* Hmm, should we be allowed to suspend when there are realtime
-	   processes around? */
+	unsigned int state = get_current_state();
 	bool was_frozen = false;
-	unsigned int save = get_current_state();
 
 	pr_debug("%s entered refrigerator\n", current->comm);
 
+	WARN_ON_ONCE(state && !(state & TASK_NORMAL));
+
 	for (;;) {
-		set_current_state(TASK_UNINTERRUPTIBLE);
+		bool freeze;
+
+		set_current_state(TASK_FROZEN);
 
 		spin_lock_irq(&freezer_lock);
-		current->flags |= PF_FROZEN;
-		if (!freezing(current) ||
-		    (check_kthr_stop && kthread_should_stop()))
-			current->flags &= ~PF_FROZEN;
+		freeze = freezing(current) && !(check_kthr_stop && kthread_should_stop());
 		spin_unlock_irq(&freezer_lock);
 
-		if (!(current->flags & PF_FROZEN))
+		if (!freeze)
 			break;
+
 		was_frozen = true;
 		schedule();
 	}
+	__set_current_state(TASK_RUNNING);
 
 	pr_debug("%s left refrigerator\n", current->comm);
 
-	/*
-	 * Restore saved task state before returning.  The mb'd version
-	 * needs to be used; otherwise, it might silently break
-	 * synchronization which depends on ordered task state change.
-	 */
-	set_current_state(save);
-
 	return was_frozen;
 }
 EXPORT_SYMBOL(__refrigerator);
@@ -101,6 +101,44 @@ static void fake_signal_wake_up(struct task_struct *p)
 	}
 }
 
+static int __set_task_frozen(struct task_struct *p, void *arg)
+{
+	unsigned int state = READ_ONCE(p->__state);
+
+	if (p->on_rq)
+		return 0;
+
+	if (p != current && task_curr(p))
+		return 0;
+
+	if (!(state & (TASK_FREEZABLE | __TASK_STOPPED | __TASK_TRACED)))
+		return 0;
+
+	/*
+	 * Only TASK_NORMAL can be augmented with TASK_FREEZABLE, since they
+	 * can suffer spurious wakeups.
+	 */
+	if (state & TASK_FREEZABLE)
+		WARN_ON_ONCE(!(state & TASK_NORMAL));
+
+#ifdef CONFIG_LOCKDEP
+	/*
+	 * It's dangerous to freeze with locks held; there be dragons there.
+	 */
+	if (!(state & __TASK_FREEZABLE_UNSAFE))
+		WARN_ON_ONCE(debug_locks && p->lockdep_depth);
+#endif
+
+	WRITE_ONCE(p->__state, TASK_FROZEN);
+	return TASK_FROZEN;
+}
+
+static bool __freeze_task(struct task_struct *p)
+{
+	/* TASK_FREEZABLE|TASK_STOPPED|TASK_TRACED -> TASK_FROZEN */
+	return task_call_func(p, __set_task_frozen, NULL);
+}
+
 /**
  * freeze_task - send a freeze request to given task
  * @p: task to send the request to
@@ -116,20 +154,8 @@ bool freeze_task(struct task_struct *p)
 {
 	unsigned long flags;
 
-	/*
-	 * This check can race with freezer_do_not_count, but worst case that
-	 * will result in an extra wakeup being sent to the task.  It does not
-	 * race with freezer_count(), the barriers in freezer_count() and
-	 * freezer_should_skip() ensure that either freezer_count() sees
-	 * freezing == true in try_to_freeze() and freezes, or
-	 * freezer_should_skip() sees !PF_FREEZE_SKIP and freezes the task
-	 * normally.
-	 */
-	if (freezer_should_skip(p))
-		return false;
-
 	spin_lock_irqsave(&freezer_lock, flags);
-	if (!freezing(p) || frozen(p)) {
+	if (!freezing(p) || frozen(p) || __freeze_task(p)) {
 		spin_unlock_irqrestore(&freezer_lock, flags);
 		return false;
 	}
@@ -137,19 +163,52 @@ bool freeze_task(struct task_struct *p)
 	if (!(p->flags & PF_KTHREAD))
 		fake_signal_wake_up(p);
 	else
-		wake_up_state(p, TASK_INTERRUPTIBLE);
+		wake_up_state(p, TASK_NORMAL);
 
 	spin_unlock_irqrestore(&freezer_lock, flags);
 	return true;
 }
 
+/*
+ * The special task states (TASK_STOPPED, TASK_TRACED) keep their canonical
+ * state in p->jobctl. If either of them got a wakeup that was missed because
+ * TASK_FROZEN, then their canonical state reflects that and the below will
+ * refuse to restore the special state and instead issue the wakeup.
+ */
+static int __set_task_special(struct task_struct *p, void *arg)
+{
+	unsigned int state = 0;
+
+	if (p->jobctl & JOBCTL_TRACED)
+		state = TASK_TRACED;
+
+	else if (p->jobctl & JOBCTL_STOPPED)
+		state = TASK_STOPPED;
+
+	if (state)
+		WRITE_ONCE(p->__state, state);
+
+	return state;
+}
+
 void __thaw_task(struct task_struct *p)
 {
-	unsigned long flags;
+	unsigned long flags, flags2;
 
 	spin_lock_irqsave(&freezer_lock, flags);
-	if (frozen(p))
-		wake_up_process(p);
+	if (WARN_ON_ONCE(freezing(p)))
+		goto unlock;
+
+	if (lock_task_sighand(p, &flags2)) {
+		/* TASK_FROZEN -> TASK_{STOPPED,TRACED} */
+		bool ret = task_call_func(p, __set_task_special, NULL);
+		unlock_task_sighand(p, &flags2);
+		if (ret)
+			goto unlock;
+	}
+
+	wake_up_state(p, TASK_FROZEN);
+unlock:
 	spin_unlock_irqrestore(&freezer_lock, flags);
 }
 
diff --git a/kernel/futex/waitwake.c b/kernel/futex/waitwake.c
index 4ce0923..ba01b94 100644
--- a/kernel/futex/waitwake.c
+++ b/kernel/futex/waitwake.c
@@ -334,7 +334,7 @@ void futex_wait_queue(struct futex_hash_bucket *hb, struct futex_q *q,
 	 * futex_queue() calls spin_unlock() upon completion, both serializing
 	 * access to the hash list and forcing another memory barrier.
 	 */
-	set_current_state(TASK_INTERRUPTIBLE);
+	set_current_state(TASK_INTERRUPTIBLE|TASK_FREEZABLE);
 	futex_queue(q, hb);
 
 	/* Arm the timer */
@@ -352,7 +352,7 @@ void futex_wait_queue(struct futex_hash_bucket *hb, struct futex_q *q,
 		 * is no timeout, or if it has yet to expire.
 		 */
 		if (!timeout || timeout->task)
-			freezable_schedule();
+			schedule();
 	}
 	__set_current_state(TASK_RUNNING);
 }
@@ -430,7 +430,7 @@ retry:
 			return ret;
 	}
 
-	set_current_state(TASK_INTERRUPTIBLE);
+	set_current_state(TASK_INTERRUPTIBLE|TASK_FREEZABLE);
 
 	for (i = 0; i < count; i++) {
 		u32 __user *uaddr = (u32 __user *)(unsigned long)vs[i].w.uaddr;
@@ -504,7 +504,7 @@ static void futex_sleep_multiple(struct futex_vector *vs, unsigned int count,
 			return;
 	}
 
-	freezable_schedule();
+	schedule();
 }
 
 /**
diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index bb2354f..f1321c0 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -95,8 +95,8 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
 	 * Ensure the task is not frozen.
 	 * Also, skip vfork and any other user process that freezer should skip.
 	 */
-	if (unlikely(t->flags & (PF_FROZEN | PF_FREEZER_SKIP)))
-	    return;
+	if (unlikely(READ_ONCE(t->__state) & (TASK_FREEZABLE | TASK_FROZEN)))
+		return;
 
 	/*
 	 * When a freshly created task is scheduled once, changes its state to
diff --git a/kernel/power/main.c b/kernel/power/main.c
index dae3d17..31ec4a9 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -24,7 +24,7 @@
 unsigned int lock_system_sleep(void)
 {
 	unsigned int flags = current->flags;
-	current->flags |= PF_FREEZER_SKIP;
+	current->flags |= PF_NOFREEZE;
 	mutex_lock(&system_transition_mutex);
 	return flags;
 }
@@ -48,8 +48,8 @@ void unlock_system_sleep(unsigned int flags)
 	 * Which means, if we use try_to_freeze() here, it would make them
 	 * enter the refrigerator, thus causing hibernation to lockup.
 	 */
-	if (!(flags & PF_FREEZER_SKIP))
-		current->flags &= ~PF_FREEZER_SKIP;
+	if (!(flags & PF_NOFREEZE))
+		current->flags &= ~PF_NOFREEZE;
 	mutex_unlock(&system_transition_mutex);
 }
 EXPORT_SYMBOL_GPL(unlock_system_sleep);
diff --git a/kernel/power/process.c b/kernel/power/process.c
index 3068601..ddd9988 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -50,8 +50,7 @@ static int try_to_freeze_tasks(bool user_only)
 			if (p == current || !freeze_task(p))
 				continue;
 
-			if (!freezer_should_skip(p))
-				todo++;
+			todo++;
 		}
 		read_unlock(&tasklist_lock);
 
@@ -96,8 +95,7 @@ static int try_to_freeze_tasks(bool user_only)
 		if (!wakeup || pm_debug_messages_on) {
 			read_lock(&tasklist_lock);
 			for_each_process_thread(g, p) {
-				if (p != current && !freezer_should_skip(p)
-				    && freezing(p) && !frozen(p))
+				if (p != current && freezing(p) && !frozen(p))
 					sched_show_task(p);
 			}
 			read_unlock(&tasklist_lock);
@@ -129,7 +127,7 @@ int freeze_processes(void)
 	current->flags |= PF_SUSPEND_TASK;
 
 	if (!pm_freezing)
-		atomic_inc(&system_freezing_cnt);
+		static_branch_inc(&freezer_active);
 
 	pm_wakeup_clear(0);
 	pr_info("Freezing user space processes ... ");
@@ -190,7 +188,7 @@ void thaw_processes(void)
 
 	trace_suspend_resume(TPS("thaw_processes"), 0, true);
 	if (pm_freezing)
-		atomic_dec(&system_freezing_cnt);
+		static_branch_dec(&freezer_active);
 	pm_freezing = false;
 	pm_nosig_freezing = false;
 
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 1893d90..5448219 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -269,7 +269,7 @@ static int ptrace_check_attach(struct task_struct *child, bool ignore_state)
 	read_unlock(&tasklist_lock);
 
 	if (!ret && !ignore_state &&
-	    WARN_ON_ONCE(!wait_task_inactive(child, __TASK_TRACED)))
+	    WARN_ON_ONCE(!wait_task_inactive(child, __TASK_TRACED|TASK_FROZEN)))
 		ret = -ESRCH;
 
 	return ret;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ea26526..2b85d1b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6428,7 +6428,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 			prev->sched_contributes_to_load =
 				(prev_state & TASK_UNINTERRUPTIBLE) &&
 				!(prev_state & TASK_NOLOAD) &&
-				!(prev->flags & PF_FROZEN);
+				!(prev_state & TASK_FROZEN);
 
 			if (prev->sched_contributes_to_load)
 				rq->nr_uninterruptible++;
diff --git a/kernel/signal.c b/kernel/signal.c
index 6f86fda..c2e90d6 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2304,7 +2304,7 @@ static int ptrace_stop(int exit_code, int why, unsigned long message,
 	read_unlock(&tasklist_lock);
 	cgroup_enter_frozen();
 	preempt_enable_no_resched();
-	freezable_schedule();
+	schedule();
 	cgroup_leave_frozen(true);
 
 	/*
@@ -2473,7 +2473,7 @@ static bool do_signal_stop(int signr)
 
 		/* Now we don't run again until woken by SIGCONT or SIGKILL */
 		cgroup_enter_frozen();
-		freezable_schedule();
+		schedule();
 		return true;
 	} else {
 		/*
@@ -2548,11 +2548,11 @@ static void do_freezer_trap(void)
 	 * immediately (if there is a non-fatal signal pending), and
 	 * put the task into sleep.
 	 */
-	__set_current_state(TASK_INTERRUPTIBLE);
+	__set_current_state(TASK_INTERRUPTIBLE|TASK_FREEZABLE);
 	clear_thread_flag(TIF_SIGPENDING);
 	spin_unlock_irq(&current->sighand->siglock);
 	cgroup_enter_frozen();
-	freezable_schedule();
+	schedule();
 }
 
 static int ptrace_signal(int signr, kernel_siginfo_t *info, enum pid_type type)
@@ -3600,9 +3600,9 @@ static int do_sigtimedwait(const sigset_t *which, kernel_siginfo_t *info,
 		recalc_sigpending();
 		spin_unlock_irq(&tsk->sighand->siglock);
 
-		__set_current_state(TASK_INTERRUPTIBLE);
-		ret = freezable_schedule_hrtimeout_range(to, tsk->timer_slack_ns,
-							 HRTIMER_MODE_REL);
+		__set_current_state(TASK_INTERRUPTIBLE|TASK_FREEZABLE);
+		ret = schedule_hrtimeout_range(to, tsk->timer_slack_ns,
+					       HRTIMER_MODE_REL);
 		spin_lock_irq(&tsk->sighand->siglock);
 		__set_task_blocked(tsk, &tsk->real_blocked);
 		sigemptyset(&tsk->real_blocked);
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 23af5ec..3ae661a 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -2037,11 +2037,11 @@ static int __sched do_nanosleep(struct hrtimer_sleeper *t, enum hrtimer_mode mod
 	struct restart_block *restart;
 
 	do {
-		set_current_state(TASK_INTERRUPTIBLE);
+		set_current_state(TASK_INTERRUPTIBLE|TASK_FREEZABLE);
 		hrtimer_sleeper_start_expires(t, mode);
 
 		if (likely(t->task))
-			freezable_schedule();
+			schedule();
 
 		hrtimer_cancel(&t->timer);
 		mode = HRTIMER_MODE_ABS;
diff --git a/kernel/umh.c b/kernel/umh.c
index 8945eaf..8506315 100644
--- a/kernel/umh.c
+++ b/kernel/umh.c
@@ -404,6 +404,7 @@ EXPORT_SYMBOL(call_usermodehelper_setup);
  */
 int call_usermodehelper_exec(struct subprocess_info *sub_info, int wait)
 {
+	unsigned int state = TASK_UNINTERRUPTIBLE;
 	DECLARE_COMPLETION_ONSTACK(done);
 	int retval = 0;
 
@@ -437,25 +438,22 @@ int call_usermodehelper_exec(struct subprocess_info *sub_info, int wait)
 	if (wait == UMH_NO_WAIT)	/* task has freed sub_info */
 		goto unlock;
 
+	if (wait & UMH_KILLABLE)
+		state |= TASK_KILLABLE;
+
 	if (wait & UMH_FREEZABLE)
-		freezer_do_not_count();
+		state |= TASK_FREEZABLE;
 
-	if (wait & UMH_KILLABLE) {
-		retval = wait_for_completion_killable(&done);
-		if (!retval)
-			goto wait_done;
+	retval = wait_for_completion_state(&done, state);
+	if (!retval)
+		goto wait_done;
 
+	if (wait & UMH_KILLABLE) {
 		/* umh_complete() will see NULL and free sub_info */
 		if (xchg(&sub_info->complete, NULL))
 			goto unlock;
-		/* fallthrough, umh_complete() was already called */
 	}
 
-	wait_for_completion(&done);
-
-	if (wait & UMH_FREEZABLE)
-		freezer_count();
-
 wait_done:
 	retval = sub_info->retval;
 out:
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 01f7178..77162fb 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -730,8 +730,8 @@ static void khugepaged_alloc_sleep(void)
 	DEFINE_WAIT(wait);
 
 	add_wait_queue(&khugepaged_wait, &wait);
-	freezable_schedule_timeout_interruptible(
-		msecs_to_jiffies(khugepaged_alloc_sleep_millisecs));
+	__set_current_state(TASK_INTERRUPTIBLE|TASK_FREEZABLE);
+	schedule_timeout(msecs_to_jiffies(khugepaged_alloc_sleep_millisecs));
 	remove_wait_queue(&khugepaged_wait, &wait);
 }
 
diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
index 25b9221..46cbf15 100644
--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -269,7 +269,7 @@ EXPORT_SYMBOL_GPL(rpc_destroy_wait_queue);
 
 static int rpc_wait_bit_killable(struct wait_bit_key *key, int mode)
 {
-	freezable_schedule_unsafe();
+	schedule();
 	if (signal_pending_state(mode, current))
 		return -ERESTARTSYS;
 	return 0;
@@ -333,14 +333,12 @@ static int rpc_complete_task(struct rpc_task *task)
  * to enforce taking of the wq->lock and hence avoid races with
  * rpc_complete_task().
  */
-int __rpc_wait_for_completion_task(struct rpc_task *task, wait_bit_action_f *action)
+int rpc_wait_for_completion_task(struct rpc_task *task)
 {
-	if (action == NULL)
-		action = rpc_wait_bit_killable;
 	return out_of_line_wait_on_bit(&task->tk_runstate, RPC_TASK_ACTIVE,
-			action, TASK_KILLABLE);
+			rpc_wait_bit_killable, TASK_KILLABLE|TASK_FREEZABLE_UNSAFE);
 }
-EXPORT_SYMBOL_GPL(__rpc_wait_for_completion_task);
+EXPORT_SYMBOL_GPL(rpc_wait_for_completion_task);
 
 /*
  * Make an RPC task runnable.
@@ -964,7 +962,7 @@ static void __rpc_execute(struct rpc_task *task)
 		trace_rpc_task_sync_sleep(task, task->tk_action);
 		status = out_of_line_wait_on_bit(&task->tk_runstate,
 				RPC_TASK_QUEUED, rpc_wait_bit_killable,
-				TASK_KILLABLE);
+				TASK_KILLABLE|TASK_FREEZABLE);
 		if (status < 0) {
 			/*
 			 * When a sync task receives a signal, it exits with
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index bf338b7..dda9eb1 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2543,13 +2543,14 @@ static long unix_stream_data_wait(struct sock *sk, long timeo,
 				  struct sk_buff *last, unsigned int last_len,
 				  bool freezable)
 {
+	unsigned int state = TASK_INTERRUPTIBLE | freezable * TASK_FREEZABLE;
 	struct sk_buff *tail;
 	DEFINE_WAIT(wait);
 
 	unix_state_lock(sk);
 
 	for (;;) {
-		prepare_to_wait(sk_sleep(sk), &wait, TASK_INTERRUPTIBLE);
+		prepare_to_wait(sk_sleep(sk), &wait, state);
 
 		tail = skb_peek_tail(&sk->sk_receive_queue);
 		if (tail != last ||
@@ -2562,10 +2563,7 @@ static long unix_stream_data_wait(struct sock *sk, long timeo,
 
 		sk_set_bit(SOCKWQ_ASYNC_WAITDATA, sk);
 		unix_state_unlock(sk);
-		if (freezable)
-			timeo = freezable_schedule_timeout(timeo);
-		else
-			timeo = schedule_timeout(timeo);
+		timeo = schedule_timeout(timeo);
 		unix_state_lock(sk);
 
 		if (sock_flag(sk, SOCK_DEAD))
