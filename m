Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5E96A6E2C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 15:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjCAOSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 09:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjCAOSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 09:18:06 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0704C2749F
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 06:18:04 -0800 (PST)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1677680283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dI0Osk/OAmUYMH0JGdEpZhhzt84bkmaFLBo02yUJopk=;
        b=RllZtvlPLoBcZswhHJc6ZhEoJJgFlOOwrIYL8LeIhuaaau50JfVbyOeTHN7knaPSH3D0ck
        aHBLmFtcVdVAKo6GEGqgaArorj65LtFxjeM4KTw2+ElhVckeoHufXxUQdENO/xFNZj3HHy
        zxfInWeZXhQUwj6IEwAudBLQb6qM6f6tfsWjiFz/1KCPaHdK4n17utM8UVFmYSx+LqluPo
        rNU4UfhgViPD5E3ty2fepVQ2fGwFbco1BIdAuVj5LGaEFO4+ZIRFqMPGTyZYyt2898SLYE
        l0Exabb/QWjE9dFVDZtvOl5qNPe3I06rVnbHqJnlo0F6tAGVNu6TYo+dwlpp1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1677680283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dI0Osk/OAmUYMH0JGdEpZhhzt84bkmaFLBo02yUJopk=;
        b=2YeVth/SqIUuVhpAhfCwmY9LcAG4Bp69PIpwirO/x9u0N2rHiZh0AuHCi6DpPBdEQXPb4b
        vV+zGbwAnt0bpmDQ==
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
Subject: [PATCH v5 02/18] timer: Add comment to get_next_timer_interrupt() description
Date:   Wed,  1 Mar 2023 15:17:28 +0100
Message-Id: <20230301141744.16063-3-anna-maria@linutronix.de>
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

get_next_timer_interrupt() does more than simply getting the next timer
interrupt. The timer bases are forwarded and also marked as idle whenever
possible.

To get not confused, add a comment to function description.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
v5: New patch, which adds only a comment to get_next_timer_interrupt()
instead of changing the function name
---
 kernel/time/timer.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 63a8ce7177dd..ffb94bc3852f 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1915,6 +1915,10 @@ static u64 cmp_next_hrtimer_event(u64 basem, u64 expires)
  * @basej:	base time jiffies
  * @basem:	base time clock monotonic
  *
+ * If required, base->clk is forwarded and base is also marked as
+ * idle. Idle handling of timer bases is allowed only to be done by CPU
+ * itself.
+ *
  * Returns the tick aligned clock monotonic time of the next pending
  * timer or KTIME_MAX if no timer is pending.
  */
-- 
2.30.2

