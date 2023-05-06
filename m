Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D27F6F8D88
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 03:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjEFBas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 21:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbjEFBap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 21:30:45 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1497F76B3;
        Fri,  5 May 2023 18:30:40 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-643995a47f7so2261500b3a.1;
        Fri, 05 May 2023 18:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683336639; x=1685928639;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=yoMULFCZo0s527f3yIU9Yxdj4m+1KSAK5S0eEMK4qbE=;
        b=SmCaoUTPlJ2sfqNOQzbEy25OMXh3MHOpjtGgFGKZMoF/hY1cx8yFMsci9owGqZgxRP
         DhsY3SNwXpVfVVCsW/2dKJsGfXTZXMK9+HXbzmjoYuG2brOWKPbYp2Tx+CsaSoX1kp9+
         LNU1WSKYmG9SvPvR22XXCh6mGifPGDZOhvMDr0Xlqo5D0ygH7+4pte3wWG4nuoBewzUH
         FGuYkPHmAHHejeul8VBaUsoTCrYXHMh4S2/1urb7NG0z0OQcctv6rxYCU5fM3arCCcT4
         41kVHmNaO1o0qXJsODuVRQkZbdx4CwHVe9ir8RH9T5M8eBTh5YwN7iIbn8CSJ5roAkWP
         omvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683336639; x=1685928639;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yoMULFCZo0s527f3yIU9Yxdj4m+1KSAK5S0eEMK4qbE=;
        b=gX3F0goT41VrR2A8B/7zjCLl9serEx6bVWd7+Dk2a4Y2QVurSHkw/4OntSoD0HW5jK
         Ct4ig7NflizPECvUr6Dd1LvtSq31Nm8ekYzqFDpMtQ3eJsslgIZXr+2BjTQhl4A9GzoE
         2tasHN4h/88nfUTXF3+S+OuW+ro+f+A/xsmusoZ+8O3jmrZA8FtlR6US6S7CSoBiHape
         qDAQjrozH8JE4f8BnyDo3pUbOx+mqinejVAvEndwXxqgW/KzC4Hn59Ae5W/Sc2ghyYAM
         QT4YLRYVDmj1t1nwt3xk0VaJDDsOlJd0PdhqS1F8gY2qZEYgLosMEq3n442/CLjUaO9Q
         x4hg==
X-Gm-Message-State: AC+VfDxSeW5/u7FTzNSxA6yoghLQqk4ypwmw7uVhuvIF3R4pYKCZbe77
        oGk9msYwBJZ/wpOkRAp95z4=
X-Google-Smtp-Source: ACHHUZ5ssm4VsFUzuiHtW2gYfjKPRpoQgsqGwNy2RYoN+WIBcsTgAb9au9yD2FLMAFI0vQMfwK93HQ==
X-Received: by 2002:a05:6a20:244d:b0:f3:5cf7:581b with SMTP id t13-20020a056a20244d00b000f35cf7581bmr4374769pzc.28.1683336639251;
        Fri, 05 May 2023 18:30:39 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a15-20020aa780cf000000b0063799398eb9sm2154722pfn.58.2023.05.05.18.30.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 18:30:38 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <f1f8ff7a-6f23-e284-b494-7df2f0dce1a4@roeck-us.net>
Date:   Fri, 5 May 2023 18:30:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/1] platform/x86: asus-wmi: add support for ASUS
 screenpad
Content-Language: en-US
To:     Luke Jones <luke@ljones.dev>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net, hdegoede@redhat.com,
        corentin.chary@gmail.com, markgross@kernel.org, jdelvare@suse.com
References: <20230505043013.2622603-1-luke@ljones.dev>
 <20230505043013.2622603-2-luke@ljones.dev>
 <9f77e8fd-38fe-818f-2fee-ca3bf4243576@linux.intel.com>
 <TWL7UR.KE812U8BYMG8@ljones.dev>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <TWL7UR.KE812U8BYMG8@ljones.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/5/23 16:43, Luke Jones wrote:
> 
> 
> On Fri, May 5 2023 at 16:08:16 +0300, Ilpo Järvinen <ilpo.jarvinen@linux.intel.com> wrote:
>> On Fri, 5 May 2023, Luke D. Jones wrote:
>>
>>>  Add support for the WMI methods used to turn off and adjust the
>>>  brightness of the secondary "screenpad" device found on some high-end
>>>  ASUS laptops like the GX650P series and others.
>>>
>>>  These methods are utilised in a new backlight device named:
>>>  - asus_screenpad
>>>
>>>  Signed-off-by: Luke D. Jones <luke@ljones.dev>
>>>  ---
>>>   .../ABI/testing/sysfs-platform-asus-wmi       |   2 +-
>>>   drivers/platform/x86/asus-wmi.c               | 132 ++++++++++++++++++
>>>   drivers/platform/x86/asus-wmi.h               |   1 +
>>>   include/linux/platform_data/x86/asus-wmi.h    |   4 +
>>>   4 files changed, 138 insertions(+), 1 deletion(-)
>>>
>>>  diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b/Documentation/ABI/testing/sysfs-platform-asus-wmi
>>>  index a77a004a1baa..df9817c6233a 100644
>>>  --- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
>>>  +++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
>>>  @@ -97,4 +97,4 @@ Contact:    "Luke Jones" <luke@ljones.dev>
>>>   Description:
>>>           Enable an LCD response-time boost to reduce or remove ghosting:
>>>               * 0 - Disable,
>>>  -            * 1 - Enable
>>>  +            * 1 - Enable
>>>  \ No newline at end of file
>>
>> Spurious change?
> 
> Indeed it is. Not sure how that occurred.
> 
>>
>>>  diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
>>>  index 1038dfdcdd32..0528eef02ef7 100644
>>>  --- a/drivers/platform/x86/asus-wmi.c
>>>  +++ b/drivers/platform/x86/asus-wmi.c
>>>  @@ -200,6 +200,7 @@ struct asus_wmi {
>>>
>>>       struct input_dev *inputdev;
>>>       struct backlight_device *backlight_device;
>>>  +    struct backlight_device *screenpad_backlight_device;
>>>       struct platform_device *platform_device;
>>>
>>>       struct led_classdev wlan_led;
>>>  @@ -3208,6 +3209,129 @@ static int is_display_toggle(int code)
>>>       return 0;
>>>   }
>>>
>>>  +/* Screenpad backlight */
>>>  +
>>>  +static int read_screenpad_backlight_power(struct asus_wmi *asus)
>>>  +{
>>>  +    int ret = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_SCREENPAD_POWER);
>>
>> Please move this to own line because now you have the extra newline
>> in between the call and error handling.
> 
> I don't understand what you mean sorry. Remove the new line or:
> int ret;
> ret = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_SCREENPAD_POWER);
> 
>>
>>>  +
>>>  +    if (ret < 0)
>>>  +        return ret;
>>>  +    /* 1 == powered */
>>>  +    return ret ? FB_BLANK_UNBLANK : FB_BLANK_POWERDOWN;
>>>  +}
>>>  +
>>>  +static int read_screenpad_brightness(struct backlight_device *bd)
>>>  +{
>>>  +    struct asus_wmi *asus = bl_get_data(bd);
>>>  +    u32 retval;
>>>  +    int err;
>>>  +
>>>  +    err = read_screenpad_backlight_power(asus);
>>>  +    if (err < 0)
>>>  +        return err;
>>>  +    /* The device brightness can only be read if powered, so return stored */
>>>  +    if (err == FB_BLANK_POWERDOWN)
>>>  +        return asus->driver->screenpad_brightness;
>>>  +
>>>  +    err = asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_SCREENPAD_LIGHT, &retval);
>>>  +    if (err < 0)
>>>  +        return err;
>>>  +
>>>  +    return retval & ASUS_WMI_DSTS_BRIGHTNESS_MASK;
>>>  +}
>>>  +
>>>  +static int update_screenpad_bl_status(struct backlight_device *bd)
>>>  +{
>>>  +    struct asus_wmi *asus = bl_get_data(bd);
>>>  +    int power, err = 0;
>>>  +    u32 ctrl_param;
>>>  +
>>>  +    power = read_screenpad_backlight_power(asus);
>>>  +    if (power == -ENODEV)
>>>  +        return err;
>>
>> Just return 0. Or is there perhaps something wrong/missing here?
> 
> I thought the correct thing was to return any possible error state (here, anything less than 0 would be an error, right?)
> 

Well, yes, but you are not returning an error. You are returning 'err'
which is 0 at this point. So, at the very least, this code is (very)
misleading since it suggests that it would return some error
(as saved in the 'err' variable) when it doesn't.

Guenter


