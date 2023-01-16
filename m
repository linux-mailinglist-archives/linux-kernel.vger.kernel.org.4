Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0094966BF87
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 14:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbjAPNR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 08:17:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbjAPNRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 08:17:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609831F4B1;
        Mon, 16 Jan 2023 05:16:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EBF7460FA9;
        Mon, 16 Jan 2023 13:16:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06093C433F0;
        Mon, 16 Jan 2023 13:15:59 +0000 (UTC)
Message-ID: <571d5a60-dfcc-d8f9-8c42-0da70b0913f2@linux-m68k.org>
Date:   Mon, 16 Jan 2023 23:15:57 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1 1/1] gpio: Remove unused and obsoleted irq_to_gpio()
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net,
        linux-m68k@lists.linux-m68k.org, linux-sh@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
References: <20230112133942.58471-1-andriy.shevchenko@linux.intel.com>
 <CAMuHMdXSc-H5TKBGisthv3DH3sZmF3fV_15FuMEt=typwTWUtA@mail.gmail.com>
From:   Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <CAMuHMdXSc-H5TKBGisthv3DH3sZmF3fV_15FuMEt=typwTWUtA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 13/1/23 01:14, Geert Uytterhoeven wrote:
> CC greg
> 
> On Thu, Jan 12, 2023 at 2:39 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
>> irq_to_gpio() is legacy and unused API, remove it for good.
>>
>> This leaves gpio_to_irq() as it's used yet in many places.
>> Nevertheless, removal of its counterpart is a good signal
>> to whoever even trying to consider using them that do not.
>>
>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> ---
>>   Documentation/driver-api/gpio/legacy.rst             |  8 --------
>>   .../translations/zh_CN/driver-api/gpio/legacy.rst    |  7 -------
>>   Documentation/translations/zh_TW/gpio.txt            |  7 -------
>>   arch/m68k/include/asm/gpio.h                         |  7 -------
>>   arch/sh/include/asm/gpio.h                           |  5 -----
>>   include/linux/gpio.h                                 | 12 ------------
>>   6 files changed, 46 deletions(-)
> 
> [...]
> 
>> --- a/arch/m68k/include/asm/gpio.h
>> +++ b/arch/m68k/include/asm/gpio.h
>> @@ -66,13 +66,6 @@ static inline int gpio_to_irq(unsigned gpio)
>>                  return __gpio_to_irq(gpio);
>>   }
>>
>> -static inline int irq_to_gpio(unsigned irq)
>> -{
>> -       return (irq >= MCFGPIO_IRQ_VECBASE &&
>> -               irq < (MCFGPIO_IRQ_VECBASE + MCFGPIO_IRQ_MAX)) ?
>> -               irq - MCFGPIO_IRQ_VECBASE : -ENXIO;
>> -}
>> -
>>   static inline int gpio_cansleep(unsigned gpio)
>>   {
>>          return gpio < MCFGPIO_PIN_MAX ? 0 : __gpio_cansleep(gpio);
> 
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Acked-by: Greg Ungerer <gerg@linux-m68k.org>



> Gr{oetje,eeting}s,
> 
>                          Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                  -- Linus Torvalds
