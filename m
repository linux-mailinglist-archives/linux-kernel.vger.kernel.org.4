Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB376ADF25
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 13:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjCGMv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 07:51:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjCGMvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 07:51:48 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6807E7B9;
        Tue,  7 Mar 2023 04:51:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id F343CCE1B6B;
        Tue,  7 Mar 2023 12:51:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B388C4339C;
        Tue,  7 Mar 2023 12:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678193502;
        bh=IWd9Oaqk5hzYFUwF9cR13Rf1+gfQ9UgDEiSB8uRtlwg=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=KuYImHCaJquf8HqMPScaiJR2lp6W9mEzEi2yRdjmKK5D3XZKvMg6AihfABaeD968M
         TY09FqIyWmqvkG7NtgrLjWk9SyWH0kaSBGcfBnSthzapM11OAJy6q3AbByI59YUD/0
         WOwZkD23mGez0LDxfKB7GjoAksjwCSLB08d3D5JssyHpPNHj/mz0C7zb3fIlb9OPP5
         jcxk9CzuHaOmV4js5PlYkFYD45CUOSZhNHeNK9QIBlQCsx2Fy83OrEdzq8hUcXVg3M
         JWMtnC82WcbVRps6ET9v6+RfYESDJyVG1hudBbMuFiW+r704krFViD1vnEw2rSlzuI
         pNCFPOYfSn2xA==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 07 Mar 2023 12:51:27 +0000
Subject: [PATCH v2 1/2] pinctrl: at91: Make the irqchip immutable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230216-gpio-at91-immutable-v2-1-326ef362dbc7@kernel.org>
References: <20230216-gpio-at91-immutable-v2-0-326ef362dbc7@kernel.org>
In-Reply-To: <20230216-gpio-at91-immutable-v2-0-326ef362dbc7@kernel.org>
To:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-bd1bf
X-Developer-Signature: v=1; a=openpgp-sha256; l=3089; i=broonie@kernel.org;
 h=from:subject:message-id; bh=IWd9Oaqk5hzYFUwF9cR13Rf1+gfQ9UgDEiSB8uRtlwg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkBzNY63owOkiJaom5NFGp8rCdUFUBiegMB560vrfl
 bxsbYZOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZAczWAAKCRAk1otyXVSH0DqmB/
 9FfOXcyy58/Rbpojezo69U1IdBDCuGIKXNWUAD8rhQ04A51vGcPJH1uP92wZQRDoAMOGlptJ2N3XoU
 atoktWYBmuySTr0ytbtCQSSJnt+thvZ8KdKk5KyS/Qbx0F5czs1mvr7dVAMPCTIaP06fr7sTMDx/Ia
 MnPHKXpJ4Zb8xVQfntaDUq5VKTwo4fQOKkiODY2MN0cv7atX7MtKSYBW+LP3Ek+B6SBHf8o+0SYpSS
 rdCB350gmNxrNWwFMhbpLt283eqbme3C4DxP6AjJbxvJUgBi/Y0uvBSiue9QqyO04aGkVNikHFbbqU
 qA2nteO9PusPnDgo8SD3NxLe6umP0Q
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
index 79b7061fc8f3..1e083fc7666b 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -1526,6 +1526,20 @@ static void at91_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
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
@@ -1545,6 +1559,9 @@ static void gpio_irq_mask(struct irq_data *d)
 	struct at91_gpio_chip *at91_gpio = irq_data_get_irq_chip_data(d);
 	void __iomem	*pio = at91_gpio->regbase;
 	unsigned	mask = 1 << d->hwirq;
+	unsigned        gpio = irqd_to_hwirq(d);
+
+	gpiochip_disable_irq(&at91_gpio->chip, gpio);
 
 	if (pio)
 		writel_relaxed(mask, pio + PIO_IDR);
@@ -1555,6 +1572,9 @@ static void gpio_irq_unmask(struct irq_data *d)
 	struct at91_gpio_chip *at91_gpio = irq_data_get_irq_chip_data(d);
 	void __iomem	*pio = at91_gpio->regbase;
 	unsigned	mask = 1 << d->hwirq;
+	unsigned        gpio = irqd_to_hwirq(d);
+
+	gpiochip_enable_irq(&at91_gpio->chip, gpio);
 
 	if (pio)
 		writel_relaxed(mask, pio + PIO_IER);
@@ -1721,12 +1741,15 @@ static int at91_gpio_of_irq_setup(struct platform_device *pdev,
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
@@ -1737,7 +1760,7 @@ static int at91_gpio_of_irq_setup(struct platform_device *pdev,
 	 * interrupt.
 	 */
 	girq = &at91_gpio->chip.irq;
-	girq->chip = gpio_irqchip;
+	gpio_irq_chip_set_chip(girq, gpio_irqchip);
 	girq->default_type = IRQ_TYPE_NONE;
 	girq->handler = handle_edge_irq;
 

-- 
2.30.2

