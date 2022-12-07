Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD7364650B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 00:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbiLGX0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 18:26:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiLGX0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 18:26:14 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141848930F;
        Wed,  7 Dec 2022 15:26:13 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B7NAWZt008943;
        Wed, 7 Dec 2022 23:26:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=Cgt3fdZmNLERHrjukVY2m0H3nHmNMpuE6vEmF6iAatc=;
 b=ZFJZl6KQ2ySi7syN/H2LCHNXaYUs+55B+y1GK1LY4Gfo0oYU3oxpJjG7Aa08o6/8DILB
 P1/jcOYO618SRz59pz7Jzc+r60umT07Fql78JxvL1SNMf0niqAPxkuPiDCIcOxDN9hcO
 KmtqgVu/nAIv60zIpfRizq6P1WHDPN0yQUzwiN190LiH9w+X6iNjdDkaMQyQn6HEcle4
 OYwa3pnrEbMafeIhQgqjeK5GPm4jVEUUusOSuJR0DKMf7dZZCiSTES8/u/1gE9lTJEH6
 Ug4cNkQqyeJYcicaNPU6xUWLjbjrXgv+enAEzzECDrLjSoDZyQfe2eX0XVMUVdJTlaJv lA== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mahgp2qs1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Dec 2022 23:26:04 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2B7NQ2ZH013780
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 7 Dec 2022 23:26:02 GMT
Received: from hu-collinsd-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 7 Dec 2022 15:26:02 -0800
From:   David Collins <quic_collinsd@quicinc.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     David Collins <quic_collinsd@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Zhang Rui <rui.zhang@intel.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/3] thermal: qcom-spmi-temp-alarm: add support for GEN2 rev 2 PMIC peripherals
Date:   Wed, 7 Dec 2022 15:24:57 -0800
Message-ID: <f5b213e07da293fdc11894ba4dfa75fba1b7472e.1670454176.git.quic_collinsd@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1670454176.git.quic_collinsd@quicinc.com>
References: <cover.1670454176.git.quic_collinsd@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jBWEX_CS0WmyhnuLyWTOKoh-TuI4musO
X-Proofpoint-ORIG-GUID: jBWEX_CS0WmyhnuLyWTOKoh-TuI4musO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-07_11,2022-12-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 mlxscore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212070198
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for TEMP_ALARM GEN2 PMIC peripherals with digital
major revision 2.  This revision utilizes individual registers
to set the threshold temperature for over-temperature stages 1,
2, and 3 instead of a single register to specify a set of
thresholds.

Signed-off-by: David Collins <quic_collinsd@quicinc.com>
---
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 162 +++++++++++++++++++-
 1 file changed, 156 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
index 895a2d7bff02..a8b288de6b52 100644
--- a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
+++ b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
@@ -26,6 +26,10 @@
 #define QPNP_TM_REG_STATUS		0x08
 #define QPNP_TM_REG_SHUTDOWN_CTRL1	0x40
 #define QPNP_TM_REG_ALARM_CTRL		0x46
+/* TEMP_DAC_* registers are only present for TEMP_GEN2 v2.0 */
+#define QPNP_TM_REG_TEMP_DAC_STG1	0x47
+#define QPNP_TM_REG_TEMP_DAC_STG2	0x48
+#define QPNP_TM_REG_TEMP_DAC_STG3	0x49
 
 #define QPNP_TM_TYPE			0x09
 #define QPNP_TM_SUBTYPE_GEN1		0x08
@@ -67,6 +71,25 @@ static const long temp_map_gen2_v1[THRESH_COUNT][STAGE_COUNT] = {
 
 #define TEMP_STAGE_HYSTERESIS		2000
 
+/*
+ * For TEMP_GEN2 v2.0, TEMP_DAC_STG1/2/3 registers are used to set the threshold
+ * for each stage independently.
+ * TEMP_DAC_STG* = 0 --> 80 C
+ * Each 8 step increase in TEMP_DAC_STG* value corresponds to 5 C (5000 mC).
+ */
+#define TEMP_DAC_MIN			80000
+#define TEMP_DAC_SCALE_NUM		8
+#define TEMP_DAC_SCALE_DEN		5000
+
+#define TEMP_DAC_TEMP_TO_REG(temp) \
+	(((temp) - TEMP_DAC_MIN) * TEMP_DAC_SCALE_NUM / TEMP_DAC_SCALE_DEN)
+#define TEMP_DAC_REG_TO_TEMP(reg) \
+	(TEMP_DAC_MIN + (reg) * TEMP_DAC_SCALE_DEN / TEMP_DAC_SCALE_NUM)
+
+static const long temp_dac_max[STAGE_COUNT] = {
+	119375, 159375, 159375
+};
+
 /* Temperature in Milli Celsius reported during stage 0 if no ADC is present */
 #define DEFAULT_TEMP			37000
 
@@ -87,6 +110,9 @@ struct qpnp_tm_chip {
 
 	struct iio_channel		*adc;
 	const long			(*temp_map)[THRESH_COUNT][STAGE_COUNT];
+
+	bool				has_temp_dac;
+	long				temp_dac_map[STAGE_COUNT];
 };
 
 /* This array maps from GEN2 alarm state to GEN1 alarm stage */
@@ -120,6 +146,13 @@ static int qpnp_tm_write(struct qpnp_tm_chip *chip, u16 addr, u8 data)
  */
 static long qpnp_tm_decode_temp(struct qpnp_tm_chip *chip, unsigned int stage)
 {
+	if (chip->has_temp_dac) {
+		if (stage == 0 || stage > STAGE_COUNT)
+			return 0;
+
+		return chip->temp_dac_map[stage - 1];
+	}
+
 	if (!chip->temp_map || chip->thresh >= THRESH_COUNT || stage == 0 ||
 	    stage > STAGE_COUNT)
 		return 0;
@@ -221,6 +254,34 @@ static int qpnp_tm_get_temp(struct thermal_zone_device *tz, int *temp)
 	return 0;
 }
 
+static int qpnp_tm_set_temp_dac_thresh(struct qpnp_tm_chip *chip, int trip,
+				       int temp)
+{
+	int ret, temp_cfg;
+	u8 reg;
+
+	if (trip < 0 || trip >= STAGE_COUNT) {
+		dev_err(chip->dev, "invalid TEMP_DAC trip = %d\n", trip);
+		return -EINVAL;
+	} else if (temp < TEMP_DAC_MIN || temp > temp_dac_max[trip]) {
+		dev_err(chip->dev, "invalid TEMP_DAC temp = %d\n", temp);
+		return -EINVAL;
+	}
+
+	reg = TEMP_DAC_TEMP_TO_REG(temp);
+	temp_cfg = TEMP_DAC_REG_TO_TEMP(reg);
+
+	ret = qpnp_tm_write(chip, QPNP_TM_REG_TEMP_DAC_STG1 + trip, reg);
+	if (ret < 0) {
+		dev_err(chip->dev, "TEMP_DAC_STG write failed, ret=%d\n", ret);
+		return ret;
+	}
+
+	chip->temp_dac_map[trip] = temp_cfg;
+
+	return 0;
+}
+
 static int qpnp_tm_update_critical_trip_temp(struct qpnp_tm_chip *chip,
 					     int temp)
 {
@@ -308,6 +369,24 @@ static const struct thermal_zone_device_ops qpnp_tm_sensor_ops = {
 	.set_trip_temp = qpnp_tm_set_trip_temp,
 };
 
+static int qpnp_tm_set_temp_dac_trip_temp(struct thermal_zone_device *tz,
+					  int trip, int temp)
+{
+	struct qpnp_tm_chip *chip = tz->devdata;
+	int ret;
+
+	mutex_lock(&chip->lock);
+	ret = qpnp_tm_set_temp_dac_thresh(chip, trip, temp);
+	mutex_unlock(&chip->lock);
+
+	return ret;
+}
+
+static const struct thermal_zone_device_ops qpnp_tm_sensor_temp_dac_ops = {
+	.get_temp = qpnp_tm_get_temp,
+	.set_trip_temp = qpnp_tm_set_temp_dac_trip_temp,
+};
+
 static irqreturn_t qpnp_tm_isr(int irq, void *data)
 {
 	struct qpnp_tm_chip *chip = data;
@@ -340,6 +419,60 @@ static int qpnp_tm_get_critical_trip_temp(struct qpnp_tm_chip *chip)
 	return THERMAL_TEMP_INVALID;
 }
 
+/* Configure TEMP_DAC registers based on DT thermal_zone trips */
+static int qpnp_tm_temp_dac_update_trip_temps(struct qpnp_tm_chip *chip)
+{
+	const struct thermal_trip *trips;
+	int ret, ntrips, i;
+
+	ntrips = of_thermal_get_ntrips(chip->tz_dev);
+	/* Keep hardware defaults if no DT trips are defined. */
+	if (ntrips <= 0)
+		return 0;
+
+	trips = of_thermal_get_trip_points(chip->tz_dev);
+	if (!trips)
+		return -EINVAL;
+
+	for (i = 0; i < ntrips; i++) {
+		if (of_thermal_is_trip_valid(chip->tz_dev, i)) {
+			ret = qpnp_tm_set_temp_dac_thresh(chip, i,
+							  trips[i].temperature);
+			if (ret < 0)
+				return ret;
+		}
+	}
+
+	/* Verify that trips are strictly increasing. */
+	for (i = 1; i < STAGE_COUNT; i++) {
+		if (chip->temp_dac_map[i] <= chip->temp_dac_map[i - 1]) {
+			dev_err(chip->dev, "Threshold %d=%ld <= threshold %d=%ld\n",
+				i, chip->temp_dac_map[i], i - 1,
+				chip->temp_dac_map[i - 1]);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+/* Read the hardware default TEMP_DAC stage threshold temperatures */
+static int qpnp_tm_temp_dac_init(struct qpnp_tm_chip *chip)
+{
+	int ret, i;
+	u8 reg = 0;
+
+	for (i = 0; i < STAGE_COUNT; i++) {
+		ret = qpnp_tm_read(chip, QPNP_TM_REG_TEMP_DAC_STG1 + i, &reg);
+		if (ret < 0)
+			return ret;
+
+		chip->temp_dac_map[i] = TEMP_DAC_REG_TO_TEMP(reg);
+	}
+
+	return 0;
+}
+
 /*
  * This function initializes the internal temp value based on only the
  * current thermal stage and threshold. Setup threshold control and
@@ -372,10 +505,16 @@ static int qpnp_tm_init(struct qpnp_tm_chip *chip)
 	if (stage)
 		chip->temp = qpnp_tm_decode_temp(chip, stage);
 
-	crit_temp = qpnp_tm_get_critical_trip_temp(chip);
-	ret = qpnp_tm_update_critical_trip_temp(chip, crit_temp);
-	if (ret < 0)
-		goto out;
+	if (chip->has_temp_dac) {
+		ret = qpnp_tm_temp_dac_update_trip_temps(chip);
+		if (ret < 0)
+			goto out;
+	} else {
+		crit_temp = qpnp_tm_get_critical_trip_temp(chip);
+		ret = qpnp_tm_update_critical_trip_temp(chip, crit_temp);
+		if (ret < 0)
+			goto out;
+	}
 
 	/* Enable the thermal alarm PMIC module in always-on mode. */
 	reg = ALARM_CTRL_FORCE_ENABLE;
@@ -392,6 +531,7 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 {
 	struct qpnp_tm_chip *chip;
 	struct device_node *node;
+	const struct thermal_zone_device_ops *ops;
 	u8 type, subtype, dig_major, dig_minor;
 	u32 res;
 	int ret, irq;
@@ -463,19 +603,29 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	ops = &qpnp_tm_sensor_ops;
 	chip->subtype = subtype;
-	if (subtype == QPNP_TM_SUBTYPE_GEN2 && dig_major >= 1)
+	if (subtype == QPNP_TM_SUBTYPE_GEN2 && dig_major >= 2)
+		chip->has_temp_dac = true;
+	else if (subtype == QPNP_TM_SUBTYPE_GEN2 && dig_major >= 1)
 		chip->temp_map = &temp_map_gen2_v1;
 	else
 		chip->temp_map = &temp_map_gen1;
 
+	if (chip->has_temp_dac) {
+		ops = &qpnp_tm_sensor_temp_dac_ops;
+		ret = qpnp_tm_temp_dac_init(chip);
+		if (ret < 0)
+			return ret;
+	}
+
 	/*
 	 * Register the sensor before initializing the hardware to be able to
 	 * read the trip points. get_temp() returns the default temperature
 	 * before the hardware initialization is completed.
 	 */
 	chip->tz_dev = devm_thermal_of_zone_register(
-		&pdev->dev, 0, chip, &qpnp_tm_sensor_ops);
+		&pdev->dev, 0, chip, ops);
 	if (IS_ERR(chip->tz_dev)) {
 		dev_err(&pdev->dev, "failed to register sensor\n");
 		return PTR_ERR(chip->tz_dev);
-- 
2.25.1

