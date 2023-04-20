Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 625F06E96F2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 16:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbjDTOWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 10:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231998AbjDTOWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 10:22:32 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBC63A92;
        Thu, 20 Apr 2023 07:22:21 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4ec817735a7so570931e87.3;
        Thu, 20 Apr 2023 07:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682000539; x=1684592539;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X0Xu7MA+NjArIa7BJ4lZIO3ZzLFDar+90AWHOHge/mw=;
        b=qJPA1ftO1tKXvkL3q1Uf/Ib91CY7vR+c+KIVRnc2UijFKmWUlG3HNSmsTc8VsQjlCV
         7lS20yf5HJOY/Mi5Td0Y+ecA8s0XgiCj35dpBWlqWY+z6Mtq6FxqcyHWxoeeho6o970G
         WnfP9BTlkD/nyRvhUVkJYKx6f2OL+cc+05ThKN//f7OXf18/0mfK0VLwl8Gp9QkLTqZ4
         ke2vW3jSGxL0jtGwZteI7kTZxgF0h2kAYBKv5he0OKTJwgl/ZK6IeHAs2nCTMHEcK1Y+
         rxSW1jx5bsZL0YpXRKOxYAl6NW/NtK1UJvCcEJl2udeDXYFUiE5z1JcGGsKl2dRAIKk8
         kVng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682000539; x=1684592539;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X0Xu7MA+NjArIa7BJ4lZIO3ZzLFDar+90AWHOHge/mw=;
        b=KdXkoy2L5iPR7gyi9PqiDZ9+894A86mgfxszr5xfziKDmDsvQhdPe9HxM5r5gaEjde
         IPqWM382cIaBle/hBIsVf1DZapkYAKVDEuu0HnWqH1gmFC3byiVAZIJlt204xjCgYePY
         Qgtz8FEZJ7brrwCGien3Qjl1+Ku+gdHLziIKta9W/AJmGlPj94FKgCAfF+RwsnH/V+Yg
         H55zLmxzxSlTbXEyM33oWNBrTG83YUeAQZvA4KH5fQa1X/hPH0vnCGWDpqYpzRVPh68B
         v8CVC7EYy2FEAMzRgx3KepRBra0Ufc3qMsAu0Ti4/tQT2p8IGSrwM4zBAUcHHHghplsZ
         uQIw==
X-Gm-Message-State: AAQBX9cpfAX9w0Pnp04BSgFd+neAUA2hJFOV2sJeip9Em9TZpMv2lsJK
        pxgtDHmFXwxHDvmjfaKn4yM=
X-Google-Smtp-Source: AKy350bWZTaKEQQ5q303VQeZj6+SmnubAmp5wjQRO/uQRl9mlNzf4VCqRyj9VfpzrgdBkPCuw77FTg==
X-Received: by 2002:ac2:46cb:0:b0:4eb:4002:a5ca with SMTP id p11-20020ac246cb000000b004eb4002a5camr427993lfo.66.1682000539534;
        Thu, 20 Apr 2023 07:22:19 -0700 (PDT)
Received: from [192.168.1.103] ([31.173.82.218])
        by smtp.gmail.com with ESMTPSA id u10-20020ac251ca000000b004eb19a51896sm237634lfm.83.2023.04.20.07.22.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 07:22:19 -0700 (PDT)
Subject: Re: [PATCH 2/3] xhci: Add zhaoxin xHCI U1/U2 feature support
To:     "WeitaoWang-oc@zhaoxin.com" <WeitaoWang-oc@zhaoxin.com>,
        gregkh@linuxfoundation.org, mathias.nyman@intel.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     tonywwang@zhaoxin.com, weitaowang@zhaoxin.com
References: <20230420172130.375819-1-WeitaoWang-oc@zhaoxin.com>
 <20230420172130.375819-3-WeitaoWang-oc@zhaoxin.com>
 <c853436a-85c7-d0f8-0990-bc64977cbd47@gmail.com>
 <f0f0d62d-edde-547d-5d6e-a02e2f8e8648@zhaoxin.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <54aa1618-63b7-965a-d303-5d35cb554c20@gmail.com>
Date:   Thu, 20 Apr 2023 17:22:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <f0f0d62d-edde-547d-5d6e-a02e2f8e8648@zhaoxin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/20/23 11:21 PM, WeitaoWang-oc@zhaoxin.com wrote:

>>> Add U1/U2 feature support of xHCI for zhaoxin.
>>>
>>> Signed-off-by: Weitao Wang <WeitaoWang-oc@zhaoxin.com>
>> [...]
>>
>>> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
>>> index 6307bae9cddf..730c0f68518d 100644
>>> --- a/drivers/usb/host/xhci.c
>>> +++ b/drivers/usb/host/xhci.c
>> [...]
>>> @@ -4938,6 +4938,27 @@ static int xhci_update_timeout_for_interface(struct xhci_hcd *xhci,
>>>       return 0;
>>>   }
>>>   +static int xhci_check_zhaoxin_tier_policy(struct usb_device *udev,
>>> +        enum usb3_link_state state)
>>> +{
>>> +    struct usb_device *parent;
>>> +    unsigned int num_hubs;
>>> +
>>> +    /* Don't enable U1/U2 if the device is on an external hub. */
>>> +    for (parent = udev->parent, num_hubs = 0; parent->parent;
>>> +            parent = parent->parent)
>>> +        num_hubs++;
>>> +
>>> +    if (num_hubs < 1)
>>> +        return 0;
>>> +
>>> +    dev_dbg(&udev->dev, "Disabling U1/U2 link state for device"
>>> +            " below external hub.\n");
>>> +    dev_dbg(&udev->dev, "Plug device into root hub "
>>> +            "to decrease power consumption.\n");
>>
>>     Please don't break up the message strings.
> 
> Thanks for your advice, and I will merge this message in next patch version.
>> [...]
>>> @@ -4965,6 +4986,8 @@ static int xhci_check_tier_policy(struct xhci_hcd *xhci,
>>>   {
>>>       if (xhci->quirks & XHCI_INTEL_HOST)
>>>           return xhci_check_intel_tier_policy(udev, state);
>>> +    else if (xhci->quirks & XHCI_ZHAOXIN_HOST)
>>
>>     *else* not needed after *return*.
> This function need a "int" type return value. If remove "else" branch,
> vendor other than intel and zhaoxin will not get a return value.

   I didn't tell you to remove the whole branch, just the *else* keyword.

[...]
> Best Regards,
> Weitao

MBR, Sergey
