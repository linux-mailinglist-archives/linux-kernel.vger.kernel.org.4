Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B677969B42A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 21:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjBQUq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 15:46:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjBQUqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 15:46:18 -0500
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6AE95970C;
        Fri, 17 Feb 2023 12:46:17 -0800 (PST)
Received: by mail-ot1-f41.google.com with SMTP id e18-20020a056830201200b0068bd8c1e836so416314otp.3;
        Fri, 17 Feb 2023 12:46:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y/Gw+GAu+WGGIPgicZpYCmsAgNJBx9NIhrdXTbIwsPE=;
        b=NHnABYxzLo/L4jvr2154HuhMEiSz2HV1gPdrm91i2awn7G9iXUVICZHlFe/Mn39uVG
         TpKZy8UlV50FaPsMTTAIijtpp53LmITGKFvO3LHZK/nSPHJWijjYVGlsP9MCWFpX+UKY
         dkurvjXftqNsynrmLZnMydWmAgYorJDDhcvO2GGu40TxcEkTDTgtZnv8Trv2BR3m5Da9
         rH5wvjRo1JY80JOHeSHhPCjcmgahaLim8aNe08r8kkJqVp3diQwvEqpUYRGzEo/sgn5G
         +o63QxN/JejsGA+c2vLvG5Y626NwVkJJAPZbiVmPYENsm+Ylf1GlMw/KjD+SQH+Yxroj
         UnvQ==
X-Gm-Message-State: AO0yUKVXYqsNrF+fHGzyD2qpFwEWoJsGfkoSTSU8rYOF7yzh/Nc1iYWz
        +iRFtGfz3S8TBdCVbwNNsgW73HgeUA==
X-Google-Smtp-Source: AK7set9PLW1/vYpAyHCiQ9Gf7NeoFEZ7GycKecZqsRvG6yxAhH8dy+E2002I6SdExmkdRCHckL22IQ==
X-Received: by 2002:a9d:7d86:0:b0:690:d50a:9b48 with SMTP id j6-20020a9d7d86000000b00690d50a9b48mr4355269otn.11.1676666776689;
        Fri, 17 Feb 2023 12:46:16 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p14-20020a056830130e00b0068bb7bd2668sm2277988otq.73.2023.02.17.12.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 12:46:16 -0800 (PST)
Received: (nullmailer pid 1527516 invoked by uid 1000);
        Fri, 17 Feb 2023 20:46:11 -0000
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 17 Feb 2023 14:45:41 -0600
Subject: [PATCH 2/3] spi: mpc5xxx-psc: Convert probe to use devres
 functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230217-dt-mpc5xxx-spi-v1-2-3be8602fce1e@kernel.org>
References: <20230217-dt-mpc5xxx-spi-v1-0-3be8602fce1e@kernel.org>
In-Reply-To: <20230217-dt-mpc5xxx-spi-v1-0-3be8602fce1e@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13-dev
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the mpc52xx-psc and mpc512x-psc drivers to use the managed
devres variants of functions in probe. Also use dev_err_probe() as
appropriate. With this, the error handling can be simplified.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/spi/spi-mpc512x-psc.c | 22 +++++++-----------
 drivers/spi/spi-mpc52xx-psc.c | 53 ++++++++-----------------------------------
 2 files changed, 18 insertions(+), 57 deletions(-)

diff --git a/drivers/spi/spi-mpc512x-psc.c b/drivers/spi/spi-mpc512x-psc.c
index 0b4d49ef84de..c6a610b82d4a 100644
--- a/drivers/spi/spi-mpc512x-psc.c
+++ b/drivers/spi/spi-mpc512x-psc.c
@@ -467,7 +467,7 @@ static int mpc512x_psc_spi_do_probe(struct device *dev, u32 regaddr,
 	void *tempp;
 	struct clk *clk;
 
-	master = spi_alloc_master(dev, sizeof(*mps));
+	master = devm_spi_alloc_master(dev, sizeof(*mps));
 	if (master == NULL)
 		return -ENOMEM;
 
@@ -486,28 +486,24 @@ static int mpc512x_psc_spi_do_probe(struct device *dev, u32 regaddr,
 	master->dev.of_node = dev->of_node;
 
 	tempp = devm_ioremap(dev, regaddr, size);
-	if (!tempp) {
-		dev_err(dev, "could not ioremap I/O port range\n");
-		ret = -EFAULT;
-		goto free_master;
-	}
+	if (!tempp)
+		return dev_err_probe(dev, -EFAULT, "could not ioremap I/O port range\n");
 	mps->psc = tempp;
 	mps->fifo =
 		(struct mpc512x_psc_fifo *)(tempp + sizeof(struct mpc52xx_psc));
 	ret = devm_request_irq(dev, mps->irq, mpc512x_psc_spi_isr, IRQF_SHARED,
 				"mpc512x-psc-spi", mps);
 	if (ret)
-		goto free_master;
+		return ret;
 	init_completion(&mps->txisrdone);
 
 	clk = devm_clk_get(dev, "mclk");
-	if (IS_ERR(clk)) {
-		ret = PTR_ERR(clk);
-		goto free_master;
-	}
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
 	ret = clk_prepare_enable(clk);
 	if (ret)
-		goto free_master;
+		return ret;
 	mps->clk_mclk = clk;
 	mps->mclk_rate = clk_get_rate(clk);
 
@@ -535,8 +531,6 @@ static int mpc512x_psc_spi_do_probe(struct device *dev, u32 regaddr,
 	clk_disable_unprepare(mps->clk_ipg);
 free_mclk_clock:
 	clk_disable_unprepare(mps->clk_mclk);
-free_master:
-	spi_master_put(master);
 
 	return ret;
 }
diff --git a/drivers/spi/spi-mpc52xx-psc.c b/drivers/spi/spi-mpc52xx-psc.c
index 604868df913c..7477fa152da0 100644
--- a/drivers/spi/spi-mpc52xx-psc.c
+++ b/drivers/spi/spi-mpc52xx-psc.c
@@ -300,7 +300,7 @@ static int mpc52xx_psc_spi_do_probe(struct device *dev, u32 regaddr,
 	struct spi_master *master;
 	int ret;
 
-	master = spi_alloc_master(dev, sizeof(*mps));
+	master = devm_spi_alloc_master(dev, sizeof(*mps));
 	if (master == NULL)
 		return -ENOMEM;
 
@@ -318,42 +318,24 @@ static int mpc52xx_psc_spi_do_probe(struct device *dev, u32 regaddr,
 	master->cleanup = mpc52xx_psc_spi_cleanup;
 	master->dev.of_node = dev->of_node;
 
-	mps->psc = ioremap(regaddr, size);
-	if (!mps->psc) {
-		dev_err(dev, "could not ioremap I/O port range\n");
-		ret = -EFAULT;
-		goto free_master;
-	}
+	mps->psc = devm_ioremap(dev, regaddr, size);
+	if (!mps->psc)
+		return dev_err_probe(dev, -EFAULT, "could not ioremap I/O port range\n");
 	/* On the 5200, fifo regs are immediately ajacent to the psc regs */
 	mps->fifo = ((void __iomem *)mps->psc) + sizeof(struct mpc52xx_psc);
 
-	ret = request_irq(mps->irq, mpc52xx_psc_spi_isr, 0, "mpc52xx-psc-spi",
-				mps);
+	ret = devm_request_irq(dev, mps->irq, mpc52xx_psc_spi_isr, 0,
+			       "mpc52xx-psc-spi", mps);
 	if (ret)
-		goto free_master;
+		return ret;
 
 	ret = mpc52xx_psc_spi_port_config(master->bus_num, mps);
-	if (ret < 0) {
-		dev_err(dev, "can't configure PSC! Is it capable of SPI?\n");
-		goto free_irq;
-	}
-
-	init_completion(&mps->done);
-
-	ret = spi_register_master(master);
 	if (ret < 0)
-		goto free_irq;
-
-	return ret;
+		return dev_err_probe(dev, ret, "can't configure PSC! Is it capable of SPI?\n");
 
-free_irq:
-	free_irq(mps->irq, mps);
-free_master:
-	if (mps->psc)
-		iounmap(mps->psc);
-	spi_master_put(master);
+	init_completion(&mps->done);
 
-	return ret;
+	return devm_spi_register_master(dev, master);
 }
 
 static int mpc52xx_psc_spi_of_probe(struct platform_device *op)
@@ -385,20 +367,6 @@ static int mpc52xx_psc_spi_of_probe(struct platform_device *op)
 				irq_of_parse_and_map(op->dev.of_node, 0), id);
 }
 
-static int mpc52xx_psc_spi_of_remove(struct platform_device *op)
-{
-	struct spi_master *master = spi_master_get(platform_get_drvdata(op));
-	struct mpc52xx_psc_spi *mps = spi_master_get_devdata(master);
-
-	spi_unregister_master(master);
-	free_irq(mps->irq, mps);
-	if (mps->psc)
-		iounmap(mps->psc);
-	spi_master_put(master);
-
-	return 0;
-}
-
 static const struct of_device_id mpc52xx_psc_spi_of_match[] = {
 	{ .compatible = "fsl,mpc5200-psc-spi", },
 	{ .compatible = "mpc5200-psc-spi", }, /* old */
@@ -409,7 +377,6 @@ MODULE_DEVICE_TABLE(of, mpc52xx_psc_spi_of_match);
 
 static struct platform_driver mpc52xx_psc_spi_of_driver = {
 	.probe = mpc52xx_psc_spi_of_probe,
-	.remove = mpc52xx_psc_spi_of_remove,
 	.driver = {
 		.name = "mpc52xx-psc-spi",
 		.of_match_table = mpc52xx_psc_spi_of_match,

-- 
2.39.1

