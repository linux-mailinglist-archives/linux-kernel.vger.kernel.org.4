Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3006D6925FC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 20:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbjBJTCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 14:02:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232755AbjBJTCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 14:02:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE857BFC2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 11:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676055703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=42FsmB/zk/iiIT08iOzo74RdZ2Sg/lGPW1I2w5/TG2c=;
        b=boJkZ10gY/uZHstiOJq6zaOv9TK7ns57XQyzB8I+4uCVJEeTdUD4S5npZCxsg4rY1wqHfi
        MW48KfvfIHutH+yTaHhuud9L/6mJdFKg5rw7m8IOFy6CM53Ieel+XnmwyKlqgo6bBJ4Dww
        NiJnsOjsUV8O/NDUYObGzSSPJBIcWgo=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-428-PZT0Ir9TOB-6I6pXjX7ORQ-1; Fri, 10 Feb 2023 14:01:42 -0500
X-MC-Unique: PZT0Ir9TOB-6I6pXjX7ORQ-1
Received: by mail-lj1-f199.google.com with SMTP id s2-20020a2e1502000000b002917ff038daso1791923ljd.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 11:01:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=42FsmB/zk/iiIT08iOzo74RdZ2Sg/lGPW1I2w5/TG2c=;
        b=vOki8HJ/CozwllnCAyRjQQs7MQcs4jWlUQMDZkED6wdKqKsum9bRXqIP6cNJjHQHvE
         5rdAYULK7Oy+BC7dkfI/ULnpWX3kqBCSy+m4GFJBPXWJ5buDMIVhPXcqDigWrZpo/C9g
         mAoM4SNSpUH70iizLN3R7T3CLDKDts6wnSSkrE+Pf8ngeFnOyyBW1yFCOYhd6zQvRHx/
         g0XBnLgCZ7FH7rWtg457i3xb6MgmEep2aC68/mWBmu1f1cj3YjUrIxhhiwbF205bZ/3z
         JrI615fKGshRWPqVgP6glapfAE2zlOhgmi61zOjJMndGDU6SmXFCm3KbQrubaEZfHbnK
         /6qQ==
X-Gm-Message-State: AO0yUKUSJgYDOCuWM07P8yhGL2w7BF6IksfPG6cnhzETXksxZuiEKAyh
        0Unmo3v9RScAF2SCz85cN9CLFccAAZA+rPffP4x/syhkh5GYMTx6ikzMFhL0fv29QERQq+oWWtE
        Q21b1r8cFeM7TGc7E87QbSnxtHhiTsGwnJfm1OHzwEM/9HA==
X-Received: by 2002:ac2:4c2f:0:b0:4db:2d63:21b with SMTP id u15-20020ac24c2f000000b004db2d63021bmr36112lfq.277.1676055699723;
        Fri, 10 Feb 2023 11:01:39 -0800 (PST)
X-Google-Smtp-Source: AK7set+6aNE70CMGu4cWS2L8CdpcSP6Yqof+aVBTxLJbIeOnua5SAMa1n7DpSUbxwAoaDvMLB+U1uOOc6DMrjqEVgmo=
X-Received: by 2002:ac2:4c2f:0:b0:4db:2d63:21b with SMTP id
 u15-20020ac24c2f000000b004db2d63021bmr36103lfq.277.1676055699498; Fri, 10 Feb
 2023 11:01:39 -0800 (PST)
MIME-Version: 1.0
References: <b64705e3-2e63-a466-f829-f9568b06766a@googlemail.com>
 <fcec3c78-b5d9-eb48-0fc0-d1f27de87f23@leemhuis.info> <b21fa1f6-a71d-5657-8596-ee0be73185ea@leemhuis.info>
 <3ab28896-70e9-6f90-5b97-e5397b06e715@googlemail.com> <a163dd7b-c5d1-a07b-a816-7a2dfd3edfd4@leemhuis.info>
 <ab1b0f73-6b4e-8602-2999-b7bec25d92db@googlemail.com> <CACAvsv4sOtPjCVnEcKd2RCUqYWxSn5XKyksbS-Bds2qCqyusVw@mail.gmail.com>
 <1cdb84ac-f7a8-66ba-98fc-3db302b49a5a@googlemail.com> <dab6eb81-db3f-8fa1-84ad-9b40e209514b@googlemail.com>
 <CACAvsv5iYdF3P8AbyrbYo3zGmYRYhxDWn7WbAR5V9qHpbgBXRA@mail.gmail.com>
 <1632a9ef-2954-c8f0-cdc9-03157c9d8547@googlemail.com> <5abbee70-cc84-1528-c3d8-9befd9edd611@googlemail.com>
 <5cf46df8-0fa2-e9f5-aa8e-7f7f703d96dd@googlemail.com> <f72fe15b-db1d-56dd-aaf6-3cba68a8bf0a@leemhuis.info>
In-Reply-To: <f72fe15b-db1d-56dd-aaf6-3cba68a8bf0a@leemhuis.info>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Fri, 10 Feb 2023 20:01:27 +0100
Message-ID: <CACO55tvR4ydDOXt=9nbR3n2aFLKrj8zeuGRR_xpezVQBBLrjqg@mail.gmail.com>
Subject: Re: linux-6.2-rc4+ hangs on poweroff/reboot: Bisected
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Chris Clayton <chris2553@googlemail.com>,
        Ben Skeggs <skeggsb@gmail.com>, bskeggs@redhat.com,
        Lyude Paul <lyude@redhat.com>,
        ML nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>
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

On Fri, Feb 10, 2023 at 7:35 PM Linux regression tracking (Thorsten
Leemhuis) <regressions@leemhuis.info> wrote:
>
> On 08.02.23 09:48, Chris Clayton wrote:
> >
> > I'm assuming  that we are not going to see a fix for this regression before 6.2 is released.
>
> Yeah, looks like it. That's unfortunate, but happens. But there is still
> time to fix it and there is one thing I wonder:
>
> Did any of the nouveau developers look at the netconsole captures Chris
> posted more than a week ago to check if they somehow help to track down
> the root of this problem?
>

I did now and I can't spot anything. I think at this point it would
make sense to dump the active tasks/threads via sqsrq keys to see if
any is in a weird state preventing the machine from shutting down.

> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
>
> > Consequently, I've
> > implemented a (very simple) workaround. All that happens is that in the (sysv) init script that starts and stops SDDM,
> > the nouveau module is removed once SDDM is stopped. With that in place, my system no longer freezes on reboot or poweroff.
> >
> > Let me know if I can provide any additional diagnostics although, with the problem seemingly occurring so late in the
> > shutdown process, I may need help on how to go about capturing.
> >
> > Chris
> >
> > On 02/02/2023 20:45, Chris Clayton wrote:
> >>
> >>
> >> On 01/02/2023 13:51, Chris Clayton wrote:
> >>>
> >>>
> >>> On 30/01/2023 23:27, Ben Skeggs wrote:
> >>>> On Tue, 31 Jan 2023 at 09:09, Chris Clayton <chris2553@googlemail.com> wrote:
> >>>>>
> >>>>> Hi again.
> >>>>>
> >>>>> On 30/01/2023 20:19, Chris Clayton wrote:
> >>>>>> Thanks, Ben.
> >>>>>
> >>>>> <snip>
> >>>>>
> >>>>>>> Hey,
> >>>>>>>
> >>>>>>> This is a complete shot-in-the-dark, as I don't see this behaviour on
> >>>>>>> *any* of my boards.  Could you try the attached patch please?
> >>>>>>
> >>>>>> Unfortunately, the patch made no difference.
> >>>>>>
> >>>>>> I've been looking at how the graphics on my laptop is set up, and have a bit of a worry about whether the firmware might
> >>>>>> be playing a part in this problem. In order to offload video decoding to the NVidia TU117 GPU, it seems the scrubber
> >>>>>> firmware must be available, but as far as I know,that has not been released by NVidia. To get it to work, I followed
> >>>>>> what ubuntu have done and the scrubber in /lib/firmware/nvidia/tu117/nvdec/ is a symlink to
> >>>>>> ../../tu116/nvdev/scrubber.bin. That, of course, means that some of the firmware loaded is for a different card is being
> >>>>>> loaded. I note that processing related to firmware is being changed in the patch. Might my set up be at the root of my
> >>>>>> problem?
> >>>>>>
> >>>>>> I'll have a fiddle an see what I can work out.
> >>>>>>
> >>>>>> Chris
> >>>>>>
> >>>>>>>
> >>>>>>> Thanks,
> >>>>>>> Ben.
> >>>>>>>
> >>>>>>>>
> >>>>>
> >>>>> Well, my fiddling has got my system rebooting and shutting down successfully again. I found that if I delete the symlink
> >>>>> to the scrubber firmware, reboot and shutdown work again. There are however, a number of other files in the tu117
> >>>>> firmware directory tree that that are symlinks to actual files in its tu116 counterpart. So I deleted all of those too.
> >>>>> Unfortunately, the absence of one or more of those symlinks causes Xorg to fail to start. I've reinstated all the links
> >>>>> except scrubber and I now have a system that works as it did until I tried to run a kernel that includes the bad commit
> >>>>> I identified in my bisection. That includes offloading video decoding to the NVidia card, so what ever I read that said
> >>>>> the scrubber firmware was needed seems to have been wrong. I get a new message that (nouveau 0000:01:00.0: fb: VPR
> >>>>> locked, but no scrubber binary!), but, hey, we can't have everything.
> >>>>>
> >>>>> If you still want to get to the bottom of this, let me know what you need me to provide and I'll do my best. I suspect
> >>>>> you might want to because there will a n awful lot of Ubuntu-based systems out there with that scrubber.bin symlink in
> >>>>> place. On the other hand,m it could but quite a while before ubuntu are deploying 6.2 or later kernels.
> >>>> The symlinks are correct - whole groups of GPUs share the same FW, and
> >>>> we use symlinks in linux-firmware to represent this.
> >>>>
> >>>> I don't really have any ideas how/why this patch causes issues with
> >>>> shutdown - it's a path that only gets executed during initialisation.
> >>>> Can you try and capture the kernel log during shutdown ("dmesg -w"
> >>>> over ssh? netconsole?), and see if there's any relevant messages
> >>>> providing a hint at what's going on?  Alternatively, you could try
> >>>> unloading the module (you will have to stop X/wayland/gdm/etc/etc
> >>>> first) and seeing if that hangs too.
> >>>>
> >>>> Ben.
> >>>
> >>> Sorry for the delay - I've been learning about netconsole and netcat. However, I had no success with ssh and netconsole
> >>> produced a log with nothing unusual in it.
> >>>
> >>> Simply stopping Xorg and removing the nouveau module succeeds.
> >>>
> >>> So, I rebuilt rc6+ after a pull from linus' tree this morning and set the nouveau debug level to 7. I then booted to a
> >>> console before doing a reboot (with Ctl+Alt+Del). As expected the machine locked up just before it would ordinarily
> >>> restart. The last few lines on the console might be helpful:
> >>>
> >>> ...
> >>> nouveau 0000:01:00:0  fifo: preinit running...
> >>> nouveau 0000:01:00:0  fifo: preinit completed in 4us
> >>> nouveau 0000:01:00:0  gr: preinit running...
> >>> nouveau 0000:01:00:0  gr: preinit completed in 0us
> >>> nouveau 0000:01:00:0  nvdec0: preinit running...
> >>> nouveau 0000:01:00:0  nvdec0: preinit completed in 0us
> >>> nouveau 0000:01:00:0  nvdec0: preinit running...
> >>> nouveau 0000:01:00:0  nvdec0: preinit completed in 0us
> >>> nouveau 0000:01:00:0  sec2: preinit running...
> >>> nouveau 0000:01:00:0  sec2: preinit completed in 0us
> >>> nouveau 0000:01:00:0  fb:.VPR locked, running scrubber binary
> >>>
> >>> These messages appear after the "sd 4:0:0:0 [sda] Stopping disk" I reported in my initial email.
> >>>
> >>> After the "running scrubber" line appears the machine is locked and I have to hold down the power button to recover. I
> >>> get the same outcome from running "halt -dip", "poweroff -di" and "shutdown -h -P now". I guess it's no surprise that
> >>> all three result in the same outcome because invocations halt, poweroff and reboot (without the -f argument)from a
> >>> runlevel other than 0 resukt in shutdown being run. switching to runlevel 0 with "telenit 0" results in the same
> >>> messages from nouveau followed by the lockup.
> >>>
> >>> Let me know if you need any additional diagnostics.
> >>>
> >>> Chris
> >>>
> >>
> >> I've done some more investigation and found that I hadn't done sufficient amemdment the scripts run at shutdown to
> >> prevent the network being shutdown. I've now got netconsole captures for 6.2.0-rc6+
> >> (9f266ccaa2f5228bfe67ad58a94ca4e0109b954a) and, for comparison, 6.1.9. These two logs are attached.
> >>
> >> Chris
> >>
> >>>>
> >>>>>
> >>>>> Thanks,
> >>>>>
> >>>>> Chris
> >>>>>
> >>>>> <snip>
> >
> >
>

