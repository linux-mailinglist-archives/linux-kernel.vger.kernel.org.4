Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E35E66C293
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 15:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbjAPOqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 09:46:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbjAPOp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 09:45:26 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8B1DB2749F
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 06:25:30 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 77336C14;
        Mon, 16 Jan 2023 06:26:12 -0800 (PST)
Received: from donnerap.cambridge.arm.com (donnerap.cambridge.arm.com [10.1.197.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B111B3F67D;
        Mon, 16 Jan 2023 06:25:28 -0800 (PST)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
        Mark Brown <broonie@kernel.org>, Lee Jones <lee@kernel.org>,
        Martin Botka <martin.botka@somainline.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        martin.botka1@gmail.com, Samuel Holland <samuel@sholland.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/3] regulator: axp20x: Add support for AXP313a variant
Date:   Mon, 16 Jan 2023 14:25:01 +0000
Message-Id: <20230116142501.767142-4-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230116142501.767142-1-andre.przywara@arm.com>
References: <20230116142501.767142-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Botka <martin.botka@somainline.org>

The AXP313a is your typical I2C controlled PMIC, although in a lighter
fashion compared to the other X-Powers PMICs: it has only three DCDC
rails, three LDOs, and no battery charging support.

The AXP313a datasheet does not describe a register to change the DCDC
switching frequency, and talks of it being fixed at 3 MHz. The BSP
driver hints at a register being able to change that, but we haven't
verified that, so leave that one out. It can be added later, if needed
and/or required.

The third LDO, RTCLDO, is fixed, and cannot even be turned on or off,
programmatically. On top of that, its voltage is customisable (either
1.8V or 3.3V), which we cannot describe easily using the existing
regulator wrapper functions. This should be fixed properly, using
regulator-{min,max}-microvolt in the DT, but this requires more changes
to the code. As some other PMICs (AXP2xx, AXP803) seem to paper over the
same problem as well, we follow suit here and pretend it's a fixed 1.8V
regulator. A proper fix can follow later. The BSP code seems to ignore
this regulator altogether.

Describe the AXP313A's voltage settings and switch registers, how the
voltages are encoded, and connect this to the MFD device via its
regulator ID.

Signed-off-by: Martin Botka <martin.botka@somainline.org>
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/regulator/axp20x-regulator.c | 60 ++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index d260c442b788d..f310a959de9a7 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -134,6 +134,11 @@
 #define AXP22X_PWR_OUT_DLDO4_MASK	BIT_MASK(6)
 #define AXP22X_PWR_OUT_ALDO3_MASK	BIT_MASK(7)
 
+#define AXP313A_DCDC1_NUM_VOLTAGES	107
+#define AXP313A_DCDC23_NUM_VOLTAGES	88
+#define AXP313A_DCDC_V_OUT_MASK		GENMASK(6, 0)
+#define AXP313A_LDO_V_OUT_MASK		GENMASK(4, 0)
+
 #define AXP803_PWR_OUT_DCDC1_MASK	BIT_MASK(0)
 #define AXP803_PWR_OUT_DCDC2_MASK	BIT_MASK(1)
 #define AXP803_PWR_OUT_DCDC3_MASK	BIT_MASK(2)
@@ -1001,6 +1006,48 @@ static const struct regulator_desc axp813_regulators[] = {
 		    AXP22X_PWR_OUT_CTRL2, AXP22X_PWR_OUT_DC1SW_MASK),
 };
 
+static const struct linear_range axp313a_dcdc1_ranges[] = {
+	REGULATOR_LINEAR_RANGE(500000,   0,  70,  10000),
+	REGULATOR_LINEAR_RANGE(1220000, 71,  87,  20000),
+	REGULATOR_LINEAR_RANGE(1600000, 88, 106, 100000),
+};
+
+static const struct linear_range axp313a_dcdc2_ranges[] = {
+	REGULATOR_LINEAR_RANGE(500000,   0, 70, 10000),
+	REGULATOR_LINEAR_RANGE(1220000, 71, 87, 20000),
+};
+
+/*
+ * This is deviating from the datasheet. The values here are taken from the
+ * BSP driver and have been confirmed by measurements.
+ */
+static const struct linear_range axp313a_dcdc3_ranges[] = {
+	REGULATOR_LINEAR_RANGE(500000,   0,  70, 10000),
+	REGULATOR_LINEAR_RANGE(1220000, 71, 102, 20000),
+};
+
+static const struct regulator_desc axp313a_regulators[] = {
+	AXP_DESC_RANGES(AXP313A, DCDC1, "dcdc1", "vin1",
+			axp313a_dcdc1_ranges, AXP313A_DCDC1_NUM_VOLTAGES,
+			AXP313A_DCDC1_CONRTOL, AXP313A_DCDC_V_OUT_MASK,
+			AXP313A_OUTPUT_CONTROL, BIT(0)),
+	AXP_DESC_RANGES(AXP313A, DCDC2, "dcdc2", "vin2",
+			axp313a_dcdc2_ranges, AXP313A_DCDC23_NUM_VOLTAGES,
+			AXP313A_DCDC2_CONRTOL, AXP313A_DCDC_V_OUT_MASK,
+			AXP313A_OUTPUT_CONTROL, BIT(1)),
+	AXP_DESC_RANGES(AXP313A, DCDC3, "dcdc3", "vin3",
+			axp313a_dcdc3_ranges, AXP313A_DCDC23_NUM_VOLTAGES,
+			AXP313A_DCDC3_CONRTOL, AXP313A_DCDC_V_OUT_MASK,
+			AXP313A_OUTPUT_CONTROL, BIT(2)),
+	AXP_DESC(AXP313A, LDO1, "ldo1", "vin1", 500, 3500, 100,
+		 AXP313A_ALDO1_CONRTOL, AXP313A_LDO_V_OUT_MASK,
+		 AXP313A_OUTPUT_CONTROL, BIT(3)),
+	AXP_DESC(AXP313A, LDO2, "ldo2", "vin1", 500, 3500, 100,
+		 AXP313A_DLDO1_CONRTOL, AXP313A_LDO_V_OUT_MASK,
+		 AXP313A_OUTPUT_CONTROL, BIT(4)),
+	AXP_DESC_FIXED(AXP313A, RTC_LDO, "rtc-ldo", "vin1", 1800),
+};
+
 static int axp20x_set_dcdc_freq(struct platform_device *pdev, u32 dcdcfreq)
 {
 	struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);
@@ -1040,6 +1087,15 @@ static int axp20x_set_dcdc_freq(struct platform_device *pdev, u32 dcdcfreq)
 		def = 3000;
 		step = 150;
 		break;
+	case AXP313A_ID:
+		/* The DCDC PWM frequency seems to be fixed to 3 MHz. */
+		if (dcdcfreq != 3000000) {
+			dev_err(&pdev->dev,
+				"DCDC frequency on AXP313a is fixed to 3 MHz.\n");
+			return -EINVAL;
+		}
+
+		return 0;
 	default:
 		dev_err(&pdev->dev,
 			"Setting DCDC frequency for unsupported AXP variant\n");
@@ -1220,6 +1276,10 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
 	bool drivevbus = false;
 
 	switch (axp20x->variant) {
+	case AXP313A_ID:
+		regulators = axp313a_regulators;
+		nregulators = AXP313A_REG_ID_MAX;
+		break;
 	case AXP202_ID:
 	case AXP209_ID:
 		regulators = axp20x_regulators;
-- 
2.25.1

