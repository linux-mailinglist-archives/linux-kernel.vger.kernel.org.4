Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B745F63E8F1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 05:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiLAErN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 23:47:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiLAErF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 23:47:05 -0500
Received: from gateway30.websitewelcome.com (gateway30.websitewelcome.com [192.185.152.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A449950E
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 20:47:04 -0800 (PST)
Received: from atl1wswcm04.websitewelcome.com (unknown [50.6.129.165])
        by atl3wswob01.websitewelcome.com (Postfix) with ESMTP id E1D50316CF
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 04:47:03 +0000 (UTC)
Received: from md-in-79.webhostbox.net ([43.225.55.182])
        by cmsmtp with ESMTP
        id 0bTRpZnbvgEOM0bTTpbloR; Thu, 01 Dec 2022 04:47:03 +0000
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=linumiz.com
        ; s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=L5X67zfOl/ICI08u5KNdGurEd/63s+v0R1tqBYiDipg=; b=nFIT8PUr43FK7oVtDFNPivIHiL
        0A3CTJ949I+gDnHR8z63y1t6jvKNiVW3ucRv0QrfbX1XGnH2/SxZMjak4VtXGbepM9ccq403SXX4a
        NdN7R9lVTrpcjsf3JmNwHK8jooXllYJ5EKcrEutTXNh4on32lgnJGQGvMHLPJ4iXgixjZhKUZ4cdX
        Jpd7RnQx3Sy0EB5LPZFQjNLOkyGXAvdArR8Z/1g8E3hGGW1UprF8DrmoEg5+yoANKCNOIK8DZnyXC
        XoCR6XFG0AuUHQ6eJA0VFEIlz+tn90lIv/0CuiQVZ3hjwV5RcNi4Fu4VgM6RZB8kbA5ny2dLFJGV4
        sqElmPrw==;
Received: from [223.187.112.123] (port=34121 helo=discovery..)
        by md-in-79.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <saravanan@linumiz.com>)
        id 1p0bTQ-003t5m-27;
        Thu, 01 Dec 2022 04:47:00 +0000
From:   Saravanan Sekar <saravanan@linumiz.com>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, marten.lindahl@axis.com
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Saravanan Sekar <saravanan@linumiz.com>
Subject: [PATCH v2 3/4] hwmon: (pmbus/mpq7932) Add a support for mpq7932 Power Management IC
Date:   Thu,  1 Dec 2022 05:46:42 +0100
Message-Id: <20221201044643.1150870-4-saravanan@linumiz.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221201044643.1150870-1-saravanan@linumiz.com>
References: <20221201044643.1150870-1-saravanan@linumiz.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - md-in-79.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linumiz.com
X-BWhitelist: no
X-Source-IP: 223.187.112.123
X-Source-L: No
X-Exim-ID: 1p0bTQ-003t5m-27
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (discovery..) [223.187.112.123]:34121
X-Source-Auth: saravanan@linumiz.com
X-Email-Count: 30
X-Source-Cap: bGludW1jbWM7aG9zdGdhdG9yO21kLWluLTc5LndlYmhvc3Rib3gubmV0
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfByJjKnE6+oOqUP6+A+RL8WjgAGDPLhIgeOGAcoTHxBEnn1kLZWxZcNz0G7h3nWhnXmqTLDEvwbIF/9zQx0axn+20FZv0oXATkevdIUeYPC16A7pa/X+
 Er23T1XEvMlo8PIo22t+QgyzpH9DSy4Xf8SIFJPk6I/nBPgb05i3siwRgEdIMI0KS5nG+REKAOUM4Kw8ogtcw3BaNifRF/r009Y=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MPQ7932 is a power management IC designed to operate from 5V buses to
power a variety of Advanced driver-assistance system SOCs. Six integrated
buck converters with hardware monitoring capability powers a variety of
target rails configurable over PMBus interface.

Signed-off-by: Saravanan Sekar <saravanan@linumiz.com>
---
 drivers/hwmon/pmbus/Kconfig   |  10 +++
 drivers/hwmon/pmbus/Makefile  |   1 +
 drivers/hwmon/pmbus/mpq7932.c | 144 ++++++++++++++++++++++++++++++++++
 3 files changed, 155 insertions(+)
 create mode 100644 drivers/hwmon/pmbus/mpq7932.c

diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index 89668af67206..4a1538949a73 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -317,6 +317,16 @@ config SENSORS_MP5023
 	  This driver can also be built as a module. If so, the module will
 	  be called mp5023.
 
+config SENSORS_MPQ7932
+	tristate "MPS MPQ7932"
+	help
+	  If you say yes here you get six integrated buck converter regulator
+	  with hardware monitoring functionality support for power management
+	  IC MPS MPQ7932.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called mpq7932.
+
 config SENSORS_PIM4328
 	tristate "Flex PIM4328 and compatibles"
 	help
diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
index 0002dbe22d52..28a534629cc3 100644
--- a/drivers/hwmon/pmbus/Makefile
+++ b/drivers/hwmon/pmbus/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_SENSORS_MAX8688)	+= max8688.o
 obj-$(CONFIG_SENSORS_MP2888)	+= mp2888.o
 obj-$(CONFIG_SENSORS_MP2975)	+= mp2975.o
 obj-$(CONFIG_SENSORS_MP5023)	+= mp5023.o
+obj-$(CONFIG_SENSORS_MPQ7932_REGULATOR) += mpq7932.o
 obj-$(CONFIG_SENSORS_PLI1209BC)	+= pli1209bc.o
 obj-$(CONFIG_SENSORS_PM6764TR)	+= pm6764tr.o
 obj-$(CONFIG_SENSORS_PXE1610)	+= pxe1610.o
diff --git a/drivers/hwmon/pmbus/mpq7932.c b/drivers/hwmon/pmbus/mpq7932.c
new file mode 100644
index 000000000000..3747d7862afd
--- /dev/null
+++ b/drivers/hwmon/pmbus/mpq7932.c
@@ -0,0 +1,144 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0+
+ *
+ * mpq7932.c  - regulator driver for mps mpq7932
+ * Copyright 2022 Monolithic Power Systems, Inc
+ *
+ * Author: Saravanan Sekar <saravanan@linumiz.com>
+ */
+
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/pmbus.h>
+#include "pmbus.h"
+
+#define MPQ7932_BUCK_UV_MIN		206250
+#define MPQ7932_UV_STEP			6250
+#define MPQ7932_N_VOLTAGES		0xFF
+#define MPQ7932_NUM_PAGES		6
+
+#define MPQ7932_TON_DELAY		0x60
+#define MPQ7932_VOUT_STARTUP_SLEW	0xA3
+#define MPQ7932_VOUT_SHUTDOWN_SLEW	0xA5
+#define MPQ7932_VOUT_SLEW_MASK		GENMASK(1, 0)
+#define MPQ7932_TON_DELAY_MASK		GENMASK(4, 0)
+
+struct mpq7932_data {
+	struct pmbus_driver_info info;
+	struct pmbus_platform_data pdata;
+};
+
+static struct regulator_desc mpq7932_regulators_desc[] = {
+	PMBUS_REGULATOR_STEP("buck", 0, MPQ7932_N_VOLTAGES,
+				MPQ7932_UV_STEP, MPQ7932_BUCK_UV_MIN),
+	PMBUS_REGULATOR_STEP("buck", 1, MPQ7932_N_VOLTAGES,
+				MPQ7932_UV_STEP, MPQ7932_BUCK_UV_MIN),
+	PMBUS_REGULATOR_STEP("buck", 2, MPQ7932_N_VOLTAGES,
+				MPQ7932_UV_STEP, MPQ7932_BUCK_UV_MIN),
+	PMBUS_REGULATOR_STEP("buck", 3, MPQ7932_N_VOLTAGES,
+				MPQ7932_UV_STEP, MPQ7932_BUCK_UV_MIN),
+	PMBUS_REGULATOR_STEP("buck", 4, MPQ7932_N_VOLTAGES,
+				MPQ7932_UV_STEP, MPQ7932_BUCK_UV_MIN),
+	PMBUS_REGULATOR_STEP("buck", 5, MPQ7932_N_VOLTAGES,
+				MPQ7932_UV_STEP, MPQ7932_BUCK_UV_MIN),
+};
+
+static int mpq7932_write_word_data(struct i2c_client *client, int page, int reg,
+			       u16 word)
+{
+
+	switch (reg) {
+	case PMBUS_VOUT_COMMAND:
+		return pmbus_write_byte_data(client, page, reg, (u8)word);
+
+	default:
+		return -ENODATA;
+	}
+}
+
+static int mpq7932_read_word_data(struct i2c_client *client, int page,
+				  int phase, int reg)
+{
+
+	switch (reg) {
+	case PMBUS_MFR_VOUT_MIN:
+		return 0;
+
+	case PMBUS_MFR_VOUT_MAX:
+		return MPQ7932_N_VOLTAGES;
+
+	case PMBUS_READ_VOUT:
+		return pmbus_read_byte_data(client, page, PMBUS_VOUT_COMMAND);
+
+	default:
+		return -ENODATA;
+	}
+}
+
+static int mpq7932_probe(struct i2c_client *client)
+{
+	struct mpq7932_data *data;
+	struct pmbus_driver_info *info;
+	struct device *dev = &client->dev;
+	int i;
+
+	if (!i2c_check_functionality(client->adapter,
+				     I2C_FUNC_SMBUS_READ_WORD_DATA))
+		return -ENODEV;
+
+	data = devm_kzalloc(&client->dev, sizeof(struct mpq7932_data),
+			    GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	info = &data->info;
+	info->pages = MPQ7932_NUM_PAGES;
+	info->num_regulators = ARRAY_SIZE(mpq7932_regulators_desc);
+	info->reg_desc = mpq7932_regulators_desc;
+	info->format[PSC_VOLTAGE_OUT] = direct;
+	info->m[PSC_VOLTAGE_OUT] = 160;
+	info->b[PSC_VOLTAGE_OUT] = -33;
+	for (i = 0; i < info->pages; i++) {
+		info->func[i] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT
+				| PMBUS_HAVE_STATUS_TEMP;
+	}
+
+	info->read_word_data = mpq7932_read_word_data;
+	info->write_word_data = mpq7932_write_word_data;
+
+	data->pdata.flags = PMBUS_NO_CAPABILITY;
+	dev->platform_data = &data->pdata;
+
+	return pmbus_do_probe(client, info);
+}
+
+static const struct of_device_id mpq7932_of_match[] = {
+	{ .compatible = "mps,mpq7932"},
+	{},
+};
+MODULE_DEVICE_TABLE(of, mpq7932_of_match);
+
+static const struct i2c_device_id mpq7932_id[] = {
+	{ "mpq7932", },
+	{ },
+};
+MODULE_DEVICE_TABLE(i2c, mpq7932_id);
+
+static struct i2c_driver mpq7932_regulator_driver = {
+	.driver = {
+		.name = "mpq7932",
+		.of_match_table = mpq7932_of_match,
+	},
+	.probe_new = mpq7932_probe,
+	.id_table = mpq7932_id,
+};
+module_i2c_driver(mpq7932_regulator_driver);
+
+MODULE_AUTHOR("Saravanan Sekar <saravanan@linumiz.com>");
+MODULE_DESCRIPTION("MPQ7932 PMIC regulator driver");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(PMBUS);
-- 
2.34.1

