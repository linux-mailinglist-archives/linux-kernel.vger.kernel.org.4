Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24FEA6A6E37
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 15:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjCAOS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 09:18:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjCAOSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 09:18:10 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B32233FF
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 06:18:07 -0800 (PST)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1677680286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SQpmpypWODYpg3JqMPzgFH5QjuGBcDA2FILZ1mngw/c=;
        b=oY1g4+IBVsf1u2c/lJ3SYagVSxBqVPGDwACsSDJHe7Vtp+X/qr4cBTF4eri1gkT3uoUJFT
        yG5KdvqTuKNE4GOvG3bjpd25vZkIlb4kJaAyccn8uaS1qEsUl0poEkiU2328C5PMSh7RbA
        602c2ELJU9kMX477F6L9bA5y31Ap9OQkQ0ENRk7ZyMxZr/ZGCmb7fpn/03874Awf0Ez+0F
        U7NNOqAUQGBxvUWRZOV9uveBQ5sU9qPzhP+J9DCiBi6igH/+mqbchEaBNlvs7nnITACv1e
        ipozQf7AMJIY5mXmm1PIQtkjRcObajLoreTCuov2RJs+lVl5C6usUkN161chhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1677680286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SQpmpypWODYpg3JqMPzgFH5QjuGBcDA2FILZ1mngw/c=;
        b=6TaNrjQInrjWjlipC82q9XcIGCh0LI2OGhE6v1x2fQ1wyxhrZ7RyEDzykneh+tEBKJhXXe
        63311D/WuCBqJZCA==
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
        Richard Cochran <richardcochran@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH v5 09/18] timer: Keep the pinned timers separate from the others
Date:   Wed,  1 Mar 2023 15:17:35 +0100
Message-Id: <20230301141744.16063-10-anna-maria@linutronix.de>
In-Reply-To: <20230301141744.16063-1-anna-maria@linutronix.de>
References: <20230301141744.16063-1-anna-maria@linutronix.de>
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

Separate the storage space for pinned timers. Deferrable timers (doesn't
matter if pinned or non pinned) are still enqueued into their own base.

This is preparatory work for changing the NOHZ timer placement from a push
at enqueue time to a pull at expiry time model.

When a timer is added via add_timer_on(), TIMER_PINNED flag is required to
ensure it expires on the specified CPU. Otherwise it will be enqueued in
the global timer base which could be expired by a remote CPU. WARN_ONCE()
is added to prevent misuse.

Beside of that no functional change because all callers of add_timer_on()
already use TIMER_PINNED flag.

Originally-by: Richard Cochran (linutronix GmbH) <richardcochran@gmail.com>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
v5:
  - Add WARN_ONCE() in add_timer_on()
  - Decrease patch size by splitting into three patches (this patch and the
    two before)
---
 kernel/time/timer.c | 91 +++++++++++++++++++++++++++++++++------------
 1 file changed, 68 insertions(+), 23 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 1629ccf24dd0..7656eab1bf20 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -187,12 +187,18 @@ EXPORT_SYMBOL(jiffies_64);
 #define WHEEL_SIZE	(LVL_SIZE * LVL_DEPTH)
 
 #ifdef CONFIG_NO_HZ_COMMON
-# define NR_BASES	2
-# define BASE_STD	0
-# define BASE_DEF	1
+/*
+ * If multiple bases need to be locked, use the base ordering for lock
+ * nesting, i.e. lowest number first.
+ */
+# define NR_BASES	3
+# define BASE_LOCAL	0
+# define BASE_GLOBAL	1
+# define BASE_DEF	2
 #else
 # define NR_BASES	1
-# define BASE_STD	0
+# define BASE_LOCAL	0
+# define BASE_GLOBAL	0
 # define BASE_DEF	0
 #endif
 
@@ -902,7 +908,10 @@ static int detach_if_pending(struct timer_list *timer, struct timer_base *base,
 
 static inline struct timer_base *get_timer_cpu_base(u32 tflags, u32 cpu)
 {
-	struct timer_base *base = per_cpu_ptr(&timer_bases[BASE_STD], cpu);
+	int index = tflags & TIMER_PINNED ? BASE_LOCAL : BASE_GLOBAL;
+	struct timer_base *base;
+
+	base = per_cpu_ptr(&timer_bases[index], cpu);
 
 	/*
 	 * If the timer is deferrable and NO_HZ_COMMON is set then we need
@@ -915,7 +924,10 @@ static inline struct timer_base *get_timer_cpu_base(u32 tflags, u32 cpu)
 
 static inline struct timer_base *get_timer_this_cpu_base(u32 tflags)
 {
-	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
+	int index = tflags & TIMER_PINNED ? BASE_LOCAL : BASE_GLOBAL;
+	struct timer_base *base;
+
+	base = this_cpu_ptr(&timer_bases[index]);
 
 	/*
 	 * If the timer is deferrable and NO_HZ_COMMON is set then we need
@@ -1264,6 +1276,12 @@ void add_timer_on(struct timer_list *timer, int cpu)
 	if (WARN_ON_ONCE(timer_pending(timer)))
 		return;
 
+	WARN_ONCE(!(timer->flags & TIMER_PINNED), "TIMER_PINNED flag for "
+		  "add_timer_on() is missing: timer=%p function=%ps",
+		  timer, timer->function);
+	/* Make sure timer flags have TIMER_PINNED flag set */
+	timer->flags |= TIMER_PINNED;
+
 	new_base = get_timer_cpu_base(timer->flags, cpu);
 
 	/*
@@ -1950,9 +1968,10 @@ static void forward_base_clk(struct timer_base *base, unsigned long nextevt,
  */
 u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
 {
-	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
+	unsigned long nextevt, nextevt_local, nextevt_global;
+	struct timer_base *base_local, *base_global;
+	bool local_first, is_idle;
 	u64 expires = KTIME_MAX;
-	unsigned long nextevt;
 
 	/*
 	 * Pretend that there is no timer pending if the cpu is offline.
@@ -1961,32 +1980,57 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
 	if (cpu_is_offline(smp_processor_id()))
 		return expires;
 
-	raw_spin_lock(&base->lock);
+	base_local = this_cpu_ptr(&timer_bases[BASE_LOCAL]);
+	base_global = this_cpu_ptr(&timer_bases[BASE_GLOBAL]);
 
-	nextevt = next_timer_interrupt(base);
+	raw_spin_lock(&base_local->lock);
+	raw_spin_lock_nested(&base_global->lock, SINGLE_DEPTH_NESTING);
+
+	nextevt_local = next_timer_interrupt(base_local);
+	nextevt_global = next_timer_interrupt(base_global);
 
 	/*
 	 * We have a fresh next event. Check whether we can forward the
 	 * base.
 	 */
-	forward_base_clk(base, nextevt, basej);
+	forward_base_clk(base_local, nextevt_local, basej);
+	forward_base_clk(base_global, nextevt_global, basej);
 
 	/*
-	 * Base is idle if the next event is more than a tick away. Also
+	 * Check whether the local event is expiring before or at the same
+	 * time as the global event.
+	 *
+	 * Note, that nextevt_global and nextevt_local might be based on
+	 * different base->clk values. So it's not guaranteed that
+	 * comparing with empty bases results in a correct local_first.
+	 */
+	if (base_local->timers_pending && base_global->timers_pending)
+		local_first = time_before_eq(nextevt_local, nextevt_global);
+	else
+		local_first = base_local->timers_pending;
+
+	nextevt = local_first ? nextevt_local : nextevt_global;
+
+	/*
+	 * Bases are idle if the next event is more than a tick away. Also
 	 * the tick is stopped so any added timer must forward the base clk
 	 * itself to keep granularity small. This idle logic is only
-	 * maintained for the BASE_STD base, deferrable timers may still
-	 * see large granularity skew (by design).
+	 * maintained for the BASE_LOCAL and BASE_GLOBAL base, deferrable
+	 * timers may still see large granularity skew (by design).
 	 */
-	base->is_idle = time_after(nextevt, basej + 1);
+	is_idle = time_after(nextevt, basej + 1);
+
+	/* We need to mark both bases in sync */
+	base_local->is_idle = base_global->is_idle = is_idle;
 
-	if (base->timers_pending) {
+	if (base_local->timers_pending || base_global->timers_pending) {
 		/* If we missed a tick already, force 0 delta */
 		if (time_before(nextevt, basej))
 			nextevt = basej;
 		expires = basem + (u64)(nextevt - basej) * TICK_NSEC;
 	}
-	raw_spin_unlock(&base->lock);
+	raw_spin_unlock(&base_global->lock);
+	raw_spin_unlock(&base_local->lock);
 
 	return cmp_next_hrtimer_event(basem, expires);
 }
@@ -1998,15 +2042,14 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
  */
 void timer_clear_idle(void)
 {
-	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
-
 	/*
 	 * We do this unlocked. The worst outcome is a remote enqueue sending
 	 * a pointless IPI, but taking the lock would just make the window for
 	 * sending the IPI a few instructions smaller for the cost of taking
 	 * the lock in the exit from idle path.
 	 */
-	base->is_idle = false;
+	__this_cpu_write(timer_bases[BASE_LOCAL].is_idle, false);
+	__this_cpu_write(timer_bases[BASE_GLOBAL].is_idle, false);
 }
 #endif
 
@@ -2052,11 +2095,13 @@ static inline void __run_timers(struct timer_base *base)
  */
 static __latent_entropy void run_timer_softirq(struct softirq_action *h)
 {
-	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
+	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_LOCAL]);
 
 	__run_timers(base);
-	if (IS_ENABLED(CONFIG_NO_HZ_COMMON))
+	if (IS_ENABLED(CONFIG_NO_HZ_COMMON)) {
+		__run_timers(this_cpu_ptr(&timer_bases[BASE_GLOBAL]));
 		__run_timers(this_cpu_ptr(&timer_bases[BASE_DEF]));
+	}
 }
 
 /*
@@ -2064,7 +2109,7 @@ static __latent_entropy void run_timer_softirq(struct softirq_action *h)
  */
 static void run_local_timers(void)
 {
-	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
+	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_LOCAL]);
 
 	hrtimer_run_queues();
 
-- 
2.30.2

