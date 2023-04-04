Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AABC6D5C2B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 11:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234224AbjDDJnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 05:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234310AbjDDJnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 05:43:16 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8771BF1
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 02:43:14 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id k37so41665840lfv.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 02:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680601392;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OEIEuBxKK8j0WCwoJQ18kuVBxSDA3HKgR75PLHwlYjY=;
        b=QUgnZEVbU8qkLDF2ntyTZYUEn81xMGQMTF+In3pJjOtoHeA+wHfgBjiPJd3SQo2ubS
         EdNjEPTsTPejVfxjcQyDuBp9bw6lcgMwOYJ0hzaw94espyf5V34EXkl/ZpBlcv3D9D83
         +0V2+XrzqywGLnbVfh9drT5aX/q5V4zCL36sADRuJeqAfcn/NLlq8m4DdSrZY3wG0Zi/
         q8FBEDa9RQuvXQZ0GWlpOlmM6ZZK4U1qYzUppqfAYv14x6YsE1Ip3xn/3V6DSPeA1aCF
         FhyY2tH7hm6RIvEb2q12iB15E5zC2jQ355mxMbjoyJAliFKlrL3/5gyw+cCOHZfsai7x
         J1Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680601392;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OEIEuBxKK8j0WCwoJQ18kuVBxSDA3HKgR75PLHwlYjY=;
        b=b/65aUyq8mtUQUmVlZKfMOC6e36HWWz+ZDBMxPcm/rjJAO87cbCdniifmjEPjpXo0Z
         xfADFwDZUrG7TPt86wv1LiYKsZp8GsM8EH6Vm0IcBfkJqND5KF2kleCWXLOH5RTgoywj
         XAEI2CqZyhXwkPfyAdjI6+sf57XBowN5eouWI5JrpATWh+Aij7LSyuf5lufRMabmh+i2
         uG9UiWzVWM7burKVoGxy2NOT5s/qKrX3Z+H83wG/3rATgVpKWikLGEzCX7kyREhIxOSa
         BYgkMWDHCKW9kBxl4D5J0tYEj+W3f4q352u/JmHH88R7q5rwz+Gl/UmT9zeiFzc2VEP2
         cBLQ==
X-Gm-Message-State: AAQBX9fAiRCKzi1AJ2O9T7IGgZMxOL7EPAuNKD3zwCth9MD9P3CGKy0x
        7jWU91llko+8LgZvD0qM4mkulg==
X-Google-Smtp-Source: AKy350Y1n4D3ouEbNQ+64kQoJU+ffHbBrLRRh0g8NH1+mtywafqluhvvLZ5sB6bllrfgJQ3/14bcqQ==
X-Received: by 2002:a19:ad04:0:b0:4cb:4362:381d with SMTP id t4-20020a19ad04000000b004cb4362381dmr457830lfc.62.1680601392722;
        Tue, 04 Apr 2023 02:43:12 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id l25-20020a19c219000000b004eb258f73a9sm2218443lfc.163.2023.04.04.02.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 02:43:12 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 04 Apr 2023 11:43:05 +0200
Subject: [PATCH 3/9] pinctrl: armada-37xx: Convert to immutable irq_chip
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230403-immutable-irqchips-v1-3-503788a7f6e6@linaro.org>
References: <20230403-immutable-irqchips-v1-0-503788a7f6e6@linaro.org>
In-Reply-To: <20230403-immutable-irqchips-v1-0-503788a7f6e6@linaro.org>
To:     Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <maz@kernel.org>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the driver to immutable irq-chip with a bit of
intuition.

Cc: Marc Zyngier <maz@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c | 34 ++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
index 261b46841b9f..67c6751a6f06 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
@@ -23,6 +23,7 @@
 #include <linux/platform_device.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
+#include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/string_helpers.h>
 
@@ -101,7 +102,6 @@ struct armada_37xx_pinctrl {
 	const struct armada_37xx_pin_data	*data;
 	struct device			*dev;
 	struct gpio_chip		gpio_chip;
-	struct irq_chip			irq_chip;
 	raw_spinlock_t			irq_lock;
 	struct pinctrl_desc		pctl;
 	struct pinctrl_dev		*pctl_dev;
@@ -548,6 +548,7 @@ static void armada_37xx_irq_mask(struct irq_data *d)
 	val = readl(info->base + reg);
 	writel(val & ~d->mask, info->base + reg);
 	raw_spin_unlock_irqrestore(&info->irq_lock, flags);
+	gpiochip_disable_irq(chip, irqd_to_hwirq(d));
 }
 
 static void armada_37xx_irq_unmask(struct irq_data *d)
@@ -557,6 +558,7 @@ static void armada_37xx_irq_unmask(struct irq_data *d)
 	u32 val, reg = IRQ_EN;
 	unsigned long flags;
 
+	gpiochip_enable_irq(chip, irqd_to_hwirq(d));
 	armada_37xx_irq_update_reg(&reg, d);
 	raw_spin_lock_irqsave(&info->irq_lock, flags);
 	val = readl(info->base + reg);
@@ -729,11 +731,30 @@ static unsigned int armada_37xx_irq_startup(struct irq_data *d)
 	return 0;
 }
 
+static void armada_37xx_irq_print_chip(struct irq_data *d, struct seq_file *p)
+{
+	struct gpio_chip *chip = irq_data_get_irq_chip_data(d);
+	struct armada_37xx_pinctrl *info = gpiochip_get_data(chip);
+
+	seq_printf(p, info->data->name);
+}
+
+static const struct irq_chip armada_37xx_irqchip = {
+	.irq_ack = armada_37xx_irq_ack,
+	.irq_mask = armada_37xx_irq_mask,
+	.irq_unmask = armada_37xx_irq_unmask,
+	.irq_set_wake = armada_37xx_irq_set_wake,
+	.irq_set_type = armada_37xx_irq_set_type,
+	.irq_startup = armada_37xx_irq_startup,
+	.irq_print_chip = armada_37xx_irq_print_chip,
+	.flags = IRQCHIP_IMMUTABLE,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
+};
+
 static int armada_37xx_irqchip_register(struct platform_device *pdev,
 					struct armada_37xx_pinctrl *info)
 {
 	struct gpio_chip *gc = &info->gpio_chip;
-	struct irq_chip *irqchip = &info->irq_chip;
 	struct gpio_irq_chip *girq = &gc->irq;
 	struct device_node *np = to_of_node(gc->fwnode);
 	struct device *dev = &pdev->dev;
@@ -751,14 +772,7 @@ static int armada_37xx_irqchip_register(struct platform_device *pdev,
 	if (IS_ERR(info->base))
 		return PTR_ERR(info->base);
 
-	irqchip->irq_ack = armada_37xx_irq_ack;
-	irqchip->irq_mask = armada_37xx_irq_mask;
-	irqchip->irq_unmask = armada_37xx_irq_unmask;
-	irqchip->irq_set_wake = armada_37xx_irq_set_wake;
-	irqchip->irq_set_type = armada_37xx_irq_set_type;
-	irqchip->irq_startup = armada_37xx_irq_startup;
-	irqchip->name = info->data->name;
-	girq->chip = irqchip;
+	gpio_irq_chip_set_chip(girq, &armada_37xx_irqchip);
 	girq->parent_handler = armada_37xx_irq_handler;
 	/*
 	 * Many interrupts are connected to the parent interrupt

-- 
2.34.1

