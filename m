Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A9D723C64
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 10:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236721AbjFFI7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 04:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235189AbjFFI7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 04:59:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC7CE6F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 01:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686041890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AQST2b6YrtEOQE9e4aslcMdpne3NJ9evDrIjUqUNscM=;
        b=S3o+0VSvce9JRrluKcokV7wmrrLjzKmMhlUxi3CD8vfEiaoF+TIPXT16YsnMsdj3l5mpBV
        NnxTwVXJm4vrg6Obo8FFJndc7SR4cB46Q18PvN1N6sqlcxTTauwr2AixOgpiZuk4x6ihRn
        hTTlhLAXJ6TsSgmOgeITN8y2BwkJtgI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-Uv2lsas8ODCGdQXpfe_hZQ-1; Tue, 06 Jun 2023 04:58:09 -0400
X-MC-Unique: Uv2lsas8ODCGdQXpfe_hZQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9745f301bcfso326799266b.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 01:58:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686041888; x=1688633888;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AQST2b6YrtEOQE9e4aslcMdpne3NJ9evDrIjUqUNscM=;
        b=PxV3UkRHvxVrtweFag/+uzk6ptqukIax6gMtvRiE+0aJ6eGq0CaPAYDc481sFGhuTV
         kEmd9J8lPB8uvOyWghQcN+xMO0VRn06pzVGuUpl/QPg5ASMHhw3eXPqubV63MgS+mquQ
         zYIHBwxDerFWjp6cyvYbwsr+D0ZV4wpXeBteGnAOJaGNbk2TifJbkzTXQSPdJgV1Dufe
         zgYBFGc7nvyNfzJc3T9ffAVjGoOTy28pZPlbq7CRwpEn+NCPFTI3mCNCOG/tZF8jnCUQ
         509wFy/82LtFmaAcG3twfQntmI+1mSXwTvPNHIRulDImyW9qLe2tbjyMTCMdSTPhydWu
         xpBQ==
X-Gm-Message-State: AC+VfDzCqEtA/jYUNctE8/tR8BxPgEoyb20E4Ts4mn/IdEkikrX6XDLU
        xibLinO+BUVSg/etxVJZkt096pwLSstVPn6t0hrQCv7j+JD/kpLft7DcAbzNq/nHohdrteV2eyL
        5GM0RxDFPa8KqTNuOMd6GK67b
X-Received: by 2002:a17:906:9750:b0:973:edba:df30 with SMTP id o16-20020a170906975000b00973edbadf30mr2075503ejy.61.1686041888468;
        Tue, 06 Jun 2023 01:58:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7MDzMA9108TD5iU7c26PIK3JtdzLGFrMjNae1OqX0U7wrIWJvVr0Xj+0ROKEWAz0azLZEAEQ==
X-Received: by 2002:a17:906:9750:b0:973:edba:df30 with SMTP id o16-20020a170906975000b00973edbadf30mr2075479ejy.61.1686041888133;
        Tue, 06 Jun 2023 01:58:08 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id jp25-20020a170906f75900b0096f675ce45csm5285337ejb.182.2023.06.06.01.58.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 01:58:07 -0700 (PDT)
Message-ID: <ffdd2d13-975e-1c74-0d2b-132ba461a3ee@redhat.com>
Date:   Tue, 6 Jun 2023 10:58:06 +0200
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
 <ade1f0d1-0a6b-7eed-cc79-139e0036e562@redhat.com>
 <06314c8dc4adeb69cd7801f9621c831f75a37c89.camel@ljones.dev>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <06314c8dc4adeb69cd7801f9621c831f75a37c89.camel@ljones.dev>
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

On 6/4/23 06:52, Luke Jones wrote:
> On Thu, 2023-05-25 at 13:09 +0200, Hans de Goede wrote:

<snip>

>> Right, so I think we first need to better understand the interactions
>> between the WMI calls you are making and the drm/kms interface.
>>
>> Question 1:
>>
>> If you turn the second screen off through WMI, does it get seen as
>> disconnected by the drm/kms driver then. Or does the drm/kms driver
>> just go on treating it as an extra connected display, still drawing
>> now no longer visible content to it ?
> 
> It is most certainly viewed as disconnected.

Ok, that is good.

>> IOW does the desktop environment's monitor-config panel no longer
>> show the extra display after disabling it through WMI?
> 
> That is correct, it is no-longer a connected and visible display

Ack.

>> The best way to check this is look under /sys/class/drm and find out
>> which /sys/class/drm/card#-<conn-type>-# entry belongs to the extra
>> panel. Step 1 check for all card#-<conn-type>-# entries
>> where status returns connected, e.g. :
>>
>> [hans@shalem ~]$ cat /sys/class/drm/card1-DP-1/status 
>> connected
>>
> 
> On disable the status does change to:
> cat /sys/class/drm/card1-DP-5/enabled
> disabled

Ok, that is good.


>> Step 2: for the connected ones cat the modes, e.g.:
>>
>> [hans@shalem ~]$ cat /sys/class/drm/card1-DP-1/modes
>> 1920x1080
>> 1600x1200
>> ...
>>
>> And find the one which matches with the resolution of the extra panel
>> (the one which does not match with the resolution of the main panel).
>>
>> Then turn the extra panel of through WMI and cat the status attribute
>> again. If that still reads connected then that means the desktop
>> environment keeps seeing an extra display output which is not ideal.
>> This will e.g. cause any windows which were on the extra panel to
>> stay there, even though they are no longer visible.
>>
>>
>> Question 2:
>>
>> If you turn the second screen off through drm/kms, using the desktop
>> environments monitor config panel does this also turn off the
>> backlight ?
> 
> The screen is dark but there is still some backlight coming out of it.
> I think this means I need to add a small pre-off to the patch to ensure
> backlight is fully off when display is turned off.

I'm afraid that this is not going to be easy to fix at the kernel level,
we first need to tie backlight control to drm-connectors as I proposed
(and plan to implement when I can make time):

https://lore.kernel.org/dri-devel/b61d3eeb-6213-afac-2e70-7b9791c86d2e@redhat.com/

Once that is in place we can simply make the drm-code call out to
the backlight driver and have it turn the backlight off when disabling
the output through the drm/kms interface.

>> After disabling the screen in the desktop environments monitor config
>> check that the enabled attribute, e.g. cat /sys/class/drm/card1-DP-
>> 1/enabled shows disabled and after verifying this look at the extra
>> screen in a dark room, do you see any backlight bleed indicating the
>> backlight is still  on?
>>
> 
> Shows as disabled
> 
>>
>> We really want the backlight on/off state and the drm-connector
>> enabled state to match. My proposal from above will allow this once
>> implemented. Until we can hook this all up nicely I think it might be
>> better to just go with the custom sysfs attributes from your v1 patch
>> rather then adding a /sys/class/backlight device for this.
>>
> 
> I would like to go with the backlight patch as it seems more likely I
> can adjust this without breaking userspace if required in future. The
> WMI controls behave as expected to.

Ok, lets go with the v2 which adds /sys/class/backlight support then.

I must warn you though if this does turn out to cause issues I'll have
no choice but to revert it.

I must admit I've lost track a bit of the state of v2 during this
discussion.  Can I pick up v2 as is, or were there (other) remarks
which need addressing and should I expect a v3 ?

####### Switch to (off-topic) GPU mux discussion ########

>>> So I think now is probably a good time to raise a particular issue
>>> I've encountered with the last two years: the display MUX.
>>>
>>> As I understand it now, there are two types of new MUX - the manual
>>> switch, and the newer "Advanced Optimus" automatic switch. The
>>> issues I have are with the manual switch since I've not encountered
>>> the advanced optimus yet.
>>>
>>> When the switch is. uh. switched. the dgpu drives the internal
>>> display, and I expect that since the display is now detected
>>> through the dgpu, this is why the dgpu is kept awake to drive it.
>>> But, the igpu is also still active, and because of this the initial
>>> boot from grub to display-manager is a black screen including tty.
>>> This means anyone with an encrypted drive will never see the prompt
>>> and they believe they have a failed boot. I don't know what to do
>>> about this?
>>
>> Is this with EFI booting or with classic BIOS boot? With EFI booting
>> the EFIFB should be put on the right GPU by the firmware. So I
>> suspect this is with classic BIOS boot?
> 
> No this is with EFI boot always. I'm not even sure these machines still
> have the ability to boot oldschool bios style.

Hmm, weird with EFI grub is just using the EFI text output protocol
so what is happening here at the grub level is actually a bug in
the firmware of the laptop(s)...

>> I think the best thing to do here is to just use EFI on machines like
>> this. That or put grub in text mode so that it makes BIOS calls to
>> display text. Using GRUB_TERMINAL_OUTPUT=gfxterm combined with
>> classic BIOS booting will make grub try to directly drive the gfx
>> card itself and I'm not surprised that it gets that wrong in this
>> case.
>> Note I think that just using EFI is prefered over switching grub to
>> GRUB_TERMINAL_OUTPUT=console. I would expect
>> GRUB_TERMINAL_OUTPUT=console to also work but I'm not sure. I don't
>> think that the classic BIOS boot stuff is still tested by laptop
>> vendors and esp. not tested with non standard BIOS settings ...
> 
> The grub gfx mode is GRUB_TERMINAL_OUTPUT="console", fedora default in
> all cases here. Grub itself shows fine when the MUX mode is in dgpu
> mode (aka, internal display connected to dgpu).

Ah ok, so I misunderstood and the problem only happens *after* grub?

Have I understood that correctly?

And this is on Fedora with the nvidia binary driver ?

The problem then likely is that the nvidia binary driver is not in
the initrd (which is by design since it may need to be rebuild on
a driver update while the kernel is kept at the same version,
so the initrd won't be rebuild).

So during the initrd there then is no kms driver to drive the
internal display.

Normally plymouth falls back to using the efifb (through simpledrm)
but that is after a pretty large timeout and I think this may not
be happening here because plymouth maybe thinks there is a kms
capable display connected to the iGPU for some reason
(maybe the extra screenpad panel ?)

As a workaround you can tell plymouth to use the simpledrm kms
device as soon as it becomes available instead of waiting for
a native kms driver. To do this add "plymouth.use-simpledrm" to
the kernel commandline. I think that this will work around
the problem.

> P.S> I will go ahead with the screen patch as it looks like this
> behaves as expected minus the need to turn off BL before turn off
> display. I will submit revision later in the week.

Ok, so that answers my question from above and I should wait for a v3 :)

Regards,

Hans



