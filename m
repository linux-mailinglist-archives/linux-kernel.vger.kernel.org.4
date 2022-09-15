Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D334F5B91C2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 02:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbiIOAdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 20:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbiIOAdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 20:33:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FEB38992F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 17:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663201978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OuGypoVnJNhzQ829OSUgv+IQ/uot1AKSMTgWYQGrHy8=;
        b=f1Hv1olr/BC82QWkCn49K8tZr41rQVUU6OltO34EMPMuHCEZW1GDIVa+QljZniYt3IO6Ti
        U/OT0wa+Egt6D2uB2nP6snzM4ZeaX3Uw6YBWkzCjznNe8gjXVV7UL3Olj9VHDOjAVouGwG
        2Nio6gM4ncgOVfGTpbMr6aSXa3Ro0Fc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-494-R5SAjrXDNoWZYsDXay6zSw-1; Wed, 14 Sep 2022 20:32:57 -0400
X-MC-Unique: R5SAjrXDNoWZYsDXay6zSw-1
Received: by mail-ej1-f72.google.com with SMTP id qf40-20020a1709077f2800b0077b43f8b94cso5213485ejc.23
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 17:32:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=OuGypoVnJNhzQ829OSUgv+IQ/uot1AKSMTgWYQGrHy8=;
        b=JCmO7JmF/qfbiUYC6//djKz0F7Fn3e1bLyLEw6nfT2w5GamoiE4WFIVcwnzeyKL8wB
         v3ZpuehZAxqqRJxo0Lzp5d9dabN8Li/1D5L+VEcHGMkDEiIwRS3cnkyKt1R0RtsBq7Zh
         r2ZLW5DkR1ALytNKAGa13K3XXxWaX2rgqojH9KmkXwZygv3AQFQ8b1sH5UL9txw9lX5y
         wR+IKAEIX4/vXDtBMgnrUZtZj1faA7rHVsA7L49EvmjqOYG8NPTWrqxRod9AAwDy7mVj
         KfIuHOBTBfHIT+uZFTPY4Cdp074If9o2PvAtj4EzXd4hG6I1q460yNhFK9/4WrXM06X7
         gt/w==
X-Gm-Message-State: ACgBeo1rpt+6CI6WxATJzxWC7mcfPX7g1yZo24sjgEGWxnlApuFd5XcD
        mMJE4ifR49w2ExeN+pEZDGQ/U+d/3R70E68Md7UQsd3z66/k6Oi9X2xqeI8htm7H+3AufdHt0dt
        ClrPgR2U5Y4p6A6DX8AyTTOhZ
X-Received: by 2002:a17:907:75d4:b0:77a:fcb7:a2cc with SMTP id jl20-20020a17090775d400b0077afcb7a2ccmr17036615ejc.480.1663201974087;
        Wed, 14 Sep 2022 17:32:54 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4MNS6XjdMbm8wBWysxd/Ofibg9IanT71clyMWCRa2Ji1qtA7+ijOuAd2lmEatpGLIF+B5n7Q==
X-Received: by 2002:a17:907:75d4:b0:77a:fcb7:a2cc with SMTP id jl20-20020a17090775d400b0077afcb7a2ccmr17036608ejc.480.1663201973936;
        Wed, 14 Sep 2022 17:32:53 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id o22-20020a056402039600b00450d23d40besm10663787edv.82.2022.09.14.17.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 17:32:52 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, stefan@agner.ch, alison.wang@nxp.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next 4/8] drm/fsl-dcu: plane: use drm managed resources
Date:   Thu, 15 Sep 2022 02:32:27 +0200
Message-Id: <20220915003231.363447-5-dakr@redhat.com>
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

Use drm managed resource allocation (drmm_universal_plane_alloc()) in
order to get rid of the explicit destroy hook in struct drm_plane_funcs.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c  |  4 ++--
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c | 25 ++++++++-------------
 2 files changed, 11 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c
index 0b70624260fc..1dad90f701c8 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c
@@ -176,8 +176,8 @@ int fsl_dcu_drm_crtc_create(struct fsl_dcu_drm_device *fsl_dev)
 	fsl_dcu_drm_init_planes(drm);
 
 	primary = fsl_dcu_drm_primary_create_plane(drm);
-	if (!primary)
-		return -ENOMEM;
+	if (IS_ERR(primary))
+		return PTR_ERR(primary);
 
 	ret = drmm_crtc_init_with_planes(drm, crtc, primary, NULL,
 					 &fsl_dcu_drm_crtc_funcs, NULL);
diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c
index 91865956da02..23ff285da477 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c
@@ -174,7 +174,6 @@ static const struct drm_plane_helper_funcs fsl_dcu_drm_plane_helper_funcs = {
 static const struct drm_plane_funcs fsl_dcu_drm_plane_funcs = {
 	.atomic_duplicate_state = drm_atomic_helper_plane_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_plane_destroy_state,
-	.destroy = drm_plane_helper_destroy,
 	.disable_plane = drm_atomic_helper_disable_plane,
 	.reset = drm_atomic_helper_plane_reset,
 	.update_plane = drm_atomic_helper_update_plane,
@@ -206,24 +205,18 @@ void fsl_dcu_drm_init_planes(struct drm_device *dev)
 struct drm_plane *fsl_dcu_drm_primary_create_plane(struct drm_device *dev)
 {
 	struct drm_plane *primary;
-	int ret;
-
-	primary = kzalloc(sizeof(*primary), GFP_KERNEL);
-	if (!primary) {
-		DRM_DEBUG_KMS("Failed to allocate primary plane\n");
-		return NULL;
-	}
 
 	/* possible_crtc's will be filled in later by crtc_init */
-	ret = drm_universal_plane_init(dev, primary, 0,
-				       &fsl_dcu_drm_plane_funcs,
-				       fsl_dcu_drm_plane_formats,
-				       ARRAY_SIZE(fsl_dcu_drm_plane_formats),
-				       NULL, DRM_PLANE_TYPE_PRIMARY, NULL);
-	if (ret) {
-		kfree(primary);
-		primary = NULL;
+	primary = drmm_universal_plane_alloc(dev, struct drm_plane, dev, 0,
+					     &fsl_dcu_drm_plane_funcs,
+					     fsl_dcu_drm_plane_formats,
+					     ARRAY_SIZE(fsl_dcu_drm_plane_formats),
+					     NULL, DRM_PLANE_TYPE_PRIMARY, NULL);
+	if (IS_ERR(primary)) {
+		DRM_DEBUG_KMS("Failed to create primary plane\n");
+		return primary;
 	}
+
 	drm_plane_helper_add(primary, &fsl_dcu_drm_plane_helper_funcs);
 
 	return primary;
-- 
2.37.3

