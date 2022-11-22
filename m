Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE5E76335F0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 08:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbiKVHiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 02:38:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiKVHiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 02:38:03 -0500
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEA62EF7A;
        Mon, 21 Nov 2022 23:38:02 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id vv4so24510033ejc.2;
        Mon, 21 Nov 2022 23:38:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FZbyfU/5XPRkx8d6jWoqG6QOs2Sad6DVEQvXwiCOOh0=;
        b=R+tVETho4FKIVcWXANAt109MigQcn4SCHMisAVjuP/LBIL55wQF1K0VfjX0omq1X0e
         eCALUXve1zyb4vRupRiFcItEG+SCzja5saSaNRmMLVe4ZEs8AHAc+z9JEWRNhYBDH6PX
         vXtgJRsfjhYTfp/A8AHiwyq3L/V1iDoDLs4R3H9ebn2OMVf85+5qbvUbLR/hovR56xY8
         AKiOZvqJpCSvDtHUr45Ej/8TKtj2X7UKrDR4/h1AlNKS5t4BfCL4Tx3oYVlYibYLKdIT
         j9bsHUZHzb2vcnYwIBNniYZTjqOQl00hZ1lkHeYjrudkvS49oah3hStP7XqdgIVzU1LK
         XifQ==
X-Gm-Message-State: ANoB5pmpffqh8cB7687DPdHReUh2jNmCbOACcYFDQdsahzVrdUMsHWPf
        /ZxbW1vJBd7VljniGo+Q3Tm3oKDJvuJU+w==
X-Google-Smtp-Source: AA0mqf4NNRrZxVv/0q8JUh4PpI2elm99gd/na+ce9HFqGdofxdSe5clW87ZYq5NoXJG4ArwkqlS7Dw==
X-Received: by 2002:a17:906:5a8b:b0:7a5:f8a5:6f80 with SMTP id l11-20020a1709065a8b00b007a5f8a56f80mr19481420ejq.202.1669102681013;
        Mon, 21 Nov 2022 23:38:01 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:49? ([2a0b:e7c0:0:107::aaaa:49])
        by smtp.gmail.com with ESMTPSA id r9-20020a1709061ba900b007b6ed81deecsm1575600ejg.96.2022.11.21.23.37.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 23:38:00 -0800 (PST)
Message-ID: <2f242291-99b6-a50f-cd52-e7dfd8c88c8f@kernel.org>
Date:   Tue, 22 Nov 2022 08:37:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Content-Language: en-US
To:     "Gabriel L. Somlo" <gsomlo@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        gregkh@linuxfoundation.org, kgugala@antmicro.com,
        mholenko@antmicro.com, joel@jms.id.au,
        david.abdurachmanov@gmail.com, florent@enjoy-digital.fr,
        geert@linux-m68k.org, ilpo.jarvinen@linux.intel.com
References: <20221118145512.509950-1-gsomlo@gmail.com>
 <20221118145512.509950-10-gsomlo@gmail.com>
 <44bf21b6-cbe4-4d73-0883-a9bcbd7d5971@kernel.org>
 <1b5a963c-2a5b-54fe-784e-fcc4d06c347e@kernel.org>
 <Y3uDZV8b+3GfQyUY@errol.ini.cmu.edu>
From:   Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v5 09/14] serial: liteuart: fix rx loop variable types
In-Reply-To: <Y3uDZV8b+3GfQyUY@errol.ini.cmu.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21. 11. 22, 14:55, Gabriel L. Somlo wrote:
> Hi Jiri,
> 
> Thanks for the feedback!
> 
> On Mon, Nov 21, 2022 at 09:45:05AM +0100, Jiri Slaby wrote:
>> On 21. 11. 22, 9:37, Jiri Slaby wrote:
>>> On 18. 11. 22, 15:55, Gabriel Somlo wrote:
>>>> Update variable types to match the signature of uart_insert_char()
>>>> which consumes them.
>>>>
>>>> Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
>>>> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>>>> ---
>>>>    drivers/tty/serial/liteuart.c | 3 +--
>>>>    1 file changed, 1 insertion(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/tty/serial/liteuart.c
>>>> b/drivers/tty/serial/liteuart.c
>>>> index 81aa7c1da73c..42ac9aee050a 100644
>>>> --- a/drivers/tty/serial/liteuart.c
>>>> +++ b/drivers/tty/serial/liteuart.c
>>>> @@ -73,8 +73,7 @@ static void liteuart_timer(struct timer_list *t)
>>>>        struct liteuart_port *uart = from_timer(uart, t, timer);
>>>>        struct uart_port *port = &uart->port;
>>>>        unsigned char __iomem *membase = port->membase;
>>>> -    int ch;
>>>> -    unsigned long status;
>>>> +    unsigned int status, ch;
>>>
>>> These should be u8 after all, right?
> 
> OK, so:
> 
>    - I can hard-code `status` as `1`, like so:
> 
> 	while(!litex_read8(membase + OFF_RXEMPTY) {
> 		...
> 		if (!(uart_handle_sysrq_char(port, ch)))
> 			uart_insert_char(port, 1, 0, ch, TTY_NORMAL);
> 
>      ... since `status` would always be `1` inside the loop. So I'm
>      basically going to get rid of it altogether.

Yes, I had that in my mind. Except passing 1 to uart_insert_char() when 
overflow is hardwired to 0 makes no sense IMO :).

>    - `ch` is indeed *produced* by `litex_read8()`, which would make it
>      `u8`. It is subsequently *consumed* by `uart_handle_sysrq_char()`
>      and `uart_insert_char()`, which both expect `unsigned int`.

Ignore uart_handle_sysrq_char and uart_insert_char. They should be fixed 
one day. It should really be u8. All down the call chain (it magically 
turns into int in the sysrq handlers, then char is expected).

>      If you think it's better to go with the type when the value is
>      produced (as opposed to when it's consumed), I'm OK with that for
>      the upcoming v6 of the series... :)

Yes, please. We should slowly convert _all_ of them.

>> And can you change membase to u8 * too 8-)?
> 
> Hmmm, in `struct uart_port` (in include/linux/serial_core.h), the
> `membase` field is declared as:
> 
> 	unsigned char __iomem   *membase;
> 
> which is why I'm thinking we should leave it as-is? Unless there are
> plans (or a pending patch I'm unaware of) to switch the field in
> include/linux/serial_core.h to `u8` as well? -- Please advise.

Ah, then keep it. I somehow thought it's void *. And yes, even this 
should be u8 __iomem *, eventually.

thanks,
-- 
js
suse labs

