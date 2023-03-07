Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6C856ADFD1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 14:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjCGNFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 08:05:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjCGNF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 08:05:26 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F9EE0
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 05:04:56 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id k14so16963290lfj.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 05:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678194286;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t+KEmI8whzjEUAizVJPshJjrICLTLWn62dQQiYVD1jA=;
        b=ivIOKdjXJOAGhCprjPgOdvonPXMyFzqBR0VHl+PrzMbdmTRzJIvMQr3bkAKB8TUTt6
         VJkVZq/cX3c6mxFLVPYwZAbo9fHd4WpwZzvU/jNVSjyBXMIhIPbqSgXfzP7vMc0r3IR0
         Wze9ZWsbA0eXNu8gx6u40bSLeg5OM8NxSflVtn2+EDdVG/3Wunq+WQjvhK9CH/ut8iLl
         DLShDAZeZ1gnYiYq/GR88Ag/QBSlaM7NT/KJyuCN6pY2cnBGW5+eHQuoRzhxX0DOuR2F
         G/FF/Mhd6tyK9fPpwgYzbzj6MdPtz4hrae/mLZ4JX1+vbjzHzVUoiz/mT6tFPlV/3/CK
         s6Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678194286;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t+KEmI8whzjEUAizVJPshJjrICLTLWn62dQQiYVD1jA=;
        b=ry65MwBIDuTTYDYR2/na0t47sds3UFOUFvclq5ILJSL9SMTH2Mw6BNK9zwUgb776od
         ruKnzgfr/v/3w8rWVCX5SoLwohkQip08qgKeH7DogdGR9uHC3NpnMRZI7MiAMA4CZ9Xi
         NtrIt+DL+pvMqqV44Q5gDas5LTn6A9CygjSCIEnHtc8qMUQ0roOTUmUIgUUpdBZJ6sKk
         5wSACMOEsn3ncOdPVZnxyJBAYnbTU0Lr8GAS26ecy9xnv8XNRyACTQWl9lDFxBvba50A
         9ts/Kk0AByrnE53rNQRb655bxgrOQrOtc8dZahD9Kd7abXWWxyHUPP2jT/+HT/+UU9Fj
         HHiQ==
X-Gm-Message-State: AO0yUKX29270X77TdR5BAQbQbb0LKrs87hBcdueRig3olGNr8gUkpUIT
        v6I05LDKuvEov7amBtwie8mQkg==
X-Google-Smtp-Source: AK7set8VxHEGYGpsZW0/selFSXoV2TQysp2TeyhwgH4Mz1Y9cEa/yyGjc+FFad13OmFBaxNGKoDrUw==
X-Received: by 2002:ac2:5504:0:b0:4e1:d90:e754 with SMTP id j4-20020ac25504000000b004e10d90e754mr4113951lfk.7.1678194286233;
        Tue, 07 Mar 2023 05:04:46 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.219])
        by smtp.gmail.com with ESMTPSA id w14-20020ac2598e000000b004caf992bba9sm2030548lfn.268.2023.03.07.05.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 05:04:45 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 07 Mar 2023 14:04:43 +0100
Subject: [PATCH v2 01/16] gpio: altera: Convert to immutable irq_chip
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230215-immutable-chips-v2-1-d6b0e3f2d991@linaro.org>
References: <20230215-immutable-chips-v2-0-d6b0e3f2d991@linaro.org>
In-Reply-To: <20230215-immutable-chips-v2-0-d6b0e3f2d991@linaro.org>
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
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
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

