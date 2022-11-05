Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5894361D788
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 06:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiKEFvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 01:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiKEFve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 01:51:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085BE30548
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 22:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667627439;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n/DPXqnNM3/vCTawtYzMf2SZGZlw8n3vrmnUPC8gUwE=;
        b=FF77BdUfPnbl0I3TcEELFeX+Rq71HWRBTa+Ak3SkM1JsXMqNaKYksMPaOFX7uATuxbtja2
        afUIPCNxjnMAYVgtbTn/yQeHyzrXBVK4dEJL82R7Q4PUdl0Do0/SO8sVCIgDVcD+WoPmi/
        osFvlGP5CaUoCbfF5DWdGVDoO0bpYHc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-563-PsAQG54JPWyZ9X-A6xacPA-1; Sat, 05 Nov 2022 01:50:37 -0400
X-MC-Unique: PsAQG54JPWyZ9X-A6xacPA-1
Received: by mail-ed1-f70.google.com with SMTP id r12-20020a05640251cc00b00463699c95aeso4734596edd.18
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 22:50:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n/DPXqnNM3/vCTawtYzMf2SZGZlw8n3vrmnUPC8gUwE=;
        b=3MYxD+UrOySggvKZzclI7olGx8hOTZYZKWgHgrhwYbUaODomVNdMga3asJpFsWwsPr
         TMER54cXmEqHjxokzOtOLFb3uT0t9ODCpfBuoVgxe/XZt4JlZt5FDoe+2D6otOh0OJ3R
         6QQbUDEsxE7yOH2GglnEajsnftDcF6AFFpjTL6IFhlbvaSDPd9ujOhh9cQPl/DuJ6gqj
         rnvzAxtZ4JfphGd/22/d6mjY1fr44bIUWYyI2gOK3k3S1JH/BTkSUHy+kMNgBrW7xS4v
         +4XO7qjxxWb+qVpgDabVc7/ExGfI93E/UdtPgXm6eS5so7w92/I70pRiF0M9LfmS+oQU
         IZQA==
X-Gm-Message-State: ACrzQf31cnobbpUubWXo8tM7CqSpN9KMz8MLzizMY2XRCErUclDYg0w4
        DdyHClwjbM6tJcfngVehWbLXatJzbLOfDDRnmcLk0j/IUDf/nSZlUI6jiZaX39hvXiPwVneArll
        D1kvV7+oY4TBh0OA3GzkuJBc1lz/1Z40sUckSMNXD
X-Received: by 2002:aa7:c859:0:b0:463:4b54:16a8 with SMTP id g25-20020aa7c859000000b004634b5416a8mr32111547edt.136.1667627436421;
        Fri, 04 Nov 2022 22:50:36 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5A9+6ol1jnUB036VhOH+sVLMKPc0rjDaF4P/UgBmXrj6EZZzZioW4TXgnIDDoT14UQIBs4LTH6v6uVO017x1c=
X-Received: by 2002:aa7:c859:0:b0:463:4b54:16a8 with SMTP id
 g25-20020aa7c859000000b004634b5416a8mr32111531edt.136.1667627436187; Fri, 04
 Nov 2022 22:50:36 -0700 (PDT)
MIME-Version: 1.0
References: <3acf1cc7a974cb4fb9b77b39311c6714@tfwno.gf> <Y2XUNive2KMwTjUF@MiWiFi-R3L-srv>
In-Reply-To: <Y2XUNive2KMwTjUF@MiWiFi-R3L-srv>
From:   Dave Young <dyoung@redhat.com>
Date:   Sat, 5 Nov 2022 13:49:59 +0800
Message-ID: <CALu+AoTVtO=-tzbgjeVRQ3uO0yGUPWKPuAiLn0CpaAq_=xr-sw@mail.gmail.com>
Subject: Re: Bug: kexec on Lenovo ThinkPad T480 disables EFI mode
To:     Baoquan He <bhe@redhat.com>
Cc:     ns@tfwno.gf, Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Baoquan, thanks for cc me.

On Sat, 5 Nov 2022 at 11:10, Baoquan He <bhe@redhat.com> wrote:
>
> Add Dave to CC
>
> On 10/28/22 at 01:02pm, ns@tfwno.gf wrote:
> > Greetings,
> >
> > I've been hitting a bug on my Lenovo ThinkPad T480 where kexecing will
> > cause EFI mode (if that's the right term for it) to be unconditionally
> > disabled, even when not using the --noefi option to kexec.
> >
> > What I mean by "EFI mode" being disabled, more than just EFI runtime
> > services, is that basically nothing about the system's EFI is visible
> > post-kexec. Normally you have a message like this in dmesg when the
> > system is booted in EFI mode:
> >
> > [    0.000000] efi: EFI v2.70 by EDK II
> > [    0.000000] efi: SMBIOS=0x7f98a000 ACPI=0x7fb7e000 ACPI 2.0=0x7fb7e014
> > MEMATTR=0x7ec63018
> > (obviously not the real firmware of the machine I'm talking about, but I
> > can also send that if it would be of any help)
> >
> > No such message pops up in my dmesg as a result of this bug, & this
> > causes some fallout like being unable to find the system's DMI
> > information:
> >
> > <6>[    0.000000] DMI not present or invalid.
> >
> > The efivarfs module also fails to load with -ENODEV.
> >
> > I've tried also booting with efi=runtime explicitly but it doesn't
> > change anything. The kernel still does not print the name of the EFI
> > firmware, DMI is still missing, & efivarfs still fails to load.
> >
> > I've been using the kexec_load syscall for all these tests, if it's
> > important.
> >
> > Also, to make it very clear, all this only ever happens post-kexec. When
> > booting straight from UEFI (with the EFI stub), all the aforementioned
> > stuff that fails works perfectly fine (i.e. name of firmware is printed,
> > DMI is properly found, & efivarfs loads & mounts just fine).
> >
> > This is reproducible with a vanilla 6.1-rc2 kernel. I've been trying to
> > bisect it, but it seems like it goes pretty far back. I've got vanilla
> > mainline kernel builds dating back to 5.17 that have the exact same
> > issue. It might be worth noting that during this testing, I made sure
> > the version of the kernel being kexeced & the kernel kexecing were the
> > same version. It may not have been a problem in older kernels, but that
> > would be difficult to test for me (a pretty important driver for this
> > machine was only merged during v5.17-rc4). So it may not have been a
> > regression & just a hidden problem since time immemorial.
> >
> > I am willing to test any patches I may get to further debug or fix
> > this issue, preferably based on the current state of torvalds/linux.git.
> > I can build & test kernels quite a few times per day.
> >
> > I can also send any important materials (kernel config, dmesg, firmware
> > information, so on & so forth) on request. I'll also just mention I'm
> > using kexec-tools 2.0.24 upfront, if it matters.

Can you check the efi runtime in sysfs:
ls /sys/firmware/efi/runtime-map/

If nothing then maybe you did not enable CONFIG_EFI_RUNTIME_MAP=y, it
is needed for kexec UEFI boot on x86_64.

Otherwise you can add debug printf in kexec-tools efi error path to
see what is wrong.
kexec/arch/i386/x86-linux-setup.c : function setup_efi_data

And if it still not work please post your kernel config, I can have a
try although I do not have the t480 now.


> >
> > Regards,
> >
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec
> >
>

