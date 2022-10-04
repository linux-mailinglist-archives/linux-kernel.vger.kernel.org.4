Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52CA85F3FAD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 11:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbiJDJaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 05:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiJDJ1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:27:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44802620;
        Tue,  4 Oct 2022 02:27:16 -0700 (PDT)
Date:   Tue, 04 Oct 2022 09:27:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664875635;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7pi4RJHtO3XJpc68SUyJf1Iso6xt3ntYwa3wqfD2VAA=;
        b=Aslae4EtcjLWMLXUNbvw5DyClx/PSIXqPjBO88iETQHhIJ44nZMEbNTX8GQP6rO4DJuXEU
        rHrJCWoRUoXOwxcDoUZbUqzlcFQ3xrnYp1QQKiyT8GbpNGW2K2i+Izp/RT9TuvuNazqjrp
        3jEgV04mzCUsafNUy+e+YE+zPOjJGO0W6vRXTFQOWC5oOTSoxWWp3VSmcYVlmUN18p1Btx
        b3c/YqU2XHpPtrSD4dAHJrEfzV9JRtau/1BDQaoI1KKs3ottwshr7jHLpMBH21wn0mrdn0
        4cCaQSbtuPM6Yof538gG9yfnRmstiBZWtJuQxpRrfZ5wQG+9Voye6X+6P0J4qQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664875635;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7pi4RJHtO3XJpc68SUyJf1Iso6xt3ntYwa3wqfD2VAA=;
        b=3L7g1qj9n1vw9/A/t9wuqNY50iep6nJ5jJmXucIyoclfJIjd363kipQQEVJwzJcpLZnAKa
        5AGlAtVTahut+rBg==
From:   "tip-bot2 for Tony Lindgren" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/timer-ti-dm: Simplify register
 access further
Cc:     Tony Lindgren <tony@atomide.com>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220815131250.34603-5-tony@atomide.com>
References: <20220815131250.34603-5-tony@atomide.com>
MIME-Version: 1.0
Message-ID: <166487563427.401.9091335164563992983.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     f32bdac10cb5f461f8c71c3b9703617c42322d2f
Gitweb:        https://git.kernel.org/tip/f32bdac10cb5f461f8c71c3b9703617c42322d2f
Author:        Tony Lindgren <tony@atomide.com>
AuthorDate:    Mon, 15 Aug 2022 16:12:45 +03:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 20 Sep 2022 10:49:45 +02:00

clocksource/drivers/timer-ti-dm: Simplify register access further

Let's unify register access and use dmtimer_read() and dmtimer_write()
also for the timer revision specific registers like we now do for the
shread registers.

Signed-off-by: Tony Lindgren <tony@atomide.com>
Reviewed-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Link: https://lore.kernel.org/r/20220815131250.34603-5-tony@atomide.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-ti-dm.c | 28 ++++++++++++++--------------
 include/clocksource/timer-ti-dm.h |  6 +++---
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index 61c3c76..fe8ba0f 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -101,16 +101,16 @@ static inline void __omap_dm_timer_init_regs(struct omap_dm_timer *timer)
 	tidr = readl_relaxed(timer->io_base);
 	if (!(tidr >> 16)) {
 		timer->revision = 1;
-		timer->irq_stat = timer->io_base + OMAP_TIMER_V1_STAT_OFFSET;
-		timer->irq_ena = timer->io_base + OMAP_TIMER_V1_INT_EN_OFFSET;
-		timer->irq_dis = timer->io_base + OMAP_TIMER_V1_INT_EN_OFFSET;
+		timer->irq_stat = OMAP_TIMER_V1_STAT_OFFSET;
+		timer->irq_ena = OMAP_TIMER_V1_INT_EN_OFFSET;
+		timer->irq_dis = OMAP_TIMER_V1_INT_EN_OFFSET;
 		timer->pend = timer->io_base + _OMAP_TIMER_WRITE_PEND_OFFSET;
 		timer->func_base = timer->io_base;
 	} else {
 		timer->revision = 2;
-		timer->irq_stat = timer->io_base + OMAP_TIMER_V2_IRQSTATUS;
-		timer->irq_ena = timer->io_base + OMAP_TIMER_V2_IRQENABLE_SET;
-		timer->irq_dis = timer->io_base + OMAP_TIMER_V2_IRQENABLE_CLR;
+		timer->irq_stat = OMAP_TIMER_V2_IRQSTATUS - OMAP_TIMER_V2_FUNC_OFFSET;
+		timer->irq_ena = OMAP_TIMER_V2_IRQENABLE_SET - OMAP_TIMER_V2_FUNC_OFFSET;
+		timer->irq_dis = OMAP_TIMER_V2_IRQENABLE_CLR - OMAP_TIMER_V2_FUNC_OFFSET;
 		timer->pend = timer->io_base +
 			_OMAP_TIMER_WRITE_PEND_OFFSET +
 				OMAP_TIMER_V2_FUNC_OFFSET;
@@ -165,13 +165,13 @@ static inline void __omap_dm_timer_stop(struct omap_dm_timer *timer,
 	}
 
 	/* Ack possibly pending interrupt */
-	writel_relaxed(OMAP_TIMER_INT_OVERFLOW, timer->irq_stat);
+	dmtimer_write(timer, timer->irq_stat, OMAP_TIMER_INT_OVERFLOW);
 }
 
 static inline void __omap_dm_timer_int_enable(struct omap_dm_timer *timer,
 						unsigned int value)
 {
-	writel_relaxed(value, timer->irq_ena);
+	dmtimer_write(timer, timer->irq_ena, value);
 	dmtimer_write(timer, OMAP_TIMER_WAKEUP_EN_REG, value);
 }
 
@@ -184,7 +184,7 @@ __omap_dm_timer_read_counter(struct omap_dm_timer *timer)
 static inline void __omap_dm_timer_write_status(struct omap_dm_timer *timer,
 						unsigned int value)
 {
-	writel_relaxed(value, timer->irq_stat);
+	dmtimer_write(timer, timer->irq_stat, value);
 }
 
 static void omap_timer_restore_context(struct omap_dm_timer *timer)
@@ -196,7 +196,7 @@ static void omap_timer_restore_context(struct omap_dm_timer *timer)
 	dmtimer_write(timer, OMAP_TIMER_LOAD_REG, timer->context.tldr);
 	dmtimer_write(timer, OMAP_TIMER_MATCH_REG, timer->context.tmar);
 	dmtimer_write(timer, OMAP_TIMER_IF_CTRL_REG, timer->context.tsicr);
-	writel_relaxed(timer->context.tier, timer->irq_ena);
+	dmtimer_write(timer, timer->irq_ena, timer->context.tier);
 	dmtimer_write(timer, OMAP_TIMER_CTRL_REG, timer->context.tclr);
 }
 
@@ -208,7 +208,7 @@ static void omap_timer_save_context(struct omap_dm_timer *timer)
 	timer->context.twer = dmtimer_read(timer, OMAP_TIMER_WAKEUP_EN_REG);
 	timer->context.tldr = dmtimer_read(timer, OMAP_TIMER_LOAD_REG);
 	timer->context.tmar = dmtimer_read(timer, OMAP_TIMER_MATCH_REG);
-	timer->context.tier = readl_relaxed(timer->irq_ena);
+	timer->context.tier = dmtimer_read(timer, timer->irq_ena);
 	timer->context.tsicr = dmtimer_read(timer, OMAP_TIMER_IF_CTRL_REG);
 }
 
@@ -722,9 +722,9 @@ static int omap_dm_timer_set_int_disable(struct omap_dm_timer *timer, u32 mask)
 	omap_dm_timer_enable(timer);
 
 	if (timer->revision == 1)
-		l = readl_relaxed(timer->irq_ena) & ~mask;
+		l = dmtimer_read(timer, timer->irq_ena) & ~mask;
 
-	writel_relaxed(l, timer->irq_dis);
+	dmtimer_write(timer, timer->irq_dis, l);
 	l = dmtimer_read(timer, OMAP_TIMER_WAKEUP_EN_REG) & ~mask;
 	dmtimer_write(timer, OMAP_TIMER_WAKEUP_EN_REG, l);
 
@@ -741,7 +741,7 @@ static unsigned int omap_dm_timer_read_status(struct omap_dm_timer *timer)
 		return 0;
 	}
 
-	l = readl_relaxed(timer->irq_stat);
+	l = dmtimer_read(timer, timer->irq_stat);
 
 	return l;
 }
diff --git a/include/clocksource/timer-ti-dm.h b/include/clocksource/timer-ti-dm.h
index 4142bf7..e874eed 100644
--- a/include/clocksource/timer-ti-dm.h
+++ b/include/clocksource/timer-ti-dm.h
@@ -100,9 +100,9 @@ struct omap_dm_timer {
 	struct clk *fclk;
 
 	void __iomem	*io_base;
-	void __iomem	*irq_stat;	/* TISR/IRQSTATUS interrupt status */
-	void __iomem	*irq_ena;	/* irq enable */
-	void __iomem	*irq_dis;	/* irq disable, only on v2 ip */
+	int		irq_stat;	/* TISR/IRQSTATUS interrupt status */
+	int		irq_ena;	/* irq enable */
+	int		irq_dis;	/* irq disable, only on v2 ip */
 	void __iomem	*pend;		/* write pending */
 	void __iomem	*func_base;	/* function register base */
 
