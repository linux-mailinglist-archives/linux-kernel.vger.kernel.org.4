Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5380A73EEAE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 00:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjFZWeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 18:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjFZWeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 18:34:07 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982C2E53;
        Mon, 26 Jun 2023 15:34:05 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-668711086f4so2503776b3a.1;
        Mon, 26 Jun 2023 15:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687818845; x=1690410845;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JEICAU15slllX+Lkh6ej3nIM4496nJAdw6QRd6tNHGo=;
        b=l/RLDoqfu4S8Rt97BtNa3P1/8vd58dc0IlfXF/ilJ5s1SBukM/ChUGtUPnGSMg5fKk
         q9/n2SjQ1h+aAQVfJlSsSlXDAM9W4k+qr7UXi306JWt+l+owTqZXSsLZfc+kaqX1WHow
         3UNbDmmvai8HCIDNNWMuZJ+1+5xw6fj4+RKHD6GkRWR4TxQgrXe4bA00uVGpkvhvieEe
         vNt9q6VHOvAhX/hIS94gYA0+e7KdNuV+5Aj+uu9SnkcwTA5od1lWBoaFGX2i9IObtPJW
         9o242GxvGYn5zvuh735hrlYRzAfGSBjHCgIYJPHD7Qvv5OTfADziq4vgKH3GSslTRSdj
         U2hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687818845; x=1690410845;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JEICAU15slllX+Lkh6ej3nIM4496nJAdw6QRd6tNHGo=;
        b=gBskz29atYXHzC1f81dpc5u5i3ZNdozz4iamq6Cm1/Qa/ld5lTdFJsnlvjuhovGnkd
         oEftIQ5y94qYnTVJ0t8w5/cy2zY+zCzjwtVf/lY0laflY6IPs/8lpcrKcHzl7R5o9ic/
         n4PZRxn93KWy7oHHQF/nKup5fS3Q+Tt2vHSqPOprN8hO1dtzoH2Xwpt+pVcmJ5fXCWBe
         nZZrrnm4KBWFrFJB8CpOGvlpbyA59FXqkmAwZlStIg19kQVoBwiVRoPVZ+fm+u+xhGb1
         HD7bT5pIUzXwkomvOmFX8y2ObI+MuxZlaKkoJ8faqsyY+UY333Us9/aRCshidX49/GJe
         Lw7A==
X-Gm-Message-State: AC+VfDzYMo3SUhfwxguR+6ynIDZwVDwQ0q3Bky8BT4TgSCJ/QERLU1Uw
        roTvBxhx+jbk9OnW4yjQrbYhm91myk5wmoZM
X-Google-Smtp-Source: ACHHUZ5wTCBCt3YlwbiIZnNvzwAYCQGBX/Fj3D6gZWBjMfMyGlH9MxvgVI4ceYhSzkErIi0OCvTcKQ==
X-Received: by 2002:a05:6a20:a121:b0:126:23d:cd10 with SMTP id q33-20020a056a20a12100b00126023dcd10mr13607964pzk.21.1687818844824;
        Mon, 26 Jun 2023 15:34:04 -0700 (PDT)
Received: from localhost ([2405:6581:d4e0:1600:59cc:f1fc:e0e2:7431])
        by smtp.gmail.com with ESMTPSA id bm2-20020a056a00320200b0063b675f01a5sm4451607pfb.11.2023.06.26.15.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 15:34:04 -0700 (PDT)
Date:   Tue, 27 Jun 2023 07:34:01 +0900
From:   Nick Hastings <nicholaschastings@gmail.com>
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
        Lukas Wunner <lukas@wunner.de>,
        Salvatore Bonaccorso <carnil@debian.org>,
        "1036530@bugs.debian.org" <1036530@bugs.debian.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>
Subject: Re: Regression from "ACPI: OSI: Remove Linux-Dell-Video _OSI
 string"? (was: Re: Bug#1036530: linux-signed-amd64: Hard lock up of system)
Message-ID: <ZJoSWftrHO65wmxz@xps>
References: <ZHfa/wQlaVCeUC22@xps>
 <fe0ab1fa-6ed6-dc64-8165-8fc70669317b@amd.com>
 <CACO55tsuO1kQUFfPdPFUHm4WEQseCR2tQSDhFRzR+8wOECZCyA@mail.gmail.com>
 <MN0PR12MB61017541F5AC55485A490BCDE2499@MN0PR12MB6101.namprd12.prod.outlook.com>
 <CACO55tudULtvt_Hcdg+uqXeYkSAR_NZ1oD=R_KhuE_THSRe88g@mail.gmail.com>
 <MN0PR12MB6101DE067CF85E59AF187763E2499@MN0PR12MB6101.namprd12.prod.outlook.com>
 <CACO55tuqAH5Zt+X9pjLFZ-RcFgxpgjpqmrAHPvm4=fb_DMBHyw@mail.gmail.com>
 <ZHkxYo/a+/uInkLG@xps>
 <MN0PR12MB610181D29933EE4787DE9BC8E24EA@MN0PR12MB6101.namprd12.prod.outlook.com>
 <ed5f982e-c12c-b3a2-1108-62fba50bf9db@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ed5f982e-c12c-b3a2-1108-62fba50bf9db@leemhuis.info>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thorsten,

* Linux regression tracking (Thorsten Leemhuis) <regressions@leemhuis.info> [230626 21:09]:
> Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
> for once, to make this easily accessible to everyone.
> 
> Nick, what's the status/was there any progress? Did you do what Mario
> suggested and file a nouveau bug?

It was not apparent that the suggestion to open "a Nouveau drm bug" was
addressed to me.

> I ask, as I still have this on my list of regressions and it seems there
> was no progress in three+ weeks now.

I have not pursued this further since as far as I could tell I already
provided all requested information and I don't actually use nouveau, so
I blacklisted it.

Regards,

Nick.

> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
> 
> #regzbot backburner: slow progress, likely just affects one machine
> #regzbot poke
> 
> 
> On 02.06.23 02:57, Limonciello, Mario wrote:
> > [AMD Official Use Only - General]
> > 
> >> -----Original Message-----
> >> From: Nick Hastings <nicholaschastings@gmail.com>
> >> Sent: Thursday, June 1, 2023 7:02 PM
> >> To: Karol Herbst <kherbst@redhat.com>
> >> Cc: Limonciello, Mario <Mario.Limonciello@amd.com>; Lyude Paul
> >> <lyude@redhat.com>; Lukas Wunner <lukas@wunner.de>; Salvatore
> >> Bonaccorso <carnil@debian.org>; 1036530@bugs.debian.org; Rafael J.
> >> Wysocki <rafael@kernel.org>; Len Brown <lenb@kernel.org>; linux-
> >> acpi@vger.kernel.org; linux-kernel@vger.kernel.org;
> >> regressions@lists.linux.dev
> >> Subject: Re: Regression from "ACPI: OSI: Remove Linux-Dell-Video _OSI
> >> string"? (was: Re: Bug#1036530: linux-signed-amd64: Hard lock up of system)
> >>
> >> Hi,
> >>
> >> * Karol Herbst <kherbst@redhat.com> [230602 03:10]:
> >>> On Thu, Jun 1, 2023 at 7:21 PM Limonciello, Mario
> >>> <Mario.Limonciello@amd.com> wrote:
> >>>>> -----Original Message-----
> >>>>> From: Karol Herbst <kherbst@redhat.com>
> >>>>> Sent: Thursday, June 1, 2023 12:19 PM
> >>>>> To: Limonciello, Mario <Mario.Limonciello@amd.com>
> >>>>> Cc: Nick Hastings <nicholaschastings@gmail.com>; Lyude Paul
> >>>>> <lyude@redhat.com>; Lukas Wunner <lukas@wunner.de>; Salvatore
> >>>>> Bonaccorso <carnil@debian.org>; 1036530@bugs.debian.org; Rafael J.
> >>>>> Wysocki <rafael@kernel.org>; Len Brown <lenb@kernel.org>; linux-
> >>>>> acpi@vger.kernel.org; linux-kernel@vger.kernel.org;
> >>>>> regressions@lists.linux.dev
> >>>>> Subject: Re: Regression from "ACPI: OSI: Remove Linux-Dell-Video _OSI
> >>>>> string"? (was: Re: Bug#1036530: linux-signed-amd64: Hard lock up of
> >> system)
> >>>>>
> >>>>> On Thu, Jun 1, 2023 at 6:54 PM Limonciello, Mario
> >>>>> <Mario.Limonciello@amd.com> wrote:
> >>>>>>
> >>>>>> [AMD Official Use Only - General]
> >>>>>>
> >>>>>>> -----Original Message-----
> >>>>>>> From: Karol Herbst <kherbst@redhat.com>
> >>>>>>> Sent: Thursday, June 1, 2023 11:33 AM
> >>>>>>> To: Limonciello, Mario <Mario.Limonciello@amd.com>
> >>>>>>> Cc: Nick Hastings <nicholaschastings@gmail.com>; Lyude Paul
> >>>>>>> <lyude@redhat.com>; Lukas Wunner <lukas@wunner.de>; Salvatore
> >>>>>>> Bonaccorso <carnil@debian.org>; 1036530@bugs.debian.org; Rafael
> >> J.
> >>>>>>> Wysocki <rafael@kernel.org>; Len Brown <lenb@kernel.org>; linux-
> >>>>>>> acpi@vger.kernel.org; linux-kernel@vger.kernel.org;
> >>>>>>> regressions@lists.linux.dev
> >>>>>>> Subject: Re: Regression from "ACPI: OSI: Remove Linux-Dell-Video
> >> _OSI
> >>>>>>> string"? (was: Re: Bug#1036530: linux-signed-amd64: Hard lock up of
> >>>>> system)
> >>>>>>>
> >>>>>>> On Thu, Jun 1, 2023 at 6:18 PM Limonciello, Mario
> >>>>>>>>
> >>>>>>>> Lyude, Lukas, Karol
> >>>>>>>>
> >>>>>>>> This thread is in relation to this commit:
> >>>>>>>>
> >>>>>>>> 24867516f06d ("ACPI: OSI: Remove Linux-Dell-Video _OSI string")
> >>>>>>>>
> >>>>>>>> Nick has found that runtime PM is *not* working for nouveau.
> >>>>>>>>
> >>>>>>>
> >>>>>>> keep in mind we have a list of PCIe controllers where we apply a
> >>>>>>> workaround:
> >>>>>>>
> >>>>>
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers
> >>>>>>> /gpu/drm/nouveau/nouveau_drm.c?h=v6.4-rc4#n682
> >>>>>>>
> >>>>>>> And I suspect there might be one or two more IDs we'll have to add
> >>>>>>> there. Do we have any logs?
> >>>>>>
> >>>>>> There's some archived onto the distro bug.  Search this page for
> >>>>> "journalctl.log.gz"
> >>>>>> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1036530
> >>>>>>
> >>>>>
> >>>>> interesting.. It seems to be the same controller used here. I wonder
> >>>>> if the pci topology is different or if the workaround is applied at
> >>>>> all.
> >>>>
> >>>> I didn't see the message in the log about the workaround being applied
> >>>> in that log, so I guess PCI topology difference is a likely suspect.
> >>>>
> >>>
> >>> yeah, but I also couldn't see a log with the usual nouveau messages,
> >>> so it's kinda weird.
> >>>
> >>> Anyway, the output of `lspci -tvnn` would help
> >>
> >> % lspci -tvnn
> >> -[0000:00]-+-00.0  Intel Corporation Device [8086:3e20]
> >>            +-01.0-[01]----00.0  NVIDIA Corporation TU117M [GeForce GTX 1650
> >> Mobile / Max-Q] [10de:1f91]
> > 
> > So the bridge it's connected to is the same that the quirk *should have been* triggering.
> > 
> > May 29 15:02:42 xps kernel: pci 0000:00:01.0: [8086:1901] type 01 class 0x060400
> > 
> > Since the quirk isn't working and this is still a problem in 6.4-rc4 I suggest opening a
> > Nouveau drm bug to figure out why.
> > 
> >>            +-02.0  Intel Corporation CoffeeLake-H GT2 [UHD Graphics 630]
> >> [8086:3e9b]
> >>            +-04.0  Intel Corporation Xeon E3-1200 v5/E3-1500 v5/6th Gen Core
> >> Processor Thermal Subsystem [8086:1903]
> >>            +-08.0  Intel Corporation Xeon E3-1200 v5/v6 / E3-1500 v5 /
> >> 6th/7th/8th Gen Core Processor Gaussian Mixture Model [8086:1911]
> >>            +-12.0  Intel Corporation Cannon Lake PCH Thermal Controller
> >> [8086:a379]
> >>            +-14.0  Intel Corporation Cannon Lake PCH USB 3.1 xHCI Host Controller
> >> [8086:a36d]
> >>            +-14.2  Intel Corporation Cannon Lake PCH Shared SRAM [8086:a36f]
> >>            +-15.0  Intel Corporation Cannon Lake PCH Serial IO I2C Controller #0
> >> [8086:a368]
> >>            +-15.1  Intel Corporation Cannon Lake PCH Serial IO I2C Controller #1
> >> [8086:a369]
> >>            +-16.0  Intel Corporation Cannon Lake PCH HECI Controller [8086:a360]
> >>            +-17.0  Intel Corporation Cannon Lake Mobile PCH SATA AHCI Controller
> >> [8086:a353]
> >>            +-1b.0-[02-3a]----00.0-[03-3a]--+-00.0-[04]----00.0  Intel Corporation
> >> JHL6340 Thunderbolt 3 NHI (C step) [Alpine Ridge 2C 2016] [8086:15d9]
> >>            |                               +-01.0-[05-39]--
> >>            |                               \-02.0-[3a]----00.0  Intel Corporation JHL6340
> >> Thunderbolt 3 USB 3.1 Controller (C step) [Alpine Ridge 2C 2016]
> >> [8086:15db]
> >>            +-1c.0-[3b]----00.0  Intel Corporation Wi-Fi 6 AX200 [8086:2723]
> >>            +-1c.4-[3c]----00.0  Realtek Semiconductor Co., Ltd. RTS525A PCI
> >> Express Card Reader [10ec:525a]
> >>            +-1d.0-[3d]----00.0  Samsung Electronics Co Ltd NVMe SSD Controller
> >> SM981/PM981/PM983 [144d:a808]
> >>            +-1f.0  Intel Corporation Cannon Lake LPC Controller [8086:a30e]
> >>            +-1f.3  Intel Corporation Cannon Lake PCH cAVS [8086:a348]
> >>            +-1f.4  Intel Corporation Cannon Lake PCH SMBus Controller
> >> [8086:a323]
> >>            \-1f.5  Intel Corporation Cannon Lake PCH SPI Controller
> >>            [8086:a324]
> >>
> >>
> >> Regards,
> >>
> >> Nick.
> > 

