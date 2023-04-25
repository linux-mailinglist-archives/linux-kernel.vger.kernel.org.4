Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 410F46EE368
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 15:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234290AbjDYNpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 09:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234277AbjDYNpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 09:45:40 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53BF14469
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 06:45:37 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-959a3e2dd27so463193266b.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 06:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1682430336; x=1685022336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Al0zqUJCRs8AI5Sc47A1KMBnQC63vKqupk6DIofDhiM=;
        b=ITM1rBhaC1OkA8L7qspcDJ8xbkZrOsaT0dCfP5BjuAZtPW6BBgMTvTknoRUzcp9oGq
         tRqmd/cXl4V2QIGzwRFD4JMcMxoOdclL3ggk62TG+Qpvg2hU/UqbKiEhRvzwvrY82/G/
         ekhBg3pKTFerlph1uFfJZDo9PptMNJ6QMRbtQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682430336; x=1685022336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Al0zqUJCRs8AI5Sc47A1KMBnQC63vKqupk6DIofDhiM=;
        b=Gu+5k8j9LKHdOF5KDXfJmjTXEjH2TEdTXS6nDca4tC6GDQPgE7Iam9nAAzqpamtVtO
         veXcsZsqYutRjuKDaBpY+Zt2iIb1ySMoGCAlUaKbJwSQQ1CCOnCOtX0pVBlDQHzLLUN/
         80xzeaO72d1iuagSs2AbKgTFNgUGtkxk6FIKh6FqYgVC2B8siadcEaI5bqGmqJsi7JDe
         zYfIgA845VfBrhN0+Xt0c/6eJNsgKEmZBsuP3Xd4dW+KCJZxTwQdG64W/Wz2aPO2x1qP
         Yy0aWA4McUBmFD1pFC2UOJ/M0VJ1zz+uzHt4Y5aD6ReRFAcUI6s0fNP9zcjCoE0eNQLO
         iyLA==
X-Gm-Message-State: AAQBX9f5uems7L55NtN47xqL7Dxe26e/UjSEVG0faKHdhZP5boRHii5n
        5U65CDVCBQvxKKh+5V/23Br87Q==
X-Google-Smtp-Source: AKy350aKN7c3TBlSHw8bGq2LBpYoNswxL+Q4j51QbggX6/tE0dIImeRVxwOgA/3I0vsBbihspOdvSg==
X-Received: by 2002:a17:906:8a44:b0:94f:553:6fd6 with SMTP id gx4-20020a1709068a4400b0094f05536fd6mr13433197ejc.24.1682430335987;
        Tue, 25 Apr 2023 06:45:35 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id f10-20020a170906048a00b0094eeea5c649sm6806822eja.114.2023.04.25.06.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 06:45:35 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] spi: spi-imx: fix use of more than four chipselects
Date:   Tue, 25 Apr 2023 15:45:27 +0200
Message-Id: <20230425134527.483607-4-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230425134527.483607-1-linux@rasmusvillemoes.dk>
References: <20230425134527.483607-1-linux@rasmusvillemoes.dk>
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

Currently, the spi->chip_select is used unconditionally in code such as

	/* set chip select to use */
	ctrl |= MX51_ECSPI_CTRL_CS(spi->chip_select);

and

	if (spi->mode & SPI_CPHA)
		cfg |= MX51_ECSPI_CONFIG_SCLKPHA(spi->chip_select);
	else
		cfg &= ~MX51_ECSPI_CONFIG_SCLKPHA(spi->chip_select);

with these macros being

	#define MX51_ECSPI_CTRL_CS(cs)          ((cs) << 18)
	#define MX51_ECSPI_CONFIG_SCLKPHA(cs)   (1 << ((cs) +  0))

However, the CHANNEL_SELECT field in the control register is only two
bits wide, so when spi->chip_select >= 4, we end up writing garbage
into the BURST_LENGTH field. Similarly, there are only four bits in
the SCLK_PHA field, so the code above ends up actually modifying bits
in the SCLK_POL (or higher) field.

The scrambling of the BURST_LENGTH field itself is probably benign,
since that is explicitly completely initialized later, in
->prepare_transfer.

But, since we effectively write (spi->chip_select & 3) into the
CHANNEL_SELECT field, that value is what the IP block then uses to
determine which bits of the configuration register control phase,
polarity etc., and those bits are not properly initialized, so
communication with the spi device completely fails.

Fix this by using the ->unused_native_cs value as channel number for
any spi device which uses a gpio as chip select.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/spi/spi-imx.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index e8f7afbd9847..569a5132f324 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -504,6 +504,13 @@ static void mx51_ecspi_disable(struct spi_imx_data *spi_imx)
 	writel(ctrl, spi_imx->base + MX51_ECSPI_CTRL);
 }
 
+static int mx51_ecspi_channel(const struct spi_device *spi)
+{
+	if (!spi->cs_gpiod)
+		return spi->chip_select;
+	return spi->controller->unused_native_cs;
+}
+
 static int mx51_ecspi_prepare_message(struct spi_imx_data *spi_imx,
 				      struct spi_message *msg)
 {
@@ -514,6 +521,7 @@ static int mx51_ecspi_prepare_message(struct spi_imx_data *spi_imx,
 	u32 testreg, delay;
 	u32 cfg = readl(spi_imx->base + MX51_ECSPI_CONFIG);
 	u32 current_cfg = cfg;
+	int channel = mx51_ecspi_channel(spi);
 
 	/* set Master or Slave mode */
 	if (spi_imx->slave_mode)
@@ -528,7 +536,7 @@ static int mx51_ecspi_prepare_message(struct spi_imx_data *spi_imx,
 		ctrl |= MX51_ECSPI_CTRL_DRCTL(spi_imx->spi_drctl);
 
 	/* set chip select to use */
-	ctrl |= MX51_ECSPI_CTRL_CS(spi->chip_select);
+	ctrl |= MX51_ECSPI_CTRL_CS(channel);
 
 	/*
 	 * The ctrl register must be written first, with the EN bit set other
@@ -549,22 +557,22 @@ static int mx51_ecspi_prepare_message(struct spi_imx_data *spi_imx,
 	 * BURST_LENGTH + 1 bits are received
 	 */
 	if (spi_imx->slave_mode && is_imx53_ecspi(spi_imx))
-		cfg &= ~MX51_ECSPI_CONFIG_SBBCTRL(spi->chip_select);
+		cfg &= ~MX51_ECSPI_CONFIG_SBBCTRL(channel);
 	else
-		cfg |= MX51_ECSPI_CONFIG_SBBCTRL(spi->chip_select);
+		cfg |= MX51_ECSPI_CONFIG_SBBCTRL(channel);
 
 	if (spi->mode & SPI_CPOL) {
-		cfg |= MX51_ECSPI_CONFIG_SCLKPOL(spi->chip_select);
-		cfg |= MX51_ECSPI_CONFIG_SCLKCTL(spi->chip_select);
+		cfg |= MX51_ECSPI_CONFIG_SCLKPOL(channel);
+		cfg |= MX51_ECSPI_CONFIG_SCLKCTL(channel);
 	} else {
-		cfg &= ~MX51_ECSPI_CONFIG_SCLKPOL(spi->chip_select);
-		cfg &= ~MX51_ECSPI_CONFIG_SCLKCTL(spi->chip_select);
+		cfg &= ~MX51_ECSPI_CONFIG_SCLKPOL(channel);
+		cfg &= ~MX51_ECSPI_CONFIG_SCLKCTL(channel);
 	}
 
 	if (spi->mode & SPI_CS_HIGH)
-		cfg |= MX51_ECSPI_CONFIG_SSBPOL(spi->chip_select);
+		cfg |= MX51_ECSPI_CONFIG_SSBPOL(channel);
 	else
-		cfg &= ~MX51_ECSPI_CONFIG_SSBPOL(spi->chip_select);
+		cfg &= ~MX51_ECSPI_CONFIG_SSBPOL(channel);
 
 	if (cfg == current_cfg)
 		return 0;
@@ -609,14 +617,15 @@ static void mx51_configure_cpha(struct spi_imx_data *spi_imx,
 	bool cpha = (spi->mode & SPI_CPHA);
 	bool flip_cpha = (spi->mode & SPI_RX_CPHA_FLIP) && spi_imx->rx_only;
 	u32 cfg = readl(spi_imx->base + MX51_ECSPI_CONFIG);
+	int channel = mx51_ecspi_channel(spi);
 
 	/* Flip cpha logical value iff flip_cpha */
 	cpha ^= flip_cpha;
 
 	if (cpha)
-		cfg |= MX51_ECSPI_CONFIG_SCLKPHA(spi->chip_select);
+		cfg |= MX51_ECSPI_CONFIG_SCLKPHA(channel);
 	else
-		cfg &= ~MX51_ECSPI_CONFIG_SCLKPHA(spi->chip_select);
+		cfg &= ~MX51_ECSPI_CONFIG_SCLKPHA(channel);
 
 	writel(cfg, spi_imx->base + MX51_ECSPI_CONFIG);
 }
-- 
2.37.2

