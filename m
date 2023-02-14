Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B36C695AB2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 08:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjBNHgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 02:36:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjBNHgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 02:36:48 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B8E12F32;
        Mon, 13 Feb 2023 23:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1676360205; x=1707896205;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=q0jRgzfjk88MLjnmkmWogHFXwiLWrycu/Mr0YbBtyho=;
  b=mF7DButAltO0ZREyFfrdeUo27xIgY+yXFkrk0DY05Yx2hpAaUlLQtWMS
   pVjCqXr1K+04c9gsmDr8/9mZHgSvWS9IC6XHzDyqPjq8li4zUcw871hDg
   vwz5/rYIb2wgtunejJgkoIokGpoHNFFjxtiu52uCL6QAy87Nm0fZgmqnM
   x0E8tsGqEuMv32qr9Tm+z8iPw/PTIC31BhaICGHoGsp+lVAx+8b3uIs4l
   a9fPgztxzeMwKm3NlRXr5IvfxFaiyfsTtBKr5edck2EG4ZajcSyO/2Vef
   IX8NIFieesBxwda6qL5oHShZ6gCycB+ACo7OwGg67reO87JxgT8wLxWju
   A==;
X-IronPort-AV: E=Sophos;i="5.97,296,1669071600"; 
   d="scan'208";a="29060373"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 14 Feb 2023 08:36:42 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Tue, 14 Feb 2023 08:36:42 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Tue, 14 Feb 2023 08:36:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1676360202; x=1707896202;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=q0jRgzfjk88MLjnmkmWogHFXwiLWrycu/Mr0YbBtyho=;
  b=Bwct2luZmtOPBOlF8NVpMfPvMHfdUGir7tNGyPvsadQe4QPduE4uqEYv
   Zca4QDO0aBjflovemjR7GUA9HHBJZbBilTgMO3ThS3TbAU7qRaPbkLMXO
   rHUtGg4bNq2wUCKlL2MAjGobo5kuUGrn5xKBo3NXKsYKnDiP1B1vJ5cIN
   psDxKyW6hBss7uDoCLvSIzT+vVnze+5qB0XK3L+aYwYMUObkNvh9zK0r+
   iSmPvGD0LlImAjxOvVOsCvu0OyyDdDmYcpYJCPWzeIJgdq2kyWsSYnbXw
   6auN3Wfjk9PEelYYn+29QPOunP4MpwwY0lwLdb5VSgNgxVEmdcBCNsAt6
   w==;
X-IronPort-AV: E=Sophos;i="5.97,296,1669071600"; 
   d="scan'208";a="29060372"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 14 Feb 2023 08:36:42 +0100
Received: from steina-w.tq-net.de (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 3CD95280056;
        Tue, 14 Feb 2023 08:36:42 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>
Subject: [PATCH 1/1] gpio: vf610: make irq_chip immutable
Date:   Tue, 14 Feb 2023 08:36:38 +0100
Message-Id: <20230214073638.571417-1-alexander.stein@ew.tq-group.com>
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
The overall changes are based on commit f1138dacb7ff
("gpio: sch: make irq_chip immutable")

 drivers/gpio/gpio-vf610.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/gpio/gpio-vf610.c b/drivers/gpio/gpio-vf610.c
index a429176673e7..e63ca8c85bec 100644
--- a/drivers/gpio/gpio-vf610.c
+++ b/drivers/gpio/gpio-vf610.c
@@ -30,7 +30,6 @@ struct fsl_gpio_soc_data {
 
 struct vf610_gpio_port {
 	struct gpio_chip gc;
-	struct irq_chip ic;
 	void __iomem *base;
 	void __iomem *gpio_base;
 	const struct fsl_gpio_soc_data *sdata;
@@ -237,6 +236,17 @@ static int vf610_gpio_irq_set_wake(struct irq_data *d, u32 enable)
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
@@ -249,7 +259,6 @@ static int vf610_gpio_probe(struct platform_device *pdev)
 	struct vf610_gpio_port *port;
 	struct gpio_chip *gc;
 	struct gpio_irq_chip *girq;
-	struct irq_chip *ic;
 	int i;
 	int ret;
 
@@ -315,14 +324,6 @@ static int vf610_gpio_probe(struct platform_device *pdev)
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
@@ -331,7 +332,7 @@ static int vf610_gpio_probe(struct platform_device *pdev)
 	vf610_gpio_writel(~0, port->base + PORT_ISFR);
 
 	girq = &gc->irq;
-	girq->chip = ic;
+	gpio_irq_chip_set_chip(girq, &vf610_irqchip);
 	girq->parent_handler = vf610_gpio_irq_handler;
 	girq->num_parents = 1;
 	girq->parents = devm_kcalloc(&pdev->dev, 1,
-- 
2.34.1

