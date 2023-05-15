Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A17027021FE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 05:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237616AbjEODDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 23:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbjEODDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 23:03:14 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CC710C8;
        Sun, 14 May 2023 20:03:09 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34F2u0Hg012814;
        Mon, 15 May 2023 03:03:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=2PieqsEAV4sxv39i1McboDZR6TpeKwDnoJxMYkJ2cIw=;
 b=CbXNuhiscsWVSeC/jxPNK8L9bekJj6vl/H7E6C+ibc5qlO8mFNcJPPyaE5XnlQMPtbs8
 +JPmyxQgJAmnDC4zBTcOoanGKOg20CP8rRFkBfGaPN4IUExeTuixs4KtNNRioyuexOTf
 v2LwqfqPWysZ5HYXgXFUal6+WmMUkAcAcVg9QMoowxVgHNdoseGdo40RiSNBFmQejGZQ
 gZOwHhTFGFC0QrklNl3tbx61XZSDKUIwPInDEtpcolJSqDYDWVhDf4HXr/aLKJF/aLKK
 L6pQV3vvX1apqBINOJJ9h0k3kxDFTtYg3HxgEvhPh6xytVXYBuk6LZjR6WhCQTklwNnJ mA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qj1gxtnn7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 May 2023 03:03:03 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34F3337V030193
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 May 2023 03:03:03 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Sun, 14 May 2023 20:03:02 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>
CC:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/msm/dp: Clean up pdev/dev duplication in dp_power
Date:   Sun, 14 May 2023 20:02:56 -0700
Message-ID: <20230515030256.300104-3-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230515030256.300104-1-quic_bjorande@quicinc.com>
References: <20230515030256.300104-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IH7g2MK2smO5TxVH9_N9SXfw7d4BmASx
X-Proofpoint-ORIG-GUID: IH7g2MK2smO5TxVH9_N9SXfw7d4BmASx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-14_18,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 spamscore=0
 clxscore=1015 mlxlogscore=999 priorityscore=1501 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305150024
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dp_power module keeps track of both the DP controller's struct
platform_device and struct device - with the prior pulled out of the
dp_parser module.

Clean up the duplication by dropping the platform_device reference and
just track the passed struct device.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 drivers/gpu/drm/msm/dp/dp_power.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_power.c b/drivers/gpu/drm/msm/dp/dp_power.c
index 031d2eefef07..9be645f91211 100644
--- a/drivers/gpu/drm/msm/dp/dp_power.c
+++ b/drivers/gpu/drm/msm/dp/dp_power.c
@@ -14,7 +14,6 @@
 
 struct dp_power_private {
 	struct dp_parser *parser;
-	struct platform_device *pdev;
 	struct device *dev;
 	struct drm_device *drm_dev;
 	struct clk *link_clk_src;
@@ -28,7 +27,7 @@ static int dp_power_clk_init(struct dp_power_private *power)
 {
 	int rc = 0;
 	struct dss_module_power *core, *ctrl, *stream;
-	struct device *dev = &power->pdev->dev;
+	struct device *dev = power->dev;
 
 	core = &power->parser->mp[DP_CORE_PM];
 	ctrl = &power->parser->mp[DP_CTRL_PM];
@@ -153,7 +152,7 @@ int dp_power_client_init(struct dp_power *dp_power)
 
 	power = container_of(dp_power, struct dp_power_private, dp_power);
 
-	pm_runtime_enable(&power->pdev->dev);
+	pm_runtime_enable(power->dev);
 
 	return dp_power_clk_init(power);
 }
@@ -164,7 +163,7 @@ void dp_power_client_deinit(struct dp_power *dp_power)
 
 	power = container_of(dp_power, struct dp_power_private, dp_power);
 
-	pm_runtime_disable(&power->pdev->dev);
+	pm_runtime_disable(power->dev);
 }
 
 int dp_power_init(struct dp_power *dp_power, bool flip)
@@ -174,11 +173,11 @@ int dp_power_init(struct dp_power *dp_power, bool flip)
 
 	power = container_of(dp_power, struct dp_power_private, dp_power);
 
-	pm_runtime_get_sync(&power->pdev->dev);
+	pm_runtime_get_sync(power->dev);
 
 	rc = dp_power_clk_enable(dp_power, DP_CORE_PM, true);
 	if (rc)
-		pm_runtime_put_sync(&power->pdev->dev);
+		pm_runtime_put_sync(power->dev);
 
 	return rc;
 }
@@ -190,7 +189,7 @@ int dp_power_deinit(struct dp_power *dp_power)
 	power = container_of(dp_power, struct dp_power_private, dp_power);
 
 	dp_power_clk_enable(dp_power, DP_CORE_PM, false);
-	pm_runtime_put_sync(&power->pdev->dev);
+	pm_runtime_put_sync(power->dev);
 	return 0;
 }
 
@@ -199,12 +198,11 @@ struct dp_power *dp_power_get(struct device *dev, struct dp_parser *parser)
 	struct dp_power_private *power;
 	struct dp_power *dp_power;
 
-	power = devm_kzalloc(&parser->pdev->dev, sizeof(*power), GFP_KERNEL);
+	power = devm_kzalloc(dev, sizeof(*power), GFP_KERNEL);
 	if (!power)
 		return ERR_PTR(-ENOMEM);
 
 	power->parser = parser;
-	power->pdev = parser->pdev;
 	power->dev = dev;
 
 	dp_power = &power->dp_power;
-- 
2.39.2

