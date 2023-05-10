Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A59E6FD82C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 09:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236297AbjEJH3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 03:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236008AbjEJH3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 03:29:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87DC76A6
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 00:28:52 -0700 (PDT)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683703719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3nPoc4ex9ONP2BmQpTyzqK0BECnFowWD2Bg10S9sUhQ=;
        b=lwpH+7Mo0htGaU9or8EAzwRFe5sp59Qu2+vv4tgo/ceZXYYd+xWKKrTmDYs15FG3UeWi2n
        r2JQtjs5P0sbGkfv5pcR49ODrm1amWM2s7lW1/yfwHOOI5D0B9C4ZK1jyL7O1W7DNNocJA
        +lKP0qkjUxxoZVN7s6uEaUHxNw/uYQR3FCu8Zqt1QbKnmIC81i3vQvcv1Y8dZxibBTSiUo
        /ieJjYfY7ik86G2UHh/DTtldFX3XdIds7cO/AcKhOGYUUB6zSJv87r4vlNVC3uvoZsRnBU
        qRUxmudTfDKvaRPqp8NGUZvrnzEU0e2rfveNawg4gbMUNemjbMTiwKkMLDV8RA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683703719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3nPoc4ex9ONP2BmQpTyzqK0BECnFowWD2Bg10S9sUhQ=;
        b=8N+/a2xubOkF5Cwp8MuTwiUx8UZMgX05VDRVgyU92jJGqL+ALW6WCsncuIQecTAowMaZBA
        H7+vq2Cxw7ebEWAA==
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
Subject: [PATCH v6 06/21] timer: Rework idle logic
Date:   Wed, 10 May 2023 09:28:02 +0200
Message-Id: <20230510072817.116056-7-anna-maria@linutronix.de>
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
v4: Change condition to force 0 delta and update commit message (Frederic)
---
 kernel/time/timer.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 1a61977f9efa..1522fb81887e 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1957,21 +1957,20 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
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

