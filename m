Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F129661EB3D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 07:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbiKGG4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 01:56:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiKGG4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 01:56:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E96C47
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 22:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667804111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y18m8azyHOn5Ibl6TKD7X9UraJRtgy45vbRa6wrCY5k=;
        b=Hurjy+ChXxI+jDxyIlYBjoAJh6tMRs9usPltj+tY5zPUJovDRH9txp0vXMN250UFNcV3Ti
        RHNWAD+llFig5Oz2fa+XVNjaz7i7QBq7eZCXzTuuSyJNYOTtp4gjEkkNP3muOrWyXr2fg3
        4FiKB1IQ5UrECnVD42RpsWx9lrAgOdY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-404-I9AKQT7RPyex1MWVIcUUkQ-1; Mon, 07 Nov 2022 01:55:10 -0500
X-MC-Unique: I9AKQT7RPyex1MWVIcUUkQ-1
Received: by mail-ed1-f69.google.com with SMTP id c9-20020a05640227c900b00463de74bc15so7581871ede.13
        for <linux-kernel@vger.kernel.org>; Sun, 06 Nov 2022 22:55:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y18m8azyHOn5Ibl6TKD7X9UraJRtgy45vbRa6wrCY5k=;
        b=KC8wbmSt3zY40i8ejZbKWi+u45ubOz0HA0aU7CH0Gy+U0KMKvanTimbjJuX6uWUBNJ
         0tx+Zt9U4aF0HmrC2mXeyNHk6BsB80MMJLRo2EF3038dUKNhfZIbdIFXH1OiSzgKoGcm
         IUsWk3RT4YvQ8B/+w6Z0neWcknVtcBnESoBuSW0de8XXScYAwA1Kgz1uAcMBUe0HMzgY
         UMHIA6KXWQ0Vo9j+wndbFlGXbje20XuceZUH40M+DLykDWRqa2XsfHN7wSMVwlnRfRiP
         Z55MQlpaWSx42nwgRQuq0u0ORcU29fG7BB0JMFu4gICzcNmB2mnIBzSo79juMCcnuecu
         S2dA==
X-Gm-Message-State: ANoB5pnr0x1rksrBwnKeK2jxpBSwgqbutQljFi0u0jg7xCT/U9U2UNJE
        RTaIYQd0uSAdLWFCLPwo7lt3Rc9JOCmvepjorRTjj6k9rycvRSqoQQuZIP/IgnF0m8nwItC+5WJ
        +NbTSbWpy6ptkYJvREWu697sQjsji+wgfIdMuFkVG
X-Received: by 2002:a17:906:3ada:b0:7ae:566e:3a1c with SMTP id z26-20020a1709063ada00b007ae566e3a1cmr8250029ejd.223.1667804109001;
        Sun, 06 Nov 2022 22:55:09 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6uXDuXJgOmXAKWQ2kw35atMalXsKsAYB/O9QnMHiEi9sGLW0X78hBV93ehTpTac+itcHRs4D2V0w/vPKwvWQE=
X-Received: by 2002:a17:906:3ada:b0:7ae:566e:3a1c with SMTP id
 z26-20020a1709063ada00b007ae566e3a1cmr8250014ejd.223.1667804108772; Sun, 06
 Nov 2022 22:55:08 -0800 (PST)
MIME-Version: 1.0
References: <3acf1cc7a974cb4fb9b77b39311c6714@tfwno.gf> <Y2XUNive2KMwTjUF@MiWiFi-R3L-srv>
 <CALu+AoTVtO=-tzbgjeVRQ3uO0yGUPWKPuAiLn0CpaAq_=xr-sw@mail.gmail.com> <2f43e1e583a92e1592c48a15a763e1f7@tfwno.gf>
In-Reply-To: <2f43e1e583a92e1592c48a15a763e1f7@tfwno.gf>
From:   Dave Young <dyoung@redhat.com>
Date:   Mon, 7 Nov 2022 14:54:31 +0800
Message-ID: <CALu+AoQqb23tnNS6VY4+Q5Mz85NDFfWOP_aynoz7fcoMvzNeKg@mail.gmail.com>
Subject: Re: Bug: kexec on Lenovo ThinkPad T480 disables EFI mode
To:     ns@tfwno.gf
Cc:     Baoquan He <bhe@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 5 Nov 2022 at 22:16, <ns@tfwno.gf> wrote:
>
> On 2022-11-05 05:49, Dave Young wrote:
> > Baoquan, thanks for cc me.
> >
> > On Sat, 5 Nov 2022 at 11:10, Baoquan He <bhe@redhat.com> wrote:
> >>
> >> Add Dave to CC
> >>
> >> On 10/28/22 at 01:02pm, ns@tfwno.gf wrote:
> >> > Greetings,
> >> >
> >> > I've been hitting a bug on my Lenovo ThinkPad T480 where kexecing will
> >> > cause EFI mode (if that's the right term for it) to be unconditionally
> >> > disabled, even when not using the --noefi option to kexec.
> >> >
> >> > What I mean by "EFI mode" being disabled, more than just EFI runtime
> >> > services, is that basically nothing about the system's EFI is visible
> >> > post-kexec. Normally you have a message like this in dmesg when the
> >> > system is booted in EFI mode:
> >> >
> >> > [    0.000000] efi: EFI v2.70 by EDK II
> >> > [    0.000000] efi: SMBIOS=0x7f98a000 ACPI=0x7fb7e000 ACPI 2.0=0x7fb7e014
> >> > MEMATTR=0x7ec63018
> >> > (obviously not the real firmware of the machine I'm talking about, but I
> >> > can also send that if it would be of any help)
> >> >
> >> > No such message pops up in my dmesg as a result of this bug, & this
> >> > causes some fallout like being unable to find the system's DMI
> >> > information:
> >> >
> >> > <6>[    0.000000] DMI not present or invalid.
> >> >
> >> > The efivarfs module also fails to load with -ENODEV.
> >> >
> >> > I've tried also booting with efi=runtime explicitly but it doesn't
> >> > change anything. The kernel still does not print the name of the EFI
> >> > firmware, DMI is still missing, & efivarfs still fails to load.
> >> >
> >> > I've been using the kexec_load syscall for all these tests, if it's
> >> > important.
> >> >
> >> > Also, to make it very clear, all this only ever happens post-kexec. When
> >> > booting straight from UEFI (with the EFI stub), all the aforementioned
> >> > stuff that fails works perfectly fine (i.e. name of firmware is printed,
> >> > DMI is properly found, & efivarfs loads & mounts just fine).
> >> >
> >> > This is reproducible with a vanilla 6.1-rc2 kernel. I've been trying to
> >> > bisect it, but it seems like it goes pretty far back. I've got vanilla
> >> > mainline kernel builds dating back to 5.17 that have the exact same
> >> > issue. It might be worth noting that during this testing, I made sure
> >> > the version of the kernel being kexeced & the kernel kexecing were the
> >> > same version. It may not have been a problem in older kernels, but that
> >> > would be difficult to test for me (a pretty important driver for this
> >> > machine was only merged during v5.17-rc4). So it may not have been a
> >> > regression & just a hidden problem since time immemorial.
> >> >
> >> > I am willing to test any patches I may get to further debug or fix
> >> > this issue, preferably based on the current state of torvalds/linux.git.
> >> > I can build & test kernels quite a few times per day.
> >> >
> >> > I can also send any important materials (kernel config, dmesg, firmware
> >> > information, so on & so forth) on request. I'll also just mention I'm
> >> > using kexec-tools 2.0.24 upfront, if it matters.
> >
> > Can you check the efi runtime in sysfs:
> > ls /sys/firmware/efi/runtime-map/
> >
> > If nothing then maybe you did not enable CONFIG_EFI_RUNTIME_MAP=y, it
> > is needed for kexec UEFI boot on x86_64.
>
> Oh my, it really is that simple.
>
> Indeed, enabling this in the pre-kexec kernel fixes it all up. I had
> blindly disabled it in my quest to downsize the pre-kexec kernel to
> reduce boot time (it only runs a bootloader). In hindsight, the firmware
> drivers section is not really a good section to tweak on a whim.
>
> I'm terribly sorry to have taken your time to "fix" this "bug". But I
> must ask, is there any reason why this is a visible config option, or at
> least not gated behind CONFIG_EXPERT? drivers/firmware/efi/runtime-map.c
> is pretty tiny, & considering it depends on CONFIG_KEXEC_CORE, one
> probably wants to have kexec work properly if they can even enable it.

Glad to know it works with the .config tweaking. I can not recall any
reason for that though.

Since it sits in the efi code path, let's see how Ard thinks about
your proposal.

Thanks
Dave

