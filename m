Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1AB8674F73
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 09:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjATI1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 03:27:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbjATI1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 03:27:00 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958938766C;
        Fri, 20 Jan 2023 00:26:58 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30K7m0rq007517;
        Fri, 20 Jan 2023 08:26:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=0bHqY0XOBrNrw4HPp6H3BH1/TLDxZOssORbD0W3AEEk=;
 b=gUwjPdywKG1b3Wo1rBhkornBJF3yj4SWiH6mJOocJJDhxSjwgSlIPNy7p1aI4KiyeVeh
 LlbLr9D2qKy/L+R9wLbtRXPGuBURcZJBeni1BgdjcjUg5FCM+gbEOZ+qAA/xPoyo3w2K
 oc7LjmSHLxV+BtaHCwlUfhdSujUtlBuRdK69J6p//oOT0DQ0ptMwT0nBO4sHLa8DCylb
 aSaziu9A+3HQu4hTs/KfwjjD+ZzepOsuRP/LBRxPcuIUBMjgf5IlxCQleF3r70QPIqHu
 r3FtnYOdh6i7c5lGn3p51aJGkYX/Iybmj90lx+sm/jDK2MsjSHYFWJxKLhq5NROVPCoh tw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n7c28h6v6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 08:26:54 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30K8Qrbk027471
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 08:26:53 GMT
Received: from kathirav-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 20 Jan 2023 00:26:49 -0800
From:   Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Varadarajan Narayanan <quic_varada@quicinc.com>,
        Sricharan R <quic_srichara@quicinc.com>,
        Kathiravan T <quic_kathirav@quicinc.com>
Subject: [PATCH V5] clk: qcom: clk-alpha-pll: Add support for Stromer PLLs
Date:   Fri, 20 Jan 2023 13:56:31 +0530
Message-ID: <20230120082631.22053-1-quic_kathirav@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kd7eZGDzSnrOHIGP7vcxpfRHDfuIqmYP
X-Proofpoint-ORIG-GUID: kd7eZGDzSnrOHIGP7vcxpfRHDfuIqmYP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_04,2023-01-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 mlxlogscore=999
 clxscore=1015 mlxscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301200079
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Varadarajan Narayanan <quic_varada@quicinc.com>

Add programming sequence support for managing the Stromer
PLLs.

Co-developed-by: Sricharan R <quic_srichara@quicinc.com>
Signed-off-by: Sricharan R <quic_srichara@quicinc.com>
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
---
Changes since V4:
	- Introduced a separate function clk_stromer_pll_configure()
	  instead of making changes in clk_alpha_pll_configure() - Stephen Boyd
	- Updated the copyright year to 2023 - Stephen Boyd
	- Minor changes - Stephen Boyd
	- Renamed the variables 'status_reg_val' and 'status_reg_mask'
	  to 'status_val' and 'status_mask' respectively

Changes since V3:
	- Updated the title with correct patch version

Changes since V2:
	- splitted this patch from IPQ5018 series[1]
	- Rebased on linux-6.2-rc1
[1]
https://lore.kernel.org/linux-arm-msm/20220621161126.15883-1-quic_srichara@quicinc.com/

 drivers/clk/qcom/clk-alpha-pll.c | 128 ++++++++++++++++++++++++++++++-
 drivers/clk/qcom/clk-alpha-pll.h |  13 +++-
 2 files changed, 139 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
index f9e4cfd7261c..d841ec414072 100644
--- a/drivers/clk/qcom/clk-alpha-pll.c
+++ b/drivers/clk/qcom/clk-alpha-pll.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2015, 2018, The Linux Foundation. All rights reserved.
- * Copyright (c) 2021, Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021, 2023, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/kernel.h>
@@ -204,6 +204,18 @@ const u8 clk_alpha_pll_regs[][PLL_OFF_MAX_REGS] = {
 		[PLL_OFF_CONFIG_CTL] = 0x1C,
 		[PLL_OFF_STATUS] = 0x20,
 	},
+	[CLK_ALPHA_PLL_TYPE_STROMER] = {
+		[PLL_OFF_L_VAL] = 0x08,
+		[PLL_OFF_ALPHA_VAL] = 0x10,
+		[PLL_OFF_ALPHA_VAL_U] = 0x14,
+		[PLL_OFF_USER_CTL] = 0x18,
+		[PLL_OFF_USER_CTL_U] = 0x1c,
+		[PLL_OFF_CONFIG_CTL] = 0x20,
+		[PLL_OFF_CONFIG_CTL_U] = 0xff,
+		[PLL_OFF_TEST_CTL] = 0x30,
+		[PLL_OFF_TEST_CTL_U] = 0x34,
+		[PLL_OFF_STATUS] = 0x28,
+	},
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_regs);
 
@@ -215,6 +227,8 @@ EXPORT_SYMBOL_GPL(clk_alpha_pll_regs);
 #define ALPHA_BITWIDTH		32U
 #define ALPHA_SHIFT(w)		min(w, ALPHA_BITWIDTH)
 
+#define	ALPHA_PLL_STATUS_REG_SHIFT	8
+
 #define PLL_HUAYRA_M_WIDTH		8
 #define PLL_HUAYRA_M_SHIFT		8
 #define PLL_HUAYRA_M_MASK		0xff
@@ -2324,3 +2338,115 @@ const struct clk_ops clk_alpha_pll_rivian_evo_ops = {
 	.round_rate = clk_rivian_evo_pll_round_rate,
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_rivian_evo_ops);
+
+void clk_stromer_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
+			       const struct alpha_pll_config *config)
+{
+	u32 val, val_u, mask, mask_u;
+
+	regmap_write(regmap, PLL_L_VAL(pll), config->l);
+	regmap_write(regmap, PLL_ALPHA_VAL(pll), config->alpha);
+	regmap_write(regmap, PLL_CONFIG_CTL(pll), config->config_ctl_val);
+
+	if (pll_has_64bit_config(pll))
+		regmap_write(regmap, PLL_CONFIG_CTL_U(pll),
+			     config->config_ctl_hi_val);
+
+	if (pll_alpha_width(pll) > 32)
+		regmap_write(regmap, PLL_ALPHA_VAL_U(pll), config->alpha_hi);
+
+	val = config->main_output_mask;
+	val |= config->aux_output_mask;
+	val |= config->aux2_output_mask;
+	val |= config->early_output_mask;
+	val |= config->pre_div_val;
+	val |= config->post_div_val;
+	val |= config->vco_val;
+	val |= config->alpha_en_mask;
+	val |= config->alpha_mode_mask;
+
+	mask = config->main_output_mask;
+	mask |= config->aux_output_mask;
+	mask |= config->aux2_output_mask;
+	mask |= config->early_output_mask;
+	mask |= config->pre_div_mask;
+	mask |= config->post_div_mask;
+	mask |= config->vco_mask;
+	mask |= config->alpha_en_mask;
+	mask |= config->alpha_mode_mask;
+
+	regmap_update_bits(regmap, PLL_USER_CTL(pll), mask, val);
+
+	/* Stromer APSS PLL does not enable LOCK_DET by default, so enable it */
+	val_u = config->status_val << ALPHA_PLL_STATUS_REG_SHIFT;
+	val_u |= config->lock_det;
+
+	mask_u = config->status_mask;
+	mask_u |= config->lock_det;
+
+	regmap_update_bits(regmap, PLL_USER_CTL_U(pll), mask_u, val_u);
+	regmap_write(regmap, PLL_TEST_CTL(pll), config->test_ctl_val);
+	regmap_write(regmap, PLL_TEST_CTL_U(pll), config->test_ctl_hi_val);
+
+	if (pll->flags & SUPPORTS_FSM_MODE)
+		qcom_pll_set_fsm_mode(regmap, PLL_MODE(pll), 6, 0);
+}
+EXPORT_SYMBOL_GPL(clk_stromer_pll_configure);
+
+static int clk_alpha_pll_stromer_determine_rate(struct clk_hw *hw,
+						struct clk_rate_request *req)
+{
+	u32 l;
+	u64 a;
+
+	req->rate = alpha_pll_round_rate(req->rate, req->best_parent_rate,
+					 &l, &a, ALPHA_REG_BITWIDTH);
+
+	return 0;
+}
+
+static int clk_alpha_pll_stromer_set_rate(struct clk_hw *hw, unsigned long rate,
+					  unsigned long prate)
+{
+	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
+	int ret;
+	u32 l;
+	u64 a;
+
+	rate = alpha_pll_round_rate(rate, prate, &l, &a, ALPHA_REG_BITWIDTH);
+
+	regmap_write(pll->clkr.regmap, PLL_L_VAL(pll), l);
+	regmap_write(pll->clkr.regmap, PLL_ALPHA_VAL(pll), a);
+	regmap_write(pll->clkr.regmap, PLL_ALPHA_VAL_U(pll),
+		     a >> ALPHA_BITWIDTH);
+
+	regmap_update_bits(pll->clkr.regmap, PLL_USER_CTL(pll),
+			   PLL_ALPHA_EN, PLL_ALPHA_EN);
+
+	if (!clk_hw_is_enabled(hw))
+		return 0;
+
+	/*
+	 * Stromer PLL supports Dynamic programming.
+	 * It allows the PLL frequency to be changed on-the-fly without first
+	 * execution of a shutdown procedure followed by a bring up procedure.
+	 */
+	regmap_update_bits(pll->clkr.regmap, PLL_MODE(pll), PLL_UPDATE,
+			   PLL_UPDATE);
+
+	ret = wait_for_pll_update(pll);
+	if (ret)
+		return ret;
+
+	return wait_for_pll_enable_lock(pll);
+}
+
+const struct clk_ops clk_alpha_pll_stromer_ops = {
+	.enable = clk_alpha_pll_enable,
+	.disable = clk_alpha_pll_disable,
+	.is_enabled = clk_alpha_pll_is_enabled,
+	.recalc_rate = clk_alpha_pll_recalc_rate,
+	.determine_rate = clk_alpha_pll_stromer_determine_rate,
+	.set_rate = clk_alpha_pll_stromer_set_rate,
+};
+EXPORT_SYMBOL_GPL(clk_alpha_pll_stromer_ops);
diff --git a/drivers/clk/qcom/clk-alpha-pll.h b/drivers/clk/qcom/clk-alpha-pll.h
index 2bdae362c827..33b8badb9fb0 100644
--- a/drivers/clk/qcom/clk-alpha-pll.h
+++ b/drivers/clk/qcom/clk-alpha-pll.h
@@ -1,5 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (c) 2015, 2018, The Linux Foundation. All rights reserved. */
+/*
+ * Copyright (c) 2015, 2018, 2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
 
 #ifndef __QCOM_CLK_ALPHA_PLL_H__
 #define __QCOM_CLK_ALPHA_PLL_H__
@@ -22,6 +26,7 @@ enum {
 	CLK_ALPHA_PLL_TYPE_RIVIAN_EVO,
 	CLK_ALPHA_PLL_TYPE_DEFAULT_EVO,
 	CLK_ALPHA_PLL_TYPE_BRAMMO_EVO,
+	CLK_ALPHA_PLL_TYPE_STROMER,
 	CLK_ALPHA_PLL_TYPE_MAX,
 };
 
@@ -131,6 +136,9 @@ struct alpha_pll_config {
 	u32 post_div_mask;
 	u32 vco_val;
 	u32 vco_mask;
+	u32 status_val;
+	u32 status_mask;
+	u32 lock_det;
 };
 
 extern const struct clk_ops clk_alpha_pll_ops;
@@ -139,6 +147,7 @@ extern const struct clk_ops clk_alpha_pll_hwfsm_ops;
 extern const struct clk_ops clk_alpha_pll_postdiv_ops;
 extern const struct clk_ops clk_alpha_pll_huayra_ops;
 extern const struct clk_ops clk_alpha_pll_postdiv_ro_ops;
+extern const struct clk_ops clk_alpha_pll_stromer_ops;
 
 extern const struct clk_ops clk_alpha_pll_fabia_ops;
 extern const struct clk_ops clk_alpha_pll_fixed_fabia_ops;
@@ -187,5 +196,7 @@ void clk_lucid_evo_pll_configure(struct clk_alpha_pll *pll, struct regmap *regma
 				 const struct alpha_pll_config *config);
 void clk_rivian_evo_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
 				  const struct alpha_pll_config *config);
+void clk_stromer_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
+			       const struct alpha_pll_config *config);
 
 #endif
-- 
2.17.1

