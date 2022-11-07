Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF1C62006F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 22:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbiKGVKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 16:10:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233348AbiKGVJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 16:09:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610842E68D
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 13:07:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D677061321
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 21:07:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B49FC43146
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 21:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667855228;
        bh=35Kt7RfXTGrpmnm+A+6ICvQbAqN4Rh+f2zdGLkqxYlQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EKoBGIv2z25CaP2ZaTUHxI2NDsDw2pq7HU2Pi3V+xT6qKnFVdplEQ8Gt1Zb2YI2Ko
         DxHI1sKGDggo3kOkbtl5m31tGbv3KhW72f3cdiOhBr3EllnT2AV39+nngiR8VeWaCi
         ESR+Oq8InGTavmbG/omzYfL5Fkbnzd5clbEmXjhQ+2gP1/w1xfmYqD6C4e4gVY+FtN
         OZX4RuJ+RvsPrKJPeYt9EO2i9OwwDQqTm3vVuJsnEMPFwi5d4puKFOBQA+Vprs/Aay
         +v/Lxx0w9HuCeFcWxqpT9q3ZRjuBdgKAe/jdET1gaYomVf6+4SKOcsto9DzbXJkFdp
         R11xlsjNhRemg==
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-3704852322fso116372457b3.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 13:07:08 -0800 (PST)
X-Gm-Message-State: ACrzQf2no4eQ1vquiU1z1laXHVzOryAMkrSRGainn4Md2hOmX1l5yV+r
        6fCbqoL0QDo4HInA2J0ModuAyXVzdR+1aUb8LVo=
X-Google-Smtp-Source: AMsMyM5OImNYpUi6MJAyaoHBG+PMmSj5RdM9uwWMSNW6HniZGG7MfQ9/cV022DRtOdso7B9q6QZg0WbcHQ/7IiZXcjw=
X-Received: by 2002:a05:690c:825:b0:36a:b160:21b with SMTP id
 by5-20020a05690c082500b0036ab160021bmr50210487ywb.211.1667855227298; Mon, 07
 Nov 2022 13:07:07 -0800 (PST)
MIME-Version: 1.0
References: <20221106210225.2065371-1-ogabbay@kernel.org> <20221106210225.2065371-3-ogabbay@kernel.org>
 <2f415e77-9332-2d66-cd59-05db8d5790ea@quicinc.com>
In-Reply-To: <2f415e77-9332-2d66-cd59-05db8d5790ea@quicinc.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Mon, 7 Nov 2022 23:06:41 +0200
X-Gmail-Original-Message-ID: <CAFCwf11AMAYgKHJia87x0gsZ2ufVK1ZQqXqDLLimeeTVQVp2CA@mail.gmail.com>
Message-ID: <CAFCwf11AMAYgKHJia87x0gsZ2ufVK1ZQqXqDLLimeeTVQVp2CA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 2/3] accel: add dedicated minor for accelerator devices
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>
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
        Jiho Chu <jiho.chu@samsung.com>,
        Daniel Stone <daniel@fooishbar.org>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>,
        Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 7, 2022 at 6:20 PM Jeffrey Hugo <quic_jhugo@quicinc.com> wrote:
>
> On 11/6/2022 2:02 PM, Oded Gabbay wrote:
> > --- a/drivers/accel/drm_accel.c
> > +++ b/drivers/accel/drm_accel.c
> > @@ -8,14 +8,25 @@
> >
> >   #include <linux/debugfs.h>
> >   #include <linux/device.h>
> > +#include <linux/xarray.h>
>
> If we are not using xarray at this time, do we still need this include?
>
> >
> >   #include <drm/drm_accel.h>
> > +#include <drm/drm_debugfs.h>
> > +#include <drm/drm_drv.h>
> > +#include <drm/drm_file.h>
> >   #include <drm/drm_ioctl.h>
> >   #include <drm/drm_print.h>
> >
> > +static DEFINE_SPINLOCK(accel_minor_lock);
> > +static struct idr accel_minors_idr;
>
> I beleive we should have an explicit include for the IDR header.
>
> > --- a/include/drm/drm_accel.h
> > +++ b/include/drm/drm_accel.h
> > @@ -8,12 +8,56 @@
> >   #ifndef DRM_ACCEL_H_
> >   #define DRM_ACCEL_H_
> >
> > -#define ACCEL_MAJOR     261
> > +#include <drm/drm_file.h>
> > +
> > +#define ACCEL_MAJOR          261
> > +#define ACCEL_MAX_MINORS     256
>
> This diff seems really weird.  The changes to the ACCEL_MAJOR define
> could get pushed to the previous patch, no?
>
> > @@ -23,9 +67,31 @@ static inline void accel_core_exit(void)
> >
> >   static inline int __init accel_core_init(void)
> >   {
> > +     /* Return 0 to allow drm_core_init to complete successfully */
>
> Move to previous patch?
>
> > --- a/include/drm/drm_drv.h
> > +++ b/include/drm/drm_drv.h
> > @@ -94,6 +94,14 @@ enum drm_driver_feature {
> >        * synchronization of command submission.
> >        */
> >       DRIVER_SYNCOBJ_TIMELINE         = BIT(6),
> > +     /**
> > +      * @DRIVER_COMPUTE_ACCEL:
> > +      *
> > +      * Driver supports compute acceleration devices. This flag is mutually exclusive with
> > +      * @DRIVER_RENDER and @DRIVER_MODESET. Devices that support both graphics and compute
> > +      * acceleration should be handled by two drivers that are connected using auxiliry bus.
>
> auxiliry -> auxiliary
>
All comments will be fixed.
Thanks,
Oded
