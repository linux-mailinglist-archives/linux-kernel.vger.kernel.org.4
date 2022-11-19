Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24EF0630F16
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 15:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbiKSOIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 09:08:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbiKSOIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 09:08:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FBE36CA0D
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 06:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668866867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LxrbP82gc4CMOlqz/wR+dTRovpN0YcTjIpFuHgDP3ms=;
        b=W2wxq2mGNxfcXM+HFIhgrp4Ln1CvOOG0wPaPhnOgAp3GncgvDswgEMkpjh3VVwYqwJesdy
        paFN8rX0gKmP4Qz0MgYak7I7SoQBbjUWGaA+RDq2Ms0BtBCZupj/xx5eE98hCns31V+rYK
        cmjQqTyYAEvO6dJPek74X3TgYOhZsm8=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-658-GX5_aBEuPWC7zjazO_Xc8w-1; Sat, 19 Nov 2022 09:07:45 -0500
X-MC-Unique: GX5_aBEuPWC7zjazO_Xc8w-1
Received: by mail-il1-f198.google.com with SMTP id i8-20020a056e0212c800b00302578e6d78so5157166ilm.0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 06:07:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LxrbP82gc4CMOlqz/wR+dTRovpN0YcTjIpFuHgDP3ms=;
        b=0vI3bnUhB1pfRAcEq2cOmmMV/E+AZRP4u7amHRCacDwIGABW2R6Jyahg7JX2OG1Ra7
         CZoy1sspUkOfsT1pqpVHeLPo+lBdXJQyYi2UkuaillRc68FUCSoSP7zrP5C5S/pkCRKw
         /Ziz8X76u8fpiZYxN2W1Z8fm64P+PC5jtdCayClEhkk5V4q8V2ROeOnoFEVNOY6OIvUf
         fkhlI9kLdpncs67JI1ZskNHykMgD81N/dyQpTxpqLxdbiOKoQ+pswV+VwZ+eGDOxNQtp
         mkdDw1VkxKVSLkHAkLWLjFPlF9qzS5Oo6nDQZqrighew/pZHBlzPwtUmB+6BzSxl9HRf
         7NFg==
X-Gm-Message-State: ANoB5pmH89vDs/hMExQwY0VeevXfK9+9pBFRwGvubsRBmFuAuMPurQQH
        aEgyZAoWDJAWPIpumcyjPbOEA0hdjzfFb4leD88M3Q5iiXJRGsJ+Y+jBZypGtLG+0Jg54NJ9MJJ
        dR0XXRsMpslMWuX8xH6QeZVyX
X-Received: by 2002:a02:7306:0:b0:374:f967:4187 with SMTP id y6-20020a027306000000b00374f9674187mr5098750jab.130.1668866863866;
        Sat, 19 Nov 2022 06:07:43 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7tOREu70M5qhaRZufAFqX8HCt7/A1lrEL/trOqxZEOCkASnfkJQvz9HCQomomiUex8POAGlg==
X-Received: by 2002:a02:7306:0:b0:374:f967:4187 with SMTP id y6-20020a027306000000b00374f9674187mr5098736jab.130.1668866863555;
        Sat, 19 Nov 2022 06:07:43 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id i23-20020a02ca17000000b0035a40af60fcsm2316808jak.86.2022.11.19.06.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Nov 2022 06:07:42 -0800 (PST)
Date:   Sat, 19 Nov 2022 07:07:41 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] Resizable BARs vs bridges with BARs
Message-ID: <20221119070741.7038464f.alex.williamson@redhat.com>
In-Reply-To: <fe0e40cb-b982-2aba-b622-8534c174ea39@amd.com>
References: <20221118160916.7e165306.alex.williamson@redhat.com>
        <fe0e40cb-b982-2aba-b622-8534c174ea39@amd.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

On Sat, 19 Nov 2022 12:02:55 +0100
Christian K=C3=B6nig <christian.koenig@amd.com> wrote:

> Hi Alex,
>=20
> Am 19.11.22 um 00:09 schrieb Alex Williamson:
> > Hi,
> >
> > I'm trying to get resizable BARs working in a configuration where my
> > root bus resources provide plenty of aperture for the BAR:
> >
> > pci_bus 0000:5d: root bus resource [io  0x8000-0x9fff window]
> > pci_bus 0000:5d: root bus resource [mem 0xb8800000-0xc5ffffff window]
> > pci_bus 0000:5d: root bus resource [mem 0xb000000000-0xbfffffffff windo=
w] <<<
> > pci_bus 0000:5d: root bus resource [bus 5d-7f]
> >
> > But resizing fails with -ENOSPC.  The topology looks like this:
> >
> >   +-[0000:5d]-+-00.0-[5e-61]----00.0-[5f-61]--+-01.0-[60]----00.0  Inte=
l Corporation DG2 [Arc A380]
> >                                               \-04.0-[61]----00.0  Inte=
l Corporation Device 4f92
> >
> > The BIOS is not fluent in resizable BARs and only programs the root
> > port with a small aperture:
> >
> > 5d:00.0 PCI bridge: Intel Corporation Sky Lake-E PCI Express Root Port =
A (rev 07) (prog-if 00 [Normal decode])
> >          Bus: primary=3D5d, secondary=3D5e, subordinate=3D61, sec-laten=
cy=3D0
> >          I/O behind bridge: 0000f000-00000fff [disabled]
> >          Memory behind bridge: b9000000-ba0fffff [size=3D17M]
> >          Prefetchable memory behind bridge: 000000bfe0000000-000000bff0=
7fffff [size=3D264M]
> >          Kernel driver in use: pcieport
> >
> > The trouble comes on the upstream PCIe switch port:
> >
> > 5e:00.0 PCI bridge: Intel Corporation Device 4fa1 (rev 01) (prog-if 00 =
[Normal decode]) =20
> >     >>>  Region 0: Memory at b010000000 (64-bit, prefetchable) =20
> >          Bus: primary=3D5e, secondary=3D5f, subordinate=3D61, sec-laten=
cy=3D0
> >          I/O behind bridge: 0000f000-00000fff [disabled]
> >          Memory behind bridge: b9000000-ba0fffff [size=3D17M]
> >          Prefetchable memory behind bridge: 000000bfe0000000-000000bfef=
ffffff [size=3D256M]
> >          Kernel driver in use: pcieport
> >
> > Note region 0 of this bridge, which is 64-bit, prefetchable and
> > therefore conflicts with the same type for the resizable BAR on the GPU:
> >
> > 60:00.0 VGA compatible controller: Intel Corporation DG2 [Arc A380] (re=
v 05) (prog-if 00 [VGA controller])
> >          Region 0: Memory at b9000000 (64-bit, non-prefetchable) [disab=
led] [size=3D16M]
> >          Region 2: Memory at bfe0000000 (64-bit, prefetchable) [disable=
d] [size=3D256M]
> >          Expansion ROM at <ignored> [disabled]
> >          Capabilities: [420 v1] Physical Resizable BAR
> >                  BAR 2: current size: 256MB, supported: 256MB 512MB 1GB=
 2GB 4GB 8GB
> >
> > It's a shame that the hardware designers didn't mark the upstream port
> > BAR as non-prefetchable to avoid it living in the same resource
> > aperture as the resizable BAR on the downstream device. =20
>=20
> This is expected. Bridges always have a 32bit non prefetchable and a=20
> 64bit prefetchable BAR. This is part of the PCI(e) spec.

To be clear, the issue is a bridge implementing a 64-bit, prefetchable
BAR at config offset 0x10 & 0x14, not the limit/base registers that
define the bridge windows for prefetchable and non-prefetchable
downstream resources.

> > In any case, it's my understanding that our bridge drivers don't genera=
lly make use
> > of bridge BARs.  I think we can test whether a driver has done a
> > pci_request_region() or equivalent by looking for the IORESOURCE_BUSY
> > flag, but I also suspect this is potentially racy. =20
>=20
> That sounds like we have a misunderstanding here how those bridges work.=
=20
> The upstream bridges should include all the resources of the downstream=20
> devices/bridges in their BARs.

Correct, and the issue is that the bridge at 5e:00.0 _consumes_ a
portion of the window we need to resize at the root port.

Root port:
Prefetchable memory behind bridge: 000000bfe0000000-000000bff07fffff [size=
=3D264M]

Upstream switch port:
Region 0: Memory at b010000000 (64-bit, prefetchable)
Prefetchable memory behind bridge: 000000bfe0000000-000000bfefffffff [size=
=3D256M]

It's that Region 0 resource that prevents resizing.

> > The patch below works for me, allowing the new resourceN_resize sysfs
> > attribute to resize the root port window within the provided bus
> > window.  Is this the right answer?  How can we make it feel less
> > sketchy?  Thanks, =20
>=20
> The correct approach is to remove all the drivers (EFI, vesafb etc...)=20
> which are using the PCI(e) devices under the bridge in question. Then=20
> release the resources and puzzle everything back together.
>=20
> See amdgpu_device_resize_fb_bar() how to do this correctly.

Resource resizing in pci-sysfs is largely modeled after the amdgpu
code, but I don't see any special provisions for handling conflicting
resources consumed on intermediate devices.  The driver attached to the
upstream switch port is pcieport and removing it doesn't resolve the
problem.  The necessary resource on the root port still reports a
child.

Is amdgppu resizing known to work in cases where the GPU is downstream
of a PCIe switch that consumes resources of the same type and the root
port aperture needs to be resized?  I suspect it does not.  Thanks,

Alex

