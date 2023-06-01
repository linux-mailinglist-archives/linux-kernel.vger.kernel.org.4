Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 198A271A048
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 16:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234102AbjFAOgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 10:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234304AbjFAOf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 10:35:58 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735F9E59;
        Thu,  1 Jun 2023 07:35:25 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 351DVoeR026972;
        Thu, 1 Jun 2023 14:35:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=kxLRDQdPZnbg9t1qi33zyS+kkQehrhxlvDPCOdAwb5o=;
 b=OnyFGo33hkbpAcCYL/Nvn1y4++c3edvrEYpyFso3BULbCPNHsKoIHBMfuJGbEy7EoHo6
 jnPbNVMIESl6/kKl+RYbTv1vTxX0T21yaPUAALUj4XPYxp2F+J9hTekpGlGn7XJhYiJf
 pREB9bR5Bdi9Z7WaNiOoyQeHZJ1tSnzA6zIIAEfLuL5IYVC4VHInv897i8LD5Ly8WFkk
 M3P9rsi20i7eiuRIubS8JYvuJT1oCg4wSC7yPs/RImJg0z8VYiAlX93pm4e+ep5K8TDG
 NilBZW3i6VhTvP3vmkk0PY43AwhnBIuZpDgRIIH1BIHFXjgPDUWHobjyUHmUHWVXnWVC Bw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qxnwv18te-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jun 2023 14:35:20 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 351EZJj3015976
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Jun 2023 14:35:19 GMT
Received: from hu-jkona-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 1 Jun 2023 07:35:14 -0700
From:   Jagadeesh Kona <quic_jkona@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        "Satya Priya Kakitapalli" <quic_skakitap@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>
Subject: [PATCH V3 2/5] clk: qcom: Remove support to set CAL_L field in lucid evo pll configure
Date:   Thu, 1 Jun 2023 20:04:27 +0530
Message-ID: <20230601143430.5595-3-quic_jkona@quicinc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601143430.5595-1-quic_jkona@quicinc.com>
References: <20230601143430.5595-1-quic_jkona@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: EzMpEdVyv6x3ZlCo1bCovgEP-Ju1lvHj
X-Proofpoint-ORIG-GUID: EzMpEdVyv6x3ZlCo1bCovgEP-Ju1lvHj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_08,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 suspectscore=0
 bulkscore=0 clxscore=1015 malwarescore=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306010128
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For lucid evo and ole pll's the CAL_L, RINGOSC_CAL_L and L_VAL are
part of the same register, hence update the l configuration value
to include these fields across all the chipsets.

Since the l configuration value now includes both L and CAL_L fields,
there is no need to explicitly set CAL_L field again in lucid evo pll
configure, Hence remove support to explicity set CAL_L field for evo pll.

Fixes: 260e36606a03 ("clk: qcom: clk-alpha-pll: add Lucid EVO PLL configuration interfaces")
Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
---
Changes since V2:
 - Squashed update L val and remove explicit cal_l configuration to single patch
 - Updated L configuration for gpucc-sm8450 as well which was merged recently
Changes since V1:
 - Newly added.

 drivers/clk/qcom/camcc-sm8450.c  | 24 ++++++++++++++++--------
 drivers/clk/qcom/clk-alpha-pll.c |  6 +-----
 drivers/clk/qcom/dispcc-sm8450.c |  6 ++++--
 drivers/clk/qcom/dispcc-sm8550.c |  6 ++++--
 drivers/clk/qcom/gpucc-sa8775p.c |  6 ++++--
 drivers/clk/qcom/gpucc-sm8450.c  |  6 ++++--
 6 files changed, 33 insertions(+), 21 deletions(-)

diff --git a/drivers/clk/qcom/camcc-sm8450.c b/drivers/clk/qcom/camcc-sm8450.c
index 51338a2884d2..6a5a08f88598 100644
--- a/drivers/clk/qcom/camcc-sm8450.c
+++ b/drivers/clk/qcom/camcc-sm8450.c
@@ -57,7 +57,8 @@ static const struct pll_vco rivian_evo_vco[] = {
 static const struct clk_parent_data pll_parent_data_tcxo = { .index = DT_BI_TCXO };
 
 static const struct alpha_pll_config cam_cc_pll0_config = {
-	.l = 0x3e,
+	/* .l includes CAL_L_VAL, L_VAL fields */
+	.l = 0x0044003e,
 	.alpha = 0x8000,
 	.config_ctl_val = 0x20485699,
 	.config_ctl_hi_val = 0x00182261,
@@ -128,7 +129,8 @@ static struct clk_alpha_pll_postdiv cam_cc_pll0_out_odd = {
 };
 
 static const struct alpha_pll_config cam_cc_pll1_config = {
-	.l = 0x25,
+	/* .l includes CAL_L_VAL, L_VAL fields */
+	.l = 0x00440025,
 	.alpha = 0xeaaa,
 	.config_ctl_val = 0x20485699,
 	.config_ctl_hi_val = 0x00182261,
@@ -199,7 +201,8 @@ static struct clk_alpha_pll cam_cc_pll2 = {
 };
 
 static const struct alpha_pll_config cam_cc_pll3_config = {
-	.l = 0x2d,
+	/* .l includes CAL_L_VAL, L_VAL fields */
+	.l = 0x0044002d,
 	.alpha = 0x0,
 	.config_ctl_val = 0x20485699,
 	.config_ctl_hi_val = 0x00182261,
@@ -247,7 +250,8 @@ static struct clk_alpha_pll_postdiv cam_cc_pll3_out_even = {
 };
 
 static const struct alpha_pll_config cam_cc_pll4_config = {
-	.l = 0x2d,
+	/* .l includes CAL_L_VAL, L_VAL fields */
+	.l = 0x0044002d,
 	.alpha = 0x0,
 	.config_ctl_val = 0x20485699,
 	.config_ctl_hi_val = 0x00182261,
@@ -295,7 +299,8 @@ static struct clk_alpha_pll_postdiv cam_cc_pll4_out_even = {
 };
 
 static const struct alpha_pll_config cam_cc_pll5_config = {
-	.l = 0x2d,
+	/* .l includes CAL_L_VAL, L_VAL fields */
+	.l = 0x0044002d,
 	.alpha = 0x0,
 	.config_ctl_val = 0x20485699,
 	.config_ctl_hi_val = 0x00182261,
@@ -343,7 +348,8 @@ static struct clk_alpha_pll_postdiv cam_cc_pll5_out_even = {
 };
 
 static const struct alpha_pll_config cam_cc_pll6_config = {
-	.l = 0x2d,
+	/* .l includes CAL_L_VAL, L_VAL fields */
+	.l = 0x0044002d,
 	.alpha = 0x0,
 	.config_ctl_val = 0x20485699,
 	.config_ctl_hi_val = 0x00182261,
@@ -391,7 +397,8 @@ static struct clk_alpha_pll_postdiv cam_cc_pll6_out_even = {
 };
 
 static const struct alpha_pll_config cam_cc_pll7_config = {
-	.l = 0x2d,
+	/* .l includes CAL_L_VAL, L_VAL fields */
+	.l = 0x0044002d,
 	.alpha = 0x0,
 	.config_ctl_val = 0x20485699,
 	.config_ctl_hi_val = 0x00182261,
@@ -439,7 +446,8 @@ static struct clk_alpha_pll_postdiv cam_cc_pll7_out_even = {
 };
 
 static const struct alpha_pll_config cam_cc_pll8_config = {
-	.l = 0x32,
+	/* .l includes CAL_L_VAL, L_VAL fields */
+	.l = 0x00440032,
 	.alpha = 0x0,
 	.config_ctl_val = 0x20485699,
 	.config_ctl_hi_val = 0x00182261,
diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
index f81c7c561352..68a80395997b 100644
--- a/drivers/clk/qcom/clk-alpha-pll.c
+++ b/drivers/clk/qcom/clk-alpha-pll.c
@@ -270,7 +270,6 @@ EXPORT_SYMBOL_GPL(clk_alpha_pll_regs);
 #define LUCID_EVO_PCAL_NOT_DONE		BIT(8)
 #define LUCID_EVO_ENABLE_VOTE_RUN       BIT(25)
 #define LUCID_EVO_PLL_L_VAL_MASK        GENMASK(15, 0)
-#define LUCID_EVO_PLL_CAL_L_VAL_SHIFT	16
 
 /* ZONDA PLL specific */
 #define ZONDA_PLL_OUT_MASK	0xf
@@ -2084,10 +2083,7 @@ EXPORT_SYMBOL_GPL(clk_alpha_pll_zonda_ops);
 void clk_lucid_evo_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
 				 const struct alpha_pll_config *config)
 {
-	u32 lval = config->l;
-
-	lval |= TRION_PLL_CAL_VAL << LUCID_EVO_PLL_CAL_L_VAL_SHIFT;
-	clk_alpha_pll_write_config(regmap, PLL_L_VAL(pll), lval);
+	clk_alpha_pll_write_config(regmap, PLL_L_VAL(pll), config->l);
 	clk_alpha_pll_write_config(regmap, PLL_ALPHA_VAL(pll), config->alpha);
 	clk_alpha_pll_write_config(regmap, PLL_CONFIG_CTL(pll), config->config_ctl_val);
 	clk_alpha_pll_write_config(regmap, PLL_CONFIG_CTL_U(pll), config->config_ctl_hi_val);
diff --git a/drivers/clk/qcom/dispcc-sm8450.c b/drivers/clk/qcom/dispcc-sm8450.c
index adbfd30bfc96..293eae670a23 100644
--- a/drivers/clk/qcom/dispcc-sm8450.c
+++ b/drivers/clk/qcom/dispcc-sm8450.c
@@ -76,7 +76,8 @@ static struct pll_vco lucid_evo_vco[] = {
 };
 
 static const struct alpha_pll_config disp_cc_pll0_config = {
-	.l = 0xD,
+	/* .l includes CAL_L_VAL, L_VAL fields */
+	.l = 0x0044000d,
 	.alpha = 0x6492,
 	.config_ctl_val = 0x20485699,
 	.config_ctl_hi_val = 0x00182261,
@@ -103,7 +104,8 @@ static struct clk_alpha_pll disp_cc_pll0 = {
 };
 
 static const struct alpha_pll_config disp_cc_pll1_config = {
-	.l = 0x1F,
+	/* .l includes CAL_L_VAL, L_VAL fields */
+	.l = 0x0044001f,
 	.alpha = 0x4000,
 	.config_ctl_val = 0x20485699,
 	.config_ctl_hi_val = 0x00182261,
diff --git a/drivers/clk/qcom/dispcc-sm8550.c b/drivers/clk/qcom/dispcc-sm8550.c
index 1e5a11081860..b0d4c623731d 100644
--- a/drivers/clk/qcom/dispcc-sm8550.c
+++ b/drivers/clk/qcom/dispcc-sm8550.c
@@ -76,7 +76,8 @@ static struct pll_vco lucid_ole_vco[] = {
 };
 
 static const struct alpha_pll_config disp_cc_pll0_config = {
-	.l = 0xd,
+	/* .l includes RINGOSC_CAL_L_VAL, CAL_L_VAL, L_VAL fields */
+	.l = 0x4444000d,
 	.alpha = 0x6492,
 	.config_ctl_val = 0x20485699,
 	.config_ctl_hi_val = 0x00182261,
@@ -103,7 +104,8 @@ static struct clk_alpha_pll disp_cc_pll0 = {
 };
 
 static const struct alpha_pll_config disp_cc_pll1_config = {
-	.l = 0x1f,
+	/* .l includes RINGOSC_CAL_L_VAL, CAL_L_VAL, L_VAL fields */
+	.l = 0x4444001f,
 	.alpha = 0x4000,
 	.config_ctl_val = 0x20485699,
 	.config_ctl_hi_val = 0x00182261,
diff --git a/drivers/clk/qcom/gpucc-sa8775p.c b/drivers/clk/qcom/gpucc-sa8775p.c
index 18d23be8d435..153bf6ecb795 100644
--- a/drivers/clk/qcom/gpucc-sa8775p.c
+++ b/drivers/clk/qcom/gpucc-sa8775p.c
@@ -46,7 +46,8 @@ static const struct pll_vco lucid_evo_vco[] = {
 
 /* 810MHz configuration */
 static struct alpha_pll_config gpu_cc_pll0_config = {
-	.l = 0x2a,
+	/* .l includes CAL_L_VAL, L_VAL fields */
+	.l = 0x0044002a,
 	.alpha = 0x3000,
 	.config_ctl_val = 0x20485699,
 	.config_ctl_hi_val = 0x00182261,
@@ -72,7 +73,8 @@ static struct clk_alpha_pll gpu_cc_pll0 = {
 
 /* 1000MHz configuration */
 static struct alpha_pll_config gpu_cc_pll1_config = {
-	.l = 0x34,
+	/* .l includes CAL_L_VAL, L_VAL fields */
+	.l = 0x00440034,
 	.alpha = 0x1555,
 	.config_ctl_val = 0x20485699,
 	.config_ctl_hi_val = 0x00182261,
diff --git a/drivers/clk/qcom/gpucc-sm8450.c b/drivers/clk/qcom/gpucc-sm8450.c
index 16c0381b3087..dddfda880202 100644
--- a/drivers/clk/qcom/gpucc-sm8450.c
+++ b/drivers/clk/qcom/gpucc-sm8450.c
@@ -40,7 +40,8 @@ static struct pll_vco lucid_evo_vco[] = {
 };
 
 static struct alpha_pll_config gpu_cc_pll0_config = {
-	.l = 0x1d,
+	/* .l includes CAL_L_VAL, L_VAL fields */
+	.l = 0x0044001d,
 	.alpha = 0xb000,
 	.config_ctl_val = 0x20485699,
 	.config_ctl_hi_val = 0x00182261,
@@ -67,7 +68,8 @@ static struct clk_alpha_pll gpu_cc_pll0 = {
 };
 
 static struct alpha_pll_config gpu_cc_pll1_config = {
-	.l = 0x34,
+	/* .l includes CAL_L_VAL, L_VAL fields */
+	.l = 0x00440034,
 	.alpha = 0x1555,
 	.config_ctl_val = 0x20485699,
 	.config_ctl_hi_val = 0x00182261,
-- 
2.40.1

