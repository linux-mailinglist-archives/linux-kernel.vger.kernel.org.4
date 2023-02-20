Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA1F69D13E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 17:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbjBTQUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 11:20:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBTQUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 11:20:15 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE913596
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 08:20:14 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-17213c961dfso1377239fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 08:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/0p3LPNhbtXZVHQ0KXCbO4t7UGZG8cqmR73L2JPywN8=;
        b=llJs2UEq4nJ44+iP6g74zAtfuY+X6AqSOFJ4K3RGSYpANyPZeIh12hkcIJPp8DsFfr
         PxynjMHjio2tPN4V/uPpmbQ9BOpMoFg0oMNc1nm+AxSa7s4rWhAA3vJJs4bWI9NVmpdn
         P+LKvQDeUan+wViUn73qnXAstjRq7dLwhn6nb4Ioqz8I89YPBnhLbbg95x5iYU6zr9Lp
         23crzFiT6+mQVkxoOHsS3pb9SLv/25qXXxLt2f2Ul8cApOuLy2J7aHW0fFsmjXL23ISf
         Fgp3R5acGJVAT4mGwO4Vq8cXR1r9lqZSuMpUtIxhI6IZPXNg5wvPo8C0/N0jm6MufeXa
         P8yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/0p3LPNhbtXZVHQ0KXCbO4t7UGZG8cqmR73L2JPywN8=;
        b=p1Jc7anaNvJ2CqHhR44exVFojs8zi3UXE0iFPa1juRgGkKDr9OF7aEdJ1k5+AVVfas
         IVTuA6Po+VkfQtro8zfAX+yVC027lYkMMnUjix4MdHhvU/patvyHETbaU02F/Z8EgS8K
         Ri4J/uV6yMIYfi9v0s2htnZe9Zo/B7l24FMkGzDMs0IjcjRZq11wa7tHYtbQK+fRpt39
         UvFbHVQ/YjtgvCgtmDagVwKi+4KEwfNhJh+Fk1xnBF+2/L5zPSXFEUchXACDC3NVm/IU
         soos1PN5MX9+YfZzPhEV6d0qWS4GzrtWVSRhO2OKyvV7bIoVrv3X1q2HVO43YGQjz8mn
         0kpA==
X-Gm-Message-State: AO0yUKUXtiW2QqnggASBqC3St6nEbMKE4g9FFhCxeVsFP/Nz8qL3pr95
        sEmME3cLHVuKBRdKfwHDc+DiRKELyAeS9Q3hxtg=
X-Google-Smtp-Source: AK7set/ced+CJ00blev+IgUMPb1g6skEoqdRVPsy6UHvrTHEkAn+0CO4cRQwHrbFrsQy/CV1Ds+no98BIMQEZo4oSMg=
X-Received: by 2002:a05:6870:32d4:b0:16e:5e5a:49da with SMTP id
 r20-20020a05687032d400b0016e5e5a49damr1187270oac.58.1676910013598; Mon, 20
 Feb 2023 08:20:13 -0800 (PST)
MIME-Version: 1.0
References: <20230218211608.1630586-1-robdclark@gmail.com> <20230218211608.1630586-10-robdclark@gmail.com>
 <20230220110553.47ecd504@eldfell>
In-Reply-To: <20230220110553.47ecd504@eldfell>
From:   Rob Clark <robdclark@gmail.com>
Date:   Mon, 20 Feb 2023 08:20:03 -0800
Message-ID: <CAF6AEGt0xZavULWDfKfeNA1Ysb9gwdcGSDW-hVB0vLxTzEXK1w@mail.gmail.com>
Subject: Re: [PATCH v4 09/14] drm/syncobj: Add deadline support for syncobj waits
To:     Pekka Paalanen <ppaalanen@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
        =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
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

On Mon, Feb 20, 2023 at 1:05 AM Pekka Paalanen <ppaalanen@gmail.com> wrote:
>
> On Sat, 18 Feb 2023 13:15:52 -0800
> Rob Clark <robdclark@gmail.com> wrote:
>
> > From: Rob Clark <robdclark@chromium.org>
> >
> > Add a new flag to let userspace provide a deadline as a hint for syncobj
> > and timeline waits.  This gives a hint to the driver signaling the
> > backing fences about how soon userspace needs it to compete work, so it
> > can addjust GPU frequency accordingly.  An immediate deadline can be
> > given to provide something equivalent to i915 "wait boost".
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> >
> > I'm a bit on the fence about the addition of the DRM_CAP, but it seems
> > useful to give userspace a way to probe whether the kernel and driver
> > supports the new wait flag, especially since we have vk-common code
> > dealing with syncobjs.  But open to suggestions.
> >
> >  drivers/gpu/drm/drm_ioctl.c   |  3 ++
> >  drivers/gpu/drm/drm_syncobj.c | 59 ++++++++++++++++++++++++++++-------
> >  include/drm/drm_drv.h         |  6 ++++
> >  include/uapi/drm/drm.h        | 16 ++++++++--
> >  4 files changed, 71 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
> > index 7c9d66ee917d..1c5c942cf0f9 100644
> > --- a/drivers/gpu/drm/drm_ioctl.c
> > +++ b/drivers/gpu/drm/drm_ioctl.c
> > @@ -254,6 +254,9 @@ static int drm_getcap(struct drm_device *dev, void *data, struct drm_file *file_
> >       case DRM_CAP_SYNCOBJ_TIMELINE:
> >               req->value = drm_core_check_feature(dev, DRIVER_SYNCOBJ_TIMELINE);
> >               return 0;
> > +     case DRM_CAP_SYNCOBJ_DEADLINE:
> > +             req->value = drm_core_check_feature(dev, DRIVER_SYNCOBJ_TIMELINE);
>
> Hi,
>
> is that a typo for DRIVER_SYNCOBJ_DEADLINE?

Ahh, yes, that is a typo.. but I'm thinking of dropping the cap and
allowing count_handles==0 instead as a way for userspace to probe
whether the kernel supports the new ioctl flag/fields.

> > +             return 0;
> >       }
> >
> >       /* Other caps only work with KMS drivers */
> > diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
> > index 0c2be8360525..61cf97972a60 100644
> > --- a/drivers/gpu/drm/drm_syncobj.c
> > +++ b/drivers/gpu/drm/drm_syncobj.c
> > @@ -973,7 +973,8 @@ static signed long drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
> >                                                 uint32_t count,
> >                                                 uint32_t flags,
> >                                                 signed long timeout,
> > -                                               uint32_t *idx)
> > +                                               uint32_t *idx,
> > +                                               ktime_t *deadline)
> >  {
> >       struct syncobj_wait_entry *entries;
> >       struct dma_fence *fence;
> > @@ -1053,6 +1054,15 @@ static signed long drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
> >                       drm_syncobj_fence_add_wait(syncobjs[i], &entries[i]);
> >       }
> >
> > +     if (deadline) {
> > +             for (i = 0; i < count; ++i) {
> > +                     fence = entries[i].fence;
> > +                     if (!fence)
> > +                             continue;
> > +                     dma_fence_set_deadline(fence, *deadline);
> > +             }
> > +     }
> > +
> >       do {
> >               set_current_state(TASK_INTERRUPTIBLE);
> >
> > @@ -1151,7 +1161,8 @@ static int drm_syncobj_array_wait(struct drm_device *dev,
> >                                 struct drm_file *file_private,
> >                                 struct drm_syncobj_wait *wait,
> >                                 struct drm_syncobj_timeline_wait *timeline_wait,
> > -                               struct drm_syncobj **syncobjs, bool timeline)
> > +                               struct drm_syncobj **syncobjs, bool timeline,
> > +                               ktime_t *deadline)
> >  {
> >       signed long timeout = 0;
> >       uint32_t first = ~0;
> > @@ -1162,7 +1173,8 @@ static int drm_syncobj_array_wait(struct drm_device *dev,
> >                                                        NULL,
> >                                                        wait->count_handles,
> >                                                        wait->flags,
> > -                                                      timeout, &first);
> > +                                                      timeout, &first,
> > +                                                      deadline);
> >               if (timeout < 0)
> >                       return timeout;
> >               wait->first_signaled = first;
> > @@ -1172,7 +1184,8 @@ static int drm_syncobj_array_wait(struct drm_device *dev,
> >                                                        u64_to_user_ptr(timeline_wait->points),
> >                                                        timeline_wait->count_handles,
> >                                                        timeline_wait->flags,
> > -                                                      timeout, &first);
> > +                                                      timeout, &first,
> > +                                                      deadline);
> >               if (timeout < 0)
> >                       return timeout;
> >               timeline_wait->first_signaled = first;
> > @@ -1243,13 +1256,20 @@ drm_syncobj_wait_ioctl(struct drm_device *dev, void *data,
> >  {
> >       struct drm_syncobj_wait *args = data;
> >       struct drm_syncobj **syncobjs;
> > +     unsigned possible_flags;
> > +     ktime_t t, *tp = NULL;
> >       int ret = 0;
> >
> >       if (!drm_core_check_feature(dev, DRIVER_SYNCOBJ))
> >               return -EOPNOTSUPP;
> >
> > -     if (args->flags & ~(DRM_SYNCOBJ_WAIT_FLAGS_WAIT_ALL |
> > -                         DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT))
> > +     possible_flags = DRM_SYNCOBJ_WAIT_FLAGS_WAIT_ALL |
> > +                      DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT;
> > +
> > +     if (drm_core_check_feature(dev, DRIVER_SYNCOBJ_DEADLINE))
> > +             possible_flags |= DRM_SYNCOBJ_WAIT_FLAGS_WAIT_DEADLINE;
> > +
> > +     if (args->flags & ~possible_flags)
> >               return -EINVAL;
> >
> >       if (args->count_handles == 0)
> > @@ -1262,8 +1282,13 @@ drm_syncobj_wait_ioctl(struct drm_device *dev, void *data,
> >       if (ret < 0)
> >               return ret;
> >
> > +     if (args->flags & DRM_SYNCOBJ_WAIT_FLAGS_WAIT_DEADLINE) {
> > +             t = ktime_set(args->deadline_sec, args->deadline_nsec);
> > +             tp = &t;
> > +     }
> > +
> >       ret = drm_syncobj_array_wait(dev, file_private,
> > -                                  args, NULL, syncobjs, false);
> > +                                  args, NULL, syncobjs, false, tp);
> >
> >       drm_syncobj_array_free(syncobjs, args->count_handles);
> >
> > @@ -1276,14 +1301,21 @@ drm_syncobj_timeline_wait_ioctl(struct drm_device *dev, void *data,
> >  {
> >       struct drm_syncobj_timeline_wait *args = data;
> >       struct drm_syncobj **syncobjs;
> > +     unsigned possible_flags;
> > +     ktime_t t, *tp = NULL;
> >       int ret = 0;
> >
> >       if (!drm_core_check_feature(dev, DRIVER_SYNCOBJ_TIMELINE))
> >               return -EOPNOTSUPP;
> >
> > -     if (args->flags & ~(DRM_SYNCOBJ_WAIT_FLAGS_WAIT_ALL |
> > -                         DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT |
> > -                         DRM_SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE))
> > +     possible_flags = DRM_SYNCOBJ_WAIT_FLAGS_WAIT_ALL |
> > +                      DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT |
> > +                      DRM_SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE;
> > +
> > +     if (drm_core_check_feature(dev, DRIVER_SYNCOBJ_DEADLINE))
> > +             possible_flags |= DRM_SYNCOBJ_WAIT_FLAGS_WAIT_DEADLINE;
> > +
> > +     if (args->flags & ~possible_flags)
> >               return -EINVAL;
> >
> >       if (args->count_handles == 0)
> > @@ -1296,8 +1328,13 @@ drm_syncobj_timeline_wait_ioctl(struct drm_device *dev, void *data,
> >       if (ret < 0)
> >               return ret;
> >
> > +     if (args->flags & DRM_SYNCOBJ_WAIT_FLAGS_WAIT_DEADLINE) {
> > +             t = ktime_set(args->deadline_sec, args->deadline_nsec);
> > +             tp = &t;
> > +     }
> > +
> >       ret = drm_syncobj_array_wait(dev, file_private,
> > -                                  NULL, args, syncobjs, true);
> > +                                  NULL, args, syncobjs, true, tp);
> >
> >       drm_syncobj_array_free(syncobjs, args->count_handles);
> >
> > diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
> > index 1d76d0686b03..9aa24f097e22 100644
> > --- a/include/drm/drm_drv.h
> > +++ b/include/drm/drm_drv.h
> > @@ -104,6 +104,12 @@ enum drm_driver_feature {
> >        * acceleration should be handled by two drivers that are connected using auxiliary bus.
> >        */
> >       DRIVER_COMPUTE_ACCEL            = BIT(7),
> > +     /**
> > +      * @DRIVER_SYNCOBJ_DEADLINE:
> > +      *
> > +      * Driver supports &dma_fence_ops.set_deadline
> > +      */
> > +     DRIVER_SYNCOBJ_DEADLINE         = BIT(8),
> >
> >       /* IMPORTANT: Below are all the legacy flags, add new ones above. */
> >
> > diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
> > index 642808520d92..c6b85bb13810 100644
> > --- a/include/uapi/drm/drm.h
> > +++ b/include/uapi/drm/drm.h
> > @@ -767,6 +767,13 @@ struct drm_gem_open {
> >   * Documentation/gpu/drm-mm.rst, section "DRM Sync Objects".
> >   */
> >  #define DRM_CAP_SYNCOBJ_TIMELINE     0x14
> > +/**
> > + * DRM_CAP_SYNCOBJ_DEADLINE
> > + *
> > + * If set to 1, the driver supports DRM_SYNCOBJ_WAIT_FLAGS_WAIT_DEADLINE flag
> > + * on the SYNCOBJ_TIMELINE_WAIT/SYNCOBJ_WAIT ioctls.
> > + */
> > +#define DRM_CAP_SYNCOBJ_DEADLINE     0x15
> >
> >  /* DRM_IOCTL_GET_CAP ioctl argument type */
> >  struct drm_get_cap {
> > @@ -887,6 +894,7 @@ struct drm_syncobj_transfer {
> >  #define DRM_SYNCOBJ_WAIT_FLAGS_WAIT_ALL (1 << 0)
> >  #define DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT (1 << 1)
> >  #define DRM_SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE (1 << 2) /* wait for time point to become available */
> > +#define DRM_SYNCOBJ_WAIT_FLAGS_WAIT_DEADLINE (1 << 3) /* set fence deadline based to deadline_nsec/sec */
>
> Where was the UAPI documentation explaining what a fence deadline is
> and what it does, again?
>
> >  struct drm_syncobj_wait {
> >       __u64 handles;
> >       /* absolute timeout */
> > @@ -894,7 +902,9 @@ struct drm_syncobj_wait {
> >       __u32 count_handles;
> >       __u32 flags;
> >       __u32 first_signaled; /* only valid when not waiting all */
> > -     __u32 pad;
> > +     /* Deadline to set on backing fence(s) in CLOCK_MONOTONIC: */
> > +     __u32 deadline_nsec;
> > +     __u64 deadline_sec;
> >  };
> >
> >  struct drm_syncobj_timeline_wait {
> > @@ -906,7 +916,9 @@ struct drm_syncobj_timeline_wait {
> >       __u32 count_handles;
> >       __u32 flags;
> >       __u32 first_signaled; /* only valid when not waiting all */
> > -     __u32 pad;
> > +     /* Deadline to set on backing fence(s) in CLOCK_MONOTONIC: */
> > +     __u32 deadline_nsec;
> > +     __u64 deadline_sec;
> >  };
>
> It seems inconsistent that these sec,nsec are here unsigned, when in
> other places they are signed. There is also the question if these need
> to meet clock_settime() requirements of valid values.
>

Yes, should have been signed.  But I think Christian has convinced me
to use 'u64 ns' (absolute monotonic) instead for the sync_file ioctl.
And it would make sense to use the same here.

BR,
-R

>
> Thanks,
> pq
