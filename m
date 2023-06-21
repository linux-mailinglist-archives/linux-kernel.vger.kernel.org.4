Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9F2B738F83
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 21:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbjFUTBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 15:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbjFUTBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 15:01:24 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3D019AF;
        Wed, 21 Jun 2023 12:01:15 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35LHtGD4024028;
        Wed, 21 Jun 2023 19:01:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=akQ9QEQoqbutkjlrjiBqJmRXYROOKQGiFl//a5RKGkU=;
 b=gPD9qlpbJEHNEEz+taluWwVp4DO+yEQhssxfX5oYRk6aZUow86y4oAkA0hGag6FnH7o8
 yVJdH/nLn8Ff44rn8PXfh0AI6v4uUfAWIJwulcfDKHPGN3MHRo0sXXjzv4R3RLzWtlNp
 czRAHSOL9eIqWI/E6pgtAKHP41A1Q5VT5PIq6xR+DQVvCjXKwdO/zrzqwCnnCbpFkll0
 HjY10IKoSP8rI4iL/iFSh9ceQoJ8JF1uSZKTZowVY4FoxVV6g2OHnDlsKzMXMZcUcc9I
 C7DiveIqxQC7HDLXLNHobWxA5W15+4Qnjz+BBhndSYZWhov4wPayWG5AVvjX/T/8vBgt qQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rbvr1hkhe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 19:01:07 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35LJ16kr026837
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 19:01:06 GMT
Received: from hu-amelende-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 21 Jun 2023 12:01:05 -0700
From:   Anjelique Melendez <quic_amelende@quicinc.com>
To:     <pavel@ucw.cz>, <lee@kernel.org>, <thierry.reding@gmail.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <agross@kernel.org>, <andersson@kernel.org>
CC:     <konrad.dybcio@linaro.org>, <u.kleine-koenig@pengutronix.de>,
        <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>,
        Anjelique Melendez <quic_amelende@quicinc.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>
Subject: [PATCH 6/7] leds: rgb: leds-qcom-lpg: Support two-nvmem PPG Scheme
Date:   Wed, 21 Jun 2023 11:59:50 -0700
Message-ID: <20230621185949.2068-7-quic_amelende@quicinc.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230621185949.2068-1-quic_amelende@quicinc.com>
References: <20230621185949.2068-1-quic_amelende@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: XEpbdcmkysnXx3maq5-r_Vxnn9cpv5GE
X-Proofpoint-ORIG-GUID: XEpbdcmkysnXx3maq5-r_Vxnn9cpv5GE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_11,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 impostorscore=0 phishscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306210158
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On PMICs such as PM8350C, the lookup table containing the pattern data
is stored in a separate nvmem device from the one where the per-channel
data is stored.

Add support for two separate nvmems to handle this case while maintaining
backward compatibility for those targets that use only a single nvmem
device.

Signed-off-by: Guru Das Srinagesh <quic_gurus@quicinc.com>
Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
---
 drivers/leds/rgb/leds-qcom-lpg.c | 112 ++++++++++++++++++++++++-------
 1 file changed, 89 insertions(+), 23 deletions(-)

diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
index ac814a509781..273cb81260e7 100644
--- a/drivers/leds/rgb/leds-qcom-lpg.c
+++ b/drivers/leds/rgb/leds-qcom-lpg.c
@@ -60,6 +60,7 @@
 #define RAMP_STEP_DURATION(x)		(((x) * 1000 / DEFAULT_TICK_DURATION_US) & 0xff)
 
 /* LPG common config settings for PPG */
+#define SDAM_START_BASE			0x40
 #define SDAM_REG_RAMP_STEP_DURATION		0x47
 #define SDAM_LUT_COUNT_MAX			64
 
@@ -69,6 +70,8 @@
 #define SDAM_END_INDEX_OFFSET			0x3
 #define SDAM_START_INDEX_OFFSET		0x4
 #define SDAM_PBS_SCRATCH_LUT_COUNTER_OFFSET	0x6
+#define SDAM_PAUSE_HI_MULTIPLIER_OFFSET	0x8
+#define SDAM_PAUSE_LO_MULTIPLIER_OFFSET	0x9
 
 struct lpg_channel;
 struct lpg_data;
@@ -85,7 +88,9 @@ struct lpg_data;
  * @lut_bitmap:	allocation bitmap for LUT entries
  * @pbs_dev:	PBS client device
  * @lpg_chan_nvmem:	LPG nvmem peripheral device
+ * @lut_nvmem:	LUT nvmem peripheral device
  * @pbs_en_bitmap:	bitmap for tracking PBS triggers
+ * @nvmem_count:	number of nvmems used for LUT and PPG config
  * @lut_sdam_base:	offset where LUT pattern begins in nvmem
  * @ppg_en:	Flag indicating whether PPG is enabled/used
  * @triled_base:	base address of the TRILED block (optional)
@@ -111,7 +116,9 @@ struct lpg {
 
 	struct pbs_dev *pbs_dev;
 	struct nvmem_device *lpg_chan_nvmem;
+	struct nvmem_device *lut_nvmem;
 	unsigned long pbs_en_bitmap;
+	unsigned int nvmem_count;
 	u32 lut_sdam_base;
 	bool ppg_en;
 
@@ -261,6 +268,8 @@ static int lpg_sdam_write(struct lpg *lpg, u16 addr, u8 val)
 }
 
 #define SDAM_REG_PBS_SEQ_EN		0x42
+#define SDAM_PBS_TRIG_SET		0xe5
+#define SDAM_PBS_TRIG_CLR		0xe6
 #define PBS_SW_TRIG_BIT		BIT(0)
 
 static int lpg_clear_pbs_trigger(struct lpg_channel *chan)
@@ -272,6 +281,12 @@ static int lpg_clear_pbs_trigger(struct lpg_channel *chan)
 		rc = lpg_sdam_write(chan->lpg, SDAM_REG_PBS_SEQ_EN, 0);
 		if (rc < 0)
 			return rc;
+
+		if (chan->lpg->nvmem_count == 2) {
+			rc = lpg_sdam_write(chan->lpg, SDAM_PBS_TRIG_CLR, PBS_SW_TRIG_BIT);
+			if (rc < 0)
+				return rc;
+		}
 	}
 
 	return 0;
@@ -286,9 +301,15 @@ static int lpg_set_pbs_trigger(struct lpg_channel *chan)
 		if (rc < 0)
 			return rc;
 
-		rc = qcom_pbs_trigger_event(chan->lpg->pbs_dev, PBS_SW_TRIG_BIT);
-		if (rc < 0)
-			return rc;
+		if (chan->lpg->nvmem_count == 1) {
+			rc = qcom_pbs_trigger_event(chan->lpg->pbs_dev, PBS_SW_TRIG_BIT);
+			if (rc < 0)
+				return rc;
+		} else {
+			rc = lpg_sdam_write(chan->lpg, SDAM_PBS_TRIG_SET, PBS_SW_TRIG_BIT);
+			if (rc < 0)
+				return rc;
+		}
 	}
 	set_bit(chan->lpg_idx, &chan->lpg->pbs_en_bitmap);
 
@@ -342,7 +363,12 @@ static int lpg_lut_store_sdam(struct lpg *lpg, struct led_pattern *pattern,
 	for (i = 0; i < len; i++) {
 		brightness = pattern[i].brightness;
 		addr = lpg->lut_sdam_base + i + idx;
-		rc = lpg_sdam_write(lpg, addr, brightness);
+
+		if (lpg->nvmem_count == 1)
+			rc = lpg_sdam_write(lpg, addr, brightness);
+		else
+			rc = nvmem_device_write(lpg->lut_nvmem, addr, 1, &brightness);
+
 		if (rc < 0)
 			return rc;
 	}
@@ -601,24 +627,48 @@ static void lpg_apply_pwm_value(struct lpg_channel *chan)
 #define LPG_PATTERN_CONFIG_PAUSE_HI	BIT(1)
 #define LPG_PATTERN_CONFIG_PAUSE_LO	BIT(0)
 
+static u8 lpg_get_sdam_lut_idx(struct lpg_channel *chan, u8 idx)
+{
+	if (chan->lpg->nvmem_count == 2)
+		return chan->lpg->lut_sdam_base - SDAM_START_BASE + idx;
+	return idx;
+}
+
 static void lpg_sdam_apply_lut_control(struct lpg_channel *chan)
 {
 	u8 val, conf = 0;
+	unsigned int hi_pause, lo_pause;
 	struct lpg *lpg = chan->lpg;
 
+	hi_pause = DIV_ROUND_UP(chan->ramp_hi_pause_ms, chan->ramp_tick_ms);
+	lo_pause = DIV_ROUND_UP(chan->ramp_lo_pause_ms, chan->ramp_tick_ms);
+
 	if (!chan->ramp_oneshot)
 		conf |= LPG_PATTERN_CONFIG_REPEAT;
+	if (chan->ramp_hi_pause_ms && lpg->nvmem_count != 1)
+		conf |= LPG_PATTERN_CONFIG_PAUSE_HI;
+	if (chan->ramp_lo_pause_ms && lpg->nvmem_count != 1)
+		conf |= LPG_PATTERN_CONFIG_PAUSE_LO;
 
 	lpg_sdam_write(lpg, SDAM_PBS_SCRATCH_LUT_COUNTER_OFFSET + chan->sdam_offset, 0);
 	lpg_sdam_write(lpg, SDAM_PATTERN_CONFIG_OFFSET + chan->sdam_offset, conf);
 
-	lpg_sdam_write(lpg, SDAM_END_INDEX_OFFSET + chan->sdam_offset, chan->pattern_hi_idx);
-	lpg_sdam_write(lpg, SDAM_START_INDEX_OFFSET + chan->sdam_offset, chan->pattern_lo_idx);
+	val = lpg_get_sdam_lut_idx(chan, chan->pattern_hi_idx);
+	lpg_sdam_write(lpg, SDAM_END_INDEX_OFFSET + chan->sdam_offset, val);
+
+	val = lpg_get_sdam_lut_idx(chan, chan->pattern_lo_idx);
+	lpg_sdam_write(lpg, SDAM_START_INDEX_OFFSET + chan->sdam_offset, val);
 
 	val = RAMP_STEP_DURATION(chan->ramp_tick_ms);
 	if (val > 0)
 		val--;
 	lpg_sdam_write(lpg, SDAM_REG_RAMP_STEP_DURATION, val);
+
+	if (lpg->nvmem_count != 1) {
+		lpg_sdam_write(lpg, SDAM_PAUSE_HI_MULTIPLIER_OFFSET + chan->sdam_offset, hi_pause);
+		lpg_sdam_write(lpg, SDAM_PAUSE_LO_MULTIPLIER_OFFSET + chan->sdam_offset, lo_pause);
+	}
+
 }
 
 static void lpg_apply_lut_control(struct lpg_channel *chan)
@@ -1000,8 +1050,8 @@ static int lpg_pattern_set(struct lpg_led *led, struct led_pattern *led_pattern,
 	 * enabled. In this scenario the delta_t of the middle entry (i.e. the
 	 * last in the programmed pattern) determines the "high pause".
 	 *
-	 * NVMEM devices supporting LUT do not support "low pause", "high pause"
-	 * or "ping pong"
+	 * All NVMEM devices supporting LUT do not support "ping pong"
+	 * Single NVMEM devices supporting LUT do not support "low pause" and "high pause"
 	 */
 
 	/* Detect palindromes and use "ping pong" to reduce LUT usage */
@@ -1028,7 +1078,7 @@ static int lpg_pattern_set(struct lpg_led *led, struct led_pattern *led_pattern,
 	 * Validate that all delta_t in the pattern are the same, with the
 	 * exception of the middle element in case of ping_pong.
 	 */
-	if (lpg->ppg_en) {
+	if (lpg->nvmem_count == 1) {
 		i = 1;
 		delta_t = pattern[0].delta_t;
 	} else {
@@ -1042,7 +1092,7 @@ static int lpg_pattern_set(struct lpg_led *led, struct led_pattern *led_pattern,
 			 * Allow last entry in the full or shortened pattern to
 			 * specify hi pause. Reject other variations.
 			 */
-			if (i != actual_len - 1 || lpg->ppg_en)
+			if (i != actual_len - 1 || lpg->nvmem_count == 1)
 				goto out_free_pattern;
 		}
 	}
@@ -1051,8 +1101,8 @@ static int lpg_pattern_set(struct lpg_led *led, struct led_pattern *led_pattern,
 	if (delta_t >= BIT(9))
 		goto out_free_pattern;
 
-	/* Find "low pause" and "high pause" in the pattern if not an NVMEM device*/
-	if (!lpg->ppg_en) {
+	/* Find "low pause" and "high pause" in the pattern if not a single NVMEM device*/
+	if (lpg->nvmem_count != 1) {
 		lo_pause = pattern[0].delta_t;
 		hi_pause = pattern[actual_len - 1].delta_t;
 	}
@@ -1509,29 +1559,45 @@ static int lpg_parse_sdam(struct lpg *lpg)
 {
 	int rc = 0;
 
-	if (lpg->data->nvmem_count == 0)
+	lpg->nvmem_count = lpg->data->nvmem_count;
+	if (lpg->nvmem_count == 0)
 		return 0;
 
-	/* get the nvmem device for LPG/LUT config */
+	if (lpg->nvmem_count > 2)
+		return -EINVAL;
+
+	/* get the 1st nvmem device for LPG/LUT config */
 	lpg->lpg_chan_nvmem = devm_nvmem_device_get(lpg->dev, "lpg_chan_sdam");
 	if (IS_ERR(lpg->lpg_chan_nvmem)) {
 		rc = PTR_ERR(lpg->lpg_chan_nvmem);
-		if (rc != -EPROBE_DEFER)
-			dev_err(lpg->dev, "Failed to get nvmem device, rc=%d\n", rc);
-		return rc;
+		goto err;
 	}
 
-	lpg->pbs_dev = get_pbs_client_device(lpg->dev);
-	if (IS_ERR(lpg->pbs_dev)) {
-		rc = PTR_ERR(lpg->pbs_dev);
-		if (rc != -EPROBE_DEFER)
-			dev_err(lpg->dev, "Failed to get PBS client device, rc=%d\n", rc);
-		return rc;
+	if (lpg->nvmem_count == 1) {
+		/* get PBS device node if single NVMEM device */
+		lpg->pbs_dev = get_pbs_client_device(lpg->dev);
+		if (IS_ERR(lpg->pbs_dev)) {
+			rc = PTR_ERR(lpg->pbs_dev);
+			if (rc != -EPROBE_DEFER)
+				dev_err(lpg->dev, "Failed to get PBS client device, rc=%d\n", rc);
+			return rc;
+		}
+	} else if (lpg->nvmem_count == 2) {
+		/* get the 2nd nvmem device for LUT pattern */
+		lpg->lut_nvmem = devm_nvmem_device_get(lpg->dev, "lut_sdam");
+		if (IS_ERR(lpg->lut_nvmem)) {
+			rc = PTR_ERR(lpg->lut_nvmem);
+			goto err;
+		}
 	}
 
 	lpg->ppg_en = true;
 
 	return rc;
+err:
+	if (rc != -EPROBE_DEFER)
+		dev_err(lpg->dev, "Failed to get nvmem device, rc=%d\n", rc);
+	return rc;
 }
 
 static int lpg_init_sdam(struct lpg *lpg)
-- 
2.40.0

