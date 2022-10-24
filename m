Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC91D60BB19
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 22:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235046AbiJXUqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 16:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235053AbiJXUq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 16:46:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDE5BEAFD
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 11:54:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7D7E7B819BA
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 12:44:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30650C43149
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 12:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666615462;
        bh=Ruagwt0yc5BirBvqVLC/ClrMrdT1LhW7pInoMnUa4gk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Mhatf8ycnzeGmxDSWLV8/lKNqCO5vyLIZhA/0HW9rTCbVwnlgwwdbrrv3E0l3SuFU
         h6+tcFRDbPO/3tLp2P/HBh/mJk6dKzTr8ETHne8XGH8k67nmUmEdPwOyq7A7dJyIXQ
         2BpzFQ295mQu6VJQOemQ2M6seNV0Z6B6mp4JAUPN42aohNW7VbafogE8GViemGNmI4
         F4nmeEdpyeaXJfZbP7QujEP/nupobs9HJ+BM6bWSldGTDocqQ/YOTxO87HX373k78l
         Z59cBDO2a+nW9yhRlwj6Dk5DQQz3frwze5nXcyYzSQvEA/X0/qiW1JqeQjl9bGMrv6
         BPoMq8gxF8gVw==
Received: by mail-ed1-f45.google.com with SMTP id a13so30845889edj.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 05:44:22 -0700 (PDT)
X-Gm-Message-State: ACrzQf1syjUgmHyU7/pwGmajKSCfLVMWK10ipdX5YU7nh5l2lvxBQqFt
        Ge70IliTrmDDzmeYyIstNv7qUKUQ5Rfv78FU4us=
X-Google-Smtp-Source: AMsMyM4rt3Qq7d0FZm6/isWTqW2zbQWwSePM/s9LXTDQcxB4ZdmsdmOGifvZ6w7o3/hF/bM5BnC3zMa5haK/f1n0esY=
X-Received: by 2002:a05:6402:5291:b0:45c:3f6a:d4bc with SMTP id
 en17-20020a056402529100b0045c3f6ad4bcmr30210375edb.285.1666615460146; Mon, 24
 Oct 2022 05:44:20 -0700 (PDT)
MIME-Version: 1.0
References: <20221022214622.18042-1-ogabbay@kernel.org> <af4c71cb-be60-e354-ca4f-23e834aca6e1@suse.de>
In-Reply-To: <af4c71cb-be60-e354-ca4f-23e834aca6e1@suse.de>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Mon, 24 Oct 2022 15:43:53 +0300
X-Gmail-Original-Message-ID: <CAFCwf12HDZvsr1TrRFQH9Vi26S-Xf9ULgxtBazme90Sj5AzhQQ@mail.gmail.com>
Message-ID: <CAFCwf12HDZvsr1TrRFQH9Vi26S-Xf9ULgxtBazme90Sj5AzhQQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] new subsystem for compute accelerator devices
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>,
        Jiho Chu <jiho.chu@samsung.com>,
        Daniel Stone <daniel@fooishbar.org>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 2:56 PM Thomas Zimmermann <tzimmermann@suse.de> wro=
te:
>
> Hi
>
> Am 22.10.22 um 23:46 schrieb Oded Gabbay:
> > In the last couple of months we had a discussion [1] about creating a n=
ew
> > subsystem for compute accelerator devices in the kernel.
> >
> > After an analysis that was done by DRM maintainers and myself, and foll=
owing
> > a BOF session at the Linux Plumbers conference a few weeks ago [2], we
> > decided to create a new subsystem that will use the DRM subsystem's cod=
e and
> > functionality. i.e. the accel core code will be part of the DRM subsyst=
em.
> >
> > This will allow us to leverage the extensive DRM code-base and
> > collaborate with DRM developers that have experience with this type of
> > devices. In addition, new features that will be added for the accelerat=
or
> > drivers can be of use to GPU drivers as well (e.g. RAS).
> >
> > As agreed in the BOF session, the accelerator devices will be exposed t=
o
> > user-space with a new, dedicated device char files and a dedicated majo=
r
> > number (261), to clearly separate them from graphic cards and the graph=
ic
> > user-space s/w stack. Furthermore, the drivers will be located in a sep=
arate
> > place in the kernel tree (drivers/accel/).
> >
> > This series of patches is the first step in this direction as it adds t=
he
> > necessary infrastructure for accelerator devices to DRM. The new device=
s will
> > be exposed with the following convention:
> >
> > device char files - /dev/accel/accel*
> > sysfs             - /sys/class/accel/accel*/
> > debugfs           - /sys/kernel/debug/accel/accel*/
>
> I know I'm really late to this discussion, but wouldn't 'compute' be a
> better name?
I also thought like you :)
But I consulted with Dave while writing these patches and he suggested
accel/accel.
I'm fine either way...

>
> (I agree that skynet would also be nice :)
>
> >
> > I tried to reuse the existing DRM code as much as possible, while keepi=
ng it
> > readable and maintainable.
> >
> > One thing that is missing from this series is defining a namespace for =
the
> > new accel subsystem, while I'll add in the next iteration of this patch=
-set,
> > after I will receive feedback from the community.
> >
> > As for drivers, once this series will be accepted (after adding the nam=
espace),
> > I will start working on migrating the habanalabs driver to the new acce=
l
> > subsystem. I have talked about it with Dave and we agreed that it will =
be
> > a good start to simply move the driver as-is with minimal changes, and =
then
> > start working on the driver's individual features that will be either a=
dded
> > to the accel core code (with or without changes), or will be removed an=
d
> > instead the driver will use existing DRM code.
>
> What's your opinion on the long-term prospect of DRM vs accel? I assume
> that over time, DRM helpers will move into accel and some DRM drivers
> will start depending on accel?
I don't think that is what I had in mind.
What I had in mind is that accel helpers are only relevant for accel
drivers, and any code that might also be relevant for DRM drivers will
be placed in DRM core code. e.g. GEM enhancements, RAS netlink
support. btw, I suspect this will be the majority of the code.
In addition, DRM drivers should never set the new DRIVER_COMPUTE_ACCEL
driver feature in their structure so they should have zero dependency
on the accel core code.

>
> After reading the provided links, I wondered if we shouldn't rename
> drivers/gpu to drivers/accel and put the new subsystem into
> drivers/accel/compute. We'd have DRM and compute devices next to each
> other and shared helpers could be located in other subdirectories within
> accel/
I think this idea was brought up at the BOF session and Dave and
others said it will be too big of a burden (due to backports) to do
it.
From Dave's blogpost:
"Moving things around now for current drivers is too hard to deal with
for backports etc. Adding a new directory for accel drivers would be a
good plan, even if they used the drm framework."

Thanks,
Oded
>
> Best regards
> Thomas
>
> >
> > In addition, I know of at least 3 or 4 drivers that were submitted for =
review
> > and are good candidates to be included in this new subsystem, instead o=
f being
> > a drm render node driver or a misc driver.
> >
> > [1] https://lkml.org/lkml/2022/7/31/83
> > [2] https://airlied.blogspot.com/2022/09/accelerators-bof-outcomes-summ=
ary.html
> >
> > Thanks,
> > Oded
> >
> > Oded Gabbay (3):
> >    drivers/accel: add new kconfig and update MAINTAINERS
> >    drm: define new accel major and register it
> >    drm: add dedicated minor for accelerator devices
> >
> >   Documentation/admin-guide/devices.txt |   5 +
> >   MAINTAINERS                           |   8 +
> >   drivers/Kconfig                       |   2 +
> >   drivers/accel/Kconfig                 |  24 +++
> >   drivers/gpu/drm/drm_drv.c             | 214 +++++++++++++++++++++----=
-
> >   drivers/gpu/drm/drm_file.c            |  69 ++++++---
> >   drivers/gpu/drm/drm_internal.h        |   5 +-
> >   drivers/gpu/drm/drm_sysfs.c           |  81 +++++++++-
> >   include/drm/drm_device.h              |   3 +
> >   include/drm/drm_drv.h                 |   8 +
> >   include/drm/drm_file.h                |  21 ++-
> >   include/drm/drm_ioctl.h               |   1 +
> >   12 files changed, 374 insertions(+), 67 deletions(-)
> >   create mode 100644 drivers/accel/Kconfig
> >
> > --
> > 2.34.1
> >
>
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
> (HRB 36809, AG N=C3=BCrnberg)
> Gesch=C3=A4ftsf=C3=BChrer: Ivo Totev
