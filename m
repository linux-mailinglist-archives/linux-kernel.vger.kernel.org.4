Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A23274D1A2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 11:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjGJJec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 05:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232199AbjGJJd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 05:33:59 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F76110D3;
        Mon, 10 Jul 2023 02:32:30 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36A8e92o005226;
        Mon, 10 Jul 2023 09:32:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=16ATSE0CtOFh/8jVPBIuN4he3PgzMAsFGOsa7cmjT4s=;
 b=KSzAimm9fYvukMPecgMqnkPFezO7oE4vvZlwHQbyTNiQkaP3/7LIa7ngRxNyYv7QBX/+
 0aTeNSp9cIh+bDb/TIdtqjr9YJutPNShb1wnoy1I05ZfcIbJ6L06L47DbCLIKJ5Ch3hB
 KxEKcGBOrJS691VYmoHGwQfe5lnwIeTBVKoaXf/Yoo9grvspshJehKUvLRtdTpKdSSOg
 Sbugaya5jVsX0AOvVHep+tXOLHxqXLqignd8mYSx39SaEEFdiSaA12ZR1EXN/cXVWXbU
 4jPUVjAqDl6DXu/7s5NXlf+VYvuGTUL+PL+79xpiZXfe7kcVbYhy0mFsafKUw8qhQVOZ ng== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rpwgm38nb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jul 2023 09:32:25 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36A9WOv4019457
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jul 2023 09:32:24 GMT
Received: from devipriy-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 10 Jul 2023 02:32:19 -0700
From:   Devi Priya <quic_devipriy@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_saahtoma@quicinc.com>
Subject: [PATCH] clk: qcom: clk-alpha-pll: Use determine_rate instead of round_rate
Date:   Mon, 10 Jul 2023 15:02:06 +0530
Message-ID: <20230710093206.18894-1-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: j5arkFWOqtWuhqFNVF84zutg5zDlv7vl
X-Proofpoint-ORIG-GUID: j5arkFWOqtWuhqFNVF84zutg5zDlv7vl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-10_05,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=914 mlxscore=0
 phishscore=0 adultscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 spamscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307100086
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The round_rate() API returns a long value as the errors are reported using
negative error codes. This leads to long overflow when the clock rate
exceeds 2GHz.As the clock controller treats the clock rate above signed
long max as an error, use determine_rate in place of round_rate as the
determine_rate API does not possess such limitations.

Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
---
 drivers/clk/qcom/clk-alpha-pll.c | 128 +++++++++++++++++--------------
 1 file changed, 71 insertions(+), 57 deletions(-)

diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
index e4ef645f65d1..4d9085f83d6b 100644
--- a/drivers/clk/qcom/clk-alpha-pll.c
+++ b/drivers/clk/qcom/clk-alpha-pll.c
@@ -744,22 +744,24 @@ static int clk_alpha_pll_hwfsm_set_rate(struct clk_hw *hw, unsigned long rate,
 					clk_alpha_pll_hwfsm_is_enabled);
 }
 
-static long clk_alpha_pll_round_rate(struct clk_hw *hw, unsigned long rate,
-				     unsigned long *prate)
+static int clk_alpha_pll_determine_rate(struct clk_hw *hw,
+					struct clk_rate_request *req)
 {
 	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
 	u32 l, alpha_width = pll_alpha_width(pll);
 	u64 a;
 	unsigned long min_freq, max_freq;
 
-	rate = alpha_pll_round_rate(rate, *prate, &l, &a, alpha_width);
-	if (!pll->vco_table || alpha_pll_find_vco(pll, rate))
-		return rate;
+	req->rate = alpha_pll_round_rate(req->rate, req->best_parent_rate,
+					 &l, &a, alpha_width);
+	if (!pll->vco_table || alpha_pll_find_vco(pll, req->rate))
+		return 0;
 
 	min_freq = pll->vco_table[0].min_freq;
 	max_freq = pll->vco_table[pll->num_vco - 1].max_freq;
 
-	return clamp(rate, min_freq, max_freq);
+	req->rate = clamp(req->rate, min_freq, max_freq);
+	return 0;
 }
 
 static unsigned long
@@ -906,12 +908,15 @@ static int alpha_pll_huayra_set_rate(struct clk_hw *hw, unsigned long rate,
 	return 0;
 }
 
-static long alpha_pll_huayra_round_rate(struct clk_hw *hw, unsigned long rate,
-					unsigned long *prate)
+static int alpha_pll_huayra_determine_rate(struct clk_hw *hw,
+					   struct clk_rate_request *req)
 {
 	u32 l, a;
 
-	return alpha_huayra_pll_round_rate(rate, *prate, &l, &a);
+	req->rate = alpha_huayra_pll_round_rate(req->rate,
+						req->best_parent_rate,
+						&l, &a);
+	return 0;
 }
 
 static int trion_pll_is_enabled(struct clk_alpha_pll *pll,
@@ -1030,7 +1035,7 @@ const struct clk_ops clk_alpha_pll_ops = {
 	.disable = clk_alpha_pll_disable,
 	.is_enabled = clk_alpha_pll_is_enabled,
 	.recalc_rate = clk_alpha_pll_recalc_rate,
-	.round_rate = clk_alpha_pll_round_rate,
+	.determine_rate = clk_alpha_pll_determine_rate,
 	.set_rate = clk_alpha_pll_set_rate,
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_ops);
@@ -1040,7 +1045,7 @@ const struct clk_ops clk_alpha_pll_huayra_ops = {
 	.disable = clk_alpha_pll_disable,
 	.is_enabled = clk_alpha_pll_is_enabled,
 	.recalc_rate = alpha_pll_huayra_recalc_rate,
-	.round_rate = alpha_pll_huayra_round_rate,
+	.determine_rate = alpha_pll_huayra_determine_rate,
 	.set_rate = alpha_pll_huayra_set_rate,
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_huayra_ops);
@@ -1050,7 +1055,7 @@ const struct clk_ops clk_alpha_pll_hwfsm_ops = {
 	.disable = clk_alpha_pll_hwfsm_disable,
 	.is_enabled = clk_alpha_pll_hwfsm_is_enabled,
 	.recalc_rate = clk_alpha_pll_recalc_rate,
-	.round_rate = clk_alpha_pll_round_rate,
+	.determine_rate = clk_alpha_pll_determine_rate,
 	.set_rate = clk_alpha_pll_hwfsm_set_rate,
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_hwfsm_ops);
@@ -1060,7 +1065,7 @@ const struct clk_ops clk_alpha_pll_fixed_trion_ops = {
 	.disable = clk_trion_pll_disable,
 	.is_enabled = clk_trion_pll_is_enabled,
 	.recalc_rate = clk_trion_pll_recalc_rate,
-	.round_rate = clk_alpha_pll_round_rate,
+	.determine_rate = clk_alpha_pll_determine_rate,
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_fixed_trion_ops);
 
@@ -1094,25 +1099,25 @@ static const struct clk_div_table clk_alpha_2bit_div_table[] = {
 	{ }
 };
 
-static long
-clk_alpha_pll_postdiv_round_rate(struct clk_hw *hw, unsigned long rate,
-				 unsigned long *prate)
+static int clk_alpha_pll_postdiv_determine_rate(struct clk_hw *hw,
+						struct clk_rate_request *req)
 {
 	struct clk_alpha_pll_postdiv *pll = to_clk_alpha_pll_postdiv(hw);
 	const struct clk_div_table *table;
+	unsigned long rate = req->rate;
 
 	if (pll->width == 2)
 		table = clk_alpha_2bit_div_table;
 	else
 		table = clk_alpha_div_table;
 
-	return divider_round_rate(hw, rate, prate, table,
-				  pll->width, CLK_DIVIDER_POWER_OF_TWO);
+	req->rate = divider_round_rate(hw, rate, &req->best_parent_rate, table,
+				       pll->width, CLK_DIVIDER_POWER_OF_TWO);
+	return 0;
 }
 
-static long
-clk_alpha_pll_postdiv_round_ro_rate(struct clk_hw *hw, unsigned long rate,
-				    unsigned long *prate)
+static int clk_alpha_pll_postdiv_determine_ro_rate(struct clk_hw *hw,
+						   struct clk_rate_request *req)
 {
 	struct clk_alpha_pll_postdiv *pll = to_clk_alpha_pll_postdiv(hw);
 	u32 ctl, div;
@@ -1124,9 +1129,11 @@ clk_alpha_pll_postdiv_round_ro_rate(struct clk_hw *hw, unsigned long rate,
 	div = 1 << fls(ctl);
 
 	if (clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT)
-		*prate = clk_hw_round_rate(clk_hw_get_parent(hw), div * rate);
+		req->best_parent_rate = clk_hw_round_rate(clk_hw_get_parent(hw),
+							  div * req->rate);
+	req->rate = DIV_ROUND_UP_ULL((u64)req->best_parent_rate, div);
 
-	return DIV_ROUND_UP_ULL((u64)*prate, div);
+	return 0;
 }
 
 static int clk_alpha_pll_postdiv_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -1145,13 +1152,13 @@ static int clk_alpha_pll_postdiv_set_rate(struct clk_hw *hw, unsigned long rate,
 
 const struct clk_ops clk_alpha_pll_postdiv_ops = {
 	.recalc_rate = clk_alpha_pll_postdiv_recalc_rate,
-	.round_rate = clk_alpha_pll_postdiv_round_rate,
+	.determine_rate = clk_alpha_pll_postdiv_determine_rate,
 	.set_rate = clk_alpha_pll_postdiv_set_rate,
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_postdiv_ops);
 
 const struct clk_ops clk_alpha_pll_postdiv_ro_ops = {
-	.round_rate = clk_alpha_pll_postdiv_round_ro_rate,
+	.determine_rate = clk_alpha_pll_postdiv_determine_ro_rate,
 	.recalc_rate = clk_alpha_pll_postdiv_recalc_rate,
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_postdiv_ro_ops);
@@ -1393,7 +1400,7 @@ const struct clk_ops clk_alpha_pll_fabia_ops = {
 	.is_enabled = clk_alpha_pll_is_enabled,
 	.set_rate = alpha_pll_fabia_set_rate,
 	.recalc_rate = alpha_pll_fabia_recalc_rate,
-	.round_rate = clk_alpha_pll_round_rate,
+	.determine_rate = clk_alpha_pll_determine_rate,
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_fabia_ops);
 
@@ -1402,7 +1409,7 @@ const struct clk_ops clk_alpha_pll_fixed_fabia_ops = {
 	.disable = alpha_pll_fabia_disable,
 	.is_enabled = clk_alpha_pll_is_enabled,
 	.recalc_rate = alpha_pll_fabia_recalc_rate,
-	.round_rate = clk_alpha_pll_round_rate,
+	.determine_rate = clk_alpha_pll_determine_rate,
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_fixed_fabia_ops);
 
@@ -1452,14 +1459,16 @@ clk_trion_pll_postdiv_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 	return (parent_rate / div);
 }
 
-static long
-clk_trion_pll_postdiv_round_rate(struct clk_hw *hw, unsigned long rate,
-				 unsigned long *prate)
+static int
+clk_trion_pll_postdiv_determine_rate(struct clk_hw *hw,
+				     struct clk_rate_request *req)
 {
 	struct clk_alpha_pll_postdiv *pll = to_clk_alpha_pll_postdiv(hw);
 
-	return divider_round_rate(hw, rate, prate, pll->post_div_table,
-				  pll->width, CLK_DIVIDER_ROUND_CLOSEST);
+	req->rate = divider_round_rate(hw, req->rate, &req->best_parent_rate,
+				       pll->post_div_table, pll->width,
+				       CLK_DIVIDER_ROUND_CLOSEST);
+	return 0;
 };
 
 static int
@@ -1485,18 +1494,21 @@ clk_trion_pll_postdiv_set_rate(struct clk_hw *hw, unsigned long rate,
 
 const struct clk_ops clk_alpha_pll_postdiv_trion_ops = {
 	.recalc_rate = clk_trion_pll_postdiv_recalc_rate,
-	.round_rate = clk_trion_pll_postdiv_round_rate,
+	.determine_rate = clk_trion_pll_postdiv_determine_rate,
 	.set_rate = clk_trion_pll_postdiv_set_rate,
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_postdiv_trion_ops);
 
-static long clk_alpha_pll_postdiv_fabia_round_rate(struct clk_hw *hw,
-				unsigned long rate, unsigned long *prate)
+static int
+clk_alpha_pll_postdiv_fabia_determine_rate(struct clk_hw *hw,
+					   struct clk_rate_request *req)
 {
 	struct clk_alpha_pll_postdiv *pll = to_clk_alpha_pll_postdiv(hw);
 
-	return divider_round_rate(hw, rate, prate, pll->post_div_table,
-				pll->width, CLK_DIVIDER_ROUND_CLOSEST);
+	req->rate = divider_round_rate(hw, req->rate, &req->best_parent_rate,
+				       pll->post_div_table, pll->width,
+					CLK_DIVIDER_ROUND_CLOSEST);
+	return 0;
 }
 
 static int clk_alpha_pll_postdiv_fabia_set_rate(struct clk_hw *hw,
@@ -1531,7 +1543,7 @@ static int clk_alpha_pll_postdiv_fabia_set_rate(struct clk_hw *hw,
 
 const struct clk_ops clk_alpha_pll_postdiv_fabia_ops = {
 	.recalc_rate = clk_alpha_pll_postdiv_fabia_recalc_rate,
-	.round_rate = clk_alpha_pll_postdiv_fabia_round_rate,
+	.determine_rate = clk_alpha_pll_postdiv_fabia_determine_rate,
 	.set_rate = clk_alpha_pll_postdiv_fabia_set_rate,
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_postdiv_fabia_ops);
@@ -1683,7 +1695,7 @@ const struct clk_ops clk_alpha_pll_trion_ops = {
 	.disable = clk_trion_pll_disable,
 	.is_enabled = clk_trion_pll_is_enabled,
 	.recalc_rate = clk_trion_pll_recalc_rate,
-	.round_rate = clk_alpha_pll_round_rate,
+	.determine_rate = clk_alpha_pll_determine_rate,
 	.set_rate = alpha_pll_trion_set_rate,
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_trion_ops);
@@ -1694,14 +1706,14 @@ const struct clk_ops clk_alpha_pll_lucid_ops = {
 	.disable = clk_trion_pll_disable,
 	.is_enabled = clk_trion_pll_is_enabled,
 	.recalc_rate = clk_trion_pll_recalc_rate,
-	.round_rate = clk_alpha_pll_round_rate,
+	.determine_rate = clk_alpha_pll_determine_rate,
 	.set_rate = alpha_pll_trion_set_rate,
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_lucid_ops);
 
 const struct clk_ops clk_alpha_pll_postdiv_lucid_ops = {
 	.recalc_rate = clk_alpha_pll_postdiv_fabia_recalc_rate,
-	.round_rate = clk_alpha_pll_postdiv_fabia_round_rate,
+	.determine_rate = clk_alpha_pll_postdiv_fabia_determine_rate,
 	.set_rate = clk_alpha_pll_postdiv_fabia_set_rate,
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_postdiv_lucid_ops);
@@ -1753,7 +1765,7 @@ const struct clk_ops clk_alpha_pll_agera_ops = {
 	.disable = clk_alpha_pll_disable,
 	.is_enabled = clk_alpha_pll_is_enabled,
 	.recalc_rate = alpha_pll_fabia_recalc_rate,
-	.round_rate = clk_alpha_pll_round_rate,
+	.determine_rate = clk_alpha_pll_determine_rate,
 	.set_rate = clk_alpha_pll_agera_set_rate,
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_agera_ops);
@@ -1918,7 +1930,7 @@ const struct clk_ops clk_alpha_pll_lucid_5lpe_ops = {
 	.disable = alpha_pll_lucid_5lpe_disable,
 	.is_enabled = clk_trion_pll_is_enabled,
 	.recalc_rate = clk_trion_pll_recalc_rate,
-	.round_rate = clk_alpha_pll_round_rate,
+	.determine_rate = clk_alpha_pll_determine_rate,
 	.set_rate = alpha_pll_lucid_5lpe_set_rate,
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_lucid_5lpe_ops);
@@ -1928,13 +1940,13 @@ const struct clk_ops clk_alpha_pll_fixed_lucid_5lpe_ops = {
 	.disable = alpha_pll_lucid_5lpe_disable,
 	.is_enabled = clk_trion_pll_is_enabled,
 	.recalc_rate = clk_trion_pll_recalc_rate,
-	.round_rate = clk_alpha_pll_round_rate,
+	.determine_rate = clk_alpha_pll_determine_rate,
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_fixed_lucid_5lpe_ops);
 
 const struct clk_ops clk_alpha_pll_postdiv_lucid_5lpe_ops = {
 	.recalc_rate = clk_alpha_pll_postdiv_fabia_recalc_rate,
-	.round_rate = clk_alpha_pll_postdiv_fabia_round_rate,
+	.determine_rate = clk_alpha_pll_postdiv_fabia_determine_rate,
 	.set_rate = clk_lucid_5lpe_pll_postdiv_set_rate,
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_postdiv_lucid_5lpe_ops);
@@ -2087,7 +2099,7 @@ const struct clk_ops clk_alpha_pll_zonda_ops = {
 	.disable = clk_zonda_pll_disable,
 	.is_enabled = clk_trion_pll_is_enabled,
 	.recalc_rate = clk_trion_pll_recalc_rate,
-	.round_rate = clk_alpha_pll_round_rate,
+	.determine_rate = clk_alpha_pll_determine_rate,
 	.set_rate = clk_zonda_pll_set_rate,
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_zonda_ops);
@@ -2277,13 +2289,13 @@ const struct clk_ops clk_alpha_pll_fixed_lucid_evo_ops = {
 	.disable = alpha_pll_lucid_evo_disable,
 	.is_enabled = clk_trion_pll_is_enabled,
 	.recalc_rate = alpha_pll_lucid_evo_recalc_rate,
-	.round_rate = clk_alpha_pll_round_rate,
+	.determine_rate = clk_alpha_pll_determine_rate,
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_fixed_lucid_evo_ops);
 
 const struct clk_ops clk_alpha_pll_postdiv_lucid_evo_ops = {
 	.recalc_rate = clk_alpha_pll_postdiv_fabia_recalc_rate,
-	.round_rate = clk_alpha_pll_postdiv_fabia_round_rate,
+	.determine_rate = clk_alpha_pll_postdiv_fabia_determine_rate,
 	.set_rate = clk_lucid_evo_pll_postdiv_set_rate,
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_postdiv_lucid_evo_ops);
@@ -2294,7 +2306,7 @@ const struct clk_ops clk_alpha_pll_lucid_evo_ops = {
 	.disable = alpha_pll_lucid_evo_disable,
 	.is_enabled = clk_trion_pll_is_enabled,
 	.recalc_rate = alpha_pll_lucid_evo_recalc_rate,
-	.round_rate = clk_alpha_pll_round_rate,
+	.determine_rate = clk_alpha_pll_determine_rate,
 	.set_rate = alpha_pll_lucid_5lpe_set_rate,
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_lucid_evo_ops);
@@ -2305,7 +2317,7 @@ const struct clk_ops clk_alpha_pll_reset_lucid_evo_ops = {
 	.disable = alpha_pll_reset_lucid_evo_disable,
 	.is_enabled = clk_trion_pll_is_enabled,
 	.recalc_rate = alpha_pll_lucid_evo_recalc_rate,
-	.round_rate = clk_alpha_pll_round_rate,
+	.determine_rate = clk_alpha_pll_determine_rate,
 	.set_rate = alpha_pll_lucid_5lpe_set_rate,
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_reset_lucid_evo_ops);
@@ -2341,22 +2353,24 @@ static unsigned long clk_rivian_evo_pll_recalc_rate(struct clk_hw *hw,
 	return parent_rate * l;
 }
 
-static long clk_rivian_evo_pll_round_rate(struct clk_hw *hw, unsigned long rate,
-					  unsigned long *prate)
+static int clk_rivian_evo_pll_determine_rate(struct clk_hw *hw,
+					     struct clk_rate_request *req)
 {
 	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
 	unsigned long min_freq, max_freq;
 	u32 l;
 	u64 a;
 
-	rate = alpha_pll_round_rate(rate, *prate, &l, &a, 0);
-	if (!pll->vco_table || alpha_pll_find_vco(pll, rate))
-		return rate;
+	req->rate = alpha_pll_round_rate(req->rate, req->best_parent_rate,
+					 &l, &a, 0);
+	if (!pll->vco_table || alpha_pll_find_vco(pll, req->rate))
+		return 0;
 
 	min_freq = pll->vco_table[0].min_freq;
 	max_freq = pll->vco_table[pll->num_vco - 1].max_freq;
 
-	return clamp(rate, min_freq, max_freq);
+	req->rate = clamp(req->rate, min_freq, max_freq);
+	return 0;
 }
 
 const struct clk_ops clk_alpha_pll_rivian_evo_ops = {
@@ -2364,7 +2378,7 @@ const struct clk_ops clk_alpha_pll_rivian_evo_ops = {
 	.disable = alpha_pll_lucid_5lpe_disable,
 	.is_enabled = clk_trion_pll_is_enabled,
 	.recalc_rate = clk_rivian_evo_pll_recalc_rate,
-	.round_rate = clk_rivian_evo_pll_round_rate,
+	.determine_rate = clk_rivian_evo_pll_determine_rate,
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_rivian_evo_ops);
 
-- 
2.17.1

