Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6008374EAFE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 11:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbjGKJnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 05:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjGKJn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 05:43:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1BC010E3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 02:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689068549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5tXuHSt42vOhi/RR7LZmETd8IFscnoA25c33wyaRGfc=;
        b=KMYGokUHQ6ipCuztM1GJq3RVBuuq72/bmvjZRVZoPUmp4129QxNAOtKrNda7Zg7oTlvShq
        5WzPcFdF5fmSKXJ2VSHKz67EZQ3dO7h4alrAlwLFA7wuADhj9zoOF/x7NbEW2SLFfUAoji
        ZH9kRYMJZyJdPQWMC+jicmTipPposaI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-3waUSnGDPF2jW0Z26Bswwg-1; Tue, 11 Jul 2023 05:42:27 -0400
X-MC-Unique: 3waUSnGDPF2jW0Z26Bswwg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9932e8e76b9so368012466b.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 02:42:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689068546; x=1691660546;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5tXuHSt42vOhi/RR7LZmETd8IFscnoA25c33wyaRGfc=;
        b=LnFxDzbHUaINj/dIXJpe2X8ZPq5Bq+6tXgW3XmmS/vOL2/M9JakZDp/mQnfgcsyNec
         /jtet+A2sLZBZY161KA2wpKHp6F7zkLZIxZ2DHmwNX5bkYk/KCauHMq0LzWzg5nTMnx3
         rUOaBau5t0PnJnZHqo2qVPcCUxF0+krwvkQU+sp96QugHhG4DUS8sm2Udy7RI+ZPZKM9
         fPg0LAcrxqB+MYw9tIFnnc+rgTQ0Zxngk6qdwjecpeYhXmll1YS4C8J0xCey1IsnC/1R
         RI7EtNAfZ2w8EdsvI50nzFHnj1EAP+b2l20gFmEdoRrYV1j6g/k/+Yuw9OwaWkJPzCr3
         wb8A==
X-Gm-Message-State: ABy/qLZjUQuVqYHn/mxDujDY5l10JdZCsO3oL7NR91J9GD7ryEkn4mBh
        daljypLTSiLGT/8NQB79/ooFSXB0HUazvmSlnFTnqZc1SiDs9PIDZM1hoKl8vxrU5WC0NHDjuew
        jT2k0eRVcC6UQ14A1N3lTCXOF
X-Received: by 2002:a17:906:1392:b0:97e:aace:b6bc with SMTP id f18-20020a170906139200b0097eaaceb6bcmr14187408ejc.53.1689068546625;
        Tue, 11 Jul 2023 02:42:26 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG5oNHW/3l71/L8d2Jx6e6y4wCLbtZsMzUF9WeJiuUI31nQYW8MwxDMb6YtJIa3Ct+4x4Mjvw==
X-Received: by 2002:a17:906:1392:b0:97e:aace:b6bc with SMTP id f18-20020a170906139200b0097eaaceb6bcmr14187392ejc.53.1689068546321;
        Tue, 11 Jul 2023 02:42:26 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id rk21-20020a170907215500b00993150e5325sm928676ejb.60.2023.07.11.02.42.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 02:42:25 -0700 (PDT)
Message-ID: <350cfb54-f435-4482-5a40-18d4358bf747@redhat.com>
Date:   Tue, 11 Jul 2023 11:42:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 1/1] platform/x86: asus-wmi: add support for ASUS
 screenpad
Content-Language: en-US, nl
To:     Luke Jones <luke@ljones.dev>
Cc:     corentin.chary@gmail.com, acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, markgross@kernel.org,
        jdelvare@suse.com, linux@roeck-us.net
References: <20230630041743.911303-1-luke@ljones.dev>
 <20230630041743.911303-2-luke@ljones.dev>
 <974093b4-5dac-dc29-8f86-304eb5c6c19b@redhat.com>
 <39e6044b960c1099ecc34d76f78aad12496b23e2.camel@ljones.dev>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <39e6044b960c1099ecc34d76f78aad12496b23e2.camel@ljones.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/7/23 00:23, Luke Jones wrote:
> On Tue, 2023-07-04 at 13:16 +0200, Hans de Goede wrote:
>> Hi Luke,
>>
>> On 6/30/23 06:17, Luke D. Jones wrote:
>>> Add support for the WMI methods used to turn off and adjust the
>>> brightness of the secondary "screenpad" device found on some high-
>>> end
>>> ASUS laptops like the GX650P series and others.
>>>
>>> These methods are utilised in a new backlight device named
>>> asus_screenpad.
>>>
>>> Signed-off-by: Luke D. Jones <luke@ljones.dev>
>>
>> Thank you for your work on this. I have one small change request
>> and then v5 should be ready for merging, see me inline comment
>> below.
>>
>>> ---
>>>  drivers/platform/x86/asus-wmi.c            | 128
>>> +++++++++++++++++++++
>>>  drivers/platform/x86/asus-wmi.h            |   1 +
>>>  include/linux/platform_data/x86/asus-wmi.h |   4 +
>>>  3 files changed, 133 insertions(+)
>>>
>>> diff --git a/drivers/platform/x86/asus-wmi.c
>>> b/drivers/platform/x86/asus-wmi.c
>>> index 62cee13f5576..967c92ceb041 100644
>>> --- a/drivers/platform/x86/asus-wmi.c
>>> +++ b/drivers/platform/x86/asus-wmi.c
>>> @@ -25,6 +25,7 @@
>>>  #include <linux/input/sparse-keymap.h>
>>>  #include <linux/kernel.h>
>>>  #include <linux/leds.h>
>>> +#include <linux/minmax.h>
>>>  #include <linux/module.h>
>>>  #include <linux/pci.h>
>>>  #include <linux/pci_hotplug.h>
>>> @@ -212,6 +213,7 @@ struct asus_wmi {
>>>  
>>>         struct input_dev *inputdev;
>>>         struct backlight_device *backlight_device;
>>> +       struct backlight_device *screenpad_backlight_device;
>>>         struct platform_device *platform_device;
>>>  
>>>         struct led_classdev wlan_led;
>>> @@ -3839,6 +3841,123 @@ static int is_display_toggle(int code)
>>>         return 0;
>>>  }
>>>  
>>> +/* Screenpad backlight
>>> *******************************************************/
>>> +
>>> +static int read_screenpad_backlight_power(struct asus_wmi *asus)
>>> +{
>>> +       int ret;
>>> +
>>> +       ret = asus_wmi_get_devstate_simple(asus,
>>> ASUS_WMI_DEVID_SCREENPAD_POWER);
>>> +       if (ret < 0)
>>> +               return ret;
>>> +       /* 1 == powered */
>>> +       return ret ? FB_BLANK_UNBLANK : FB_BLANK_POWERDOWN;
>>> +}
>>> +
>>> +static int read_screenpad_brightness(struct backlight_device *bd)
>>> +{
>>> +       struct asus_wmi *asus = bl_get_data(bd);
>>> +       u32 retval;
>>> +       int err;
>>> +
>>> +       err = read_screenpad_backlight_power(asus);
>>> +       if (err < 0)
>>> +               return err;
>>> +       /* The device brightness can only be read if powered, so
>>> return stored */
>>> +       if (err == FB_BLANK_POWERDOWN)
>>> +               return asus->driver->screenpad_brightness;
>>> +
>>> +       err = asus_wmi_get_devstate(asus,
>>> ASUS_WMI_DEVID_SCREENPAD_LIGHT, &retval);
>>> +       if (err < 0)
>>> +               return err;
>>> +
>>> +       return retval & ASUS_WMI_DSTS_BRIGHTNESS_MASK;
>>> +}
>>> +
>>> +static int update_screenpad_bl_status(struct backlight_device *bd)
>>> +{
>>> +       struct asus_wmi *asus = bl_get_data(bd);
>>> +       int power, err = 0;
>>> +       u32 ctrl_param;
>>> +
>>> +       power = read_screenpad_backlight_power(asus);
>>> +       if (power < 0)
>>> +               return power;
>>> +
>>> +       if (bd->props.power != power) {
>>> +               if (power != FB_BLANK_UNBLANK) {
>>> +                       /* Only brightness > 0 can power it back on
>>> */
>>> +                       ctrl_param = max(1, asus->driver-
>>>> screenpad_brightness);
>>> +                       err =
>>> asus_wmi_set_devstate(ASUS_WMI_DEVID_SCREENPAD_LIGHT,
>>> +                                                   ctrl_param,
>>> NULL);
>>> +               } else {
>>> +                       err =
>>> asus_wmi_set_devstate(ASUS_WMI_DEVID_SCREENPAD_POWER, 0, NULL);
>>> +               }
>>> +       } else if (power == FB_BLANK_UNBLANK) {
>>> +               /* Only set brightness if powered on or we get
>>> invalid/unsync state */
>>> +               ctrl_param = bd->props.brightness;
>>> +               err =
>>> asus_wmi_set_devstate(ASUS_WMI_DEVID_SCREENPAD_LIGHT, ctrl_param,
>>> NULL);
>>> +       }
>>> +
>>> +       /* Ensure brightness is stored to turn back on with */
>>> +       asus->driver->screenpad_brightness = bd->props.brightness;
>>> +
>>> +       return err;
>>> +}
>>> +
>>> +static const struct backlight_ops asus_screenpad_bl_ops = {
>>> +       .get_brightness = read_screenpad_brightness,
>>> +       .update_status = update_screenpad_bl_status,
>>> +       .options = BL_CORE_SUSPENDRESUME,
>>> +};
>>> +
>>> +static int asus_screenpad_init(struct asus_wmi *asus)
>>> +{
>>> +       struct backlight_device *bd;
>>> +       struct backlight_properties props;
>>> +       int err, power;
>>> +       int brightness = 0;
>>> +
>>> +       power = read_screenpad_backlight_power(asus);
>>> +       if (power < 0)
>>> +               return power;
>>> +
>>> +       if (power != FB_BLANK_POWERDOWN) {
>>> +               err = asus_wmi_get_devstate(asus,
>>> ASUS_WMI_DEVID_SCREENPAD_LIGHT, &brightness);
>>> +               if (err < 0)
>>> +                       return err;
>>> +       }
>>> +       /* default to an acceptable min brightness on boot if too
>>> low */
>>> +       if (brightness < 60)
>>> +               brightness = 60;
>>
>> If settings below 60 are no good, then the correct way to handle
>> this is to limit the range to 0 - (255-60) and add / substract
>> 60 when setting / getting the brightness.
>>
>> E.g. do something like this:
>>
>> #define SCREENPAD_MIN_BRIGHTNESS        60
>> #define SCREENPAD_MAX_BRIGHTNESS        255
>>
>>         props.max_brightness = SCREENPAD_MAX_BRIGHTNESS -
>> SCREENPAD_MIN_BRIGHTNESS;
>>
>> And in update_screenpad_bl_status() do:
>>
>>         ctrl_param = bd->props.brightness + SCREENPAD_MIN_BRIGHTNESS;
>>
>> And when reading the brightness substract SCREENPAD_MIN_BRIGHTNESS,
>> clamping to a minimum value of 0.
>>
>> This avoids a dead-zone in the brightness range between 0-60 .
> 
> Hi Hans, I think this is the wrong thing to do.
> 
> The initial point of that first `brightness = 60;` is only to set it to
> an acceptable brightness on boot. We don't want to prevent the user
> from going below that brightness at all - this is just to ensure the
> screen is visible on boot if the brightness was under that value, and
> it is usually only under that value if it was set to off before
> shutdown/reboot.
> 
> It's not to try and put the range between 60-255, it's just to make the
> screen visible on boot if it was off previously. The folks who have
> tested this have found that this is the desired behaviour they expect.

I see.

So if I understand things correctly then 60 is a good default,
but the screen can go darker and still be usable.

But 1 leads to an unusable screen, so we still need
a SCREENPAD_MIN_BRIGHTNESS to avoid the screen being able
to go so dark that it is no longer usable and then still
move the range a bit, but just not by 60, but by some
other number (something in the 10-30 range I guess?)

Combined with adding a:

#define SCREENPAD_DEFAULT_BRIGHTNESS        60

And at boot when the read back brightness <
SCREENPAD_MIN_BRIGHTNESS set it to SCREENPAD_DEFAULT_BRIGHTNESS.

We really want to avoid users to be able to set an unusable
low brightness level. As mentioned in the new panel brightness
API proposal:

https://lore.kernel.org/dri-devel/b61d3eeb-6213-afac-2e70-7b9791c86d2e@redhat.com/

"3. The meaning of 0 is not clearly defined, it can be either off,
   or minimum brightness at which the display is still readable
  (in a low light environment)"

and the plan going forward is to:

"Unlike the /sys/class/backlight/foo/brightness this brightness property
has a clear definition for the value 0. The kernel must ensure that 0
means minimum brightness (so 0 should _never_ turn the backlight off).
If necessary the kernel must enforce a minimum value by adding
an offset to the value seen in the property to ensure this behavior."

So I really want to see this new backlight driver implement the
new planned behavior for 0 from the start, with 0 meaning minimum
*usable* brightness.

Regards,

Hans



