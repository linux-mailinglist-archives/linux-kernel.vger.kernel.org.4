Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B7A619AB6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 15:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbiKDO6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 10:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbiKDO6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 10:58:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C8A3123E
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 07:57:58 -0700 (PDT)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667573877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q4/MLAhLTPtV7qoK3GH2WeOlioSjvDorYqg4PRgG1nU=;
        b=ORe+HzPLzL0nYvHtB3lHHqfioy+48qZXQY2id+lpHiXJJhU+BwM4+kWGtv6u+S97KiQJkn
        4BdBCSa4rAwpq9kZBBZVtCTfND7UPMN9UecEEsXegYh1HoJL5ehbs4ZWNFURiF9cCtPfQ6
        NRZ34sYy2FdLYDbH+54TpnWclgCUMdNMNsHxLh1QVL2qkj/hRCz/byInwPAJSg2s3R5TPv
        j6QJ5wBcReSquPG+r/kNzewx/dVJbeEELZ05HnjiX9AjrZtCelaYTg5ZYi7YFhJ+WhAbZq
        jD69f6+9Gp00w8g/lUg1c4AJGcX0EgwvGR1EIpcu+U7sq/T8TQva0hS47eVQvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667573877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q4/MLAhLTPtV7qoK3GH2WeOlioSjvDorYqg4PRgG1nU=;
        b=slqSY2OQGC/wGbjGP+bBoCvIJNORpq3RLGJTsO5feZ/WYf8OifeUvQ1cMWG6hGCNUB75os
        tK4QctkJVcXdotCA==
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
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH v4 09/16] timer: Split out "get next timer interrupt" functionality
Date:   Fri,  4 Nov 2022 15:57:30 +0100
Message-Id: <20221104145737.71236-10-anna-maria@linutronix.de>
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

forward_and_idle_timer_bases() includes the functionality for getting the
next timer interrupt. To reuse it, it is splitted into an separate function
"get_next_timer_interrupt()".

This is preparatory work for the conversion of the NOHZ timer
placement to a pull at expiry time model. No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
v4: Fix typo in comment
---
 kernel/time/timer.c | 93 +++++++++++++++++++++++++--------------------
 1 file changed, 51 insertions(+), 42 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 680a0760e30d..853089febf83 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1704,6 +1704,46 @@ static unsigned long next_timer_interrupt(struct timer_base *base)
 	return base->next_expiry;
 }
 
+static unsigned long get_next_timer_interrupt(struct timer_base *base_local,
+					      struct timer_base *base_global,
+					      unsigned long basej, u64 basem,
+					      struct timer_events *tevt)
+{
+	unsigned long nextevt_local, nextevt_global;
+	bool local_first;
+
+	nextevt_local = next_timer_interrupt(base_local);
+	nextevt_global = next_timer_interrupt(base_global);
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
+	/*
+	 * Update tevt->* values:
+	 *
+	 * If the local queue expires first, then the global event can
+	 * be ignored. If the global queue is empty, nothing to do
+	 * either.
+	 */
+	if (!local_first && base_global->timers_pending)
+		tevt->global = basem + (u64)(nextevt_global - basej) * TICK_NSEC;
+
+	if (base_local->timers_pending)
+		tevt->local = basem + (u64)(nextevt_local - basej) * TICK_NSEC;
+
+	return local_first ? nextevt_local : nextevt_global;
+}
+
 /*
  * Forward base clock is done only when @basej is past base->clk, otherwise
  * base-clk might be rewind.
@@ -1738,7 +1778,7 @@ void forward_and_idle_timer_bases(unsigned long basej, u64 basem,
 {
 	unsigned long nextevt, nextevt_local, nextevt_global;
 	struct timer_base *base_local, *base_global;
-	bool local_first, is_idle;
+	bool is_idle;
 
 	/* Preset local / global events */
 	tevt->local = tevt->global = KTIME_MAX;
@@ -1756,8 +1796,11 @@ void forward_and_idle_timer_bases(unsigned long basej, u64 basem,
 	raw_spin_lock(&base_local->lock);
 	raw_spin_lock_nested(&base_global->lock, SINGLE_DEPTH_NESTING);
 
-	nextevt_local = next_timer_interrupt(base_local);
-	nextevt_global = next_timer_interrupt(base_global);
+	nextevt = get_next_timer_interrupt(base_local, base_global,
+					   basej, basem, tevt);
+
+	nextevt_local = base_local->next_expiry;
+	nextevt_global = base_global->next_expiry;
 
 	/*
 	 * We have a fresh next event. Check whether we can forward the
@@ -1766,21 +1809,6 @@ void forward_and_idle_timer_bases(unsigned long basej, u64 basem,
 	forward_base_clk(base_local, nextevt_local, basej);
 	forward_base_clk(base_global, nextevt_global, basej);
 
-	/*
-	 * Check whether the local event is expiring before or at the same
-	 * time as the global event.
-	 *
-	 * Note, that nextevt_global and nextevt_local might be based on
-	 * different base->clk values. So it's not guaranteed that
-	 * comparing with empty bases results in a correct local_first.
-	 */
-	if (base_local->timers_pending && base_global->timers_pending)
-		local_first = time_before_eq(nextevt_local, nextevt_global);
-	else
-		local_first = base_local->timers_pending;
-
-	nextevt = local_first ? nextevt_local : nextevt_global;
-
 	/*
 	 * Bases are idle if the next event is more than a tick away. Also
 	 * the tick is stopped so any added timer must forward the base clk
@@ -1793,43 +1821,24 @@ void forward_and_idle_timer_bases(unsigned long basej, u64 basem,
 	/* We need to mark both bases in sync */
 	base_local->is_idle = base_global->is_idle = is_idle;
 
+	raw_spin_unlock(&base_global->lock);
+	raw_spin_unlock(&base_local->lock);
+
 	/*
 	 * If the bases are not marked idle, i.e one of the events is at
 	 * max. one tick away, then the CPU can't go into a NOHZ idle
 	 * sleep. Use the earlier event of both and store it in the local
 	 * expiry value. The next global event is irrelevant in this case
-	 * and can be left as KTIME_MAX. CPU will wakeup on time.
+	 * and can be reset as KTIME_MAX. CPU will wakeup on time.
 	 */
 	if (!is_idle) {
 		/* If we missed a tick already, force 0 delta */
 		if (time_before(nextevt, basej))
 			nextevt = basej;
 		tevt->local = basem + (u64)(nextevt - basej) * TICK_NSEC;
-		goto unlock;
+		tevt->global = KTIME_MAX;
 	}
 
-	/*
-	 * If the bases are marked idle, i.e. the next event on both the
-	 * local and the global queue are farther away than a tick,
-	 * evaluate both bases. No need to check whether one of the bases
-	 * has an already expired timer as this is caught by the !is_idle
-	 * condition above.
-	 */
-	if (base_local->timers_pending)
-		tevt->local = basem + (u64)(nextevt_local - basej) * TICK_NSEC;
-
-	/*
-	 * If the local queue expires first, then the global event can be
-	 * ignored. The CPU wakes up before that. If the global queue is
-	 * empty, nothing to do either.
-	 */
-	if (!local_first && base_global->timers_pending)
-		tevt->global = basem + (u64)(nextevt_global - basej) * TICK_NSEC;
-
-unlock:
-	raw_spin_unlock(&base_global->lock);
-	raw_spin_unlock(&base_local->lock);
-
 	cmp_next_hrtimer_event(basem, tevt);
 }
 
-- 
2.30.2

