Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21326BF1CB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 20:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjCQTii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 15:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjCQTig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 15:38:36 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766F948E2E
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 12:38:34 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-176261d7f45so6788585fac.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 12:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679081913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g4CRQW5pF6Xx0toKLDpXgqayNx8cYo+HEUQnJtr2Bps=;
        b=V1FnTrEDvrmXooPxB9BFOFCSWeFA3PtHSqlkjo3B/kgdwP55lAHlbXCarz0wrLHewv
         2zD8JslNGzIuuGMggdw0yQCXPJEpioP7O/1ukOSfEUq74v7a1J8AJoXNsl8t6GOgcUag
         6DCSJdrSQtnwyYdU1AhxYv61LIxrTvbm2r0Pq1JFTFBlexf9kBPjlqC25c08RPqSzcCg
         LvrlapBm0HRhqfM2MBcKzOmqOGLsGY36asurvz2OlJefE5wDaET4HwD9wo2GUSepQeIm
         zoiAaNv4syW2StXWCw4oqyP09CY2LtVhfq3TVEfMIt6+cI4DaMAev5aAT+hWpUfgbKCU
         9PLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679081913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g4CRQW5pF6Xx0toKLDpXgqayNx8cYo+HEUQnJtr2Bps=;
        b=m1lMNVdDZuzltwc/QqaBQ3dwhh+Z2I+Gnmg++x35ytOpT9oZj6OAYc+hPxlUODdEL1
         9JsYBE9ad6XJRYVGu7zv9e/3Dgc/FgvBAddMXdYG4yVoSFKQmzT5VRIn4e6/97X4YDtf
         m0svnPAKX7/gJSEHD0WsskPjzk6Q3E6EtziZr97SfI5pPyP50c6Y3KEdNGfHb+2gE18m
         W2WT3YET2MhCSUs12yRZy9mRWKKr1cVSkHiv3OSQ+ceXOLGvcdTB6kNlGDWBk85nwQ5A
         x+BcurmPrJbEYHpMyV6V3AzDE27/hN8FfY9kf3w5yOghUbRefeXUSEE1DoRjcLwWy7C1
         5ldw==
X-Gm-Message-State: AO0yUKWMUrmu3F4fm7m8SX73aoz3iHioXp5R720vj4LcFb7hKYRcxEc2
        SQvqO/9rs1rs3EYJCVVYSRmX7R/ZlIeunzYyY3c=
X-Google-Smtp-Source: AK7set8HTaL1eqc4hBHnhHOUeVdf6WbJQVjDF98pwXR1E4FskcwcsCC/FpTAIQOgS8D203EVYEsr5r2haK6MFrcmjus=
X-Received: by 2002:a05:6870:df8c:b0:176:3897:6928 with SMTP id
 us12-20020a056870df8c00b0017638976928mr263980oab.5.1679081913684; Fri, 17 Mar
 2023 12:38:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230308155322.344664-1-robdclark@gmail.com> <20230308155322.344664-10-robdclark@gmail.com>
 <CAOFGe944_xJOJ3a-uJDVyca_1_+aYTqat4=Qc3CC1wUubxw3XQ@mail.gmail.com>
In-Reply-To: <CAOFGe944_xJOJ3a-uJDVyca_1_+aYTqat4=Qc3CC1wUubxw3XQ@mail.gmail.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Fri, 17 Mar 2023 12:38:22 -0700
Message-ID: <CAF6AEGv5Bo6sbT+en7=C+QG9+m+Wn0gauQ1qhdzBv6AEkChu7A@mail.gmail.com>
Subject: Re: [Intel-gfx] [PATCH v10 09/15] drm/syncobj: Add deadline support
 for syncobj waits
To:     Faith Ekstrand <faith@gfxstrand.net>
Cc:     dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
        intel-gfx@lists.freedesktop.org,
        Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        open list <linux-kernel@vger.kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Matt Turner <mattst88@gmail.com>,
        freedreno@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023 at 12:08=E2=80=AFPM Faith Ekstrand <faith@gfxstrand.ne=
t> wrote:
>
>
> On Wed, Mar 8, 2023 at 9:54=E2=80=AFAM Rob Clark <robdclark@gmail.com> wr=
ote:
>>
>> From: Rob Clark <robdclark@chromium.org>
>>
>> Add a new flag to let userspace provide a deadline as a hint for syncobj
>> and timeline waits.  This gives a hint to the driver signaling the
>> backing fences about how soon userspace needs it to compete work, so it
>> can addjust GPU frequency accordingly.  An immediate deadline can be
>> given to provide something equivalent to i915 "wait boost".
>>
>> v2: Use absolute u64 ns value for deadline hint, drop cap and driver
>>     feature flag in favor of allowing count_handles=3D=3D0 as a way for
>>     userspace to probe kernel for support of new flag
>> v3: More verbose comments about UAPI
>>
>> Signed-off-by: Rob Clark <robdclark@chromium.org>
>> ---
>>  drivers/gpu/drm/drm_syncobj.c | 64 ++++++++++++++++++++++++++++-------
>>  include/uapi/drm/drm.h        | 17 ++++++++++
>>  2 files changed, 68 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj=
.c
>> index 0c2be8360525..a85e9464f07b 100644
>> --- a/drivers/gpu/drm/drm_syncobj.c
>> +++ b/drivers/gpu/drm/drm_syncobj.c
>> @@ -126,6 +126,11 @@
>>   * synchronize between the two.
>>   * This requirement is inherited from the Vulkan fence API.
>>   *
>> + * If &DRM_SYNCOBJ_WAIT_FLAGS_WAIT_DEADLINE is set, the ioctl will also=
 set
>> + * a fence deadline hint on the backing fences before waiting, to provi=
de the
>> + * fence signaler with an appropriate sense of urgency.  The deadline i=
s
>> + * specified as an absolute &CLOCK_MONOTONIC value in units of ns.
>> + *
>>   * Similarly, &DRM_IOCTL_SYNCOBJ_TIMELINE_WAIT takes an array of syncob=
j
>>   * handles as well as an array of u64 points and does a host-side wait =
on all
>>   * of syncobj fences at the given points simultaneously.
>> @@ -973,7 +978,8 @@ static signed long drm_syncobj_array_wait_timeout(st=
ruct drm_syncobj **syncobjs,
>>                                                   uint32_t count,
>>                                                   uint32_t flags,
>>                                                   signed long timeout,
>> -                                                 uint32_t *idx)
>> +                                                 uint32_t *idx,
>> +                                                 ktime_t *deadline)
>>  {
>>         struct syncobj_wait_entry *entries;
>>         struct dma_fence *fence;
>> @@ -1053,6 +1059,15 @@ static signed long drm_syncobj_array_wait_timeout=
(struct drm_syncobj **syncobjs,
>>                         drm_syncobj_fence_add_wait(syncobjs[i], &entries=
[i]);
>>         }
>>
>> +       if (deadline) {
>> +               for (i =3D 0; i < count; ++i) {
>> +                       fence =3D entries[i].fence;
>> +                       if (!fence)
>> +                               continue;
>> +                       dma_fence_set_deadline(fence, *deadline);
>> +               }
>> +       }
>> +
>>         do {
>>                 set_current_state(TASK_INTERRUPTIBLE);
>>
>> @@ -1151,7 +1166,8 @@ static int drm_syncobj_array_wait(struct drm_devic=
e *dev,
>>                                   struct drm_file *file_private,
>>                                   struct drm_syncobj_wait *wait,
>>                                   struct drm_syncobj_timeline_wait *time=
line_wait,
>> -                                 struct drm_syncobj **syncobjs, bool ti=
meline)
>> +                                 struct drm_syncobj **syncobjs, bool ti=
meline,
>> +                                 ktime_t *deadline)
>>  {
>>         signed long timeout =3D 0;
>>         uint32_t first =3D ~0;
>> @@ -1162,7 +1178,8 @@ static int drm_syncobj_array_wait(struct drm_devic=
e *dev,
>>                                                          NULL,
>>                                                          wait->count_han=
dles,
>>                                                          wait->flags,
>> -                                                        timeout, &first=
);
>> +                                                        timeout, &first=
,
>> +                                                        deadline);
>>                 if (timeout < 0)
>>                         return timeout;
>>                 wait->first_signaled =3D first;
>> @@ -1172,7 +1189,8 @@ static int drm_syncobj_array_wait(struct drm_devic=
e *dev,
>>                                                          u64_to_user_ptr=
(timeline_wait->points),
>>                                                          timeline_wait->=
count_handles,
>>                                                          timeline_wait->=
flags,
>> -                                                        timeout, &first=
);
>> +                                                        timeout, &first=
,
>> +                                                        deadline);
>>                 if (timeout < 0)
>>                         return timeout;
>>                 timeline_wait->first_signaled =3D first;
>> @@ -1243,17 +1261,22 @@ drm_syncobj_wait_ioctl(struct drm_device *dev, v=
oid *data,
>>  {
>>         struct drm_syncobj_wait *args =3D data;
>>         struct drm_syncobj **syncobjs;
>> +       unsigned possible_flags;
>> +       ktime_t t, *tp =3D NULL;
>>         int ret =3D 0;
>>
>>         if (!drm_core_check_feature(dev, DRIVER_SYNCOBJ))
>>                 return -EOPNOTSUPP;
>>
>> -       if (args->flags & ~(DRM_SYNCOBJ_WAIT_FLAGS_WAIT_ALL |
>> -                           DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT))
>> +       possible_flags =3D DRM_SYNCOBJ_WAIT_FLAGS_WAIT_ALL |
>> +                        DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT |
>> +                        DRM_SYNCOBJ_WAIT_FLAGS_WAIT_DEADLINE;
>> +
>> +       if (args->flags & ~possible_flags)
>>                 return -EINVAL;
>>
>>         if (args->count_handles =3D=3D 0)
>> -               return -EINVAL;
>> +               return 0;
>
>
> Did you intend this change? If so, why? What does waiting with no handles=
 gain us? I mean, it's probably fine but it seems unrelated to this change.

Yes, it was intentional.. it gives userspace a way to probe whether
the kernel supports the new flag..

BR,
-R

>>         ret =3D drm_syncobj_array_find(file_private,
>>                                      u64_to_user_ptr(args->handles),
>> @@ -1262,8 +1285,13 @@ drm_syncobj_wait_ioctl(struct drm_device *dev, vo=
id *data,
>>         if (ret < 0)
>>                 return ret;
>>
>> +       if (args->flags & DRM_SYNCOBJ_WAIT_FLAGS_WAIT_DEADLINE) {
>> +               t =3D ns_to_ktime(args->deadline_ns);
>> +               tp =3D &t;
>> +       }
>> +
>>         ret =3D drm_syncobj_array_wait(dev, file_private,
>> -                                    args, NULL, syncobjs, false);
>> +                                    args, NULL, syncobjs, false, tp);
>>
>>         drm_syncobj_array_free(syncobjs, args->count_handles);
>>
>> @@ -1276,18 +1304,23 @@ drm_syncobj_timeline_wait_ioctl(struct drm_devic=
e *dev, void *data,
>>  {
>>         struct drm_syncobj_timeline_wait *args =3D data;
>>         struct drm_syncobj **syncobjs;
>> +       unsigned possible_flags;
>> +       ktime_t t, *tp =3D NULL;
>>         int ret =3D 0;
>>
>>         if (!drm_core_check_feature(dev, DRIVER_SYNCOBJ_TIMELINE))
>>                 return -EOPNOTSUPP;
>>
>> -       if (args->flags & ~(DRM_SYNCOBJ_WAIT_FLAGS_WAIT_ALL |
>> -                           DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT |
>> -                           DRM_SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE))
>> +       possible_flags =3D DRM_SYNCOBJ_WAIT_FLAGS_WAIT_ALL |
>> +                        DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT |
>> +                        DRM_SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE |
>> +                        DRM_SYNCOBJ_WAIT_FLAGS_WAIT_DEADLINE;
>> +
>> +       if (args->flags & ~possible_flags)
>>                 return -EINVAL;
>>
>>         if (args->count_handles =3D=3D 0)
>> -               return -EINVAL;
>> +               return -0;
>
>
> Did you intend this change? -0 is a pretty weird integer.
>
>>
>>         ret =3D drm_syncobj_array_find(file_private,
>>                                      u64_to_user_ptr(args->handles),
>> @@ -1296,8 +1329,13 @@ drm_syncobj_timeline_wait_ioctl(struct drm_device=
 *dev, void *data,
>>         if (ret < 0)
>>                 return ret;
>>
>> +       if (args->flags & DRM_SYNCOBJ_WAIT_FLAGS_WAIT_DEADLINE) {
>> +               t =3D ns_to_ktime(args->deadline_ns);
>> +               tp =3D &t;
>> +       }
>> +
>>         ret =3D drm_syncobj_array_wait(dev, file_private,
>> -                                    NULL, args, syncobjs, true);
>> +                                    NULL, args, syncobjs, true, tp);
>>
>>         drm_syncobj_array_free(syncobjs, args->count_handles);
>>
>> diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
>> index 642808520d92..bff0509ac8b6 100644
>> --- a/include/uapi/drm/drm.h
>> +++ b/include/uapi/drm/drm.h
>> @@ -887,6 +887,7 @@ struct drm_syncobj_transfer {
>>  #define DRM_SYNCOBJ_WAIT_FLAGS_WAIT_ALL (1 << 0)
>>  #define DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT (1 << 1)
>>  #define DRM_SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE (1 << 2) /* wait for time=
 point to become available */
>> +#define DRM_SYNCOBJ_WAIT_FLAGS_WAIT_DEADLINE (1 << 3) /* set fence dead=
line based to deadline_ns */
>>  struct drm_syncobj_wait {
>>         __u64 handles;
>>         /* absolute timeout */
>> @@ -895,6 +896,14 @@ struct drm_syncobj_wait {
>>         __u32 flags;
>>         __u32 first_signaled; /* only valid when not waiting all */
>>         __u32 pad;
>> +       /**
>> +        * @deadline_ns - fence deadline hint
>> +        *
>> +        * Deadline hint, in absolute CLOCK_MONOTONIC, to set on backing
>> +        * fence(s) if the DRM_SYNCOBJ_WAIT_FLAGS_WAIT_DEADLINE flag is
>> +        * set.
>> +        */
>> +       __u64 deadline_ns;
>>  };
>>
>>  struct drm_syncobj_timeline_wait {
>> @@ -907,6 +916,14 @@ struct drm_syncobj_timeline_wait {
>>         __u32 flags;
>>         __u32 first_signaled; /* only valid when not waiting all */
>>         __u32 pad;
>> +       /**
>> +        * @deadline_ns - fence deadline hint
>> +        *
>> +        * Deadline hint, in absolute CLOCK_MONOTONIC, to set on backing
>> +        * fence(s) if the DRM_SYNCOBJ_WAIT_FLAGS_WAIT_DEADLINE flag is
>> +        * set.
>> +        */
>> +       __u64 deadline_ns;
>>  };
>>
>>
>> --
>> 2.39.2
>>
