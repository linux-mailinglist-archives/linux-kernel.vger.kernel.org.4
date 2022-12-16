Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9738564E6AD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 05:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiLPE0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 23:26:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiLPE0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 23:26:19 -0500
X-Greylist: delayed 519 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 15 Dec 2022 20:26:17 PST
Received: from out-18.mta0.migadu.com (out-18.mta0.migadu.com [91.218.175.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36F86036B
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 20:26:17 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1671164255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=UGBLh9DAaCubl0iR5/VhBqErDCfa1wpAZno7Lj8I1vQ=;
        b=i9itX9UC8z+pZqiL6AKDm0ZaIFmVLa+2t+R4rq697k8wYExxyWN5L2L6vXMBoP7zveIs/d
        q8bQb5KgAFzo0BsF1oPKsKgVYGZ/Tjnk7q12M6zHUPZEPW57kJQbuq9dASKDwUWps556jc
        woucGuahZfg5d6Z0UNvNTYYltqGyFWY=
From:   Cixi Geng <cixi.geng@linux.dev>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
        gengcixi@gmail.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] gpio: sprd: Make irq_chip immutable
Date:   Fri, 16 Dec 2022 12:17:08 +0800
Message-Id: <20221216041708.32768-1-cixi.geng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cixi Geng <cixi.geng1@unisoc.com>

Kernel warns about mutable irq_chips:

    "not an immutable chip, please consider fixing!"

Make the struct irq_chip const, flag it as IRQCHIP_IMMUTABLE, add the
new helper functions, and call the appropriate gpiolib functions.

Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
---
 drivers/gpio/gpio-eic-sprd.c      |  4 ++--
 drivers/gpio/gpio-pmic-eic-sprd.c |  4 ++--
 drivers/gpio/gpio-sprd.c          | 11 +++++++++--
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.c
index 8d722e026e9c..07b9099f2a6d 100644
--- a/drivers/gpio/gpio-eic-sprd.c
+++ b/drivers/gpio/gpio-eic-sprd.c
@@ -631,10 +631,10 @@ static int sprd_eic_probe(struct platform_device *pdev)
 	sprd_eic->intc.irq_mask = sprd_eic_irq_mask;
 	sprd_eic->intc.irq_unmask = sprd_eic_irq_unmask;
 	sprd_eic->intc.irq_set_type = sprd_eic_irq_set_type;
-	sprd_eic->intc.flags = IRQCHIP_SKIP_SET_WAKE;
+	sprd_eic->intc.flags = IRQCHIP_SKIP_SET_WAKE | IRQCHIP_IMMUTABLE;
 
 	irq = &sprd_eic->chip.irq;
-	irq->chip = &sprd_eic->intc;
+	gpio_irq_chip_set_chip(irq, &sprd_eic->intc);
 	irq->handler = handle_bad_irq;
 	irq->default_type = IRQ_TYPE_NONE;
 	irq->parent_handler = sprd_eic_irq_handler;
diff --git a/drivers/gpio/gpio-pmic-eic-sprd.c b/drivers/gpio/gpio-pmic-eic-sprd.c
index e518490c4b68..d96604ea10e7 100644
--- a/drivers/gpio/gpio-pmic-eic-sprd.c
+++ b/drivers/gpio/gpio-pmic-eic-sprd.c
@@ -344,10 +344,10 @@ static int sprd_pmic_eic_probe(struct platform_device *pdev)
 	pmic_eic->intc.irq_set_type = sprd_pmic_eic_irq_set_type;
 	pmic_eic->intc.irq_bus_lock = sprd_pmic_eic_bus_lock;
 	pmic_eic->intc.irq_bus_sync_unlock = sprd_pmic_eic_bus_sync_unlock;
-	pmic_eic->intc.flags = IRQCHIP_SKIP_SET_WAKE;
+	pmic_eic->intc.flags = IRQCHIP_SKIP_SET_WAKE | IRQCHIP_IMMUTABLE;
 
 	irq = &pmic_eic->chip.irq;
-	irq->chip = &pmic_eic->intc;
+	gpio_irq_chip_set_chip(irq, &pmic_eic->intc);
 	irq->threaded = true;
 
 	ret = devm_gpiochip_add_data(&pdev->dev, &pmic_eic->chip, pmic_eic);
diff --git a/drivers/gpio/gpio-sprd.c b/drivers/gpio/gpio-sprd.c
index 9bff63990eee..8398f9707ec0 100644
--- a/drivers/gpio/gpio-sprd.c
+++ b/drivers/gpio/gpio-sprd.c
@@ -64,6 +64,11 @@ static void sprd_gpio_update(struct gpio_chip *chip, unsigned int offset,
 
 	writel_relaxed(tmp, base + reg);
 	spin_unlock_irqrestore(&sprd_gpio->lock, flags);
+
+	if (reg == SPRD_GPIO_IE && val == 1)
+		gpiochip_enable_irq(chip, offset);
+	else if (reg == SPRD_GPIO_IE && val == 0)
+		gpiochip_disable_irq(chip, offset);
 }
 
 static int sprd_gpio_read(struct gpio_chip *chip, unsigned int offset, u16 reg)
@@ -205,13 +210,15 @@ static void sprd_gpio_irq_handler(struct irq_desc *desc)
 	chained_irq_exit(ic, desc);
 }
 
-static struct irq_chip sprd_gpio_irqchip = {
+static const struct irq_chip sprd_gpio_irqchip = {
 	.name = "sprd-gpio",
 	.irq_ack = sprd_gpio_irq_ack,
 	.irq_mask = sprd_gpio_irq_mask,
 	.irq_unmask = sprd_gpio_irq_unmask,
 	.irq_set_type = sprd_gpio_irq_set_type,
 	.flags = IRQCHIP_SKIP_SET_WAKE,
+	.flags = IRQCHIP_SKIP_SET_WAKE | IRQCHIP_IMMUTABLE,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
 };
 
 static int sprd_gpio_probe(struct platform_device *pdev)
@@ -245,7 +252,7 @@ static int sprd_gpio_probe(struct platform_device *pdev)
 	sprd_gpio->chip.direction_output = sprd_gpio_direction_output;
 
 	irq = &sprd_gpio->chip.irq;
-	irq->chip = &sprd_gpio_irqchip;
+	gpio_irq_chip_set_chip(irq, &sprd_gpio_irqchip);
 	irq->handler = handle_bad_irq;
 	irq->default_type = IRQ_TYPE_NONE;
 	irq->parent_handler = sprd_gpio_irq_handler;
-- 
2.34.1

