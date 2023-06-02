Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBEC3720106
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 13:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234432AbjFBL6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 07:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234755AbjFBL6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 07:58:19 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F1D10C4
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 04:57:51 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f3a99b9177so2689976e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 04:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1685707054; x=1688299054;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=evrwcymqMNKTbAB9nnVcN2soWGAlTnOdSH5Owxy9OYQ=;
        b=EdZFtjCv0OOg290UqgCv24tqwEyrrNi3aaROlD2uMvEhdZj5TBD7sET7MpjcTA4v+n
         lBObkojN9igzCLsZp4AfqDTO5FwE+JE77ByU7wKckHKYQg62f2f1fDAjk9Xt7CIQP8+Y
         HS8cPT2m6rzhoImXthNDxpX3rzRLYZJxe33Vo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685707054; x=1688299054;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=evrwcymqMNKTbAB9nnVcN2soWGAlTnOdSH5Owxy9OYQ=;
        b=gmDh7NQ0CiA426UrKA9xIIdaq3fANJQ2MUJOKUxypHByn4N+PFNDJyM7Kw6dIjZc/v
         xCyIUQJvXSnUBcKgQIZ/r+T2ANHLjJDPdV6CvPmlinTeRxm+oaZTy9e7K05uMBbH14My
         fjCWemHV85OaZvTZaK0zhuu2GgpTcj8ztf+Wv/W2/rBk/B6uFxVYcdRZuAPnkzF90AkJ
         yzMf4bRxsrl7VtpqcuEq4dhed07XtLeXj/X9Y1Ria0Dq/MqtE9gPTws0ceVoz7lNAXXy
         WP3k5q6JnCe1+K9rd849LmaDSXn6bcrKEyCTnZduKnFCM8V38/98bWkIAJ8pOCNILETQ
         iLBA==
X-Gm-Message-State: AC+VfDxrIdaZVmPeNN/nPhA2BCn7GUCXXKu1yQ282JsbegMI9WwgSVOn
        dV+jzJa74ZSpMBKRTeVnNy/kow==
X-Google-Smtp-Source: ACHHUZ5V3Nt2S6IKerF7pPam5XtnNoVjNy9QC/LXBJc5lXRLxmZTqM8KDhn3IwFNGNvt3Fh8ShpeTw==
X-Received: by 2002:ac2:4831:0:b0:4f3:b9b1:5683 with SMTP id 17-20020ac24831000000b004f3b9b15683mr1706934lft.62.1685707054242;
        Fri, 02 Jun 2023 04:57:34 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id e20-20020ac25474000000b004db0d26adb4sm140316lfn.182.2023.06.02.04.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 04:57:33 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     Boerge Struempfel <boerge.struempfel@gmail.com>,
        "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] spi: spi-imx: fix mixing of native and gpio chipselects for imx51/imx53/imx6 variants
Date:   Fri,  2 Jun 2023 13:57:30 +0200
Message-Id: <20230602115731.708883-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 87c614175bbf (spi: spi-imx: fix MX51_ECSPI_* macros when cs >
3) ensured that the argument passed to the macros was masked with &3,
so that we no longer write outside the intended fields in the various
control registers. When all chip selects are gpios, this works just
fine.

However, when a mix of native and gpio chip selects are in use, that
masking is too naive. Say, for example, that SS0 is muxed as native
chip select, and there is also a chip at 4 (obviously with a gpio
cs). In that case, when accessing the latter chip, both the SS0 pin
and the gpio pin will be asserted low.

The fix for this is to use the ->unused_native_cs value as channel
number for any spi device which uses a gpio as chip select.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---

Previous submission: https://lore.kernel.org/lkml/20230425134527.483607-1-linux@rasmusvillemoes.dk/

The first two patches have already been applied in -next. This adapts
3/3 to -next as of next-20230602, taking both 6a983ff5102f and
9e264f3f85a5 into account.

 drivers/spi/spi-imx.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 6f4d3cb81fdf..528ae46c087f 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -517,6 +517,13 @@ static void mx51_ecspi_disable(struct spi_imx_data *spi_imx)
 	writel(ctrl, spi_imx->base + MX51_ECSPI_CTRL);
 }
 
+static int mx51_ecspi_channel(const struct spi_device *spi)
+{
+	if (!spi_get_csgpiod(spi, 0))
+		return spi_get_chipselect(spi, 0);
+	return spi->controller->unused_native_cs;
+}
+
 static int mx51_ecspi_prepare_message(struct spi_imx_data *spi_imx,
 				      struct spi_message *msg)
 {
@@ -527,6 +534,7 @@ static int mx51_ecspi_prepare_message(struct spi_imx_data *spi_imx,
 	u32 testreg, delay;
 	u32 cfg = readl(spi_imx->base + MX51_ECSPI_CONFIG);
 	u32 current_cfg = cfg;
+	int channel = mx51_ecspi_channel(spi);
 
 	/* set Master or Slave mode */
 	if (spi_imx->slave_mode)
@@ -541,7 +549,7 @@ static int mx51_ecspi_prepare_message(struct spi_imx_data *spi_imx,
 		ctrl |= MX51_ECSPI_CTRL_DRCTL(spi_imx->spi_drctl);
 
 	/* set chip select to use */
-	ctrl |= MX51_ECSPI_CTRL_CS(spi_get_chipselect(spi, 0));
+	ctrl |= MX51_ECSPI_CTRL_CS(channel);
 
 	/*
 	 * The ctrl register must be written first, with the EN bit set other
@@ -562,27 +570,27 @@ static int mx51_ecspi_prepare_message(struct spi_imx_data *spi_imx,
 	 * BURST_LENGTH + 1 bits are received
 	 */
 	if (spi_imx->slave_mode && is_imx53_ecspi(spi_imx))
-		cfg &= ~MX51_ECSPI_CONFIG_SBBCTRL(spi_get_chipselect(spi, 0));
+		cfg &= ~MX51_ECSPI_CONFIG_SBBCTRL(channel);
 	else
-		cfg |= MX51_ECSPI_CONFIG_SBBCTRL(spi_get_chipselect(spi, 0));
+		cfg |= MX51_ECSPI_CONFIG_SBBCTRL(channel);
 
 	if (spi->mode & SPI_CPOL) {
-		cfg |= MX51_ECSPI_CONFIG_SCLKPOL(spi_get_chipselect(spi, 0));
-		cfg |= MX51_ECSPI_CONFIG_SCLKCTL(spi_get_chipselect(spi, 0));
+		cfg |= MX51_ECSPI_CONFIG_SCLKPOL(channel);
+		cfg |= MX51_ECSPI_CONFIG_SCLKCTL(channel);
 	} else {
-		cfg &= ~MX51_ECSPI_CONFIG_SCLKPOL(spi_get_chipselect(spi, 0));
-		cfg &= ~MX51_ECSPI_CONFIG_SCLKCTL(spi_get_chipselect(spi, 0));
+		cfg &= ~MX51_ECSPI_CONFIG_SCLKPOL(channel);
+		cfg &= ~MX51_ECSPI_CONFIG_SCLKCTL(channel);
 	}
 
 	if (spi->mode & SPI_MOSI_IDLE_LOW)
-		cfg |= MX51_ECSPI_CONFIG_DATACTL(spi_get_chipselect(spi, 0));
+		cfg |= MX51_ECSPI_CONFIG_DATACTL(channel);
 	else
-		cfg &= ~MX51_ECSPI_CONFIG_DATACTL(spi_get_chipselect(spi, 0));
+		cfg &= ~MX51_ECSPI_CONFIG_DATACTL(channel);
 
 	if (spi->mode & SPI_CS_HIGH)
-		cfg |= MX51_ECSPI_CONFIG_SSBPOL(spi_get_chipselect(spi, 0));
+		cfg |= MX51_ECSPI_CONFIG_SSBPOL(channel);
 	else
-		cfg &= ~MX51_ECSPI_CONFIG_SSBPOL(spi_get_chipselect(spi, 0));
+		cfg &= ~MX51_ECSPI_CONFIG_SSBPOL(channel);
 
 	if (cfg == current_cfg)
 		return 0;
@@ -627,14 +635,15 @@ static void mx51_configure_cpha(struct spi_imx_data *spi_imx,
 	bool cpha = (spi->mode & SPI_CPHA);
 	bool flip_cpha = (spi->mode & SPI_RX_CPHA_FLIP) && spi_imx->rx_only;
 	u32 cfg = readl(spi_imx->base + MX51_ECSPI_CONFIG);
+	int channel = mx51_ecspi_channel(spi);
 
 	/* Flip cpha logical value iff flip_cpha */
 	cpha ^= flip_cpha;
 
 	if (cpha)
-		cfg |= MX51_ECSPI_CONFIG_SCLKPHA(spi_get_chipselect(spi, 0));
+		cfg |= MX51_ECSPI_CONFIG_SCLKPHA(channel);
 	else
-		cfg &= ~MX51_ECSPI_CONFIG_SCLKPHA(spi_get_chipselect(spi, 0));
+		cfg &= ~MX51_ECSPI_CONFIG_SCLKPHA(channel);
 
 	writel(cfg, spi_imx->base + MX51_ECSPI_CONFIG);
 }
-- 
2.37.2

