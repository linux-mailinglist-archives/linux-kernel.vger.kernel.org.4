Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDB360B04A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 18:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbiJXQDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 12:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbiJXQCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 12:02:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C27211879B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 07:56:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3C0F1B81BAB
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 14:41:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8BCFC433B5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 14:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666622490;
        bh=573Ln4cycAv4yHsGNxf7bxVDj7O7ePVFwztAvN6jSoM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=q9TqLvaN+1UAy9IG2bu4Iozalg8dBOv6S4MbjtkwkQAHMAmVtgRXAeMEDhyVNTJ+v
         nKBekhnevPjEqKbHFZkvk+dR2lwIsgOLNAlUhOtlYMceOENsH09bhBjGkutO9Ignm0
         Gt8bVLTUI3ozmgVX0QUAXK+hWg7Xpkx2mMdYfPWILw3hgLCHv40bsit4MiRn4S4KkM
         0Muuz4v57rq2D+QAOskyqlCIy0cezoX/Pl89TPnnieF6kxnIUlypt61w7+FuN+LCcx
         7NpgPhvkrH5kdTKAIg0Rbzfz2AluAsaI7cGxEFJ0ZqKJaKLi0pgOWnc30aDt7Peqzw
         AYsTJZuEfxkiw==
Received: by mail-ed1-f51.google.com with SMTP id a67so32082248edf.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 07:41:30 -0700 (PDT)
X-Gm-Message-State: ACrzQf0PFCCguyPdPZvgCaGJE3FI3JFlRZnmshY8qbXX86lWww0fjLJg
        G7esLjhkL9ZMRqd6rHvOcwtYO2AslCHBvlSCPjo=
X-Google-Smtp-Source: AMsMyM7sKGmviZaWbmgBjJrmStEDKqj4gFQWVeLtPAXAlPTvbW1zSztmy5BKQLk0oZ5O9EqH/+4IOlfmDyFvTrQiihU=
X-Received: by 2002:a17:906:ef90:b0:7ab:1b2c:b654 with SMTP id
 ze16-20020a170906ef9000b007ab1b2cb654mr906693ejb.627.1666622489127; Mon, 24
 Oct 2022 07:41:29 -0700 (PDT)
MIME-Version: 1.0
References: <20221022214622.18042-1-ogabbay@kernel.org> <CADnq5_PwNwsSUeyhXDkoy-y1JXFrTj99AgVV02oHX0a29QUXpQ@mail.gmail.com>
In-Reply-To: <CADnq5_PwNwsSUeyhXDkoy-y1JXFrTj99AgVV02oHX0a29QUXpQ@mail.gmail.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Mon, 24 Oct 2022 17:41:02 +0300
X-Gmail-Original-Message-ID: <CAFCwf11CPvW8uqbDs8-qyMVMbPhw1tPF9ddfjee1MvKthRQb+g@mail.gmail.com>
Message-ID: <CAFCwf11CPvW8uqbDs8-qyMVMbPhw1tPF9ddfjee1MvKthRQb+g@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] new subsystem for compute accelerator devices
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Jiho Chu <jiho.chu@samsung.com>,
        Christoph Hellwig <hch@infradead.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Kevin Hilman <khilman@baylibre.com>,
        Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>,
        Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 4:55 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Sat, Oct 22, 2022 at 5:46 PM Oded Gabbay <ogabbay@kernel.org> wrote:
> >
> > In the last couple of months we had a discussion [1] about creating a new
> > subsystem for compute accelerator devices in the kernel.
> >
> > After an analysis that was done by DRM maintainers and myself, and following
> > a BOF session at the Linux Plumbers conference a few weeks ago [2], we
> > decided to create a new subsystem that will use the DRM subsystem's code and
> > functionality. i.e. the accel core code will be part of the DRM subsystem.
> >
> > This will allow us to leverage the extensive DRM code-base and
> > collaborate with DRM developers that have experience with this type of
> > devices. In addition, new features that will be added for the accelerator
> > drivers can be of use to GPU drivers as well (e.g. RAS).
> >
> > As agreed in the BOF session, the accelerator devices will be exposed to
> > user-space with a new, dedicated device char files and a dedicated major
> > number (261), to clearly separate them from graphic cards and the graphic
> > user-space s/w stack. Furthermore, the drivers will be located in a separate
> > place in the kernel tree (drivers/accel/).
> >
> > This series of patches is the first step in this direction as it adds the
> > necessary infrastructure for accelerator devices to DRM. The new devices will
> > be exposed with the following convention:
> >
> > device char files - /dev/accel/accel*
> > sysfs             - /sys/class/accel/accel*/
> > debugfs           - /sys/kernel/debug/accel/accel*/
> >
> > I tried to reuse the existing DRM code as much as possible, while keeping it
> > readable and maintainable.
>
> Wouldn't something like this:
> https://patchwork.freedesktop.org/series/109575/
> Be simpler and provide better backwards compatibility for existing
> non-gfx devices in the drm subsystem as well as newer devices?

As Greg said, see the summary. The consensus in the LPC session was
that we need to clearly separate accel devices from existing gpu
devices (whether they use primary and/or render nodes). That is the
main guideline according to which I wrote the patches. I don't think I
want to change this decision.

Also, there was never any intention to provide backward compatibility
for existing non-gfx devices. Why would we want that ? We are mainly
talking about drivers that are currently trying to get upstream, and
the habana driver.

Oded
>
> Alex
>
> >
> > One thing that is missing from this series is defining a namespace for the
> > new accel subsystem, while I'll add in the next iteration of this patch-set,
> > after I will receive feedback from the community.
> >
> > As for drivers, once this series will be accepted (after adding the namespace),
> > I will start working on migrating the habanalabs driver to the new accel
> > subsystem. I have talked about it with Dave and we agreed that it will be
> > a good start to simply move the driver as-is with minimal changes, and then
> > start working on the driver's individual features that will be either added
> > to the accel core code (with or without changes), or will be removed and
> > instead the driver will use existing DRM code.
> >
> > In addition, I know of at least 3 or 4 drivers that were submitted for review
> > and are good candidates to be included in this new subsystem, instead of being
> > a drm render node driver or a misc driver.
> >
> > [1] https://lkml.org/lkml/2022/7/31/83
> > [2] https://airlied.blogspot.com/2022/09/accelerators-bof-outcomes-summary.html
> >
> > Thanks,
> > Oded
> >
> > Oded Gabbay (3):
> >   drivers/accel: add new kconfig and update MAINTAINERS
> >   drm: define new accel major and register it
> >   drm: add dedicated minor for accelerator devices
> >
> >  Documentation/admin-guide/devices.txt |   5 +
> >  MAINTAINERS                           |   8 +
> >  drivers/Kconfig                       |   2 +
> >  drivers/accel/Kconfig                 |  24 +++
> >  drivers/gpu/drm/drm_drv.c             | 214 +++++++++++++++++++++-----
> >  drivers/gpu/drm/drm_file.c            |  69 ++++++---
> >  drivers/gpu/drm/drm_internal.h        |   5 +-
> >  drivers/gpu/drm/drm_sysfs.c           |  81 +++++++++-
> >  include/drm/drm_device.h              |   3 +
> >  include/drm/drm_drv.h                 |   8 +
> >  include/drm/drm_file.h                |  21 ++-
> >  include/drm/drm_ioctl.h               |   1 +
> >  12 files changed, 374 insertions(+), 67 deletions(-)
> >  create mode 100644 drivers/accel/Kconfig
> >
> > --
> > 2.34.1
> >
