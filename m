Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 127745F557A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 15:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbiJENd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 09:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbiJENdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 09:33:24 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BABEE7A528;
        Wed,  5 Oct 2022 06:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664976803; x=1696512803;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XqQdBjp19mIbx44Ty96ErCKDz0PF5lNUbgCFtZpOCOU=;
  b=RrTLNx43VFU/wXmB3NdOaU47f7zHJpt7HSmfLAMGDUoljJcoKYDx/wg/
   wymtS3CUAFx4QU7sauzkk05DKRzBD2KvJImmJVExILifZmE5ByzOS9SeD
   Lk/yZBLtbjqvRChUlvKE4A0rixGL5qYIpLxoYr5mLMARbMSZ5+W8TNR7m
   J6nrSURJ7BtuUTwpo4kiBCl8Df438ZbGKlU0wQzXI7twm9pmjKbd3xNr1
   k5QgJILoIWvgVE6yl8DdT+jjA/QTzbLOf+1RW7Z33XsJeHl77mBFBOaGT
   VKs30wQ3Fg8/Rnr/6DbOncMNhaO+ZOVOY2KJrYeqG5VRZy6QrvSEtUJxo
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="282870577"
X-IronPort-AV: E=Sophos;i="5.95,159,1661842800"; 
   d="scan'208";a="282870577"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 06:33:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="602010546"
X-IronPort-AV: E=Sophos;i="5.95,159,1661842800"; 
   d="scan'208";a="602010546"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 05 Oct 2022 06:33:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 23A9717E; Wed,  5 Oct 2022 16:33:39 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH v1 1/1] pinctrl: actions: make irq_chip immutable
Date:   Wed,  5 Oct 2022 16:33:37 +0300
Message-Id: <20221005133337.19245-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since recently, the kernel is nagging about mutable irq_chips:

   "not an immutable chip, please consider fixing it!"

Drop the unneeded copy, flag it as IRQCHIP_IMMUTABLE, add the new
helper functions and call the appropriate gpiolib functions.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/actions/pinctrl-owl.c | 39 ++++++++++++++++-----------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/drivers/pinctrl/actions/pinctrl-owl.c b/drivers/pinctrl/actions/pinctrl-owl.c
index ed46abc15d72..0898d178f4e5 100644
--- a/drivers/pinctrl/actions/pinctrl-owl.c
+++ b/drivers/pinctrl/actions/pinctrl-owl.c
@@ -38,7 +38,6 @@
  * @clk: clock control
  * @soc: reference to soc_data
  * @base: pinctrl register base address
- * @irq_chip: IRQ chip information
  * @num_irq: number of possible interrupts
  * @irq: interrupt numbers
  */
@@ -50,7 +49,6 @@ struct owl_pinctrl {
 	struct clk *clk;
 	const struct owl_pinctrl_soc_data *soc;
 	void __iomem *base;
-	struct irq_chip irq_chip;
 	unsigned int num_irq;
 	unsigned int *irq;
 };
@@ -722,10 +720,11 @@ static void owl_gpio_irq_mask(struct irq_data *data)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(data);
 	struct owl_pinctrl *pctrl = gpiochip_get_data(gc);
+	irq_hw_number_t hwirq = irqd_to_hwirq(data);
 	const struct owl_gpio_port *port;
+	unsigned int gpio = hwirq;
 	void __iomem *gpio_base;
 	unsigned long flags;
-	unsigned int gpio = data->hwirq;
 	u32 val;
 
 	port = owl_gpio_get_port(pctrl, &gpio);
@@ -745,22 +744,27 @@ static void owl_gpio_irq_mask(struct irq_data *data)
 					OWL_GPIO_CTLR_ENABLE + port->shared_ctl_offset * 5, false);
 
 	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
+
+	gpiochip_disable_irq(gc, hwirq);
 }
 
 static void owl_gpio_irq_unmask(struct irq_data *data)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(data);
 	struct owl_pinctrl *pctrl = gpiochip_get_data(gc);
+	irq_hw_number_t hwirq = irqd_to_hwirq(data);
 	const struct owl_gpio_port *port;
+	unsigned int gpio = hwirq;
 	void __iomem *gpio_base;
 	unsigned long flags;
-	unsigned int gpio = data->hwirq;
 	u32 value;
 
 	port = owl_gpio_get_port(pctrl, &gpio);
 	if (WARN_ON(port == NULL))
 		return;
 
+	gpiochip_enable_irq(gc, hwirq);
+
 	gpio_base = pctrl->base + port->offset;
 	raw_spin_lock_irqsave(&pctrl->lock, flags);
 
@@ -780,20 +784,21 @@ static void owl_gpio_irq_ack(struct irq_data *data)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(data);
 	struct owl_pinctrl *pctrl = gpiochip_get_data(gc);
+	irq_hw_number_t hwirq = irqd_to_hwirq(data);
 	const struct owl_gpio_port *port;
+	unsigned int gpio = hwirq;
 	void __iomem *gpio_base;
 	unsigned long flags;
-	unsigned int gpio = data->hwirq;
 
 	/*
 	 * Switch the interrupt edge to the opposite edge of the interrupt
 	 * which got triggered for the case of emulating both edges
 	 */
 	if (irqd_get_trigger_type(data) == IRQ_TYPE_EDGE_BOTH) {
-		if (owl_gpio_get(gc, gpio))
-			irq_set_type(pctrl, gpio, IRQ_TYPE_EDGE_FALLING);
+		if (owl_gpio_get(gc, hwirq))
+			irq_set_type(pctrl, hwirq, IRQ_TYPE_EDGE_FALLING);
 		else
-			irq_set_type(pctrl, gpio, IRQ_TYPE_EDGE_RISING);
+			irq_set_type(pctrl, hwirq, IRQ_TYPE_EDGE_RISING);
 	}
 
 	port = owl_gpio_get_port(pctrl, &gpio);
@@ -825,6 +830,16 @@ static int owl_gpio_irq_set_type(struct irq_data *data, unsigned int type)
 	return 0;
 }
 
+static const struct irq_chip owl_gpio_irqchip = {
+	.name = "owl-irq",
+	.irq_ack = owl_gpio_irq_ack,
+	.irq_mask = owl_gpio_irq_mask,
+	.irq_unmask = owl_gpio_irq_unmask,
+	.irq_set_type = owl_gpio_irq_set_type,
+	.flags = IRQCHIP_IMMUTABLE,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
+};
+
 static void owl_gpio_irq_handler(struct irq_desc *desc)
 {
 	struct owl_pinctrl *pctrl = irq_desc_get_handler_data(desc);
@@ -875,14 +890,8 @@ static int owl_gpio_init(struct owl_pinctrl *pctrl)
 	chip->parent = pctrl->dev;
 	chip->owner = THIS_MODULE;
 
-	pctrl->irq_chip.name = chip->of_node->name;
-	pctrl->irq_chip.irq_ack = owl_gpio_irq_ack;
-	pctrl->irq_chip.irq_mask = owl_gpio_irq_mask;
-	pctrl->irq_chip.irq_unmask = owl_gpio_irq_unmask;
-	pctrl->irq_chip.irq_set_type = owl_gpio_irq_set_type;
-
 	gpio_irq = &chip->irq;
-	gpio_irq->chip = &pctrl->irq_chip;
+	gpio_irq_chip_set_chip(gpio_irq, &owl_gpio_irqchip);
 	gpio_irq->handler = handle_simple_irq;
 	gpio_irq->default_type = IRQ_TYPE_NONE;
 	gpio_irq->parent_handler = owl_gpio_irq_handler;
-- 
2.35.1

