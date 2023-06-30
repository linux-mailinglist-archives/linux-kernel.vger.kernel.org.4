Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACBAF7443FB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 23:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbjF3ViO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 17:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjF3ViK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 17:38:10 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376C935BC;
        Fri, 30 Jun 2023 14:38:09 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-666edfc50deso1521200b3a.0;
        Fri, 30 Jun 2023 14:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688161088; x=1690753088;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IWD7tfLxcvcTCa8P+h7hLCAFcbEomZRu0NTbnn5k0Rs=;
        b=nqCwmwgC/xl+Rvgi5n74y7vUJu/LmSbgRZlAd1giKGyvxXCNO5SC4nfd8Bf/xCtgER
         oyuUJEgnd/0RGiPyZM1OzHE2OlfDmamGhNdsrZ7uZeD0NXyJ3JPCyCu6uedzrUWHOrti
         EjccwktjUSTKNCazAty/EWj4S0A4L41v1ju+pVeubqp9liaemHI+EouEj1S2gQBf4MAH
         76J5vgQh5tZcO/bZRqytBKUxHMI2oOBDQ9jA/tw9jKSX5etEIsuhUkMpsfY89tC/Y/Ns
         6urovKW8X+bdiLLC3sjOYdIEFuFp4Vk8Vg5awBMOvjggIE1a72iAhQKSB205zr8y4zq6
         n0fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688161088; x=1690753088;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IWD7tfLxcvcTCa8P+h7hLCAFcbEomZRu0NTbnn5k0Rs=;
        b=VKK/eYKneTv9EihmMPWMhlM/0ONRGgFcn4cveojW5qO0y85zk4SxYApSby5kSSbXjP
         SAa4ec6LNqIPXBOC11TAqBboU70u+7eosgyMneULvj71cVsVW15Pr/omBBcZKz0KKM1D
         bO1wxBDHlcAim3P4HxAedEoeLYXMHdEGu+4Dk+xfQbI1jqm8YLlJuT9bdShcvLVI04WP
         kQoD0b93t6VZUcTJ0gNpwHzdU5N9BJ6M5n0l+uQk7muDha//b+o+/fjau09u8hUrdbX7
         Ns+3D4gCw6OEvpMxYO/EqMbe7MPG5YthQpp9+zLX2SQeLtrvG9+3PrFkkVK3pc313Rnk
         sWXA==
X-Gm-Message-State: AC+VfDxSZovqtzO+cF3I3OnAiBFKAXlyzie9ShTTDV6Okeu4HOCcjDjR
        wC/Jy7swpsyra68Ov7aFnCc=
X-Google-Smtp-Source: ACHHUZ48NX7p8s/gZfqvgvFj+I+oUA/53DxpgNowsswPiN6nF2bpkzYTjoJ41oS5bNolItoZ+By+9Q==
X-Received: by 2002:a05:6a00:3494:b0:666:6c01:2e9e with SMTP id cp20-20020a056a00349400b006666c012e9emr11025643pfb.15.1688161088486;
        Fri, 30 Jun 2023 14:38:08 -0700 (PDT)
Received: from localhost ([2405:6581:d4e0:1600:c494:2aca:bc01:6f7b])
        by smtp.gmail.com with ESMTPSA id x187-20020a6363c4000000b005533b6cb3a6sm10879305pgb.16.2023.06.30.14.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 14:38:07 -0700 (PDT)
Date:   Sat, 1 Jul 2023 06:38:05 +0900
From:   Nick Hastings <nicholaschastings@gmail.com>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>, Lukas Wunner <lukas@wunner.de>,
        Salvatore Bonaccorso <carnil@debian.org>,
        "1036530@bugs.debian.org" <1036530@bugs.debian.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>
Subject: Re: Regression from "ACPI: OSI: Remove Linux-Dell-Video _OSI
 string"? (was: Re: Bug#1036530: linux-signed-amd64: Hard lock up of system)
Message-ID: <ZJ9LPZcgkDLscww+@xps>
References: <CACO55tsuO1kQUFfPdPFUHm4WEQseCR2tQSDhFRzR+8wOECZCyA@mail.gmail.com>
 <MN0PR12MB61017541F5AC55485A490BCDE2499@MN0PR12MB6101.namprd12.prod.outlook.com>
 <CACO55tudULtvt_Hcdg+uqXeYkSAR_NZ1oD=R_KhuE_THSRe88g@mail.gmail.com>
 <MN0PR12MB6101DE067CF85E59AF187763E2499@MN0PR12MB6101.namprd12.prod.outlook.com>
 <CACO55tuqAH5Zt+X9pjLFZ-RcFgxpgjpqmrAHPvm4=fb_DMBHyw@mail.gmail.com>
 <ZHkxYo/a+/uInkLG@xps>
 <MN0PR12MB610181D29933EE4787DE9BC8E24EA@MN0PR12MB6101.namprd12.prod.outlook.com>
 <ed5f982e-c12c-b3a2-1108-62fba50bf9db@leemhuis.info>
 <ZJoSWftrHO65wmxz@xps>
 <35e9ae66-76d0-5a17-31e6-7aa8de5bfadd@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <35e9ae66-76d0-5a17-31e6-7aa8de5bfadd@leemhuis.info>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Thorsten Leemhuis <regressions@leemhuis.info> [230630 22:02]:
> On 27.06.23 00:34, Nick Hastings wrote:
> > * Linux regression tracking (Thorsten Leemhuis) <regressions@leemhuis.info> [230626 21:09]:
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

In principle I can open another bug report, but I don't know how or
where to report "a Nouveau drm bug". Please keep in mind that I'm just
an end user. I learnt to use git bisect specifically because of this
bug. Prior to that, I hadn't compiled a kernel in about 15 years.

> >> I ask, as I still have this on my list of regressions and it seems there
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

If someone can point me to some docs about for reporting nouveau bugs I
can look into it.

> Hence I guess then this won't be fixed in the end. In a ideal world this
> would not happen, but we don't live in one and all have just 24 hours in
> a day. :-/

This is a very common Dell XPS 15 7590 so I expect many people could
experience this issue. Or maybe like me they only use the intel GPU.

> Nevertheless: thx for your report your help through this thread.

No problem. I am willing to try to do more, but right now I don't know
how to do what has been suggested.

Cheers,

Nick.

> [1] some points on the following page kinda explain this
> https://linux-regtracking.leemhuis.info/post/frequent-reasons-why-linux-kernel-bug-reports-are-ignored/
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
> >> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
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
> >>>> Subject: Re: Regression from "ACPI: OSI: Remove Linux-Dell-Video _OSI
> >>>> string"? (was: Re: Bug#1036530: linux-signed-amd64: Hard lock up of system)
> >>>>
> >>>> Hi,
> >>>>
> >>>> * Karol Herbst <kherbst@redhat.com> [230602 03:10]:
> >>>>> On Thu, Jun 1, 2023 at 7:21 PM Limonciello, Mario
> >>>>> <Mario.Limonciello@amd.com> wrote:
> >>>>>>> -----Original Message-----
> >>>>>>> From: Karol Herbst <kherbst@redhat.com>
> >>>>>>> Sent: Thursday, June 1, 2023 12:19 PM
> >>>>>>> To: Limonciello, Mario <Mario.Limonciello@amd.com>
> >>>>>>> Cc: Nick Hastings <nicholaschastings@gmail.com>; Lyude Paul
> >>>>>>> <lyude@redhat.com>; Lukas Wunner <lukas@wunner.de>; Salvatore
> >>>>>>> Bonaccorso <carnil@debian.org>; 1036530@bugs.debian.org; Rafael J.
> >>>>>>> Wysocki <rafael@kernel.org>; Len Brown <lenb@kernel.org>; linux-
> >>>>>>> acpi@vger.kernel.org; linux-kernel@vger.kernel.org;
> >>>>>>> regressions@lists.linux.dev
> >>>>>>> Subject: Re: Regression from "ACPI: OSI: Remove Linux-Dell-Video _OSI
> >>>>>>> string"? (was: Re: Bug#1036530: linux-signed-amd64: Hard lock up of
> >>>> system)
> >>>>>>>
> >>>>>>> On Thu, Jun 1, 2023 at 6:54 PM Limonciello, Mario
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
> >>>>>>>>> Wysocki <rafael@kernel.org>; Len Brown <lenb@kernel.org>; linux-
> >>>>>>>>> acpi@vger.kernel.org; linux-kernel@vger.kernel.org;
> >>>>>>>>> regressions@lists.linux.dev
> >>>>>>>>> Subject: Re: Regression from "ACPI: OSI: Remove Linux-Dell-Video
> >>>> _OSI
> >>>>>>>>> string"? (was: Re: Bug#1036530: linux-signed-amd64: Hard lock up of
> >>>>>>> system)
> >>>>>>>>>
> >>>>>>>>> On Thu, Jun 1, 2023 at 6:18 PM Limonciello, Mario
> >>>>>>>>>>
> >>>>>>>>>> Lyude, Lukas, Karol
> >>>>>>>>>>
> >>>>>>>>>> This thread is in relation to this commit:
> >>>>>>>>>>
> >>>>>>>>>> 24867516f06d ("ACPI: OSI: Remove Linux-Dell-Video _OSI string")
> >>>>>>>>>>
> >>>>>>>>>> Nick has found that runtime PM is *not* working for nouveau.
> >>>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> keep in mind we have a list of PCIe controllers where we apply a
> >>>>>>>>> workaround:
> >>>>>>>>>
> >>>>>>>
> >>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers
> >>>>>>>>> /gpu/drm/nouveau/nouveau_drm.c?h=v6.4-rc4#n682
> >>>>>>>>>
> >>>>>>>>> And I suspect there might be one or two more IDs we'll have to add
> >>>>>>>>> there. Do we have any logs?
> >>>>>>>>
> >>>>>>>> There's some archived onto the distro bug.  Search this page for
> >>>>>>> "journalctl.log.gz"
> >>>>>>>> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1036530
> >>>>>>>>
> >>>>>>>
> >>>>>>> interesting.. It seems to be the same controller used here. I wonder
> >>>>>>> if the pci topology is different or if the workaround is applied at
> >>>>>>> all.
> >>>>>>
> >>>>>> I didn't see the message in the log about the workaround being applied
> >>>>>> in that log, so I guess PCI topology difference is a likely suspect.
> >>>>>>
> >>>>>
> >>>>> yeah, but I also couldn't see a log with the usual nouveau messages,
> >>>>> so it's kinda weird.
> >>>>>
> >>>>> Anyway, the output of `lspci -tvnn` would help
> >>>>
> >>>> % lspci -tvnn
> >>>> -[0000:00]-+-00.0  Intel Corporation Device [8086:3e20]
> >>>>            +-01.0-[01]----00.0  NVIDIA Corporation TU117M [GeForce GTX 1650
> >>>> Mobile / Max-Q] [10de:1f91]
> >>>
> >>> So the bridge it's connected to is the same that the quirk *should have been* triggering.
> >>>
> >>> May 29 15:02:42 xps kernel: pci 0000:00:01.0: [8086:1901] type 01 class 0x060400
> >>>
> >>> Since the quirk isn't working and this is still a problem in 6.4-rc4 I suggest opening a
> >>> Nouveau drm bug to figure out why.
> >>>
> >>>>            +-02.0  Intel Corporation CoffeeLake-H GT2 [UHD Graphics 630]
> >>>> [8086:3e9b]
> >>>>            +-04.0  Intel Corporation Xeon E3-1200 v5/E3-1500 v5/6th Gen Core
> >>>> Processor Thermal Subsystem [8086:1903]
> >>>>            +-08.0  Intel Corporation Xeon E3-1200 v5/v6 / E3-1500 v5 /
> >>>> 6th/7th/8th Gen Core Processor Gaussian Mixture Model [8086:1911]
> >>>>            +-12.0  Intel Corporation Cannon Lake PCH Thermal Controller
> >>>> [8086:a379]
> >>>>            +-14.0  Intel Corporation Cannon Lake PCH USB 3.1 xHCI Host Controller
> >>>> [8086:a36d]
> >>>>            +-14.2  Intel Corporation Cannon Lake PCH Shared SRAM [8086:a36f]
> >>>>            +-15.0  Intel Corporation Cannon Lake PCH Serial IO I2C Controller #0
> >>>> [8086:a368]
> >>>>            +-15.1  Intel Corporation Cannon Lake PCH Serial IO I2C Controller #1
> >>>> [8086:a369]
> >>>>            +-16.0  Intel Corporation Cannon Lake PCH HECI Controller [8086:a360]
> >>>>            +-17.0  Intel Corporation Cannon Lake Mobile PCH SATA AHCI Controller
> >>>> [8086:a353]
> >>>>            +-1b.0-[02-3a]----00.0-[03-3a]--+-00.0-[04]----00.0  Intel Corporation
> >>>> JHL6340 Thunderbolt 3 NHI (C step) [Alpine Ridge 2C 2016] [8086:15d9]
> >>>>            |                               +-01.0-[05-39]--
> >>>>            |                               \-02.0-[3a]----00.0  Intel Corporation JHL6340
> >>>> Thunderbolt 3 USB 3.1 Controller (C step) [Alpine Ridge 2C 2016]
> >>>> [8086:15db]
> >>>>            +-1c.0-[3b]----00.0  Intel Corporation Wi-Fi 6 AX200 [8086:2723]
> >>>>            +-1c.4-[3c]----00.0  Realtek Semiconductor Co., Ltd. RTS525A PCI
> >>>> Express Card Reader [10ec:525a]
> >>>>            +-1d.0-[3d]----00.0  Samsung Electronics Co Ltd NVMe SSD Controller
> >>>> SM981/PM981/PM983 [144d:a808]
> >>>>            +-1f.0  Intel Corporation Cannon Lake LPC Controller [8086:a30e]
> >>>>            +-1f.3  Intel Corporation Cannon Lake PCH cAVS [8086:a348]
> >>>>            +-1f.4  Intel Corporation Cannon Lake PCH SMBus Controller
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

