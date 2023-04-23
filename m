Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79AE6EC046
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 16:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjDWOPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 10:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbjDWOPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 10:15:21 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6751330F5
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 07:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Hj+41OAGChCkaIi9YXRqlEYXZ5g/+UsZBvfDycRkUvs=; b=AQBnmpqHLmaGWXY8B+vvIMQ5fI
        FsT0iFt+CjslQ7cEGoxl5K2M+FTdDpUAE464kVGnbtKcrwodU4Fa3RwE1+wj2mUDdr0Ata/aqt1OG
        ie1fkBpZFsFebdeOabZum2K/5ateXqXV+un/E5r6SmgwKPbpYAbotaH4PPQfti7K5bbrrQmoIqK1+
        bL+Uh06UrTyrUCWImEsm4bsY6cXMPU3w3cmksPrJB3QaDazsTdT7Qiq3X8IK1RtU0MNhFKuDlcWnF
        nbgWCSheuGPQaW2ADYc7XKBg2xwcq384WVArUiI0qhWKruD79KY/RKvcuPwLyhNvPR0rVyz8DA6Cz
        QXAsGmPg==;
Received: from nat-wifi.fi.muni.cz ([147.251.43.9] helo=killbill.fi.muni.cz)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1pqaT1-00ANVs-I6; Sun, 23 Apr 2023 16:13:27 +0200
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
Subject: [RFC PATCH 27/40] drm/amd/display: add CRTC regamma TF support
Date:   Sun, 23 Apr 2023 13:10:39 -0100
Message-Id: <20230423141051.702990-28-mwen@igalia.com>
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

Add predefined transfer function programming. There is no out gamma ROM,
but we can use AMD color modules to program LUT parameters from a
predefined TF and an empty regamma LUT (or power LUT parameters with
predefined TF setup).

Signed-off-by: Joshua Ashton <joshua@froggi.es>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   | 60 ++++++++++++++-----
 1 file changed, 44 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index ff29be3929af..55aa876a5008 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -268,16 +268,18 @@ static int __set_output_tf(struct dc_transfer_func *func,
 	struct calculate_buffer cal_buffer = {0};
 	bool res;
 
-	ASSERT(lut && lut_size == MAX_COLOR_LUT_ENTRIES);
-
 	cal_buffer.buffer_index = -1;
 
-	gamma = dc_create_gamma();
-	if (!gamma)
-		return -ENOMEM;
+	if (lut_size) {
+		ASSERT(lut && lut_size == MAX_COLOR_LUT_ENTRIES);
 
-	gamma->num_entries = lut_size;
-	__drm_lut_to_dc_gamma(lut, gamma, false);
+		gamma = dc_create_gamma();
+		if (!gamma)
+			return -ENOMEM;
+
+		gamma->num_entries = lut_size;
+		__drm_lut_to_dc_gamma(lut, gamma, false);
+	}
 
 	if (func->tf == TRANSFER_FUNCTION_LINEAR) {
 		/*
@@ -285,30 +287,34 @@ static int __set_output_tf(struct dc_transfer_func *func,
 		 * on top of a linear input. But degamma params can be used
 		 * instead to simulate this.
 		 */
-		gamma->type = GAMMA_CUSTOM;
+		if (gamma)
+			gamma->type = GAMMA_CUSTOM;
 		res = mod_color_calculate_degamma_params(NULL, func,
-							gamma, true);
+							 gamma, gamma != NULL);
 	} else {
 		/*
 		 * Assume sRGB. The actual mapping will depend on whether the
 		 * input was legacy or not.
 		 */
-		gamma->type = GAMMA_CS_TFM_1D;
-		res = mod_color_calculate_regamma_params(func, gamma, false,
+		if (gamma)
+			gamma->type = GAMMA_CS_TFM_1D;
+		res = mod_color_calculate_regamma_params(func, gamma, gamma != NULL,
 							 has_rom, NULL, &cal_buffer);
 	}
 
-	dc_gamma_release(&gamma);
+	if (gamma)
+		dc_gamma_release(&gamma);
 
 	return res ? 0 : -ENOMEM;
 }
 
 static int amdgpu_dm_set_atomic_regamma(struct dc_stream_state *stream,
 					const struct drm_color_lut *regamma_lut,
-					uint32_t regamma_size, bool has_rom)
+					uint32_t regamma_size, bool has_rom,
+					enum dc_transfer_func_predefined tf)
 {
 	int ret = 0;
-	if (regamma_size) {
+	if (regamma_size || tf != TRANSFER_FUNCTION_LINEAR) {
 		/* CRTC RGM goes into RGM LUT.
 		 *
 		 * Note: there is no implicit sRGB regamma here. We are using
@@ -316,7 +322,7 @@ static int amdgpu_dm_set_atomic_regamma(struct dc_stream_state *stream,
 		 * from a linear base.
 		 */
 		stream->out_transfer_func->type = TF_TYPE_DISTRIBUTED_POINTS;
-		stream->out_transfer_func->tf = TRANSFER_FUNCTION_LINEAR;
+		stream->out_transfer_func->tf = tf;
 
 		ret = __set_output_tf(stream->out_transfer_func,
 				      regamma_lut, regamma_size, has_rom);
@@ -364,6 +370,25 @@ static int __set_input_tf(struct dc_transfer_func *func,
 }
 
 #ifdef CONFIG_STEAM_DECK
+static enum dc_transfer_func_predefined drm_tf_to_dc_tf(enum drm_transfer_function drm_tf)
+{
+	switch (drm_tf)
+	{
+	default:
+	case DRM_TRANSFER_FUNCTION_DEFAULT:	return TRANSFER_FUNCTION_LINEAR;
+	case DRM_TRANSFER_FUNCTION_SRGB:	return TRANSFER_FUNCTION_SRGB;
+
+	case DRM_TRANSFER_FUNCTION_BT709:	return TRANSFER_FUNCTION_BT709;
+	case DRM_TRANSFER_FUNCTION_PQ:		return TRANSFER_FUNCTION_PQ;
+	case DRM_TRANSFER_FUNCTION_LINEAR:	return TRANSFER_FUNCTION_LINEAR;
+	case DRM_TRANSFER_FUNCTION_UNITY:	return TRANSFER_FUNCTION_UNITY;
+	case DRM_TRANSFER_FUNCTION_HLG:		return TRANSFER_FUNCTION_HLG;
+	case DRM_TRANSFER_FUNCTION_GAMMA22:	return TRANSFER_FUNCTION_GAMMA22;
+	case DRM_TRANSFER_FUNCTION_GAMMA24:	return TRANSFER_FUNCTION_GAMMA24;
+	case DRM_TRANSFER_FUNCTION_GAMMA26:	return TRANSFER_FUNCTION_GAMMA26;
+	}
+}
+
 static void __to_dc_lut3d_color(struct dc_rgb *rgb,
 				const struct drm_color_lut lut,
 				int bit_precision)
@@ -640,6 +665,7 @@ int amdgpu_dm_update_crtc_color_mgmt(struct dm_crtc_state *crtc,
 	const struct drm_color_lut *degamma_lut, *regamma_lut;
 	uint32_t degamma_size, regamma_size;
 	bool has_regamma, has_degamma;
+	enum dc_transfer_func_predefined tf = TRANSFER_FUNCTION_LINEAR;
 	bool is_legacy;
 	int r;
 #ifdef CONFIG_STEAM_DECK
@@ -652,6 +678,8 @@ int amdgpu_dm_update_crtc_color_mgmt(struct dm_crtc_state *crtc,
 
 	lut3d = __extract_blob_lut(crtc->lut3d, &lut3d_size);
 	shaper_lut = __extract_blob_lut(crtc->shaper_lut, &shaper_size);
+
+	tf = drm_tf_to_dc_tf(crtc->gamma_tf);
 #endif
 
 	r = amdgpu_dm_verify_lut_sizes(&crtc->base);
@@ -718,7 +746,7 @@ int amdgpu_dm_update_crtc_color_mgmt(struct dm_crtc_state *crtc,
 		 */
 		regamma_size = has_regamma ? regamma_size : 0;
 		r = amdgpu_dm_set_atomic_regamma(stream, regamma_lut,
-						 regamma_size, has_rom);
+						 regamma_size, has_rom, tf);
 		if (r)
 			return r;
 	}
-- 
2.39.2

