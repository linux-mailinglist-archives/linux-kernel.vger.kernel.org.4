Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7B2600A62
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 11:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbiJQJWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 05:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiJQJVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 05:21:52 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A6713D30;
        Mon, 17 Oct 2022 02:21:48 -0700 (PDT)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by gandalf.ozlabs.org (Postfix) with ESMTP id 4MrWb13WWgz4xGm;
        Mon, 17 Oct 2022 20:16:45 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MrWZx343vz4wgv;
        Mon, 17 Oct 2022 20:16:41 +1100 (AEDT)
From:   =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To:     linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
        Naresh Solanki <naresh.solanki@9elements.com>
Subject: [PATCH linux v2 2/3] spi: aspeed: Handle custom decoding ranges
Date:   Mon, 17 Oct 2022 11:16:23 +0200
Message-Id: <20221017091624.130227-3-clg@kaod.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221017091624.130227-1-clg@kaod.org>
References: <20221017091624.130227-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "ranges" property predefines settings for the decoding ranges of
each CS. If found in the DT, the driver applies the settings at probe
time. The default behavior is to set the decoding range of each CS
using the flash device size when the spi slave is setup.

Cc: Naresh Solanki <naresh.solanki@9elements.com>
Cc: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 drivers/spi/spi-aspeed-smc.c | 65 +++++++++++++++++++++++++++++++++++-
 1 file changed, 64 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
index b90571396a60..75e1d08bbd00 100644
--- a/drivers/spi/spi-aspeed-smc.c
+++ b/drivers/spi/spi-aspeed-smc.c
@@ -96,6 +96,7 @@ struct aspeed_spi {
 	u32			 ahb_base_phy;
 	u32			 ahb_window_size;
 	struct device		*dev;
+	bool                     fixed_windows;
 
 	struct clk		*clk;
 	u32			 clk_freq;
@@ -382,6 +383,7 @@ static const char *aspeed_spi_get_name(struct spi_mem *mem)
 
 struct aspeed_spi_window {
 	u32 cs;
+	u32 reg;
 	u32 offset;
 	u32 size;
 };
@@ -396,6 +398,7 @@ static void aspeed_spi_get_windows(struct aspeed_spi *aspi,
 	for (cs = 0; cs < aspi->data->max_cs; cs++) {
 		reg_val = readl(aspi->regs + CE0_SEGMENT_ADDR_REG + cs * 4);
 		windows[cs].cs = cs;
+		windows[cs].reg = reg_val;
 		windows[cs].size = data->segment_end(aspi, reg_val) -
 			data->segment_start(aspi, reg_val);
 		windows[cs].offset = data->segment_start(aspi, reg_val) - aspi->ahb_base_phy;
@@ -572,7 +575,8 @@ static int aspeed_spi_dirmap_create(struct spi_mem_dirmap_desc *desc)
 	if (op->data.dir != SPI_MEM_DATA_IN)
 		return -EOPNOTSUPP;
 
-	aspeed_spi_chip_adjust_window(chip, desc->info.offset, desc->info.length);
+	if (!aspi->fixed_windows)
+		aspeed_spi_chip_adjust_window(chip, desc->info.offset, desc->info.length);
 
 	if (desc->info.length > chip->ahb_window_size)
 		dev_warn(aspi->dev, "CE%d window (%dMB) too small for mapping",
@@ -712,6 +716,61 @@ static void aspeed_spi_enable(struct aspeed_spi *aspi, bool enable)
 		aspeed_spi_chip_enable(aspi, cs, enable);
 }
 
+static int aspeed_spi_chip_read_ranges(struct device_node *node, struct aspeed_spi *aspi)
+{
+	const char *range_prop = "ranges";
+	struct property *prop;
+	struct aspeed_spi_window ranges[ASPEED_SPI_MAX_NUM_CS];
+	int prop_size;
+	int count;
+	int ret;
+	int i;
+
+	prop = of_find_property(node, range_prop, &prop_size);
+	if (!prop)
+		return 0;
+
+	count = prop_size / sizeof(*ranges);
+	if (count > aspi->data->max_cs) {
+		dev_err(aspi->dev, "invalid '%s' property %d\n", range_prop, count);
+		return -EINVAL;
+	}
+
+	if (count < aspi->data->max_cs)
+		dev_dbg(aspi->dev, "'%s' property does not cover all CE\n",
+			range_prop);
+
+	ret = of_property_read_u32_array(node, range_prop, (u32 *)ranges, count * 4);
+	if (ret)
+		return ret;
+
+	dev_info(aspi->dev, "Using preset decoding ranges\n");
+	for (i = 0; i < count; i++) {
+		struct aspeed_spi_window *win = &ranges[i];
+
+		if (win->cs > aspi->data->max_cs) {
+			dev_err(aspi->dev, "CE%d range is invalid", win->cs);
+			return -EINVAL;
+		}
+
+		/* Trim top bit of the address to keep offset */
+		win->offset &= aspi->ahb_window_size - 1;
+
+		/* Minimal check */
+		if (win->offset + win->size > aspi->ahb_window_size) {
+			dev_warn(aspi->dev, "CE%d range is too large", win->cs);
+				return -EINVAL;
+		}
+
+		ret = aspeed_spi_set_window(aspi, win);
+		if (ret)
+			return ret;
+	}
+
+	aspi->fixed_windows = true;
+	return 0;
+}
+
 static int aspeed_spi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -767,6 +826,10 @@ static int aspeed_spi_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ret = aspeed_spi_chip_read_ranges(dev->of_node, aspi);
+	if (ret)
+		return ret;
+
 	/* IRQ is for DMA, which the driver doesn't support yet */
 
 	ctlr->mode_bits = SPI_RX_DUAL | SPI_TX_DUAL | data->mode_bits;
-- 
2.37.3

