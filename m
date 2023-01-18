Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC10672186
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 16:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbjARPlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 10:41:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbjARPlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 10:41:08 -0500
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887B0A27E;
        Wed, 18 Jan 2023 07:41:07 -0800 (PST)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1pIAYj-0007hg-1C;
        Wed, 18 Jan 2023 16:41:05 +0100
Date:   Wed, 18 Jan 2023 15:40:58 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Steven Liu <steven.liu@mediatek.com>,
        Henry Yen <Henry.Yen@mediatek.com>,
        Chad Monroe <chad@monroe.io>, John Crispin <john@phrozen.org>
Subject: [PATCH v5 2/2] thermal: mediatek: add support for MT7986 and MT7981
Message-ID: <2d341fc45266217249586eb4bd3be3ac4ca83a12.1674055882.git.daniel@makrotopia.org>
References: <cover.1674055882.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1674055882.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for V3 generation thermal found in MT7986 and MT7981 SoCs.
Brings code to assign values from efuse as well as new function to
convert raw temperature to millidegree celsius, as found in MediaTek's
SDK sources (but cleaned up and de-duplicated)

[1]: https://git01.mediatek.com/plugins/gitiles/openwrt/feeds/mtk-openwrt-feeds/+/baf36c7eef477aae1f8f2653b6c29e2caf48475b
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/thermal/mtk_thermal.c | 128 ++++++++++++++++++++++++++++++++--
 1 file changed, 124 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
index 992750ee09e62..0707ff21adf65 100644
--- a/drivers/thermal/mtk_thermal.c
+++ b/drivers/thermal/mtk_thermal.c
@@ -150,6 +150,20 @@
 #define CALIB_BUF1_VALID_V2(x)		(((x) >> 4) & 0x1)
 #define CALIB_BUF1_O_SLOPE_SIGN_V2(x)	(((x) >> 3) & 0x1)
 
+/*
+ * Layout of the fuses providing the calibration data
+ * These macros can be used for MT7981 and MT7986.
+ */
+#define CALIB_BUF0_ADC_GE_V3(x)		(((x) >> 0) & 0x3ff)
+#define CALIB_BUF0_DEGC_CALI_V3(x)	(((x) >> 20) & 0x3f)
+#define CALIB_BUF0_O_SLOPE_V3(x)	(((x) >> 26) & 0x3f)
+#define CALIB_BUF1_VTS_TS1_V3(x)	(((x) >> 0) & 0x1ff)
+#define CALIB_BUF1_VTS_TS2_V3(x)	(((x) >> 21) & 0x1ff)
+#define CALIB_BUF1_VTS_TSABB_V3(x)	(((x) >> 9) & 0x1ff)
+#define CALIB_BUF1_VALID_V3(x)		(((x) >> 18) & 0x1)
+#define CALIB_BUF1_O_SLOPE_SIGN_V3(x)	(((x) >> 19) & 0x1)
+#define CALIB_BUF1_ID_V3(x)		(((x) >> 20) & 0x1)
+
 enum {
 	VTS1,
 	VTS2,
@@ -163,6 +177,7 @@ enum {
 enum mtk_thermal_version {
 	MTK_THERMAL_V1 = 1,
 	MTK_THERMAL_V2,
+	MTK_THERMAL_V3,
 };
 
 /* MT2701 thermal sensors */
@@ -245,6 +260,27 @@ enum mtk_thermal_version {
 /* The calibration coefficient of sensor  */
 #define MT8183_CALIBRATION	153
 
+/* AUXADC channel 11 is used for the temperature sensors */
+#define MT7986_TEMP_AUXADC_CHANNEL	11
+
+/* The total number of temperature sensors in the MT7986 */
+#define MT7986_NUM_SENSORS		1
+
+/* The number of banks in the MT7986 */
+#define MT7986_NUM_ZONES		1
+
+/* The number of sensing points per bank */
+#define MT7986_NUM_SENSORS_PER_ZONE	1
+
+/* MT7986 thermal sensors */
+#define MT7986_TS1			0
+
+/* The number of controller in the MT7986 */
+#define MT7986_NUM_CONTROLLER		1
+
+/* The calibration coefficient of sensor  */
+#define MT7986_CALIBRATION		165
+
 struct mtk_thermal;
 
 struct thermal_bank_cfg {
@@ -388,6 +424,14 @@ static const int mt7622_mux_values[MT7622_NUM_SENSORS] = { 0, };
 static const int mt7622_vts_index[MT7622_NUM_SENSORS] = { VTS1 };
 static const int mt7622_tc_offset[MT7622_NUM_CONTROLLER] = { 0x0, };
 
+/* MT7986 thermal sensor data */
+static const int mt7986_bank_data[MT7986_NUM_SENSORS] = { MT7986_TS1, };
+static const int mt7986_msr[MT7986_NUM_SENSORS_PER_ZONE] = { TEMP_MSR0, };
+static const int mt7986_adcpnp[MT7986_NUM_SENSORS_PER_ZONE] = { TEMP_ADCPNP0, };
+static const int mt7986_mux_values[MT7986_NUM_SENSORS] = { 0, };
+static const int mt7986_vts_index[MT7986_NUM_SENSORS] = { VTS1 };
+static const int mt7986_tc_offset[MT7986_NUM_CONTROLLER] = { 0x0, };
+
 /*
  * The MT8173 thermal controller has four banks. Each bank can read up to
  * four temperature sensors simultaneously. The MT8173 has a total of 5
@@ -551,6 +595,30 @@ static const struct mtk_thermal_data mt8183_thermal_data = {
 	.version = MTK_THERMAL_V1,
 };
 
+/*
+ * MT7986 uses AUXADC Channel 11 for raw data access.
+ */
+static const struct mtk_thermal_data mt7986_thermal_data = {
+	.auxadc_channel = MT7986_TEMP_AUXADC_CHANNEL,
+	.num_banks = MT7986_NUM_ZONES,
+	.num_sensors = MT7986_NUM_SENSORS,
+	.vts_index = mt7986_vts_index,
+	.cali_val = MT7986_CALIBRATION,
+	.num_controller = MT7986_NUM_CONTROLLER,
+	.controller_offset = mt7986_tc_offset,
+	.need_switch_bank = true,
+	.bank_data = {
+		{
+			.num_sensors = 1,
+			.sensors = mt7986_bank_data,
+		},
+	},
+	.msr = mt7986_msr,
+	.adcpnp = mt7986_adcpnp,
+	.sensor_mux_values = mt7986_mux_values,
+	.version = MTK_THERMAL_V3,
+};
+
 /**
  * raw_to_mcelsius_v1 - convert a raw ADC value to mcelsius
  * @mt:	The thermal controller
@@ -605,6 +673,22 @@ static int raw_to_mcelsius_v2(struct mtk_thermal *mt, int sensno, s32 raw)
 	return (format_2 - tmp) * 100;
 }
 
+static int raw_to_mcelsius_v3(struct mtk_thermal *mt, int sensno, s32 raw)
+{
+	s32 tmp;
+
+	if (raw == 0)
+		return 0;
+
+	raw &= 0xfff;
+	tmp = 100000 * 15 / 16 * 10000;
+	tmp /= 4096 - 512 + mt->adc_ge;
+	tmp /= 1490;
+	tmp *= raw - mt->vts[sensno] - 2900;
+
+	return mt->degc_cali * 500 - tmp;
+}
+
 /**
  * mtk_thermal_get_bank - get bank
  * @bank:	The bank
@@ -885,6 +969,25 @@ static int mtk_thermal_extract_efuse_v2(struct mtk_thermal *mt, u32 *buf)
 	return 0;
 }
 
+static int mtk_thermal_extract_efuse_v3(struct mtk_thermal *mt, u32 *buf)
+{
+	if (!CALIB_BUF1_VALID_V3(buf[1]))
+		return -EINVAL;
+
+	mt->adc_ge = CALIB_BUF0_ADC_GE_V3(buf[0]);
+	mt->degc_cali = CALIB_BUF0_DEGC_CALI_V3(buf[0]);
+	mt->o_slope = CALIB_BUF0_O_SLOPE_V3(buf[0]);
+	mt->vts[VTS1] = CALIB_BUF1_VTS_TS1_V3(buf[1]);
+	mt->vts[VTS2] = CALIB_BUF1_VTS_TS2_V3(buf[1]);
+	mt->vts[VTSABB] = CALIB_BUF1_VTS_TSABB_V3(buf[1]);
+	mt->o_slope_sign = CALIB_BUF1_O_SLOPE_SIGN_V3(buf[1]);
+
+	if (CALIB_BUF1_ID_V3(buf[1]) == 0)
+		mt->o_slope = 0;
+
+	return 0;
+}
+
 static int mtk_thermal_get_calibration_data(struct device *dev,
 					    struct mtk_thermal *mt)
 {
@@ -895,6 +998,7 @@ static int mtk_thermal_get_calibration_data(struct device *dev,
 
 	/* Start with default values */
 	mt->adc_ge = 512;
+	mt->adc_oe = 512;
 	for (i = 0; i < mt->conf->num_sensors; i++)
 		mt->vts[i] = 260;
 	mt->degc_cali = 40;
@@ -920,10 +1024,20 @@ static int mtk_thermal_get_calibration_data(struct device *dev,
 		goto out;
 	}
 
-	if (mt->conf->version == MTK_THERMAL_V1)
+	switch (mt->conf->version) {
+	case MTK_THERMAL_V1:
 		ret = mtk_thermal_extract_efuse_v1(mt, buf);
-	else
+		break;
+	case MTK_THERMAL_V2:
 		ret = mtk_thermal_extract_efuse_v2(mt, buf);
+		break;
+	case MTK_THERMAL_V3:
+		ret = mtk_thermal_extract_efuse_v3(mt, buf);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
 
 	if (ret) {
 		dev_info(dev, "Device not calibrated, using default calibration values\n");
@@ -953,6 +1067,10 @@ static const struct of_device_id mtk_thermal_of_match[] = {
 		.compatible = "mediatek,mt7622-thermal",
 		.data = (void *)&mt7622_thermal_data,
 	},
+	{
+		.compatible = "mediatek,mt7986-thermal",
+		.data = (void *)&mt7986_thermal_data,
+	},
 	{
 		.compatible = "mediatek,mt8183-thermal",
 		.data = (void *)&mt8183_thermal_data,
@@ -1068,15 +1186,17 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 		goto err_disable_clk_auxadc;
 	}
 
-	if (mt->conf->version == MTK_THERMAL_V2) {
+	if (mt->conf->version != MTK_THERMAL_V1) {
 		mtk_thermal_turn_on_buffer(apmixed_base);
 		mtk_thermal_release_periodic_ts(mt, auxadc_base);
 	}
 
 	if (mt->conf->version == MTK_THERMAL_V1)
 		mt->raw_to_mcelsius = raw_to_mcelsius_v1;
-	else
+	else if (mt->conf->version == MTK_THERMAL_V2)
 		mt->raw_to_mcelsius = raw_to_mcelsius_v2;
+	else
+		mt->raw_to_mcelsius = raw_to_mcelsius_v3;
 
 	for (ctrl_id = 0; ctrl_id < mt->conf->num_controller ; ctrl_id++)
 		for (i = 0; i < mt->conf->num_banks; i++)
-- 
2.39.1

