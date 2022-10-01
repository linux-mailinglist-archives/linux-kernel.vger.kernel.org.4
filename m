Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C125F1DC7
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 18:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiJAQlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 12:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiJAQkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 12:40:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E58136DF0
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 09:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664642418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NI0bF9fBHKufsMehkRni4gVvJDlrywziIYn+evXebr8=;
        b=ZXgNPh/BAiUc8KtjiVe53Oy0uT1/LUdNbbMW4hYL9x5Hyzovl9aGBKBRRRSsHoUtnfS8Vz
        2ADZcKm4znpZr1nIFgpMLvOzq8SO3KHiGJx+VJTUm45MUsTAhZhGminQZLJqY4O6KasNBT
        RKGnDCazEUirZC5vQYxWYp7wXalJmg8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-35-X_CK9hvbNLas7VPxoSOzEg-1; Sat, 01 Oct 2022 12:40:16 -0400
X-MC-Unique: X_CK9hvbNLas7VPxoSOzEg-1
Received: by mail-ed1-f72.google.com with SMTP id z16-20020a05640235d000b0045485e4a5e0so5756837edc.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 09:40:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=NI0bF9fBHKufsMehkRni4gVvJDlrywziIYn+evXebr8=;
        b=yyzPDIxYRmadmO6x2DmT4JFx2o0GGoC/Iu5kalaSl6sKsKYlb6jJoy30dd5p3q1N54
         QpNslWsq6E3kpUCrbYDsHy+aUwc/8rMOV5lba917awL4c1/ekKhf5iUOom0HyfykWOWM
         oWDByfYT7SrMB6fbIL5y75r61EUGZeio6Nv2LCezrjXCEj/wXVd5TZZ064PKAfGkkrEf
         xW4NAUW23MU+N4fDdKxu8AH6cQbgt0kKIYcE+HOZqW1ViXVBID+gnEAdLpWeWe38/cDC
         JtZ6H2OAYS3dIp3pkMzKpXuXEf+GOdLKKw2nj7szX6c2EVsHGygozYlj+tCSjfu9UHCD
         GZfw==
X-Gm-Message-State: ACrzQf3P4m+IFhfgkV8884h7DjZxLgxPXmPJv6iT0g0XhuAgu3jymGO/
        93Etz7+CWW1hK4MdvRoATDtuU7cFQdNNrfp+QOULMZqiusV1aUwJ+JLSQshRk1sa2O2mELg9a78
        Hq6ys2hYSsQAlmI85GCf4p9b7
X-Received: by 2002:a17:906:4bd3:b0:731:3bdf:b95c with SMTP id x19-20020a1709064bd300b007313bdfb95cmr10256743ejv.677.1664642415615;
        Sat, 01 Oct 2022 09:40:15 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7C/Ts2uHJUPcJEM6l6hCyE9V7MI9D7avdy67tj8jdhoBYY6yqYRglyvOpGoWE5CwNmUEgcUw==
X-Received: by 2002:a17:906:4bd3:b0:731:3bdf:b95c with SMTP id x19-20020a1709064bd300b007313bdfb95cmr10256732ejv.677.1664642415407;
        Sat, 01 Oct 2022 09:40:15 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id r8-20020a1709062cc800b0072b7d76211dsm2926614ejr.107.2022.10.01.09.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 09:40:14 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, liviu.dudau@arm.com, brian.starkey@arm.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v2 7/9] drm/arm/malidp: crtc: protect device resources after removal
Date:   Sat,  1 Oct 2022 18:39:44 +0200
Message-Id: <20221001163946.534067-8-dakr@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221001163946.534067-1-dakr@redhat.com>
References: <20221001163946.534067-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Hardware) resources which are bound to the driver and device lifecycle
must not be accessed after the device and driver are unbound.

However, the DRM device isn't freed as long as the last user didn't
close it, hence userspace can still call into the driver.

Therefore protect the critical sections which are accessing those
resources with drm_dev_enter() and drm_dev_exit().

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/arm/malidp_crtc.c | 61 +++++++++++++++++++++++++------
 1 file changed, 50 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/arm/malidp_crtc.c b/drivers/gpu/drm/arm/malidp_crtc.c
index dc01c43f6193..e11cda5fdeb7 100644
--- a/drivers/gpu/drm/arm/malidp_crtc.c
+++ b/drivers/gpu/drm/arm/malidp_crtc.c
@@ -14,6 +14,7 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
+#include <drm/drm_drv.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
@@ -27,6 +28,8 @@ static enum drm_mode_status malidp_crtc_mode_valid(struct drm_crtc *crtc,
 {
 	struct malidp_drm *malidp = crtc_to_malidp_device(crtc);
 	struct malidp_hw_device *hwdev = malidp->dev;
+	enum drm_mode_status status = MODE_OK;
+	int idx;
 
 	/*
 	 * check that the hardware can drive the required clock rate,
@@ -34,15 +37,21 @@ static enum drm_mode_status malidp_crtc_mode_valid(struct drm_crtc *crtc,
 	 */
 	long rate, req_rate = mode->crtc_clock * 1000;
 
+	if (!drm_dev_enter(&malidp->base, &idx))
+		return MODE_NOCLOCK;
+
 	if (req_rate) {
 		rate = clk_round_rate(hwdev->pxlclk, req_rate);
 		if (rate != req_rate) {
 			DRM_DEBUG_DRIVER("pxlclk doesn't support %ld Hz\n",
 					 req_rate);
-			return MODE_NOCLOCK;
+			status = MODE_NOCLOCK;
+			goto out;
 		}
 	}
 
+out:
+	drm_dev_exit(idx);
 	return MODE_OK;
 }
 
@@ -52,11 +61,15 @@ static void malidp_crtc_atomic_enable(struct drm_crtc *crtc,
 	struct malidp_drm *malidp = crtc_to_malidp_device(crtc);
 	struct malidp_hw_device *hwdev = malidp->dev;
 	struct videomode vm;
-	int err = pm_runtime_get_sync(crtc->dev->dev);
+	int err, idx;
+
+	if (!drm_dev_enter(&malidp->base, &idx))
+		return;
 
+	err = pm_runtime_get_sync(crtc->dev->dev);
 	if (err < 0) {
 		DRM_DEBUG_DRIVER("Failed to enable runtime power management: %d\n", err);
-		return;
+		goto out;
 	}
 
 	drm_display_mode_to_videomode(&crtc->state->adjusted_mode, &vm);
@@ -68,6 +81,9 @@ static void malidp_crtc_atomic_enable(struct drm_crtc *crtc,
 	hwdev->hw->modeset(hwdev, &vm);
 	hwdev->hw->leave_config_mode(hwdev);
 	drm_crtc_vblank_on(crtc);
+
+out:
+	drm_dev_exit(idx);
 }
 
 static void malidp_crtc_atomic_disable(struct drm_crtc *crtc,
@@ -77,7 +93,10 @@ static void malidp_crtc_atomic_disable(struct drm_crtc *crtc,
 									 crtc);
 	struct malidp_drm *malidp = crtc_to_malidp_device(crtc);
 	struct malidp_hw_device *hwdev = malidp->dev;
-	int err;
+	int err, idx;
+
+	if (!drm_dev_enter(&malidp->base, &idx))
+		return;
 
 	/* always disable planes on the CRTC that is being turned off */
 	drm_atomic_helper_disable_planes_on_crtc(old_state, false);
@@ -91,6 +110,8 @@ static void malidp_crtc_atomic_disable(struct drm_crtc *crtc,
 	if (err < 0) {
 		DRM_DEBUG_DRIVER("Failed to disable runtime power management: %d\n", err);
 	}
+
+	drm_dev_exit(idx);
 }
 
 static const struct gamma_curve_segment {
@@ -260,7 +281,10 @@ static int malidp_crtc_atomic_check_scaling(struct drm_crtc *crtc,
 	u32 h_upscale_factor = 0; /* U16.16 */
 	u32 v_upscale_factor = 0; /* U16.16 */
 	u8 scaling = cs->scaled_planes_mask;
-	int ret;
+	int idx, ret;
+
+	if (!drm_dev_enter(&malidp->base, &idx))
+		return -ENODEV;
 
 	if (!scaling) {
 		s->scale_enable = false;
@@ -268,8 +292,10 @@ static int malidp_crtc_atomic_check_scaling(struct drm_crtc *crtc,
 	}
 
 	/* The scaling engine can only handle one plane at a time. */
-	if (scaling & (scaling - 1))
-		return -EINVAL;
+	if (scaling & (scaling - 1)) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	drm_atomic_crtc_state_for_each_plane_state(plane, pstate, state) {
 		struct malidp_plane *mp = to_malidp_plane(plane);
@@ -331,10 +357,10 @@ static int malidp_crtc_atomic_check_scaling(struct drm_crtc *crtc,
 
 mclk_calc:
 	drm_display_mode_to_videomode(&state->adjusted_mode, &vm);
-	ret = hwdev->hw->se_calc_mclk(hwdev, s, &vm);
-	if (ret < 0)
-		return -EINVAL;
-	return 0;
+	ret = hwdev->hw->se_calc_mclk(hwdev, s, &vm) < 0 ? -EINVAL : 0;
+out:
+	drm_dev_exit(idx);
+	return ret;
 }
 
 static int malidp_crtc_atomic_check(struct drm_crtc *crtc,
@@ -498,9 +524,16 @@ static int malidp_crtc_enable_vblank(struct drm_crtc *crtc)
 {
 	struct malidp_drm *malidp = crtc_to_malidp_device(crtc);
 	struct malidp_hw_device *hwdev = malidp->dev;
+	int idx;
+
+	if (!drm_dev_enter(&malidp->base, &idx))
+		return -ENODEV;
 
 	malidp_hw_enable_irq(hwdev, MALIDP_DE_BLOCK,
 			     hwdev->hw->map.de_irq_map.vsync_irq);
+
+	drm_dev_exit(idx);
+
 	return 0;
 }
 
@@ -508,9 +541,15 @@ static void malidp_crtc_disable_vblank(struct drm_crtc *crtc)
 {
 	struct malidp_drm *malidp = crtc_to_malidp_device(crtc);
 	struct malidp_hw_device *hwdev = malidp->dev;
+	int idx;
+
+	if (!drm_dev_enter(&malidp->base, &idx))
+		return;
 
 	malidp_hw_disable_irq(hwdev, MALIDP_DE_BLOCK,
 			      hwdev->hw->map.de_irq_map.vsync_irq);
+
+	drm_dev_exit(idx);
 }
 
 static const struct drm_crtc_funcs malidp_crtc_funcs = {
-- 
2.37.3

