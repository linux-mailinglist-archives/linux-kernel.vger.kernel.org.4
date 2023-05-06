Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB6366F91C2
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 13:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbjEFLxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 07:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbjEFLxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 07:53:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495E383F7
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 04:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683373934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d9HYJ21X01Eu+hi6xs2fwuX9W4E4k8z5R0PudPWWgj0=;
        b=XXU2lWLQXnbDrJylYG2gOcpNTGPB7N8mluddCf/vLBnwG6QR3k0N/ssOxDpdXhagpw8csx
        fQaIK62lBr6b1WA0KdiGyGxs+m+hUVNsltQeG2TCMeTYjE9tr8/+IRU2PPrbGBJdd3WW1T
        FWm8KSdq608MwEDaAVJM4cp9+LChhzo=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-4E3dkTvbOR2hPEdlSbbYfA-1; Sat, 06 May 2023 07:52:13 -0400
X-MC-Unique: 4E3dkTvbOR2hPEdlSbbYfA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-95c3f20df2dso259531866b.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 May 2023 04:52:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683373932; x=1685965932;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d9HYJ21X01Eu+hi6xs2fwuX9W4E4k8z5R0PudPWWgj0=;
        b=UjpylM2KZY5XvAL/s6KzbwYiBy0GZ2OO1Gf6jSH2izDLdhN93rwXJn9GHbUGqqPX05
         zme8hbH+IPP4EOSC16tCTYGCBRhl9KD9KOjwScXiZBaYVz8pSOX3aMDmr2IWohsvnYNM
         S1adBb58CScLaMPgjYj6Vrrsy5ohHz/1Tc0ncYhVxiw0/tWAu58QUmoZHvNeU3oMn5Pn
         3QajQfLnvAH7fnc8Lm6rd0IQ48i5oEq7xJbRBAa/l764nWhEqdJ6JbqpYq/q9WG/KR0f
         obkG1psFKPRSevo1/OliDbm6IEhvyOwnFG+4qWWzoFwzV81I2o26G5k6I2PdW8PzjFaU
         bJMA==
X-Gm-Message-State: AC+VfDwTM5g6UabGsiRPEBEzWn36Xg+1ZMGz4OldY6xR7C22dMSG24Nk
        ly4AfmsPDIK4/cLnOAAlEguQu3TQMBi+nbj+1LvDRiu6JIB/4cqCC1TQx3CYmE6VHafbd+s0IuB
        MZY/Z0Ja+vjAINAsFzPVqBaEz
X-Received: by 2002:a17:907:7e91:b0:94f:967d:e4f with SMTP id qb17-20020a1709077e9100b0094f967d0e4fmr4207853ejc.39.1683373932056;
        Sat, 06 May 2023 04:52:12 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5EqdCSAFLRdaZFoDK9jX3YTYbb6j8tTgXmxZqtWYWcFs4n/b0DcHlCQm9mo7gv6JvjMEmOQw==
X-Received: by 2002:a17:907:7e91:b0:94f:967d:e4f with SMTP id qb17-20020a1709077e9100b0094f967d0e4fmr4207837ejc.39.1683373931757;
        Sat, 06 May 2023 04:52:11 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id q16-20020a1709060e5000b009662c57b4ffsm136695eji.96.2023.05.06.04.52.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 May 2023 04:52:11 -0700 (PDT)
Message-ID: <4be2cc57-59b9-24e2-fd10-f2af175ff518@redhat.com>
Date:   Sat, 6 May 2023 13:52:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 0/1] platform/x86: asus-wmi: add support for ASUS
 screenpad
Content-Language: en-US, nl
To:     "Luke D. Jones" <luke@ljones.dev>,
        platform-driver-x86@vger.kernel.org,
        =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, acpi4asus-user@lists.sourceforge.net,
        corentin.chary@gmail.com, markgross@kernel.org, jdelvare@suse.com,
        linux@roeck-us.net
References: <20230505043013.2622603-1-luke@ljones.dev>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230505043013.2622603-1-luke@ljones.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luke,

On 5/5/23 06:30, Luke D. Jones wrote:
> Adds support for the screenpad(-plus) found on a few ASUS laptops that have a main 16:9 or 16:10 screen and a shorter screen below the main but above the keyboard.
> The support consists of:
> - On off control
> - Setting brightness from 0-255
> 
> There are some small quirks with this device when considering only the raw WMI methods:
> 1. The Off method can only switch the device off
> 2. Changing the brightness turns the device back on
> 3. To turn the device back on the brightness must be > 1
> 4. When the device is off the brightness can't be changed (so it is stored by the driver if device is off).
> 5. Booting with a value of 0 brightness (retained by bios) means the bios will set a value of > 0, < 15 which is far too dim and was unexpected by testers. The compromise was to set the brightness to 60 which is a usable brightness if the module init brightness was under 15.
> 6. When the device is off it is "unplugged"
> 
> All of the above points are addressed within the patch to create a good user experience and keep within user expectations.
> 
> Changelog:
> - V2
>   - Complete refactor to use as a backlight device

Thank you on your work for this.

Unfortunately I did not get a chance to react to the v1 posting and
the remarks to switch to using /sys/class/backlight there before you
posted this v2.

Technically the remark to use /sys/class/backlight for this is
completely correct. But due to the way how userspace uses
/sys/class/backlight this is a problematic.

Userspace basically always assumes there is only 1 LCD panel
and it then looks at /sys/class/backlight and picks 1
/sys/class/backlight entry and uses that for the brightness
slider in the desktop-environment UI / system-menu as well
as to handle brightness up/down keyboard hotkey presses.

In the (recent) past the kernel used to register e.g.
both /sys/class/backlight/acpi_video0 and
/sys/class/backlight/intel_backlight

For ACPI resp. direct hw control of the LCD panel backlight
(so both control the same backlight, sometimes both work
sometimes only 1 works).

Userspace uses the backlight-type to determine which backlight
class to use, using (for GNOME, but I believe everywhere) the
following preference order:

1. First look for "firmware" type backlight devices (like acpi_video0)
2. Then try "platform" type backlight devices
3. Last try "raw" type backlight devices

And to make things work the kernel has been hiding the "acpi_video0"
entry in cases where it is known that we need the "raw" aka native
type backlight.

Luke you seem to already be partly aware of this, because the patch
now has this:

	props.type = BACKLIGHT_RAW; /* ensure this bd is last to be picked */

but almost all modern laptops exclusively use the raw/native type
for backlight control of the main LCD panel.

So now we end up with 2 "raw" type backlight devices and if
e.g. gnome-settings-daemon picks the right one now sort of
is left to luck.

Well that is not entirely true, at least gnome-settings-daemon
prefers raw backlight devices where the parent has an "enabled"
sysfs attribute (it expects the parent to be a drm_connector
object) and where that enabled attribute reads as "enabled".

This is done for hybrid-gfx laptops where there already may
be 2 raw backlight-class devices, 1 for each GPU but only
1 of the 2 drm_connectors going to the main LCD panel should
actually show as enabled.

So typing all this out I guess we could go ahead with using
the backlight class for this after all, but this relies
on userspace preferring raw backlight-class devices
with a drm_connector-object parent which show as being
enabled.

Any userspace code which does not do the parent has
an enabled attr reading "enabled" or a similar check
will end up picking a random backlight class device
as control for the main panel brightness which will not
always end well. So this all is a bit fragile ...

And I'm not sure what is the best thing to do here.

Barnabás, Ilpo, Guenter, any comments on this ?

Regards,

Hans


p.s.

Note I'm working on allowing brightness control for
multiple screens in a sane way, see:

https://lore.kernel.org/dri-devel/b61d3eeb-6213-afac-2e70-7b9791c86d2e@redhat.com/

The last few kernel-cycles I have landed a refactor/cleanup
of the existing backlight code so that we only ever
register 1 /sys/class/backlight entry for the main LCD
panel, instead of having e.g. both acpi_video0 + intel_backlight
and relying on userspace preferring acpi_video0 in that case.

And when I can find time for it I plan to implement
the API in the linked RFC, which allows properly
dealing with all this.

Luke, question how does the second/exta panel look
from an outputting video to it pov ?  Does it show
up as an extra screen connected to a drm_connector
on one of the GPUs. IOW can it be used with standard
kernel-modesetting APIs ?

