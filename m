Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38296A6BE0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 12:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjCALmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 06:42:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjCALmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 06:42:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B57E23C4D
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 03:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677670879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TPCyEVg0U0tc1yF8bE87NQHA3jtsj86l3zakJn+3lhI=;
        b=JgJFgS0J2azqHgaVk+i8TOi1vLSFY7Bi9TNSWCKTJpR5K19J5JH+p5Vl4ovDN14TNL+Duu
        f/FnmKdLGD0VyD9VtYox1KFhPZS5twEbMTluMhMfu76PVN+ezAmF9ZgMXdZa8RjzDXhiiv
        kVj8mYuPpCXCTF1dTNjMf5MeCmLZp1U=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-625-JUlsujcXP7ya-2_LEGJL9A-1; Wed, 01 Mar 2023 06:41:18 -0500
X-MC-Unique: JUlsujcXP7ya-2_LEGJL9A-1
Received: by mail-ed1-f72.google.com with SMTP id cf11-20020a0564020b8b00b0049ec3a108beso18649208edb.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 03:41:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TPCyEVg0U0tc1yF8bE87NQHA3jtsj86l3zakJn+3lhI=;
        b=U6lo0XFR+E+ManDrbj7LLDKXovWSnoSP1qm2I+mred/MMWABUQtFzwvARsZpMX1diN
         7a99JWDC6p9/1vWmKFrFbT80BOKvppuFPQd8O1C5XWtjpNspuREFHFKTEqqriUlxwLfC
         tqi3YWrlkT2/QAQMf1X3SV/TT8OUQmxbcCjxkk7FXPhzlVsIPTj9j64DjmaXC39ui9Wz
         2w0HDnup6koMM5vmLtGYgHQw0VL1zzpl3tQS9D18Bx3qRHADqTAm/mfjU/M9Xr0hj3wm
         hZMTVtiH0tMBZC1FQse7dqlDOgBGBM1lxabdbCvZRP3uW6NB5abL86vayAasbLPRWTrp
         Mt6w==
X-Gm-Message-State: AO0yUKVY1xLHqewaojPQzWsVaiRqiaRTuUmX4uHQ7Xt7DZKf1/npGos6
        q4hAwtX/hKrOA8Bhr3xuPfYS6oHZl9K9yslB+Pvf9w28z8ombNlRqej70SdmB0SEju9cei0GhlN
        EJzxCTequsKWG0p050+TTSaSI1VBcDg==
X-Received: by 2002:aa7:d286:0:b0:4af:7dff:7b8d with SMTP id w6-20020aa7d286000000b004af7dff7b8dmr7072534edq.17.1677670876920;
        Wed, 01 Mar 2023 03:41:16 -0800 (PST)
X-Google-Smtp-Source: AK7set8xWbwYUim7ZGfuAnjthmlbIj2z5JotEc3BmMlCMnOQ+dZ+8AFTRUbRmfA+GimRtPVTd+lwZg==
X-Received: by 2002:aa7:d286:0:b0:4af:7dff:7b8d with SMTP id w6-20020aa7d286000000b004af7dff7b8dmr7072515edq.17.1677670876630;
        Wed, 01 Mar 2023 03:41:16 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id w18-20020a50d792000000b004af720b855fsm5461304edi.82.2023.03.01.03.41.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 03:41:16 -0800 (PST)
Message-ID: <13c5e60d-d9ba-f840-f43e-40db957a6617@redhat.com>
Date:   Wed, 1 Mar 2023 12:41:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [regression] Bug 216946 - Toshiba satellite click mini l9w-b:
 touchscreen: no touch events with kernel 6.1.4
Content-Language: en-US, nl
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?G=c3=a9_Koerkamp?= <ge.koerkamp@gmail.com>
References: <32a14a8a-9795-4c8c-7e00-da9012f548f8@leemhuis.info>
 <abb495f7-f973-4614-846b-d3922dc0fe25@leemhuis.info>
 <CAO-hwJJ2OMFgpmrXK_Z43z0ddujaS1fNjaAJSWwao4qQN+pJ6w@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAO-hwJJ2OMFgpmrXK_Z43z0ddujaS1fNjaAJSWwao4qQN+pJ6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/28/23 14:26, Benjamin Tissoires wrote:
> On Tue, Feb 28, 2023 at 12:32 PM Thorsten Leemhuis
> <regressions@leemhuis.info> wrote:
>>
>> On 19.01.23 16:06, Linux kernel regression tracking (Thorsten Leemhuis)
>> wrote:
>>> Hi, this is your Linux kernel regression tracker.
>>>
>>> I noticed a regression report in bugzilla.kernel.org. As many (most?)
>>> kernel developer don't keep an eye on it, I decided to forward it by
>>> mail. Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=216946 :
>>
>> The reporter recently confirmed in the ticket that the issue still
>> happens with 6.2.
>>
>> There wasn't any reply from any of the input developers here or in
>> bugzilla afaics. :-/ Hmmm. Could someone from that camp maybe please
>> take a minute and at least briefly look into this as answer something
>> like "that might be due to a problem in subsystem 'foo'", "maybe ask bar
>> for an option", or "we have no idea what might cause this, this needs to
>> be bisected"? That would help a lot.
> 
> The working dmesg shows a line with:
> hid-generic 0018:0457:10FB.0002: input,hidraw1: I2C HID v1.00 Device
> [SIS0817:00 0457:10FB] on i2c-SIS0817:00
> and then
> hid-multitouch 0018:0457:10FB.0002: input,hidraw1: I2C HID v1.00
> Device [SIS0817:00 0457:10FB] on i2c-SIS0817:00
> 
> But these 2 lines do not appear on the 6.1.4 logs.
> 
> So the device is not properly enumerated by ACPI or I2C. Hans might
> have an idea on how to debug/solve that issue.

I actually have a Toshiba satellite click mini l9w-b lying around
myself. I already made a note to try and reproduce this

But I'm very much swamped with too much kernel work, so no promises
when I will get around to this ...

Regards,

Hans




>> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
>> --
>> Everything you wanna know about Linux kernel regression tracking:
>> https://linux-regtracking.leemhuis.info/about/#tldr
>> If I did something stupid, please tell me, as explained on that page.
>>
>> #regzbot poke
>>>>  Gé Koerkamp 2023-01-17 20:21:51 UTC
>>>>
>>>> Created attachment 303619 [details]
>>>> Kernel configuration for v6.1.4/ journalctl (dmesg)/ ACPIdump/lsmod
>>>>
>>>> Overview:
>>>> The touchscreen does not react on touch events.
>>>> Touchscreen display and touchpad are working.
>>>>
>>>> Step to reproduce:
>>>> Open any UI page
>>>> Try to use touch on relevant UI controls (buttons etc.)
>>>>
>>>> Result:
>>>> No reaction on screen touches
>>>>
>>>> Expected result:
>>>> Reaction on touched control, same as when using the touch pad or connected mouse (which do work).
>>>>
>>>> Build information:
>>>> The error happens with kernel version 6.1.4
>>>> After rebuilding with different kernel versions, it appears that it first fails with kernel 5.16
>>>>
>>>> Additional builds:
>>>> The click mini l9w-b still works with kernel 5.10.y LTS and 5.15.y LTS.
>>>>
>>>> Important remark:
>>>> Touchscreen still works fine with kernel 6.1.4 using
>>>> - an HP x2 detachable 10-p0xx or
>>>> - a Lenovo yoga 520-14ikb
>>>>
>>>> So it could be a hardware dependent issue
>>>
>>> See the ticket for more details.
>>>
>>>
>>> [TLDR for the rest of this mail: I'm adding this report to the list of
>>> tracked Linux kernel regressions; the text you find below is based on a
>>> few templates paragraphs you might have encountered already in similar
>>> form.]
>>>
>>> BTW, let me use this mail to also add the report to the list of tracked
>>> regressions to ensure it's doesn't fall through the cracks:
>>>
>>> #regzbot introduced: v5.15..v5.16
>>> https://bugzilla.kernel.org/show_bug.cgi?id=216946
>>> #regzbot title: hid: touchscreen broken with Toshiba satellite click
>>> mini l9w-b
>>> #regzbot ignore-activity
>>>
>>> This isn't a regression? This issue or a fix for it are already
>>> discussed somewhere else? It was fixed already? You want to clarify when
>>> the regression started to happen? Or point out I got the title or
>>> something else totally wrong? Then just reply and tell me -- ideally
>>> while also telling regzbot about it, as explained by the page listed in
>>> the footer of this mail.
>>>
>>> Developers: When fixing the issue, remember to add 'Link:' tags pointing
>>> to the report (e.g. the buzgzilla ticket and maybe this mail as well, if
>>> this thread sees some discussion). See page linked in footer for details.
>>>
>>> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
>>> --
>>> Everything you wanna know about Linux kernel regression tracking:
>>> https://linux-regtracking.leemhuis.info/about/#tldr
>>> If I did something stupid, please tell me, as explained on that page.
>>
> 

