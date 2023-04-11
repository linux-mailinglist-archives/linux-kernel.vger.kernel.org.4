Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1456DDEC4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 17:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjDKPDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 11:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjDKPCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 11:02:41 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317A45591;
        Tue, 11 Apr 2023 08:02:22 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id w13so26206644oik.2;
        Tue, 11 Apr 2023 08:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681225341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2WJpgC9tCR8udl5BovYzFlcONxJeVE/qdJ1S1reXt5E=;
        b=VsL3u5pOE/5IW3p3ulEMJtpEvaImLs5+xtOp2Gxms1RMPA9RVBx5/L8A+UefiuApt1
         x7bVqF2L8QNuiYODEVADMlCaVMntM/anO13q5izgGfJnMTY8U7P6I5aK+oDgitnOBaEh
         qmFVeCdTutHisXuxKmbW6LXKQkpdH4j3B7twZIyDnsfwMMX7JV8V8SLPo8H+gRQ/iAzx
         lf+K3PLIgXy14Pxk4bCaqZWNTmLMvckmqaSCTTDeM9kMKEK0hMvLnKD0Qkx0+YEC/ZRC
         ITYRZKCUdpfFPzX9N2dak+kG7IbrtVZRaJ5EmYU4KFhIrs00dAShwAdv6xhPL2kRJc+n
         CakQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681225341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2WJpgC9tCR8udl5BovYzFlcONxJeVE/qdJ1S1reXt5E=;
        b=b1hL33WsWLac1nRKpWRgd8x1m5jBoQJW+Ys2g5230PHpSEPpmlkhbR1g/8IdZlz+o7
         9FjG10feL8U1sL+glJzsHFfEcuUbMp10Lt3ce1LorUSByDt6ARj705ObBkZAvN+Q1yxX
         x2RDX7JAw8ALapghc6S9ja7Ni1JNtDiHia+08ZQC639n/XP9sj2e6CgzYtqFYQnVgGa8
         UdnOJam9yhM4JPD9tdmcbRk1qCaRg+dSoHbpj0zUnlNmMPljaCtcX/i6kgS3OVf29lT6
         Y3mu1etR4G7dntbeK/lycNBFesyAiv54HXB9uWOKvvViwfPL5fWXYRO8sfKwpx00JxxA
         RkLQ==
X-Gm-Message-State: AAQBX9fXbH8zIE8Hy1/gcGtLVueB0fpgfcU5MOHO3zYYONRulVoDSBCl
        2NfsrOjJvIbAsi2q4YlSsIFTTP/Ste1DqY3kMkQ=
X-Google-Smtp-Source: AKy350YwtRIiyCDeEf6JFQH53X2u6nZHWvn5d3u/Drcf/pPiALqRx7i8rjGAzsLiwjvV95U1/m3LauiEIuV3O9FcwoI=
X-Received: by 2002:a05:6808:2994:b0:384:1e6a:bf10 with SMTP id
 ex20-20020a056808299400b003841e6abf10mr2176191oib.5.1681225341294; Tue, 11
 Apr 2023 08:02:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230410210608.1873968-1-robdclark@gmail.com> <20230410210608.1873968-2-robdclark@gmail.com>
 <ZDU5vvc4V85E9hqP@phenom.ffwll.local>
In-Reply-To: <ZDU5vvc4V85E9hqP@phenom.ffwll.local>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 11 Apr 2023 08:02:09 -0700
Message-ID: <CAF6AEGuzfvC0v7bo_OD7mP6C9cA4mJeTvdM+i7e1hVS-Tv+AFQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm: Add fdinfo memory stats
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Christopher Healy <healych@amazon.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Rob Clark <robdclark@chromium.org>,
        David Airlie <airlied@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 3:43=E2=80=AFAM Daniel Vetter <daniel@ffwll.ch> wro=
te:
>
> On Mon, Apr 10, 2023 at 02:06:06PM -0700, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > Add a helper to dump memory stats to fdinfo.  For the things the drm
> > core isn't aware of, use a callback.
> >
> > v2: Fix typos, change size units to match docs, use div_u64
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>
>
> Uh can't we wire this up by default? Having this as a per-driver opt-in
> sounds like we'll get maximally fragmented drm fd_info, and since that's
> uapi I don't think that's any good at all.

That is the reason for the centralized documentation of the props (and
why for this one I added a helper, rather than continuing the current
pattern of everyone rolling their own)..

We _could_ (and I had contemplated) doing this all in core if (a) we
move madv to drm_gem_object, and (b) track
drm_gem_get_pages()/drm_gem_put_pages().  I guess neither is totally
unreasonable, pretty much all the non-ttm/non-cma GEM drivers have
some form of madvise ioctl and use
drm_gem_get_pages()/drm_gem_put_pages()..

BR,
-R

> I think it's time we have
> - drm_fd_info
> - rolled out to all drivers in their fops
> - with feature checks as appropriate
> - push the driver-specific things into a drm_driver callback
>
> And I guess start peopling giving a hard time for making things needless
> driver-specifict ... there's really no reason at all this is not
> consistent across drivers.
> -Daniel
>
> > ---
> >  Documentation/gpu/drm-usage-stats.rst | 21 +++++++
> >  drivers/gpu/drm/drm_file.c            | 79 +++++++++++++++++++++++++++
> >  include/drm/drm_file.h                | 10 ++++
> >  3 files changed, 110 insertions(+)
> >
> > diff --git a/Documentation/gpu/drm-usage-stats.rst b/Documentation/gpu/=
drm-usage-stats.rst
> > index b46327356e80..b5e7802532ed 100644
> > --- a/Documentation/gpu/drm-usage-stats.rst
> > +++ b/Documentation/gpu/drm-usage-stats.rst
> > @@ -105,6 +105,27 @@ object belong to this client, in the respective me=
mory region.
> >  Default unit shall be bytes with optional unit specifiers of 'KiB' or =
'MiB'
> >  indicating kibi- or mebi-bytes.
> >
> > +- drm-shared-memory: <uint> [KiB|MiB]
> > +
> > +The total size of buffers that are shared with another file (ie. have =
more
> > +than a single handle).
> > +
> > +- drm-private-memory: <uint> [KiB|MiB]
> > +
> > +The total size of buffers that are not shared with another file.
> > +
> > +- drm-resident-memory: <uint> [KiB|MiB]
> > +
> > +The total size of buffers that are resident in system memory.
> > +
> > +- drm-purgeable-memory: <uint> [KiB|MiB]
> > +
> > +The total size of buffers that are purgeable.
> > +
> > +- drm-active-memory: <uint> [KiB|MiB]
> > +
> > +The total size of buffers that are active on one or more rings.
> > +
> >  - drm-cycles-<str> <uint>
> >
> >  Engine identifier string must be the same as the one specified in the
> > diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
> > index a51ff8cee049..085b01842a87 100644
> > --- a/drivers/gpu/drm/drm_file.c
> > +++ b/drivers/gpu/drm/drm_file.c
> > @@ -42,6 +42,7 @@
> >  #include <drm/drm_client.h>
> >  #include <drm/drm_drv.h>
> >  #include <drm/drm_file.h>
> > +#include <drm/drm_gem.h>
> >  #include <drm/drm_print.h>
> >
> >  #include "drm_crtc_internal.h"
> > @@ -868,6 +869,84 @@ void drm_send_event(struct drm_device *dev, struct=
 drm_pending_event *e)
> >  }
> >  EXPORT_SYMBOL(drm_send_event);
> >
> > +static void print_size(struct drm_printer *p, const char *stat, size_t=
 sz)
> > +{
> > +     const char *units[] =3D {"", " KiB", " MiB"};
> > +     unsigned u;
> > +
> > +     for (u =3D 0; u < ARRAY_SIZE(units) - 1; u++) {
> > +             if (sz < SZ_1K)
> > +                     break;
> > +             sz =3D div_u64(sz, SZ_1K);
> > +     }
> > +
> > +     drm_printf(p, "%s:\t%zu%s\n", stat, sz, units[u]);
> > +}
> > +
> > +/**
> > + * drm_print_memory_stats - Helper to print standard fdinfo memory sta=
ts
> > + * @file: the DRM file
> > + * @p: the printer to print output to
> > + * @status: callback to get driver tracked object status
> > + *
> > + * Helper to iterate over GEM objects with a handle allocated in the s=
pecified
> > + * file.  The optional status callback can return additional object st=
ate which
> > + * determines which stats the object is counted against.  The callback=
 is called
> > + * under table_lock.  Racing against object status change is "harmless=
", and the
> > + * callback can expect to not race against object destruction.
> > + */
> > +void drm_print_memory_stats(struct drm_file *file, struct drm_printer =
*p,
> > +                         enum drm_gem_object_status (*status)(struct d=
rm_gem_object *))
> > +{
> > +     struct drm_gem_object *obj;
> > +     struct {
> > +             size_t shared;
> > +             size_t private;
> > +             size_t resident;
> > +             size_t purgeable;
> > +             size_t active;
> > +     } size =3D {0};
> > +     int id;
> > +
> > +     spin_lock(&file->table_lock);
> > +     idr_for_each_entry (&file->object_idr, obj, id) {
> > +             enum drm_gem_object_status s =3D 0;
> > +
> > +             if (status)
> > +                     s =3D status(obj);
> > +
> > +             if (obj->handle_count > 1) {
> > +                     size.shared +=3D obj->size;
> > +             } else {
> > +                     size.private +=3D obj->size;
> > +             }
> > +
> > +             if (s & DRM_GEM_OBJECT_RESIDENT) {
> > +                     size.resident +=3D obj->size;
> > +                     s &=3D ~DRM_GEM_OBJECT_PURGEABLE;
> > +             }
> > +
> > +             if (s & DRM_GEM_OBJECT_ACTIVE) {
> > +                     size.active +=3D obj->size;
> > +                     s &=3D ~DRM_GEM_OBJECT_PURGEABLE;
> > +             }
> > +
> > +             if (s & DRM_GEM_OBJECT_PURGEABLE)
> > +                     size.purgeable +=3D obj->size;
> > +     }
> > +     spin_unlock(&file->table_lock);
> > +
> > +     print_size(p, "drm-shared-memory", size.shared);
> > +     print_size(p, "drm-private-memory", size.private);
> > +
> > +     if (status) {
> > +             print_size(p, "drm-resident-memory", size.resident);
> > +             print_size(p, "drm-purgeable-memory", size.purgeable);
> > +             print_size(p, "drm-active-memory", size.active);
> > +     }
> > +}
> > +EXPORT_SYMBOL(drm_print_memory_stats);
> > +
> >  /**
> >   * mock_drm_getfile - Create a new struct file for the drm device
> >   * @minor: drm minor to wrap (e.g. #drm_device.primary)
> > diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
> > index 0d1f853092ab..7bd8a1374f39 100644
> > --- a/include/drm/drm_file.h
> > +++ b/include/drm/drm_file.h
> > @@ -41,6 +41,7 @@
> >  struct dma_fence;
> >  struct drm_file;
> >  struct drm_device;
> > +struct drm_printer;
> >  struct device;
> >  struct file;
> >
> > @@ -438,6 +439,15 @@ void drm_send_event_timestamp_locked(struct drm_de=
vice *dev,
> >                                    struct drm_pending_event *e,
> >                                    ktime_t timestamp);
> >
> > +enum drm_gem_object_status {
> > +     DRM_GEM_OBJECT_RESIDENT  =3D BIT(0),
> > +     DRM_GEM_OBJECT_PURGEABLE =3D BIT(1),
> > +     DRM_GEM_OBJECT_ACTIVE    =3D BIT(2),
> > +};
> > +
> > +void drm_print_memory_stats(struct drm_file *file, struct drm_printer =
*p,
> > +                         enum drm_gem_object_status (*status)(struct d=
rm_gem_object *));
> > +
> >  struct file *mock_drm_getfile(struct drm_minor *minor, unsigned int fl=
ags);
> >
> >  #endif /* _DRM_FILE_H_ */
> > --
> > 2.39.2
> >
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
