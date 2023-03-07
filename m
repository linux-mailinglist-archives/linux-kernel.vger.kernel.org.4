Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315166ADFE6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 14:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbjCGNGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 08:06:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbjCGNFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 08:05:38 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC761EBC6
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 05:05:09 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id k14so16963913lfj.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 05:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678194296;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nj6jio3cM/arnjJ3w8Z7XTVvD/CZOiBuUJssoRypJa0=;
        b=gTl0sWAHZELkBxPNjBg4QMipl5SoU+iNUQxL6p5sL5f0MBR5nPYOyZaiMzeOB+Q+xj
         3GaijKUlUOO0C2yVej7qgB6oK4tr/pCZr0ZEHV3NQ5+miMkcnDahGA/O2BQgaULoJJBd
         mU/TWvz84AOJwTsrP7ocKUZty9JD/vdR3+cBkaTmVo2RmLiLbhmhjLtFpH+IvL4FvP1U
         jQB+d450gCmiksPXVpSBV6LL4OGkFDeHg2jIJQFjV3MrsgmqD2KJ6N5fTf0JUeHvQwLI
         5NK3CVAcz1wSJrJfFumcuXHqd2qH6tJmF8ovGZVTV6xhphAgnT1ITng5XXRqFgzJSOmu
         gM5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678194296;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nj6jio3cM/arnjJ3w8Z7XTVvD/CZOiBuUJssoRypJa0=;
        b=CzR5TwNH06HhsV9rrYzS1dq1En/vZMy/FhMUp2EO86QLwMM63Pn1OfdfY2cCFt6rv2
         vInK9u+P6l2EDhE0t9YpyphcE2F1jhE5VI6/ltQ/pd+EOHxUl6yLbnwdSIr8e+C5dBVu
         06FLZJxZby21JpChF4AMg2V2JcfQVVPwvsIhCaK8mlPgT6ZDWt/wxSQh5yfj0zxOA9uf
         WFocWTnEoze0SeQS58ErgtVgZ8vgEEvJz3UeF9j3/4udzEIEk7uRcjjxrztcJ2yURuBu
         3K1bA4I8QqoVQ/r6mMnVfTco1wcsQSdawMCi0xyJvahjFiu05apUGk8ItBT/XWgfjgvb
         dagg==
X-Gm-Message-State: AO0yUKXTI4gsMIlOke7QnKdJbZB6LC40nZdCntcQzLna+HGfUzpMEVSJ
        VJ7A3mLeW/A/pv/i2kWmh2dmQg==
X-Google-Smtp-Source: AK7set9z4O5TDeAgNvJ2hZmgaZa6GINTcQ4TTJ21C+OJ5m8X3lagEuaZ48dkwefG3tKzGshJuOGmeQ==
X-Received: by 2002:ac2:4ac9:0:b0:4dc:84dd:eb91 with SMTP id m9-20020ac24ac9000000b004dc84ddeb91mr4510736lfp.22.1678194295779;
        Tue, 07 Mar 2023 05:04:55 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.219])
        by smtp.gmail.com with ESMTPSA id w14-20020ac2598e000000b004caf992bba9sm2030548lfn.268.2023.03.07.05.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 05:04:55 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 07 Mar 2023 14:04:52 +0100
Subject: [PATCH v2 10/16] gpio: msc313: Convert to immutable irq_chip
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230215-immutable-chips-v2-10-d6b0e3f2d991@linaro.org>
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
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the driver to immutable irq-chip with a bit of
intuition.

This conversion follows the pattern of the gpio-ixp4xx
hierarchical GPIO interrupt driver.

Cc: Marc Zyngier <maz@kernel.org>
Acked-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpio-msc313.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-msc313.c b/drivers/gpio/gpio-msc313.c
index b0773e5652fa..036ad2324892 100644
--- a/drivers/gpio/gpio-msc313.c
+++ b/drivers/gpio/gpio-msc313.c
@@ -532,17 +532,35 @@ static int msc313_gpio_direction_output(struct gpio_chip *chip, unsigned int off
 	return 0;
 }
 
+static void msc313_gpio_irq_mask(struct irq_data *d)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+
+	irq_chip_mask_parent(d);
+	gpiochip_disable_irq(gc, d->hwirq);
+}
+
+static void msc313_gpio_irq_unmask(struct irq_data *d)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+
+	gpiochip_enable_irq(gc, d->hwirq);
+	irq_chip_unmask_parent(d);
+}
+
 /*
  * The interrupt handling happens in the parent interrupt controller,
  * we don't do anything here.
  */
-static struct irq_chip msc313_gpio_irqchip = {
+static const struct irq_chip msc313_gpio_irqchip = {
 	.name = "GPIO",
 	.irq_eoi = irq_chip_eoi_parent,
-	.irq_mask = irq_chip_mask_parent,
-	.irq_unmask = irq_chip_unmask_parent,
+	.irq_mask = msc313_gpio_irq_mask,
+	.irq_unmask = msc313_gpio_irq_unmask,
 	.irq_set_type = irq_chip_set_type_parent,
 	.irq_set_affinity = irq_chip_set_affinity_parent,
+	.flags = IRQCHIP_IMMUTABLE,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
 };
 
 /*
@@ -644,7 +662,7 @@ static int msc313_gpio_probe(struct platform_device *pdev)
 	gpiochip->names = gpio->gpio_data->names;
 
 	gpioirqchip = &gpiochip->irq;
-	gpioirqchip->chip = &msc313_gpio_irqchip;
+	gpio_irq_chip_set_chip(gpioirqchip, &msc313_gpio_irqchip);
 	gpioirqchip->fwnode = of_node_to_fwnode(dev->of_node);
 	gpioirqchip->parent_domain = parent_domain;
 	gpioirqchip->child_to_parent_hwirq = msc313e_gpio_child_to_parent_hwirq;

-- 
2.34.1

