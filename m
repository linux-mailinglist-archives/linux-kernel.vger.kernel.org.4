Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02238657675
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 13:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbiL1Mc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 07:32:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232810AbiL1MZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 07:25:07 -0500
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED89D315;
        Wed, 28 Dec 2022 04:25:06 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1672230305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X5m8HaHVkvDRo1mPS0/MegFApoCHSK8vTZSy37tpuxA=;
        b=PnJU6KrBrKWlRIl/XDx/xUlB5SElPOVTfJJmo8odwIKFqGSishGAHSXeDz3LSMKhycU2iA
        0S5oMg6OqmXh4Zb8QRNv2D0nQ+fJJLJFmpMcPiHIpXumIhA8nMTMlY/oj9Jkz9FRR6DGCl
        VjlD5egbG7pVAghrEAnj2uxZcRv3Bes=
From:   Cixi Geng <cixi.geng@linux.dev>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        cixi.geng1@unisoc.com
Subject: [PATCH V3 2/3] gpio: gpio-pmic-eic-sprd: Make the irqchip immutable
Date:   Wed, 28 Dec 2022 20:24:41 +0800
Message-Id: <20221228122442.392504-3-cixi.geng@linux.dev>
In-Reply-To: <20221228122442.392504-1-cixi.geng@linux.dev>
References: <20221228122442.392504-1-cixi.geng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
---
 drivers/gpio/gpio-pmic-eic-sprd.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/gpio/gpio-pmic-eic-sprd.c b/drivers/gpio/gpio-pmic-eic-sprd.c
index e518490c4b68..add15416f7a6 100644
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
+	irq_hw_number_t hwirq = irqd_to_hwirq(data);
 
 	pmic_eic->reg[REG_IE] = 0;
 	pmic_eic->reg[REG_TRIG] = 0;
+
+	gpiochip_disable_irq(chip, hwirq);
 }
 
 static void sprd_pmic_eic_irq_unmask(struct irq_data *data)
 {
 	struct gpio_chip *chip = irq_data_get_irq_chip_data(data);
 	struct sprd_pmic_eic *pmic_eic = gpiochip_get_data(chip);
+	irq_hw_number_t hwirq = irqd_to_hwirq(data);
+
+	gpiochip_enable_irq(chip, hwirq);
 
 	pmic_eic->reg[REG_IE] = 1;
 	pmic_eic->reg[REG_TRIG] = 1;
@@ -292,6 +296,17 @@ static irqreturn_t sprd_pmic_eic_irq_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static const struct irq_chip pmic_eic_irq_chip = {
+	.name			= "sprd-pmic-eic-gpio",
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

