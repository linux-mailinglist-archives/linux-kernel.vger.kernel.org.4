Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0996EC085
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 16:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbjDWOtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 10:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbjDWOtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 10:49:05 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E541B1FD8
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 07:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=QwuSO2LNJ+LJ1+yrvEcZOrqAYwcz+YFmvLiCu9u3lbQ=; b=mORa53lOjf6BQPulDyK5c+ctGp
        7OS8D5hV+ZI9NRVY0Ypu6IY6WqiF0u0PogOM0YVPNCTSHAZv21TK2yltFeu/NOinJ5+GZDwCB8sIE
        XA2LN+prpg73D38iJoWmtLIxa5fZEQvsITh/jOLw7H43mP2xHOClrJnhXK8nwhrSnZlA7jJiRxwMo
        AcSCwp8ShKkdKEEZeFf0qUdetr2sbbhPccegDIUB1NCLhEWKf/hNebglaABOnRm6OA+ylqMCgVas3
        VvKi5XzfLqcTNLiddrsRsJYHNLCQl/x982gL31yJZNkebLSzsCoJKFm5A1IFgEq6EuGdTydUlVViZ
        WfDpbpnQ==;
Received: from nat-wifi.fi.muni.cz ([147.251.43.9] helo=killbill.fi.muni.cz)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1pqaTD-00ANVs-Ax; Sun, 23 Apr 2023 16:13:39 +0200
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
        Melissa Wen <mwen@igalia.com>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 31/40] drm/amd/display: decouple steps for mapping CRTC degamma to DC plane
Date:   Sun, 23 Apr 2023 13:10:43 -0100
Message-Id: <20230423141051.702990-32-mwen@igalia.com>
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

The next patch adds pre-blending degamma to AMD color mgmt pipeline, but
pre-blending degamma caps (DPP) is currently in use to provide DRM CRTC
atomic degamma or implict degamma on legacy gamma. Detach degamma usage
regarging CRTC color properties to manage plane and CRTC color
correction combinations.

Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   | 55 +++++++++++++------
 1 file changed, 38 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index 6a233380f284..518082222fff 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -791,20 +791,8 @@ int amdgpu_dm_update_crtc_color_mgmt(struct dm_crtc_state *crtc,
 	return 0;
 }
 
-/**
- * amdgpu_dm_update_plane_color_mgmt: Maps DRM color management to DC plane.
- * @crtc: amdgpu_dm crtc state
- * @dc_plane_state: target DC surface
- *
- * Update the underlying dc_stream_state's input transfer function (ITF) in
- * preparation for hardware commit. The transfer function used depends on
- * the preparation done on the stream for color management.
- *
- * Returns:
- * 0 on success. -ENOMEM if mem allocation fails.
- */
-int amdgpu_dm_update_plane_color_mgmt(struct dm_crtc_state *crtc,
-				      struct dc_plane_state *dc_plane_state)
+static int map_crtc_degamma_to_dc_plane(struct dm_crtc_state *crtc,
+					struct dc_plane_state *dc_plane_state)
 {
 	const struct drm_color_lut *degamma_lut;
 	enum dc_transfer_func_predefined tf = TRANSFER_FUNCTION_SRGB;
@@ -827,8 +815,7 @@ int amdgpu_dm_update_plane_color_mgmt(struct dm_crtc_state *crtc,
 						 &degamma_size);
 		ASSERT(degamma_size == MAX_COLOR_LUT_ENTRIES);
 
-		dc_plane_state->in_transfer_func->type =
-			TF_TYPE_DISTRIBUTED_POINTS;
+		dc_plane_state->in_transfer_func->type = TF_TYPE_DISTRIBUTED_POINTS;
 
 		/*
 		 * This case isn't fully correct, but also fairly
@@ -864,7 +851,7 @@ int amdgpu_dm_update_plane_color_mgmt(struct dm_crtc_state *crtc,
 				   degamma_lut, degamma_size);
 		if (r)
 			return r;
-	} else if (crtc->cm_is_degamma_srgb) {
+	} else {
 		/*
 		 * For legacy gamma support we need the regamma input
 		 * in linear space. Assume that the input is sRGB.
@@ -876,6 +863,40 @@ int amdgpu_dm_update_plane_color_mgmt(struct dm_crtc_state *crtc,
 		    !mod_color_calculate_degamma_params(NULL,
 			    dc_plane_state->in_transfer_func, NULL, false))
 			return -ENOMEM;
+	}
+
+	return 0;
+}
+
+/**
+ * amdgpu_dm_update_plane_color_mgmt: Maps DRM color management to DC plane.
+ * @crtc: amdgpu_dm crtc state
+ * @dc_plane_state: target DC surface
+ *
+ * Update the underlying dc_stream_state's input transfer function (ITF) in
+ * preparation for hardware commit. The transfer function used depends on
+ * the preparation done on the stream for color management.
+ *
+ * Returns:
+ * 0 on success. -ENOMEM if mem allocation fails.
+ */
+int amdgpu_dm_update_plane_color_mgmt(struct dm_crtc_state *crtc,
+				      struct dc_plane_state *dc_plane_state)
+{
+	bool has_crtc_cm_degamma;
+	int ret;
+
+	has_crtc_cm_degamma = (crtc->cm_has_degamma || crtc->cm_is_degamma_srgb);
+	if (has_crtc_cm_degamma){
+		/* AMD HW doesn't have post-blending degamma caps. When DRM
+		 * CRTC atomic degamma is set, we maps it to DPP degamma block
+		 * (pre-blending) or, on legacy gamma, we use DPP degamma to
+		 * linearize (implicit degamma) from sRGB/BT709 according to
+		 * the input space.
+		 */
+		ret = map_crtc_degamma_to_dc_plane(crtc, dc_plane_state);
+		if (ret)
+			return ret;
 	} else {
 		/* ...Otherwise we can just bypass the DGM block. */
 		dc_plane_state->in_transfer_func->type = TF_TYPE_BYPASS;
-- 
2.39.2

