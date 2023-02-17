Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE0569B429
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 21:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjBQUqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 15:46:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjBQUqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 15:46:18 -0500
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839F062FC8;
        Fri, 17 Feb 2023 12:46:16 -0800 (PST)
Received: by mail-oi1-f179.google.com with SMTP id bk11so2351237oib.13;
        Fri, 17 Feb 2023 12:46:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PpKp+66L0fbbAMKQqh8biegp8ez57RhVOVDRZ2wuGL8=;
        b=ktySaqwp5fN3rKGlFGqdVib8KFofGzxEip+SZXBMuHkAloj3vAFP9G6yad1OG2qtkB
         /5haMWz4qe4DG4+y31zHrlnCKBhwakQwuThEwMG50LOnQLXf20aBqglSyizZDjtb0a0J
         Bl2s5VxtDcPv23wZuwHyGfHxryR0DZ4QJl9f3tQdg0pKWPncwRpY8yjkOUU/9HwgSJtL
         wwnNDMPANOdpffq/X2Hfdut9ddl6D8pzlrx+Pcp3woOiRbiX1LQlOR32tKZHPXxJmfOQ
         Mjt72IA85Kudfy3HllnUOZmcSA1LBFzIJYRiwcslBdPTfw9fZx7T5LG/JbnBXRlTk649
         t15g==
X-Gm-Message-State: AO0yUKXjfwDgFyequo0TFhDnmP0sbPu1eHeHOOO0RkvUwCld/dlUGGin
        fQW989DGNl/RXdaKnQCYhvd9r4P1+w==
X-Google-Smtp-Source: AK7set9aqsRAdgdgI4Jy/yRoE9NTtt3nX5Z92C1aACpnlKt+63b7skkrRyU61RtHhTUE37xX0vGACg==
X-Received: by 2002:a05:6808:288f:b0:37a:fcd6:5c09 with SMTP id eu15-20020a056808288f00b0037afcd65c09mr141201oib.49.1676666775463;
        Fri, 17 Feb 2023 12:46:15 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id es25-20020a056808279900b0035a9003b8edsm2193359oib.40.2023.02.17.12.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 12:46:15 -0800 (PST)
Received: (nullmailer pid 1527518 invoked by uid 1000);
        Fri, 17 Feb 2023 20:46:11 -0000
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 17 Feb 2023 14:45:42 -0600
Subject: [PATCH 3/3] spi: mpc5xxx-psc: Use platform resources instead of
 parsing DT properties
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230217-dt-mpc5xxx-spi-v1-3-3be8602fce1e@kernel.org>
References: <20230217-dt-mpc5xxx-spi-v1-0-3be8602fce1e@kernel.org>
In-Reply-To: <20230217-dt-mpc5xxx-spi-v1-0-3be8602fce1e@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13-dev
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mpc52xx-psc and mpc512x-psc drivers use DT property parsing
functions for 'reg' and 'interrupts', but those are available as
platform device resources. Convert probe functions to use them and
simplify probe to a single function. For 'cell-index', also use the
preferred typed property function.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/spi/spi-mpc512x-psc.c | 40 ++++++++--------------------------
 drivers/spi/spi-mpc52xx-psc.c | 50 +++++++++++--------------------------------
 2 files changed, 21 insertions(+), 69 deletions(-)

diff --git a/drivers/spi/spi-mpc512x-psc.c b/drivers/spi/spi-mpc512x-psc.c
index c6a610b82d4a..5bdfe4a740e9 100644
--- a/drivers/spi/spi-mpc512x-psc.c
+++ b/drivers/spi/spi-mpc512x-psc.c
@@ -14,11 +14,9 @@
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/interrupt.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
-#include <linux/of_platform.h>
 #include <linux/completion.h>
 #include <linux/io.h>
+#include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/clk.h>
 #include <linux/spi/spi.h>
@@ -458,9 +456,9 @@ static irqreturn_t mpc512x_psc_spi_isr(int irq, void *dev_id)
 	return IRQ_NONE;
 }
 
-static int mpc512x_psc_spi_do_probe(struct device *dev, u32 regaddr,
-					      u32 size, unsigned int irq)
+static int mpc512x_psc_spi_of_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct mpc512x_psc_spi *mps;
 	struct spi_master *master;
 	int ret;
@@ -473,8 +471,7 @@ static int mpc512x_psc_spi_do_probe(struct device *dev, u32 regaddr,
 
 	dev_set_drvdata(dev, master);
 	mps = spi_master_get_devdata(master);
-	mps->type = (int)of_device_get_match_data(dev);
-	mps->irq = irq;
+	mps->type = (int)device_get_match_data(dev);
 
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST;
 	master->setup = mpc512x_psc_spi_setup;
@@ -485,12 +482,14 @@ static int mpc512x_psc_spi_do_probe(struct device *dev, u32 regaddr,
 	master->cleanup = mpc512x_psc_spi_cleanup;
 	master->dev.of_node = dev->of_node;
 
-	tempp = devm_ioremap(dev, regaddr, size);
+	tempp = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
 	if (!tempp)
 		return dev_err_probe(dev, -EFAULT, "could not ioremap I/O port range\n");
 	mps->psc = tempp;
 	mps->fifo =
 		(struct mpc512x_psc_fifo *)(tempp + sizeof(struct mpc52xx_psc));
+
+	mps->irq = platform_get_irq(pdev, 0);
 	ret = devm_request_irq(dev, mps->irq, mpc512x_psc_spi_isr, IRQF_SHARED,
 				"mpc512x-psc-spi", mps);
 	if (ret)
@@ -535,9 +534,9 @@ static int mpc512x_psc_spi_do_probe(struct device *dev, u32 regaddr,
 	return ret;
 }
 
-static int mpc512x_psc_spi_do_remove(struct device *dev)
+static int mpc512x_psc_spi_of_remove(struct platform_device *pdev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
+	struct spi_master *master = dev_get_drvdata(&pdev->dev);
 	struct mpc512x_psc_spi *mps = spi_master_get_devdata(master);
 
 	clk_disable_unprepare(mps->clk_mclk);
@@ -546,27 +545,6 @@ static int mpc512x_psc_spi_do_remove(struct device *dev)
 	return 0;
 }
 
-static int mpc512x_psc_spi_of_probe(struct platform_device *op)
-{
-	const u32 *regaddr_p;
-	u64 regaddr64, size64;
-
-	regaddr_p = of_get_address(op->dev.of_node, 0, &size64, NULL);
-	if (!regaddr_p) {
-		dev_err(&op->dev, "Invalid PSC address\n");
-		return -EINVAL;
-	}
-	regaddr64 = of_translate_address(op->dev.of_node, regaddr_p);
-
-	return mpc512x_psc_spi_do_probe(&op->dev, (u32) regaddr64, (u32) size64,
-				irq_of_parse_and_map(op->dev.of_node, 0));
-}
-
-static int mpc512x_psc_spi_of_remove(struct platform_device *op)
-{
-	return mpc512x_psc_spi_do_remove(&op->dev);
-}
-
 static const struct of_device_id mpc512x_psc_spi_of_match[] = {
 	{ .compatible = "fsl,mpc5121-psc-spi", .data = (void *)TYPE_MPC5121 },
 	{ .compatible = "fsl,mpc5125-psc-spi", .data = (void *)TYPE_MPC5125 },
diff --git a/drivers/spi/spi-mpc52xx-psc.c b/drivers/spi/spi-mpc52xx-psc.c
index 7477fa152da0..95a4a511c388 100644
--- a/drivers/spi/spi-mpc52xx-psc.c
+++ b/drivers/spi/spi-mpc52xx-psc.c
@@ -11,15 +11,14 @@
 #include <linux/types.h>
 #include <linux/errno.h>
 #include <linux/interrupt.h>
-#include <linux/of_address.h>
-#include <linux/of_platform.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
 #include <linux/workqueue.h>
 #include <linux/completion.h>
 #include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/spi/spi.h>
 #include <linux/slab.h>
-#include <linux/of_irq.h>
 
 #include <asm/mpc52xx.h>
 #include <asm/mpc52xx_psc.h>
@@ -292,12 +291,12 @@ static irqreturn_t mpc52xx_psc_spi_isr(int irq, void *dev_id)
 	return IRQ_NONE;
 }
 
-/* bus_num is used only for the case dev->platform_data == NULL */
-static int mpc52xx_psc_spi_do_probe(struct device *dev, u32 regaddr,
-				u32 size, unsigned int irq, s16 bus_num)
+static int mpc52xx_psc_spi_of_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct mpc52xx_psc_spi *mps;
 	struct spi_master *master;
+	u32 bus_num;
 	int ret;
 
 	master = devm_spi_alloc_master(dev, sizeof(*mps));
@@ -310,20 +309,24 @@ static int mpc52xx_psc_spi_do_probe(struct device *dev, u32 regaddr,
 	/* the spi->mode bits understood by this driver: */
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST;
 
-	mps->irq = irq;
-	master->bus_num = bus_num;
+	ret = of_property_read_u32(dev->of_node, "cell-index", &bus_num);
+	if (ret || bus_num > 5)
+		return dev_err_probe(dev, ret ? : -EINVAL, "Invalid cell-index property\n");
+	master->bus_num = bus_num + 1;
+
 	master->num_chipselect = 255;
 	master->setup = mpc52xx_psc_spi_setup;
 	master->transfer_one_message = mpc52xx_psc_spi_transfer_one_message;
 	master->cleanup = mpc52xx_psc_spi_cleanup;
 	master->dev.of_node = dev->of_node;
 
-	mps->psc = devm_ioremap(dev, regaddr, size);
+	mps->psc = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
 	if (!mps->psc)
 		return dev_err_probe(dev, -EFAULT, "could not ioremap I/O port range\n");
 	/* On the 5200, fifo regs are immediately ajacent to the psc regs */
 	mps->fifo = ((void __iomem *)mps->psc) + sizeof(struct mpc52xx_psc);
 
+	mps->irq = platform_get_irq(pdev, 0);
 	ret = devm_request_irq(dev, mps->irq, mpc52xx_psc_spi_isr, 0,
 			       "mpc52xx-psc-spi", mps);
 	if (ret)
@@ -338,35 +341,6 @@ static int mpc52xx_psc_spi_do_probe(struct device *dev, u32 regaddr,
 	return devm_spi_register_master(dev, master);
 }
 
-static int mpc52xx_psc_spi_of_probe(struct platform_device *op)
-{
-	const u32 *regaddr_p;
-	u64 regaddr64, size64;
-	s16 id = -1;
-
-	regaddr_p = of_get_address(op->dev.of_node, 0, &size64, NULL);
-	if (!regaddr_p) {
-		dev_err(&op->dev, "Invalid PSC address\n");
-		return -EINVAL;
-	}
-	regaddr64 = of_translate_address(op->dev.of_node, regaddr_p);
-
-	/* get PSC id (1..6, used by port_config) */
-	if (op->dev.platform_data == NULL) {
-		const u32 *psc_nump;
-
-		psc_nump = of_get_property(op->dev.of_node, "cell-index", NULL);
-		if (!psc_nump || *psc_nump > 5) {
-			dev_err(&op->dev, "Invalid cell-index property\n");
-			return -EINVAL;
-		}
-		id = *psc_nump + 1;
-	}
-
-	return mpc52xx_psc_spi_do_probe(&op->dev, (u32)regaddr64, (u32)size64,
-				irq_of_parse_and_map(op->dev.of_node, 0), id);
-}
-
 static const struct of_device_id mpc52xx_psc_spi_of_match[] = {
 	{ .compatible = "fsl,mpc5200-psc-spi", },
 	{ .compatible = "mpc5200-psc-spi", }, /* old */

-- 
2.39.1

