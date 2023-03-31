Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B65B6D2AF7
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 00:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233419AbjCaWM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 18:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbjCaWMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 18:12:22 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251B85279
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 15:12:21 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-544787916d9so440388277b3.13
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 15:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680300740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZuaeI2NbvCBfBMRGGvq+S9k09VZQWz1w9ljulNq50E=;
        b=Iu2vFEXw7fvHYskrAoRtS3ueCnnQMQt2rszei65kmJs9H5F1PLnMw4lY5cBNskPlO4
         DYy7GbC6aTbcrWvZJTAI9TddMmyh944J13vI06eIuxXS3d6Xk/89vsz2mMbNyToEGjny
         0S+bNLtQadnyt1X5SURdYk89upGr3NpW//sWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680300740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qZuaeI2NbvCBfBMRGGvq+S9k09VZQWz1w9ljulNq50E=;
        b=X+wOGledKGpbCVqtagHbEiQdbC31JnU9tGsnXLMiRj7bXVVscRaXY6TVOf63thVQ18
         Jku9lvSngp2fiiUUlLRA0V8x9eSn/bRTX4pExS9z907pIDQjDZHnESMRxxAinbpYK9G4
         AZIWcq5PYw5rZ678jw0IFwMf2muZU20SaEeC/Ikmd0FG8jrr0tji/kQqbE8cr4OIQS+R
         0Qe4PBR6/zWzxHcLid/HQRcq5UKgDZIakEUtmGZqCis3BzTKMxs4DYMbI+iW4KA7pxf9
         1fPM6/8PwybVi0GsWamYKpVKI/vYVG5HPBcgt6qqBPJ6LDdporHHkSS0Z4bFeB3VJxt1
         S78w==
X-Gm-Message-State: AAQBX9d1amJEvChcVi5g0j2MG7l5MKGQNf+ypUB27OShC9T+d6Igv3//
        hVa6w/VkE710c1gCihUJVrRkSg==
X-Google-Smtp-Source: AKy350Z1iL6EsI2Wjmh2Kggauq8YsS4JxBKhskbn0KDnJ969R/xa1R0pnvfpSF8C614iEvVq32o7dg==
X-Received: by 2002:a81:a249:0:b0:52d:ff16:edb1 with SMTP id z9-20020a81a249000000b0052dff16edb1mr23446137ywg.17.1680300740369;
        Fri, 31 Mar 2023 15:12:20 -0700 (PDT)
Received: from localhost ([2620:0:1035:15:a8f6:869a:3ef5:e1d])
        by smtp.gmail.com with UTF8SMTPSA id df7-20020a05690c0f8700b00545a08184desm781939ywb.110.2023.03.31.15.12.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 15:12:20 -0700 (PDT)
From:   Mark Yacoub <markyacoub@chromium.org>
X-Google-Original-From: Mark Yacoub <markyacoub@google.com>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     seanpaul@chromium.org, suraj.kandpal@intel.com,
        dianders@chromium.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        Jani Nikula <jani.nikula@intel.com>,
        Mark Yacoub <markyacoub@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 02/10] drm/hdcp: Avoid changing crtc state in hdcp atomic check
Date:   Fri, 31 Mar 2023 18:12:04 -0400
Message-Id: <20230331221213.1691997-3-markyacoub@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
In-Reply-To: <20230331221213.1691997-1-markyacoub@google.com>
References: <20230331221213.1691997-1-markyacoub@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Paul <seanpaul@chromium.org>

Instead of forcing a modeset in the hdcp atomic check, rename to
drm_hdcp_has_changed and return true if the content protection value
is changing and let the driver decide whether a modeset is required or not.

Acked-by: Jani Nikula <jani.nikula@intel.com>
Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Mark Yacoub <markyacoub@chromium.org>

---
Changes in v2:
-None
Changes in v3:
-None
Changes in v4:
-None
Changes in v5:
-None
Changes in v6:
-Rebase: modifications in drm_hdcp_helper.c instead of drm_hdcp.c
Changes in v7:
-Renamed the function from drm_hdcp_atomic_check to drm_hdcp_has_changed
(Dmitry Baryshkov)
Changes in v8:
-None

 drivers/gpu/drm/display/drm_hdcp_helper.c   | 39 ++++++++++++++-------
 drivers/gpu/drm/i915/display/intel_atomic.c |  6 ++--
 include/drm/display/drm_hdcp_helper.h       |  2 +-
 3 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_hdcp_helper.c b/drivers/gpu/drm/display/drm_hdcp_helper.c
index 7ca390b3ea106..34baf2b97cd87 100644
--- a/drivers/gpu/drm/display/drm_hdcp_helper.c
+++ b/drivers/gpu/drm/display/drm_hdcp_helper.c
@@ -422,18 +422,21 @@ void drm_hdcp_update_content_protection(struct drm_connector *connector,
 EXPORT_SYMBOL(drm_hdcp_update_content_protection);
 
 /**
- * drm_hdcp_atomic_check - Helper for drivers to call during connector->atomic_check
+ * drm_hdcp_has_changed - Helper for drivers to call during connector->atomic_check
  *
  * @state: pointer to the atomic state being checked
  * @connector: drm_connector on which content protection state needs an update
  *
  * This function can be used by display drivers to perform an atomic check on the
- * hdcp state elements. If hdcp state has changed, this function will set
- * mode_changed on the crtc driving the connector so it can update its hardware
- * to match the hdcp state.
+ * hdcp state elements. If hdcp state has changed in a manner which requires the
+ * driver to enable or disable content protection, this function will return
+ * true.
+ *
+ * Returns:
+ * true if the driver must enable/disable hdcp, false otherwise
  */
-void drm_hdcp_atomic_check(struct drm_connector *connector,
-			   struct drm_atomic_state *state)
+bool drm_hdcp_has_changed(struct drm_connector *connector,
+			  struct drm_atomic_state *state)
 {
 	struct drm_connector_state *new_conn_state, *old_conn_state;
 	struct drm_crtc_state *new_crtc_state;
@@ -450,19 +453,31 @@ void drm_hdcp_atomic_check(struct drm_connector *connector,
 		 * If the connector is being disabled with CP enabled, mark it
 		 * desired so it's re-enabled when the connector is brought back
 		 */
-		if (old_hdcp == DRM_MODE_CONTENT_PROTECTION_ENABLED)
+		if (old_hdcp == DRM_MODE_CONTENT_PROTECTION_ENABLED) {
 			new_conn_state->content_protection =
 				DRM_MODE_CONTENT_PROTECTION_DESIRED;
-		return;
+			return true;
+		}
+		return false;
 	}
 
 	new_crtc_state =
 		drm_atomic_get_new_crtc_state(state, new_conn_state->crtc);
 	if (drm_atomic_crtc_needs_modeset(new_crtc_state) &&
 	    (old_hdcp == DRM_MODE_CONTENT_PROTECTION_ENABLED &&
-	     new_hdcp != DRM_MODE_CONTENT_PROTECTION_UNDESIRED))
+	     new_hdcp != DRM_MODE_CONTENT_PROTECTION_UNDESIRED)) {
 		new_conn_state->content_protection =
 			DRM_MODE_CONTENT_PROTECTION_DESIRED;
+		return true;
+	}
+
+	/*
+	 * Coming back from UNDESIRED state, CRTC change or re-enablement requires
+	 * the driver to try CP enable.
+	 */
+	if (new_hdcp == DRM_MODE_CONTENT_PROTECTION_DESIRED &&
+	    new_conn_state->crtc != old_conn_state->crtc)
+		return true;
 
 	/*
 	 * Nothing to do if content type is unchanged and one of:
@@ -477,9 +492,9 @@ void drm_hdcp_atomic_check(struct drm_connector *connector,
 	     new_hdcp == DRM_MODE_CONTENT_PROTECTION_DESIRED)) {
 		if (old_conn_state->hdcp_content_type ==
 		    new_conn_state->hdcp_content_type)
-			return;
+			return false;
 	}
 
-	new_crtc_state->mode_changed = true;
+	return true;
 }
-EXPORT_SYMBOL(drm_hdcp_atomic_check);
+EXPORT_SYMBOL(drm_hdcp_has_changed);
diff --git a/drivers/gpu/drm/i915/display/intel_atomic.c b/drivers/gpu/drm/i915/display/intel_atomic.c
index e9d00b6a63d39..23a6ba315a22e 100644
--- a/drivers/gpu/drm/i915/display/intel_atomic.c
+++ b/drivers/gpu/drm/i915/display/intel_atomic.c
@@ -124,8 +124,6 @@ int intel_digital_connector_atomic_check(struct drm_connector *conn,
 		to_intel_digital_connector_state(old_state);
 	struct drm_crtc_state *crtc_state;
 
-	drm_hdcp_atomic_check(conn, state);
-
 	if (!new_state->crtc)
 		return 0;
 
@@ -141,8 +139,8 @@ int intel_digital_connector_atomic_check(struct drm_connector *conn,
 	    new_conn_state->base.picture_aspect_ratio != old_conn_state->base.picture_aspect_ratio ||
 	    new_conn_state->base.content_type != old_conn_state->base.content_type ||
 	    new_conn_state->base.scaling_mode != old_conn_state->base.scaling_mode ||
-	    new_conn_state->base.privacy_screen_sw_state != old_conn_state->base.privacy_screen_sw_state ||
-	    !drm_connector_atomic_hdr_metadata_equal(old_state, new_state))
+	    !drm_connector_atomic_hdr_metadata_equal(old_state, new_state) ||
+	    drm_hdcp_has_changed(conn, state))
 		crtc_state->mode_changed = true;
 
 	return 0;
diff --git a/include/drm/display/drm_hdcp_helper.h b/include/drm/display/drm_hdcp_helper.h
index dd02b2e72a502..703421fcdf96c 100644
--- a/include/drm/display/drm_hdcp_helper.h
+++ b/include/drm/display/drm_hdcp_helper.h
@@ -19,7 +19,7 @@ int drm_hdcp_check_ksvs_revoked(struct drm_device *dev, u8 *ksvs, u32 ksv_count)
 int drm_connector_attach_content_protection_property(struct drm_connector *connector,
 						     bool hdcp_content_type);
 void drm_hdcp_update_content_protection(struct drm_connector *connector, u64 val);
-void drm_hdcp_atomic_check(struct drm_connector *connector,
+bool drm_hdcp_has_changed(struct drm_connector *connector,
 			   struct drm_atomic_state *state);
 
 #endif
-- 
2.40.0.348.gf938b09366-goog

