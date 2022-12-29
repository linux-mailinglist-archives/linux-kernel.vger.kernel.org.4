Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F197F658E27
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 15:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233646AbiL2O4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 09:56:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233627AbiL2O4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 09:56:24 -0500
Received: from out-23.mta0.migadu.com (out-23.mta0.migadu.com [91.218.175.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CCE6432
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 06:56:23 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1672325780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HRDh64TLuc7fg9bN8jkkUfHhB4fjnXAc5g4yon1RY9I=;
        b=c/O6pZ12Pp2xeL+X3o3eRF0Lp8KmCvyCXOBQ9HzizVI8JXM7ZJuqVWO4w9a6a9GU2tbxhY
        MYGAWKatEkGNzB+W4TRglJcvXutojTPCK/JCqc2ekpKToFOhI2Aheqvlp0TnUHxhGIUKcu
        PlyFQrORhO5/iv4ZQAdT8Af0bk/rngU=
From:   Cixi Geng <cixi.geng@linux.dev>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        cixi.geng1@unisoc.com
Subject: [PATCH V4 2/3] gpio: gpio-pmic-eic-sprd: Make the irqchip immutable
Date:   Thu, 29 Dec 2022 22:55:44 +0800
Message-Id: <20221229145545.14055-3-cixi.geng@linux.dev>
In-Reply-To: <20221229145545.14055-1-cixi.geng@linux.dev>
References: <20221229145545.14055-1-cixi.geng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cixi Geng <cixi.geng1@unisoc.com>

Remove the irq_chip from pmic_eic structure,
use the various calls by defining the statically
irq_chip structure.

Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 drivers/gpio/gpio-pmic-eic-sprd.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/gpio/gpio-pmic-eic-sprd.c b/drivers/gpio/gpio-pmic-eic-sprd.c
index e518490c4b68..c3e4d90f6b18 100644
--- a/drivers/gpio/gpio-pmic-eic-sprd.c
+++ b/drivers/gpio/gpio-pmic-eic-sprd.c
@@ -47,7 +47,6 @@ enum {
 /**
  * struct sprd_pmic_eic - PMIC EIC controller
  * @chip: the gpio_chip structure.
- * @intc: the irq_chip structure.
  * @map:  the regmap from the parent device.
  * @offset: the EIC controller's offset address of the PMIC.
  * @reg: the array to cache the EIC registers.
@@ -56,7 +55,6 @@ enum {
  */
 struct sprd_pmic_eic {
 	struct gpio_chip chip;
-	struct irq_chip intc;
 	struct regmap *map;
 	u32 offset;
 	u8 reg[CACHE_NR_REGS];
@@ -151,15 +149,21 @@ static void sprd_pmic_eic_irq_mask(struct irq_data *data)
 {
 	struct gpio_chip *chip = irq_data_get_irq_chip_data(data);
 	struct sprd_pmic_eic *pmic_eic = gpiochip_get_data(chip);
+	u32 offset = irqd_to_hwirq(data);
 
 	pmic_eic->reg[REG_IE] = 0;
 	pmic_eic->reg[REG_TRIG] = 0;
+
+	gpiochip_disable_irq(chip, offset);
 }
 
 static void sprd_pmic_eic_irq_unmask(struct irq_data *data)
 {
 	struct gpio_chip *chip = irq_data_get_irq_chip_data(data);
 	struct sprd_pmic_eic *pmic_eic = gpiochip_get_data(chip);
+	u32 offset = irqd_to_hwirq(data);
+
+	gpiochip_enable_irq(chip, offset);
 
 	pmic_eic->reg[REG_IE] = 1;
 	pmic_eic->reg[REG_TRIG] = 1;
@@ -292,6 +296,17 @@ static irqreturn_t sprd_pmic_eic_irq_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static const struct irq_chip pmic_eic_irq_chip = {
+	.name			= "sprd-pmic-eic",
+	.irq_mask		= sprd_pmic_eic_irq_mask,
+	.irq_unmask		= sprd_pmic_eic_irq_unmask,
+	.irq_set_type		= sprd_pmic_eic_irq_set_type,
+	.irq_bus_lock		= sprd_pmic_eic_bus_lock,
+	.irq_bus_sync_unlock	= sprd_pmic_eic_bus_sync_unlock,
+	.flags			= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_IMMUTABLE,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
+};
+
 static int sprd_pmic_eic_probe(struct platform_device *pdev)
 {
 	struct gpio_irq_chip *irq;
@@ -338,16 +353,8 @@ static int sprd_pmic_eic_probe(struct platform_device *pdev)
 	pmic_eic->chip.set = sprd_pmic_eic_set;
 	pmic_eic->chip.get = sprd_pmic_eic_get;
 
-	pmic_eic->intc.name = dev_name(&pdev->dev);
-	pmic_eic->intc.irq_mask = sprd_pmic_eic_irq_mask;
-	pmic_eic->intc.irq_unmask = sprd_pmic_eic_irq_unmask;
-	pmic_eic->intc.irq_set_type = sprd_pmic_eic_irq_set_type;
-	pmic_eic->intc.irq_bus_lock = sprd_pmic_eic_bus_lock;
-	pmic_eic->intc.irq_bus_sync_unlock = sprd_pmic_eic_bus_sync_unlock;
-	pmic_eic->intc.flags = IRQCHIP_SKIP_SET_WAKE;
-
 	irq = &pmic_eic->chip.irq;
-	irq->chip = &pmic_eic->intc;
+	gpio_irq_chip_set_chip(irq, &pmic_eic_irq_chip);
 	irq->threaded = true;
 
 	ret = devm_gpiochip_add_data(&pdev->dev, &pmic_eic->chip, pmic_eic);
-- 
2.34.1

