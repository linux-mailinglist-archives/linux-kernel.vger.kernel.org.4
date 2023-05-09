Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F65B6FCACE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 18:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235801AbjEIQJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 12:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235753AbjEIQJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 12:09:20 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28182198E;
        Tue,  9 May 2023 09:09:17 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 0E568FF808;
        Tue,  9 May 2023 16:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1683648556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZCRkhFR06vPBPYnYS6pds8F9tYZWCNedEUh6aEbvGHw=;
        b=K26BywLsaW+WXL8J/wyF+28wpw8+j5fhpe0NGB6iboS1/6eb9xf1kfmbenQkA2Dxv2zWbl
        L4UeDkXPUGoyPaSxhLDfZ/Nb2omwvAYb+CvavlsjNSBRDrYyZheoxEhAicjUMUoM8+jDEK
        o4yGOY+fXUyIk3Md7SLsvkhx2I1Vmj+eWUKSylX4tpz9CyO9n4CnB0zSmuGniDv1ip40fz
        LoKZAIkNtcBjPO5If11/IcQL1mMXN5Ao9ncEug+u8DGpudHWReW1mHQyPo2BV9VyqTYr7E
        fkeJorCecd2BGzBLftLkHMjojsjWCaB6r3WBFAFbOH1UkIaBKHa7DPFWye5nNg==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Herve Codina <herve.codina@bootlin.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v4 2/3] iio: potentiometer: Add support for the Renesas X9250 potentiometers
Date:   Tue,  9 May 2023 18:08:51 +0200
Message-Id: <20230509160852.158101-3-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509160852.158101-1-herve.codina@bootlin.com>
References: <20230509160852.158101-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Renesas X9250 integrates four digitally controlled potentiometers.
On each potentiometer, the X9250T has a 100 kOhms total resistance and
the X9250U has a 50 kOhms total resistance.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/iio/potentiometer/Kconfig  |  10 ++
 drivers/iio/potentiometer/Makefile |   1 +
 drivers/iio/potentiometer/x9250.c  | 223 +++++++++++++++++++++++++++++
 3 files changed, 234 insertions(+)
 create mode 100644 drivers/iio/potentiometer/x9250.c

diff --git a/drivers/iio/potentiometer/Kconfig b/drivers/iio/potentiometer/Kconfig
index 01dd3f858d99..e6a9a3c67845 100644
--- a/drivers/iio/potentiometer/Kconfig
+++ b/drivers/iio/potentiometer/Kconfig
@@ -136,4 +136,14 @@ config TPL0102
 	  To compile this driver as a module, choose M here: the
 	  module will be called tpl0102.
 
+config X9250
+	tristate "Renesas X9250 quad controlled potentiometers"
+	depends on SPI
+	help
+	  Enable support for the Renesas X9250 quad controlled
+	  potentiometers.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called x9250.
+
 endmenu
diff --git a/drivers/iio/potentiometer/Makefile b/drivers/iio/potentiometer/Makefile
index 5ebb8e3bbd76..d11fb739176c 100644
--- a/drivers/iio/potentiometer/Makefile
+++ b/drivers/iio/potentiometer/Makefile
@@ -15,3 +15,4 @@ obj-$(CONFIG_MCP4131) += mcp4131.o
 obj-$(CONFIG_MCP4531) += mcp4531.o
 obj-$(CONFIG_MCP41010) += mcp41010.o
 obj-$(CONFIG_TPL0102) += tpl0102.o
+obj-$(CONFIG_X9250) += x9250.o
diff --git a/drivers/iio/potentiometer/x9250.c b/drivers/iio/potentiometer/x9250.c
new file mode 100644
index 000000000000..3d4ca18d1f14
--- /dev/null
+++ b/drivers/iio/potentiometer/x9250.c
@@ -0,0 +1,223 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *
+ * x9250.c  --  Renesas X9250 potentiometers IIO driver
+ *
+ * Copyright 2023 CS GROUP France
+ *
+ * Author: Herve Codina <herve.codina@bootlin.com>
+ */
+
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/iio/iio.h>
+#include <linux/limits.h>
+#include <linux/module.h>
+#include <linux/regulator/consumer.h>
+#include <linux/slab.h>
+#include <linux/spi/spi.h>
+
+struct x9250_cfg {
+	const char *name;
+	int kohms;
+};
+
+struct x9250 {
+	struct spi_device *spi;
+	const struct x9250_cfg *cfg;
+	struct gpio_desc *wp_gpio;
+};
+
+#define X9250_ID		0x50
+#define X9250_CMD_RD_WCR(_p)    (0x90 | (_p))
+#define X9250_CMD_WR_WCR(_p)    (0xa0 | (_p))
+
+static int x9250_write8(struct x9250 *x9250, u8 cmd, u8 val)
+{
+	u8 txbuf[3];
+
+	txbuf[0] = X9250_ID;
+	txbuf[1] = cmd;
+	txbuf[2] = val;
+
+	return spi_write_then_read(x9250->spi, txbuf, ARRAY_SIZE(txbuf), NULL, 0);
+}
+
+static int x9250_read8(struct x9250 *x9250, u8 cmd, u8 *val)
+{
+	u8 txbuf[2];
+
+	txbuf[0] = X9250_ID;
+	txbuf[1] = cmd;
+
+	return spi_write_then_read(x9250->spi, txbuf, ARRAY_SIZE(txbuf), val, 1);
+}
+
+#define X9250_CHANNEL(ch) {						\
+	.type = IIO_RESISTANCE,						\
+	.indexed = 1,							\
+	.output = 1,							\
+	.channel = (ch),						\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
+	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_RAW),	\
+}
+
+static const struct iio_chan_spec x9250_channels[] = {
+	X9250_CHANNEL(0),
+	X9250_CHANNEL(1),
+	X9250_CHANNEL(2),
+	X9250_CHANNEL(3),
+};
+
+static int x9250_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
+			  int *val, int *val2, long mask)
+{
+	struct x9250 *x9250 = iio_priv(indio_dev);
+	int ch = chan->channel;
+	int ret;
+	u8 v;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = x9250_read8(x9250, X9250_CMD_RD_WCR(ch), &v);
+		if (ret)
+			return ret;
+		*val = v;
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		*val = 1000 * x9250->cfg->kohms;
+		*val2 = U8_MAX;
+		return IIO_VAL_FRACTIONAL;
+	}
+
+	return -EINVAL;
+}
+
+static int x9250_read_avail(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
+			    const int **vals, int *type, int *length, long mask)
+{
+	static const int range[] = {0, 1, 255}; /* min, step, max */
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		*length = ARRAY_SIZE(range);
+		*vals = range;
+		*type = IIO_VAL_INT;
+		return IIO_AVAIL_RANGE;
+	}
+
+	return -EINVAL;
+}
+
+static int x9250_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
+			   int val, int val2, long mask)
+{
+	struct x9250 *x9250 = iio_priv(indio_dev);
+	int ch = chan->channel;
+	int ret;
+
+	if (mask != IIO_CHAN_INFO_RAW)
+		return -EINVAL;
+
+	if (val > U8_MAX || val < 0)
+		return -EINVAL;
+
+	gpiod_set_value_cansleep(x9250->wp_gpio, 0);
+	ret = x9250_write8(x9250, X9250_CMD_WR_WCR(ch), val);
+	gpiod_set_value_cansleep(x9250->wp_gpio, 1);
+
+	return ret;
+}
+
+static const struct iio_info x9250_info = {
+	.read_raw = x9250_read_raw,
+	.read_avail = x9250_read_avail,
+	.write_raw = x9250_write_raw,
+};
+
+enum x9250_type {
+	X9250T,
+	X9250U,
+};
+
+static const struct x9250_cfg x9250_cfg[] = {
+	[X9250T] = { .name = "x9250t", .kohms =  100, },
+	[X9250U] = { .name = "x9250u", .kohms =  50, },
+};
+
+static const char *const x9250_regulator_names[] = {
+	"vcc",
+	"avp",
+	"avn",
+};
+
+static int x9250_probe(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev;
+	struct x9250 *x9250;
+	int ret;
+
+	ret = devm_regulator_bulk_get_enable(&spi->dev, ARRAY_SIZE(x9250_regulator_names),
+					     x9250_regulator_names);
+	if (ret)
+		return dev_err_probe(&spi->dev, ret, "Failed to get regulators\n");
+
+	/*
+	 * The x9250 needs a 5ms maximum delay after the power-supplies are set
+	 * before performing the first write (1ms for the first read).
+	 */
+	usleep_range(5000, 6000);
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*x9250));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	x9250 = iio_priv(indio_dev);
+	x9250->spi = spi;
+	x9250->cfg = device_get_match_data(&spi->dev);
+	if (!x9250->cfg)
+		x9250->cfg = &x9250_cfg[spi_get_device_id(spi)->driver_data];
+
+	x9250->wp_gpio = devm_gpiod_get_optional(&spi->dev, "wp", GPIOD_OUT_LOW);
+	if (IS_ERR(x9250->wp_gpio))
+		return dev_err_probe(&spi->dev, PTR_ERR(x9250->wp_gpio),
+				     "failed to get wp gpio\n");
+
+	indio_dev->info = &x9250_info;
+	indio_dev->channels = x9250_channels;
+	indio_dev->num_channels = ARRAY_SIZE(x9250_channels);
+	indio_dev->name = x9250->cfg->name;
+
+	return devm_iio_device_register(&spi->dev, indio_dev);
+}
+
+static const struct of_device_id x9250_of_match[] = {
+	{ .compatible = "renesas,x9250t", &x9250_cfg[X9250T]},
+	{ .compatible = "renesas,x9250u", &x9250_cfg[X9250U]},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, x9250_of_match);
+
+static const struct spi_device_id x9250_id_table[] = {
+	{ "x9250t", X9250T },
+	{ "x9250u", X9250U },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, x9250_id_table);
+
+static struct spi_driver x9250_spi_driver = {
+	.driver  = {
+		.name = "x9250",
+		.of_match_table = x9250_of_match,
+	},
+	.id_table = x9250_id_table,
+	.probe  = x9250_probe,
+};
+
+module_spi_driver(x9250_spi_driver);
+
+MODULE_AUTHOR("Herve Codina <herve.codina@bootlin.com>");
+MODULE_DESCRIPTION("X9250 ALSA SoC driver");
+MODULE_LICENSE("GPL");
-- 
2.40.1

