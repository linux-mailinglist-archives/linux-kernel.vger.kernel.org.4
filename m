Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 305C47499E0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 12:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbjGFKwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 06:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbjGFKwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 06:52:10 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927981FEA;
        Thu,  6 Jul 2023 03:51:56 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3666QRMr003186;
        Thu, 6 Jul 2023 10:51:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=LRbBxS8Aog1cxdQAmDI4JTjt1cKQOcv2mQ2PRh/lRpQ=;
 b=QaFFnEbk7ebWl52PNAjfPCFAbIpuHgDBNj4neBZVq26LF/xayuxaG8O1Z6+nV4CF9M0i
 wKVPIHALnVdgmhPKzUyIlp2jLi6fzkQrl7hP74iGF1oQkZ766c5JDCuzlQJpzeEMpUYv
 yOeOkO6PUksWilKprtnE1sgO8G7D4qjw/LqA1X1QcUjP0sdwTRj8DKdsJdxAg2q6zXTD
 ZRzcvsMdXXLEl23rLkjzTq8cJxluONO0zuzlGSg6gEOA4DERVuNTRufcfIA4UpQBl95o
 jLIDfW3zGwZOIU9Tb+7IAVF4Wh6jpRatVnPAfO+JwLpJ1ow9zpDwvDmXoE24rNPSZeYS WA== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rndvp1h22-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jul 2023 10:51:52 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 366Appwf020704
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Jul 2023 10:51:51 GMT
Received: from hu-imrashai-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 6 Jul 2023 03:51:46 -0700
From:   Imran Shaik <quic_imrashai@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        "Melody Olvera" <quic_molvera@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>
Subject: [PATCH V3 3/6] clk: qcom: gcc-qdu1000: Fix clkref clocks handling
Date:   Thu, 6 Jul 2023 16:20:42 +0530
Message-ID: <20230706105045.633076-4-quic_imrashai@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230706105045.633076-1-quic_imrashai@quicinc.com>
References: <20230706105045.633076-1-quic_imrashai@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: bEHtYhMPi6fDZYj8sUlCHMYoo1AsKC_U
X-Proofpoint-GUID: bEHtYhMPi6fDZYj8sUlCHMYoo1AsKC_U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-06_07,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 mlxscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307060096
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the gcc clkref clock ops and update the halt_check as per the
latest hw version of QDU1000 and QRU1000 SoCs.

Fixes: 1c9efb0bc040 ("clk: qcom: Add QDU1000 and QRU1000 GCC support")
Co-developed-by: Taniya Das <quic_tdas@quicinc.com>
Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
Signed-off-by: Imran Shaik <quic_imrashai@quicinc.com>
---
Changes since v2:
 - Split the patch as per the review comments
 - Newly added

 drivers/clk/qcom/gcc-qdu1000.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/qcom/gcc-qdu1000.c b/drivers/clk/qcom/gcc-qdu1000.c
index c00d26a3e6df..8df7b7983968 100644
--- a/drivers/clk/qcom/gcc-qdu1000.c
+++ b/drivers/clk/qcom/gcc-qdu1000.c
@@ -1447,14 +1447,13 @@ static struct clk_branch gcc_pcie_0_cfg_ahb_clk = {
 
 static struct clk_branch gcc_pcie_0_clkref_en = {
 	.halt_reg = 0x9c004,
-	.halt_bit = 31,
-	.halt_check = BRANCH_HALT_ENABLE,
+	.halt_check = BRANCH_HALT,
 	.clkr = {
 		.enable_reg = 0x9c004,
 		.enable_mask = BIT(0),
 		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_pcie_0_clkref_en",
-			.ops = &clk_branch_ops,
+			.ops = &clk_branch2_ops,
 		},
 	},
 };
@@ -2274,14 +2273,13 @@ static struct clk_branch gcc_tsc_etu_clk = {
 
 static struct clk_branch gcc_usb2_clkref_en = {
 	.halt_reg = 0x9c008,
-	.halt_bit = 31,
-	.halt_check = BRANCH_HALT_ENABLE,
+	.halt_check = BRANCH_HALT,
 	.clkr = {
 		.enable_reg = 0x9c008,
 		.enable_mask = BIT(0),
 		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_usb2_clkref_en",
-			.ops = &clk_branch_ops,
+			.ops = &clk_branch2_ops,
 		},
 	},
 };
-- 
2.25.1

