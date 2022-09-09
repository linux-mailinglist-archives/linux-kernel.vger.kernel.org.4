Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995355B3B40
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 16:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbiIIO4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 10:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbiIIOz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 10:55:58 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C45EE535;
        Fri,  9 Sep 2022 07:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662735355; x=1694271355;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SdpU6mAf+kWQ7mR1E+usWSEMfcH0CftSR9IvezNKSVQ=;
  b=RkqyqU7EDriYoOK+cZFTNKYUd+ViyiW6hQ6oR5L/sqZvaP+vxlBrhN/g
   uUQpibf/Em3JN9TNdt17F2BV0O45H6bhBYY34KAHiK0wS/5fX03nLXpx5
   GJuNAPQ8ozu0KFi+rnmJDJVaxjvLv2NxDWH243a1V3xCHt7afi/eywzFr
   +0lcVwSTUD9RkqNMTINk1ZT4e3BTZA9AbZJ5eLfH6pF5IMvvDamya8d0J
   z/Q38B9x/b+gXDgF92yZSC6MoUDfiJisZ3KXk4XuZgHO0A7t5UwJyh/CV
   AMtt2wRi4DYgh8+jBTQDZyyuieIJo3XR0aTDpdgLaSsF9NgauctNPz7WR
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="176423081"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Sep 2022 07:55:53 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 9 Sep 2022 07:55:53 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Fri, 9 Sep 2022 07:55:52 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <linus.walleij@linaro.org>, <andy.shevchenko@gmail.com>,
        <UNGLinuxDriver@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH v3] pinctrl: ocelot: Fix interrupt controller
Date:   Fri, 9 Sep 2022 16:59:42 +0200
Message-ID: <20220909145942.844102-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When an external device generated a level based interrupt then the
interrupt controller could miss the interrupt. The reason is that the
interrupt controller can detect only link changes.

In the following example, if there is a PHY that generates an interrupt
then the following would happen. The GPIO detected that the interrupt
line changed, and then the 'ocelot_irq_handler' was called. Here it
detects which GPIO line saw the change and for that will call the
following:
1. irq_mask
2. phy interrupt routine
3. irq_eoi
4. irq_unmask

And this works fine for simple cases, but if the PHY generates many
interrupts, for example when doing PTP timestamping, then the following
could happen. Again the function 'ocelot_irq_handler' will be called
and then from here the following could happen:
1. irq_mask
2. phy interrupt routine
3. irq_eoi
4. irq_unmask

Right before step 3(irq_eoi), the PHY will generate another interrupt.
Now the interrupt controller will acknowledge the change in the
interrupt line. So we miss the interrupt.

A solution will be to use 'handle_level_irq' instead of
'handle_fasteoi_irq', because for this will change routine order of
handling the interrupt.
1. irq_mask
2. irq_ack
3. phy interrupt routine
4. irq_unmask

And now if the PHY will generate a new interrupt before irq_unmask, the
interrupt controller will detect this because it already acknowledge the
change in interrupt line at step 2(irq_ack).

But this is not the full solution because there is another issue. In
case there are 2 PHYs that share the interrupt line. For example phy1
generates an interrupt, then the following can happen:
1.irq_mask
2.irq_ack
3.phy0 interrupt routine
4.phy1 interrupt routine
5.irq_unmask

In case phy0 will generate an interrupt while clearing the interrupt
source in phy1, then the interrupt line will be kept down by phy0. So
the interrupt controller will not see any changes in the interrupt line.
The solution here is to update 'irq_unmask' such that it can detect if
the interrupt line is still active or not. And if it is active then call
again the procedure to clear the interrupts. But we don't want to do it
every time, only if we know that the interrupt controller has not seen
already that the interrupt line has changed.

While at this, add support also for IRQ_TYPE_LEVEL_LOW.

Fixes: be36abb71d878f ("pinctrl: ocelot: add support for interrupt controller")
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
v2->v3:
- fix more grammer mistakes
- use temporary variable for BIT(gpio % 32)
- use own workqueue to queue work, such when the driver is removed all
  the pending work is done
v1->v2:
- fix grammer mistakes
- remove redundant checks for type in ocelot_irq_set_type
- split assignment and declaration of work variable
- use irqd_get_trigger_type instead of getting trigger from action
---
 drivers/pinctrl/pinctrl-ocelot.c | 111 +++++++++++++++++++++++++++----
 1 file changed, 97 insertions(+), 14 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-ocelot.c b/drivers/pinctrl/pinctrl-ocelot.c
index c5fd154990c8..c7df8c5fe585 100644
--- a/drivers/pinctrl/pinctrl-ocelot.c
+++ b/drivers/pinctrl/pinctrl-ocelot.c
@@ -331,6 +331,7 @@ struct ocelot_pinctrl {
 	const struct ocelot_pincfg_data *pincfg_data;
 	struct ocelot_pmx_func func[FUNC_MAX];
 	u8 stride;
+	struct workqueue_struct *wq;
 };
 
 struct ocelot_match_data {
@@ -338,6 +339,11 @@ struct ocelot_match_data {
 	struct ocelot_pincfg_data pincfg_data;
 };
 
+struct ocelot_irq_work {
+	struct work_struct irq_work;
+	struct irq_desc *irq_desc;
+};
+
 #define LUTON_P(p, f0, f1)						\
 static struct ocelot_pin_caps luton_pin_##p = {				\
 	.pin = p,							\
@@ -1813,6 +1819,75 @@ static void ocelot_irq_mask(struct irq_data *data)
 	gpiochip_disable_irq(chip, gpio);
 }
 
+static void ocelot_irq_work(struct work_struct *work)
+{
+	struct ocelot_irq_work *w = container_of(work, struct ocelot_irq_work, irq_work);
+	struct irq_chip *parent_chip = irq_desc_get_chip(w->irq_desc);
+	struct gpio_chip *chip = irq_desc_get_chip_data(w->irq_desc);
+	struct irq_data *data = irq_desc_get_irq_data(w->irq_desc);
+	unsigned int gpio = irqd_to_hwirq(data);
+
+	local_irq_disable();
+	chained_irq_enter(parent_chip, w->irq_desc);
+	generic_handle_domain_irq(chip->irq.domain, gpio);
+	chained_irq_exit(parent_chip, w->irq_desc);
+	local_irq_enable();
+
+	kfree(w);
+}
+
+static void ocelot_irq_unmask_level(struct irq_data *data)
+{
+	struct gpio_chip *chip = irq_data_get_irq_chip_data(data);
+	struct ocelot_pinctrl *info = gpiochip_get_data(chip);
+	struct irq_desc *desc = irq_data_to_desc(data);
+	unsigned int gpio = irqd_to_hwirq(data);
+	unsigned int bit = BIT(gpio % 32);
+	bool ack = false, active = false;
+	u8 trigger_level;
+	int val;
+
+	trigger_level = irqd_get_trigger_type(data);
+
+	/* Check if the interrupt line is still active. */
+	regmap_read(info->map, REG(OCELOT_GPIO_IN, info, gpio), &val);
+	if ((!(val & bit) && trigger_level == IRQ_TYPE_LEVEL_LOW) ||
+	      (val & bit && trigger_level == IRQ_TYPE_LEVEL_HIGH))
+		active = true;
+
+	/*
+	 * Check if the interrupt controller has seen any changes in the
+	 * interrupt line.
+	 */
+	regmap_read(info->map, REG(OCELOT_GPIO_INTR, info, gpio), &val);
+	if (val & bit)
+		ack = true;
+
+	/* Enable the interrupt now */
+	gpiochip_enable_irq(chip, gpio);
+	regmap_update_bits(info->map, REG(OCELOT_GPIO_INTR_ENA, info, gpio),
+			   bit, bit);
+
+	/*
+	 * In case the interrupt line is still active and the interrupt
+	 * controller has not seen any changes in the interrupt line, then it
+	 * means that there happen another interrupt while the line was active.
+	 * So we missed that one, so we need to kick the interrupt again
+	 * handler.
+	 */
+	if (active && !ack) {
+		struct ocelot_irq_work *work;
+
+		work = kmalloc(sizeof(*work), GFP_ATOMIC);
+		if (!work)
+			return;
+
+		work->irq_desc = desc;
+		INIT_WORK(&work->irq_work, ocelot_irq_work);
+		queue_work(info->wq, &work->irq_work);
+	}
+}
+
 static void ocelot_irq_unmask(struct irq_data *data)
 {
 	struct gpio_chip *chip = irq_data_get_irq_chip_data(data);
@@ -1836,13 +1911,12 @@ static void ocelot_irq_ack(struct irq_data *data)
 
 static int ocelot_irq_set_type(struct irq_data *data, unsigned int type);
 
-static struct irq_chip ocelot_eoi_irqchip = {
+static struct irq_chip ocelot_level_irqchip = {
 	.name		= "gpio",
 	.irq_mask	= ocelot_irq_mask,
-	.irq_eoi	= ocelot_irq_ack,
-	.irq_unmask	= ocelot_irq_unmask,
-	.flags          = IRQCHIP_EOI_THREADED | IRQCHIP_EOI_IF_HANDLED |
-			  IRQCHIP_IMMUTABLE,
+	.irq_ack	= ocelot_irq_ack,
+	.irq_unmask	= ocelot_irq_unmask_level,
+	.flags		= IRQCHIP_IMMUTABLE,
 	.irq_set_type	= ocelot_irq_set_type,
 	GPIOCHIP_IRQ_RESOURCE_HELPERS
 };
@@ -1859,14 +1933,9 @@ static struct irq_chip ocelot_irqchip = {
 
 static int ocelot_irq_set_type(struct irq_data *data, unsigned int type)
 {
-	type &= IRQ_TYPE_SENSE_MASK;
-
-	if (!(type & (IRQ_TYPE_EDGE_BOTH | IRQ_TYPE_LEVEL_HIGH)))
-		return -EINVAL;
-
-	if (type & IRQ_TYPE_LEVEL_HIGH)
-		irq_set_chip_handler_name_locked(data, &ocelot_eoi_irqchip,
-						 handle_fasteoi_irq, NULL);
+	if (type & (IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW))
+		irq_set_chip_handler_name_locked(data, &ocelot_level_irqchip,
+						 handle_level_irq, NULL);
 	if (type & IRQ_TYPE_EDGE_BOTH)
 		irq_set_chip_handler_name_locked(data, &ocelot_irqchip,
 						 handle_edge_irq, NULL);
@@ -1996,6 +2065,10 @@ static int ocelot_pinctrl_probe(struct platform_device *pdev)
 	if (!info->desc)
 		return -ENOMEM;
 
+	info->wq = alloc_ordered_workqueue("ocelot_ordered", 0);
+	if (!info->wq)
+		return -ENOMEM;
+
 	info->pincfg_data = &data->pincfg_data;
 
 	reset = devm_reset_control_get_optional_shared(dev, "switch");
@@ -2018,7 +2091,7 @@ static int ocelot_pinctrl_probe(struct platform_device *pdev)
 		dev_err(dev, "Failed to create regmap\n");
 		return PTR_ERR(info->map);
 	}
-	dev_set_drvdata(dev, info->map);
+	dev_set_drvdata(dev, info);
 	info->dev = dev;
 
 	/* Pinconf registers */
@@ -2043,6 +2116,15 @@ static int ocelot_pinctrl_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static int ocelot_pinctrl_remove(struct platform_device *pdev)
+{
+	struct ocelot_pinctrl *info = platform_get_drvdata(pdev);
+
+	destroy_workqueue(info->wq);
+
+	return 0;
+}
+
 static struct platform_driver ocelot_pinctrl_driver = {
 	.driver = {
 		.name = "pinctrl-ocelot",
@@ -2050,6 +2132,7 @@ static struct platform_driver ocelot_pinctrl_driver = {
 		.suppress_bind_attrs = true,
 	},
 	.probe = ocelot_pinctrl_probe,
+	.remove = ocelot_pinctrl_remove,
 };
 module_platform_driver(ocelot_pinctrl_driver);
 MODULE_LICENSE("Dual MIT/GPL");
-- 
2.33.0

