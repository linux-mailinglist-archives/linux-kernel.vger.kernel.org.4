Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60031702B69
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 13:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241248AbjEOLZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 07:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238998AbjEOLZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 07:25:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1080E114
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 04:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684149863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LA6RNmi8/9A5ZO1b+Ye7BHmrUGzK5ynFwgRATXWe15g=;
        b=iQYoVAwY24YZ41ubdHWlyL0qcoqydz5T9DRUpMS2ECF5KRe3pIBSimQNIHrNRthkVa+yxh
        Y1vreiRezWRRXSzTmAJ1goG4qlFEbR3sWDxEymdXJBHdr4SXCc//xQj/ATogRXEe9CNoeC
        R3t5M2AEitaopFV0QzA420VQb0JrJoA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-Ez5pKXtmP22EO59T9xpbFA-1; Mon, 15 May 2023 07:24:21 -0400
X-MC-Unique: Ez5pKXtmP22EO59T9xpbFA-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5105d6d5756so1055469a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 04:24:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684149861; x=1686741861;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LA6RNmi8/9A5ZO1b+Ye7BHmrUGzK5ynFwgRATXWe15g=;
        b=d9PvAECSdOjrWO+p97wDmFxx2R22lt96zh7bZVUYNw1ZF3vg2ENiew1FGGYu3eZ0lV
         dyiVuDnCgPUSoWF/RFdwGlQbWvXIMastwouK1BhfiIpXIh0ZeceW6bfZaXNZeWb1RwIZ
         Y2KgRInpL6nW99xIG53HpED19Wf5ivjCJ+2FCamAr7+iXKQLzxMZGWHqPYV2aQhkii5O
         wDkxgkNEAynxjPPmT6ykAXLG/kB1wbDeSJT02R7UCcOOctUWN8HSuc1MjO13gLj5F41v
         Im+HneNXOvjWf/U48NpyZsO44EYFLRqsH2TSsbn3xFdOrLMHnSXNKNuwEPVXE0g5Xm0L
         9qDQ==
X-Gm-Message-State: AC+VfDwC71RVkRFgseTKf6s6FZxoLQrmqrm700Yh1o2irAeEr/cgvqEY
        6ILVHbLNJ0vppPH1tT3DSBRPX+49vrPD7dDTxWooYMQltgoMsYH6P/SGd9gA5FMtW2TWZf44mgi
        ExG3guHJtTkOrUz8KmYlvdhOh
X-Received: by 2002:aa7:ce0a:0:b0:50c:1677:91c2 with SMTP id d10-20020aa7ce0a000000b0050c167791c2mr24500062edv.30.1684149860820;
        Mon, 15 May 2023 04:24:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5G1wxuE4djtvdvkwsGUUamxqP5ZVHK+DMxopOMGrWRjH3j3V3PCzDfZftv6baS8UWf8IANHw==
X-Received: by 2002:aa7:ce0a:0:b0:50c:1677:91c2 with SMTP id d10-20020aa7ce0a000000b0050c167791c2mr24500051edv.30.1684149860452;
        Mon, 15 May 2023 04:24:20 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id n8-20020a056402514800b0050d8aac0a1esm7136795edd.19.2023.05.15.04.24.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 04:24:19 -0700 (PDT)
Message-ID: <0549face-4b03-03e4-6da3-28f59fff94d1@redhat.com>
Date:   Mon, 15 May 2023 13:24:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 3/3] leds: simatic-ipc-leds-gpio: introduce more
 Kconfig switches
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
References: <20230301170215.23382-1-henning.schild@siemens.com>
 <20230301170215.23382-4-henning.schild@siemens.com>
 <a6281345-95e1-3e8d-b6fb-146c1852373f@redhat.com>
 <20230302094728.563c04ce@md1za8fc.ad001.siemens.net>
 <bfa3ede3-8cc0-ca6c-8e88-17e374aedcb6@redhat.com>
 <20230515124150.7ffd6c81@md1za8fc.ad001.siemens.net>
Content-Language: en-US
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230515124150.7ffd6c81@md1za8fc.ad001.siemens.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 5/15/23 12:41, Henning Schild wrote:
> Am Thu, 2 Mar 2023 10:02:51 +0100
> schrieb Hans de Goede <hdegoede@redhat.com>:
> 
>> Hi,
>>
>> On 3/2/23 09:47, Henning Schild wrote:
>>> Am Wed, 1 Mar 2023 19:04:01 +0100
>>> schrieb Hans de Goede <hdegoede@redhat.com>:
>>>   
>>>> Hi,
>>>>
>>>> On 3/1/23 18:02, Henning Schild wrote:  
>>>>> To describe the dependency chain better and allow for potential
>>>>> fine-grained config tuning, introduce Kconfig switch for the
>>>>> individual GPIO based drivers.
>>>>>
>>>>> Signed-off-by: Henning Schild <henning.schild@siemens.com>
>>>>> ---
>>>>>  drivers/leds/simple/Kconfig  | 31 ++++++++++++++++++++++++++++---
>>>>>  drivers/leds/simple/Makefile |  7 +++----
>>>>>  2 files changed, 31 insertions(+), 7 deletions(-)
>>>>>
>>>>> diff --git a/drivers/leds/simple/Kconfig
>>>>> b/drivers/leds/simple/Kconfig index fd2b8225d926..44fa0f93cb3b
>>>>> 100644 --- a/drivers/leds/simple/Kconfig
>>>>> +++ b/drivers/leds/simple/Kconfig
>>>>> @@ -1,11 +1,36 @@
>>>>>  # SPDX-License-Identifier: GPL-2.0-only
>>>>>  config LEDS_SIEMENS_SIMATIC_IPC
>>>>>  	tristate "LED driver for Siemens Simatic IPCs"
>>>>> -	depends on LEDS_GPIO    
>>>>
>>>> Since it is simatic-ipc-leds-gpio-core.c which actually registers
>>>> the LEDs GPIO platform device, this one should stay IMHO.  
>>>
>>> No this one is now only for the port-IO based driver. The GPIO core
>>> is built under the two new switches only.  
>>
>> You are right, I thought this would enable building
>> simatic-ipc-leds-gpio-core.o into its own .ko which would
>> then be used by both other gpio LED drivers. But upon a closer
>> look at the Makefile changes I see that is not the case.
>>
>> Note that with your current solution you are linking that into
>> the kernel twice.
>>
>> As long this is build into modules that is fine. But if both are
>> builtin I *think* you may get linker errors because of duplicate
>> symbols?
>>
>> I believe this is why Andy asked to try a build with all 3 options
>> set to Y.
>>
>>>>>  	depends on SIEMENS_SIMATIC_IPC
>>>>>  	help
>>>>>  	  This option enables support for the LEDs of several
>>>>> Industrial PCs from Siemens.
>>>>>  
>>>>> -	  To compile this driver as a module, choose M here: the
>>>>> modules
>>>>> -	  will be called simatic-ipc-leds and
>>>>> simatic-ipc-leds-gpio.
>>>>> +	  To compile this driver as a module, choose M here: the
>>>>> module
>>>>> +	  will be called simatic-ipc-leds.
>>>>> +
>>>>> +config LEDS_SIEMENS_SIMATIC_IPC_APOLLOLAKE
>>>>> +	tristate "LED driver for Siemens Simatic IPCs based on
>>>>> Intel Apollo Lake GPIO"
>>>>> +	depends on LEDS_GPIO    
>>>>
>>>> And then it can be dropped here.
>>>>  
>>>>> +	depends on PINCTRL_BROXTON    
>>>>  
>>>>> +	depends on SIEMENS_SIMATIC_IPC    
>>>>
>>>> This should be "depends on LEDS_SIEMENS_SIMATIC_IPC" since it
>>>> actually uses symbol from that module.  
>>>
>>> Same as above, the GPIO based drivers do not depend on the port-IO
>>> based driver.  
> 
> Hi Hans,
> 
>> Ack.
> 
> was that for that last patch or all three of them? I am preparing a v3
> which will include ACKs, i will have to assume p3 only because it came
> in reply to that patch.

You may add my:

Acked-by: Hans de Goede <hdegoede@redhat.com>

To all 3 patches in the series.

Regards,

Hans






>>>>> +	default LEDS_SIEMENS_SIMATIC_IPC
>>>>> +	help
>>>>> +	  This option enables support for the LEDs of several
>>>>> Industrial PCs
>>>>> +	  from Siemens based on Apollo Lake GPIO i.e. IPC127E.
>>>>> +
>>>>> +	  To compile this driver as a module, choose M here: the
>>>>> module
>>>>> +	  will be called simatic-ipc-leds-gpio-apollolake.
>>>>> +
>>>>> +config LEDS_SIEMENS_SIMATIC_IPC_F7188X
>>>>> +	tristate "LED driver for Siemens Simatic IPCs based on
>>>>> Nuvoton GPIO"
>>>>> +	depends on LEDS_GPIO    
>>>>
>>>> Idem.
>>>>  
>>>>> +	depends on GPIO_F7188X
>>>>> +	depends on SIEMENS_SIMATIC_IPC    
>>>>
>>>> Idem.
>>>>  
>>>>> +	default LEDS_SIEMENS_SIMATIC_IPC
>>>>> +	help
>>>>> +	  This option enables support for the LEDs of several
>>>>> Industrial PCs
>>>>> +	  from Siemens based on Nuvoton GPIO i.e. IPC227G.
>>>>> +
>>>>> +	  To compile this driver as a module, choose M here: the
>>>>> module
>>>>> +	  will be called simatic-ipc-leds-gpio-f7188x.
>>>>> diff --git a/drivers/leds/simple/Makefile
>>>>> b/drivers/leds/simple/Makefile index ed9057f7b6da..e3e840cea275
>>>>> 100644 --- a/drivers/leds/simple/Makefile
>>>>> +++ b/drivers/leds/simple/Makefile
>>>>> @@ -1,5 +1,4 @@
>>>>>  # SPDX-License-Identifier: GPL-2.0
>>>>> -obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC)	+=
>>>>> simatic-ipc-leds.o -obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC)  +=
>>>>> simatic-ipc-leds-gpio-core.o
>>>>> -obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC)	+=
>>>>> simatic-ipc-leds-gpio-apollolake.o
>>>>> -obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC)	+=
>>>>> simatic-ipc-leds-gpio-f7188x.o
>>>>> +obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC)			+=
>>>>> simatic-ipc-leds.o
>>>>> +obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC_APOLLOLAKE)	+=
>>>>> simatic-ipc-leds-gpio-core.o simatic-ipc-leds-gpio-apollolake.o
>>>>> +obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC_F7188X)		+=
>>>>> simatic-ipc-leds-gpio-core.o simatic-ipc-leds-gpio-f7188x.o    
>>>>
>>>> Regards,
>>>>
>>>> Hans
>>>>  
>>>   
>>
> 

