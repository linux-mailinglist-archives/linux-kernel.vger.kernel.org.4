Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC64699002
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 10:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjBPJha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 04:37:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjBPJhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 04:37:21 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8BD4DBDD
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 01:37:12 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id c20so2024231lfv.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 01:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p9WM9bt3/Qg3GpN9YlZ5Md1vJbLQ+qCNkMONfruzQdU=;
        b=uzg/z7JsYN6JRINI2ztHDI7TVZ5gbs5hccwxhziMFWqgp6FPYevwrJdEn6294hbqEc
         9RqcwZLiwz41RhtZox1l19YuY0E3m73AHer6GaayRRRTnZ6OAnosbKbjB6277iNWM9Vx
         tFyJ4pzjpNujTKprYJmj2G6u411h5U+UNkextvLF2I63BscpPxxgRFoVyu3Kul9S9BYD
         41UJe28ggKb3d55uLsCZTOqn/FWPGtN0FB284wDKgWly9/4XXf7DDvgALtqQSVOE1mpV
         x2SXb0zMIjFSltPqWvVUOgvskt396AsontVpIlDa3gij5ylP+fLcR3RDLReVr8rfmn+a
         rNvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p9WM9bt3/Qg3GpN9YlZ5Md1vJbLQ+qCNkMONfruzQdU=;
        b=Dqe32AllDhBt0C87He7rLU7B4E1WWqK0j8IdjSt5fWw+ugHfW6BG6GmiY1XOW/t68o
         Izk/pDxRKBUZsCghhvLiQ2BnHfvTOf/XVmT8l1KSXs2N32oVlJA2nMEPV3tZrRZAgGql
         RjnpI0XgSopKY6Ur9uEVKy7QnZP39XUhPgjIzZu6HSp9VbkLG1a4hJPG8GBybPtXwzeB
         CqTWAIan2EwPc4ZCDm4FIFT6pXIj4Q3iQOPcjI/dKOVS0I07ljNyq0nIR/zw0SDd0lDq
         XgssaZvFKuHTKMoircsyf6Y7ZXeDnUCosDGuAVvD60A6XD3uZXbWn8pYzBvNxMjtOYHH
         1noA==
X-Gm-Message-State: AO0yUKXqLuQID9j4l8AzB+MDjP+HRwyhbgtuFPz6PQJCo5dWgBzVzIB/
        4mTiwjeBBi3yR2TSJ7dTebXWFQ==
X-Google-Smtp-Source: AK7set8iaxNS73z6iMuN8ou73deEBqjeFNK+tgPO89SDO4UEnUoK2/uA/aJ8sSgQCGZ7D/GOVGIFlw==
X-Received: by 2002:a19:750f:0:b0:4db:2c52:349b with SMTP id y15-20020a19750f000000b004db2c52349bmr1843213lfe.21.1676540231694;
        Thu, 16 Feb 2023 01:37:11 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.219])
        by smtp.gmail.com with ESMTPSA id r3-20020a19ac43000000b004d8758a452asm229069lfc.288.2023.02.16.01.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 01:37:11 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 16 Feb 2023 10:37:07 +0100
Subject: [PATCH 06/17] gpio: cadence: Convert to immutable irq_chip
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230215-immutable-chips-v1-6-51a8f224a5d0@linaro.org>
References: <20230215-immutable-chips-v1-0-51a8f224a5d0@linaro.org>
In-Reply-To: <20230215-immutable-chips-v1-0-51a8f224a5d0@linaro.org>
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
        Grygorii Strashko <grygorii.strashko@ti.com>,
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

