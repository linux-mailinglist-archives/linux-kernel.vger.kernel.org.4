Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0BC5B6ABF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 11:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbiIMJeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 05:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbiIMJeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 05:34:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5185F5B05E
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 02:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663061641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=K9tJ9sQhd6nvPP4b0Ne81nbqJQEp2juSZk9CIj/eGcA=;
        b=YcjDzlbJTCagwgxly8tkZednpf0WArZl0+4kLi/MK/1oV9AZ69IW3iKqNb0Wj5acJo7qaH
        TUr1uxDqpI8acRibdCnt2zSexN3RBQTc8s5l2aGKcJrESlmyyFzrw2CLmWWneJAxV9g0rg
        XS6vbo0f2uoN6r8Vchzz9X6uYRPsz9c=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-43-jxmeXWVPMMiI2j9LiX5lMw-1; Tue, 13 Sep 2022 05:33:59 -0400
X-MC-Unique: jxmeXWVPMMiI2j9LiX5lMw-1
Received: by mail-wm1-f69.google.com with SMTP id b16-20020a05600c4e1000b003a5a47762c3so6220455wmq.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 02:33:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=K9tJ9sQhd6nvPP4b0Ne81nbqJQEp2juSZk9CIj/eGcA=;
        b=aXu7NK7lu/ayc5oCdeb3edvjWsIdfFJjrhRHn5hUe1iwaWPrSU7xPdRpwp05hRoGiF
         ubU9g+LmmhQds3XxE8rP8CYwvPIHejmfYhXlGrHVmGGDs+s6htoUCbXzlqcAiiTBtNB3
         MzxgZOSF0rc2snU7Ni/wz8xyBXUo4fs/0twV8+6pvUoeb856VidMnAXVdeOLJ+4i2z8z
         +zmgJQkUHI3M6cKS3qhqNPmqEznQJvaBSURQFHcWVoJ3AluWWdlTPCuEw2r/hbspz1SK
         yPJGMDilxnFgMIvOoUcpETp+QbjGh7Vl+OWkDHd8DfLypfuIw2ZTbFqfjDH2lYYpiQbL
         t4Rw==
X-Gm-Message-State: ACgBeo1aKJ8Thi4H5CVKg6ePzCHTf2Y5BMKszMIEClLAv54x1Jq2zJdo
        PvmG5cDLtCpuIpHcQ3k1sioBg5mTMCdVXnG/D8KOUTkOD/3KvhdPJlBzlw+LLvvQGrRIUt3NVYe
        iqmMolKhUIuvIYJShA+QQvUz/QQKDuLGsgUN8YKRec+Z+G3xx/H5GoN0k831hSQkT9vzCfU47Sg
        M=
X-Received: by 2002:a5d:6d50:0:b0:225:89b2:a03a with SMTP id k16-20020a5d6d50000000b0022589b2a03amr18613879wri.51.1663061637243;
        Tue, 13 Sep 2022 02:33:57 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4eOBQBD+/cVY3kS1nmoR6/Cp/Tyj03Enj/AhHo+tzC7Qbs4FUAC9zmUaM42HPjmCbgZdD4Uw==
X-Received: by 2002:a5d:6d50:0:b0:225:89b2:a03a with SMTP id k16-20020a5d6d50000000b0022589b2a03amr18613853wri.51.1663061636997;
        Tue, 13 Sep 2022 02:33:56 -0700 (PDT)
Received: from minerva.access.network ([185.122.133.20])
        by smtp.gmail.com with ESMTPSA id o16-20020a056000011000b0021e4829d359sm9752455wrx.39.2022.09.13.02.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 02:33:56 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2] drm/plane-helper: Add a drm_plane_helper_atomic_check() helper
Date:   Tue, 13 Sep 2022 11:33:39 +0200
Message-Id: <20220913093339.106625-1-javierm@redhat.com>
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
---

Changes in v2:
- Fix `new_state` field comment (Ville Syrjälä).
- Rename `new_state` to just `state` (Ville Syrjälä).

 drivers/gpu/drm/drm_plane_helper.c | 28 ++++++++++++++++++++++++++++
 drivers/gpu/drm/solomon/ssd130x.c  | 18 +-----------------
 drivers/gpu/drm/tiny/simpledrm.c   | 25 +------------------------
 include/drm/drm_plane_helper.h     |  1 +
 4 files changed, 31 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/drm_plane_helper.c b/drivers/gpu/drm/drm_plane_helper.c
index c7785967f5bf..2165390863f4 100644
--- a/drivers/gpu/drm/drm_plane_helper.c
+++ b/drivers/gpu/drm/drm_plane_helper.c
@@ -278,3 +278,31 @@ void drm_plane_helper_destroy(struct drm_plane *plane)
 	kfree(plane);
 }
 EXPORT_SYMBOL(drm_plane_helper_destroy);
+
+/**
+ * drm_plane_helper_atomic_check() - Helper to check primary planes states
+ * @plane: plane to check
+ * @state: atomic state object
+ *
+ * Provides a default plane state check handler for primary planes whose atomic
+ * state scale and position is not expected to change because the primary plane
+ * is always a fullscreen scanout buffer.
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

