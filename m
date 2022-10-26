Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B860860DB72
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 08:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233094AbiJZGjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 02:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiJZGi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 02:38:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C5F8709A
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 23:38:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9CFCEB8210F
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 06:38:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49E61C43141
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 06:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666766333;
        bh=61Hb6HxumLKiyn9KEa/suPToYAXki8IY7g9gAEJU+m0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ix/J1CBu0zNHI4/yZvUVCuCYLOIm6BMTQfW4E0VeVobQ+Nl7GXZtwdaCMN4A1VMsT
         zZzztMXs9JbonquBj6U+ssowTM8C3pWK7ZK3PbPS4pI82mfQRA5djbbQbSZ7Pn9eqw
         6aB48A3dTvH3zs5m0KLjClohaDe3UnVaO8oWHT1piY4+t0yZ9dCnsnRWuovDK1JoCz
         t2oiCXW5no2LvtjrZccYqm9LiH1Vb4qPHXCY+j0IzxNoX97RVW54a+pA3e2LPcqd+n
         QTuGoM0w6OvcTJiDeYlZjatA0JmF661nJ/kdMx0l0gRyk6XxnqaxLdi5Dx8Po6ujWO
         uWKcOzkTAp/3A==
Received: by mail-ed1-f46.google.com with SMTP id a5so26804060edb.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 23:38:53 -0700 (PDT)
X-Gm-Message-State: ACrzQf3XryvkfjVuam1ATVUSmL5OdmyYP0NIT7qYX6wcZRyZh0ltVrLG
        8VW0Uk7k3gqhYRnwzDhwW64V0DSRXVEDtKzYZK4=
X-Google-Smtp-Source: AMsMyM66J0TK1LkxGYBKU8UrlEn6zd7Urf//t7Wuf68mxaxnpS0HD2lFafWDcfkGTMvGGHsNtc7opgHrSn5gjZQVKWM=
X-Received: by 2002:a05:6402:270b:b0:45d:61cd:73cc with SMTP id
 y11-20020a056402270b00b0045d61cd73ccmr39530200edd.136.1666766320964; Tue, 25
 Oct 2022 23:38:40 -0700 (PDT)
MIME-Version: 1.0
References: <20221022214622.18042-1-ogabbay@kernel.org> <CGME20221022214657epcas1p18a2625c84cd6470b5404cb71f9836cc8@epcas1p1.samsung.com>
 <20221022214622.18042-4-ogabbay@kernel.org> <20221025154330.a3a839357363da6d5de96c89@samsung.com>
In-Reply-To: <20221025154330.a3a839357363da6d5de96c89@samsung.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Wed, 26 Oct 2022 09:38:13 +0300
X-Gmail-Original-Message-ID: <CAFCwf11kg-ZvYjEKf=VrvgvM03QZp7GejFhJ=gbCp4up++4h2w@mail.gmail.com>
Message-ID: <CAFCwf11kg-ZvYjEKf=VrvgvM03QZp7GejFhJ=gbCp4up++4h2w@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] drm: add dedicated minor for accelerator devices
To:     Jiho Chu <jiho.chu@samsung.com>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>,
        Daniel Stone <daniel@fooishbar.org>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 9:43 AM Jiho Chu <jiho.chu@samsung.com> wrote:
>
>
> On Sun, 23 Oct 2022 00:46:22 +0300
> Oded Gabbay <ogabbay@kernel.org> wrote:
>
> > diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> > index b58ffb1433d6..c13701a8d4be 100644
> > --- a/drivers/gpu/drm/drm_drv.c
> > +++ b/drivers/gpu/drm/drm_drv.c
> > @@ -56,6 +56,9 @@ MODULE_LICENSE("GPL and additional rights");
> >  static DEFINE_SPINLOCK(drm_minor_lock);
> >  static struct idr drm_minors_idr;
> >
> > +static DEFINE_SPINLOCK(accel_minor_lock);
> > +static struct idr accel_minors_idr;
> > +
> >  /*
> >   * If the drm core fails to init for whatever reason,
> >   * we should prevent any drivers from registering with it.
> > @@ -94,6 +97,8 @@ static struct drm_minor **drm_minor_get_slot(struct drm_device *dev,
> >               return &dev->primary;
> >       case DRM_MINOR_RENDER:
> >               return &dev->render;
> > +     case DRM_MINOR_ACCEL:
> > +             return &dev->accel;
> >       default:
> >               BUG();
> >       }
> > @@ -108,9 +113,15 @@ static void drm_minor_alloc_release(struct drm_device *dev, void *data)
> >
> >       put_device(minor->kdev);
> >
> > -     spin_lock_irqsave(&drm_minor_lock, flags);
> > -     idr_remove(&drm_minors_idr, minor->index);
> > -     spin_unlock_irqrestore(&drm_minor_lock, flags);
> > +     if (minor->type == DRM_MINOR_ACCEL) {
> > +             spin_lock_irqsave(&accel_minor_lock, flags);
> > +             idr_remove(&accel_minors_idr, minor->index);
> > +             spin_unlock_irqrestore(&accel_minor_lock, flags);
> > +     } else {
> > +             spin_lock_irqsave(&drm_minor_lock, flags);
> > +             idr_remove(&drm_minors_idr, minor->index);
> > +             spin_unlock_irqrestore(&drm_minor_lock, flags);
> > +     }
> >  }
> >
> >  static int drm_minor_alloc(struct drm_device *dev, unsigned int type)
> > @@ -127,13 +138,23 @@ static int drm_minor_alloc(struct drm_device *dev, unsigned int type)
> >       minor->dev = dev;
> >
> >       idr_preload(GFP_KERNEL);
> > -     spin_lock_irqsave(&drm_minor_lock, flags);
> > -     r = idr_alloc(&drm_minors_idr,
> > -                   NULL,
> > -                   64 * type,
> > -                   64 * (type + 1),
> > -                   GFP_NOWAIT);
> > -     spin_unlock_irqrestore(&drm_minor_lock, flags);
> > +     if (type == DRM_MINOR_ACCEL) {
> > +             spin_lock_irqsave(&accel_minor_lock, flags);
> > +             r = idr_alloc(&accel_minors_idr,
> > +                     NULL,
> > +                     64 * (type - DRM_MINOR_ACCEL),
> > +                     64 * (type - DRM_MINOR_ACCEL + 1),
> > +                     GFP_NOWAIT);
> > +             spin_unlock_irqrestore(&accel_minor_lock, flags);
> > +     } else {
> > +             spin_lock_irqsave(&drm_minor_lock, flags);
> > +             r = idr_alloc(&drm_minors_idr,
> > +                     NULL,
> > +                     64 * type,
> > +                     64 * (type + 1),
> > +                     GFP_NOWAIT);
> > +             spin_unlock_irqrestore(&drm_minor_lock, flags);
> > +     }
>
> Hi,
> There are many functions which checks drm type and decides its behaviors. It's good to
> re-use exiting codes, but accel devices use totally different major/minor, and so it needs to be moved to
> /drvier/accel/ (maybe later..). How about seperating functions for alloc/release minor (accel_minor_alloc..)?
> also, for others which have drm type related codes.
My feeling was moving the minor code handling to a different file (in
addition to moving the major code handling) will cause too much
duplication.
My main theme is that an accel minor is another minor in drm, even if
a bit different. i.e. It uses the same drm_minor structure.
The driver declares he wants to use this minor using a drm driver feature flag.
imo, all of that indicates the code should be inside drm.
>
>
>
>
> > @@ -607,6 +652,14 @@ static int drm_dev_init(struct drm_device *dev,
> >       /* no per-device feature limits by default */
> >       dev->driver_features = ~0u;
> >
> > +     if (drm_core_check_feature(dev, DRIVER_COMPUTE_ACCEL) &&
> > +                             (drm_core_check_feature(dev, DRIVER_RENDER) ||
> > +                             drm_core_check_feature(dev, DRIVER_MODESET))) {
> > +
> > +             DRM_ERROR("DRM driver can't be both a compute acceleration and graphics driver\n");
> > +             return -EINVAL;
> > +     }
> > +
>
> It's fine for the device only for acceleration, but can't graphic devices have acceleration feature?
Of course they can :) In that case, and if they want to expose an
accel device char, they should write an accel driver and connect it to
their main graphics driver via auxiliary bus.

I could have added two flags - compute_accel, and compute_accel_only
(similar to a patch that was sent to add render only flag), but imo it
would make the code more convoluted. I prefer the clean separation and
using standard auxiliary bus.

Thanks,
Oded

>
>
> Thanks,
> Jiho Chu
