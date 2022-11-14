Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9058628441
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 16:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237149AbiKNPma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 10:42:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235551AbiKNPm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 10:42:27 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6FB8220C9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 07:42:25 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668440543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=unZ79EI04FPyCTLjELDFXpRWHGSycC4SqJMn0XyHZ04=;
        b=iD7mQSmtlAR3TZF6lyBExCH6jAShTWF7pooTQK2TFDghY7+YU8uAtQ5Vl+TIMV6A9tFibY
        cvUGOlmbaN/TYIfy/ShzxA2mILerYwhw4q/Rg8MoKnTcOgbNTL6HntamGUe4BnNJeWvrOV
        4CxxClZhZ7ia4NYWS8yTEfDM4NVfnY4dElsUkdilsIcswxCy9DFRw0A8g82BKPdFpv//c2
        487WUABC5F9HX4TP7FBJX5K/Fup3DyEZIdOE3iDMO8G+uObRLXcoJj8lnxhYZuGjEEaNYi
        AOH9XRnXPFrMUEZyxOSZ29IFEFdgw4gyZIT0sSrQfz1jDqKQdNTDYQbhg57DFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668440543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=unZ79EI04FPyCTLjELDFXpRWHGSycC4SqJMn0XyHZ04=;
        b=cUhmi2zWYV/B6zoBrQlAJWmryZg/+0VimnSUcT5I/H/Qv2mVtuIFvB71x3v1rXbPcSLgRz
        kxjOn81sEFNc2DAg==
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        Eric Dumazet <edumazet@google.com>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v6 4/6] timers: Add timer_shutdown_sync() to be called
 before freeing timers
In-Reply-To: <87sfims7ca.ffs@tglx>
References: <20221110064101.429013735@goodmis.org>
 <20221110064147.343514404@goodmis.org> <875yfitpdu.ffs@tglx>
 <20221113191518.0a3b29b1@rorschach.local.home> <87sfims7ca.ffs@tglx>
Date:   Mon, 14 Nov 2022 16:42:22 +0100
Message-ID: <87iljhsftt.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14 2022 at 01:33, Thomas Gleixner wrote:
>    https://lore.kernel.org/all/87v8vjiaih.ffs@tglx/

I went back to the original thread and looked at the Bluetooth example
and then at commit 72ef98445aca ("Bluetooth: hci_qca: Use del_timer_sync()
before freeing"). That commit fixes the obvious problem of using
del_timer() instead of del_timer_sync(). Also the reordering of the
timer teardown vs. the workqueue teardown makes it less likely to
explode, but it's still fundamentally broken.

destroy_workqueue(wq);
/* After this point @wq cannot be touched anymore */

---> timer expires
       queue_work(wq) <---- Explodes with a NULl pointer dereference
                            deep in the work queue core code.
del_timer_sync(t);

As I said in the above mail:

 "So well written drivers have a priv->shutdown flag which makes timer
  callbacks and workqueue functions aware that a shutdown is in progress
  so they can take appropriate action."

That's exactly the point why I was not convinced that any form of
timer_shutdown_sync() will solve these kind of problem. It might just
lure people into the false expectation that all teardown ordering
problems go magically away when this function is used.

The above commit is just a proof.

timer_shutdown_sync() can solve the problem in that driver, but you
_cannot_ issue a warning if any of the enqueue functions is invoked with
timer->function == NULL. Why?

The ordering in that driver would have to go back to the original
ordering to prevent the above problem.

  timer_shutdown_sync(t);

Now t->function == NULL, right?

  destroy_workqueue(wq)
    drain_workqueue(wq)
      bt_work()
        mod_timer(t);   <- would warn because t->function == NULL

So if we want to make this solid and make the life of driver writers
easier, then we cannot issue a warning as I said in the original thread
already.

The semantics of timer_shutdown_sync() have to be:

   After return:
     - the timer is not queued
     - the timer callbacks is not running
     - the timer cannot be enqueued again

For that BT case this is the right thing to do because the draining of
the pending work via destroy_workqueue() must not rearm the timers.
There is no functional requirement to do so because the device is
on the way out already.

It won't solve all of those problems but probably quite some of
them. Needs a careful look at each usage site.

So something like the below should do the trick. It's compiled this time
and I spent more than 5 seconds to stare at it. Still needs some
eyeballs and splitting apart into more digestable pieces.

The only downside of this is that timers which are not properly
initialized are now silently ignored. That's not a real problem as
driver writers should run their code with debugobjects enabled at least
once, which will tell them nicely. So if someone has to scratch his head
why his timer is not firing, then it's well deserved.

Thanks,

        tglx
---
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -183,12 +183,47 @@ extern int timer_reduce(struct timer_lis
 extern void add_timer(struct timer_list *timer);
 
 extern int try_to_del_timer_sync(struct timer_list *timer);
+extern int timer_delete_sync(struct timer_list *timer, bool shutdown);
 
-#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT)
-  extern int del_timer_sync(struct timer_list *timer);
-#else
-# define del_timer_sync(t)		del_timer(t)
-#endif
+/**
+ * del_timer_sync - Delete a pending timer and wait for a running callback
+ * @timer: The timer to be deleted
+ *
+ * The function ensures under timer_base(@timer)->lock that:
+ *   - @timer is not queued
+ *   - The callback function of @timer is not running
+ *
+ * But this function cannot guarantee that the timer is not rearmed again
+ * by some concurrent or preempting code, right after it dropped the base
+ * lock.
+ *
+ * If this guarantee is needed, e.g. for teardown, then use
+ * timer_shutdown_sync() instead.
+ *
+ * Returns:	%0 if the timer was not pending
+ *		%1 if the timer was pending
+ */
+static inline int del_timer_sync(struct timer_list *timer)
+{
+	return timer_delete_sync(timer, false);
+}
+
+/**
+ * timer_shutdown_sync - Shutdown a timer and prevent rearming
+ * @timer: The timer to be shutdown
+ *
+ * When the function returns it is guaranteed that:
+ *   - @timer is not queued
+ *   - The callback function of @timer is not running
+ *   - @timer cannot be enqueued again
+ *
+ * Returns:	%0 if the timer was not pending
+ *		%1 if the timer was pending
+ */
+static inline int timer_shutdown_sync(struct timer_list *timer)
+{
+	return timer_delete_sync(timer, true);
+}
 
 #define del_singleshot_timer_sync(t) del_timer_sync(t)
 
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1017,8 +1017,6 @@ static inline int
 	unsigned int idx = UINT_MAX;
 	int ret = 0;
 
-	BUG_ON(!timer->function);
-
 	/*
 	 * This is a common optimization triggered by the networking code - if
 	 * the timer is re-modified to have the same timeout or ends up in the
@@ -1044,6 +1042,15 @@ static inline int
 		 * dequeue/enqueue dance.
 		 */
 		base = lock_timer_base(timer, &flags);
+		/*
+		 * Has @timer been shutdown? This needs to be evaluated
+		 * while holding base lock to prevent a race against the
+		 * shutdown code.
+		 */
+		if (!timer->function) {
+			ret = 0;
+			goto out_unlock;
+		}
 		forward_timer_base(base);
 
 		if (timer_pending(timer) && (options & MOD_TIMER_REDUCE) &&
@@ -1070,6 +1077,15 @@ static inline int
 		}
 	} else {
 		base = lock_timer_base(timer, &flags);
+		/*
+		 * Has @timer been shutdown? This needs to be evaluated
+		 * while holding base lock to prevent a race against the
+		 * shutdown code.
+		 */
+		if (!timer->function) {
+			ret = 0;
+			goto out_unlock;
+		}
 		forward_timer_base(base);
 	}
 
@@ -1193,7 +1209,8 @@ EXPORT_SYMBOL(timer_reduce);
  */
 void add_timer(struct timer_list *timer)
 {
-	BUG_ON(timer_pending(timer));
+	if (WARN_ON_ONCE(timer_pending(timer)))
+		return;
 	__mod_timer(timer, timer->expires, MOD_TIMER_NOTPENDING);
 }
 EXPORT_SYMBOL(add_timer);
@@ -1210,7 +1227,8 @@ void add_timer_on(struct timer_list *tim
 	struct timer_base *new_base, *base;
 	unsigned long flags;
 
-	BUG_ON(timer_pending(timer) || !timer->function);
+	if (WARN_ON_ONCE(timer_pending(timer)))
+		return;
 
 	new_base = get_timer_cpu_base(timer->flags, cpu);
 
@@ -1220,6 +1238,13 @@ void add_timer_on(struct timer_list *tim
 	 * wrong base locked.  See lock_timer_base().
 	 */
 	base = lock_timer_base(timer, &flags);
+	/*
+	 * Has @timer been shutdown? This needs to be evaluated while
+	 * holding base lock to prevent a race against the shutdown code.
+	 */
+	if (!timer->function)
+		goto out_unlock;
+
 	if (base != new_base) {
 		timer->flags |= TIMER_MIGRATING;
 
@@ -1233,20 +1258,22 @@ void add_timer_on(struct timer_list *tim
 
 	debug_timer_activate(timer);
 	internal_add_timer(base, timer);
+out_unlock:
 	raw_spin_unlock_irqrestore(&base->lock, flags);
 }
 EXPORT_SYMBOL_GPL(add_timer_on);
 
 /**
- * del_timer - deactivate a timer.
- * @timer: the timer to be deactivated
+ * del_timer - Deactivate a timer.
+ * @timer:	The timer to be deactivated
  *
- * del_timer() deactivates a timer - this works on both active and inactive
- * timers.
+ * Returns:	%0	If the timer was not pending
+ *		%1	If the timer was pending and deactivated
  *
- * The function returns whether it has deactivated a pending timer or not.
- * (ie. del_timer() of an inactive timer returns 0, del_timer() of an
- * active timer returns 1.)
+ * Note, the function does not wait for an eventually running timer
+ * callback on a different CPU and it neither prevents rearming of
+ * the timer. See del_timer_sync() and timer_shutdown_sync() for
+ * alternative options.
  */
 int del_timer(struct timer_list *timer)
 {
@@ -1267,13 +1294,24 @@ int del_timer(struct timer_list *timer)
 EXPORT_SYMBOL(del_timer);
 
 /**
- * try_to_del_timer_sync - Try to deactivate a timer
- * @timer: timer to delete
+ * __try_to_del_timer_sync - Internal function: Try to deactivate a timer
+ * @timer:	Timer to deactivate
+ * @shutdown:	If true this indicates that the timer is about to be
+ *		shutdown permanently.
+ *
+ * This function tries to deactivate @timer.
+ *
+ * If @shutdown is true then @timer->function is set to NULL under the
+ * timer base lock which prevents further rearming of the timer.
+ *
+ * Returns:	%0	If the timer was not pending
+ *		%1	If the timer was pending and deactivated
+ *		%-1	If the timer callback is running on a different CPU
  *
- * This function tries to deactivate a timer. Upon successful (ret >= 0)
- * exit the timer is not queued and the handler is not running on any CPU.
+ * Note: This function cannot guarantee that the timer cannot be rearmed
+ *	 after dropping the base lock unless @shutdown is true.
  */
-int try_to_del_timer_sync(struct timer_list *timer)
+static int __try_to_del_timer_sync(struct timer_list *timer, bool free)
 {
 	struct timer_base *base;
 	unsigned long flags;
@@ -1285,11 +1323,30 @@ int try_to_del_timer_sync(struct timer_l
 
 	if (base->running_timer != timer)
 		ret = detach_if_pending(timer, base, true);
+	if (free)
+		timer->function = NULL;
 
 	raw_spin_unlock_irqrestore(&base->lock, flags);
 
 	return ret;
 }
+
+/**
+ * try_to_del_timer_sync - Try to deactivate a timer
+ * @timer:	Timer to deactivate
+ *
+ * Returns:	%0	If the timer was not pending
+ *		%1	If the timer was pending and deactivated
+ *		%-1	If the timer callback is running on a different CPU
+ *
+ * Note: This function cannot guarantee that the timer cannot be rearmed
+ *	 right after dropping the base lock. That needs to be prevented
+ *	 by the calling code if necessary.
+ */
+int try_to_del_timer_sync(struct timer_list *timer)
+{
+	return __try_to_del_timer_sync(timer, false);
+}
 EXPORT_SYMBOL(try_to_del_timer_sync);
 
 #ifdef CONFIG_PREEMPT_RT
@@ -1365,16 +1422,13 @@ static inline void timer_sync_wait_runni
 static inline void del_timer_wait_running(struct timer_list *timer) { }
 #endif
 
-#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT)
 /**
- * del_timer_sync - deactivate a timer and wait for the handler to finish.
- * @timer: the timer to be deactivated
+ * timer_delete_sync - Deactivate a timer and wait for the handler to finish.
+ * @timer:	The timer to be deactivated
+ * @shutdown:	If true @timer->function will be set to NULL under the
+ *		timer base lock which prevents rearming of @timer
  *
- * This function only differs from del_timer() on SMP: besides deactivating
- * the timer it also makes sure the handler has finished executing on other
- * CPUs.
- *
- * Synchronization rules: Callers must prevent restarting of the timer,
+ * SMP synchronization rules: Callers must prevent restarting of the timer,
  * otherwise this function is meaningless. It must not be called from
  * interrupt contexts unless the timer is an irqsafe one. The caller must
  * not hold locks which would prevent completion of the timer's
@@ -1400,9 +1454,15 @@ static inline void del_timer_wait_runnin
  * The interrupt on the other CPU is waiting to grab somelock but
  * it has interrupted the softirq that CPU0 is waiting to finish.
  *
- * The function returns whether it has deactivated a pending timer or not.
+ * If @shutdown is not set the timer can be rearmed later. If it is set
+ * then @timer->function is set to NULL under timer base lock which
+ * prevents rearming of the timer. If the timer should be reused after
+ * shutdown it has to be initialized again.
+ *
+ * Returns:	%0	If the timer was not pending
+ *		%1	If the timer was pending and deactivated
  */
-int del_timer_sync(struct timer_list *timer)
+int timer_delete_sync(struct timer_list *timer, bool shutdown)
 {
 	int ret;
 
@@ -1432,7 +1492,7 @@ int del_timer_sync(struct timer_list *ti
 		lockdep_assert_preemption_enabled();
 
 	do {
-		ret = try_to_del_timer_sync(timer);
+		ret = __try_to_del_timer_sync(timer, shutdown);
 
 		if (unlikely(ret < 0)) {
 			del_timer_wait_running(timer);
@@ -1442,8 +1502,7 @@ int del_timer_sync(struct timer_list *ti
 
 	return ret;
 }
-EXPORT_SYMBOL(del_timer_sync);
-#endif
+EXPORT_SYMBOL(timer_delete_sync);
 
 static void call_timer_fn(struct timer_list *timer,
 			  void (*fn)(struct timer_list *),
@@ -1509,6 +1568,12 @@ static void expire_timers(struct timer_b
 
 		fn = timer->function;
 
+		if (WARN_ON_ONCE(!fn)) {
+			/* Should never happen. Emphasis on should! */
+			base->running_timer = NULL;
+			return;
+		}
+
 		if (timer->flags & TIMER_IRQSAFE) {
 			raw_spin_unlock(&base->lock);
 			call_timer_fn(timer, fn, baseclk);

