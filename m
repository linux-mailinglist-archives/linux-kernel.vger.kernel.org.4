Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32A6F618987
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 21:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbiKCU0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 16:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbiKCUZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 16:25:56 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E141D0D3
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 13:25:54 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id v1so4380850wrt.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 13:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TC/S8fegbzAu0hQykhV2xCdnvqKdkE9Dz0YGKKQfFpI=;
        b=GIDkE78dzkJ6VhB12QpzwyfMSsnxm6YAoxkWGBM2Xc5XX4g5K0flN/u4e2g33/dYU9
         w/AS36WmBIvXaQpj4gaC8mn1hUBRgJv53sIfXsQkFaUBQQzAMZkw2qy2KvOs76Cxtq+4
         auNTC//fnf5nxVlMr5PuoBb33rG7eN3TsdBbF0IJhK83a+7XVlaEiHWsw5Dny0IDNlen
         yqIEl2gV0lTmID96njfhmxBMf2BA3pD3xWC+nZE6jv96prcIQ8Won0hxKpCuLCnQP4Pq
         NWNJHmI5nJmQ9SPyRqAjI2JIZNMWNZ0w23ugN0LOf3mYj6pGwHbRg5Uv2iMxspJyQbzW
         TAdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TC/S8fegbzAu0hQykhV2xCdnvqKdkE9Dz0YGKKQfFpI=;
        b=XzgfKAnhFOYyxb7QWxvfhb5W/9UPJg8T8TuF5CnKv8tDMOKkaXLPvKSHhsp+tRJZRo
         hIzP/Qp+zn7Z1IRSASktUmoPsMX/Lny1YZ+O84OBKS5CYqPfe6Tsdl6h9nlyseA5C2QQ
         7iI8e6HlQMRx5f8NSscrAH//Puy6OfK9MMLFW9h+vdSp4g3QtYzHuKmN8bFBbPulPmYd
         b8p+abqITPE6Uip3Yp4YVMn7hZeqw7CfECDiFBivfOWQ7KZxOdkjW4AQ5X+QrwZb7XJz
         WvtzGmPRE75iReVqy/PovRCDJAjCQ4E+ryYfG6vGNdE6q9jsanAvwIvYKZiVLjEikENT
         t2+g==
X-Gm-Message-State: ACrzQf0SNo5OpEuv4u0EPOxYKKi2MVtODP7Mu+WhHBzeQYBm5v3wMQj/
        YiL5mk8+OeHptiDDlDFik+K2C6yD7+SdYZaj
X-Google-Smtp-Source: AMsMyM4tWeyIO3P5Dsk0ERXLv63tpnBpWNgo8lo6DsfM5ToMPu2vDOcvThPggVTEOAH6PyAAGhbXxA==
X-Received: by 2002:a05:6000:90b:b0:22c:beec:5b26 with SMTP id bz11-20020a056000090b00b0022cbeec5b26mr19915166wrb.490.1667507153205;
        Thu, 03 Nov 2022 13:25:53 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id g12-20020a05600c4ecc00b003b4fe03c881sm787946wmq.48.2022.11.03.13.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 13:25:52 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Lee Jones <lee@kernel.org>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Marcello Sylvester Bauer <sylv@sylv.io>,
        Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: [PATCH v7 2/2] mfd: max597x: Add support for MAX5970 and MAX5978
Date:   Thu,  3 Nov 2022 21:25:48 +0100
Message-Id: <20221103202548.1921397-3-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221103202548.1921397-1-Naresh.Solanki@9elements.com>
References: <20221103202548.1921397-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Rudolph <patrick.rudolph@9elements.com>

Implement a regulator driver with IRQ support for fault management.
Written against documentation [1] and [2] and tested on real hardware.

Every channel has its own regulator supplies nammed 'vss1-supply' and
'vss2-supply'. The regulator supply is used to determine the output
voltage, as the smart switch provides no output regulation.
The driver requires the 'shunt-resistor-micro-ohms' property to be
present in Device Tree to properly calculate current related
values.

Datasheet links:
1: https://datasheets.maximintegrated.com/en/ds/MAX5970.pdf
2: https://datasheets.maximintegrated.com/en/ds/MAX5978.pdf

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 drivers/mfd/Kconfig         |  12 +++++
 drivers/mfd/Makefile        |   1 +
 drivers/mfd/max597x.c       |  92 ++++++++++++++++++++++++++++++++
 include/linux/mfd/max597x.h | 103 ++++++++++++++++++++++++++++++++++++
 4 files changed, 208 insertions(+)
 create mode 100644 drivers/mfd/max597x.c
 create mode 100644 include/linux/mfd/max597x.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 8b93856de432..416fe7986b7b 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -253,6 +253,18 @@ config MFD_MADERA_SPI
 	  Support for the Cirrus Logic Madera platform audio SoC
 	  core functionality controlled via SPI.
 
+config MFD_MAX597X
+	tristate "Maxim 597x Power Switch and Monitor"
+	depends on I2C
+	depends on OF
+	select MFD_CORE
+	select REGMAP_I2C
+	help
+	  This driver controls a Maxim 5970/5978 switch via I2C bus.
+	  The MAX5970/5978 is a smart switch with no output regulation, but
+	  fault protection and voltage and current monitoring capabilities.
+	  Also it supports upto 4 indication LEDs.
+
 config MFD_CS47L15
 	bool "Cirrus Logic CS47L15"
 	select PINCTRL_CS47L15
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 7ed3ef4a698c..819d711fa748 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -161,6 +161,7 @@ obj-$(CONFIG_MFD_DA9063)	+= da9063.o
 obj-$(CONFIG_MFD_DA9150)	+= da9150-core.o
 
 obj-$(CONFIG_MFD_MAX14577)	+= max14577.o
+obj-$(CONFIG_MFD_MAX597X)	+= max597x.o
 obj-$(CONFIG_MFD_MAX77620)	+= max77620.o
 obj-$(CONFIG_MFD_MAX77650)	+= max77650.o
 obj-$(CONFIG_MFD_MAX77686)	+= max77686.o
diff --git a/drivers/mfd/max597x.c b/drivers/mfd/max597x.c
new file mode 100644
index 000000000000..2c64edb6b6dd
--- /dev/null
+++ b/drivers/mfd/max597x.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Maxim MAX5970/MAX5978 MFD Driver
+ *
+ * Copyright (c) 2022 9elements GmbH
+ *
+ * Author: Patrick Rudolph <patrick.rudolph@9elements.com>
+ */
+
+#include <linux/i2c.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/max597x.h>
+#include <linux/regmap.h>
+
+static const struct regmap_config max597x_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = MAX_REGISTERS,
+};
+
+static const struct mfd_cell max597x_cells[] = {
+	{ .name = "max597x-regulator", },
+	{ .name = "max597x-iio", },
+	{ .name = "max597x-led", },
+};
+
+static int max597x_probe(struct i2c_client *i2c, const struct i2c_device_id *id)
+{
+	struct max597x_data *ddata;
+	enum max597x_chip_type chip = id->driver_data;
+
+	ddata = devm_kzalloc(&i2c->dev, sizeof(*ddata),	GFP_KERNEL);
+	if (!ddata)
+		return -ENOMEM;
+
+	/* Initialize num of switch based on chip type for later use by regulator
+	 * & iio cells
+	 */
+	switch (chip) {
+	case MAX597x_TYPE_MAX5970:
+		ddata->num_switches = MAX5970_NUM_SWITCHES;
+		break;
+	case MAX597x_TYPE_MAX5978:
+		ddata->num_switches = MAX5978_NUM_SWITCHES;
+		break;
+	}
+
+	ddata->regmap = devm_regmap_init_i2c(i2c, &max597x_regmap_config);
+	if (IS_ERR(ddata->regmap)) {
+		dev_err(&i2c->dev, "Failed to initialise regmap");
+		return -EINVAL;
+	}
+
+	/* IRQ used by regulator cell */
+	ddata->irq = i2c->irq;
+	ddata->dev = &i2c->dev;
+	i2c_set_clientdata(i2c, ddata);
+
+	return devm_mfd_add_devices(ddata->dev, PLATFORM_DEVID_AUTO,
+				    max597x_cells, ARRAY_SIZE(max597x_cells),
+				    NULL, 0, NULL);
+}
+
+static const struct i2c_device_id max597x_table[] = {
+	{ .name = "max5970", MAX597x_TYPE_MAX5970 },
+	{ .name = "max5978", MAX597x_TYPE_MAX5978 },
+};
+
+MODULE_DEVICE_TABLE(i2c, max597x_table);
+
+static const struct of_device_id max597x_of_match[] = {
+	{ .compatible = "maxim,max5970", .data = (void *)MAX597x_TYPE_MAX5970 },
+	{ .compatible = "maxim,max5978", .data = (void *)MAX597x_TYPE_MAX5978 },
+	{ /* sentinel */ }
+};
+
+MODULE_DEVICE_TABLE(of, max597x_of_match);
+
+static struct i2c_driver max597x_driver = {
+	.id_table = max597x_table,
+	.driver = {
+		.name = "max597x",
+		.of_match_table = of_match_ptr(max597x_of_match),
+		},
+	.probe = max597x_probe,
+};
+
+module_i2c_driver(max597x_driver);
+
+MODULE_AUTHOR("Patrick Rudolph <patrick.rudolph@9elements.com>");
+MODULE_DESCRIPTION("MAX597X Power Switch and Monitor");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/mfd/max597x.h b/include/linux/mfd/max597x.h
new file mode 100644
index 000000000000..f88a57f0e4f2
--- /dev/null
+++ b/include/linux/mfd/max597x.h
@@ -0,0 +1,103 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Maxim MAX5970/MAX5978 MFD Driver
+ *
+ * Copyright (c) 2022 9elements GmbH
+ *
+ * Author: Patrick Rudolph <patrick.rudolph@9elements.com>
+ */
+
+#ifndef MFD_MAX597X_H
+#define MFD_MAX597X_H
+
+#include <linux/device.h>
+#include <linux/regmap.h>
+
+/* Number of switch based on chip variant */
+#define MAX5970_NUM_SWITCHES 2
+#define MAX5978_NUM_SWITCHES 1
+/* Both chip variant have 4 indication LEDs used by LED cell */
+#define MAX597X_NUM_LEDS     4
+
+enum max597x_chip_type {
+	MAX597x_TYPE_MAX5978 = 1,
+	MAX597x_TYPE_MAX5970,
+};
+
+#define MAX5970_REG_CURRENT_L(ch)		(0x01 + (ch) * 4)
+#define MAX5970_REG_CURRENT_H(ch)		(0x00 + (ch) * 4)
+#define MAX5970_REG_VOLTAGE_L(ch)		(0x03 + (ch) * 4)
+#define MAX5970_REG_VOLTAGE_H(ch)		(0x02 + (ch) * 4)
+#define MAX5970_REG_MON_RANGE			0x18
+#define  MAX5970_MON_MASK				0x3
+#define  MAX5970_MON(reg, ch)		(((reg) >> ((ch) * 2)) & MAX5970_MON_MASK)
+#define  MAX5970_MON_MAX_RANGE_UV		16000000
+
+#define MAX5970_REG_CH_UV_WARN_H(ch)	(0x1A + (ch) * 10)
+#define MAX5970_REG_CH_UV_WARN_L(ch)	(0x1B + (ch) * 10)
+#define MAX5970_REG_CH_UV_CRIT_H(ch)	(0x1C + (ch) * 10)
+#define MAX5970_REG_CH_UV_CRIT_L(ch)	(0x1D + (ch) * 10)
+#define MAX5970_REG_CH_OV_WARN_H(ch)	(0x1E + (ch) * 10)
+#define MAX5970_REG_CH_OV_WARN_L(ch)	(0x1F + (ch) * 10)
+#define MAX5970_REG_CH_OV_CRIT_H(ch)	(0x20 + (ch) * 10)
+#define MAX5970_REG_CH_OV_CRIT_L(ch)	(0x21 + (ch) * 10)
+
+#define  MAX5970_VAL2REG_H(x)			(((x) >> 2) & 0xFF)
+#define  MAX5970_VAL2REG_L(x)			((x) & 0x3)
+
+#define MAX5970_REG_DAC_FAST(ch)		(0x2E + (ch))
+
+#define MAX5970_FAST2SLOW_RATIO			200
+
+#define MAX5970_REG_STATUS0				0x31
+#define  MAX5970_CB_IFAULTF(ch)			(1 << (ch))
+#define  MAX5970_CB_IFAULTS(ch)			(1 << ((ch) + 4))
+
+#define MAX5970_REG_STATUS1				0x32
+#define  STATUS1_PROT_MASK				0x3
+#define  STATUS1_PROT(reg) \
+	(((reg) >> 6) & STATUS1_PROT_MASK)
+#define  STATUS1_PROT_SHUTDOWN			0
+#define  STATUS1_PROT_CLEAR_PG			1
+#define  STATUS1_PROT_ALERT_ONLY		2
+
+#define MAX5970_REG_STATUS2				0x33
+#define  MAX5970_IRNG_MASK				0x3
+#define  MAX5970_IRNG(reg, ch)	\
+						(((reg) >> ((ch) * 2)) & MAX5970_IRNG_MASK)
+
+#define MAX5970_REG_STATUS3				0x34
+#define  MAX5970_STATUS3_ALERT			BIT(4)
+#define  MAX5970_STATUS3_PG(ch)			BIT(ch)
+
+#define MAX5970_REG_FAULT0				0x35
+#define  UV_STATUS_WARN(ch)				BIT(ch)
+#define  UV_STATUS_CRIT(ch)				BIT(ch + 4)
+
+#define MAX5970_REG_FAULT1				0x36
+#define  OV_STATUS_WARN(ch)				BIT(ch)
+#define  OV_STATUS_CRIT(ch)				BIT(ch + 4)
+
+#define MAX5970_REG_FAULT2				0x37
+#define  OC_STATUS_WARN(ch)				BIT(ch)
+
+#define MAX5970_REG_CHXEN				0x3b
+#define  CHXEN(ch)						(3 << (ch * 2))
+
+#define MAX5970_REG_LED_FLASH			0x43
+
+#define MAX_REGISTERS					0x49
+#define ADC_MASK						0x3FF
+
+struct max597x_data {
+	struct device *dev;
+	int irq;
+	int num_switches;
+	struct regmap *regmap;
+	/* Chip specific parameters needed by regulator & iio cells */
+	u32 irng[MAX5970_NUM_SWITCHES];
+	u32 mon_rng[MAX5970_NUM_SWITCHES];
+	u32 shunt_micro_ohms[MAX5970_NUM_SWITCHES];
+};
+
+#endif				/* _MAX597X_H */
-- 
2.37.3

