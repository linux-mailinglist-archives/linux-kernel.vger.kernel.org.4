Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6799F6F0B32
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 19:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244547AbjD0RnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 13:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244438AbjD0RnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 13:43:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E262E50;
        Thu, 27 Apr 2023 10:42:37 -0700 (PDT)
Date:   Thu, 27 Apr 2023 19:42:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682617354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=7oNjQ7UEQCbzh/JU1XlAhxSkic1e0vzjEKDP3mGtVQM=;
        b=Z9h0xHkEKkVZRTLq0KH36Ta7C/3d+wmNDZ7dvaBX4uU88spLUw1GC5pFXvndopt2KhUxXa
        +qmJ3HHnIIqufP0OlViZQN6EsESmxHw3omIYVLmzoFTw2UrmP+1vaacGeu98TrT6X1MgQk
        KR8EXfLbus6Kf1sN/kuG4tI3i9UjEFV41iYvXErEHQKOAaTsd+ZJdc3rk4djW0r4ZEPdP6
        LLg83iuw2G9bGzUdcw5t/kPy1mhTpZhrZLxcZaVgoWqS/0xCqM/rZ39IUnJMgmk6MEbIJt
        qbxDX4XhCKG7z7P/DT+t2HSqp77sJAMEI1MT5rXkCGNHegEWtckPVQHfWOHlRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682617354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=7oNjQ7UEQCbzh/JU1XlAhxSkic1e0vzjEKDP3mGtVQM=;
        b=aBGtiYMFnxVmuv9CzuuKu4XPkmt3gyDx7PbwD7o357Zislv9FcvBlTtXA+Yzzxq/5EMTvY
        bTgbu1A54rRBGyAg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v6.3-rt11
Message-ID: <20230427174233.JX6nXwfN@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v6.3-rt11 patch set. 

Changes since v6.3-rt10:

  - The locking patches for flushed queued I/O on lock contention have
    been updated and reposted.

  - The TPM patch was slightly altered based on upstream's feedback.

  - The periodic tick timer has been aligned CLOCK_MONOTONIC. It has
    been broken since v4.19-rc1. This is needed for instance for
    cyclictest's --secaligned argument to work properly. Reported by
    Klaus Gusenleitner.

  - The tracing decoding for hrtimer events is now able to also decode
    the HRTIMER_MODE_.*_HARD modes.

Known issues
     None

The delta patch against v6.3-rt10 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.3/incr/patch-6.3-rt10-rt11.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.3-rt11

The RT patch against v6.3 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.3/older/patch-6.3-rt11.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.3/older/patches-6.3-rt11.tar.xz

Sebastian

diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
index 513e0d1c349a6..450d7985ff346 100644
--- a/drivers/char/tpm/tpm_tis.c
+++ b/drivers/char/tpm/tpm_tis.c
@@ -52,8 +52,8 @@ static inline struct tpm_tis_tcg_phy *to_tpm_tis_tcg_phy(struct tpm_tis_data *da
 
 #ifdef CONFIG_PREEMPT_RT
 /*
- * Flushes previous write operations to chip so that a subsequent
- * ioread*()s won't stall a CPU.
+ * Flush previous write operations with a dummy read operation to the
+ * TPM MMIO base address.
  */
 static inline void tpm_tis_flush(void __iomem *iobase)
 {
@@ -63,12 +63,26 @@ static inline void tpm_tis_flush(void __iomem *iobase)
 #define tpm_tis_flush(iobase) do { } while (0)
 #endif
 
+/*
+ * Write a byte word to the TPM MMIO address, and flush the write queue.
+ * The flush ensures that the data is sent immediately over the bus and not
+ * aggregated with further requests and transferred later in a batch. The large
+ * write requests can lead to unwanted latency spikes by blocking the CPU until
+ * the complete batch has been transferred.
+ */
 static inline void tpm_tis_iowrite8(u8 b, void __iomem *iobase, u32 addr)
 {
 	iowrite8(b, iobase + addr);
 	tpm_tis_flush(iobase);
 }
 
+/*
+ * Write a 32-bit word to the TPM MMIO address, and flush the write queue.
+ * The flush ensures that the data is sent immediately over the bus and not
+ * aggregated with further requests and transferred later in a batch. The large
+ * write requests can lead to unwanted latency spikes by blocking the CPU until
+ * the complete batch has been transferred.
+ */
 static inline void tpm_tis_iowrite32(u32 b, void __iomem *iobase, u32 addr)
 {
 	iowrite32(b, iobase + addr);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index ab43d2b59aedc..593d7e7c2e4c7 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -303,6 +303,11 @@ extern long schedule_timeout_idle(long timeout);
 asmlinkage void schedule(void);
 extern void schedule_preempt_disabled(void);
 asmlinkage void preempt_schedule_irq(void);
+
+extern void sched_submit_work(void);
+extern void sched_resume_work(void);
+extern void schedule_rtmutex(void);
+
 #ifdef CONFIG_PREEMPT_RT
  extern void schedule_rtlock(void);
 #endif
diff --git a/include/trace/events/timer.h b/include/trace/events/timer.h
index 2e713a7d9aa3a..5d43751a766c6 100644
--- a/include/trace/events/timer.h
+++ b/include/trace/events/timer.h
@@ -158,7 +158,11 @@ DEFINE_EVENT(timer_class, timer_cancel,
 		{ HRTIMER_MODE_ABS_SOFT,	"ABS|SOFT"	},	\
 		{ HRTIMER_MODE_REL_SOFT,	"REL|SOFT"	},	\
 		{ HRTIMER_MODE_ABS_PINNED_SOFT,	"ABS|PINNED|SOFT" },	\
-		{ HRTIMER_MODE_REL_PINNED_SOFT,	"REL|PINNED|SOFT" })
+		{ HRTIMER_MODE_REL_PINNED_SOFT,	"REL|PINNED|SOFT" },	\
+		{ HRTIMER_MODE_ABS_HARD,	"ABS|HARD" },		\
+		{ HRTIMER_MODE_REL_HARD,	"REL|HARD" },		\
+		{ HRTIMER_MODE_ABS_PINNED_HARD, "ABS|PINNED|HARD" },	\
+		{ HRTIMER_MODE_REL_PINNED_HARD,	"REL|PINNED|HARD" })
 
 /**
  * hrtimer_init - called when the hrtimer is initialized
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 08c599a5089a2..479a9487edcc2 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -23,7 +23,6 @@
 #include <linux/sched/rt.h>
 #include <linux/sched/wake_q.h>
 #include <linux/ww_mutex.h>
-#include <linux/blkdev.h>
 
 #include <trace/events/lock.h>
 
@@ -219,6 +218,11 @@ static __always_inline bool rt_mutex_cmpxchg_acquire(struct rt_mutex_base *lock,
 	return try_cmpxchg_acquire(&lock->owner, &old, new);
 }
 
+static __always_inline bool rt_mutex_try_acquire(struct rt_mutex_base *lock)
+{
+	return rt_mutex_cmpxchg_acquire(lock, NULL, current);
+}
+
 static __always_inline bool rt_mutex_cmpxchg_release(struct rt_mutex_base *lock,
 						     struct task_struct *old,
 						     struct task_struct *new)
@@ -298,6 +302,24 @@ static __always_inline bool rt_mutex_cmpxchg_acquire(struct rt_mutex_base *lock,
 
 }
 
+static int __sched rt_mutex_slowtrylock(struct rt_mutex_base *lock);
+
+static __always_inline bool rt_mutex_try_acquire(struct rt_mutex_base *lock)
+{
+	/*
+	 * With debug enabled rt_mutex_cmpxchg trylock() will always fail,
+	 * which will unconditionally invoke sched_submit/resume_work() in
+	 * the slow path of __rt_mutex_lock() and __ww_rt_mutex_lock() even
+	 * in the non-contended case.
+	 *
+	 * Avoid that by using rt_mutex_slow_trylock() which is covered by
+	 * the debug code and can acquire a non-contended rtmutex. On
+	 * success the callsite avoids the sched_submit/resume_work()
+	 * dance.
+	 */
+	return rt_mutex_slowtrylock(lock);
+}
+
 static __always_inline bool rt_mutex_cmpxchg_release(struct rt_mutex_base *lock,
 						     struct task_struct *old,
 						     struct task_struct *new)
@@ -1556,7 +1578,7 @@ static int __sched rt_mutex_slowlock_block(struct rt_mutex_base *lock,
 		raw_spin_unlock_irq(&lock->wait_lock);
 
 		if (!owner || !rtmutex_spin_on_owner(lock, waiter, owner))
-			schedule();
+			schedule_rtmutex();
 
 		raw_spin_lock_irq(&lock->wait_lock);
 		set_current_state(state);
@@ -1585,7 +1607,7 @@ static void __sched rt_mutex_handle_deadlock(int res, int detect_deadlock,
 	WARN(1, "rtmutex deadlock detected\n");
 	while (1) {
 		set_current_state(TASK_INTERRUPTIBLE);
-		schedule();
+		schedule_rtmutex();
 	}
 }
 
@@ -1680,6 +1702,12 @@ static int __sched rt_mutex_slowlock(struct rt_mutex_base *lock,
 	unsigned long flags;
 	int ret;
 
+	/*
+	 * The task is about to sleep. Invoke sched_submit_work() before
+	 * blocking as that might take locks and corrupt tsk::pi_blocked_on.
+	 */
+	sched_submit_work();
+
 	/*
 	 * Technically we could use raw_spin_[un]lock_irq() here, but this can
 	 * be called in early boot if the cmpxchg() fast path is disabled
@@ -1692,29 +1720,17 @@ static int __sched rt_mutex_slowlock(struct rt_mutex_base *lock,
 	ret = __rt_mutex_slowlock_locked(lock, ww_ctx, state);
 	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 
+	sched_resume_work();
 	return ret;
 }
 
 static __always_inline int __rt_mutex_lock(struct rt_mutex_base *lock,
 					   unsigned int state)
 {
-	/*
-	 * With DEBUG enabled cmpxchg trylock will always fail. Instead of
-	 * invoking blk_flush_plug() try the trylock-slowpath first which will
-	 * succeed if the lock is not contended.
-	 */
-#ifdef CONFIG_DEBUG_RT_MUTEXES
-	if (likely(rt_mutex_slowtrylock(lock)))
+	lockdep_assert(!current->pi_blocked_on);
+
+	if (likely(rt_mutex_try_acquire(lock)))
 		return 0;
-#else
-	if (likely(rt_mutex_cmpxchg_acquire(lock, NULL, current)))
-		return 0;
-#endif
-	/*
-	 * If we are going to sleep and we have plugged IO queued, make sure to
-	 * submit it to avoid deadlocks.
-	 */
-	blk_flush_plug(current->plug, true);
 
 	return rt_mutex_slowlock(lock, NULL, state);
 }
diff --git a/kernel/locking/rwbase_rt.c b/kernel/locking/rwbase_rt.c
index 96042dca2fd97..5be92ca5afabc 100644
--- a/kernel/locking/rwbase_rt.c
+++ b/kernel/locking/rwbase_rt.c
@@ -131,18 +131,23 @@ static int __sched __rwbase_read_lock(struct rwbase_rt *rwb,
 static __always_inline int rwbase_read_lock(struct rwbase_rt *rwb,
 					    unsigned int state)
 {
+	int ret;
+
+	lockdep_assert(!current->pi_blocked_on);
+
 	if (rwbase_read_trylock(rwb))
 		return 0;
 
-	if (state != TASK_RTLOCK_WAIT) {
-		/*
-		 * If we are going to sleep and we have plugged IO queued,
-		 * make sure to submit it to avoid deadlocks.
-		 */
-		blk_flush_plug(current->plug, true);
-	}
-
-	return __rwbase_read_lock(rwb, state);
+	/*
+	 * The task is about to sleep. For rwsems this submits work as that
+	 * might take locks and corrupt tsk::pi_blocked_on. Must be
+	 * explicit here because __rwbase_read_lock() cannot invoke
+	 * rt_mutex_slowlock(). NOP for rwlocks.
+	 */
+	rwbase_sched_submit_work();
+	ret = __rwbase_read_lock(rwb, state);
+	rwbase_sched_resume_work();
+	return ret;
 }
 
 static void __sched __rwbase_read_unlock(struct rwbase_rt *rwb,
@@ -238,7 +243,10 @@ static int __sched rwbase_write_lock(struct rwbase_rt *rwb,
 	struct rt_mutex_base *rtm = &rwb->rtmutex;
 	unsigned long flags;
 
-	/* Take the rtmutex as a first step */
+	/*
+	 * Take the rtmutex as a first step. For rwsem this will also
+	 * invoke sched_submit_work() to flush IO and workers.
+	 */
 	if (rwbase_rtmutex_lock_state(rtm, state))
 		return -EINTR;
 
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index acb5a50309a18..aca266006ad47 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -1415,6 +1415,12 @@ static inline void __downgrade_write(struct rw_semaphore *sem)
 #define rwbase_rtmutex_lock_state(rtm, state)		\
 	__rt_mutex_lock(rtm, state)
 
+#define rwbase_sched_submit_work()			\
+	sched_submit_work()
+
+#define rwbase_sched_resume_work()			\
+	sched_resume_work()
+
 #define rwbase_rtmutex_slowlock_locked(rtm, state)	\
 	__rt_mutex_slowlock_locked(rtm, NULL, state)
 
diff --git a/kernel/locking/spinlock_rt.c b/kernel/locking/spinlock_rt.c
index 48a19ed8486d8..9fe282cd145d9 100644
--- a/kernel/locking/spinlock_rt.c
+++ b/kernel/locking/spinlock_rt.c
@@ -37,6 +37,8 @@
 
 static __always_inline void rtlock_lock(struct rt_mutex_base *rtm)
 {
+	lockdep_assert(!current->pi_blocked_on);
+
 	if (unlikely(!rt_mutex_cmpxchg_acquire(rtm, NULL, current)))
 		rtlock_slowlock(rtm);
 }
@@ -159,6 +161,9 @@ rwbase_rtmutex_lock_state(struct rt_mutex_base *rtm, unsigned int state)
 	return 0;
 }
 
+static __always_inline void rwbase_sched_submit_work(void) { }
+static __always_inline void rwbase_sched_resume_work(void) { }
+
 static __always_inline int
 rwbase_rtmutex_slowlock_locked(struct rt_mutex_base *rtm, unsigned int state)
 {
diff --git a/kernel/locking/ww_rt_mutex.c b/kernel/locking/ww_rt_mutex.c
index 472e3622abf09..c7196de838edc 100644
--- a/kernel/locking/ww_rt_mutex.c
+++ b/kernel/locking/ww_rt_mutex.c
@@ -62,16 +62,11 @@ __ww_rt_mutex_lock(struct ww_mutex *lock, struct ww_acquire_ctx *ww_ctx,
 	}
 	mutex_acquire_nest(&rtm->dep_map, 0, 0, nest_lock, ip);
 
-	if (likely(rt_mutex_cmpxchg_acquire(&rtm->rtmutex, NULL, current))) {
+	if (likely(rt_mutex_try_acquire(&rtm->rtmutex))) {
 		if (ww_ctx)
 			ww_mutex_set_context_fastpath(lock, ww_ctx);
 		return 0;
 	}
-	/*
-	 * If we are going to sleep and we have plugged IO queued, make sure to
-	 * submit it to avoid deadlocks.
-	 */
-	blk_flush_plug(current->plug, true);
 
 	ret = rt_mutex_slowlock(&rtm->rtmutex, ww_ctx, state);
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 6c98bb4ae562b..a57a1a3beeba1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6765,14 +6765,11 @@ void __noreturn do_task_dead(void)
 		cpu_relax();
 }
 
-static inline void sched_submit_work(struct task_struct *tsk)
+void sched_submit_work(void)
 {
-	unsigned int task_flags;
+	struct task_struct *tsk = current;
+	unsigned int task_flags = tsk->flags;
 
-	if (task_is_running(tsk))
-		return;
-
-	task_flags = tsk->flags;
 	/*
 	 * If a worker goes to sleep, notify and ask workqueue whether it
 	 * wants to wake up a task to maintain concurrency.
@@ -6798,8 +6795,10 @@ static inline void sched_submit_work(struct task_struct *tsk)
 	blk_flush_plug(tsk->plug, true);
 }
 
-static void sched_update_worker(struct task_struct *tsk)
+void sched_resume_work(void)
 {
+	struct task_struct *tsk = current;
+
 	if (tsk->flags & (PF_WQ_WORKER | PF_IO_WORKER)) {
 		if (tsk->flags & PF_WQ_WORKER)
 			wq_worker_running(tsk);
@@ -6808,20 +6807,29 @@ static void sched_update_worker(struct task_struct *tsk)
 	}
 }
 
-asmlinkage __visible void __sched schedule(void)
+static void schedule_loop(unsigned int sched_mode)
 {
-	struct task_struct *tsk = current;
-
-	sched_submit_work(tsk);
 	do {
 		preempt_disable();
-		__schedule(SM_NONE);
+		__schedule(sched_mode);
 		sched_preempt_enable_no_resched();
 	} while (need_resched());
-	sched_update_worker(tsk);
+}
+
+asmlinkage __visible void __sched schedule(void)
+{
+	if (!task_is_running(current))
+		sched_submit_work();
+	schedule_loop(SM_NONE);
+	sched_resume_work();
 }
 EXPORT_SYMBOL(schedule);
 
+void schedule_rtmutex(void)
+{
+	schedule_loop(SM_NONE);
+}
+
 /*
  * synchronize_rcu_tasks() makes sure that no task is stuck in preempted
  * state (have scheduled out non-voluntarily) by making sure that all
@@ -6881,11 +6889,7 @@ void __sched schedule_preempt_disabled(void)
 #ifdef CONFIG_PREEMPT_RT
 void __sched notrace schedule_rtlock(void)
 {
-	do {
-		preempt_disable();
-		__schedule(SM_RTLOCK_WAIT);
-		sched_preempt_enable_no_resched();
-	} while (need_resched());
+	schedule_loop(SM_RTLOCK_WAIT);
 }
 NOKPROBE_SYMBOL(schedule_rtlock);
 #endif
diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index 46789356f856e..65b8658da829e 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -218,9 +218,19 @@ static void tick_setup_device(struct tick_device *td,
 		 * this cpu:
 		 */
 		if (tick_do_timer_cpu == TICK_DO_TIMER_BOOT) {
+			ktime_t next_p;
+			u32 rem;
+
 			tick_do_timer_cpu = cpu;
 
-			tick_next_period = ktime_get();
+			next_p = ktime_get();
+			div_u64_rem(next_p, TICK_NSEC, &rem);
+			if (rem) {
+				next_p -= rem;
+				next_p += TICK_NSEC;
+			}
+
+			tick_next_period = next_p;
 #ifdef CONFIG_NO_HZ_FULL
 			/*
 			 * The boot CPU may be nohz_full, in which case set
diff --git a/localversion-rt b/localversion-rt
index d79dde624aaac..05c35cb580779 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt10
+-rt11
