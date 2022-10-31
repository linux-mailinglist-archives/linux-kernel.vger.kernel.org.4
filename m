Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5DCD613504
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 12:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbiJaL4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 07:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbiJaL4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 07:56:30 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E0771EE06;
        Mon, 31 Oct 2022 04:56:29 -0700 (PDT)
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 9195780CD;
        Mon, 31 Oct 2022 11:46:58 +0000 (UTC)
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
Subject: [RFC PATCH 2/3] clocksource/drivers/timer-ti-dm: Implement chained irq
Date:   Mon, 31 Oct 2022 13:56:12 +0200
Message-Id: <20221031115613.56229-3-tony@atomide.com>
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

The timer has input capture support that can be used for PWM capture. And
some drivers, like remoteproc, already use hardware timers directly as
described in commit e28edc571925 ("remoteproc/omap: Request a timer(s) for
remoteproc usage"). We can simplify the the use of some hardware timer
features for PWM and remoteproc with chained irq.

This allows us to eventually deprecate the following functions exposed
by struct omap_dm_timer_ops:

get_irq()
set_int_enable()
set_int_disable(),
read_status()
write_status()

The functions above can be dropped after omap_remoteproc has been updated
to request a timer irq. For PWM, set_match() is still needed for input
capture.

Not-Yet-Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/clocksource/timer-ti-dm.c | 255 +++++++++++++++++++++++++++++-
 drivers/pwm/pwm-omap-dmtimer.c    |   1 +
 2 files changed, 248 insertions(+), 8 deletions(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -22,6 +22,8 @@
 #include <linux/clk-provider.h>
 #include <linux/cpu_pm.h>
 #include <linux/module.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
 #include <linux/io.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -29,6 +31,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/irqchip/chained_irq.h>
 #include <linux/platform_data/dmtimer-omap.h>
 
 #include <clocksource/timer-ti-dm.h>
@@ -46,6 +49,7 @@
 /* posted mode types */
 #define OMAP_TIMER_NONPOSTED			0x00
 #define OMAP_TIMER_POSTED			0x01
+#define OMAP_DM_TIMER_NR_IRQS			3	/* Capture, overflow, match */
 
 /* register offsets with the write pending bit encoded */
 #define	WPSHIFT					16
@@ -142,6 +146,8 @@ struct dmtimer {
 	struct platform_device *pdev;
 	struct list_head node;
 	struct notifier_block nb;
+	struct irq_chip chip;
+	struct irq_domain *domain;
 };
 
 static u32 omap_reserved_systimers;
@@ -286,6 +292,232 @@ static inline void __omap_dm_timer_int_enable(struct dmtimer *timer,
 	dmtimer_write(timer, OMAP_TIMER_WAKEUP_EN_REG, value);
 }
 
+static inline void __omap_dm_timer_int_disable(struct dmtimer *timer,
+					       unsigned int mask)
+{
+	u32 l = mask;
+
+	if (timer->revision == 1)
+		l = dmtimer_read(timer, timer->irq_ena) & ~mask;
+
+	dmtimer_write(timer, timer->irq_dis, l);
+	l = dmtimer_read(timer, OMAP_TIMER_WAKEUP_EN_REG) & ~mask;
+	dmtimer_write(timer, OMAP_TIMER_WAKEUP_EN_REG, l);
+}
+
+/*
+ * Chained interrupt support for input pin event capture for PWM.
+ */
+static void dmtimer_chain_handler(struct irq_desc *desc)
+{
+	struct dmtimer *timer = irq_desc_get_handler_data(desc);
+	struct irq_chip *chip;
+	unsigned int bit;
+	unsigned long l;
+
+	chip = irq_desc_get_chip(desc);
+	chained_irq_enter(chip, desc);
+	l = dmtimer_read(timer, timer->irq_stat);
+
+	for_each_set_bit(bit, &l, OMAP_DM_TIMER_NR_IRQS)
+		generic_handle_domain_irq(timer->domain, bit);
+
+	chained_irq_exit(chip, desc);
+}
+
+static struct lock_class_key dmtimer_lock_class;
+static struct lock_class_key dmtimer_request_class;
+
+static int dmtimer_irqdomain_map(struct irq_domain *d, unsigned int irq,
+				 irq_hw_number_t hwirq)
+{
+	struct dmtimer *timer = d->host_data;
+
+	irq_set_chip_data(irq, timer);
+	irq_set_chip_and_handler(irq, &timer->chip,
+				 handle_level_irq);
+	irq_set_lockdep_class(irq, &dmtimer_lock_class,
+			      &dmtimer_request_class);
+	irq_set_noprobe(irq);
+
+	return 0;
+}
+
+static const struct irq_domain_ops dmtimer_irqdomain_ops = {
+	.map = dmtimer_irqdomain_map,
+	.xlate = irq_domain_xlate_twocell,
+};
+
+static void dmtimer_irq_mask(struct irq_data *d);
+static void dmtimer_irq_unmask(struct irq_data *d);
+
+static unsigned int dmtimer_irq_startup(struct irq_data *d)
+{
+	struct dmtimer *timer = irq_data_get_irq_chip_data(d);
+	unsigned long flags;
+	u32 l, val;
+
+	switch (BIT(d->hwirq)) {
+	case OMAP_TIMER_INT_CAPTURE:
+		val = OMAP_TIMER_CTRL_GPOCFG;
+		break;
+	case OMAP_TIMER_INT_OVERFLOW:
+		goto unmask;
+	case OMAP_TIMER_INT_MATCH:
+		val = OMAP_TIMER_CTRL_CE;
+		break;
+	default:
+		return 0;
+	}
+
+	spin_lock_irqsave(&timer->lock, flags);
+	l = dmtimer_read(timer, OMAP_TIMER_CTRL_REG);
+	l |= val;
+	dmtimer_write(timer, OMAP_TIMER_CTRL_REG, l);
+	spin_unlock_irqrestore(&timer->lock, flags);
+
+unmask:
+	dmtimer_irq_unmask(d);
+
+	return 0;
+}
+
+static void dmtimer_irq_shutdown(struct irq_data *d)
+{
+	struct dmtimer *timer = irq_data_get_irq_chip_data(d);
+	unsigned long flags;
+	u32 l, val;
+
+	switch (BIT(d->hwirq)) {
+	case OMAP_TIMER_INT_CAPTURE:
+		val = OMAP_TIMER_CTRL_GPOCFG;
+		break;
+	case OMAP_TIMER_INT_OVERFLOW:
+		goto mask;
+	case OMAP_TIMER_INT_MATCH:
+		val = OMAP_TIMER_CTRL_CE;
+		break;
+	default:
+		return;
+	}
+
+	spin_lock_irqsave(&timer->lock, flags);
+	l = dmtimer_read(timer, OMAP_TIMER_CTRL_REG);
+	l &= ~val;
+	dmtimer_write(timer, OMAP_TIMER_CTRL_REG, l);
+	spin_unlock_irqrestore(&timer->lock, flags);
+
+mask:
+	dmtimer_irq_mask(d);
+}
+
+static void dmtimer_irq_mask(struct irq_data *d)
+{
+	struct dmtimer *timer = irq_data_get_irq_chip_data(d);
+	u32 mask = BIT(d->hwirq);
+
+	__omap_dm_timer_int_disable(timer, mask);
+}
+
+static void dmtimer_irq_unmask(struct irq_data *d)
+{
+	struct dmtimer *timer = irq_data_get_irq_chip_data(d);
+	u32 mask = BIT(d->hwirq);
+
+	__omap_dm_timer_int_enable(timer, mask);
+}
+
+static void dmtimer_irq_ack(struct irq_data *d)
+{
+	struct dmtimer *timer = irq_data_get_irq_chip_data(d);
+
+	dmtimer_write(timer, timer->irq_stat, BIT(d->hwirq));
+}
+
+static void dmtimer_irq_mask_ack(struct irq_data *d)
+{
+	struct dmtimer *timer = irq_data_get_irq_chip_data(d);
+	u32 mask = BIT(d->hwirq);
+
+	__omap_dm_timer_int_disable(timer, mask);
+	dmtimer_write(timer, timer->irq_stat, mask);
+}
+
+static int dmtimer_irq_set_type(struct irq_data *d, unsigned int type)
+{
+	struct dmtimer *timer = irq_data_get_irq_chip_data(d);
+	unsigned long flags;
+	u32 l;
+
+	/* TIMER_TCLR register TCM bits match IRQ_TYPE values for edge */
+	switch (type) {
+	case IRQ_TYPE_NONE:
+	case IRQ_TYPE_EDGE_RISING:
+	case IRQ_TYPE_EDGE_FALLING:
+	case IRQ_TYPE_EDGE_BOTH:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* Configure TCLR register TCM bits */
+	spin_lock_irqsave(&timer->lock, flags);
+	l = dmtimer_read(timer, OMAP_TIMER_CTRL_REG);
+	l &= ~(3 << 8);
+	l |= (type << 8);
+	dmtimer_write(timer, OMAP_TIMER_CTRL_REG, l);
+	spin_unlock_irqrestore(&timer->lock, flags);
+
+	return 0;
+}
+
+static int dmtimer_irq_set_wake(struct irq_data *d, unsigned int state)
+{
+	if (state)
+		dmtimer_irq_unmask(d);
+	else
+		dmtimer_irq_mask(d);
+
+	return 0;
+}
+
+static int dmtimer_register_irqchip(struct dmtimer *timer)
+{
+	struct device *dev = &timer->pdev->dev;
+	struct device_node *np = dev->of_node;
+
+	/* Can be removed if omap1 starts using timer-ti-dm-systimer */
+	if (timer->omap1)
+		return 0;
+
+	timer->chip.name = dev->driver->name;
+	timer->chip.irq_startup = dmtimer_irq_startup;
+	timer->chip.irq_shutdown = dmtimer_irq_shutdown;
+	timer->chip.irq_mask = dmtimer_irq_mask;
+	timer->chip.irq_unmask = dmtimer_irq_unmask;
+	timer->chip.irq_ack = dmtimer_irq_ack;
+	timer->chip.irq_mask_ack = dmtimer_irq_mask_ack;
+	timer->chip.irq_set_type = dmtimer_irq_set_type;
+	timer->chip.irq_set_wake = dmtimer_irq_set_wake;
+
+	irq_set_chained_handler_and_data(timer->irq,
+					 dmtimer_chain_handler,
+					 timer);
+
+	timer->domain = irq_domain_add_simple(np, OMAP_DM_TIMER_NR_IRQS, 0,
+					      &dmtimer_irqdomain_ops,
+					      timer);
+	if (!timer->domain) {
+		irq_set_chained_handler(timer->irq, NULL);
+		return -EINVAL;
+	}
+
+	/* Initialize dev for runtime PM, see irq_chip_pm_get() */
+	timer->domain->dev = dev;
+
+	return 0;
+}
+
 static inline unsigned int
 __omap_dm_timer_read_counter(struct dmtimer *timer)
 {
@@ -966,7 +1198,6 @@ static int omap_dm_timer_set_int_disable(struct omap_dm_timer *cookie, u32 mask)
 {
 	struct dmtimer *timer;
 	struct device *dev;
-	u32 l = mask;
 	int rc;
 
 	timer = to_dmtimer(cookie);
@@ -978,12 +1209,7 @@ static int omap_dm_timer_set_int_disable(struct omap_dm_timer *cookie, u32 mask)
 	if (rc)
 		return rc;
 
-	if (timer->revision == 1)
-		l = dmtimer_read(timer, timer->irq_ena) & ~mask;
-
-	dmtimer_write(timer, timer->irq_dis, l);
-	l = dmtimer_read(timer, OMAP_TIMER_WAKEUP_EN_REG) & ~mask;
-	dmtimer_write(timer, OMAP_TIMER_WAKEUP_EN_REG, l);
+	__omap_dm_timer_int_disable(timer, mask);
 
 	pm_runtime_put_sync(dev);
 
@@ -1173,6 +1399,12 @@ static int omap_dm_timer_probe(struct platform_device *pdev)
 		/* Clear timer configuration */
 		dmtimer_write(timer, OMAP_TIMER_CTRL_REG, 0);
 
+		ret = dmtimer_register_irqchip(timer);
+		if (ret) {
+			dev_err(dev, "irqchip register failed: %i\n", ret);
+			goto err_put;
+		}
+
 		pm_runtime_put(dev);
 	}
 
@@ -1185,6 +1417,8 @@ static int omap_dm_timer_probe(struct platform_device *pdev)
 
 	return 0;
 
+err_put:
+	pm_runtime_put(dev);
 err_disable:
 	pm_runtime_disable(dev);
 	return ret;
@@ -1205,15 +1439,20 @@ static int omap_dm_timer_remove(struct platform_device *pdev)
 	int ret = -EINVAL;
 
 	spin_lock_irqsave(&dm_timer_lock, flags);
-	list_for_each_entry(timer, &omap_timer_list, node)
+	list_for_each_entry(timer, &omap_timer_list, node) {
 		if (!strcmp(dev_name(&timer->pdev->dev),
 			    dev_name(&pdev->dev))) {
+			if (timer->domain) {
+				irq_domain_remove(timer->domain);
+				irq_set_chained_handler(timer->irq, NULL);
+			}
 			if (!(timer->capability & OMAP_TIMER_ALWON))
 				cpu_pm_unregister_notifier(&timer->nb);
 			list_del(&timer->node);
 			ret = 0;
 			break;
 		}
+	}
 	spin_unlock_irqrestore(&dm_timer_lock, flags);
 
 	pm_runtime_disable(&pdev->dev);
diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
--- a/drivers/pwm/pwm-omap-dmtimer.c
+++ b/drivers/pwm/pwm-omap-dmtimer.c
@@ -35,6 +35,7 @@
 
 #include <linux/clk.h>
 #include <linux/err.h>
+#include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
-- 
2.37.3
