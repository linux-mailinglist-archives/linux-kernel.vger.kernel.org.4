Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7D66A5577
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 10:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbjB1JU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 04:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbjB1JUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 04:20:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC1D1DBB1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 01:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677575972;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QdbwjW6mh2D31Q//X6nqJgpNGXAc9BEbg23UZQeD1ZY=;
        b=MlXxH81ctTppINt6420HQO/l8SfMvDR6f5Yv6Tapfy4UDs12HM88tp//Iqr+76QucmeRaJ
        m0XFI2TvEIHJNE/fTU2GjljvNR9Cvj3wNVnUVs/F3dVayFW2ZSca++zq5fvBQuSUO2mdXN
        RaIa8g56+0Pk9R/4L8sBMn1J2cDLGE4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-183-bllSDU0UPjCympAo2zqG8g-1; Tue, 28 Feb 2023 04:19:30 -0500
X-MC-Unique: bllSDU0UPjCympAo2zqG8g-1
Received: by mail-wr1-f71.google.com with SMTP id x3-20020a5d6503000000b002c8c421fdfaso1376812wru.15
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 01:19:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677575969;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QdbwjW6mh2D31Q//X6nqJgpNGXAc9BEbg23UZQeD1ZY=;
        b=zN6PSaUVNYKPkfPf+G85ZUPK2dpYZvL7+1Cg5fs+rpLThfLcjBwxQ/iIrSwS/v0i+1
         ZGQEGXA9HJXGLvyx3JoUTbteZ1bf3bsFp7gW7Hjm+59aWFBNdpHAKOedL/Dy5X651/xq
         yuhg6ue2rTWlKUDXwArhkBIM94dt1zsGSS3QLH4MQZkzEjmbj+Aeylo97h0JtLOJP7hq
         cit/Ym/fyRWrZnZ9OoQskGryrju97M2P29+SAAHbCocO4MyWhPuAxyq/bphP6876+1+V
         ujxDq71Cwam/zh15GJmbjZNf1PEyxaGeoKMX1jNoNhj9dTN3CSnuAKdBhoBfoOTdXJoj
         hX5A==
X-Gm-Message-State: AO0yUKWDuR10fn3VTb29bzcNXroPslTycSFdiOU8xE1KtJIQuxDZQFiy
        bIh4p0xID7q10SQcGpm8pvSuzKJVyAWYcxT+pXzHtpMvWSDenSRXRhDZD8k6oxKqk9ahpNBO68p
        QZsoR8YICSqw+ybLEGBm+snKitFn8Xw==
X-Received: by 2002:adf:d84f:0:b0:2c7:1e16:57cf with SMTP id k15-20020adfd84f000000b002c71e1657cfmr1362633wrl.67.1677575969446;
        Tue, 28 Feb 2023 01:19:29 -0800 (PST)
X-Google-Smtp-Source: AK7set/dz651a4PoXIYeSOC9JT6wZQx3Rn5ZUvdKYAe7L6UD30v+qnszt0MT84Gs5qjY714aHC6kxw==
X-Received: by 2002:adf:d84f:0:b0:2c7:1e16:57cf with SMTP id k15-20020adfd84f000000b002c71e1657cfmr1362608wrl.67.1677575969096;
        Tue, 28 Feb 2023 01:19:29 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id i20-20020a5d5234000000b002c5493a17efsm9394627wra.25.2023.02.28.01.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 01:19:28 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Gerd Hoffmann <kraxel@redhat.com>, Rob Clark <robdclark@gmail.com>
Cc:     Rob Clark <robdclark@chromium.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        open list <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Ryan Neph <ryanneph@chromium.org>,
        David Airlie <airlied@redhat.com>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH] drm/virtio: Add option to disable KMS support
In-Reply-To: <20230228062809.ccyzgnvizh6jidn4@sirius.home.kraxel.org>
References: <20230224180225.2477641-1-robdclark@gmail.com>
 <20230227063821.dg2gbjjwcekbxyzw@sirius.home.kraxel.org>
 <CAF6AEGsv1G7CPSkCPe3iHGB9JEO4iy+bTbkFLoitmx64U78RJw@mail.gmail.com>
 <20230228062809.ccyzgnvizh6jidn4@sirius.home.kraxel.org>
Date:   Tue, 28 Feb 2023 10:19:27 +0100
Message-ID: <87a60yywo0.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gerd Hoffmann <kraxel@redhat.com> writes:

Hello Gerd,

> On Mon, Feb 27, 2023 at 07:40:11AM -0800, Rob Clark wrote:
>> On Sun, Feb 26, 2023 at 10:38 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>> >
>> > On Fri, Feb 24, 2023 at 10:02:24AM -0800, Rob Clark wrote:
>> > > From: Rob Clark <robdclark@chromium.org>
>> > >
>> > > Add a build option to disable modesetting support.  This is useful in
>> > > cases where the guest only needs to use the GPU in a headless mode, or
>> > > (such as in the CrOS usage) window surfaces are proxied to a host
>> > > compositor.
>> >
>> > Why make that a compile time option?  There is a config option for the
>> > number of scanouts (aka virtual displays) a device has.  Just set that
>> > to zero (and fix the driver to not consider that configuration an
>> > error).
>> 
>> The goal is to not advertise DRIVER_MODESET (and DRIVER_ATOMIC).. I
>> guess that could be done based on whether there are any scanouts, but
>> it would mean making the drm_driver struct non-const.
>
> Apparently there is a drm_device->driver_features override,
> (amdgpu uses that).  The driver could simply drop the DRIVER_MODESET and
> DRIVER_ATOMIC bits in case no scanout is present instead of throwing an
> error.
>
>> And I think it is legitimate to allow the guest to make this choice,
>> regardless of what the host decides to expose, since it is about the
>> ioctl surface area that the guest kernel exposes to guest userspace.
>
> I think it is a bad idea to make that a compile time option, I'd suggest
> a runtime switch instead, for example a module parameter to ask the
> driver to ignore any scanouts.
>

I don't think there's a need for a new module parameter, there's already
the virtio-gpu 'modeset' module parameter to enable/disable modsetting
and the global 'nomodeset' kernel cmdline parameter to do it for all DRM
drivers.

Currently, many drivers just fail to probe when 'nomodeset' is present,
but others only disable modsetting but keep the rendering part. In fact,
most DRM only drivers just ignore the 'nomodeset' parameter.

We could make virtio-gpu driver to only disable KMS with these params,
something like the following (untested) patch:

From 9cddee7f696f37c34d80d6160e87827f3d7a0237 Mon Sep 17 00:00:00 2001
From: Javier Martinez Canillas <javierm@redhat.com>
Date: Tue, 28 Feb 2023 10:09:11 +0100
Subject: [PATCH] drm/virtio: Only disable KMS with nomodeset

The virtio-gpu driver currently fails to probe if either the "nomodeset"
kernel cmdline parameter is used or the module "modeset" parameter used.

But there may be cases where the rendering part of the driver is needed
and only the mode setting part needs to be disabled. So let's change the
logic to only disable the KMS part but still keep the DRM side of it.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_display.c | 16 +++++++++++++++
 drivers/gpu/drm/virtio/virtgpu_drv.c     | 23 ++++++++++++++--------
 drivers/gpu/drm/virtio/virtgpu_kms.c     | 25 +-----------------------
 3 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
index 9ea7611a9e0f..e176e5e8c1a0 100644
--- a/drivers/gpu/drm/virtio/virtgpu_display.c
+++ b/drivers/gpu/drm/virtio/virtgpu_display.c
@@ -335,6 +335,22 @@ static const struct drm_mode_config_funcs virtio_gpu_mode_funcs = {
 int virtio_gpu_modeset_init(struct virtio_gpu_device *vgdev)
 {
 	int i, ret;
+	u32 num_scanouts;
+
+	if (virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_EDID)) {
+		vgdev->has_edid = true;
+	}
+
+	/* get display info */
+	virtio_cread_le(vgdev->vdev, struct virtio_gpu_config,
+			num_scanouts, &num_scanouts);
+	vgdev->num_scanouts = min_t(uint32_t, num_scanouts,
+				    VIRTIO_GPU_MAX_SCANOUTS);
+	if (!vgdev->num_scanouts) {
+		DRM_ERROR("num_scanouts is zero\n");
+		return -EINVAL;
+	}
+	DRM_INFO("number of scanouts: %d\n", num_scanouts);
 
 	ret = drmm_mode_config_init(vgdev->ddev);
 	if (ret)
diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
index ae97b98750b6..979b5b177f49 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.c
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
@@ -40,7 +40,7 @@
 
 #include "virtgpu_drv.h"
 
-static const struct drm_driver driver;
+static struct drm_driver driver;
 
 static int virtio_gpu_modeset = -1;
 
@@ -69,13 +69,12 @@ static int virtio_gpu_pci_quirk(struct drm_device *dev)
 static int virtio_gpu_probe(struct virtio_device *vdev)
 {
 	struct drm_device *dev;
+	struct virtio_gpu_device *vgdev;
 	int ret;
 
-	if (drm_firmware_drivers_only() && virtio_gpu_modeset == -1)
-		return -EINVAL;
-
-	if (virtio_gpu_modeset == 0)
-		return -EINVAL;
+	if ((drm_firmware_drivers_only() && virtio_gpu_modeset == -1) ||
+	    (virtio_gpu_modeset == 0))
+		driver.driver_features &= ~(DRIVER_MODESET | DRIVER_ATOMIC);
 
 	/*
 	 * The virtio-gpu device is a virtual device that doesn't have DMA
@@ -98,11 +97,19 @@ static int virtio_gpu_probe(struct virtio_device *vdev)
 	if (ret)
 		goto err_free;
 
+	if (drm_core_check_feature(dev, DRIVER_MODESET)) {
+		vgdev = dev->dev_private;
+		ret = virtio_gpu_modeset_init(vgdev);
+		if (ret)
+			goto err_deinit;
+	}
+
 	ret = drm_dev_register(dev, 0);
 	if (ret)
 		goto err_deinit;
 
-	drm_fbdev_generic_setup(vdev->priv, 32);
+	if (drm_core_check_feature(dev, DRIVER_MODESET))
+		drm_fbdev_generic_setup(vdev->priv, 32);
 	return 0;
 
 err_deinit:
@@ -171,7 +178,7 @@ MODULE_AUTHOR("Alon Levy");
 
 DEFINE_DRM_GEM_FOPS(virtio_gpu_driver_fops);
 
-static const struct drm_driver driver = {
+static struct drm_driver driver = {
 	.driver_features = DRIVER_MODESET | DRIVER_GEM | DRIVER_RENDER | DRIVER_ATOMIC,
 	.open = virtio_gpu_driver_open,
 	.postclose = virtio_gpu_driver_postclose,
diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
index 27b7f14dae89..2f5f2aac6b71 100644
--- a/drivers/gpu/drm/virtio/virtgpu_kms.c
+++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
@@ -122,7 +122,7 @@ int virtio_gpu_init(struct virtio_device *vdev, struct drm_device *dev)
 	struct virtio_gpu_device *vgdev;
 	/* this will expand later */
 	struct virtqueue *vqs[2];
-	u32 num_scanouts, num_capsets;
+	u32 num_capsets;
 	int ret = 0;
 
 	if (!virtio_has_feature(vdev, VIRTIO_F_VERSION_1))
@@ -161,9 +161,6 @@ int virtio_gpu_init(struct virtio_device *vdev, struct drm_device *dev)
 	if (virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_VIRGL))
 		vgdev->has_virgl_3d = true;
 #endif
-	if (virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_EDID)) {
-		vgdev->has_edid = true;
-	}
 	if (virtio_has_feature(vgdev->vdev, VIRTIO_RING_F_INDIRECT_DESC)) {
 		vgdev->has_indirect = true;
 	}
@@ -218,28 +215,10 @@ int virtio_gpu_init(struct virtio_device *vdev, struct drm_device *dev)
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
-	}
-	DRM_INFO("number of scanouts: %d\n", num_scanouts);
-
 	virtio_cread_le(vgdev->vdev, struct virtio_gpu_config,
 			num_capsets, &num_capsets);
 	DRM_INFO("number of cap sets: %d\n", num_capsets);
 
-	ret = virtio_gpu_modeset_init(vgdev);
-	if (ret) {
-		DRM_ERROR("modeset init failed\n");
-		goto err_scanouts;
-	}
-
 	virtio_device_ready(vgdev->vdev);
 
 	if (num_capsets)
@@ -252,8 +231,6 @@ int virtio_gpu_init(struct virtio_device *vdev, struct drm_device *dev)
 			   5 * HZ);
 	return 0;
 
-err_scanouts:
-	virtio_gpu_free_vbufs(vgdev);
 err_vbufs:
 	vgdev->vdev->config->del_vqs(vgdev->vdev);
 err_vqs:
-- 
2.39.2

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

