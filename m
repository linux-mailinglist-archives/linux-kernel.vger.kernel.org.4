Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6B15B780E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 19:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233191AbiIMRfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 13:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233162AbiIMReh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 13:34:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADDAFE5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 09:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663086214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=/ucusGnYdezKlzEU00G3OKGUQ3PtOtcS9x0L25TIYSE=;
        b=iKgpQaQsVB6EalkJT503ROLqMhAu2+FNtMWD3BcrNIuk6mzjx1KVJIpH3i0Tw71Z1VTLnW
        069+on2j1bj8K/A+qyJWUSu1WnyG1j0LlpgT4rhnRMB/Q+mcjlRc8rQzfXwmerDGWpYUDY
        xvFXFY63EgPBabkc0JIH7bB8q0R7JGw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-673-_BiuCZDAPvi9tyldxyELmA-1; Tue, 13 Sep 2022 12:23:33 -0400
X-MC-Unique: _BiuCZDAPvi9tyldxyELmA-1
Received: by mail-wm1-f70.google.com with SMTP id 84-20020a1c0257000000b003b499f99aceso58247wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 09:23:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=/ucusGnYdezKlzEU00G3OKGUQ3PtOtcS9x0L25TIYSE=;
        b=WVLjIiYXipjASYM6dw6BSYdc4ZjIsseyHXZoogiHiuwZRNUaBbwzATGxvdzxSbH6//
         L0+zl/VMgOfEq0aAsPyR3wkYQxgNiAS2oVY/SmEeLurvlVE+Pptt90ayfyObRxLdyCi7
         FuViIO6F9m741r+9zS9iRrvyAkl20k37PAMQihlKDBb6F2kgDa5a+qmehsCfS41FNWwn
         7MRpQHBjQxp3iEKSmmh3hDAcHpMGhGEnaps+SV0PTpncTQxzxFJHpfvlcViibwFx7nMV
         yqz0jkSPuEVyFpIsP+X6NgAsCxGi3AkgM0F5tbZwzPrIFRKBYxMWf0nV5t5K1EqBJX9v
         lUiw==
X-Gm-Message-State: ACgBeo346ET/CeJ+Jjk7QoxWPZvafEEnfpBgasuma5YQcUpYepXVY65A
        LGLbO5lvPUa7nH3Wr7rJDus04K5BlYsnOSSFvTAV/n0nzmkIZxlvXbeDQiD3LdggpwmDig7/nBi
        MZG9mJfqOUh+eLQJDvoa9wzHEDMTWol3619dzX9J9VNWb7tsdf2Xhg/FQlBY1y0+bWyKBX1MMya
        A=
X-Received: by 2002:adf:d1ce:0:b0:22a:36d6:da05 with SMTP id b14-20020adfd1ce000000b0022a36d6da05mr15347226wrd.719.1663086212336;
        Tue, 13 Sep 2022 09:23:32 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4O1BQyUm2ehPm712XtDMX5Wsz2i51HwUqgqqPqtTaRYU9jbn9uJHp4bBswlTFqsxc2H905hg==
X-Received: by 2002:adf:d1ce:0:b0:22a:36d6:da05 with SMTP id b14-20020adfd1ce000000b0022a36d6da05mr15347206wrd.719.1663086212047;
        Tue, 13 Sep 2022 09:23:32 -0700 (PDT)
Received: from minerva.access.network ([185.122.133.20])
        by smtp.gmail.com with ESMTPSA id m13-20020a05600c3b0d00b003a2e92edeccsm1902634wms.46.2022.09.13.09.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 09:23:31 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Harry Wentland <harry.wentland@amd.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v3] drm/plane-helper: Add a drm_plane_helper_atomic_check() helper
Date:   Tue, 13 Sep 2022 18:23:07 +0200
Message-Id: <20220913162307.121503-1-javierm@redhat.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provides a default plane state check handler for primary planes that are a
fullscreen scanout buffer and whose state scale and position can't change.

There are some drivers that duplicate this logic in their helpers, such as
simpledrm and ssd130x. Factor out this common code into a plane helper and
make drivers use it.

Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
---

Changes in v3:
- Use plane-state and atomic-state (Thomas Zimmermann).
- Drop primary and just refer to plane (Thomas Zimmermann).
- Make kernel-doc comment more clear (Harry Wentland, Thomas Zimmermann).
- Add Thomas Zimmermann Reviewed-by tag.

Changes in v2:
- Fix `new_state` field comment (Ville Syrjälä).
- Rename `new_state` to just `state` (Ville Syrjälä).

 drivers/gpu/drm/drm_plane_helper.c | 30 ++++++++++++++++++++++++++++++
 drivers/gpu/drm/solomon/ssd130x.c  | 18 +-----------------
 drivers/gpu/drm/tiny/simpledrm.c   | 25 +------------------------
 include/drm/drm_plane_helper.h     |  1 +
 4 files changed, 33 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/drm_plane_helper.c b/drivers/gpu/drm/drm_plane_helper.c
index c7785967f5bf..db04d9a32ce8 100644
--- a/drivers/gpu/drm/drm_plane_helper.c
+++ b/drivers/gpu/drm/drm_plane_helper.c
@@ -278,3 +278,33 @@ void drm_plane_helper_destroy(struct drm_plane *plane)
 	kfree(plane);
 }
 EXPORT_SYMBOL(drm_plane_helper_destroy);
+
+/**
+ * drm_plane_helper_atomic_check() - Helper to check plane atomic-state
+ * @plane: plane to check
+ * @state: atomic state object
+ *
+ * Provides a default plane-state check handler for planes whose atomic-state
+ * scale and positioning are not expected to change since the plane is always
+ * a fullscreen scanout buffer.
+ *
+ * This is often the case for the primary plane of simple framebuffers.
+ *
+ * RETURNS:
+ * Zero on success, or an errno code otherwise.
+ */
+int drm_plane_helper_atomic_check(struct drm_plane *plane, struct drm_atomic_state *state)
+{
+	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state, plane);
+	struct drm_crtc *new_crtc = new_plane_state->crtc;
+	struct drm_crtc_state *new_crtc_state = NULL;
+
+	if (new_crtc)
+		new_crtc_state = drm_atomic_get_new_crtc_state(state, new_crtc);
+
+	return drm_atomic_helper_check_plane_state(new_plane_state, new_crtc_state,
+						   DRM_PLANE_NO_SCALING,
+						   DRM_PLANE_NO_SCALING,
+						   false, false);
+}
+EXPORT_SYMBOL(drm_plane_helper_atomic_check);
diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index 79e8e2017c68..28cf9c87f86d 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -565,22 +565,6 @@ static int ssd130x_fb_blit_rect(struct drm_framebuffer *fb, const struct iosys_m
 	return ret;
 }
 
-static int ssd130x_primary_plane_helper_atomic_check(struct drm_plane *plane,
-						     struct drm_atomic_state *new_state)
-{
-	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(new_state, plane);
-	struct drm_crtc *new_crtc = new_plane_state->crtc;
-	struct drm_crtc_state *new_crtc_state = NULL;
-
-	if (new_crtc)
-		new_crtc_state = drm_atomic_get_new_crtc_state(new_state, new_crtc);
-
-	return drm_atomic_helper_check_plane_state(new_plane_state, new_crtc_state,
-						   DRM_PLANE_NO_SCALING,
-						   DRM_PLANE_NO_SCALING,
-						   false, false);
-}
-
 static void ssd130x_primary_plane_helper_atomic_update(struct drm_plane *plane,
 						       struct drm_atomic_state *old_state)
 {
@@ -623,7 +607,7 @@ static void ssd130x_primary_plane_helper_atomic_disable(struct drm_plane *plane,
 
 static const struct drm_plane_helper_funcs ssd130x_primary_plane_helper_funcs = {
 	DRM_GEM_SHADOW_PLANE_HELPER_FUNCS,
-	.atomic_check = ssd130x_primary_plane_helper_atomic_check,
+	.atomic_check = drm_plane_helper_atomic_check,
 	.atomic_update = ssd130x_primary_plane_helper_atomic_update,
 	.atomic_disable = ssd130x_primary_plane_helper_atomic_disable,
 };
diff --git a/drivers/gpu/drm/tiny/simpledrm.c b/drivers/gpu/drm/tiny/simpledrm.c
index 777ccd250871..ea5b3239a659 100644
--- a/drivers/gpu/drm/tiny/simpledrm.c
+++ b/drivers/gpu/drm/tiny/simpledrm.c
@@ -469,29 +469,6 @@ static const uint64_t simpledrm_primary_plane_format_modifiers[] = {
 	DRM_FORMAT_MOD_INVALID
 };
 
-static int simpledrm_primary_plane_helper_atomic_check(struct drm_plane *plane,
-						       struct drm_atomic_state *new_state)
-{
-	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(new_state, plane);
-	struct drm_crtc *new_crtc = new_plane_state->crtc;
-	struct drm_crtc_state *new_crtc_state = NULL;
-	int ret;
-
-	if (new_crtc)
-		new_crtc_state = drm_atomic_get_new_crtc_state(new_state, new_crtc);
-
-	ret = drm_atomic_helper_check_plane_state(new_plane_state, new_crtc_state,
-						  DRM_PLANE_NO_SCALING,
-						  DRM_PLANE_NO_SCALING,
-						  false, false);
-	if (ret)
-		return ret;
-	else if (!new_plane_state->visible)
-		return 0;
-
-	return 0;
-}
-
 static void simpledrm_primary_plane_helper_atomic_update(struct drm_plane *plane,
 							 struct drm_atomic_state *old_state)
 {
@@ -543,7 +520,7 @@ static void simpledrm_primary_plane_helper_atomic_disable(struct drm_plane *plan
 
 static const struct drm_plane_helper_funcs simpledrm_primary_plane_helper_funcs = {
 	DRM_GEM_SHADOW_PLANE_HELPER_FUNCS,
-	.atomic_check = simpledrm_primary_plane_helper_atomic_check,
+	.atomic_check = drm_plane_helper_atomic_check,
 	.atomic_update = simpledrm_primary_plane_helper_atomic_update,
 	.atomic_disable = simpledrm_primary_plane_helper_atomic_disable,
 };
diff --git a/include/drm/drm_plane_helper.h b/include/drm/drm_plane_helper.h
index 1781fab24dd6..7760b27b0323 100644
--- a/include/drm/drm_plane_helper.h
+++ b/include/drm/drm_plane_helper.h
@@ -41,5 +41,6 @@ int drm_plane_helper_update_primary(struct drm_plane *plane, struct drm_crtc *cr
 int drm_plane_helper_disable_primary(struct drm_plane *plane,
 				     struct drm_modeset_acquire_ctx *ctx);
 void drm_plane_helper_destroy(struct drm_plane *plane);
+int drm_plane_helper_atomic_check(struct drm_plane *plane, struct drm_atomic_state *state);
 
 #endif
-- 
2.37.1

