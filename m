Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D340A6EC078
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 16:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjDWOqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 10:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjDWOqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 10:46:34 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33EDBE79
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 07:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=566kXB93gduhO2pKotI8dq2ueeNQbJHEXFmIOVEzq10=; b=FJPh6PhjvOZATxzA+xct5dbVc7
        gvsyJq189sn9N+Sx8/b9V6/F8OeScwhlxwajOaTzJvKBQnCNtyZ+iM7bAPOTmI8wsDKons2orsKLg
        /LWoGEFqE+GwbFxo8YTX1W/W4nPqxZnaFQTQ7yN+8uFphqOhYLY6upDlZo1wFnu4ydap/J1htHOx1
        ElZWZnaBcH19SMPD+XsHcuc+xXBL1MJlatgLUu1s4BcNufr4b8EfZk1FrYPnBxbRXMNmCFitoeLc0
        3Sj1JESKDWFQTgypjuGrJMcSMfIko5ngJRmWOzro7uRcaVm0fvU318+tQz7TI3dbXMiWAAYJIj4Zl
        U/HVg21Q==;
Received: from nat-wifi.fi.muni.cz ([147.251.43.9] helo=killbill.fi.muni.cz)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1pqaTg-00ANVs-Do; Sun, 23 Apr 2023 16:14:08 +0200
From:   Melissa Wen <mwen@igalia.com>
To:     amd-gfx@lists.freedesktop.org,
        Harry Wentland <harry.wentland@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        sunpeng.li@amd.com, Alex Deucher <alexander.deucher@amd.com>,
        dri-devel@lists.freedesktop.org, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     Joshua Ashton <joshua@froggi.es>,
        Sebastian Wick <sebastian.wick@redhat.com>,
        Xaver Hugl <xaver.hugl@gmail.com>,
        Shashank Sharma <Shashank.Sharma@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        sungjoon.kim@amd.com, Alex Hung <alex.hung@amd.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 38/40] drm/amd/display: add DRM plane blend LUT and TF support
Date:   Sun, 23 Apr 2023 13:10:50 -0100
Message-Id: <20230423141051.702990-39-mwen@igalia.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230423141051.702990-1-mwen@igalia.com>
References: <20230423141051.702990-1-mwen@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joshua Ashton <joshua@froggi.es>

Map DRM plane blend properties to DPP blend gamma. Plane blend is a
post-3D LUT curve that linearizes color space for blending. It may be
defined by a user-blob LUT and/or predefined transfer function. As
hardcoded curve (ROM) is not supported on blend gamma, we use AMD color
module to fill parameters when setting non-linear TF with empty LUT.

Signed-off-by: Joshua Ashton <joshua@froggi.es>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   | 60 +++++++++++++++++--
 1 file changed, 56 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index baa7fea9ebae..a034c0c0d383 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -493,6 +493,34 @@ static int amdgpu_dm_atomic_shaper_lut(const struct drm_color_lut *shaper_lut,
 	return ret;
 }
 
+static int amdgpu_dm_atomic_blend_lut(const struct drm_color_lut *blend_lut,
+				       bool has_rom,
+				       enum dc_transfer_func_predefined tf,
+				       uint32_t blend_size,
+				       struct dc_transfer_func *func_blend)
+{
+	int ret = 0;
+
+	if (blend_size || tf != TRANSFER_FUNCTION_LINEAR) {
+		/* DRM plane gamma LUT or TF means we are linearizing color
+		 * space before blending (similar to degamma programming). As
+		 * we don't have hardcoded curve support, or we use AMD color
+		 * module to fill the parameters that will be translated to HW
+		 * points.
+		 */
+		func_blend->type = TF_TYPE_DISTRIBUTED_POINTS;
+		func_blend->tf = tf;
+		func_blend->sdr_ref_white_level = 80; /* hardcoded for now */
+
+		ret = __set_input_tf(func_blend, blend_lut, blend_size);
+	} else {
+		func_blend->type = TF_TYPE_BYPASS;
+		func_blend->tf = TRANSFER_FUNCTION_LINEAR;
+	}
+
+	return ret;
+}
+
 /* amdgpu_dm_atomic_shaper_lut3d - set DRM CRTC shaper LUT and 3D LUT to DC
  * interface
  * @dc: Display Core control structure
@@ -921,9 +949,11 @@ amdgpu_dm_plane_set_color_properties(struct drm_plane_state *plane_state,
 {
 	struct dm_plane_state *dm_plane_state = to_dm_plane_state(plane_state);
 	enum drm_transfer_function shaper_tf = DRM_TRANSFER_FUNCTION_DEFAULT;
-	const struct drm_color_lut *shaper_lut, *lut3d;
-	uint32_t lut3d_size, shaper_size;
-
+	enum drm_transfer_function blend_tf = DRM_TRANSFER_FUNCTION_DEFAULT;
+	const struct drm_color_lut *shaper_lut, *lut3d, *blend_lut;
+	uint32_t lut3d_size, shaper_size, blend_size;
+	int ret;
+	
 	/* We have nothing to do here, return */
 	if (!plane_state->color_mgmt_changed)
 		return 0;
@@ -940,8 +970,30 @@ amdgpu_dm_plane_set_color_properties(struct drm_plane_state *plane_state,
 	ret = amdgpu_dm_atomic_shaper_lut(shaper_lut, false,
 					  drm_tf_to_dc_tf(shaper_tf),
 					  shaper_size, dc_plane_state->in_shaper_func);
+	if (ret) {
+		drm_dbg_kms(plane_state->plane->dev,
+			    "setting plane %d shaper/3d lut failed.\n",
+			    plane_state->plane->index);
 
-	return ret;
+		return ret;
+	}
+
+	blend_tf = dm_plane_state->blend_tf;
+	blend_lut = __extract_blob_lut(dm_plane_state->blend_lut, &blend_size);
+	blend_size = blend_lut != NULL ? blend_size : 0;
+
+	ret = amdgpu_dm_atomic_blend_lut(blend_lut, false,
+					 drm_tf_to_dc_tf(blend_tf),
+					 blend_size, dc_plane_state->blend_tf);
+	if (ret) {
+		drm_dbg_kms(plane_state->plane->dev,
+			    "setting plane %d gamma lut failed.\n",
+			    plane_state->plane->index);
+
+		return ret;
+	}
+
+	return 0;
 }
 #endif
 
-- 
2.39.2

