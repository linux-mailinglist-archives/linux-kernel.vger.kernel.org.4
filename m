Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07EC77431A7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 02:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbjF3A0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 20:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjF3A0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 20:26:07 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD552D71;
        Thu, 29 Jun 2023 17:26:04 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35U0ITER001981;
        Fri, 30 Jun 2023 00:25:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : references : in-reply-to : to : cc; s=qcppdkim1;
 bh=nAmy69iVvXk/SE6Y/mxEaOm5wnxUqAey5VFpDvvr/n0=;
 b=ELLZXKRIqcnkCSBFOOHBc+3mB9MDWmNjKvhi7P9zwZMRPYhlI/tI9aKWJnW/ONJIZge8
 2a+uC5//4Wzi3WS+JjmxWUYEmf6ocs/HTebrmwkF9bnwkTDX84UNfc5Olldd+la8Gjx6
 Y+Dt7sGTajDRp3Nk+fbZZ0Qs/lJGWMV7/ZQTTMZHJfeevfwfe/HxPO72ZAaTBX7ucbCt
 9HNLDGzldZY8y9PNuEwiiM07KSB5cJVYHPK3NEEdPwWK+9c6X29PXEUt1GZIKRnOdfa4
 o0f7ysvo0ExiJTCfNsgOp0bjsLJ2JPQBZ5f8jlLTz6YiiXhEXSQXWmEQhMEzOms02wY8 /Q== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rh7aesrh7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 00:25:39 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35U0Pcuq010720
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 00:25:38 GMT
Received: from jesszhan-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 29 Jun 2023 17:25:37 -0700
From:   Jessica Zhang <quic_jesszhan@quicinc.com>
Date:   Thu, 29 Jun 2023 17:25:05 -0700
Subject: [PATCH RFC v4 6/7] drm/msm/dpu: Allow NULL FBs in atomic commit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230404-solid-fill-v4-6-f4ec0caa742d@quicinc.com>
References: <20230404-solid-fill-v4-0-f4ec0caa742d@quicinc.com>
In-Reply-To: <20230404-solid-fill-v4-0-f4ec0caa742d@quicinc.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        "Sean Paul" <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>
CC:     <quic_abhinavk@quicinc.com>, <ppaalanen@gmail.com>,
        <contact@emersion.fr>, <laurent.pinchart@ideasonboard.com>,
        <sebastian.wick@redhat.com>, <ville.syrjala@linux.intel.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <freedreno@lists.freedesktop.org>,
        <wayland-devel@lists.freedesktop.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>
X-Mailer: b4 0.13-dev-c6835
X-Developer-Signature: v=1; a=ed25519-sha256; t=1688084735; l=4916;
 i=quic_jesszhan@quicinc.com; s=20230329; h=from:subject:message-id;
 bh=58ZDN8nT1KKdPLqbgZ4k1pPvaA/blOs4t/NKZBXGwyM=;
 b=vb7Fv7MmTS9f8b5MIMPJBMV3MM9FQBe2+PQ9RJEVg8NzfVcF3xamrwUDSU5iC+bMxF0Kw+n4c
 zIFdde+hGICDUZxWVItwgviqVQeAzdPNA7hwi0og8uyj2TLyyqp69pY
X-Developer-Key: i=quic_jesszhan@quicinc.com; a=ed25519;
 pk=gAUCgHZ6wTJOzQa3U0GfeCDH7iZLlqIEPo4rrjfDpWE=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: i4xPWJPj8me3hkNnt29W6pXmiOtzh5Ku
X-Proofpoint-ORIG-GUID: i4xPWJPj8me3hkNnt29W6pXmiOtzh5Ku
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-29_10,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=802
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306300001
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since solid fill planes allow for a NULL framebuffer in a valid commit,
add NULL framebuffer checks to atomic commit calls within DPU.

Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c  |  9 ++++++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 45 +++++++++++++++++++------------
 2 files changed, 36 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index 1edf2b6b0a26..d1b37d2cc202 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -451,6 +451,7 @@ static void _dpu_crtc_blend_setup_mixer(struct drm_crtc *crtc,
 	struct drm_plane_state *state;
 	struct dpu_crtc_state *cstate = to_dpu_crtc_state(crtc->state);
 	struct dpu_plane_state *pstate = NULL;
+	const struct msm_format *fmt;
 	struct dpu_format *format;
 	struct dpu_hw_ctl *ctl = mixer->lm_ctl;
 
@@ -470,7 +471,13 @@ static void _dpu_crtc_blend_setup_mixer(struct drm_crtc *crtc,
 		pstate = to_dpu_plane_state(state);
 		fb = state->fb;
 
-		format = to_dpu_format(msm_framebuffer_format(pstate->base.fb));
+		if (state->pixel_source == DRM_PLANE_PIXEL_SOURCE_FB && fb)
+			fmt = msm_framebuffer_format(pstate->base.fb);
+		else
+			fmt = dpu_get_msm_format(&_dpu_crtc_get_kms(crtc)->base,
+					DRM_FORMAT_RGBA8888, 0);
+
+		format = to_dpu_format(fmt);
 
 		if (pstate->stage == DPU_STAGE_BASE && format->alpha_enable)
 			bg_alpha_enable = true;
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
index 5f0984ce62b1..4476722f03bb 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
@@ -837,8 +837,10 @@ static int dpu_plane_atomic_check(struct drm_plane *plane,
 
 	pipe_cfg->dst_rect = new_plane_state->dst;
 
-	fb_rect.x2 = new_plane_state->fb->width;
-	fb_rect.y2 = new_plane_state->fb->height;
+	if (new_plane_state->pixel_source == DRM_PLANE_PIXEL_SOURCE_FB && new_plane_state->fb) {
+		fb_rect.x2 = new_plane_state->fb->width;
+		fb_rect.y2 = new_plane_state->fb->height;
+	}
 
 	/* Ensure fb size is supported */
 	if (drm_rect_width(&fb_rect) > MAX_IMG_WIDTH ||
@@ -848,10 +850,13 @@ static int dpu_plane_atomic_check(struct drm_plane *plane,
 		return -E2BIG;
 	}
 
-	fmt = to_dpu_format(msm_framebuffer_format(new_plane_state->fb));
-
 	max_linewidth = pdpu->catalog->caps->max_linewidth;
 
+	if (drm_plane_solid_fill_enabled(new_plane_state))
+		fmt = dpu_get_dpu_format(DRM_FORMAT_ABGR8888);
+	else
+		fmt = to_dpu_format(msm_framebuffer_format(new_plane_state->fb));
+
 	if (drm_rect_width(&pipe_cfg->src_rect) > max_linewidth) {
 		/*
 		 * In parallel multirect case only the half of the usual width
@@ -1082,21 +1087,32 @@ static void dpu_plane_sspp_atomic_update(struct drm_plane *plane)
 	struct drm_crtc *crtc = state->crtc;
 	struct drm_framebuffer *fb = state->fb;
 	bool is_rt_pipe;
-	const struct dpu_format *fmt =
-		to_dpu_format(msm_framebuffer_format(fb));
+	const struct dpu_format *fmt;
 	struct dpu_sw_pipe_cfg *pipe_cfg = &pstate->pipe_cfg;
 	struct dpu_sw_pipe_cfg *r_pipe_cfg = &pstate->r_pipe_cfg;
 	struct dpu_kms *kms = _dpu_plane_get_kms(&pdpu->base);
 	struct msm_gem_address_space *aspace = kms->base.aspace;
 	struct dpu_hw_fmt_layout layout;
 	bool layout_valid = false;
-	int ret;
 
-	ret = dpu_format_populate_layout(aspace, fb, &layout);
-	if (ret)
-		DPU_ERROR_PLANE(pdpu, "failed to get format layout, %d\n", ret);
-	else
-		layout_valid = true;
+	if (state->pixel_source == DRM_PLANE_PIXEL_SOURCE_FB && fb) {
+		int ret;
+
+		fmt = to_dpu_format(msm_framebuffer_format(fb));
+
+		ret = dpu_format_populate_layout(aspace, fb, &layout);
+		if (ret)
+			DPU_ERROR_PLANE(pdpu, "failed to get format layout, %d\n", ret);
+		else
+			layout_valid = true;
+
+		DPU_DEBUG_PLANE(pdpu, "FB[%u] " DRM_RECT_FP_FMT "->crtc%u " DRM_RECT_FMT
+				", %4.4s ubwc %d\n", fb->base.id, DRM_RECT_FP_ARG(&state->src),
+				crtc->base.id, DRM_RECT_ARG(&state->dst),
+				(char *)&fmt->base.pixel_format, DPU_FORMAT_IS_UBWC(fmt));
+	} else {
+		fmt = dpu_get_dpu_format(DRM_FORMAT_ABGR8888);
+	}
 
 	pstate->pending = true;
 
@@ -1104,11 +1120,6 @@ static void dpu_plane_sspp_atomic_update(struct drm_plane *plane)
 	pstate->needs_qos_remap |= (is_rt_pipe != pdpu->is_rt_pipe);
 	pdpu->is_rt_pipe = is_rt_pipe;
 
-	DPU_DEBUG_PLANE(pdpu, "FB[%u] " DRM_RECT_FP_FMT "->crtc%u " DRM_RECT_FMT
-			", %4.4s ubwc %d\n", fb->base.id, DRM_RECT_FP_ARG(&state->src),
-			crtc->base.id, DRM_RECT_ARG(&state->dst),
-			(char *)&fmt->base.pixel_format, DPU_FORMAT_IS_UBWC(fmt));
-
 	dpu_plane_sspp_update_pipe(plane, pipe, pipe_cfg, fmt,
 				   drm_mode_vrefresh(&crtc->mode),
 				   layout_valid ? &layout : NULL);

-- 
2.41.0

