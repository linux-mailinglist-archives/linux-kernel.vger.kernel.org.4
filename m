Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E490670EF05
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 09:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239962AbjEXHIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 03:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239900AbjEXHHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 03:07:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1212D9B
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 00:07:05 -0700 (PDT)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684912023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=toZ3+ufortFTTBI6OBlc3a3bWizxyvQL3TeTeVCWUqU=;
        b=U34zMuW1T+0NnQXAvVtSY/xZY7B7AQ7PK8D6JhE/lZ1vlJJHSyGCug8oKFSSY6GfcUSSem
        OM4sDozDQ4U0INnjdI3PqmVxW7nh64lVuYkniLfwzSvxwbrJxXCtCa4ZFWTb2i00I6APFe
        dpt+deuVti3Iz2xiYd7oJ6Tr8tVnItyPTYwLdWzBvigEbXV52YFOFu0at7N7LNQE1zJ653
        ouL0EHo+QPmUrip6shzvzXom8mYh+fTYI2YKXsG2zjZBZgGkurWZ2FxKGoLzzUGJG6zU/b
        pz5DNTg3yX5Y2iKbF2oBAP685kys/zSFqBsNpFRNwB+PeV8ctvXzgGw9Is2Dig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684912023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=toZ3+ufortFTTBI6OBlc3a3bWizxyvQL3TeTeVCWUqU=;
        b=8TaUbW9PT2Pjl6QzwXtZA7s6O4RZP3SC15HsBKLr6IdomKYrFDQbeYwL8DNCNf+UBNnkEZ
        zZ7dqhWkv502wlAA==
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
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH v7 14/21] timer: Split out "get next timer interrupt" functionality
Date:   Wed, 24 May 2023 09:06:22 +0200
Message-Id: <20230524070629.6377-15-anna-maria@linutronix.de>
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

The functionality for getting the next timer interrupt in
get_next_timer_interrupt() is split into a separate function
fetch_next_timer_interrupt() to be usable by other call sites.

This is preparatory work for the conversion of the NOHZ timer
placement to a pull at expiry time model. No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
v6: s/splitted/split
v5: Update commit message
v4: Fix typo in comment
---
 kernel/time/timer.c | 91 +++++++++++++++++++++++++--------------------
 1 file changed, 50 insertions(+), 41 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index e4b50760da3f..4bb6c168d106 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1973,6 +1973,46 @@ static unsigned long next_timer_interrupt(struct timer_base *base)
 	return base->next_expiry;
 }
 
+static unsigned long fetch_next_timer_interrupt(struct timer_base *base_local,
+						struct timer_base *base_global,
+						unsigned long basej, u64 basem,
+						struct timer_events *tevt)
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
@@ -2005,7 +2045,7 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
 	struct timer_events tevt = { .local = KTIME_MAX, .global = KTIME_MAX };
 	unsigned long nextevt, nextevt_local, nextevt_global;
 	struct timer_base *base_local, *base_global;
-	bool local_first, is_idle;
+	bool is_idle;
 
 	/*
 	 * Pretend that there is no timer pending if the cpu is offline.
@@ -2020,8 +2060,11 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
 	raw_spin_lock(&base_local->lock);
 	raw_spin_lock_nested(&base_global->lock, SINGLE_DEPTH_NESTING);
 
-	nextevt_local = next_timer_interrupt(base_local);
-	nextevt_global = next_timer_interrupt(base_global);
+	nextevt = fetch_next_timer_interrupt(base_local, base_global,
+					     basej, basem, &tevt);
+
+	nextevt_local = base_local->next_expiry;
+	nextevt_global = base_global->next_expiry;
 
 	/*
 	 * We have a fresh next event. Check whether we can forward the
@@ -2030,21 +2073,6 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
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
@@ -2057,6 +2085,9 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
 	/* We need to mark both bases in sync */
 	base_local->is_idle = base_global->is_idle = is_idle;
 
+	raw_spin_unlock(&base_global->lock);
+	raw_spin_unlock(&base_local->lock);
+
 	/*
 	 * If the bases are not marked idle, i.e one of the events is at
 	 * max. one tick away, then the CPU can't go into a NOHZ idle
@@ -2069,31 +2100,9 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
 		if (time_before(nextevt, basej))
 			nextevt = basej;
 		tevt.local = basem + (u64)(nextevt - basej) * TICK_NSEC;
-		goto unlock;
+		tevt.global = KTIME_MAX;
 	}
 
-	/*
-	 * If the bases are marked idle, i.e. the next event on both the
-	 * local and the global queue are farther away than a tick,
-	 * evaluate both bases. No need to check whether one of the bases
-	 * has an already expired timer as this is caught by the !is_idle
-	 * condition above.
-	 */
-	if (base_local->timers_pending)
-		tevt.local = basem + (u64)(nextevt_local - basej) * TICK_NSEC;
-
-	/*
-	 * If the local queue expires first, then the global event can be
-	 * ignored. The CPU wakes up before that. If the global queue is
-	 * empty, nothing to do either.
-	 */
-	if (!local_first && base_global->timers_pending)
-		tevt.global = basem + (u64)(nextevt_global - basej) * TICK_NSEC;
-
-unlock:
-	raw_spin_unlock(&base_global->lock);
-	raw_spin_unlock(&base_local->lock);
-
 	tevt.local = min_t(u64, tevt.local, tevt.global);
 
 	return cmp_next_hrtimer_event(basem, tevt.local);
-- 
2.30.2

