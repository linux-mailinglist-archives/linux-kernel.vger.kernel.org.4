Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72BAE6288F9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 20:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236635AbiKNTOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 14:14:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235707AbiKNTOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 14:14:40 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382811A2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 11:14:39 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id 128so12441998vsz.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 11:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ppYNbwGBmFp60JGsjkd+4WjNN17srw2QFRc27Nuw4kM=;
        b=aefewAI7GXQMCF4zxIt7Rf6T2cPnkSzrllgXa7FUxI9qT5MOICGJ2bUGc3mCxT4LOX
         33B6J+rlFF4+p79fcdrzl6nHV2VEJVi3oGiuzs1uAWx5DH5+5u2KiwdEQNRyi+3CxJxp
         RYlmsrghULjrf5CEy6rgGsHdsR+Ubya6Oz4kMsJkUazljNkqbNdfpl6UDdJdlkGeabRs
         ufSZeCh7M+w7To6j/rQ279i2ddkYT4hG46xZeP/yGcEQuZkDjNt0yDjy4CiO4KTMV/bt
         hVq+96/HD6Azy9ZPgGVykGPdivZAzdMrFVxRoV/KlCVsUyM0bNKqn+48mZnkwbt6aXi3
         6BMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ppYNbwGBmFp60JGsjkd+4WjNN17srw2QFRc27Nuw4kM=;
        b=rEtiYv92zg3aL6Yv1/jCTx8GqzWTT3CgIRxi8cZPblGBROKlRyCC6YluiofK2VwP1x
         5nbf8+znRW6yUDtGsWl58G3QL7HSBRvT7/Pei0fjKA4j+Xt8FcI8u+5qk+fsljlqGlsV
         7pyQEk8S/Fwp6JIf7fbLJCuTtdIMU+yu3yDoqK+oqIJKaGCZNrgiw2S8CccKnGHv3+Vf
         MhanTmKNaX0XS9uDF+YF8GAn+e51g6ReYt6x/PQ9BMEoQwN4N9qrTfe7sm9EEwhuYWUc
         l3byNGddVT20y8MvJ2jod1rmw/s53g1UsdPWb3aC+oj1CyPWOQMIP4BgUWLmrTYhsN8N
         CPuQ==
X-Gm-Message-State: ANoB5pmqDc+AamjVVudr5eNMyv1DoxrQDHqItq1w32PtgMsgCWHOPhhO
        u0m0Rr3wIZptyvi/0XSxHmtIfkU5kKvN6hb28DupUg==
X-Google-Smtp-Source: AA0mqf6RLsB1ENKz3VM3rmc/6sfce0CAiGCTUb20MrAD03R5dH4uNh8HbsqmEwcDKscYBlck4GZaxm32VKYq6lPzpEo=
X-Received: by 2002:a67:ce83:0:b0:3aa:1bff:a8a5 with SMTP id
 c3-20020a67ce83000000b003aa1bffa8a5mr6911973vse.67.1668453278130; Mon, 14 Nov
 2022 11:14:38 -0800 (PST)
MIME-Version: 1.0
References: <20221017171118.1588820-1-sammler@google.com> <CAM9Jb+ggq5L9XZZHhfA98XDO+P=8y-mT+ct0JFAtXRbsCuORsA@mail.gmail.com>
 <CAFPP518-gU1M1XcHMHgpx=ZPPkSyjPmfOK6D+wM6t6vM6Ve6XQ@mail.gmail.com>
 <CAM9Jb+hk0ZRtXnF+WVj0LiRiO7uH-jDydJrnUQ_57yTEcs--Dw@mail.gmail.com>
 <6359ab83d6e4d_4da3294d0@dwillia2-xfh.jf.intel.com.notmuch>
 <CAHS8izOYYV+dz3vPdbkipt1i1XAU-mvJOn6c_z-NJJwzUtWzDg@mail.gmail.com> <CAM9Jb+j3MDq_HpaZXYaMWmc4OhXob9hQiLLeSvaJfGa2LoPBDw@mail.gmail.com>
In-Reply-To: <CAM9Jb+j3MDq_HpaZXYaMWmc4OhXob9hQiLLeSvaJfGa2LoPBDw@mail.gmail.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Mon, 14 Nov 2022 11:14:26 -0800
Message-ID: <CAHS8izNgmwjwyTyFzXWKrM==nTO0CJEW3+mUoKmtYjPushL5-g@mail.gmail.com>
Subject: Re: [PATCH v1] virtio_pmem: populate numa information
To:     Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Michael Sammler <sammler@google.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 13, 2022 at 9:44 AM Pankaj Gupta
<pankaj.gupta.linux@gmail.com> wrote:
>
> > > Pankaj Gupta wrote:
> > > > > > > Compute the numa information for a virtio_pmem device from the memory
> > > > > > > range of the device. Previously, the target_node was always 0 since
> > > > > > > the ndr_desc.target_node field was never explicitly set. The code for
> > > > > > > computing the numa node is taken from cxl_pmem_region_probe in
> > > > > > > drivers/cxl/pmem.c.
> > > > > > >
> > > > > > > Signed-off-by: Michael Sammler <sammler@google.com>
> >
> > Tested-by: Mina Almasry <almasrymina@google.com>
> >
> > I don't have much expertise on this driver, but with the help of this
> > patch I was able to get memory tiering [1] emulation going on qemu. As
> > far as I know there is no alternative to this emulation, and so I
> > would love to see this or equivalent merged, if possible.
> >
> > This is what I have going to get memory tiering emulation:
> >
> > In qemu, added these configs:
> >       -object memory-backend-file,id=m4,share=on,mem-path="$path_to_virtio_pmem_file",size=2G
> > \
> >       -smp 2,sockets=2,maxcpus=2  \
> >       -numa node,nodeid=0,memdev=m0 \
> >       -numa node,nodeid=1,memdev=m1 \
> >       -numa node,nodeid=2,memdev=m2,initiator=0 \
> >       -numa node,nodeid=3,initiator=0 \
> >       -device virtio-pmem-pci,memdev=m4,id=nvdimm1 \
> >
> > On boot, ran these commands:
> >     ndctl_static create-namespace -e namespace0.0 -m devdax -f 1&> /dev/null
> >     echo dax0.0 > /sys/bus/dax/drivers/device_dax/unbind
> >     echo dax0.0 > /sys/bus/dax/drivers/kmem/new_id
> >     for i in `ls /sys/devices/system/memory/`; do
> >       state=$(cat "/sys/devices/system/memory/$i/state" 2&>/dev/null)
> >       if [ "$state" == "offline" ]; then
> >         echo online_movable > "/sys/devices/system/memory/$i/state"
> >       fi
> >     done
>
> Nice to see the way to handle the virtio-pmem device memory through kmem driver
> and online the corresponding memory blocks to 'zone_movable'.
>
> This also opens way to use this memory range directly irrespective of attached
> block device. Of course there won't be any persistent data guarantee. But good
> way to simulate memory tiering inside guest as demonstrated below.
> >
> > Without this CL, I see the memory onlined in node 0 always, and is not
> > a separate memory tier. With this CL and qemu configs, the memory is
> > onlined in node 3 and is set as a separate memory tier, which enables
> > qemu-based development:
> >
> > ==> /sys/devices/virtual/memory_tiering/memory_tier22/nodelist <==
> > 3
> > ==> /sys/devices/virtual/memory_tiering/memory_tier4/nodelist <==
> > 0-2
> >
> > AFAIK there is no alternative to enabling memory tiering emulation in
> > qemu, and would love to see this or equivalent merged, if possible.
>
> Just wondering if Qemu vNVDIMM device can also achieve this?
>

I spent a few minutes on this. Please note I'm really not familiar
with these drivers, but as far as I can tell the qemu vNVDIMM device
has the same problem and needs a similar fix to this to what Michael
did here. What I did with vNVDIMM qemu device:

- Added these qemu configs:
      -object memory-backend-file,id=m4,share=on,mem-path=./hello,size=2G,readonly=off
\
      -device nvdimm,id=nvdimm1,memdev=m4,unarmed=off \

- Ran the same commands in my previous email (they seem to apply to
the vNVDIMM device without modification):
    ndctl_static create-namespace -e namespace0.0 -m devdax -f 1&> /dev/null
    echo dax0.0 > /sys/bus/dax/drivers/device_dax/unbind
    echo dax0.0 > /sys/bus/dax/drivers/kmem/new_id
    for i in `ls /sys/devices/system/memory/`; do
      state=$(cat "/sys/devices/system/memory/$i/state" 2&>/dev/null)
      if [ "$state" == "offline" ]; then
        echo online_movable > "/sys/devices/system/memory/$i/state"
      fi
    done

I see the memory from the vNVDIMM device get onlined on node0, and is
not detected as a separate memory tier. I suspect that driver needs a
similar fix to this one.

> In any case, this patch is useful, So,
> Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com
>
> >
> >
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/ABI/testing/sysfs-kernel-mm-memory-tiers
> >
> > > > > > > ---
> > > > > > >  drivers/nvdimm/virtio_pmem.c | 11 +++++++++--
> > > > > > >  1 file changed, 9 insertions(+), 2 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/nvdimm/virtio_pmem.c b/drivers/nvdimm/virtio_pmem.c
> > > > > > > index 20da455d2ef6..a92eb172f0e7 100644
> > > > > > > --- a/drivers/nvdimm/virtio_pmem.c
> > > > > > > +++ b/drivers/nvdimm/virtio_pmem.c
> > > > > > > @@ -32,7 +32,6 @@ static int init_vq(struct virtio_pmem *vpmem)
> > > > > > >  static int virtio_pmem_probe(struct virtio_device *vdev)
> > > > > > >  {
> > > > > > >         struct nd_region_desc ndr_desc = {};
> > > > > > > -       int nid = dev_to_node(&vdev->dev);
> > > > > > >         struct nd_region *nd_region;
> > > > > > >         struct virtio_pmem *vpmem;
> > > > > > >         struct resource res;
> > > > > > > @@ -79,7 +78,15 @@ static int virtio_pmem_probe(struct virtio_device *vdev)
> > > > > > >         dev_set_drvdata(&vdev->dev, vpmem->nvdimm_bus);
> > > > > > >
> > > > > > >         ndr_desc.res = &res;
> > > > > > > -       ndr_desc.numa_node = nid;
> > > > > > > +
> > > > > > > +       ndr_desc.numa_node = memory_add_physaddr_to_nid(res.start);
> > > > > > > +       ndr_desc.target_node = phys_to_target_node(res.start);
> > > > > > > +       if (ndr_desc.target_node == NUMA_NO_NODE) {
> > > > > > > +               ndr_desc.target_node = ndr_desc.numa_node;
> > > > > > > +               dev_dbg(&vdev->dev, "changing target node from %d to %d",
> > > > > > > +                       NUMA_NO_NODE, ndr_desc.target_node);
> > > > > > > +       }
> > > > > >
> > > > > > As this memory later gets hotplugged using "devm_memremap_pages". I don't
> > > > > > see if 'target_node' is used for fsdax case?
> > > > > >
> > > > > > It seems to me "target_node" is used mainly for volatile range above
> > > > > > persistent memory ( e.g kmem driver?).
> > > > > >
> > > > > I am not sure if 'target_node' is used in the fsdax case, but it is
> > > > > indeed used by the devdax/kmem driver when hotplugging the memory (see
> > > > > 'dev_dax_kmem_probe' and '__dax_pmem_probe').
> > > >
> > > > Yes, but not currently for FS_DAX iiuc.
> > >
> > > The target_node is only used by the dax_kmem driver. In the FSDAX case
> > > the memory (persistent or otherwise) is mapped behind a block-device.
> > > That block-device has affinity to a CPU initiator, but that memory does
> > > not itself have any NUMA affinity or identity as a target.
> > >
> > > So:
> > >
> > > block-device NUMA node == closest CPU initiator node to the device
> > >
> > > dax-device target node == memory only NUMA node target, after onlining
