Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2016D9E61
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 19:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240014AbjDFRTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 13:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239520AbjDFRS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 13:18:59 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814F79ED2;
        Thu,  6 Apr 2023 10:18:36 -0700 (PDT)
Received: from localhost (unknown [188.27.34.213])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2D01B66031EE;
        Thu,  6 Apr 2023 18:18:35 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680801515;
        bh=xfQ/7UvlTEZNT/nG8uJjsoHa3zrmCqKaD8nZ/sO9yw8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cC1hbJmBRiPzHXy/VJ3ilY8S2BWATdTMQ/D4yw0gbl7nsElNOW8mYbRMAmjrF5PHj
         accV9rYFxUwzB+MkOAcyN5mjF4Aya+QN9c9HU4N1id5m4K6nr7pNUESV1wEfDFyNxN
         uufmvjL1dAXUUWHf2HB+wqFB+fRNvqFhZswwnubuK8wfJ9ozbLLiWmQQTwr+uiMZIw
         ZFROdwQvMgrBZqZansWbgpdjJ5IWCsL7KDzUSZ/DSy3fJgRCsbkSed8JdE5Ev4+V7l
         DKxxFPG99NhSDHgZZCb7eLikFj3ET7O+GCm4CggVmW+UEt9+uIc5C7iWLnAgXEJHy2
         ARjbUsZ+n+VKA==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Joseph Chen <chenjh@rock-chips.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH v2 8/8] regulator: fan53555: Add support for RK860X
Date:   Thu,  6 Apr 2023 20:18:06 +0300
Message-Id: <20230406171806.948290-9-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230406171806.948290-1-cristian.ciocaltea@collabora.com>
References: <20230406171806.948290-1-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend the existing fan53555 driver to support the Rockchip RK860X
regulators.

RK8600/RK8601 are pretty similar to the FAN53555 regulators.

RK8602/RK8603 are a bit different, having a wider output voltage
selection range, from 0.5 V to 1.5 V in 6.25 mV steps. They also use
additional VSEL0/VSEL1 registers for the voltage selector, but the
enable and mode bits are still located in the original FAN53555 specific
VSEL0/VSEL1 registers.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/regulator/fan53555.c | 121 ++++++++++++++++++++++++++++++++++-
 1 file changed, 118 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/fan53555.c b/drivers/regulator/fan53555.c
index acf14ba7aaa6..130f3dbe9840 100644
--- a/drivers/regulator/fan53555.c
+++ b/drivers/regulator/fan53555.c
@@ -26,6 +26,9 @@
 #define FAN53555_VSEL0		0x00
 #define FAN53555_VSEL1		0x01
 
+#define RK8602_VSEL0		0x06
+#define RK8602_VSEL1		0x07
+
 #define TCS4525_VSEL0		0x11
 #define TCS4525_VSEL1		0x10
 #define TCS4525_TIME		0x13
@@ -55,6 +58,7 @@
 
 #define FAN53555_NVOLTAGES	64	/* Numbers of voltages */
 #define FAN53526_NVOLTAGES	128
+#define RK8602_NVOLTAGES	160
 
 #define TCS_VSEL0_MODE		BIT(7)
 #define TCS_VSEL1_MODE		BIT(6)
@@ -64,6 +68,8 @@
 enum fan53555_vendor {
 	FAN53526_VENDOR_FAIRCHILD = 0,
 	FAN53555_VENDOR_FAIRCHILD,
+	FAN53555_VENDOR_ROCKCHIP,	/* RK8600, RK8601 */
+	RK8602_VENDOR_ROCKCHIP,		/* RK8602, RK8603 */
 	FAN53555_VENDOR_SILERGY,
 	FAN53526_VENDOR_TCS,
 };
@@ -87,6 +93,14 @@ enum {
 	FAN53555_CHIP_ID_08 = 8,
 };
 
+enum {
+	RK8600_CHIP_ID_08 = 8,		/* RK8600, RK8601 */
+};
+
+enum {
+	RK8602_CHIP_ID_10 = 10,		/* RK8602, RK8603 */
+};
+
 enum {
 	TCS4525_CHIP_ID_12 = 12,
 };
@@ -117,6 +131,8 @@ struct fan53555_device_info {
 	/* Voltage setting register */
 	unsigned int vol_reg;
 	unsigned int sleep_reg;
+	unsigned int en_reg;
+	unsigned int sleep_en_reg;
 	/* Voltage range and step(linear) */
 	unsigned int vsel_min;
 	unsigned int vsel_step;
@@ -159,7 +175,7 @@ static int fan53555_set_suspend_enable(struct regulator_dev *rdev)
 {
 	struct fan53555_device_info *di = rdev_get_drvdata(rdev);
 
-	return regmap_update_bits(rdev->regmap, di->sleep_reg,
+	return regmap_update_bits(rdev->regmap, di->sleep_en_reg,
 				  VSEL_BUCK_EN, VSEL_BUCK_EN);
 }
 
@@ -167,7 +183,7 @@ static int fan53555_set_suspend_disable(struct regulator_dev *rdev)
 {
 	struct fan53555_device_info *di = rdev_get_drvdata(rdev);
 
-	return regmap_update_bits(rdev->regmap, di->sleep_reg,
+	return regmap_update_bits(rdev->regmap, di->sleep_en_reg,
 				  VSEL_BUCK_EN, 0);
 }
 
@@ -317,6 +333,50 @@ static int fan53555_voltages_setup_fairchild(struct fan53555_device_info *di)
 	return 0;
 }
 
+static int fan53555_voltages_setup_rockchip(struct fan53555_device_info *di)
+{
+	/* Init voltage range and step */
+	switch (di->chip_id) {
+	case RK8600_CHIP_ID_08:
+		di->vsel_min = 712500;
+		di->vsel_step = 12500;
+		break;
+	default:
+		dev_err(di->dev,
+			"Chip ID %d not supported!\n", di->chip_id);
+		return -EINVAL;
+	}
+	di->slew_reg = FAN53555_CONTROL;
+	di->slew_mask = CTL_SLEW_MASK;
+	di->ramp_delay_table = slew_rates;
+	di->n_ramp_values = ARRAY_SIZE(slew_rates);
+	di->vsel_count = FAN53555_NVOLTAGES;
+
+	return 0;
+}
+
+static int rk8602_voltages_setup_rockchip(struct fan53555_device_info *di)
+{
+	/* Init voltage range and step */
+	switch (di->chip_id) {
+	case RK8602_CHIP_ID_10:
+		di->vsel_min = 500000;
+		di->vsel_step = 6250;
+		break;
+	default:
+		dev_err(di->dev,
+			"Chip ID %d not supported!\n", di->chip_id);
+		return -EINVAL;
+	}
+	di->slew_reg = FAN53555_CONTROL;
+	di->slew_mask = CTL_SLEW_MASK;
+	di->ramp_delay_table = slew_rates;
+	di->n_ramp_values = ARRAY_SIZE(slew_rates);
+	di->vsel_count = RK8602_NVOLTAGES;
+
+	return 0;
+}
+
 static int fan53555_voltages_setup_silergy(struct fan53555_device_info *di)
 {
 	/* Init voltage range and step */
@@ -377,6 +437,7 @@ static int fan53555_device_setup(struct fan53555_device_info *di,
 	switch (di->vendor) {
 	case FAN53526_VENDOR_FAIRCHILD:
 	case FAN53555_VENDOR_FAIRCHILD:
+	case FAN53555_VENDOR_ROCKCHIP:
 	case FAN53555_VENDOR_SILERGY:
 		switch (pdata->sleep_vsel_id) {
 		case FAN53555_VSEL_ID_0:
@@ -391,6 +452,27 @@ static int fan53555_device_setup(struct fan53555_device_info *di,
 			dev_err(di->dev, "Invalid VSEL ID!\n");
 			return -EINVAL;
 		}
+		di->sleep_en_reg = di->sleep_reg;
+		di->en_reg = di->vol_reg;
+		break;
+	case RK8602_VENDOR_ROCKCHIP:
+		switch (pdata->sleep_vsel_id) {
+		case FAN53555_VSEL_ID_0:
+			di->sleep_reg = RK8602_VSEL0;
+			di->vol_reg = RK8602_VSEL1;
+			di->sleep_en_reg = FAN53555_VSEL0;
+			di->en_reg = FAN53555_VSEL1;
+			break;
+		case FAN53555_VSEL_ID_1:
+			di->sleep_reg = RK8602_VSEL1;
+			di->vol_reg = RK8602_VSEL0;
+			di->sleep_en_reg = FAN53555_VSEL1;
+			di->en_reg = FAN53555_VSEL0;
+			break;
+		default:
+			dev_err(di->dev, "Invalid VSEL ID!\n");
+			return -EINVAL;
+		}
 		break;
 	case FAN53526_VENDOR_TCS:
 		switch (pdata->sleep_vsel_id) {
@@ -406,6 +488,8 @@ static int fan53555_device_setup(struct fan53555_device_info *di,
 			dev_err(di->dev, "Invalid VSEL ID!\n");
 			return -EINVAL;
 		}
+		di->sleep_en_reg = di->sleep_reg;
+		di->en_reg = di->vol_reg;
 		break;
 	default:
 		dev_err(di->dev, "vendor %d not supported!\n", di->vendor);
@@ -427,10 +511,23 @@ static int fan53555_device_setup(struct fan53555_device_info *di,
 		}
 		break;
 	case FAN53555_VENDOR_FAIRCHILD:
+	case FAN53555_VENDOR_ROCKCHIP:
 	case FAN53555_VENDOR_SILERGY:
 		di->mode_reg = di->vol_reg;
 		di->mode_mask = VSEL_MODE;
 		break;
+	case RK8602_VENDOR_ROCKCHIP:
+		di->mode_mask = VSEL_MODE;
+
+		switch (pdata->sleep_vsel_id) {
+		case FAN53555_VSEL_ID_0:
+			di->mode_reg = FAN53555_VSEL1;
+			break;
+		case FAN53555_VSEL_ID_1:
+			di->mode_reg = FAN53555_VSEL0;
+			break;
+		}
+		break;
 	case FAN53526_VENDOR_TCS:
 		di->mode_reg = TCS4525_COMMAND;
 
@@ -456,6 +553,12 @@ static int fan53555_device_setup(struct fan53555_device_info *di,
 	case FAN53555_VENDOR_FAIRCHILD:
 		ret = fan53555_voltages_setup_fairchild(di);
 		break;
+	case FAN53555_VENDOR_ROCKCHIP:
+		ret = fan53555_voltages_setup_rockchip(di);
+		break;
+	case RK8602_VENDOR_ROCKCHIP:
+		ret = rk8602_voltages_setup_rockchip(di);
+		break;
 	case FAN53555_VENDOR_SILERGY:
 		ret = fan53555_voltages_setup_silergy(di);
 		break;
@@ -481,7 +584,7 @@ static int fan53555_regulator_register(struct fan53555_device_info *di,
 	rdesc->ops = &fan53555_regulator_ops;
 	rdesc->type = REGULATOR_VOLTAGE;
 	rdesc->n_voltages = di->vsel_count;
-	rdesc->enable_reg = di->vol_reg;
+	rdesc->enable_reg = di->en_reg;
 	rdesc->enable_mask = VSEL_BUCK_EN;
 	rdesc->min_uV = di->vsel_min;
 	rdesc->uV_step = di->vsel_step;
@@ -531,6 +634,12 @@ static const struct of_device_id __maybe_unused fan53555_dt_ids[] = {
 	}, {
 		.compatible = "fcs,fan53555",
 		.data = (void *)FAN53555_VENDOR_FAIRCHILD
+	}, {
+		.compatible = "rockchip,rk8600",
+		.data = (void *)FAN53555_VENDOR_ROCKCHIP
+	}, {
+		.compatible = "rockchip,rk8602",
+		.data = (void *)RK8602_VENDOR_ROCKCHIP
 	}, {
 		.compatible = "silergy,syr827",
 		.data = (void *)FAN53555_VENDOR_SILERGY,
@@ -637,6 +746,12 @@ static const struct i2c_device_id fan53555_id[] = {
 	}, {
 		.name = "fan53555",
 		.driver_data = FAN53555_VENDOR_FAIRCHILD
+	}, {
+		.name = "rk8600",
+		.driver_data = FAN53555_VENDOR_ROCKCHIP
+	}, {
+		.name = "rk8602",
+		.driver_data = RK8602_VENDOR_ROCKCHIP
 	}, {
 		.name = "syr827",
 		.driver_data = FAN53555_VENDOR_SILERGY
-- 
2.40.0

