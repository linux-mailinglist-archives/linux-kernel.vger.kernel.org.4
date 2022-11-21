Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E56A6631BB8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 09:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiKUImp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 03:42:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiKUImn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 03:42:43 -0500
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A92644E;
        Mon, 21 Nov 2022 00:42:42 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id l24so2631001edj.8;
        Mon, 21 Nov 2022 00:42:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=79IcmyiF9Ta7ifYcXOVVX61hUTkh+ixj1xyhExMH+Hw=;
        b=7yrFaf7g6TNx+C0LuPxttfpCics2NYsNKQhkOm5+dLVpZwOt4c3boosiknVP7IbzuN
         qP+d7SbofT0gIo1P4vXiDc9wMaQcOUXA0h0Zp142tHm3OVgQHC4b75BvolkUyHJwQNO2
         5rZ8/IejyuEzrUmJYKkelrgJXSWdKDs2NI1aOFukTXqrXw9pA9RCXZDGeyN49ZOmkUWx
         EFoxYCQNzhy/PBUCS4wJ+xjXRu7OFo0pZyjlr89kjIj7ZgMyspN4sKg82zIPg+M1576t
         jxSOFJAIqxvJNIlf50JUMDT3HFG3PQnJ8hNmFvf0bV3n6AyjAbRt0BOcc8arftSbIPNH
         QynQ==
X-Gm-Message-State: ANoB5pkBUyjnO4LytYVgqmGo/+nMTOVwRDXdr7jRwvs6Ee3nGnrbAa15
        rqtuwL8w141GUaDjBQA07mCrCSqTQleWXw==
X-Google-Smtp-Source: AA0mqf4EKwn2NcoKuzk3M00InmLenObnz7fbVogrY3sWgEq5cOGQpHRPcZnELt6wJjmdKO19IdWWJg==
X-Received: by 2002:a05:6402:528d:b0:468:dc9:ec08 with SMTP id en13-20020a056402528d00b004680dc9ec08mr15565745edb.17.1669020160813;
        Mon, 21 Nov 2022 00:42:40 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:49? ([2a0b:e7c0:0:107::aaaa:49])
        by smtp.gmail.com with ESMTPSA id s26-20020a056402165a00b0046800749670sm4997624edx.53.2022.11.21.00.42.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 00:42:40 -0800 (PST)
Message-ID: <a1d0f706-f12e-dbf2-be18-99f22d91eccc@kernel.org>
Date:   Mon, 21 Nov 2022 09:42:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v5 09/14] serial: liteuart: fix rx loop variable types
Content-Language: en-US
From:   Jiri Slaby <jirislaby@kernel.org>
To:     Gabriel Somlo <gsomlo@gmail.com>, linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        kgugala@antmicro.com, mholenko@antmicro.com, joel@jms.id.au,
        david.abdurachmanov@gmail.com, florent@enjoy-digital.fr,
        geert@linux-m68k.org, ilpo.jarvinen@linux.intel.com
References: <20221118145512.509950-1-gsomlo@gmail.com>
 <20221118145512.509950-10-gsomlo@gmail.com>
 <44bf21b6-cbe4-4d73-0883-a9bcbd7d5971@kernel.org>
In-Reply-To: <44bf21b6-cbe4-4d73-0883-a9bcbd7d5971@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21. 11. 22, 9:37, Jiri Slaby wrote:
> On 18. 11. 22, 15:55, Gabriel Somlo wrote:
>> Update variable types to match the signature of uart_insert_char()
>> which consumes them.
>>
>> Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
>> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>> ---
>>   drivers/tty/serial/liteuart.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/tty/serial/liteuart.c 
>> b/drivers/tty/serial/liteuart.c
>> index 81aa7c1da73c..42ac9aee050a 100644
>> --- a/drivers/tty/serial/liteuart.c
>> +++ b/drivers/tty/serial/liteuart.c
>> @@ -73,8 +73,7 @@ static void liteuart_timer(struct timer_list *t)
>>       struct liteuart_port *uart = from_timer(uart, t, timer);
>>       struct uart_port *port = &uart->port;
>>       unsigned char __iomem *membase = port->membase;
>> -    int ch;
>> -    unsigned long status;
>> +    unsigned int status, ch;
> 
> These should be u8 after all, right?
> 
> Wait, status is a bool in the end:
> 
>>       while ((status = !litex_read8(membase + OFF_RXEMPTY)) == 1) {
> 
> But why is it passed to uart_insert_char() as such? That's ugly. Maybe 
> drop all of this "status" and pass LSR_RXC directly.

Actually, even 0 directly, provided overrun parameter is always 0.

> The while's 
> condition would simply look like (!litex_read8(membase + OFF_RXEMPTY)) 
> then.
> 
>>           ch = litex_read8(membase + OFF_RXTX);
> 
> thanks,

-- 
js

