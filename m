Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A60B6EC083
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 16:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjDWOsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 10:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjDWOsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 10:48:21 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D5610F0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 07:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=j3/12jxSdcW585zS5aTXAW8FYxDjDH8xTDC6oGODNZ4=; b=gGPYg1jP8KMZzxXdI1YyTRkYWD
        ZOSsJyEWVsUa4GnVoAhvsXfQe5MwF/3xExwFTIXBkBhDy26yZagqaIfPPwFlbEkrrNcPp3NBd7CBE
        cKO/cuBPRttDjjstSCMeNkP6/A7WLmMcJoClGtyLVXAtwsZga4YDQHji8U8a1HHhz6hienUN4W++V
        g3vS9eYtpHFvmFYUtrlL8GLh2d9et+g2dxLs6Bzn1Ewt/J7yqREVBcR/w9pFXOxaMg5xpSPow0Sfi
        02XeYziyiJQbR9xryPVYgY113jjbSkCgryI/9m2MC3TEQVdXp7BXUzlfxY8tzz68AwJZFnQMRyu1g
        VY7vcTog==;
Received: from nat-wifi.fi.muni.cz ([147.251.43.9] helo=killbill.fi.muni.cz)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1pqaTZ-00ANVs-0W; Sun, 23 Apr 2023 16:14:01 +0200
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
Subject: [RFC PATCH 36/40] drm/amd/display: add plane shaper/3D LUT and shaper TF support
Date:   Sun, 23 Apr 2023 13:10:48 -0100
Message-Id: <20230423141051.702990-37-mwen@igalia.com>
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

We already have the steps to program post-blending shaper/3D LUT on AMD
display driver, so that we can reuse them and map plane properties to DC
plane for pre-blending (plane) shaper/3D LUT setup.

Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   | 34 +++++++++++++++++--
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  5 +--
 2 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index 854510b05194..e17141fc8d12 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -909,6 +909,35 @@ __set_dm_plane_degamma(struct drm_plane_state *plane_state,
 	}
 	return 0;
 }
+
+static int
+amdgpu_dm_plane_set_color_properties(struct drm_plane_state *plane_state,
+				     struct dc_plane_state *dc_plane_state)
+{
+	struct dm_plane_state *dm_plane_state = to_dm_plane_state(plane_state);
+	enum drm_transfer_function shaper_tf = DRM_TRANSFER_FUNCTION_DEFAULT;
+	const struct drm_color_lut *shaper_lut, *lut3d;
+	uint32_t lut3d_size, shaper_size;
+
+	/* We have nothing to do here, return */
+	if (!plane_state->color_mgmt_changed)
+		return 0;
+
+	dc_plane_state->hdr_mult = dc_fixpt_from_s3132(dm_plane_state->hdr_mult);
+
+	shaper_tf = dm_plane_state->shaper_tf;
+	shaper_lut = __extract_blob_lut(dm_plane_state->shaper_lut, &shaper_size);
+	lut3d = __extract_blob_lut(dm_plane_state->lut3d, &lut3d_size);
+	lut3d_size = lut3d != NULL ? lut3d_size : 0;
+	shaper_size = shaper_lut != NULL ? shaper_size : 0;
+
+	amdgpu_dm_atomic_lut3d(lut3d, lut3d_size, dc_plane_state->lut3d_func);
+	ret = amdgpu_dm_atomic_shaper_lut(shaper_lut, false,
+					  drm_tf_to_dc_tf(shaper_tf),
+					  shaper_size, dc_plane_state->in_shaper_func);
+
+	return ret;
+}
 #endif
 
 /**
@@ -939,7 +968,9 @@ int amdgpu_dm_update_plane_color_mgmt(struct dm_crtc_state *crtc,
 	has_crtc_cm_degamma = (crtc->cm_has_degamma || crtc->cm_is_degamma_srgb);
 
 #ifdef CONFIG_STEAM_DECK
-	dc_plane_state->hdr_mult = dc_fixpt_from_s3132(dm_plane_state->hdr_mult);
+	ret = amdgpu_dm_plane_set_color_properties(plane_state, dc_plane_state);
+	if(ret)
+		return ret;
 
 	ret = __set_dm_plane_degamma(plane_state, dc_plane_state);
 	if (ret != -EINVAL)
@@ -971,6 +1002,5 @@ int amdgpu_dm_update_plane_color_mgmt(struct dm_crtc_state *crtc,
 			return ret;
 	}
 
-
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 5800acf6aae1..91fee60410f4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1759,8 +1759,9 @@ static void dcn20_program_pipe(
 		hws->funcs.set_hdr_multiplier(pipe_ctx);
 
 	if (pipe_ctx->update_flags.bits.enable ||
-			pipe_ctx->plane_state->update_flags.bits.in_transfer_func_change ||
-			pipe_ctx->plane_state->update_flags.bits.gamma_change)
+	    pipe_ctx->plane_state->update_flags.bits.in_transfer_func_change ||
+	    pipe_ctx->plane_state->update_flags.bits.gamma_change ||
+	    pipe_ctx->plane_state->update_flags.bits.lut_3d)
 		hws->funcs.set_input_transfer_func(dc, pipe_ctx, pipe_ctx->plane_state);
 
 	/* dcn10_translate_regamma_to_hw_format takes 750us to finish
-- 
2.39.2

