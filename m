Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 411D266DAAE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 11:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236512AbjAQKOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 05:14:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235848AbjAQKOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 05:14:21 -0500
X-Greylist: delayed 320 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 17 Jan 2023 02:14:19 PST
Received: from forward106p.mail.yandex.net (forward106p.mail.yandex.net [77.88.28.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA7A2717;
        Tue, 17 Jan 2023 02:14:18 -0800 (PST)
Received: from sas1-71299a9d5a62.qloud-c.yandex.net (sas1-71299a9d5a62.qloud-c.yandex.net [IPv6:2a02:6b8:c08:210e:0:640:7129:9a9d])
        by forward106p.mail.yandex.net (Yandex) with ESMTP id 3C0EC2FC146B;
        Tue, 17 Jan 2023 13:08:59 +0300 (MSK)
Received: by sas1-71299a9d5a62.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id q8hUV81caqM1-gLFtdELT;
        Tue, 17 Jan 2023 13:08:58 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1673950138;
        bh=13oqyiL3oCSWyyK89szmL0p9HX+bAt5xjKGvK/84qyU=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=LZOORB60TvX8leSH04bEkqqZoLQYZP9RlXhfMywTLS5gfCPDkQGplKo9F5nM2nl6B
         jOVspOMvu7YqEPP6rSedWdTu94p1ANlnfyleDt9Dvysn0FKZkQUT341jLNDucxfpyj
         xeorTe+nRdsMZvT3z6ujBgPsvSh57Ox75B5nXcvQ=
Authentication-Results: sas1-71299a9d5a62.qloud-c.yandex.net; dkim=pass header.i=@maquefel.me
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     linux-gpio@vger.kernel.org
Cc:     Nikita Shubin <nikita.shubin@maquefel.me>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Lukasz Majewski <lukma@denx.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] gpio: ep93xx: Make irqchip immutable
Date:   Tue, 17 Jan 2023 13:08:44 +0300
Message-Id: <20230117100845.16708-2-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20230117100845.16708-1-nikita.shubin@maquefel.me>
References: <20230117100845.16708-1-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This turns the Cirrus ep93xx gpio irqchip immutable.

Preserve per-chip labels by adding an ->irq_print_chip() callback.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 drivers/gpio/gpio-ep93xx.c | 52 +++++++++++++++++++++++---------------
 1 file changed, 31 insertions(+), 21 deletions(-)

diff --git a/drivers/gpio/gpio-ep93xx.c b/drivers/gpio/gpio-ep93xx.c
index dff2ce050522..0f87dcd0e84c 100644
--- a/drivers/gpio/gpio-ep93xx.c
+++ b/drivers/gpio/gpio-ep93xx.c
@@ -17,9 +17,9 @@
 #include <linux/gpio/driver.h>
 #include <linux/bitops.h>
 #include <linux/interrupt.h>
+#include <linux/seq_file.h>
 
 struct ep93xx_gpio_irq_chip {
-	struct irq_chip ic;
 	void __iomem *base;
 	u8 int_unmasked;
 	u8 int_enabled;
@@ -139,7 +139,8 @@ static void ep93xx_gpio_irq_mask_ack(struct irq_data *d)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct ep93xx_gpio_irq_chip *eic = to_ep93xx_gpio_irq_chip(gc);
-	int port_mask = BIT(irqd_to_hwirq(d));
+	u32 offset = irqd_to_hwirq(d);
+	int port_mask = BIT(offset);
 
 	if (irqd_get_trigger_type(d) == IRQ_TYPE_EDGE_BOTH)
 		eic->int_type2 ^= port_mask; /* switch edge direction */
@@ -148,23 +149,29 @@ static void ep93xx_gpio_irq_mask_ack(struct irq_data *d)
 	ep93xx_gpio_update_int_params(eic);
 
 	writeb(port_mask, eic->base + EP93XX_INT_EOI_OFFSET);
+	gpiochip_disable_irq(gc, offset);
 }
 
 static void ep93xx_gpio_irq_mask(struct irq_data *d)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct ep93xx_gpio_irq_chip *eic = to_ep93xx_gpio_irq_chip(gc);
+	u32 offset = irqd_to_hwirq(d);
 
-	eic->int_unmasked &= ~BIT(irqd_to_hwirq(d));
+	eic->int_unmasked &= ~BIT(offset);
 	ep93xx_gpio_update_int_params(eic);
+
+	gpiochip_disable_irq(gc, offset);
 }
 
 static void ep93xx_gpio_irq_unmask(struct irq_data *d)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct ep93xx_gpio_irq_chip *eic = to_ep93xx_gpio_irq_chip(gc);
+	u32 offset = irqd_to_hwirq(d);
 
-	eic->int_unmasked |= BIT(irqd_to_hwirq(d));
+	gpiochip_enable_irq(gc, offset);
+	eic->int_unmasked |= BIT(offset);
 	ep93xx_gpio_update_int_params(eic);
 }
 
@@ -240,15 +247,25 @@ static int ep93xx_gpio_set_config(struct gpio_chip *gc, unsigned offset,
 	return 0;
 }
 
-static void ep93xx_init_irq_chip(struct device *dev, struct irq_chip *ic)
+static void ep93xx_irq_print_chip(struct irq_data *data, struct seq_file *p)
 {
-	ic->irq_ack = ep93xx_gpio_irq_ack;
-	ic->irq_mask_ack = ep93xx_gpio_irq_mask_ack;
-	ic->irq_mask = ep93xx_gpio_irq_mask;
-	ic->irq_unmask = ep93xx_gpio_irq_unmask;
-	ic->irq_set_type = ep93xx_gpio_irq_type;
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(data);
+
+	seq_printf(p, dev_name(gc->parent));
 }
 
+static const struct irq_chip gpio_eic_irq_chip = {
+	.name			= "ep93xx-gpio-eic",
+	.irq_ack		= ep93xx_gpio_irq_ack,
+	.irq_mask		= ep93xx_gpio_irq_mask,
+	.irq_unmask		= ep93xx_gpio_irq_unmask,
+	.irq_mask_ack	= ep93xx_gpio_irq_mask_ack,
+	.irq_set_type	= ep93xx_gpio_irq_type,
+	.irq_print_chip	= ep93xx_irq_print_chip,
+	.flags			= IRQCHIP_IMMUTABLE,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
+};
+
 static int ep93xx_setup_irqs(struct platform_device *pdev,
 			     struct ep93xx_gpio_chip *egc)
 {
@@ -257,7 +274,6 @@ static int ep93xx_setup_irqs(struct platform_device *pdev,
 	struct gpio_irq_chip *girq = &gc->irq;
 	struct irq_chip *ic;
 	int ret, irq, i = 0;
-	const char *label = 0;
 	void __iomem *intr = devm_platform_ioremap_resource_byname(pdev, "intr");
 
 	if (IS_ERR(intr))
@@ -271,14 +287,7 @@ static int ep93xx_setup_irqs(struct platform_device *pdev,
 		return -ENOMEM;
 
 	egc->eic->base = intr;
-	ic = &egc->eic->ic;
-	label = dev_name(dev);
-	ic->name = devm_kasprintf(dev, GFP_KERNEL, "gpio-irq-%s", label);
-	if (!ic->name)
-		return -ENOMEM;
-
-	ep93xx_init_irq_chip(dev, ic);
-	girq->chip = ic;
+	gpio_irq_chip_set_chip(girq, &gpio_eic_irq_chip);
 	girq->num_parents = platform_irq_count(pdev);
 	if (girq->num_parents == 0)
 		return -EINVAL;
@@ -293,7 +302,7 @@ static int ep93xx_setup_irqs(struct platform_device *pdev,
 		irq = platform_get_irq(pdev, 0);
 		ret = devm_request_irq(dev, irq,
 				ep93xx_ab_irq_handler,
-				IRQF_SHARED, ic->name, gc);
+				IRQF_SHARED, gc->label, gc);
 		if (ret) {
 			dev_err(dev, "error requesting IRQ : %d\n", irq);
 			return ret;
@@ -315,7 +324,8 @@ static int ep93xx_setup_irqs(struct platform_device *pdev,
 	}
 
 	girq->default_type = IRQ_TYPE_NONE;
-	girq->handler = handle_bad_irq;
+	/* TODO: replace wuth handle_bad_irq once we are fully hierarchical */
+	girq->handler = handle_simple_irq;
 
 	return 0;
 }
-- 
2.37.4

