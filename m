Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A2B73512F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 11:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjFSJ5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 05:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbjFSJ4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 05:56:54 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F95B2;
        Mon, 19 Jun 2023 02:56:47 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35J5L9Ds009890;
        Mon, 19 Jun 2023 04:56:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=eVBy1DdQ/Htxu3+Iafc8MS5EBhxzrsgLDgBhuvU1Eb4=;
 b=DT1xOklxgV6UPh9R+Tavlnl5NICGwHGvuCcgRDeqxujgkLhm9v5QyvL5gGQaeGmgcx5e
 7rwwDPMcjAfR078Sedtj8FLR+/sTbCAPb9tDmOjNl22qNtulcugL1w/tbve/Bddilz0P
 yo/8TBCsejlmBAj/tyxxsIY1bUzIOxDdqMTbvf+txp5H7RelFEHNU5urTIPWiOIus1Qm
 8B+1uxZM+WSGBhTFnkblsw3BJLIaFuHRzrNOAAUsFEq0EfZwQl5HoCtEozY/zDjiCPzO
 6j8g0wQebvu9aMhTWcRIo4HFdsSWM8LpWdio7CDYTUqhmj+b05/4uv0DcesPBEeSwYcO ug== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3r9a809n3e-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Jun 2023 04:56:27 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Mon, 19 Jun
 2023 10:56:23 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 19 Jun 2023 10:56:23 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id A7D793560;
        Mon, 19 Jun 2023 09:56:23 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <broonie@kernel.org>, <lee@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linus.walleij@linaro.org>,
        <vkoul@kernel.org>
CC:     <robh+dt@kernel.org>, <conor+dt@kernel.org>, <lgirdwood@gmail.com>,
        <yung-chuan.liao@linux.intel.com>, <sanyog.r.kale@intel.com>,
        <pierre-louis.bossart@linux.intel.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <devicetree@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 5/6] spi: cs42l43: Add SPI controller support
Date:   Mon, 19 Jun 2023 10:56:22 +0100
Message-ID: <20230619095623.1987742-6-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230619095623.1987742-1-ckeepax@opensource.cirrus.com>
References: <20230619095623.1987742-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: a70tk5S88Vx8RasnJaQhzB3mo4B2FQen
X-Proofpoint-GUID: a70tk5S88Vx8RasnJaQhzB3mo4B2FQen
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Tanure <tanureal@opensource.cirrus.com>

The CS42L43 is an audio CODEC with integrated MIPI SoundWire interface
(Version 1.2.1 compliant), I2C, SPI, and I2S/TDM interfaces designed
for portable applications. It provides a high dynamic range, stereo
DAC for headphone output, two integrated Class D amplifiers for
loudspeakers, and two ADCs for wired headset microphone input or
stereo line input. PDM inputs are provided for digital microphones.

The SPI component incorporates a SPI controller interface for
communication with other peripheral components.

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

No change since v4.

Thanks,
Charles

 MAINTAINERS               |   1 +
 drivers/spi/Kconfig       |   7 +
 drivers/spi/Makefile      |   1 +
 drivers/spi/spi-cs42l43.c | 281 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 290 insertions(+)
 create mode 100644 drivers/spi/spi-cs42l43.c

diff --git a/MAINTAINERS b/MAINTAINERS
index eed125df31b27..94c6a6900c1e6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4929,6 +4929,7 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/sound/cirrus,cs*
 F:	drivers/mfd/cs42l43*
 F:	drivers/pinctrl/cirrus/pinctrl-cs42l43*
+F:	drivers/spi/spi-cs42l43*
 F:	include/dt-bindings/sound/cs*
 F:	include/linux/mfd/cs42l43*
 F:	include/sound/cs*
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 3de2ebe8294aa..f6ce06de41051 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -281,6 +281,13 @@ config SPI_COLDFIRE_QSPI
 	  This enables support for the Coldfire QSPI controller in master
 	  mode.
 
+config SPI_CS42L43
+	tristate "Cirrus Logic CS42L43 SPI controller"
+	depends on MFD_CS42L43 && PINCTRL_CS42L43
+	help
+	  This enables support for the SPI controller inside the Cirrus Logic
+	  CS42L43 audio codec.
+
 config SPI_DAVINCI
 	tristate "Texas Instruments DaVinci/DA8x/OMAP-L/AM1x SoC SPI controller"
 	depends on ARCH_DAVINCI || ARCH_KEYSTONE || COMPILE_TEST
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 28c4817a8a74a..49937ea0d73d0 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -40,6 +40,7 @@ obj-$(CONFIG_SPI_CADENCE_QUADSPI)	+= spi-cadence-quadspi.o
 obj-$(CONFIG_SPI_CADENCE_XSPI)		+= spi-cadence-xspi.o
 obj-$(CONFIG_SPI_CLPS711X)		+= spi-clps711x.o
 obj-$(CONFIG_SPI_COLDFIRE_QSPI)		+= spi-coldfire-qspi.o
+obj-$(CONFIG_SPI_CS42L43)		+= spi-cs42l43.o
 obj-$(CONFIG_SPI_DAVINCI)		+= spi-davinci.o
 obj-$(CONFIG_SPI_DLN2)			+= spi-dln2.o
 obj-$(CONFIG_SPI_DESIGNWARE)		+= spi-dw.o
diff --git a/drivers/spi/spi-cs42l43.c b/drivers/spi/spi-cs42l43.c
new file mode 100644
index 0000000000000..08b07ac42259a
--- /dev/null
+++ b/drivers/spi/spi-cs42l43.c
@@ -0,0 +1,281 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// CS42L43 SPI Controller Driver
+//
+// Copyright (C) 2022-2023 Cirrus Logic, Inc. and
+//                         Cirrus Logic International Semiconductor Ltd.
+
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/mfd/cs42l43.h>
+#include <linux/mfd/cs42l43-regs.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/spi/spi.h>
+#include <linux/units.h>
+
+#define CS42L43_FIFO_SIZE		16
+#define CS42L43_SPI_ROOT_HZ		(4 * HZ_PER_MHZ)
+#define CS42L43_SPI_MAX_LENGTH		65532
+
+enum cs42l43_spi_cmd {
+	CS42L43_WRITE,
+	CS42L43_READ
+};
+
+struct cs42l43_spi {
+	struct device *dev;
+	struct regmap *regmap;
+	struct spi_controller *ctlr;
+};
+
+static const unsigned int cs42l43_clock_divs[] = {
+	2, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30
+};
+
+static int cs42l43_spi_tx(struct regmap *regmap, const u8 *buf, unsigned int len)
+{
+	const u8 *end = buf + len;
+	u32 val = 0;
+	int ret;
+
+	while (buf < end) {
+		const u8 *block = min(buf + CS42L43_FIFO_SIZE, end);
+
+		for (; buf < block - (sizeof(u32) - 1); buf += sizeof(u32))
+			regmap_raw_write(regmap, CS42L43_TX_DATA, buf, sizeof(u32));
+
+		if (buf < block) {
+			unsigned int residue = end - buf;
+
+			memcpy(&val, buf, residue);
+			regmap_raw_write(regmap, CS42L43_TX_DATA, &val, sizeof(u32));
+			buf += residue;
+		}
+
+		regmap_write(regmap, CS42L43_TRAN_CONFIG8, CS42L43_SPI_TX_DONE_MASK);
+
+		ret = regmap_read_poll_timeout(regmap, CS42L43_TRAN_STATUS1,
+					       val, (val & CS42L43_SPI_TX_REQUEST_MASK),
+					       1000, 5000);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int cs42l43_spi_rx(struct regmap *regmap, u8 *buf, unsigned int len)
+{
+	u8 *end = buf + len;
+	u32 val;
+	int ret;
+
+	while (buf < end) {
+		const u8 *block = min(buf + CS42L43_FIFO_SIZE, end);
+
+		ret = regmap_read_poll_timeout(regmap, CS42L43_TRAN_STATUS1,
+					       val, (val & CS42L43_SPI_RX_REQUEST_MASK),
+					       1000, 5000);
+		if (ret)
+			return ret;
+
+		for (; buf < block - (sizeof(u32) - 1); buf += sizeof(u32)) {
+			ret = regmap_raw_read(regmap, CS42L43_RX_DATA, buf, sizeof(u32));
+			if (ret)
+				return ret;
+		}
+
+		if (buf < block) {
+			unsigned int residue = end - buf;
+
+			ret = regmap_raw_read(regmap, CS42L43_RX_DATA, &val, sizeof(u32));
+			if (ret)
+				return ret;
+
+			memcpy(buf, &val, residue);
+			buf += residue;
+		}
+
+		regmap_write(regmap, CS42L43_TRAN_CONFIG8, CS42L43_SPI_RX_DONE_MASK);
+	}
+
+	return 0;
+}
+
+static int cs42l43_transfer_one(struct spi_controller *ctlr, struct spi_device *spi,
+				struct spi_transfer *tfr)
+{
+	struct cs42l43_spi *priv = spi_controller_get_devdata(spi->controller);
+	int i, ret = -EINVAL;
+
+	for (i = 0; i < ARRAY_SIZE(cs42l43_clock_divs); i++) {
+		if (CS42L43_SPI_ROOT_HZ / cs42l43_clock_divs[i] <= tfr->speed_hz)
+			break;
+	}
+
+	if (i == ARRAY_SIZE(cs42l43_clock_divs))
+		return -EINVAL;
+
+	regmap_write(priv->regmap, CS42L43_SPI_CLK_CONFIG1, i);
+
+	if (tfr->tx_buf) {
+		regmap_write(priv->regmap, CS42L43_TRAN_CONFIG3,
+			     CS42L43_WRITE | 0x2 << CS42L43_SPI_WORD_SIZE_SHIFT);
+		regmap_write(priv->regmap, CS42L43_TRAN_CONFIG4, tfr->len - 1);
+	} else if (tfr->rx_buf) {
+		regmap_write(priv->regmap, CS42L43_TRAN_CONFIG3,
+			     CS42L43_READ | 0x2 << CS42L43_SPI_WORD_SIZE_SHIFT);
+		regmap_write(priv->regmap, CS42L43_TRAN_CONFIG5, tfr->len - 1);
+	}
+
+	regmap_write(priv->regmap, CS42L43_TRAN_CONFIG1, CS42L43_SPI_START_MASK);
+
+	if (tfr->tx_buf)
+		ret = cs42l43_spi_tx(priv->regmap, (const u8 *)tfr->tx_buf, tfr->len);
+	else if (tfr->rx_buf)
+		ret = cs42l43_spi_rx(priv->regmap, (u8 *)tfr->rx_buf, tfr->len);
+
+	return ret;
+}
+
+static void cs42l43_set_cs(struct spi_device *spi, bool is_high)
+{
+	struct cs42l43_spi *priv = spi_controller_get_devdata(spi->controller);
+
+	if (spi_get_chipselect(spi, 0) == 0)
+		regmap_write(priv->regmap, CS42L43_SPI_CONFIG2, !is_high);
+}
+
+static int cs42l43_prepare_message(struct spi_controller *ctlr, struct spi_message *msg)
+{
+	struct cs42l43_spi *priv = spi_controller_get_devdata(ctlr);
+	struct spi_device *spi = msg->spi;
+	unsigned int spi_config1 = 0;
+
+	/* select another internal CS, which doesn't exist, so CS 0 is not used */
+	if (spi_get_csgpiod(spi, 0))
+		spi_config1 |= 1 << CS42L43_SPI_SS_SEL_SHIFT;
+	if (spi->mode & SPI_CPOL)
+		spi_config1 |= CS42L43_SPI_CPOL_MASK;
+	if (spi->mode & SPI_CPHA)
+		spi_config1 |= CS42L43_SPI_CPHA_MASK;
+	if (spi->mode & SPI_3WIRE)
+		spi_config1 |= CS42L43_SPI_THREE_WIRE_MASK;
+
+	regmap_write(priv->regmap, CS42L43_SPI_CONFIG1, spi_config1);
+
+	return 0;
+}
+
+static int cs42l43_prepare_transfer_hardware(struct spi_controller *ctlr)
+{
+	struct cs42l43_spi *priv = spi_controller_get_devdata(ctlr);
+	int ret;
+
+	ret = regmap_write(priv->regmap, CS42L43_BLOCK_EN2, CS42L43_SPI_MSTR_EN_MASK);
+	if (ret)
+		dev_err(priv->dev, "Failed to enable SPI controller: %d\n", ret);
+
+	return ret;
+}
+
+static int cs42l43_unprepare_transfer_hardware(struct spi_controller *ctlr)
+{
+	struct cs42l43_spi *priv = spi_controller_get_devdata(ctlr);
+	int ret;
+
+	ret = regmap_write(priv->regmap, CS42L43_BLOCK_EN2, 0);
+	if (ret)
+		dev_err(priv->dev, "Failed to disable SPI controller: %d\n", ret);
+
+	return ret;
+}
+
+static size_t cs42l43_spi_max_length(struct spi_device *spi)
+{
+	return CS42L43_SPI_MAX_LENGTH;
+}
+
+static int cs42l43_spi_probe(struct platform_device *pdev)
+{
+	struct cs42l43 *cs42l43 = dev_get_drvdata(pdev->dev.parent);
+	struct cs42l43_spi *priv;
+	struct fwnode_handle *fwnode = dev_fwnode(cs42l43->dev);
+	int ret;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->ctlr = devm_spi_alloc_master(&pdev->dev, sizeof(*priv->ctlr));
+	if (!priv->ctlr)
+		return -ENOMEM;
+
+	spi_controller_set_devdata(priv->ctlr, priv);
+
+	priv->dev = &pdev->dev;
+	priv->regmap = cs42l43->regmap;
+
+	priv->ctlr->prepare_message = cs42l43_prepare_message;
+	priv->ctlr->prepare_transfer_hardware = cs42l43_prepare_transfer_hardware;
+	priv->ctlr->unprepare_transfer_hardware = cs42l43_unprepare_transfer_hardware;
+	priv->ctlr->transfer_one = cs42l43_transfer_one;
+	priv->ctlr->set_cs = cs42l43_set_cs;
+	priv->ctlr->max_transfer_size = cs42l43_spi_max_length;
+
+	if (is_of_node(fwnode))
+		fwnode = fwnode_get_named_child_node(fwnode, "spi");
+
+	device_set_node(&priv->ctlr->dev, fwnode);
+
+	priv->ctlr->mode_bits = SPI_3WIRE | SPI_MODE_X_MASK;
+	priv->ctlr->flags = SPI_CONTROLLER_HALF_DUPLEX;
+	priv->ctlr->bits_per_word_mask = SPI_BPW_MASK(8) | SPI_BPW_MASK(16) |
+					 SPI_BPW_MASK(32);
+	priv->ctlr->min_speed_hz = CS42L43_SPI_ROOT_HZ /
+				   cs42l43_clock_divs[ARRAY_SIZE(cs42l43_clock_divs) - 1];
+	priv->ctlr->max_speed_hz = CS42L43_SPI_ROOT_HZ / cs42l43_clock_divs[0];
+	priv->ctlr->use_gpio_descriptors = true;
+	priv->ctlr->auto_runtime_pm = true;
+
+	devm_pm_runtime_enable(priv->dev);
+	pm_runtime_idle(priv->dev);
+
+	regmap_write(priv->regmap, CS42L43_TRAN_CONFIG6, CS42L43_FIFO_SIZE - 1);
+	regmap_write(priv->regmap, CS42L43_TRAN_CONFIG7, CS42L43_FIFO_SIZE - 1);
+
+	// Disable Watchdog timer and enable stall
+	regmap_write(priv->regmap, CS42L43_SPI_CONFIG3, 0);
+	regmap_write(priv->regmap, CS42L43_SPI_CONFIG4, CS42L43_SPI_STALL_ENA_MASK);
+
+	ret = devm_spi_register_controller(priv->dev, priv->ctlr);
+	if (ret) {
+		pm_runtime_disable(priv->dev);
+		dev_err(priv->dev, "Failed to register SPI controller: %d\n", ret);
+	}
+
+	return ret;
+}
+
+static const struct platform_device_id cs42l43_spi_id_table[] = {
+	{ "cs42l43-spi", },
+	{}
+};
+MODULE_DEVICE_TABLE(platform, cs42l43_spi_id_table);
+
+static struct platform_driver cs42l43_spi_driver = {
+	.driver = {
+		.name	= "cs42l43-spi",
+	},
+	.probe		= cs42l43_spi_probe,
+	.id_table	= cs42l43_spi_id_table,
+};
+module_platform_driver(cs42l43_spi_driver);
+
+MODULE_DESCRIPTION("CS42L43 SPI Driver");
+MODULE_AUTHOR("Lucas Tanure <tanureal@opensource.cirrus.com>");
+MODULE_AUTHOR("Maciej Strozek <mstrozek@opensource.cirrus.com>");
+MODULE_LICENSE("GPL");
-- 
2.30.2

