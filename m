Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7336960CE2C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 16:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbiJYN7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 09:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbiJYN70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 09:59:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3917A29C;
        Tue, 25 Oct 2022 06:59:25 -0700 (PDT)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666706363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vvmb4wfRRA26uf1ExR6XWWcWf4ly6fbBq4i3VJ/TCEY=;
        b=LwzQPpX+Ny/PxpUuI5+8qcVrqQfT+WjE7/NENxhUShNmOEw/iTf37CJ4FwRBqsuzl/u5z+
        wnhOmVBSHuvvQyowXC9m+wb5s2TtJpaDZsDxGrXBFbncS/SR0qiDtqA+1c8pv+rwlX9rfm
        aKX3hwqW3fvLBrefg8HwPjql35faDPU5ouq3uzKL5MPAVoxJLVIEeSj2Pgi26Jjk/kIKG7
        eEX9DHBUgsGP6QEHMDXA0SIbTKgCLNyh0PJSXLS9Q2AxQ0fmesw+KOHPOCPl+ANDsd6Tw8
        jjKvOFiZGe8GwKADdu1P0m0wi7qVYiwGlix0MqBMBM89OEmMaLhlzh/DYDe1LQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666706363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vvmb4wfRRA26uf1ExR6XWWcWf4ly6fbBq4i3VJ/TCEY=;
        b=8N2pUT0OaCAesECVu/HpMphD9DDy2spXcuoPHDFPo3FjS0DZYJm78WHzj9wdoRKnl4Q9t9
        /tIBD5wqb5wMx+Cg==
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
Subject: [PATCH v3 05/17] timer: Rework idle logic
Date:   Tue, 25 Oct 2022 15:58:38 +0200
Message-Id: <20221025135850.51044-6-anna-maria@linutronix.de>
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

From: Thomas Gleixner <tglx@linutronix.de>

To improve readability of the code, split base->idle calculation and
expires calculation into separate parts.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/timer.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index f34bc75ff848..cb4194ecca60 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1727,21 +1727,20 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
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
+		if (time_before_eq(nextevt, basej))
+			nextevt = basej;
+		expires = basem + (u64)(nextevt - basej) * TICK_NSEC;
 	}
 	raw_spin_unlock(&base->lock);
 
-- 
2.30.2

