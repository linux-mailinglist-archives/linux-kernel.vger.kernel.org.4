Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA5A710A92
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 13:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239810AbjEYLKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 07:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbjEYLKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 07:10:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E93132
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 04:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685012959;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UX0UHXOxx8t0yqKIWochGuP3ifI6xO7B7bwx//kqB1E=;
        b=bXwBMqRecBp8Fwl2pJatj7w+R4RM9oNTYT4gr2ezWKv3+IzRcrYE8UPpYM99D1QP5IBjn+
        0uTPOrR6dIr6IQ+mB17nh4iAxBcjDZnl+3bSCqb/yQBMj1ad1UxImwgW9zw6KQ/gaz4OgP
        lsYsXA852TI/Owp8B16KOJ+Z+HsDFt0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-AysWvMBONIWqa4PNupHcdw-1; Thu, 25 May 2023 07:09:17 -0400
X-MC-Unique: AysWvMBONIWqa4PNupHcdw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-96fd3757c1dso59818366b.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 04:09:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685012956; x=1687604956;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UX0UHXOxx8t0yqKIWochGuP3ifI6xO7B7bwx//kqB1E=;
        b=BWqaZTaRFe7J9WuCBpwo11/7nJH6JyKWBC982as8t9xYit3wnsuAvOifBkwolXuKRq
         GXwCyAQnPkg6BYNI8tIiOaQ3i0v91IUv0l7j6gLLz6pyhvRTnjrMkdzeponSCwivui/T
         q5W3FJ+RsChGlbRdZWFUueXRPV9XavkM7AiSvDBCyXnAeuX9RsbMCiKSBekr9JhVQ36r
         zjzZF5nmUuoAtsaVDSaqu2Tb4i3UInqI0bP2ut9keE7BoPq/KIIemeYuEKYq52l2miuX
         EBb0prIWOUV23jAIeqp4UEmFAmZfIMT6L3eLRS1+BPB4a01tzXWKhG850YoLgKFr5rb/
         a9Lg==
X-Gm-Message-State: AC+VfDyg0fGKFP6tU9CcNqSg2aiHZiVCm7dJqikNsc3QRNWhon/sRZye
        ZeE2Hu2wLYPPTwzbuWeo97rDfFbmN+ZIonBotVdsH6NpZZDok8LINt24S2gp6JwN802XLJ06ZLp
        YC9JmRVtWeGXzFM/QrAmLebkI
X-Received: by 2002:a17:907:3d87:b0:96a:bf50:3ad9 with SMTP id he7-20020a1709073d8700b0096abf503ad9mr1270723ejc.43.1685012956267;
        Thu, 25 May 2023 04:09:16 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7xCbN+UoRC7K+jNs4/2FslhJ8VLM5029hd36tSIsq0lzZyGfl4gno14325M08N+N5vAV48TA==
X-Received: by 2002:a17:907:3d87:b0:96a:bf50:3ad9 with SMTP id he7-20020a1709073d8700b0096abf503ad9mr1270698ejc.43.1685012955900;
        Thu, 25 May 2023 04:09:15 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? ([2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id pg27-20020a170907205b00b009662d0e637esm686407ejb.155.2023.05.25.04.09.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 04:09:15 -0700 (PDT)
Message-ID: <ade1f0d1-0a6b-7eed-cc79-139e0036e562@redhat.com>
Date:   Thu, 25 May 2023 13:09:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 0/1] platform/x86: asus-wmi: add support for ASUS
 screenpad
Content-Language: en-US, nl
To:     Luke Jones <luke@ljones.dev>
Cc:     platform-driver-x86@vger.kernel.org,
        =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, acpi4asus-user@lists.sourceforge.net,
        corentin.chary@gmail.com, markgross@kernel.org, jdelvare@suse.com,
        linux@roeck-us.net
References: <20230505043013.2622603-1-luke@ljones.dev>
 <4be2cc57-59b9-24e2-fd10-f2af175ff518@redhat.com>
 <02f28fe4-bca4-f9d7-a9be-0f1999662d62@redhat.com>
 <FD1QUR.SO09CWU6HM4Q1@ljones.dev>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <FD1QUR.SO09CWU6HM4Q1@ljones.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luke,

On 5/16/23 00:34, Luke Jones wrote:
> On Mon, May 15 2023 at 14:39:10 +0200, Hans de Goede <hdegoede@redhat.com> wrote:

<snip>

>>>  Thank you on your work for this.
>>>
>>>  Unfortunately I did not get a chance to react to the v1 posting and
>>>  the remarks to switch to using /sys/class/backlight there before you
>>>  posted this v2.
>>>
>>>  Technically the remark to use /sys/class/backlight for this is
>>>  completely correct. But due to the way how userspace uses
>>>  /sys/class/backlight this is a problematic.
>>>
>>>  Userspace basically always assumes there is only 1 LCD panel
>>>  and it then looks at /sys/class/backlight and picks 1
>>>  /sys/class/backlight entry and uses that for the brightness
>>>  slider in the desktop-environment UI / system-menu as well
>>>  as to handle brightness up/down keyboard hotkey presses.
>>>
> 
> IMO, desktops need to adjust this expectation and start offering controls for all possible screens. This would open up the possibility of setting brightness of modern external screens also. And then they should use the "Primary display" brightness controls, or at least offer an option to set which is controlled.

Right this is what the proposal at:

https://lore.kernel.org/dri-devel/b61d3eeb-6213-afac-2e70-7b9791c86d2e@redhat.com/

is about. ATM userspace cannot reliably determine which
/sys/class/backlight device belongs to which screen /
video-output . So before desktops can offer this functionality
we first need to fix the kernel <-> userspace APIs for this.

<snip>

>>>  So now we end up with 2 "raw" type backlight devices and if
>>>  e.g. gnome-settings-daemon picks the right one now sort of
>>>  is left to luck.
>>>
> 
> In a test KDE at least picked the right one.

That is good to know I'm still not entirely convinced using
/sys/class/backlight for this is a good idea though. 

See below.

>>>  Well that is not entirely true, at least gnome-settings-daemon
>>>  prefers raw backlight devices where the parent has an "enabled"
>>>  sysfs attribute (it expects the parent to be a drm_connector
>>>  object) and where that enabled attribute reads as "enabled".
>>>
> 
> Ah I see. Parent for screenpad is "platform", while the main is on igpu with parent "pci". I will paste some udev info at the end of this reply.

Actually for the backlight-device on the iGPU the parent
should be a drm-connector for the eDP (and the parent of
that is the iGPU PCI device). Note I did not check
the udev dump.

<snip>

>>>  Luke, question how does the second/exta panel look
>>>  from an outputting video to it pov ?  Does it show
>>>  up as an extra screen connected to a drm_connector
>>>  on one of the GPUs. IOW can it be used with standard
>>>  kernel-modesetting APIs ?
>>
> 
> Hi Hans, sorry about delay in response, just been tied up with work.
> 
> As I don't actually have this kind of laptop I can't easily get info, but I can ask a few people in my discord for information. Is there anything in particular you would need to know? From my basic understanding some of the points are:
> 
> 1. It does show as an actual additional screen
> 2. Internal wiring is unclear, when dispaly MUX is switched to dgpu the screen is still detected but not drawn to
> 3. Point 2 is actually more uncertain as it seems only wayland had this issue? I will get more info.

Right, so I think we first need to better understand the interactions between the WMI calls you are making and the drm/kms interface.

Question 1:

If you turn the second screen off through WMI, does it get seen as disconnected by the drm/kms driver then. Or does the drm/kms driver just go on treating it as an extra connected display, still drawing now no longer visible content to it ?

IOW does the desktop environment's monitor-config panel no longer show the extra display after disabling it through WMI?

The best way to check this is look under /sys/class/drm and find out which /sys/class/drm/card#-<conn-type>-# entry belongs to the extra panel. Step 1 check for all card#-<conn-type>-# entries
where status returns connected, e.g. :

[hans@shalem ~]$ cat /sys/class/drm/card1-DP-1/status 
connected

Step 2: for the connected ones cat the modes, e.g.:

[hans@shalem ~]$ cat /sys/class/drm/card1-DP-1/modes
1920x1080
1600x1200
...

And find the one which matches with the resolution of the extra panel (the one which does not match with the resolution of the main panel).

Then turn the extra panel of through WMI and cat the status attribute again. If that still reads connected then that means the desktop environment keeps seeing an extra display output which is not ideal. This will e.g. cause any windows which were on the extra panel to stay there, even though they are no longer visible.


Question 2:

If you turn the second screen off through drm/kms, using the desktop environments monitor config panel does this also turn off the backlight ?

After disabling the screen in the desktop environments monitor config check that the enabled attribute, e.g. cat /sys/class/drm/card1-DP-1/enabled shows disabled and after verifying this look at the extra screen in a dark room, do you see any backlight bleed indicating the backlight is still  on?


We really want the backlight on/off state and the drm-connector enabled state to match. My proposal from above will allow this once implemented. Until we can hook this all up nicely I think it might be better to just go with the custom sysfs attributes from your v1 patch rather then adding a /sys/class/backlight device for this.


> So I think now is probably a good time to raise a particular issue I've encountered with the last two years: the display MUX.
> 
> As I understand it now, there are two types of new MUX - the manual switch, and the newer "Advanced Optimus" automatic switch. The issues I have are with the manual switch since I've not encountered the advanced optimus yet.
> 
> When the switch is. uh. switched. the dgpu drives the internal display, and I expect that since the display is now detected through the dgpu, this is why the dgpu is kept awake to drive it. But, the igpu is also still active, and because of this the initial boot from grub to display-manager is a black screen including tty. This means anyone with an encrypted drive will never see the prompt and they believe they have a failed boot. I don't know what to do about this?

Is this with EFI booting or with classic BIOS boot? With EFI booting the EFIFB should be put on the right GPU by the firmware. So I suspect this is with classic BIOS boot?

I think the best thing to do here is to just use EFI on machines like this. That or put grub in text mode so that it makes BIOS calls to display text. Using GRUB_TERMINAL_OUTPUT=gfxterm combined with classic BIOS booting will make grub try to directly drive the gfx card itself and I'm not surprised that it gets that wrong in this case.

Note I think that just using EFI is prefered over switching grub to GRUB_TERMINAL_OUTPUT=console. I would expect GRUB_TERMINAL_OUTPUT=console to also work but I'm not sure. I don't think that the classic BIOS boot stuff is still tested by laptop vendors and esp. not tested with non standard BIOS settings ...


> What I would love is somehow to either disable the igpu in kernel if the MUX is toggled, or to change which device is the primary. Do you have any thoughts on where I should start on this?

Not really, on the hybrid gfx devices which I have when optimus is disabled in the BIOS, muxing the main LCD to the Nvidia GPU the iGPU gets disabled by the BIOS.

If the iGPU in these models does not get disabled then I guess it is still needed for some connectors, e.g. maybe for displays connected to one of the thunderbolt ports ?

Or maybe it is left on now a days for things like Intel quicksync ?

> An additional problem: `boot_vga` property of display adaptors. I've been using this as a first-stage check in supergfxctl to determine if there was a switch, but it is never ever reliable - sometimes it changes, sometimes it is entirely blank (using udev to fetch properties). And then I need to use a combination of checks to determine state. So this `boot_vga` seems to always be available but is practically unusable.

I'm afraid I cannot really help here. I think most of these laptops ship in Optimus mode (so both GPUs enabled) by default. And the non optimus mode is likely only tested under certain circumstances so there are going to be firmware bugs here. And Linux' code for detecting this likely also has issues of its own. Combine the 2 and you get lots of "fun".

I guess this is also what trips up grub. I wonder if this is better / more reliable under EFI mode though? Esp. since that is what vendors actually QA/test.

Regards,

Hans


