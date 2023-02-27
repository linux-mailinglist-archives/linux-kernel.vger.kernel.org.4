Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5DEF6A4762
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 17:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjB0Q4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 11:56:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjB0Q4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 11:56:38 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C202331B
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 08:56:36 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id r40so4675489oiw.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 08:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UFOFhw8IRNqs5cPEOOn1fmt/veQOghOiXH0c0ACn44g=;
        b=Ihkny839qJsF9eJvYoIxD5wZsPdFIkxSe2idlYePFV7G/ClKpGzvX1tsvulQ526bZs
         jwhfQQDDdy0W0NyL4gxvnE4D1/BO0CSOhEnRqag/roMIUr+y9H6aDTaA20HwjGsJYJpV
         aseRMPqIXjL8X/S+wVfgA/OBjiLvEi629ygZDNbzcgaV1TFCrrJAYqmf0zxGG+TcrFb+
         V/EHim8g3XCqUpz+IdAGbZ1gc9VbdgrIb1OV/Q3v2xTzMvfRvLtzWZKU/yHq3UyN/BzB
         h74E2WrSACowm/TakUCYDXQvqSXRtDJeRj7HRhgHSDMEB05WFeZvwrGDhIuD/VgdsxQS
         YnKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UFOFhw8IRNqs5cPEOOn1fmt/veQOghOiXH0c0ACn44g=;
        b=EDQHNHFNcvkzLd3AOr9IPhvCxCcV4zCa7HhWEZkixigG9x0RSs81+de234Q6HooD0s
         xP4w/OUKPrHX/ktFTZRCQ2Hw9SJ/npPwZI4n2w/gb8Ti18fVBE/Ep5u9ZDCq0vkDjisR
         Wk5SBPxIujaKG9wlVtYb9SYAZ59uz9Yoe+KFKC/c5xMxGlYRmfTrbgM9eMyUWpMb0Iyg
         AuKn0RO8BW+0wOn9x/tWj1DhkMNZy0PIn21TCx0kEgpoCl/6Q1J1js6WvXq7FcBqtsfG
         Q45sSNWkTepeMdYTmgi/aWbTpXuoVbcvZ1eF9PsA5UwvFpldQ2mDIZAk6cvRPeD+Vzo5
         B6wA==
X-Gm-Message-State: AO0yUKVlTj2mXejk9dWsy+Egz9GLsEyKuwQ5tKlGVbVsUxU9a91PwdAq
        /wAZog7mnLdFhYNIXwtGf0SmO7HoACY4e6ALjxU=
X-Google-Smtp-Source: AK7set9KKDyOAtXfl6ttjcR6L1Q7g1Em64KRPcVyPy0CnlrqZJRRGo704yVg02/SL9WYEkXwyrCt9VRtT9E2YEAE+Wc=
X-Received: by 2002:a54:409a:0:b0:384:253:642d with SMTP id
 i26-20020a54409a000000b003840253642dmr3506494oii.3.1677516996023; Mon, 27 Feb
 2023 08:56:36 -0800 (PST)
MIME-Version: 1.0
References: <20230227160114.2799001-1-robdclark@gmail.com> <Y/zXaaFJhi8Q5YRZ@phenom.ffwll.local>
In-Reply-To: <Y/zXaaFJhi8Q5YRZ@phenom.ffwll.local>
From:   Rob Clark <robdclark@gmail.com>
Date:   Mon, 27 Feb 2023 08:56:24 -0800
Message-ID: <CAF6AEGt1fjSVhV03uP2v-jxzwRvZLia+0CZOwxbbS038rAZgzw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/virtio: Add option to disable KMS support
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org,
        Chia-I Wu <olvaffe@gmail.com>,
        Ryan Neph <ryanneph@chromium.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Rob Clark <robdclark@chromium.org>,
        David Airlie <airlied@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 8:16 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Mon, Feb 27, 2023 at 08:01:13AM -0800, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > Add a build option to disable modesetting support.  This is useful in
> > cases where the guest only needs to use the GPU in a headless mode, or
> > (such as in the CrOS usage) window surfaces are proxied to a host
> > compositor.
> >
> > v2: Use more if (IS_ENABLED(...))
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
>
> This feels a bit much like a worksforus solution. Not objecting to landing
> this, but would some kind of feature bit on the virtio hw and
> autodetection in the guest driver side work? Especially if people ever
> want to get this to a Just Works model with standard distros.

I could probably make this also work if the host advertises zero
scanouts.  But I don't expect distro's would want to disable this
option, which is why it is "If unsure, say Y".  The CrOS guest kernel
already needs a special "virtio-wl" driver, so we are already
venturing outside of "guest is just a generic distro" territory.

BR,
-R

> Usually the argument for compile option is "binary size", but you're
> leaving most of the kms stuff in there so that's clearly not it :-)
> -Daniel
>
>
>
> > ---
> >  drivers/gpu/drm/virtio/Kconfig       | 11 +++++++++
> >  drivers/gpu/drm/virtio/Makefile      |  5 +++-
> >  drivers/gpu/drm/virtio/virtgpu_drv.c |  6 ++++-
> >  drivers/gpu/drm/virtio/virtgpu_drv.h | 10 ++++++++
> >  drivers/gpu/drm/virtio/virtgpu_kms.c | 35 ++++++++++++++++------------
> >  5 files changed, 50 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/virtio/Kconfig b/drivers/gpu/drm/virtio/Kconfig
> > index 51ec7c3240c9..ea06ff2aa4b4 100644
> > --- a/drivers/gpu/drm/virtio/Kconfig
> > +++ b/drivers/gpu/drm/virtio/Kconfig
> > @@ -11,3 +11,14 @@ config DRM_VIRTIO_GPU
> >          QEMU based VMMs (like KVM or Xen).
> >
> >          If unsure say M.
> > +
> > +config DRM_VIRTIO_GPU_KMS
> > +     bool "Virtio GPU driver modesetting support"
> > +     depends on DRM_VIRTIO_GPU
> > +     default y
> > +     help
> > +        Enable modesetting support for virtio GPU driver.  This can be
> > +        disabled in cases where only "headless" usage of the GPU is
> > +        required.
> > +
> > +        If unsure, say Y.
> > diff --git a/drivers/gpu/drm/virtio/Makefile b/drivers/gpu/drm/virtio/Makefile
> > index b99fa4a73b68..24c7ebe87032 100644
> > --- a/drivers/gpu/drm/virtio/Makefile
> > +++ b/drivers/gpu/drm/virtio/Makefile
> > @@ -4,8 +4,11 @@
> >  # Direct Rendering Infrastructure (DRI) in XFree86 4.1.0 and higher.
> >
> >  virtio-gpu-y := virtgpu_drv.o virtgpu_kms.o virtgpu_gem.o virtgpu_vram.o \
> > -     virtgpu_display.o virtgpu_vq.o \
> > +     virtgpu_vq.o \
> >       virtgpu_fence.o virtgpu_object.o virtgpu_debugfs.o virtgpu_plane.o \
> >       virtgpu_ioctl.o virtgpu_prime.o virtgpu_trace_points.o
> >
> > +virtio-gpu-$(CONFIG_DRM_VIRTIO_GPU_KMS) += \
> > +     virtgpu_display.o
> > +
> >  obj-$(CONFIG_DRM_VIRTIO_GPU) += virtio-gpu.o
> > diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
> > index ae97b98750b6..9cb7d6dd3da6 100644
> > --- a/drivers/gpu/drm/virtio/virtgpu_drv.c
> > +++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
> > @@ -172,7 +172,11 @@ MODULE_AUTHOR("Alon Levy");
> >  DEFINE_DRM_GEM_FOPS(virtio_gpu_driver_fops);
> >
> >  static const struct drm_driver driver = {
> > -     .driver_features = DRIVER_MODESET | DRIVER_GEM | DRIVER_RENDER | DRIVER_ATOMIC,
> > +     .driver_features =
> > +#if defined(CONFIG_DRM_VIRTIO_GPU_KMS)
> > +                     DRIVER_MODESET | DRIVER_ATOMIC |
> > +#endif
> > +                     DRIVER_GEM | DRIVER_RENDER,
> >       .open = virtio_gpu_driver_open,
> >       .postclose = virtio_gpu_driver_postclose,
> >
> > diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
> > index af6ffb696086..ffe8faf67247 100644
> > --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> > +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> > @@ -426,8 +426,18 @@ virtio_gpu_cmd_set_scanout_blob(struct virtio_gpu_device *vgdev,
> >                               uint32_t x, uint32_t y);
> >
> >  /* virtgpu_display.c */
> > +#if defined(CONFIG_DRM_VIRTIO_GPU_KMS)
> >  int virtio_gpu_modeset_init(struct virtio_gpu_device *vgdev);
> >  void virtio_gpu_modeset_fini(struct virtio_gpu_device *vgdev);
> > +#else
> > +static inline int virtio_gpu_modeset_init(struct virtio_gpu_device *vgdev)
> > +{
> > +     return 0;
> > +}
> > +static inline void virtio_gpu_modeset_fini(struct virtio_gpu_device *vgdev)
> > +{
> > +}
> > +#endif
> >
> >  /* virtgpu_plane.c */
> >  uint32_t virtio_gpu_translate_format(uint32_t drm_fourcc);
> > diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
> > index 27b7f14dae89..70d87e653d07 100644
> > --- a/drivers/gpu/drm/virtio/virtgpu_kms.c
> > +++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
> > @@ -161,7 +161,8 @@ int virtio_gpu_init(struct virtio_device *vdev, struct drm_device *dev)
> >       if (virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_VIRGL))
> >               vgdev->has_virgl_3d = true;
> >  #endif
> > -     if (virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_EDID)) {
> > +     if (IS_ENABLED(CONFIG_DRM_VIRTIO_GPU_KMS) &&
> > +         virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_EDID)) {
> >               vgdev->has_edid = true;
> >       }
> >       if (virtio_has_feature(vgdev->vdev, VIRTIO_RING_F_INDIRECT_DESC)) {
> > @@ -218,17 +219,19 @@ int virtio_gpu_init(struct virtio_device *vdev, struct drm_device *dev)
> >               goto err_vbufs;
> >       }
> >
> > -     /* get display info */
> > -     virtio_cread_le(vgdev->vdev, struct virtio_gpu_config,
> > -                     num_scanouts, &num_scanouts);
> > -     vgdev->num_scanouts = min_t(uint32_t, num_scanouts,
> > -                                 VIRTIO_GPU_MAX_SCANOUTS);
> > -     if (!vgdev->num_scanouts) {
> > -             DRM_ERROR("num_scanouts is zero\n");
> > -             ret = -EINVAL;
> > -             goto err_scanouts;
> > +     if (IS_ENABLED(CONFIG_DRM_VIRTIO_GPU_KMS)) {
> > +             /* get display info */
> > +             virtio_cread_le(vgdev->vdev, struct virtio_gpu_config,
> > +                             num_scanouts, &num_scanouts);
> > +             vgdev->num_scanouts = min_t(uint32_t, num_scanouts,
> > +                                         VIRTIO_GPU_MAX_SCANOUTS);
> > +             if (!vgdev->num_scanouts) {
> > +                     DRM_ERROR("num_scanouts is zero\n");
> > +                     ret = -EINVAL;
> > +                     goto err_scanouts;
> > +             }
> > +             DRM_INFO("number of scanouts: %d\n", num_scanouts);
> >       }
> > -     DRM_INFO("number of scanouts: %d\n", num_scanouts);
> >
> >       virtio_cread_le(vgdev->vdev, struct virtio_gpu_config,
> >                       num_capsets, &num_capsets);
> > @@ -246,10 +249,12 @@ int virtio_gpu_init(struct virtio_device *vdev, struct drm_device *dev)
> >               virtio_gpu_get_capsets(vgdev, num_capsets);
> >       if (vgdev->has_edid)
> >               virtio_gpu_cmd_get_edids(vgdev);
> > -     virtio_gpu_cmd_get_display_info(vgdev);
> > -     virtio_gpu_notify(vgdev);
> > -     wait_event_timeout(vgdev->resp_wq, !vgdev->display_info_pending,
> > -                        5 * HZ);
> > +     if (IS_ENABLED(CONFIG_DRM_VIRTIO_GPU_KMS)) {
> > +             virtio_gpu_cmd_get_display_info(vgdev);
> > +             virtio_gpu_notify(vgdev);
> > +             wait_event_timeout(vgdev->resp_wq, !vgdev->display_info_pending,
> > +                                5 * HZ);
> > +     }
> >       return 0;
> >
> >  err_scanouts:
> > --
> > 2.39.1
> >
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
