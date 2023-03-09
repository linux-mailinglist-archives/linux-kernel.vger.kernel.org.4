Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321616B1CCC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 08:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjCIHrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 02:47:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbjCIHqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 02:46:30 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22EEDF720
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 23:46:07 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id i9so1157712lfc.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 23:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678347967;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nj6jio3cM/arnjJ3w8Z7XTVvD/CZOiBuUJssoRypJa0=;
        b=xwf8KALZLR0nIYkuFjQZGVcY2mmqSH9Bfzggzf2PNDHJUzO3FLSp55bkFvwwJSjugU
         bySHixGlQTucE5mALVhMAqd0U+SRxp4YOp92wG1995YoeXHMhdFR3yToSBGokblA+vvP
         memzY3k/ZT9CqUyFJw0X9S2BjjUsf9rzmVL+yqMBnchOcpNOFJ1qUcxjGEm8hYv+nACV
         BjEEZ/dQQF5gc2Is9vQYGVC+P6zD65aux1fObZAcWAyhb9Uw2cwVjkKt23QS8an5bAgg
         zOP52WaV4fGwrWmCuf1qkEqT69qCzTzLIdQrXVCadt6QYxOuR83ew8G9YRq2lNEF30VF
         DUKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678347967;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nj6jio3cM/arnjJ3w8Z7XTVvD/CZOiBuUJssoRypJa0=;
        b=1TjoxJXyfkqk2ldbwqxupruXXReTzO4QBXEm+3txVs/GZyeKso6WDnP81RIdeFZfpL
         rSbu1zz4VMa6JmBn2ELugk/6Cyx8CEEuFg8CkyM5xX6gizjKkbvpgO3ID7wSGaI5OKAF
         66unQFNNypZKbh9dr3DTnxILpPmkAklBRDt95UKGqpiIVSEFYqTPhgR6p4zCIlhZsT7o
         2XIQGA5QC7hqGi33bSf+1McE+bYwV6leiCWiXzriVv8HamQh4oRnIQ0iA8doxczFRxc8
         ysY1ModVHZDDkJtLK1qkrEtu592HC53CugmKxNUch9amgfHfSCEJCUXwaW2KrRSUilyI
         BOcw==
X-Gm-Message-State: AO0yUKX/i5AQMcvmOf/Y807LM7/UIxrECp9vnQfF48gDYTQGicSwGh+V
        y7AbsI6VTEy3sqoEviE48L/ELA==
X-Google-Smtp-Source: AK7set+7SeKoeP6ww+p3rAPDNpLbeniGpZIzW6H3NPKfLtikv3/3WvapNsR2GFMi6AMLr1TPdSWKnQ==
X-Received: by 2002:a19:a416:0:b0:4dd:a025:d8e with SMTP id q22-20020a19a416000000b004dda0250d8emr6336857lfc.47.1678347967362;
        Wed, 08 Mar 2023 23:46:07 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.219])
        by smtp.gmail.com with ESMTPSA id a6-20020a056512020600b004bb766e01a4sm2568972lfo.245.2023.03.08.23.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 23:46:07 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 09 Mar 2023 08:45:59 +0100
Subject: [PATCH v3 11/17] gpio: msc313: Convert to immutable irq_chip
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230215-immutable-chips-v3-11-972542092a77@linaro.org>
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

