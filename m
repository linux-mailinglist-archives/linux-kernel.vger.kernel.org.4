Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 284A97499E8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 12:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbjGFKwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 06:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbjGFKw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 06:52:26 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672E82119;
        Thu,  6 Jul 2023 03:52:08 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3664dglT005531;
        Thu, 6 Jul 2023 10:52:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=DSGCmSUMmD9vqAlEq4+ygEMiWmotZ3551m/1TTc35qE=;
 b=ZkRWn9CEjiIPEGOXuznlJ8lW8QshoaVgfesGdXeG9UgvvL2qQlvxla8M6jfy055c5OEZ
 wAJMHhExBXeBG9NM60xoR0dP7p/Y+miYEfENNRdbWECLDMIPjW/Rhw3WKPmv0oBKo/yg
 mZZqsqMC6UupaUaxrQ+25M49dXI/2xK3bRWO+h/FpiM76/vw/yt/O+V9IYx4hZuSUMmS
 E5Kn3jx3Ij22kIENQ5HTOjIT+yLravxwFA+JtwC2wydI4hLqnR9YjEuPFidUEcd0OJpJ
 ygiT6m2ZWHL53+4rYX8mtsZFn1L6Smi0gIPdHidmEK9YYtB7iPZWiNrb+j6aHTswtoT8 iw== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rnfm4hba0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jul 2023 10:52:04 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 366Aq2Mv011374
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Jul 2023 10:52:02 GMT
Received: from hu-imrashai-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 6 Jul 2023 03:51:56 -0700
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
Subject: [PATCH V3 5/6] clk: qcom: gcc-qdu1000: Add support for GDSCs
Date:   Thu, 6 Jul 2023 16:20:44 +0530
Message-ID: <20230706105045.633076-6-quic_imrashai@quicinc.com>
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
X-Proofpoint-GUID: w7AuDZeVFVSa2LeZCfvlOsLNHuJhc_QC
X-Proofpoint-ORIG-GUID: w7AuDZeVFVSa2LeZCfvlOsLNHuJhc_QC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-06_07,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307060095
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the GDSCs support for QDU1000 and QRU1000 SoCs.

Co-developed-by: Taniya Das <quic_tdas@quicinc.com>
Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
Signed-off-by: Imran Shaik <quic_imrashai@quicinc.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Changes since v2:
 - None
Changes since v1:
 - Newly added

 drivers/clk/qcom/gcc-qdu1000.c | 42 ++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/clk/qcom/gcc-qdu1000.c b/drivers/clk/qcom/gcc-qdu1000.c
index 991fb2bc97e9..718c34dca6e8 100644
--- a/drivers/clk/qcom/gcc-qdu1000.c
+++ b/drivers/clk/qcom/gcc-qdu1000.c
@@ -17,6 +17,7 @@
 #include "clk-regmap-divider.h"
 #include "clk-regmap-mux.h"
 #include "clk-regmap-phy-mux.h"
+#include "gdsc.h"
 #include "reset.h"
 
 enum {
@@ -2409,6 +2410,39 @@ static struct clk_branch gcc_usb3_prim_phy_pipe_clk = {
 	},
 };
 
+static struct gdsc pcie_0_gdsc = {
+	.gdscr = 0x9d004,
+	.en_rest_wait_val = 0x2,
+	.en_few_wait_val = 0x2,
+	.clk_dis_wait_val = 0xf,
+	.pd = {
+		.name = "gcc_pcie_0_gdsc",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+};
+
+static struct gdsc pcie_0_phy_gdsc = {
+	.gdscr = 0x7c004,
+	.en_rest_wait_val = 0x2,
+	.en_few_wait_val = 0x2,
+	.clk_dis_wait_val = 0x2,
+	.pd = {
+		.name = "gcc_pcie_0_phy_gdsc",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+};
+
+static struct gdsc usb30_prim_gdsc = {
+	.gdscr = 0x49004,
+	.en_rest_wait_val = 0x2,
+	.en_few_wait_val = 0x2,
+	.clk_dis_wait_val = 0xf,
+	.pd = {
+		.name = "gcc_usb30_prim_gdsc",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+};
+
 static struct clk_regmap *gcc_qdu1000_clocks[] = {
 	[GCC_AGGRE_NOC_ECPRI_DMA_CLK] = &gcc_aggre_noc_ecpri_dma_clk.clkr,
 	[GCC_AGGRE_NOC_ECPRI_DMA_CLK_SRC] = &gcc_aggre_noc_ecpri_dma_clk_src.clkr,
@@ -2545,6 +2579,12 @@ static struct clk_regmap *gcc_qdu1000_clocks[] = {
 	[GCC_DDRSS_ECPRI_GSI_CLK] = &gcc_ddrss_ecpri_gsi_clk.clkr,
 };
 
+static struct gdsc *gcc_qdu1000_gdscs[] = {
+	[PCIE_0_GDSC] = &pcie_0_gdsc,
+	[PCIE_0_PHY_GDSC] = &pcie_0_phy_gdsc,
+	[USB30_PRIM_GDSC] = &usb30_prim_gdsc,
+};
+
 static const struct qcom_reset_map gcc_qdu1000_resets[] = {
 	[GCC_ECPRI_CC_BCR] = { 0x3e000 },
 	[GCC_ECPRI_SS_BCR] = { 0x3a000 },
@@ -2606,6 +2646,8 @@ static const struct qcom_cc_desc gcc_qdu1000_desc = {
 	.num_clks = ARRAY_SIZE(gcc_qdu1000_clocks),
 	.resets = gcc_qdu1000_resets,
 	.num_resets = ARRAY_SIZE(gcc_qdu1000_resets),
+	.gdscs = gcc_qdu1000_gdscs,
+	.num_gdscs = ARRAY_SIZE(gcc_qdu1000_gdscs),
 };
 
 static const struct of_device_id gcc_qdu1000_match_table[] = {
-- 
2.25.1

