Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 954226ADFDC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 14:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjCGNF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 08:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjCGNFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 08:05:36 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66EFE4FF04
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 05:05:05 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id r27so16941816lfe.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 05:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678194291;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YxZa+3MhOrXUUjhkc+LrGW+xXurv1Litsrz7qLnZ7aI=;
        b=FOsLAFR4aJaT6cegudEG+nQzhg/px9P0RBR3m2KqmJXANgyhdZkOgw0Oqs/2NwomjO
         cNp7npQYIZ+zBcHN1RcsOqNPaVgcLdlTzLmwbqXXbqyAa6DWI8nttbGR7YVg52zyxiR8
         QffXvLy84zDBN8oWts17U5XpHOEecbe58+/BwLQ4VQrLqhk6whlyMPWoOYE4iA63xJ+j
         4wJ+sxiQhb3y2ftp6oQrPLYWIJ4Cbk97ymR5SrP+I1yi/Jf4gNaYHRxRtJ+R4gpuOI/F
         /Zdq9EgQ+4blVaLXq6zhOfo0Nkyxh1Hprys2CEK6+yjk/dZCdyWL79gAm8XIOJ+ew0Dx
         xepA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678194291;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YxZa+3MhOrXUUjhkc+LrGW+xXurv1Litsrz7qLnZ7aI=;
        b=1tuXsX3lJ8yEyK6Kr2SqBw/50/C4et7zc2R/Q7pWjXECvmO8eeyPXVT8+m3X7X29De
         AGJz1/0bBsXoEDNk745LHgctzW2fkg3utexb3zKfMPDJdhFgMcxq2U7kWY8T09YGwsB2
         WDuCfHvPYTY2LUUVu9bZWfxRlPvjBF18Se8vNYJPrb4/1JDj8E7Im26tgoQK0o9GaDug
         5+gTgdfqOXWgFsUHnJfLoeUe0zqsGLu/STAumCniksYDAJNSIvt4lAIWpnQ1KP75WEOl
         kjQNlkKsbX7hNPVPVE9KHvSB94x/3ewdRPeBlodIwdsD94iOHijchZV7YspJH8taoXwb
         E/Pw==
X-Gm-Message-State: AO0yUKWCYqEEv6GyKO4QppoLCBRem4YlHCeUZYkknMEvm1Spke5m/nBp
        UTzCQSC5uSO6zxb3iOSJ4LLWyg==
X-Google-Smtp-Source: AK7set+G1fG9oVwtlrbXsTuC1Xj1dVb/epzn2WdT/mLhlI1kqvrL2HGEs2SVGZUSSYmXicyy5x+ljw==
X-Received: by 2002:a05:6512:10c2:b0:4d8:86c1:4772 with SMTP id k2-20020a05651210c200b004d886c14772mr4298774lfg.7.1678194291670;
        Tue, 07 Mar 2023 05:04:51 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.219])
        by smtp.gmail.com with ESMTPSA id w14-20020ac2598e000000b004caf992bba9sm2030548lfn.268.2023.03.07.05.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 05:04:51 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 07 Mar 2023 14:04:48 +0100
Subject: [PATCH v2 06/16] gpio: cadence: Convert to immutable irq_chip
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230215-immutable-chips-v2-6-d6b0e3f2d991@linaro.org>
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

