Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC934678BDC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 00:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbjAWXLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 18:11:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232564AbjAWXLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 18:11:14 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75440392B1;
        Mon, 23 Jan 2023 15:11:07 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id bk15so34558153ejb.9;
        Mon, 23 Jan 2023 15:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nlmvRomHtcVCsgxI9mL922H8tGvbIBB4555k2PJ7e+4=;
        b=qKgqUzVNLgqlWfIYsU7V/r2tsX8f5caJIwrn8KpeyZYKxN3Qe1J3txm00XqFbNDl1r
         /RBxZL/68PoZRWqHL7+8x+627WggjG9Js1PY1nRCGeZoHCUHKYoHGpsIoyZOHsPfwiNK
         oAnUejOPqrLQy1B8IBBlWYcNDENQdNpRdGc67TRhicwEohP3Zb9TFNxw2j4S45g8s/No
         DmTmSdahyCyltIx+loNg295n7kLgba7URWXWyhxA9xMmZYR2V7Xc3ds2GY9tJjk5Kud8
         IqkOwU866jxc79ZmRpOW1MJGd7/bHybWMNmBpbu53cZWVeu2LI9wMWckdrKjWHStSTlL
         +BHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nlmvRomHtcVCsgxI9mL922H8tGvbIBB4555k2PJ7e+4=;
        b=bJPwEuEDJvHqu0qIVXU/z74ti4ymVRNUwpfY7xaQgVlDBYQJpesyUOAjLFwjbjMiJv
         EQDnA9PWwo3VTYwnsf+XS4q3O4G7beCUGdLJ+vnesRpwI8fh9WS0Rv6EwWhkSEuU6tAS
         VxSlBh4ITuOTdfo5yKZzbp2ZhTdohC+LizZGZO1Ay8JLZZf6PmTpLRzdnm2IcU8wqa1A
         GptuRRXtJ25Ojk5YzCnUeU64pK65yCmwjedAhM0FrPcZ3imtiIKGij1zC/tYhFi3X2fk
         gc6bKa4Ou2Ses80ICQ+C5Dkmcw2cSax7iZ9/s7npNopM/15uLwuS52zYhuB2Ore3mJvU
         RSpg==
X-Gm-Message-State: AFqh2koWz9NxRAk1yxw7SyV8WZU8u4/abn5mXuRpDzcOsLjxYPoORFJu
        xGNR5PSDvThALffrQ+/94IEU0OVPJlY=
X-Google-Smtp-Source: AMrXdXtB7FOv3psBSi5KvTml/nYh3YkMxgq8+cU6jrrvoGpjdsvjjaMlplc4xsd+SFKtB7TbLTPddQ==
X-Received: by 2002:a17:906:2798:b0:870:97f1:3877 with SMTP id j24-20020a170906279800b0087097f13877mr23491896ejc.53.1674515465569;
        Mon, 23 Jan 2023 15:11:05 -0800 (PST)
Received: from localhost.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id b21-20020a170906709500b0084d43e23436sm72601ejk.38.2023.01.23.15.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 15:11:05 -0800 (PST)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Markuss Broks <markuss.broks@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 2/2] iio: light: Add support for AMS TCS3490 light sensor
Date:   Tue, 24 Jan 2023 01:10:25 +0200
Message-Id: <20230123231028.26073-3-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230123231028.26073-1-markuss.broks@gmail.com>
References: <20230123231028.26073-1-markuss.broks@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a driver for AMS TCS3490 Color Light-to-Digital Converter. This
device provides color and IR (red, green, blue, clear and IR) light
sensing. The color sensing can be used for light source detection and
color temperature measurements.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
---
 MAINTAINERS                 |   7 +
 drivers/iio/light/Kconfig   |  12 ++
 drivers/iio/light/Makefile  |   1 +
 drivers/iio/light/tcs3490.c | 270 ++++++++++++++++++++++++++++++++++++
 4 files changed, 290 insertions(+)
 create mode 100644 drivers/iio/light/tcs3490.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 30e032abd196..3c47e132e4dd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1144,6 +1144,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/light/ams,as73211.yaml
 F:	drivers/iio/light/as73211.c
 
+AMS TCS3490 DRIVER
+M:	Markuss Broks <markuss.broks@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/light/ams,tcs3490.yaml
+F:	drivers/iio/light/tcs3490.c
+
 AMT (Automatic Multicast Tunneling)
 M:	Taehee Yoo <ap420073@gmail.com>
 L:	netdev@vger.kernel.org
diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 0d4447df7200..582e3853e835 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -494,6 +494,18 @@ config TCS3472
 	  This driver can also be built as a module.  If so, the module
 	  will be called tcs3472.
 
+config TCS3490
+	tristate "AMS TCS3490 color light-to-digital converter"
+	depends on I2C
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	help
+	  Say Y here if you have an AMS TCS3490 color light-to digital converter
+	  which provides RGB color and IR light sensing.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called tcs3490.
+
 config SENSORS_TSL2563
 	tristate "TAOS TSL2560, TSL2561, TSL2562 and TSL2563 ambient light sensors"
 	depends on I2C
diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
index d74d2b5ff14c..81663465d8c1 100644
--- a/drivers/iio/light/Makefile
+++ b/drivers/iio/light/Makefile
@@ -47,6 +47,7 @@ obj-$(CONFIG_ST_UVIS25_I2C)	+= st_uvis25_i2c.o
 obj-$(CONFIG_ST_UVIS25_SPI)	+= st_uvis25_spi.o
 obj-$(CONFIG_TCS3414)		+= tcs3414.o
 obj-$(CONFIG_TCS3472)		+= tcs3472.o
+obj-$(CONFIG_TCS3490)		+= tcs3490.o
 obj-$(CONFIG_SENSORS_TSL2563)	+= tsl2563.o
 obj-$(CONFIG_TSL2583)		+= tsl2583.o
 obj-$(CONFIG_TSL2591)		+= tsl2591.o
diff --git a/drivers/iio/light/tcs3490.c b/drivers/iio/light/tcs3490.c
new file mode 100644
index 000000000000..6fa2c220a6a1
--- /dev/null
+++ b/drivers/iio/light/tcs3490.c
@@ -0,0 +1,270 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * AMS TCS3490 Color Light-to-Digital Converter
+ *
+ * Copyright (c) 2023 Markuss Broks <markuss.broks@gmail.com>
+ */
+
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/iio/iio.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+
+#define TCS3490_SUSPEND			0
+#define TCS3490_POWER_ON_INTERNAL	BIT(0)
+#define TCS3490_ADC_ENABLE		BIT(1)
+
+#define TCS3490_ENABLE			0x80
+#define TCS3490_GAIN_CTRL		0x8f
+#define TCS3490_REVID			0x91
+#define TCS3490_ID			0x92
+#define TCS3490_STATUS			0x93
+
+#define TCS3490_CLEAR_IR_BASE		0x94
+#define TCS3490_RED_BASE		0x96
+#define TCS3490_GREEN_BASE		0x98
+#define TCS3490_BLUE_BASE		0x9a
+
+#define TCS3490_CLEAR_IR_MODE		0xc0
+
+#define TCS3490_STATUS_RGBC_VALID	BIT(0)
+#define TCS3490_STATUS_ALS_SAT		BIT(7)
+
+#define TCS3490_MODE_CLEAR		0
+#define TCS3490_MODE_IR			BIT(7)
+
+#define TCS3490_GAIN_MASK		GENMASK(1, 0)
+
+#define TCS3490_LIGHT_CHANNEL(_color, _idx) {		\
+	.type = IIO_INTENSITY,				\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
+	.info_mask_shared_by_type =			\
+			BIT(IIO_CHAN_INFO_CALIBSCALE),	\
+	.address = _idx,				\
+	.modified = 1,					\
+	.channel2 = IIO_MOD_LIGHT_##_color,		\
+}							\
+
+struct tcs3490 {
+	struct i2c_client *client;
+	struct regmap *regmap;
+	struct regulator *vdd_supply;
+};
+
+const unsigned int tcs3490_gain_multiplier[] = {1, 4, 16, 64};
+
+static const struct regmap_config tcs3490_regmap_config = {
+	.reg_bits	= 8,
+	.val_bits	= 8,
+};
+
+static const struct iio_chan_spec tcs3490_channels[] = {
+	TCS3490_LIGHT_CHANNEL(RED, TCS3490_RED_BASE),
+	TCS3490_LIGHT_CHANNEL(GREEN, TCS3490_GREEN_BASE),
+	TCS3490_LIGHT_CHANNEL(BLUE, TCS3490_BLUE_BASE),
+	TCS3490_LIGHT_CHANNEL(CLEAR, TCS3490_CLEAR_IR_BASE),
+	TCS3490_LIGHT_CHANNEL(IR, TCS3490_CLEAR_IR_BASE),
+};
+
+static int tcs3490_get_gain(struct tcs3490 *data, int *val)
+{
+	int ret;
+	unsigned int gain;
+
+	ret = regmap_read(data->regmap, TCS3490_GAIN_CTRL, &gain);
+	if (ret)
+		return ret;
+
+	gain &= TCS3490_GAIN_MASK;
+
+	*val = tcs3490_gain_multiplier[gain];
+	return 0;
+}
+
+static int tcs3490_set_gain(struct tcs3490 *data, unsigned int gain)
+{
+	int ret, i;
+
+	for (i = 0; i < ARRAY_SIZE(tcs3490_gain_multiplier); i++) {
+		if (tcs3490_gain_multiplier[i] == gain)
+			break;
+	}
+
+	if (i == ARRAY_SIZE(tcs3490_gain_multiplier))
+		return -EINVAL;
+
+	ret = regmap_write(data->regmap, TCS3490_GAIN_CTRL, i);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int tcs3490_read_channel(struct tcs3490 *data,
+				const struct iio_chan_spec *chan,
+				int *val)
+{
+	unsigned int tries = 20;
+	unsigned int val_l, val_h, status;
+	int ret;
+
+	ret = regmap_write(data->regmap, TCS3490_ENABLE,
+			   TCS3490_POWER_ON_INTERNAL | TCS3490_ADC_ENABLE);
+	if (ret)
+		return ret;
+
+	switch (chan->channel2) {
+	case IIO_MOD_LIGHT_RED:
+	case IIO_MOD_LIGHT_GREEN:
+	case IIO_MOD_LIGHT_BLUE:
+		break;
+	case IIO_MOD_LIGHT_CLEAR:
+		ret = regmap_write(data->regmap, TCS3490_CLEAR_IR_MODE, TCS3490_MODE_CLEAR);
+		break;
+	case IIO_MOD_LIGHT_IR:
+		ret = regmap_write(data->regmap, TCS3490_CLEAR_IR_MODE, TCS3490_MODE_IR);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	do {
+		usleep_range(3000, 4000);
+
+		ret = regmap_read(data->regmap, TCS3490_STATUS, &status);
+		if (ret)
+			return ret;
+		if (status & TCS3490_STATUS_RGBC_VALID)
+			break;
+	} while (--tries);
+
+	if (!tries)
+		return -ETIMEDOUT;
+
+	ret = regmap_read(data->regmap, chan->address, &val_l);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(data->regmap, chan->address + 1, &val_h);
+	if (ret)
+		return ret;
+
+	*val = (val_h << 8) | val_l;
+
+	ret = regmap_write(data->regmap, TCS3490_ENABLE, TCS3490_SUSPEND);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int tcs3490_read_raw(struct iio_dev *indio_dev,
+			    const struct iio_chan_spec *chan,
+			    int *val, int *val2, long mask)
+{
+	struct tcs3490 *data = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = tcs3490_read_channel(data, chan, val);
+		if (ret < 0)
+			return ret;
+
+		ret = IIO_VAL_INT;
+		break;
+	case IIO_CHAN_INFO_CALIBSCALE:
+		ret = tcs3490_get_gain(data, val);
+		ret = IIO_VAL_INT;
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	if (ret < 0)
+		return ret;
+	return IIO_VAL_INT;
+}
+
+static int tcs3490_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int val, int val2, long mask)
+{
+	struct tcs3490 *data = iio_priv(indio_dev);
+
+	if (mask == IIO_CHAN_INFO_CALIBSCALE)
+		return tcs3490_set_gain(data, val);
+
+	return -EINVAL;
+}
+
+static const struct iio_info tcs3490_info = {
+	.read_raw = tcs3490_read_raw,
+	.write_raw = tcs3490_write_raw,
+};
+
+static int tcs3490_probe(struct i2c_client *client)
+{
+	struct tcs3490 *data;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+
+	data->client = client;
+
+	data->vdd_supply = devm_regulator_get(&client->dev, "vdd");
+	if (IS_ERR(data->vdd_supply))
+		return dev_err_probe(&client->dev, PTR_ERR(data->vdd_supply),
+				     "Unable to get regulators\n");
+
+	data->regmap = devm_regmap_init_i2c(client, &tcs3490_regmap_config);
+	if (IS_ERR(data->regmap))
+		return dev_err_probe(&client->dev, PTR_ERR(data->regmap),
+				     "Failed to register the register map\n");
+
+	ret = regulator_enable(data->vdd_supply);
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+				     "Unable to enable regulators\n");
+
+	indio_dev->name = "tcs3490";
+	indio_dev->info = &tcs3490_info;
+	indio_dev->channels = tcs3490_channels;
+	indio_dev->num_channels = ARRAY_SIZE(tcs3490_channels);
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = regmap_write(data->regmap, TCS3490_ENABLE, TCS3490_SUSPEND);
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(&client->dev, indio_dev);
+}
+
+static const struct of_device_id tcs3490_of_match[] = {
+	{ .compatible = "ams,tcs3490", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, tcs3490_of_match);
+
+static struct i2c_driver tcs3490_driver = {
+	.driver = {
+		.name = "tcs3490",
+		.of_match_table = of_match_ptr(tcs3490_of_match),
+	},
+	.probe_new = tcs3490_probe,
+};
+
+module_i2c_driver(tcs3490_driver);
+
+MODULE_DESCRIPTION("AMS TCS3490 Color Light-to-Digital Converter driver");
+MODULE_AUTHOR("Markuss Broks <markuss.broks@gmail.com>");
+MODULE_LICENSE("GPL");
-- 
2.39.0

