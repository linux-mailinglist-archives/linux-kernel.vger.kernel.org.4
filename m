Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62EB61781F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 08:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbiKCH4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 03:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbiKCH4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 03:56:18 -0400
Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DD7643C;
        Thu,  3 Nov 2022 00:55:53 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 19B6C61E20;
        Thu,  3 Nov 2022 08:55:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1667462151; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=jgiZ76hjZGwQyFp2pMmSV5dvCWpl+uU1tutNnDKJgL8=;
        b=T0qUswBSZskxLY9E/HLspktcWimDaLmaC3Oa/jt1KdwUxJVUQVy9HlzXzSadMMGO6aOyk4
        izUf6+xSFVMyZl+5t9rofs+woAcO+jyKSVIpBcv9TvFxoaX7CMKVSaqfRz0qAsianrrWFU
        b4t0AwEBgGWj4qAg3ps5kqMNnVPIZBXiX7ucwZ2yUj6cHOFFlF83EV+JQfXwW/CcO6ZmYv
        mWAgMvBIVkat+TjGEUAxiYuL1AypFAElZx+b4lxxgnke2WDnT19qiyMwY3z7+ECTu9Z999
        FKSREl5W6Ux1/MGI3c4cCzDmoI9h1hwBrK8K6mStEql1IOHS5seP/meyFabyPw==
From:   Daniel Wagner <wagi@monom.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>
Cc:     Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Wagner <wagi@monom.org>
Subject: [PATCH RT 1/4] timers: Prepare support for PREEMPT_RT
Date:   Thu,  3 Nov 2022 08:55:45 +0100
Message-Id: <20221103075548.6477-2-wagi@monom.org>
In-Reply-To: <20221103075548.6477-1-wagi@monom.org>
References: <20221103075548.6477-1-wagi@monom.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anna-Maria Gleixner <anna-maria@linutronix.de>

v4.19.255-rt114-rc2 stable review patch.
If anyone has any objections, please let me know.

-----------


Upstream commit 030dcdd197d77374879bb5603d091eee7d8aba80

When PREEMPT_RT is enabled, the soft interrupt thread can be preempted.  If
the soft interrupt thread is preempted in the middle of a timer callback,
then calling del_timer_sync() can lead to two issues:

  - If the caller is on a remote CPU then it has to spin wait for the timer
    handler to complete. This can result in unbound priority inversion.

  - If the caller originates from the task which preempted the timer
    handler on the same CPU, then spin waiting for the timer handler to
    complete is never going to end.

To avoid these issues, add a new lock to the timer base which is held
around the execution of the timer callbacks. If del_timer_sync() detects
that the timer callback is currently running, it blocks on the expiry
lock. When the callback is finished, the expiry lock is dropped by the
softirq thread which wakes up the waiter and the system makes progress.

This addresses both the priority inversion and the life lock issues.

This mechanism is not used for timers which are marked IRQSAFE as for those
preemption is disabled accross the callback and therefore this situation
cannot happen. The callbacks for such timers need to be individually
audited for RT compliance.

The same issue can happen in virtual machines when the vCPU which runs a
timer callback is scheduled out. If a second vCPU of the same guest calls
del_timer_sync() it will spin wait for the other vCPU to be scheduled back
in. The expiry lock mechanism would avoid that. It'd be trivial to enable
this when paravirt spinlocks are enabled in a guest, but it's not clear
whether this is an actual problem in the wild, so for now it's an RT only
mechanism.

As the softirq thread can be preempted with PREEMPT_RT=y, the SMP variant
of del_timer_sync() needs to be used on UP as well.

[ tglx: Refactored it for mainline ]

Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20190726185753.832418500@linutronix.de
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Daniel Wagner <wagi@monom.org>
---
 kernel/time/timer.c | 130 ++++++++++++++++++++++++++++++--------------
 1 file changed, 88 insertions(+), 42 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 0a6d60b3e67c..b859ecf6424b 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -198,7 +198,10 @@ EXPORT_SYMBOL(jiffies_64);
 struct timer_base {
 	raw_spinlock_t		lock;
 	struct timer_list	*running_timer;
+#ifdef CONFIG_PREEMPT_RT
 	spinlock_t		expiry_lock;
+	atomic_t		timer_waiters;
+#endif
 	unsigned long		clk;
 	unsigned long		next_expiry;
 	unsigned int		cpu;
@@ -1227,8 +1230,14 @@ int del_timer(struct timer_list *timer)
 }
 EXPORT_SYMBOL(del_timer);
 
-static int __try_to_del_timer_sync(struct timer_list *timer,
-				   struct timer_base **basep)
+/**
+ * try_to_del_timer_sync - Try to deactivate a timer
+ * @timer: timer to delete
+ *
+ * This function tries to deactivate a timer. Upon successful (ret >= 0)
+ * exit the timer is not queued and the handler is not running on any CPU.
+ */
+int try_to_del_timer_sync(struct timer_list *timer)
 {
 	struct timer_base *base;
 	unsigned long flags;
@@ -1236,7 +1245,7 @@ static int __try_to_del_timer_sync(struct timer_list *timer,
 
 	debug_assert_init(timer);
 
-	*basep = base = lock_timer_base(timer, &flags);
+	base = lock_timer_base(timer, &flags);
 
 	if (base->running_timer != timer)
 		ret = detach_if_pending(timer, base, true);
@@ -1245,45 +1254,80 @@ static int __try_to_del_timer_sync(struct timer_list *timer,
 
 	return ret;
 }
+EXPORT_SYMBOL(try_to_del_timer_sync);
 
-/**
- * try_to_del_timer_sync - Try to deactivate a timer
- * @timer: timer to delete
- *
- * This function tries to deactivate a timer. Upon successful (ret >= 0)
- * exit the timer is not queued and the handler is not running on any CPU.
- */
-int try_to_del_timer_sync(struct timer_list *timer)
+#ifdef CONFIG_PREEMPT_RT
+static __init void timer_base_init_expiry_lock(struct timer_base *base)
 {
-	struct timer_base *base;
+	spin_lock_init(&base->expiry_lock);
+}
 
-	return __try_to_del_timer_sync(timer, &base);
+static inline void timer_base_lock_expiry(struct timer_base *base)
+{
+	spin_lock(&base->expiry_lock);
 }
-EXPORT_SYMBOL(try_to_del_timer_sync);
 
-#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT_FULL)
-static int __del_timer_sync(struct timer_list *timer)
+static inline void timer_base_unlock_expiry(struct timer_base *base)
 {
-	struct timer_base *base;
-	int ret;
+	spin_unlock(&base->expiry_lock);
+}
 
-	for (;;) {
-		ret = __try_to_del_timer_sync(timer, &base);
-		if (ret >= 0)
-			return ret;
+/*
+ * The counterpart to del_timer_wait_running().
+ *
+ * If there is a waiter for base->expiry_lock, then it was waiting for the
+ * timer callback to finish. Drop expiry_lock and reaquire it. That allows
+ * the waiter to acquire the lock and make progress.
+ */
+static void timer_sync_wait_running(struct timer_base *base)
+{
+	if (atomic_read(&base->timer_waiters)) {
+		spin_unlock(&base->expiry_lock);
+		spin_lock(&base->expiry_lock);
+	}
+}
 
-		if (READ_ONCE(timer->flags) & TIMER_IRQSAFE)
-			continue;
+/*
+ * This function is called on PREEMPT_RT kernels when the fast path
+ * deletion of a timer failed because the timer callback function was
+ * running.
+ *
+ * This prevents priority inversion, if the softirq thread on a remote CPU
+ * got preempted, and it prevents a life lock when the task which tries to
+ * delete a timer preempted the softirq thread running the timer callback
+ * function.
+ */
+static void del_timer_wait_running(struct timer_list *timer)
+{
+	u32 tf;
+
+	tf = READ_ONCE(timer->flags);
+	if (!(tf & TIMER_MIGRATING)) {
+		struct timer_base *base = get_timer_base(tf);
 
 		/*
-		 * When accessing the lock, timers of base are no longer expired
-		 * and so timer is no longer running.
+		 * Mark the base as contended and grab the expiry lock,
+		 * which is held by the softirq across the timer
+		 * callback. Drop the lock immediately so the softirq can
+		 * expire the next timer. In theory the timer could already
+		 * be running again, but that's more than unlikely and just
+		 * causes another wait loop.
 		 */
-		spin_lock(&base->expiry_lock);
-		spin_unlock(&base->expiry_lock);
+		atomic_inc(&base->timer_waiters);
+		spin_lock_bh(&base->expiry_lock);
+		atomic_dec(&base->timer_waiters);
+		spin_unlock_bh(&base->expiry_lock);
 	}
 }
+#else
+static inline void timer_base_init_expiry_lock(struct timer_base *base) { }
+static inline void timer_base_lock_expiry(struct timer_base *base) { }
+static inline void timer_base_unlock_expiry(struct timer_base *base) { }
+static inline void timer_sync_wait_running(struct timer_base *base) { }
+static inline void del_timer_wait_running(struct timer_list *timer) { }
+#endif
 
+#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT_FULL)
 /**
  * del_timer_sync - deactivate a timer and wait for the handler to finish.
  * @timer: the timer to be deactivated
@@ -1322,6 +1366,8 @@ static int __del_timer_sync(struct timer_list *timer)
  */
 int del_timer_sync(struct timer_list *timer)
 {
+	int ret;
+
 #ifdef CONFIG_LOCKDEP
 	unsigned long flags;
 
@@ -1339,14 +1385,17 @@ int del_timer_sync(struct timer_list *timer)
 	 * could lead to deadlock.
 	 */
 	WARN_ON(in_irq() && !(timer->flags & TIMER_IRQSAFE));
-	/*
-	 * Must be able to sleep on PREEMPT_RT because of the slowpath in
-	 * __del_timer_sync().
-	 */
-	if (IS_ENABLED(CONFIG_PREEMPT_RT) && !(timer->flags & TIMER_IRQSAFE))
-		might_sleep();
 
-	return __del_timer_sync(timer);
+	do {
+		ret = try_to_del_timer_sync(timer);
+
+		if (unlikely(ret < 0)) {
+			del_timer_wait_running(timer);
+			cpu_relax();
+		}
+	} while (ret < 0);
+
+	return ret;
 }
 EXPORT_SYMBOL(del_timer_sync);
 #endif
@@ -1410,15 +1459,12 @@ static void expire_timers(struct timer_base *base, struct hlist_head *head)
 			raw_spin_unlock(&base->lock);
 			call_timer_fn(timer, fn);
 			base->running_timer = NULL;
-			spin_unlock(&base->expiry_lock);
-			spin_lock(&base->expiry_lock);
 			raw_spin_lock(&base->lock);
 		} else {
 			raw_spin_unlock_irq(&base->lock);
 			call_timer_fn(timer, fn);
 			base->running_timer = NULL;
-			spin_unlock(&base->expiry_lock);
-			spin_lock(&base->expiry_lock);
+			timer_sync_wait_running(base);
 			raw_spin_lock_irq(&base->lock);
 		}
 	}
@@ -1715,7 +1761,7 @@ static inline void __run_timers(struct timer_base *base)
 	if (!time_after_eq(jiffies, base->clk))
 		return;
 
-	spin_lock(&base->expiry_lock);
+	timer_base_lock_expiry(base);
 	raw_spin_lock_irq(&base->lock);
 
 	/*
@@ -1743,7 +1789,7 @@ static inline void __run_timers(struct timer_base *base)
 			expire_timers(base, heads + levels);
 	}
 	raw_spin_unlock_irq(&base->lock);
-	spin_unlock(&base->expiry_lock);
+	timer_base_unlock_expiry(base);
 }
 
 /*
@@ -1990,7 +2036,7 @@ static void __init init_timer_cpu(int cpu)
 		base->cpu = cpu;
 		raw_spin_lock_init(&base->lock);
 		base->clk = jiffies;
-		spin_lock_init(&base->expiry_lock);
+		timer_base_init_expiry_lock(base);
 	}
 }
 
-- 
2.38.0

