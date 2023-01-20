Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C72B6754F2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 13:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjATMsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 07:48:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbjATMrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 07:47:55 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20C85FF9;
        Fri, 20 Jan 2023 04:47:36 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KClUMo018877;
        Fri, 20 Jan 2023 12:47:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=DCKrb3P7nekSK9eKi2Ps/31DNO6RV37h11YsJzrBZ24=;
 b=GR/kblmlg5HnMw2iPhtyptJ/KspT1tioCxc2ViF/0hCFsKVNDHzqPHaNqQMSg5Wh9kCb
 mCNEHD9Q4CQRl89E0pW2hwKL7cnP5n/I2Bo70p/E5FGR/hrr1A4ogIbspbt6WB1bTJoo
 kD/a5KbLgErUmqLqYwr+slfRobOMkLXow3xI0k+ezYRchOnnT1Mp3Fz4wb/gF2O8IJLP
 wq8Zj6SKigv8EZFzhO68NAVB5NQ1onNUwrmoXRvfLRO/395iU2vQIM9gDn5qVI4A1AMU
 s1ctnXKNaP3tpbMPPAOO0CKgk7O4rzWmh+/ikW2dSXoE9FuXBZLC5nWv/6ktTK11zG+B 2Q== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n6xktkupx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 12:47:30 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30KClT4M024482
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 12:47:29 GMT
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 20 Jan 2023 04:47:24 -0800
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <swboyd@chromium.org>, <agross@kernel.org>, <andersson@kernel.org>,
        <robh+dt@kernel.org>, <broonie@kernel.org>,
        <quic_plai@quicinc.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <konrad.dybcio@somainline.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [PATCH v5 5/6] clk: qcom: lpassaudiocc-sc7280: Merge lpasscc into lpass_aon
Date:   Fri, 20 Jan 2023 18:16:45 +0530
Message-ID: <1674218806-7711-6-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1674218806-7711-1-git-send-email-quic_srivasam@quicinc.com>
References: <1674218806-7711-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1sMRpx3o9B9YR10jVFIRygFSeNwPw3OA
X-Proofpoint-GUID: 1sMRpx3o9B9YR10jVFIRygFSeNwPw3OA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_08,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 clxscore=1015 spamscore=0 mlxlogscore=647 lowpriorityscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301200120
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Merge lpasscc clocks into lpass_aon clk_regmap structure as they
are using same register space.
In existing implementation, lpasscc clocks and lpass_aon clocks are
being registered exclusively and overlapping if both of them are
to be used.
This is required to avoid such overlapping and to register
lpasscc clocks and lpass_aon clocks simultaneously.

Fixes: 4ab43d171181 ("clk: qcom: Add lpass clock controller driver for SC7280")
Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Tested-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
---
 drivers/clk/qcom/lpassaudiocc-sc7280.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/qcom/lpassaudiocc-sc7280.c b/drivers/clk/qcom/lpassaudiocc-sc7280.c
index 1339f92..732ecc4 100644
--- a/drivers/clk/qcom/lpassaudiocc-sc7280.c
+++ b/drivers/clk/qcom/lpassaudiocc-sc7280.c
@@ -660,6 +660,8 @@ static struct clk_regmap *lpass_aon_cc_sc7280_clocks[] = {
 	[LPASS_AON_CC_TX_MCLK_2X_CLK] = &lpass_aon_cc_tx_mclk_2x_clk.clkr,
 	[LPASS_AON_CC_TX_MCLK_CLK] = &lpass_aon_cc_tx_mclk_clk.clkr,
 	[LPASS_AON_CC_TX_MCLK_RCG_CLK_SRC] = &lpass_aon_cc_tx_mclk_rcg_clk_src.clkr,
+	[LPASS_Q6_AHBM_CLK] = &lpass_q6ss_ahbm_clk.clkr,
+	[LPASS_Q6_AHBS_CLK] = &lpass_q6ss_ahbs_clk.clkr,
 };
 
 static struct gdsc *lpass_aon_cc_sc7280_gdscs[] = {
@@ -826,10 +828,12 @@ static int lpass_aon_cc_sc7280_probe(struct platform_device *pdev)
 		return ret;
 
 	if (of_property_read_bool(pdev->dev.of_node, "qcom,adsp-pil-mode")) {
-		lpass_audio_cc_sc7280_regmap_config.name = "cc";
-		desc = &lpass_cc_sc7280_desc;
-		ret = qcom_cc_probe(pdev, desc);
-		goto exit;
+		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cc");
+		if (res) {
+			lpass_audio_cc_sc7280_regmap_config.name = "cc";
+			desc = &lpass_cc_sc7280_desc;
+			return qcom_cc_probe(pdev, desc);
+		}
 	}
 
 	lpass_audio_cc_sc7280_regmap_config.name = "lpasscc_aon";
-- 
2.7.4

