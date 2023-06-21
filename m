Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A817389E3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233697AbjFUPkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 11:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233668AbjFUPkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:40:31 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3DE2114
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 08:40:06 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f7677a94d1so8372054e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 08:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687361958; x=1689953958;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fb9J9GvWBYe5VRYUcNYFbGxYkIOx3Dvj9V9F/TGODfo=;
        b=n4SOthY/ihHplEiJUth7V8qjZkEA1aQD7zGgq4QikrGv45pqBzufOiXNIRtvjnVU0n
         Jwku86pkC/4f/m7LXto4uquICt0d87Q9ILogfO54iR6AA5H2bhS7rRMZrjltzVxCIU0s
         bZmu3HslsV3EUpqYvmm2ZcWQjxn1B9jjQEUOqIXrnbZIEaUef6YZXe0Kgw4IBY66nCHF
         92qjIHuUcNSGwfMR54bhm9iXdNiTX2SyyvG3U+qnrzGuOW1/7eXvGX1qX9ARyaV1MMu1
         CL/Whwg4uq8IFfLVIAd0N1Ow9Q/2qdKZub3gU2j+VROcQ9/uPglU5Yhq5A0VMzGd4M6Z
         vK5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687361958; x=1689953958;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fb9J9GvWBYe5VRYUcNYFbGxYkIOx3Dvj9V9F/TGODfo=;
        b=PZIQaP2aKi1v4n5NRsKpQ0v0pCFFOVKLz+EgMTaRTKO7PPUqO0/oD2T5T1ZaI/zsPJ
         iC5jN+ufB4pMzFbs7l0al56XT7qP5Go6LxrejAm1o0+a+/5rTzhPTKWDHRLWYBHrtdHn
         D4Ddh5sUM+eBtv9tEpBowx3u5VDDWcl0VnZ6QQ9glQWWL9EXWU9o7gVa3/Kwnt7XWBxh
         4LwkvOCB31LOZNZ52+n6ZS+DjdY9XdtRECCItSnagr3uY4xixbAVSWeLU+2Cx3OUaW33
         6bbEP55vtwrX96Sa9BnMBQVb5lW3W+odZ2IREJohD3P3whRDDWpIL4CS9axvS7XsOqm0
         h40w==
X-Gm-Message-State: AC+VfDzh0hlRgXeMMtt3MBOqLUiHnwKfFNcDAaTZ8IMo3SQv/fUdg+nS
        TypVWpt0VF/6jJvjxIXaLmfLGQ==
X-Google-Smtp-Source: ACHHUZ6ubVZcqD9XQFE2e4TLaXaz5czx4mbFJ7Vbyb+2EFonXk0p05QpPpFwIZY9bCCRcialGfiwxQ==
X-Received: by 2002:a19:7914:0:b0:4e8:c5d:42a5 with SMTP id u20-20020a197914000000b004e80c5d42a5mr9671940lfc.24.1687361958073;
        Wed, 21 Jun 2023 08:39:18 -0700 (PDT)
Received: from [192.168.1.101] (abxj193.neoplus.adsl.tpnet.pl. [83.9.3.193])
        by smtp.gmail.com with ESMTPSA id l15-20020a19c20f000000b004f73eac0308sm821078lfc.183.2023.06.21.08.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 08:39:17 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 21 Jun 2023 17:39:12 +0200
Subject: [PATCH 3/3] power: supply: Introduce MM8013 fuel gauge driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230621-topic-mm8013-v1-3-4407c6260053@linaro.org>
References: <20230621-topic-mm8013-v1-0-4407c6260053@linaro.org>
In-Reply-To: <20230621-topic-mm8013-v1-0-4407c6260053@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687361953; l=9964;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=ZEuJ8+X/qdfI2sOGh4SbbX/ldR75MGx5vuNAtp88VUg=;
 b=NpktR2cC8ZCUBVmPP0K5jmkVUApup/30ys4XfcV1lwiuqekJeZWNnDNsuESfIpKNZnIhEC2r3
 J+YvQS3GtvaASvoZmwyMnkhDCsP5bfpPawL2EPIADsNfg4qCIvQk5JZ
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a driver for the Mitsumi MM8013 fuel gauge. The driver is a vastly
cleaned up and improved version of the one that shipped in some obscure
Lenovo downstream kernel [1], with some register definitions borrowed from
ChromeOS EC platform code [2].

[1] https://github.com/adazem009/kernel_lenovo_bengal/commit/b6b346427a871715709bd22aae449b9383f3b66b
[2] https://chromium.googlesource.com/chromiumos/platform/ec/+/master/driver/battery/mm8013.h
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 MAINTAINERS                   |   5 +
 drivers/power/supply/Kconfig  |   9 ++
 drivers/power/supply/Makefile |   1 +
 drivers/power/supply/mm8013.c | 280 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 295 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 210285042dcd..17aff9762091 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14300,6 +14300,11 @@ W:	https://linuxtv.org
 T:	git git://linuxtv.org/media_tree.git
 F:	drivers/media/radio/radio-miropcm20*
 
+MITSUMI MM8013 FG DRIVER
+M:	Konrad Dybcio <konradybcio@kernel.org>
+F:	Documentation/devicetree/bindings/power/supply/mitsumi,mm8013.yaml
+F:	drivers/power/supply/mm8013.c
+
 MMP SUPPORT
 R:	Lubomir Rintel <lkundrak@v3.sk>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 663a1c423806..c19e8287d80f 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -951,4 +951,13 @@ config CHARGER_QCOM_SMB2
 	  adds support for the SMB2 switch mode battery charger found
 	  in PMI8998 and related PMICs.
 
+config FUEL_GAUGE_MM8013
+	tristate "Mitsumi MM8013 fuel gauge driver"
+	depends on I2C
+	help
+	  Say Y here to enable the Mitsumi MM8013 fuel gauge driver.
+	  It enables the monitoring of many battery parameters, including
+	  the state of charge, temperature, cycle count, actual and design
+	  capacity, etc.
+
 endif # POWER_SUPPLY
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index a8a9fa6de1e9..ba2c41f060be 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -111,3 +111,4 @@ obj-$(CONFIG_BATTERY_SURFACE)	+= surface_battery.o
 obj-$(CONFIG_CHARGER_SURFACE)	+= surface_charger.o
 obj-$(CONFIG_BATTERY_UG3105)	+= ug3105_battery.o
 obj-$(CONFIG_CHARGER_QCOM_SMB2)	+= qcom_pmi8998_charger.o
+obj-$(CONFIG_FUEL_GAUGE_MM8013)	+= mm8013.o
diff --git a/drivers/power/supply/mm8013.c b/drivers/power/supply/mm8013.c
new file mode 100644
index 000000000000..1aea06456d03
--- /dev/null
+++ b/drivers/power/supply/mm8013.c
@@ -0,0 +1,280 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2016-2019 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023, Linaro Limited
+ */
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/power_supply.h>
+
+#define REG_BATID			0x00 /* This one is very unclear */
+ #define BATID_101			0x0101 /* 107kOhm */
+ #define BATID_102			0x0102 /* 10kOhm */
+#define REG_TEMPERATURE			0x06
+#define REG_VOLTAGE			0x08
+#define REG_FLAGS			0x0a
+ #define MM8013_FLAG_OTC		BIT(15)
+ #define MM8013_FLAG_OTD		BIT(14)
+ #define MM8013_FLAG_BATHI		BIT(13)
+ #define MM8013_FLAG_FC			BIT(9)
+ #define MM8013_FLAG_CHG		BIT(8)
+ #define MM8013_FLAG_DSG		BIT(0)
+#define REG_FULL_CHARGE_CAPACITY	0x0e
+#define REG_AVERAGE_CURRENT		0x14
+#define REG_AVERAGE_TIME_TO_EMPTY	0x16
+#define REG_AVERAGE_TIME_TO_FULL	0x18
+#define REG_CYCLE_COUNT			0x2a
+#define REG_STATE_OF_CHARGE		0x2c
+#define REG_DESIGN_CAPACITY		0x3c
+/* TODO: 0x62-0x68 seem to contain 'MM8013C' in a length-prefixed, non-terminated string */
+
+#define DECIKELVIN_TO_DECIDEGC(t)	(t - 2731)
+
+struct mm8013_chip {
+	struct i2c_client *client;
+};
+
+static int mm8013_write_reg(struct i2c_client *client, u8 reg, u16 value)
+{
+	int ret;
+
+	ret = i2c_smbus_write_word_data(client, reg, value);
+	if (ret < 0)
+		dev_err(&client->dev, "%s: err %d\n", __func__, ret);
+
+	usleep_range(4000, 5000);
+	return ret;
+}
+
+static int mm8013_read_reg(struct i2c_client *client, u8 reg)
+{
+	int ret;
+
+	ret = i2c_smbus_read_word_data(client, reg);
+	if (ret < 0)
+		dev_err(&client->dev, "%s: err %d\n", __func__, ret);
+
+	usleep_range(4000, 5000);
+	return ret;
+}
+
+static int mm8013_checkdevice(struct mm8013_chip *chip)
+{
+	int battery_id, ret;
+
+	ret = mm8013_write_reg(chip->client, REG_BATID, 0x0008);
+	if (ret < 0)
+		return ret;
+
+	ret = mm8013_read_reg(chip->client, REG_BATID);
+	if (ret < 0)
+		return ret;
+
+	if (ret == BATID_102)
+		battery_id = 2;
+	else if (ret == BATID_101)
+		battery_id = 1;
+	else
+		return -EINVAL;
+
+	dev_dbg(&chip->client->dev, "battery_id: %d\n", battery_id);
+
+	return 0;
+}
+
+static enum power_supply_property mm8013_battery_props[] = {
+	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_CHARGE_FULL,
+	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_CYCLE_COUNT,
+	POWER_SUPPLY_PROP_HEALTH,
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_TEMP,
+	POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG,
+	POWER_SUPPLY_PROP_TIME_TO_FULL_AVG,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+};
+
+static int mm8013_get_property(struct power_supply *psy,
+			       enum power_supply_property psp,
+			       union power_supply_propval *val)
+{
+	struct mm8013_chip *chip = psy->drv_data;
+	struct i2c_client *client = chip->client;
+	int ret = 0;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CAPACITY:
+		ret = mm8013_read_reg(client, REG_STATE_OF_CHARGE);
+		if (ret < 0)
+			return ret;
+
+		val->intval = ret;
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_FULL:
+		ret = mm8013_read_reg(client, REG_FULL_CHARGE_CAPACITY);
+		if (ret < 0)
+			return ret;
+
+		val->intval = ret;
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
+		ret = mm8013_read_reg(client, REG_DESIGN_CAPACITY);
+		if (ret < 0)
+			return ret;
+
+		val->intval = ret;
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		ret = mm8013_read_reg(client, REG_AVERAGE_CURRENT);
+		if (ret < 0)
+			return ret;
+
+		if (ret > S16_MAX)
+			val->intval -= (1 << 16);
+		else
+			val->intval = ret;
+
+		val->intval *= -1000;
+		break;
+	case POWER_SUPPLY_PROP_CYCLE_COUNT:
+		ret = mm8013_read_reg(client, REG_CYCLE_COUNT);
+		if (ret < 0)
+			return ret;
+
+		val->intval = ret;
+		break;
+	case POWER_SUPPLY_PROP_HEALTH:
+		ret = mm8013_read_reg(client, REG_FLAGS);
+		if (ret < 0)
+			return ret;
+
+		if (ret & MM8013_FLAG_BATHI)
+			val->intval = POWER_SUPPLY_HEALTH_OVERVOLTAGE;
+		else if (ret & (MM8013_FLAG_OTD | MM8013_FLAG_OTC))
+			val->intval = POWER_SUPPLY_HEALTH_OVERHEAT;
+		else
+			val->intval = POWER_SUPPLY_HEALTH_GOOD;
+		break;
+	case POWER_SUPPLY_PROP_STATUS:
+		ret = mm8013_read_reg(client, REG_FLAGS);
+		if (ret < 0)
+			return ret;
+
+		if (ret & MM8013_FLAG_DSG)
+			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
+		else if (ret & MM8013_FLAG_CHG)
+			val->intval = POWER_SUPPLY_STATUS_CHARGING;
+		else if (ret & MM8013_FLAG_FC)
+			val->intval = POWER_SUPPLY_STATUS_FULL;
+		else
+			val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
+		break;
+	case POWER_SUPPLY_PROP_TEMP:
+		ret = mm8013_read_reg(client, REG_TEMPERATURE);
+		if (ret < 0)
+			return ret;
+
+		val->intval = DECIKELVIN_TO_DECIDEGC(ret);
+		break;
+	case POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG:
+		ret = mm8013_read_reg(client, REG_AVERAGE_TIME_TO_EMPTY);
+		if (ret < 0)
+			return ret;
+
+		/* The estimation is not yet ready */
+		if (ret == U16_MAX)
+			return -ENODATA;
+
+		val->intval = ret;
+		break;
+	case POWER_SUPPLY_PROP_TIME_TO_FULL_AVG:
+		ret = mm8013_read_reg(client, REG_AVERAGE_TIME_TO_FULL);
+		if (ret < 0)
+			return ret;
+
+		/* The estimation is not yet ready */
+		if (ret == U16_MAX)
+			return -ENODATA;
+
+		val->intval = ret;
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		ret = mm8013_read_reg(client, REG_VOLTAGE);
+		if (ret < 0)
+			return ret;
+
+		val->intval = ret;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct power_supply_desc mm8013_desc = {
+	.name			= "mm8013",
+	.type			= POWER_SUPPLY_TYPE_BATTERY,
+	.properties		= mm8013_battery_props,
+	.num_properties		= ARRAY_SIZE(mm8013_battery_props),
+	.get_property		= mm8013_get_property,
+};
+
+static int mm8013_probe(struct i2c_client *client)
+{
+	struct power_supply_config psy_cfg = {};
+	struct device *dev = &client->dev;
+	struct power_supply *psy;
+	struct mm8013_chip *chip;
+	int ret = 0;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA))
+		return dev_err_probe(dev, -EIO,
+				     "I2C_FUNC_SMBUS_WORD_DATA not supported\n");
+
+	chip = devm_kzalloc(dev, sizeof(struct mm8013_chip), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
+	chip->client = client;
+
+	ret = mm8013_checkdevice(chip);
+	if (ret)
+		return dev_err_probe(dev, -ENODEV, "MM8013 not found\n");
+
+	psy_cfg.drv_data = chip;
+	psy_cfg.of_node = dev->of_node;
+
+	psy = devm_power_supply_register(dev, &mm8013_desc, &psy_cfg);
+	if (IS_ERR(psy))
+		return PTR_ERR(psy);
+
+	return 0;
+}
+
+static const struct i2c_device_id mm8013_id_table[] = {
+	{ "mm8013", 0 },
+	{},
+};
+MODULE_DEVICE_TABLE(i2c, mm8013_id_table);
+
+static const struct of_device_id mm8013_match_table[] = {
+	{ .compatible = "mitsumi,mm8013" },
+	{ },
+};
+
+static struct i2c_driver mm8013_i2c_driver = {
+	.probe = mm8013_probe,
+	.id_table = mm8013_id_table,
+	.driver = {
+		.name = "mm8013",
+		.owner = THIS_MODULE,
+		.of_match_table = mm8013_match_table,
+	},
+};
+module_i2c_driver(mm8013_i2c_driver);
+
+MODULE_DESCRIPTION("MM8013 fuel gauge driver");
+MODULE_LICENSE("GPL");

-- 
2.41.0

