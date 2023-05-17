Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754D9706543
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 12:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbjEQKa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 06:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjEQKat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 06:30:49 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E463A80;
        Wed, 17 May 2023 03:30:48 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-96652cb7673so85955566b.0;
        Wed, 17 May 2023 03:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684319447; x=1686911447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/uCyHD4ZZLXiJ+7a65CaGz07Y7p462n263W2+NsBdCE=;
        b=npscXZ4xsA8kGNXcRo6Dc8FfCtLGwcPyA6TDG+4cfzuGraEKUxFXIaUiO//pMHtB6p
         tbNg2/rQqTDP2NyACu+yJUyt5th/gs6xRCIamoh8Rb/VranATb4fftelphEaz3x7Kw6X
         gywGGBtdDjblsAh2Q2CvVSBu3Cmylq6NWUjHWL4PSiGt9tOJvB/wYY8Nw1riVyPkspRQ
         zIknzuf7IKgPu71EHFwETxvtSp9JgOvZIlle+WbS531CjZqq1W0J4CDdY+4F7kM53dg6
         MIvBMWrPHCaVqLBnKUMENFDCbsWtTRY6D4BgukCJzQV4AC2A5LF68be/IGpzxGMS5Ram
         oSpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684319447; x=1686911447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/uCyHD4ZZLXiJ+7a65CaGz07Y7p462n263W2+NsBdCE=;
        b=IHHAK8GcB2tv17TmskcsulXyihLxUgEO0Aee3+zY6lkgiNPIfCDoIDdU9oXeaQhDwY
         wLrRHWPnOh6x9eAQBw6ZQMTFrs50xHFDSnBxbJosBBotCCNAi/UiZgprSqK7iTZ/ssoT
         tUHPh86jD6bnAnDBK87gMXdTINJVkRsAEPw5hu94XSoKy5y+JJh/7c1aN9F4k25n/9Au
         uhXe94ij6fqQetpnACsNodSAP+o0XmTY4Pe0xNRR98IP5hzBQpOPqcoOokIF36AGV+Fe
         P814dlAcBkaqijad3o0cEuwDL1KaH3GrPXgaDO/D6s8qyraUyXklENN0KYTrY2jhHYIP
         rjcw==
X-Gm-Message-State: AC+VfDyfVRmV1zYw22ZXxPTmkEGVr9/NpAwwDRBpwI4OFmLdjbzwEyRs
        TgRQTnJj2vYGyYmbr/Bt/Es=
X-Google-Smtp-Source: ACHHUZ5RbegKV/3FRbn9juOyFXO+EqEEGjjbu2yJLnw3DmFv3T9rnK2d/2eJITEAKGeRmnoxQGB8WQ==
X-Received: by 2002:a17:907:788:b0:96a:19d8:f082 with SMTP id xd8-20020a170907078800b0096a19d8f082mr27561932ejb.25.1684319446931;
        Wed, 17 May 2023 03:30:46 -0700 (PDT)
Received: from wslxew193.fritz.box (p200300c78700c900d536eaeb32769819.dip0.t-ipconnect.de. [2003:c7:8700:c900:d536:eaeb:3276:9819])
        by smtp.gmail.com with ESMTPSA id bu2-20020a170906a14200b0096654fdbe34sm12235758ejb.142.2023.05.17.03.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 03:30:46 -0700 (PDT)
From:   Boerge Struempfel <boerge.struempfel@gmail.com>
Cc:     boerge.struempfel@gmail.com, bstruempfel@ultratronik.de,
        andy.shevchenko@gmail.com, festevam@gmail.com,
        amit.kumar-mahapatra@amd.com, broonie@kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] spi: spi-imx: add support for SPI_MOSI_IDLE_LOW mode bit
Date:   Wed, 17 May 2023 12:30:06 +0200
Message-Id: <20230517103007.26287-2-boerge.struempfel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230517103007.26287-1-boerge.struempfel@gmail.com>
References: <20230517103007.26287-1-boerge.struempfel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default, the spi-imx controller pulls the mosi line high, whenever it
is idle. This behaviour can be inverted per CS by setting the
corresponding DATA_CTL bit in the config register of the controller.

Also, since the controller mode-bits have to be touched anyways, the
SPI_CPOL and SPI_CPHA are replaced by the combined SPI_MODE_X_MASK flag.

Signed-off-by: Boerge Struempfel <boerge.struempfel@gmail.com>
---
 drivers/spi/spi-imx.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 34e5f81ec431..e5e55d66fecc 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -281,6 +281,7 @@ static bool spi_imx_can_dma(struct spi_controller *controller, struct spi_device
 #define MX51_ECSPI_CONFIG_SCLKPOL(cs)	(1 << ((cs & 3) +  4))
 #define MX51_ECSPI_CONFIG_SBBCTRL(cs)	(1 << ((cs & 3) +  8))
 #define MX51_ECSPI_CONFIG_SSBPOL(cs)	(1 << ((cs & 3) + 12))
+#define MX51_ECSPI_CONFIG_DATACTL(cs)	(1 << ((cs & 3) + 16))
 #define MX51_ECSPI_CONFIG_SCLKCTL(cs)	(1 << ((cs & 3) + 20))
 
 #define MX51_ECSPI_INT		0x10
@@ -573,6 +574,11 @@ static int mx51_ecspi_prepare_message(struct spi_imx_data *spi_imx,
 		cfg &= ~MX51_ECSPI_CONFIG_SCLKCTL(spi_get_chipselect(spi, 0));
 	}
 
+	if (spi->mode & SPI_MOSI_IDLE_LOW)
+		cfg |= MX51_ECSPI_CONFIG_DATACTL(spi_get_chipselect(spi, 0));
+	else
+		cfg &= ~MX51_ECSPI_CONFIG_DATACTL(spi_get_chipselect(spi, 0);
+
 	if (spi->mode & SPI_CS_HIGH)
 		cfg |= MX51_ECSPI_CONFIG_SSBPOL(spi_get_chipselect(spi, 0));
 	else
@@ -1743,7 +1749,8 @@ static int spi_imx_probe(struct platform_device *pdev)
 	spi_imx->controller->prepare_message = spi_imx_prepare_message;
 	spi_imx->controller->unprepare_message = spi_imx_unprepare_message;
 	spi_imx->controller->slave_abort = spi_imx_slave_abort;
-	spi_imx->controller->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_NO_CS;
+	spi_imx->controller->mode_bits = SPI_MODE_X_MASK | SPI_CS_HIGH | SPI_NO_CS |
+					 SPI_MOSI_IDLE_LOW;
 
 	if (is_imx35_cspi(spi_imx) || is_imx51_ecspi(spi_imx) ||
 	    is_imx53_ecspi(spi_imx))
-- 
2.25.1

