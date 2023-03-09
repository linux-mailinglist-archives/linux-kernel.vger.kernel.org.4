Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5346B1CBA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 08:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjCIHqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 02:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjCIHqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 02:46:06 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8801FDB6E4
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 23:46:04 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id r27so1134932lfe.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 23:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678347964;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c+tr96cZPYMIs0/699FeDkH9/3i8GidF6/NXAvTE8Kg=;
        b=oGW4OUQOWAHop80go+7eApoUqKVJQON4IntulrZQevBtG7/txnRJ1hEPqqfqWliJ3/
         eQ4luTNNRRIvo4ZQ5IrXKX2HMtUI5ARBUVi+45UZ1NSgSLq4lvMHn6XqEqz4PuYZPIT8
         m1upl/zAA244KcLjUxk4wfhic/fEhP7jUJ3IX4y8pzpIJU3DfwSwgaLQVTGrYIpE1/Zm
         ZeiA75Yomc6pyu7as9PecDHpKv56m+T6RsagMseeYS43IzgC3i46K4zTFv9L1g0HyJBO
         gxkj/MIhbE3NYOS/6XbaMpAvFGhW9BbJLj8mSKHyRgsNKzqcStlN38pffi9HgN3ksQ97
         XAwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678347964;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c+tr96cZPYMIs0/699FeDkH9/3i8GidF6/NXAvTE8Kg=;
        b=JIlUt/2sTENSsvty92rjlLeOXhusStUI1Kmpo4JR7mLltrNMr0LEwROYPxUafyQmZ7
         dMp7qdr2uqQFf8AWT26SAsevNfdXz3/tuZru1mBvDaS8+ddxvFIuwQYzP3c0fNx6Pywy
         J733QTwb5SrZgBpia6c1mSKKtsEEcrvzJVJvQAhU22UfR3sJiOyrA45WbMAHrtny4EWg
         7mQmBMd/deodrsWFrCDbU9B4YKVXs962/80ycbhg5wk6gr5POhG5sl3Oy8GdZJPhpveF
         IVC6IroOVEzZzlnHemT5nbBSWu/AdczgNmXL3T13tH7THEfoF3mafc3IlneQXhWPd0AR
         FbJA==
X-Gm-Message-State: AO0yUKXAAJ5RMd4pk0ywasf5FNv0VxQT02cYWB6aSpZFR+LJxEtrJf6e
        9MJKg6P9eB2NvKEM8OoEmpcV/A==
X-Google-Smtp-Source: AK7set9O0Rzn6gceHkhyQLCg6KQ/J7lIL+u70P7LbVjJf285Bv2SVczsQHACcSpz6PjNCY+uHSpttA==
X-Received: by 2002:a05:6512:4c9:b0:4dd:d687:4ea7 with SMTP id w9-20020a05651204c900b004ddd6874ea7mr5528402lfq.36.1678347964117;
        Wed, 08 Mar 2023 23:46:04 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.219])
        by smtp.gmail.com with ESMTPSA id a6-20020a056512020600b004bb766e01a4sm2568972lfo.245.2023.03.08.23.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 23:46:03 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 09 Mar 2023 08:45:56 +0100
Subject: [PATCH v3 08/17] gpio: hisi: Convert to immutable irq_chip
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230215-immutable-chips-v3-8-972542092a77@linaro.org>
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

The IRQ chip was unnamed which seems unwise, so we just
assign the name "HISI-GPIO".

Cc: Marc Zyngier <maz@kernel.org>
Acked-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpio-hisi.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/gpio/gpio-hisi.c b/drivers/gpio/gpio-hisi.c
index 55bd69043bf4..29a03de37fd8 100644
--- a/drivers/gpio/gpio-hisi.c
+++ b/drivers/gpio/gpio-hisi.c
@@ -37,7 +37,6 @@ struct hisi_gpio {
 	struct device		*dev;
 	void __iomem		*reg_base;
 	unsigned int		line_num;
-	struct irq_chip		irq_chip;
 	int			irq;
 };
 
@@ -100,12 +99,14 @@ static void hisi_gpio_irq_set_mask(struct irq_data *d)
 	struct gpio_chip *chip = irq_data_get_irq_chip_data(d);
 
 	hisi_gpio_write_reg(chip, HISI_GPIO_INTMASK_SET_WX, BIT(irqd_to_hwirq(d)));
+	gpiochip_disable_irq(chip, irqd_to_hwirq(d));
 }
 
 static void hisi_gpio_irq_clr_mask(struct irq_data *d)
 {
 	struct gpio_chip *chip = irq_data_get_irq_chip_data(d);
 
+	gpiochip_enable_irq(chip, irqd_to_hwirq(d));
 	hisi_gpio_write_reg(chip, HISI_GPIO_INTMASK_CLR_WX, BIT(irqd_to_hwirq(d)));
 }
 
@@ -191,20 +192,24 @@ static void hisi_gpio_irq_handler(struct irq_desc *desc)
 	chained_irq_exit(irq_c, desc);
 }
 
+static const struct irq_chip hisi_gpio_irq_chip = {
+	.name = "HISI-GPIO",
+	.irq_ack = hisi_gpio_set_ack,
+	.irq_mask = hisi_gpio_irq_set_mask,
+	.irq_unmask = hisi_gpio_irq_clr_mask,
+	.irq_set_type = hisi_gpio_irq_set_type,
+	.irq_enable = hisi_gpio_irq_enable,
+	.irq_disable = hisi_gpio_irq_disable,
+	.flags = IRQCHIP_IMMUTABLE,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
+};
+
 static void hisi_gpio_init_irq(struct hisi_gpio *hisi_gpio)
 {
 	struct gpio_chip *chip = &hisi_gpio->chip;
 	struct gpio_irq_chip *girq_chip = &chip->irq;
 
-	/* Set hooks for irq_chip */
-	hisi_gpio->irq_chip.irq_ack = hisi_gpio_set_ack;
-	hisi_gpio->irq_chip.irq_mask = hisi_gpio_irq_set_mask;
-	hisi_gpio->irq_chip.irq_unmask = hisi_gpio_irq_clr_mask;
-	hisi_gpio->irq_chip.irq_set_type = hisi_gpio_irq_set_type;
-	hisi_gpio->irq_chip.irq_enable = hisi_gpio_irq_enable;
-	hisi_gpio->irq_chip.irq_disable = hisi_gpio_irq_disable;
-
-	girq_chip->chip = &hisi_gpio->irq_chip;
+	gpio_irq_chip_set_chip(girq_chip, &hisi_gpio_irq_chip);
 	girq_chip->default_type = IRQ_TYPE_NONE;
 	girq_chip->num_parents = 1;
 	girq_chip->parents = &hisi_gpio->irq;

-- 
2.34.1

