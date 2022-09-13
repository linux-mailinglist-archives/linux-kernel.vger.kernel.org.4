Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1945A5B770E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 19:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbiIMRB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 13:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232216AbiIMRBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 13:01:04 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6703C22B5;
        Tue, 13 Sep 2022 08:51:43 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28DDuYBx032004;
        Tue, 13 Sep 2022 14:56:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=Q8fMXPRTOj41ul1hOkF6ZjA0IwUwTjYrCJYLPmkluZQ=;
 b=XuRdqf9BeoDxC7yiAVwSgIst1IeBfeKEWHC+0D8FNYOPkr+98SIEmVVwvJbBhpTg1qSG
 fdCDnS0jPWyEYk3uBQ1XMmV0/kgqo6mL7XRPsl2U7LrQ3qUn8nHiMLRn1PPlTOS1dD6s
 VmAYDNr0eLYYYZoSxTVwVn/8rGIVIBZI7gMA3FuHhQTfgnxGwk5HgR0WXe/j9iZ3JURR
 DP7+Tnd37+cBrSCpzb6opcK+cgkX1KJzIlzoDpa2ojPo01vT+WykChFIkcc/lGCMzjP/
 aIOsvgfrFgpj01lyA/o/Mot9gtqcr4zlMYo2yjMwURFwExoqan4TBW0KqHr7Y4odhWFw 7Q== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jjm1wt6t8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Sep 2022 14:56:30 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 28DEpQcX017890;
        Tue, 13 Sep 2022 14:51:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3jh46m5dr2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 13 Sep 2022 14:51:26 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28DEpQGd017856;
        Tue, 13 Sep 2022 14:51:26 GMT
Received: from vpolimer-linux.qualcomm.com (vpolimer-linux.qualcomm.com [10.204.67.235])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 28DEpQSr017838;
        Tue, 13 Sep 2022 14:51:26 +0000
Received: by vpolimer-linux.qualcomm.com (Postfix, from userid 463814)
        id 4B29B4033; Tue, 13 Sep 2022 20:21:25 +0530 (IST)
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
Subject: [PATCH v7 03/15] drm/msm/dp: use atomic callbacks for DP bridge ops
Date:   Tue, 13 Sep 2022 20:21:04 +0530
Message-Id: <1663080676-12936-4-git-send-email-quic_vpolimer@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1663080676-12936-1-git-send-email-quic_vpolimer@quicinc.com>
References: <1663080676-12936-1-git-send-email-quic_vpolimer@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: CDx8Irf025v0_nH4UIk78uAw-ZV63HeD
X-Proofpoint-ORIG-GUID: CDx8Irf025v0_nH4UIk78uAw-ZV63HeD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-13_07,2022-09-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 mlxlogscore=930 mlxscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

Use atomic variants for DP bridge callback functions so that
the atomic state can be accessed in the interface drivers.
The atomic state will help the driver find out if the display
is in self refresh state.

Signed-off-by: Sankeerth Billakanti <quic_sbillaka@quicinc.com>
Signed-off-by: Vinod Polimera <quic_vpolimer@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
 drivers/gpu/drm/msm/dp/dp_display.c |  9 ++++++---
 drivers/gpu/drm/msm/dp/dp_drm.c     | 17 ++++++++++-------
 drivers/gpu/drm/msm/dp/dp_drm.h     |  9 ++++++---
 3 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index bfd0aef..bfffc2b 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -1636,7 +1636,8 @@ int msm_dp_modeset_init(struct msm_dp *dp_display, struct drm_device *dev,
 	return 0;
 }
 
-void dp_bridge_enable(struct drm_bridge *drm_bridge)
+void dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
+			     struct drm_bridge_state *old_bridge_state)
 {
 	struct msm_dp_bridge *dp_bridge = to_dp_bridge(drm_bridge);
 	struct msm_dp *dp = dp_bridge->dp_display;
@@ -1691,7 +1692,8 @@ void dp_bridge_enable(struct drm_bridge *drm_bridge)
 	mutex_unlock(&dp_display->event_mutex);
 }
 
-void dp_bridge_disable(struct drm_bridge *drm_bridge)
+void dp_bridge_atomic_disable(struct drm_bridge *drm_bridge,
+			      struct drm_bridge_state *old_bridge_state)
 {
 	struct msm_dp_bridge *dp_bridge = to_dp_bridge(drm_bridge);
 	struct msm_dp *dp = dp_bridge->dp_display;
@@ -1702,7 +1704,8 @@ void dp_bridge_disable(struct drm_bridge *drm_bridge)
 	dp_ctrl_push_idle(dp_display->ctrl);
 }
 
-void dp_bridge_post_disable(struct drm_bridge *drm_bridge)
+void dp_bridge_atomic_post_disable(struct drm_bridge *drm_bridge,
+				   struct drm_bridge_state *old_bridge_state)
 {
 	struct msm_dp_bridge *dp_bridge = to_dp_bridge(drm_bridge);
 	struct msm_dp *dp = dp_bridge->dp_display;
diff --git a/drivers/gpu/drm/msm/dp/dp_drm.c b/drivers/gpu/drm/msm/dp/dp_drm.c
index 6df25f7..43ce208 100644
--- a/drivers/gpu/drm/msm/dp/dp_drm.c
+++ b/drivers/gpu/drm/msm/dp/dp_drm.c
@@ -61,13 +61,16 @@ static int dp_bridge_get_modes(struct drm_bridge *bridge, struct drm_connector *
 }
 
 static const struct drm_bridge_funcs dp_bridge_ops = {
-	.enable       = dp_bridge_enable,
-	.disable      = dp_bridge_disable,
-	.post_disable = dp_bridge_post_disable,
-	.mode_set     = dp_bridge_mode_set,
-	.mode_valid   = dp_bridge_mode_valid,
-	.get_modes    = dp_bridge_get_modes,
-	.detect       = dp_bridge_detect,
+	.atomic_enable = dp_bridge_atomic_enable,
+	.atomic_disable = dp_bridge_atomic_disable,
+	.atomic_post_disable = dp_bridge_atomic_post_disable,
+	.mode_set = dp_bridge_mode_set,
+	.mode_valid = dp_bridge_mode_valid,
+	.get_modes = dp_bridge_get_modes,
+	.detect = dp_bridge_detect,
+	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
 };
 
 struct drm_bridge *dp_bridge_init(struct msm_dp *dp_display, struct drm_device *dev,
diff --git a/drivers/gpu/drm/msm/dp/dp_drm.h b/drivers/gpu/drm/msm/dp/dp_drm.h
index 82035db..e69c0b9 100644
--- a/drivers/gpu/drm/msm/dp/dp_drm.h
+++ b/drivers/gpu/drm/msm/dp/dp_drm.h
@@ -23,9 +23,12 @@ struct drm_connector *dp_drm_connector_init(struct msm_dp *dp_display, struct dr
 struct drm_bridge *dp_bridge_init(struct msm_dp *dp_display, struct drm_device *dev,
 			struct drm_encoder *encoder);
 
-void dp_bridge_enable(struct drm_bridge *drm_bridge);
-void dp_bridge_disable(struct drm_bridge *drm_bridge);
-void dp_bridge_post_disable(struct drm_bridge *drm_bridge);
+void dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
+			     struct drm_bridge_state *old_bridge_state);
+void dp_bridge_atomic_disable(struct drm_bridge *drm_bridge,
+			      struct drm_bridge_state *old_bridge_state);
+void dp_bridge_atomic_post_disable(struct drm_bridge *drm_bridge,
+				   struct drm_bridge_state *old_bridge_state);
 enum drm_mode_status dp_bridge_mode_valid(struct drm_bridge *bridge,
 					  const struct drm_display_info *info,
 					  const struct drm_display_mode *mode);
-- 
2.7.4

