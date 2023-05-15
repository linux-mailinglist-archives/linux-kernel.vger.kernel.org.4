Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1442702CF0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 14:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241268AbjEOMlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 08:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241968AbjEOMkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 08:40:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E01019BB
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 05:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684154354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lT/IF6S2V5Zzk178e+Y1pzx60+tI2NTT4SZX6FLl/8M=;
        b=EnA/ccrgyr62wk8D8Fhn6xAJr1R9NPB3ezESzmqqRQv6/wKl9VMBI56eK6ZKgWht+5cqMy
        sjKg6IdCdkk7O1MwU+JRUGEJG35D3HbDoPqdlgabgeQhvOAGVue5kL3OVrHKhQAORdIrcl
        h1UcoqUOdnqnjNIARN573hZkKueaBWw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-NwQ8wQxdOuW6sm-SOeQVEg-1; Mon, 15 May 2023 08:39:13 -0400
X-MC-Unique: NwQ8wQxdOuW6sm-SOeQVEg-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-50dddc6d049so5546329a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 05:39:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684154352; x=1686746352;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lT/IF6S2V5Zzk178e+Y1pzx60+tI2NTT4SZX6FLl/8M=;
        b=gLAvYHIZxEL//ATQ9P+UtYlgrtgSI7pXSdCBWpeVcTzk5GRLzvJEqhNC1yOe1DB/8z
         qNZInRr58t2EZzcGctZ+VvROZB9OErQ/khwQSfOD1vj6s7VOr6TKiu2ObvNAp8peu5WA
         VbHFet4cPyuyfBE5GtgPLquqBDEeHxV6mv6hN3y5NbGQij0nt9lOtmU5XqnhOTDMgNYy
         1rTIsgvI9STg/B45y9fe6lQp3gHNgO5t86Wf98sgpGvW/f0HICJTUWqXoKIQLHsPMSk/
         eEizcWzD9Hlbl88mJcasD+JUdH87+hu8Gtzc9XRxIiEwbALPlC7nSr6Cpzxo411yneDF
         qjkg==
X-Gm-Message-State: AC+VfDwcnRiStrDteK3nsMVzEsEDtQV7JLLJzbOCK/m07NNlBCV7H3CZ
        FJrOkvQQ3IbPCWqhCYnyzdE9YoDzoTzWksADNDcVrtqt4Sw6XBjz6Myxx6zyMIXTsI9hkxI7zWW
        8LFBg6h/W/DnELhfaN3muRQxy
X-Received: by 2002:a17:907:9415:b0:94f:395b:df1b with SMTP id dk21-20020a170907941500b0094f395bdf1bmr28234965ejc.21.1684154352214;
        Mon, 15 May 2023 05:39:12 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7/j9wy+u2tobCE8F8u/7JHHd/NPJJavUEiF0Hkh3/5VUUBXiB1qB0rkUSQhEBySOi91jviSA==
X-Received: by 2002:a17:907:9415:b0:94f:395b:df1b with SMTP id dk21-20020a170907941500b0094f395bdf1bmr28234950ejc.21.1684154351840;
        Mon, 15 May 2023 05:39:11 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id v21-20020a1709060b5500b00965e68b8df5sm9443451ejg.76.2023.05.15.05.39.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 05:39:11 -0700 (PDT)
Message-ID: <02f28fe4-bca4-f9d7-a9be-0f1999662d62@redhat.com>
Date:   Mon, 15 May 2023 14:39:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 0/1] platform/x86: asus-wmi: add support for ASUS
 screenpad
Content-Language: en-US
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Luke D. Jones" <luke@ljones.dev>,
        platform-driver-x86@vger.kernel.org,
        =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, acpi4asus-user@lists.sourceforge.net,
        corentin.chary@gmail.com, markgross@kernel.org, jdelvare@suse.com,
        linux@roeck-us.net
References: <20230505043013.2622603-1-luke@ljones.dev>
 <4be2cc57-59b9-24e2-fd10-f2af175ff518@redhat.com>
In-Reply-To: <4be2cc57-59b9-24e2-fd10-f2af175ff518@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/6/23 13:52, Hans de Goede wrote:
> Hi Luke,
> 
> On 5/5/23 06:30, Luke D. Jones wrote:
>> Adds support for the screenpad(-plus) found on a few ASUS laptops that have a main 16:9 or 16:10 screen and a shorter screen below the main but above the keyboard.
>> The support consists of:
>> - On off control
>> - Setting brightness from 0-255
>>
>> There are some small quirks with this device when considering only the raw WMI methods:
>> 1. The Off method can only switch the device off
>> 2. Changing the brightness turns the device back on
>> 3. To turn the device back on the brightness must be > 1
>> 4. When the device is off the brightness can't be changed (so it is stored by the driver if device is off).
>> 5. Booting with a value of 0 brightness (retained by bios) means the bios will set a value of > 0, < 15 which is far too dim and was unexpected by testers. The compromise was to set the brightness to 60 which is a usable brightness if the module init brightness was under 15.
>> 6. When the device is off it is "unplugged"
>>
>> All of the above points are addressed within the patch to create a good user experience and keep within user expectations.
>>
>> Changelog:
>> - V2
>>   - Complete refactor to use as a backlight device
> 
> Thank you on your work for this.
> 
> Unfortunately I did not get a chance to react to the v1 posting and
> the remarks to switch to using /sys/class/backlight there before you
> posted this v2.
> 
> Technically the remark to use /sys/class/backlight for this is
> completely correct. But due to the way how userspace uses
> /sys/class/backlight this is a problematic.
> 
> Userspace basically always assumes there is only 1 LCD panel
> and it then looks at /sys/class/backlight and picks 1
> /sys/class/backlight entry and uses that for the brightness
> slider in the desktop-environment UI / system-menu as well
> as to handle brightness up/down keyboard hotkey presses.
> 
> In the (recent) past the kernel used to register e.g.
> both /sys/class/backlight/acpi_video0 and
> /sys/class/backlight/intel_backlight
> 
> For ACPI resp. direct hw control of the LCD panel backlight
> (so both control the same backlight, sometimes both work
> sometimes only 1 works).
> 
> Userspace uses the backlight-type to determine which backlight
> class to use, using (for GNOME, but I believe everywhere) the
> following preference order:
> 
> 1. First look for "firmware" type backlight devices (like acpi_video0)
> 2. Then try "platform" type backlight devices
> 3. Last try "raw" type backlight devices
> 
> And to make things work the kernel has been hiding the "acpi_video0"
> entry in cases where it is known that we need the "raw" aka native
> type backlight.
> 
> Luke you seem to already be partly aware of this, because the patch
> now has this:
> 
> 	props.type = BACKLIGHT_RAW; /* ensure this bd is last to be picked */
> 
> but almost all modern laptops exclusively use the raw/native type
> for backlight control of the main LCD panel.
> 
> So now we end up with 2 "raw" type backlight devices and if
> e.g. gnome-settings-daemon picks the right one now sort of
> is left to luck.
> 
> Well that is not entirely true, at least gnome-settings-daemon
> prefers raw backlight devices where the parent has an "enabled"
> sysfs attribute (it expects the parent to be a drm_connector
> object) and where that enabled attribute reads as "enabled".
> 
> This is done for hybrid-gfx laptops where there already may
> be 2 raw backlight-class devices, 1 for each GPU but only
> 1 of the 2 drm_connectors going to the main LCD panel should
> actually show as enabled.
> 
> So typing all this out I guess we could go ahead with using
> the backlight class for this after all, but this relies
> on userspace preferring raw backlight-class devices
> with a drm_connector-object parent which show as being
> enabled.
> 
> Any userspace code which does not do the parent has
> an enabled attr reading "enabled" or a similar check
> will end up picking a random backlight class device
> as control for the main panel brightness which will not
> always end well. So this all is a bit fragile ...
> 
> And I'm not sure what is the best thing to do here.
> 
> Barnabás, Ilpo, Guenter, any comments on this ?

Hmm, no comments from anyone on the potential problems of using
/sys/class/backlight for this causing potential userspace confusion
since normally /sys/class/backlight devices control the main LCD
brightness ?

Luke do you have any thoughts on this yourself ?

And can you answer this question please ?  :

> Luke, question how does the second/exta panel look
> from an outputting video to it pov ?  Does it show
> up as an extra screen connected to a drm_connector
> on one of the GPUs. IOW can it be used with standard
> kernel-modesetting APIs ?

Regards,

Hans


