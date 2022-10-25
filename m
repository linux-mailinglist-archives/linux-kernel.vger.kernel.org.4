Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE2E660CE2D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 16:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbiJYN77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 09:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbiJYN7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 09:59:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982972C7;
        Tue, 25 Oct 2022 06:59:25 -0700 (PDT)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666706364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x46JYBFTO1X/bJKO4tug7/7x9UDRQaxrzWXN6ho7ju4=;
        b=BZ9FSMHiqTVkwnPyfP7hBRki0zdIzjsksJ/AdWXQA8VJXkVr4YyI82kSznMZcNPEQBEtdu
        N6Q21sTkpJhpZJxgKK5Hh1nzOZnW2SfuL5qhq1TbN+kAJI1ITuCAS0hIdf8OC0EFy0shHf
        jd6qJ4ySunva5bs64xSNxLMF6bEtY0vx/3hhm3kv6beYkoLQ55avLqdeqozi4EWPdrjQbk
        uElV227jngkbOs6GAWHRe6ToSwFV9QosOCg9foEbRF3FUcGvuGCDUGL055sL6S+m4wC3wR
        yrkBWcrMpjkbTLsZoBKvCl8IiEB1MbK1NPZ8COBioErA9utQyywMV2+A/5sXqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666706364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x46JYBFTO1X/bJKO4tug7/7x9UDRQaxrzWXN6ho7ju4=;
        b=hBj8RzG3hZ+zE1Oay8C9CZq39/On6KUzfUwuERExfFtyF1/Nfm5wm0cmKrfn/xj/4B/mCv
        ZMG1pDtndboAgNCw==
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Eric Dumazet <edumazet@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pm@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rik van Riel <riel@redhat.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Richard Cochran <richardcochran@gmail.com>
Subject: [PATCH v3 06/17] timer: Keep the pinned timers separate from the others
Date:   Tue, 25 Oct 2022 15:58:39 +0200
Message-Id: <20221025135850.51044-7-anna-maria@linutronix.de>
In-Reply-To: <20221025135850.51044-1-anna-maria@linutronix.de>
References: <20221025135850.51044-1-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Seperate the storage space for pinned timers.

This is preparatory work for changing the NOHZ timer placement from a push
at enqueue time to a pull at expiry time model.

No functional change.

Originally-by: Richard Cochran (linutronix GmbH) <richardcochran@gmail.com>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/timer.c | 109 ++++++++++++++++++++++++++++++++------------
 1 file changed, 81 insertions(+), 28 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index cb4194ecca60..b3eea90cb212 100644
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
@@ -1700,9 +1712,10 @@ static unsigned long next_timer_interrupt(struct timer_base *base)
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
@@ -1711,38 +1724,69 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
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
 	 * base. We can only do that when @basej is past base->clk
 	 * otherwise we might rewind base->clk.
 	 */
-	if (time_after(basej, base->clk)) {
-		if (time_after(nextevt, basej))
-			base->clk = basej;
-		else if (time_after(nextevt, base->clk))
-			base->clk = nextevt;
+	if (time_after(basej, base_local->clk)) {
+		if (time_after(nextevt_local, basej))
+			base_local->clk = basej;
+		else if (time_after(nextevt_local, base_local->clk))
+			base_local->clk = nextevt_local;
+	}
+
+	if (time_after(basej, base_global->clk)) {
+		if (time_after(nextevt_global, basej))
+			base_global->clk = basej;
+		else if (time_after(nextevt_global, base_global->clk))
+			base_global->clk = nextevt_global;
 	}
 
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
 		if (time_before_eq(nextevt, basej))
 			nextevt = basej;
 		expires = basem + (u64)(nextevt - basej) * TICK_NSEC;
 	}
-	raw_spin_unlock(&base->lock);
+	raw_spin_unlock(&base_global->lock);
+	raw_spin_unlock(&base_local->lock);
 
 	return cmp_next_hrtimer_event(basem, expires);
 }
@@ -1754,7 +1798,7 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
  */
 void timer_clear_idle(void)
 {
-	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
+	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_LOCAL]);
 
 	/*
 	 * We do this unlocked. The worst outcome is a remote enqueue sending
@@ -1763,6 +1807,9 @@ void timer_clear_idle(void)
 	 * the lock in the exit from idle path.
 	 */
 	base->is_idle = false;
+
+	base = this_cpu_ptr(&timer_bases[BASE_GLOBAL]);
+	base->is_idle = false;
 }
 #endif
 
@@ -1808,11 +1855,13 @@ static inline void __run_timers(struct timer_base *base)
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
@@ -1820,17 +1869,21 @@ static __latent_entropy void run_timer_softirq(struct softirq_action *h)
  */
 static void run_local_timers(void)
 {
-	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
+	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_LOCAL]);
 
 	hrtimer_run_queues();
 	/* Raise the softirq only if required. */
 	if (time_before(jiffies, base->next_expiry)) {
 		if (!IS_ENABLED(CONFIG_NO_HZ_COMMON))
 			return;
-		/* CPU is awake, so check the deferrable base. */
+		/* CPU is awake, so check for the global base. */
 		base++;
-		if (time_before(jiffies, base->next_expiry))
-			return;
+		if (time_before(jiffies, base->next_expiry)) {
+			/* CPU is awake, so check the deferrable base. */
+			base++;
+			if (time_before(jiffies, base->next_expiry))
+				return;
+		}
 	}
 	raise_softirq(TIMER_SOFTIRQ);
 }
-- 
2.30.2

