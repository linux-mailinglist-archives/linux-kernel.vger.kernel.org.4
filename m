Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47ED86A322B
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 16:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjBZPZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 10:25:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjBZPZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 10:25:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFFB1FF1E
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 07:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677424587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zWuCETYlGm5nXIPBM19Dg25vOC37BZrnNuNH9S7qgEM=;
        b=ioCsOvSjaP43VP7dXev/O00ALB9NeBNzChAWBTc/EELR3GEc3nkiCyn/hO/ipWOmaMShWZ
        I8OKr4//PP9iOIDbQveQ/EbVDfzWKImRjDx3clWBcEuIo7R30nPGq7WWsQJpBUXX7nSTuw
        j2P78NnzhIQsDRDAasriZEuBIKRNjPw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-507-D62xYjmuNxKKZpp49_TjIA-1; Sun, 26 Feb 2023 10:02:11 -0500
X-MC-Unique: D62xYjmuNxKKZpp49_TjIA-1
Received: by mail-qv1-f69.google.com with SMTP id u18-20020a0cec92000000b0056ea549d728so2099017qvo.10
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 07:02:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zWuCETYlGm5nXIPBM19Dg25vOC37BZrnNuNH9S7qgEM=;
        b=SNE8zDpBoASa13TCP3KbLrz7UiFn61A3pEnBtnzA/xFxv50a8hsK+CxgiUe1c0AaZR
         j8dAWX7RSWKvbam80AN1oKdlRvSYiIV9queqLi932q0B9Pk6ltEEyKxCf1owxvFZMn2h
         pPQGyQ+s2NBviQ0u2V1tmcp2cUOdO/bXlYzzdILIHAovAP5Wv3uC58WtB9SKZsCqM5yc
         flyYI/GDOlsndCMD4ZoYciWHnx1UPnjHLBMdN6GAhBBJTvcPnUjMp/cb1oWqIN0vQEb9
         FzfLAqHX8kUcAI6nBz16+BNUxHZJj96z8kbuNOt8mUKA44cOfKYsh4D32rDniE2+kx16
         LlCA==
X-Gm-Message-State: AO0yUKUqg5ud5H8JHgYhj5oj0Fkd1ycul0XiSgy6TeNrt0lklEckiMgO
        85WN2IVA/sJAHPIG+OX1giwLEZwAYYGOuec4XmGeiq8FxUrTOhw4YVwgzkwKI3J4FhadttPEUSC
        PUFPV5lR46AzJesX2Xr3hCc6gYCxpm9kAEsa4byz9+oDKg7nE2mu7BSMHtLFWSJEbSAQBfUutlA
        yc
X-Received: by 2002:ac8:584f:0:b0:3ba:ef:fc0e with SMTP id h15-20020ac8584f000000b003ba00effc0emr38862251qth.57.1677423730406;
        Sun, 26 Feb 2023 07:02:10 -0800 (PST)
X-Google-Smtp-Source: AK7set/SXesiOhOnAgh3EpQdbpIYg1w5jnpyIXaoHzasz8z/7gzWSqqsQylwzoVbm8kRJ4sdLh/n4w==
X-Received: by 2002:ac8:584f:0:b0:3ba:ef:fc0e with SMTP id h15-20020ac8584f000000b003ba00effc0emr38862208qth.57.1677423729999;
        Sun, 26 Feb 2023 07:02:09 -0800 (PST)
Received: from [192.168.1.19] (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id p3-20020ac84083000000b003b9a573aec6sm2982825qtl.70.2023.02.26.07.02.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Feb 2023 07:02:09 -0800 (PST)
Subject: Re: [PATCH] tty: serial: fsl_lpuart: select SERIAL_FSL_LPUART for
 SERIAL_FSL_LPUART_CONSOLE
To:     Randy Dunlap <rdunlap@infradead.org>, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230225173949.651311-1-trix@redhat.com>
 <0f8a8857-5e18-e49a-0361-197b4bc892ab@infradead.org>
 <026ee207-3b90-c7ae-a7fd-66a34cd3ee90@redhat.com>
 <6dd89251-f4d6-8051-8ecf-cdea7d23bc68@infradead.org>
 <c3ca14dc-14d0-959c-0f55-8f584457db33@infradead.org>
 <9a16ee6f-5a49-167e-fc33-9ca147b3686a@infradead.org>
From:   Tom Rix <trix@redhat.com>
Message-ID: <e767cb93-eb46-a82c-186c-68d12cefce31@redhat.com>
Date:   Sun, 26 Feb 2023 07:02:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <9a16ee6f-5a49-167e-fc33-9ca147b3686a@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/25/23 10:38 AM, Randy Dunlap wrote:
>
> On 2/25/23 10:16, Randy Dunlap wrote:
>>
>> On 2/25/23 10:03, Randy Dunlap wrote:
>>>
>>> On 2/25/23 09:51, Tom Rix wrote:
>>>> On 2/25/23 9:46 AM, Randy Dunlap wrote:
>>>>> Hi--
>>>>>
>>>>> On 2/25/23 09:39, Tom Rix wrote:
>>>>>> A rand config causes this link error
>>>>>> ld: drivers/tty/serial/earlycon.o: in function `parse_options':
>>>>>> drivers/tty/serial/earlycon.c:99: undefined reference to `uart_parse_earlycon'
>>>>>>
>>>>>> The rand config has
>>>>>> CONFIG_SERIAL_CORE=m
>>>>>> CONFIG_SERIAL_EARLYCON=y
>>>>>> CONFIG_SERIAL_FSL_LPUART=m
>>>>>> CONFIG_SERIAL_FSL_LPUART_CONSOLE=y
>>>>>>
>>>>>> SERIAL_FSL_LPUART should have been selected instead of depends on-ed.
>>>>>>
>>>>>> Signed-off-by: Tom Rix <trix@redhat.com>
>>>>>> ---
>>>>>>    drivers/tty/serial/Kconfig | 2 +-
>>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
>>>>>> index 625358f44419..b24d74d389fc 100644
>>>>>> --- a/drivers/tty/serial/Kconfig
>>>>>> +++ b/drivers/tty/serial/Kconfig
>>>>>> @@ -1313,7 +1313,7 @@ config SERIAL_FSL_LPUART
>>>>>>      config SERIAL_FSL_LPUART_CONSOLE
>>>>>>        bool "Console on Freescale lpuart serial port"
>>>>>> -    depends on SERIAL_FSL_LPUART
>>>>>> +    select SERIAL_FSL_LPUART
>>>>> Most other _CONSOLE Kconfig have:
>>>>>
>>>>>      depends on SERIAL_FSL_LPUART=y
>>>> commit 5779a072c248db7a40cfd0f5ea958097fd1d9a30 removed the =y. so it could be built as a module.
>>>>
>>> uh. But it's still a bool, not a tristate. How does that work?
>> OK, I see. :)
>>
>> Well, I don't see another decent solution ATM.
>>
>> Tom, does your patch fix the build error?
>>
>> What are the listed CONFIG settings after the patch?
> OK, after I apply the patch, all of the listed config symbols are
> changed to =y (builtin), so not built as a loadable module.
>
> Do you see something different?

No, all y's.

Since the showing the after state is useful, I added it to v2

>
>
>>>>> e.g.
>>>>>
>>>>> but I noticed a few others with a similar problem.
>>>>>
>>>>>>        select SERIAL_CORE_CONSOLE
>>>>>>        select SERIAL_EARLYCON
>>>>>>        help

