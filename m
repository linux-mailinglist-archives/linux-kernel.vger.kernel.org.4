Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C534560CE30
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 16:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbiJYOAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 10:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231811AbiJYN7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 09:59:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884D1BDF;
        Tue, 25 Oct 2022 06:59:26 -0700 (PDT)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666706365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o6uqNXLi9fS/j/t+vRTXJBiE22APnO3iPTi53EIarr4=;
        b=IADpQrO9FsdT2Wos+BkvFJ9hjjdCh4J+cOqRGOoYjt3bnRm3xDgwNx89+L80e+paMSqk2S
        SvQHqauzMLFnVh/2rsm27Lv9IQSDZLlIRZILg0M20RvYZcBw4HFGP1VwAmo4y4+wN+OSVg
        LI05beGqz/QfdGGNxfsn7oXrF7hqw2VhHXdEVm9xFjx8P8ZXWiz3bBIbi8z5OoYiXgwA96
        QSCHO0iQJSYE2PiZfinnps6DexqXxPexByDGMjTmaIUwTRQ/+/2PVgm57jMKO8OoIdX9Co
        eP7PeXKJ5eaI8eCmj+CMpqI9HQLsWgbvpbgg4L7Xw2zG6PJH1oVv1HP7+pBTuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666706365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o6uqNXLi9fS/j/t+vRTXJBiE22APnO3iPTi53EIarr4=;
        b=8eofvPNNbQD92dcU/AsphDAJ7l/BqOxnIQ7vR6FpjpkbEt7FENM3a0/xo/Yqp6+oniYnu8
        k7KMGh2fs+K9qjCQ==
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
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH v3 08/17] timer: Rename get_next_timer_interrupt()
Date:   Tue, 25 Oct 2022 15:58:41 +0200
Message-Id: <20221025135850.51044-9-anna-maria@linutronix.de>
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

get_next_timer_interrupt() does more than simply getting the next timer
interrupt. The timer bases are forwarded and also marked as idle when
possible and the next timer interrupt information is required for this.

To get not confused, rename function to a more descriptive name. No
functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/tick-internal.h |  4 ++--
 kernel/time/tick-sched.c    | 16 ++++++++--------
 kernel/time/timer.c         | 10 +++++++---
 3 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
index fcb2d45c2934..6f5f164506d5 100644
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -168,8 +168,8 @@ static inline void timers_update_nohz(void) { }
 
 DECLARE_PER_CPU(struct hrtimer_cpu_base, hrtimer_bases);
 
-extern void get_next_timer_interrupt(unsigned long basej, u64 basem,
-				     struct timer_events *tevt);
+extern void forward_and_idle_timer_bases(unsigned long basej, u64 basem,
+					 struct timer_events *tevt);
 void timer_clear_idle(void);
 
 #define CLOCK_SET_WALL							\
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 78f172d1f3d2..7f7bfe8b498d 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -802,11 +802,11 @@ static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
 	 * Keep the periodic tick, when RCU, architecture or irq_work
 	 * requests it.
 	 * Aside of that check whether the local timer softirq is
-	 * pending. If so its a bad idea to call get_next_timer_interrupt()
-	 * because there is an already expired timer, so it will request
-	 * immediate expiry, which rearms the hardware timer with a
-	 * minimal delta which brings us back to this place
-	 * immediately. Lather, rinse and repeat...
+	 * pending. If so its a bad idea to call
+	 * forward_and_idle_timer_bases() because there is an already
+	 * expired timer, so it will request immeditate expiry, which
+	 * rearms the hardware timer with a minimal delta which brings us
+	 * back to this place immediately. Lather, rinse and repeat...
 	 */
 	if (rcu_needs_cpu() || arch_needs_cpu() ||
 	    irq_work_needs_cpu() || local_timer_softirq_pending()) {
@@ -823,7 +823,7 @@ static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
 		 * disabled this also looks at the next expiring
 		 * hrtimer.
 		 */
-		get_next_timer_interrupt(basejiff, basemono, &tevt);
+		forward_and_idle_timer_bases(basejiff, basemono, &tevt);
 		tevt.local = min_t(u64, tevt.local, tevt.global);
 		ts->next_timer = tevt.local;
 	}
@@ -838,7 +838,7 @@ static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
 	if (delta <= (u64)TICK_NSEC) {
 		/*
 		 * Tell the timer code that the base is not idle, i.e. undo
-		 * the effect of get_next_timer_interrupt():
+		 * the effect of forward_and_idle_timer_bases():
 		 */
 		timer_clear_idle();
 		/*
@@ -1141,7 +1141,7 @@ void tick_nohz_idle_retain_tick(void)
 {
 	tick_nohz_retain_tick(this_cpu_ptr(&tick_cpu_sched));
 	/*
-	 * Undo the effect of get_next_timer_interrupt() called from
+	 * Undo the effect of forward_and_idle_timer_bases() called from
 	 * tick_nohz_next_event().
 	 */
 	timer_clear_idle();
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 069478e65230..1990eb1b2cc9 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1705,7 +1705,7 @@ static unsigned long next_timer_interrupt(struct timer_base *base)
 }
 
 /**
- * get_next_timer_interrupt
+ * forward_and_idle_timer_bases
  * @basej:	base time jiffies
  * @basem:	base time clock monotonic
  * @tevt:	Pointer to the storage for the expiry values
@@ -1713,9 +1713,13 @@ static unsigned long next_timer_interrupt(struct timer_base *base)
  * Stores the next pending local and global timer expiry values in the
  * struct pointed to by @tevt. If a queue is empty the corresponding field
  * is set to KTIME_MAX.
+ *
+ * If required, base->clk is forwarded and base is also marked as
+ * idle. Idle handling of timer bases is allowed only to be done by
+ * CPU itself.
  */
-void get_next_timer_interrupt(unsigned long basej, u64 basem,
-			      struct timer_events *tevt)
+void forward_and_idle_timer_bases(unsigned long basej, u64 basem,
+				  struct timer_events *tevt)
 {
 	unsigned long nextevt, nextevt_local, nextevt_global;
 	struct timer_base *base_local, *base_global;
-- 
2.30.2

