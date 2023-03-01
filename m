Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83FA6A6E2F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 15:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjCAOSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 09:18:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbjCAOSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 09:18:06 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C7C303C6
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 06:18:05 -0800 (PST)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1677680284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A3VhrY17dPpOY3y4FlMoo2pmszX0SRI6dHh159vCceQ=;
        b=Zcha6x1HtunQVxVsE5cwm1zCjM17QNul8CZuCnZdpsd+0xfgMvLqTKgFOsJyVh09MRLaOO
        laXLfzFngjJL119Am6gvRYJnsGTXx+MlTNlJgwsHTbJWwN/Clj8JRiRkrINaQrVklaFoZb
        Kki/VJSYpu65N/DRF8iakrixsY2EPqHqCl/XHZ6WP1hfe57XwSPORenLPR2nhY7xZsapDK
        rbkS80MR9/AKm8e9WFpt1Lrrn8J9OOqB548uuCO/P7rLasKRMOroVO2SYET2lv8FtFf/1M
        1pVDkAf4IHr6E16ODitO8+Z41PhIWwLHQWJRqkGjLf/cIzXrN7XkGyKBSjWy+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1677680284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A3VhrY17dPpOY3y4FlMoo2pmszX0SRI6dHh159vCceQ=;
        b=iq9Z6Stf0/aTlghbUUKcQsToba/xMsTjP5ZEpIa9jo7mP50KPoT0L0WOZixlsaeHZUMXXV
        CH5R+PzcM08S2WBA==
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
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH v5 04/18] timer: Split next timer interrupt logic
Date:   Wed,  1 Mar 2023 15:17:30 +0100
Message-Id: <20230301141744.16063-5-anna-maria@linutronix.de>
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

Logic for getting next timer interrupt (no matter of recalculated or
already stored in base->next_expiry) is split into a separate function
"next_timer_interrupt()" to make it available for new call sites.

No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/timer.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 08e855727ff8..9e6c2058889b 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1913,6 +1913,14 @@ static u64 cmp_next_hrtimer_event(u64 basem, u64 expires)
 	return DIV_ROUND_UP_ULL(nextevt, TICK_NSEC) * TICK_NSEC;
 }
 
+static unsigned long next_timer_interrupt(struct timer_base *base)
+{
+	if (base->next_expiry_recalc)
+		next_expiry_recalc(base);
+
+	return base->next_expiry;
+}
+
 /**
  * get_next_timer_interrupt - return the time (clock mono) of the next timer
  * @basej:	base time jiffies
@@ -1939,9 +1947,8 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
 		return expires;
 
 	raw_spin_lock(&base->lock);
-	if (base->next_expiry_recalc)
-		next_expiry_recalc(base);
-	nextevt = base->next_expiry;
+
+	nextevt = next_timer_interrupt(base);
 
 	/*
 	 * We have a fresh next event. Check whether we can forward the
-- 
2.30.2

