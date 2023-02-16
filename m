Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EADC069993B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 16:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbjBPPt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 10:49:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbjBPPtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 10:49:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDED4BE9D;
        Thu, 16 Feb 2023 07:49:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 37C5AB8288D;
        Thu, 16 Feb 2023 15:49:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18673C433D2;
        Thu, 16 Feb 2023 15:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676562582;
        bh=ZMy/7K0GrqhyVPHagfn1voqoG6ZPydbo2TAU4MYQvgM=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=Sf4QKmtIspOFqEKH/6aztwlvEabpHI2sepZLloMpzTsqe3ilHM7YcDqVYSqKFQT6C
         cTOwaf3igymSEITTEOOO2YTDX0UJJWpNYyvGVM6tliXqmn4R+4cWIJuV4iqVmsM8pC
         WMwnv+Kjdqcz4qSA2libZ8aqfIRzsLYmEOHitTl4B+I6wrmVkQBnb5fR6OzwYLdy8H
         AEqW34z9x+NkdsOqxl2lxzK/PyuNiUpANWdyt9Y36SDg3ksKGV4LUaGfiiejqaW5Wk
         EolrO9D6/rhAv0kCq+H2iD8Zx/LpQuoeph1cOlrrngOD38ZJGKHHW49YQ5k6PYouKE
         wZo9o7bpyoicg==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 16 Feb 2023 15:43:57 +0000
Subject: [PATCH 1/2] pinctrl: at91: Make the irqchip immutable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230216-gpio-at91-immutable-v1-1-44f52f148ab9@kernel.org>
References: <20230216-gpio-at91-immutable-v1-0-44f52f148ab9@kernel.org>
In-Reply-To: <20230216-gpio-at91-immutable-v1-0-44f52f148ab9@kernel.org>
To:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3089; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ZMy/7K0GrqhyVPHagfn1voqoG6ZPydbo2TAU4MYQvgM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBj7lCPT+JiHe1zqX049WAmrla9tn3RtNpXWoikTUfr
 j/lqGQyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY+5QjwAKCRAk1otyXVSH0OswB/
 wIOv+I7IY8diRY7euJLXLIVxNgVadI/efZkeZdDCDZyTNinMBX+N9xnIWG7UTuWMUJV7fLwiU2QUEf
 0EvP7yzkC8//YI2R0jFNcTidUR5E1lxjMGlBY247sOI4H586mjtmAUghZAGSj1y71a0CATQTMV5nhP
 B2c+uKuRgCgSLChIIlZnkxnZAdwnZBpbo42vdk8e8Mf8TLaEiPY8wyvpbrNhqZlTHQo7aQ9+nvx7XX
 imZkDOjNvx7pUH0Fa/sYAYe3pHEMsFPkoAxCmOK3iP9GhxNt6FO7sEaEgr3zSt/J5uVWsvFYbQhJE/
 fBn/KhUQEQdaS06H+wx0iykoe7W8S8
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To help gpiolib not fiddle around with the internals of the irqchip
flag the chip as immutable, adding the calls into the gpiolib core
required to do so.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/pinctrl/pinctrl-at91.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index 1e1813d7c550..8ecf52ec9b9b 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -1536,6 +1536,20 @@ static void at91_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
 #define at91_gpio_dbg_show	NULL
 #endif
 
+static int gpio_irq_request_resources(struct irq_data *d)
+{
+	struct at91_gpio_chip *at91_gpio = irq_data_get_irq_chip_data(d);
+
+	return gpiochip_lock_as_irq(&at91_gpio->chip, irqd_to_hwirq(d));
+}
+
+static void gpio_irq_release_resources(struct irq_data *d)
+{
+	struct at91_gpio_chip *at91_gpio = irq_data_get_irq_chip_data(d);
+
+	gpiochip_unlock_as_irq(&at91_gpio->chip, irqd_to_hwirq(d));
+}
+
 /* Several AIC controller irqs are dispatched through this GPIO handler.
  * To use any AT91_PIN_* as an externally triggered IRQ, first call
  * at91_set_gpio_input() then maybe enable its glitch filter.
@@ -1555,6 +1569,9 @@ static void gpio_irq_mask(struct irq_data *d)
 	struct at91_gpio_chip *at91_gpio = irq_data_get_irq_chip_data(d);
 	void __iomem	*pio = at91_gpio->regbase;
 	unsigned	mask = 1 << d->hwirq;
+	unsigned        gpio = irqd_to_hwirq(d);
+
+	gpiochip_disable_irq(&at91_gpio->chip, gpio);
 
 	if (pio)
 		writel_relaxed(mask, pio + PIO_IDR);
@@ -1565,6 +1582,9 @@ static void gpio_irq_unmask(struct irq_data *d)
 	struct at91_gpio_chip *at91_gpio = irq_data_get_irq_chip_data(d);
 	void __iomem	*pio = at91_gpio->regbase;
 	unsigned	mask = 1 << d->hwirq;
+	unsigned        gpio = irqd_to_hwirq(d);
+
+	gpiochip_enable_irq(&at91_gpio->chip, gpio);
 
 	if (pio)
 		writel_relaxed(mask, pio + PIO_IER);
@@ -1731,12 +1751,15 @@ static int at91_gpio_of_irq_setup(struct platform_device *pdev,
 	at91_gpio->pioc_hwirq = irqd_to_hwirq(d);
 
 	gpio_irqchip->name = "GPIO";
+	gpio_irqchip->irq_request_resources = gpio_irq_request_resources;
+	gpio_irqchip->irq_release_resources = gpio_irq_release_resources;
 	gpio_irqchip->irq_ack = gpio_irq_ack;
 	gpio_irqchip->irq_disable = gpio_irq_mask;
 	gpio_irqchip->irq_mask = gpio_irq_mask;
 	gpio_irqchip->irq_unmask = gpio_irq_unmask;
 	gpio_irqchip->irq_set_wake = pm_ptr(gpio_irq_set_wake);
 	gpio_irqchip->irq_set_type = at91_gpio->ops->irq_type;
+	gpio_irqchip->flags = IRQCHIP_IMMUTABLE;
 
 	/* Disable irqs of this PIO controller */
 	writel_relaxed(~0, at91_gpio->regbase + PIO_IDR);
@@ -1747,7 +1770,7 @@ static int at91_gpio_of_irq_setup(struct platform_device *pdev,
 	 * interrupt.
 	 */
 	girq = &at91_gpio->chip.irq;
-	girq->chip = gpio_irqchip;
+	gpio_irq_chip_set_chip(girq, gpio_irqchip);
 	girq->default_type = IRQ_TYPE_NONE;
 	girq->handler = handle_edge_irq;
 

-- 
2.34.1

