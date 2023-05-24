Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04DFF70EF01
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 09:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239942AbjEXHHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 03:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239860AbjEXHHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 03:07:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6261B1A7
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 00:07:04 -0700 (PDT)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684912022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r6aAJpUsFbdAiX81BLzrgrPjSrKyBdcLGR/988cXOog=;
        b=dotju3Hn6qkQGsykvxfeiHzdDDTEMSn5UJX94gDlmxsBbeo2gk1Uao0P/JJhqVqG2+IQK+
        223ALp6/P+ZME0M4pYKnWqHYUNzikSZ/glwLMO8GRewxoeCA6LB9DGxAxe3MmdaYW5kAgU
        aAX1cI8VGgxUvBhBIQbeASIZKcvV7pfH1u/kBgavVB/sSwEdFBDyTdr5ZcMYsf1o5Ob/W/
        72OPmK1LeGzrVqsb0kKUJ7i37MpffOa7ACt8MVJ9eWnmvxZKpBYzeUsB3iqBytPbV3y4h/
        c59ApQaapOxjyn7nGk8mvsEWT8krbSBGa9egMV5nzv+mx4e18PQXZ8Tpafbncg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684912022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r6aAJpUsFbdAiX81BLzrgrPjSrKyBdcLGR/988cXOog=;
        b=NY8bKGCPTTmbfMpu7VN7uc27lpyCP0SGl5UQuM/cv0smZEQTlQYK5kdoEHNDLLCUgNXMof
        15sd8FJPNbnH4PDw==
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
        Richard Cochran <richardcochran@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH v7 13/21] timer: Retrieve next expiry of pinned/non-pinned timers separately
Date:   Wed, 24 May 2023 09:06:21 +0200
Message-Id: <20230524070629.6377-14-anna-maria@linutronix.de>
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

For the conversion of the NOHZ timer placement to a pull at expiry time
model it's required to have separate expiry times for the pinned and the
non-pinned (movable) timers. Therefore struct timer_events is introduced.

No functional change

Originally-by: Richard Cochran (linutronix GmbH) <richardcochran@gmail.com>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/timer.c | 45 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 40 insertions(+), 5 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 010c8877fa85..e4b50760da3f 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -221,6 +221,11 @@ struct timer_base {
 
 static DEFINE_PER_CPU(struct timer_base, timer_bases[NR_BASES]);
 
+struct timer_events {
+	u64	local;
+	u64	global;
+};
+
 #ifdef CONFIG_NO_HZ_COMMON
 
 static DEFINE_STATIC_KEY_FALSE(timers_nohz_active);
@@ -1997,17 +2002,17 @@ static void forward_base_clk(struct timer_base *base, unsigned long nextevt,
  */
 u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
 {
+	struct timer_events tevt = { .local = KTIME_MAX, .global = KTIME_MAX };
 	unsigned long nextevt, nextevt_local, nextevt_global;
 	struct timer_base *base_local, *base_global;
 	bool local_first, is_idle;
-	u64 expires = KTIME_MAX;
 
 	/*
 	 * Pretend that there is no timer pending if the cpu is offline.
 	 * Possible pending timers will be migrated later to an active cpu.
 	 */
 	if (cpu_is_offline(smp_processor_id()))
-		return expires;
+		return tevt.local;
 
 	base_local = this_cpu_ptr(&timer_bases[BASE_LOCAL]);
 	base_global = this_cpu_ptr(&timer_bases[BASE_GLOBAL]);
@@ -2052,16 +2057,46 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
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
+		tevt.local = basem + (u64)(nextevt - basej) * TICK_NSEC;
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
+		tevt.local = basem + (u64)(nextevt_local - basej) * TICK_NSEC;
+
+	/*
+	 * If the local queue expires first, then the global event can be
+	 * ignored. The CPU wakes up before that. If the global queue is
+	 * empty, nothing to do either.
+	 */
+	if (!local_first && base_global->timers_pending)
+		tevt.global = basem + (u64)(nextevt_global - basej) * TICK_NSEC;
+
+unlock:
 	raw_spin_unlock(&base_global->lock);
 	raw_spin_unlock(&base_local->lock);
 
-	return cmp_next_hrtimer_event(basem, expires);
+	tevt.local = min_t(u64, tevt.local, tevt.global);
+
+	return cmp_next_hrtimer_event(basem, tevt.local);
 }
 
 /**
-- 
2.30.2

