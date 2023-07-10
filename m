Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B0774D364
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233398AbjGJK2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233263AbjGJK2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:28:00 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFF1B2;
        Mon, 10 Jul 2023 03:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688984878; x=1720520878;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NBPhEpTs2nKKIX3PGSmZUmwrqrmiZCxKqHX3RdjwvAU=;
  b=PHc2Nupccaf2oOCNo2j42JGsaoo/N0isnnPlr0vytUft6bp+rM9VGpAS
   BcpbDmWxn8tStvlqUi7yCEagKd72hOBB7dtNq661Hx1k7v+Fs7xZnmQjB
   ucz6OtLnwL8QrgB5wbJE/AV56rUiOG9DWHxFVqY91wngbPYWdlqQRZfjy
   /Pn5Hre2dg+TYClJD+EyAYFhYvZOo1q/QxGoMAMXjafp4N/EoGs5Ki5kU
   GPl44CgmwRuQ+c9W+u+v/OZLpj2YupEgqvyG/vrz7KGM0APkEXolT/9qw
   8AuQgvw7wLeNRY22IKDFMbQvtYqPi1qndlCAOmTkJSpI6ThAc11Ftmn+B
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="367803754"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="367803754"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 03:27:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="755956012"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="755956012"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 10 Jul 2023 03:27:48 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2C3084BD; Mon, 10 Jul 2023 13:27:53 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Amit Kumar Mahapatra via Alsa-devel 
        <alsa-devel@alsa-project.org>, Kris Bahnsen <kris@embeddedTS.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org
Cc:     Radu Pirea <radu_nicolae.pirea@upb.ro>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>
Subject: [PATCH v1 4/8] spi: Get rid of old SPI_MASTER_NO_.X and SPI_MASTER_MUST_.X
Date:   Mon, 10 Jul 2023 13:27:47 +0300
Message-Id: <20230710102751.83314-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230710102751.83314-1-andriy.shevchenko@linux.intel.com>
References: <20230710102751.83314-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the users to SPI_CONTROLLER_NO_?X and SPI_CONTROLLER_MUST_.X
and kill the not used anymore definitions.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-at91-usart.c    |  2 +-
 drivers/spi/spi-atmel.c         |  2 +-
 drivers/spi/spi-bitbang-txrx.h  | 16 ++++++++--------
 drivers/spi/spi-bitbang.c       |  2 +-
 drivers/spi/spi-davinci.c       |  2 +-
 drivers/spi/spi-fsl-lpspi.c     |  2 +-
 drivers/spi/spi-gpio.c          |  8 ++++----
 drivers/spi/spi-lp8841-rtc.c    |  8 ++++----
 drivers/spi/spi-meson-spicc.c   |  2 +-
 drivers/spi/spi-mt65xx.c        |  2 +-
 drivers/spi/spi-pci1xxxx.c      |  2 +-
 drivers/spi/spi-pic32.c         |  2 +-
 drivers/spi/spi-rb4xx.c         |  2 +-
 drivers/spi/spi-slave-mt27xx.c  |  2 +-
 drivers/spi/spi-stm32.c         |  2 +-
 drivers/spi/spi-xtensa-xtfpga.c |  2 +-
 include/linux/spi/spi.h         |  4 ----
 17 files changed, 29 insertions(+), 33 deletions(-)

diff --git a/drivers/spi/spi-at91-usart.c b/drivers/spi/spi-at91-usart.c
index 7854d9790fe9..7dfe2b6c2990 100644
--- a/drivers/spi/spi-at91-usart.c
+++ b/drivers/spi/spi-at91-usart.c
@@ -527,7 +527,7 @@ static int at91_usart_spi_probe(struct platform_device *pdev)
 	controller->dev.of_node = pdev->dev.parent->of_node;
 	controller->bits_per_word_mask = SPI_BPW_MASK(8);
 	controller->setup = at91_usart_spi_setup;
-	controller->flags = SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX;
+	controller->flags = SPI_CONTROLLER_MUST_RX | SPI_CONTROLLER_MUST_TX;
 	controller->transfer_one = at91_usart_spi_transfer_one;
 	controller->prepare_message = at91_usart_spi_prepare_message;
 	controller->unprepare_message = at91_usart_spi_unprepare_message;
diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 152cd6773403..0865993005b2 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1475,7 +1475,7 @@ static int atmel_spi_probe(struct platform_device *pdev)
 	host->bus_num = pdev->id;
 	host->num_chipselect = 4;
 	host->setup = atmel_spi_setup;
-	host->flags = (SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX |
+	host->flags = (SPI_CONTROLLER_MUST_RX | SPI_CONTROLLER_MUST_TX |
 			SPI_MASTER_GPIO_SS);
 	host->transfer_one = atmel_spi_one_transfer;
 	host->set_cs = atmel_spi_set_cs;
diff --git a/drivers/spi/spi-bitbang-txrx.h b/drivers/spi/spi-bitbang-txrx.h
index 2dcbe166df63..0cab48b7875b 100644
--- a/drivers/spi/spi-bitbang-txrx.h
+++ b/drivers/spi/spi-bitbang-txrx.h
@@ -57,7 +57,7 @@ bitbang_txrx_be_cpha0(struct spi_device *spi,
 	for (word <<= (32 - bits); likely(bits); bits--) {
 
 		/* setup MSB (to slave) on trailing edge */
-		if ((flags & SPI_MASTER_NO_TX) == 0) {
+		if ((flags & SPI_CONTROLLER_NO_TX) == 0) {
 			if ((word & (1 << 31)) != oldbit) {
 				setmosi(spi, word & (1 << 31));
 				oldbit = word & (1 << 31);
@@ -70,7 +70,7 @@ bitbang_txrx_be_cpha0(struct spi_device *spi,
 
 		/* sample MSB (from slave) on leading edge */
 		word <<= 1;
-		if ((flags & SPI_MASTER_NO_RX) == 0)
+		if ((flags & SPI_CONTROLLER_NO_RX) == 0)
 			word |= getmiso(spi);
 		setsck(spi, cpol);
 	}
@@ -90,7 +90,7 @@ bitbang_txrx_be_cpha1(struct spi_device *spi,
 
 		/* setup MSB (to slave) on leading edge */
 		setsck(spi, !cpol);
-		if ((flags & SPI_MASTER_NO_TX) == 0) {
+		if ((flags & SPI_CONTROLLER_NO_TX) == 0) {
 			if ((word & (1 << 31)) != oldbit) {
 				setmosi(spi, word & (1 << 31));
 				oldbit = word & (1 << 31);
@@ -103,7 +103,7 @@ bitbang_txrx_be_cpha1(struct spi_device *spi,
 
 		/* sample MSB (from slave) on trailing edge */
 		word <<= 1;
-		if ((flags & SPI_MASTER_NO_RX) == 0)
+		if ((flags & SPI_CONTROLLER_NO_RX) == 0)
 			word |= getmiso(spi);
 	}
 	return word;
@@ -122,7 +122,7 @@ bitbang_txrx_le_cpha0(struct spi_device *spi,
 	for (; likely(bits); bits--) {
 
 		/* setup LSB (to slave) on trailing edge */
-		if ((flags & SPI_MASTER_NO_TX) == 0) {
+		if ((flags & SPI_CONTROLLER_NO_TX) == 0) {
 			if ((word & 1) != oldbit) {
 				setmosi(spi, word & 1);
 				oldbit = word & 1;
@@ -135,7 +135,7 @@ bitbang_txrx_le_cpha0(struct spi_device *spi,
 
 		/* sample LSB (from slave) on leading edge */
 		word >>= 1;
-		if ((flags & SPI_MASTER_NO_RX) == 0)
+		if ((flags & SPI_CONTROLLER_NO_RX) == 0)
 			word |= getmiso(spi) << rxbit;
 		setsck(spi, cpol);
 	}
@@ -156,7 +156,7 @@ bitbang_txrx_le_cpha1(struct spi_device *spi,
 
 		/* setup LSB (to slave) on leading edge */
 		setsck(spi, !cpol);
-		if ((flags & SPI_MASTER_NO_TX) == 0) {
+		if ((flags & SPI_CONTROLLER_NO_TX) == 0) {
 			if ((word & 1) != oldbit) {
 				setmosi(spi, word & 1);
 				oldbit = word & 1;
@@ -169,7 +169,7 @@ bitbang_txrx_le_cpha1(struct spi_device *spi,
 
 		/* sample LSB (from slave) on trailing edge */
 		word >>= 1;
-		if ((flags & SPI_MASTER_NO_RX) == 0)
+		if ((flags & SPI_CONTROLLER_NO_RX) == 0)
 			word |= getmiso(spi) << rxbit;
 	}
 	return word;
diff --git a/drivers/spi/spi-bitbang.c b/drivers/spi/spi-bitbang.c
index 27d0087f8688..862f209cada1 100644
--- a/drivers/spi/spi-bitbang.c
+++ b/drivers/spi/spi-bitbang.c
@@ -248,7 +248,7 @@ static int spi_bitbang_bufs(struct spi_device *spi, struct spi_transfer *t)
 	if (spi->mode & SPI_3WIRE) {
 		unsigned flags;
 
-		flags = t->tx_buf ? SPI_MASTER_NO_RX : SPI_MASTER_NO_TX;
+		flags = t->tx_buf ? SPI_CONTROLLER_NO_RX : SPI_CONTROLLER_NO_TX;
 		return cs->txrx_bufs(spi, cs->txrx_word, nsecs, t, flags);
 	}
 	return cs->txrx_bufs(spi, cs->txrx_word, nsecs, t, 0);
diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index b04811c911e2..014392459d5e 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -939,7 +939,7 @@ static int davinci_spi_probe(struct platform_device *pdev)
 	master->bus_num = pdev->id;
 	master->num_chipselect = pdata->num_chipselect;
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(2, 16);
-	master->flags = SPI_MASTER_MUST_RX | SPI_MASTER_GPIO_SS;
+	master->flags = SPI_CONTROLLER_MUST_RX | SPI_MASTER_GPIO_SS;
 	master->setup = davinci_spi_setup;
 	master->cleanup = davinci_spi_cleanup;
 	master->can_dma = davinci_spi_can_dma;
diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index fb68c72df171..1c907d5d5bb3 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -856,7 +856,7 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
 	controller->prepare_transfer_hardware = lpspi_prepare_xfer_hardware;
 	controller->unprepare_transfer_hardware = lpspi_unprepare_xfer_hardware;
 	controller->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
-	controller->flags = SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX;
+	controller->flags = SPI_CONTROLLER_MUST_RX | SPI_CONTROLLER_MUST_TX;
 	controller->dev.of_node = pdev->dev.of_node;
 	controller->bus_num = pdev->id;
 	controller->num_chipselect = fsl_lpspi->num_cs;
diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index 092afc7679d4..85e149ec2910 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -170,7 +170,7 @@ static u32 spi_gpio_txrx_word_mode3(struct spi_device *spi,
 
 /*
  * These functions do not call setmosi or getmiso if respective flag
- * (SPI_MASTER_NO_RX or SPI_MASTER_NO_TX) is set, so they are safe to
+ * (SPI_CONTROLLER_NO_RX or SPI_CONTROLLER_NO_TX) is set, so they are safe to
  * call when such pin is not present or defined in the controller.
  * A separate set of callbacks is defined to get highest possible
  * speed in the generic case (when both MISO and MOSI lines are
@@ -416,11 +416,11 @@ static int spi_gpio_probe(struct platform_device *pdev)
 	if (!spi_gpio->mosi) {
 		/* HW configuration without MOSI pin
 		 *
-		 * No setting SPI_MASTER_NO_RX here - if there is only
+		 * No setting SPI_CONTROLLER_NO_RX here - if there is only
 		 * a MOSI pin connected the host can still do RX by
 		 * changing the direction of the line.
 		 */
-		master->flags = SPI_MASTER_NO_TX;
+		master->flags = SPI_CONTROLLER_NO_TX;
 	}
 
 	master->bus_num = pdev->id;
@@ -438,7 +438,7 @@ static int spi_gpio_probe(struct platform_device *pdev)
 	bb->chipselect = spi_gpio_chipselect;
 	bb->set_line_direction = spi_gpio_set_direction;
 
-	if (master->flags & SPI_MASTER_NO_TX) {
+	if (master->flags & SPI_CONTROLLER_NO_TX) {
 		bb->txrx_word[SPI_MODE_0] = spi_gpio_spec_txrx_word_mode0;
 		bb->txrx_word[SPI_MODE_1] = spi_gpio_spec_txrx_word_mode1;
 		bb->txrx_word[SPI_MODE_2] = spi_gpio_spec_txrx_word_mode2;
diff --git a/drivers/spi/spi-lp8841-rtc.c b/drivers/spi/spi-lp8841-rtc.c
index 2d436541d6c2..ccaa7a946359 100644
--- a/drivers/spi/spi-lp8841-rtc.c
+++ b/drivers/spi/spi-lp8841-rtc.c
@@ -75,14 +75,14 @@ bitbang_txrx_be_cpha0_lsb(struct spi_lp8841_rtc *data,
 	for (; likely(bits); bits--) {
 
 		/* setup LSB (to slave) on leading edge */
-		if ((flags & SPI_MASTER_NO_TX) == 0)
+		if ((flags & SPI_CONTROLLER_NO_TX) == 0)
 			setmosi(data, (word & 1));
 
 		usleep_range(usecs, usecs + 1);	/* T(setup) */
 
 		/* sample LSB (from slave) on trailing edge */
 		word >>= 1;
-		if ((flags & SPI_MASTER_NO_RX) == 0)
+		if ((flags & SPI_CONTROLLER_NO_RX) == 0)
 			word |= (getmiso(data) << 31);
 
 		setsck(data, !cpol);
@@ -113,7 +113,7 @@ spi_lp8841_rtc_transfer_one(struct spi_master *master,
 		while (likely(count > 0)) {
 			word = *tx++;
 			bitbang_txrx_be_cpha0_lsb(data, 1, 0,
-					SPI_MASTER_NO_RX, word, 8);
+					SPI_CONTROLLER_NO_RX, word, 8);
 			count--;
 		}
 	} else if (rx) {
@@ -121,7 +121,7 @@ spi_lp8841_rtc_transfer_one(struct spi_master *master,
 		writeb(data->state, data->iomem);
 		while (likely(count > 0)) {
 			word = bitbang_txrx_be_cpha0_lsb(data, 1, 0,
-					SPI_MASTER_NO_TX, word, 8);
+					SPI_CONTROLLER_NO_TX, word, 8);
 			*rx++ = word;
 			count--;
 		}
diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
index 141562c882f1..7a9eba35ac38 100644
--- a/drivers/spi/spi-meson-spicc.c
+++ b/drivers/spi/spi-meson-spicc.c
@@ -864,7 +864,7 @@ static int meson_spicc_probe(struct platform_device *pdev)
 				     SPI_BPW_MASK(24) |
 				     SPI_BPW_MASK(16) |
 				     SPI_BPW_MASK(8);
-	master->flags = (SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX);
+	master->flags = (SPI_CONTROLLER_MUST_RX | SPI_CONTROLLER_MUST_TX);
 	master->min_speed_hz = spicc->data->min_speed_hz;
 	master->max_speed_hz = spicc->data->max_speed_hz;
 	master->setup = meson_spicc_setup;
diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 39272ad6641b..0757985947dd 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -1142,7 +1142,7 @@ static int mtk_spi_probe(struct platform_device *pdev)
 		master->mode_bits |= SPI_CS_HIGH;
 
 	if (mdata->dev_comp->must_tx)
-		master->flags = SPI_MASTER_MUST_TX;
+		master->flags = SPI_CONTROLLER_MUST_TX;
 	if (mdata->dev_comp->ipm_design)
 		master->mode_bits |= SPI_LOOP | SPI_RX_DUAL | SPI_TX_DUAL |
 				     SPI_RX_QUAD | SPI_TX_QUAD;
diff --git a/drivers/spi/spi-pci1xxxx.c b/drivers/spi/spi-pci1xxxx.c
index 4445d82409d6..d23c42839da1 100644
--- a/drivers/spi/spi-pci1xxxx.c
+++ b/drivers/spi/spi-pci1xxxx.c
@@ -365,7 +365,7 @@ static int pci1xxxx_spi_probe(struct pci_dev *pdev, const struct pci_device_id *
 		spi_host->bits_per_word_mask = SPI_BPW_MASK(8);
 		spi_host->max_speed_hz = PCI1XXXX_SPI_MAX_CLOCK_HZ;
 		spi_host->min_speed_hz = PCI1XXXX_SPI_MIN_CLOCK_HZ;
-		spi_host->flags = SPI_MASTER_MUST_TX;
+		spi_host->flags = SPI_CONTROLLER_MUST_TX;
 		spi_master_set_devdata(spi_host, spi_sub_ptr);
 		ret = devm_spi_register_master(dev, spi_host);
 		if (ret)
diff --git a/drivers/spi/spi-pic32.c b/drivers/spi/spi-pic32.c
index f2af5e653f3d..e9b4c9cb97fb 100644
--- a/drivers/spi/spi-pic32.c
+++ b/drivers/spi/spi-pic32.c
@@ -773,7 +773,7 @@ static int pic32_spi_probe(struct platform_device *pdev)
 	master->max_speed_hz	= clk_get_rate(pic32s->clk);
 	master->setup		= pic32_spi_setup;
 	master->cleanup		= pic32_spi_cleanup;
-	master->flags		= SPI_MASTER_MUST_TX | SPI_MASTER_MUST_RX;
+	master->flags		= SPI_CONTROLLER_MUST_TX | SPI_CONTROLLER_MUST_RX;
 	master->bits_per_word_mask	= SPI_BPW_MASK(8) | SPI_BPW_MASK(16) |
 					  SPI_BPW_MASK(32);
 	master->transfer_one		= pic32_spi_one_transfer;
diff --git a/drivers/spi/spi-rb4xx.c b/drivers/spi/spi-rb4xx.c
index 5073736d3d1f..c817889a7797 100644
--- a/drivers/spi/spi-rb4xx.c
+++ b/drivers/spi/spi-rb4xx.c
@@ -156,7 +156,7 @@ static int rb4xx_spi_probe(struct platform_device *pdev)
 	master->num_chipselect = 3;
 	master->mode_bits = SPI_TX_DUAL;
 	master->bits_per_word_mask = SPI_BPW_MASK(8);
-	master->flags = SPI_MASTER_MUST_TX;
+	master->flags = SPI_CONTROLLER_MUST_TX;
 	master->transfer_one = rb4xx_transfer_one;
 	master->set_cs = rb4xx_set_cs;
 
diff --git a/drivers/spi/spi-slave-mt27xx.c b/drivers/spi/spi-slave-mt27xx.c
index 4e4d426bfb43..6d6772974783 100644
--- a/drivers/spi/spi-slave-mt27xx.c
+++ b/drivers/spi/spi-slave-mt27xx.c
@@ -414,7 +414,7 @@ static int mtk_spi_slave_probe(struct platform_device *pdev)
 	mdata->dev_comp = of_id->data;
 
 	if (mdata->dev_comp->must_rx)
-		ctlr->flags = SPI_MASTER_MUST_RX;
+		ctlr->flags = SPI_CONTROLLER_MUST_RX;
 
 	platform_set_drvdata(pdev, ctlr);
 
diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 6d10fa4ab783..423212bd0675 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -1750,7 +1750,7 @@ static const struct stm32_spi_cfg stm32f4_spi_cfg = {
 	.baud_rate_div_min = STM32F4_SPI_BR_DIV_MIN,
 	.baud_rate_div_max = STM32F4_SPI_BR_DIV_MAX,
 	.has_fifo = false,
-	.flags = SPI_MASTER_MUST_TX,
+	.flags = SPI_CONTROLLER_MUST_TX,
 };
 
 static const struct stm32_spi_cfg stm32h7_spi_cfg = {
diff --git a/drivers/spi/spi-xtensa-xtfpga.c b/drivers/spi/spi-xtensa-xtfpga.c
index 24dc845b940e..dbd85d7a1526 100644
--- a/drivers/spi/spi-xtensa-xtfpga.c
+++ b/drivers/spi/spi-xtensa-xtfpga.c
@@ -87,7 +87,7 @@ static int xtfpga_spi_probe(struct platform_device *pdev)
 	if (!master)
 		return -ENOMEM;
 
-	master->flags = SPI_MASTER_NO_RX;
+	master->flags = SPI_CONTROLLER_NO_RX;
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 16);
 	master->bus_num = pdev->dev.id;
 	master->dev.of_node = pdev->dev.of_node;
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 32c94eae8926..44ba6798046c 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -1623,10 +1623,6 @@ spi_transfer_is_last(struct spi_controller *ctlr, struct spi_transfer *xfer)
 #define spi_master			spi_controller
 
 #define SPI_MASTER_HALF_DUPLEX		SPI_CONTROLLER_HALF_DUPLEX
-#define SPI_MASTER_NO_RX		SPI_CONTROLLER_NO_RX
-#define SPI_MASTER_NO_TX		SPI_CONTROLLER_NO_TX
-#define SPI_MASTER_MUST_RX		SPI_CONTROLLER_MUST_RX
-#define SPI_MASTER_MUST_TX		SPI_CONTROLLER_MUST_TX
 
 #define spi_master_get_devdata(_ctlr)	spi_controller_get_devdata(_ctlr)
 #define spi_master_set_devdata(_ctlr, _data)	\
-- 
2.40.0.1.gaa8946217a0b

