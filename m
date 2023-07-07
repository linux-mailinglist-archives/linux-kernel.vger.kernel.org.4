Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEFC074B9A8
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 00:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbjGGWlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 18:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232418AbjGGWll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 18:41:41 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B103A212D
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 15:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=de0EjBF+hzGDM+i69O+/YEHpbFntjniyjiLFzME0BgQ=; b=pr7i6ElhPBq4hMwP1RxSfNRX3w
        FhHG0ElDBsFZbPU01vkXlK9eefxtD4SfCwMUHWmB3apmHAY2qXSWmqP6jXYEmUNror8Fdw6zJx/cK
        AE85Rdafqq/WLNl/+UrMeQRtOEq28/mvF/GKJpXGNvCGhAxGHEd0czxQvd6H1nKvay0zQrJLwf5sO
        RQm93ORQZY2JeJsRM2iWh1X9nV+rU9ZehYloxyf6vk+hq1/gqsFSqnlSw+I2FHBHiP0wweZZu/eY/
        w6VFWVeV8SZA/iAMWB1yN8k6KS8yfSUZN3IPo0e+k/komiehe4FoMM/Vv8lmfXRKnnAym+OsmiUi3
        T0DG+0eg==;
Received: from [187.74.70.209] (helo=steammachine.lan)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1qHu8u-00AP6e-RH; Sat, 08 Jul 2023 00:41:37 +0200
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, wayland-devel@lists.freedesktop.org
Cc:     kernel-dev@igalia.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, pierre-eric.pelloux-prayer@amd.com,
        Simon Ser <contact@emersion.fr>,
        Rob Clark <robdclark@gmail.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Daniel Stone <daniel@fooishbar.org>,
        =?UTF-8?q?=27Marek=20Ol=C5=A1=C3=A1k=27?= <maraeo@gmail.com>,
        Dave Airlie <airlied@gmail.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
        Randy Dunlap <rdunlap@infradead.org>, hwentlan@amd.com,
        joshua@froggi.es, ville.syrjala@linux.intel.com,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v5 5/6] drm: Refuse to async flip with atomic prop changes
Date:   Fri,  7 Jul 2023 19:40:58 -0300
Message-ID: <20230707224059.305474-6-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707224059.305474-1-andrealmeid@igalia.com>
References: <20230707224059.305474-1-andrealmeid@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Given that prop changes may lead to modesetting, which would defeat the
fast path of the async flip, refuse any atomic prop change for async
flips in atomic API. The only exceptions are the framebuffer ID to flip
to and the mode ID, that could be referring to an identical mode.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
v4: new patch
---
 drivers/gpu/drm/drm_atomic_helper.c |  5 +++
 drivers/gpu/drm/drm_atomic_uapi.c   | 52 +++++++++++++++++++++++++++--
 drivers/gpu/drm/drm_crtc_internal.h |  2 +-
 drivers/gpu/drm/drm_mode_object.c   |  2 +-
 4 files changed, 56 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 2c2c9caf0be5..1e2973f0e1f6 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -629,6 +629,11 @@ drm_atomic_helper_check_modeset(struct drm_device *dev,
 		WARN_ON(!drm_modeset_is_locked(&crtc->mutex));
 
 		if (!drm_mode_equal(&old_crtc_state->mode, &new_crtc_state->mode)) {
+			if (new_crtc_state->async_flip) {
+				drm_dbg_atomic(dev, "[CRTC:%d:%s] no mode changes allowed during async flip\n",
+					       crtc->base.id, crtc->name);
+				return -EINVAL;
+			}
 			drm_dbg_atomic(dev, "[CRTC:%d:%s] mode changed\n",
 				       crtc->base.id, crtc->name);
 			new_crtc_state->mode_changed = true;
diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index dfd4cf7169df..536c21f53b5f 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -972,13 +972,28 @@ int drm_atomic_connector_commit_dpms(struct drm_atomic_state *state,
 	return ret;
 }
 
+static int drm_atomic_check_prop_changes(int ret, uint64_t old_val, uint64_t prop_value,
+					 struct drm_property *prop)
+{
+	if (ret != 0 || old_val != prop_value) {
+		drm_dbg_atomic(prop->dev,
+			       "[PROP:%d:%s] No prop can be changed during async flip\n",
+			       prop->base.id, prop->name);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 int drm_atomic_set_property(struct drm_atomic_state *state,
 			    struct drm_file *file_priv,
 			    struct drm_mode_object *obj,
 			    struct drm_property *prop,
-			    uint64_t prop_value)
+			    uint64_t prop_value,
+			    bool async_flip)
 {
 	struct drm_mode_object *ref;
+	uint64_t old_val;
 	int ret;
 
 	if (!drm_property_change_valid_get(prop, prop_value, &ref))
@@ -995,6 +1010,13 @@ int drm_atomic_set_property(struct drm_atomic_state *state,
 			break;
 		}
 
+		if (async_flip) {
+			ret = drm_atomic_connector_get_property(connector, connector_state,
+								prop, &old_val);
+			ret = drm_atomic_check_prop_changes(ret, old_val, prop_value, prop);
+			break;
+		}
+
 		ret = drm_atomic_connector_set_property(connector,
 				connector_state, file_priv,
 				prop, prop_value);
@@ -1003,6 +1025,7 @@ int drm_atomic_set_property(struct drm_atomic_state *state,
 	case DRM_MODE_OBJECT_CRTC: {
 		struct drm_crtc *crtc = obj_to_crtc(obj);
 		struct drm_crtc_state *crtc_state;
+		struct drm_mode_config *config = &crtc->dev->mode_config;
 
 		crtc_state = drm_atomic_get_crtc_state(state, crtc);
 		if (IS_ERR(crtc_state)) {
@@ -1010,6 +1033,18 @@ int drm_atomic_set_property(struct drm_atomic_state *state,
 			break;
 		}
 
+		/*
+		 * We allow mode_id changes here for async flips, because we
+		 * check later on drm_atomic_helper_check_modeset() callers if
+		 * there are modeset changes or they are equal
+		 */
+		if (async_flip && prop != config->prop_mode_id) {
+			ret = drm_atomic_crtc_get_property(crtc, crtc_state,
+							   prop, &old_val);
+			ret = drm_atomic_check_prop_changes(ret, old_val, prop_value, prop);
+			break;
+		}
+
 		ret = drm_atomic_crtc_set_property(crtc,
 				crtc_state, prop, prop_value);
 		break;
@@ -1017,6 +1052,7 @@ int drm_atomic_set_property(struct drm_atomic_state *state,
 	case DRM_MODE_OBJECT_PLANE: {
 		struct drm_plane *plane = obj_to_plane(obj);
 		struct drm_plane_state *plane_state;
+		struct drm_mode_config *config = &plane->dev->mode_config;
 
 		plane_state = drm_atomic_get_plane_state(state, plane);
 		if (IS_ERR(plane_state)) {
@@ -1024,6 +1060,13 @@ int drm_atomic_set_property(struct drm_atomic_state *state,
 			break;
 		}
 
+		if (async_flip && prop != config->prop_fb_id) {
+			ret = drm_atomic_plane_get_property(plane, plane_state,
+							    prop, &old_val);
+			ret = drm_atomic_check_prop_changes(ret, old_val, prop_value, prop);
+			break;
+		}
+
 		ret = drm_atomic_plane_set_property(plane,
 				plane_state, file_priv,
 				prop, prop_value);
@@ -1312,6 +1355,7 @@ int drm_mode_atomic_ioctl(struct drm_device *dev,
 	struct drm_out_fence_state *fence_state;
 	int ret = 0;
 	unsigned int i, j, num_fences;
+	bool async_flip = false;
 
 	/* disallow for drivers not supporting atomic: */
 	if (!drm_core_check_feature(dev, DRIVER_ATOMIC))
@@ -1348,6 +1392,8 @@ int drm_mode_atomic_ioctl(struct drm_device *dev,
 				       "commit failed: DRM_MODE_PAGE_FLIP_ASYNC not supported with atomic\n");
 			return -EINVAL;
 		}
+
+		async_flip = true;
 	}
 
 	/* can't test and expect an event at the same time. */
@@ -1427,8 +1473,8 @@ int drm_mode_atomic_ioctl(struct drm_device *dev,
 				goto out;
 			}
 
-			ret = drm_atomic_set_property(state, file_priv,
-						      obj, prop, prop_value);
+			ret = drm_atomic_set_property(state, file_priv, obj,
+						      prop, prop_value, async_flip);
 			if (ret) {
 				drm_mode_object_put(obj);
 				goto out;
diff --git a/drivers/gpu/drm/drm_crtc_internal.h b/drivers/gpu/drm/drm_crtc_internal.h
index 501a10edd0e1..381130cebe81 100644
--- a/drivers/gpu/drm/drm_crtc_internal.h
+++ b/drivers/gpu/drm/drm_crtc_internal.h
@@ -251,7 +251,7 @@ int drm_atomic_set_property(struct drm_atomic_state *state,
 			    struct drm_file *file_priv,
 			    struct drm_mode_object *obj,
 			    struct drm_property *prop,
-			    uint64_t prop_value);
+			    uint64_t prop_value, bool async_flip);
 int drm_atomic_get_property(struct drm_mode_object *obj,
 			    struct drm_property *property, uint64_t *val);
 
diff --git a/drivers/gpu/drm/drm_mode_object.c b/drivers/gpu/drm/drm_mode_object.c
index ba1608effc0f..64f519254895 100644
--- a/drivers/gpu/drm/drm_mode_object.c
+++ b/drivers/gpu/drm/drm_mode_object.c
@@ -536,7 +536,7 @@ static int set_property_atomic(struct drm_mode_object *obj,
 						       obj_to_connector(obj),
 						       prop_value);
 	} else {
-		ret = drm_atomic_set_property(state, file_priv, obj, prop, prop_value);
+		ret = drm_atomic_set_property(state, file_priv, obj, prop, prop_value, false);
 		if (ret)
 			goto out;
 		ret = drm_atomic_commit(state);
-- 
2.41.0

