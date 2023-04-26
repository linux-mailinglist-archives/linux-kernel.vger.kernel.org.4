Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 549746EF092
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 11:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239886AbjDZJEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 05:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239757AbjDZJEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 05:04:10 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC43640DE
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 02:04:04 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f173af665fso44813935e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 02:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1682499843; x=1685091843;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gTe9Erp8A3FszZ2u9J7n6BQSH7RUrGdSBEbUVVQT+CU=;
        b=DvWydOSzPpE2ZNg3OBCevSDs4MTY/t+5ZWETDzwzyN/I8tIzRI7Rx/OzTu3xjeWW73
         zbgJfjtIT4VgZfH5XGr8bu7Gy6imXfp/UJeYV2m+KhUrHru4hkVUma6NyJUbgISv7RhE
         aF04cjZI+7kgTyyaHrPHyl7rTdNFaQqXavFx2M/q2WJqSFnnwiLDsKG9SGIyuEYm5qsQ
         +Nb59obfPcbFYgUuAcJjNEibJOIq0JiQ8uWPHcfFjZRVFDPscJa32HZgp5smEGNFNKxw
         X5RpuPt0EtCYDTTO4dzc1ZbZGY2+c/I9JdDnBx+34f3aXZM+oPYWuBW/qpMTlYor3Awn
         ceWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682499843; x=1685091843;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gTe9Erp8A3FszZ2u9J7n6BQSH7RUrGdSBEbUVVQT+CU=;
        b=CojVVqnwY3szC83h2fIGc38atJ292l6pIoSuNGZifNQT59mSizCpv2kxayeIJcJKCk
         Sog2YgmVUaNlV5YwE0N7L8Pu3+zShL0IDj4tKuVRezu/kBeRMb6G4rodKT0CmtxcerEm
         0z53TMEv8Cf9Kef1bvbm2nBsg0z5NuJbbVmRkofYXSPwqADpQI8LM8yqgyFSjT1UGWr1
         HZbFsaWRE0fsSMAGtYSrMhctb9iqn+vLDIJuSLvQtCeqkK107sRbCcJLWf4am91cHn36
         O6yYQ2NE5lTd4mjlIbhIb5MoXC9Cdj5rCd2LaCm95fD5OTmWYZS+lLdgFFCCMLqc7gQd
         JQzQ==
X-Gm-Message-State: AAQBX9ei4d16y3ZEHHrEXfJhrDea4MQUFQJx7699SpxxadSCJ3pYtGrn
        ha2gHZvT/zLOgPh5Rf30BudZBoIaJJwUTv0LbrqekA==
X-Google-Smtp-Source: AKy350bKiZnHIZkU69q2t7FbxHuEOy8iMEQ+J0Vc3jVLtV490stbBq/2MUC8X0rk6GPFseUQ1Kv9Yw==
X-Received: by 2002:a05:600c:3657:b0:3f0:4734:bef8 with SMTP id y23-20020a05600c365700b003f04734bef8mr12041627wmq.39.1682499843148;
        Wed, 26 Apr 2023 02:04:03 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id k18-20020a05600c0b5200b003edf2dc7ca3sm17243673wmr.34.2023.04.26.02.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 02:04:02 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: [PATCH] hwmon: (max597x) Add Maxim Max597x
Date:   Wed, 26 Apr 2023 11:03:55 +0200
Message-Id: <20230426090356.745979-1-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Rudolph <patrick.rudolph@9elements.com>

Add support for the Maxim Max59x power switch with current/voltage
monitor.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 drivers/hwmon/Kconfig   |   9 ++
 drivers/hwmon/Makefile  |   1 +
 drivers/hwmon/max597x.c | 212 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 222 insertions(+)
 create mode 100644 drivers/hwmon/max597x.c

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 5b3b76477b0e..164d980d9de2 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1097,6 +1097,15 @@ config SENSORS_MAX31760
 	  This driver can also be built as a module. If so, the module
 	  will be called max31760.
 
+config SENSORS_MAX597X
+	tristate "Maxim 597x power switch and monitor"
+	depends on I2C
+	depends on OF
+	select MFD_MAX597X
+	help
+	  This driver exposes Maxim 5970/5978 voltage/current monitoring
+	  interface.
+
 config SENSORS_MAX6620
 	tristate "Maxim MAX6620 fan controller"
 	depends on I2C
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 88712b5031c8..720eb7d5fe46 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -142,6 +142,7 @@ obj-$(CONFIG_SENSORS_MAX197)	+= max197.o
 obj-$(CONFIG_SENSORS_MAX31722)	+= max31722.o
 obj-$(CONFIG_SENSORS_MAX31730)	+= max31730.o
 obj-$(CONFIG_SENSORS_MAX31760)  += max31760.o
+obj-$(CONFIG_SENSORS_MAX597X)	+= max597x.o
 obj-$(CONFIG_SENSORS_MAX6620)	+= max6620.o
 obj-$(CONFIG_SENSORS_MAX6621)	+= max6621.o
 obj-$(CONFIG_SENSORS_MAX6639)	+= max6639.o
diff --git a/drivers/hwmon/max597x.c b/drivers/hwmon/max597x.c
new file mode 100644
index 000000000000..d4d8c2faf55c
--- /dev/null
+++ b/drivers/hwmon/max597x.c
@@ -0,0 +1,212 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device driver for regulators in MAX5970 and MAX5978 IC
+ *
+ * Copyright (c) 2022 9elements GmbH
+ *
+ * Author: Patrick Rudolph <patrick.rudolph@9elements.com>
+ */
+
+#include <linux/hwmon.h>
+#include <linux/i2c.h>
+#include <linux/mfd/max597x.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+struct max597x_hwmon {
+	int num_switches, irng[MAX5970_NUM_SWITCHES], mon_rng[MAX5970_NUM_SWITCHES];
+	struct regmap *regmap;
+};
+
+static int max597x_read_reg(struct max597x_hwmon *ddata, int reg, int range, long *val)
+{
+	u8 reg_data[2];
+	int ret;
+
+	ret = regmap_bulk_read(ddata->regmap, reg, &reg_data[0], 2);
+	if (ret < 0)
+		return ret;
+
+	*val = (reg_data[0] << 2) | (reg_data[1] & 3);
+	*val = *val * range;
+	/*
+	 * From datasheet, the range is fractionally less.
+	 * To compensate that, divide with 1033 number.
+	 */
+	*val = *val / 1033;
+
+	return 0;
+}
+
+static int max597x_read(struct device *dev, enum hwmon_sensor_types type,
+			u32 attr, int channel, long *val)
+{
+	struct max597x_hwmon *ddata = dev_get_drvdata(dev);
+	int ret;
+
+	switch (type) {
+	case hwmon_curr:
+		switch (attr) {
+		case hwmon_curr_input:
+			ret = max597x_read_reg(ddata, MAX5970_REG_CURRENT_H(channel),
+					       ddata->irng[channel], val);
+			if (ret < 0)
+				return ret;
+
+			return 0;
+		default:
+			return -EOPNOTSUPP;
+		}
+
+	case hwmon_in:
+		switch (attr) {
+		case hwmon_in_input:
+			ret = max597x_read_reg(ddata, MAX5970_REG_VOLTAGE_H(channel),
+					       ddata->mon_rng[channel], val);
+			if (ret < 0)
+				return ret;
+			return 0;
+		default:
+			return -EOPNOTSUPP;
+		}
+	}
+	return -EOPNOTSUPP;
+}
+
+static umode_t max597x_is_visible(const void *data,
+				  enum hwmon_sensor_types type,
+				  u32 attr, int channel)
+{
+	struct max597x_hwmon *ddata = (struct max597x_hwmon *)data;
+
+	if (channel >= ddata->num_switches)
+		return 0;
+
+	switch (type) {
+	case hwmon_in:
+		switch (attr) {
+		case hwmon_in_input:
+			return 0444;
+		}
+		break;
+	case hwmon_curr:
+		switch (attr) {
+		case hwmon_curr_input:
+			return 0444;
+		}
+		break;
+	default:
+		break;
+	}
+	return 0;
+}
+
+static const struct hwmon_ops max597x_hwmon_ops = {
+	.is_visible = max597x_is_visible,
+	.read = max597x_read,
+};
+
+#define HWMON_CURRENT	HWMON_C_INPUT
+#define HWMON_VOLTAGE	HWMON_I_INPUT
+
+static const struct hwmon_channel_info *max597x_info[] = {
+	HWMON_CHANNEL_INFO(in, HWMON_VOLTAGE, HWMON_VOLTAGE),
+	HWMON_CHANNEL_INFO(curr, HWMON_CURRENT, HWMON_CURRENT),
+	NULL
+};
+
+static const struct hwmon_chip_info max597x_chip_info = {
+	.ops = &max597x_hwmon_ops,
+	.info = max597x_info,
+};
+
+static int max597x_adc_range(struct regmap *regmap, const int ch,
+			     u32 *irng, u32 *mon_rng)
+{
+	unsigned int reg;
+	int ret;
+
+	/* Decode current ADC range */
+	ret = regmap_read(regmap, MAX5970_REG_STATUS2, &reg);
+	if (ret)
+		return ret;
+	switch (MAX5970_IRNG(reg, ch)) {
+	case 0:
+		*irng = 100000;	/* 100 mV */
+		break;
+	case 1:
+		*irng = 50000;	/* 50 mV */
+		break;
+	case 2:
+		*irng = 25000;	/* 25 mV */
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* Decode current voltage monitor range */
+	ret = regmap_read(regmap, MAX5970_REG_MON_RANGE, &reg);
+	if (ret)
+		return ret;
+
+	*mon_rng = MAX5970_MON_MAX_RANGE_UV >> MAX5970_MON(reg, ch);
+	*mon_rng /= 1000; /* uV to mV */
+
+	return 0;
+}
+
+static int max597x_sensor_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct i2c_client *i2c = to_i2c_client(pdev->dev.parent);
+	struct max597x_hwmon *ddata;
+	struct regmap *regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	struct device *hwmon_dev;
+	int err;
+
+	if (!regmap)
+		return -EPROBE_DEFER;
+
+	ddata = devm_kzalloc(dev, sizeof(struct max597x_hwmon), GFP_KERNEL);
+	if (!ddata)
+		return -ENOMEM;
+
+	if (of_device_is_compatible(i2c->dev.of_node, "maxim,max5978"))
+		ddata->num_switches = MAX597x_TYPE_MAX5978;
+	else if (of_device_is_compatible(i2c->dev.of_node, "maxim,max5970"))
+		ddata->num_switches = MAX597x_TYPE_MAX5970;
+	else
+		return -ENODEV;
+
+	ddata->regmap = regmap;
+
+	for (int i = 0; i < ddata->num_switches; i++) {
+		err = max597x_adc_range(regmap, i, &ddata->irng[i], &ddata->mon_rng[i]);
+		if (err < 0)
+			return err;
+	}
+
+	hwmon_dev = devm_hwmon_device_register_with_info(dev,
+							 "max597x_hwmon", ddata,
+							 &max597x_chip_info, NULL);
+
+	if (IS_ERR(hwmon_dev)) {
+		err = PTR_ERR(hwmon_dev);
+		dev_err(dev, "Unable to register hwmon device, returned %d\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
+static struct platform_driver max597x_sensor_driver = {
+	.probe = max597x_sensor_probe,
+	.driver = {
+		.name = "max597x-hwmon",
+	},
+};
+module_platform_driver(max597x_sensor_driver);
+
+MODULE_AUTHOR("Patrick Rudolph <patrick.rudolph@9elements.com>");
+MODULE_DESCRIPTION("MAX5970_hot-swap controller driver");
+MODULE_LICENSE("GPL v2");

base-commit: b4c288cfd2f84c44994330c408e14645d45dee5b
-- 
2.39.1

