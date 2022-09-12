Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7C315B57FE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 12:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbiILKPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 06:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiILKPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 06:15:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F5F26109
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 03:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662977733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=kEIZbmjCrkwFqJwW0FrEWe4XG+lhgHO0wcbZ0Aw/+qQ=;
        b=MySWWnq+LSWHbcgQX2EHp+eD57vSLvLZfaHgKPRSMN1b/e32XQ7vKE7CwwfVkWKjfOzWSH
        8ftX22ALSu4usDpH0+oMV+LVj6bU1F4FpYMf3EY38C9iUuejpxEBvvEChCjFzztieyPRDL
        nnf67+fSnynnKqPIaoOkvyPFtI0NkQk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-627-GalejlTYPG61K0uYVtIF8g-1; Mon, 12 Sep 2022 06:15:32 -0400
X-MC-Unique: GalejlTYPG61K0uYVtIF8g-1
Received: by mail-wr1-f69.google.com with SMTP id e15-20020adf9bcf000000b002285faa9bd4so1428788wrc.8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 03:15:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=kEIZbmjCrkwFqJwW0FrEWe4XG+lhgHO0wcbZ0Aw/+qQ=;
        b=VxCy3d4E2ssXZhV3G4ohqMYa3W31gD30rWX1Dp/r1EiNOM+ToLq2xSf8Jjywmwi7QJ
         jBl810Ubo3yUMo79QMZhQT/le1wnbBWBfcPDKsAsrcEOCTsYCPMA5nQHhGu/h6hsCX04
         I6Z6V1dL2MMsykX/yZzjqbzr9JoG/hk7oyNDHXaHpp2m3Vj/nXYyhQKdFR9+Bmi5MT91
         m6ccGxs88UN0Va5yqvEb9HTcdyvkwl3rYtMhAj5kVV1agx7PKTFul3VaOnQxJAarYWyw
         xIFUs9kBXqHR/06lmT8hwDg3o9dNqo77SAXnXLkfBj5UBik5AfmAI2t+f24+EuCMjmtx
         bCBA==
X-Gm-Message-State: ACgBeo3DD6sH2iRz08SvOIk2lXbaBItmT1LxMQnt1DE4Cuk4snzm2FpZ
        x9LiIwiR5oM1GErm45xdfqAP+ecYYfVz2GbAu3CCIfX9uKNX5hvDOnbxsgqEKQu8JbNCLqDO9mA
        T93vqUmCp/jComHto79/k3OnNqNMFyK553tmh5mz2EDzVJcxSSHmocGJZTSIamNMuqWcP3+jj+M
        s=
X-Received: by 2002:a5d:4f12:0:b0:22a:47ee:7378 with SMTP id c18-20020a5d4f12000000b0022a47ee7378mr5996384wru.672.1662977730825;
        Mon, 12 Sep 2022 03:15:30 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6pjf8CuDFu3kBC/4imjX+VqZcCp966TUhhANAd4wyUtUKcoe6xfXwj0XMA2TgJwL1ZKXByzg==
X-Received: by 2002:a5d:4f12:0:b0:22a:47ee:7378 with SMTP id c18-20020a5d4f12000000b0022a47ee7378mr5996343wru.672.1662977730293;
        Mon, 12 Sep 2022 03:15:30 -0700 (PDT)
Received: from minerva.access.network ([185.122.133.20])
        by smtp.gmail.com with ESMTPSA id o22-20020a05600c511600b003a5b6086381sm9554526wms.48.2022.09.12.03.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 03:15:29 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/plane-helper: Add a drm_plane_helper_atomic_check() helper
Date:   Mon, 12 Sep 2022 12:15:22 +0200
Message-Id: <20220912101522.69482-1-javierm@redhat.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
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

 drivers/gpu/drm/drm_plane_helper.c | 29 +++++++++++++++++++++++++++++
 drivers/gpu/drm/solomon/ssd130x.c  | 18 +-----------------
 drivers/gpu/drm/tiny/simpledrm.c   | 25 +------------------------
 include/drm/drm_plane_helper.h     |  2 ++
 4 files changed, 33 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/drm_plane_helper.c b/drivers/gpu/drm/drm_plane_helper.c
index c7785967f5bf..fb41eee74693 100644
--- a/drivers/gpu/drm/drm_plane_helper.c
+++ b/drivers/gpu/drm/drm_plane_helper.c
@@ -278,3 +278,32 @@ void drm_plane_helper_destroy(struct drm_plane *plane)
 	kfree(plane);
 }
 EXPORT_SYMBOL(drm_plane_helper_destroy);
+
+/**
+ * drm_plane_helper_atomic_check() - Helper to check primary planes states
+ * @plane: plane to check
+ * @new_state: plane state to check
+ *
+ * Provides a default plane state check handler for primary planes whose atomic
+ * state scale and position is not expected to change because the primary plane
+ * is always a fullscreen scanout buffer.
+ *
+ * RETURNS:
+ * Zero on success, or an errno code otherwise.
+ */
+int drm_plane_helper_atomic_check(struct drm_plane *plane,
+				  struct drm_atomic_state *new_state)
+{
+	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(new_state, plane);
+	struct drm_crtc *new_crtc = new_plane_state->crtc;
+	struct drm_crtc_state *new_crtc_state = NULL;
+
+	if (new_crtc)
+		new_crtc_state = drm_atomic_get_new_crtc_state(new_state, new_crtc);
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
index 1781fab24dd6..7ba414655d69 100644
--- a/include/drm/drm_plane_helper.h
+++ b/include/drm/drm_plane_helper.h
@@ -41,5 +41,7 @@ int drm_plane_helper_update_primary(struct drm_plane *plane, struct drm_crtc *cr
 int drm_plane_helper_disable_primary(struct drm_plane *plane,
 				     struct drm_modeset_acquire_ctx *ctx);
 void drm_plane_helper_destroy(struct drm_plane *plane);
+int drm_plane_helper_atomic_check(struct drm_plane *plane,
+				  struct drm_atomic_state *new_state);
 
 #endif
-- 
2.37.1

