Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8574E6FD8F5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 10:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236557AbjEJIMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 04:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236290AbjEJIMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 04:12:00 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4234EFE;
        Wed, 10 May 2023 01:11:55 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3062db220a3so4456678f8f.0;
        Wed, 10 May 2023 01:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683706314; x=1686298314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=77wc1d6atkrSEJWlP3Ir0nLtSYker340vhK9d9PW+mI=;
        b=ae0I6iddFisGGANa9OOcfirX9cB0n+MSDzgjiH+0SR+KzIbiMhbsU7lKAKHsINsAdL
         nlio9quJn2D75JzGpvuSrFuC5wonhJgndyBVjQSmqjmxQD5mx7C0iZ2Nl0fMI5ofuiGK
         BtLscgOl6d764lfDlUAHFezOowTkPUQMQmgoydbi6QPB0EQHOeEcHAgQQjEHgtrayVjF
         HMXJIZCsQEiKq1GX1YZwmchI5biSj/INjJWi2JS4jYF/yUbqclmtucW1Ib2Hogj7pRXf
         5WBWYeHZ8q1SZ/N5RItG3Iy0T4epZmLAPvICMtxCUZ46dJVk7yS9n3e+6LmO1m4mQlCf
         hBMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683706314; x=1686298314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=77wc1d6atkrSEJWlP3Ir0nLtSYker340vhK9d9PW+mI=;
        b=O8kQh/vDkx02cntUxnsuV/B2ZaqPQMQJXqMpOtccUq12CnJawtOPA/FrZ6z6M+x0ma
         +yyW7MyIlmhMfqpZ28eHyNI7X3qV60+DYVs/ywU5J+dpjmGPehcUbjxOSLTnplNVnlKB
         qqgIwECv6ggXM5khPpfaRwrCNAGh7U4w48jZ/NcG3Zd3MAXMzGd45MhZabaC0To3I3zu
         Vaywd64ZYzMyIXBRLCeU7CGoEiMX7TtF1cIjhBVlOJUljBaCWvilZYE2slh4dn8G4nSJ
         Tu5GGjJEVa1rrE72/vX2285/0OGI+oz0Ma+GKrsXMppRwj2Nvq2GJ0ONRRne6THf2hQR
         wKpw==
X-Gm-Message-State: AC+VfDypqyQM1Em9AgPR05FlZQHi9YyXBSkczy8q6owRox2RoXO9+PSI
        3rTEqYyULB1Py/arN28y5FTDCLSbNoWyCfzt
X-Google-Smtp-Source: ACHHUZ7LOXg/DkoBru/U76rMVLiEGmaOUTu4YooGzoHGu24IFRnzbR7KaWi2Y+Iz6Mo8QI4e9lZzGQ==
X-Received: by 2002:a5d:43c4:0:b0:307:6278:611a with SMTP id v4-20020a5d43c4000000b003076278611amr12190947wrr.21.1683706314126;
        Wed, 10 May 2023 01:11:54 -0700 (PDT)
Received: from localhost.localdomain ([176.221.215.212])
        by smtp.gmail.com with ESMTPSA id f16-20020a5d4dd0000000b003062ad45243sm16496375wru.14.2023.05.10.01.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 01:11:53 -0700 (PDT)
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
Subject: [PATCH v5 2/5] spi: sun6i: change OF match data to a struct
Date:   Wed, 10 May 2023 11:11:09 +0300
Message-Id: <20230510081121.3463710-3-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230510081121.3463710-1-bigunclemax@gmail.com>
References: <20230510081121.3463710-1-bigunclemax@gmail.com>
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

