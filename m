Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 990C16DFD28
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 20:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjDLSAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 14:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjDLSAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 14:00:08 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9644C6A6F;
        Wed, 12 Apr 2023 11:00:06 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id u24-20020a9d7218000000b006a413c893c8so2139750otj.10;
        Wed, 12 Apr 2023 11:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681322406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CzOqx6mVXEtIBUOE3WreIDPOYhl4JJde1mjyAr9BQAc=;
        b=a6eGnU95JQv1bo7V2DHIV19lbywl8RiZZUUU0LxO34JGM6k/4PpNTGdNexNFKB+gkQ
         FD7zxhI/kHMZ6P1EHMSDgSgw0lNsmjTV1n19/nWUxhD60nDYe5LXrsbsSytlzFlrKRyU
         TjgFFT+dA2/APheyrPOz/T4vZcPIhSmNPo+bnylm0HvYhV7uu6lNynMhniv68vVS5zQ2
         WsKssvRL197HCy4lm2cNAlSYcAUhA48wF8vCCRce9WvEmq9tXHkcEgLxZbIoht2NH3Q0
         S+tMYJ1NUkOMCQwLkE+ycbjBvqITAR1EVo4BMM56U1twLTRYdM/pqDmCU6TCUO0YUNs4
         Ea0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681322406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CzOqx6mVXEtIBUOE3WreIDPOYhl4JJde1mjyAr9BQAc=;
        b=LBDGUjVRsVTv2D8lKwPxNqgp+HhlTm8RQAlC9vpPxJSCbQiHsnmCCtJZZSZg9WfFbE
         vjS7EC/IX8DD0J0zga/BJboi0W3KobLa/0GUNilnl5dVLneW9xalk8opSpzf5Iisxy29
         DK67RQgfJ3lUHs4887cgNV10h3LqA/I8b9lBeOlaFcMqd6b0W3WjPOEvXICgk+YciE1i
         1TtdKBFJiedkMmAUYSge/pex4Uf+lGA+kNc/gQmT6A2n+4lVJ+LisHF9+8UgNU2LNyFP
         klwgD1Pu23IFgdY3KXZBqwRqL9o4pRNW8ZPZteX4uQfKjAAFC/Go2rvJCb2F73i39aEm
         04cQ==
X-Gm-Message-State: AAQBX9eASJD89zsFoRfqTUO8fKjjM2szFALLMX2B3iKXYScntfOscTBm
        Ko7dclbBGBblKoA40cjDPgpUP9IQ52J9ISFbqb0=
X-Google-Smtp-Source: AKy350ab8S9cyjEWp1tbQSbr4I7sFOG/DFlCiWEacyjk9m+yoyZewr9GvlIpCuw1ZaDW6IIOt1pJS1NbVkQws6qeH94=
X-Received: by 2002:a9d:332:0:b0:69f:6663:508e with SMTP id
 47-20020a9d0332000000b0069f6663508emr1196933otv.1.1681322405810; Wed, 12 Apr
 2023 11:00:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230411225725.2032862-1-robdclark@gmail.com> <20230411225725.2032862-7-robdclark@gmail.com>
 <29a8d9aa-c6ea-873f-ce0b-fb8199b13068@linux.intel.com>
In-Reply-To: <29a8d9aa-c6ea-873f-ce0b-fb8199b13068@linux.intel.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Wed, 12 Apr 2023 10:59:54 -0700
Message-ID: <CAF6AEGsZsMx+Vy+4UQSx3X7w_QNvvjLqWxx=PnCLAOC9f-X2CQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] drm: Add fdinfo memory stats
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Christopher Healy <healych@amazon.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Rob Clark <robdclark@chromium.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
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

On Wed, Apr 12, 2023 at 7:42=E2=80=AFAM Tvrtko Ursulin
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

Actually, it was very deliberate not to conflict with the existing
drm-memory-<region> keys ;-)

I wouldn't have preferred drm-memory-{active,resident,...} but it
could be mis-parsed by existing userspace so my hands were a bit tied.

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

I'm not too sure how to rectify different memory regions with this,
since drm core doesn't really know about the driver's memory regions.
Perhaps we can go back to this being a helper and drivers with vram
just don't use the helper?  Or??

BR,
-R

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
