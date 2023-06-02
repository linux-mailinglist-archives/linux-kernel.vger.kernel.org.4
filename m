Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 699E671F6F6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 02:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbjFBABp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 20:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbjFBABn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 20:01:43 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407981A5;
        Thu,  1 Jun 2023 17:01:41 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-53f70f7c2d2so922918a12.3;
        Thu, 01 Jun 2023 17:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685664100; x=1688256100;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=93AdyG83HyxVnXaMo7sA8WZyZkxYZ/RccX4TOVu/C4s=;
        b=VV0r3rsC+gzwtZhbR6SRIxP1YPYMh+vFr7XPIKHPLYgkaOzVPSjxk3jmTVNMx3JuyZ
         rsVBXKADShH2J/xdvbmHEQ4CB2fj9Soow/U8DnbcS3BBqBIwzh8JspOHPFUCknxF7kYR
         RC9C+nYQgTVLUOBGfrB2PjLUCaPOSA184pINCYMY7Qo/3wzmoAVd2aiLvmqAolRIONqh
         u1g19En54Ao1tyBydYgHq2W21O/wg3lzwyhAmB7XAe66nSPXQkvx3XIhRbm3wM5hxfcu
         0kAio9s7taW6rnglYLpB93vPgYdWzh9QT5cQzZCS9mWVszrh5b4B4EgmB0i7I8cwkGL9
         arxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685664100; x=1688256100;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=93AdyG83HyxVnXaMo7sA8WZyZkxYZ/RccX4TOVu/C4s=;
        b=eRLOs5ATlb5yVBy9czLkNCs+nraUyGxGGr8oT0WiBMa/ko9wtSkyRdZVRGxVXrjdhm
         u1BbWLG52gDPmxKX9KeiKfH1gqlq8ofBuW7CYCS4XXqOmycpaETyQXpeq7SD83ymNKul
         ydExSU8Zfyij7rgfRFCWQP99xQB/A31GwOf5Ut5A30O52J8wA9URLqS/ggxBXnQ+oEQ1
         MsNWWW2RkVHBB5WwyV67iqzu1yAesGrMtREFb5TmiFPn02UMomxtHplWz8tSW1tZSTxv
         v71x2KwTwLl83OZwOG+CoNuDkik8r1ku5X53Wf4so0XO04zvgAhtQ8ReKLivZfYU31SX
         kOFg==
X-Gm-Message-State: AC+VfDxeAYbAQl8hVWBuPA9ixsrVY8CLUjbIvDXyT73Dxl/51swMzGuY
        UJUh93dBOfDUIXP4vXJPhxQ=
X-Google-Smtp-Source: ACHHUZ5THhBGMCfAmSzS/ioq25KBw5L0O65vhmB+0J8a4/fpA8qair3Z0fIPhVFMX+By3qAv9ZgXLw==
X-Received: by 2002:a17:902:e884:b0:1b0:7c3c:31f9 with SMTP id w4-20020a170902e88400b001b07c3c31f9mr840365plg.53.1685664100488;
        Thu, 01 Jun 2023 17:01:40 -0700 (PDT)
Received: from localhost ([2405:6581:d4e0:1600:c494:2aca:bc01:6f7b])
        by smtp.gmail.com with ESMTPSA id x11-20020a170902ea8b00b001ab1b7bae5asm4072981plb.184.2023.06.01.17.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 17:01:40 -0700 (PDT)
Date:   Fri, 2 Jun 2023 09:01:38 +0900
From:   Nick Hastings <nicholaschastings@gmail.com>
To:     Karol Herbst <kherbst@redhat.com>
Cc:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Lyude Paul <lyude@redhat.com>, Lukas Wunner <lukas@wunner.de>,
        Salvatore Bonaccorso <carnil@debian.org>,
        "1036530@bugs.debian.org" <1036530@bugs.debian.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: Regression from "ACPI: OSI: Remove Linux-Dell-Video _OSI
 string"? (was: Re: Bug#1036530: linux-signed-amd64: Hard lock up of system)
Message-ID: <ZHkxYo/a+/uInkLG@xps>
References: <ZHUt9xQKCwCflvVC@xps>
 <8537d965-ddf4-7f45-6459-d5acf520376e@amd.com>
 <ZHWfMBeAONerAJmd@xps>
 <ZHfa/wQlaVCeUC22@xps>
 <fe0ab1fa-6ed6-dc64-8165-8fc70669317b@amd.com>
 <CACO55tsuO1kQUFfPdPFUHm4WEQseCR2tQSDhFRzR+8wOECZCyA@mail.gmail.com>
 <MN0PR12MB61017541F5AC55485A490BCDE2499@MN0PR12MB6101.namprd12.prod.outlook.com>
 <CACO55tudULtvt_Hcdg+uqXeYkSAR_NZ1oD=R_KhuE_THSRe88g@mail.gmail.com>
 <MN0PR12MB6101DE067CF85E59AF187763E2499@MN0PR12MB6101.namprd12.prod.outlook.com>
 <CACO55tuqAH5Zt+X9pjLFZ-RcFgxpgjpqmrAHPvm4=fb_DMBHyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACO55tuqAH5Zt+X9pjLFZ-RcFgxpgjpqmrAHPvm4=fb_DMBHyw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Karol Herbst <kherbst@redhat.com> [230602 03:10]:
> On Thu, Jun 1, 2023 at 7:21 PM Limonciello, Mario
> <Mario.Limonciello@amd.com> wrote:
> > > -----Original Message-----
> > > From: Karol Herbst <kherbst@redhat.com>
> > > Sent: Thursday, June 1, 2023 12:19 PM
> > > To: Limonciello, Mario <Mario.Limonciello@amd.com>
> > > Cc: Nick Hastings <nicholaschastings@gmail.com>; Lyude Paul
> > > <lyude@redhat.com>; Lukas Wunner <lukas@wunner.de>; Salvatore
> > > Bonaccorso <carnil@debian.org>; 1036530@bugs.debian.org; Rafael J.
> > > Wysocki <rafael@kernel.org>; Len Brown <lenb@kernel.org>; linux-
> > > acpi@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > regressions@lists.linux.dev
> > > Subject: Re: Regression from "ACPI: OSI: Remove Linux-Dell-Video _OSI
> > > string"? (was: Re: Bug#1036530: linux-signed-amd64: Hard lock up of system)
> > >
> > > On Thu, Jun 1, 2023 at 6:54 PM Limonciello, Mario
> > > <Mario.Limonciello@amd.com> wrote:
> > > >
> > > > [AMD Official Use Only - General]
> > > >
> > > > > -----Original Message-----
> > > > > From: Karol Herbst <kherbst@redhat.com>
> > > > > Sent: Thursday, June 1, 2023 11:33 AM
> > > > > To: Limonciello, Mario <Mario.Limonciello@amd.com>
> > > > > Cc: Nick Hastings <nicholaschastings@gmail.com>; Lyude Paul
> > > > > <lyude@redhat.com>; Lukas Wunner <lukas@wunner.de>; Salvatore
> > > > > Bonaccorso <carnil@debian.org>; 1036530@bugs.debian.org; Rafael J.
> > > > > Wysocki <rafael@kernel.org>; Len Brown <lenb@kernel.org>; linux-
> > > > > acpi@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > > > regressions@lists.linux.dev
> > > > > Subject: Re: Regression from "ACPI: OSI: Remove Linux-Dell-Video _OSI
> > > > > string"? (was: Re: Bug#1036530: linux-signed-amd64: Hard lock up of
> > > system)
> > > > >
> > > > > On Thu, Jun 1, 2023 at 6:18 PM Limonciello, Mario
> > > > > >
> > > > > > Lyude, Lukas, Karol
> > > > > >
> > > > > > This thread is in relation to this commit:
> > > > > >
> > > > > > 24867516f06d ("ACPI: OSI: Remove Linux-Dell-Video _OSI string")
> > > > > >
> > > > > > Nick has found that runtime PM is *not* working for nouveau.
> > > > > >
> > > > >
> > > > > keep in mind we have a list of PCIe controllers where we apply a
> > > > > workaround:
> > > > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers
> > > > > /gpu/drm/nouveau/nouveau_drm.c?h=v6.4-rc4#n682
> > > > >
> > > > > And I suspect there might be one or two more IDs we'll have to add
> > > > > there. Do we have any logs?
> > > >
> > > > There's some archived onto the distro bug.  Search this page for
> > > "journalctl.log.gz"
> > > > https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1036530
> > > >
> > >
> > > interesting.. It seems to be the same controller used here. I wonder
> > > if the pci topology is different or if the workaround is applied at
> > > all.
> >
> > I didn't see the message in the log about the workaround being applied
> > in that log, so I guess PCI topology difference is a likely suspect.
> >
>
> yeah, but I also couldn't see a log with the usual nouveau messages,
> so it's kinda weird.
>
> Anyway, the output of `lspci -tvnn` would help

% lspci -tvnn
-[0000:00]-+-00.0  Intel Corporation Device [8086:3e20]
           +-01.0-[01]----00.0  NVIDIA Corporation TU117M [GeForce GTX 1650 Mobile / Max-Q] [10de:1f91]
           +-02.0  Intel Corporation CoffeeLake-H GT2 [UHD Graphics 630] [8086:3e9b]
           +-04.0  Intel Corporation Xeon E3-1200 v5/E3-1500 v5/6th Gen Core Processor Thermal Subsystem [8086:1903]
           +-08.0  Intel Corporation Xeon E3-1200 v5/v6 / E3-1500 v5 / 6th/7th/8th Gen Core Processor Gaussian Mixture Model [8086:1911]
           +-12.0  Intel Corporation Cannon Lake PCH Thermal Controller [8086:a379]
           +-14.0  Intel Corporation Cannon Lake PCH USB 3.1 xHCI Host Controller [8086:a36d]
           +-14.2  Intel Corporation Cannon Lake PCH Shared SRAM [8086:a36f]
           +-15.0  Intel Corporation Cannon Lake PCH Serial IO I2C Controller #0 [8086:a368]
           +-15.1  Intel Corporation Cannon Lake PCH Serial IO I2C Controller #1 [8086:a369]
           +-16.0  Intel Corporation Cannon Lake PCH HECI Controller [8086:a360]
           +-17.0  Intel Corporation Cannon Lake Mobile PCH SATA AHCI Controller [8086:a353]
           +-1b.0-[02-3a]----00.0-[03-3a]--+-00.0-[04]----00.0  Intel Corporation JHL6340 Thunderbolt 3 NHI (C step) [Alpine Ridge 2C 2016] [8086:15d9]
           |                               +-01.0-[05-39]--
           |                               \-02.0-[3a]----00.0  Intel Corporation JHL6340 Thunderbolt 3 USB 3.1 Controller (C step) [Alpine Ridge 2C 2016] [8086:15db]
           +-1c.0-[3b]----00.0  Intel Corporation Wi-Fi 6 AX200 [8086:2723]
           +-1c.4-[3c]----00.0  Realtek Semiconductor Co., Ltd. RTS525A PCI Express Card Reader [10ec:525a]
           +-1d.0-[3d]----00.0  Samsung Electronics Co Ltd NVMe SSD Controller SM981/PM981/PM983 [144d:a808]
           +-1f.0  Intel Corporation Cannon Lake LPC Controller [8086:a30e]
           +-1f.3  Intel Corporation Cannon Lake PCH cAVS [8086:a348]
           +-1f.4  Intel Corporation Cannon Lake PCH SMBus Controller [8086:a323]
           \-1f.5  Intel Corporation Cannon Lake PCH SPI Controller
           [8086:a324]


Regards,

Nick.

