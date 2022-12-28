Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94E9F657676
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 13:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbiL1MdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 07:33:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232830AbiL1MZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 07:25:11 -0500
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CD72BA;
        Wed, 28 Dec 2022 04:25:10 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1672230309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BTPJCC4TTwP84BBs21zNnyfu2sa/UTInRsPtE+n30Ws=;
        b=V1S7bplS+y8D9cCLAQGLJABikiXryBsHamNvolWehSPkVGmzskHzmK0d9V/KdWty0+tj/N
        XS6PWb4TbHD/7k8mFgTf5Yk0sY29fIP8dheLnyntQ8dUSYTF7H4VMwwU5ehVQfGQRwS8Z8
        6SMai/It+C3fIamoNts88ANxY8FYot8=
From:   Cixi Geng <cixi.geng@linux.dev>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        cixi.geng1@unisoc.com
Subject: [PATCH V3 3/3] gpio: gpio-sprd: Make the irqchip immutable
Date:   Wed, 28 Dec 2022 20:24:42 +0800
Message-Id: <20221228122442.392504-4-cixi.geng@linux.dev>
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

Make the struct irq_chip const, flag it as IRQCHIP_IMMUTABLE, add the
new helper functions, and call the appropriate gpiolib functions.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@lip6.fr>
Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
---
 drivers/gpio/gpio-sprd.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-sprd.c b/drivers/gpio/gpio-sprd.c
index 9bff63990eee..072b4e653216 100644
--- a/drivers/gpio/gpio-sprd.c
+++ b/drivers/gpio/gpio-sprd.c
@@ -120,6 +120,7 @@ static void sprd_gpio_irq_mask(struct irq_data *data)
 	u32 offset = irqd_to_hwirq(data);
 
 	sprd_gpio_update(chip, offset, SPRD_GPIO_IE, 0);
+	gpiochip_disable_irq(chip, offset);
 }
 
 static void sprd_gpio_irq_ack(struct irq_data *data)
@@ -136,6 +137,7 @@ static void sprd_gpio_irq_unmask(struct irq_data *data)
 	u32 offset = irqd_to_hwirq(data);
 
 	sprd_gpio_update(chip, offset, SPRD_GPIO_IE, 1);
+	gpiochip_enable_irq(chip, offset);
 }
 
 static int sprd_gpio_irq_set_type(struct irq_data *data,
@@ -205,13 +207,14 @@ static void sprd_gpio_irq_handler(struct irq_desc *desc)
 	chained_irq_exit(ic, desc);
 }
 
-static struct irq_chip sprd_gpio_irqchip = {
+static const struct irq_chip sprd_gpio_irqchip = {
 	.name = "sprd-gpio",
 	.irq_ack = sprd_gpio_irq_ack,
 	.irq_mask = sprd_gpio_irq_mask,
 	.irq_unmask = sprd_gpio_irq_unmask,
 	.irq_set_type = sprd_gpio_irq_set_type,
-	.flags = IRQCHIP_SKIP_SET_WAKE,
+	.flags = IRQCHIP_SKIP_SET_WAKE | IRQCHIP_IMMUTABLE,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
 };
 
 static int sprd_gpio_probe(struct platform_device *pdev)
@@ -245,7 +248,7 @@ static int sprd_gpio_probe(struct platform_device *pdev)
 	sprd_gpio->chip.direction_output = sprd_gpio_direction_output;
 
 	irq = &sprd_gpio->chip.irq;
-	irq->chip = &sprd_gpio_irqchip;
+	gpio_irq_chip_set_chip(irq, &sprd_gpio_irqchip);
 	irq->handler = handle_bad_irq;
 	irq->default_type = IRQ_TYPE_NONE;
 	irq->parent_handler = sprd_gpio_irq_handler;
-- 
2.34.1

