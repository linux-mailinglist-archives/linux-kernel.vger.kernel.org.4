Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6D9743C6C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 15:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbjF3NKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 09:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232498AbjF3NK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 09:10:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE213A87
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 06:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688130573;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xc5/Cp59uA+b5Eo0Vu+fzIijEsuICv4yiOmEUWQV4Qc=;
        b=C+aprVofcNt3xvIh6qD/iKKYoWoOOVP3O3F1S7cyVuljR1FiwwpwDguZZ5iV3XG5vBcXxk
        3UWA3xvTua5QsCLXwifzEG3EkeicioRw3gsxv4b06UAp5pp0yOUMp/kua3fzwJ9clxYwjc
        t94qaOCo/kMKrxyVNqIWj8sX8Sn6pcA=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-MXxbWW9XMASNKjIQFdNI9Q-1; Fri, 30 Jun 2023 09:09:32 -0400
X-MC-Unique: MXxbWW9XMASNKjIQFdNI9Q-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2b6a011a980so1849921fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 06:09:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688130571; x=1690722571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xc5/Cp59uA+b5Eo0Vu+fzIijEsuICv4yiOmEUWQV4Qc=;
        b=A+UrQTin45RjA2yPfeg7kjvm1JFPaHAHmg7QYYiS3ttaPOgr1yORhqNj7FQEKQCha2
         GM/cvv6oHYZXS1PhWL2p32DrxretsSnLG/dNLMYNW8l0f/FDRvdu32xJNaxt6pXI/2nj
         1t7TeZCaO2GcFhEjzWsbUsduOySV8b1N79S9+Ytf4qOyZLCQv5YYk2Cz/Te2HEc54ygn
         jIRLFKQCe5VHjAeUNHROOZrYl5XIQmX5dMGpqTpDVAbmzaG+c/d/kqVzyqoO48XRYUT3
         zhZEMx4U3/EPkM4EarSatYY/t88P8oyLnfMH3JElLuxCu+gljQn0lA7SudCRrmrFSxu1
         UluQ==
X-Gm-Message-State: ABy/qLYTkwgMpoKk5cEjcRy9lYuMdRAG/GUf0c8uJahhpgXjvemZN5Dr
        O+JlqDVduTa8H/8oh0lkDIXGikaalmGYgTM7lhQvxNAP0871XgZq7zs1QpTXR2Ksyvslom+2mer
        LQgZcfSZ/qBDQ8DWc8YYYyZ+keSgVzef6ncu8yn9b
X-Received: by 2002:a2e:6f16:0:b0:2b6:7c3a:6adc with SMTP id k22-20020a2e6f16000000b002b67c3a6adcmr1591792ljc.5.1688130570957;
        Fri, 30 Jun 2023 06:09:30 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEvM04R7k1TF7SARhjetpFa6GX9qx3D4A9ib7WFaaSP0Ffc7ekaneq28s4k2kuk0Evc9Fi5M2fZ/59eoh30Sic=
X-Received: by 2002:a2e:6f16:0:b0:2b6:7c3a:6adc with SMTP id
 k22-20020a2e6f16000000b002b67c3a6adcmr1591772ljc.5.1688130570624; Fri, 30 Jun
 2023 06:09:30 -0700 (PDT)
MIME-Version: 1.0
References: <ZHfa/wQlaVCeUC22@xps> <fe0ab1fa-6ed6-dc64-8165-8fc70669317b@amd.com>
 <CACO55tsuO1kQUFfPdPFUHm4WEQseCR2tQSDhFRzR+8wOECZCyA@mail.gmail.com>
 <MN0PR12MB61017541F5AC55485A490BCDE2499@MN0PR12MB6101.namprd12.prod.outlook.com>
 <CACO55tudULtvt_Hcdg+uqXeYkSAR_NZ1oD=R_KhuE_THSRe88g@mail.gmail.com>
 <MN0PR12MB6101DE067CF85E59AF187763E2499@MN0PR12MB6101.namprd12.prod.outlook.com>
 <CACO55tuqAH5Zt+X9pjLFZ-RcFgxpgjpqmrAHPvm4=fb_DMBHyw@mail.gmail.com>
 <ZHkxYo/a+/uInkLG@xps> <MN0PR12MB610181D29933EE4787DE9BC8E24EA@MN0PR12MB6101.namprd12.prod.outlook.com>
 <ed5f982e-c12c-b3a2-1108-62fba50bf9db@leemhuis.info> <ZJoSWftrHO65wmxz@xps> <35e9ae66-76d0-5a17-31e6-7aa8de5bfadd@leemhuis.info>
In-Reply-To: <35e9ae66-76d0-5a17-31e6-7aa8de5bfadd@leemhuis.info>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Fri, 30 Jun 2023 15:09:19 +0200
Message-ID: <CACO55ts9sJaxmVAdCVBRYwghQDtHVqWLUsPTngni2DpgzpucxQ@mail.gmail.com>
Subject: Re: Regression from "ACPI: OSI: Remove Linux-Dell-Video _OSI string"?
 (was: Re: Bug#1036530: linux-signed-amd64: Hard lock up of system)
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Nick Hastings <nicholaschastings@gmail.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Lyude Paul <lyude@redhat.com>, Lukas Wunner <lukas@wunner.de>,
        Salvatore Bonaccorso <carnil@debian.org>,
        "1036530@bugs.debian.org" <1036530@bugs.debian.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023 at 3:02=E2=80=AFPM Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
>
> On 27.06.23 00:34, Nick Hastings wrote:
> > * Linux regression tracking (Thorsten Leemhuis) <regressions@leemhuis.i=
nfo> [230626 21:09]:
> >> Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
> >> for once, to make this easily accessible to everyone.
> >>
> >> Nick, what's the status/was there any progress? Did you do what Mario
> >> suggested and file a nouveau bug?
> >
> > It was not apparent that the suggestion to open "a Nouveau drm bug" was
> > addressed to me.
>
> I wish things were earlier for reporters, but from what I can see this
> is the only way forward if you or some silent bystander cares.
>
> >> I ask, as I still have this on my list of regressions and it seems the=
re
> >> was no progress in three+ weeks now.
> >
> > I have not pursued this further since as far as I could tell I already
> > provided all requested information and I don't actually use nouveau, so
> > I blacklisted it.
>
> I doubt any developer cares enough to take a closer look[1] without a
> proper nouveau bug and some help & prodding from someone affected. And
> looks to me like reverting the culprit now might create even bigger
> problems for users.
>
> Hence I guess then this won't be fixed in the end. In a ideal world this
> would not happen, but we don't live in one and all have just 24 hours in
> a day. :-/
>

We recently merged this commit:
https://gitlab.freedesktop.org/drm/nouveau/-/commit/11d24327c2d7ad7f24fcc44=
fb00e1fa91ebf6525

It might resolve the problem. Worth testing at least, but I can't
remember if this was a hybrid AMD/Nvidia system, but I think it was?

> Nevertheless: thx for your report your help through this thread.
>
> [1] some points on the following page kinda explain this
> https://linux-regtracking.leemhuis.info/post/frequent-reasons-why-linux-k=
ernel-bug-reports-are-ignored/
>
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
>
> #regzbot inconclusive: reporting deadlock (see thread for details)
>
>
>
> >> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' ha=
t)
> >> --
> >> Everything you wanna know about Linux kernel regression tracking:
> >> https://linux-regtracking.leemhuis.info/about/#tldr
> >> If I did something stupid, please tell me, as explained on that page.
> >>
> >> #regzbot backburner: slow progress, likely just affects one machine
> >> #regzbot poke
> >>
> >>
> >> On 02.06.23 02:57, Limonciello, Mario wrote:
> >>> [AMD Official Use Only - General]
> >>>
> >>>> -----Original Message-----
> >>>> From: Nick Hastings <nicholaschastings@gmail.com>
> >>>> Sent: Thursday, June 1, 2023 7:02 PM
> >>>> To: Karol Herbst <kherbst@redhat.com>
> >>>> Cc: Limonciello, Mario <Mario.Limonciello@amd.com>; Lyude Paul
> >>>> <lyude@redhat.com>; Lukas Wunner <lukas@wunner.de>; Salvatore
> >>>> Bonaccorso <carnil@debian.org>; 1036530@bugs.debian.org; Rafael J.
> >>>> Wysocki <rafael@kernel.org>; Len Brown <lenb@kernel.org>; linux-
> >>>> acpi@vger.kernel.org; linux-kernel@vger.kernel.org;
> >>>> regressions@lists.linux.dev
> >>>> Subject: Re: Regression from "ACPI: OSI: Remove Linux-Dell-Video _OS=
I
> >>>> string"? (was: Re: Bug#1036530: linux-signed-amd64: Hard lock up of =
system)
> >>>>
> >>>> Hi,
> >>>>
> >>>> * Karol Herbst <kherbst@redhat.com> [230602 03:10]:
> >>>>> On Thu, Jun 1, 2023 at 7:21=E2=80=AFPM Limonciello, Mario
> >>>>> <Mario.Limonciello@amd.com> wrote:
> >>>>>>> -----Original Message-----
> >>>>>>> From: Karol Herbst <kherbst@redhat.com>
> >>>>>>> Sent: Thursday, June 1, 2023 12:19 PM
> >>>>>>> To: Limonciello, Mario <Mario.Limonciello@amd.com>
> >>>>>>> Cc: Nick Hastings <nicholaschastings@gmail.com>; Lyude Paul
> >>>>>>> <lyude@redhat.com>; Lukas Wunner <lukas@wunner.de>; Salvatore
> >>>>>>> Bonaccorso <carnil@debian.org>; 1036530@bugs.debian.org; Rafael J=
.
> >>>>>>> Wysocki <rafael@kernel.org>; Len Brown <lenb@kernel.org>; linux-
> >>>>>>> acpi@vger.kernel.org; linux-kernel@vger.kernel.org;
> >>>>>>> regressions@lists.linux.dev
> >>>>>>> Subject: Re: Regression from "ACPI: OSI: Remove Linux-Dell-Video =
_OSI
> >>>>>>> string"? (was: Re: Bug#1036530: linux-signed-amd64: Hard lock up =
of
> >>>> system)
> >>>>>>>
> >>>>>>> On Thu, Jun 1, 2023 at 6:54=E2=80=AFPM Limonciello, Mario
> >>>>>>> <Mario.Limonciello@amd.com> wrote:
> >>>>>>>>
> >>>>>>>> [AMD Official Use Only - General]
> >>>>>>>>
> >>>>>>>>> -----Original Message-----
> >>>>>>>>> From: Karol Herbst <kherbst@redhat.com>
> >>>>>>>>> Sent: Thursday, June 1, 2023 11:33 AM
> >>>>>>>>> To: Limonciello, Mario <Mario.Limonciello@amd.com>
> >>>>>>>>> Cc: Nick Hastings <nicholaschastings@gmail.com>; Lyude Paul
> >>>>>>>>> <lyude@redhat.com>; Lukas Wunner <lukas@wunner.de>; Salvatore
> >>>>>>>>> Bonaccorso <carnil@debian.org>; 1036530@bugs.debian.org; Rafael
> >>>> J.
> >>>>>>>>> Wysocki <rafael@kernel.org>; Len Brown <lenb@kernel.org>; linux=
-
> >>>>>>>>> acpi@vger.kernel.org; linux-kernel@vger.kernel.org;
> >>>>>>>>> regressions@lists.linux.dev
> >>>>>>>>> Subject: Re: Regression from "ACPI: OSI: Remove Linux-Dell-Vide=
o
> >>>> _OSI
> >>>>>>>>> string"? (was: Re: Bug#1036530: linux-signed-amd64: Hard lock u=
p of
> >>>>>>> system)
> >>>>>>>>>
> >>>>>>>>> On Thu, Jun 1, 2023 at 6:18=E2=80=AFPM Limonciello, Mario
> >>>>>>>>>>
> >>>>>>>>>> Lyude, Lukas, Karol
> >>>>>>>>>>
> >>>>>>>>>> This thread is in relation to this commit:
> >>>>>>>>>>
> >>>>>>>>>> 24867516f06d ("ACPI: OSI: Remove Linux-Dell-Video _OSI string"=
)
> >>>>>>>>>>
> >>>>>>>>>> Nick has found that runtime PM is *not* working for nouveau.
> >>>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> keep in mind we have a list of PCIe controllers where we apply =
a
> >>>>>>>>> workaround:
> >>>>>>>>>
> >>>>>>>
> >>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/t=
ree/drivers
> >>>>>>>>> /gpu/drm/nouveau/nouveau_drm.c?h=3Dv6.4-rc4#n682
> >>>>>>>>>
> >>>>>>>>> And I suspect there might be one or two more IDs we'll have to =
add
> >>>>>>>>> there. Do we have any logs?
> >>>>>>>>
> >>>>>>>> There's some archived onto the distro bug.  Search this page for
> >>>>>>> "journalctl.log.gz"
> >>>>>>>> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1036530
> >>>>>>>>
> >>>>>>>
> >>>>>>> interesting.. It seems to be the same controller used here. I won=
der
> >>>>>>> if the pci topology is different or if the workaround is applied =
at
> >>>>>>> all.
> >>>>>>
> >>>>>> I didn't see the message in the log about the workaround being app=
lied
> >>>>>> in that log, so I guess PCI topology difference is a likely suspec=
t.
> >>>>>>
> >>>>>
> >>>>> yeah, but I also couldn't see a log with the usual nouveau messages=
,
> >>>>> so it's kinda weird.
> >>>>>
> >>>>> Anyway, the output of `lspci -tvnn` would help
> >>>>
> >>>> % lspci -tvnn
> >>>> -[0000:00]-+-00.0  Intel Corporation Device [8086:3e20]
> >>>>            +-01.0-[01]----00.0  NVIDIA Corporation TU117M [GeForce G=
TX 1650
> >>>> Mobile / Max-Q] [10de:1f91]
> >>>
> >>> So the bridge it's connected to is the same that the quirk *should ha=
ve been* triggering.
> >>>
> >>> May 29 15:02:42 xps kernel: pci 0000:00:01.0: [8086:1901] type 01 cla=
ss 0x060400
> >>>
> >>> Since the quirk isn't working and this is still a problem in 6.4-rc4 =
I suggest opening a
> >>> Nouveau drm bug to figure out why.
> >>>
> >>>>            +-02.0  Intel Corporation CoffeeLake-H GT2 [UHD Graphics =
630]
> >>>> [8086:3e9b]
> >>>>            +-04.0  Intel Corporation Xeon E3-1200 v5/E3-1500 v5/6th =
Gen Core
> >>>> Processor Thermal Subsystem [8086:1903]
> >>>>            +-08.0  Intel Corporation Xeon E3-1200 v5/v6 / E3-1500 v5=
 /
> >>>> 6th/7th/8th Gen Core Processor Gaussian Mixture Model [8086:1911]
> >>>>            +-12.0  Intel Corporation Cannon Lake PCH Thermal Control=
ler
> >>>> [8086:a379]
> >>>>            +-14.0  Intel Corporation Cannon Lake PCH USB 3.1 xHCI Ho=
st Controller
> >>>> [8086:a36d]
> >>>>            +-14.2  Intel Corporation Cannon Lake PCH Shared SRAM [80=
86:a36f]
> >>>>            +-15.0  Intel Corporation Cannon Lake PCH Serial IO I2C C=
ontroller #0
> >>>> [8086:a368]
> >>>>            +-15.1  Intel Corporation Cannon Lake PCH Serial IO I2C C=
ontroller #1
> >>>> [8086:a369]
> >>>>            +-16.0  Intel Corporation Cannon Lake PCH HECI Controller=
 [8086:a360]
> >>>>            +-17.0  Intel Corporation Cannon Lake Mobile PCH SATA AHC=
I Controller
> >>>> [8086:a353]
> >>>>            +-1b.0-[02-3a]----00.0-[03-3a]--+-00.0-[04]----00.0  Inte=
l Corporation
> >>>> JHL6340 Thunderbolt 3 NHI (C step) [Alpine Ridge 2C 2016] [8086:15d9=
]
> >>>>            |                               +-01.0-[05-39]--
> >>>>            |                               \-02.0-[3a]----00.0  Inte=
l Corporation JHL6340
> >>>> Thunderbolt 3 USB 3.1 Controller (C step) [Alpine Ridge 2C 2016]
> >>>> [8086:15db]
> >>>>            +-1c.0-[3b]----00.0  Intel Corporation Wi-Fi 6 AX200 [808=
6:2723]
> >>>>            +-1c.4-[3c]----00.0  Realtek Semiconductor Co., Ltd. RTS5=
25A PCI
> >>>> Express Card Reader [10ec:525a]
> >>>>            +-1d.0-[3d]----00.0  Samsung Electronics Co Ltd NVMe SSD =
Controller
> >>>> SM981/PM981/PM983 [144d:a808]
> >>>>            +-1f.0  Intel Corporation Cannon Lake LPC Controller [808=
6:a30e]
> >>>>            +-1f.3  Intel Corporation Cannon Lake PCH cAVS [8086:a348=
]
> >>>>            +-1f.4  Intel Corporation Cannon Lake PCH SMBus Controlle=
r
> >>>> [8086:a323]
> >>>>            \-1f.5  Intel Corporation Cannon Lake PCH SPI Controller
> >>>>            [8086:a324]
> >>>>
> >>>>
> >>>> Regards,
> >>>>
> >>>> Nick.
> >>>
> >
> >
> >
>

