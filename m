Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45BE36767AF
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 18:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjAUReQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 12:34:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjAUReH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 12:34:07 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B26023D9F;
        Sat, 21 Jan 2023 09:34:06 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30LGtvkq001872;
        Sat, 21 Jan 2023 17:34:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=lmeM+DB2VDIPrS3hzzoUz5qgNKJjawV/XSN9MCTs++0=;
 b=OHKv9YdSbZYgMKSiGLEUrnILVfCuYaEgUm8gxY0hXkfLQyoZf6edPjPG5jAUfivGGyWd
 0j8yF7TsyBjUDf0iDWpVNeI6dBF01EvgRYOKctH3PHKcj8VOJI82GpCeig7UjFjUC42E
 1ErRbtgovcHBDStNfjxJaekiKdUXNZ1zrepAS0eR2SkRjNjmqkxTvxUa0NmWHrvlVwUJ
 vBZBXN0mT3GLCjs8eVdc854H5Gjn15n/mFp9OIJYSwNcaIRdMwuKaWsGFrOuFDEPKh1U
 7l8/ttDgju5rEYCrMZABYqrtujdNtPWM9guFaiW0f1X6BE8+ISXgDNKX2q60KfsG7PLP cw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n89htrny3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 21 Jan 2023 17:33:59 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30LHXwad023790
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 21 Jan 2023 17:33:58 GMT
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Sat, 21 Jan 2023 09:33:54 -0800
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <swboyd@chromium.org>, <agross@kernel.org>, <andersson@kernel.org>,
        <robh+dt@kernel.org>, <broonie@kernel.org>,
        <quic_plai@quicinc.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <konrad.dybcio@somainline.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [RESEND v5 3/6] clk: qcom: lpasscc-sc7280: Skip qdsp6ss clock registration
Date:   Sat, 21 Jan 2023 23:02:17 +0530
Message-ID: <1674322340-25882-4-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1674322340-25882-1-git-send-email-quic_srivasam@quicinc.com>
References: <1674322340-25882-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: q02MSg5nL5rZYlcIwIzuWF56u6tobd7M
X-Proofpoint-GUID: q02MSg5nL5rZYlcIwIzuWF56u6tobd7M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-21_11,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 mlxlogscore=999 suspectscore=0 clxscore=1015 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301210169
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The qdsp6ss memory region is being shared by ADSP remoteproc device and
lpasscc clock device, hence causing memory conflict.
As the qdsp6ss clocks are being enabled in remoteproc driver, skip qdsp6ss
clock registration if "qcom,adsp-pil-mode" is enabled.

Fixes: 4ab43d171181 ("clk: qcom: Add lpass clock controller driver for SC7280")
Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Tested-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/clk/qcom/lpasscc-sc7280.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/qcom/lpasscc-sc7280.c b/drivers/clk/qcom/lpasscc-sc7280.c
index 5c1e17b..85dd5b9 100644
--- a/drivers/clk/qcom/lpasscc-sc7280.c
+++ b/drivers/clk/qcom/lpasscc-sc7280.c
@@ -118,12 +118,14 @@ static int lpass_cc_sc7280_probe(struct platform_device *pdev)
 		goto destroy_pm_clk;
 	}
 
-	lpass_regmap_config.name = "qdsp6ss";
-	desc = &lpass_qdsp6ss_sc7280_desc;
+	if (!of_property_read_bool(pdev->dev.of_node, "qcom,adsp-pil-mode")) {
+		lpass_regmap_config.name = "qdsp6ss";
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
2.7.4

