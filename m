Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96FE46BD8FB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 20:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjCPTWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 15:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjCPTWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 15:22:34 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E2F6700A;
        Thu, 16 Mar 2023 12:22:14 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32GFP6i3032319;
        Thu, 16 Mar 2023 19:22:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=RRxY15SlGGOlnRMN/BOYobVD1oYCTe7VuJE4qAyxm+0=;
 b=WM3Vh/FCe3gNXLUZLDS7PdiEPZoVRsj73fSH24Q+1BYW3CcKPNR+GzKxys1w2qwzcsEq
 gStzeGmmP/0wafrUoZmEah4Hx7AKtRne4ITUKJcAc+Wn9v6/kX+4odzaARuJ4NIfF++2
 eUONfGvMkgdUROpJPo4qe9CBuqAN+PAxEHbv6ig38ZXJTD102ybhU68LwtdIvxEmlrky
 1EuUjalPhNGJGNi2/3q+AW8hhiOGAjRA8quhfm/saxhjiVYzsZs8Q+px3KJdEBmix+30
 pJ/A7H/Q4UZ7uAbqwx6nvkmYUXQyp/08pPceEMd1A3OIPVTfXjCfMAnC0T1Bs8k836PR fg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pc5r18kxn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Mar 2023 19:22:08 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32GJM7Zx019577
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Mar 2023 19:22:07 GMT
Received: from hu-amelende-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 16 Mar 2023 12:22:07 -0700
From:   Anjelique Melendez <quic_amelende@quicinc.com>
To:     <pavel@ucw.cz>, <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <andersson@kernel.org>
CC:     <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_c_skakit@quicinc.com>,
        "Anjelique Melendez" <quic_amelende@quicinc.com>
Subject: [PATCH 2/3] leds: rgb: leds-qcom-lpg: Add support for high resolution PWM
Date:   Thu, 16 Mar 2023 12:21:33 -0700
Message-ID: <20230316192134.26436-3-quic_amelende@quicinc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230316192134.26436-1-quic_amelende@quicinc.com>
References: <20230316192134.26436-1-quic_amelende@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vuLxp_f648UWwSLtxL7EYXJ7oU34PeKJ
X-Proofpoint-ORIG-GUID: vuLxp_f648UWwSLtxL7EYXJ7oU34PeKJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-16_12,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 mlxscore=0 clxscore=1015 mlxlogscore=998 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303160146
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Certain PMICs like PMK8550 have a high resolution PWM module which can
support from 8-bit to 15-bit PWM. Add support for it.

Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
---
 drivers/leds/rgb/leds-qcom-lpg.c | 142 ++++++++++++++++++++++---------
 1 file changed, 100 insertions(+), 42 deletions(-)

diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
index 67f48f222109..534ca4c0dea4 100644
--- a/drivers/leds/rgb/leds-qcom-lpg.c
+++ b/drivers/leds/rgb/leds-qcom-lpg.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (c) 2017-2022 Linaro Ltd
  * Copyright (c) 2010-2012, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 #include <linux/bits.h>
 #include <linux/bitfield.h>
@@ -17,10 +18,13 @@
 #define LPG_SUBTYPE_REG		0x05
 #define  LPG_SUBTYPE_LPG	0x2
 #define  LPG_SUBTYPE_PWM	0xb
+#define  LPG_SUBTYPE_HI_RES_PWM	0xc
 #define  LPG_SUBTYPE_LPG_LITE	0x11
 #define LPG_PATTERN_CONFIG_REG	0x40
 #define LPG_SIZE_CLK_REG	0x41
 #define  PWM_CLK_SELECT_MASK	GENMASK(1, 0)
+#define  PWM_CLK_SELECT_HI_RES_MASK	GENMASK(2, 0)
+#define  PWM_SIZE_HI_RES_MASK	GENMASK(6, 4)
 #define LPG_PREDIV_CLK_REG	0x42
 #define  PWM_FREQ_PRE_DIV_MASK	GENMASK(6, 5)
 #define  PWM_FREQ_EXP_MASK	GENMASK(2, 0)
@@ -43,8 +47,10 @@
 #define LPG_LUT_REG(x)		(0x40 + (x) * 2)
 #define RAMP_CONTROL_REG	0xc8
 
-#define LPG_RESOLUTION		512
+#define LPG_RESOLUTION		BIT(9)
+#define LPG_RESOLUTION_HI_RES	BIT(15)
 #define LPG_MAX_M		7
+#define LPG_MAX_PREDIV		6
 
 struct lpg_channel;
 struct lpg_data;
@@ -106,6 +112,7 @@ struct lpg {
  * @clk_sel:	reference clock frequency selector
  * @pre_div_sel: divider selector of the reference clock
  * @pre_div_exp: exponential divider of the reference clock
+ * @pwm_size_sel:	pwm size selector
  * @ramp_enabled: duty cycle is driven by iterating over lookup table
  * @ramp_ping_pong: reverse through pattern, rather than wrapping to start
  * @ramp_oneshot: perform only a single pass over the pattern
@@ -138,6 +145,7 @@ struct lpg_channel {
 	unsigned int clk_sel;
 	unsigned int pre_div_sel;
 	unsigned int pre_div_exp;
+	unsigned int pwm_size_sel;
 
 	bool ramp_enabled;
 	bool ramp_ping_pong;
@@ -253,17 +261,24 @@ static int lpg_lut_sync(struct lpg *lpg, unsigned int mask)
 }
 
 static const unsigned int lpg_clk_rates[] = {0, 1024, 32768, 19200000};
+static const unsigned int lpg_clk_rates_hi_res[] = {0, 1024, 32768, 19200000, 76800000};
 static const unsigned int lpg_pre_divs[] = {1, 3, 5, 6};
+static const unsigned int lpg_pwm_size[] =  {9};
+static const unsigned int lpg_pwm_size_hi_res[] =  {8, 9, 10, 11, 12, 13, 14, 15};
 
 static int lpg_calc_freq(struct lpg_channel *chan, uint64_t period)
 {
-	unsigned int clk_sel, best_clk = 0;
+	unsigned int i, pwm_size_len, best_pwm_size_sel = 0;
+	const unsigned int *clk_rate_arr, *pwm_size_arr;
+	unsigned int clk_sel, clk_len, best_clk = 0;
 	unsigned int div, best_div = 0;
 	unsigned int m, best_m = 0;
+	unsigned int resolution;
 	unsigned int error;
 	unsigned int best_err = UINT_MAX;
 	u64 best_period = 0;
 	u64 max_period;
+	u64 max_res;
 
 	/*
 	 * The PWM period is determined by:
@@ -272,73 +287,104 @@ static int lpg_calc_freq(struct lpg_channel *chan, uint64_t period)
 	 * period = --------------------------
 	 *                   refclk
 	 *
-	 * With resolution fixed at 2^9 bits, pre_div = {1, 3, 5, 6} and
+	 * Resolution = 2^9 bits for PWM or
+	 *              2^{8, 9, 10, 11, 12, 13, 14, 15} bits for high resolution PWM
+	 * pre_div = {1, 3, 5, 6} and
 	 * M = [0..7].
 	 *
-	 * This allows for periods between 27uS and 384s, as the PWM framework
-	 * wants a period of equal or lower length than requested, reject
-	 * anything below 27uS.
+	 * This allows for periods between 27uS and 384s for PWM channels and periods between
+	 * 3uS and 24576s for high resolution PWMs.
+	 * The PWM framework wants a period of equal or lower length than requested,
+	 * reject anything below minimum period.
 	 */
-	if (period <= (u64)NSEC_PER_SEC * LPG_RESOLUTION / 19200000)
+
+	if (chan->subtype == LPG_SUBTYPE_HI_RES_PWM) {
+		clk_rate_arr = lpg_clk_rates_hi_res;
+		clk_len = ARRAY_SIZE(lpg_clk_rates_hi_res);
+		pwm_size_arr = lpg_pwm_size_hi_res;
+		pwm_size_len = ARRAY_SIZE(lpg_pwm_size_hi_res);
+		max_res = LPG_RESOLUTION_HI_RES;
+	} else {
+		clk_rate_arr = lpg_clk_rates;
+		clk_len = ARRAY_SIZE(lpg_clk_rates);
+		pwm_size_arr = lpg_pwm_size;
+		pwm_size_len = ARRAY_SIZE(lpg_pwm_size);
+		max_res = LPG_RESOLUTION;
+	}
+
+	if (period <= (u64)NSEC_PER_SEC * (1 << pwm_size_arr[0]) / clk_rate_arr[clk_len - 1])
 		return -EINVAL;
 
 	/* Limit period to largest possible value, to avoid overflows */
-	max_period = (u64)NSEC_PER_SEC * LPG_RESOLUTION * 6 * (1 << LPG_MAX_M) / 1024;
+	max_period = (u64)NSEC_PER_SEC * max_res * LPG_MAX_PREDIV * (1 << LPG_MAX_M) / 1024;
 	if (period > max_period)
 		period = max_period;
 
 	/*
-	 * Search for the pre_div, refclk and M by solving the rewritten formula
-	 * for each refclk and pre_div value:
+	 * Search for the pre_div, refclk, resolution and M by solving the rewritten formula
+	 * for each refclk, resolution and pre_div value:
 	 *
 	 *                     period * refclk
 	 * M = log2 -------------------------------------
 	 *           NSEC_PER_SEC * pre_div * resolution
 	 */
-	for (clk_sel = 1; clk_sel < ARRAY_SIZE(lpg_clk_rates); clk_sel++) {
-		u64 numerator = period * lpg_clk_rates[clk_sel];
-
-		for (div = 0; div < ARRAY_SIZE(lpg_pre_divs); div++) {
-			u64 denominator = (u64)NSEC_PER_SEC * lpg_pre_divs[div] * LPG_RESOLUTION;
-			u64 actual;
-			u64 ratio;
-
-			if (numerator < denominator)
-				continue;
-
-			ratio = div64_u64(numerator, denominator);
-			m = ilog2(ratio);
-			if (m > LPG_MAX_M)
-				m = LPG_MAX_M;
-
-			actual = DIV_ROUND_UP_ULL(denominator * (1 << m), lpg_clk_rates[clk_sel]);
-
-			error = period - actual;
-			if (error < best_err) {
-				best_err = error;
 
-				best_div = div;
-				best_m = m;
-				best_clk = clk_sel;
-				best_period = actual;
+	for (i = 0; i < pwm_size_len; i++) {
+		resolution = 1 << pwm_size_arr[i];
+		for (clk_sel = 1; clk_sel < clk_len; clk_sel++) {
+			u64 numerator = period * clk_rate_arr[clk_sel];
+
+			for (div = 0; div < ARRAY_SIZE(lpg_pre_divs); div++) {
+				u64 denominator = (u64)NSEC_PER_SEC * lpg_pre_divs[div] *
+						  resolution;
+				u64 actual;
+				u64 ratio;
+
+				if (numerator < denominator)
+					continue;
+
+				ratio = div64_u64(numerator, denominator);
+				m = ilog2(ratio);
+				if (m > LPG_MAX_M)
+					m = LPG_MAX_M;
+
+				actual = DIV_ROUND_UP_ULL(denominator * (1 << m),
+							  clk_rate_arr[clk_sel]);
+				error = period - actual;
+				if (error < best_err) {
+					best_err = error;
+					best_div = div;
+					best_m = m;
+					best_clk = clk_sel;
+					best_period = actual;
+					best_pwm_size_sel = i;
+				}
 			}
 		}
 	}
-
 	chan->clk_sel = best_clk;
 	chan->pre_div_sel = best_div;
 	chan->pre_div_exp = best_m;
 	chan->period = best_period;
-
+	chan->pwm_size_sel = best_pwm_size_sel;
 	return 0;
 }
 
 static void lpg_calc_duty(struct lpg_channel *chan, uint64_t duty)
 {
-	unsigned int max = LPG_RESOLUTION - 1;
+	unsigned int max;
 	unsigned int val;
+	unsigned int clk_rate;
+
+	if (chan->subtype == LPG_SUBTYPE_HI_RES_PWM) {
+		max = LPG_RESOLUTION_HI_RES - 1;
+		clk_rate = lpg_clk_rates_hi_res[chan->clk_sel];
+	} else {
+		max = LPG_RESOLUTION - 1;
+		clk_rate = lpg_clk_rates[chan->clk_sel];
+	}
 
-	val = div64_u64(duty * lpg_clk_rates[chan->clk_sel],
+	val = div64_u64(duty * clk_rate,
 			(u64)NSEC_PER_SEC * lpg_pre_divs[chan->pre_div_sel] * (1 << chan->pre_div_exp));
 
 	chan->pwm_value = min(val, max);
@@ -354,7 +400,7 @@ static void lpg_apply_freq(struct lpg_channel *chan)
 
 	val = chan->clk_sel;
 
-	/* Specify 9bit resolution, based on the subtype of the channel */
+	/* Specify resolution, based on the subtype of the channel */
 	switch (chan->subtype) {
 	case LPG_SUBTYPE_LPG:
 		val |= GENMASK(5, 4);
@@ -362,6 +408,9 @@ static void lpg_apply_freq(struct lpg_channel *chan)
 	case LPG_SUBTYPE_PWM:
 		val |= BIT(2);
 		break;
+	case LPG_SUBTYPE_HI_RES_PWM:
+		val |= FIELD_PREP(PWM_SIZE_HI_RES_MASK, chan->pwm_size_sel);
+		break;
 	case LPG_SUBTYPE_LPG_LITE:
 	default:
 		val |= BIT(4);
@@ -977,6 +1026,7 @@ static int lpg_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 {
 	struct lpg *lpg = container_of(chip, struct lpg, pwm);
 	struct lpg_channel *chan = &lpg->channels[pwm->hwpwm];
+	unsigned int pwm_size;
 	unsigned int pre_div;
 	unsigned int refclk;
 	unsigned int val;
@@ -988,7 +1038,14 @@ static int lpg_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (ret)
 		return ret;
 
-	refclk = lpg_clk_rates[val & PWM_CLK_SELECT_MASK];
+	if (chan->subtype == LPG_SUBTYPE_HI_RES_PWM) {
+		refclk = lpg_clk_rates_hi_res[FIELD_GET(PWM_CLK_SELECT_HI_RES_MASK, val)];
+		pwm_size = lpg_pwm_size_hi_res[FIELD_GET(PWM_SIZE_HI_RES_MASK, val)];
+	} else {
+		refclk = lpg_clk_rates[FIELD_GET(PWM_CLK_SELECT_MASK, val)];
+		pwm_size = 9;
+	}
+
 	if (refclk) {
 		ret = regmap_read(lpg->map, chan->base + LPG_PREDIV_CLK_REG, &val);
 		if (ret)
@@ -1001,7 +1058,8 @@ static int lpg_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 		if (ret)
 			return ret;
 
-		state->period = DIV_ROUND_UP_ULL((u64)NSEC_PER_SEC * LPG_RESOLUTION * pre_div * (1 << m), refclk);
+		state->period = DIV_ROUND_UP_ULL((u64)NSEC_PER_SEC * (1 << pwm_size) *
+						 pre_div * (1 << m), refclk);
 		state->duty_cycle = DIV_ROUND_UP_ULL((u64)NSEC_PER_SEC * pwm_value * pre_div * (1 << m), refclk);
 	} else {
 		state->period = 0;
-- 
2.39.0

