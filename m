Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF796A6E30
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 15:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjCAOSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 09:18:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjCAOSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 09:18:09 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE1623DA4
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 06:18:07 -0800 (PST)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1677680284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mxBQLfqFMmn/4LKpc4xr9a8h2eIYUaZukb+bTAZlfes=;
        b=4se4AVrvLdzBcWQjXgIXW9CmrWvBZGxWhLunDIKEAhH1PUHbrFnelH0e5fnHB5qQvT7l/J
        uxO4fQAqLOXIgahydxDpwa/A+fvwbPnYb6AAN/+b4HOBDK5odzWSHu6Tf1tLp3hmMNzLM5
        aGondTb2qrb1CLSytKZF0GOJ3rR1z/D25PuZmHw+VLrOCI9MmnrgpErECf9tCQEfQWP3x2
        +W7zmO6z0HiV9R2ks9sSCfTPA/BSCBhDNLRyOZXVDFqFXqI9oBNjbwfgkWwTkuEg/sERJ/
        QNfO4eJSJX+9tFjroGFam4wERVfB1nXbbNj2HxCXAaOVcRAU7WAFGb/FaKzu9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1677680284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mxBQLfqFMmn/4LKpc4xr9a8h2eIYUaZukb+bTAZlfes=;
        b=BTBv5acIz2sWHYAB6pSVgBKf4KjRx45jcrlu+rqaSbUZwZ81H3AAla2zQhp/eOt0Rkz2ar
        NNMCk5FbcTjXVqBw==
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
Subject: [PATCH v5 05/18] timer: Rework idle logic
Date:   Wed,  1 Mar 2023 15:17:31 +0100
Message-Id: <20230301141744.16063-6-anna-maria@linutronix.de>
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

From: Thomas Gleixner <tglx@linutronix.de>

To improve readability of the code, split base->idle calculation and
expires calculation into separate parts.

Thereby the following subtle change happens if the next event is just one
jiffy ahead and the tick was already stopped: Originally base->is_idle
remains true in this situation. Now base->is_idle turns to false. This may
spare an IPI if a timer is enqueued remotely to an idle CPU that is going
to tick on the next jiffy.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/timer.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 9e6c2058889b..d74d538e06a2 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1962,21 +1962,20 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
 			base->clk = nextevt;
 	}
 
-	if (time_before_eq(nextevt, basej)) {
-		expires = basem;
-		base->is_idle = false;
-	} else {
-		if (base->timers_pending)
-			expires = basem + (u64)(nextevt - basej) * TICK_NSEC;
-		/*
-		 * If we expect to sleep more than a tick, mark the base idle.
-		 * Also the tick is stopped so any added timer must forward
-		 * the base clk itself to keep granularity small. This idle
-		 * logic is only maintained for the BASE_STD base, deferrable
-		 * timers may still see large granularity skew (by design).
-		 */
-		if ((expires - basem) > TICK_NSEC)
-			base->is_idle = true;
+	/*
+	 * Base is idle if the next event is more than a tick away. Also
+	 * the tick is stopped so any added timer must forward the base clk
+	 * itself to keep granularity small. This idle logic is only
+	 * maintained for the BASE_STD base, deferrable timers may still
+	 * see large granularity skew (by design).
+	 */
+	base->is_idle = time_after(nextevt, basej + 1);
+
+	if (base->timers_pending) {
+		/* If we missed a tick already, force 0 delta */
+		if (time_before(nextevt, basej))
+			nextevt = basej;
+		expires = basem + (u64)(nextevt - basej) * TICK_NSEC;
 	}
 	raw_spin_unlock(&base->lock);
 
-- 
2.30.2

