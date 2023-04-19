Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFEE56E7D32
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 16:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233513AbjDSOm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 10:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233405AbjDSOmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 10:42:04 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B673E4C3A
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 07:42:00 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id he13so22241997wmb.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 07:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20221208.gappssmtp.com; s=20221208; t=1681915319; x=1684507319;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hkfWN99F4hBvx1XEfrJngIeLn15ofD5JlY1D197wDT8=;
        b=3Cxnjb3YswWA056HbGtIB6yadcSK4Yw3KDO0AMN47lIDDhRRgAWvheSzQq8kp0BwkS
         2Nyc/uYul5Iv+c4Vbn9nFXOMVfRBohbbkWocAG3ZKtrNETAr4kStKiew2dhHkoeXzs6n
         bzcnOQt5hzd8m4iwwFPB4/orgBLtAHK+7O5n7QbqgrwmHWC3l7rkPq1mY9mwqiS6HBxG
         e2fgrzmdzmEffoQJIBtRek/UGiI0KqVKa87HhQJNF7bqzvlUg1jg1fGwcmwQYAzmUiGE
         KIIJDqCPxUwSRyC0bwipOmSllHVYHwHwVEGrxinDD/uJVSl5iD1zA/Xz68bpvzAxAfbq
         S+YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681915319; x=1684507319;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hkfWN99F4hBvx1XEfrJngIeLn15ofD5JlY1D197wDT8=;
        b=CYukjIQid6trUzhq0QSdYjpfgieYlYKYDhem1tEOdZCGO8Rpw2b3jqAmDXdbIiUemS
         9ukMZqP6Rt7Zj3qFg2BnTj8ZummLGUs9CC42Z0Sb+yi/3NWX2+/eDGLJL9qnmlVWBsbw
         IH5BXxmYE6Og3p4G55lsM/W5GqkyFDeO7BGW5FwkdiNqjBTm8gYaxAj+3mCA84i68MQ3
         A6S5WEnyqyCyozK79NQ0S0oJhrRi5fDTpWqWAXiTEkGfpErHYv3dBt8S+t89TkOmWhaj
         JcG03Ujrk+e87KAwkoNF+2YZFhje1Wi+yi9kHoCAj/8ouTUoDMsdHwDQHxMbxOTM7X5A
         6ovQ==
X-Gm-Message-State: AAQBX9dyzYMV33ahaC4Rhl+XYoKl4g+KCczQo2S5eJ4AJzfV+XUa7Zpz
        w65eNV/M6cSYRjkBf2kGGNj3
X-Google-Smtp-Source: AKy350Z4XvreRKuse360cUN0YJiTS3FQn+PMeJOel2baif9x0ixM+kMjMz4P1+eNretMarvSA/00hQ==
X-Received: by 2002:a7b:ce89:0:b0:3f0:68ce:5465 with SMTP id q9-20020a7bce89000000b003f068ce5465mr17171216wmj.7.1681915319103;
        Wed, 19 Apr 2023 07:41:59 -0700 (PDT)
Received: from [127.0.1.1] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id m22-20020a7bcb96000000b003f17131952fsm2388519wmi.29.2023.04.19.07.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 07:41:58 -0700 (PDT)
From:   Arnaud Vrac <avrac@freebox.fr>
Date:   Wed, 19 Apr 2023 16:41:13 +0200
Subject: [PATCH 06/11] drm/msm/dpu: support cursor sspp hw blocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230419-dpu-tweaks-v1-6-d1bac46db075@freebox.fr>
References: <20230419-dpu-tweaks-v1-0-d1bac46db075@freebox.fr>
In-Reply-To: <20230419-dpu-tweaks-v1-0-d1bac46db075@freebox.fr>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Arnaud Vrac <avrac@freebox.fr>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4055; i=avrac@freebox.fr;
 h=from:subject:message-id; bh=JIN3wOAwRVDkVnPtsZfcQyHShaT43mZJjQaS4MuN1UU=;
 b=owEBbQKS/ZANAwAIAXED/9m7NDSrAcsmYgBkP/2izIHn4G021J6ANBFbFX+WtbijpqW9KvBFY
 pB2QJc9EzyJAjMEAAEIAB0WIQSUwb/ndwkXHdZ/QQZxA//ZuzQ0qwUCZD/9ogAKCRBxA//ZuzQ0
 qx3jD/wP2/AD6Il7RXMRRrIsrRVYu3W++Ep5Yc+PFxyTi5+BnuCvuv8VakNG1e9ubJ6WWyT6d3b
 xnctAKrsGKFOMyC/7mGJ9+5CwR0EJ9Hn1DZVfZ3S0RZng8TxD5CUAHlSJifKfvZEh8PHlNoABuP
 9LX2eXedY1HDcoYeLFKer1BD19/6V03G0E+HwgKWlUtHuI3sZlyWdB5lMBFdM6MbfApECvNXWBl
 vfYNv7JxAlf9KVBpc66UfCKuBwjakG19dvxDeodFnGVCHINs5yIW1+W/jUz85vadPUempbJWlwk
 bZHLkqbdtptrzTVYcGRJ8H+JRv4wCi4maG3l4Y407VPtYkTJJJyLhhZ6Ktgz1m5WHfOUI+wB1VT
 0+EX9Jm+qyFY3MxTDmd2GJi8rElsK87p+D+/jLszbWnJrA64jmazciEODemu0wVL+MPqX9bNbPs
 wn0XE7GOtU7oFE8pvtZFoR3iPkfiYSj6tRy57NAMeD7xDbGZ46nOOdNhiml0pHqtpB8MeNyf3iz
 B+Hor7gxz7abwgQfN+S6FoKrBLWdnwzoa7TQU33PxQhc6A1tQwf5cm+z3cxLKR+MiKjhlDRcftN
 PHyhv3TtV9vcPpnXk1LHLSXHHlrWG4ySJTmft2kGccJXG3UlJfkV7DBhVnjkv8WWcZYTBJLuBgE
 x9mqsOvYDGc2YTQ==
X-Developer-Key: i=avrac@freebox.fr; a=openpgp;
 fpr=6225092072BB58E3CEEC091E75392A176D952DB4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cursor SSPP must be assigned to the last mixer stage, so we assign an
immutable zpos property with a value higher than primary/overlay planes,
to ensure it will always be on top.

Signed-off-by: Arnaud Vrac <avrac@freebox.fr>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c   | 19 ++++++++++++++-----
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 26 +++++++++++++++++++++++---
 2 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index 0e7a68714e9e1..6cce0f6cfcb01 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -738,13 +738,22 @@ static int _dpu_kms_drm_obj_init(struct dpu_kms *dpu_kms)
 	for (i = 0; i < catalog->sspp_count; i++) {
 		enum drm_plane_type type;
 
-		if ((catalog->sspp[i].features & BIT(DPU_SSPP_CURSOR))
-			&& cursor_planes_idx < max_crtc_count)
-			type = DRM_PLANE_TYPE_CURSOR;
-		else if (primary_planes_idx < max_crtc_count)
+		if (catalog->sspp[i].features & BIT(DPU_SSPP_CURSOR)) {
+			if (cursor_planes_idx < max_crtc_count) {
+				type = DRM_PLANE_TYPE_CURSOR;
+			} else if (catalog->sspp[i].type == SSPP_TYPE_CURSOR) {
+				/* Cursor SSPP can only be used in the last
+				 * mixer stage, so it doesn't make sense to
+				 * assign two of those to the same CRTC */
+				continue;
+			} else {
+				type = DRM_PLANE_TYPE_OVERLAY;
+			}
+		} else if (primary_planes_idx < max_crtc_count) {
 			type = DRM_PLANE_TYPE_PRIMARY;
-		else
+		} else {
 			type = DRM_PLANE_TYPE_OVERLAY;
+		}
 
 		DPU_DEBUG("Create plane type %d with features %lx (cur %lx)\n",
 			  type, catalog->sspp[i].features,
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
index 128ecdc145260..5a7bb8543866c 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
@@ -881,7 +881,14 @@ static int dpu_plane_atomic_check(struct drm_plane *plane,
 	r_pipe->multirect_mode = DPU_SSPP_MULTIRECT_NONE;
 	r_pipe->sspp = NULL;
 
-	pstate->stage = DPU_STAGE_BASE + pstate->base.normalized_zpos;
+	if (pipe_hw_caps->type == SSPP_TYPE_CURSOR) {
+		/* enforce cursor sspp to use the last mixer stage */
+		pstate->stage = DPU_STAGE_BASE +
+			pdpu->catalog->caps->max_mixer_blendstages;
+	} else {
+		pstate->stage = DPU_STAGE_BASE + pstate->base.normalized_zpos;
+	}
+
 	if (pstate->stage > DPU_STAGE_BASE + pdpu->catalog->caps->max_mixer_blendstages) {
 		DPU_ERROR("> %d plane mixer stages assigned\n",
 			  pdpu->catalog->caps->max_mixer_blendstages);
@@ -1463,6 +1470,7 @@ struct drm_plane *dpu_plane_init(struct drm_device *dev,
 	struct msm_drm_private *priv = dev->dev_private;
 	struct dpu_kms *kms = to_dpu_kms(priv->kms);
 	struct dpu_hw_sspp *pipe_hw;
+	const uint64_t *format_modifiers;
 	uint32_t num_formats;
 	uint32_t supported_rotations;
 	int ret = -EINVAL;
@@ -1489,15 +1497,27 @@ struct drm_plane *dpu_plane_init(struct drm_device *dev,
 	format_list = pipe_hw->cap->sblk->format_list;
 	num_formats = pipe_hw->cap->sblk->num_formats;
 
+	if (pipe_hw->cap->type == SSPP_TYPE_CURSOR)
+		format_modifiers = NULL;
+	else
+		format_modifiers = supported_format_modifiers;
+
 	ret = drm_universal_plane_init(dev, plane, 0xff, &dpu_plane_funcs,
 				format_list, num_formats,
-				supported_format_modifiers, type, NULL);
+				format_modifiers, type, NULL);
 	if (ret)
 		goto clean_plane;
 
 	pdpu->catalog = kms->catalog;
 
-	ret = drm_plane_create_zpos_property(plane, 0, 0, DPU_ZPOS_MAX);
+	if (pipe_hw->cap->type == SSPP_TYPE_CURSOR) {
+		/* cursor SSPP can only be used in the last mixer stage,
+		 * enforce it by maxing out the cursor plane zpos */
+		ret = drm_plane_create_zpos_immutable_property(plane, DPU_ZPOS_MAX);
+	} else {
+		ret = drm_plane_create_zpos_property(plane, 0, 0, DPU_ZPOS_MAX - 1);
+	}
+
 	if (ret)
 		DPU_ERROR("failed to install zpos property, rc = %d\n", ret);
 

-- 
2.40.0

