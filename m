Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56181619AB8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 15:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbiKDO6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 10:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232261AbiKDO6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 10:58:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A972EF48
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 07:57:58 -0700 (PDT)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667573876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q2yemYw0b9XnqUBChrfmowbVg4uqr41YiwOJoEf/0lc=;
        b=2AgDEWlSAz6fhOfklAMqgW0XMnuKTy2ItAGHIZZmaD+jMZY2GU0IH9xWiBJPSMe9dM6XTv
        4PKdVUEa/9RAad2nV7G9D46CqftglC+ghdEiJbwV6RXy/z5g37R191LrMS8SOIcUvY27Ph
        ajReU/RgJKWCc11DUJ5u+AAiUkRF8V7mDDsuNMpXHExhHxMJSmT1u+WXAYO32igvkiEMKD
        AWyHVC0dCgSabXuYfYoo9JPNL793iiprU3F/xhZpk3z9WomVZXylrv3wkc4CQ2bRZFdurJ
        i/k+K/cHGA0RMG2RooeWii1rUIYYEKoBgIIs0jCvOSRZwI7LaqFH98I5ErMR6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667573876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q2yemYw0b9XnqUBChrfmowbVg4uqr41YiwOJoEf/0lc=;
        b=worRQsbG4fafVfswdvOZvJ0ny2Co+XEBy2/Rd0+/I4Iu8NgUWIkYzyWwTTJbMf38v+7Mg/
        YQDEx5nYnzfhimCw==
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rik van Riel <riel@surriel.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Richard Cochran <richardcochran@gmail.com>
Subject: [PATCH v4 07/16] timer: Retrieve next expiry of pinned/non-pinned timers seperately
Date:   Fri,  4 Nov 2022 15:57:28 +0100
Message-Id: <20221104145737.71236-8-anna-maria@linutronix.de>
In-Reply-To: <20221104145737.71236-1-anna-maria@linutronix.de>
References: <20221104145737.71236-1-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the conversion of the NOHZ timer placement to a pull at expiry time
model it's required to have seperate expiry times for the pinned and the
non-pinned (movable) timers. Therefore struct timer_events is introduced.

No functional change

Originally-by: Richard Cochran (linutronix GmbH) <richardcochran@gmail.com>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/tick-internal.h |  8 ++++-
 kernel/time/tick-sched.c    | 20 ++++++++----
 kernel/time/timer.c         | 65 ++++++++++++++++++++++++++++---------
 3 files changed, 70 insertions(+), 23 deletions(-)

diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
index 649f2b48e8f0..fcb2d45c2934 100644
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -8,6 +8,11 @@
 #include "timekeeping.h"
 #include "tick-sched.h"
 
+struct timer_events {
+	u64	local;
+	u64	global;
+};
+
 #ifdef CONFIG_GENERIC_CLOCKEVENTS
 
 # define TICK_DO_TIMER_NONE	-1
@@ -163,7 +168,8 @@ static inline void timers_update_nohz(void) { }
 
 DECLARE_PER_CPU(struct hrtimer_cpu_base, hrtimer_bases);
 
-extern u64 get_next_timer_interrupt(unsigned long basej, u64 basem);
+extern void get_next_timer_interrupt(unsigned long basej, u64 basem,
+				     struct timer_events *tevt);
 void timer_clear_idle(void);
 
 #define CLOCK_SET_WALL							\
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 7ffdc7ba19b4..78f172d1f3d2 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -784,7 +784,8 @@ static inline bool local_timer_softirq_pending(void)
 
 static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
 {
-	u64 basemono, next_tick, delta, expires;
+	struct timer_events tevt = { .local = KTIME_MAX, .global = KTIME_MAX };
+	u64 basemono, delta, expires;
 	unsigned long basejiff;
 	unsigned int seq;
 
@@ -809,7 +810,11 @@ static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
 	 */
 	if (rcu_needs_cpu() || arch_needs_cpu() ||
 	    irq_work_needs_cpu() || local_timer_softirq_pending()) {
-		next_tick = basemono + TICK_NSEC;
+		/*
+		 * If anyone needs the CPU, treat this as a local
+		 * timer expiring in a jiffy.
+		 */
+		tevt.local = basemono + TICK_NSEC;
 	} else {
 		/*
 		 * Get the next pending timer. If high resolution
@@ -818,17 +823,18 @@ static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
 		 * disabled this also looks at the next expiring
 		 * hrtimer.
 		 */
-		next_tick = get_next_timer_interrupt(basejiff, basemono);
-		ts->next_timer = next_tick;
+		get_next_timer_interrupt(basejiff, basemono, &tevt);
+		tevt.local = min_t(u64, tevt.local, tevt.global);
+		ts->next_timer = tevt.local;
 	}
 
 	/*
 	 * If the tick is due in the next period, keep it ticking or
 	 * force prod the timer.
 	 */
-	WARN_ON_ONCE(basemono > next_tick);
+	WARN_ON_ONCE(basemono > tevt.local);
 
-	delta = next_tick - basemono;
+	delta = tevt.local - basemono;
 	if (delta <= (u64)TICK_NSEC) {
 		/*
 		 * Tell the timer code that the base is not idle, i.e. undo
@@ -861,7 +867,7 @@ static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
 	else
 		expires = KTIME_MAX;
 
-	ts->timer_expires = min_t(u64, expires, next_tick);
+	ts->timer_expires = min_t(u64, expires, tevt.local);
 
 out:
 	return ts->timer_expires;
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 0e2abd906916..d272672935da 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1664,7 +1664,7 @@ static void next_expiry_recalc(struct timer_base *base)
  * Check, if the next hrtimer event is before the next timer wheel
  * event:
  */
-static u64 cmp_next_hrtimer_event(u64 basem, u64 expires)
+static void cmp_next_hrtimer_event(u64 basem, struct timer_events *tevt)
 {
 	u64 nextevt = hrtimer_get_next_event();
 
@@ -1672,15 +1672,17 @@ static u64 cmp_next_hrtimer_event(u64 basem, u64 expires)
 	 * If high resolution timers are enabled
 	 * hrtimer_get_next_event() returns KTIME_MAX.
 	 */
-	if (expires <= nextevt)
-		return expires;
+	if (tevt->local <= nextevt)
+		return;
 
 	/*
 	 * If the next timer is already expired, return the tick base
 	 * time so the tick is fired immediately.
 	 */
-	if (nextevt <= basem)
-		return basem;
+	if (nextevt <= basem) {
+		tevt->local = basem;
+		return;
+	}
 
 	/*
 	 * Round up to the next jiffie. High resolution timers are
@@ -1690,7 +1692,7 @@ static u64 cmp_next_hrtimer_event(u64 basem, u64 expires)
 	 *
 	 * Use DIV_ROUND_UP_ULL to prevent gcc calling __divdi3
 	 */
-	return DIV_ROUND_UP_ULL(nextevt, TICK_NSEC) * TICK_NSEC;
+	tevt->local = DIV_ROUND_UP_ULL(nextevt, TICK_NSEC) * TICK_NSEC;
 }
 
 
@@ -1718,26 +1720,31 @@ static void forward_base_clk(struct timer_base *base, unsigned long nextevt,
 }
 
 /**
- * get_next_timer_interrupt - return the time (clock mono) of the next timer
+ * get_next_timer_interrupt
  * @basej:	base time jiffies
  * @basem:	base time clock monotonic
+ * @tevt:	Pointer to the storage for the expiry values
  *
- * Returns the tick aligned clock monotonic time of the next pending
- * timer or KTIME_MAX if no timer is pending.
+ * Stores the next pending local and global timer expiry values in the
+ * struct pointed to by @tevt. If a queue is empty the corresponding field
+ * is set to KTIME_MAX.
  */
-u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
+void get_next_timer_interrupt(unsigned long basej, u64 basem,
+			      struct timer_events *tevt)
 {
 	unsigned long nextevt, nextevt_local, nextevt_global;
 	struct timer_base *base_local, *base_global;
 	bool local_first, is_idle;
-	u64 expires = KTIME_MAX;
+
+	/* Preset local / global events */
+	tevt->local = tevt->global = KTIME_MAX;
 
 	/*
 	 * Pretend that there is no timer pending if the cpu is offline.
 	 * Possible pending timers will be migrated later to an active cpu.
 	 */
 	if (cpu_is_offline(smp_processor_id()))
-		return expires;
+		return;
 
 	base_local = this_cpu_ptr(&timer_bases[BASE_LOCAL]);
 	base_global = this_cpu_ptr(&timer_bases[BASE_GLOBAL]);
@@ -1782,16 +1789,44 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
 	/* We need to mark both bases in sync */
 	base_local->is_idle = base_global->is_idle = is_idle;
 
-	if (base_local->timers_pending || base_global->timers_pending) {
+	/*
+	 * If the bases are not marked idle, i.e one of the events is at
+	 * max. one tick away, then the CPU can't go into a NOHZ idle
+	 * sleep. Use the earlier event of both and store it in the local
+	 * expiry value. The next global event is irrelevant in this case
+	 * and can be left as KTIME_MAX. CPU will wakeup on time.
+	 */
+	if (!is_idle) {
 		/* If we missed a tick already, force 0 delta */
 		if (time_before(nextevt, basej))
 			nextevt = basej;
-		expires = basem + (u64)(nextevt - basej) * TICK_NSEC;
+		tevt->local = basem + (u64)(nextevt - basej) * TICK_NSEC;
+		goto unlock;
 	}
+
+	/*
+	 * If the bases are marked idle, i.e. the next event on both the
+	 * local and the global queue are farther away than a tick,
+	 * evaluate both bases. No need to check whether one of the bases
+	 * has an already expired timer as this is caught by the !is_idle
+	 * condition above.
+	 */
+	if (base_local->timers_pending)
+		tevt->local = basem + (u64)(nextevt_local - basej) * TICK_NSEC;
+
+	/*
+	 * If the local queue expires first, then the global event can be
+	 * ignored. The CPU wakes up before that. If the global queue is
+	 * empty, nothing to do either.
+	 */
+	if (!local_first && base_global->timers_pending)
+		tevt->global = basem + (u64)(nextevt_global - basej) * TICK_NSEC;
+
+unlock:
 	raw_spin_unlock(&base_global->lock);
 	raw_spin_unlock(&base_local->lock);
 
-	return cmp_next_hrtimer_event(basem, expires);
+	cmp_next_hrtimer_event(basem, tevt);
 }
 
 /**
-- 
2.30.2

