Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A82D6FD836
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 09:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236462AbjEJHa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 03:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236427AbjEJH3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 03:29:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A3883E1
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 00:29:15 -0700 (PDT)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683703725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kjr8ehOGWl+U5w68OocZ0UatjT7x+exFpUCyarAkc4Y=;
        b=ljoPopX8xyoTH/W0FdPnmxoNe/tKkyQaO9C2hKFbE0R4MAH9DfSVWm3+D/Rjs2+DT2wHjy
        sjyfYOqRapeo8Et8Jjv/CVF0mv8ux+DWHntkiYVHi8BglqYI2FhTiPVxCLDgbnnG2Vja67
        TxszarTgf6b29R5nJuV24/b6bB3piqqeCQf5tZexb7ZqSeH+7CkTeOb4xAs6CUk/Sa8kCy
        +QfoK8afiv58YXcqoRZA6ZdVqJDs59nSsVsTltfsF7k7cpWqSs5ivsMeHBZj+hH2P7mzR4
        9ct9HXvBjLklVebqs3Vl5D+l+XgiXBMXSB42Ty7eZFcuUfvLjFiHGhTwQahtOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683703725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kjr8ehOGWl+U5w68OocZ0UatjT7x+exFpUCyarAkc4Y=;
        b=NH4PQF9E0vHu77m0Ba4gQagyokNn5JG2QxcMHoC7UpqMfyXt03MnR4LeUMkOCO55d3VcdY
        TyNuI1vJWOXfrGBA==
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
        "Richard Cochran (linutronix GmbH)" <richardcochran@gmail.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH v6 16/21] timer: Restructure internal locking
Date:   Wed, 10 May 2023 09:28:12 +0200
Message-Id: <20230510072817.116056-17-anna-maria@linutronix.de>
In-Reply-To: <20230510072817.116056-1-anna-maria@linutronix.de>
References: <20230510072817.116056-1-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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
index 2370c9a15ba6..61042f1e6f6a 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -2196,11 +2196,7 @@ static inline void __run_timers(struct timer_base *base)
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
@@ -2220,21 +2216,36 @@ static inline void __run_timers(struct timer_base *base)
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

