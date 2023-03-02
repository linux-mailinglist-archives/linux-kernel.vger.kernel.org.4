Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B68C6A8D19
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 00:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjCBXfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 18:35:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCBXfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 18:35:12 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF422E053
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 15:35:10 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id a2so966333plm.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 15:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677800110;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZnV2ysdoyXjUrpdCQrmBC3MJoS1QGa+/4VTCaLwr/IA=;
        b=qvB8+mQ7h8uVjZUKQZNws288ccBV67GzNbaXTofx1wjqf/ytIzrKPz5QQdqZYqsFi/
         AelK9a55XpRrVOwEWJ+nnb6SmhWCPQCQTY3cBXWdOWcy3gl1q4H5Pqjfi6xwnH07nqsR
         pvln3kskVtJuNKo7BaqDeddbxpKKvEVfW8oGStUkcq3WGVZlun1tuohDf6va4HiW6wN3
         3IazJc/3JM53RG+o/U+kb+NuEftsu27B82UHV8F3RppK93bcXJUXAUbA4lBzqf8ozfJD
         Jf/qq8k/EDTEmpT0GbtATGh9Uw+5SNpNzcoaKk4YL1cwcI5/tCiOTUekx08liz1q1cXI
         b2Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677800110;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZnV2ysdoyXjUrpdCQrmBC3MJoS1QGa+/4VTCaLwr/IA=;
        b=W+d/Pk5X6F8kmFh9maECYCmPhHfMjlXwCVtzcOIF6mjU+X/aE7IET17wum4vqhtobc
         ZlyoUThnBzalKesWyRDdE3FxRbvD4yR5pGKNPsk2+Nex4K7Dq2b2XnlrKWNdZAe1FT0H
         QgDTKoXh+iS0FTVodsg22Y5i3UvzBQIgCHZ2uedjAt3rbE1E6KHWeRA04kcS9BZ4HoQR
         FRVJE2n4DVclGxRnH5IqrHND22H8vhZWrdrqzrFjZwPXAh06qjfDei71kP5WTSPsLzON
         Y/Nh9pg5dh5KVvCBLrgQTzOnMpXj8zjGaLUX8U3uDoD6/ZspWCKhUFiPjgGEWjwCBqvY
         y7vA==
X-Gm-Message-State: AO0yUKVh3n0Jf15oF7hI4kMHlwKCnBNzNb+kqNP5885GhTiY+vMHmqPA
        8qrJ3vO8h9p0OCtPJCnf4b4=
X-Google-Smtp-Source: AK7set+HbCU3T+T1xaEIiSVN0/+3rkeq32UaXybOuDXMEFmJIbxsCV9TGLNQfT2TYo3D79CM++aLhA==
X-Received: by 2002:a17:902:ec85:b0:19d:1dfe:eab4 with SMTP id x5-20020a170902ec8500b0019d1dfeeab4mr14789303plg.41.1677800110089;
        Thu, 02 Mar 2023 15:35:10 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id kb8-20020a170903338800b00194d14d8e54sm213616plb.96.2023.03.02.15.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 15:35:09 -0800 (PST)
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
Subject: [PATCH v6] drm/virtio: Add option to disable KMS support
Date:   Thu,  2 Mar 2023 15:35:06 -0800
Message-Id: <20230302233506.3146290-1-robdclark@gmail.com>
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
v6: Drop conditionally building virtgpu_display.c and early-out of
    it's init/fini fxns instead

Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
---
 drivers/gpu/drm/virtio/Kconfig           | 11 +++++++++++
 drivers/gpu/drm/virtio/virtgpu_display.c |  6 ++++++
 drivers/gpu/drm/virtio/virtgpu_drv.c     |  4 ++++
 drivers/gpu/drm/virtio/virtgpu_kms.c     | 23 ++++++++++++++---------
 4 files changed, 35 insertions(+), 9 deletions(-)

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
diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
index 9ea7611a9e0f..ad924a8502e9 100644
--- a/drivers/gpu/drm/virtio/virtgpu_display.c
+++ b/drivers/gpu/drm/virtio/virtgpu_display.c
@@ -336,6 +336,9 @@ int virtio_gpu_modeset_init(struct virtio_gpu_device *vgdev)
 {
 	int i, ret;
 
+	if (!vgdev->num_scanouts)
+		return 0;
+
 	ret = drmm_mode_config_init(vgdev->ddev);
 	if (ret)
 		return ret;
@@ -362,6 +365,9 @@ void virtio_gpu_modeset_fini(struct virtio_gpu_device *vgdev)
 {
 	int i;
 
+	if (!vgdev->num_scanouts)
+		return;
+
 	for (i = 0 ; i < vgdev->num_scanouts; ++i)
 		kfree(vgdev->outputs[i].edid);
 }
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
diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
index 27b7f14dae89..02e5c18c2c75 100644
--- a/drivers/gpu/drm/virtio/virtgpu_kms.c
+++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
@@ -223,12 +223,15 @@ int virtio_gpu_init(struct virtio_device *vdev, struct drm_device *dev)
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
@@ -246,10 +249,12 @@ int virtio_gpu_init(struct virtio_device *vdev, struct drm_device *dev)
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

