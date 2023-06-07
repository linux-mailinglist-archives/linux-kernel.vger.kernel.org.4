Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 981B3725C7F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 13:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240109AbjFGLA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 07:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240453AbjFGLAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 07:00:07 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9441BF7;
        Wed,  7 Jun 2023 03:58:44 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3575Li4h019759;
        Wed, 7 Jun 2023 10:57:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=UM+Hot4o78/iHbAP5+OzXNzvYsZB6jnxy+maXjSOyOg=;
 b=Tgrmlj3XU7A/VxCSNtvh2bVnJw1CvvBLTh12leoL4olMAvcaECBrbVkzgyWpw6O52Tkj
 ej2qbNJ2UyH/321JsNNlU426r47cDscqdiaCEtiLX0jY7rNJtCCk3Y1bSszogw1EbeBv
 rpseyyHfDniv2lkJduMIuMlz19VWBFa1q9zXvTwDWm/fpMEnkeLJFpwxl0Xgd4Lv1ZWZ
 khY6VKI4DaCOUWM234wVDBM67gDr+v5pRuYkVgk8pd+Ha07Md8RC6Vljc8q0mgsYSgl8
 a9VNmxXn1yg4vFEp7vJmlcPl5NYWenRLB82mHxmLzgQqW2UucRYdCEaNoanW6nCROFcb 8w== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r2a719mc7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jun 2023 10:57:05 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 357Av5Ak023479
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 7 Jun 2023 10:57:05 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 7 Jun 2023 03:56:56 -0700
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <p.zabel@pengutronix.de>, <arnd@arndb.de>,
        <geert+renesas@glider.be>, <neil.armstrong@linaro.org>,
        <nfraprado@collabora.com>, <broonie@kernel.org>,
        <rafal@milecki.pl>, <quic_srichara@quicinc.com>,
        <quic_varada@quicinc.org>, <quic_wcheng@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-clk@vger.kernel.org>
CC:     Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH 4/9] clk: qcom: ipq5332: Fix USB related clock defines
Date:   Wed, 7 Jun 2023 16:26:08 +0530
Message-ID: <3840e5b5795ef55ecbf25d0faa8c328f09c6d976.1686126439.git.quic_varada@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1686126439.git.quic_varada@quicinc.com>
References: <cover.1686126439.git.quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Z2TsTwjIBn2S3qlWPRVHa0LxQyJiosUC
X-Proofpoint-ORIG-GUID: Z2TsTwjIBn2S3qlWPRVHa0LxQyJiosUC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_06,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 mlxlogscore=999
 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306070089
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the USB related clock defines and add details
referenced by them

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
 drivers/clk/qcom/gcc-ipq5332.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/qcom/gcc-ipq5332.c b/drivers/clk/qcom/gcc-ipq5332.c
index a75ab88..2b58558 100644
--- a/drivers/clk/qcom/gcc-ipq5332.c
+++ b/drivers/clk/qcom/gcc-ipq5332.c
@@ -351,6 +351,16 @@ static const struct freq_tbl ftbl_gcc_adss_pwm_clk_src[] = {
 	{ }
 };
 
+static const struct clk_parent_data gcc_usb3phy_0_cc_pipe_clk_xo[] = {
+	{ .fw_name = "usb3phy_0_cc_pipe_clk" },
+	{ .fw_name = "xo" },
+};
+
+static const struct parent_map gcc_usb3phy_0_cc_pipe_clk_xo_map[] = {
+	{ P_USB3PHY_0_PIPE, 0 },
+	{ P_XO, 2 },
+};
+
 static struct clk_rcg2 gcc_adss_pwm_clk_src = {
 	.cmd_rcgr = 0x1c004,
 	.mnd_width = 0,
@@ -1101,16 +1111,18 @@ static struct clk_rcg2 gcc_usb0_mock_utmi_clk_src = {
 	},
 };
 
-static struct clk_regmap_phy_mux gcc_usb0_pipe_clk_src = {
+static struct clk_regmap_mux usb0_pipe_clk_src = {
 	.reg = 0x2c074,
+	.shift = 8,
+	.width = 2,
+	.parent_map = gcc_usb3phy_0_cc_pipe_clk_xo_map,
 	.clkr = {
-		.hw.init = &(struct clk_init_data) {
-			.name = "gcc_usb0_pipe_clk_src",
-			.parent_data = &(const struct clk_parent_data) {
-				.index = DT_USB_PCIE_WRAPPER_PIPE_CLK,
-			},
-			.num_parents = 1,
-			.ops = &clk_regmap_phy_mux_ops,
+		.hw.init = &(const struct clk_init_data){
+			.name = "usb0phy_0_cc_pipe_clk_src",
+			.parent_data = gcc_usb3phy_0_cc_pipe_clk_xo,
+			.num_parents = 2,
+			.ops = &clk_regmap_mux_closest_ops,
+			.flags = CLK_SET_RATE_PARENT,
 		},
 	},
 };
@@ -3041,8 +3053,8 @@ static struct clk_branch gcc_usb0_pipe_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_usb0_pipe_clk",
-			.parent_hws = (const struct clk_hw*[]) {
-				&gcc_usb0_pipe_clk_src.clkr.hw,
+			.parent_names = (const char *[]){
+				"usb0_pipe_clk_src"
 			},
 			.num_parents = 1,
 			.flags = CLK_SET_RATE_PARENT,
@@ -3580,7 +3592,7 @@ static struct clk_regmap *gcc_ipq5332_clocks[] = {
 	[GCC_PCIE3X2_PIPE_CLK_SRC] = &gcc_pcie3x2_pipe_clk_src.clkr,
 	[GCC_PCIE3X1_0_PIPE_CLK_SRC] = &gcc_pcie3x1_0_pipe_clk_src.clkr,
 	[GCC_PCIE3X1_1_PIPE_CLK_SRC] = &gcc_pcie3x1_1_pipe_clk_src.clkr,
-	[GCC_USB0_PIPE_CLK_SRC] = &gcc_usb0_pipe_clk_src.clkr,
+	[GCC_USB0_PIPE_CLK_SRC] = &usb0_pipe_clk_src.clkr,
 };
 
 static const struct qcom_reset_map gcc_ipq5332_resets[] = {
-- 
2.7.4

