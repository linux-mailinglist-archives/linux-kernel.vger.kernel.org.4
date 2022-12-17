Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B3364F63E
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 01:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiLQAYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 19:24:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbiLQAXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 19:23:47 -0500
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3D640833
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 16:20:34 -0800 (PST)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-144bd860fdbso5297258fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 16:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R8rAH2GjPEN9cY2fq9wcLQvkq0XDelpfrBUCyI4W8M0=;
        b=gVLraqrBI+CrXfl1q9XWLveth0b2gcmRhlBQRTvPhYEv33+nDHVTAlpeX2gnLCEi7N
         M0tc5wNsQbUrSCvQH7/jOfhyabJYHMZ+2/4cWYuIR0nubbdW0JTx94PrSELNjzR7s6l1
         osxNLFbYVEZJtMJgBHP5bcuKq/OxlGj7+tB3tmSnT5QApImssWMsNSp1KFEyLRYhPEH4
         xQiLnfTvCuJEp11PIgr8tgxhMqgK5iVfJlTz3FXtyoDnglB/k1B9bndI8PTpZeIhmGP5
         wRXgNDrg9zzuyHbjgSim4vo/ArQF2+KEQR2bn0io5tXaWdL76P4yNC4Gg2WfCZQ/firw
         hg2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R8rAH2GjPEN9cY2fq9wcLQvkq0XDelpfrBUCyI4W8M0=;
        b=Tkl+Z/GAkZ6XAx/pxUvuVCw6+IQ4WwL+G+M3iIW23jU1++dfXQghTnDV8f7snQOiHO
         uU6HNn/PROrOzerY15PoHheT4flshohWobBI8twLgVwKF5fJV2PmAz4DXMtF93bFvRSo
         xYyP1KfLJXydwrj4IiK9nw2U8D6c28gqdRcuZNjSEQpBJ9Usw06nAotueT6bNhQGnYUc
         ty0sBWmt16Mg+lE7R8i4z9Ae2TWtmhq6ECjVl1iE1M1XRwHSfzmveaUTyh/+vty59Ay9
         uoGuBb2F8l0N1HmKRgkkVyngq7yL9KbSNj2iAbET9CREcgTow5bTe2MeYdxTSZYUFlA8
         xeIA==
X-Gm-Message-State: AFqh2kofNCQa6UFbRcQSwZvOtqn5noiU1c0PbYzmtCU51oDmePRT11jM
        2T05Z9VTXaCLUmpZYnqvB/pyccNQ9DY4lm/su5U=
X-Google-Smtp-Source: AMrXdXs5aUnA063HWx2w3Qx3FkzdCzT/FVgFv/YjFe2WVtsqLFBdJ01EfAg6nEjQRyvTc58uOdUhUOgr1Mqcba+0PoQ=
X-Received: by 2002:a05:6870:3411:b0:144:5f0d:9fcb with SMTP id
 g17-20020a056870341100b001445f0d9fcbmr825544oah.38.1671236433326; Fri, 16 Dec
 2022 16:20:33 -0800 (PST)
MIME-Version: 1.0
References: <20221216233355.542197-1-robdclark@gmail.com> <CAPaKu7RP281inKJKNWWTnETCU+giwU2YajzwH6AUVeTDXQoWWg@mail.gmail.com>
In-Reply-To: <CAPaKu7RP281inKJKNWWTnETCU+giwU2YajzwH6AUVeTDXQoWWg@mail.gmail.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Fri, 16 Dec 2022 16:20:33 -0800
Message-ID: <CAF6AEGv0w=iPW-25BEjmEoQyODyQU23sK_j2eNGV2jOQO+byCg@mail.gmail.com>
Subject: Re: [PATCH] drm/panfrost: Fix GEM handle creation UAF
To:     Chia-I Wu <olvaffe@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        open list <linux-kernel@vger.kernel.org>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
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

On Fri, Dec 16, 2022 at 3:59 PM Chia-I Wu <olvaffe@gmail.com> wrote:
>
> On Fri, Dec 16, 2022 at 3:34 PM Rob Clark <robdclark@gmail.com> wrote:
> >
> > From: Rob Clark <robdclark@chromium.org>
> >
> > Relying on an unreturned handle to hold a reference to an object we
> > dereference is not safe.  Userspace can guess the handle and race us
> > by closing the handle from another thread.  The _create_with_handle()
> > that returns an object ptr is pretty much a pattern to avoid.  And
> > ideally creating the handle would be done after any needed dererencing.
> > But in this case creation of the mapping is tied to the handle creation.
> > Fortunately the mapping is refcnt'd and holds a reference to the object,
> > so we can drop the handle's reference once we hold a mapping reference.
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> >  drivers/gpu/drm/panfrost/panfrost_drv.c |  7 +++++++
> >  drivers/gpu/drm/panfrost/panfrost_gem.c | 10 +++++++---
> >  2 files changed, 14 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> > index 2fa5afe21288..aa5848de647c 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> > @@ -98,6 +98,13 @@ static int panfrost_ioctl_create_bo(struct drm_device *dev, void *data,
> >                 return PTR_ERR(bo);
> >
> >         mapping = panfrost_gem_mapping_get(bo, priv);
> > +
> > +       /*
> > +        * Now that the mapping holds a reference to the bo until we no longer
> > +        * need it, we can safely drop the handle's reference.
> > +        */
> Not too familiar with panfrost, but I don't see
> panfrost_gem_mapping_get hold a reference to the bo?

It doesn't directly, but the mapping already holds a reference, taken
before the handle reference is dropped

It is all a bit too subtle for my taste.

> > +       drm_gem_object_put(&bo->base.base);
> > +
> >         if (!mapping) {
> >                 drm_gem_object_put(&bo->base.base);
> >                 return -EINVAL;
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.c b/drivers/gpu/drm/panfrost/panfrost_gem.c
> > index 293e799e2fe8..e3e21c500d24 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_gem.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_gem.c
> > @@ -234,6 +234,10 @@ struct drm_gem_object *panfrost_gem_create_object(struct drm_device *dev, size_t
> >         return &obj->base.base;
> >  }
> >
> > +/*
> > + * NOTE: if this succeeds, both the handle and the returned object have
> > + * an outstanding reference.
> > + */
> I might suggest dropping the "_with_handle" suffix.

Maybe _and_handle would be a better name (for this and other cases
that return both a handle and obj)?

> The naming convention is used in several drivers.  I think we should
> make it the case that the _with_handle variants always return the
> handle without the pointer.  (And with the change, it immediately
> becomes clear that qxl and vmwgfx also have similar issues).

ugg, yeah, qxl does have the issue in the qxl_mode_dumb_create path.
I overlooked that it returns an obj pointer by reference.

on the surface vmwgfx looked ok, but I could have overlooked something.

BR,
-R

> >  struct panfrost_gem_object *
> >  panfrost_gem_create_with_handle(struct drm_file *file_priv,
> >                                 struct drm_device *dev, size_t size,
> > @@ -261,10 +265,10 @@ panfrost_gem_create_with_handle(struct drm_file *file_priv,
> >          * and handle has the id what user can see.
> >          */
> >         ret = drm_gem_handle_create(file_priv, &shmem->base, handle);
> > -       /* drop reference from allocate - handle holds it now. */
> > -       drm_gem_object_put(&shmem->base);
> > -       if (ret)
> > +       if (ret) {
> > +               drm_gem_object_put(&shmem->base);
> >                 return ERR_PTR(ret);
> > +       }
> >
> >         return bo;
> >  }
> > --
> > 2.38.1
> >
