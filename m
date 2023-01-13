Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18745669B03
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 15:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjAMOxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 09:53:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjAMOwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 09:52:36 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859E47EC88;
        Fri, 13 Jan 2023 06:38:26 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30DDgCvE018314;
        Fri, 13 Jan 2023 14:37:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=TIzwL21/6Eec7RTfa/nt4grL8psh5AsYyGkeDqti/xg=;
 b=fBGu/Gl2vYLFq1BbDfpgwDBZ056Z1Pw9KFUie2sPX5lhCwGoOTLCAh74Bq0dNhq0Foz4
 uL0CRw1bPfqR0FaHSO8X25E8AdakIAfMGR18WrOwJHSkH8UbVWXsf575ntFdpQznNGPM
 DPr+EPMtOy1cvMpA8ohXLitEyRgu3rHHgyDpa82CTOv6GRFiQ2hFYDJew+rAOyet24R5
 fT++GzrRF/7it2VEH96RuMABehZpMyh/dyCR940f2uHjuQ9N2PQ3O87f5BMwB3qwJRQp
 iugZ/rRRhSQX+On0kpeZAthplcpWnU4H/LTYru04Fr28E8Yq/EWqy5sggXn+9Qhae4WO tQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n2jghtys8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 14:37:58 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30DEbvsE000505
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 14:37:57 GMT
Received: from devipriy-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 13 Jan 2023 06:37:49 -0800
From:   devi priya <quic_devipriy@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <jassisinghbrar@gmail.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <shawnguo@kernel.org>, <arnd@arndb.de>,
        <marcel.ziswiler@toradex.com>, <dmitry.baryshkov@linaro.org>,
        <nfraprado@collabora.com>, <broonie@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_poovendh@quicinc.com>
Subject: [PATCH 6/6] clk: qcom: Fix APSS PLL and RCG Configuration
Date:   Fri, 13 Jan 2023 20:06:47 +0530
Message-ID: <20230113143647.14961-7-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230113143647.14961-1-quic_devipriy@quicinc.com>
References: <20230113143647.14961-1-quic_devipriy@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: dfOSr7wANXk6JETj8MnbsuzSbz2-IxvR
X-Proofpoint-ORIG-GUID: dfOSr7wANXk6JETj8MnbsuzSbz2-IxvR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-13_06,2023-01-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 mlxlogscore=922
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301130096
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Included CLK_IS_CRITICAL flag which helps to properly enable
the APSS PLL during bootup.
clk_rcg2_ops should be used for APSS clock RCG, as other ops
will not configure the RCG register

Co-developed-by: Praveenkumar I <quic_ipkumar@quicinc.com>
Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
Signed-off-by: devi priya <quic_devipriy@quicinc.com>
---
 drivers/clk/qcom/apss-ipq-pll.c | 1 +
 drivers/clk/qcom/apss-ipq6018.c | 8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/apss-ipq-pll.c b/drivers/clk/qcom/apss-ipq-pll.c
index dd0c01bf5a98..75486a124fcd 100644
--- a/drivers/clk/qcom/apss-ipq-pll.c
+++ b/drivers/clk/qcom/apss-ipq-pll.c
@@ -33,6 +33,7 @@ static struct clk_alpha_pll ipq_pll = {
 			},
 			.num_parents = 1,
 			.ops = &clk_alpha_pll_huayra_ops,
+			.flags = CLK_IS_CRITICAL,
 		},
 	},
 };
diff --git a/drivers/clk/qcom/apss-ipq6018.c b/drivers/clk/qcom/apss-ipq6018.c
index f2f502e2d5a4..0d0e7196a4dc 100644
--- a/drivers/clk/qcom/apss-ipq6018.c
+++ b/drivers/clk/qcom/apss-ipq6018.c
@@ -33,15 +33,21 @@ static const struct parent_map parents_apcs_alias0_clk_src_map[] = {
 	{ P_APSS_PLL_EARLY, 5 },
 };
 
+static const struct freq_tbl ftbl_apcs_alias0_clk_src[] = {
+	{ .src = P_APSS_PLL_EARLY, .pre_div = 1 },
+	{ }
+};
+
 static struct clk_rcg2 apcs_alias0_clk_src = {
 	.cmd_rcgr = 0x0050,
+	.freq_tbl = ftbl_apcs_alias0_clk_src,
 	.hid_width = 5,
 	.parent_map = parents_apcs_alias0_clk_src_map,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "apcs_alias0_clk_src",
 		.parent_data = parents_apcs_alias0_clk_src,
 		.num_parents = ARRAY_SIZE(parents_apcs_alias0_clk_src),
-		.ops = &clk_rcg2_mux_closest_ops,
+		.ops = &clk_rcg2_ops,
 		.flags = CLK_SET_RATE_PARENT,
 	},
 };
-- 
2.17.1

