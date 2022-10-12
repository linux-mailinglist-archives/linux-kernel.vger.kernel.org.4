Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3EA25FC4F7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 14:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbiJLMEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 08:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiJLMC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 08:02:59 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97047BEAC7;
        Wed, 12 Oct 2022 05:02:56 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29C7aKRo029243;
        Wed, 12 Oct 2022 12:02:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=cy190nBWWOxADp30jZrS+SpeqJ87gjicEcMiZS0Ave4=;
 b=FE+lpCO6vcoOVg6WLkOdJ3PYyIUhrF3bofHcA2lGeaHHPsf6A4h6h7ju3dy8DjVsMMMF
 7av65ap4/5g0gT/2KbQtgPlxpeq7yxgGRCKMSrOLBdArfYibJVPFB3dVYDSyuAWd43yw
 WCXtpJAjqWejSWjwJjv2ccB5+Y6qixprJmUQY2EkdlULw/QMrGkGNWVPakpG9TqR9FLF
 iFrGau7xwId5vIHECBW/Ze0mcyv131N/dGreXCqDoGnLs4uPecaHZ5gObQZTnqueKr3m
 uiEdFj+J40rrVJpsg31Kro6D23B1gfh1W+vdn1fvkhfMiUlNI1gitKMBIB2nrflh0Tb4 CA== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k5rtsgwfn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 12:02:53 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 29CC2mXY026939;
        Wed, 12 Oct 2022 12:02:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3k3jpu0t2s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 12 Oct 2022 12:02:50 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29CC2lla026847;
        Wed, 12 Oct 2022 12:02:48 GMT
Received: from vpolimer-linux.qualcomm.com (vpolimer-linux.qualcomm.com [10.204.67.235])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 29CC2mW2026868;
        Wed, 12 Oct 2022 12:02:48 +0000
Received: by vpolimer-linux.qualcomm.com (Postfix, from userid 463814)
        id BA0EC3EAA; Wed, 12 Oct 2022 17:32:46 +0530 (IST)
From:   Vinod Polimera <quic_vpolimer@quicinc.com>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     Vinod Polimera <quic_vpolimer@quicinc.com>,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        dianders@chromium.org, swboyd@chromium.org,
        quic_kalyant@quicinc.com, dmitry.baryshkov@linaro.org,
        quic_khsieh@quicinc.com, quic_vproddut@quicinc.com,
        quic_bjorande@quicinc.com, quic_aravindh@quicinc.com,
        quic_abhinavk@quicinc.com, quic_sbillaka@quicinc.com
Subject: [PATCH v8 05/15] drm/msm/dp: use the eDP bridge ops to validate eDP modes
Date:   Wed, 12 Oct 2022 17:32:29 +0530
Message-Id: <1665576159-3749-6-git-send-email-quic_vpolimer@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1665576159-3749-1-git-send-email-quic_vpolimer@quicinc.com>
References: <1665576159-3749-1-git-send-email-quic_vpolimer@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nq9NM_gVHaPGNUJwtYvY3Ki7D9Dtmn4B
X-Proofpoint-ORIG-GUID: nq9NM_gVHaPGNUJwtYvY3Ki7D9Dtmn4B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-12_06,2022-10-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 malwarescore=0 suspectscore=0 mlxlogscore=943 impostorscore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210120079
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The eDP and DP interfaces shared the bridge operations and
the eDP specific changes were implemented under is_edp check.
To add psr support for eDP, we started using a new set of eDP
bridge ops. We are moving the eDP specific code in the
dp_bridge_mode_valid function to a new eDP function,
edp_bridge_mode_valid under the eDP bridge ops.

Signed-off-by: Sankeerth Billakanti <quic_sbillaka@quicinc.com>
Signed-off-by: Vinod Polimera <quic_vpolimer@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/dp/dp_display.c |  8 --------
 drivers/gpu/drm/msm/dp/dp_drm.c     | 34 +++++++++++++++++++++++++++++++++-
 2 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 5f2aae4..e481099 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -984,14 +984,6 @@ enum drm_mode_status dp_bridge_mode_valid(struct drm_bridge *bridge,
 		return -EINVAL;
 	}
 
-	/*
-	 * The eDP controller currently does not have a reliable way of
-	 * enabling panel power to read sink capabilities. So, we rely
-	 * on the panel driver to populate only supported modes for now.
-	 */
-	if (dp->is_edp)
-		return MODE_OK;
-
 	if (mode->clock > DP_MAX_PIXEL_CLK_KHZ)
 		return MODE_CLOCK_HIGH;
 
diff --git a/drivers/gpu/drm/msm/dp/dp_drm.c b/drivers/gpu/drm/msm/dp/dp_drm.c
index a3491d2..3e8912b 100644
--- a/drivers/gpu/drm/msm/dp/dp_drm.c
+++ b/drivers/gpu/drm/msm/dp/dp_drm.c
@@ -192,12 +192,44 @@ static void edp_bridge_atomic_post_disable(struct drm_bridge *drm_bridge,
 	dp_bridge_atomic_post_disable(drm_bridge, old_bridge_state);
 }
 
+/**
+ * edp_bridge_mode_valid - callback to determine if specified mode is valid
+ * @bridge: Pointer to drm bridge structure
+ * @info: display info
+ * @mode: Pointer to drm mode structure
+ * Returns: Validity status for specified mode
+ */
+static enum drm_mode_status edp_bridge_mode_valid(struct drm_bridge *bridge,
+					  const struct drm_display_info *info,
+					  const struct drm_display_mode *mode)
+{
+	struct msm_dp *dp;
+	int mode_pclk_khz = mode->clock;
+
+	dp = to_dp_bridge(bridge)->dp_display;
+
+	if (!dp || !mode_pclk_khz || !dp->connector) {
+		DRM_ERROR("invalid params\n");
+		return -EINVAL;
+	}
+
+	if (mode->clock > DP_MAX_PIXEL_CLK_KHZ)
+		return MODE_CLOCK_HIGH;
+
+	/*
+	 * The eDP controller currently does not have a reliable way of
+	 * enabling panel power to read sink capabilities. So, we rely
+	 * on the panel driver to populate only supported modes for now.
+	 */
+	return MODE_OK;
+}
+
 static const struct drm_bridge_funcs edp_bridge_ops = {
 	.atomic_enable = edp_bridge_atomic_enable,
 	.atomic_disable = edp_bridge_atomic_disable,
 	.atomic_post_disable = edp_bridge_atomic_post_disable,
 	.mode_set = dp_bridge_mode_set,
-	.mode_valid = dp_bridge_mode_valid,
+	.mode_valid = edp_bridge_mode_valid,
 	.atomic_reset = drm_atomic_helper_bridge_reset,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
-- 
2.7.4

