Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A256A6ED7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 15:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjCAOyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 09:54:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjCAOx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 09:53:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5552166EE
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 06:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677682388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o3ML0kGUbp6ISR0bjBKWSTGdZ+Mpg9gbDYm1RlI+eDc=;
        b=WZkYQ0dq4Wro1yLsVVcnhYjWjj9BuxdAOf6Yj+olLqxhoUEUJPTpooztkb2IhJOHYiOsSZ
        KElyjSD2v+gotHswE9Kc+UOB4VyACJ8DmL27ZYyhPKn+3Y8lhULm81atezcsu03rjPy23a
        1YOgOESpK6rrPHE+b1VVI0ljvS4R1OA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-RDFZ4am4Mnu3Hhoatk8vVQ-1; Wed, 01 Mar 2023 09:53:06 -0500
X-MC-Unique: RDFZ4am4Mnu3Hhoatk8vVQ-1
Received: by mail-ed1-f71.google.com with SMTP id cy28-20020a0564021c9c00b004acc6cf6322so19315887edb.18
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 06:53:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o3ML0kGUbp6ISR0bjBKWSTGdZ+Mpg9gbDYm1RlI+eDc=;
        b=lLPcLubaUi18rxYWEkYyEVJO+StSQOzIoTW4u8fmih08+IPuJFVPp5QP7QJv8DT4Ci
         QD2SXIgPnCZ5nUzL4VgFKJ2alqfCPGZAbv0mVH024cryB0UmPGjh4EREw4WsK0xwMFQB
         mwlT/OyN9neSZHubdlm++0Qq59tFA/6PWYSmHHptXoHgYJcaRZwRlMfe4cO/IAc4JDm1
         Yzk7HkD+1jNWdo5MEp2uyJMpSHi/vVS6bexGfNlHUoPxinQUpuKaR7Ri0M9wGEkBHh4W
         GeRdBH7ciwFE5hFQc1EWf+x8Wic2WmQwdolUJn1blnWmwL8ozdgPkuWHAF0FCwjCf2dn
         Qgrw==
X-Gm-Message-State: AO0yUKV/qpmMkZ7r7XYIX4sDAM2R4l2hEry4dvUhPESSmNJPUXqNAhJ/
        bACob0GkNFuJspvyeqO4D1dKcSflJnvw7EzD+xIOtZAOkrYYdaajBLiKlJ0zbjh9JLfQ9acR0PO
        rd/GhA5JJYRtb8v4u3e09cypE
X-Received: by 2002:aa7:da4f:0:b0:4af:62af:460a with SMTP id w15-20020aa7da4f000000b004af62af460amr8106206eds.8.1677682385579;
        Wed, 01 Mar 2023 06:53:05 -0800 (PST)
X-Google-Smtp-Source: AK7set8F2UAXhTnt/8cqyDd31UL3TbM2YZwTxX+l+7izfN4P0Z6CwqoUAUcHNjYpo7V45Y0+PiOsRA==
X-Received: by 2002:aa7:da4f:0:b0:4af:62af:460a with SMTP id w15-20020aa7da4f000000b004af62af460amr8106183eds.8.1677682385278;
        Wed, 01 Mar 2023 06:53:05 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id m25-20020a509999000000b004bc2d1c0fadsm856636edb.32.2023.03.01.06.53.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 06:53:04 -0800 (PST)
Message-ID: <bf678bc5-9615-31a3-3039-5d013f9c9f25@redhat.com>
Date:   Wed, 1 Mar 2023 15:53:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/3] leds: simatic-ipc-leds-gpio: split up into multiple
 drivers
Content-Language: en-US, nl
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Henning Schild <henning.schild@siemens.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Mark Gross <markgross@kernel.org>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
References: <20230221122414.24874-1-henning.schild@siemens.com>
 <20230221122414.24874-3-henning.schild@siemens.com>
 <Y/TMR0GBUr69KiQ5@smile.fi.intel.com>
 <20230221154354.290ae938@md1za8fc.ad001.siemens.net>
 <Y/TaftuNMABevCWV@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <Y/TaftuNMABevCWV@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 2/21/23 15:51, Andy Shevchenko wrote:
> On Tue, Feb 21, 2023 at 03:43:54PM +0100, Henning Schild wrote:
>> Am Tue, 21 Feb 2023 15:51:03 +0200
>> schrieb Andy Shevchenko <andriy.shevchenko@linux.intel.com>:
>>> On Tue, Feb 21, 2023 at 01:24:13PM +0100, Henning Schild wrote:
>>>> In order to clearly describe the dependencies between the gpio  
> 
> ...
> 
>>>> +#ifndef __DRIVERS_LEDS_SIMPLE_SIMATIC_IPC_LEDS_GPIO
>>>> +#define __DRIVERS_LEDS_SIMPLE_SIMATIC_IPC_LEDS_GPIO  
>>>
>>>> +#endif /* __DRIVERS_LEDS_SIMPLE_SIMATIC_IPC_LEDS_GPIO */  
>>>
>>> This header doesn't look right.
>>>
>>> Have you run `make W=1 ...` against your patches?
>>
>> No reports.
>>
>>> Even if it doesn't show defined but unused errors
>>> the idea is that this should be a C-file, called,
>>> let's say, ...-core.c.
>>
>> When i started i kind of had a -common.c in mind as well. But then the
>> header idea came and i gave it a try, expecting questions in the review.
>>
>> It might be a bit unconventional but it seems to do the trick pretty
>> well. Do you see a concrete problem or a violation of a rule?
> 
> Exactly as described above. The header approach means that *all* static
> definitions must be used by each user of that file. Otherwise you will
> get "defined but not used" compiler warning.
> 
> And approach itself is considered (at least by me) as a hackish way to
> achieve what usually should be done via C-file.
> 
> So, if maintainers are okay, I wouldn't have objections, but again
> I do not think it's a correct approach.

I agree with Andy here, please add a -common.o file with a shared
probe() helper which gets the 2 different gpiod_lookup_table-s
as parameter and then put the actual probe() function calling
the helper inside the 2 different .c files.

And all the:

+static struct platform_driver simatic_ipc_led_gpio_driver = {
+	.probe = simatic_ipc_leds_gpio_probe,
+	.remove = simatic_ipc_leds_gpio_remove,
+	.driver = {
+		.name = KBUILD_MODNAME,
+	},
+};
+
+module_platform_driver(simatic_ipc_led_gpio_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:" KBUILD_MODNAME);

bits should then also go into the 2 different .c file files.

Really putting something like module_platform_driver() or
MODULE_LICENSE() / MODULE_ALIAS() inside a .h file is
just wrong IMHO.

Regards,

Hans

