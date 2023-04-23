Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786576EC002
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 16:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjDWOMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 10:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjDWOMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 10:12:37 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2D510F0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 07:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=wQhPhw7uUonhHv6/pWaJwwFqQGY16VHjVM8DO5hkoxs=; b=qDuXtaWPVP/TKMVjyGy+mjnaLX
        LxYOPVWECl+YkJA4RcDIRr3nMqDwH2ZnP6/zouD+0EZfJ+tODlPAf6VUkVFj/wj0JO9Cwsg+A0TDk
        ChIum3eAfJKKKfE0+RWL41Wz7gIy0BPJH8sAatZzDeU20+2Agf6Z4PNBMNTEhg7H3itGe8e2D/gVF
        tjLHQ8IPFDgQW4rgXvK+AcW167XXtY+Qcfdn03BoHDtUGEQEDRZGxroN6D1TCkRV0vAGZPTsRJO8f
        P/8X0eEh7eH+PRsl//4vMrDl47QYkSDX8QDDsr3KBcf/J0GZRWnK+Q1/lzQ7yYHwkRt8wIL83Rd87
        PWJjHKSQ==;
Received: from nat-wifi.fi.muni.cz ([147.251.43.9] helo=killbill.fi.muni.cz)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1pqaRq-00ANVs-Bb; Sun, 23 Apr 2023 16:12:14 +0200
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
Subject: [RFC PATCH 07/40] drm/amd/display: add CRTC gamma TF to driver-private props
Date:   Sun, 23 Apr 2023 13:10:19 -0100
Message-Id: <20230423141051.702990-8-mwen@igalia.com>
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

Add predefined transfer function property to DRM CRTC gamma to convert
to wire encoding with or without gamma LUT.

Co-developed-by: Melissa Wen <mwen@igalia.com>
Signed-off-by: Melissa Wen <mwen@igalia.com>
Signed-off-by: Joshua Ashton <joshua@froggi.es>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   | 22 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h      |  4 ++++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 23 +++++++++++++++++++
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    | 13 +++++++++++
 4 files changed, 62 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 2abe5fe87c10..1913903cab88 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -1248,6 +1248,19 @@ amdgpu_display_user_framebuffer_create(struct drm_device *dev,
 }
 
 #ifdef CONFIG_STEAM_DECK
+static const struct drm_prop_enum_list drm_transfer_function_enum_list[] = {
+	{ DRM_TRANSFER_FUNCTION_DEFAULT, "Default" },
+	{ DRM_TRANSFER_FUNCTION_SRGB, "sRGB" },
+	{ DRM_TRANSFER_FUNCTION_BT709, "BT.709" },
+	{ DRM_TRANSFER_FUNCTION_PQ, "PQ (Perceptual Quantizer)" },
+	{ DRM_TRANSFER_FUNCTION_LINEAR, "Linear" },
+	{ DRM_TRANSFER_FUNCTION_UNITY, "Unity" },
+	{ DRM_TRANSFER_FUNCTION_HLG, "HLG (Hybrid Log Gamma)" },
+	{ DRM_TRANSFER_FUNCTION_GAMMA22, "Gamma 2.2" },
+	{ DRM_TRANSFER_FUNCTION_GAMMA24, "Gamma 2.4" },
+	{ DRM_TRANSFER_FUNCTION_GAMMA26, "Gamma 2.6" },
+};
+
 static int
 amdgpu_display_create_color_properties(struct amdgpu_device *adev)
 {
@@ -1281,6 +1294,15 @@ amdgpu_display_create_color_properties(struct amdgpu_device *adev)
 		return -ENOMEM;
 	adev->mode_info.lut3d_size_property = prop;
 
+	prop = drm_property_create_enum(adev_to_drm(adev),
+					DRM_MODE_PROP_ENUM,
+					"GAMMA_TF",
+					drm_transfer_function_enum_list,
+					ARRAY_SIZE(drm_transfer_function_enum_list));
+	if (!prop)
+		return -ENOMEM;
+	adev->mode_info.gamma_tf_property = prop;
+
 	return 0;
 }
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
index 205fa4f5bea7..76337e18c728 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
@@ -368,6 +368,10 @@ struct amdgpu_mode_info {
 	 * LUT as supported by the driver (read-only).
 	 */
 	struct drm_property *lut3d_size_property;
+	/**
+	 * @gamma_tf_property: Transfer function for CRTC regamma.
+	 */
+	struct drm_property *gamma_tf_property;
 #endif
 };
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 09c3e1858b56..1e90a2dd445e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -699,6 +699,23 @@ static inline void amdgpu_dm_set_mst_status(uint8_t *status,
 
 extern const struct amdgpu_ip_block_version dm_ip_block;
 
+#ifdef CONFIG_STEAM_DECK
+enum drm_transfer_function {
+	DRM_TRANSFER_FUNCTION_DEFAULT,
+
+	DRM_TRANSFER_FUNCTION_SRGB,
+	DRM_TRANSFER_FUNCTION_BT709,
+	DRM_TRANSFER_FUNCTION_PQ,
+	DRM_TRANSFER_FUNCTION_LINEAR,
+	DRM_TRANSFER_FUNCTION_UNITY,
+	DRM_TRANSFER_FUNCTION_HLG,
+	DRM_TRANSFER_FUNCTION_GAMMA22,
+	DRM_TRANSFER_FUNCTION_GAMMA24,
+	DRM_TRANSFER_FUNCTION_GAMMA26,
+	DRM_TRANSFER_FUNCTION_MAX,
+};
+#endif
+
 struct dm_plane_state {
 	struct drm_plane_state base;
 	struct dc_plane_state *dc_state;
@@ -751,6 +768,12 @@ struct dm_crtc_state {
 	 * &struct drm_color_lut.
 	 */
 	struct drm_property_blob *lut3d;
+        /**
+	 * @gamma_tf:
+	 *
+	 * Pre-defined transfer function for converting internal FB -> wire encoding.
+	 */
+	enum drm_transfer_function gamma_tf;
 #endif
 };
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 0e1280228e6e..79324fbab1f1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -272,6 +272,7 @@ static struct drm_crtc_state *dm_crtc_duplicate_state(struct drm_crtc *crtc)
 #ifdef CONFIG_STEAM_DECK
 	state->shaper_lut = cur->shaper_lut;
 	state->lut3d = cur->lut3d;
+	state->gamma_tf = cur->gamma_tf;
 
 	if (state->shaper_lut)
 		drm_property_blob_get(state->shaper_lut);
@@ -336,6 +337,11 @@ dm_crtc_additional_color_mgmt(struct drm_crtc *crtc)
 					   adev->mode_info.lut3d_size_property,
 					   MAX_COLOR_3DLUT_ENTRIES);
 	}
+
+	if(adev->dm.dc->caps.color.mpc.ogam_ram)
+		drm_object_attach_property(&crtc->base,
+					   adev->mode_info.gamma_tf_property,
+					   DRM_TRANSFER_FUNCTION_DEFAULT);
 }
 
 static int
@@ -398,6 +404,11 @@ amdgpu_dm_atomic_crtc_set_property(struct drm_crtc *crtc,
 					&replaced);
 		acrtc_state->base.color_mgmt_changed |= replaced;
 		return ret;
+	} else if (property == adev->mode_info.gamma_tf_property) {
+		if (acrtc_state->gamma_tf != val) {
+			acrtc_state->gamma_tf = val;
+			acrtc_state->base.color_mgmt_changed |= 1;
+		}
 	} else {
 		drm_dbg_atomic(crtc->dev,
 			       "[CRTC:%d:%s] unknown property [PROP:%d:%s]]\n",
@@ -424,6 +435,8 @@ amdgpu_dm_atomic_crtc_get_property(struct drm_crtc *crtc,
 	else if (property == adev->mode_info.lut3d_property)
 		*val = (acrtc_state->lut3d) ?
 			acrtc_state->lut3d->base.id : 0;
+	else if (property == adev->mode_info.gamma_tf_property)
+		*val = acrtc_state->gamma_tf;
 	else
 		return -EINVAL;
 
-- 
2.39.2

