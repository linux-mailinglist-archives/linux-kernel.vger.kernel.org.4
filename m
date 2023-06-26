Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D1573DC4D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 12:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjFZKcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 06:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbjFZKcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 06:32:17 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E16AE5F
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 03:32:15 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fb7b2e3dacso408228e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 03:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687775533; x=1690367533;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lNqCqk1p3DEAINdEzhEM0YGD2kICxrffp8EeTtdvows=;
        b=lebYaEpJJsjMdw+fYTpvibU4apgZjTpqT73VB5kWTAlwSkNmL5pQhaK7OoXfjpqKp1
         3TGRxMu8VVwmOErGfpGMLkNJ0uigSLvDt8fiQ34/6BPzo4l8ypBnse43eBnA3L2nQ3IG
         z3af6ILONaZROVtX/EZ3mGOUBtYaJnIsqM2vjPawmAwX+l5fBv1iwqvcRIyx7hbU1lwK
         QYbKnYp3AolNGtmYnLjIUA4PnhZ8pmz4b9cEuM0dIjwgQUqe8PdHmwjT84nhyLC0tZDR
         AkfN1EJkua+HNegYY2IawTaMZoo3i9o6I3IO0zJI2vxjfHjKP9PAvS2skY1g9B7ALktN
         Ayaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687775533; x=1690367533;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lNqCqk1p3DEAINdEzhEM0YGD2kICxrffp8EeTtdvows=;
        b=C1081OpNTPwbMoimVBGzayIHWlxzNTAq9mqBjV5GHt2tfuXaxr7j7CBxelmDt0a06e
         swo/z10sPXNoiAjeScRrOGhBcRLPsVwH58u5AK9X7fViYmXZOE+VrEnw7rLjP7CU/Ib8
         tWri633hC4Gr5WTCIiA/Bhpbs39GWN9rYQSY+9H8uMmirCpH91lIUq198CUE6QohYdO9
         Nf26GslfXMcgIqyWPJa2VSUGLLruOxg+m1PDwAHwJUOt0RrVLCxA93JgaRHnO4Rf163P
         tWyTs9U+Wsul7Vqr+8EpU+h3WckNPoQDoPrbaFPw18bCaATzX/YQcA2bQbejqP/9RRf7
         r0ZQ==
X-Gm-Message-State: AC+VfDxJhBSIbdEJwYydL+rjIb8GQeO+NuiHgNZIUDbixz8xnu9S73EA
        /kFPf32IW9LBRpg1xD3p+HDG2g==
X-Google-Smtp-Source: ACHHUZ5gMc6L10S73k98RJoWSJ8xS8aCYA639/iTopFJJkRLsdbNyN10KONPMofU6K16KISAsYYECw==
X-Received: by 2002:a05:6512:b0e:b0:4f8:75cf:fdd7 with SMTP id w14-20020a0565120b0e00b004f875cffdd7mr12224933lfu.22.1687775532708;
        Mon, 26 Jun 2023 03:32:12 -0700 (PDT)
Received: from [192.168.1.101] (abyk179.neoplus.adsl.tpnet.pl. [83.9.30.179])
        by smtp.gmail.com with ESMTPSA id c26-20020ac2531a000000b004f13ca69dc8sm1041655lfh.72.2023.06.26.03.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 03:32:12 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 26 Jun 2023 12:32:08 +0200
Subject: [PATCH v2 3/3] power: supply: Introduce MM8013 fuel gauge driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230621-topic-mm8013-v2-3-4be6223587ad@linaro.org>
References: <20230621-topic-mm8013-v2-0-4be6223587ad@linaro.org>
In-Reply-To: <20230621-topic-mm8013-v2-0-4be6223587ad@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687775527; l=10078;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=FXajsw1B4OtWBdv0fbmYQgvV8Jhhw7n80XW8hUwq/0k=;
 b=g02M65fU+Ao2eFLMCgUmeZTQv9AlE3wEveJxffqgctITZOoN8/G9arUyZVH4m5cwshe6A6xPM
 gM14x3b9aFDDJle5O//cZexLBAqW6yJr5i9lnKir7T8yPQqapM52ytW
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/power/supply/mm8013.c | 283 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 298 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5ce188b58eaa..ba5f075a2ca8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14296,6 +14296,11 @@ W:	https://linuxtv.org
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
index 000000000000..ce20c6078116
--- /dev/null
+++ b/drivers/power/supply/mm8013.c
@@ -0,0 +1,283 @@
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
+	POWER_SUPPLY_PROP_PRESENT,
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
+	case POWER_SUPPLY_PROP_PRESENT:
+		val->intval = mm8013_read_reg(client, REG_TEMPERATURE) > 0;
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
+		.of_match_table = mm8013_match_table,
+	},
+};
+module_i2c_driver(mm8013_i2c_driver);
+
+MODULE_DESCRIPTION("MM8013 fuel gauge driver");
+MODULE_LICENSE("GPL");

-- 
2.41.0

