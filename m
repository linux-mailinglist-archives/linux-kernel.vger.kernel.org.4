Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883FE681469
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 16:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238059AbjA3PNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 10:13:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238054AbjA3PNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 10:13:11 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C967338B60;
        Mon, 30 Jan 2023 07:12:46 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30UDbdVZ007414;
        Mon, 30 Jan 2023 15:12:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=GiQCoiSSCZvGFcwZrwzy8q/MFFIfYcIFi6WuXFCkCb4=;
 b=Wx1ZkG/7N1LEN5Cizz610t2HvWi0nibJQ7hEylsZGRkgaqT7nPQ5LHmXGDMvvVLOkFai
 a6dRSfSlSEhe7Brkl9GC+gp+FVXcIKBT0W4NKxdfeVU1C3Afocvxz5Hk50OwCN6I5VCs
 TmwTdYHc9Y/ebX+yGrnsZFfR5TiU+NGoa4kg2bQWD3TZonh1AGtj4Hh8OgIyjvugVT+g
 Tho1cR8ewS4cGnlV8Kd9sTwfcUGBy48Im9sxWIBPRVY0S+x89+xyQ0DUGL7eU3KeBva7
 LjZYla0Ooc9/Octn+F0mPABFBGviGEos9HROfH0P6N+44jiZ+C1DO1KqFgDVk/E8RDM0 PA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ncuxakvnj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 15:12:36 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30UFCa7R020285
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 15:12:36 GMT
Received: from vpolimer-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 30 Jan 2023 07:12:30 -0800
From:   Vinod Polimera <quic_vpolimer@quicinc.com>
To:     <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <freedreno@lists.freedesktop.org>, <devicetree@vger.kernel.org>
CC:     Vinod Polimera <quic_vpolimer@quicinc.com>,
        <linux-kernel@vger.kernel.org>, <robdclark@gmail.com>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <quic_kalyant@quicinc.com>, <dmitry.baryshkov@linaro.org>,
        <quic_khsieh@quicinc.com>, <quic_vproddut@quicinc.com>,
        <quic_bjorande@quicinc.com>, <quic_abhinavk@quicinc.com>,
        <quic_sbillaka@quicinc.com>
Subject: [PATCH v12 08/14] drm/msm/dp: use the eDP bridge ops to validate eDP modes
Date:   Mon, 30 Jan 2023 20:41:28 +0530
Message-ID: <1675091494-13988-9-git-send-email-quic_vpolimer@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1675091494-13988-1-git-send-email-quic_vpolimer@quicinc.com>
References: <1675091494-13988-1-git-send-email-quic_vpolimer@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: pzrWwB4eJX18BANn4z-1K9akA759K4E9
X-Proofpoint-GUID: pzrWwB4eJX18BANn4z-1K9akA759K4E9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_14,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 lowpriorityscore=0 mlxlogscore=995 impostorscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301300147
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index 86ed80c..ffb21a6 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -996,14 +996,6 @@ enum drm_mode_status dp_bridge_mode_valid(struct drm_bridge *bridge,
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
index 3b38bd9..029e08c 100644
--- a/drivers/gpu/drm/msm/dp/dp_drm.c
+++ b/drivers/gpu/drm/msm/dp/dp_drm.c
@@ -226,12 +226,44 @@ static void edp_bridge_atomic_post_disable(struct drm_bridge *drm_bridge,
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

