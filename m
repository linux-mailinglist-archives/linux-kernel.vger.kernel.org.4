Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77F7D724535
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236176AbjFFOER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236737AbjFFOEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:04:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C247CE42;
        Tue,  6 Jun 2023 07:04:01 -0700 (PDT)
Date:   Tue, 6 Jun 2023 16:03:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686060240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=F9JFJX71FnksAAeM5q9c1/qEXNzjKOY57CEkHxx+ofI=;
        b=RLQubAtMa/KZci4KBS/+BzC1Ad+M+ki9kzHa8HYyv39NbfmfjHHHRDS0iyvkqrG/V3k4nZ
        +v4yuUjRsRMy0JJfQsw/9RatYaxFfdfHpYCLuIhkWQrHOtVCzKQ09zGBL0VYEBPlB69Rrm
        lqIn0+6DArGJubbz9FPQkFiCqEDuQgj7CW5ce69DkY06tyfIGK/lrqLDRIEqwGp7lVqslj
        qsQyrAQo6W0fObQC8YhJOOM/FtNTfkd/lbKFrcUEAkALxQ56wNjAR1iSUVRKWFjajKy6NQ
        /gg2nL8vCQlYRQmzoR78L0zqRoiUdRAz0pGDrE5Pbgag8d30UOK2MgjWPz/LNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686060240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=F9JFJX71FnksAAeM5q9c1/qEXNzjKOY57CEkHxx+ofI=;
        b=iJG6J6v7+3kClt+kELH2O8ecnqD0Oq28avTjW4rVE/xnBbPCX5npAUlrGqxO725ziDzNZg
        hMGgkgYBilkbVKCA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v6.4-rc5-rt4
Message-ID: <20230606140358._3o60S6s@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v6.4-rc5-rt4 patch set. 

Changes since v6.4-rc5-rt3:

  - Drop the sigqueue caching patch which was introduced in
    v6.3-rc5-rt8. After discussion with upstream it is probably not
    worth it.

  - Alternative fix for ptrace/ wait_task_inactive().

Known issues
     None

The delta patch against v6.4-rc5-rt3 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.4/incr/patch-6.4-rc5-rt3-rt4.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.4-rc5-rt4

The RT patch against v6.4-rc5 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.4/older/patch-6.4-rc5-rt4.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.4/older/patches-6.4-rc5-rt4.tar.xz

Sebastian

diff --git a/include/linux/sched.h b/include/linux/sched.h
index f2e752377eadd..3ce3e07fbf6f5 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2011,15 +2011,12 @@ static __always_inline void scheduler_ipi(void)
 	 */
 	preempt_fold_need_resched();
 }
-extern unsigned long wait_task_inactive(struct task_struct *, unsigned int match_state);
 #else
 static inline void scheduler_ipi(void) { }
-static inline unsigned long wait_task_inactive(struct task_struct *p, unsigned int match_state)
-{
-	return 1;
-}
 #endif
 
+extern unsigned long wait_task_inactive(struct task_struct *, unsigned int match_state);
+
 /*
  * Set thread flags in other task's structures.
  * See asm/thread_info.h for TIF_xxxx flags available:
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index b38ce53576000..669e8cff40c74 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -22,7 +22,6 @@ struct sighand_struct {
 	refcount_t		count;
 	wait_queue_head_t	signalfd_wqh;
 	struct k_sigaction	action[_NSIG];
-	struct sigqueue		*sigqueue_cache;
 };
 
 /*
@@ -350,7 +349,6 @@ extern int send_sig(int, struct task_struct *, int);
 extern int zap_other_threads(struct task_struct *p);
 extern struct sigqueue *sigqueue_alloc(void);
 extern void sigqueue_free(struct sigqueue *);
-extern void sigqueue_free_cached_entry(struct sigqueue *q);
 extern int send_sigqueue(struct sigqueue *, struct pid *, enum pid_type);
 extern int do_sigaction(int, struct k_sigaction *, struct k_sigaction *);
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 4ba3b5c98ca09..81cba91f30bbe 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1814,7 +1814,6 @@ static int copy_sighand(unsigned long clone_flags, struct task_struct *tsk)
 	RCU_INIT_POINTER(tsk->sighand, sig);
 	if (!sig)
 		return -ENOMEM;
-	sig->sigqueue_cache = NULL;
 
 	refcount_set(&sig->count, 1);
 	spin_lock_irq(&current->sighand->siglock);
@@ -1831,17 +1830,7 @@ static int copy_sighand(unsigned long clone_flags, struct task_struct *tsk)
 void __cleanup_sighand(struct sighand_struct *sighand)
 {
 	if (refcount_dec_and_test(&sighand->count)) {
-		struct sigqueue *sigqueue = NULL;
-
 		signalfd_cleanup(sighand);
-		spin_lock_irq(&sighand->siglock);
-		if (sighand->sigqueue_cache) {
-			sigqueue = sighand->sigqueue_cache;
-			sighand->sigqueue_cache = NULL;
-		}
-		spin_unlock_irq(&sighand->siglock);
-
-		sigqueue_free_cached_entry(sigqueue);
 		/*
 		 * sighand_cachep is SLAB_TYPESAFE_BY_RCU so we can free it
 		 * without an RCU grace period, see __lock_task_sighand().
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 77cde41aeccab..c7c09f1db4572 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2253,6 +2253,154 @@ void check_preempt_curr(struct rq *rq, struct task_struct *p, int flags)
 		rq_clock_skip_update(rq);
 }
 
+static __always_inline
+int __task_state_match(struct task_struct *p, unsigned int state)
+{
+	if (READ_ONCE(p->__state) & state)
+		return 1;
+
+#ifdef CONFIG_PREEMPT_RT
+	if (READ_ONCE(p->saved_state) & state)
+		return -1;
+#endif
+	return 0;
+}
+
+static __always_inline
+int task_state_match(struct task_struct *p, unsigned int state)
+{
+#ifdef CONFIG_PREEMPT_RT
+	int match;
+
+	/*
+	 * Serialize against current_save_and_set_rtlock_wait_state() and
+	 * current_restore_rtlock_saved_state().
+	 */
+	raw_spin_lock_irq(&p->pi_lock);
+	match = __task_state_match(p, state);
+	raw_spin_unlock_irq(&p->pi_lock);
+
+	return match;
+#else
+	return __task_state_match(p, state);
+#endif
+}
+
+/*
+ * wait_task_inactive - wait for a thread to unschedule.
+ *
+ * Wait for the thread to block in any of the states set in @match_state.
+ * If it changes, i.e. @p might have woken up, then return zero.  When we
+ * succeed in waiting for @p to be off its CPU, we return a positive number
+ * (its total switch count).  If a second call a short while later returns the
+ * same number, the caller can be sure that @p has remained unscheduled the
+ * whole time.
+ *
+ * The caller must ensure that the task *will* unschedule sometime soon,
+ * else this function might spin for a *long* time. This function can't
+ * be called with interrupts off, or it may introduce deadlock with
+ * smp_call_function() if an IPI is sent by the same process we are
+ * waiting to become inactive.
+ */
+unsigned long wait_task_inactive(struct task_struct *p, unsigned int match_state)
+{
+	int running, queued, match;
+	struct rq_flags rf;
+	unsigned long ncsw;
+	struct rq *rq;
+
+	for (;;) {
+		/*
+		 * We do the initial early heuristics without holding
+		 * any task-queue locks at all. We'll only try to get
+		 * the runqueue lock when things look like they will
+		 * work out!
+		 */
+		rq = task_rq(p);
+
+		/*
+		 * If the task is actively running on another CPU
+		 * still, just relax and busy-wait without holding
+		 * any locks.
+		 *
+		 * NOTE! Since we don't hold any locks, it's not
+		 * even sure that "rq" stays as the right runqueue!
+		 * But we don't care, since "task_on_cpu()" will
+		 * return false if the runqueue has changed and p
+		 * is actually now running somewhere else!
+		 */
+		while (task_on_cpu(rq, p)) {
+			if (!task_state_match(p, match_state))
+				return 0;
+			cpu_relax();
+		}
+
+		/*
+		 * Ok, time to look more closely! We need the rq
+		 * lock now, to be *sure*. If we're wrong, we'll
+		 * just go back and repeat.
+		 */
+		rq = task_rq_lock(p, &rf);
+		trace_sched_wait_task(p);
+		running = task_on_cpu(rq, p);
+		queued = task_on_rq_queued(p);
+		ncsw = 0;
+		if ((match = __task_state_match(p, match_state))) {
+			/*
+			 * When matching on p->saved_state, consider this task
+			 * still queued so it will wait.
+			 */
+			if (match < 0)
+				queued = 1;
+			ncsw = p->nvcsw | LONG_MIN; /* sets MSB */
+		}
+		task_rq_unlock(rq, p, &rf);
+
+		/*
+		 * If it changed from the expected state, bail out now.
+		 */
+		if (unlikely(!ncsw))
+			break;
+
+		/*
+		 * Was it really running after all now that we
+		 * checked with the proper locks actually held?
+		 *
+		 * Oops. Go back and try again..
+		 */
+		if (unlikely(running)) {
+			cpu_relax();
+			continue;
+		}
+
+		/*
+		 * It's not enough that it's not actively running,
+		 * it must be off the runqueue _entirely_, and not
+		 * preempted!
+		 *
+		 * So if it was still runnable (but just not actively
+		 * running right now), it's preempted, and we should
+		 * yield - it could be a while.
+		 */
+		if (unlikely(queued)) {
+			ktime_t to = NSEC_PER_SEC / HZ;
+
+			set_current_state(TASK_UNINTERRUPTIBLE);
+			schedule_hrtimeout(&to, HRTIMER_MODE_REL_HARD);
+			continue;
+		}
+
+		/*
+		 * Ahh, all good. It wasn't running, and it wasn't
+		 * runnable, which means that it will never become
+		 * running in the future either. We're all done!
+		 */
+		break;
+	}
+
+	return ncsw;
+}
+
 #ifdef CONFIG_SMP
 
 static void
@@ -3383,185 +3531,6 @@ int migrate_swap(struct task_struct *cur, struct task_struct *p,
 }
 #endif /* CONFIG_NUMA_BALANCING */
 
-#ifdef CONFIG_PREEMPT_RT
-
-/*
- * Consider:
- *
- *  set_special_state(X);
- *
- *  do_things()
- *    // Somewhere in there is an rtlock that can be contended:
- *    current_save_and_set_rtlock_wait_state();
- *    [...]
- *    schedule_rtlock(); (A)
- *    [...]
- *    current_restore_rtlock_saved_state();
- *
- *  schedule(); (B)
- *
- * If p->saved_state is anything else than TASK_RUNNING, then p blocked on an
- * rtlock (A) *before* voluntarily calling into schedule() (B) after setting its
- * state to X. For things like ptrace (X=TASK_TRACED), the task could have more
- * work to do upon acquiring the lock in do_things() before whoever called
- * wait_task_inactive() should return. IOW, we have to wait for:
- *
- *   p.saved_state = TASK_RUNNING
- *   p.__state     = X
- *
- * which implies the task isn't blocked on an RT lock and got to schedule() (B).
- *
- * Also see comments in ttwu_state_match().
- */
-
-static __always_inline bool state_mismatch(struct task_struct *p, unsigned int match_state)
-{
-	unsigned long flags;
-	bool mismatch;
-
-	raw_spin_lock_irqsave(&p->pi_lock, flags);
-	if (READ_ONCE(p->__state) & match_state)
-		mismatch = false;
-	else if (READ_ONCE(p->saved_state) & match_state)
-		mismatch = false;
-	else
-		mismatch = true;
-
-	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
-	return mismatch;
-}
-static __always_inline bool state_match(struct task_struct *p, unsigned int match_state,
-					bool *wait)
-{
-	if (READ_ONCE(p->__state) & match_state)
-		return true;
-	if (READ_ONCE(p->saved_state) & match_state) {
-		*wait = true;
-		return true;
-	}
-	return false;
-}
-#else
-static __always_inline bool state_mismatch(struct task_struct *p, unsigned int match_state)
-{
-	return !(READ_ONCE(p->__state) & match_state);
-}
-static __always_inline bool state_match(struct task_struct *p, unsigned int match_state,
-					bool *wait)
-{
-	return (READ_ONCE(p->__state) & match_state);
-}
-#endif
-
-/*
- * wait_task_inactive - wait for a thread to unschedule.
- *
- * Wait for the thread to block in any of the states set in @match_state.
- * If it changes, i.e. @p might have woken up, then return zero.  When we
- * succeed in waiting for @p to be off its CPU, we return a positive number
- * (its total switch count).  If a second call a short while later returns the
- * same number, the caller can be sure that @p has remained unscheduled the
- * whole time.
- *
- * The caller must ensure that the task *will* unschedule sometime soon,
- * else this function might spin for a *long* time. This function can't
- * be called with interrupts off, or it may introduce deadlock with
- * smp_call_function() if an IPI is sent by the same process we are
- * waiting to become inactive.
- */
-unsigned long wait_task_inactive(struct task_struct *p, unsigned int match_state)
-{
-	bool running, wait;
-	struct rq_flags rf;
-	unsigned long ncsw;
-	struct rq *rq;
-
-	for (;;) {
-		/*
-		 * We do the initial early heuristics without holding
-		 * any task-queue locks at all. We'll only try to get
-		 * the runqueue lock when things look like they will
-		 * work out!
-		 */
-		rq = task_rq(p);
-
-		/*
-		 * If the task is actively running on another CPU
-		 * still, just relax and busy-wait without holding
-		 * any locks.
-		 *
-		 * NOTE! Since we don't hold any locks, it's not
-		 * even sure that "rq" stays as the right runqueue!
-		 * But we don't care, since "task_on_cpu()" will
-		 * return false if the runqueue has changed and p
-		 * is actually now running somewhere else!
-		 */
-		while (task_on_cpu(rq, p)) {
-			if (state_mismatch(p, match_state))
-				return 0;
-			cpu_relax();
-		}
-
-		/*
-		 * Ok, time to look more closely! We need the rq
-		 * lock now, to be *sure*. If we're wrong, we'll
-		 * just go back and repeat.
-		 */
-		rq = task_rq_lock(p, &rf);
-		trace_sched_wait_task(p);
-		running = task_on_cpu(rq, p);
-		wait = task_on_rq_queued(p);
-		ncsw = 0;
-
-		if (state_match(p, match_state, &wait))
-			ncsw = p->nvcsw | LONG_MIN; /* sets MSB */
-		task_rq_unlock(rq, p, &rf);
-
-		/*
-		 * If it changed from the expected state, bail out now.
-		 */
-		if (unlikely(!ncsw))
-			break;
-
-		/*
-		 * Was it really running after all now that we
-		 * checked with the proper locks actually held?
-		 *
-		 * Oops. Go back and try again..
-		 */
-		if (unlikely(running)) {
-			cpu_relax();
-			continue;
-		}
-
-		/*
-		 * It's not enough that it's not actively running,
-		 * it must be off the runqueue _entirely_, and not
-		 * preempted!
-		 *
-		 * So if it was still runnable (but just not actively
-		 * running right now), it's preempted, and we should
-		 * yield - it could be a while.
-		 */
-		if (unlikely(wait)) {
-			ktime_t to = NSEC_PER_SEC / HZ;
-
-			set_current_state(TASK_UNINTERRUPTIBLE);
-			schedule_hrtimeout(&to, HRTIMER_MODE_REL_HARD);
-			continue;
-		}
-
-		/*
-		 * Ahh, all good. It wasn't running, and it wasn't
-		 * runnable, which means that it will never become
-		 * running in the future either. We're all done!
-		 */
-		break;
-	}
-
-	return ncsw;
-}
-
 /***
  * kick_process - kick a running thread to enter/exit the kernel
  * @p: the to-be-kicked thread
@@ -4116,15 +4085,14 @@ static void ttwu_queue(struct task_struct *p, int cpu, int wake_flags)
 static __always_inline
 bool ttwu_state_match(struct task_struct *p, unsigned int state, int *success)
 {
+	int match;
+
 	if (IS_ENABLED(CONFIG_DEBUG_PREEMPT)) {
 		WARN_ON_ONCE((state & TASK_RTLOCK_WAIT) &&
 			     state != TASK_RTLOCK_WAIT);
 	}
 
-	if (READ_ONCE(p->__state) & state) {
-		*success = 1;
-		return true;
-	}
+	*success = !!(match = __task_state_match(p, state));
 
 #ifdef CONFIG_PREEMPT_RT
 	/*
@@ -4140,12 +4108,10 @@ bool ttwu_state_match(struct task_struct *p, unsigned int state, int *success)
 	 * p::saved_state to TASK_RUNNING so any further tests will
 	 * not result in false positives vs. @success
 	 */
-	if (p->saved_state & state) {
+	if (match < 0)
 		p->saved_state = TASK_RUNNING;
-		*success = 1;
-	}
 #endif
-	return false;
+	return match > 0;
 }
 
 /*
diff --git a/kernel/signal.c b/kernel/signal.c
index 5ba6cb05ff4f5..9e07b3075c72e 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -432,18 +432,7 @@ __sigqueue_alloc(int sig, struct task_struct *t, gfp_t gfp_flags,
 		return NULL;
 
 	if (override_rlimit || likely(sigpending <= task_rlimit(t, RLIMIT_SIGPENDING))) {
-
-		if (!sigqueue_flags) {
-			struct sighand_struct *sighand = t->sighand;
-
-			lockdep_assert_held(&sighand->siglock);
-			if (sighand->sigqueue_cache) {
-				q = sighand->sigqueue_cache;
-				sighand->sigqueue_cache = NULL;
-			}
-		}
-		if (!q)
-			q = kmem_cache_alloc(sigqueue_cachep, gfp_flags);
+		q = kmem_cache_alloc(sigqueue_cachep, gfp_flags);
 	} else {
 		print_dropped_signal(sig);
 	}
@@ -458,43 +447,14 @@ __sigqueue_alloc(int sig, struct task_struct *t, gfp_t gfp_flags,
 	return q;
 }
 
-static bool sigqueue_cleanup_accounting(struct sigqueue *q)
+static void __sigqueue_free(struct sigqueue *q)
 {
 	if (q->flags & SIGQUEUE_PREALLOC)
-		return false;
+		return;
 	if (q->ucounts) {
 		dec_rlimit_put_ucounts(q->ucounts, UCOUNT_RLIMIT_SIGPENDING);
 		q->ucounts = NULL;
 	}
-	return true;
-}
-
-static void __sigqueue_free(struct sigqueue *q)
-{
-	if (!sigqueue_cleanup_accounting(q))
-		return;
-	kmem_cache_free(sigqueue_cachep, q);
-}
-
-void sigqueue_free_cached_entry(struct sigqueue *q)
-{
-	if (!q)
-		return;
-	kmem_cache_free(sigqueue_cachep, q);
-}
-
-static void sigqueue_cache_or_free(struct sigqueue *q)
-{
-	struct sighand_struct *sighand = current->sighand;
-
-	if (!sigqueue_cleanup_accounting(q))
-		return;
-
-	lockdep_assert_held(&sighand->siglock);
-	if (!sighand->sigqueue_cache) {
-		sighand->sigqueue_cache = q;
-		return;
-	}
 	kmem_cache_free(sigqueue_cachep, q);
 }
 
@@ -634,7 +594,7 @@ static void collect_signal(int sig, struct sigpending *list, kernel_siginfo_t *i
 			(info->si_code == SI_TIMER) &&
 			(info->si_sys_private);
 
-		sigqueue_cache_or_free(first);
+		__sigqueue_free(first);
 	} else {
 		/*
 		 * Ok, it wasn't in the queue.  This must be
diff --git a/localversion-rt b/localversion-rt
index 1445cd65885cd..ad3da1bcab7e8 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt3
+-rt4
