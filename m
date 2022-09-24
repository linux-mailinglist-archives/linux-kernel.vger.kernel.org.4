Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A85895E88AA
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 08:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233357AbiIXGEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 02:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233150AbiIXGEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 02:04:39 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49122B48B
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 23:04:34 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id bh13so2079586pgb.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 23:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=LyNPBwWe6WJ8KkBMqAVwuLs9djH6Di1aX2hj4xy6qDI=;
        b=dbPjlxIIex6Fpz9F6nzQnyipqNAtcWfXCZM9DAWBw4UEiJ6VTc3PLiSGBorz9TiZvm
         fGsP/A1jb6Hgq4U3hPtp//vYhb6idKCc0+4CabUyRXHyCmKOnuE5L9i6KAxpy3fk5V9z
         8yUqXl/ItS4jf41JhhQ0OJ/E8lwHhv5pND1vqGdnY3TU8suC7JCwUJC1d4G49vv+zUb0
         +J8q9qos/kwpAx1/saFl4Fd5DuP+Blrc9Ck/k1tHK7APX75k+8IjPHrPiEKdPyRZzxG9
         SjfZlbX6tfCZ/rnckn5hyNww/fiesApYFkKI47LdLnBn/tJ3E+zs65eTseg/98gqiSwT
         fokg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=LyNPBwWe6WJ8KkBMqAVwuLs9djH6Di1aX2hj4xy6qDI=;
        b=yJWUkvqh0AX8My1/cl8XJ0mN+Qun7YbdlziVuaekSc1zcak8V3MNhQtQb0z0CbDQbd
         3GKNiqSjqVn3fqfuiKMdzzuCn/XArSmBqP75whZr6r/JuNtzO7O8GqVZs28mfWpa95Ja
         VW1vAT4IiFNvaS6hwKTDagZidSNMavBVYWwAi9Cb1lD8+GFRcM8UHsM/T2mesfxu72zX
         7oLaaVUP/AIc1IkFMpPBAPaVLLmTwJlwQLHQH/XSxGoaNBpaSX5lgrgsj3Jur5sq6g+i
         Wk8H8oiU+z05GkjQkpF0Ts1+tX3fSLbkNUHPpvw4N9OloJOYUW77jdWRUTHjyYf2os/I
         xOdg==
X-Gm-Message-State: ACrzQf15MkAUKM2Ldv3I+QZlhY32ZKyt+55xn1M15g0WYcH8r2ELtxwD
        OpJv1rK4LFx12jnB0yK8CsA=
X-Google-Smtp-Source: AMsMyM6gnyI/juUK1cmRAKqONnTVudQlkLyQ47gbrzxYE45IKsvkA1sdXvvKl4X5x3K2CUZ3C+Hskg==
X-Received: by 2002:a63:85c6:0:b0:43a:eb08:6ea7 with SMTP id u189-20020a6385c6000000b0043aeb086ea7mr10866888pgd.336.1663999473442;
        Fri, 23 Sep 2022 23:04:33 -0700 (PDT)
Received: from penguin (c-73-63-252-74.hsd1.ca.comcast.net. [73.63.252.74])
        by smtp.gmail.com with ESMTPSA id k1-20020aa79981000000b0053e72ed5252sm7501729pfh.42.2022.09.23.23.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 23:04:32 -0700 (PDT)
Date:   Fri, 23 Sep 2022 23:04:29 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pcmcia: at91_cf: switch to using gpiod API
Message-ID: <Yy6d7TjqzUwGQnQa@penguin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch switches the driver to use newer gpiod API instead of legacy
gpio API. This moves us closer to the goal of stopping exporting
OF-specific APIs of gpiolib.

While at it, stop using module-global for regmap.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/pcmcia/at91_cf.c | 116 ++++++++++++++++++++-------------------
 1 file changed, 60 insertions(+), 56 deletions(-)

diff --git a/drivers/pcmcia/at91_cf.c b/drivers/pcmcia/at91_cf.c
index 92df2c2c5d07..4ae790d00fd6 100644
--- a/drivers/pcmcia/at91_cf.c
+++ b/drivers/pcmcia/at91_cf.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2005 David Brownell
  */
 
+#include <linux/err.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
@@ -12,14 +13,13 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/slab.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/io.h>
 #include <linux/sizes.h>
 #include <linux/mfd/syscon.h>
 #include <linux/mfd/syscon/atmel-mc.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
-#include <linux/of_gpio.h>
 #include <linux/pci.h>
 #include <linux/regmap.h>
 
@@ -36,18 +36,17 @@
 #define	CF_MEM_PHYS	(0x017ff800)
 
 struct at91_cf_data {
-	int	irq_pin;		/* I/O IRQ */
-	int	det_pin;		/* Card detect */
-	int	vcc_pin;		/* power switching */
-	int	rst_pin;		/* card reset */
+	struct gpio_desc *irq_pin;	/* I/O IRQ */
+	struct gpio_desc *det_pin;	/* Card detect */
+	struct gpio_desc *vcc_pin;	/* power switching */
+	struct gpio_desc *rst_pin;	/* card reset */
+	struct regmap *mc;
 	u8	chipselect;		/* EBI Chip Select number */
 	u8	flags;
 #define AT91_CF_TRUE_IDE	0x01
 #define AT91_IDE_SWAP_A0_A2	0x02
 };
 
-struct regmap *mc;
-
 /*--------------------------------------------------------------------------*/
 
 struct at91_cf_socket {
@@ -63,7 +62,7 @@ struct at91_cf_socket {
 
 static inline int at91_cf_present(struct at91_cf_socket *cf)
 {
-	return !gpio_get_value(cf->board->det_pin);
+	return gpiod_get_value(cf->board->det_pin);
 }
 
 /*--------------------------------------------------------------------------*/
@@ -77,7 +76,7 @@ static irqreturn_t at91_cf_irq(int irq, void *_cf)
 {
 	struct at91_cf_socket *cf = _cf;
 
-	if (irq == gpio_to_irq(cf->board->det_pin)) {
+	if (irq == gpiod_to_irq(cf->board->det_pin)) {
 		unsigned present = at91_cf_present(cf);
 
 		/* kick pccard as needed */
@@ -103,16 +102,15 @@ static int at91_cf_get_status(struct pcmcia_socket *s, u_int *sp)
 
 	/* NOTE: CF is always 3VCARD */
 	if (at91_cf_present(cf)) {
-		int rdy	= gpio_is_valid(cf->board->irq_pin);	/* RDY/nIRQ */
-		int vcc	= gpio_is_valid(cf->board->vcc_pin);
-
 		*sp = SS_DETECT | SS_3VCARD;
-		if (!rdy || gpio_get_value(cf->board->irq_pin))
+		/* RDY/nIRQ */
+		if (!cf->board->irq_pin || gpiod_get_value(cf->board->irq_pin))
 			*sp |= SS_READY;
-		if (!vcc || gpio_get_value(cf->board->vcc_pin))
+		if (!cf->board->vcc_pin || gpiod_get_value(cf->board->vcc_pin))
 			*sp |= SS_POWERON;
-	} else
+	} else {
 		*sp = 0;
+	}
 
 	return 0;
 }
@@ -125,13 +123,13 @@ at91_cf_set_socket(struct pcmcia_socket *sock, struct socket_state_t *s)
 	cf = container_of(sock, struct at91_cf_socket, socket);
 
 	/* switch Vcc if needed and possible */
-	if (gpio_is_valid(cf->board->vcc_pin)) {
+	if (cf->board->vcc_pin) {
 		switch (s->Vcc) {
 		case 0:
-			gpio_set_value(cf->board->vcc_pin, 0);
+			gpiod_set_value(cf->board->vcc_pin, 0);
 			break;
 		case 33:
-			gpio_set_value(cf->board->vcc_pin, 1);
+			gpiod_set_value(cf->board->vcc_pin, 1);
 			break;
 		default:
 			return -EINVAL;
@@ -139,7 +137,7 @@ at91_cf_set_socket(struct pcmcia_socket *sock, struct socket_state_t *s)
 	}
 
 	/* toggle reset if needed */
-	gpio_set_value(cf->board->rst_pin, s->flags & SS_RESET);
+	gpiod_set_value(cf->board->rst_pin, s->flags & SS_RESET);
 
 	dev_dbg(&cf->pdev->dev, "Vcc %d, io_irq %d, flags %04x csc %04x\n",
 				s->Vcc, s->io_irq, s->flags, s->csc_mask);
@@ -180,7 +178,8 @@ static int at91_cf_set_io_map(struct pcmcia_socket *s, struct pccard_io_map *io)
 		csr = AT91_MC_SMC_DBW_16;
 		dev_dbg(&cf->pdev->dev, "16bit i/o bus\n");
 	}
-	regmap_update_bits(mc, AT91_MC_SMC_CSR(cf->board->chipselect),
+	regmap_update_bits(cf->board->mc,
+			   AT91_MC_SMC_CSR(cf->board->chipselect),
 			   AT91_MC_SMC_DBW, csr);
 
 	io->start = cf->socket.io_offset;
@@ -238,17 +237,9 @@ static int at91_cf_probe(struct platform_device *pdev)
 	if (!board)
 		return -ENOMEM;
 
-	board->irq_pin = of_get_gpio(pdev->dev.of_node, 0);
-	board->det_pin = of_get_gpio(pdev->dev.of_node, 1);
-	board->vcc_pin = of_get_gpio(pdev->dev.of_node, 2);
-	board->rst_pin = of_get_gpio(pdev->dev.of_node, 3);
-
-	mc = syscon_regmap_lookup_by_compatible("atmel,at91rm9200-sdramc");
-	if (IS_ERR(mc))
-		return PTR_ERR(mc);
-
-	if (!gpio_is_valid(board->det_pin) || !gpio_is_valid(board->rst_pin))
-		return -ENODEV;
+	board->mc = syscon_regmap_lookup_by_compatible("atmel,at91rm9200-sdramc");
+	if (IS_ERR(board->mc))
+		return PTR_ERR(board->mc);
 
 	io = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!io)
@@ -264,26 +255,34 @@ static int at91_cf_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, cf);
 
 	/* must be a GPIO; ergo must trigger on both edges */
-	status = devm_gpio_request(&pdev->dev, board->det_pin, "cf_det");
-	if (status < 0)
+	board->det_pin = devm_gpiod_get_index(&pdev->dev, NULL, 1, GPIOD_IN);
+	status = PTR_ERR_OR_ZERO(board->det_pin);
+	if (status)
 		return status;
 
-	status = devm_request_irq(&pdev->dev, gpio_to_irq(board->det_pin),
+	gpiod_set_consumer_name(board->det_pin, "cf_det");
+
+	status = devm_request_irq(&pdev->dev, gpiod_to_irq(board->det_pin),
 					at91_cf_irq, 0, "at91_cf detect", cf);
 	if (status < 0)
 		return status;
 
 	device_init_wakeup(&pdev->dev, 1);
 
-	status = devm_gpio_request(&pdev->dev, board->rst_pin, "cf_rst");
-	if (status < 0)
+	board->rst_pin = devm_gpiod_get_index(&pdev->dev, NULL, 3, GPIOD_ASIS);
+	status = PTR_ERR_OR_ZERO(board->rst_pin);
+	if (status)
 		goto fail0a;
 
-	if (gpio_is_valid(board->vcc_pin)) {
-		status = devm_gpio_request(&pdev->dev, board->vcc_pin, "cf_vcc");
-		if (status < 0)
-			goto fail0a;
-	}
+	gpiod_set_consumer_name(board->rst_pin, "cf_rst");
+
+	board->vcc_pin = devm_gpiod_get_index_optional(&pdev->dev,
+						      NULL, 2, GPIOD_ASIS);
+	status = PTR_ERR_OR_ZERO(board->rst_pin);
+	if (status)
+		goto fail0a;
+
+	gpiod_set_consumer_name(board->vcc_pin, "cf_vcc");
 
 	/*
 	 * The card driver will request this irq later as needed.
@@ -291,18 +290,23 @@ static int at91_cf_probe(struct platform_device *pdev)
 	 * unless we report that we handle everything (sigh).
 	 * (Note:  DK board doesn't wire the IRQ pin...)
 	 */
-	if (gpio_is_valid(board->irq_pin)) {
-		status = devm_gpio_request(&pdev->dev, board->irq_pin, "cf_irq");
-		if (status < 0)
-			goto fail0a;
+	board->irq_pin = devm_gpiod_get_index_optional(&pdev->dev,
+						      NULL, 0, GPIOD_IN);
+	status = PTR_ERR_OR_ZERO(board->irq_pin);
+	if (status)
+		goto fail0a;
 
-		status = devm_request_irq(&pdev->dev, gpio_to_irq(board->irq_pin),
+	if (board->irq_pin) {
+		gpiod_set_consumer_name(board->irq_pin, "cf_irq");
+
+		status = devm_request_irq(&pdev->dev, gpiod_to_irq(board->irq_pin),
 					at91_cf_irq, IRQF_SHARED, "at91_cf", cf);
 		if (status < 0)
 			goto fail0a;
-		cf->socket.pci_irq = gpio_to_irq(board->irq_pin);
-	} else
+		cf->socket.pci_irq = gpiod_to_irq(board->irq_pin);
+	} else {
 		cf->socket.pci_irq = nr_irqs + 1;
+	}
 
 	/*
 	 * pcmcia layer only remaps "real" memory not iospace
@@ -322,7 +326,7 @@ static int at91_cf_probe(struct platform_device *pdev)
 	}
 
 	dev_info(&pdev->dev, "irqs det #%d, io #%d\n",
-		gpio_to_irq(board->det_pin), gpio_to_irq(board->irq_pin));
+		gpiod_to_irq(board->det_pin), gpiod_to_irq(board->irq_pin));
 
 	cf->socket.owner = THIS_MODULE;
 	cf->socket.dev.parent = &pdev->dev;
@@ -362,9 +366,9 @@ static int at91_cf_suspend(struct platform_device *pdev, pm_message_t mesg)
 	struct at91_cf_data	*board = cf->board;
 
 	if (device_may_wakeup(&pdev->dev)) {
-		enable_irq_wake(gpio_to_irq(board->det_pin));
-		if (gpio_is_valid(board->irq_pin))
-			enable_irq_wake(gpio_to_irq(board->irq_pin));
+		enable_irq_wake(gpiod_to_irq(board->det_pin));
+		if (board->irq_pin)
+			enable_irq_wake(gpiod_to_irq(board->irq_pin));
 	}
 	return 0;
 }
@@ -375,9 +379,9 @@ static int at91_cf_resume(struct platform_device *pdev)
 	struct at91_cf_data	*board = cf->board;
 
 	if (device_may_wakeup(&pdev->dev)) {
-		disable_irq_wake(gpio_to_irq(board->det_pin));
-		if (gpio_is_valid(board->irq_pin))
-			disable_irq_wake(gpio_to_irq(board->irq_pin));
+		disable_irq_wake(gpiod_to_irq(board->det_pin));
+		if (board->irq_pin)
+			disable_irq_wake(gpiod_to_irq(board->irq_pin));
 	}
 
 	return 0;
-- 
2.30.2


-- 
Dmitry
