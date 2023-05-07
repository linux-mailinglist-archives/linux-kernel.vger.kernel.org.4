Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F646F9926
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 17:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbjEGPFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 11:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjEGPFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 11:05:45 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4102318DC5;
        Sun,  7 May 2023 08:05:40 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f315735514so144187655e9.1;
        Sun, 07 May 2023 08:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683471938; x=1686063938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=77wc1d6atkrSEJWlP3Ir0nLtSYker340vhK9d9PW+mI=;
        b=XutFOCZHWJnWkRB9BewbmcrURpWtS0oGRy7KitO4zl8hpXeDbYm+5ThXZS34mSfEcn
         EVrt1FMqI5UZMsN8Ix012ShRWbcrQ1PD5U/Q7RtLFeNXXzJXRW8KIF/aerD27CGlhG0m
         HLZMsgyiuGhoe1+7TsE3erKCGIFtDb3MECuULbMo6+SyNoyoJnp2Ymw84KeMAoYFrO+7
         f/Uz2ZQQuztHQvyRE6XN8c5SwuXdMTtfZyOfUOuV3wkYTePb+nt5nRxwo1Ijw89E7+EG
         2P6mmFHLBJ6NuLtSJYLJr5CYaedoERne6G+ReFHD1LPPbtOyR35oLeTqFB+T+EwCjVbv
         Y7Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683471938; x=1686063938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=77wc1d6atkrSEJWlP3Ir0nLtSYker340vhK9d9PW+mI=;
        b=AQkY7ksGjQH/kUXV/zZMFPqeBPcKedf61X3+fgDDxTkPB8VZHQuIy9E6Ag4UEM03o7
         +Jn4DDzeSYVzxD1h3Mh6AQxtlw53u9YOLseCCZE/XQkpd4JYth/dHfAsMAUVygTZaFvn
         AhZ3UYQxZEus5uV+YZh3jrpGnwyYY1a+kGz7pl4OydYKnqkioh+CWbiyyDtCsADSI2O3
         UuQnllacCN61/aup1PsMq1kaJaQknn1VzO1bzOWv9XvCbLwrEV+CUW+wnR6u5kybSoYp
         +CknqICaIiv+jE0ChdAsx65WBo0FJ5jlNjT2LfR9l576IrfHA0hnYym81V5uicQFGiGr
         PonQ==
X-Gm-Message-State: AC+VfDzC2570VtkLXF7Lad9fZLCTTUk30wxn0tjeK1OlDGLi1ll7jmvj
        wR4qVKTvrPfLwT2okoJlBlo=
X-Google-Smtp-Source: ACHHUZ4bDccmBL9QdKVq9vlwdYZQPjzfCJXGWwQ7Tqwl3/wtWtlVOhk3dYx4QSgktssjK8nmqbL8Tw==
X-Received: by 2002:a05:600c:8511:b0:3f1:7510:62e8 with SMTP id gw17-20020a05600c851100b003f1751062e8mr5566482wmb.3.1683471938339;
        Sun, 07 May 2023 08:05:38 -0700 (PDT)
Received: from localhost.localdomain ([176.221.215.212])
        by smtp.gmail.com with ESMTPSA id e15-20020a5d594f000000b0030771c6e443sm8437998wri.42.2023.05.07.08.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 08:05:38 -0700 (PDT)
From:   Maksim Kiselev <bigunclemax@gmail.com>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Icenowy Zheng <icenowy@aosc.io>,
        Maksim Kiselev <bigunclemax@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Maxime Ripard <mripard@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v4 2/5] spi: sun6i: change OF match data to a struct
Date:   Sun,  7 May 2023 18:03:34 +0300
Message-Id: <20230507150345.1971083-3-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230507150345.1971083-1-bigunclemax@gmail.com>
References: <20230507150345.1971083-1-bigunclemax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Icenowy Zheng <icenowy@aosc.io>

As we're adding more properties to the OF match data, convert it to a
struct now.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
Reviewed-by: Samuel Holland <samuel@sholland.org>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/spi/spi-sun6i.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index 7532c85a352c..01a01cd86db5 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -85,6 +85,10 @@
 #define SUN6I_TXDATA_REG		0x200
 #define SUN6I_RXDATA_REG		0x300
 
+struct sun6i_spi_cfg {
+	unsigned long		fifo_depth;
+};
+
 struct sun6i_spi {
 	struct spi_master	*master;
 	void __iomem		*base_addr;
@@ -99,7 +103,7 @@ struct sun6i_spi {
 	const u8		*tx_buf;
 	u8			*rx_buf;
 	int			len;
-	unsigned long		fifo_depth;
+	const struct sun6i_spi_cfg *cfg;
 };
 
 static inline u32 sun6i_spi_read(struct sun6i_spi *sspi, u32 reg)
@@ -156,7 +160,7 @@ static inline void sun6i_spi_fill_fifo(struct sun6i_spi *sspi)
 	u8 byte;
 
 	/* See how much data we can fit */
-	cnt = sspi->fifo_depth - sun6i_spi_get_tx_fifo_count(sspi);
+	cnt = sspi->cfg->fifo_depth - sun6i_spi_get_tx_fifo_count(sspi);
 
 	len = min((int)cnt, sspi->len);
 
@@ -289,14 +293,14 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 		 * the hardcoded value used in old generation of Allwinner
 		 * SPI controller. (See spi-sun4i.c)
 		 */
-		trig_level = sspi->fifo_depth / 4 * 3;
+		trig_level = sspi->cfg->fifo_depth / 4 * 3;
 	} else {
 		/*
 		 * Setup FIFO DMA request trigger level
 		 * We choose 1/2 of the full fifo depth, that value will
 		 * be used as DMA burst length.
 		 */
-		trig_level = sspi->fifo_depth / 2;
+		trig_level = sspi->cfg->fifo_depth / 2;
 
 		if (tfr->tx_buf)
 			reg |= SUN6I_FIFO_CTL_TF_DRQ_EN;
@@ -410,9 +414,9 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 	reg = SUN6I_INT_CTL_TC;
 
 	if (!use_dma) {
-		if (rx_len > sspi->fifo_depth)
+		if (rx_len > sspi->cfg->fifo_depth)
 			reg |= SUN6I_INT_CTL_RF_RDY;
-		if (tx_len > sspi->fifo_depth)
+		if (tx_len > sspi->cfg->fifo_depth)
 			reg |= SUN6I_INT_CTL_TF_ERQ;
 	}
 
@@ -543,7 +547,7 @@ static bool sun6i_spi_can_dma(struct spi_master *master,
 	 * the fifo length we can just fill the fifo and wait for a single
 	 * irq, so don't bother setting up dma
 	 */
-	return xfer->len > sspi->fifo_depth;
+	return xfer->len > sspi->cfg->fifo_depth;
 }
 
 static int sun6i_spi_probe(struct platform_device *pdev)
@@ -582,7 +586,7 @@ static int sun6i_spi_probe(struct platform_device *pdev)
 	}
 
 	sspi->master = master;
-	sspi->fifo_depth = (unsigned long)of_device_get_match_data(&pdev->dev);
+	sspi->cfg = of_device_get_match_data(&pdev->dev);
 
 	master->max_speed_hz = 100 * 1000 * 1000;
 	master->min_speed_hz = 3 * 1000;
@@ -695,9 +699,17 @@ static void sun6i_spi_remove(struct platform_device *pdev)
 		dma_release_channel(master->dma_rx);
 }
 
+static const struct sun6i_spi_cfg sun6i_a31_spi_cfg = {
+	.fifo_depth	= SUN6I_FIFO_DEPTH,
+};
+
+static const struct sun6i_spi_cfg sun8i_h3_spi_cfg = {
+	.fifo_depth	= SUN8I_FIFO_DEPTH,
+};
+
 static const struct of_device_id sun6i_spi_match[] = {
-	{ .compatible = "allwinner,sun6i-a31-spi", .data = (void *)SUN6I_FIFO_DEPTH },
-	{ .compatible = "allwinner,sun8i-h3-spi",  .data = (void *)SUN8I_FIFO_DEPTH },
+	{ .compatible = "allwinner,sun6i-a31-spi", .data = &sun6i_a31_spi_cfg },
+	{ .compatible = "allwinner,sun8i-h3-spi",  .data = &sun8i_h3_spi_cfg },
 	{}
 };
 MODULE_DEVICE_TABLE(of, sun6i_spi_match);
-- 
2.39.2

