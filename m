Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D74B60DAFB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 08:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbiJZGL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 02:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiJZGL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 02:11:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F578E9B7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 23:11:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ECA0C61D06
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 06:11:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D404C4347C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 06:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666764684;
        bh=5vqCpENyB2EHG4Hg+p62w22SAGxOrapCrm+qpQ9lY64=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uluVYyBsVgavrANCvbT2DDbhXJzw1YuH0OMIKxYx3f7gVXRxkXylo9xWb/YkzHl78
         GRf2px5rHGbxOBYFTIVRAeACCbdFoLvZjSDLcgdKvJJycJ2mUQmsdbDic8JIJVZcIt
         P3FOwRFUEkNFCimkgGDScV2kx7LSwIKNO38UH8nLbE2CWtuqN87eEHuApj8ZK24PYm
         MXCYgIU/ZSQ7/grk1KStouU4Hj5eoWJpPswLjvCFvtbTai1UA90//a2ymWxU0KNGHT
         ZYnjZoOmvOX5yV72Dg2CQ3mBe1cpBB9beJDPIRDzZ0mUWAArC9dd2Dm9AApx0xounh
         jRoYxrcdB0EfQ==
Received: by mail-ej1-f47.google.com with SMTP id t25so13048004ejb.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 23:11:24 -0700 (PDT)
X-Gm-Message-State: ACrzQf1DD3Ry8nqF/sEcBGIIGHASqbcV9cXjnjSDb5IjO8rfT/cUztVL
        Xp/g8aZ9TjmBAMdhTSquD4uvbAnjadMcWQdZ7Rk=
X-Google-Smtp-Source: AMsMyM6WFE3Pt0b6zSDwtNDJ8co5aHpxM8gyVPNcCppKbCP9Jk1KJBR4UYapXUUl2Z6dTo12Cq12igu4wbvS8epqpQI=
X-Received: by 2002:a17:907:7606:b0:7ac:a344:ebea with SMTP id
 jx6-20020a170907760600b007aca344ebeamr5524345ejc.580.1666764682363; Tue, 25
 Oct 2022 23:11:22 -0700 (PDT)
MIME-Version: 1.0
References: <20221022214622.18042-1-ogabbay@kernel.org> <CADnq5_PwNwsSUeyhXDkoy-y1JXFrTj99AgVV02oHX0a29QUXpQ@mail.gmail.com>
 <CAFCwf11CPvW8uqbDs8-qyMVMbPhw1tPF9ddfjee1MvKthRQb+g@mail.gmail.com> <CADnq5_PsM1xPzZgj_2sVBQQnDerzOEestLh_PmTQxpddD5Dsvg@mail.gmail.com>
In-Reply-To: <CADnq5_PsM1xPzZgj_2sVBQQnDerzOEestLh_PmTQxpddD5Dsvg@mail.gmail.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Wed, 26 Oct 2022 09:10:55 +0300
X-Gmail-Original-Message-ID: <CAFCwf12uJPFXcUiTSOteU0ew+cr=yeTsBTzoyvd=Z8q64K5R2Q@mail.gmail.com>
Message-ID: <CAFCwf12uJPFXcUiTSOteU0ew+cr=yeTsBTzoyvd=Z8q64K5R2Q@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 6:10 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Mon, Oct 24, 2022 at 10:41 AM Oded Gabbay <ogabbay@kernel.org> wrote:
> >
> > On Mon, Oct 24, 2022 at 4:55 PM Alex Deucher <alexdeucher@gmail.com> wrote:
> > >
> > > On Sat, Oct 22, 2022 at 5:46 PM Oded Gabbay <ogabbay@kernel.org> wrote:
> > > >
> > > > In the last couple of months we had a discussion [1] about creating a new
> > > > subsystem for compute accelerator devices in the kernel.
> > > >
> > > > After an analysis that was done by DRM maintainers and myself, and following
> > > > a BOF session at the Linux Plumbers conference a few weeks ago [2], we
> > > > decided to create a new subsystem that will use the DRM subsystem's code and
> > > > functionality. i.e. the accel core code will be part of the DRM subsystem.
> > > >
> > > > This will allow us to leverage the extensive DRM code-base and
> > > > collaborate with DRM developers that have experience with this type of
> > > > devices. In addition, new features that will be added for the accelerator
> > > > drivers can be of use to GPU drivers as well (e.g. RAS).
> > > >
> > > > As agreed in the BOF session, the accelerator devices will be exposed to
> > > > user-space with a new, dedicated device char files and a dedicated major
> > > > number (261), to clearly separate them from graphic cards and the graphic
> > > > user-space s/w stack. Furthermore, the drivers will be located in a separate
> > > > place in the kernel tree (drivers/accel/).
> > > >
> > > > This series of patches is the first step in this direction as it adds the
> > > > necessary infrastructure for accelerator devices to DRM. The new devices will
> > > > be exposed with the following convention:
> > > >
> > > > device char files - /dev/accel/accel*
> > > > sysfs             - /sys/class/accel/accel*/
> > > > debugfs           - /sys/kernel/debug/accel/accel*/
> > > >
> > > > I tried to reuse the existing DRM code as much as possible, while keeping it
> > > > readable and maintainable.
> > >
> > > Wouldn't something like this:
> > > https://patchwork.freedesktop.org/series/109575/
> > > Be simpler and provide better backwards compatibility for existing
> > > non-gfx devices in the drm subsystem as well as newer devices?
> >
> > As Greg said, see the summary. The consensus in the LPC session was
> > that we need to clearly separate accel devices from existing gpu
> > devices (whether they use primary and/or render nodes). That is the
> > main guideline according to which I wrote the patches. I don't think I
> > want to change this decision.
> >
> > Also, there was never any intention to provide backward compatibility
> > for existing non-gfx devices. Why would we want that ? We are mainly
> > talking about drivers that are currently trying to get upstream, and
> > the habana driver.
>
> If someone already has a non-gfx device which uses the drm subsystem,
> should they be converted to the new accel stuff?  What about new
> devices that utilize the same driver?  SHould they use accel or
> continue to use drm?
My baseline assumption was that this subsystem is mainly (but not
solely) for new drivers that are now trying to get upstreamed and for
the habana driver.
imo we should not force existing drivers to convert their entire
driver just because we created a new subsystem. If they want to do it,
they are more than welcomed.
But that's only my opinion and other maintainers might think otherwise.

> For the sake of the rest of the stack drm would
> make more sense, but if accel grows a bunch of stuff that all accel
> drivers should be using what do we do?
First of all, as I wrote in another email, I don't think accel core
code will be very large. Otherwise, I probably would have tried to
convince people that the accel stuff should be totally independent of
drm.
You can see I tried to make the code tightly-coupled with drm (too
much according to the reviews) and I did that because I believe most
core code will be common to drm and accel. So I'm not worried about
this aspect.

Second, yes, if for some reason there will be accel-only features that
devices want to use, they will need to create an accel device that
will have this functionality and be connected via auxiliary bus to
their main driver (which can be drm or other subsystem, e.g. nvme).
For example, to utilize Ethernet and RDMA features, habana is now
writing Ethernet and RDMA drivers that will be upstreamed and they
will be connected to the main/compute driver via auxiliary bus.

> Also using render nodes also
> makes the devices compatible with all of the existing user space tools
> that use the existing drm device nodes like libdrm, etc.  I'm failing
> to see what advantage accel brings other than requiring userspace to
> support two very similar device nodes.
This is exactly what we are trying to avoid here :) We want to make
sure that all existing user space tools that use drm devices will NOT
work with the accel devices.
Accel devices are not GPUs. The h/w ip might be a part of a GPU ASIC,
but the specific functionality is not related to the
drm/mesa/x-server/wayland/opengl/vulkan stack.
I don't want them to expose render nodes that Chrome or some other
application tries to open because it thinks it is a GPU...

So it was the majority opinion of the people in LPC that we should
make a clear separation. If there is no separation, then I don't see
the point in doing an accel subsystem, let's just continue to do drm.

Thanks,
Oded

>
> Alex
>
> >
> > Oded
> > >
> > > Alex
> > >
> > > >
> > > > One thing that is missing from this series is defining a namespace for the
> > > > new accel subsystem, while I'll add in the next iteration of this patch-set,
> > > > after I will receive feedback from the community.
> > > >
> > > > As for drivers, once this series will be accepted (after adding the namespace),
> > > > I will start working on migrating the habanalabs driver to the new accel
> > > > subsystem. I have talked about it with Dave and we agreed that it will be
> > > > a good start to simply move the driver as-is with minimal changes, and then
> > > > start working on the driver's individual features that will be either added
> > > > to the accel core code (with or without changes), or will be removed and
> > > > instead the driver will use existing DRM code.
> > > >
> > > > In addition, I know of at least 3 or 4 drivers that were submitted for review
> > > > and are good candidates to be included in this new subsystem, instead of being
> > > > a drm render node driver or a misc driver.
> > > >
> > > > [1] https://lkml.org/lkml/2022/7/31/83
> > > > [2] https://airlied.blogspot.com/2022/09/accelerators-bof-outcomes-summary.html
> > > >
> > > > Thanks,
> > > > Oded
> > > >
> > > > Oded Gabbay (3):
> > > >   drivers/accel: add new kconfig and update MAINTAINERS
> > > >   drm: define new accel major and register it
> > > >   drm: add dedicated minor for accelerator devices
> > > >
> > > >  Documentation/admin-guide/devices.txt |   5 +
> > > >  MAINTAINERS                           |   8 +
> > > >  drivers/Kconfig                       |   2 +
> > > >  drivers/accel/Kconfig                 |  24 +++
> > > >  drivers/gpu/drm/drm_drv.c             | 214 +++++++++++++++++++++-----
> > > >  drivers/gpu/drm/drm_file.c            |  69 ++++++---
> > > >  drivers/gpu/drm/drm_internal.h        |   5 +-
> > > >  drivers/gpu/drm/drm_sysfs.c           |  81 +++++++++-
> > > >  include/drm/drm_device.h              |   3 +
> > > >  include/drm/drm_drv.h                 |   8 +
> > > >  include/drm/drm_file.h                |  21 ++-
> > > >  include/drm/drm_ioctl.h               |   1 +
> > > >  12 files changed, 374 insertions(+), 67 deletions(-)
> > > >  create mode 100644 drivers/accel/Kconfig
> > > >
> > > > --
> > > > 2.34.1
> > > >
