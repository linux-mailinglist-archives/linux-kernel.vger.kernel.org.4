Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01CBF5B7726
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 19:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbiIMRBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 13:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbiIMRBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 13:01:06 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F198D3D3;
        Tue, 13 Sep 2022 08:52:06 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28DDvMcI030217;
        Tue, 13 Sep 2022 14:56:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=cy190nBWWOxADp30jZrS+SpeqJ87gjicEcMiZS0Ave4=;
 b=NZh8lqmWF0x/Z+Fun4RkwD8ia0pZVede8ppj3VjR+T/gXbaDnEA7fBBKjimovH9I7yCK
 FOnWQ8LvLPqOCb0he68frYOoqTabokyIjT6KJkygfM2htvMisDZ09JJJde7yirKtjAkb
 SvPsWNdyohNPIMnL+2QXwA1hb4EIAybrRfK2bM+2/NfUuITPADfFVcAd7pE4ccntwcHW
 3gJqdaQEctclsl7+pU4DfYYFt8tuH6Z9DgYHGstXQl030OJ0V7KBm6knHHoY1499EKXG
 WFSod2ElISjSFk/D0zt6KxnI8OZtU6L7WGpqVaeCgeR2eo9qM9YTwYHFqbsmzVIRATZN Zg== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jjbh1b86a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Sep 2022 14:56:30 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 28DEpQIF017889;
        Tue, 13 Sep 2022 14:51:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3jh46m5dr4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 13 Sep 2022 14:51:26 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28DEpMa6017814;
        Tue, 13 Sep 2022 14:51:26 GMT
Received: from vpolimer-linux.qualcomm.com (vpolimer-linux.qualcomm.com [10.204.67.235])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 28DEpQ6Z017839;
        Tue, 13 Sep 2022 14:51:26 +0000
Received: by vpolimer-linux.qualcomm.com (Postfix, from userid 463814)
        id 740E9403E; Tue, 13 Sep 2022 20:21:25 +0530 (IST)
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
Subject: [PATCH v7 05/15] drm/msm/dp: use the eDP bridge ops to validate eDP modes
Date:   Tue, 13 Sep 2022 20:21:06 +0530
Message-Id: <1663080676-12936-6-git-send-email-quic_vpolimer@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1663080676-12936-1-git-send-email-quic_vpolimer@quicinc.com>
References: <1663080676-12936-1-git-send-email-quic_vpolimer@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -sOE5QrXKs0ZqHufbmSNrLFbk01RGHs_
X-Proofpoint-ORIG-GUID: -sOE5QrXKs0ZqHufbmSNrLFbk01RGHs_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-13_07,2022-09-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 spamscore=0 impostorscore=0 adultscore=0 mlxlogscore=965
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209130068
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

