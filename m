Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5366941C8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 10:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjBMJq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 04:46:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbjBMJqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 04:46:48 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97351706;
        Mon, 13 Feb 2023 01:46:45 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31D8s1Dv011981;
        Mon, 13 Feb 2023 09:46:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=+/6k6xClAQ57FD79WVy/jg5fv7bosxXVuUxNYbtr08I=;
 b=LkYOvKc6ZPebpZ0IqElVo1QUUDBO5NnwwA2m4vpyTg4YKvjuINeI/cgH+xS+Kja4N173
 TDAHjlgU49k+b10qwcyGt86gAhywKPqqb5MDP4mnK1LhOIRYYjAXHgvTjBbT0OdTiHT9
 WUZsg7+D1/qYn1/tuPEv3fVpFTClfwjf8fu03ioxYiXDhejO12qV0GQHxoPVWCjjut8Y
 cDkt+3EzW/PJUMbOnkdMsr9ap2BRgaYutO+MtmN21bOY0KHgZlSLHPwZ2k3v9jAHSLFE
 qTT6PHYj82KnyS7pNFzsBCiURRwmBR4deiKtqwfTtpGn9fgW0aZ21KmUyKJYMIbyndfZ aQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3np0qpurqm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 09:46:39 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31D9kcNL026184
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 09:46:38 GMT
Received: from hu-mohs-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 13 Feb 2023 01:46:32 -0800
From:   Mohammad Rafi Shaik <quic_mohs@quicinc.com>
To:     <swboyd@chromium.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>, <robh+dt@kernel.org>,
        <broonie@kernel.org>, <quic_plai@quicinc.com>,
        <konrad.dybcio@somainline.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>, <quic_visr@quicinc.com>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Subject: [PATCH v8 4/5] clk: qcom: lpassaudiocc-sc7280: Merge AHB clocks into lpass_aon
Date:   Mon, 13 Feb 2023 15:15:27 +0530
Message-ID: <20230213094528.3733509-5-quic_mohs@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230213094528.3733509-1-quic_mohs@quicinc.com>
References: <20230213094528.3733509-1-quic_mohs@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: a39prfC_STL2WaoIeWCa9ZRyHFOi-H-7
X-Proofpoint-ORIG-GUID: a39prfC_STL2WaoIeWCa9ZRyHFOi-H-7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_04,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 mlxlogscore=582
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302130087
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>

Merge AHBM and AHBS clocks into lpass_aon clk_regmap structure as they
are using same register space.
Modify AHB clocks explicit registration, from qcom_cc_probe to
com_cc_probe_by_index.
In existing implementation, Q6 AHB clocks and lpass_aon clocks are
being registered exclusively and overlapping if both of them are
to be used. The regmap region used by Q6 AHB clocks is <0x03389000 0x24>
and of lpass_aon clocks is <0x03380000 0x30000>.
This is required to avoid such overlapping and to register
Q6 AHB clocks and lpass_aon clocks simultaneously.

Fixes: 4ab43d171181 ("clk: qcom: Add lpass clock controller driver for SC7280")
Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Tested-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
---
 drivers/clk/qcom/lpassaudiocc-sc7280.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/lpassaudiocc-sc7280.c b/drivers/clk/qcom/lpassaudiocc-sc7280.c
index 1339f9211a14..533d68d80538 100644
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
@@ -828,8 +830,9 @@ static int lpass_aon_cc_sc7280_probe(struct platform_device *pdev)
 	if (of_property_read_bool(pdev->dev.of_node, "qcom,adsp-pil-mode")) {
 		lpass_audio_cc_sc7280_regmap_config.name = "cc";
 		desc = &lpass_cc_sc7280_desc;
-		ret = qcom_cc_probe(pdev, desc);
-		goto exit;
+		ret = qcom_cc_probe_by_index(pdev, 1, desc);
+		if (!ret)
+			goto exit;
 	}
 
 	lpass_audio_cc_sc7280_regmap_config.name = "lpasscc_aon";
-- 
2.25.1

