Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8FF6B1CC0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 08:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjCIHqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 02:46:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjCIHqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 02:46:07 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F5DDD37E
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 23:46:04 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id i28so1206250lfv.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 23:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678347963;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YxZa+3MhOrXUUjhkc+LrGW+xXurv1Litsrz7qLnZ7aI=;
        b=t8rkah655HCn9cL1h3Am/2+vV9AgN0P4gZ9nz2b0HxputsAayTbj821PqUa7otUYtR
         4rT352da4OCJCfzzGkx9v813htRdIT96XMYNv1//VWUxakgKq165OFenRYcp5/5kdn30
         Ag75I+gOCogp/+q0kzxvJtJZogUvIVcQ6yVAT6f0Y/qOf2S88dCiQqa5kz0UCIj+C6e6
         1m4ygY3ig91t87dlglPlwRBVeCJWVMX0RsTwJN65yun6okbknftwuSQ0DyUnVS6P73If
         0ODs59J99Vwr19HNTlOec8uCB7RYpPoN87qHQYs/v3qQNAJdhj0QMK29Zyylffu6ehsm
         KNbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678347963;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YxZa+3MhOrXUUjhkc+LrGW+xXurv1Litsrz7qLnZ7aI=;
        b=zQ1MCXy6nyapOSmCkDSe3wlvhPb1UGdHQWXm480+r7rhRtTZz0p4EKfT5/vNuMecCq
         YuWCNr97aI2x+SkbMABsQKTtNxjmueQtXY+Zi5Ml8q1UWCRzBOi63eYuEnU1ugXaZ1gT
         xx1Sfu8ZUIef8+cEgO/W8RNXed5W6jIOoxkazIMf2tOg2EBUy8w0n42s2uVHg2ukMCo8
         HP3zTG8Es2awcfUqz6bJ5NZCZn1rvtgcIx2HqIWt9lyH3MK7YMTcbd6usgsOGSI6J3Sz
         tJgS/s5uPs8B1byHuBXDmAQvynlRYHkLsQspRePQZED6YPezAJHqPWCwibh2kZyg5p2u
         pvww==
X-Gm-Message-State: AO0yUKVensugYkHflnqhgnxBLLzORmbjtfbsrLYeB0YvZ9MuD6twFwmg
        CFROQHuDW+XTnmY4tOoVIXJ2zw==
X-Google-Smtp-Source: AK7set9+YUkmbffwVNF3AIk/o8rXQz65/wJCi4qVl7hoX4l3kYgknjGEoz/Z3F52gOsCNKsSA4bbQA==
X-Received: by 2002:ac2:4475:0:b0:4b0:1305:6e02 with SMTP id y21-20020ac24475000000b004b013056e02mr6031006lfl.8.1678347962992;
        Wed, 08 Mar 2023 23:46:02 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.219])
        by smtp.gmail.com with ESMTPSA id a6-20020a056512020600b004bb766e01a4sm2568972lfo.245.2023.03.08.23.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 23:46:02 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 09 Mar 2023 08:45:55 +0100
Subject: [PATCH v3 07/17] gpio: cadence: Convert to immutable irq_chip
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230215-immutable-chips-v3-7-972542092a77@linaro.org>
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
 drivers/gpio/gpio-cadence.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-cadence.c b/drivers/gpio/gpio-cadence.c
index 137aea49ba02..3720b90cad10 100644
--- a/drivers/gpio/gpio-cadence.c
+++ b/drivers/gpio/gpio-cadence.c
@@ -70,6 +70,7 @@ static void cdns_gpio_irq_mask(struct irq_data *d)
 	struct cdns_gpio_chip *cgpio = gpiochip_get_data(chip);
 
 	iowrite32(BIT(d->hwirq), cgpio->regs + CDNS_GPIO_IRQ_DIS);
+	gpiochip_disable_irq(chip, irqd_to_hwirq(d));
 }
 
 static void cdns_gpio_irq_unmask(struct irq_data *d)
@@ -77,6 +78,7 @@ static void cdns_gpio_irq_unmask(struct irq_data *d)
 	struct gpio_chip *chip = irq_data_get_irq_chip_data(d);
 	struct cdns_gpio_chip *cgpio = gpiochip_get_data(chip);
 
+	gpiochip_enable_irq(chip, irqd_to_hwirq(d));
 	iowrite32(BIT(d->hwirq), cgpio->regs + CDNS_GPIO_IRQ_EN);
 }
 
@@ -138,11 +140,13 @@ static void cdns_gpio_irq_handler(struct irq_desc *desc)
 	chained_irq_exit(irqchip, desc);
 }
 
-static struct irq_chip cdns_gpio_irqchip = {
+static const struct irq_chip cdns_gpio_irqchip = {
 	.name		= "cdns-gpio",
 	.irq_mask	= cdns_gpio_irq_mask,
 	.irq_unmask	= cdns_gpio_irq_unmask,
-	.irq_set_type	= cdns_gpio_irq_set_type
+	.irq_set_type	= cdns_gpio_irq_set_type,
+	.flags		= IRQCHIP_IMMUTABLE,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
 };
 
 static int cdns_gpio_probe(struct platform_device *pdev)
@@ -222,7 +226,7 @@ static int cdns_gpio_probe(struct platform_device *pdev)
 		struct gpio_irq_chip *girq;
 
 		girq = &cgpio->gc.irq;
-		girq->chip = &cdns_gpio_irqchip;
+		gpio_irq_chip_set_chip(girq, &cdns_gpio_irqchip);
 		girq->parent_handler = cdns_gpio_irq_handler;
 		girq->num_parents = 1;
 		girq->parents = devm_kcalloc(&pdev->dev, 1,

-- 
2.34.1

