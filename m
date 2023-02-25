Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE566A2B56
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 19:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjBYSjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 13:39:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjBYSjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 13:39:01 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11B81164D;
        Sat, 25 Feb 2023 10:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=qGtUm5ybyuFsA+IcFkr+qjHVXjXSLgVqu3UunV7ocXg=; b=Ol+rVQtD1xrF68NAIG8ZwvTGdT
        YmF23B5MYP/gN3tO/TY48fXaDnW1lZ2S56j0nFq3IIRvsmo5KXh9vmZhk0LgRqmMHD8wyscIdjN31
        uqwrGJWPnqIINRJ0T4XoeZM0AkYa8Rd8tJOLjFEXWmaYYaBS0g+LghMT1vjCWaWluysPX0Nc3yJps
        R5IxdYAkE9QrYua+u17AiSkDFUK7+sCO+c0H+WwoiJXWw6qdbE/cvCpGJlEF6Di7bQ0mvTs0o1U2q
        GnE6IFgA4JmSj58keIAc2oTBeVLDHvg2NEVlaFK0d0MS49gYs4f6ArL2Xo1OStk5E7xrQBz3U9eL1
        I7FqmolA==;
Received: from [2601:1c2:980:9ec0::df2f]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pVzRg-0069cP-At; Sat, 25 Feb 2023 18:38:57 +0000
Message-ID: <9a16ee6f-5a49-167e-fc33-9ca147b3686a@infradead.org>
Date:   Sat, 25 Feb 2023 10:38:55 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH] tty: serial: fsl_lpuart: select SERIAL_FSL_LPUART for
 SERIAL_FSL_LPUART_CONSOLE
Content-Language: en-US
From:   Randy Dunlap <rdunlap@infradead.org>
To:     Tom Rix <trix@redhat.com>, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230225173949.651311-1-trix@redhat.com>
 <0f8a8857-5e18-e49a-0361-197b4bc892ab@infradead.org>
 <026ee207-3b90-c7ae-a7fd-66a34cd3ee90@redhat.com>
 <6dd89251-f4d6-8051-8ecf-cdea7d23bc68@infradead.org>
 <c3ca14dc-14d0-959c-0f55-8f584457db33@infradead.org>
In-Reply-To: <c3ca14dc-14d0-959c-0f55-8f584457db33@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/25/23 10:16, Randy Dunlap wrote:
> 
> 
> On 2/25/23 10:03, Randy Dunlap wrote:
>>
>>
>> On 2/25/23 09:51, Tom Rix wrote:
>>>
>>> On 2/25/23 9:46 AM, Randy Dunlap wrote:
>>>> Hi--
>>>>
>>>> On 2/25/23 09:39, Tom Rix wrote:
>>>>> A rand config causes this link error
>>>>> ld: drivers/tty/serial/earlycon.o: in function `parse_options':
>>>>> drivers/tty/serial/earlycon.c:99: undefined reference to `uart_parse_earlycon'
>>>>>
>>>>> The rand config has
>>>>> CONFIG_SERIAL_CORE=m
>>>>> CONFIG_SERIAL_EARLYCON=y
>>>>> CONFIG_SERIAL_FSL_LPUART=m
>>>>> CONFIG_SERIAL_FSL_LPUART_CONSOLE=y
>>>>>
>>>>> SERIAL_FSL_LPUART should have been selected instead of depends on-ed.
>>>>>
>>>>> Signed-off-by: Tom Rix <trix@redhat.com>
>>>>> ---
>>>>>   drivers/tty/serial/Kconfig | 2 +-
>>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
>>>>> index 625358f44419..b24d74d389fc 100644
>>>>> --- a/drivers/tty/serial/Kconfig
>>>>> +++ b/drivers/tty/serial/Kconfig
>>>>> @@ -1313,7 +1313,7 @@ config SERIAL_FSL_LPUART
>>>>>     config SERIAL_FSL_LPUART_CONSOLE
>>>>>       bool "Console on Freescale lpuart serial port"
>>>>> -    depends on SERIAL_FSL_LPUART
>>>>> +    select SERIAL_FSL_LPUART
>>>> Most other _CONSOLE Kconfig have:
>>>>
>>>>     depends on SERIAL_FSL_LPUART=y
>>>
>>> commit 5779a072c248db7a40cfd0f5ea958097fd1d9a30 removed the =y. so it could be built as a module.
>>>
>>
>> uh. But it's still a bool, not a tristate. How does that work?
> 
> OK, I see. :)
> 
> Well, I don't see another decent solution ATM.
> 
> Tom, does your patch fix the build error?
> 
> What are the listed CONFIG settings after the patch?

OK, after I apply the patch, all of the listed config symbols are
changed to =y (builtin), so not built as a loadable module.

Do you see something different?


>>>> e.g.
>>>>
>>>> but I noticed a few others with a similar problem.
>>>>
>>>>>       select SERIAL_CORE_CONSOLE
>>>>>       select SERIAL_EARLYCON
>>>>>       help
>>>
>>
> 

-- 
~Randy
