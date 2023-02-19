Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3847C69C14F
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 17:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjBSQJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 11:09:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjBSQJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 11:09:26 -0500
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C8BFF08
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 08:09:24 -0800 (PST)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-171dfaa208aso642092fac.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 08:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U8DH84LKaD917hUBncqWw/XridwiC/MLhQgA5LA3yEY=;
        b=cABMhkh9tj5IpY0BR82LmpJKi2ceNeL/U0Tzim/EVfbn2ldVTEoq5/s8z1WdYrztQ4
         WYDyPxggzoJiVIEL6L0U4nLJpnmZ6rmF2FoyDX1c5vtu2QybGAi+xDh7IjNRxdlXD86p
         oEujXZPbzUeLnO7U63MvAgJUVWOUCrXYKMr56o3aH8C0zrsweMeddRBMyJa66Q+GNrC4
         sn0zGAUSIKW7ZSAdnuV0a9Oejw+UCbEUjr/typkJD1XvVEdD3FQKJKHjNeX4z/CcCRLT
         6PkNrPGMAu0JuKFA7jl7pHyUwNn9eJi8ROnWYR9wgJYtyV3BLNM6xuY68wSQBgM+ME4t
         jguA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U8DH84LKaD917hUBncqWw/XridwiC/MLhQgA5LA3yEY=;
        b=M/z+oczF9n4gRdX6PER/mjwffCmhOV7+KV8RxJCacnPAbKvWC4s/wCBxuIKo99dPxV
         JOiUakVF48L/hXTSUBSsk8jHuXCjJNn0hWKlKoYnacqSKKG6m5pTUQoQt/SfZHt69kgi
         5aL8i96ACMSZ6KB/ompYmMiYFuRBtyapEp56s7RCeTWm2on3x0NBC91rg96y9D4Tv5Wa
         /i/RnFhA+Tjyrq50q0KwguUdN+L8B1MSVOgEm8P3Zft6dLubaxPdLeW18vE5r3/hrr8l
         99tvfOPg7JA6ccbEBgWsDImmFcroRnDSQcou0K9WEnm9v0IXSq9izZ2KPSLBfhUfKWS6
         Whmg==
X-Gm-Message-State: AO0yUKVA+rHHDsBZMD3dY/NyJmSiCDKp0sWVcwYTcLlPe2yTN5FLUm92
        btGLgbSxhPdtDXPdEraXwjHy+ZmvBJ6HfuckIG4=
X-Google-Smtp-Source: AK7set9LQvl/SiM6LgHO2wfkGc0m3ae20+NmBQLzB2//7NZwqE+WdO5q6dkMgnqoQVA3B0+jvn/iUMo6HLlWlbxJPN4=
X-Received: by 2002:a05:6870:32d4:b0:16e:5e5a:49da with SMTP id
 r20-20020a05687032d400b0016e5e5a49damr953721oac.58.1676822962981; Sun, 19 Feb
 2023 08:09:22 -0800 (PST)
MIME-Version: 1.0
References: <20230218211608.1630586-1-robdclark@gmail.com> <20230218211608.1630586-10-robdclark@gmail.com>
In-Reply-To: <20230218211608.1630586-10-robdclark@gmail.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Sun, 19 Feb 2023 08:09:43 -0800
Message-ID: <CAF6AEGtr8NmCkyX5qVEjZ21TNqUMdKQmXkK8Y73-K757L9=GOw@mail.gmail.com>
Subject: Re: [PATCH v4 09/14] drm/syncobj: Add deadline support for syncobj waits
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
        =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Simon Ser <contact@emersion.fr>,
        Rob Clark <robdclark@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
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

On Sat, Feb 18, 2023 at 1:16 PM Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> Add a new flag to let userspace provide a deadline as a hint for syncobj
> and timeline waits.  This gives a hint to the driver signaling the
> backing fences about how soon userspace needs it to compete work, so it
> can addjust GPU frequency accordingly.  An immediate deadline can be
> given to provide something equivalent to i915 "wait boost".
>
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>
> I'm a bit on the fence about the addition of the DRM_CAP, but it seems
> useful to give userspace a way to probe whether the kernel and driver
> supports the new wait flag, especially since we have vk-common code
> dealing with syncobjs.  But open to suggestions.

I guess an alternative would be to allow count_handles as a way to
probe the supported flags

BR,
-R

>  drivers/gpu/drm/drm_ioctl.c   |  3 ++
>  drivers/gpu/drm/drm_syncobj.c | 59 ++++++++++++++++++++++++++++-------
>  include/drm/drm_drv.h         |  6 ++++
>  include/uapi/drm/drm.h        | 16 ++++++++--
>  4 files changed, 71 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
> index 7c9d66ee917d..1c5c942cf0f9 100644
> --- a/drivers/gpu/drm/drm_ioctl.c
> +++ b/drivers/gpu/drm/drm_ioctl.c
> @@ -254,6 +254,9 @@ static int drm_getcap(struct drm_device *dev, void *data, struct drm_file *file_
>         case DRM_CAP_SYNCOBJ_TIMELINE:
>                 req->value = drm_core_check_feature(dev, DRIVER_SYNCOBJ_TIMELINE);
>                 return 0;
> +       case DRM_CAP_SYNCOBJ_DEADLINE:
> +               req->value = drm_core_check_feature(dev, DRIVER_SYNCOBJ_TIMELINE);
> +               return 0;
>         }
>
>         /* Other caps only work with KMS drivers */
> diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
> index 0c2be8360525..61cf97972a60 100644
> --- a/drivers/gpu/drm/drm_syncobj.c
> +++ b/drivers/gpu/drm/drm_syncobj.c
> @@ -973,7 +973,8 @@ static signed long drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
>                                                   uint32_t count,
>                                                   uint32_t flags,
>                                                   signed long timeout,
> -                                                 uint32_t *idx)
> +                                                 uint32_t *idx,
> +                                                 ktime_t *deadline)
>  {
>         struct syncobj_wait_entry *entries;
>         struct dma_fence *fence;
> @@ -1053,6 +1054,15 @@ static signed long drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
>                         drm_syncobj_fence_add_wait(syncobjs[i], &entries[i]);
>         }
>
> +       if (deadline) {
> +               for (i = 0; i < count; ++i) {
> +                       fence = entries[i].fence;
> +                       if (!fence)
> +                               continue;
> +                       dma_fence_set_deadline(fence, *deadline);
> +               }
> +       }
> +
>         do {
>                 set_current_state(TASK_INTERRUPTIBLE);
>
> @@ -1151,7 +1161,8 @@ static int drm_syncobj_array_wait(struct drm_device *dev,
>                                   struct drm_file *file_private,
>                                   struct drm_syncobj_wait *wait,
>                                   struct drm_syncobj_timeline_wait *timeline_wait,
> -                                 struct drm_syncobj **syncobjs, bool timeline)
> +                                 struct drm_syncobj **syncobjs, bool timeline,
> +                                 ktime_t *deadline)
>  {
>         signed long timeout = 0;
>         uint32_t first = ~0;
> @@ -1162,7 +1173,8 @@ static int drm_syncobj_array_wait(struct drm_device *dev,
>                                                          NULL,
>                                                          wait->count_handles,
>                                                          wait->flags,
> -                                                        timeout, &first);
> +                                                        timeout, &first,
> +                                                        deadline);
>                 if (timeout < 0)
>                         return timeout;
>                 wait->first_signaled = first;
> @@ -1172,7 +1184,8 @@ static int drm_syncobj_array_wait(struct drm_device *dev,
>                                                          u64_to_user_ptr(timeline_wait->points),
>                                                          timeline_wait->count_handles,
>                                                          timeline_wait->flags,
> -                                                        timeout, &first);
> +                                                        timeout, &first,
> +                                                        deadline);
>                 if (timeout < 0)
>                         return timeout;
>                 timeline_wait->first_signaled = first;
> @@ -1243,13 +1256,20 @@ drm_syncobj_wait_ioctl(struct drm_device *dev, void *data,
>  {
>         struct drm_syncobj_wait *args = data;
>         struct drm_syncobj **syncobjs;
> +       unsigned possible_flags;
> +       ktime_t t, *tp = NULL;
>         int ret = 0;
>
>         if (!drm_core_check_feature(dev, DRIVER_SYNCOBJ))
>                 return -EOPNOTSUPP;
>
> -       if (args->flags & ~(DRM_SYNCOBJ_WAIT_FLAGS_WAIT_ALL |
> -                           DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT))
> +       possible_flags = DRM_SYNCOBJ_WAIT_FLAGS_WAIT_ALL |
> +                        DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT;
> +
> +       if (drm_core_check_feature(dev, DRIVER_SYNCOBJ_DEADLINE))
> +               possible_flags |= DRM_SYNCOBJ_WAIT_FLAGS_WAIT_DEADLINE;
> +
> +       if (args->flags & ~possible_flags)
>                 return -EINVAL;
>
>         if (args->count_handles == 0)
> @@ -1262,8 +1282,13 @@ drm_syncobj_wait_ioctl(struct drm_device *dev, void *data,
>         if (ret < 0)
>                 return ret;
>
> +       if (args->flags & DRM_SYNCOBJ_WAIT_FLAGS_WAIT_DEADLINE) {
> +               t = ktime_set(args->deadline_sec, args->deadline_nsec);
> +               tp = &t;
> +       }
> +
>         ret = drm_syncobj_array_wait(dev, file_private,
> -                                    args, NULL, syncobjs, false);
> +                                    args, NULL, syncobjs, false, tp);
>
>         drm_syncobj_array_free(syncobjs, args->count_handles);
>
> @@ -1276,14 +1301,21 @@ drm_syncobj_timeline_wait_ioctl(struct drm_device *dev, void *data,
>  {
>         struct drm_syncobj_timeline_wait *args = data;
>         struct drm_syncobj **syncobjs;
> +       unsigned possible_flags;
> +       ktime_t t, *tp = NULL;
>         int ret = 0;
>
>         if (!drm_core_check_feature(dev, DRIVER_SYNCOBJ_TIMELINE))
>                 return -EOPNOTSUPP;
>
> -       if (args->flags & ~(DRM_SYNCOBJ_WAIT_FLAGS_WAIT_ALL |
> -                           DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT |
> -                           DRM_SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE))
> +       possible_flags = DRM_SYNCOBJ_WAIT_FLAGS_WAIT_ALL |
> +                        DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT |
> +                        DRM_SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE;
> +
> +       if (drm_core_check_feature(dev, DRIVER_SYNCOBJ_DEADLINE))
> +               possible_flags |= DRM_SYNCOBJ_WAIT_FLAGS_WAIT_DEADLINE;
> +
> +       if (args->flags & ~possible_flags)
>                 return -EINVAL;
>
>         if (args->count_handles == 0)
> @@ -1296,8 +1328,13 @@ drm_syncobj_timeline_wait_ioctl(struct drm_device *dev, void *data,
>         if (ret < 0)
>                 return ret;
>
> +       if (args->flags & DRM_SYNCOBJ_WAIT_FLAGS_WAIT_DEADLINE) {
> +               t = ktime_set(args->deadline_sec, args->deadline_nsec);
> +               tp = &t;
> +       }
> +
>         ret = drm_syncobj_array_wait(dev, file_private,
> -                                    NULL, args, syncobjs, true);
> +                                    NULL, args, syncobjs, true, tp);
>
>         drm_syncobj_array_free(syncobjs, args->count_handles);
>
> diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
> index 1d76d0686b03..9aa24f097e22 100644
> --- a/include/drm/drm_drv.h
> +++ b/include/drm/drm_drv.h
> @@ -104,6 +104,12 @@ enum drm_driver_feature {
>          * acceleration should be handled by two drivers that are connected using auxiliary bus.
>          */
>         DRIVER_COMPUTE_ACCEL            = BIT(7),
> +       /**
> +        * @DRIVER_SYNCOBJ_DEADLINE:
> +        *
> +        * Driver supports &dma_fence_ops.set_deadline
> +        */
> +       DRIVER_SYNCOBJ_DEADLINE         = BIT(8),
>
>         /* IMPORTANT: Below are all the legacy flags, add new ones above. */
>
> diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
> index 642808520d92..c6b85bb13810 100644
> --- a/include/uapi/drm/drm.h
> +++ b/include/uapi/drm/drm.h
> @@ -767,6 +767,13 @@ struct drm_gem_open {
>   * Documentation/gpu/drm-mm.rst, section "DRM Sync Objects".
>   */
>  #define DRM_CAP_SYNCOBJ_TIMELINE       0x14
> +/**
> + * DRM_CAP_SYNCOBJ_DEADLINE
> + *
> + * If set to 1, the driver supports DRM_SYNCOBJ_WAIT_FLAGS_WAIT_DEADLINE flag
> + * on the SYNCOBJ_TIMELINE_WAIT/SYNCOBJ_WAIT ioctls.
> + */
> +#define DRM_CAP_SYNCOBJ_DEADLINE       0x15
>
>  /* DRM_IOCTL_GET_CAP ioctl argument type */
>  struct drm_get_cap {
> @@ -887,6 +894,7 @@ struct drm_syncobj_transfer {
>  #define DRM_SYNCOBJ_WAIT_FLAGS_WAIT_ALL (1 << 0)
>  #define DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT (1 << 1)
>  #define DRM_SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE (1 << 2) /* wait for time point to become available */
> +#define DRM_SYNCOBJ_WAIT_FLAGS_WAIT_DEADLINE (1 << 3) /* set fence deadline based to deadline_nsec/sec */
>  struct drm_syncobj_wait {
>         __u64 handles;
>         /* absolute timeout */
> @@ -894,7 +902,9 @@ struct drm_syncobj_wait {
>         __u32 count_handles;
>         __u32 flags;
>         __u32 first_signaled; /* only valid when not waiting all */
> -       __u32 pad;
> +       /* Deadline to set on backing fence(s) in CLOCK_MONOTONIC: */
> +       __u32 deadline_nsec;
> +       __u64 deadline_sec;
>  };
>
>  struct drm_syncobj_timeline_wait {
> @@ -906,7 +916,9 @@ struct drm_syncobj_timeline_wait {
>         __u32 count_handles;
>         __u32 flags;
>         __u32 first_signaled; /* only valid when not waiting all */
> -       __u32 pad;
> +       /* Deadline to set on backing fence(s) in CLOCK_MONOTONIC: */
> +       __u32 deadline_nsec;
> +       __u64 deadline_sec;
>  };
>
>
> --
> 2.39.1
>
