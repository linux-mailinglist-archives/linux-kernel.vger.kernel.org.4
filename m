Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D44473C40F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 00:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbjFWWZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 18:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjFWWZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 18:25:36 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB434269F
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 15:25:34 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f9bece8e19so15286265e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 15:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687559133; x=1690151133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mKukKTNolk7o3JwLovvGiZSWB7MAEKhSelWOQgYadOg=;
        b=nMpjrKdcnJ8XhmRMfB91CKOQkjOP9VFD/yB0lnj8RKVvNm+yU85lRkWGQtqRoix7+3
         47pIxJVbS1xpdiMdCdKV6hv+q7WMVtM2+ElPY7CbjHDjzOLt22K1p5+ndYZpo0MgD2Bt
         BGRG2sg6gUwO5FJDdghj8JwU5V3CjwMse3+Vg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687559133; x=1690151133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mKukKTNolk7o3JwLovvGiZSWB7MAEKhSelWOQgYadOg=;
        b=Tpr1EMcQLB50gVp9IxMz5NbW1vaIkrAyN7hwJMyeE94EK20vj+ev7gjO07Rz1twAqu
         raLT8lytHDp9vgjy7seR5Or6XU2ShVpZRZyEbDRVfl16qu2+2+q9Bpqz8zZQLux+S3+z
         VxWXU1enpjx4Riwbs6xGvBsJCFPnrRf+XY/hnrdEpUGkZEDnSbV27WbUO7VeFnArsqkL
         Wd34y3EFvzfRbtdg82Gj7qqmoI1FnziKLQ3RzBs7X6vz83RUicgeezAs5eDpzAzusjtj
         Vkzfd8IPjEJH+/uqgZFnCzs5TRGZ0mTZbInXsVLzMCJQJ63tzk+lWDhErIXiAClEodHp
         CALQ==
X-Gm-Message-State: AC+VfDyKzlGbuxA+9xqZXxYe4PVpKvAru1dpvVH/O5Kiis8ZkOGXtGqW
        9Ip07j/hG68cBqsWFd14z0K61Q==
X-Google-Smtp-Source: ACHHUZ7rsXQXJQmsIskpsoN95A1IWOFJKMU7V7NSVLFldsmXoPhlG5DDcXS3z9jdHUMyzCYrVoS/KQ==
X-Received: by 2002:a5d:58d1:0:b0:30f:bcfd:c690 with SMTP id o17-20020a5d58d1000000b0030fbcfdc690mr23643997wrf.38.1687559133379;
        Fri, 23 Jun 2023 15:25:33 -0700 (PDT)
Received: from big-boopo.mynetworksettings.com (pool-108-46-233-209.nycmny.fios.verizon.net. [108.46.233.209])
        by smtp.gmail.com with ESMTPSA id l6-20020a5d4106000000b0030c2e3c7fb3sm453223wrp.101.2023.06.23.15.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 15:25:33 -0700 (PDT)
From:   Jim Shargo <jshargo@chromium.org>
To:     mairacanal@riseup.net, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Melissa Wen <melissa.srw@gmail.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Jim Shargo <jshargo@chromium.org>, dri-devel@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] drm/vkms: Provide platform data when creating VKMS devices
Date:   Fri, 23 Jun 2023 18:23:45 -0400
Message-ID: <20230623222353.97283-4-jshargo@chromium.org>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
In-Reply-To: <20230623222353.97283-1-jshargo@chromium.org>
References: <20230623222353.97283-1-jshargo@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a small refactor to make ConfigFS support easier. This should be
a no-op refactor.

Signed-off-by: Jim Shargo <jshargo@chromium.org>
---
 drivers/gpu/drm/vkms/vkms_drv.c    | 13 +++++++++++--
 drivers/gpu/drm/vkms/vkms_drv.h    |  9 ++++++---
 drivers/gpu/drm/vkms/vkms_output.c |  2 +-
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index aa2bee82b757..d43121addf66 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -152,12 +152,14 @@ static int vkms_modeset_init(struct vkms_device *vkmsdev)
 	dev->mode_config.preferred_depth = 0;
 	dev->mode_config.helper_private = &vkms_mode_config_helpers;
 
-	return vkms_output_init(vkmsdev, 0);
+	return vkmsdev->is_default ? vkms_output_init_default(vkmsdev) :
+				     -ENOSYS;
 }
 
 static int vkms_platform_probe(struct platform_device *pdev)
 {
 	int ret;
+	struct vkms_device_setup *vkms_device_setup = pdev->dev.platform_data;
 	struct vkms_device *vkms_device;
 	void *grp;
 
@@ -177,6 +179,7 @@ static int vkms_platform_probe(struct platform_device *pdev)
 	vkms_device->config.cursor = enable_cursor;
 	vkms_device->config.writeback = enable_writeback;
 	vkms_device->config.overlay = enable_overlay;
+	vkms_device->is_default = vkms_device_setup->is_default;
 
 	ret = dma_coerce_mask_and_coherent(vkms_device->drm.dev,
 					   DMA_BIT_MASK(64));
@@ -240,6 +243,9 @@ static int __init vkms_init(void)
 {
 	int ret;
 	struct platform_device *pdev;
+	struct vkms_device_setup vkms_device_setup = {
+		.is_default = true,
+	};
 
 	ret = platform_driver_register(&vkms_platform_driver);
 	if (ret) {
@@ -247,8 +253,11 @@ static int __init vkms_init(void)
 		return ret;
 	}
 
-	pdev = platform_device_register_simple(DRIVER_NAME, -1, NULL, 0);
+	pdev = platform_device_register_data(NULL, DRIVER_NAME, 0,
+					     &vkms_device_setup,
+					     sizeof(vkms_device_setup));
 	if (IS_ERR(pdev)) {
+		DRM_ERROR("Unable to register default vkms device\n");
 		platform_driver_unregister(&vkms_platform_driver);
 		return PTR_ERR(pdev);
 	}
diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index 4c3274838ec7..84b35aa1dc5a 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -121,17 +121,20 @@ struct vkms_output {
 	struct vkms_plane planes[VKMS_MAX_PLANES];
 };
 
-struct vkms_device;
-
 struct vkms_config {
 	bool writeback;
 	bool cursor;
 	bool overlay;
 };
 
+struct vkms_device_setup {
+	bool is_default;
+};
+
 struct vkms_device {
 	struct drm_device drm;
 	struct platform_device *platform;
+	bool is_default;
 	struct vkms_output output;
 	struct vkms_config config;
 };
@@ -155,7 +158,7 @@ struct vkms_crtc *vkms_crtc_init(struct vkms_device *vkmsdev,
 				 struct drm_plane *primary,
 				 struct drm_plane *cursor);
 
-int vkms_output_init(struct vkms_device *vkmsdev, int index);
+int vkms_output_init_default(struct vkms_device *vkmsdev);
 
 struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
 				   enum drm_plane_type type);
diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
index 6b4a77780d3c..3b5e272a8b33 100644
--- a/drivers/gpu/drm/vkms/vkms_output.c
+++ b/drivers/gpu/drm/vkms/vkms_output.c
@@ -80,7 +80,7 @@ static struct drm_encoder *vkms_encoder_init(struct vkms_device *vkms_device)
 	return encoder;
 }
 
-int vkms_output_init(struct vkms_device *vkmsdev, int index)
+int vkms_output_init_default(struct vkms_device *vkmsdev)
 {
 	struct vkms_output *output = &vkmsdev->output;
 	struct drm_device *dev = &vkmsdev->drm;
-- 
2.41.0.162.gfafddb0af9-goog

