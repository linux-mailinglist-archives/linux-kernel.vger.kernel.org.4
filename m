Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8FE67E4C4
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 13:12:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233739AbjA0ML7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 07:11:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbjA0MLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 07:11:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB33B88CC2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 04:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674821049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=poqA6RHKV0v9iLyMFWGM9vfyO+m9ySeX6jjTFbMjzpk=;
        b=T2UZYKdmsvIvOZ/egaX/H5UVUgLVJ8SYpfa6HCaNJ+Hklq01bQ36ni0gRdN0vAkXZaC+3b
        A31aAUSRss3TBtKHcgqjJiIUkzsUn57TC4fsOgzgkWWuRT1wItd6WZVh+6WDqHIQt1ZC5S
        gHrQUzRwmvbHho9btLNHSxaUAe1fWoc=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-131-Z5mUYqVeM62WTMZ7tLWyIg-1; Fri, 27 Jan 2023 06:35:21 -0500
X-MC-Unique: Z5mUYqVeM62WTMZ7tLWyIg-1
Received: by mail-lf1-f69.google.com with SMTP id bi41-20020a0565120ea900b004d584f37a04so1992634lfb.21
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:35:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=poqA6RHKV0v9iLyMFWGM9vfyO+m9ySeX6jjTFbMjzpk=;
        b=BkuzzIGRjpGTnu7/WzsMXkUvgVNKJfVSP7Ii4Bf0ceteJ7PqscKtlcXhhacGPZvSyW
         z9+3wL4QoCvCmO+LM69eQbM9ws3NK30YYTKtf8IEgnFRQB3OP3VwqBb1P9xggcCo7gc0
         2viba+jM95WXrvW3fqAQ/hvepF+zX/Ijyj5HXhIBOU78nPqPcucHFdsMhqRykFTcKDes
         NeFOhYKQktnmXNc3bmRhacrxyL/1PCauoodKCEIDQolVHaqwxGgnWgkDM9eZ5SyaNqS7
         N7RZmyWsDCY43Gr2SFVHBf832Ksdmt+sP/WztkrY7vhr7RSELz23sTgSgVGLc9N+2foR
         K1/A==
X-Gm-Message-State: AFqh2krgxgPrZMzLAJDyGauTvT1RwY5fWhtI9Z5kc4LBkFRgHG9UaED7
        NIneLMFs10+ewj+qqWmDQeJd0woekFV67WBLuKky3XOIwkLDErYyXx7YRRwe0/8O4xgHzHtUZxV
        CmMDxFfxEU0JVUW9IoivkcvcGY4tXFngoHky7N9Hc
X-Received: by 2002:ac2:4bd5:0:b0:4d5:76af:f890 with SMTP id o21-20020ac24bd5000000b004d576aff890mr2351454lfq.228.1674819320272;
        Fri, 27 Jan 2023 03:35:20 -0800 (PST)
X-Google-Smtp-Source: AMrXdXui82HUdxbT8XcUd+t5khVAAaqiRUAf8yYK1febBIf6BtoEPVLmD26XmE6V5geG4mseiUv9bSQx4PG0c4B4//A=
X-Received: by 2002:ac2:4bd5:0:b0:4d5:76af:f890 with SMTP id
 o21-20020ac24bd5000000b004d576aff890mr2351452lfq.228.1674819320042; Fri, 27
 Jan 2023 03:35:20 -0800 (PST)
MIME-Version: 1.0
References: <b64705e3-2e63-a466-f829-f9568b06766a@googlemail.com>
 <fcec3c78-b5d9-eb48-0fc0-d1f27de87f23@leemhuis.info> <b21fa1f6-a71d-5657-8596-ee0be73185ea@leemhuis.info>
In-Reply-To: <b21fa1f6-a71d-5657-8596-ee0be73185ea@leemhuis.info>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Fri, 27 Jan 2023 12:35:08 +0100
Message-ID: <CACO55tsgc7mmmYBQATqG=zUmO22A1uA3_+A0krdCoORj4PirXg@mail.gmail.com>
Subject: Re: linux-6.2-rc4+ hangs on poweroff/reboot: Bisected
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     bskeggs@redhat.com, Lyude Paul <lyude@redhat.com>,
        Chris Clayton <chris2553@googlemail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        ML nouveau <nouveau@lists.freedesktop.org>
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

Where was the original email sent to anyway, because I don't have it at all.

Anyhow, I suspect we want to fetch logs to see what's happening, but
due to the nature of this bug it might get difficult.

I'm checking out the laptops I have here if I can reproduce this
issue, but I think all mine with Turing GPUs are fine.

Maybe Ben has any idea what might be wrong with
0e44c21708761977dcbea9b846b51a6fb684907a or if that's an issue which
is already fixed by not upstreamed patches as I think I remember Ben
to talk about something like that recently.

Karol

On Fri, Jan 27, 2023 at 12:20 PM Linux kernel regression tracking
(Thorsten Leemhuis) <regressions@leemhuis.info> wrote:
>
> Hi, this is your Linux kernel regression tracker. Top-posting for once,
> to make this easily accessible to everyone.
>
> @nouveau-maintainers, did anyone take a look at this? The report is
> already 8 days old and I don't see a single reply. Sure, we'll likely
> get a -rc8, but still it would be good to not fix this on the finish line.
>
> Chris, btw, did you try if you can revert the commit on top of latest
> mainline? And if so, does it fix the problem?
>
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
>
> #regzbot poke
>
> On 19.01.23 15:33, Linux kernel regression tracking (Thorsten Leemhuis)
> wrote:
> > [adding various lists and the two other nouveau maintainers to the list
> > of recipients]
>
> > On 18.01.23 21:59, Chris Clayton wrote:
> >> Hi.
> >>
> >> I build and installed the lastest development kernel earlier this week. I've found that when I try the laptop down (or
> >> reboot it), it hangs right at the end of closing the current session. The last line I see on  the screen when rebooting is:
> >>
> >>      sd 4:0:0:0: [sda] Synchronising SCSI cache
> >>
> >> when closing down I see one additional line:
> >>
> >>      sd 4:0:0:0 [sda]Stopping disk
> >>
> >> In both cases the machine then hangs and I have to hold down the power button fot a few seconds to switch it off.
> >>
> >> Linux 6.1 is OK but 6.2-rc1 hangs, so I bisected between this two and landed on:
> >>
> >>      # first bad commit: [0e44c21708761977dcbea9b846b51a6fb684907a] drm/nouveau/flcn: new code to load+boot simple HS FWs
> >> (VPR scrubber)
> >>
> >> I built and installed a kernel with f15cde64b66161bfa74fb58f4e5697d8265b802e (the parent of the bad commit) checked out
> >> and that shuts down and reboots fine. It the did the same with the bad commit checked out and that does indeed hang, so
> >> I'm confident the bisect outcome is OK.
> >>
> >> Kernels 6.1.6 and 5.15.88 are also OK.
> >>
> >> My system had dual GPUs - one intel and one NVidia. Related extracts from 'lscpi -v' is:
> >>
> >> 00:02.0 VGA compatible controller: Intel Corporation CometLake-H GT2 [UHD Graphics] (rev 05) (prog-if 00 [VGA controller])
> >>         Subsystem: CLEVO/KAPOK Computer CometLake-H GT2 [UHD Graphics]
> >>
> >>         Flags: bus master, fast devsel, latency 0, IRQ 142
> >>
> >>         Memory at c2000000 (64-bit, non-prefetchable) [size=16M]
> >>
> >>         Memory at a0000000 (64-bit, prefetchable) [size=256M]
> >>
> >>         I/O ports at 5000 [size=64]
> >>
> >>         Expansion ROM at 000c0000 [virtual] [disabled] [size=128K]
> >>
> >>         Capabilities: [40] Vendor Specific Information: Len=0c <?>
> >>
> >>         Capabilities: [70] Express Root Complex Integrated Endpoint, MSI 00
> >>
> >>         Capabilities: [ac] MSI: Enable+ Count=1/1 Maskable- 64bit-
> >>
> >>         Capabilities: [d0] Power Management version 2
> >>
> >>         Kernel driver in use: i915
> >>
> >>         Kernel modules: i915
> >>
> >>
> >> 01:00.0 VGA compatible controller: NVIDIA Corporation TU117M [GeForce GTX 1650 Ti Mobile] (rev a1) (prog-if 00 [VGA
> >> controller])
> >>         Subsystem: CLEVO/KAPOK Computer TU117M [GeForce GTX 1650 Ti Mobile]
> >>         Flags: bus master, fast devsel, latency 0, IRQ 141
> >>         Memory at c4000000 (32-bit, non-prefetchable) [size=16M]
> >>         Memory at b0000000 (64-bit, prefetchable) [size=256M]
> >>         Memory at c0000000 (64-bit, prefetchable) [size=32M]
> >>         I/O ports at 4000 [size=128]
> >>         Expansion ROM at c3000000 [disabled] [size=512K]
> >>         Capabilities: [60] Power Management version 3
> >>         Capabilities: [68] MSI: Enable+ Count=1/1 Maskable- 64bit+
> >>         Capabilities: [78] Express Legacy Endpoint, MSI 00
> >>         Kernel driver in use: nouveau
> >>         Kernel modules: nouveau
> >>
> >> DRI_PRIME=1 is exported in one of my init scripts (yes, I am still using sysvinit).
> >>
> >> I've attached the bisect.log, but please let me know if I can provide any other diagnostics. Please cc me as I'm not
> >> subscribed.
> >
> > Thanks for the report. To be sure the issue doesn't fall through the
> > cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
> > tracking bot:
> >
> > #regzbot ^introduced e44c2170876197
> > #regzbot title drm: nouveau: hangs on poweroff/reboot
> > #regzbot ignore-activity
> >
> > This isn't a regression? This issue or a fix for it are already
> > discussed somewhere else? It was fixed already? You want to clarify when
> > the regression started to happen? Or point out I got the title or
> > something else totally wrong? Then just reply and tell me -- ideally
> > while also telling regzbot about it, as explained by the page listed in
> > the footer of this mail.
> >
> > Developers: When fixing the issue, remember to add 'Link:' tags pointing
> > to the report (the parent of this mail). See page linked in footer for
> > details.
> >
> > Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> > --
> > Everything you wanna know about Linux kernel regression tracking:
> > https://linux-regtracking.leemhuis.info/about/#tldr
> > That page also explains what to do if mails like this annoy you.
>

