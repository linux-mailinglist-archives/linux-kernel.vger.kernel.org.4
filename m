Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09CD96A73E2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 19:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjCASyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 13:54:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjCASyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 13:54:39 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D742F46159
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 10:54:37 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id 6-20020a17090a190600b00237c5b6ecd7so207695pjg.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 10:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677696877;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qIhBybknQqSSCYaaXviqV/xcYtdK0wdqPp4paRUIIu0=;
        b=pHLFh6/NTQjadjGwr/P+ltAcpWdPLZqgVM9lMSDvqBcLYPNruHqX400/0+7OvKxxyd
         yAQMukFfkTmQ6rqX91Tt2iIS7TZyzTjor7Tb6V+eXkyDqtGqt1/bwY6PiEaOpPlN8hJL
         j1kX75ajoyEMSH3BzjnZaDXr//eko5EC5mmkyzSIq21N6ttdhwJaRajFta7XhPJt2n9h
         s7gLYsD5C5jVHsXJw2EdstgQTa8jOw/ugze68oLP116+agbM1do6xZ0paG6q9BJsizam
         3W2NyRi/mFWRRLsMVq6cLDdUNPCsz5qqNVxKuvTaQjfSj7OI+I3gv4+SxXs+pwRiVhkc
         r7vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677696877;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qIhBybknQqSSCYaaXviqV/xcYtdK0wdqPp4paRUIIu0=;
        b=PCPoCpkFxO/ofkMxuJkus5Xp4dqj6s7+w/Se7PbeFliD++OYXifQYTx5KFMm2ppN/L
         9FuHnoa3aogMTrxYQ0gU5C0q0FVPpR/VqsyGwizuhU9tUhFMU2SG1C2352VsrgFRjHDm
         f2eC8dTx7s6qjRlNboXtDVK/Y0w3Go2oVPPR2D4I2whcoZmc9fceXVJ0xH5LjxAbuc1o
         +C0jRGXqGx6iWuN+xRbfVkHyWMnfTC8lEH9bmyRwjHbn6qZA9s7soFwJ7oLdrBW57ser
         PfychMp0dZ6np/yLK6+8vSRMSEnaWarQwOgnB9j2JK1a1gAhIJ3z+h3oTeVJx/Q8S3Ml
         yr6g==
X-Gm-Message-State: AO0yUKWHcuUJpEG7T0IuF9CTL3aOv3e83jOE6+phSyjyk+08TEETeo1L
        bJCplGGFVx+hUKvMFnSJwTA=
X-Google-Smtp-Source: AK7set+PMn6YNoOuC6/NpsrFMwgq4P7BDo+JBRMQgrh+GPtAgWrragL0O79B+cVbgIzsDzIXyTIlUw==
X-Received: by 2002:a05:6a20:6922:b0:ce:33ea:a07c with SMTP id q34-20020a056a20692200b000ce33eaa07cmr2376980pzj.30.1677696877104;
        Wed, 01 Mar 2023 10:54:37 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id i21-20020a633c55000000b005034a46fbf7sm5563111pgn.28.2023.03.01.10.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 10:54:36 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Chia-I Wu <olvaffe@gmail.com>, Ryan Neph <ryanneph@chromium.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@chromium.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        David Airlie <airlied@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5] drm/virtio: Add option to disable KMS support
Date:   Wed,  1 Mar 2023 10:54:32 -0800
Message-Id: <20230301185432.3010939-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Add a build option to disable modesetting support.  This is useful in
cases where the guest only needs to use the GPU in a headless mode, or
(such as in the CrOS usage) window surfaces are proxied to a host
compositor.

As the modesetting ioctls are a big surface area for potential security
bugs to be found (it's happened in the past, we should assume it will
again in the future), it makes sense to have a build option to disable
those ioctls in cases where they serve no legitimate purpose.

v2: Use more if (IS_ENABLED(...))
v3: Also permit the host to advertise no scanouts
v4: Spiff out commit msg
v5: Make num_scanouts==0 and DRM_VIRTIO_GPU_KMS=n behave the same

Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
---
 drivers/gpu/drm/virtio/Kconfig       | 11 ++++++++++
 drivers/gpu/drm/virtio/Makefile      |  5 ++++-
 drivers/gpu/drm/virtio/virtgpu_drv.c |  4 ++++
 drivers/gpu/drm/virtio/virtgpu_drv.h | 10 +++++++++
 drivers/gpu/drm/virtio/virtgpu_kms.c | 33 +++++++++++++++++-----------
 5 files changed, 49 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/virtio/Kconfig b/drivers/gpu/drm/virtio/Kconfig
index 51ec7c3240c9..ea06ff2aa4b4 100644
--- a/drivers/gpu/drm/virtio/Kconfig
+++ b/drivers/gpu/drm/virtio/Kconfig
@@ -11,3 +11,14 @@ config DRM_VIRTIO_GPU
 	   QEMU based VMMs (like KVM or Xen).
 
 	   If unsure say M.
+
+config DRM_VIRTIO_GPU_KMS
+	bool "Virtio GPU driver modesetting support"
+	depends on DRM_VIRTIO_GPU
+	default y
+	help
+	   Enable modesetting support for virtio GPU driver.  This can be
+	   disabled in cases where only "headless" usage of the GPU is
+	   required.
+
+	   If unsure, say Y.
diff --git a/drivers/gpu/drm/virtio/Makefile b/drivers/gpu/drm/virtio/Makefile
index b99fa4a73b68..24c7ebe87032 100644
--- a/drivers/gpu/drm/virtio/Makefile
+++ b/drivers/gpu/drm/virtio/Makefile
@@ -4,8 +4,11 @@
 # Direct Rendering Infrastructure (DRI) in XFree86 4.1.0 and higher.
 
 virtio-gpu-y := virtgpu_drv.o virtgpu_kms.o virtgpu_gem.o virtgpu_vram.o \
-	virtgpu_display.o virtgpu_vq.o \
+	virtgpu_vq.o \
 	virtgpu_fence.o virtgpu_object.o virtgpu_debugfs.o virtgpu_plane.o \
 	virtgpu_ioctl.o virtgpu_prime.o virtgpu_trace_points.o
 
+virtio-gpu-$(CONFIG_DRM_VIRTIO_GPU_KMS) += \
+	virtgpu_display.o
+
 obj-$(CONFIG_DRM_VIRTIO_GPU) += virtio-gpu.o
diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
index ae97b98750b6..add075681e18 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.c
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
@@ -172,6 +172,10 @@ MODULE_AUTHOR("Alon Levy");
 DEFINE_DRM_GEM_FOPS(virtio_gpu_driver_fops);
 
 static const struct drm_driver driver = {
+	/*
+	 * If KMS is disabled DRIVER_MODESET and DRIVER_ATOMIC are masked
+	 * out via drm_device::driver_features:
+	 */
 	.driver_features = DRIVER_MODESET | DRIVER_GEM | DRIVER_RENDER | DRIVER_ATOMIC,
 	.open = virtio_gpu_driver_open,
 	.postclose = virtio_gpu_driver_postclose,
diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index af6ffb696086..ffe8faf67247 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -426,8 +426,18 @@ virtio_gpu_cmd_set_scanout_blob(struct virtio_gpu_device *vgdev,
 				uint32_t x, uint32_t y);
 
 /* virtgpu_display.c */
+#if defined(CONFIG_DRM_VIRTIO_GPU_KMS)
 int virtio_gpu_modeset_init(struct virtio_gpu_device *vgdev);
 void virtio_gpu_modeset_fini(struct virtio_gpu_device *vgdev);
+#else
+static inline int virtio_gpu_modeset_init(struct virtio_gpu_device *vgdev)
+{
+	return 0;
+}
+static inline void virtio_gpu_modeset_fini(struct virtio_gpu_device *vgdev)
+{
+}
+#endif
 
 /* virtgpu_plane.c */
 uint32_t virtio_gpu_translate_format(uint32_t drm_fourcc);
diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
index 27b7f14dae89..61a1afe2c8c8 100644
--- a/drivers/gpu/drm/virtio/virtgpu_kms.c
+++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
@@ -223,21 +223,26 @@ int virtio_gpu_init(struct virtio_device *vdev, struct drm_device *dev)
 			num_scanouts, &num_scanouts);
 	vgdev->num_scanouts = min_t(uint32_t, num_scanouts,
 				    VIRTIO_GPU_MAX_SCANOUTS);
-	if (!vgdev->num_scanouts) {
-		DRM_ERROR("num_scanouts is zero\n");
-		ret = -EINVAL;
-		goto err_scanouts;
+
+	if (IS_ENABLED(CONFIG_DRM_VIRTIO_GPU_KMS) || !vgdev->num_scanouts) {
+		DRM_INFO("KMS disabled\n");
+		vgdev->num_scanouts = 0;
+		vgdev->has_edid = false;
+		dev->driver_features &= ~(DRIVER_MODESET | DRIVER_ATOMIC);
+	} else {
+		DRM_INFO("number of scanouts: %d\n", num_scanouts);
 	}
-	DRM_INFO("number of scanouts: %d\n", num_scanouts);
 
 	virtio_cread_le(vgdev->vdev, struct virtio_gpu_config,
 			num_capsets, &num_capsets);
 	DRM_INFO("number of cap sets: %d\n", num_capsets);
 
-	ret = virtio_gpu_modeset_init(vgdev);
-	if (ret) {
-		DRM_ERROR("modeset init failed\n");
-		goto err_scanouts;
+	if (vgdev->num_scanouts) {
+		ret = virtio_gpu_modeset_init(vgdev);
+		if (ret) {
+			DRM_ERROR("modeset init failed\n");
+			goto err_scanouts;
+		}
 	}
 
 	virtio_device_ready(vgdev->vdev);
@@ -246,10 +251,12 @@ int virtio_gpu_init(struct virtio_device *vdev, struct drm_device *dev)
 		virtio_gpu_get_capsets(vgdev, num_capsets);
 	if (vgdev->has_edid)
 		virtio_gpu_cmd_get_edids(vgdev);
-	virtio_gpu_cmd_get_display_info(vgdev);
-	virtio_gpu_notify(vgdev);
-	wait_event_timeout(vgdev->resp_wq, !vgdev->display_info_pending,
-			   5 * HZ);
+	if (vgdev->num_scanouts) {
+		virtio_gpu_cmd_get_display_info(vgdev);
+		virtio_gpu_notify(vgdev);
+		wait_event_timeout(vgdev->resp_wq, !vgdev->display_info_pending,
+				   5 * HZ);
+	}
 	return 0;
 
 err_scanouts:
-- 
2.39.1

