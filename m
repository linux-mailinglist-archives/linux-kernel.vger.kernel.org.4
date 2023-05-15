Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14DE37021FA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 05:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234024AbjEODDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 23:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjEODDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 23:03:14 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2663410F0;
        Sun, 14 May 2023 20:03:09 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34F2oCRD010556;
        Mon, 15 May 2023 03:03:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=jEGjD1EqgsIv21poC3vaXgPM07vXS+pks5OM2NnqqbQ=;
 b=cd7/G7axZ3YhmdyIJT3nri6UcHnbBfeRmAtOTfS+a0/rSGv9Ruq/vlY0aUn6ZTrpLeEf
 CzVMOLlI8mChPE/m2aZTrdp+Yh7rpLJS2y8Shl17j5WvbBatdlYILMtzioUXwW50DWH/
 sEE3UWrHnm8uV/D6q8GhAj6zW1XT9TKOptAJRh2W5jcKrQlwclPVHKK9gCR+dchJkU5F
 jUEj8Z6yAgPWGJMvGUQA25OrX5ojVCdoxIRwwEmmI/nRGzzmTPjdZnTMyOAkJhtt0e88
 pZianx8ljM+HWBK0W/2VU8NuBRjrJW1C82DqJfaUowsCBcB+D8Hz/fSA9yzRbVx7NB99 2Q== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qj3amahdu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 May 2023 03:03:03 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34F332px009566
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 May 2023 03:03:02 GMT
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
Subject: [PATCH 2/3] drm/msm/dp: Clean up logs dp_power module
Date:   Sun, 14 May 2023 20:02:55 -0700
Message-ID: <20230515030256.300104-2-quic_bjorande@quicinc.com>
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
X-Proofpoint-GUID: TsFosy6ukuJADtMDE59KCbBrja5cPrRc
X-Proofpoint-ORIG-GUID: TsFosy6ukuJADtMDE59KCbBrja5cPrRc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-14_18,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 impostorscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0
 mlxscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
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

The clk_bulk API already provides error messages indicating which
specific clock in the request for which the operation failed, further
more these errors are associated with the specific DisplayPort
controller (rather than the shared drm_device). The additional error
messages int he dp_power module does thereby not provide any benefit.

While at it, none of the dp_power handles passed to these functions are
dynamic in nature, so there should not be any need for runtime checking
them. Drop these as well.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 drivers/gpu/drm/msm/dp/dp_power.c | 62 +++++--------------------------
 1 file changed, 9 insertions(+), 53 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_power.c b/drivers/gpu/drm/msm/dp/dp_power.c
index c0aaabb03389..031d2eefef07 100644
--- a/drivers/gpu/drm/msm/dp/dp_power.c
+++ b/drivers/gpu/drm/msm/dp/dp_power.c
@@ -35,25 +35,16 @@ static int dp_power_clk_init(struct dp_power_private *power)
 	stream = &power->parser->mp[DP_STREAM_PM];
 
 	rc = devm_clk_bulk_get(dev, core->num_clk, core->clocks);
-	if (rc) {
-		DRM_ERROR("failed to get %s clk. err=%d\n",
-			dp_parser_pm_name(DP_CORE_PM), rc);
+	if (rc)
 		return rc;
-	}
 
 	rc = devm_clk_bulk_get(dev, ctrl->num_clk, ctrl->clocks);
-	if (rc) {
-		DRM_ERROR("failed to get %s clk. err=%d\n",
-			dp_parser_pm_name(DP_CTRL_PM), rc);
+	if (rc)
 		return -ENODEV;
-	}
 
 	rc = devm_clk_bulk_get(dev, stream->num_clk, stream->clocks);
-	if (rc) {
-		DRM_ERROR("failed to get %s clk. err=%d\n",
-			dp_parser_pm_name(DP_CTRL_PM), rc);
+	if (rc)
 		return -ENODEV;
-	}
 
 	return 0;
 }
@@ -121,11 +112,9 @@ int dp_power_clk_enable(struct dp_power *dp_power,
 			mp = &power->parser->mp[DP_CORE_PM];
 
 			rc = clk_bulk_prepare_enable(mp->num_clk, mp->clocks);
-			if (rc) {
-				DRM_ERROR("fail to enable clks: %s. err=%d\n",
-					dp_parser_pm_name(DP_CORE_PM), rc);
+			if (rc)
 				return rc;
-			}
+
 			dp_power->core_clks_on = true;
 		}
 	}
@@ -133,10 +122,8 @@ int dp_power_clk_enable(struct dp_power *dp_power,
 	mp = &power->parser->mp[pm_type];
 	if (enable) {
 		rc = clk_bulk_prepare_enable(mp->num_clk, mp->clocks);
-		if (rc) {
-			DRM_ERROR("failed to enable clks, err: %d\n", rc);
+		if (rc)
 			return rc;
-		}
 	} else {
 		clk_bulk_disable_unprepare(mp->num_clk, mp->clocks);
 	}
@@ -162,34 +149,19 @@ int dp_power_clk_enable(struct dp_power *dp_power,
 
 int dp_power_client_init(struct dp_power *dp_power)
 {
-	int rc = 0;
 	struct dp_power_private *power;
 
-	if (!dp_power) {
-		DRM_ERROR("invalid power data\n");
-		return -EINVAL;
-	}
-
 	power = container_of(dp_power, struct dp_power_private, dp_power);
 
 	pm_runtime_enable(&power->pdev->dev);
 
-	rc = dp_power_clk_init(power);
-	if (rc)
-		DRM_ERROR("failed to init clocks %d\n", rc);
-
-	return rc;
+	return dp_power_clk_init(power);
 }
 
 void dp_power_client_deinit(struct dp_power *dp_power)
 {
 	struct dp_power_private *power;
 
-	if (!dp_power) {
-		DRM_ERROR("invalid power data\n");
-		return;
-	}
-
 	power = container_of(dp_power, struct dp_power_private, dp_power);
 
 	pm_runtime_disable(&power->pdev->dev);
@@ -200,25 +172,14 @@ int dp_power_init(struct dp_power *dp_power, bool flip)
 	int rc = 0;
 	struct dp_power_private *power = NULL;
 
-	if (!dp_power) {
-		DRM_ERROR("invalid power data\n");
-		return -EINVAL;
-	}
-
 	power = container_of(dp_power, struct dp_power_private, dp_power);
 
 	pm_runtime_get_sync(&power->pdev->dev);
 
 	rc = dp_power_clk_enable(dp_power, DP_CORE_PM, true);
-	if (rc) {
-		DRM_ERROR("failed to enable DP core clocks, %d\n", rc);
-		goto exit;
-	}
-
-	return 0;
+	if (rc)
+		pm_runtime_put_sync(&power->pdev->dev);
 
-exit:
-	pm_runtime_put_sync(&power->pdev->dev);
 	return rc;
 }
 
@@ -238,11 +199,6 @@ struct dp_power *dp_power_get(struct device *dev, struct dp_parser *parser)
 	struct dp_power_private *power;
 	struct dp_power *dp_power;
 
-	if (!parser) {
-		DRM_ERROR("invalid input\n");
-		return ERR_PTR(-EINVAL);
-	}
-
 	power = devm_kzalloc(&parser->pdev->dev, sizeof(*power), GFP_KERNEL);
 	if (!power)
 		return ERR_PTR(-ENOMEM);
-- 
2.39.2

