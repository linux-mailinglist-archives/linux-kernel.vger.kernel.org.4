Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C726A4851
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 18:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjB0Rjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 12:39:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbjB0RjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 12:39:07 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1264F2448C
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:38:15 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id x34so7001575pjj.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rNfTITiB76ukzwFF6cFliF1Hu+NibHQ+AsYiWgqYkCQ=;
        b=eXJ7ddIAJ7waVdfnoYhVLXmN2+0TxqaR5PmjrQJg6HeA0mQmBG0DfgD3GIJJeALDfY
         WdnQJr3gpoKJsm96pDlGwhfXfwNZrKKv+PrAqcYNZQpEcVkzEv/NdOK6ZiV1K8n5YvrJ
         HqBt5LELLlO89gyVeGhn2H7UbZV2ngWy52FkAiqxjCBPyWuyIM/FZ5X6OFqgiyMQu5eP
         e04qpaZaHyHAhTOKumvdycHgBgdNRoCDfkK6pBkU7azFTb7YZyXfG1nezfOjl2mMvdE/
         ZPf9DoVJ0lGKZPXpSWltya7SIXwG5B+1bNpDB9BPearrz5NJ91rkguCrhFcfTdPwqdv1
         fO8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rNfTITiB76ukzwFF6cFliF1Hu+NibHQ+AsYiWgqYkCQ=;
        b=BnNs1aCbVHumTjRaDyMeckqNfTCAFls5epPeQzMJGhd0zA4nwWHTmedGbW3+ybLm3s
         Axjn4Egua44LPwx1QHPloQNa0+e5KE+kAOJFLOHhNmtmLKn6KlFJZdPMAdY351a7ZP0/
         rTye3w+uon+8aAtbWcLfHb1K9INdJnj1mZETc9hY+X0czf5EqNtGUr3TTDYFLNdkOArf
         Jy6YXjFUP6qjEvyJxdqFsQ9BTciG8QbJFqvmpRZY8h0kcp8uw/Ed0sKq8M5z8vXcEZUp
         A1mdr/kCLgybmu+P8C5LgdCK6c7GGqPfVXgJjeKkdvFblTiIHoOtXGht/o81i79EyCGC
         7KWw==
X-Gm-Message-State: AO0yUKXSRvbxXEmh4E2bjw1AJElaKxHCtamh2au/vhnawnZb+fyauW2e
        h+lq0QhD+54BQ+4CqacP2us=
X-Google-Smtp-Source: AK7set/pvdAaqce378lV7yVOMqQ/LwE6WHpuj+2JJlXB4fyZwHAN6lzowY+ASeiTUC5nDZ6ywH8STg==
X-Received: by 2002:a05:6a20:77a4:b0:cc:1ec7:45e5 with SMTP id c36-20020a056a2077a400b000cc1ec745e5mr167119pzg.35.1677519490483;
        Mon, 27 Feb 2023 09:38:10 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id v20-20020a62a514000000b005d9984a947bsm4462373pfm.139.2023.02.27.09.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 09:38:09 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Chia-I Wu <olvaffe@gmail.com>, Ryan Neph <ryanneph@chromium.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@chromium.org>,
        David Airlie <airlied@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3] drm/virtio: Add option to disable KMS support
Date:   Mon, 27 Feb 2023 09:38:00 -0800
Message-Id: <20230227173800.2809727-1-robdclark@gmail.com>
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

v2: Use more if (IS_ENABLED(...))
v3: Also permit the host to advertise no scanouts

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/virtio/Kconfig       | 11 +++++++
 drivers/gpu/drm/virtio/Makefile      |  5 +++-
 drivers/gpu/drm/virtio/virtgpu_drv.c |  6 +++-
 drivers/gpu/drm/virtio/virtgpu_drv.h | 10 +++++++
 drivers/gpu/drm/virtio/virtgpu_kms.c | 44 ++++++++++++++++++----------
 5 files changed, 59 insertions(+), 17 deletions(-)

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
index ae97b98750b6..9cb7d6dd3da6 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.c
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
@@ -172,7 +172,11 @@ MODULE_AUTHOR("Alon Levy");
 DEFINE_DRM_GEM_FOPS(virtio_gpu_driver_fops);
 
 static const struct drm_driver driver = {
-	.driver_features = DRIVER_MODESET | DRIVER_GEM | DRIVER_RENDER | DRIVER_ATOMIC,
+	.driver_features =
+#if defined(CONFIG_DRM_VIRTIO_GPU_KMS)
+			DRIVER_MODESET | DRIVER_ATOMIC |
+#endif
+			DRIVER_GEM | DRIVER_RENDER,
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
index 27b7f14dae89..1d888e309d6b 100644
--- a/drivers/gpu/drm/virtio/virtgpu_kms.c
+++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
@@ -161,7 +161,8 @@ int virtio_gpu_init(struct virtio_device *vdev, struct drm_device *dev)
 	if (virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_VIRGL))
 		vgdev->has_virgl_3d = true;
 #endif
-	if (virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_EDID)) {
+	if (IS_ENABLED(CONFIG_DRM_VIRTIO_GPU_KMS) &&
+	    virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_EDID)) {
 		vgdev->has_edid = true;
 	}
 	if (virtio_has_feature(vgdev->vdev, VIRTIO_RING_F_INDIRECT_DESC)) {
@@ -218,17 +219,28 @@ int virtio_gpu_init(struct virtio_device *vdev, struct drm_device *dev)
 		goto err_vbufs;
 	}
 
-	/* get display info */
-	virtio_cread_le(vgdev->vdev, struct virtio_gpu_config,
-			num_scanouts, &num_scanouts);
-	vgdev->num_scanouts = min_t(uint32_t, num_scanouts,
-				    VIRTIO_GPU_MAX_SCANOUTS);
-	if (!vgdev->num_scanouts) {
-		DRM_ERROR("num_scanouts is zero\n");
-		ret = -EINVAL;
-		goto err_scanouts;
+	if (IS_ENABLED(CONFIG_DRM_VIRTIO_GPU_KMS)) {
+		/* get display info */
+		virtio_cread_le(vgdev->vdev, struct virtio_gpu_config,
+				num_scanouts, &num_scanouts);
+		vgdev->num_scanouts = min_t(uint32_t, num_scanouts,
+					    VIRTIO_GPU_MAX_SCANOUTS);
+		if (!vgdev->num_scanouts) {
+			/*
+			 * Having an EDID but no scanouts is non-sensical,
+			 * but it is permitted to have no scanouts and no
+			 * EDID (in which case DRIVER_MODESET and
+			 * DRIVER_ATOMIC are not advertised)
+			 */
+			if (vgdev->has_edid) {
+				DRM_ERROR("num_scanouts is zero\n");
+				ret = -EINVAL;
+				goto err_scanouts;
+			}
+			dev->driver_features &= ~(DRIVER_MODESET | DRIVER_ATOMIC);
+		}
+		DRM_INFO("number of scanouts: %d\n", num_scanouts);
 	}
-	DRM_INFO("number of scanouts: %d\n", num_scanouts);
 
 	virtio_cread_le(vgdev->vdev, struct virtio_gpu_config,
 			num_capsets, &num_capsets);
@@ -246,10 +258,12 @@ int virtio_gpu_init(struct virtio_device *vdev, struct drm_device *dev)
 		virtio_gpu_get_capsets(vgdev, num_capsets);
 	if (vgdev->has_edid)
 		virtio_gpu_cmd_get_edids(vgdev);
-	virtio_gpu_cmd_get_display_info(vgdev);
-	virtio_gpu_notify(vgdev);
-	wait_event_timeout(vgdev->resp_wq, !vgdev->display_info_pending,
-			   5 * HZ);
+	if (IS_ENABLED(CONFIG_DRM_VIRTIO_GPU_KMS) && vgdev->num_scanouts) {
+		virtio_gpu_cmd_get_display_info(vgdev);
+		virtio_gpu_notify(vgdev);
+		wait_event_timeout(vgdev->resp_wq, !vgdev->display_info_pending,
+				   5 * HZ);
+	}
 	return 0;
 
 err_scanouts:
-- 
2.39.1

