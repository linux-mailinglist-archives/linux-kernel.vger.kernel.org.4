Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962BE6EC07A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 16:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjDWOqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 10:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbjDWOqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 10:46:39 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C1E1701
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 07:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=YuRvpsn5roC+eRUxTHLyKChKqQovXO5NGq7R4iJaNio=; b=FNUSIzcpPCB6FEpiH8zNLT8EVn
        FKHwSPuShGgq3xWnWZaDT3vF72WB3E+4l2s1M2C1c6QMBsRwUgFzuiVYUC/+/hBKWbDpCj4Sx3azm
        r5grGq3nR6ebdh67g1rIEj88WslocWkWQS0h0l4Su4LT5A7uziEHbR9+PLZwFZ2suBw4UlA+Kg7KZ
        ZNyVOWRBIJfGnuAmXCxcbrmXZz+aOdQbvrsGjJfUGx25Gcbs/93zjxsqDizmWncZzWYTYU/KUBmyk
        L8Rwi0hvAlQ97Rw8j1L1Xubxa9LNnpqJi4pPb+TL+Lz+iCHL8nUWUaWxMQXQ+8kmkvqeN8O4/8/p1
        VOj7whEQ==;
Received: from nat-wifi.fi.muni.cz ([147.251.43.9] helo=killbill.fi.muni.cz)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1pqaSP-00ANVs-HQ; Sun, 23 Apr 2023 16:12:49 +0200
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
Subject: [RFC PATCH 16/40] drm/amd/display: add plane blend LUT and TF driver-private properties
Date:   Sun, 23 Apr 2023 13:10:28 -0100
Message-Id: <20230423141051.702990-17-mwen@igalia.com>
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

Blend 1D LUT or a predefined transfer function can be set to linearize
content before blending, so that it's positioned just before blending
planes, and after 3D LUT (non-linear space). Shaper and Blend LUTs are
1D LUTs that sandwich 3D LUT. Drivers should advertize blend properties
according to HW caps.

Signed-off-by: Joshua Ashton <joshua@froggi.es>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   | 23 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h      | 18 ++++++++++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 12 +++++++
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 34 +++++++++++++++++++
 4 files changed, 87 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 2bf8b19feae4..0bcf0bc6baff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -1369,6 +1369,29 @@ amdgpu_display_create_color_properties(struct amdgpu_device *adev)
 		return -ENOMEM;
 	adev->mode_info.plane_lut3d_size_property = prop;
 
+	prop = drm_property_create(adev_to_drm(adev),
+				   DRM_MODE_PROP_BLOB,
+				   "AMD_PLANE_BLEND_LUT", 0);
+	if (!prop)
+		return -ENOMEM;
+	adev->mode_info.plane_blend_lut_property = prop;
+
+	prop = drm_property_create_range(adev_to_drm(adev),
+					 DRM_MODE_PROP_IMMUTABLE,
+					 "AMD_PLANE_BLEND_LUT_SIZE", 0, UINT_MAX);
+	if (!prop)
+		return -ENOMEM;
+	adev->mode_info.plane_blend_lut_size_property = prop;
+
+	prop = drm_property_create_enum(adev_to_drm(adev),
+					DRM_MODE_PROP_ENUM,
+					"AMD_PLANE_BLEND_TF",
+					drm_transfer_function_enum_list,
+					ARRAY_SIZE(drm_transfer_function_enum_list));
+	if (!prop)
+		return -ENOMEM;
+	adev->mode_info.plane_blend_tf_property = prop;
+
 	return 0;
 }
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
index 17c7669ad9ab..f640dbd53b8c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
@@ -417,6 +417,24 @@ struct amdgpu_mode_info {
 	 * size of 3D LUT as supported by the driver (read-only).
 	 */
 	struct drm_property *plane_lut3d_size_property;
+	/**
+	 * @plane_blend_lut_property: Plane property for output gamma before
+	 * blending. Userspace set a blend LUT to convert colors after 3D LUT
+	 * conversion. It works as a post-3D LUT 1D LUT, with shaper LUT, they
+	 * are sandwiching 3D LUT with two 1D LUT.
+	 */
+	struct drm_property *plane_blend_lut_property;
+	/**
+	 * @plane_blend_lut_size_property: Plane property to define the max
+	 * size of blend LUT as supported by the driver (read-only).
+	 */
+	struct drm_property *plane_blend_lut_size_property;
+	/**
+	 * @plane_blend_tf_property: Plane property to set a predefined
+	 * transfer function for pre-blending blend (before applying 3D LUT)
+	 * with or without LUT.
+	 */
+	struct drm_property *plane_blend_tf_property;
 #endif
 };
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 8a425e7a7e89..54121c3fa040 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -764,6 +764,18 @@ struct dm_plane_state {
 	 * &struct drm_color_lut.
 	 */
 	struct drm_property_blob *lut3d;
+	/**
+	 * @blend_lut: blend lut lookup table blob. The blob (if not NULL) is an
+	 * array of &struct drm_color_lut.
+	 */
+	struct drm_property_blob *blend_lut;
+	/**
+	 * @blend_tf:
+	 *
+	 * Pre-defined transfer function for converting plane pixel data before
+	 * applying blend LUT.
+	 */
+	enum drm_transfer_function blend_tf;
 #endif
 };
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index e4f28fbf6613..cdbd11f3be20 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -1325,6 +1325,7 @@ static void dm_drm_plane_reset(struct drm_plane *plane)
 		amdgpu_state->degamma_tf = DRM_TRANSFER_FUNCTION_DEFAULT;
 		amdgpu_state->hdr_mult = AMDGPU_HDR_MULT_DEFAULT;
 		amdgpu_state->shaper_tf = DRM_TRANSFER_FUNCTION_DEFAULT;
+		amdgpu_state->blend_tf = DRM_TRANSFER_FUNCTION_DEFAULT;
 	}
 #endif
 }
@@ -1352,6 +1353,8 @@ dm_drm_plane_duplicate_state(struct drm_plane *plane)
 		drm_property_blob_get(dm_plane_state->shaper_lut);
 	if (dm_plane_state->lut3d)
 		drm_property_blob_get(dm_plane_state->lut3d);
+	if (dm_plane_state->blend_lut)
+		drm_property_blob_get(dm_plane_state->blend_lut);
 #endif
 
 	return &dm_plane_state->base;
@@ -1424,6 +1427,7 @@ static void dm_drm_plane_destroy_state(struct drm_plane *plane,
 	drm_property_blob_put(dm_plane_state->degamma_lut);
 	drm_property_blob_put(dm_plane_state->shaper_lut);
 	drm_property_blob_put(dm_plane_state->lut3d);
+	drm_property_blob_put(dm_plane_state->blend_lut);
 #endif
 
 	if (dm_plane_state->dc_state)
@@ -1513,6 +1517,17 @@ dm_plane_attach_color_mgmt_properties(struct amdgpu_display_manager *dm,
 					   dm->adev->mode_info.plane_lut3d_size_property,
 					   MAX_COLOR_3DLUT_ENTRIES);
 	}
+
+	if (dm->dc->caps.color.dpp.ogam_ram) {
+		drm_object_attach_property(&plane->base,
+					   dm->adev->mode_info.plane_blend_lut_property, 0);
+		drm_object_attach_property(&plane->base,
+					   dm->adev->mode_info.plane_blend_lut_size_property,
+					   MAX_COLOR_LUT_ENTRIES);
+		drm_object_attach_property(&plane->base,
+					   dm->adev->mode_info.plane_blend_tf_property,
+					   DRM_TRANSFER_FUNCTION_DEFAULT);
+	}
 }
 
 static int
@@ -1564,6 +1579,19 @@ dm_atomic_plane_set_property(struct drm_plane *plane,
 					&replaced);
 		dm_plane_state->base.color_mgmt_changed |= replaced;
 		return ret;
+	} else if (property == adev->mode_info.plane_blend_lut_property) {
+		ret = amdgpu_dm_replace_property_blob_from_id(plane->dev,
+					&dm_plane_state->blend_lut,
+					val,
+					-1, sizeof(struct drm_color_lut),
+					&replaced);
+		dm_plane_state->base.color_mgmt_changed |= replaced;
+		return ret;
+	} else if (property == adev->mode_info.plane_blend_tf_property) {
+		if (dm_plane_state->blend_tf != val) {
+			dm_plane_state->blend_tf = val;
+			dm_plane_state->base.color_mgmt_changed = 1;
+		}
 	} else {
 		drm_dbg_atomic(plane->dev,
 			       "[PLANE:%d:%s] unknown property [PROP:%d:%s]]\n",
@@ -1600,6 +1628,12 @@ dm_atomic_plane_get_property(struct drm_plane *plane,
 	} else 	if (property == adev->mode_info.plane_lut3d_property) {
 		*val = (dm_plane_state->lut3d) ?
 			dm_plane_state->lut3d->base.id : 0;
+	} else 	if (property == adev->mode_info.plane_blend_lut_property) {
+		*val = (dm_plane_state->blend_lut) ?
+			dm_plane_state->blend_lut->base.id : 0;
+	} else if (property == adev->mode_info.plane_blend_tf_property) {
+		*val = dm_plane_state->blend_tf;
+
 	} else {
 		return -EINVAL;
 	}
-- 
2.39.2

