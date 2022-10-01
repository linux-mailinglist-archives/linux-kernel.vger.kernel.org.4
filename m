Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 896705F1D15
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 16:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiJAO7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 10:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiJAO7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 10:59:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6ACD9DFB5
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 07:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664636317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IqWM55e5x02znRK55veSvbQ977VUM5OMWrptzYqj4WI=;
        b=XZYAaFtWCsu0wJs5SYMv151hpBcdiXxO0/uJVMndEicJJ4pDT0vf1OOmUwgQ1RcYK5EXV9
        cNmJsYW2TTZii2EqE0IO1ZfdN3dYNow+AQxuOD5q7tlTlOuwHVtnPWDlMw1t1moS8/uB6z
        JjvQ8CtXq+KeQJqGezazFrFTigCVKQA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-333-8CCcJDjAMF-UxmxvVMR2vg-1; Sat, 01 Oct 2022 10:58:34 -0400
X-MC-Unique: 8CCcJDjAMF-UxmxvVMR2vg-1
Received: by mail-ed1-f71.google.com with SMTP id t13-20020a056402524d00b00452c6289448so5656536edd.17
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 07:58:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=IqWM55e5x02znRK55veSvbQ977VUM5OMWrptzYqj4WI=;
        b=2KV84S4gyldXMVFo9DuJnCcOqTTrY9QesjBhPenghV2yv04I+DKyHDlJ0o+1C23uS3
         N1iZsfKNyDKQ8731WM2kq5C4KR3QOMhxMrbA8+/0+659WVnonkFU2OfJMGXpbY87ePQm
         qmCQTv4TnpCsuVlNrqiqT/+NdqDPPY9TEmlKpNaEC5JDGaMYJneEAQQ7O64bLP9277Gt
         mJ8CFq92t498/IMxQ4CXO9oO5bDOo7ldMIb13tUbwoe6cq1OJIItt/VwIRME+ZmSK6N/
         5TFpbv6TvlmzrpS94XfLAUBTWkJHcvi2CvM5hU50N47KFzxXGPXf/yX42qqSZnD9KNeL
         jPFQ==
X-Gm-Message-State: ACrzQf1eCOOtSWqmKyZfMiDLhGku34AmRr/6tcMUD10D3wi2PwcOEtL9
        sxvOrebLmWH3FrZNKcrOGB+poFFY+CnNbm/uRZPgJyr4k5+o4WBhyvUMzj+/gNCqCViQODdQ7Vr
        yZ7L0Wuv/gvgy3E54LSUbGJJc
X-Received: by 2002:a17:907:6ea4:b0:782:6b82:a2cb with SMTP id sh36-20020a1709076ea400b007826b82a2cbmr10122992ejc.408.1664636313407;
        Sat, 01 Oct 2022 07:58:33 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7yvsyArbVNFdDnwv/ocXdiRliElOJYmVUR11MG6/x3BFrrdNeYB3g5s60MP+XkB94O71odTg==
X-Received: by 2002:a17:907:6ea4:b0:782:6b82:a2cb with SMTP id sh36-20020a1709076ea400b007826b82a2cbmr10122982ejc.408.1664636313177;
        Sat, 01 Oct 2022 07:58:33 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id i26-20020a50fc1a000000b00457c9b7ac07sm3649245edr.84.2022.10.01.07.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 07:58:32 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, stefan@agner.ch, alison.wang@nxp.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v2 7/9] drm/fsl-dcu: crtc: protect device resources after removal
Date:   Sat,  1 Oct 2022 16:58:00 +0200
Message-Id: <20221001145802.515916-8-dakr@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221001145802.515916-1-dakr@redhat.com>
References: <20221001145802.515916-1-dakr@redhat.com>
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
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c
index 1dad90f701c8..c77df9b7893f 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c
@@ -13,6 +13,7 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
+#include <drm/drm_drv.h>
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_vblank.h>
 
@@ -26,6 +27,10 @@ static void fsl_dcu_drm_crtc_atomic_flush(struct drm_crtc *crtc,
 	struct drm_device *dev = crtc->dev;
 	struct fsl_dcu_drm_device *fsl_dev = drm_to_fsl_dcu_drm_dev(dev);
 	struct drm_pending_vblank_event *event = crtc->state->event;
+	int idx;
+
+	if (!drm_dev_enter(dev, &idx))
+		return;
 
 	regmap_write(fsl_dev->regmap,
 		     DCU_UPDATE_MODE, DCU_UPDATE_MODE_READREG);
@@ -40,6 +45,8 @@ static void fsl_dcu_drm_crtc_atomic_flush(struct drm_crtc *crtc,
 			drm_crtc_send_vblank_event(crtc, event);
 		spin_unlock_irq(&crtc->dev->event_lock);
 	}
+
+	drm_dev_exit(idx);
 }
 
 static void fsl_dcu_drm_crtc_atomic_disable(struct drm_crtc *crtc,
@@ -49,6 +56,10 @@ static void fsl_dcu_drm_crtc_atomic_disable(struct drm_crtc *crtc,
 									      crtc);
 	struct drm_device *dev = crtc->dev;
 	struct fsl_dcu_drm_device *fsl_dev = drm_to_fsl_dcu_drm_dev(dev);
+	int idx;
+
+	if (!drm_dev_enter(dev, &idx))
+		return;
 
 	/* always disable planes on the CRTC */
 	drm_atomic_helper_disable_planes_on_crtc(old_crtc_state, true);
@@ -61,6 +72,8 @@ static void fsl_dcu_drm_crtc_atomic_disable(struct drm_crtc *crtc,
 	regmap_write(fsl_dev->regmap, DCU_UPDATE_MODE,
 		     DCU_UPDATE_MODE_READREG);
 	clk_disable_unprepare(fsl_dev->pix_clk);
+
+	drm_dev_exit(idx);
 }
 
 static void fsl_dcu_drm_crtc_atomic_enable(struct drm_crtc *crtc,
@@ -68,6 +81,10 @@ static void fsl_dcu_drm_crtc_atomic_enable(struct drm_crtc *crtc,
 {
 	struct drm_device *dev = crtc->dev;
 	struct fsl_dcu_drm_device *fsl_dev = drm_to_fsl_dcu_drm_dev(dev);
+	int idx;
+
+	if (!drm_dev_enter(dev, &idx))
+		return;
 
 	clk_prepare_enable(fsl_dev->pix_clk);
 	regmap_update_bits(fsl_dev->regmap, DCU_DCU_MODE,
@@ -77,6 +94,8 @@ static void fsl_dcu_drm_crtc_atomic_enable(struct drm_crtc *crtc,
 		     DCU_UPDATE_MODE_READREG);
 
 	drm_crtc_vblank_on(crtc);
+
+	drm_dev_exit(idx);
 }
 
 static void fsl_dcu_drm_crtc_mode_set_nofb(struct drm_crtc *crtc)
@@ -87,6 +106,10 @@ static void fsl_dcu_drm_crtc_mode_set_nofb(struct drm_crtc *crtc)
 	struct drm_display_mode *mode = &crtc->state->mode;
 	unsigned int pol = 0;
 	struct videomode vm;
+	int idx;
+
+	if (!drm_dev_enter(dev, &idx))
+		return;
 
 	clk_set_rate(fsl_dev->pix_clk, mode->clock * 1000);
 
@@ -122,6 +145,8 @@ static void fsl_dcu_drm_crtc_mode_set_nofb(struct drm_crtc *crtc)
 		     DCU_THRESHOLD_LS_BF_VS(BF_VS_VAL) |
 		     DCU_THRESHOLD_OUT_BUF_HIGH(BUF_MAX_VAL) |
 		     DCU_THRESHOLD_OUT_BUF_LOW(BUF_MIN_VAL));
+
+	drm_dev_exit(idx);
 	return;
 }
 
@@ -137,11 +162,17 @@ static int fsl_dcu_drm_crtc_enable_vblank(struct drm_crtc *crtc)
 	struct drm_device *dev = crtc->dev;
 	struct fsl_dcu_drm_device *fsl_dev = drm_to_fsl_dcu_drm_dev(dev);
 	unsigned int value;
+	int idx;
+
+	if (!drm_dev_enter(dev, &idx))
+		return -ENODEV;
 
 	regmap_read(fsl_dev->regmap, DCU_INT_MASK, &value);
 	value &= ~DCU_INT_MASK_VBLANK;
 	regmap_write(fsl_dev->regmap, DCU_INT_MASK, value);
 
+	drm_dev_exit(idx);
+
 	return 0;
 }
 
@@ -150,10 +181,16 @@ static void fsl_dcu_drm_crtc_disable_vblank(struct drm_crtc *crtc)
 	struct drm_device *dev = crtc->dev;
 	struct fsl_dcu_drm_device *fsl_dev = drm_to_fsl_dcu_drm_dev(dev);
 	unsigned int value;
+	int idx;
+
+	if (!drm_dev_enter(dev, &idx))
+		return;
 
 	regmap_read(fsl_dev->regmap, DCU_INT_MASK, &value);
 	value |= DCU_INT_MASK_VBLANK;
 	regmap_write(fsl_dev->regmap, DCU_INT_MASK, value);
+
+	drm_dev_exit(idx);
 }
 
 static const struct drm_crtc_funcs fsl_dcu_drm_crtc_funcs = {
-- 
2.37.3

