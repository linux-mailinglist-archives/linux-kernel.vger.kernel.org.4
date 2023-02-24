Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E916A2111
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 19:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjBXSCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 13:02:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjBXSCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 13:02:32 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66295206BE
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 10:02:30 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id y2so12999752pjg.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 10:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dIetUbx7EIF3EVZI4uWomKEyBANtRstOQ9q276wzqdo=;
        b=MH6aam4wwxxCOP8F74s6Ll3IKPas17IyPHqfjrU5DRqREcp574aRJL7kZZuGLwFtVM
         5qjwEkw++dNg3OMCh2Mtk6meGfZ10SKB8U9bSt0sReAXqCuRh6EfFKMsMx+c1OC4Pgon
         wyvgbEPrwlEVV0Ru6arZDsOe/vb+k7/8o0RqOFWHBPQbxxeg9MRI6yg0BjX8HvWZ4JI6
         Vk8Tlb6Dr9bOk3jtTS3WAGohoRkn3p82EsApeWBwGCjmaO4fkDPz8AbSPi9uGOJTPktK
         Njh3v40YmDl2P0NXJLECxSCJKbMnE20Pcn+zoMIpaP3w9hWNsgQacWC49zFUwiIuY6Gn
         +Mdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dIetUbx7EIF3EVZI4uWomKEyBANtRstOQ9q276wzqdo=;
        b=s0YpC5G5OsaqaeAI0plWCeIHB0RjLt7puN0di1WW80by8ifoaoEvZGtPthott8e7Qr
         ByGUANdqQEHHNQ71zKZ5j/wyJEOs+xUkA0VKzxR9MpQY+uV8L03MD6/PuDmIvMf7qPMf
         0pMeoy6WGNPQIIUWSW/knien5DWwjg7Wr/LZH2DvgQZR1MeNb0kVS9jvxPgGac8vxwtg
         lwOTClrHW8iV5+0OStMGfOpqsYt9EWrEj3CUwO5FJ3xRgZDxpFbF6l+s2Hx5g1Rhpz81
         SlLhHtPRFODO+OI60a4JDi4GbG0JLnUAQKXk4nE6h4WxAcX3ZIPVPqJG8JCcXz1El1mu
         kktQ==
X-Gm-Message-State: AO0yUKXf4M0bkqqy98QVDdDuiyH7ijzDb4CTJjOh3thnmxyEe9GU1m5J
        sphALosMV3Ev0nSZbTOYvOY=
X-Google-Smtp-Source: AK7set9P5Feo6a4/0yoFYK8d+lC8D6mrYWoq7w/KhB+AYtuzYRizJ3vRuhh03PSshTB20wmkY0jxxA==
X-Received: by 2002:a17:902:ba83:b0:19c:be07:4af2 with SMTP id k3-20020a170902ba8300b0019cbe074af2mr4714336pls.45.1677261749322;
        Fri, 24 Feb 2023 10:02:29 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id h5-20020a170902704500b00198ff118fd3sm1108105plt.101.2023.02.24.10.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 10:02:28 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Chia-I Wu <olvaffe@gmail.com>, Ryan Neph <ryanneph@chromium.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Rob Clark <robdclark@chromium.org>,
        David Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/virtio: Add option to disable KMS support
Date:   Fri, 24 Feb 2023 10:02:24 -0800
Message-Id: <20230224180225.2477641-1-robdclark@gmail.com>
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

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/virtio/Kconfig       | 11 +++++++++++
 drivers/gpu/drm/virtio/Makefile      |  5 ++++-
 drivers/gpu/drm/virtio/virtgpu_drv.c |  6 +++++-
 drivers/gpu/drm/virtio/virtgpu_drv.h | 10 ++++++++++
 drivers/gpu/drm/virtio/virtgpu_kms.c |  6 ++++++
 5 files changed, 36 insertions(+), 2 deletions(-)

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
index 27b7f14dae89..293e6f0bf133 100644
--- a/drivers/gpu/drm/virtio/virtgpu_kms.c
+++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
@@ -161,9 +161,11 @@ int virtio_gpu_init(struct virtio_device *vdev, struct drm_device *dev)
 	if (virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_VIRGL))
 		vgdev->has_virgl_3d = true;
 #endif
+#if defined(CONFIG_DRM_VIRTIO_GPU_KMS)
 	if (virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_EDID)) {
 		vgdev->has_edid = true;
 	}
+#endif
 	if (virtio_has_feature(vgdev->vdev, VIRTIO_RING_F_INDIRECT_DESC)) {
 		vgdev->has_indirect = true;
 	}
@@ -218,6 +220,7 @@ int virtio_gpu_init(struct virtio_device *vdev, struct drm_device *dev)
 		goto err_vbufs;
 	}
 
+#if defined(CONFIG_DRM_VIRTIO_GPU_KMS)
 	/* get display info */
 	virtio_cread_le(vgdev->vdev, struct virtio_gpu_config,
 			num_scanouts, &num_scanouts);
@@ -229,6 +232,7 @@ int virtio_gpu_init(struct virtio_device *vdev, struct drm_device *dev)
 		goto err_scanouts;
 	}
 	DRM_INFO("number of scanouts: %d\n", num_scanouts);
+#endif
 
 	virtio_cread_le(vgdev->vdev, struct virtio_gpu_config,
 			num_capsets, &num_capsets);
@@ -246,10 +250,12 @@ int virtio_gpu_init(struct virtio_device *vdev, struct drm_device *dev)
 		virtio_gpu_get_capsets(vgdev, num_capsets);
 	if (vgdev->has_edid)
 		virtio_gpu_cmd_get_edids(vgdev);
+#if defined(CONFIG_DRM_VIRTIO_GPU_KMS)
 	virtio_gpu_cmd_get_display_info(vgdev);
 	virtio_gpu_notify(vgdev);
 	wait_event_timeout(vgdev->resp_wq, !vgdev->display_info_pending,
 			   5 * HZ);
+#endif
 	return 0;
 
 err_scanouts:
-- 
2.39.1

