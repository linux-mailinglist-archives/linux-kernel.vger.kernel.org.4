Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFEC5FA25A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 19:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiJJRCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 13:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiJJRCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 13:02:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B522BD3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 10:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665421339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YUvuSJvCKaC4wzR9m0+Cm+eAjqQDPWwMTFGQwXn6Lfs=;
        b=JEoSrPTxj25RKMOZupgZEr53WnCp/2PkMURTnxqw/4d7T+8mZMoRXEC3Gr5b70BtpBCiuU
        F5/LCyveJ8a/SOgcqH8qclStPSgTvvNzyMWACLwnurH3lkbo5hsg9r+fSm83HGiO2fiDLe
        oIBegOzCi0modXXMqt2T9d8be3kvOVk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-669-fP0y41v5MLaTklOOvlRS7Q-1; Mon, 10 Oct 2022 13:02:17 -0400
X-MC-Unique: fP0y41v5MLaTklOOvlRS7Q-1
Received: by mail-wr1-f69.google.com with SMTP id r4-20020adfbb04000000b0022e5ec02713so2963987wrg.18
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 10:02:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YUvuSJvCKaC4wzR9m0+Cm+eAjqQDPWwMTFGQwXn6Lfs=;
        b=g3FnkTHIhdW8gD0na8PGaBusObbnLydAPfbAHhmm/IX2f//ICmu4E7/Hg87GlN0Zuv
         VDz0VFO/2F6UWU801D1GWIUH1VNaeEhwqnpf6bQ1jauNi98PkNPtMWOlu2mg5vnmwN8G
         LxnWQzhtGGUam2lEmBjiqd0H50Mw6ndNu1FO51F6xxH+W+QFzVr+wCtTzCK1c8+n0QpE
         ougGv+tW+R+USG09TB7pMmGVWezxtWNglLDDadvoz68wJmyQTiUJzIq7IdL2Sgz+Yg8V
         CyDZ6E9Sv21cw9PqKtz7wy4kKuLNOdGxR/bMwb9PaFnI1/lGz2sZ2vTdXwZRbQ6GCAK6
         hZZQ==
X-Gm-Message-State: ACrzQf327cR2p4EjPHlnFIanzEOnBeZqbBWBT0XqJoJ+2BoLk5smVslA
        BWbqgFZXhXSEqS92hbFzxfEUWhf7hXWOSK52JaQ4rHvjAHqJFJgXHAP9hCad3JdNu6fVAJ8bXPg
        bGFqH8LF6ACBMdy1ny0ZGsm04yCrBld8lft4p5K/yXsHTi8riNhICnP5x7nkLOf5lBOc0tKql9v
        Y=
X-Received: by 2002:adf:e64a:0:b0:22c:db6c:5b72 with SMTP id b10-20020adfe64a000000b0022cdb6c5b72mr13112303wrn.356.1665421335527;
        Mon, 10 Oct 2022 10:02:15 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7pVLFc/Zjx0wEtIfD8w+Dsx1klKtaRxVvzYBAj1jOqK5N5Un3lUp2LkATHQInMjHJVBVWfpQ==
X-Received: by 2002:adf:e64a:0:b0:22c:db6c:5b72 with SMTP id b10-20020adfe64a000000b0022cdb6c5b72mr13112264wrn.356.1665421335125;
        Mon, 10 Oct 2022 10:02:15 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id z5-20020a056000110500b0022b11a27e39sm9160551wrw.1.2022.10.10.10.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 10:02:14 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 3/3] drm/crtc-helper: Add a drm_crtc_helper_atomic_check() helper
Date:   Mon, 10 Oct 2022 19:02:03 +0200
Message-Id: <20221010170203.274949-4-javierm@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221010170203.274949-1-javierm@redhat.com>
References: <20221010170203.274949-1-javierm@redhat.com>
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
---

 drivers/gpu/drm/drm_crtc_helper.c | 24 ++++++++++++++++++++++++
 drivers/gpu/drm/solomon/ssd130x.c | 14 ++------------
 drivers/gpu/drm/tiny/simpledrm.c  | 14 ++------------
 include/drm/drm_crtc_helper.h     |  2 ++
 4 files changed, 30 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/drm_crtc_helper.c b/drivers/gpu/drm/drm_crtc_helper.c
index 457448cc60f7..4ad3abaa98f4 100644
--- a/drivers/gpu/drm/drm_crtc_helper.c
+++ b/drivers/gpu/drm/drm_crtc_helper.c
@@ -421,6 +421,30 @@ bool drm_crtc_helper_set_mode(struct drm_crtc *crtc,
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
+ * This is often the case for the CRTC of simple framebuffers.
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

