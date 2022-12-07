Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6F36451BE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 03:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiLGCFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 21:05:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbiLGCFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 21:05:37 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2B054343;
        Tue,  6 Dec 2022 18:05:33 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B6Nwv8b007363;
        Wed, 7 Dec 2022 02:05:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=Gg+YEv7cB1pdzmHUU3gSL/k7WR0qVRrmi/i2KVESApc=;
 b=Kvm7fBphPphCOqTaq4bYIZRC2zRP1arAsWMAIAcM4zHnkBzCjgNROLelQC9R5N5ruGyC
 GK5hM/73HbwAU1WNqLGavGLhjOYGJeuygDcVjiFjVWyeGqxVkyhqJqbg3kyV88A+qAYF
 XaP07S+nis9g63Dm/gTyhXB9dP+D/SEy3eu0rCfqMdlxK09JuFZMQrRDfLT5H/v4uo41
 XZoMPdC0JFSPNqINqrEbVWMGaaZlboERXRzvW5znGSD2e9U0e+BqupPV/eVeDDw8V8ek
 HVsenX3FEPTA3VSdfJyEbO4ZRxXRhudI/BkdPFVOfUQiAFNdhXVCA1saiJpp8xKXsvCH 7w== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ma4y6a8rd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Dec 2022 02:05:25 +0000
Received: from nasanex01b.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2B725Oqf000508
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 7 Dec 2022 02:05:24 GMT
Received: from hu-collinsd-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 6 Dec 2022 18:05:23 -0800
From:   David Collins <quic_collinsd@quicinc.com>
To:     Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     David Collins <quic_collinsd@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/3] thermal: qcom-spmi-temp-alarm: add support for LITE PMIC peripherals
Date:   Tue, 6 Dec 2022 18:04:46 -0800
Message-ID: <fa5b6b7a88b23f3efb15f4da4a2fdfa6e6d57cb2.1670375556.git.quic_collinsd@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1670375556.git.quic_collinsd@quicinc.com>
References: <cover.1670375556.git.quic_collinsd@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: mijaInQCdo-akfN5e3E7ZTZu_QmNMGgs
X-Proofpoint-GUID: mijaInQCdo-akfN5e3E7ZTZu_QmNMGgs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-06_12,2022-12-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 phishscore=0 clxscore=1015 spamscore=0 adultscore=0
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212070009
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for TEMP_ALARM LITE PMIC peripherals.  This subtype
utilizes a pair of registers to configure a warning interrupt
threshold temperature and an automatic hardware shutdown
threshold temperature.

Signed-off-by: David Collins <quic_collinsd@quicinc.com>
---
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 216 +++++++++++++++++++-
 1 file changed, 207 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
index a8b288de6b52..212e6e9865d5 100644
--- a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
+++ b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
@@ -24,21 +24,28 @@
 #define QPNP_TM_REG_TYPE		0x04
 #define QPNP_TM_REG_SUBTYPE		0x05
 #define QPNP_TM_REG_STATUS		0x08
+#define QPNP_TM_REG_IRQ_STATUS		0x10
 #define QPNP_TM_REG_SHUTDOWN_CTRL1	0x40
 #define QPNP_TM_REG_ALARM_CTRL		0x46
 /* TEMP_DAC_* registers are only present for TEMP_GEN2 v2.0 */
 #define QPNP_TM_REG_TEMP_DAC_STG1	0x47
 #define QPNP_TM_REG_TEMP_DAC_STG2	0x48
 #define QPNP_TM_REG_TEMP_DAC_STG3	0x49
+#define QPNP_TM_REG_LITE_TEMP_CFG1	0x50
+#define QPNP_TM_REG_LITE_TEMP_CFG2	0x51
 
 #define QPNP_TM_TYPE			0x09
 #define QPNP_TM_SUBTYPE_GEN1		0x08
 #define QPNP_TM_SUBTYPE_GEN2		0x09
+#define QPNP_TM_SUBTYPE_LITE		0xC0
 
 #define STATUS_GEN1_STAGE_MASK		GENMASK(1, 0)
 #define STATUS_GEN2_STATE_MASK		GENMASK(6, 4)
 #define STATUS_GEN2_STATE_SHIFT		4
 
+/* IRQ status only needed for TEMP_ALARM_LITE */
+#define IRQ_STATUS_MASK			BIT(0)
+
 #define SHUTDOWN_CTRL1_OVERRIDE_S2	BIT(6)
 #define SHUTDOWN_CTRL1_THRESHOLD_MASK	GENMASK(1, 0)
 
@@ -46,6 +53,8 @@
 
 #define ALARM_CTRL_FORCE_ENABLE		BIT(7)
 
+#define LITE_TEMP_CFG_THRESHOLD_MASK	GENMASK(3, 2)
+
 #define THRESH_COUNT			4
 #define STAGE_COUNT			3
 
@@ -90,6 +99,19 @@ static const long temp_dac_max[STAGE_COUNT] = {
 	119375, 159375, 159375
 };
 
+/*
+ * TEMP_ALARM_LITE has two stages: warning and shutdown with independently
+ * configured threshold temperatures.
+ */
+
+static const long temp_map_lite_warning[THRESH_COUNT] = {
+	115000, 125000, 135000, 145000
+};
+
+static const long temp_map_lite_shutdown[THRESH_COUNT] = {
+	135000, 145000, 160000, 175000
+};
+
 /* Temperature in Milli Celsius reported during stage 0 if no ADC is present */
 #define DEFAULT_TEMP			37000
 
@@ -146,7 +168,7 @@ static int qpnp_tm_write(struct qpnp_tm_chip *chip, u16 addr, u8 data)
  */
 static long qpnp_tm_decode_temp(struct qpnp_tm_chip *chip, unsigned int stage)
 {
-	if (chip->has_temp_dac) {
+	if (chip->has_temp_dac || chip->subtype == QPNP_TM_SUBTYPE_LITE) {
 		if (stage == 0 || stage > STAGE_COUNT)
 			return 0;
 
@@ -164,19 +186,26 @@ static long qpnp_tm_decode_temp(struct qpnp_tm_chip *chip, unsigned int stage)
  * qpnp_tm_get_temp_stage() - return over-temperature stage
  * @chip:		Pointer to the qpnp_tm chip
  *
- * Return: stage (GEN1) or state (GEN2) on success, or errno on failure.
+ * Return: stage (GEN1), state (GEN2), or alarm interrupt state (LITE) on
+ *	   success; or errno on failure.
  */
 static int qpnp_tm_get_temp_stage(struct qpnp_tm_chip *chip)
 {
 	int ret;
+	u16 addr = QPNP_TM_REG_STATUS;
 	u8 reg = 0;
 
-	ret = qpnp_tm_read(chip, QPNP_TM_REG_STATUS, &reg);
+	if (chip->subtype == QPNP_TM_SUBTYPE_LITE)
+		addr = QPNP_TM_REG_IRQ_STATUS;
+
+	ret = qpnp_tm_read(chip, addr, &reg);
 	if (ret < 0)
 		return ret;
 
 	if (chip->subtype == QPNP_TM_SUBTYPE_GEN1)
 		ret = reg & STATUS_GEN1_STAGE_MASK;
+	else if (chip->subtype == QPNP_TM_SUBTYPE_LITE)
+		ret = reg & IRQ_STATUS_MASK;
 	else
 		ret = (reg & STATUS_GEN2_STATE_MASK) >> STATUS_GEN2_STATE_SHIFT;
 
@@ -199,7 +228,8 @@ static int qpnp_tm_update_temp_no_adc(struct qpnp_tm_chip *chip)
 		return ret;
 	stage = ret;
 
-	if (chip->subtype == QPNP_TM_SUBTYPE_GEN1) {
+	if (chip->subtype == QPNP_TM_SUBTYPE_GEN1
+	    || chip->subtype == QPNP_TM_SUBTYPE_LITE) {
 		stage_new = stage;
 		stage_old = chip->stage;
 	} else {
@@ -282,6 +312,78 @@ static int qpnp_tm_set_temp_dac_thresh(struct qpnp_tm_chip *chip, int trip,
 	return 0;
 }
 
+static int qpnp_tm_set_temp_lite_thresh(struct qpnp_tm_chip *chip, int trip,
+				       int temp)
+{
+	int ret, temp_cfg, i;
+	const long *temp_map;
+	u16 addr;
+	u8 reg, thresh;
+
+	if (trip < 0 || trip >= STAGE_COUNT) {
+		dev_err(chip->dev, "invalid TEMP_LITE trip = %d\n", trip);
+		return -EINVAL;
+	}
+
+	switch (trip) {
+	case 0:
+		temp_map = temp_map_lite_warning;
+		addr = QPNP_TM_REG_LITE_TEMP_CFG1;
+		break;
+	case 1:
+		/*
+		 * The second trip point is purely in software to facilitate
+		 * a controlled shutdown after the warning threshold is crossed
+		 * but before the automatic hardware shutdown threshold is
+		 * crossed.
+		 */
+		return 0;
+	case 2:
+		temp_map = temp_map_lite_shutdown;
+		addr = QPNP_TM_REG_LITE_TEMP_CFG2;
+		break;
+	default:
+		return 0;
+	}
+
+	if (temp < temp_map[THRESH_MIN] || temp > temp_map[THRESH_MAX]) {
+		dev_err(chip->dev, "invalid TEMP_LITE temp = %d\n", temp);
+		return -EINVAL;
+	}
+
+	thresh = 0;
+	temp_cfg = temp_map[thresh];
+	for (i = THRESH_MAX; i >= THRESH_MIN; i--) {
+		if (temp >= temp_map[i]) {
+			thresh = i;
+			temp_cfg = temp_map[i];
+			break;
+		}
+	}
+
+	if (temp_cfg == chip->temp_dac_map[trip])
+		return 0;
+
+	ret = qpnp_tm_read(chip, addr, &reg);
+	if (ret < 0) {
+		dev_err(chip->dev, "LITE_TEMP_CFG read failed, ret=%d\n", ret);
+		return ret;
+	}
+
+	reg &= ~LITE_TEMP_CFG_THRESHOLD_MASK;
+	reg |= FIELD_PREP(LITE_TEMP_CFG_THRESHOLD_MASK, thresh);
+
+	ret = qpnp_tm_write(chip, addr, reg);
+	if (ret < 0) {
+		dev_err(chip->dev, "LITE_TEMP_CFG write failed, ret=%d\n", ret);
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
@@ -387,6 +489,24 @@ static const struct thermal_zone_device_ops qpnp_tm_sensor_temp_dac_ops = {
 	.set_trip_temp = qpnp_tm_set_temp_dac_trip_temp,
 };
 
+static int qpnp_tm_set_temp_lite_trip_temp(struct thermal_zone_device *tz,
+					   int trip, int temp)
+{
+	struct qpnp_tm_chip *chip = tz->devdata;
+	int ret;
+
+	mutex_lock(&chip->lock);
+	ret = qpnp_tm_set_temp_lite_thresh(chip, trip, temp);
+	mutex_unlock(&chip->lock);
+
+	return ret;
+}
+
+static const struct thermal_zone_device_ops qpnp_tm_sensor_temp_lite_ops = {
+	.get_temp = qpnp_tm_get_temp,
+	.set_trip_temp = qpnp_tm_set_temp_lite_trip_temp,
+};
+
 static irqreturn_t qpnp_tm_isr(int irq, void *data)
 {
 	struct qpnp_tm_chip *chip = data;
@@ -473,6 +593,71 @@ static int qpnp_tm_temp_dac_init(struct qpnp_tm_chip *chip)
 	return 0;
 }
 
+/* Configure TEMP_LITE registers based on DT thermal_zone trips */
+static int qpnp_tm_temp_lite_update_trip_temps(struct qpnp_tm_chip *chip)
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
+			ret = qpnp_tm_set_temp_lite_thresh(chip, i,
+							  trips[i].temperature);
+			if (ret < 0)
+				return ret;
+		}
+	}
+
+	/* Verify that trips are strictly increasing. */
+	if (chip->temp_dac_map[2] <= chip->temp_dac_map[0]) {
+		dev_err(chip->dev, "Threshold 2=%ld <= threshold 0=%ld\n",
+			chip->temp_dac_map[2], chip->temp_dac_map[0]);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/* Read the hardware default TEMP_LITE stage threshold temperatures */
+static int qpnp_tm_temp_lite_init(struct qpnp_tm_chip *chip)
+{
+	int ret, thresh;
+	u8 reg = 0;
+
+	/*
+	 * Store the warning trip temp in temp_dac_map[0] and the shutdown trip
+	 * temp in temp_dac_map[2].  The second trip point is purely in software
+	 * to facilitate a controlled shutdown after the warning threshold is
+	 * crossed but before the automatic hardware shutdown threshold is
+	 * crossed.  Thus, there is no register to read for the second trip
+	 * point.
+	 */
+	ret = qpnp_tm_read(chip, QPNP_TM_REG_LITE_TEMP_CFG1, &reg);
+	if (ret < 0)
+		return ret;
+
+	thresh = FIELD_GET(LITE_TEMP_CFG_THRESHOLD_MASK, reg);
+	chip->temp_dac_map[0] = temp_map_lite_warning[thresh];
+
+	ret = qpnp_tm_read(chip, QPNP_TM_REG_LITE_TEMP_CFG2, &reg);
+	if (ret < 0)
+		return ret;
+
+	thresh = FIELD_GET(LITE_TEMP_CFG_THRESHOLD_MASK, reg);
+	chip->temp_dac_map[2] = temp_map_lite_shutdown[thresh];
+
+	return 0;
+}
+
 /*
  * This function initializes the internal temp value based on only the
  * current thermal stage and threshold. Setup threshold control and
@@ -499,13 +684,18 @@ static int qpnp_tm_init(struct qpnp_tm_chip *chip)
 		goto out;
 	chip->stage = ret;
 
-	stage = chip->subtype == QPNP_TM_SUBTYPE_GEN1
-		? chip->stage : alarm_state_map[chip->stage];
+	stage = (chip->subtype == QPNP_TM_SUBTYPE_GEN1
+		 || chip->subtype == QPNP_TM_SUBTYPE_LITE)
+			? chip->stage : alarm_state_map[chip->stage];
 
 	if (stage)
 		chip->temp = qpnp_tm_decode_temp(chip, stage);
 
-	if (chip->has_temp_dac) {
+	if (chip->subtype == QPNP_TM_SUBTYPE_LITE) {
+		ret = qpnp_tm_temp_lite_update_trip_temps(chip);
+		if (ret < 0)
+			goto out;
+	} else if (chip->has_temp_dac) {
 		ret = qpnp_tm_temp_dac_update_trip_temps(chip);
 		if (ret < 0)
 			goto out;
@@ -597,7 +787,8 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 	chip->dig_revision = (dig_major << 8) | dig_minor;
 
 	if (type != QPNP_TM_TYPE || (subtype != QPNP_TM_SUBTYPE_GEN1
-				     && subtype != QPNP_TM_SUBTYPE_GEN2)) {
+				     && subtype != QPNP_TM_SUBTYPE_GEN2
+				     && subtype != QPNP_TM_SUBTYPE_LITE)) {
 		dev_err(&pdev->dev, "invalid type 0x%02x or subtype 0x%02x\n",
 			type, subtype);
 		return -ENODEV;
@@ -609,7 +800,7 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 		chip->has_temp_dac = true;
 	else if (subtype == QPNP_TM_SUBTYPE_GEN2 && dig_major >= 1)
 		chip->temp_map = &temp_map_gen2_v1;
-	else
+	else if (subtype == QPNP_TM_SUBTYPE_GEN1)
 		chip->temp_map = &temp_map_gen1;
 
 	if (chip->has_temp_dac) {
@@ -619,6 +810,13 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 			return ret;
 	}
 
+	if (chip->subtype == QPNP_TM_SUBTYPE_LITE) {
+		ops = &qpnp_tm_sensor_temp_lite_ops;
+		ret = qpnp_tm_temp_lite_init(chip);
+		if (ret < 0)
+			return ret;
+	}
+
 	/*
 	 * Register the sensor before initializing the hardware to be able to
 	 * read the trip points. get_temp() returns the default temperature
-- 
2.25.1

