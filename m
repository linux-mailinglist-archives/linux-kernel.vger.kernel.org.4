Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3DE56B1CA7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 08:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjCIHqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 02:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjCIHp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 02:45:59 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF3EDD352
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 23:45:58 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id s20so1127930lfb.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 23:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678347956;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t+KEmI8whzjEUAizVJPshJjrICLTLWn62dQQiYVD1jA=;
        b=IzVpcZj96fumWwiZ9ce8p3OR00lwH2NSwIo6JgwE3eUrUbaCenSVg9A2IfJ0T5yKrF
         SkQWIosnVkJASnorq0HjSVujiLGhuf+H/CU3+yYMQDsjvDUskV5emKdM0lVSezIrvkss
         FdSBrCi4CbAaiEwps34Uui98JaatpeK5ak6yYuz8f0AyWyYZGKxp09rbxX+XT2uue5iD
         y0EBrkyqDVoaygONBXCc3okeqz57bWs1/PtSZqIlcbl24A1He/CyjbG+PL8ikEmDC83G
         bojse/lcmBP4bVFZ6FWWkICZkNA3MUkOtFnZcL3KeJuhzjI5+iXI9EZUHsr5eguGZ3l2
         MDkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678347956;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t+KEmI8whzjEUAizVJPshJjrICLTLWn62dQQiYVD1jA=;
        b=PDYrTYUUDwwAFbik6oSKNUrl7RGb/xz5cWevciQSjent4BQP7MXHCnfYvQyUzKY1KQ
         QVsL3OzkzWUnUxnrbvqu3usIFauvFacs/eq6CUef5y9ZfTvvcNTz4N65is1Oub0TKCom
         XP1HakWi1LgBi0HuRO/8Wtd4zjyJH5rYMOzl4eyM3eM2kDt/gGvtx+k9/4T6w/3+XYLb
         osV5zeMn602Y3lDIDSXZJPksC8wTXXDiH3zqXe616ns8mZcPnBiwpZqUp3EA7r63Mo+y
         2JNTen5R8QqxEbskQJPmPH/EpRCTIe06Ym1ajoGP9P/fD1q1cwRcPruMZk/lCO5oceYG
         +dQw==
X-Gm-Message-State: AO0yUKVYcSBC7Po6TyUDqDQBbUZDW4237WfGiA17/mcjwbqRqv2WhTNZ
        UwkQBeVgUrFjzd7fLQcysJmI7Q==
X-Google-Smtp-Source: AK7set9WPD6eu/vWCYRu6sj0S213JwL98jfUk1++KvMe+8mAaYh/4t0MAArd1j+T9EDICORejXX9CQ==
X-Received: by 2002:ac2:4c0d:0:b0:4e2:3453:40eb with SMTP id t13-20020ac24c0d000000b004e2345340ebmr5437312lfq.34.1678347956342;
        Wed, 08 Mar 2023 23:45:56 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.219])
        by smtp.gmail.com with ESMTPSA id a6-20020a056512020600b004bb766e01a4sm2568972lfo.245.2023.03.08.23.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 23:45:55 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 09 Mar 2023 08:45:49 +0100
Subject: [PATCH v3 01/17] gpio: altera: Convert to immutable irq_chip
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230215-immutable-chips-v3-1-972542092a77@linaro.org>
References: <20230215-immutable-chips-v3-0-972542092a77@linaro.org>
In-Reply-To: <20230215-immutable-chips-v3-0-972542092a77@linaro.org>
To:     Mun Yew Tham <mun.yew.tham@intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, Alban Bedel <albeu@free.fr>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Jay Fang <f.fangjian@huawei.com>,
        Daniel Palmer <daniel@thingy.jp>,
        Romain Perier <romain.perier@gmail.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        William Breathitt Gray <william.gray@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-omap@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <maz@kernel.org>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the driver to immutable irq-chip with a bit of
intuition.

Cc: Marc Zyngier <maz@kernel.org>
Acked-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpio-altera.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/gpio/gpio-altera.c b/drivers/gpio/gpio-altera.c
index b59fae993626..c1599edb3453 100644
--- a/drivers/gpio/gpio-altera.c
+++ b/drivers/gpio/gpio-altera.c
@@ -24,14 +24,12 @@
 * @interrupt_trigger	: specifies the hardware configured IRQ trigger type
 *			  (rising, falling, both, high)
 * @mapped_irq		: kernel mapped irq number.
-* @irq_chip		: IRQ chip configuration
 */
 struct altera_gpio_chip {
 	struct of_mm_gpio_chip mmchip;
 	raw_spinlock_t gpio_lock;
 	int interrupt_trigger;
 	int mapped_irq;
-	struct irq_chip irq_chip;
 };
 
 static void altera_gpio_irq_unmask(struct irq_data *d)
@@ -43,6 +41,7 @@ static void altera_gpio_irq_unmask(struct irq_data *d)
 
 	altera_gc = gpiochip_get_data(irq_data_get_irq_chip_data(d));
 	mm_gc = &altera_gc->mmchip;
+	gpiochip_enable_irq(&mm_gc->gc, irqd_to_hwirq(d));
 
 	raw_spin_lock_irqsave(&altera_gc->gpio_lock, flags);
 	intmask = readl(mm_gc->regs + ALTERA_GPIO_IRQ_MASK);
@@ -68,6 +67,7 @@ static void altera_gpio_irq_mask(struct irq_data *d)
 	intmask &= ~BIT(irqd_to_hwirq(d));
 	writel(intmask, mm_gc->regs + ALTERA_GPIO_IRQ_MASK);
 	raw_spin_unlock_irqrestore(&altera_gc->gpio_lock, flags);
+	gpiochip_disable_irq(&mm_gc->gc, irqd_to_hwirq(d));
 }
 
 /*
@@ -233,6 +233,17 @@ static void altera_gpio_irq_leveL_high_handler(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
+static const struct irq_chip altera_gpio_irq_chip = {
+	.name = "altera-gpio",
+	.irq_mask = altera_gpio_irq_mask,
+	.irq_unmask = altera_gpio_irq_unmask,
+	.irq_set_type = altera_gpio_irq_set_type,
+	.irq_startup  = altera_gpio_irq_startup,
+	.irq_shutdown = altera_gpio_irq_mask,
+	.flags = IRQCHIP_IMMUTABLE,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
+};
+
 static int altera_gpio_probe(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
@@ -278,15 +289,9 @@ static int altera_gpio_probe(struct platform_device *pdev)
 	}
 	altera_gc->interrupt_trigger = reg;
 
-	altera_gc->irq_chip.name = "altera-gpio";
-	altera_gc->irq_chip.irq_mask     = altera_gpio_irq_mask;
-	altera_gc->irq_chip.irq_unmask   = altera_gpio_irq_unmask;
-	altera_gc->irq_chip.irq_set_type = altera_gpio_irq_set_type;
-	altera_gc->irq_chip.irq_startup  = altera_gpio_irq_startup;
-	altera_gc->irq_chip.irq_shutdown = altera_gpio_irq_mask;
-
 	girq = &altera_gc->mmchip.gc.irq;
-	girq->chip = &altera_gc->irq_chip;
+	gpio_irq_chip_set_chip(girq, &altera_gpio_irq_chip);
+
 	if (altera_gc->interrupt_trigger == IRQ_TYPE_LEVEL_HIGH)
 		girq->parent_handler = altera_gpio_irq_leveL_high_handler;
 	else

-- 
2.34.1

