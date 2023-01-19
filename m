Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 881B0674586
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 23:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbjASWL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 17:11:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjASWKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 17:10:51 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD73DA8E6;
        Thu, 19 Jan 2023 13:48:05 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30JKhe0C028026;
        Thu, 19 Jan 2023 21:47:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=pMM55Ju181dle18LqM06bzYA1IAzgBsYxm2Y3C5SHAc=;
 b=k6JtfgUDef8Smp4ok0b0tIAGSHLQqeveVg8znnorMvyWuPTQHWqDD50oi9DZdSzbjAc/
 G1JeZSIZJwVbexbRCRVKChiPZDgjjYihNlBALz+PmHVnZlvoEKov0c8mR6lXzn95TQNW
 7+ERdywroztL65DJwA7SE27ZGYtUlCM9vPyb7oM7d1GFC5s8spvjQqnX+tsucIWsZpqB
 wvibe3BLRDUyfJYqBZjCNkM4t14NWmv43QDKgi12uIEOq1yIpl2dmkzqOJONT7hRQqte
 urbn1FF8LoPddzJvQJwQ3QsZcfwPTWtVVaCdwM7l4EEujw6LuA+/Ssobo0mlDbe1yIHk HA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n6ya2tcfx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 21:47:56 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30JLltlu012606
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 21:47:55 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 19 Jan 2023 13:47:55 -0800
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
Subject: [PATCH 2/4] regulator: Introduce Maxim MAX20411 Step-Down converter
Date:   Thu, 19 Jan 2023 13:47:47 -0800
Message-ID: <20230119214749.4048933-3-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230119214749.4048933-1-quic_bjorande@quicinc.com>
References: <20230119214749.4048933-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4yAtqMay91m6nqCd3DXsYqkubUMOrf0v
X-Proofpoint-GUID: 4yAtqMay91m6nqCd3DXsYqkubUMOrf0v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-19_14,2023-01-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 mlxscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 impostorscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301190183
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

Introduce a driver to control the Maxim MAX20411 family of
high-efficiency, syncrhonous step-down converters.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 drivers/regulator/Kconfig              |   8 ++
 drivers/regulator/Makefile             |   1 +
 drivers/regulator/max20411-regulator.c | 163 +++++++++++++++++++++++++
 3 files changed, 172 insertions(+)
 create mode 100644 drivers/regulator/max20411-regulator.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 820c9a0788e5..aae28d0a489c 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -655,6 +655,14 @@ config REGULATOR_MAX20086
 	  protectorvia I2C bus. The regulator has 2 or 4 outputs depending on
 	  the device model. This driver is only capable to turn on/off them.
 
+config REGULATOR_MAX20411
+	tristate "Maxim MAX20411 High-Efficiency Single Step-Down Converter"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  This driver controls the Maxim MAX20411 family of high-efficiency,
+	  syncrhonous step-down converters.
+
 config REGULATOR_MAX77686
 	tristate "Maxim 77686 regulator"
 	depends on MFD_MAX77686 || COMPILE_TEST
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index b9f5eb35bf5f..ee383d8fc835 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -80,6 +80,7 @@ obj-$(CONFIG_REGULATOR_MAX8973) += max8973-regulator.o
 obj-$(CONFIG_REGULATOR_MAX8997) += max8997-regulator.o
 obj-$(CONFIG_REGULATOR_MAX8998) += max8998.o
 obj-$(CONFIG_REGULATOR_MAX20086) += max20086-regulator.o
+obj-$(CONFIG_REGULATOR_MAX20411) += max20411-regulator.o
 obj-$(CONFIG_REGULATOR_MAX77686) += max77686-regulator.o
 obj-$(CONFIG_REGULATOR_MAX77693) += max77693-regulator.o
 obj-$(CONFIG_REGULATOR_MAX77802) += max77802-regulator.o
diff --git a/drivers/regulator/max20411-regulator.c b/drivers/regulator/max20411-regulator.c
new file mode 100644
index 000000000000..a5139ddc7a84
--- /dev/null
+++ b/drivers/regulator/max20411-regulator.c
@@ -0,0 +1,163 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2021, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022, Linaro Ltd.
+ */
+
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/of_regulator.h>
+
+#define MAX20411_UV_STEP		6250
+#define MAX20411_BASE_UV		243750
+#define MAX20411_MIN_SEL		41 /* 0.5V */
+#define MAX20411_MAX_SEL		165 /* 1.275V */
+#define MAX20411_VID_OFFSET		0x7
+#define MAX20411_VID_MASK		0xff
+#define MAX20411_SLEW_OFFSET		0x6
+#define MAX20411_SLEW_DVS_MASK		0xc
+#define MAX20411_SLEW_SR_MASK		0x3
+
+struct max20411 {
+	struct device *dev;
+	struct device_node *of_node;
+	struct regulator_desc desc;
+	struct regulator_dev *rdev;
+	struct regmap *regmap;
+};
+
+static const unsigned int max20411_slew_rates[] = { 13100, 6600, 3300, 1600 };
+
+static int max20411_enable_time(struct regulator_dev *rdev)
+{
+	int voltage, rate, ret;
+	unsigned int val;
+
+	/* get voltage */
+	ret = regmap_read(rdev->regmap, rdev->desc->vsel_reg, &val);
+	if (ret)
+		return ret;
+
+	val &= rdev->desc->vsel_mask;
+	voltage = regulator_list_voltage_linear(rdev, val);
+
+	/* get rate */
+	ret = regmap_read(rdev->regmap, MAX20411_SLEW_OFFSET, &val);
+	if (ret)
+		return ret;
+
+	val = FIELD_GET(MAX20411_SLEW_SR_MASK, val);
+	rate = max20411_slew_rates[val];
+
+	return DIV_ROUND_UP(voltage, rate);
+}
+
+static const struct regmap_config max20411_regmap_config = {
+	.reg_bits		= 8,
+	.val_bits		= 8,
+	.max_register		= 0xe,
+};
+
+static const struct regulator_ops max20411_ops = {
+	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
+	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
+	.list_voltage		= regulator_list_voltage_linear,
+	.enable_time		= max20411_enable_time,
+};
+
+static int max20411_probe(struct i2c_client *client,
+			  const struct i2c_device_id *id)
+{
+	struct regulator_init_data *init_data;
+	struct device *dev = &client->dev;
+	struct regulator_config cfg = {};
+	struct regulator_desc *desc;
+	struct max20411 *max20411;
+
+	max20411 = devm_kzalloc(dev, sizeof(*max20411), GFP_KERNEL);
+	if (!max20411)
+		return -ENOMEM;
+
+	max20411->regmap = devm_regmap_init_i2c(client, &max20411_regmap_config);
+	if (IS_ERR(max20411->regmap)) {
+		dev_err(dev, "Failed to allocate regmap!\n");
+		return PTR_ERR(max20411->regmap);
+	}
+
+	max20411->dev = dev;
+	max20411->of_node = dev->of_node;
+
+	init_data = of_get_regulator_init_data(max20411->dev, max20411->of_node, &max20411->desc);
+	if (!init_data)
+		return -ENODATA;
+
+	desc = &max20411->desc;
+
+	desc->ops = &max20411_ops;
+	desc->owner = THIS_MODULE;
+	desc->type = REGULATOR_VOLTAGE;
+	desc->supply_name = "vin";
+	desc->name = "max20411";
+
+	/*
+	 * voltage = 0.24375V + selector * 6.25mV
+	 * with valid selector between 41 to 165 (0.5V to 1.275V)
+	 */
+	desc->min_uV = MAX20411_BASE_UV;
+	desc->uV_step = MAX20411_UV_STEP;
+	desc->linear_min_sel = MAX20411_MIN_SEL;
+	desc->n_voltages = MAX20411_MAX_SEL;
+
+	desc->vsel_reg = MAX20411_VID_OFFSET;
+	desc->vsel_mask = MAX20411_VID_MASK;
+
+	desc->ramp_reg = MAX20411_SLEW_OFFSET;
+	desc->ramp_mask = MAX20411_SLEW_DVS_MASK;
+	desc->ramp_delay_table = max20411_slew_rates;
+	desc->n_ramp_values = ARRAY_SIZE(max20411_slew_rates);
+
+	cfg.dev = max20411->dev;
+	cfg.init_data = init_data;
+	cfg.of_node = max20411->of_node;
+	cfg.driver_data = max20411;
+
+	cfg.ena_gpiod = gpiod_get(max20411->dev, "enable", GPIOD_ASIS);
+	if (IS_ERR(cfg.ena_gpiod))
+		return dev_err_probe(dev, PTR_ERR(cfg.ena_gpiod),
+				     "unable to acquire enable gpio\n");
+
+	max20411->rdev = devm_regulator_register(max20411->dev, desc, &cfg);
+	if (IS_ERR(max20411->rdev))
+		dev_err(max20411->dev, "Failed to register regulator\n");
+
+	return PTR_ERR_OR_ZERO(max20411->rdev);
+}
+
+static const struct of_device_id of_max20411_match_tbl[] = {
+	{ .compatible = "maxim,max20411", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, of_max20411_match_tbl);
+
+static const struct i2c_device_id max20411_id[] = {
+	{ "max20411", 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(i2c, max20411_id);
+
+static struct i2c_driver max20411_i2c_driver = {
+	.driver	= {
+		.name = "max20411",
+		.of_match_table	= of_max20411_match_tbl,
+	},
+	.probe = max20411_probe,
+	.id_table = max20411_id,
+};
+module_i2c_driver(max20411_i2c_driver);
+
+MODULE_LICENSE("GPL");
-- 
2.37.3

