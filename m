Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE69652172
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 14:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbiLTNZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 08:25:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbiLTNYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 08:24:43 -0500
Received: from out-75.mta0.migadu.com (out-75.mta0.migadu.com [91.218.175.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18631A3B6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 05:24:39 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1671542676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5jk//G82XoL09MdS2UpCztzol1TvVIpJTF0T1a5iUsA=;
        b=VNG68UwF28BevfhLvQx2lMbX6+djqfTVhe+/Sw8paS2LAl/4PDuT/S6buJZAVPe22JXukj
        l31oQjNSqJqNcA+y62hTxFoYIf7BUT417DX8sYYR5uBMsFvBvgz3fu2GVR/tEC8wWvPbRv
        8gOvqXxm5RZCCGNWenwsfgemmjct0Dw=
From:   Cixi Geng <cixi.geng@linux.dev>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 3/3] gpio: gpio-sprd: Make the irqchip immutable
Date:   Tue, 20 Dec 2022 21:23:41 +0800
Message-Id: <20221220132341.19383-4-cixi.geng@linux.dev>
In-Reply-To: <20221220132341.19383-1-cixi.geng@linux.dev>
References: <20221220132341.19383-1-cixi.geng@linux.dev>
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

Make the struct irq_chip const, flag it as IRQCHIP_IMMUTABLE, add the
new helper functions, and call the appropriate gpiolib functions.

Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
---
 drivers/gpio/gpio-sprd.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-sprd.c b/drivers/gpio/gpio-sprd.c
index 9bff63990eee..e6e48606a302 100644
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
@@ -205,13 +207,15 @@ static void sprd_gpio_irq_handler(struct irq_desc *desc)
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
@@ -245,7 +249,7 @@ static int sprd_gpio_probe(struct platform_device *pdev)
 	sprd_gpio->chip.direction_output = sprd_gpio_direction_output;
 
 	irq = &sprd_gpio->chip.irq;
-	irq->chip = &sprd_gpio_irqchip;
+	gpio_irq_chip_set_chip(irq, &sprd_gpio_irqchip);
 	irq->handler = handle_bad_irq;
 	irq->default_type = IRQ_TYPE_NONE;
 	irq->parent_handler = sprd_gpio_irq_handler;
-- 
2.34.1

