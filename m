Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3155FC4C7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 14:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiJLMDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 08:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiJLMC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 08:02:56 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A70A7A87;
        Wed, 12 Oct 2022 05:02:55 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29C8Ttr6017696;
        Wed, 12 Oct 2022 12:02:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=+oNredd0QS/T/RiB7osKfG+EsHkLu56DQInS/XLlZx0=;
 b=N4o7+MCL6IeUxkcYzwYcIHvgEypOpatZg2WRj1ljvwDG2WIOKLap2SdrgQT9YZ0xCWLA
 3qA0IdSJV7ouhMEt+/l3j8JAt+1eqIwGHtn/OrazN4V4Oz67A/lcrAkXSG1GsWBWF9Rp
 fX2D7AYjTrnzOhonpCG/uD8Qm9ZraIs1FlY9l1rpyUgER9Nav2RX2aWlBmYM/Kh+cLeo
 2eF9XVFOuCj1+qmP3CR/KtOi6bdQJcdZ/dqwmapzUdYdAqesUytGQkNlsvUXQ6bRrWRY
 qSKMqf34xmoO3y2Eys0EKIvDGN5cN4iexcD0qfsSPwARjyRbYHnKezD+Kuq2hbFAF9V3 5w== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k5rtsgwfh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 12:02:52 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 29CC2lOZ026862;
        Wed, 12 Oct 2022 12:02:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3k3jpu0t2e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 12 Oct 2022 12:02:48 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29CC2liO026837;
        Wed, 12 Oct 2022 12:02:48 GMT
Received: from vpolimer-linux.qualcomm.com (vpolimer-linux.qualcomm.com [10.204.67.235])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 29CC2mCq026871;
        Wed, 12 Oct 2022 12:02:48 +0000
Received: by vpolimer-linux.qualcomm.com (Postfix, from userid 463814)
        id 24C9D3EEC; Wed, 12 Oct 2022 17:32:47 +0530 (IST)
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
Subject: [PATCH v8 11/15] drm/msm/disp/dpu: add PSR support for eDP interface in dpu driver
Date:   Wed, 12 Oct 2022 17:32:35 +0530
Message-Id: <1665576159-3749-12-git-send-email-quic_vpolimer@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1665576159-3749-1-git-send-email-quic_vpolimer@quicinc.com>
References: <1665576159-3749-1-git-send-email-quic_vpolimer@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -JHtwgIZ1c0DobiWxTFkD9gxzRK16GaN
X-Proofpoint-ORIG-GUID: -JHtwgIZ1c0DobiWxTFkD9gxzRK16GaN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-12_06,2022-10-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 malwarescore=0 suspectscore=0 mlxlogscore=890 impostorscore=0
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

Enable PSR on eDP interface using drm self-refresh librabry.
This patch uses a trigger from self-refresh library to enter/exit
into PSR, when there are no updates from framework.

Signed-off-by: Kalyan Thota <quic_kalyant@quicinc.com>
Signed-off-by: Vinod Polimera <quic_vpolimer@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c    | 13 ++++++++++++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 14 ++++++++++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c     |  2 +-
 3 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index 8ec9a13..5ba4963 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -21,6 +21,7 @@
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_rect.h>
 #include <drm/drm_vblank.h>
+#include <drm/drm_self_refresh_helper.h>
 
 #include "dpu_kms.h"
 #include "dpu_hw_lm.h"
@@ -1018,6 +1019,9 @@ static void dpu_crtc_disable(struct drm_crtc *crtc,
 
 	DRM_DEBUG_KMS("crtc%d\n", crtc->base.id);
 
+	if (old_crtc_state->self_refresh_active)
+		return;
+
 	/* Disable/save vblank irq handling */
 	drm_crtc_vblank_off(crtc);
 
@@ -1572,7 +1576,7 @@ struct drm_crtc *dpu_crtc_init(struct drm_device *dev, struct drm_plane *plane,
 {
 	struct drm_crtc *crtc = NULL;
 	struct dpu_crtc *dpu_crtc = NULL;
-	int i;
+	int i, ret;
 
 	dpu_crtc = kzalloc(sizeof(*dpu_crtc), GFP_KERNEL);
 	if (!dpu_crtc)
@@ -1609,6 +1613,13 @@ struct drm_crtc *dpu_crtc_init(struct drm_device *dev, struct drm_plane *plane,
 	/* initialize event handling */
 	spin_lock_init(&dpu_crtc->event_lock);
 
+	ret = drm_self_refresh_helper_init(crtc);
+	if (ret) {
+		DPU_ERROR("Failed to initialize %s with self-refresh helpers %d\n",
+			crtc->name, ret);
+		return ERR_PTR(ret);
+	}
+
 	DRM_DEBUG_KMS("%s: successfully initialized crtc\n", dpu_crtc->name);
 	return crtc;
 }
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index e8c3518..9f4f4e5 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -12,6 +12,7 @@
 #include <linux/kthread.h>
 #include <linux/seq_file.h>
 
+#include <drm/drm_atomic.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_file.h>
 #include <drm/drm_probe_helper.h>
@@ -1208,11 +1209,24 @@ static void dpu_encoder_virt_atomic_disable(struct drm_encoder *drm_enc,
 					struct drm_atomic_state *state)
 {
 	struct dpu_encoder_virt *dpu_enc = NULL;
+	struct drm_crtc *crtc;
+	struct drm_crtc_state *old_state = NULL;
 	int i = 0;
 
 	dpu_enc = to_dpu_encoder_virt(drm_enc);
 	DPU_DEBUG_ENC(dpu_enc, "\n");
 
+	crtc = drm_atomic_get_old_crtc_for_encoder(state, drm_enc);
+	if (crtc)
+		old_state = drm_atomic_get_old_crtc_state(state, crtc);
+
+	/*
+	 * The encoder is already disabled if self refresh mode was set earlier,
+	 * in the old_state for the corresponding crtc.
+	 */
+	if (old_state && old_state->self_refresh_active)
+		return;
+
 	mutex_lock(&dpu_enc->enc_lock);
 	dpu_enc->enabled = false;
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index 5e6e262..0247f39 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -503,7 +503,7 @@ static void dpu_kms_wait_for_commit_done(struct msm_kms *kms,
 		return;
 	}
 
-	if (!crtc->state->active) {
+	if (!drm_atomic_crtc_effectively_active(crtc->state)) {
 		DPU_DEBUG("[crtc:%d] not active\n", crtc->base.id);
 		return;
 	}
-- 
2.7.4

