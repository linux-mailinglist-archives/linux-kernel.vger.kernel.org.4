Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C52A69C9D8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 12:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbjBTL2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 06:28:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjBTL2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 06:28:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780541A971
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 03:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676892423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QITTcF0TgBnVC2t89a+M11n/sxNBaKivZvomAgx8yQQ=;
        b=Jv74FbD4JXneKOm+NYMiTy5lpr4H20n5BYpArQkrY4uCiZoHZ6vvqwYGCwfGJ+mGe+wTn+
        TH0+0Ri9ejwqYk9bZGJgGd5aw3jeP1WsyTWPiHH8hLrRCkDYn5+M8EYdLfhVufFIU2VU/W
        FAgXB3rJzucIg9CYTwZiImkEc5fuCVs=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-218-AufvJVRVPXWZAWuXQoTswQ-1; Mon, 20 Feb 2023 06:27:02 -0500
X-MC-Unique: AufvJVRVPXWZAWuXQoTswQ-1
Received: by mail-lj1-f199.google.com with SMTP id l8-20020a2ea808000000b002945cfdc512so291953ljq.20
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 03:27:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QITTcF0TgBnVC2t89a+M11n/sxNBaKivZvomAgx8yQQ=;
        b=Ecuxhe6g29KlCAPpyAKae8ZXvqYM0a2v2p/FSn1m17tKGcVWelGq6CegluwqAne8I5
         2pdvlQfyv9swlPuG7nmadMgC3Tj+bD6Zu3LqdM+68+2IP7EHfPXpsR4fCzRf250cLD2t
         GTGaxTGO3ASQNyreVhkWdhLXI3hZhYpJqiTrItSieZPfOfQProE1VmujxUsNmuGoUpCK
         KLabNwnZsMA4olX2vtK5d+aTxkeTPoiUZDftsVRqHlIvZ0/g3UhTBPSXU/X0kCkakJoW
         Gxii8rsWZezfUs+Wuh20JG7nGEOtGOVyCOjzIaXnqqAGrMb6HfheRJiE71R+ICWoG0uk
         Zwkg==
X-Gm-Message-State: AO0yUKX9UBVhQWut0G0b9EKGkPaULgsJg9J4FV3B/jH8YuiO0ngq+X0H
        KXwTqj6GRKG/0+vi08UZFgAkkKz4GdwSbfauWQR/sLd6mBIWy3gkrnbxtdmitsL/Z6Raycd+tc+
        GOp/kTxsrynFKqstssy0az1YqCuWGTb/jtZAj+cGx
X-Received: by 2002:a05:651c:1304:b0:294:751e:30a0 with SMTP id u4-20020a05651c130400b00294751e30a0mr556833lja.9.1676892420962;
        Mon, 20 Feb 2023 03:27:00 -0800 (PST)
X-Google-Smtp-Source: AK7set/4C6+yoxchfoTjNWJnjnM2hCEqXG3EkpndVmt0f/WEwCJ1cowhjfViNSCDPEa/J6ctx3R+mP/1PPpLwCmCT9c=
X-Received: by 2002:a05:651c:1304:b0:294:751e:30a0 with SMTP id
 u4-20020a05651c130400b00294751e30a0mr556829lja.9.1676892420634; Mon, 20 Feb
 2023 03:27:00 -0800 (PST)
MIME-Version: 1.0
References: <b64705e3-2e63-a466-f829-f9568b06766a@googlemail.com>
 <5abbee70-cc84-1528-c3d8-9befd9edd611@googlemail.com> <5cf46df8-0fa2-e9f5-aa8e-7f7f703d96dd@googlemail.com>
 <f72fe15b-db1d-56dd-aaf6-3cba68a8bf0a@leemhuis.info> <CACO55tvR4ydDOXt=9nbR3n2aFLKrj8zeuGRR_xpezVQBBLrjqg@mail.gmail.com>
 <a6188878-f84c-0fcc-9509-b9d7ab797f4c@leemhuis.info> <d031f0a5-8d5e-af51-6db6-11844de3eeba@googlemail.com>
 <CAPM=9tz+wksJTvMi_4Ef7XWezfH0ReN2se189s8Q=obJjHC+Fw@mail.gmail.com>
 <4e786e22-f17a-da76-5129-8fef0c7c825a@googlemail.com> <b829633e-ccc4-7a54-1cad-f29254de1251@leemhuis.info>
 <CACO55tsvM07_6mGU3dCgeji0a6B4JJKSDOOBuCHv2Mw3rYbCHg@mail.gmail.com>
 <181bea6a-e501-f5bd-b002-de7a244a921a@googlemail.com> <CACO55tsGXfy9-a-nexvcn7pnDGoEWXMqhiQEBwCDkGyOeT1sXQ@mail.gmail.com>
 <dbfc1f77-29f3-7690-c231-55f906a4e7e5@googlemail.com> <7f6ec5b3-b5c7-f564-003e-132f112b7cf4@googlemail.com>
 <CACAvsv7Uf5=K44y8YLsiy0aMnc1zvGEQdeDe7RQF=AV+fxxzuQ@mail.gmail.com> <c12aa9b8-65a1-0cdf-8948-15309f16b955@googlemail.com>
In-Reply-To: <c12aa9b8-65a1-0cdf-8948-15309f16b955@googlemail.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Mon, 20 Feb 2023 12:26:48 +0100
Message-ID: <CACO55tvGQdHPnZEMAGPZN3K1nUCV-ruX_QNwSqQAg_z81ab0MA@mail.gmail.com>
Subject: Re: linux-6.2-rc4+ hangs on poweroff/reboot: Bisected
To:     Chris Clayton <chris2553@googlemail.com>
Cc:     Ben Skeggs <skeggsb@gmail.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Dave Airlie <airlied@gmail.com>, bskeggs@redhat.com,
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

On Mon, Feb 20, 2023 at 11:51 AM Chris Clayton <chris2553@googlemail.com> wrote:
>
>
>
> On 20/02/2023 05:35, Ben Skeggs wrote:
> > On Sun, 19 Feb 2023 at 04:55, Chris Clayton <chris2553@googlemail.com> wrote:
> >>
> >>
> >>
> >> On 18/02/2023 15:19, Chris Clayton wrote:
> >>>
> >>>
> >>> On 18/02/2023 12:25, Karol Herbst wrote:
> >>>> On Sat, Feb 18, 2023 at 1:22 PM Chris Clayton <chris2553@googlemail.com> wrote:
> >>>>>
> >>>>>
> >>>>>
> >>>>> On 15/02/2023 11:09, Karol Herbst wrote:
> >>>>>> On Wed, Feb 15, 2023 at 11:36 AM Linux regression tracking #update
> >>>>>> (Thorsten Leemhuis) <regressions@leemhuis.info> wrote:
> >>>>>>>
> >>>>>>> On 13.02.23 10:14, Chris Clayton wrote:
> >>>>>>>> On 13/02/2023 02:57, Dave Airlie wrote:
> >>>>>>>>> On Sun, 12 Feb 2023 at 00:43, Chris Clayton <chris2553@googlemail.com> wrote:
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> On 10/02/2023 19:33, Linux regression tracking (Thorsten Leemhuis) wrote:
> >>>>>>>>>>> On 10.02.23 20:01, Karol Herbst wrote:
> >>>>>>>>>>>> On Fri, Feb 10, 2023 at 7:35 PM Linux regression tracking (Thorsten
> >>>>>>>>>>>> Leemhuis) <regressions@leemhuis.info> wrote:
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> On 08.02.23 09:48, Chris Clayton wrote:
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> I'm assuming  that we are not going to see a fix for this regression before 6.2 is released.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Yeah, looks like it. That's unfortunate, but happens. But there is still
> >>>>>>>>>>>>> time to fix it and there is one thing I wonder:
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Did any of the nouveau developers look at the netconsole captures Chris
> >>>>>>>>>>>>> posted more than a week ago to check if they somehow help to track down
> >>>>>>>>>>>>> the root of this problem?
> >>>>>>>>>>>>
> >>>>>>>>>>>> I did now and I can't spot anything. I think at this point it would
> >>>>>>>>>>>> make sense to dump the active tasks/threads via sqsrq keys to see if
> >>>>>>>>>>>> any is in a weird state preventing the machine from shutting down.
> >>>>>>>>>>>
> >>>>>>>>>>> Many thx for looking into it!
> >>>>>>>>>>
> >>>>>>>>>> Yes, thanks Karol.
> >>>>>>>>>>
> >>>>>>>>>> Attached is the output from dmesg when this block of code:
> >>>>>>>>>>
> >>>>>>>>>>         /bin/mount /dev/sda7 /mnt/sda7
> >>>>>>>>>>         /bin/mountpoint /proc || /bin/mount /proc
> >>>>>>>>>>         /bin/dmesg -w > /mnt/sda7/sysrq.dmesg.log &
> >>>>>>>>>>         /bin/echo t > /proc/sysrq-trigger
> >>>>>>>>>>         /bin/sleep 1
> >>>>>>>>>>         /bin/sync
> >>>>>>>>>>         /bin/sleep 1
> >>>>>>>>>>         kill $(pidof dmesg)
> >>>>>>>>>>         /bin/umount /mnt/sda7
> >>>>>>>>>>
> >>>>>>>>>> is executed immediately before /sbin/reboot is called as the final step of rebooting my system.
> >>>>>>>>>>
> >>>>>>>>>> I hope this is what you were looking for, but if not, please let me know what you need
> >>>>>>>>
> >>>>>>>> Thanks Dave. [...]
> >>>>>>> FWIW, in case anyone strands here in the archives: the msg was
> >>>>>>> truncated. The full post can be found in a new thread:
> >>>>>>>
> >>>>>>> https://lore.kernel.org/lkml/e0b80506-b3cf-315b-4327-1b988d86031e@googlemail.com/
> >>>>>>>
> >>>>>>> Sadly it seems the info "With runpm=0, both reboot and poweroff work on
> >>>>>>> my laptop." didn't bring us much further to a solution. :-/ I don't
> >>>>>>> really like it, but for regression tracking I'm now putting this on the
> >>>>>>> back-burner, as a fix is not in sight.
> >>>>>>>
> >>>>>>> #regzbot monitor:
> >>>>>>> https://lore.kernel.org/lkml/e0b80506-b3cf-315b-4327-1b988d86031e@googlemail.com/
> >>>>>>> #regzbot backburner: hard to debug and apparently rare
> >>>>>>> #regzbot ignore-activity
> >>>>>>>
> >>>>>>
> >>>>>> yeah.. this bug looks a little annoying. Sadly the only Turing based
> >>>>>> laptop I got doesn't work on Nouveau because of firmware related
> >>>>>> issues and we probably need to get updated ones from Nvidia here :(
> >>>>>>
> >>>>>> But it's a bit weird that the kernel doesn't shutdown, because I don't
> >>>>>> see anything in the logs which would prevent that from happening.
> >>>>>> Unless it's waiting on one of the tasks to complete, but none of them
> >>>>>> looked in any way nouveau related.
> >>>>>>
> >>>>>> If somebody else has any fancy kernel debugging tips here to figure
> >>>>>> out why it hangs, that would be very helpful...
> >>>>>>
> >>>>>
> >>>>> I think I've figured this out. It's to do with how my system is configured. I do have an initrd, but the only thing on
> >>>>> it is the cpu microcode which, it is recommended, should be loaded early. The absence of the NVidia firmare from an
> >>>>> initrd doesn't matter because the drivers for the hardware that need to load firmware are all built as modules, So, by
> >>>>> the time the devices are configured via udev, the root partition is mounted and the drivers can get at the firmware.
> >>>>>
> >>>>> I've found, by turning on nouveau debug and taking a video of the screen as the system shuts down, that nouveau seems to
> >>>>> be trying to run the scrubber very very late in the shutdown process. The problem is that by this time, I think the root
> >>>>> partition, and thus the scrubber binary, have become inaccessible.
> >>>>>
> >>>>> I seem to have two choices - either make the firmware accessible on an initrd or unload the module in a shutdown script
> >>>>> before the scrubber binary becomes inaccessible. The latter of these is the workaround I have implemented whilst the
> >>>>> problem I reported has been under investigation. For simplicity, I think I'll promote my workaround to being the
> >>>>> permanent solution.
> >>>>>
> >>>>> So, apologies (and thanks) to everyone whose time I have taken up with this non-bug.
> >>>>>
> >>>>
> >>>> Well.. nouveau shouldn't prevent the system from shutting down if the
> >>>> firmware file isn't available. Or at least it should print a
> >>>> warning/error. Mind messing with the code a little to see if skipping
> >>>> it kind of works? I probably can also come up with a patch by next
> >>>> week.
> >>>>
> >>> Well, I'd love to but a quick glance at the code caused me to bump into this obscenity:
> >>>
> >>> int
> >>> gm200_flcn_reset_wait_mem_scrubbing(struct nvkm_falcon *falcon)
> >>> {
> >>>         nvkm_falcon_mask(falcon, 0x040, 0x00000000, 0x00000000);
> >>>
> >>>         if (nvkm_msec(falcon->owner->device, 10,
> >>>                 if (!(nvkm_falcon_rd32(falcon, 0x10c) & 0x00000006))
> >>>                         break;
> >>>         ) < 0)
> >>>                 return -ETIMEDOUT;
> >>>
> >>>         return 0;
> >>> }
> >>>
> >>> nvkm_msec is #defined to nvkm_usec which in turn is #defined to nvkm_nsec where the loop that the break is related to
> >>> appears
> >>
> >> I think someone who knows the code needs to look at this. What I can confirm is that after a freeze, I waited for 90
> >> seconds for a timeout to occur, but it didn't.
> > Hey,
> >
> > Are you able to try the attached patch for me please?
> >
> > Thanks,
> > Ben.
> >
>
> Thanks Ben.
>
> Yes, this patch fixes the lockup on reboot and poweroff that I've been seeing on my laptop. As you would expect,
> offloaded rendering is still working and the discrete GPU is being powered on and off as required.
>
> Thanks.
>
> Reported-by: Chris Clayton <chris2553@googlemail.com>
> Tested-by: Chris Clayton <chris2553@googlemail.com>
>

Ben, did you manage to get push rights to drm-misc by now or should I
just pick the patch and push it through -fixes?

> >>
> >>
> >> .> Chris
> >>>>>
> >>>>>>> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> >>>>>>> --
> >>>>>>> Everything you wanna know about Linux kernel regression tracking:
> >>>>>>> https://linux-regtracking.leemhuis.info/about/#tldr
> >>>>>>> That page also explains what to do if mails like this annoy you.
> >>>>>>>
> >>>>>>> #regzbot ignore-activity
> >>>>>>>
> >>>>>>
> >>>>>
> >>>>
>

