Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716CC74431F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 22:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbjF3USY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 16:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbjF3USI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 16:18:08 -0400
Received: from unicorn.mansr.com (unicorn.mansr.com [81.2.72.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F722D52
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 13:18:07 -0700 (PDT)
Received: from raven.mansr.com (raven.mansr.com [IPv6:2001:8b0:ca0d:1::3])
        by unicorn.mansr.com (Postfix) with ESMTPS id 61C4715362;
        Fri, 30 Jun 2023 21:18:03 +0100 (BST)
Received: by raven.mansr.com (Postfix, from userid 51770)
        id 4E3CC21A9CD; Fri, 30 Jun 2023 21:18:03 +0100 (BST)
From:   Mans Rullgard <mans@mansr.com>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH 2/3] clocksource: sun5i: remove pointless struct
Date:   Fri, 30 Jun 2023 21:01:27 +0100
Message-ID: <20230630201800.16501-3-mans@mansr.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230630201800.16501-1-mans@mansr.com>
References: <20230630201800.16501-1-mans@mansr.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the pointless struct added in the previous patch to make
the diff smaller.

Signed-off-by: Mans Rullgard <mans@mansr.com>
---
 drivers/clocksource/timer-sun5i.c | 49 ++++++++++++++-----------------
 1 file changed, 22 insertions(+), 27 deletions(-)

diff --git a/drivers/clocksource/timer-sun5i.c b/drivers/clocksource/timer-sun5i.c
index e0ca97cf80cb..3ca427e54daf 100644
--- a/drivers/clocksource/timer-sun5i.c
+++ b/drivers/clocksource/timer-sun5i.c
@@ -35,22 +35,17 @@
 
 #define TIMER_SYNC_TICKS	3
 
-/* Pointless struct to minimise diff */
-struct _sun5i_timer {
+struct sun5i_timer {
 	void __iomem		*base;
 	struct clk		*clk;
 	struct notifier_block	clk_rate_cb;
 	u32			ticks_per_jiffy;
-};
-
-struct sun5i_timer {
-	struct _sun5i_timer	timer;
 	struct clocksource	clksrc;
 	struct clock_event_device	clkevt;
 };
 
 #define nb_to_sun5i_timer(x) \
-	container_of(x, struct sun5i_timer, timer.clk_rate_cb)
+	container_of(x, struct sun5i_timer, clk_rate_cb)
 #define clksrc_to_sun5i_timer(x) \
 	container_of(x, struct sun5i_timer, clksrc)
 #define clkevt_to_sun5i_timer(x) \
@@ -64,28 +59,28 @@ struct sun5i_timer {
  */
 static void sun5i_clkevt_sync(struct sun5i_timer *ce)
 {
-	u32 old = readl(ce->timer.base + TIMER_CNTVAL_LO_REG(1));
+	u32 old = readl(ce->base + TIMER_CNTVAL_LO_REG(1));
 
-	while ((old - readl(ce->timer.base + TIMER_CNTVAL_LO_REG(1))) < TIMER_SYNC_TICKS)
+	while ((old - readl(ce->base + TIMER_CNTVAL_LO_REG(1))) < TIMER_SYNC_TICKS)
 		cpu_relax();
 }
 
 static void sun5i_clkevt_time_stop(struct sun5i_timer *ce, u8 timer)
 {
-	u32 val = readl(ce->timer.base + TIMER_CTL_REG(timer));
-	writel(val & ~TIMER_CTL_ENABLE, ce->timer.base + TIMER_CTL_REG(timer));
+	u32 val = readl(ce->base + TIMER_CTL_REG(timer));
+	writel(val & ~TIMER_CTL_ENABLE, ce->base + TIMER_CTL_REG(timer));
 
 	sun5i_clkevt_sync(ce);
 }
 
 static void sun5i_clkevt_time_setup(struct sun5i_timer *ce, u8 timer, u32 delay)
 {
-	writel(delay, ce->timer.base + TIMER_INTVAL_LO_REG(timer));
+	writel(delay, ce->base + TIMER_INTVAL_LO_REG(timer));
 }
 
 static void sun5i_clkevt_time_start(struct sun5i_timer *ce, u8 timer, bool periodic)
 {
-	u32 val = readl(ce->timer.base + TIMER_CTL_REG(timer));
+	u32 val = readl(ce->base + TIMER_CTL_REG(timer));
 
 	if (periodic)
 		val &= ~TIMER_CTL_ONESHOT;
@@ -93,7 +88,7 @@ static void sun5i_clkevt_time_start(struct sun5i_timer *ce, u8 timer, bool perio
 		val |= TIMER_CTL_ONESHOT;
 
 	writel(val | TIMER_CTL_ENABLE | TIMER_CTL_RELOAD,
-	       ce->timer.base + TIMER_CTL_REG(timer));
+	       ce->base + TIMER_CTL_REG(timer));
 }
 
 static int sun5i_clkevt_shutdown(struct clock_event_device *clkevt)
@@ -118,7 +113,7 @@ static int sun5i_clkevt_set_periodic(struct clock_event_device *clkevt)
 	struct sun5i_timer *ce = clkevt_to_sun5i_timer(clkevt);
 
 	sun5i_clkevt_time_stop(ce, 0);
-	sun5i_clkevt_time_setup(ce, 0, ce->timer.ticks_per_jiffy);
+	sun5i_clkevt_time_setup(ce, 0, ce->ticks_per_jiffy);
 	sun5i_clkevt_time_start(ce, 0, true);
 	return 0;
 }
@@ -139,7 +134,7 @@ static irqreturn_t sun5i_timer_interrupt(int irq, void *dev_id)
 {
 	struct sun5i_timer *ce = dev_id;
 
-	writel(0x1, ce->timer.base + TIMER_IRQ_ST_REG);
+	writel(0x1, ce->base + TIMER_IRQ_ST_REG);
 	ce->clkevt.event_handler(&ce->clkevt);
 
 	return IRQ_HANDLED;
@@ -149,7 +144,7 @@ static u64 sun5i_clksrc_read(struct clocksource *clksrc)
 {
 	struct sun5i_timer *cs = clksrc_to_sun5i_timer(clksrc);
 
-	return ~readl(cs->timer.base + TIMER_CNTVAL_LO_REG(1));
+	return ~readl(cs->base + TIMER_CNTVAL_LO_REG(1));
 }
 
 static int sun5i_rate_cb(struct notifier_block *nb,
@@ -166,7 +161,7 @@ static int sun5i_rate_cb(struct notifier_block *nb,
 	case POST_RATE_CHANGE:
 		clocksource_register_hz(&cs->clksrc, ndata->new_rate);
 		clockevents_update_freq(&cs->clkevt, ndata->new_rate);
-		cs->timer.ticks_per_jiffy = DIV_ROUND_UP(ndata->new_rate, HZ);
+		cs->ticks_per_jiffy = DIV_ROUND_UP(ndata->new_rate, HZ);
 		break;
 
 	default:
@@ -180,7 +175,7 @@ static int __init sun5i_setup_clocksource(struct device_node *node,
 					  struct sun5i_timer *cs,
 					  unsigned long rate)
 {
-	void __iomem *base = cs->timer.base;
+	void __iomem *base = cs->base;
 	int ret;
 
 	writel(~0, base + TIMER_INTVAL_LO_REG(1));
@@ -206,7 +201,7 @@ static int __init sun5i_setup_clockevent(struct device_node *node,
 					 struct sun5i_timer *ce,
 					 unsigned long rate, int irq)
 {
-	void __iomem *base = ce->timer.base;
+	void __iomem *base = ce->base;
 	int ret;
 	u32 val;
 
@@ -282,13 +277,13 @@ static int __init sun5i_timer_init(struct device_node *node)
 		goto err_disable_clk;
 	}
 
-	st->timer.base = timer_base;
-	st->timer.ticks_per_jiffy = DIV_ROUND_UP(rate, HZ);
-	st->timer.clk = clk;
-	st->timer.clk_rate_cb.notifier_call = sun5i_rate_cb;
-	st->timer.clk_rate_cb.next = NULL;
+	st->base = timer_base;
+	st->ticks_per_jiffy = DIV_ROUND_UP(rate, HZ);
+	st->clk = clk;
+	st->clk_rate_cb.notifier_call = sun5i_rate_cb;
+	st->clk_rate_cb.next = NULL;
 
-	ret = clk_notifier_register(clk, &st->timer.clk_rate_cb);
+	ret = clk_notifier_register(clk, &st->clk_rate_cb);
 	if (ret) {
 		pr_err("Unable to register clock notifier.\n");
 		goto err_disable_clk;
@@ -305,7 +300,7 @@ static int __init sun5i_timer_init(struct device_node *node)
 	return sun5i_setup_clockevent(node, st, rate, irq);
 
 err_remove_notifier:
-	clk_notifier_unregister(clk, &st->timer.clk_rate_cb);
+	clk_notifier_unregister(clk, &st->clk_rate_cb);
 err_disable_clk:
 	clk_disable_unprepare(clk);
 err_free:
-- 
2.41.0

