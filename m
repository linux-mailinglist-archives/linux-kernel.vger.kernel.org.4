Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E853E5F1D01
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 16:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiJAO6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 10:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiJAO6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 10:58:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0A89AFD1
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 07:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664636294;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d5wQaZFEzn9uIXApEc4pGB3KbziveTZ08VHPOZH9w9g=;
        b=Fzjxn7w4rx1mqMTR505zo3FraEs0YT1lBoxwn5zgxwHQyARrqZXmVISRL3Wb4QMxSsTMAQ
        onHEgRVKd5nFzESfrTxpxuw4dOdkVp7xkuIVFXoaO2XXyEJT8bY7huigjrgslMXyVlPxyC
        w1eIIMo6Ziq8v9vfk/sylpuCQYyX/Ts=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-426-GVe-venlN7-ZSS_481PLfQ-1; Sat, 01 Oct 2022 10:58:12 -0400
X-MC-Unique: GVe-venlN7-ZSS_481PLfQ-1
Received: by mail-ed1-f69.google.com with SMTP id dz21-20020a0564021d5500b0045217702048so5564605edb.5
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 07:58:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=d5wQaZFEzn9uIXApEc4pGB3KbziveTZ08VHPOZH9w9g=;
        b=mI6kTGhw7+UBnD0a4i+8gJHsuXsAsiQPSS/YACw+As5LT22K/wy6D4O5Y/UKt4F+Jv
         w+Yu9OG2OH0tSq6bj5kuokAxmTJjL6ZK2Nj0OOaHgxMXWCNtOFdNZWCJ3kM1GbNdrmkS
         Qo5IEEjmD+5lo+t0uNGIgq7QqxyogYCe/Ej3pb6R/+RUXfPkgXbybIjUcHxjX+3tKdib
         JRtA2QrjvRkloqsCq7thwVe4P/GKV7npF0YQ0NaSqCO+cDbMgKe2pIIXf4REHDgmlcqh
         Q99GVBNaCgkzBT0dUo9Y7Ym2deiykPWfds6TFlWbhNNzs03n8smiAaLA7wcH8TjWX77l
         KPvA==
X-Gm-Message-State: ACrzQf3Vq5VjDJZjO6nU8FkEsOsCP7z2xFmpBZd4dSzuv7P2q2ReOSPQ
        GKpESYykNLtQuF0ipJBovwSKaLeQW4i4k9uZ4kEeCVZhFju3ZwobPnsdOmPMlU4j9nLHEGCjKu/
        SY/NVBvesBarVfCCYoZ2ZLzYV
X-Received: by 2002:aa7:cd4f:0:b0:458:6077:c3ac with SMTP id v15-20020aa7cd4f000000b004586077c3acmr8383491edw.32.1664636291354;
        Sat, 01 Oct 2022 07:58:11 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5quDAMs15O1EjA+ONIf+6V51idpelHTXT3LBeScuciqSA9637lLszp8q/Y+fE9d7gydpiI7A==
X-Received: by 2002:aa7:cd4f:0:b0:458:6077:c3ac with SMTP id v15-20020aa7cd4f000000b004586077c3acmr8383476edw.32.1664636291177;
        Sat, 01 Oct 2022 07:58:11 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id q1-20020a17090609a100b00772b5835c12sm2841964eje.23.2022.10.01.07.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 07:58:10 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, stefan@agner.ch, alison.wang@nxp.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v2 1/9] drm/fsl-dcu: use drmm_* to allocate driver structures
Date:   Sat,  1 Oct 2022 16:57:54 +0200
Message-Id: <20221001145802.515916-2-dakr@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221001145802.515916-1-dakr@redhat.com>
References: <20221001145802.515916-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use drm managed resources to allocate driver structures and get rid of
the deprecated drm_dev_alloc() call and replace it with
devm_drm_dev_alloc().

This also serves as preparation to get rid of drm_device->dev_private
and to fix use-after-free issues on driver unload.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c |  7 ++---
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c  | 30 +++++++++-------------
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h  |  2 +-
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_kms.c  | 19 +++++++-------
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c  |  8 +++---
 5 files changed, 31 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c
index 2af60d98f48f..a1b8ce70928a 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c
@@ -171,15 +171,16 @@ int fsl_dcu_drm_crtc_create(struct fsl_dcu_drm_device *fsl_dev)
 {
 	struct drm_plane *primary;
 	struct drm_crtc *crtc = &fsl_dev->crtc;
+	struct drm_device *drm = &fsl_dev->base;
 	int ret;
 
-	fsl_dcu_drm_init_planes(fsl_dev->drm);
+	fsl_dcu_drm_init_planes(drm);
 
-	primary = fsl_dcu_drm_primary_create_plane(fsl_dev->drm);
+	primary = fsl_dcu_drm_primary_create_plane(drm);
 	if (!primary)
 		return -ENOMEM;
 
-	ret = drm_crtc_init_with_planes(fsl_dev->drm, crtc, primary, NULL,
+	ret = drm_crtc_init_with_planes(drm, crtc, primary, NULL,
 					&fsl_dcu_drm_crtc_funcs, NULL);
 	if (ret) {
 		primary->funcs->destroy(primary);
diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
index b4acc3422ba4..a47b72995fcf 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
@@ -168,6 +168,7 @@ static const struct drm_driver fsl_dcu_drm_driver = {
 static int fsl_dcu_drm_pm_suspend(struct device *dev)
 {
 	struct fsl_dcu_drm_device *fsl_dev = dev_get_drvdata(dev);
+	struct drm_device *drm = &fsl_dev->base;
 	int ret;
 
 	if (!fsl_dev)
@@ -175,7 +176,7 @@ static int fsl_dcu_drm_pm_suspend(struct device *dev)
 
 	disable_irq(fsl_dev->irq);
 
-	ret = drm_mode_config_helper_suspend(fsl_dev->drm);
+	ret = drm_mode_config_helper_suspend(drm);
 	if (ret) {
 		enable_irq(fsl_dev->irq);
 		return ret;
@@ -189,6 +190,7 @@ static int fsl_dcu_drm_pm_suspend(struct device *dev)
 static int fsl_dcu_drm_pm_resume(struct device *dev)
 {
 	struct fsl_dcu_drm_device *fsl_dev = dev_get_drvdata(dev);
+	struct drm_device *drm = &fsl_dev->base;
 	int ret;
 
 	if (!fsl_dev)
@@ -202,10 +204,10 @@ static int fsl_dcu_drm_pm_resume(struct device *dev)
 
 	if (fsl_dev->tcon)
 		fsl_tcon_bypass_enable(fsl_dev->tcon);
-	fsl_dcu_drm_init_planes(fsl_dev->drm);
+	fsl_dcu_drm_init_planes(drm);
 	enable_irq(fsl_dev->irq);
 
-	drm_mode_config_helper_resume(fsl_dev->drm);
+	drm_mode_config_helper_resume(drm);
 
 	return 0;
 }
@@ -255,9 +257,10 @@ static int fsl_dcu_drm_probe(struct platform_device *pdev)
 	int ret;
 	u8 div_ratio_shift = 0;
 
-	fsl_dev = devm_kzalloc(dev, sizeof(*fsl_dev), GFP_KERNEL);
-	if (!fsl_dev)
-		return -ENOMEM;
+	fsl_dev = devm_drm_dev_alloc(dev, &fsl_dcu_drm_driver,
+				     typeof(*fsl_dev), base);
+	if (IS_ERR(fsl_dev))
+		return PTR_ERR(fsl_dev);
 
 	id = of_match_node(fsl_dcu_of_match, pdev->dev.of_node);
 	if (!id)
@@ -317,28 +320,19 @@ static int fsl_dcu_drm_probe(struct platform_device *pdev)
 
 	fsl_dev->tcon = fsl_tcon_init(dev);
 
-	drm = drm_dev_alloc(&fsl_dcu_drm_driver, dev);
-	if (IS_ERR(drm)) {
-		ret = PTR_ERR(drm);
-		goto unregister_pix_clk;
-	}
-
 	fsl_dev->dev = dev;
-	fsl_dev->drm = drm;
 	fsl_dev->np = dev->of_node;
 	drm->dev_private = fsl_dev;
 	dev_set_drvdata(dev, fsl_dev);
 
 	ret = drm_dev_register(drm, 0);
 	if (ret < 0)
-		goto put;
+		goto unregister_pix_clk;
 
 	drm_fbdev_generic_setup(drm, legacyfb_depth);
 
 	return 0;
 
-put:
-	drm_dev_put(drm);
 unregister_pix_clk:
 	clk_unregister(fsl_dev->pix_clk);
 disable_clk:
@@ -349,9 +343,9 @@ static int fsl_dcu_drm_probe(struct platform_device *pdev)
 static int fsl_dcu_drm_remove(struct platform_device *pdev)
 {
 	struct fsl_dcu_drm_device *fsl_dev = platform_get_drvdata(pdev);
+	struct drm_device *drm = &fsl_dev->base;
 
-	drm_dev_unregister(fsl_dev->drm);
-	drm_dev_put(fsl_dev->drm);
+	drm_dev_unregister(drm);
 	clk_disable_unprepare(fsl_dev->clk);
 	clk_unregister(fsl_dev->pix_clk);
 
diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h
index e2049a0e8a92..20ca13ff618a 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h
@@ -177,6 +177,7 @@ struct fsl_dcu_soc_data {
 };
 
 struct fsl_dcu_drm_device {
+	struct drm_device base;
 	struct device *dev;
 	struct device_node *np;
 	struct regmap *regmap;
@@ -186,7 +187,6 @@ struct fsl_dcu_drm_device {
 	struct fsl_tcon *tcon;
 	/*protects hardware register*/
 	spinlock_t irq_lock;
-	struct drm_device *drm;
 	struct drm_crtc crtc;
 	struct drm_encoder encoder;
 	struct fsl_dcu_drm_connector connector;
diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_kms.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_kms.c
index 5b47000738e4..c3d55c0aca9f 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_kms.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_kms.c
@@ -20,15 +20,16 @@ static const struct drm_mode_config_funcs fsl_dcu_drm_mode_config_funcs = {
 
 int fsl_dcu_drm_modeset_init(struct fsl_dcu_drm_device *fsl_dev)
 {
+	struct drm_device *drm = &fsl_dev->base;
 	int ret;
 
-	drm_mode_config_init(fsl_dev->drm);
+	drm_mode_config_init(drm);
 
-	fsl_dev->drm->mode_config.min_width = 0;
-	fsl_dev->drm->mode_config.min_height = 0;
-	fsl_dev->drm->mode_config.max_width = 2031;
-	fsl_dev->drm->mode_config.max_height = 2047;
-	fsl_dev->drm->mode_config.funcs = &fsl_dcu_drm_mode_config_funcs;
+	drm->mode_config.min_width = 0;
+	drm->mode_config.min_height = 0;
+	drm->mode_config.max_width = 2031;
+	drm->mode_config.max_height = 2047;
+	drm->mode_config.funcs = &fsl_dcu_drm_mode_config_funcs;
 
 	ret = fsl_dcu_drm_crtc_create(fsl_dev);
 	if (ret)
@@ -42,12 +43,12 @@ int fsl_dcu_drm_modeset_init(struct fsl_dcu_drm_device *fsl_dev)
 	if (ret)
 		goto err;
 
-	drm_mode_config_reset(fsl_dev->drm);
-	drm_kms_helper_poll_init(fsl_dev->drm);
+	drm_mode_config_reset(drm);
+	drm_kms_helper_poll_init(drm);
 
 	return 0;
 
 err:
-	drm_mode_config_cleanup(fsl_dev->drm);
+	drm_mode_config_cleanup(drm);
 	return ret;
 }
diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c
index 4d4a715b429d..b9b02f617cd2 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c
@@ -22,6 +22,7 @@ int fsl_dcu_drm_encoder_create(struct fsl_dcu_drm_device *fsl_dev,
 			       struct drm_crtc *crtc)
 {
 	struct drm_encoder *encoder = &fsl_dev->encoder;
+	struct drm_device *drm = &fsl_dev->base;
 	int ret;
 
 	encoder->possible_crtcs = 1;
@@ -30,8 +31,7 @@ int fsl_dcu_drm_encoder_create(struct fsl_dcu_drm_device *fsl_dev,
 	if (fsl_dev->tcon)
 		fsl_tcon_bypass_enable(fsl_dev->tcon);
 
-	ret = drm_simple_encoder_init(fsl_dev->drm, encoder,
-				      DRM_MODE_ENCODER_LVDS);
+	ret = drm_simple_encoder_init(drm, encoder, DRM_MODE_ENCODER_LVDS);
 	if (ret < 0)
 		return ret;
 
@@ -79,12 +79,12 @@ static int fsl_dcu_attach_panel(struct fsl_dcu_drm_device *fsl_dev,
 {
 	struct drm_encoder *encoder = &fsl_dev->encoder;
 	struct drm_connector *connector = &fsl_dev->connector.base;
+	struct drm_device *drm = &fsl_dev->base;
 	int ret;
 
 	fsl_dev->connector.encoder = encoder;
 
-	ret = drm_connector_init(fsl_dev->drm, connector,
-				 &fsl_dcu_drm_connector_funcs,
+	ret = drm_connector_init(drm, connector, &fsl_dcu_drm_connector_funcs,
 				 DRM_MODE_CONNECTOR_LVDS);
 	if (ret < 0)
 		return ret;
-- 
2.37.3

