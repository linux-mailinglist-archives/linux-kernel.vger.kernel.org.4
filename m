Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22371657674
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 13:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232777AbiL1Mcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 07:32:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232702AbiL1MZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 07:25:04 -0500
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A8B2BA;
        Wed, 28 Dec 2022 04:25:03 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1672230302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fn0UF29ExGYYN9yHRFeunYSNii70MOtxu0VxA0YXtZ0=;
        b=tA1NLv+Q3aweIMLHhhQjorIzhflzNmP2a/j1cMCYBgDZYAH1VxsFbrp6kiQbPI1d6P9nWz
        ZaurL2t0wD9a7VQkb+gKMKgdz50aJoJsC+gc5gfL/gD0uviPy/eJ2IvTvOAlcTbgKFJ2Es
        xx3d6NBNyXNl/HpoNwRmMbI0xx46Sr4=
From:   Cixi Geng <cixi.geng@linux.dev>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        cixi.geng1@unisoc.com
Subject: [PATCH V3 1/3] gpio: eic-sprd: Make the irqchip immutable
Date:   Wed, 28 Dec 2022 20:24:40 +0800
Message-Id: <20221228122442.392504-2-cixi.geng@linux.dev>
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
 drivers/gpio/gpio-eic-sprd.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.c
index 8d722e026e9c..86563c0604e8 100644
--- a/drivers/gpio/gpio-eic-sprd.c
+++ b/drivers/gpio/gpio-eic-sprd.c
@@ -91,7 +91,6 @@ enum sprd_eic_type {
 
 struct sprd_eic {
 	struct gpio_chip chip;
-	struct irq_chip intc;
 	void __iomem *base[SPRD_EIC_MAX_BANK];
 	enum sprd_eic_type type;
 	spinlock_t lock;
@@ -255,6 +254,8 @@ static void sprd_eic_irq_mask(struct irq_data *data)
 	default:
 		dev_err(chip->parent, "Unsupported EIC type.\n");
 	}
+
+	gpiochip_disable_irq(chip, offset);
 }
 
 static void sprd_eic_irq_unmask(struct irq_data *data)
@@ -263,6 +264,8 @@ static void sprd_eic_irq_unmask(struct irq_data *data)
 	struct sprd_eic *sprd_eic = gpiochip_get_data(chip);
 	u32 offset = irqd_to_hwirq(data);
 
+	gpiochip_enable_irq(chip, offset);
+
 	switch (sprd_eic->type) {
 	case SPRD_EIC_DEBOUNCE:
 		sprd_eic_update(chip, offset, SPRD_EIC_DBNC_IE, 1);
@@ -564,6 +567,15 @@ static void sprd_eic_irq_handler(struct irq_desc *desc)
 	chained_irq_exit(ic, desc);
 }
 
+static const struct irq_chip sprd_eic_irq = {
+	.name		= "sprd-eic-gpio",
+	.irq_ack	= sprd_eic_irq_ack,
+	.irq_mask	= sprd_eic_irq_mask,
+	.irq_unmask	= sprd_eic_irq_unmask,
+	.irq_set_type	= sprd_eic_irq_set_type,
+	.flags		= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_IMMUTABLE,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
+};
 static int sprd_eic_probe(struct platform_device *pdev)
 {
 	const struct sprd_eic_variant_data *pdata;
@@ -626,15 +638,8 @@ static int sprd_eic_probe(struct platform_device *pdev)
 		break;
 	}
 
-	sprd_eic->intc.name = dev_name(&pdev->dev);
-	sprd_eic->intc.irq_ack = sprd_eic_irq_ack;
-	sprd_eic->intc.irq_mask = sprd_eic_irq_mask;
-	sprd_eic->intc.irq_unmask = sprd_eic_irq_unmask;
-	sprd_eic->intc.irq_set_type = sprd_eic_irq_set_type;
-	sprd_eic->intc.flags = IRQCHIP_SKIP_SET_WAKE;
-
 	irq = &sprd_eic->chip.irq;
-	irq->chip = &sprd_eic->intc;
+	gpio_irq_chip_set_chip(irq, &sprd_eic_irq);
 	irq->handler = handle_bad_irq;
 	irq->default_type = IRQ_TYPE_NONE;
 	irq->parent_handler = sprd_eic_irq_handler;
-- 
2.34.1

