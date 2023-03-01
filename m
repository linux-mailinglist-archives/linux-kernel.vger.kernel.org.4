Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE38D6A6E3E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 15:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjCAOT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 09:19:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjCAOSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 09:18:12 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC735302AB
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 06:18:09 -0800 (PST)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1677680288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hYkRaj7fFuHhhF0p5MKMIEGo5VHWJduanTtTi0xnzx4=;
        b=mVDzJUVSL8YbK+9WDuug7CP+lk9mwKhlGxGqYBLWtRQSlXkhIBWl4oBxypRJGdqj+TUatt
        VExTVmNdLsACHM/tNqpr80K/MOPP9k4If66+GlQJgP0/m/jekcPdlSBuaFeVCvKkMIhvfU
        saLM+xNjbyzEH5tLcJbm51/1SQS5qpe3IiXo7BQgQCZHtgwIt4VWluS3RZqDtCjOG5PMUI
        7MhBnPA0pTWsRHK/BPjCprpdFLZwBb8ASGDnXzkWn5DNGzeDjErUjTANfpLYAaho1qjKoJ
        emM45ZMQBHGv+aHZODTbLTZXEAsaFpM5kechy4w0V/0wRoJlsaVkV3E2KpqDLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1677680288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hYkRaj7fFuHhhF0p5MKMIEGo5VHWJduanTtTi0xnzx4=;
        b=Dxk2RIhDpMLPxR2d11a/L4F5Oxuy6YM3yRzV2H/snMQzjS/yU651n5EfrTTDPrSORm0i4N
        y175wT56vIlHjNCw==
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
        "Richard Cochran (linutronix GmbH)" <richardcochran@gmail.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH v5 13/18] timer: Restructure internal locking
Date:   Wed,  1 Mar 2023 15:17:39 +0100
Message-Id: <20230301141744.16063-14-anna-maria@linutronix.de>
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

From: "Richard Cochran (linutronix GmbH)" <richardcochran@gmail.com>

Move the locking out from __run_timers() to the call sites, so the
protected section can be extended at the call site. Preparatory patch for
changing the NOHZ timer placement to a pull at expiry time model.

No functional change.

Signed-off-by: Richard Cochran (linutronix GmbH) <richardcochran@gmail.com>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/timer.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 9daaef5d2f6f..be085e94afcc 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -2142,11 +2142,7 @@ static inline void __run_timers(struct timer_base *base)
 	struct hlist_head heads[LVL_DEPTH];
 	int levels;
 
-	if (time_before(jiffies, base->next_expiry))
-		return;
-
-	timer_base_lock_expiry(base);
-	raw_spin_lock_irq(&base->lock);
+	lockdep_assert_held(&base->lock);
 
 	while (time_after_eq(jiffies, base->clk) &&
 	       time_after_eq(jiffies, base->next_expiry)) {
@@ -2166,21 +2162,36 @@ static inline void __run_timers(struct timer_base *base)
 		while (levels--)
 			expire_timers(base, heads + levels);
 	}
+}
+
+static void __run_timer_base(struct timer_base *base)
+{
+	if (time_before(jiffies, base->next_expiry))
+		return;
+
+	timer_base_lock_expiry(base);
+	raw_spin_lock_irq(&base->lock);
+	__run_timers(base);
 	raw_spin_unlock_irq(&base->lock);
 	timer_base_unlock_expiry(base);
 }
 
+static void run_timer_base(int index)
+{
+	struct timer_base *base = this_cpu_ptr(&timer_bases[index]);
+
+	__run_timer_base(base);
+}
+
 /*
  * This function runs timers and the timer-tq in bottom half context.
  */
 static __latent_entropy void run_timer_softirq(struct softirq_action *h)
 {
-	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_LOCAL]);
-
-	__run_timers(base);
+	run_timer_base(BASE_LOCAL);
 	if (IS_ENABLED(CONFIG_NO_HZ_COMMON)) {
-		__run_timers(this_cpu_ptr(&timer_bases[BASE_GLOBAL]));
-		__run_timers(this_cpu_ptr(&timer_bases[BASE_DEF]));
+		run_timer_base(BASE_GLOBAL);
+		run_timer_base(BASE_DEF);
 	}
 }
 
-- 
2.30.2

