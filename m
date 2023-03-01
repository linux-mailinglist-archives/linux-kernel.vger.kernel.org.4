Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329726A6E35
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 15:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjCAOSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 09:18:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjCAOSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 09:18:10 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA9C241E9
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 06:18:08 -0800 (PST)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1677680287;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7LmHc98G0hhyTlVp1eBaBtU+iOdxru2/lJNxgEN+R0I=;
        b=AQMc/FeEQyC4v0UshKaDe2INekwpr3bkZcUCHbZa0XOyDismO4P4cy1WnalkpjwiegUh+I
        EXPRZF6Il3mnoZ9T+oMeTL8oZMFXzhFfVPnkXmzLJcr64m/BRm8qnc0nlsV7iR/jbHzf3p
        toRq0ATMuCYomxpAkSFTBRi0CwB981LniRDTtOchDarxuCsVLXvM0CaBi34+kFoscOm1YC
        R58mVj6FT38KZWo1UmuqbQl9gVwFRfxavqd7RH8ZtDbP1MFG/b/1s3KNgV7SPTXqj9IBYJ
        oebxWyWrAY+/QRdasWYVfdQseZnlhPQnaTgiy7yqkFM2xwFySUOq7/i4XPAFEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1677680287;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7LmHc98G0hhyTlVp1eBaBtU+iOdxru2/lJNxgEN+R0I=;
        b=l6r1TlldI9GdIPKkCE4H82PWKOrg92M/x+gnwAcHrheV6rV02Ig9c3VcAGhtYma9d3rpvI
        vwk4VdYC8GqTdaAA==
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
Subject: [PATCH v5 10/18] timer: Retrieve next expiry of pinned/non-pinned timers seperately
Date:   Wed,  1 Mar 2023 15:17:36 +0100
Message-Id: <20230301141744.16063-11-anna-maria@linutronix.de>
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

For the conversion of the NOHZ timer placement to a pull at expiry time
model it's required to have seperate expiry times for the pinned and the
non-pinned (movable) timers. Therefore struct timer_events is introduced.

No functional change

Originally-by: Richard Cochran (linutronix GmbH) <richardcochran@gmail.com>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/timer.c | 45 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 40 insertions(+), 5 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 7656eab1bf20..ff41d978cb22 100644
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
@@ -1968,17 +1973,17 @@ static void forward_base_clk(struct timer_base *base, unsigned long nextevt,
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
@@ -2023,16 +2028,46 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
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

