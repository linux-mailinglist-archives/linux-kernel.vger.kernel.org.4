Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D9A74DA66
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 17:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbjGJPu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 11:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233576AbjGJPt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 11:49:56 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077641A2;
        Mon, 10 Jul 2023 08:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689004195; x=1720540195;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X4L2zj0s8AySDlJPOTwB53/1Cp1xNye7i+ww1MhojGE=;
  b=fHmP0QpkPTXwHfacbvlfPLDuWCQX3wbQW1BepwDN7vDiY6l1G03IB6Jk
   /JsZon6CluP1P9tWpgjWVDHVQRV5hwE59G07+sDneQAK2YDh3KvvDMp45
   vh528HIXLha2rJ1Hw8rWb3RmVwPR9HyUOsxIovWfNd9FwSb2uRC4FCdAh
   gvoVhhZOELTzS3ae/AlRjmTB/5SAatnGQmZUe4dzNSoALbyugA6SMFNOm
   LrcVxDonXdYK1wZJ+Xcogc7cPOzUPB4RWpxu/3l1Jrx4uWXaY27clw6kG
   yH5lSNRsiU1xso6f+rNxTOcfpO9n5fyvOTMcUVwQD7gqARxp3HDR3fwAT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="361842577"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="361842577"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 08:49:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="720743962"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="720743962"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 10 Jul 2023 08:49:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D2DB477B; Mon, 10 Jul 2023 18:49:34 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Amit Kumar Mahapatra via Alsa-devel 
        <alsa-devel@alsa-project.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     Sanjay R Mehta <sanju.mehta@amd.com>,
        Radu Pirea <radu_nicolae.pirea@upb.ro>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Subject: [PATCH v2 12/15] spi: Get rid of old SPI_MASTER_MUST_TX & SPI_MASTER_MUST_RX
Date:   Mon, 10 Jul 2023 18:49:29 +0300
Message-Id: <20230710154932.68377-13-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230710154932.68377-1-andriy.shevchenko@linux.intel.com>
References: <20230710154932.68377-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the users from SPI_MASTER_MUST_TX and/or SPI_MASTER_MUST_RX
to SPI_CONTROLLER_MUST_TX and/or SPI_CONTROLLER_MUST_RX respectively
and kill the not used anymore definitions.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-at91-usart.c   | 2 +-
 drivers/spi/spi-atmel.c        | 2 +-
 drivers/spi/spi-davinci.c      | 2 +-
 drivers/spi/spi-fsl-lpspi.c    | 2 +-
 drivers/spi/spi-meson-spicc.c  | 2 +-
 drivers/spi/spi-mt65xx.c       | 2 +-
 drivers/spi/spi-pci1xxxx.c     | 2 +-
 drivers/spi/spi-pic32.c        | 2 +-
 drivers/spi/spi-rb4xx.c        | 2 +-
 drivers/spi/spi-slave-mt27xx.c | 2 +-
 drivers/spi/spi-stm32.c        | 2 +-
 include/linux/spi/spi.h        | 2 --
 12 files changed, 11 insertions(+), 13 deletions(-)

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
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index ce77dcf47b96..cdc3addfe117 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -1645,8 +1645,6 @@ spi_transfer_is_last(struct spi_controller *ctlr, struct spi_transfer *xfer)
 #define spi_master			spi_controller
 
 #define SPI_MASTER_HALF_DUPLEX		SPI_CONTROLLER_HALF_DUPLEX
-#define SPI_MASTER_MUST_RX		SPI_CONTROLLER_MUST_RX
-#define SPI_MASTER_MUST_TX		SPI_CONTROLLER_MUST_TX
 
 #define spi_master_get_devdata(_ctlr)	spi_controller_get_devdata(_ctlr)
 #define spi_master_set_devdata(_ctlr, _data)	\
-- 
2.40.0.1.gaa8946217a0b

