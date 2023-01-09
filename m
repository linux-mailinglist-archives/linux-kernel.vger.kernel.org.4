Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE9D6628D8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 15:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233816AbjAIOoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 09:44:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbjAIOoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 09:44:09 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE6B1DF32
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 06:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=7CfsYtEI18MX2i5Kgmt0jdgzbdIqqCHC3Q3agzts8+c=; b=UL3SEY9MNm/HRAKaMOiG/xmouZ
        nJE2ZeA7LGNDnge+AfX5rDtZxdQADFu/s0tBBYtXi3aWuyFDqF52dGmPw0CsbtVDBZH00EViWc0T+
        Un/e+ipU7hHiQmwpqF0OU/p6n31/LPV3wXBwWQttPk6cixPZz478nsgJLUmJV/Ys/X6ZRPcDyeXux
        UStywPZtxU5KTxlBEUeust2jYLyW0JCrtRsN0HEI1ElSZWj4ps/dpZ99mekh/DJdd8rVVWiF4ae6w
        fFaAGdEncCudi3rcCTnPXQQjTxU2RhJcQQWRFjI97JTqgzlvMth5LB/oWi+cesiVflyD8yYicJbg+
        x0XCFixg==;
Received: from [41.74.137.107] (helo=killbill.home)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1pEtNP-003TyM-Pi; Mon, 09 Jan 2023 15:43:51 +0100
From:   Melissa Wen <mwen@igalia.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch
Cc:     Joshua Ashton <joshua@froggi.es>, alex.hung@amd.com,
        nicholas.kazlauskas@amd.com, sungjoon.kim@amd.com,
        seanpaul@chromium.org, bhawanpreet.lakha@amd.com,
        Shashank Sharma <shashank.sharma@amd.com>,
        ville.syrjala@linux.intel.com, kernel-dev@igalia.com,
        laurent.pinchart+renesas@ideasonboard.com,
        Melissa Wen <mwen@igalia.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 02/18] drm/drm_color_mgmt: add shaper LUT to color mgmt properties
Date:   Mon,  9 Jan 2023 13:38:30 -0100
Message-Id: <20230109143846.1966301-3-mwen@igalia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230109143846.1966301-1-mwen@igalia.com>
References: <20230109143846.1966301-1-mwen@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shaper LUT is used to shape the content after blending, i.e.,
de-linearize or normalize space before applying a 3D LUT color
correction. In the next patch, we add 3D LUT property to DRM color
management after this shaper LUT and before the current gamma LUT.

Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 drivers/gpu/drm/drm_atomic_state_helper.c |  4 ++++
 drivers/gpu/drm/drm_atomic_uapi.c         | 10 ++++++++++
 drivers/gpu/drm/drm_color_mgmt.c          | 18 ++++++++++++++++++
 drivers/gpu/drm/drm_fb_helper.c           |  3 +++
 drivers/gpu/drm/drm_mode_config.c         | 14 ++++++++++++++
 include/drm/drm_crtc.h                    | 14 ++++++++++++--
 include/drm/drm_mode_config.h             | 12 ++++++++++++
 include/drm/drm_mode_object.h             |  2 +-
 8 files changed, 74 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
index bf31b9d92094..4bc860d6cf75 100644
--- a/drivers/gpu/drm/drm_atomic_state_helper.c
+++ b/drivers/gpu/drm/drm_atomic_state_helper.c
@@ -141,8 +141,11 @@ void __drm_atomic_helper_crtc_duplicate_state(struct drm_crtc *crtc,
 		drm_property_blob_get(state->degamma_lut);
 	if (state->ctm)
 		drm_property_blob_get(state->ctm);
+	if (state->shaper_lut)
+		drm_property_blob_get(state->shaper_lut);
 	if (state->gamma_lut)
 		drm_property_blob_get(state->gamma_lut);
+
 	state->mode_changed = false;
 	state->active_changed = false;
 	state->planes_changed = false;
@@ -214,6 +217,7 @@ void __drm_atomic_helper_crtc_destroy_state(struct drm_crtc_state *state)
 	drm_property_blob_put(state->mode_blob);
 	drm_property_blob_put(state->degamma_lut);
 	drm_property_blob_put(state->ctm);
+	drm_property_blob_put(state->shaper_lut);
 	drm_property_blob_put(state->gamma_lut);
 }
 EXPORT_SYMBOL(__drm_atomic_helper_crtc_destroy_state);
diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index 79730fa1dd8e..5339350c858d 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -430,6 +430,14 @@ static int drm_atomic_crtc_set_property(struct drm_crtc *crtc,
 					&replaced);
 		state->color_mgmt_changed |= replaced;
 		return ret;
+	} else if (property == config->shaper_lut_property) {
+		ret = drm_atomic_replace_property_blob_from_id(dev,
+					&state->shaper_lut,
+					val,
+					-1, sizeof(struct drm_color_lut),
+					&replaced);
+		state->color_mgmt_changed |= replaced;
+		return ret;
 	} else if (property == config->gamma_lut_property) {
 		ret = drm_atomic_replace_property_blob_from_id(dev,
 					&state->gamma_lut,
@@ -481,6 +489,8 @@ drm_atomic_crtc_get_property(struct drm_crtc *crtc,
 		*val = (state->degamma_lut) ? state->degamma_lut->base.id : 0;
 	else if (property == config->ctm_property)
 		*val = (state->ctm) ? state->ctm->base.id : 0;
+	else if (property == config->shaper_lut_property)
+		*val = (state->shaper_lut) ? state->shaper_lut->base.id : 0;
 	else if (property == config->gamma_lut_property)
 		*val = (state->gamma_lut) ? state->gamma_lut->base.id : 0;
 	else if (property == config->prop_out_fence_ptr)
diff --git a/drivers/gpu/drm/drm_color_mgmt.c b/drivers/gpu/drm/drm_color_mgmt.c
index d021497841b8..cf6a998b4298 100644
--- a/drivers/gpu/drm/drm_color_mgmt.c
+++ b/drivers/gpu/drm/drm_color_mgmt.c
@@ -69,6 +69,24 @@
  *	boot-up state too. Drivers can access the blob for the color conversion
  *	matrix through &drm_crtc_state.ctm.
  *
+ * “SHAPER_LUT”:
+ *	Blob property to set the shaper lut shaping pixel data after the color
+ *	transformation matrix and before applying 3D Lookup Table (3D LUT). It
+ *	can be used to delinearize content to get an effective 3D LUT mapping.
+ *	The data is interpreted as an array of &struct drm_color_lut elements.
+ *
+ *	Setting this to NULL (blob property value set to 0) means the output
+ *	color is identical to the input color. This is generally the driver
+ *	boot-up state too. Drivers can access this blob through
+ *	&drm_crtc_state.gamma_lut.
+ *
+ * “SHAPER_LUT_SIZE”:
+ *	Unsigned range property to give the size of the shaper lookup table to
+ *	be set on the SHAPER_LUT property (the size depends on the underlying
+ *	hardware). If drivers support multiple LUT sizes then they should
+ *	publish the largest size, and sub-sample smaller sized LUTs
+ *	appropriately.
+ *
  * “GAMMA_LUT”:
  *	Blob property to set the gamma lookup table (LUT) mapping pixel data
  *	after the transformation matrix to data sent to the connector. The
diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index 71edb80fe0fb..f8b4611cbb4a 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -1129,8 +1129,11 @@ static int setcmap_atomic(struct fb_cmap *cmap, struct fb_info *info)
 		replaced  = drm_property_replace_blob(&crtc_state->degamma_lut,
 						      NULL);
 		replaced |= drm_property_replace_blob(&crtc_state->ctm, NULL);
+		replaced |= drm_property_replace_blob(&crtc_state->shaper_lut,
+						      NULL);
 		replaced |= drm_property_replace_blob(&crtc_state->gamma_lut,
 						      gamma_lut);
+
 		crtc_state->color_mgmt_changed |= replaced;
 	}
 
diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode_config.c
index 939d621c9ad4..6468cecc7081 100644
--- a/drivers/gpu/drm/drm_mode_config.c
+++ b/drivers/gpu/drm/drm_mode_config.c
@@ -354,6 +354,20 @@ static int drm_mode_create_standard_properties(struct drm_device *dev)
 		return -ENOMEM;
 	dev->mode_config.ctm_property = prop;
 
+	prop = drm_property_create(dev,
+			DRM_MODE_PROP_BLOB,
+			"SHAPER_LUT", 0);
+	if (!prop)
+		return -ENOMEM;
+	dev->mode_config.shaper_lut_property = prop;
+
+	prop = drm_property_create_range(dev,
+			DRM_MODE_PROP_IMMUTABLE,
+			"SHAPER_LUT_SIZE", 0, UINT_MAX);
+	if (!prop)
+		return -ENOMEM;
+	dev->mode_config.shaper_lut_size_property = prop;
+
 	prop = drm_property_create(dev,
 			DRM_MODE_PROP_BLOB,
 			"GAMMA_LUT", 0);
diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
index 8e1cbc75143e..7f289e0153aa 100644
--- a/include/drm/drm_crtc.h
+++ b/include/drm/drm_crtc.h
@@ -152,8 +152,9 @@ struct drm_crtc_state {
 	bool zpos_changed : 1;
 	/**
 	 * @color_mgmt_changed: Color management properties have changed
-	 * (@gamma_lut, @degamma_lut or @ctm). Used by the atomic helpers and
-	 * drivers to steer the atomic commit control flow.
+	 * (@shaper_lut, @gamma_lut, @degamma_lut or @ctm). Used by
+	 * the atomic helpers and drivers to steer the atomic commit control
+	 * flow.
 	 */
 	bool color_mgmt_changed : 1;
 
@@ -279,6 +280,15 @@ struct drm_crtc_state {
 	 */
 	struct drm_property_blob *gamma_lut;
 
+	/**
+	 * @shaper_lut:
+	 *
+	 * Lookup table used to de-linearize pixel data for gamma correction.
+	 * See drm_crtc_enable_color_mgmt(). The blob (if not NULL) is an array
+	 * of &struct drm_color_lut.
+	 */
+	struct drm_property_blob *shaper_lut;
+
 	/**
 	 * @target_vblank:
 	 *
diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.h
index 6b5e01295348..c174d3a7c951 100644
--- a/include/drm/drm_mode_config.h
+++ b/include/drm/drm_mode_config.h
@@ -800,6 +800,18 @@ struct drm_mode_config {
 	 * degamma LUT.
 	 */
 	struct drm_property *ctm_property;
+
+	/**
+	 * @shaper_lut_property: Optional CRTC property to set the shaper LUT used to
+	 * convert colors before 3D LUT conversion.
+	 */
+	struct drm_property *shaper_lut_property;
+	/**
+	 * @shaper_lut_size_property: Optional CRTC property for the size of the
+	 * shaper LUT as supported by the driver (read-only).
+	 */
+	struct drm_property *shaper_lut_size_property;
+
 	/**
 	 * @gamma_lut_property: Optional CRTC property to set the LUT used to
 	 * convert the colors, after the CTM matrix, to the gamma space of the
diff --git a/include/drm/drm_mode_object.h b/include/drm/drm_mode_object.h
index 912f1e415685..5e75b51936e6 100644
--- a/include/drm/drm_mode_object.h
+++ b/include/drm/drm_mode_object.h
@@ -60,7 +60,7 @@ struct drm_mode_object {
 	void (*free_cb)(struct kref *kref);
 };
 
-#define DRM_OBJECT_MAX_PROPERTY 24
+#define DRM_OBJECT_MAX_PROPERTY 26
 /**
  * struct drm_object_properties - property tracking for &drm_mode_object
  */
-- 
2.35.1

