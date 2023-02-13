Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8DC69464A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 13:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjBMMuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 07:50:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjBMMuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 07:50:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94EB53AB6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 04:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676292565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1FWWxthwKmHnCwh/VB+LOrY7MxDsLLnsFPiG0T4E2UM=;
        b=FKZv4sbN//QlXvYJSbSWZLXBoEwWc4TkwikmyixEkJE7u514/djmZC5Pt9UGElUU7gCLjI
        fzy4Oa5cifHG6FA+k7pGkDhf5HmUSDUhYsfqaHNR8G17e7qw7FVAEoh8foaAtoB+R//QLz
        TVbmrYk6aWyXfXnu424CRXxhjsklKGg=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-627-xSagrCFkO3Svo0tsWpknQg-1; Mon, 13 Feb 2023 07:49:24 -0500
X-MC-Unique: xSagrCFkO3Svo0tsWpknQg-1
Received: by mail-ed1-f71.google.com with SMTP id h10-20020a056402280a00b004acc6cf6322so1633291ede.18
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 04:49:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1FWWxthwKmHnCwh/VB+LOrY7MxDsLLnsFPiG0T4E2UM=;
        b=i1j7LIi6TheH9Ou5VgRjuPO2uIEkpndHLtY8RIhbVwLS4chp6oecVcFpUeJAvaTNfI
         N0aWybG0XvmrM3N6MwgMAc0NVvobQDG0tx57pWH87znzmD30RtvP6r/TCDYEegc1CYbB
         a6l7N2gcxh+r9trPJ7sOfBr/n4XxUir/6SNOX9VQUG4Msm9P0y11XjNexPmlB+6gnNty
         UcEE36ifBuShQT6g4FBUL6kpcAaNzBahmJNj/4oWPMRxTlY36znMEcZ3VHCQbfDoO0oB
         vo1/nMZ854NYOHAlLxWOcCThldsSPc07Il4maKgmQZ+nz85uG2CJnie4nT+40Xbe78BX
         rLwQ==
X-Gm-Message-State: AO0yUKV5OVKCjYAl0lPhZYb/jAkcA0LIarkDXPrURryQC6Wn7jxKy+nq
        FoZCnBqBU97y6iQzrPX/wejIxYjV6sO6xFFbNGqsU7xMZOsWM10yNuR5r2VW3HCyQ5i3PEKsBme
        oJOphVpcJ6EnsTK6KG6cc3faS
X-Received: by 2002:a50:f61a:0:b0:4ab:f442:9cd7 with SMTP id c26-20020a50f61a000000b004abf4429cd7mr10129033edn.25.1676292560181;
        Mon, 13 Feb 2023 04:49:20 -0800 (PST)
X-Google-Smtp-Source: AK7set90NoCkzyYpdgoXcObSFiQSCvsk/f/PCPNWoROravG1wwqaMmVa08g8g0WO9X+Z6gUESLB7tQ==
X-Received: by 2002:a50:f61a:0:b0:4ab:f442:9cd7 with SMTP id c26-20020a50f61a000000b004abf4429cd7mr10129010edn.25.1676292559972;
        Mon, 13 Feb 2023 04:49:19 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id m18-20020a509992000000b004acb9ae4757sm3529087edb.40.2023.02.13.04.49.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 04:49:19 -0800 (PST)
Message-ID: <ec5bc4a6-dc9f-90dd-0cf6-5fab47bb5fa6@redhat.com>
Date:   Mon, 13 Feb 2023 13:49:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: API for setting colors of RGB backlit keyboard zones (was [PATCH
 V3] platform/x86: hp-wmi: Support omen backlight control wmi-acpi methods)
Content-Language: en-US
To:     Rishit Bansal <rishitbansal0@gmail.com>,
        Pavel Machek <pavel@ucw.cz>
Cc:     Mark Gross <markgross@kernel.org>, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>
References: <20230131235027.36304-1-rishitbansal0@gmail.com>
 <9b761996-d522-b0f8-6472-10e40e09e036@redhat.com>
 <65a11a89-e780-6d60-a40e-cd3245780762@gmail.com>
 <b83ad6ba-7d55-f309-5d7b-4a5ff77ff5a3@redhat.com>
 <02c96cfe-ab10-513f-fc36-f474dd227656@gmail.com>
 <544484b9-c0ac-2fd0-1f41-8fa94cb94d4b@redhat.com>
 <Y+I7xNqkq/X6Lag+@duo.ucw.cz>
 <3c48e204-780c-f78c-8219-267e297dc1e3@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <3c48e204-780c-f78c-8219-267e297dc1e3@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/7/23 14:05, Rishit Bansal wrote:
> Hi,
> 
> On 07/02/23 17:23, Pavel Machek wrote:
>> Hi!
>>
>>>>> 2. Create 4 separate multi-color LED sysfs devices for each zone:
>>>>>
>>>>> /sys/class/leds/hp_omen::kbd_backlight-zone1/
>>>>> /sys/class/leds/hp_omen::kbd_backlight-zone2/
>>>>> /sys/class/leds/hp_omen::kbd_backlight-zone3/
>>>>> /sys/class/leds/hp_omen::kbd_backlight-zone4/
>>
>> 4 separate devices, please. And the naming should be consistent with
>> the rest, so
>>
>> :rbg:kbd_backlight-zone1
> 
> As covered above previously, we cannot have kbd_backlight in the name as Upower and several other userspace software which depend on it assume that /sys/class/leds has just a single file name with the string "kbd_backlight" in it:
> 
>> For example, Ubuntu (and most gnome based distros) by default ships with gnome-settings-daemon, which by default attempts to dim the keyboard backlight after a short duration when on the "Low Power" ACPI platform profile. (https://gitlab.gnome.org/GNOME/gnome-settings-daemon/-/blob/master/plugins/power/gsd-power-manager.c#L1671). This was currently working as intended with the v2 patch, but if we introduce 4 different files for each zone, this may start dimming only one keyboard zone on low power instead of all 4 of them, which is certainly not intended. There are also multiple projects (mostly gnome extensions) that interact with UPower which might also function incorrectly in other ways. I don't think we should release a feature in the driver which caused unintended consequences like the ones mentioned, especially if the software is popular. What is your opinion on this?
> 
> 
> However, as Hans mentioned above, its possible to keep 4 seperate files and use a name other than kbd_backlight, so that we don't break existing stuff until the issue is fixed on upower:
> 
>> /sys/class/leds/hp_omen::kbd_zoned_backlight-1/
>> /sys/class/leds/hp_omen::kbd_zoned_backlight-2/
>> /sys/class/leds/hp_omen::kbd_zoned_backlight-3/
>> /sys/class/leds/hp_omen::kbd_zoned_backlight-4/
> 
> 
> 
>>
>> would be closer to something consistent. Should be documented in
>>
>> Documentation/leds/well-known-leds.txt
>>
>> . And if you take a look there, you'll notice we already have N900
>> that has 6 zones with white backlight.
>>
> 
> This is interesting as well, it appears the N900 also doesn't have "kbd_backlight" in the name at all. It instead uses a format like the following:
> 
> /sys/class/leds/lp5523:kb1/
> /sys/class/leds/lp5523:kb2/
> ...
> 
> 
> I'm not sure if this is because the N900 driver was made long before we had the concept of "kbd_backlight" in the name, or because of some other reason. There are about 9-10 drivers on the kernel which are sticking with using the "kbd_backlight" convention, so N900 seems to be an outlier here.
> 
> 
>> But I'd really like to see plan to go forward. AFAICT there are
>> keyboards with per-key backlight, and those start to look less like a
>> set of LEDs and more like a display..
> 
> 
>>
>> Best regards,
>>                                 Pavel
> 
> 
> Something else I would like to add. I had a look at include/dt-bindings/leds/common.h, and it defines the following:
> 
> /* Standard LED colors */
> #define LED_COLOR_ID_WHITE    0
> #define LED_COLOR_ID_RED    1
> #define LED_COLOR_ID_GREEN    2
> #define LED_COLOR_ID_BLUE    3
> #define LED_COLOR_ID_AMBER    4
> #define LED_COLOR_ID_VIOLET    5
> #define LED_COLOR_ID_YELLOW    6
> #define LED_COLOR_ID_IR        7
> #define LED_COLOR_ID_MULTI    8    /* For multicolor LEDs */
> #define LED_COLOR_ID_RGB    9    /* For multicolor LEDs that can do arbitrary color,
>                        so this would include RGBW and similar */
> #define LED_COLOR_ID_PURPLE    10
> #define LED_COLOR_ID_ORANGE    11
> #define LED_COLOR_ID_PINK    12
> #define LED_COLOR_ID_CYAN    13
> #define LED_COLOR_ID_LIME    14
> #define LED_COLOR_ID_MAX    15
> 
> This means that the proposal I had made for supporting intensities such as zone_1_red zone_1_green zone_1_blue zone_2_red zone_2_green zone_2_blue ... would be invalid as well, and inconsistent with these definitions. The limit of "15" would also prohibit us from supporting keyboards in the future which support lighting for every single key, as we would need way more than 15 indexes to accommodate all of these.
> 
> So we are at sort of a conflicted state where none of the standards seem to correctly "completely" accomodate every single case/scenario of keyboard backlighting and zones.
> 
> 
> Here is yet another approach to handle this, which I feel we should consider:
> 
> We can keep the kbd_backlight file, and additionally have the 4 zones as separate files, (a total of 5 files) like the following:
> 
> 
> 1. /sys/class/leds/hp_omen::kbd_backlight
> 
> This file controls the global backlight brightness for all 4 zones. It will have no control for RGB control at this level, this is just sort of a global switch for the entire backlight. Setting the brightness on this level will update the brightness for every zone. This file will also help us maintain support with Upower.
> 
> 2.
> /sys/class/leds/hp_omen::kbd_zoned_backlight-1/
> /sys/class/leds/hp_omen::kbd_zoned_backlight-2/
> /sys/class/leds/hp_omen::kbd_zoned_backlight-3/
> /sys/class/leds/hp_omen::kbd_zoned_backlight-4/
> 
> These will be multi intensity RGBs, each supporting "red green blue" intensities, and can be used to individually control the brightness of each zone. Note that these files don't have "kbd_backlight" in the name for us to not mess with Upower's logic of only having a single keyboard backlight. This can be documented in Documentation/leds/well-known-leds.txt for future drivers which plan to support something similar.

I am not really a fan of this. When the "global" LED then is turned off (brightness=0) then all the other LED devices all of a sudden do nothing and writing values > 0 to their brightness won't turn them on which is not how the LED class API is supposed to work. We can come up with various tricks to work around this, but the fact remains that if we go this route we end up with weird hard to define interaction between 2 LED devices while from an userspace API pov they really should be independent.

note that both Pavel and I suggested using 4 multi-color LED class devices (1 per zone) for this and I still/really believe that this is the best way to deal with this.

I do agree with you that we need to avoid kbd_backlight in the name to avoid causing existing upower code to have weird interactions with this (it supports / assumes there is only 1 kbd_backlight LED class device).

So lets go with just these 4:

/sys/class/leds/hp_omen::kbd_zoned_backlight-1/
/sys/class/leds/hp_omen::kbd_zoned_backlight-2/
/sys/class/leds/hp_omen::kbd_zoned_backlight-3/
/sys/class/leds/hp_omen::kbd_zoned_backlight-4/

Using the _zoned_ between kbd and baclight to avoid confusing the existing upower code. Then once this has landed we can look into extending upower support for this.

Note the requested documentation patch should probably also explain that the _zoned_ was done deliberately to make current upower code ignore the devices.

Regards,

hans


