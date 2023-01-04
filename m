Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 654DB65D7C0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 16:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239810AbjADP72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 10:59:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239372AbjADP7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 10:59:02 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36091A042;
        Wed,  4 Jan 2023 07:59:01 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 304EXLir021217;
        Wed, 4 Jan 2023 15:58:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=0lHZ963tDIwG5HKJcK/1mhsvlFtiSGiWC2Jyu5Sui3E=;
 b=aF08d6DpO8yJfvNVlnLTzGBZV4HXxzBRraVw9DmVVZamsQpImDu8OhPTF0zPIbjMxmyw
 qZIwItOP1jMtBUH51X9UDP5AMR3praPcRjX73pKW/RtS+rdBA9EG+ShMfE3KepOB0wVj
 L5iWq399WkZiXE2qAFmJlaU9u4pPL2yMkP4wy8CHPQb3Kq2udSSymdxAoZY73o+RYW4u
 Vyxmpb5NIDR/4uQLqnc2dWJ90eWmmciFGi/BnermKDGK0fM392FuQWfYXQUbNCECTB1l
 nue5NYP/syMjyaseu7uymA6hlxQuZ3gN3niPkI5bKOxXARO6qutxgb/jDr84Th4aP1bn Gw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mvsvgt50n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Jan 2023 15:58:55 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 304FwoFO031879
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 4 Jan 2023 15:58:50 GMT
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 4 Jan 2023 07:58:45 -0800
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <swboyd@chromium.org>, <agross@kernel.org>, <andersson@kernel.org>,
        <robh+dt@kernel.org>, <broonie@kernel.org>,
        <quic_plai@quicinc.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <konrad.dybcio@somainline.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [RESEND v3 4/4] clk: qcom: lpasscc-sc7280: Add resets for audioreach
Date:   Wed, 4 Jan 2023 21:28:12 +0530
Message-ID: <1672847892-25154-5-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1672847892-25154-1-git-send-email-quic_srivasam@quicinc.com>
References: <1672847892-25154-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9Dg5BLOeiMqYewdgzCmbxNrX7bdlptve
X-Proofpoint-ORIG-GUID: 9Dg5BLOeiMqYewdgzCmbxNrX7bdlptve
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-04_07,2023-01-04_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=863
 priorityscore=1501 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301040133
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clock gating control for TX/RX/WSA core bus clocks would be required
to be reset(moved from hardware control) from audio core driver. Thus
add the support for the reset clocks in audioreach based clock driver.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Tested-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
---
 drivers/clk/qcom/lpasscc-sc7280.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/lpasscc-sc7280.c b/drivers/clk/qcom/lpasscc-sc7280.c
index e1af32c..1efb72d 100644
--- a/drivers/clk/qcom/lpasscc-sc7280.c
+++ b/drivers/clk/qcom/lpasscc-sc7280.c
@@ -12,10 +12,12 @@
 #include <linux/regmap.h>
 
 #include <dt-bindings/clock/qcom,lpass-sc7280.h>
+#include <dt-bindings/clock/qcom,lpassaudiocc-sc7280.h>
 
 #include "clk-regmap.h"
 #include "clk-branch.h"
 #include "common.h"
+#include "reset.h"
 
 static struct clk_branch lpass_top_cc_lpi_q6_axim_hs_clk = {
 	.halt_reg = 0x0,
@@ -102,6 +104,18 @@ static const struct qcom_cc_desc lpass_qdsp6ss_sc7280_desc = {
 	.num_clks = ARRAY_SIZE(lpass_qdsp6ss_sc7280_clocks),
 };
 
+static const struct qcom_reset_map lpass_cc_sc7280_resets[] = {
+	[LPASS_AUDIO_SWR_RX_CGCR] =  { 0xa0, 1 },
+	[LPASS_AUDIO_SWR_TX_CGCR] =  { 0xa8, 1 },
+	[LPASS_AUDIO_SWR_WSA_CGCR] = { 0xb0, 1 },
+};
+
+static const struct qcom_cc_desc lpass_audio_cc_reset_sc7280_desc = {
+	.config = &lpass_regmap_config,
+	.resets = lpass_cc_sc7280_resets,
+	.num_resets = ARRAY_SIZE(lpass_cc_sc7280_resets),
+};
+
 static int lpass_cc_sc7280_probe(struct platform_device *pdev)
 {
 	const struct qcom_cc_desc *desc;
@@ -125,7 +139,6 @@ static int lpass_cc_sc7280_probe(struct platform_device *pdev)
 		ret = qcom_cc_probe_by_index(pdev, 0, desc);
 		if (ret)
 			goto destroy_pm_clk;
-		}
 	}
 
 	lpass_regmap_config.name = "top_cc";
@@ -135,6 +148,15 @@ static int lpass_cc_sc7280_probe(struct platform_device *pdev)
 	if (ret)
 		goto destroy_pm_clk;
 
+	if (of_property_read_bool(pdev->dev.of_node, "qcom,adsp-pil-mode")) {
+		lpass_regmap_config.name = "reset_cgcr";
+		desc = &lpass_audio_cc_reset_sc7280_desc;
+
+		ret = qcom_cc_probe_by_index(pdev, 2, desc);
+		if (ret)
+			goto destroy_pm_clk;
+	}
+
 	return 0;
 
 destroy_pm_clk:
-- 
2.7.4

