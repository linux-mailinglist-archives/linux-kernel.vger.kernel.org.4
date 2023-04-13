Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1BD6E129E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 18:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjDMQpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 12:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjDMQpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 12:45:33 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625829019;
        Thu, 13 Apr 2023 09:45:32 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1842cddca49so18817324fac.1;
        Thu, 13 Apr 2023 09:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681404331; x=1683996331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oByrnsONK30cwcXqGqekipGmIRVdrmv+6iLjv1XrfME=;
        b=Sh2JQs+70mr6brdXr25zhc7A+Sgf/JXbc9nTBoPmmc2YJE4Ww5ov4ydSypFpNWe0bC
         OO4C8nz506aceKcMLCnYS7s+1SU5QCYHoQWqgU1Rsm8h4n0JPzofXTkBMgCW+HCwfRDW
         MyFAOD8a1wVPjo0E/WptmvKlNzX0J6rpDSsoKHWtuhsoynoduX+DamL7eB04d4SC6KKD
         qqVPsj/nIR+Np3lS+ujVG+AqXdklQ5O6hjMXJcZo7FqsFUhHdJ8j5UoiL04vsyc/GpR3
         Z1cBUvS/MvRbU300zjlgs8rB8IoRHyvNLhra/rHJlJ+K/VwZDklASA9dUuyju21hQp1K
         u/sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681404331; x=1683996331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oByrnsONK30cwcXqGqekipGmIRVdrmv+6iLjv1XrfME=;
        b=G5b3p/2rc8y3vOYGBEanfduYCkJqLFa5KAEF/VLKz+Xj9aHGMkf/+uAIQXgfVFT04h
         VV/9hRaouqnur0zX1p3pB4C30bbJiN3IdXk2XMGc7gSvmMSPOrzJdPFAGNdruVr0TigN
         eooAvyzmOSRM5krlPH/6YRLBM/uDlhy2EkRnLBdJMz//NASIKk1tA9WmWyTBn1YhkW7W
         4JPuDELWAFJfiVhuVZiRynMjWgE6LWzGiLlExK2DAeptqrR3/vuez+96YVV4298z56yQ
         A9gT8LsX8jlNxZckFO9tbHTEtgkkpZcwaDGnkG+Gsuy1kd+OhBGMS/06cQTItJ5e/Ijd
         vNuQ==
X-Gm-Message-State: AAQBX9elNysZQqryZs2cXebiDlPjuld1HmvHlE4e+3SsmtZCI+PYyIfi
        byft3EnXFj+q+U1FIMnoEy7DChT6QZ0J15nqWVLVJmvhoHc=
X-Google-Smtp-Source: AKy350Z4h8mbgpIbx0rEysO7OX64EvjqDG8LEqmJ3Jn4Ix4GbnPhHC6u4Fh1cUn7OzpqiZ8P0/P5s1wp0N8yJEXW0p8=
X-Received: by 2002:a05:6870:1090:b0:177:9150:e7ba with SMTP id
 16-20020a056870109000b001779150e7bamr1447997oaq.3.1681404331531; Thu, 13 Apr
 2023 09:45:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230411225725.2032862-1-robdclark@gmail.com> <20230411225725.2032862-7-robdclark@gmail.com>
 <29a8d9aa-c6ea-873f-ce0b-fb8199b13068@linux.intel.com>
In-Reply-To: <29a8d9aa-c6ea-873f-ce0b-fb8199b13068@linux.intel.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 13 Apr 2023 12:45:20 -0400
Message-ID: <CADnq5_OZOQ9i1tXw4xTHvUM5hXpNi1Sgka6wdj9sd0k-Tbc_Eg@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] drm: Add fdinfo memory stats
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-arm-msm@vger.kernel.org,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Christopher Healy <healych@amazon.com>,
        open list <linux-kernel@vger.kernel.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
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

On Wed, Apr 12, 2023 at 10:42=E2=80=AFAM Tvrtko Ursulin
<tvrtko.ursulin@linux.intel.com> wrote:
>
>
> On 11/04/2023 23:56, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > Add support to dump GEM stats to fdinfo.
> >
> > v2: Fix typos, change size units to match docs, use div_u64
> > v3: Do it in core
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>
> > ---
> >   Documentation/gpu/drm-usage-stats.rst | 21 ++++++++
> >   drivers/gpu/drm/drm_file.c            | 76 ++++++++++++++++++++++++++=
+
> >   include/drm/drm_file.h                |  1 +
> >   include/drm/drm_gem.h                 | 19 +++++++
> >   4 files changed, 117 insertions(+)
> >
> > diff --git a/Documentation/gpu/drm-usage-stats.rst b/Documentation/gpu/=
drm-usage-stats.rst
> > index b46327356e80..b5e7802532ed 100644
> > --- a/Documentation/gpu/drm-usage-stats.rst
> > +++ b/Documentation/gpu/drm-usage-stats.rst
> > @@ -105,6 +105,27 @@ object belong to this client, in the respective me=
mory region.
> >   Default unit shall be bytes with optional unit specifiers of 'KiB' or=
 'MiB'
> >   indicating kibi- or mebi-bytes.
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
>
> I think this naming maybe does not work best with the existing
> drm-memory-<region> keys.
>
> How about introduce the concept of a memory region from the start and
> use naming similar like we do for engines?
>
> drm-memory-$CATEGORY-$REGION: ...
>
> Then we document a bunch of categories and their semantics, for instance:
>
> 'size' - All reachable objects
> 'shared' - Subset of 'size' with handle_count > 1
> 'resident' - Objects with backing store
> 'active' - Objects in use, subset of resident
> 'purgeable' - Or inactive? Subset of resident.
>
> We keep the same semantics as with process memory accounting (if I got
> it right) which could be desirable for a simplified mental model.
>
> (AMD needs to remind me of their 'drm-memory-...' keys semantics. If we
> correctly captured this in the first round it should be equivalent to
> 'resident' above. In any case we can document no category is equal to
> which category, and at most one of the two must be output.)

We've had the standard TTM pools for a while:
drm-memory-vram
drm-memory-gtt
drm-memory-cpu

And we recently added the following, mainly for profiling for mesa:
amd-memory-visible-vram
amd-evicted-vram
amd-evicted-visible-vram
amd-requested-vram
amd-requested-visible-vram
amd-requested-gtt

amd-memory-visible-vram is a subset of drm-memory-vram, not a separate pool=
.

Alex

>
> Region names we at most partially standardize. Like we could say
> 'system' is to be used where backing store is system RAM and others are
> driver defined.
>
> Then discrete GPUs could emit N sets of key-values, one for each memory
> region they support.
>
> I think this all also works for objects which can be migrated between
> memory regions. 'Size' accounts them against all regions while for
> 'resident' they only appear in the region of their current placement, etc=
.
>
> Userspace can aggregate if it wishes to do so but kernel side should not.
>
> > +
> > +- drm-purgeable-memory: <uint> [KiB|MiB]
> > +
> > +The total size of buffers that are purgeable.
> > +
> > +- drm-active-memory: <uint> [KiB|MiB]
> > +
> > +The total size of buffers that are active on one or more rings.
> > +
> >   - drm-cycles-<str> <uint>
> >
> >   Engine identifier string must be the same as the one specified in the
> > diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
> > index 37dfaa6be560..46fdd843bb3a 100644
> > --- a/drivers/gpu/drm/drm_file.c
> > +++ b/drivers/gpu/drm/drm_file.c
> > @@ -42,6 +42,7 @@
> >   #include <drm/drm_client.h>
> >   #include <drm/drm_drv.h>
> >   #include <drm/drm_file.h>
> > +#include <drm/drm_gem.h>
> >   #include <drm/drm_print.h>
> >
> >   #include "drm_crtc_internal.h"
> > @@ -871,6 +872,79 @@ void drm_send_event(struct drm_device *dev, struct=
 drm_pending_event *e)
> >   }
> >   EXPORT_SYMBOL(drm_send_event);
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
> > +static void print_memory_stats(struct drm_printer *p, struct drm_file =
*file)
> > +{
> > +     struct drm_gem_object *obj;
> > +     struct {
> > +             size_t shared;
> > +             size_t private;
> > +             size_t resident;
> > +             size_t purgeable;
> > +             size_t active;
> > +     } size =3D {0};
> > +     bool has_status =3D false;
> > +     int id;
> > +
> > +     spin_lock(&file->table_lock);
> > +     idr_for_each_entry (&file->object_idr, obj, id) {
> > +             enum drm_gem_object_status s =3D 0;
> > +
> > +             if (obj->funcs && obj->funcs->status) {
> > +                     s =3D obj->funcs->status(obj);
> > +                     has_status =3D true;
> > +             }
> > +
> > +             if (obj->handle_count > 1) {
> > +                     size.shared +=3D obj->size;
> > +             } else {
> > +                     size.private +=3D obj->size;
> > +             }
> > +
> > +             if (s & DRM_GEM_OBJECT_RESIDENT) {
> > +                     size.resident +=3D obj->size;
> > +             } else {
> > +                     /* If already purged or not yet backed by pages, =
don't
> > +                      * count it as purgeable:
> > +                      */
> > +                     s &=3D ~DRM_GEM_OBJECT_PURGEABLE;
>
> Side question - why couldn't resident buffers be purgeable? Did you mean
> for the if branch check to be active here? But then it wouldn't make
> sense for a driver to report active _and_ purgeable..
>
> > +             }
> > +
> > +             if (!dma_resv_test_signaled(obj->resv, dma_resv_usage_rw(=
true))) {
> > +                     size.active +=3D obj->size;
> > +
> > +                     /* If still active, don't count as purgeable: */
> > +                     s &=3D ~DRM_GEM_OBJECT_PURGEABLE;
>
> Another side question - I guess this tidies a race in reporting? If so
> not sure it matters given the stats are all rather approximate.
>
> > +             }
> > +
> > +             if (s & DRM_GEM_OBJECT_PURGEABLE)
> > +                     size.purgeable +=3D obj->size;
> > +     }
>
> One concern I have here is that it is all based on obj->size. That is,
> there is no provision for drivers to implement page level granularity.
> So correct reporting in use cases such as VM BIND in the future wouldn't
> work unless it was a driver hook to get almost all of the info above. At
> which point common code is just a loop. TBF I don't know if any drivers
> do sub obj->size backing store granularity today, but I think it is
> sometimes to be sure of before proceeding.
>
> Second concern is what I touched upon in the first reply block - if the
> common code blindly loops over all objects then on discrete GPUs it
> seems we get an 'aggregate' value here which is not what I think we
> want. We rather want to have the ability for drivers to list stats per
> individual memory region.
>
> > +     spin_unlock(&file->table_lock);
> > +
> > +     print_size(p, "drm-shared-memory", size.shared);
> > +     print_size(p, "drm-private-memory", size.private);
> > +     print_size(p, "drm-active-memory", size.active);
> > +
> > +     if (has_status) {
> > +             print_size(p, "drm-resident-memory", size.resident);
> > +             print_size(p, "drm-purgeable-memory", size.purgeable);
> > +     }
> > +}
> > +
> >   /**
> >    * drm_fop_show_fdinfo - helper for drm file fops
> >    * @seq_file: output stream
> > @@ -904,6 +978,8 @@ void drm_fop_show_fdinfo(struct seq_file *m, struct=
 file *f)
> >
> >       if (dev->driver->show_fdinfo)
> >               dev->driver->show_fdinfo(&p, file);
> > +
> > +     print_memory_stats(&p, file);
> >   }
> >   EXPORT_SYMBOL(drm_fop_show_fdinfo);
> >
> > diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
> > index dfa995b787e1..e5b40084538f 100644
> > --- a/include/drm/drm_file.h
> > +++ b/include/drm/drm_file.h
> > @@ -41,6 +41,7 @@
> >   struct dma_fence;
> >   struct drm_file;
> >   struct drm_device;
> > +struct drm_printer;
> >   struct device;
> >   struct file;
> >
> > diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
> > index 189fd618ca65..213917bb6b11 100644
> > --- a/include/drm/drm_gem.h
> > +++ b/include/drm/drm_gem.h
> > @@ -42,6 +42,14 @@
> >   struct iosys_map;
> >   struct drm_gem_object;
> >
> > +/**
> > + * enum drm_gem_object_status - bitmask of object state for fdinfo rep=
orting
> > + */
> > +enum drm_gem_object_status {
> > +     DRM_GEM_OBJECT_RESIDENT  =3D BIT(0),
> > +     DRM_GEM_OBJECT_PURGEABLE =3D BIT(1),
> > +};
> > +
> >   /**
> >    * struct drm_gem_object_funcs - GEM object functions
> >    */
> > @@ -174,6 +182,17 @@ struct drm_gem_object_funcs {
> >        */
> >       int (*evict)(struct drm_gem_object *obj);
> >
> > +     /**
> > +      * @status:
> > +      *
> > +      * The optional status callback can return additional object stat=
e
> > +      * which determines which stats the object is counted against.  T=
he
> > +      * callback is called under table_lock.  Racing against object st=
atus
> > +      * change is "harmless", and the callback can expect to not race
> > +      * against object destruction.
> > +      */
> > +     enum drm_gem_object_status (*status)(struct drm_gem_object *obj);
>
> Does this needs to be in object funcs and couldn't be consolidated to
> driver level?
>
> Regards,
>
> Tvrtko
>
> > +
> >       /**
> >        * @vm_ops:
> >        *
