Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C1B696419
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 14:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbjBNNAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 08:00:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbjBNNAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 08:00:00 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85268273A;
        Tue, 14 Feb 2023 04:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1676379595; x=1707915595;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fpuTkZWynYxgsQG+YYF/iRN5EE7qjk+6jG6qIWNIM54=;
  b=a2Yql8JgTSkYkTeT72T8lL6H0pNbU4xXd3Se/bWBNJP6oQymwAXxApBO
   CYAPCaicGc0RN7b+05QNeMhQr11T3HiptXqgrYYHla4zwtJGHx7SDFypn
   pSYvuOwqbd4MjjzLo2dEuQicsLZSK3OYnGrHpjxmRZ9YFjuX2s8NAckKi
   O5DeaSZ3pEgNrJyu8qfaMsQyTzmynmDamHa/187kbmHAAxKukbvVwFU4R
   8PAboZbMxWzZM7ShfzY1sRAcuUaELEfc49cJWXVUcCPm+nsFFSP3KIrPU
   qwWxw5sZVM/GHIYCHyShC04M1gXnVWqmYSTWqUVS76NBF90iIP6gdgO55
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,296,1669071600"; 
   d="scan'208";a="29073403"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 14 Feb 2023 13:59:53 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Tue, 14 Feb 2023 13:59:53 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Tue, 14 Feb 2023 13:59:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1676379593; x=1707915593;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fpuTkZWynYxgsQG+YYF/iRN5EE7qjk+6jG6qIWNIM54=;
  b=DvejR1bjZL4e7iv8lvf9YrMgAf4fAREnFRYxeh62B6R+RK7IaQeNZi2w
   C8GzGnSNrC6BB/hs91YcEAktdlgp4PJ6VXsXBbW58Y0UoRRZe6W2quRlO
   Pqmiro+CZTFkWUrRVnP6VF0/57U+FboogUi2ZrtLaiEXx2bWxaqP40DPf
   dxCFccS1gWvfkbUMQ/szw/cruiM9daDr4j0d1OuxFpMmxn1J/qiYKzM/9
   ZWZfQM4yS6hwpWpuNMYA4UXfMDHrmyDKHGU1I+FAhEQcADWNG0UkSpfXb
   fQw/gb1t/Z7Kqs8/vc43QfbrSpR1FG49zzmPyi0INgRz+Cs4uimpK+V7/
   g==;
X-IronPort-AV: E=Sophos;i="5.97,296,1669071600"; 
   d="scan'208";a="29073402"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 14 Feb 2023 13:59:53 +0100
Received: from steina-w.tq-net.de (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 6EE57280056;
        Tue, 14 Feb 2023 13:59:53 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        andy.shevchenko@gmail.com
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>
Subject: [PATCH v2 1/1] gpio: vf610: make irq_chip immutable
Date:   Tue, 14 Feb 2023 13:59:49 +0100
Message-Id: <20230214125949.3462396-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since recently, the kernel is nagging about mutable irq_chips:

    "not an immutable chip, please consider fixing it!"

Drop the unneeded copy, flag it as IRQCHIP_IMMUTABLE, add the new
helper functions and call the appropriate gpiolib functions.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
Thanks Andy for the feedback!

Changes in v2:
* Add missing calls to gpiochip_disable_irq() and gpiochip_enable_irq()

 drivers/gpio/gpio-vf610.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/gpio/gpio-vf610.c b/drivers/gpio/gpio-vf610.c
index a429176673e7..b657a07a9b56 100644
--- a/drivers/gpio/gpio-vf610.c
+++ b/drivers/gpio/gpio-vf610.c
@@ -30,7 +30,6 @@ struct fsl_gpio_soc_data {
 
 struct vf610_gpio_port {
 	struct gpio_chip gc;
-	struct irq_chip ic;
 	void __iomem *base;
 	void __iomem *gpio_base;
 	const struct fsl_gpio_soc_data *sdata;
@@ -207,19 +206,23 @@ static int vf610_gpio_irq_set_type(struct irq_data *d, u32 type)
 
 static void vf610_gpio_irq_mask(struct irq_data *d)
 {
-	struct vf610_gpio_port *port =
-		gpiochip_get_data(irq_data_get_irq_chip_data(d));
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct vf610_gpio_port *port = gpiochip_get_data(gc);
 	void __iomem *pcr_base = port->base + PORT_PCR(d->hwirq);
+	irq_hw_number_t gpio_num = irqd_to_hwirq(d);
 
 	vf610_gpio_writel(0, pcr_base);
+	gpiochip_disable_irq(gc, gpio_num);
 }
 
 static void vf610_gpio_irq_unmask(struct irq_data *d)
 {
-	struct vf610_gpio_port *port =
-		gpiochip_get_data(irq_data_get_irq_chip_data(d));
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct vf610_gpio_port *port = gpiochip_get_data(gc);
 	void __iomem *pcr_base = port->base + PORT_PCR(d->hwirq);
+	irq_hw_number_t gpio_num = irqd_to_hwirq(d);
 
+	gpiochip_enable_irq(gc, gpio_num);
 	vf610_gpio_writel(port->irqc[d->hwirq] << PORT_PCR_IRQC_OFFSET,
 			  pcr_base);
 }
@@ -237,6 +240,17 @@ static int vf610_gpio_irq_set_wake(struct irq_data *d, u32 enable)
 	return 0;
 }
 
+static const struct irq_chip vf610_irqchip = {
+	.name = "gpio-vf610",
+	.irq_ack = vf610_gpio_irq_ack,
+	.irq_mask = vf610_gpio_irq_mask,
+	.irq_unmask = vf610_gpio_irq_unmask,
+	.irq_set_type = vf610_gpio_irq_set_type,
+	.irq_set_wake = vf610_gpio_irq_set_wake,
+	.flags = IRQCHIP_IMMUTABLE,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
+};
+
 static void vf610_gpio_disable_clk(void *data)
 {
 	clk_disable_unprepare(data);
@@ -249,7 +263,6 @@ static int vf610_gpio_probe(struct platform_device *pdev)
 	struct vf610_gpio_port *port;
 	struct gpio_chip *gc;
 	struct gpio_irq_chip *girq;
-	struct irq_chip *ic;
 	int i;
 	int ret;
 
@@ -315,14 +328,6 @@ static int vf610_gpio_probe(struct platform_device *pdev)
 	gc->direction_output = vf610_gpio_direction_output;
 	gc->set = vf610_gpio_set;
 
-	ic = &port->ic;
-	ic->name = "gpio-vf610";
-	ic->irq_ack = vf610_gpio_irq_ack;
-	ic->irq_mask = vf610_gpio_irq_mask;
-	ic->irq_unmask = vf610_gpio_irq_unmask;
-	ic->irq_set_type = vf610_gpio_irq_set_type;
-	ic->irq_set_wake = vf610_gpio_irq_set_wake;
-
 	/* Mask all GPIO interrupts */
 	for (i = 0; i < gc->ngpio; i++)
 		vf610_gpio_writel(0, port->base + PORT_PCR(i));
@@ -331,7 +336,7 @@ static int vf610_gpio_probe(struct platform_device *pdev)
 	vf610_gpio_writel(~0, port->base + PORT_ISFR);
 
 	girq = &gc->irq;
-	girq->chip = ic;
+	gpio_irq_chip_set_chip(girq, &vf610_irqchip);
 	girq->parent_handler = vf610_gpio_irq_handler;
 	girq->num_parents = 1;
 	girq->parents = devm_kcalloc(&pdev->dev, 1,
-- 
2.34.1

