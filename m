Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139105B91BE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 02:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiIOAe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 20:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiIOAd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 20:33:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D468A1C7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 17:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663201999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IqWM55e5x02znRK55veSvbQ977VUM5OMWrptzYqj4WI=;
        b=W9/nw2jv3HxF+4UEJ5ZqV9OSTTeEV3ilZPqjiOc7r7MCeyhT4MdRIk0JKAofVmJkFyQK3y
        zqEvT9v19SloV83rKDsyvEPUCdXmMziCNLr2QZ1l3j2xBy4kIXrkxHG9sG57tcWlaaCGQD
        NLYYwd3wRHObZl5QY7WJ5JXMK78aJo0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-636-Unpv0UoAMwOKq71vvshR7Q-1; Wed, 14 Sep 2022 20:33:07 -0400
X-MC-Unique: Unpv0UoAMwOKq71vvshR7Q-1
Received: by mail-ej1-f72.google.com with SMTP id nb35-20020a1709071ca300b007805be52049so139917ejc.17
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 17:33:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=IqWM55e5x02znRK55veSvbQ977VUM5OMWrptzYqj4WI=;
        b=aDEEWnQlto/7OguHUJ0b7KXdZoW1zpiUD0nilqtoHabm0VuQACga01n3XdYgEl8GPz
         eGZZm59UkAX5kFtZVXp8a0EUhXIAlQ8+FhLbcdNV8Ooe7sP2pkYmwEWL+mwlpnSW6+zo
         SZk4xlSiczFkqUInT5FqlZElMy9FIGaOBEKHTE90UI+sQR73i8KwkRjT3EgDBBNniY7+
         6stKjjplYWSZwvLFGVTU4PunDUuAABEcrlyi4uObXE/01mkhpaDS//iA+eDQY7E4lVw2
         919/1oLmekJqcf8S9fEmf7WagsOz4fxrH0nHa6Ptb9Jgoa5z85dYXJyBB4lRH2iKmKU6
         rpAw==
X-Gm-Message-State: ACgBeo121QN35AQ/8CPNdzKzIOoxl01uKBc/dawbFAJyAWr03RiRgq7f
        ChWbq+6Rb5z0g0cxSIV6jCohhkSPxZ/DioylH3mEqoIH6uV+3rqN/bsLBnb98MWejSfwTTSIqAx
        Y5uj9A0+KeB0jP1vwQtSRSyJR
X-Received: by 2002:a17:907:94d4:b0:77f:d0c9:573f with SMTP id dn20-20020a17090794d400b0077fd0c9573fmr8146058ejc.98.1663201986324;
        Wed, 14 Sep 2022 17:33:06 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6iVRAQ1Z8stFf5ouzhJoapY1r+dUfoumzBdmir+QwjM/bFap5BDDwaSqryltzmVKD37aquAA==
X-Received: by 2002:a17:907:94d4:b0:77f:d0c9:573f with SMTP id dn20-20020a17090794d400b0077fd0c9573fmr8146041ejc.98.1663201986181;
        Wed, 14 Sep 2022 17:33:06 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id p20-20020a056402155400b004479cec6496sm10715506edx.75.2022.09.14.17.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 17:33:05 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, stefan@agner.ch, alison.wang@nxp.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next 7/8] drm/fsl-dcu: crtc: protect device resources after removal
Date:   Thu, 15 Sep 2022 02:32:30 +0200
Message-Id: <20220915003231.363447-8-dakr@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220915003231.363447-1-dakr@redhat.com>
References: <20220915003231.363447-1-dakr@redhat.com>
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

