Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADC762714D
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 18:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235291AbiKMRom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 12:44:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232884AbiKMRoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 12:44:39 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADEA77661
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 09:44:38 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id l127so9443872oia.8
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 09:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vSpSXd4xBTYt0GhSjGvAmECM0CAegHMeid7wAuT1mCI=;
        b=Iqmevfc8DicUj3o12i8cN1FEDRtwyxOcguIwcTFKcqAe80/LiALvG5Ux7cTbv0/Qiz
         +oVmJFi8ks3IOjzlGVXZcUkakMo9RBY9EX81rPnYA4G1rOQ2Pu2SgL90vtAJ5h/f83ij
         srA1uUj4/tRSjkb8P97SP4XieuvenNkQ9HSAIoH1sXBPRR+hDbjxBMip4wN8m1IeWHoJ
         vGv6fSgUQzhqJ6AtJAC9H+Xnz+4miA/cCcJfFwOd6wY3rS1LH1SjwOja1TeNcTODQKq6
         24pH1Xw5s192ck6v7MDwUX4tJnNeTfdZpuvacaQtGkeoS5PoLac3Kiv4nFadk8DDQSBZ
         kHIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vSpSXd4xBTYt0GhSjGvAmECM0CAegHMeid7wAuT1mCI=;
        b=IHvLdPXh7ZLDHskTUVedaVmYvijBhWYdX5RIh+08XsDT4uOvRpR/evb4MrJs9+QMb3
         bGZ2W2KNuEEPel3l8yFkgFeMvMrCtPVBfZCOB+Jnc4F5myEXi5PVhAlXSMiwyMzeQcbh
         vETFeL4/3X9po/cuV1Bl4FzeyPrPTCdqR7IVZPnV+du3H9TeqXJzNeoQuy4xVRFJM4vv
         EkfMHkGK9SYF6Dn1cnGGw248ySvRAvAz7Y3M5+ueJevtevwrst7z9TBcBJTB7madyR/E
         sf9oQl5P1yseOv9lSTOtgggezpbBkIFHLge06kDqhGsb9zO/BxT0uF8l/cl2ng2FWLmh
         V1hg==
X-Gm-Message-State: ANoB5pmYmLtBrMZUt0XG0NpcscasSiiGYmH7lpvZWbg51W/lXqCvycEF
        kP4/XzPdBJU6TnPSxZB5LuTTFWJBsbIw9dUUICU4Hcgp7qo=
X-Google-Smtp-Source: AA0mqf763ayLv+C8H6TkBm9gazkkwsnig5L2IS08iwPvTaK9k+4imomma5TQkF2EOgRUOuaHbd7gupbF7f+r97FMxoA=
X-Received: by 2002:aca:e156:0:b0:35a:3093:d3a with SMTP id
 y83-20020acae156000000b0035a30930d3amr4646957oig.283.1668361478005; Sun, 13
 Nov 2022 09:44:38 -0800 (PST)
MIME-Version: 1.0
References: <20221017171118.1588820-1-sammler@google.com> <CAM9Jb+ggq5L9XZZHhfA98XDO+P=8y-mT+ct0JFAtXRbsCuORsA@mail.gmail.com>
 <CAFPP518-gU1M1XcHMHgpx=ZPPkSyjPmfOK6D+wM6t6vM6Ve6XQ@mail.gmail.com>
 <CAM9Jb+hk0ZRtXnF+WVj0LiRiO7uH-jDydJrnUQ_57yTEcs--Dw@mail.gmail.com>
 <6359ab83d6e4d_4da3294d0@dwillia2-xfh.jf.intel.com.notmuch> <CAHS8izOYYV+dz3vPdbkipt1i1XAU-mvJOn6c_z-NJJwzUtWzDg@mail.gmail.com>
In-Reply-To: <CAHS8izOYYV+dz3vPdbkipt1i1XAU-mvJOn6c_z-NJJwzUtWzDg@mail.gmail.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Sun, 13 Nov 2022 18:44:26 +0100
Message-ID: <CAM9Jb+j3MDq_HpaZXYaMWmc4OhXob9hQiLLeSvaJfGa2LoPBDw@mail.gmail.com>
Subject: Re: [PATCH v1] virtio_pmem: populate numa information
To:     Mina Almasry <almasrymina@google.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Michael Sammler <sammler@google.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org
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

> > Pankaj Gupta wrote:
> > > > > > Compute the numa information for a virtio_pmem device from the memory
> > > > > > range of the device. Previously, the target_node was always 0 since
> > > > > > the ndr_desc.target_node field was never explicitly set. The code for
> > > > > > computing the numa node is taken from cxl_pmem_region_probe in
> > > > > > drivers/cxl/pmem.c.
> > > > > >
> > > > > > Signed-off-by: Michael Sammler <sammler@google.com>
>
> Tested-by: Mina Almasry <almasrymina@google.com>
>
> I don't have much expertise on this driver, but with the help of this
> patch I was able to get memory tiering [1] emulation going on qemu. As
> far as I know there is no alternative to this emulation, and so I
> would love to see this or equivalent merged, if possible.
>
> This is what I have going to get memory tiering emulation:
>
> In qemu, added these configs:
>       -object memory-backend-file,id=m4,share=on,mem-path="$path_to_virtio_pmem_file",size=2G
> \
>       -smp 2,sockets=2,maxcpus=2  \
>       -numa node,nodeid=0,memdev=m0 \
>       -numa node,nodeid=1,memdev=m1 \
>       -numa node,nodeid=2,memdev=m2,initiator=0 \
>       -numa node,nodeid=3,initiator=0 \
>       -device virtio-pmem-pci,memdev=m4,id=nvdimm1 \
>
> On boot, ran these commands:
>     ndctl_static create-namespace -e namespace0.0 -m devdax -f 1&> /dev/null
>     echo dax0.0 > /sys/bus/dax/drivers/device_dax/unbind
>     echo dax0.0 > /sys/bus/dax/drivers/kmem/new_id
>     for i in `ls /sys/devices/system/memory/`; do
>       state=$(cat "/sys/devices/system/memory/$i/state" 2&>/dev/null)
>       if [ "$state" == "offline" ]; then
>         echo online_movable > "/sys/devices/system/memory/$i/state"
>       fi
>     done

Nice to see the way to handle the virtio-pmem device memory through kmem driver
and online the corresponding memory blocks to 'zone_movable'.

This also opens way to use this memory range directly irrespective of attached
block device. Of course there won't be any persistent data guarantee. But good
way to simulate memory tiering inside guest as demonstrated below.
>
> Without this CL, I see the memory onlined in node 0 always, and is not
> a separate memory tier. With this CL and qemu configs, the memory is
> onlined in node 3 and is set as a separate memory tier, which enables
> qemu-based development:
>
> ==> /sys/devices/virtual/memory_tiering/memory_tier22/nodelist <==
> 3
> ==> /sys/devices/virtual/memory_tiering/memory_tier4/nodelist <==
> 0-2
>
> AFAIK there is no alternative to enabling memory tiering emulation in
> qemu, and would love to see this or equivalent merged, if possible.

Just wondering if Qemu vNVDIMM device can also achieve this?

In any case, this patch is useful, So,
Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com

>
>
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/ABI/testing/sysfs-kernel-mm-memory-tiers
>
> > > > > > ---
> > > > > >  drivers/nvdimm/virtio_pmem.c | 11 +++++++++--
> > > > > >  1 file changed, 9 insertions(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/nvdimm/virtio_pmem.c b/drivers/nvdimm/virtio_pmem.c
> > > > > > index 20da455d2ef6..a92eb172f0e7 100644
> > > > > > --- a/drivers/nvdimm/virtio_pmem.c
> > > > > > +++ b/drivers/nvdimm/virtio_pmem.c
> > > > > > @@ -32,7 +32,6 @@ static int init_vq(struct virtio_pmem *vpmem)
> > > > > >  static int virtio_pmem_probe(struct virtio_device *vdev)
> > > > > >  {
> > > > > >         struct nd_region_desc ndr_desc = {};
> > > > > > -       int nid = dev_to_node(&vdev->dev);
> > > > > >         struct nd_region *nd_region;
> > > > > >         struct virtio_pmem *vpmem;
> > > > > >         struct resource res;
> > > > > > @@ -79,7 +78,15 @@ static int virtio_pmem_probe(struct virtio_device *vdev)
> > > > > >         dev_set_drvdata(&vdev->dev, vpmem->nvdimm_bus);
> > > > > >
> > > > > >         ndr_desc.res = &res;
> > > > > > -       ndr_desc.numa_node = nid;
> > > > > > +
> > > > > > +       ndr_desc.numa_node = memory_add_physaddr_to_nid(res.start);
> > > > > > +       ndr_desc.target_node = phys_to_target_node(res.start);
> > > > > > +       if (ndr_desc.target_node == NUMA_NO_NODE) {
> > > > > > +               ndr_desc.target_node = ndr_desc.numa_node;
> > > > > > +               dev_dbg(&vdev->dev, "changing target node from %d to %d",
> > > > > > +                       NUMA_NO_NODE, ndr_desc.target_node);
> > > > > > +       }
> > > > >
> > > > > As this memory later gets hotplugged using "devm_memremap_pages". I don't
> > > > > see if 'target_node' is used for fsdax case?
> > > > >
> > > > > It seems to me "target_node" is used mainly for volatile range above
> > > > > persistent memory ( e.g kmem driver?).
> > > > >
> > > > I am not sure if 'target_node' is used in the fsdax case, but it is
> > > > indeed used by the devdax/kmem driver when hotplugging the memory (see
> > > > 'dev_dax_kmem_probe' and '__dax_pmem_probe').
> > >
> > > Yes, but not currently for FS_DAX iiuc.
> >
> > The target_node is only used by the dax_kmem driver. In the FSDAX case
> > the memory (persistent or otherwise) is mapped behind a block-device.
> > That block-device has affinity to a CPU initiator, but that memory does
> > not itself have any NUMA affinity or identity as a target.
> >
> > So:
> >
> > block-device NUMA node == closest CPU initiator node to the device
> >
> > dax-device target node == memory only NUMA node target, after onlining
