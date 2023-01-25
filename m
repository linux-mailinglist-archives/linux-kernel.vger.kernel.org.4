Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C38F67ABB9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 09:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235100AbjAYIak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 03:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234879AbjAYIai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 03:30:38 -0500
Received: from forward102p.mail.yandex.net (forward102p.mail.yandex.net [77.88.28.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2727DAC;
        Wed, 25 Jan 2023 00:30:36 -0800 (PST)
Received: from sas2-ffeb92823cb1.qloud-c.yandex.net (sas2-ffeb92823cb1.qloud-c.yandex.net [IPv6:2a02:6b8:c08:6803:0:640:ffeb:9282])
        by forward102p.mail.yandex.net (Yandex) with ESMTP id A7502393D0F4;
        Wed, 25 Jan 2023 11:30:34 +0300 (MSK)
Received: by sas2-ffeb92823cb1.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id UUKCeP8ZA4Y1-mPhYkTVH;
        Wed, 25 Jan 2023 11:30:34 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1674635434;
        bh=iidiJk7gqnRXHVF6+O7ZQTR6SkuDu9Exd2t+TAWbVe4=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=on5d1suYZKqi22sYt520g3EyrtgYeLgJWztXzEG/uCe/oE5myohq/ix3RXW+7CXcT
         7HRAwQdxBSsF1Vgzhf5M2pugZTZAzYVTWzaTSD24cjJ79HkajJ0v4EOBI0HLx8Ufc0
         KTJ1BPkBSNKrPSZKbjRixX+qxOv8b5T6lhOeNpN0=
Authentication-Results: sas2-ffeb92823cb1.qloud-c.yandex.net; dkim=pass header.i=@maquefel.me
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     linux-gpio@vger.kernel.org
Cc:     Nikita Shubin <nikita.shubin@maquefel.me>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Lukasz Majewski <lukma@denx.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/3] gpio: ep93xx: Make irqchip immutable
Date:   Wed, 25 Jan 2023 11:30:25 +0300
Message-Id: <20230125083026.5399-3-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20230125083026.5399-1-nikita.shubin@maquefel.me>
References: <20230117100845.16708-1-nikita.shubin@maquefel.me>
 <20230125083026.5399-1-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This turns the Cirrus ep93xx gpio irqchip immutable.

Preserve per-chip labels by adding an ->irq_print_chip() callback.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
Bartosz Golaszewski, Linus Walleij:

This could come togather with some refactoring and replacing 
all 'd->irq & 7' to 'irqd_to_hwirq', bu this comes in following 
patch.
---
 drivers/gpio/gpio-ep93xx.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/gpio/gpio-ep93xx.c b/drivers/gpio/gpio-ep93xx.c
index 7edcdc575080..192be99b1392 100644
--- a/drivers/gpio/gpio-ep93xx.c
+++ b/drivers/gpio/gpio-ep93xx.c
@@ -17,6 +17,7 @@
 #include <linux/slab.h>
 #include <linux/gpio/driver.h>
 #include <linux/bitops.h>
+#include <linux/seq_file.h>
 
 #define EP93XX_GPIO_F_INT_STATUS 0x5c
 #define EP93XX_GPIO_A_INT_STATUS 0xa0
@@ -40,7 +41,6 @@
 #define EP93XX_GPIO_F_IRQ_BASE 80
 
 struct ep93xx_gpio_irq_chip {
-	struct irq_chip ic;
 	u8 irq_offset;
 	u8 int_unmasked;
 	u8 int_enabled;
@@ -185,6 +185,7 @@ static void ep93xx_gpio_irq_mask_ack(struct irq_data *d)
 	ep93xx_gpio_update_int_params(epg, eic);
 
 	writeb(port_mask, epg->base + eic->irq_offset + EP93XX_INT_EOI_OFFSET);
+	gpiochip_disable_irq(gc, irqd_to_hwirq(d));
 }
 
 static void ep93xx_gpio_irq_mask(struct irq_data *d)
@@ -195,6 +196,7 @@ static void ep93xx_gpio_irq_mask(struct irq_data *d)
 
 	eic->int_unmasked &= ~BIT(d->irq & 7);
 	ep93xx_gpio_update_int_params(epg, eic);
+	gpiochip_disable_irq(gc, irqd_to_hwirq(d));
 }
 
 static void ep93xx_gpio_irq_unmask(struct irq_data *d)
@@ -203,6 +205,7 @@ static void ep93xx_gpio_irq_unmask(struct irq_data *d)
 	struct ep93xx_gpio_irq_chip *eic = to_ep93xx_gpio_irq_chip(gc);
 	struct ep93xx_gpio *epg = gpiochip_get_data(gc);
 
+	gpiochip_enable_irq(gc, irqd_to_hwirq(d));
 	eic->int_unmasked |= BIT(d->irq & 7);
 	ep93xx_gpio_update_int_params(epg, eic);
 }
@@ -320,15 +323,25 @@ static int ep93xx_gpio_set_config(struct gpio_chip *gc, unsigned offset,
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
 static int ep93xx_gpio_add_bank(struct ep93xx_gpio_chip *egc,
 				struct platform_device *pdev,
 				struct ep93xx_gpio *epg,
@@ -359,12 +372,7 @@ static int ep93xx_gpio_add_bank(struct ep93xx_gpio_chip *egc,
 		if (!egc->eic)
 			return -ENOMEM;
 		egc->eic->irq_offset = bank->irq;
-		ic = &egc->eic->ic;
-		ic->name = devm_kasprintf(dev, GFP_KERNEL, "gpio-irq-%s", bank->label);
-		if (!ic->name)
-			return -ENOMEM;
-		ep93xx_init_irq_chip(dev, ic);
-		girq->chip = ic;
+		gpio_irq_chip_set_chip(girq, &gpio_eic_irq_chip);
 	}
 
 	if (bank->has_irq) {
-- 
2.37.4

