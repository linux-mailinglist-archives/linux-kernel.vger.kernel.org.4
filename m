Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFD470EF00
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 09:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239936AbjEXHHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 03:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239789AbjEXHHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 03:07:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BEB1A1
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 00:07:03 -0700 (PDT)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684912022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2kwO+AnJDXfsw1irBqTyNknQ35rVxg5VAbQ15cO4kOI=;
        b=AVaNYd3l+yqlQll5hEmAqXTChU3DSe5VnRJy78E/eVFCXdWsnTCqc9yE7m7a8euAvEo1xv
        B143ELVeTjUa+fLv3RoDY8zbtJV7BqRLEbIPO4+Zc0aBK7catKus46p8/P7x5OWa9ktCXy
        Ph3B/M9uvGF2TV5wkvbNn7rX5uWBWzl2ZedGBDX1qDGlcm0GqftiG5SSLq9nZ4aQJ12c39
        UIt4XLYHd6no2ZX52qj7nwAYf76yqNhk8dkBKecZFPlog31cP8llQlLBmvsjyIYkYqoM1a
        eT41JlIo23WyITjLOc8fM6iIHxee9TG8KLkKNnGglnEo7e10qalNzP1veTG8Vg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684912022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2kwO+AnJDXfsw1irBqTyNknQ35rVxg5VAbQ15cO4kOI=;
        b=Nj9tYes1l3ulYLYWuwfvbbrojEdkhLDKRYnW6c0JufPf/1w+xn/KG4radWI9aGfYqOuvFW
        L775AW06NLyWNnDA==
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
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Richard Cochran <richardcochran@gmail.com>
Subject: [PATCH v7 12/21] timer: Keep the pinned timers separate from the others
Date:   Wed, 24 May 2023 09:06:20 +0200
Message-Id: <20230524070629.6377-13-anna-maria@linutronix.de>
In-Reply-To: <20230524070629.6377-1-anna-maria@linutronix.de>
References: <20230524070629.6377-1-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Separate the storage space for pinned timers. Deferrable timers (doesn't
matter if pinned or non pinned) are still enqueued into their own base.

This is preparatory work for changing the NOHZ timer placement from a push
at enqueue time to a pull at expiry time model.

Originally-by: Richard Cochran (linutronix GmbH) <richardcochran@gmail.com>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
v6:
  - Drop set TIMER_PINNED flag in add_timer_on() and drop related
    warning. add_timer_on() fix is splitted into a separate
    patch. Therefore also drop "Reviewed-by" of Frederic Weisbecker

v5:
  - Add WARN_ONCE() in add_timer_on()
  - Decrease patch size by splitting into three patches (this patch and the
    two before)

v4:
  - split out logic to forward base clock into a helper function
    forward_base_clk() (Frederic)
  - ease the code in run_local_timers() and timer_clear_idle() (Frederic)
---
 kernel/time/timer.c | 85 +++++++++++++++++++++++++++++++++------------
 1 file changed, 62 insertions(+), 23 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index fcff03757641..010c8877fa85 100644
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
 
@@ -899,7 +905,10 @@ static int detach_if_pending(struct timer_list *timer, struct timer_base *base,
 
 static inline struct timer_base *get_timer_cpu_base(u32 tflags, u32 cpu)
 {
-	struct timer_base *base = per_cpu_ptr(&timer_bases[BASE_STD], cpu);
+	int index = tflags & TIMER_PINNED ? BASE_LOCAL : BASE_GLOBAL;
+	struct timer_base *base;
+
+	base = per_cpu_ptr(&timer_bases[index], cpu);
 
 	/*
 	 * If the timer is deferrable and NO_HZ_COMMON is set then we need
@@ -912,7 +921,10 @@ static inline struct timer_base *get_timer_cpu_base(u32 tflags, u32 cpu)
 
 static inline struct timer_base *get_timer_this_cpu_base(u32 tflags)
 {
-	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
+	int index = tflags & TIMER_PINNED ? BASE_LOCAL : BASE_GLOBAL;
+	struct timer_base *base;
+
+	base = this_cpu_ptr(&timer_bases[index]);
 
 	/*
 	 * If the timer is deferrable and NO_HZ_COMMON is set then we need
@@ -1985,9 +1997,10 @@ static void forward_base_clk(struct timer_base *base, unsigned long nextevt,
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
@@ -1996,32 +2009,57 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
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
+
+	/*
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
 
 	/*
-	 * Base is idle if the next event is more than a tick away. Also
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
@@ -2033,15 +2071,14 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
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
 
@@ -2087,11 +2124,13 @@ static inline void __run_timers(struct timer_base *base)
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
@@ -2099,7 +2138,7 @@ static __latent_entropy void run_timer_softirq(struct softirq_action *h)
  */
 static void run_local_timers(void)
 {
-	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
+	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_LOCAL]);
 
 	hrtimer_run_queues();
 
-- 
2.30.2

