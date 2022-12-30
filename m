Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10986598F4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 14:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235131AbiL3NoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 08:44:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235108AbiL3NoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 08:44:13 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDFD1AA15;
        Fri, 30 Dec 2022 05:44:13 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BUDWEp6019116;
        Fri, 30 Dec 2022 13:44:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=k+N+XGm5mG70mVOuaPJmgJhvVTzSlPQXGIQ2a6p5Nd0=;
 b=Swko4kQCJSkUOQXjqBerlEzwIjlZGjmLSwfjuiTQzGwfaE+IdV6SvGu4Ohbucq4IqqUA
 scEaiA45U8Wx9gvxDcVPdhnzayR4T3WIlBHwnNZfL0lDzTllPZUCUu+AvchQ+oOSNC2Z
 qP9Db7RATT3M54MHPStCOlMx3RQp4TnhS8wlY2KKeqg7IlYgTJEBvoK7P9ZwCBOUbj9K
 870dklkY3CPWB4S5Bm7oU5LmYyofa3DjVioyBcNb7BQ9+WLc2LKHKKMDcLJ0Xe7yW/te
 /22TttS6QsvPTpPuJy12NAdi1mnqMHyD1wO3ngDebDvxey7fZprXamIO/GOzk6YpkjVn FA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mrjugva5x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Dec 2022 13:44:06 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BUDi5ov005694
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Dec 2022 13:44:05 GMT
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 30 Dec 2022 05:44:01 -0800
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <swboyd@chromium.org>, <agross@kernel.org>, <andersson@kernel.org>,
        <robh+dt@kernel.org>, <broonie@kernel.org>,
        <quic_plai@quicinc.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <konrad.dybcio@somainline.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [PATCH v2 4/4] clk: qcom: lpasscc-sc7280: Add resets for audioreach
Date:   Fri, 30 Dec 2022 19:13:19 +0530
Message-ID: <1672407799-13768-5-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1672407799-13768-1-git-send-email-quic_srivasam@quicinc.com>
References: <1672407799-13768-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: JgC_Hw0-izEDzr-Suil4yKuD0UWw8tFJ
X-Proofpoint-GUID: JgC_Hw0-izEDzr-Suil4yKuD0UWw8tFJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-30_08,2022-12-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212300120
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
 drivers/clk/qcom/lpasscc-sc7280.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/clk/qcom/lpasscc-sc7280.c b/drivers/clk/qcom/lpasscc-sc7280.c
index 87e1c21..a7f4ed4 100644
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
@@ -48,6 +50,18 @@ static const struct qcom_cc_desc lpass_cc_top_sc7280_desc = {
 	.num_clks = ARRAY_SIZE(lpass_cc_top_sc7280_clocks),
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
@@ -71,6 +85,13 @@ static int lpass_cc_sc7280_probe(struct platform_device *pdev)
 	if (ret)
 		goto destroy_pm_clk;
 
+	lpass_regmap_config.name = "reset_cgcr";
+	desc = &lpass_audio_cc_reset_sc7280_desc;
+
+	ret = qcom_cc_probe_by_index(pdev, 1, desc);
+	if (ret)
+		goto destroy_pm_clk;
+
 	return 0;
 
 destroy_pm_clk:
-- 
2.7.4

