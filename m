Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F3D6491AD
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 02:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiLKBYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 20:24:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiLKBYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 20:24:01 -0500
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [IPv6:2001:4b7a:2000:18::166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F379013EA7;
        Sat, 10 Dec 2022 17:24:00 -0800 (PST)
Received: from TimeMachine.lan (adsl-d248.84-47-10.t-com.sk [84.47.10.248])
        by m-r2.th.seeweb.it (Postfix) with ESMTPA id BC1553EEEB;
        Sun, 11 Dec 2022 02:23:58 +0100 (CET)
From:   Martin Botka <martin.botka@somainline.org>
To:     martin.botka1@gmail.com
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jami Kettunen <jamipkettunen@somainline.org>,
        Paul Bouchara <paul.bouchara@somainline.org>,
        Jan Trmal <jtrmal@gmail.com>, Tom <takuya@takuya.tech>,
        Martin Botka <martin.botka@somainline.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] regulator: axp20x: Add support for AXP1530 variant
Date:   Sun, 11 Dec 2022 02:21:32 +0100
Message-Id: <20221211012132.1650783-4-martin.botka@somainline.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221211012132.1650783-1-martin.botka@somainline.org>
References: <20221211012132.1650783-1-martin.botka@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,RCVD_IN_SORBS_HTTP,
        RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AXP1530 has a few regulators that are controlled via I2C Bus.

Add support for them.

Signed-off-by: Martin Botka <martin.botka@somainline.org>
---
 drivers/regulator/axp20x-regulator.c | 44 ++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index d260c442b788..ca422311a996 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -1001,6 +1001,40 @@ static const struct regulator_desc axp813_regulators[] = {
 		    AXP22X_PWR_OUT_CTRL2, AXP22X_PWR_OUT_DC1SW_MASK),
 };
 
+static const struct linear_range axp1530_dcdc1_ranges[] = {
+	REGULATOR_LINEAR_RANGE(500000, 0x0, 0x46, 10000),
+	REGULATOR_LINEAR_RANGE(1220000, 0x47, 0x57, 20000),
+	REGULATOR_LINEAR_RANGE(1600000, 0x58, 0x6A, 100000),
+};
+
+static const struct linear_range axp1530_dcdc2_ranges[] = {
+	REGULATOR_LINEAR_RANGE(500000, 0x0, 0x46, 10000),
+	REGULATOR_LINEAR_RANGE(1220000, 0x47, 0x57, 20000),
+};
+
+static const struct linear_range axp1530_dcdc3_ranges[] = {
+	REGULATOR_LINEAR_RANGE(500000, 0x0, 0x46, 10000),
+	REGULATOR_LINEAR_RANGE(1220000, 0x47, 0x66, 20000),
+};
+
+static const struct regulator_desc axp1530_regulators[] = {
+	AXP_DESC_RANGES(AXP1530, DCDC1, "dcdc1", "vin1", axp1530_dcdc1_ranges,
+					0x6B, AXP1530_DCDC1_CONRTOL, 0x7f, AXP1530_OUTPUT_CONTROL,
+					BIT(0)),
+	AXP_DESC_RANGES(AXP1530, DCDC2, "dcdc2", "vin2", axp1530_dcdc2_ranges,
+					0x58, AXP1530_DCDC2_CONRTOL, 0x7f, AXP1530_OUTPUT_CONTROL,
+					BIT(1)),
+	AXP_DESC_RANGES(AXP1530, DCDC3, "dcdc3", "vin3", axp1530_dcdc3_ranges,
+					0x58, AXP1530_DCDC3_CONRTOL, 0x7f, AXP1530_OUTPUT_CONTROL,
+					BIT(2)),
+	AXP_DESC(AXP1530, LDO1, "ldo1", "ldo1in", 500, 3500, 100,
+					AXP1530_ALDO1_CONRTOL, 0x1f, AXP1530_OUTPUT_CONTROL,
+					BIT(3)),
+	AXP_DESC(AXP1530, LDO2, "ldo2", "ldo2in", 500, 3500, 100,
+					AXP1530_DLDO1_CONRTOL, 0x1f, AXP1530_OUTPUT_CONTROL,
+					BIT(4)),
+};
+
 static int axp20x_set_dcdc_freq(struct platform_device *pdev, u32 dcdcfreq)
 {
 	struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);
@@ -1040,6 +1074,12 @@ static int axp20x_set_dcdc_freq(struct platform_device *pdev, u32 dcdcfreq)
 		def = 3000;
 		step = 150;
 		break;
+	case AXP1530_ID:
+		/*
+		 * Do not set the DCDC frequency on AXP1530
+		 */
+		return 0;
+		break;
 	default:
 		dev_err(&pdev->dev,
 			"Setting DCDC frequency for unsupported AXP variant\n");
@@ -1252,6 +1292,10 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
 		drivevbus = of_property_read_bool(pdev->dev.parent->of_node,
 						  "x-powers,drive-vbus-en");
 		break;
+		case AXP1530_ID:
+		regulators = axp1530_regulators;
+		nregulators = AXP1530_REG_ID_MAX;
+		break;
 	default:
 		dev_err(&pdev->dev, "Unsupported AXP variant: %ld\n",
 			axp20x->variant);
-- 
2.38.1

