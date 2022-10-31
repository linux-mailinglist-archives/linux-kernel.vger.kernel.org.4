Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C1D613503
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 12:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbiJaL4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 07:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbiJaL41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 07:56:27 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 34635EE18;
        Mon, 31 Oct 2022 04:56:26 -0700 (PDT)
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id EE3818218;
        Mon, 31 Oct 2022 11:46:54 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Georgi Vlaev <g-vlaev@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Keerthy <j-keerthy@ti.com>,
        Ladislav Michl <ladis@linux-mips.org>,
        Nishanth Menon <nm@ti.com>, Suman Anna <s-anna@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH 1/3] clocksource/drivers/timer-ti-dm: Add lock for register access
Date:   Mon, 31 Oct 2022 13:56:11 +0200
Message-Id: <20221031115613.56229-2-tony@atomide.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221031115613.56229-1-tony@atomide.com>
References: <20221031115613.56229-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We currently have no locking for timer control register and we assume that
the consumer device using struct omap_dm_timer_ops takes care of locking
for the timer.

In order to prepare for adding irchip and clock provider support to start
removing the struct omap_dm_timer_ops custom API, let's add timer->lock
and use it for the timer control register. This is needed to protect the
control register access between the different kernel frameworks.

Not-Yet-Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/clocksource/timer-ti-dm.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -121,6 +121,7 @@ struct dmtimer {
 	int id;
 	int irq;
 	struct clk *fclk;
+	spinlock_t lock;		/* For shared register access */
 
 	void __iomem	*io_base;
 	int		irq_stat;	/* TISR/IRQSTATUS interrupt status */
@@ -633,6 +634,7 @@ static struct omap_dm_timer *omap_dm_timer_request_by_node(struct device_node *n
 static int omap_dm_timer_free(struct omap_dm_timer *cookie)
 {
 	struct dmtimer *timer;
+	unsigned long flags;
 	struct device *dev;
 	int rc;
 
@@ -649,7 +651,9 @@ static int omap_dm_timer_free(struct omap_dm_timer *cookie)
 		return rc;
 
 	/* Clear timer configuration */
+	spin_lock_irqsave(&timer->lock, flags);
 	dmtimer_write(timer, OMAP_TIMER_CTRL_REG, 0);
+	spin_unlock_irqrestore(&timer->lock, flags);
 
 	pm_runtime_put_sync(dev);
 
@@ -728,6 +732,7 @@ __u32 omap_dm_timer_modify_idlect_mask(__u32 inputmask)
 static int omap_dm_timer_start(struct omap_dm_timer *cookie)
 {
 	struct dmtimer *timer;
+	unsigned long flags;
 	struct device *dev;
 	int rc;
 	u32 l;
@@ -742,11 +747,13 @@ static int omap_dm_timer_start(struct omap_dm_timer *cookie)
 	if (rc)
 		return rc;
 
+	spin_lock_irqsave(&timer->lock, flags);
 	l = dmtimer_read(timer, OMAP_TIMER_CTRL_REG);
 	if (!(l & OMAP_TIMER_CTRL_ST)) {
 		l |= OMAP_TIMER_CTRL_ST;
 		dmtimer_write(timer, OMAP_TIMER_CTRL_REG, l);
 	}
+	spin_unlock_irqrestore(&timer->lock, flags);
 
 	return 0;
 }
@@ -754,6 +761,7 @@ static int omap_dm_timer_start(struct omap_dm_timer *cookie)
 static int omap_dm_timer_stop(struct omap_dm_timer *cookie)
 {
 	struct dmtimer *timer;
+	unsigned long flags;
 	struct device *dev;
 	unsigned long rate = 0;
 
@@ -766,7 +774,9 @@ static int omap_dm_timer_stop(struct omap_dm_timer *cookie)
 	if (!timer->omap1)
 		rate = clk_get_rate(timer->fclk);
 
+	spin_lock_irqsave(&timer->lock, flags);
 	__omap_dm_timer_stop(timer, rate);
+	spin_unlock_irqrestore(&timer->lock, flags);
 
 	pm_runtime_put_sync(dev);
 
@@ -800,6 +810,7 @@ static int omap_dm_timer_set_match(struct omap_dm_timer *cookie, int enable,
 				   unsigned int match)
 {
 	struct dmtimer *timer;
+	unsigned long flags;
 	struct device *dev;
 	int rc;
 	u32 l;
@@ -813,6 +824,7 @@ static int omap_dm_timer_set_match(struct omap_dm_timer *cookie, int enable,
 	if (rc)
 		return rc;
 
+	spin_lock_irqsave(&timer->lock, flags);
 	l = dmtimer_read(timer, OMAP_TIMER_CTRL_REG);
 	if (enable)
 		l |= OMAP_TIMER_CTRL_CE;
@@ -820,6 +832,7 @@ static int omap_dm_timer_set_match(struct omap_dm_timer *cookie, int enable,
 		l &= ~OMAP_TIMER_CTRL_CE;
 	dmtimer_write(timer, OMAP_TIMER_MATCH_REG, match);
 	dmtimer_write(timer, OMAP_TIMER_CTRL_REG, l);
+	spin_unlock_irqrestore(&timer->lock, flags);
 
 	pm_runtime_put_sync(dev);
 
@@ -830,6 +843,7 @@ static int omap_dm_timer_set_pwm(struct omap_dm_timer *cookie, int def_on,
 				 int toggle, int trigger, int autoreload)
 {
 	struct dmtimer *timer;
+	unsigned long flags;
 	struct device *dev;
 	int rc;
 	u32 l;
@@ -843,6 +857,7 @@ static int omap_dm_timer_set_pwm(struct omap_dm_timer *cookie, int def_on,
 	if (rc)
 		return rc;
 
+	spin_lock_irqsave(&timer->lock, flags);
 	l = dmtimer_read(timer, OMAP_TIMER_CTRL_REG);
 	l &= ~(OMAP_TIMER_CTRL_GPOCFG | OMAP_TIMER_CTRL_SCPWM |
 	       OMAP_TIMER_CTRL_PT | (0x03 << 10) | OMAP_TIMER_CTRL_AR);
@@ -854,6 +869,7 @@ static int omap_dm_timer_set_pwm(struct omap_dm_timer *cookie, int def_on,
 	if (autoreload)
 		l |= OMAP_TIMER_CTRL_AR;
 	dmtimer_write(timer, OMAP_TIMER_CTRL_REG, l);
+	spin_unlock_irqrestore(&timer->lock, flags);
 
 	pm_runtime_put_sync(dev);
 
@@ -887,6 +903,7 @@ static int omap_dm_timer_set_prescaler(struct omap_dm_timer *cookie,
 				       int prescaler)
 {
 	struct dmtimer *timer;
+	unsigned long flags;
 	struct device *dev;
 	int rc;
 	u32 l;
@@ -900,6 +917,7 @@ static int omap_dm_timer_set_prescaler(struct omap_dm_timer *cookie,
 	if (rc)
 		return rc;
 
+	spin_lock_irqsave(&timer->lock, flags);
 	l = dmtimer_read(timer, OMAP_TIMER_CTRL_REG);
 	l &= ~(OMAP_TIMER_CTRL_PRE | (0x07 << 2));
 	if (prescaler >= 0) {
@@ -907,6 +925,7 @@ static int omap_dm_timer_set_prescaler(struct omap_dm_timer *cookie,
 		l |= prescaler << 2;
 	}
 	dmtimer_write(timer, OMAP_TIMER_CTRL_REG, l);
+	spin_unlock_irqrestore(&timer->lock, flags);
 
 	pm_runtime_put_sync(dev);
 
@@ -1093,6 +1112,8 @@ static int omap_dm_timer_probe(struct platform_device *pdev)
 	if (!timer)
 		return  -ENOMEM;
 
+	spin_lock_init(&timer->lock);
+
 	timer->irq = platform_get_irq(pdev, 0);
 	if (timer->irq < 0)
 		return timer->irq;
-- 
2.37.3
