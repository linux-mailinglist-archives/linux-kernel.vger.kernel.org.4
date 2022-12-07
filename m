Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6711E646062
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 18:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiLGRhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 12:37:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiLGRhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 12:37:45 -0500
Received: from gateway30.websitewelcome.com (gateway30.websitewelcome.com [192.185.152.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1FDB24094
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 09:37:39 -0800 (PST)
Received: from atl1wswcm01.websitewelcome.com (unknown [50.6.129.162])
        by atl3wswob01.websitewelcome.com (Postfix) with ESMTP id 2EC4A1B8A9
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 17:37:39 +0000 (UTC)
Received: from md-in-79.webhostbox.net ([43.225.55.182])
        by cmsmtp with ESMTP
        id 2yMSpBIseDsCK2yMUpG6HH; Wed, 07 Dec 2022 17:37:39 +0000
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=linumiz.com
        ; s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=wVWfEFOzMBLqUL1rWpwXsPoqdXN3/xrh+/ZFlA2PqQY=; b=jQWoOEFTbqzGXAMBYgoDkezzCN
        NnyMmO76yahFPgu4Bndu14s3LzXcFzrLR9czGAqwheo0AIySfMHP85ExTuGSk3DEZCNqRePP+q+N5
        g9riiRllElpCFYhsKhi1eMBHGoHRKLaOxeOmCbnUkZ2pHeOTb3+Xo1TSFARDtAFQOJ1XPdsC/mFIp
        JworZ6d2CzzzMHiQYQA00EBN5OiKiOUApvMMQ47YRV6aShl1udkZ1F43EYIqYUT6PDcJZ9ZdjlAl1
        SBnTjHSzQSgmoNCJeBTqxI9t910pzpjfa8PlpdUXYKdYn9ZvExxweUhc3YdDDP3IC+kC3p+H1m/Ul
        Ig6aTTuQ==;
Received: from [106.222.117.249] (port=8172 helo=discovery..)
        by md-in-79.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <saravanan@linumiz.com>)
        id 1p2yMR-0025qb-98;
        Wed, 07 Dec 2022 17:37:35 +0000
From:   Saravanan Sekar <saravanan@linumiz.com>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, marten.lindahl@axis.com
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Saravanan Sekar <saravanan@linumiz.com>
Subject: [PATCH v3 3/4] hwmon: (pmbus/mpq7932) Add a support for mpq7932 Power Management IC
Date:   Wed,  7 Dec 2022 18:37:15 +0100
Message-Id: <20221207173716.123223-4-saravanan@linumiz.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221207173716.123223-1-saravanan@linumiz.com>
References: <20221207173716.123223-1-saravanan@linumiz.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - md-in-79.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linumiz.com
X-BWhitelist: no
X-Source-IP: 106.222.117.249
X-Source-L: No
X-Exim-ID: 1p2yMR-0025qb-98
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (discovery..) [106.222.117.249]:8172
X-Source-Auth: saravanan@linumiz.com
X-Email-Count: 25
X-Source-Cap: bGludW1jbWM7aG9zdGdhdG9yO21kLWluLTc5LndlYmhvc3Rib3gubmV0
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfJUxUcNCd68Od9WoFuZxP0QTplCbMgVSew/Kpf5jiESwWdfSDq9jnVT0cxXPy3MpwiIznXYkkeWm3nlsFUFMmkulIeeBNUVr1+zdtDp5NLOROaU3hpVE
 mX/yCGJyrERMbGCtEYcZIp/aOQqcuowCrk3w+/8ctJ/UEZUU2GrMmpGLDgSR2hdgXDDzG83qzBKwTJeFCFcodxIK9Shwu/eLdMA=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
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
 drivers/hwmon/pmbus/Kconfig   |  16 ++++
 drivers/hwmon/pmbus/Makefile  |   1 +
 drivers/hwmon/pmbus/mpq7932.c | 153 ++++++++++++++++++++++++++++++++++
 3 files changed, 170 insertions(+)
 create mode 100644 drivers/hwmon/pmbus/mpq7932.c

diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index 89668af67206..30448e049486 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -317,6 +317,22 @@ config SENSORS_MP5023
 	  This driver can also be built as a module. If so, the module will
 	  be called mp5023.
 
+config SENSORS_MPQ7932_REGULATOR
+	bool "Regulator support for MPQ7932"
+	depends on SENSORS_MPQ7932 && REGULATOR
+	help
+	  If you say yes here you get six integrated buck converter regulator
+	  support for power management IC MPS MPQ7932.
+
+config SENSORS_MPQ7932
+	tristate "MPS MPQ7932"
+	help
+	  If you say yes here you get hardware monitoring functionality support
+	  for power management IC MPS MPQ7932.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called mpq7932.
+
 config SENSORS_PIM4328
 	tristate "Flex PIM4328 and compatibles"
 	help
diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
index 0002dbe22d52..d9d2fa4bd6f7 100644
--- a/drivers/hwmon/pmbus/Makefile
+++ b/drivers/hwmon/pmbus/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_SENSORS_MAX8688)	+= max8688.o
 obj-$(CONFIG_SENSORS_MP2888)	+= mp2888.o
 obj-$(CONFIG_SENSORS_MP2975)	+= mp2975.o
 obj-$(CONFIG_SENSORS_MP5023)	+= mp5023.o
+obj-$(CONFIG_SENSORS_MPQ7932)	+= mpq7932.o
 obj-$(CONFIG_SENSORS_PLI1209BC)	+= pli1209bc.o
 obj-$(CONFIG_SENSORS_PM6764TR)	+= pm6764tr.o
 obj-$(CONFIG_SENSORS_PXE1610)	+= pxe1610.o
diff --git a/drivers/hwmon/pmbus/mpq7932.c b/drivers/hwmon/pmbus/mpq7932.c
new file mode 100644
index 000000000000..1dc1ab71957b
--- /dev/null
+++ b/drivers/hwmon/pmbus/mpq7932.c
@@ -0,0 +1,153 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * mpq7932.c - hwmon with optional regulator driver for mps mpq7932
+ * Copyright 2022 Monolithic Power Systems, Inc
+ *
+ * Author: Saravanan Sekar <saravanan@linumiz.com>
+ */
+
+#include <linux/bits.h>
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
+#define MPQ7932_N_VOLTAGES		256
+#define MPQ7932_VOUT_MAX		0xFF
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
+#if IS_ENABLED(CONFIG_SENSORS_MPQ7932_REGULATOR)
+static struct regulator_desc mpq7932_regulators_desc[] = {
+	PMBUS_REGULATOR_STEP("buck", 0, MPQ7932_N_VOLTAGES,
+			     MPQ7932_UV_STEP, MPQ7932_BUCK_UV_MIN),
+	PMBUS_REGULATOR_STEP("buck", 1, MPQ7932_N_VOLTAGES,
+			     MPQ7932_UV_STEP, MPQ7932_BUCK_UV_MIN),
+	PMBUS_REGULATOR_STEP("buck", 2, MPQ7932_N_VOLTAGES,
+			     MPQ7932_UV_STEP, MPQ7932_BUCK_UV_MIN),
+	PMBUS_REGULATOR_STEP("buck", 3, MPQ7932_N_VOLTAGES,
+			     MPQ7932_UV_STEP, MPQ7932_BUCK_UV_MIN),
+	PMBUS_REGULATOR_STEP("buck", 4, MPQ7932_N_VOLTAGES,
+			     MPQ7932_UV_STEP, MPQ7932_BUCK_UV_MIN),
+	PMBUS_REGULATOR_STEP("buck", 5, MPQ7932_N_VOLTAGES,
+			     MPQ7932_UV_STEP, MPQ7932_BUCK_UV_MIN),
+};
+#endif
+
+static int mpq7932_write_word_data(struct i2c_client *client, int page, int reg,
+				   u16 word)
+{
+	switch (reg) {
+	/* chip support only byte access for VOUT_COMMAND otherwise
+	 * results -EREMOTEIO
+	 */
+	case PMBUS_VOUT_COMMAND:
+		return pmbus_write_byte_data(client, page, reg, word & 0xFF);
+
+	default:
+		return -ENODATA;
+	}
+}
+
+static int mpq7932_read_word_data(struct i2c_client *client, int page,
+				  int phase, int reg)
+{
+	switch (reg) {
+	/* chip support neither (PMBUS_VOUT_MARGIN_HIGH, PMBUS_VOUT_MARGIN_LOW)
+	 * nor (PMBUS_MFR_VOUT_MIN, PMBUS_MFR_VOUT_MAX). As a result set voltage
+	 * fails due to error in pmbus_regulator_get_low_margin, so faked.
+	 */
+	case PMBUS_MFR_VOUT_MIN:
+		return 0;
+
+	case PMBUS_MFR_VOUT_MAX:
+		return MPQ7932_VOUT_MAX;
+
+	/* chip support only byte access for VOUT_COMMAND otherwise
+	 * results -EREMOTEIO
+	 */
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
+	data = devm_kzalloc(dev, sizeof(struct mpq7932_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	info = &data->info;
+	info->pages = MPQ7932_NUM_PAGES;
+	info->format[PSC_VOLTAGE_OUT] = direct;
+	info->m[PSC_VOLTAGE_OUT] = 160;
+	info->b[PSC_VOLTAGE_OUT] = -33;
+	for (i = 0; i < info->pages; i++) {
+		info->func[i] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT
+				| PMBUS_HAVE_STATUS_TEMP;
+	}
+
+#if IS_ENABLED(CONFIG_SENSORS_MPQ7932_REGULATOR)
+	info->num_regulators = ARRAY_SIZE(mpq7932_regulators_desc);
+	info->reg_desc = mpq7932_regulators_desc;
+#endif
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

