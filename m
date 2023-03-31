Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E176D23FA
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 17:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233205AbjCaP2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 11:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233214AbjCaP2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 11:28:50 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA5B1D846;
        Fri, 31 Mar 2023 08:28:49 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32VCLVqP021667;
        Fri, 31 Mar 2023 15:28:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=gn5/6UhpryhqjLlUxUtKjAeprTGJZA3/5paRCHsdeN8=;
 b=fVi1lsQRFfzffsWvM9WM2twvEGo8iebXFYUyTk93AysNBH97OTXb1QUqVVxWI09vQDrC
 WLzxAKDsq+BaaarzWzr8/VAwObmbJFzd6rbuE8+gzbZzcSIeDDo9uFNewaASl7f3Uw6A
 1NF0knDFI0CgGuL1Z0959XDQuXdkNkzw/MeFfkpO8urwphfSd7uBJ6w5tJ0HvUykLVVF
 EPV0OvbjjGF5NSPqnmRc9BTtnETcsrnQqWAJT2tP6NMwJ7GzgbPIotH0644PPRIksxSF
 B7S+n2bK0P352SYh9zXEowSULIUF3EvJlqqj0nZ95UPVWzLkKHapkw4Kwc/CdfhXW14Q Ow== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pnyey8t23-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Mar 2023 15:28:43 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32VFSgGt016524
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Mar 2023 15:28:42 GMT
Received: from hu-mohs-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 31 Mar 2023 08:28:37 -0700
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
Subject: [PATCH v10 2/3] clk: qcom: lpasscc-sc7280: Skip qdsp6ss clock registration
Date:   Fri, 31 Mar 2023 20:58:04 +0530
Message-ID: <20230331152805.3199968-3-quic_mohs@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230331152805.3199968-1-quic_mohs@quicinc.com>
References: <20230331152805.3199968-1-quic_mohs@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: m5-3a0bjsPViVZnOA4Qj1kCuU18XpSjb
X-Proofpoint-ORIG-GUID: m5-3a0bjsPViVZnOA4Qj1kCuU18XpSjb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-31_07,2023-03-31_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2303310122
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>

The qdsp6ss memory region is being shared by ADSP remoteproc device and
lpasscc clock device, hence causing memory conflict.
To avoid this, when qdsp6ss clocks are being enabled in remoteproc driver,
skip qdsp6ss clock registration if "qcom,adsp-pil-mode" is enabled.

Fixes: 4ab43d171181 ("clk: qcom: Add lpass clock controller driver for SC7280")
Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/clk/qcom/lpasscc-sc7280.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/qcom/lpasscc-sc7280.c b/drivers/clk/qcom/lpasscc-sc7280.c
index 5c1e17bd0d76..24aeed6bcf0e 100644
--- a/drivers/clk/qcom/lpasscc-sc7280.c
+++ b/drivers/clk/qcom/lpasscc-sc7280.c
@@ -17,6 +17,8 @@
 #include "clk-branch.h"
 #include "common.h"
 
+#define QDSP6SS_MAX_REGISTER		0x3f
+
 static struct clk_branch lpass_top_cc_lpi_q6_axim_hs_clk = {
 	.halt_reg = 0x0,
 	.halt_check = BRANCH_HALT,
@@ -118,12 +120,15 @@ static int lpass_cc_sc7280_probe(struct platform_device *pdev)
 		goto destroy_pm_clk;
 	}
 
-	lpass_regmap_config.name = "qdsp6ss";
-	desc = &lpass_qdsp6ss_sc7280_desc;
+	if (!of_property_read_bool(pdev->dev.of_node, "qcom,adsp-pil-mode")) {
+		lpass_regmap_config.name = "qdsp6ss";
+		lpass_regmap_config.max_register = QDSP6SS_MAX_REGISTER;
+		desc = &lpass_qdsp6ss_sc7280_desc;
 
-	ret = qcom_cc_probe_by_index(pdev, 0, desc);
-	if (ret)
-		goto destroy_pm_clk;
+		ret = qcom_cc_probe_by_index(pdev, 0, desc);
+		if (ret)
+			goto destroy_pm_clk;
+	}
 
 	lpass_regmap_config.name = "top_cc";
 	desc = &lpass_cc_top_sc7280_desc;
-- 
2.25.1

