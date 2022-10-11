Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E405FB895
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 18:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiJKQwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 12:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiJKQwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 12:52:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895F795AC8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 09:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665507120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vaCOI9UDHObilr/FfRutdJn/+dgOSqkCuyMJ4ENmaOs=;
        b=KDhbJbmTqDTbAYoRd08ZUeDmHFbVAgkVa9IvPZY15y+bT878kkqr5Oe4DFftURWCob7Hrh
        CTGxKlox9C8scDzWav4hAjHXTMrmPsNytgD6otg3XrrZtC61I2R2B+pu5VnHRA+mi17pym
        tFK5J4KTwCFgpI4d+twM7VcS6sDnnow=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-637-QWhUYWehNpmBejiAQJQ8pg-1; Tue, 11 Oct 2022 12:51:58 -0400
X-MC-Unique: QWhUYWehNpmBejiAQJQ8pg-1
Received: by mail-wm1-f72.google.com with SMTP id n6-20020a7bc5c6000000b003c6bbe5d5cfso2991894wmk.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 09:51:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vaCOI9UDHObilr/FfRutdJn/+dgOSqkCuyMJ4ENmaOs=;
        b=l4L0RN2kU7mKVzayp0c6Loedy+7FW/Fn4CstWXTuqKo/N52MQoAyJJ1uPHCi8VClpW
         6/K/AK8djZJQCkrt6hEPVq/5/LTnAckAoaDueZp+O1UbrLFCo77XyT0UxUAd3zWmAyos
         G11mqXRB8pG78oip42uM2C5Q+PyFR6oO/e1V2m5daB/4y1ZegkAYUECyR18f7Lme2RU1
         aw9U4HlbObX5BwClBu1d66+MYbsywFFxq668F1JRNIwAv6YS49w+Y8zbq5uhPKUJQGQ/
         KCbF53ChEErxN79FCOju8JALDZEyHWDyn/w28cesb+XQQE758/L7PhbHoq7Z2RH44cu/
         nLLg==
X-Gm-Message-State: ACrzQf2jaXs/NVG15PVOJ+nLLpb/UZcerv+kDAQWMyOgwweOQ7O5Cwe6
        qm6/QQrdBY7iuunyi5AN6dgxCHVt+KUy8DaWcCKRLvTRjTfygU+nIDx1cA+dRy6LGQ+Qwnt23F7
        A3Vmjn/A9MtsdAliYuX8Um1yZ7RLrDweINRhjl99xLs5qzVy8vC5bV3Z4fSaVc0GbKa1V0Rdvwj
        c=
X-Received: by 2002:a5d:588e:0:b0:22e:5601:f6d with SMTP id n14-20020a5d588e000000b0022e56010f6dmr15751899wrf.207.1665507117141;
        Tue, 11 Oct 2022 09:51:57 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7PmArjh64UHPJejX+ohWlZL4spASdLrxYeMDilCiSbo8QeLZylP8y7c2Z1G8l0Ownm8AjByA==
X-Received: by 2002:a5d:588e:0:b0:22e:5601:f6d with SMTP id n14-20020a5d588e000000b0022e56010f6dmr15751873wrf.207.1665507116611;
        Tue, 11 Oct 2022 09:51:56 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id c19-20020a05600c0a5300b003c6c76b43a1sm2025629wmq.13.2022.10.11.09.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 09:51:56 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2 4/4] drm/crtc-helper: Add a drm_crtc_helper_atomic_check() helper
Date:   Tue, 11 Oct 2022 18:51:36 +0200
Message-Id: <20221011165136.469750-5-javierm@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221011165136.469750-1-javierm@redhat.com>
References: <20221011165136.469750-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provides a default CRTC state check handler for CRTCs that only have one
primary plane attached.

There are some drivers that duplicate this logic in their helpers, such as
simpledrm and ssd130x. Factor out this common code into a CRTC helper and
make drivers use it.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
---

Changes in v2:
- Reference drm_plane_helper_atomic_check() from drm_crtc_atomic_check()
  kernel doc comments and viceversa (Thomas Zimmermann).

 drivers/gpu/drm/drm_crtc_helper.c  | 26 ++++++++++++++++++++++++++
 drivers/gpu/drm/drm_plane_helper.c |  4 +++-
 drivers/gpu/drm/solomon/ssd130x.c  | 14 ++------------
 drivers/gpu/drm/tiny/simpledrm.c   | 14 ++------------
 include/drm/drm_crtc_helper.h      |  2 ++
 5 files changed, 35 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/drm_crtc_helper.c b/drivers/gpu/drm/drm_crtc_helper.c
index 457448cc60f7..1f0a270ac984 100644
--- a/drivers/gpu/drm/drm_crtc_helper.c
+++ b/drivers/gpu/drm/drm_crtc_helper.c
@@ -421,6 +421,32 @@ bool drm_crtc_helper_set_mode(struct drm_crtc *crtc,
 }
 EXPORT_SYMBOL(drm_crtc_helper_set_mode);
 
+/**
+ * drm_crtc_helper_atomic_check() - Helper to check CRTC atomic-state
+ * @crtc: CRTC to check
+ * @state: atomic state object
+ *
+ * Provides a default CRTC-state check handler for CRTCs that only have
+ * one primary plane attached to it.
+ *
+ * This is often the case for the CRTC of simple framebuffers. See also
+ * drm_plane_helper_atomic_check() for the respective plane-state check
+ * helper function.
+ *
+ * RETURNS:
+ * Zero on success, or an errno code otherwise.
+ */
+int drm_crtc_helper_atomic_check(struct drm_crtc *crtc, struct drm_atomic_state *state)
+{
+	struct drm_crtc_state *new_crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
+
+	if (!new_crtc_state->enable)
+		return 0;
+
+	return drm_atomic_helper_check_crtc_primary_plane(new_crtc_state);
+}
+EXPORT_SYMBOL(drm_crtc_helper_atomic_check);
+
 static void
 drm_crtc_helper_disable(struct drm_crtc *crtc)
 {
diff --git a/drivers/gpu/drm/drm_plane_helper.c b/drivers/gpu/drm/drm_plane_helper.c
index 865bd999b187..ba6a9136a065 100644
--- a/drivers/gpu/drm/drm_plane_helper.c
+++ b/drivers/gpu/drm/drm_plane_helper.c
@@ -298,7 +298,9 @@ EXPORT_SYMBOL(drm_plane_helper_destroy);
  * scale and positioning are not expected to change since the plane is always
  * a fullscreen scanout buffer.
  *
- * This is often the case for the primary plane of simple framebuffers.
+ * This is often the case for the primary plane of simple framebuffers. See
+ * also drm_crtc_helper_atomic_check() for the respective CRTC-state check
+ * helper function.
  *
  * RETURNS:
  * Zero on success, or an errno code otherwise.
diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index 0d4ab65233db..f2795f90ea69 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -20,6 +20,7 @@
 
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_crtc_helper.h>
 #include <drm/drm_damage_helper.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_fb_helper.h>
@@ -645,17 +646,6 @@ static enum drm_mode_status ssd130x_crtc_helper_mode_valid(struct drm_crtc *crtc
 	return MODE_OK;
 }
 
-static int ssd130x_crtc_helper_atomic_check(struct drm_crtc *crtc,
-					    struct drm_atomic_state *new_state)
-{
-	struct drm_crtc_state *new_crtc_state = drm_atomic_get_new_crtc_state(new_state, crtc);
-
-	if (!new_crtc_state->enable)
-		return 0;
-
-	return drm_atomic_helper_check_crtc_primary_plane(new_crtc_state);
-}
-
 /*
  * The CRTC is always enabled. Screen updates are performed by
  * the primary plane's atomic_update function. Disabling clears
@@ -663,7 +653,7 @@ static int ssd130x_crtc_helper_atomic_check(struct drm_crtc *crtc,
  */
 static const struct drm_crtc_helper_funcs ssd130x_crtc_helper_funcs = {
 	.mode_valid = ssd130x_crtc_helper_mode_valid,
-	.atomic_check = ssd130x_crtc_helper_atomic_check,
+	.atomic_check = drm_crtc_helper_atomic_check,
 };
 
 static void ssd130x_crtc_reset(struct drm_crtc *crtc)
diff --git a/drivers/gpu/drm/tiny/simpledrm.c b/drivers/gpu/drm/tiny/simpledrm.c
index f03f17f62a56..cbb100753154 100644
--- a/drivers/gpu/drm/tiny/simpledrm.c
+++ b/drivers/gpu/drm/tiny/simpledrm.c
@@ -11,6 +11,7 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_state_helper.h>
 #include <drm/drm_connector.h>
+#include <drm/drm_crtc_helper.h>
 #include <drm/drm_damage_helper.h>
 #include <drm/drm_device.h>
 #include <drm/drm_drv.h>
@@ -545,17 +546,6 @@ static enum drm_mode_status simpledrm_crtc_helper_mode_valid(struct drm_crtc *cr
 	return drm_crtc_helper_mode_valid_fixed(crtc, mode, &sdev->mode);
 }
 
-static int simpledrm_crtc_helper_atomic_check(struct drm_crtc *crtc,
-					      struct drm_atomic_state *new_state)
-{
-	struct drm_crtc_state *new_crtc_state = drm_atomic_get_new_crtc_state(new_state, crtc);
-
-	if (!new_crtc_state->enable)
-		return 0;
-
-	return drm_atomic_helper_check_crtc_primary_plane(new_crtc_state);
-}
-
 /*
  * The CRTC is always enabled. Screen updates are performed by
  * the primary plane's atomic_update function. Disabling clears
@@ -563,7 +553,7 @@ static int simpledrm_crtc_helper_atomic_check(struct drm_crtc *crtc,
  */
 static const struct drm_crtc_helper_funcs simpledrm_crtc_helper_funcs = {
 	.mode_valid = simpledrm_crtc_helper_mode_valid,
-	.atomic_check = simpledrm_crtc_helper_atomic_check,
+	.atomic_check = drm_crtc_helper_atomic_check,
 };
 
 static const struct drm_crtc_funcs simpledrm_crtc_funcs = {
diff --git a/include/drm/drm_crtc_helper.h b/include/drm/drm_crtc_helper.h
index a6d520d5b6ca..1840db247f69 100644
--- a/include/drm/drm_crtc_helper.h
+++ b/include/drm/drm_crtc_helper.h
@@ -50,6 +50,8 @@ bool drm_crtc_helper_set_mode(struct drm_crtc *crtc,
 			      struct drm_display_mode *mode,
 			      int x, int y,
 			      struct drm_framebuffer *old_fb);
+int drm_crtc_helper_atomic_check(struct drm_crtc *crtc,
+				 struct drm_atomic_state *state);
 bool drm_helper_crtc_in_use(struct drm_crtc *crtc);
 bool drm_helper_encoder_in_use(struct drm_encoder *encoder);
 
-- 
2.37.3

