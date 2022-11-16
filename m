Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05FFD62C0C9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 15:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbiKPO3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 09:29:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232431AbiKPO3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 09:29:02 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582D31BE9C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 06:28:59 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id cn2-20020a056830658200b0066c74617e3dso10504160otb.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 06:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dW+j6vlBeIXuiItzPahHl5X8Hwnl4fG3Q+o+UI0piaY=;
        b=Yccn5EL+fuE5Ekgmdm/U+eFMQrvXsX0/bs3Fe3602EwJ9SDTAL4Rpl3DgHdIg9bGCP
         LOtwUJuSuy8arCkhsGnhDznVzvXcALniFn2X+Aknx7mmyKqMKGni0B7fjHb7C5qfPqqJ
         G5cKLXleGdvznZ1ASi8SmlpsGP84cecrM1Fwsw4DdZSeXyNZe0lS5+YvAGMihskNnN6Q
         Xg5sUOnjiaEPWSpIW6+FBTrIIoMIcXOTDI45qBPKxBAsOwBoL+mJMMY1NuiqCqCpWG8b
         eTIxZnXCBFn6gC3MPyAuYmye6c7E7uh22yLNVU35Q9S65eM7bKfJ/bpW8jhR/3T0Ysm/
         doFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dW+j6vlBeIXuiItzPahHl5X8Hwnl4fG3Q+o+UI0piaY=;
        b=e0HuVMruVFO2b+EXNS4BQTA01LPEh8QaQ4oNzc7hmQht9Ca3Ag+hwcsLpxXgWIq/E+
         tLvh8HG1h2px9OQw5VvIYijQFU3QAMAG0A1V5ci0N+sjv0FQNNI3B4CxP70yaS8SW5ht
         klQxbBGoDVy06UgAvsVaBwtcwwAvYrSPHC2JKcEHccCv5bnQflYwXiVwdj5b34ZWmp5S
         ZU+X41vDMXxBgmz+kPheAWTZJIKSoBc6kxBFxG1KmKcGRPxe+pOe2E4i1NO46vmiIwUV
         wvvGpxtT6PoP6E0B7YMbrkaXLN3sQVJVS+om1g8LTXyT5Wtdo4EJuawvK/FBRYWTcSG3
         5hfw==
X-Gm-Message-State: ANoB5plk1X8VZMJZP/7zo6yNOfGH8mptn1wBZC24THEOJ9ssw3Zmo1l6
        JfMeM6Hfl0JVa5WMNtFjus5ht7ScsIkWo0234KA=
X-Google-Smtp-Source: AA0mqf5yDqnDExppw74B0AFVkl99kubkthLQ2UtoLeQJpUu3tMAU43IHh3d3g8VXFgrD4JTJWiHJgXT4QpIOGbopB0s=
X-Received: by 2002:a9d:2483:0:b0:661:9fdf:fd7e with SMTP id
 z3-20020a9d2483000000b006619fdffd7emr10857351ota.250.1668608938634; Wed, 16
 Nov 2022 06:28:58 -0800 (PST)
MIME-Version: 1.0
References: <20221017171118.1588820-1-sammler@google.com> <CAM9Jb+ggq5L9XZZHhfA98XDO+P=8y-mT+ct0JFAtXRbsCuORsA@mail.gmail.com>
 <CAFPP518-gU1M1XcHMHgpx=ZPPkSyjPmfOK6D+wM6t6vM6Ve6XQ@mail.gmail.com>
 <CAM9Jb+hk0ZRtXnF+WVj0LiRiO7uH-jDydJrnUQ_57yTEcs--Dw@mail.gmail.com>
 <6359ab83d6e4d_4da3294d0@dwillia2-xfh.jf.intel.com.notmuch>
 <CAHS8izOYYV+dz3vPdbkipt1i1XAU-mvJOn6c_z-NJJwzUtWzDg@mail.gmail.com>
 <CAM9Jb+j3MDq_HpaZXYaMWmc4OhXob9hQiLLeSvaJfGa2LoPBDw@mail.gmail.com> <CAHS8izNgmwjwyTyFzXWKrM==nTO0CJEW3+mUoKmtYjPushL5-g@mail.gmail.com>
In-Reply-To: <CAHS8izNgmwjwyTyFzXWKrM==nTO0CJEW3+mUoKmtYjPushL5-g@mail.gmail.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Wed, 16 Nov 2022 15:28:46 +0100
Message-ID: <CAM9Jb+heC0nu6P+Pt-kH46Q0W3YSJvcV8VMgLCDSC7a8h6h7dg@mail.gmail.com>
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

> > > > > > > > Compute the numa information for a virtio_pmem device from the memory
> > > > > > > > range of the device. Previously, the target_node was always 0 since
> > > > > > > > the ndr_desc.target_node field was never explicitly set. The code for
> > > > > > > > computing the numa node is taken from cxl_pmem_region_probe in
> > > > > > > > drivers/cxl/pmem.c.
> > > > > > > >
> > > > > > > > Signed-off-by: Michael Sammler <sammler@google.com>
> > >
> > > Tested-by: Mina Almasry <almasrymina@google.com>
> > >
> > > I don't have much expertise on this driver, but with the help of this
> > > patch I was able to get memory tiering [1] emulation going on qemu. As
> > > far as I know there is no alternative to this emulation, and so I
> > > would love to see this or equivalent merged, if possible.
> > >
> > > This is what I have going to get memory tiering emulation:
> > >
> > > In qemu, added these configs:
> > >       -object memory-backend-file,id=m4,share=on,mem-path="$path_to_virtio_pmem_file",size=2G
> > > \
> > >       -smp 2,sockets=2,maxcpus=2  \
> > >       -numa node,nodeid=0,memdev=m0 \
> > >       -numa node,nodeid=1,memdev=m1 \
> > >       -numa node,nodeid=2,memdev=m2,initiator=0 \
> > >       -numa node,nodeid=3,initiator=0 \
> > >       -device virtio-pmem-pci,memdev=m4,id=nvdimm1 \
> > >
> > > On boot, ran these commands:
> > >     ndctl_static create-namespace -e namespace0.0 -m devdax -f 1&> /dev/null
> > >     echo dax0.0 > /sys/bus/dax/drivers/device_dax/unbind
> > >     echo dax0.0 > /sys/bus/dax/drivers/kmem/new_id
> > >     for i in `ls /sys/devices/system/memory/`; do
> > >       state=$(cat "/sys/devices/system/memory/$i/state" 2&>/dev/null)
> > >       if [ "$state" == "offline" ]; then
> > >         echo online_movable > "/sys/devices/system/memory/$i/state"
> > >       fi
> > >     done
> >
> > Nice to see the way to handle the virtio-pmem device memory through kmem driver
> > and online the corresponding memory blocks to 'zone_movable'.
> >
> > This also opens way to use this memory range directly irrespective of attached
> > block device. Of course there won't be any persistent data guarantee. But good
> > way to simulate memory tiering inside guest as demonstrated below.
> > >
> > > Without this CL, I see the memory onlined in node 0 always, and is not
> > > a separate memory tier. With this CL and qemu configs, the memory is
> > > onlined in node 3 and is set as a separate memory tier, which enables
> > > qemu-based development:
> > >
> > > ==> /sys/devices/virtual/memory_tiering/memory_tier22/nodelist <==
> > > 3
> > > ==> /sys/devices/virtual/memory_tiering/memory_tier4/nodelist <==
> > > 0-2
> > >
> > > AFAIK there is no alternative to enabling memory tiering emulation in
> > > qemu, and would love to see this or equivalent merged, if possible.
> >
> > Just wondering if Qemu vNVDIMM device can also achieve this?
> >
>
> I spent a few minutes on this. Please note I'm really not familiar
> with these drivers, but as far as I can tell the qemu vNVDIMM device
> has the same problem and needs a similar fix to this to what Michael
> did here. What I did with vNVDIMM qemu device:
>
> - Added these qemu configs:
>       -object memory-backend-file,id=m4,share=on,mem-path=./hello,size=2G,readonly=off
> \
>       -device nvdimm,id=nvdimm1,memdev=m4,unarmed=off \
>
> - Ran the same commands in my previous email (they seem to apply to
> the vNVDIMM device without modification):
>     ndctl_static create-namespace -e namespace0.0 -m devdax -f 1&> /dev/null
>     echo dax0.0 > /sys/bus/dax/drivers/device_dax/unbind
>     echo dax0.0 > /sys/bus/dax/drivers/kmem/new_id
>     for i in `ls /sys/devices/system/memory/`; do
>       state=$(cat "/sys/devices/system/memory/$i/state" 2&>/dev/null)
>       if [ "$state" == "offline" ]; then
>         echo online_movable > "/sys/devices/system/memory/$i/state"
>       fi
>     done
>
> I see the memory from the vNVDIMM device get onlined on node0, and is
> not detected as a separate memory tier. I suspect that driver needs a
> similar fix to this one.

Thanks for trying. It seems vNVDIMM device already has an option to provide
the target node[1].

[1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg827765.html
