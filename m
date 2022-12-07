Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1E764621B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 21:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbiLGUHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 15:07:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiLGUHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 15:07:18 -0500
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC00686BC;
        Wed,  7 Dec 2022 12:07:17 -0800 (PST)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.94.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1p30hA-0001li-Ox; Wed, 07 Dec 2022 21:07:08 +0100
Date:   Wed, 7 Dec 2022 20:07:01 +0000
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
Subject: [PATCH v3] thermal: mediatek: add support for MT7986 and MT7981
Message-ID: <e7122cc9ae519394cba9eeb50b650484686b7bc4.1670442987.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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
SDK sources (but cleaned up and de-duplicated).

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
This patch depends on series
"thermal: mediatek: Add support for MT8365 SoC"[1] being merged first.

Changes since v2: Rebase on top of pending patch introducing
raw_to_mcelsius function pointer.
Drop left-over macro extracting the unused adc_oe field.
Use switch (...) instead of if-else-if-else-... statements.
For now, return -EINVAL as default in case of unknown version. Imho
this should be BUG(), as this version is only defined within this
driver.

Changes since v1: Drop use of adc_oe field in efuse, Henry Yen
confirmed its use has been dropped intentionally in MTK SDK as well.

[1]: https://lore.kernel.org/linux-arm-kernel/4121bb6b-30db-7a23-f4c8-40afdda7a0b5@linaro.org/T/

 drivers/thermal/mtk_thermal.c | 149 ++++++++++++++++++++++++++++++++--
 1 file changed, 142 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
index b1f4d19edd4f..4993ed6d3e21 100644
--- a/drivers/thermal/mtk_thermal.c
+++ b/drivers/thermal/mtk_thermal.c
@@ -151,6 +151,20 @@
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
@@ -164,6 +178,7 @@ enum {
 enum mtk_thermal_version {
 	MTK_THERMAL_V1 = 1,
 	MTK_THERMAL_V2,
+	MTK_THERMAL_V3,
 };
 
 /* MT2701 thermal sensors */
@@ -257,6 +272,27 @@ enum mtk_thermal_version {
 #define MT8365_TS2 1
 #define MT8365_TS3 2
 
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
 
 struct mtk_thermal_zone {
@@ -426,6 +462,14 @@ static const int mt8365_tc_offset[MT8365_NUM_CONTROLLER] = { 0 };
 
 static const int mt8365_vts_index[MT8365_NUM_SENSORS] = { VTS1, VTS2, VTS3 };
 
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
@@ -626,6 +670,30 @@ static const struct mtk_thermal_data mt8183_thermal_data = {
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
  * raw_to_mcelsius - convert a raw ADC value to mcelsius
  * @mt:	The thermal controller
@@ -680,6 +748,22 @@ static int raw_to_mcelsius_v2(struct mtk_thermal *mt, int sensno, s32 raw)
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
@@ -989,6 +1072,25 @@ static int mtk_thermal_extract_efuse_v2(struct mtk_thermal *mt, u32 *buf)
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
@@ -1024,10 +1126,23 @@ static int mtk_thermal_get_calibration_data(struct device *dev,
 		goto out;
 	}
 
-	if (mt->conf->version == MTK_THERMAL_V1)
+	switch (mt->conf->version) {
+	case MTK_THERMAL_V1:
 		ret = mtk_thermal_extract_efuse_v1(mt, buf);
-	else
+		break;
+
+	case MTK_THERMAL_V2:
 		ret = mtk_thermal_extract_efuse_v2(mt, buf);
+		break;
+
+	case MTK_THERMAL_V3:
+		ret = mtk_thermal_extract_efuse_v3(mt, buf);
+		break;
+
+	default:
+		ret = -EINVAL;
+		break;
+	}
 
 	if (ret) {
 		dev_info(dev, "Device not calibrated, using default calibration values\n");
@@ -1057,6 +1172,10 @@ static const struct of_device_id mtk_thermal_of_match[] = {
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
@@ -1181,12 +1300,28 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 		goto err_disable_clk_auxadc;
 	}
 
-	mtk_thermal_turn_on_buffer(mt, apmixed_base);
+	switch (mt->conf->version) {
+	case MTK_THERMAL_V1:
+		mt->raw_to_mcelsius = raw_to_mcelsius_v1;
+		break;
+
+	case MTK_THERMAL_V2:
+		mt->raw_to_mcelsius = raw_to_mcelsius_v2;
+		break;
 
-	mt->raw_to_mcelsius = (mt->conf->version == MTK_THERMAL_V1) ?
-				raw_to_mcelsius_v1 : raw_to_mcelsius_v2;
+	case MTK_THERMAL_V3:
+		mt->raw_to_mcelsius = raw_to_mcelsius_v3;
+		break;
+
+	default:
+		ret = -EINVAL;
+		goto err_disable_clk_peri_therm;
+	}
+
+	mtk_thermal_turn_on_buffer(mt, apmixed_base);
 
-	if (mt->conf->version == MTK_THERMAL_V2) {
+	if (mt->conf->version == MTK_THERMAL_V2 ||
+	    mt->conf->version == MTK_THERMAL_V3) {
 		mtk_thermal_release_periodic_ts(mt, auxadc_base);
 	}
 
-- 
2.38.1

