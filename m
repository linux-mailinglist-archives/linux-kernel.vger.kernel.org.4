Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4606461EC47
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 08:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbiKGHk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 02:40:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbiKGHky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 02:40:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8693BCFF
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 23:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667806798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gqTH/IxvvklYXKMEdnIMrBW3qua+LAhrbLqR4JyUT5Y=;
        b=DgPddmXsZRjIKVlvsWt0s3Q1k3wd9nqK0erxuzzwHr9nvgCErdyvf+IulACckTOchD9S/6
        FlKG+ZuL0KWnW313yPrgnNVpaeRYv7RgQ5zR4DFceOMx9d2SRe+obMAOThNT3pHN7fkHn8
        rAOzrcRBJJ2lPL2aFMr0gwZvOJ7mXos=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-423-qmo1cUkQPieqy5-dMvIDtg-1; Mon, 07 Nov 2022 02:39:57 -0500
X-MC-Unique: qmo1cUkQPieqy5-dMvIDtg-1
Received: by mail-ed1-f71.google.com with SMTP id v18-20020a056402349200b004622e273bbbso7657329edc.14
        for <linux-kernel@vger.kernel.org>; Sun, 06 Nov 2022 23:39:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gqTH/IxvvklYXKMEdnIMrBW3qua+LAhrbLqR4JyUT5Y=;
        b=fNwaoVTdY7OGtvQ0nkFhtHi1PhhQTXgdm/Tu5OY4JYoauAu2fnkmj4J31UGdKwLGTE
         PE618nEgxrYnd4vj1e4ykL/Cj/+aodHtJXZugRqCfXrE5xvwhOECczBnQSPLVGv7BCg6
         pfNmD66WET2E0XkkC/NVorjsuu5cHVACKJ/ddGMcyVxqTBresuU44P2hFk84Q++WclsN
         7T+OPls7DfV9ouP1aMTFY0Zygc8b0O0x/IhnFEUqQUWJSj/FrZOozhcO6NZkMoY24iOU
         KELXKpC4L22LsYnKh9h9b4TtZAdiLRN2Xtm/Z3Mk+2tOB4cJmXizATOjaYwu4NtmmPt0
         pSxQ==
X-Gm-Message-State: ANoB5pl9koIdNX0aMqjzbX+WlE3vJ41CINAfj1ZRVZ+UkWh21jlaaUlv
        R8gGP7rXfWRX1z4YfrpSntQHKrZUh8wyqRq9pXbkW27gSd1DgSCch8L7qIvP5huyD5KfdLbccfD
        PMsDOCQ/4dMY/LroP7cWuTgG/J3enlXZgFVycpPl8
X-Received: by 2002:aa7:d385:0:b0:461:8cd3:b38b with SMTP id x5-20020aa7d385000000b004618cd3b38bmr10532983edq.172.1667806796351;
        Sun, 06 Nov 2022 23:39:56 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6kEcP7IRVZbDPlLZz1yB6QJ3FRoM6CZNsHc+5ZoCmUj79D76jdLuYBr+2+StZs/5kxjL+vZjuSVSNBbtEMAwc=
X-Received: by 2002:aa7:d385:0:b0:461:8cd3:b38b with SMTP id
 x5-20020aa7d385000000b004618cd3b38bmr10532968edq.172.1667806796080; Sun, 06
 Nov 2022 23:39:56 -0800 (PST)
MIME-Version: 1.0
References: <3acf1cc7a974cb4fb9b77b39311c6714@tfwno.gf> <Y2XUNive2KMwTjUF@MiWiFi-R3L-srv>
 <CALu+AoTVtO=-tzbgjeVRQ3uO0yGUPWKPuAiLn0CpaAq_=xr-sw@mail.gmail.com>
 <2f43e1e583a92e1592c48a15a763e1f7@tfwno.gf> <CALu+AoQqb23tnNS6VY4+Q5Mz85NDFfWOP_aynoz7fcoMvzNeKg@mail.gmail.com>
 <CAMj1kXGyo7q1Jgkw8RAfiiyLpe8GAvsWT+jEt4DM-1W9Qf7oUQ@mail.gmail.com> <CALu+AoQeraV2fLx_6q_76rdUXdsY6wYVMNU0o_VVuXLyfqiDNA@mail.gmail.com>
In-Reply-To: <CALu+AoQeraV2fLx_6q_76rdUXdsY6wYVMNU0o_VVuXLyfqiDNA@mail.gmail.com>
From:   Dave Young <dyoung@redhat.com>
Date:   Mon, 7 Nov 2022 15:39:18 +0800
Message-ID: <CALu+AoTJeMry54KmSWooP5Jm3t0EqCxOid_GzfU51KQmXUYp8Q@mail.gmail.com>
Subject: Re: Bug: kexec on Lenovo ThinkPad T480 disables EFI mode
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     ns@tfwno.gf, Baoquan He <bhe@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Nov 2022 at 15:36, Dave Young <dyoung@redhat.com> wrote:
>
> Hi Ard,
>
> On Mon, 7 Nov 2022 at 15:30, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Mon, 7 Nov 2022 at 07:55, Dave Young <dyoung@redhat.com> wrote:
> > >
> > > Hi,
> > >
> > > On Sat, 5 Nov 2022 at 22:16, <ns@tfwno.gf> wrote:
> > > >
> > > > On 2022-11-05 05:49, Dave Young wrote:
> > > > > Baoquan, thanks for cc me.
> > > > >
> > > > > On Sat, 5 Nov 2022 at 11:10, Baoquan He <bhe@redhat.com> wrote:
> > > > >>
> > > > >> Add Dave to CC
> > > > >>
> > > > >> On 10/28/22 at 01:02pm, ns@tfwno.gf wrote:
> > > > >> > Greetings,
> > > > >> >
> > > > >> > I've been hitting a bug on my Lenovo ThinkPad T480 where kexecing will
> > > > >> > cause EFI mode (if that's the right term for it) to be unconditionally
> > > > >> > disabled, even when not using the --noefi option to kexec.
> > > > >> >
> > > > >> > What I mean by "EFI mode" being disabled, more than just EFI runtime
> > > > >> > services, is that basically nothing about the system's EFI is visible
> > > > >> > post-kexec. Normally you have a message like this in dmesg when the
> > > > >> > system is booted in EFI mode:
> > > > >> >
> > > > >> > [    0.000000] efi: EFI v2.70 by EDK II
> > > > >> > [    0.000000] efi: SMBIOS=0x7f98a000 ACPI=0x7fb7e000 ACPI 2.0=0x7fb7e014
> > > > >> > MEMATTR=0x7ec63018
> > > > >> > (obviously not the real firmware of the machine I'm talking about, but I
> > > > >> > can also send that if it would be of any help)
> > > > >> >
> > > > >> > No such message pops up in my dmesg as a result of this bug, & this
> > > > >> > causes some fallout like being unable to find the system's DMI
> > > > >> > information:
> > > > >> >
> > > > >> > <6>[    0.000000] DMI not present or invalid.
> > > > >> >
> > > > >> > The efivarfs module also fails to load with -ENODEV.
> > > > >> >
> > > > >> > I've tried also booting with efi=runtime explicitly but it doesn't
> > > > >> > change anything. The kernel still does not print the name of the EFI
> > > > >> > firmware, DMI is still missing, & efivarfs still fails to load.
> > > > >> >
> > > > >> > I've been using the kexec_load syscall for all these tests, if it's
> > > > >> > important.
> > > > >> >
> > > > >> > Also, to make it very clear, all this only ever happens post-kexec. When
> > > > >> > booting straight from UEFI (with the EFI stub), all the aforementioned
> > > > >> > stuff that fails works perfectly fine (i.e. name of firmware is printed,
> > > > >> > DMI is properly found, & efivarfs loads & mounts just fine).
> > > > >> >
> > > > >> > This is reproducible with a vanilla 6.1-rc2 kernel. I've been trying to
> > > > >> > bisect it, but it seems like it goes pretty far back. I've got vanilla
> > > > >> > mainline kernel builds dating back to 5.17 that have the exact same
> > > > >> > issue. It might be worth noting that during this testing, I made sure
> > > > >> > the version of the kernel being kexeced & the kernel kexecing were the
> > > > >> > same version. It may not have been a problem in older kernels, but that
> > > > >> > would be difficult to test for me (a pretty important driver for this
> > > > >> > machine was only merged during v5.17-rc4). So it may not have been a
> > > > >> > regression & just a hidden problem since time immemorial.
> > > > >> >
> > > > >> > I am willing to test any patches I may get to further debug or fix
> > > > >> > this issue, preferably based on the current state of torvalds/linux.git.
> > > > >> > I can build & test kernels quite a few times per day.
> > > > >> >
> > > > >> > I can also send any important materials (kernel config, dmesg, firmware
> > > > >> > information, so on & so forth) on request. I'll also just mention I'm
> > > > >> > using kexec-tools 2.0.24 upfront, if it matters.
> > > > >
> > > > > Can you check the efi runtime in sysfs:
> > > > > ls /sys/firmware/efi/runtime-map/
> > > > >
> > > > > If nothing then maybe you did not enable CONFIG_EFI_RUNTIME_MAP=y, it
> > > > > is needed for kexec UEFI boot on x86_64.
> > > >
> > > > Oh my, it really is that simple.
> > > >
> > > > Indeed, enabling this in the pre-kexec kernel fixes it all up. I had
> > > > blindly disabled it in my quest to downsize the pre-kexec kernel to
> > > > reduce boot time (it only runs a bootloader). In hindsight, the firmware
> > > > drivers section is not really a good section to tweak on a whim.
> > > >
> > > > I'm terribly sorry to have taken your time to "fix" this "bug". But I
> > > > must ask, is there any reason why this is a visible config option, or at
> > > > least not gated behind CONFIG_EXPERT? drivers/firmware/efi/runtime-map.c
> > > > is pretty tiny, & considering it depends on CONFIG_KEXEC_CORE, one
> > > > probably wants to have kexec work properly if they can even enable it.
> > >
> > > Glad to know it works with the .config tweaking. I can not recall any
> > > reason for that though.
> > >
> > > Since it sits in the efi code path, let's see how Ard thinks about
> > > your proposal.
> > >
> >
> > I don't understand why EFI_RUNTIME_MAP should depend on KEXEC_CORE at
> > all: it is documented as a feature that can be enabled for debugging
> > as well, and kexec does not work as expected without it.
>
> Probably debugging only mentioned in text, but not been considered in
> the kconfig logic :(
>
> >
> > Should we just change it like this perhaps?
> >
> > --- a/drivers/firmware/efi/Kconfig
> > +++ b/drivers/firmware/efi/Kconfig
> > @@ -28,8 +28,8 @@ config EFI_VARS_PSTORE_DEFAULT_DISABLE
> >
> >  config EFI_RUNTIME_MAP
> >         bool "Export efi runtime maps to sysfs"
> > -       depends on X86 && EFI && KEXEC_CORE
> > -       default y
> > +       depends on X86 && EFI
> > +       default KEXEC_CORE
> >         help
> >
> > and maybe add an 'if EXPERT' so that the option is only visible to
> > modify when CONFIG_EXPERT=y ?
>
> Above changes look good to me.
>
> >
> > In any case, I intend to move this code into arch/x86 as well, so I'll
> > have a couple of patches out shortly.
>
> That would be better since it is X86 only.  Thanks, Ard.

Hmm,  before doing that, do you think it is useful for debugging
purposes? That could be a reason to sit in efi code instead of x86 ..

