Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19CF168147C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 16:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238096AbjA3POM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 10:14:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238028AbjA3PNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 10:13:52 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7133D0B4;
        Mon, 30 Jan 2023 07:13:32 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30UEH3na009861;
        Mon, 30 Jan 2023 15:13:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=EUscz9X1XiQjhgHda6/DsXnSzvYxVopJBX9wf5Haj3Q=;
 b=K8aRBH6dSJt0kXESp3E2wP+0phPJess7lux4lcYEFtZ03Cg91GPWAKrB1mMgjhwKRhKY
 TH1Th87Z8Jr9e0dgbpdWXbjWVy6CJJH4OObaRsoQ4U+5Wru60nKBSbiuR9qDXSVnfNRu
 Z2iKJW0Ky3XZiCSUM8Q5/1Bx6/asHtqSNPnsFUKgYAhZ0XcZ84quMk9vj7Itwb03rsiu
 ZsTYZj6TRkGPVgYlqwS2d99JTlHbaO1jEVFFWLHbWnJyAVH5b9SqKDqzhm80vzXxJ0XJ
 OqvmvsJoaXXXqfIlQE7d1oog029jBhQwaUtfl5cx8X7nAlcauF/un9f26dK07TzfXAQ+ BA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ncvfpbssw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 15:13:08 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30UFD7Ks017058
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 15:13:07 GMT
Received: from vpolimer-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 30 Jan 2023 07:13:02 -0800
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
Subject: [PATCH v12 14/14] drm/msm/disp/dpu: update dpu_enc crtc state on crtc enable/disable during self refresh
Date:   Mon, 30 Jan 2023 20:41:34 +0530
Message-ID: <1675091494-13988-15-git-send-email-quic_vpolimer@quicinc.com>
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
X-Proofpoint-GUID: TuprCkyobcEsyKxeDUG5kM0MKIKFbuRZ
X-Proofpoint-ORIG-GUID: TuprCkyobcEsyKxeDUG5kM0MKIKFbuRZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_14,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 spamscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301300147
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Populate the enocder software structure to reflect the updated
crtc appropriately during crtc enable/disable for a new commit
while taking care of the self refresh transitions when crtc
disable is triggered from the drm self refresh library.

Signed-off-by: Vinod Polimera <quic_vpolimer@quicinc.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index 60e5984..b1ec0c3 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -1022,8 +1022,17 @@ static void dpu_crtc_disable(struct drm_crtc *crtc,
 
 	DRM_DEBUG_KMS("crtc%d\n", crtc->base.id);
 
-	if (old_crtc_state->self_refresh_active)
+	/* If disable is triggered while in self refresh mode,
+	 * reset the encoder software state so that in enable
+	 * it won't trigger a warn while assigning crtc.
+	 */
+	if (old_crtc_state->self_refresh_active) {
+		drm_for_each_encoder_mask(encoder, crtc->dev,
+					old_crtc_state->encoder_mask) {
+			dpu_encoder_assign_crtc(encoder, NULL);
+		}
 		return;
+	}
 
 	/* Disable/save vblank irq handling */
 	drm_crtc_vblank_off(crtc);
@@ -1036,7 +1045,14 @@ static void dpu_crtc_disable(struct drm_crtc *crtc,
 		 */
 		if (dpu_encoder_get_intf_mode(encoder) == INTF_MODE_VIDEO)
 			release_bandwidth = true;
-		dpu_encoder_assign_crtc(encoder, NULL);
+
+		/*
+		 * If disable is triggered during psr active(e.g: screen dim in PSR),
+		 * we will need encoder->crtc connection to process the device sleep &
+		 * preserve it during psr sequence.
+		 */
+		if (!crtc->state->self_refresh_active)
+			dpu_encoder_assign_crtc(encoder, NULL);
 	}
 
 	/* wait for frame_event_done completion */
@@ -1084,6 +1100,9 @@ static void dpu_crtc_enable(struct drm_crtc *crtc,
 	struct dpu_crtc *dpu_crtc = to_dpu_crtc(crtc);
 	struct drm_encoder *encoder;
 	bool request_bandwidth = false;
+	struct drm_crtc_state *old_crtc_state;
+
+	old_crtc_state = drm_atomic_get_old_crtc_state(state, crtc);
 
 	pm_runtime_get_sync(crtc->dev->dev);
 
@@ -1106,8 +1125,10 @@ static void dpu_crtc_enable(struct drm_crtc *crtc,
 	trace_dpu_crtc_enable(DRMID(crtc), true, dpu_crtc);
 	dpu_crtc->enabled = true;
 
-	drm_for_each_encoder_mask(encoder, crtc->dev, crtc->state->encoder_mask)
-		dpu_encoder_assign_crtc(encoder, crtc);
+	if (!old_crtc_state->self_refresh_active) {
+		drm_for_each_encoder_mask(encoder, crtc->dev, crtc->state->encoder_mask)
+			dpu_encoder_assign_crtc(encoder, crtc);
+	}
 
 	/* Enable/restore vblank irq handling */
 	drm_crtc_vblank_on(crtc);
-- 
2.7.4

