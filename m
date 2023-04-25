Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E74956EDEAC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 11:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbjDYJEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 05:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbjDYJEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 05:04:36 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F29F10F2;
        Tue, 25 Apr 2023 02:04:32 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33P6m1Qi022983;
        Tue, 25 Apr 2023 08:40:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=KmFk0MmyxLk/vuGswQlNFp7OQFv5vsA0V1TxBVlugp4=;
 b=jB2NiGRymrIZRX3L6PnNMjfxgXig0ZNwDZwiZV6dgjRjtt2QXgUWiox4IDfBOyxeFSp0
 kddMhdtJ7Sc+MFdKerw4McutsoHedys20FG3DOosIPWdNQKZaAo5U6CHqZZJd+AjmToq
 UD7eXWdrI+VOJVABAnlnxsMGCTnmSKP8YezzfyQe+wirm5Zh9lr3nBwjtqpe7cFuDqaN
 F+EZIqNUIFYcEPjIWTfJQ3ByP2iSZJI3t7IyBd9CfTOxkZ6eAXfzxvmPL8WQKFOSwxpM
 7nNfKtpqud1MxI42d0DrvdMALWrNUnEu2TWm8CVe9zCzKzvjuLq5po9kV8NAtQdX8nwm UQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q5qv6tkad-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Apr 2023 08:40:58 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33P8ev22015577
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Apr 2023 08:40:57 GMT
Received: from devipriy-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 25 Apr 2023 01:40:49 -0700
From:   Devi Priya <quic_devipriy@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>, <quic_poovendh@quicinc.com>
Subject: [PATCH V3 4/6] clk: qcom: gcc-ipq9574: constify struct clk_init_data
Date:   Tue, 25 Apr 2023 14:10:08 +0530
Message-ID: <20230425084010.15581-5-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230425084010.15581-1-quic_devipriy@quicinc.com>
References: <20230425084010.15581-1-quic_devipriy@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: FgwKRbK6wzaPSoSK-Wd05bo3eMr9v1jn
X-Proofpoint-ORIG-GUID: FgwKRbK6wzaPSoSK-Wd05bo3eMr9v1jn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_03,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304250076
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the clk_init_data struct constant.

Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
---
 Changes in V3:
	- Moved the changes to constify struct clk_init_data to a separate
	  patch.

 drivers/clk/qcom/gcc-ipq9574.c | 422 ++++++++++++++++-----------------
 1 file changed, 211 insertions(+), 211 deletions(-)

diff --git a/drivers/clk/qcom/gcc-ipq9574.c b/drivers/clk/qcom/gcc-ipq9574.c
index 8dd29bbd93b9..7b0505f5c255 100644
--- a/drivers/clk/qcom/gcc-ipq9574.c
+++ b/drivers/clk/qcom/gcc-ipq9574.c
@@ -69,7 +69,7 @@ static struct clk_alpha_pll gpll0_main = {
 	.clkr = {
 		.enable_reg = 0x0b000,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gpll0_main",
 			.parent_data = gcc_xo_data,
 			.num_parents = ARRAY_SIZE(gcc_xo_data),
@@ -81,7 +81,7 @@ static struct clk_alpha_pll gpll0_main = {
 static struct clk_fixed_factor gpll0_out_main_div2 = {
 	.mult = 1,
 	.div = 2,
-	.hw.init = &(struct clk_init_data) {
+	.hw.init = &(const struct clk_init_data) {
 		.name = "gpll0_out_main_div2",
 		.parent_hws = (const struct clk_hw *[]) {
 			&gpll0_main.clkr.hw
@@ -96,7 +96,7 @@ static struct clk_alpha_pll_postdiv gpll0 = {
 	.offset = 0x20000,
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
 	.width = 4,
-	.clkr.hw.init = &(struct clk_init_data) {
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "gpll0",
 		.parent_hws = (const struct clk_hw *[]) {
 			&gpll0_main.clkr.hw
@@ -113,7 +113,7 @@ static struct clk_alpha_pll gpll4_main = {
 	.clkr = {
 		.enable_reg = 0x0b000,
 		.enable_mask = BIT(2),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gpll4_main",
 			.parent_data = gcc_xo_data,
 			.num_parents = ARRAY_SIZE(gcc_xo_data),
@@ -126,7 +126,7 @@ static struct clk_alpha_pll_postdiv gpll4 = {
 	.offset = 0x22000,
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
 	.width = 4,
-	.clkr.hw.init = &(struct clk_init_data) {
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "gpll4",
 		.parent_hws = (const struct clk_hw *[]) {
 			&gpll4_main.clkr.hw
@@ -143,7 +143,7 @@ static struct clk_alpha_pll gpll2_main = {
 	.clkr = {
 		.enable_reg = 0x0b000,
 		.enable_mask = BIT(1),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gpll2_main",
 			.parent_data = gcc_xo_data,
 			.num_parents = ARRAY_SIZE(gcc_xo_data),
@@ -156,7 +156,7 @@ static struct clk_alpha_pll_postdiv gpll2 = {
 	.offset = 0x21000,
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
 	.width = 4,
-	.clkr.hw.init = &(struct clk_init_data) {
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "gpll2",
 		.parent_hws = (const struct clk_hw *[]) {
 			&gpll2_main.clkr.hw
@@ -172,7 +172,7 @@ static struct clk_branch gcc_sleep_clk_src = {
 	.clkr = {
 		.enable_reg = 0x3400c,
 		.enable_mask = BIT(1),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_sleep_clk_src",
 			.parent_data = gcc_sleep_clk_data,
 			.num_parents = ARRAY_SIZE(gcc_sleep_clk_data),
@@ -420,7 +420,7 @@ static struct clk_rcg2 apss_ahb_clk_src = {
 	.freq_tbl = ftbl_apss_ahb_clk_src,
 	.hid_width = 5,
 	.parent_map = gcc_xo_gpll0_gpll0_out_main_div2_map,
-	.clkr.hw.init = &(struct clk_init_data) {
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "apss_ahb_clk_src",
 		.parent_data = gcc_xo_gpll0_gpll0_out_main_div2,
 		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll0_out_main_div2),
@@ -438,7 +438,7 @@ static struct clk_rcg2 apss_axi_clk_src = {
 	.freq_tbl = ftbl_apss_axi_clk_src,
 	.hid_width = 5,
 	.parent_map = gcc_xo_gpll0_gpll0_div2_gpll0_map,
-	.clkr.hw.init = &(struct clk_init_data) {
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "apss_axi_clk_src",
 		.parent_data = gcc_xo_gpll0_gpll0_div2_gpll0,
 		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll0_div2_gpll0),
@@ -458,7 +458,7 @@ static struct clk_rcg2 blsp1_qup1_i2c_apps_clk_src = {
 	.freq_tbl = ftbl_blsp1_qup_i2c_apps_clk_src,
 	.hid_width = 5,
 	.parent_map = gcc_xo_gpll0_gpll0_out_main_div2_map,
-	.clkr.hw.init = &(struct clk_init_data) {
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "blsp1_qup1_i2c_apps_clk_src",
 		.parent_data = gcc_xo_gpll0_gpll0_out_main_div2,
 		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll0_out_main_div2),
@@ -483,7 +483,7 @@ static struct clk_rcg2 blsp1_qup1_spi_apps_clk_src = {
 	.mnd_width = 8,
 	.hid_width = 5,
 	.parent_map = gcc_xo_gpll0_gpll0_out_main_div2_map,
-	.clkr.hw.init = &(struct clk_init_data) {
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "blsp1_qup1_spi_apps_clk_src",
 		.parent_data = gcc_xo_gpll0_gpll0_out_main_div2,
 		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll0_out_main_div2),
@@ -496,7 +496,7 @@ static struct clk_rcg2 blsp1_qup2_i2c_apps_clk_src = {
 	.freq_tbl = ftbl_blsp1_qup_i2c_apps_clk_src,
 	.hid_width = 5,
 	.parent_map = gcc_xo_gpll0_gpll0_out_main_div2_map,
-	.clkr.hw.init = &(struct clk_init_data) {
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "blsp1_qup2_i2c_apps_clk_src",
 		.parent_data = gcc_xo_gpll0_gpll0_out_main_div2,
 		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll0_out_main_div2),
@@ -510,7 +510,7 @@ static struct clk_rcg2 blsp1_qup2_spi_apps_clk_src = {
 	.mnd_width = 8,
 	.hid_width = 5,
 	.parent_map = gcc_xo_gpll0_gpll0_out_main_div2_map,
-	.clkr.hw.init = &(struct clk_init_data) {
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "blsp1_qup2_spi_apps_clk_src",
 		.parent_data = gcc_xo_gpll0_gpll0_out_main_div2,
 		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll0_out_main_div2),
@@ -523,7 +523,7 @@ static struct clk_rcg2 blsp1_qup3_i2c_apps_clk_src = {
 	.freq_tbl = ftbl_blsp1_qup_i2c_apps_clk_src,
 	.hid_width = 5,
 	.parent_map = gcc_xo_gpll0_gpll0_out_main_div2_map,
-	.clkr.hw.init = &(struct clk_init_data) {
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "blsp1_qup3_i2c_apps_clk_src",
 		.parent_data = gcc_xo_gpll0_gpll0_out_main_div2,
 		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll0_out_main_div2),
@@ -537,7 +537,7 @@ static struct clk_rcg2 blsp1_qup3_spi_apps_clk_src = {
 	.mnd_width = 8,
 	.hid_width = 5,
 	.parent_map = gcc_xo_gpll0_gpll0_out_main_div2_map,
-	.clkr.hw.init = &(struct clk_init_data) {
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "blsp1_qup3_spi_apps_clk_src",
 		.parent_data = gcc_xo_gpll0_gpll0_out_main_div2,
 		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll0_out_main_div2),
@@ -550,7 +550,7 @@ static struct clk_rcg2 blsp1_qup4_i2c_apps_clk_src = {
 	.freq_tbl = ftbl_blsp1_qup_i2c_apps_clk_src,
 	.hid_width = 5,
 	.parent_map = gcc_xo_gpll0_gpll0_out_main_div2_map,
-	.clkr.hw.init = &(struct clk_init_data) {
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "blsp1_qup4_i2c_apps_clk_src",
 		.parent_data = gcc_xo_gpll0_gpll0_out_main_div2,
 		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll0_out_main_div2),
@@ -564,7 +564,7 @@ static struct clk_rcg2 blsp1_qup4_spi_apps_clk_src = {
 	.mnd_width = 8,
 	.hid_width = 5,
 	.parent_map = gcc_xo_gpll0_gpll0_out_main_div2_map,
-	.clkr.hw.init = &(struct clk_init_data) {
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "blsp1_qup4_spi_apps_clk_src",
 		.parent_data = gcc_xo_gpll0_gpll0_out_main_div2,
 		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll0_out_main_div2),
@@ -577,7 +577,7 @@ static struct clk_rcg2 blsp1_qup5_i2c_apps_clk_src = {
 	.freq_tbl = ftbl_blsp1_qup_i2c_apps_clk_src,
 	.hid_width = 5,
 	.parent_map = gcc_xo_gpll0_gpll0_out_main_div2_map,
-	.clkr.hw.init = &(struct clk_init_data) {
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "blsp1_qup5_i2c_apps_clk_src",
 		.parent_data = gcc_xo_gpll0_gpll0_out_main_div2,
 		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll0_out_main_div2),
@@ -591,7 +591,7 @@ static struct clk_rcg2 blsp1_qup5_spi_apps_clk_src = {
 	.mnd_width = 8,
 	.hid_width = 5,
 	.parent_map = gcc_xo_gpll0_gpll0_out_main_div2_map,
-	.clkr.hw.init = &(struct clk_init_data) {
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "blsp1_qup5_spi_apps_clk_src",
 		.parent_data = gcc_xo_gpll0_gpll0_out_main_div2,
 		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll0_out_main_div2),
@@ -604,7 +604,7 @@ static struct clk_rcg2 blsp1_qup6_i2c_apps_clk_src = {
 	.freq_tbl = ftbl_blsp1_qup_i2c_apps_clk_src,
 	.hid_width = 5,
 	.parent_map = gcc_xo_gpll0_gpll0_out_main_div2_map,
-	.clkr.hw.init = &(struct clk_init_data) {
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "blsp1_qup6_i2c_apps_clk_src",
 		.parent_data = gcc_xo_gpll0_gpll0_out_main_div2,
 		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll0_out_main_div2),
@@ -618,7 +618,7 @@ static struct clk_rcg2 blsp1_qup6_spi_apps_clk_src = {
 	.mnd_width = 8,
 	.hid_width = 5,
 	.parent_map = gcc_xo_gpll0_gpll0_out_main_div2_map,
-	.clkr.hw.init = &(struct clk_init_data) {
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "blsp1_qup6_spi_apps_clk_src",
 		.parent_data = gcc_xo_gpll0_gpll0_out_main_div2,
 		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll0_out_main_div2),
@@ -650,7 +650,7 @@ static struct clk_rcg2 blsp1_uart1_apps_clk_src = {
 	.mnd_width = 16,
 	.hid_width = 5,
 	.parent_map = gcc_xo_gpll0_gpll0_out_main_div2_map,
-	.clkr.hw.init = &(struct clk_init_data) {
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "blsp1_uart1_apps_clk_src",
 		.parent_data = gcc_xo_gpll0_gpll0_out_main_div2,
 		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll0_out_main_div2),
@@ -664,7 +664,7 @@ static struct clk_rcg2 blsp1_uart2_apps_clk_src = {
 	.mnd_width = 16,
 	.hid_width = 5,
 	.parent_map = gcc_xo_gpll0_gpll0_out_main_div2_map,
-	.clkr.hw.init = &(struct clk_init_data) {
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "blsp1_uart2_apps_clk_src",
 		.parent_data = gcc_xo_gpll0_gpll0_out_main_div2,
 		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll0_out_main_div2),
@@ -678,7 +678,7 @@ static struct clk_rcg2 blsp1_uart3_apps_clk_src = {
 	.mnd_width = 16,
 	.hid_width = 5,
 	.parent_map = gcc_xo_gpll0_gpll0_out_main_div2_map,
-	.clkr.hw.init = &(struct clk_init_data) {
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "blsp1_uart3_apps_clk_src",
 		.parent_data = gcc_xo_gpll0_gpll0_out_main_div2,
 		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll0_out_main_div2),
@@ -692,7 +692,7 @@ static struct clk_rcg2 blsp1_uart4_apps_clk_src = {
 	.mnd_width = 16,
 	.hid_width = 5,
 	.parent_map = gcc_xo_gpll0_gpll0_out_main_div2_map,
-	.clkr.hw.init = &(struct clk_init_data) {
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "blsp1_uart4_apps_clk_src",
 		.parent_data = gcc_xo_gpll0_gpll0_out_main_div2,
 		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll0_out_main_div2),
@@ -706,7 +706,7 @@ static struct clk_rcg2 blsp1_uart5_apps_clk_src = {
 	.mnd_width = 16,
 	.hid_width = 5,
 	.parent_map = gcc_xo_gpll0_gpll0_out_main_div2_map,
-	.clkr.hw.init = &(struct clk_init_data) {
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "blsp1_uart5_apps_clk_src",
 		.parent_data = gcc_xo_gpll0_gpll0_out_main_div2,
 		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll0_out_main_div2),
@@ -720,7 +720,7 @@ static struct clk_rcg2 blsp1_uart6_apps_clk_src = {
 	.mnd_width = 16,
 	.hid_width = 5,
 	.parent_map = gcc_xo_gpll0_gpll0_out_main_div2_map,
-	.clkr.hw.init = &(struct clk_init_data) {
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "blsp1_uart6_apps_clk_src",
 		.parent_data = gcc_xo_gpll0_gpll0_out_main_div2,
 		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll0_out_main_div2),
@@ -734,7 +734,7 @@ static struct clk_branch gcc_apss_ahb_clk = {
 	.clkr = {
 		.enable_reg = 0x0b004,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_apss_ahb_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&apss_ahb_clk_src.clkr.hw
@@ -752,7 +752,7 @@ static struct clk_branch gcc_apss_axi_clk = {
 	.clkr = {
 		.enable_reg = 0x0b004,
 		.enable_mask = BIT(1),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_apss_axi_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&apss_axi_clk_src.clkr.hw
@@ -769,7 +769,7 @@ static struct clk_branch gcc_blsp1_qup1_i2c_apps_clk = {
 	.clkr = {
 		.enable_reg = 0x2024,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_blsp1_qup1_i2c_apps_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&blsp1_qup1_i2c_apps_clk_src.clkr.hw
@@ -786,7 +786,7 @@ static struct clk_branch gcc_blsp1_qup1_spi_apps_clk = {
 	.clkr = {
 		.enable_reg = 0x02020,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_blsp1_qup1_spi_apps_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&blsp1_qup1_spi_apps_clk_src.clkr.hw
@@ -803,7 +803,7 @@ static struct clk_branch gcc_blsp1_qup2_i2c_apps_clk = {
 	.clkr = {
 		.enable_reg = 0x03024,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_blsp1_qup2_i2c_apps_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&blsp1_qup2_i2c_apps_clk_src.clkr.hw
@@ -820,7 +820,7 @@ static struct clk_branch gcc_blsp1_qup2_spi_apps_clk = {
 	.clkr = {
 		.enable_reg = 0x03020,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_blsp1_qup2_spi_apps_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&blsp1_qup2_spi_apps_clk_src.clkr.hw
@@ -837,7 +837,7 @@ static struct clk_branch gcc_blsp1_qup3_i2c_apps_clk = {
 	.clkr = {
 		.enable_reg = 0x04024,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_blsp1_qup3_i2c_apps_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&blsp1_qup3_i2c_apps_clk_src.clkr.hw
@@ -854,7 +854,7 @@ static struct clk_branch gcc_blsp1_qup3_spi_apps_clk = {
 	.clkr = {
 		.enable_reg = 0x04020,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_blsp1_qup3_spi_apps_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&blsp1_qup3_spi_apps_clk_src.clkr.hw
@@ -871,7 +871,7 @@ static struct clk_branch gcc_blsp1_qup4_i2c_apps_clk = {
 	.clkr = {
 		.enable_reg = 0x05024,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_blsp1_qup4_i2c_apps_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&blsp1_qup4_i2c_apps_clk_src.clkr.hw
@@ -888,7 +888,7 @@ static struct clk_branch gcc_blsp1_qup4_spi_apps_clk = {
 	.clkr = {
 		.enable_reg = 0x05020,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_blsp1_qup4_spi_apps_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&blsp1_qup4_spi_apps_clk_src.clkr.hw
@@ -905,7 +905,7 @@ static struct clk_branch gcc_blsp1_qup5_i2c_apps_clk = {
 	.clkr = {
 		.enable_reg = 0x06024,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_blsp1_qup5_i2c_apps_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&blsp1_qup5_i2c_apps_clk_src.clkr.hw
@@ -922,7 +922,7 @@ static struct clk_branch gcc_blsp1_qup5_spi_apps_clk = {
 	.clkr = {
 		.enable_reg = 0x06020,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_blsp1_qup5_spi_apps_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&blsp1_qup5_spi_apps_clk_src.clkr.hw
@@ -939,7 +939,7 @@ static struct clk_branch gcc_blsp1_qup6_i2c_apps_clk = {
 	.clkr = {
 		.enable_reg = 0x07024,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_blsp1_qup6_i2c_apps_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&blsp1_qup6_i2c_apps_clk_src.clkr.hw
@@ -956,7 +956,7 @@ static struct clk_branch gcc_blsp1_qup6_spi_apps_clk = {
 	.clkr = {
 		.enable_reg = 0x07020,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_blsp1_qup6_spi_apps_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&blsp1_qup6_spi_apps_clk_src.clkr.hw
@@ -973,7 +973,7 @@ static struct clk_branch gcc_blsp1_uart1_apps_clk = {
 	.clkr = {
 		.enable_reg = 0x02040,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_blsp1_uart1_apps_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&blsp1_uart1_apps_clk_src.clkr.hw
@@ -990,7 +990,7 @@ static struct clk_branch gcc_blsp1_uart2_apps_clk = {
 	.clkr = {
 		.enable_reg = 0x03040,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_blsp1_uart2_apps_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&blsp1_uart2_apps_clk_src.clkr.hw
@@ -1007,7 +1007,7 @@ static struct clk_branch gcc_blsp1_uart3_apps_clk = {
 	.clkr = {
 		.enable_reg = 0x04054,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_blsp1_uart3_apps_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&blsp1_uart3_apps_clk_src.clkr.hw
@@ -1024,7 +1024,7 @@ static struct clk_branch gcc_blsp1_uart4_apps_clk = {
 	.clkr = {
 		.enable_reg = 0x05040,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_blsp1_uart4_apps_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&blsp1_uart4_apps_clk_src.clkr.hw
@@ -1041,7 +1041,7 @@ static struct clk_branch gcc_blsp1_uart5_apps_clk = {
 	.clkr = {
 		.enable_reg = 0x06040,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_blsp1_uart5_apps_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&blsp1_uart5_apps_clk_src.clkr.hw
@@ -1058,7 +1058,7 @@ static struct clk_branch gcc_blsp1_uart6_apps_clk = {
 	.clkr = {
 		.enable_reg = 0x07040,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_blsp1_uart6_apps_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&blsp1_uart6_apps_clk_src.clkr.hw
@@ -1080,7 +1080,7 @@ static struct clk_rcg2 pcie0_axi_m_clk_src = {
 	.freq_tbl = ftbl_pcie0_axi_m_clk_src,
 	.hid_width = 5,
 	.parent_map = gcc_xo_gpll0_gpll4_map,
-	.clkr.hw.init = &(struct clk_init_data) {
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "pcie0_axi_m_clk_src",
 		.parent_data = gcc_xo_gpll0_gpll4,
 		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll4),
@@ -1093,7 +1093,7 @@ static struct clk_branch gcc_pcie0_axi_m_clk = {
 	.clkr = {
 		.enable_reg = 0x28038,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_pcie0_axi_m_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&pcie0_axi_m_clk_src.clkr.hw
@@ -1110,7 +1110,7 @@ static struct clk_branch gcc_anoc_pcie0_1lane_m_clk = {
 	.clkr = {
 		.enable_reg = 0x2e07c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_anoc_pcie0_1lane_m_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&pcie0_axi_m_clk_src.clkr.hw
@@ -1127,7 +1127,7 @@ static struct clk_rcg2 pcie1_axi_m_clk_src = {
 	.freq_tbl = ftbl_pcie0_axi_m_clk_src,
 	.hid_width = 5,
 	.parent_map = gcc_xo_gpll0_gpll4_map,
-	.clkr.hw.init = &(struct clk_init_data) {
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "pcie1_axi_m_clk_src",
 		.parent_data = gcc_xo_gpll0_gpll4,
 		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll4),
@@ -1140,7 +1140,7 @@ static struct clk_branch gcc_pcie1_axi_m_clk = {
 	.clkr = {
 		.enable_reg = 0x29038,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_pcie1_axi_m_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&pcie1_axi_m_clk_src.clkr.hw
@@ -1157,7 +1157,7 @@ static struct clk_branch gcc_anoc_pcie1_1lane_m_clk = {
 	.clkr = {
 		.enable_reg = 0x2e08c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_anoc_pcie1_1lane_m_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&pcie1_axi_m_clk_src.clkr.hw
@@ -1179,7 +1179,7 @@ static struct clk_rcg2 pcie2_axi_m_clk_src = {
 	.freq_tbl = ftbl_pcie2_axi_m_clk_src,
 	.hid_width = 5,
 	.parent_map = gcc_xo_gpll0_gpll4_bias_pll_ubi_nc_clk_map,
-	.clkr.hw.init = &(struct clk_init_data) {
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "pcie2_axi_m_clk_src",
 		.parent_data = gcc_xo_gpll0_gpll4_bias_pll_ubi_nc_clk,
 		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll4_bias_pll_ubi_nc_clk),
@@ -1192,7 +1192,7 @@ static struct clk_branch gcc_pcie2_axi_m_clk = {
 	.clkr = {
 		.enable_reg = 0x2a038,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_pcie2_axi_m_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&pcie2_axi_m_clk_src.clkr.hw
@@ -1209,7 +1209,7 @@ static struct clk_branch gcc_anoc_pcie2_2lane_m_clk = {
 	.clkr = {
 		.enable_reg = 0x2e080,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_anoc_pcie2_2lane_m_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&pcie2_axi_m_clk_src.clkr.hw
@@ -1226,7 +1226,7 @@ static struct clk_rcg2 pcie3_axi_m_clk_src = {
 	.freq_tbl = ftbl_pcie2_axi_m_clk_src,
 	.hid_width = 5,
 	.parent_map = gcc_xo_gpll0_gpll4_bias_pll_ubi_nc_clk_map,
-	.clkr.hw.init = &(struct clk_init_data) {
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "pcie3_axi_m_clk_src",
 		.parent_data = gcc_xo_gpll0_gpll4_bias_pll_ubi_nc_clk,
 		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll4_bias_pll_ubi_nc_clk),
@@ -1239,7 +1239,7 @@ static struct clk_branch gcc_pcie3_axi_m_clk = {
 	.clkr = {
 		.enable_reg = 0x2b038,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_pcie3_axi_m_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&pcie3_axi_m_clk_src.clkr.hw
@@ -1256,7 +1256,7 @@ static struct clk_branch gcc_anoc_pcie3_2lane_m_clk = {
 	.clkr = {
 		.enable_reg = 0x2e090,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_anoc_pcie3_2lane_m_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&pcie3_axi_m_clk_src.clkr.hw
@@ -1273,7 +1273,7 @@ static struct clk_rcg2 pcie0_axi_s_clk_src = {
 	.freq_tbl = ftbl_pcie0_axi_m_clk_src,
 	.hid_width = 5,
 	.parent_map = gcc_xo_gpll0_gpll4_map,
-	.clkr.hw.init = &(struct clk_init_data) {
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "pcie0_axi_s_clk_src",
 		.parent_data = gcc_xo_gpll0_gpll4,
 		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll4),
@@ -1286,7 +1286,7 @@ static struct clk_branch gcc_pcie0_axi_s_clk = {
 	.clkr = {
 		.enable_reg = 0x2803c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_pcie0_axi_s_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&pcie0_axi_s_clk_src.clkr.hw
@@ -1303,7 +1303,7 @@ static struct clk_branch gcc_pcie0_axi_s_bridge_clk = {
 	.clkr = {
 		.enable_reg = 0x28040,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_pcie0_axi_s_bridge_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&pcie0_axi_s_clk_src.clkr.hw
@@ -1320,7 +1320,7 @@ static struct clk_branch gcc_snoc_pcie0_1lane_s_clk = {
 	.clkr = {
 		.enable_reg = 0x2e048,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_snoc_pcie0_1lane_s_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&pcie0_axi_s_clk_src.clkr.hw
@@ -1337,7 +1337,7 @@ static struct clk_rcg2 pcie1_axi_s_clk_src = {
 	.freq_tbl = ftbl_pcie0_axi_m_clk_src,
 	.hid_width = 5,
 	.parent_map = gcc_xo_gpll0_gpll4_map,
-	.clkr.hw.init = &(struct clk_init_data) {
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "pcie1_axi_s_clk_src",
 		.parent_data = gcc_xo_gpll0_gpll4,
 		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll4),
@@ -1350,7 +1350,7 @@ static struct clk_branch gcc_pcie1_axi_s_clk = {
 	.clkr = {
 		.enable_reg = 0x2903c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_pcie1_axi_s_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&pcie1_axi_s_clk_src.clkr.hw
@@ -1367,7 +1367,7 @@ static struct clk_branch gcc_pcie1_axi_s_bridge_clk = {
 	.clkr = {
 		.enable_reg = 0x29040,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_pcie1_axi_s_bridge_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&pcie1_axi_s_clk_src.clkr.hw
@@ -1384,7 +1384,7 @@ static struct clk_branch gcc_snoc_pcie1_1lane_s_clk = {
 	.clkr = {
 		.enable_reg = 0x2e04c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_snoc_pcie1_1lane_s_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&pcie1_axi_s_clk_src.clkr.hw
@@ -1401,7 +1401,7 @@ static struct clk_rcg2 pcie2_axi_s_clk_src = {
 	.freq_tbl = ftbl_pcie0_axi_m_clk_src,
 	.hid_width = 5,
 	.parent_map = gcc_xo_gpll0_gpll4_map,
-	.clkr.hw.init = &(struct clk_init_data) {
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "pcie2_axi_s_clk_src",
 		.parent_data = gcc_xo_gpll0_gpll4,
 		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll4),
@@ -1414,7 +1414,7 @@ static struct clk_branch gcc_pcie2_axi_s_clk = {
 	.clkr = {
 		.enable_reg = 0x2a03c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_pcie2_axi_s_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&pcie2_axi_s_clk_src.clkr.hw
@@ -1431,7 +1431,7 @@ static struct clk_branch gcc_pcie2_axi_s_bridge_clk = {
 	.clkr = {
 		.enable_reg = 0x2a040,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_pcie2_axi_s_bridge_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&pcie2_axi_s_clk_src.clkr.hw
@@ -1448,7 +1448,7 @@ static struct clk_branch gcc_snoc_pcie2_2lane_s_clk = {
 	.clkr = {
 		.enable_reg = 0x2e050,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_snoc_pcie2_2lane_s_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&pcie2_axi_s_clk_src.clkr.hw
@@ -1465,7 +1465,7 @@ static struct clk_rcg2 pcie3_axi_s_clk_src = {
 	.freq_tbl = ftbl_pcie0_axi_m_clk_src,
 	.hid_width = 5,
 	.parent_map = gcc_xo_gpll0_gpll4_map,
-	.clkr.hw.init = &(struct clk_init_data) {
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "pcie3_axi_s_clk_src",
 		.parent_data = gcc_xo_gpll0_gpll4,
 		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll4),
@@ -1478,7 +1478,7 @@ static struct clk_branch gcc_pcie3_axi_s_clk = {
 	.clkr = {
 		.enable_reg = 0x2b03c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_pcie3_axi_s_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&pcie3_axi_s_clk_src.clkr.hw
@@ -1495,7 +1495,7 @@ static struct clk_branch gcc_pcie3_axi_s_bridge_clk = {
 	.clkr = {
 		.enable_reg = 0x2b040,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_pcie3_axi_s_bridge_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&pcie3_axi_s_clk_src.clkr.hw
@@ -1512,7 +1512,7 @@ static struct clk_branch gcc_snoc_pcie3_2lane_s_clk = {
 	.clkr = {
 		.enable_reg = 0x2e054,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_snoc_pcie3_2lane_s_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&pcie3_axi_s_clk_src.clkr.hw
@@ -1527,7 +1527,7 @@ static struct clk_branch gcc_snoc_pcie3_2lane_s_clk = {
 static struct clk_regmap_phy_mux pcie0_pipe_clk_src = {
 	.reg = 0x28064,
 	.clkr = {
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "pcie0_pipe_clk_src",
 			.parent_data = &(const struct clk_parent_data) {
 				.index = DT_PCIE30_PHY0_PIPE_CLK,
@@ -1541,7 +1541,7 @@ static struct clk_regmap_phy_mux pcie0_pipe_clk_src = {
 static struct clk_regmap_phy_mux pcie1_pipe_clk_src = {
 	.reg = 0x29064,
 	.clkr = {
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "pcie1_pipe_clk_src",
 			.parent_data = &(const struct clk_parent_data) {
 				.index = DT_PCIE30_PHY1_PIPE_CLK,
@@ -1555,7 +1555,7 @@ static struct clk_regmap_phy_mux pcie1_pipe_clk_src = {
 static struct clk_regmap_phy_mux pcie2_pipe_clk_src = {
 	.reg = 0x2a064,
 	.clkr = {
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "pcie2_pipe_clk_src",
 			.parent_data = &(const struct clk_parent_data) {
 				.index = DT_PCIE30_PHY2_PIPE_CLK,
@@ -1569,7 +1569,7 @@ static struct clk_regmap_phy_mux pcie2_pipe_clk_src = {
 static struct clk_regmap_phy_mux pcie3_pipe_clk_src = {
 	.reg = 0x2b064,
 	.clkr = {
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "pcie3_pipe_clk_src",
 			.parent_data = &(const struct clk_parent_data) {
 				.index = DT_PCIE30_PHY3_PIPE_CLK,
@@ -1591,7 +1591,7 @@ static struct clk_rcg2 pcie0_rchng_clk_src = {
 	.freq_tbl = ftbl_pcie_rchng_clk_src,
 	.hid_width = 5,
 	.parent_map = gcc_xo_gpll0_map,
-	.clkr.hw.init = &(struct clk_init_data) {
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "pcie0_rchng_clk_src",
 		.parent_data = gcc_xo_gpll0,
 		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
@@ -1604,7 +1604,7 @@ static struct clk_branch gcc_pcie0_rchng_clk = {
 	.clkr = {
 		.enable_reg = 0x28028,
 		.enable_mask = BIT(1),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_pcie0_rchng_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&pcie0_rchng_clk_src.clkr.hw
@@ -1622,7 +1622,7 @@ static struct clk_rcg2 pcie1_rchng_clk_src = {
 	.freq_tbl = ftbl_pcie_rchng_clk_src,
 	.hid_width = 5,
 	.parent_map = gcc_xo_gpll0_map,
-	.clkr.hw.init = &(struct clk_init_data) {
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "pcie1_rchng_clk_src",
 		.parent_data = gcc_xo_gpll0,
 		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
@@ -1635,7 +1635,7 @@ static struct clk_branch gcc_pcie1_rchng_clk = {
 	.clkr = {
 		.enable_reg = 0x29028,
 		.enable_mask = BIT(1),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_pcie1_rchng_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&pcie1_rchng_clk_src.clkr.hw
@@ -1652,7 +1652,7 @@ static struct clk_rcg2 pcie2_rchng_clk_src = {
 	.freq_tbl = ftbl_pcie_rchng_clk_src,
 	.hid_width = 5,
 	.parent_map = gcc_xo_gpll0_map,
-	.clkr.hw.init = &(struct clk_init_data) {
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "pcie2_rchng_clk_src",
 		.parent_data = gcc_xo_gpll0,
 		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
@@ -1665,7 +1665,7 @@ static struct clk_branch gcc_pcie2_rchng_clk = {
 	.clkr = {
 		.enable_reg = 0x2a028,
 		.enable_mask = BIT(1),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_pcie2_rchng_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&pcie2_rchng_clk_src.clkr.hw
@@ -1682,7 +1682,7 @@ static struct clk_rcg2 pcie3_rchng_clk_src = {
 	.freq_tbl = ftbl_pcie_rchng_clk_src,
 	.hid_width = 5,
 	.parent_map = gcc_xo_gpll0_map,
-	.clkr.hw.init = &(struct clk_init_data) {
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "pcie3_rchng_clk_src",
 		.parent_data = gcc_xo_gpll0,
 		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
@@ -1695,7 +1695,7 @@ static struct clk_branch gcc_pcie3_rchng_clk = {
 	.clkr = {
 		.enable_reg = 0x2b028,
 		.enable_mask = BIT(1),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_pcie3_rchng_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&pcie3_rchng_clk_src.clkr.hw
@@ -1718,7 +1718,7 @@ static struct clk_rcg2 pcie_aux_clk_src = {
 	.mnd_width = 16,
 	.hid_width = 5,
 	.parent_map = gcc_xo_gpll0_gpll0_aux_core_pi_sleep_clk_map,
-	.clkr.hw.init = &(struct clk_init_data) {
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "pcie_aux_clk_src",
 		.parent_data = gcc_xo_gpll0_gpll0_aux_core_pi_sleep_clk,
 		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll0_aux_core_pi_sleep_clk),
@@ -1731,7 +1731,7 @@ static struct clk_branch gcc_pcie0_aux_clk = {
 	.clkr = {
 		.enable_reg = 0x28034,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_pcie0_aux_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&pcie_aux_clk_src.clkr.hw
@@ -1748,7 +1748,7 @@ static struct clk_branch gcc_pcie1_aux_clk = {
 	.clkr = {
 		.enable_reg = 0x29034,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_pcie1_aux_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&pcie_aux_clk_src.clkr.hw
@@ -1765,7 +1765,7 @@ static struct clk_branch gcc_pcie2_aux_clk = {
 	.clkr = {
 		.enable_reg = 0x2a034,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_pcie2_aux_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&pcie_aux_clk_src.clkr.hw
@@ -1782,7 +1782,7 @@ static struct clk_branch gcc_pcie3_aux_clk = {
 	.clkr = {
 		.enable_reg = 0x2b034,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_pcie3_aux_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&pcie_aux_clk_src.clkr.hw
@@ -1805,7 +1805,7 @@ static struct clk_rcg2 usb0_aux_clk_src = {
 	.mnd_width = 16,
 	.hid_width = 5,
 	.parent_map = gcc_xo_gpll0_core_pi_sleep_clk_map,
-	.clkr.hw.init = &(struct clk_init_data) {
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "usb0_aux_clk_src",
 		.parent_data = gcc_xo_gpll0_core_pi_sleep_clk,
 		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_core_pi_sleep_clk),
@@ -1818,7 +1818,7 @@ static struct clk_branch gcc_usb0_aux_clk = {
 	.clkr = {
 		.enable_reg = 0x2c048,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_usb0_aux_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&usb0_aux_clk_src.clkr.hw
@@ -1842,7 +1842,7 @@ static struct clk_rcg2 usb0_master_clk_src = {
 	.mnd_width = 8,
 	.hid_width = 5,
 	.parent_map = gcc_xo_gpll0_out_main_div2_gpll0_map,
-	.clkr.hw.init = &(struct clk_init_data) {
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "usb0_master_clk_src",
 		.parent_data = gcc_xo_gpll0_out_main_div2_gpll0,
 		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_out_main_div2_gpll0),
@@ -1855,7 +1855,7 @@ static struct clk_branch gcc_usb0_master_clk = {
 	.clkr = {
 		.enable_reg = 0x2c044,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_usb0_master_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&usb0_master_clk_src.clkr.hw
@@ -1872,7 +1872,7 @@ static struct clk_branch gcc_snoc_usb_clk = {
 	.clkr = {
 		.enable_reg = 0x2e058,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_snoc_usb_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&usb0_master_clk_src.clkr.hw
@@ -1889,7 +1889,7 @@ static struct clk_branch gcc_anoc_usb_axi_clk = {
 	.clkr = {
 		.enable_reg = 0x2e084,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_anoc_usb_axi_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&usb0_master_clk_src.clkr.hw
@@ -1913,7 +1913,7 @@ static struct clk_rcg2 usb0_mock_utmi_clk_src = {
 	.mnd_width = 8,
 	.hid_width = 5,
 	.parent_map = gcc_xo_gpll4_gpll0_gpll0_out_main_div2_map,
-	.clkr.hw.init = &(struct clk_init_data) {
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "usb0_mock_utmi_clk_src",
 		.parent_data = gcc_xo_gpll4_gpll0_gpll0_out_main_div2,
 		.num_parents = ARRAY_SIZE(gcc_xo_gpll4_gpll0_gpll0_out_main_div2),
@@ -1925,7 +1925,7 @@ static struct clk_regmap_div usb0_mock_utmi_div_clk_src = {
 	.reg = 0x2c040,
 	.shift = 0,
 	.width = 2,
-	.clkr.hw.init = &(struct clk_init_data) {
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "usb0_mock_utmi_div_clk_src",
 		.parent_data = &(const struct clk_parent_data) {
 			.hw = &usb0_mock_utmi_clk_src.clkr.hw,
@@ -1941,7 +1941,7 @@ static struct clk_branch gcc_usb0_mock_utmi_clk = {
 	.clkr = {
 		.enable_reg = 0x2c04c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_usb0_mock_utmi_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&usb0_mock_utmi_div_clk_src.clkr.hw
@@ -1959,7 +1959,7 @@ static struct clk_regmap_mux usb0_pipe_clk_src = {
 	.width = 2,
 	.parent_map = gcc_usb3phy_0_cc_pipe_clk_xo_map,
 	.clkr = {
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "usb0_pipe_clk_src",
 			.parent_data = gcc_usb3phy_0_cc_pipe_clk_xo,
 			.num_parents = ARRAY_SIZE(gcc_usb3phy_0_cc_pipe_clk_xo),
@@ -1988,7 +1988,7 @@ static struct clk_rcg2 sdcc1_apps_clk_src = {
 	.mnd_width = 8,
 	.hid_width = 5,
 	.parent_map = gcc_xo_gpll0_gpll2_gpll0_out_main_div2_map,
-	.clkr.hw.init = &(struct clk_init_data) {
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "sdcc1_apps_clk_src",
 		.parent_data = gcc_xo_gpll0_gpll2_gpll0_out_main_div2,
 		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll2_gpll0_out_main_div2),
@@ -2001,7 +2001,7 @@ static struct clk_branch gcc_sdcc1_apps_clk = {
 	.clkr = {
 		.enable_reg = 0x3302c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_sdcc1_apps_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&sdcc1_apps_clk_src.clkr.hw
@@ -2024,7 +2024,7 @@ static struct clk_rcg2 sdcc1_ice_core_clk_src = {
 	.mnd_width = 8,
 	.hid_width = 5,
 	.parent_map = gcc_xo_gpll0_gpll4_gpll0_div2_map,
-	.clkr.hw.init = &(struct clk_init_data) {
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "sdcc1_ice_core_clk_src",
 		.parent_data = gcc_xo_gpll0_gpll4_gpll0_div2,
 		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll4_gpll0_div2),
@@ -2037,7 +2037,7 @@ static struct clk_branch gcc_sdcc1_ice_core_clk = {
 	.clkr = {
 		.enable_reg = 0x33030,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_sdcc1_ice_core_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&sdcc1_ice_core_clk_src.clkr.hw
@@ -2062,7 +2062,7 @@ static struct clk_rcg2 pcnoc_bfdcd_clk_src = {
 	.freq_tbl = ftbl_pcnoc_bfdcd_clk_src,
 	.hid_width = 5,
 	.parent_map = gcc_xo_gpll0_gpll0_out_main_div2_map,
-	.clkr.hw.init = &(struct clk_init_data) {
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "pcnoc_bfdcd_clk_src",
 		.parent_data = gcc_xo_gpll0_gpll0_out_main_div2,
 		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll0_out_main_div2),
@@ -2076,7 +2076,7 @@ static struct clk_branch gcc_nsscfg_clk = {
 	.clkr = {
 		.enable_reg = 0x1702c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_nsscfg_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&pcnoc_bfdcd_clk_src.clkr.hw
@@ -2093,7 +2093,7 @@ static struct clk_branch gcc_nssnoc_nsscc_clk = {
 	.clkr = {
 		.enable_reg = 0x17030,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_nssnoc_nsscc_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&pcnoc_bfdcd_clk_src.clkr.hw
@@ -2110,7 +2110,7 @@ static struct clk_branch gcc_nsscc_clk = {
 	.clkr = {
 		.enable_reg = 0x17034,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_nsscc_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&pcnoc_bfdcd_clk_src.clkr.hw
@@ -2127,7 +2127,7 @@ static struct clk_branch gcc_nssnoc_pcnoc_1_clk = {
 	.clkr = {
 		.enable_reg = 0x17080,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_nssnoc_pcnoc_1_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&pcnoc_bfdcd_clk_src.clkr.hw
@@ -2144,7 +2144,7 @@ static struct clk_branch gcc_qdss_dap_ahb_clk = {
 	.clkr = {
 		.enable_reg = 0x2d064,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_qdss_dap_ahb_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&pcnoc_bfdcd_clk_src.clkr.hw
@@ -2161,7 +2161,7 @@ static struct clk_branch gcc_qdss_cfg_ahb_clk = {
 	.clkr = {
 		.enable_reg = 0x2d068,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_qdss_cfg_ahb_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&pcnoc_bfdcd_clk_src.clkr.hw
@@ -2178,7 +2178,7 @@ static struct clk_branch gcc_qpic_ahb_clk = {
 	.clkr = {
 		.enable_reg = 0x32010,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_qpic_ahb_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&pcnoc_bfdcd_clk_src.clkr.hw
@@ -2195,7 +2195,7 @@ static struct clk_branch gcc_qpic_clk = {
 	.clkr = {
 		.enable_reg = 0x32014,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_qpic_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&pcnoc_bfdcd_clk_src.clkr.hw
@@ -2213,7 +2213,7 @@ static struct clk_branch gcc_blsp1_ahb_clk = {
 	.clkr = {
 		.enable_reg = 0x0b004,
 		.enable_mask = BIT(4),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_blsp1_ahb_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&pcnoc_bfdcd_clk_src.clkr.hw
@@ -2230,7 +2230,7 @@ static struct clk_branch gcc_mdio_ahb_clk = {
 	.clkr = {
 		.enable_reg = 0x17040,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_mdio_ahb_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&pcnoc_bfdcd_clk_src.clkr.hw
@@ -2248,7 +2248,7 @@ static struct clk_branch gcc_prng_ahb_clk = {
 	.clkr = {
 		.enable_reg = 0x0b004,
 		.enable_mask = BIT(10),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_prng_ahb_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&pcnoc_bfdcd_clk_src.clkr.hw
@@ -2265,7 +2265,7 @@ static struct clk_branch gcc_uniphy0_ahb_clk = {
 	.clkr = {
 		.enable_reg = 0x1704c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_uniphy0_ahb_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&pcnoc_bfdcd_clk_src.clkr.hw
@@ -2282,7 +2282,7 @@ static struct clk_branch gcc_uniphy1_ahb_clk = {
 	.clkr = {
 		.enable_reg = 0x1705c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_uniphy1_ahb_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&pcnoc_bfdcd_clk_src.clkr.hw
@@ -2299,7 +2299,7 @@ static struct clk_branch gcc_uniphy2_ahb_clk = {
 	.clkr = {
 		.enable_reg = 0x1706c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_uniphy2_ahb_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&pcnoc_bfdcd_clk_src.clkr.hw
@@ -2316,7 +2316,7 @@ static struct clk_branch gcc_cmn_12gpll_ahb_clk = {
 	.clkr = {
 		.enable_reg = 0x3a004,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_cmn_12gpll_ahb_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&pcnoc_bfdcd_clk_src.clkr.hw
@@ -2333,7 +2333,7 @@ static struct clk_branch gcc_cmn_12gpll_apu_clk = {
 	.clkr = {
 		.enable_reg = 0x3a00c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_cmn_12gpll_apu_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&pcnoc_bfdcd_clk_src.clkr.hw
@@ -2350,7 +2350,7 @@ static struct clk_branch gcc_pcie0_ahb_clk = {
 	.clkr = {
 		.enable_reg = 0x28030,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_pcie0_ahb_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&pcnoc_bfdcd_clk_src.clkr.hw
@@ -2367,7 +2367,7 @@ static struct clk_branch gcc_pcie1_ahb_clk = {
 	.clkr = {
 		.enable_reg = 0x29030,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_pcie1_ahb_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&pcnoc_bfdcd_clk_src.clkr.hw
@@ -2384,7 +2384,7 @@ static struct clk_branch gcc_pcie2_ahb_clk = {
 	.clkr = {
 		.enable_reg = 0x2a030,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_pcie2_ahb_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&pcnoc_bfdcd_clk_src.clkr.hw
@@ -2401,7 +2401,7 @@ static struct clk_branch gcc_pcie3_ahb_clk = {
 	.clkr = {
 		.enable_reg = 0x2b030,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_pcie3_ahb_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&pcnoc_bfdcd_clk_src.clkr.hw
@@ -2418,7 +2418,7 @@ static struct clk_branch gcc_usb0_phy_cfg_ahb_clk = {
 	.clkr = {
 		.enable_reg = 0x2c05c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_usb0_phy_cfg_ahb_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&pcnoc_bfdcd_clk_src.clkr.hw
@@ -2435,7 +2435,7 @@ static struct clk_branch gcc_sdcc1_ahb_clk = {
 	.clkr = {
 		.enable_reg = 0x33034,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_sdcc1_ahb_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&pcnoc_bfdcd_clk_src.clkr.hw
@@ -2460,7 +2460,7 @@ static struct clk_rcg2 system_noc_bfdcd_clk_src = {
 	.freq_tbl = ftbl_system_noc_bfdcd_clk_src,
 	.hid_width = 5,
 	.parent_map = gcc_xo_gpll0_gpll4_map,
-	.clkr.hw.init = &(struct clk_init_data) {
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "system_noc_bfdcd_clk_src",
 		.parent_data = gcc_xo_gpll0_gpll4,
 		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll4),
@@ -2475,7 +2475,7 @@ static struct clk_branch gcc_q6ss_boot_clk = {
 	.clkr = {
 		.enable_reg = 0x25080,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_q6ss_boot_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&system_noc_bfdcd_clk_src.clkr.hw
@@ -2492,7 +2492,7 @@ static struct clk_branch gcc_nssnoc_snoc_clk = {
 	.clkr = {
 		.enable_reg = 0x17028,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_nssnoc_snoc_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&system_noc_bfdcd_clk_src.clkr.hw
@@ -2509,7 +2509,7 @@ static struct clk_branch gcc_nssnoc_snoc_1_clk = {
 	.clkr = {
 		.enable_reg = 0x1707c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_nssnoc_snoc_1_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&system_noc_bfdcd_clk_src.clkr.hw
@@ -2526,7 +2526,7 @@ static struct clk_branch gcc_qdss_etr_usb_clk = {
 	.clkr = {
 		.enable_reg = 0x2d060,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_qdss_etr_usb_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&system_noc_bfdcd_clk_src.clkr.hw
@@ -2549,7 +2549,7 @@ static struct clk_rcg2 wcss_ahb_clk_src = {
 	.freq_tbl = ftbl_wcss_ahb_clk_src,
 	.hid_width = 5,
 	.parent_map = gcc_xo_gpll0_map,
-	.clkr.hw.init = &(struct clk_init_data) {
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "wcss_ahb_clk_src",
 		.parent_data = gcc_xo_gpll0,
 		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
@@ -2562,7 +2562,7 @@ static struct clk_branch gcc_q6_ahb_clk = {
 	.clkr = {
 		.enable_reg = 0x25014,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_q6_ahb_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&wcss_ahb_clk_src.clkr.hw
@@ -2579,7 +2579,7 @@ static struct clk_branch gcc_q6_ahb_s_clk = {
 	.clkr = {
 		.enable_reg = 0x25018,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_q6_ahb_s_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&wcss_ahb_clk_src.clkr.hw
@@ -2596,7 +2596,7 @@ static struct clk_branch gcc_wcss_ecahb_clk = {
 	.clkr = {
 		.enable_reg = 0x25058,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_wcss_ecahb_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&wcss_ahb_clk_src.clkr.hw
@@ -2613,7 +2613,7 @@ static struct clk_branch gcc_wcss_acmt_clk = {
 	.clkr = {
 		.enable_reg = 0x2505c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_wcss_acmt_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&wcss_ahb_clk_src.clkr.hw
@@ -2630,7 +2630,7 @@ static struct clk_branch gcc_sys_noc_wcss_ahb_clk = {
 	.clkr = {
 		.enable_reg = 0x2e030,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_sys_noc_wcss_ahb_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&wcss_ahb_clk_src.clkr.hw
@@ -2654,7 +2654,7 @@ static struct clk_rcg2 wcss_axi_m_clk_src = {
 	.freq_tbl = ftbl_wcss_axi_m_clk_src,
 	.hid_width = 5,
 	.parent_map = gcc_xo_gpll0_map,
-	.clkr.hw.init = &(struct clk_init_data) {
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "wcss_axi_m_clk_src",
 		.parent_data = gcc_xo_gpll0,
 		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
@@ -2667,7 +2667,7 @@ static struct clk_branch gcc_anoc_wcss_axi_m_clk = {
 	.clkr = {
 		.enable_reg = 0x2e0a8,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_anoc_wcss_axi_m_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&wcss_axi_m_clk_src.clkr.hw
@@ -2689,7 +2689,7 @@ static struct clk_rcg2 qdss_at_clk_src = {
 	.freq_tbl = ftbl_qdss_at_clk_src,
 	.hid_width = 5,
 	.parent_map = gcc_xo_gpll4_gpll0_gpll0_div2_map,
-	.clkr.hw.init = &(struct clk_init_data) {
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "qdss_at_clk_src",
 		.parent_data = gcc_xo_gpll4_gpll0_gpll0_div2,
 		.num_parents = ARRAY_SIZE(gcc_xo_gpll4_gpll0_gpll0_div2),
@@ -2702,7 +2702,7 @@ static struct clk_branch gcc_q6ss_atbm_clk = {
 	.clkr = {
 		.enable_reg = 0x2501c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_q6ss_atbm_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&qdss_at_clk_src.clkr.hw
@@ -2719,7 +2719,7 @@ static struct clk_branch gcc_wcss_dbg_ifc_atb_clk = {
 	.clkr = {
 		.enable_reg = 0x2503c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_wcss_dbg_ifc_atb_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&qdss_at_clk_src.clkr.hw
@@ -2736,7 +2736,7 @@ static struct clk_branch gcc_nssnoc_atb_clk = {
 	.clkr = {
 		.enable_reg = 0x17014,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_nssnoc_atb_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&qdss_at_clk_src.clkr.hw
@@ -2753,7 +2753,7 @@ static struct clk_branch gcc_qdss_at_clk = {
 	.clkr = {
 		.enable_reg = 0x2d038,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_qdss_at_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&qdss_at_clk_src.clkr.hw
@@ -2770,7 +2770,7 @@ static struct clk_branch gcc_sys_noc_at_clk = {
 	.clkr = {
 		.enable_reg = 0x2e038,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_sys_noc_at_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&qdss_at_clk_src.clkr.hw
@@ -2787,7 +2787,7 @@ static struct clk_branch gcc_pcnoc_at_clk = {
 	.clkr = {
 		.enable_reg = 0x31024,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_pcnoc_at_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&qdss_at_clk_src.clkr.hw
@@ -2802,7 +2802,7 @@ static struct clk_branch gcc_pcnoc_at_clk = {
 static struct clk_fixed_factor gcc_eud_at_div_clk_src = {
 	.mult = 1,
 	.div = 6,
-	.hw.init = &(struct clk_init_data) {
+	.hw.init = &(const struct clk_init_data) {
 		.name = "gcc_eud_at_div_clk_src",
 		.parent_hws = (const struct clk_hw *[]) {
 			&qdss_at_clk_src.clkr.hw
@@ -2818,7 +2818,7 @@ static struct clk_branch gcc_usb0_eud_at_clk = {
 	.clkr = {
 		.enable_reg = 0x30004,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_usb0_eud_at_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&gcc_eud_at_div_clk_src.hw
@@ -2835,7 +2835,7 @@ static struct clk_branch gcc_qdss_eud_at_clk = {
 	.clkr = {
 		.enable_reg = 0x2d06c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_qdss_eud_at_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&gcc_eud_at_div_clk_src.hw
@@ -2858,7 +2858,7 @@ static struct clk_rcg2 qdss_stm_clk_src = {
 	.freq_tbl = ftbl_qdss_stm_clk_src,
 	.hid_width = 5,
 	.parent_map = gcc_xo_gpll0_gpll0_out_main_div2_map,
-	.clkr.hw.init = &(struct clk_init_data) {
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "qdss_stm_clk_src",
 		.parent_data = gcc_xo_gpll0_gpll0_out_main_div2,
 		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll0_out_main_div2),
@@ -2871,7 +2871,7 @@ static struct clk_branch gcc_qdss_stm_clk = {
 	.clkr = {
 		.enable_reg = 0x2d03c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_qdss_stm_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&qdss_stm_clk_src.clkr.hw
@@ -2888,7 +2888,7 @@ static struct clk_branch gcc_sys_noc_qdss_stm_axi_clk = {
 	.clkr = {
 		.enable_reg = 0x2e034,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_sys_noc_qdss_stm_axi_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&qdss_stm_clk_src.clkr.hw
@@ -2910,7 +2910,7 @@ static struct clk_rcg2 qdss_traceclkin_clk_src = {
 	.freq_tbl = ftbl_qdss_traceclkin_clk_src,
 	.hid_width = 5,
 	.parent_map = gcc_xo_gpll4_gpll0_gpll0_div2_map,
-	.clkr.hw.init = &(struct clk_init_data) {
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "qdss_traceclkin_clk_src",
 		.parent_data = gcc_xo_gpll4_gpll0_gpll0_div2,
 		.num_parents = ARRAY_SIZE(gcc_xo_gpll4_gpll0_gpll0_div2),
@@ -2923,7 +2923,7 @@ static struct clk_branch gcc_qdss_traceclkin_clk = {
 	.clkr = {
 		.enable_reg = 0x2d040,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_qdss_traceclkin_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&qdss_traceclkin_clk_src.clkr.hw
@@ -2945,7 +2945,7 @@ static struct clk_rcg2 qdss_tsctr_clk_src = {
 	.freq_tbl = ftbl_qdss_tsctr_clk_src,
 	.hid_width = 5,
 	.parent_map = gcc_xo_gpll4_gpll0_gpll0_div2_map,
-	.clkr.hw.init = &(struct clk_init_data) {
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "qdss_tsctr_clk_src",
 		.parent_data = gcc_xo_gpll4_gpll0_gpll0_div2,
 		.num_parents = ARRAY_SIZE(gcc_xo_gpll4_gpll0_gpll0_div2),
@@ -2956,7 +2956,7 @@ static struct clk_rcg2 qdss_tsctr_clk_src = {
 static struct clk_fixed_factor qdss_tsctr_div2_clk_src = {
 	.mult = 1,
 	.div = 2,
-	.hw.init = &(struct clk_init_data) {
+	.hw.init = &(const struct clk_init_data) {
 		.name = "qdss_tsctr_div2_clk_src",
 		.parent_hws = (const struct clk_hw *[]) {
 			&qdss_tsctr_clk_src.clkr.hw
@@ -2972,7 +2972,7 @@ static struct clk_branch gcc_q6_tsctr_1to2_clk = {
 	.clkr = {
 		.enable_reg = 0x25020,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_q6_tsctr_1to2_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&qdss_tsctr_div2_clk_src.hw
@@ -2989,7 +2989,7 @@ static struct clk_branch gcc_wcss_dbg_ifc_nts_clk = {
 	.clkr = {
 		.enable_reg = 0x25040,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_wcss_dbg_ifc_nts_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&qdss_tsctr_div2_clk_src.hw
@@ -3006,7 +3006,7 @@ static struct clk_branch gcc_qdss_tsctr_div2_clk = {
 	.clkr = {
 		.enable_reg = 0x2d044,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_qdss_tsctr_div2_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&qdss_tsctr_div2_clk_src.hw
@@ -3029,7 +3029,7 @@ static struct clk_rcg2 uniphy_sys_clk_src = {
 	.mnd_width = 8,
 	.hid_width = 5,
 	.parent_map = gcc_xo_map,
-	.clkr.hw.init = &(struct clk_init_data) {
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "uniphy_sys_clk_src",
 		.parent_data = gcc_xo_data,
 		.num_parents = ARRAY_SIZE(gcc_xo_data),
@@ -3043,7 +3043,7 @@ static struct clk_rcg2 nss_ts_clk_src = {
 	.mnd_width = 8,
 	.hid_width = 5,
 	.parent_map = gcc_xo_map,
-	.clkr.hw.init = &(struct clk_init_data) {
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "nss_ts_clk_src",
 		.parent_data = gcc_xo_data,
 		.num_parents = ARRAY_SIZE(gcc_xo_data),
@@ -3056,7 +3056,7 @@ static struct clk_branch gcc_qdss_ts_clk = {
 	.clkr = {
 		.enable_reg = 0x2d078,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_qdss_ts_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&nss_ts_clk_src.clkr.hw
@@ -3071,7 +3071,7 @@ static struct clk_branch gcc_qdss_ts_clk = {
 static struct clk_fixed_factor qdss_dap_sync_clk_src = {
 	.mult = 1,
 	.div = 4,
-	.hw.init = &(struct clk_init_data) {
+	.hw.init = &(const struct clk_init_data) {
 		.name = "qdss_dap_sync_clk_src",
 		.parent_hws = (const struct clk_hw *[]) {
 			&qdss_tsctr_clk_src.clkr.hw
@@ -3086,7 +3086,7 @@ static struct clk_branch gcc_qdss_tsctr_div4_clk = {
 	.clkr = {
 		.enable_reg = 0x2d04c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_qdss_tsctr_div4_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&qdss_dap_sync_clk_src.hw
@@ -3101,7 +3101,7 @@ static struct clk_branch gcc_qdss_tsctr_div4_clk = {
 static struct clk_fixed_factor qdss_tsctr_div8_clk_src = {
 	.mult = 1,
 	.div = 8,
-	.hw.init = &(struct clk_init_data) {
+	.hw.init = &(const struct clk_init_data) {
 		.name = "qdss_tsctr_div8_clk_src",
 		.parent_hws = (const struct clk_hw *[]) {
 			&qdss_tsctr_clk_src.clkr.hw
@@ -3116,7 +3116,7 @@ static struct clk_branch gcc_nss_ts_clk = {
 	.clkr = {
 		.enable_reg = 0x17018,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_nss_ts_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&nss_ts_clk_src.clkr.hw
@@ -3133,7 +3133,7 @@ static struct clk_branch gcc_qdss_tsctr_div8_clk = {
 	.clkr = {
 		.enable_reg = 0x2d050,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_qdss_tsctr_div8_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&qdss_tsctr_div8_clk_src.hw
@@ -3148,7 +3148,7 @@ static struct clk_branch gcc_qdss_tsctr_div8_clk = {
 static struct clk_fixed_factor qdss_tsctr_div16_clk_src = {
 	.mult = 1,
 	.div = 16,
-	.hw.init = &(struct clk_init_data) {
+	.hw.init = &(const struct clk_init_data) {
 		.name = "qdss_tsctr_div16_clk_src",
 		.parent_hws = (const struct clk_hw *[]) {
 			&qdss_tsctr_clk_src.clkr.hw
@@ -3163,7 +3163,7 @@ static struct clk_branch gcc_qdss_tsctr_div16_clk = {
 	.clkr = {
 		.enable_reg = 0x2d054,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_qdss_tsctr_div16_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&qdss_tsctr_div16_clk_src.hw
@@ -3180,7 +3180,7 @@ static struct clk_branch gcc_q6ss_pclkdbg_clk = {
 	.clkr = {
 		.enable_reg = 0x25024,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_q6ss_pclkdbg_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&qdss_dap_sync_clk_src.hw
@@ -3197,7 +3197,7 @@ static struct clk_branch gcc_q6ss_trig_clk = {
 	.clkr = {
 		.enable_reg = 0x25068,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_q6ss_trig_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&qdss_dap_sync_clk_src.hw
@@ -3214,7 +3214,7 @@ static struct clk_branch gcc_wcss_dbg_ifc_apb_clk = {
 	.clkr = {
 		.enable_reg = 0x25038,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_wcss_dbg_ifc_apb_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&qdss_dap_sync_clk_src.hw
@@ -3231,7 +3231,7 @@ static struct clk_branch gcc_wcss_dbg_ifc_dapbus_clk = {
 	.clkr = {
 		.enable_reg = 0x25044,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_wcss_dbg_ifc_dapbus_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&qdss_dap_sync_clk_src.hw
@@ -3248,7 +3248,7 @@ static struct clk_branch gcc_qdss_dap_clk = {
 	.clkr = {
 		.enable_reg = 0x2d058,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_qdss_dap_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&qdss_dap_sync_clk_src.hw
@@ -3265,7 +3265,7 @@ static struct clk_branch gcc_qdss_apb2jtag_clk = {
 	.clkr = {
 		.enable_reg = 0x2d05c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_qdss_apb2jtag_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&qdss_dap_sync_clk_src.hw
@@ -3280,7 +3280,7 @@ static struct clk_branch gcc_qdss_apb2jtag_clk = {
 static struct clk_fixed_factor qdss_tsctr_div3_clk_src = {
 	.mult = 1,
 	.div = 3,
-	.hw.init = &(struct clk_init_data) {
+	.hw.init = &(const struct clk_init_data) {
 		.name = "qdss_tsctr_div3_clk_src",
 		.parent_hws = (const struct clk_hw *[]) {
 			&qdss_tsctr_clk_src.clkr.hw
@@ -3295,7 +3295,7 @@ static struct clk_branch gcc_qdss_tsctr_div3_clk = {
 	.clkr = {
 		.enable_reg = 0x2d048,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_qdss_tsctr_div3_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&qdss_tsctr_div3_clk_src.hw
@@ -3321,7 +3321,7 @@ static struct clk_rcg2 qpic_io_macro_clk_src = {
 	.freq_tbl = ftbl_qpic_io_macro_clk_src,
 	.hid_width = 5,
 	.parent_map = gcc_xo_gpll0_gpll2_map,
-	.clkr.hw.init = &(struct clk_init_data) {
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "qpic_io_macro_clk_src",
 		.parent_data = gcc_xo_gpll0_gpll2,
 		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll2),
@@ -3334,7 +3334,7 @@ static struct clk_branch gcc_qpic_io_macro_clk = {
 	.clkr = {
 		.enable_reg = 0x3200c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_qpic_io_macro_clk",
 			.parent_hws = (const struct clk_hw *[]){
 				&qpic_io_macro_clk_src.clkr.hw
@@ -3356,7 +3356,7 @@ static struct clk_rcg2 q6_axi_clk_src = {
 	.freq_tbl = ftbl_q6_axi_clk_src,
 	.hid_width = 5,
 	.parent_map = gcc_xo_gpll0_gpll2_gpll4_pi_sleep_map,
-	.clkr.hw.init = &(struct clk_init_data) {
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "q6_axi_clk_src",
 		.parent_data = gcc_xo_gpll0_gpll2_gpll4_pi_sleep,
 		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll2_gpll4_pi_sleep),
@@ -3369,7 +3369,7 @@ static struct clk_branch gcc_q6_axim_clk = {
 	.clkr = {
 		.enable_reg = 0x2500c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_q6_axim_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&q6_axi_clk_src.clkr.hw
@@ -3387,7 +3387,7 @@ static struct clk_branch gcc_wcss_q6_tbu_clk = {
 	.clkr = {
 		.enable_reg = 0xb00c,
 		.enable_mask = BIT(6),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_wcss_q6_tbu_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&q6_axi_clk_src.clkr.hw
@@ -3404,7 +3404,7 @@ static struct clk_branch gcc_mem_noc_q6_axi_clk = {
 	.clkr = {
 		.enable_reg = 0x19010,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_mem_noc_q6_axi_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&q6_axi_clk_src.clkr.hw
@@ -3433,7 +3433,7 @@ static struct clk_rcg2 q6_axim2_clk_src = {
 	.freq_tbl = ftbl_q6_axim2_clk_src,
 	.hid_width = 5,
 	.parent_map = gcc_xo_gpll0_gpll4_bias_pll_ubinc_clk_map,
-	.clkr.hw.init = &(struct clk_init_data) {
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "q6_axim2_clk_src",
 		.parent_data = gcc_xo_gpll0_gpll4_bias_pll_ubi_nc_clk,
 		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll4_bias_pll_ubi_nc_clk),
@@ -3451,7 +3451,7 @@ static struct clk_rcg2 nssnoc_memnoc_bfdcd_clk_src = {
 	.freq_tbl = ftbl_nssnoc_memnoc_bfdcd_clk_src,
 	.hid_width = 5,
 	.parent_map = gcc_xo_gpll0_gpll0_aux_gpll2_map,
-	.clkr.hw.init = &(struct clk_init_data) {
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "nssnoc_memnoc_bfdcd_clk_src",
 		.parent_data = gcc_xo_gpll0_gpll0_aux_gpll2,
 		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll0_aux_gpll2),
@@ -3464,7 +3464,7 @@ static struct clk_branch gcc_nssnoc_memnoc_clk = {
 	.clkr = {
 		.enable_reg = 0x17024,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_nssnoc_memnoc_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&nssnoc_memnoc_bfdcd_clk_src.clkr.hw
@@ -3481,7 +3481,7 @@ static struct clk_branch gcc_nssnoc_mem_noc_1_clk = {
 	.clkr = {
 		.enable_reg = 0x17084,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_nssnoc_mem_noc_1_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&nssnoc_memnoc_bfdcd_clk_src.clkr.hw
@@ -3498,7 +3498,7 @@ static struct clk_branch gcc_nss_tbu_clk = {
 	.clkr = {
 		.enable_reg = 0xb00c,
 		.enable_mask = BIT(4),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_nss_tbu_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&nssnoc_memnoc_bfdcd_clk_src.clkr.hw
@@ -3515,7 +3515,7 @@ static struct clk_branch gcc_mem_noc_nssnoc_clk = {
 	.clkr = {
 		.enable_reg = 0x19014,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_mem_noc_nssnoc_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&nssnoc_memnoc_bfdcd_clk_src.clkr.hw
@@ -3537,7 +3537,7 @@ static struct clk_rcg2 lpass_axim_clk_src = {
 	.freq_tbl = ftbl_lpass_axim_clk_src,
 	.hid_width = 5,
 	.parent_map = gcc_xo_gpll0_map,
-	.clkr.hw.init = &(struct clk_init_data) {
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "lpass_axim_clk_src",
 		.parent_data = gcc_xo_gpll0,
 		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
@@ -3550,7 +3550,7 @@ static struct clk_rcg2 lpass_sway_clk_src = {
 	.freq_tbl = ftbl_lpass_axim_clk_src,
 	.hid_width = 5,
 	.parent_map = gcc_xo_gpll0_map,
-	.clkr.hw.init = &(struct clk_init_data) {
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "lpass_sway_clk_src",
 		.parent_data = gcc_xo_gpll0,
 		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
@@ -3569,7 +3569,7 @@ static struct clk_rcg2 adss_pwm_clk_src = {
 	.freq_tbl = ftbl_adss_pwm_clk_src,
 	.hid_width = 5,
 	.parent_map = gcc_xo_gpll0_map,
-	.clkr.hw.init = &(struct clk_init_data) {
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "adss_pwm_clk_src",
 		.parent_data = gcc_xo_gpll0,
 		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
@@ -3582,7 +3582,7 @@ static struct clk_branch gcc_adss_pwm_clk = {
 	.clkr = {
 		.enable_reg = 0x1c00c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_adss_pwm_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&adss_pwm_clk_src.clkr.hw
@@ -3605,7 +3605,7 @@ static struct clk_rcg2 gp1_clk_src = {
 	.freq_tbl = ftbl_gp1_clk_src,
 	.hid_width = 5,
 	.parent_map = gcc_xo_gpll0_gpll0_sleep_clk_map,
-	.clkr.hw.init = &(struct clk_init_data) {
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "gp1_clk_src",
 		.parent_data = gcc_xo_gpll0_gpll0_sleep_clk,
 		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll0_sleep_clk),
@@ -3618,7 +3618,7 @@ static struct clk_rcg2 gp2_clk_src = {
 	.freq_tbl = ftbl_gp1_clk_src,
 	.hid_width = 5,
 	.parent_map = gcc_xo_gpll0_gpll0_sleep_clk_map,
-	.clkr.hw.init = &(struct clk_init_data) {
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "gp2_clk_src",
 		.parent_data = gcc_xo_gpll0_gpll0_sleep_clk,
 		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll0_sleep_clk),
@@ -3631,7 +3631,7 @@ static struct clk_rcg2 gp3_clk_src = {
 	.freq_tbl = ftbl_gp1_clk_src,
 	.hid_width = 5,
 	.parent_map = gcc_xo_gpll0_gpll0_sleep_clk_map,
-	.clkr.hw.init = &(struct clk_init_data) {
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "gp3_clk_src",
 		.parent_data = gcc_xo_gpll0_gpll0_sleep_clk,
 		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll0_sleep_clk),
@@ -3644,7 +3644,7 @@ static struct clk_branch gcc_xo_clk_src = {
 	.clkr = {
 		.enable_reg = 0x34004,
 		.enable_mask = BIT(1),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_xo_clk_src",
 			.parent_data = gcc_xo_data,
 			.num_parents = ARRAY_SIZE(gcc_xo_data),
@@ -3659,7 +3659,7 @@ static struct clk_branch gcc_nssnoc_xo_dcd_clk = {
 	.clkr = {
 		.enable_reg = 0x17074,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_nssnoc_xo_dcd_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&gcc_xo_clk_src.clkr.hw
@@ -3676,7 +3676,7 @@ static struct clk_branch gcc_xo_clk = {
 	.clkr = {
 		.enable_reg = 0x34018,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_xo_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&gcc_xo_clk_src.clkr.hw
@@ -3693,7 +3693,7 @@ static struct clk_branch gcc_uniphy0_sys_clk = {
 	.clkr = {
 		.enable_reg = 0x17048,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_uniphy0_sys_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&uniphy_sys_clk_src.clkr.hw
@@ -3710,7 +3710,7 @@ static struct clk_branch gcc_uniphy1_sys_clk = {
 	.clkr = {
 		.enable_reg = 0x17058,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_uniphy1_sys_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&uniphy_sys_clk_src.clkr.hw
@@ -3727,7 +3727,7 @@ static struct clk_branch gcc_uniphy2_sys_clk = {
 	.clkr = {
 		.enable_reg = 0x17068,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_uniphy2_sys_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&uniphy_sys_clk_src.clkr.hw
@@ -3744,7 +3744,7 @@ static struct clk_branch gcc_cmn_12gpll_sys_clk = {
 	.clkr = {
 		.enable_reg = 0x3a008,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_cmn_12gpll_sys_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&uniphy_sys_clk_src.clkr.hw
@@ -3759,7 +3759,7 @@ static struct clk_branch gcc_cmn_12gpll_sys_clk = {
 static struct clk_fixed_factor gcc_xo_div4_clk_src = {
 	.mult = 1,
 	.div = 4,
-	.hw.init = &(struct clk_init_data) {
+	.hw.init = &(const struct clk_init_data) {
 		.name = "gcc_xo_div4_clk_src",
 		.parent_hws = (const struct clk_hw *[]) {
 			&gcc_xo_clk_src.clkr.hw
@@ -3775,7 +3775,7 @@ static struct clk_branch gcc_nssnoc_qosgen_ref_clk = {
 	.clkr = {
 		.enable_reg = 0x1701c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_nssnoc_qosgen_ref_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&gcc_xo_div4_clk_src.hw
@@ -3792,7 +3792,7 @@ static struct clk_branch gcc_nssnoc_timeout_ref_clk = {
 	.clkr = {
 		.enable_reg = 0x17020,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_nssnoc_timeout_ref_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&gcc_xo_div4_clk_src.hw
@@ -3809,7 +3809,7 @@ static struct clk_branch gcc_xo_div4_clk = {
 	.clkr = {
 		.enable_reg = 0x3401c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data) {
+		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_xo_div4_clk",
 			.parent_hws = (const struct clk_hw *[]) {
 				&gcc_xo_div4_clk_src.hw
-- 
2.17.1

