Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1379E631BC2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 09:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbiKUIpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 03:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiKUIpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 03:45:09 -0500
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9813661744;
        Mon, 21 Nov 2022 00:45:08 -0800 (PST)
Received: by mail-ej1-f51.google.com with SMTP id gv23so26846361ejb.3;
        Mon, 21 Nov 2022 00:45:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OSwlfEXLAaByikFdLKEpN0fMli0S+iw5J5JRP+E+1Cc=;
        b=rvQCUCyxWAlLkTXzd4eJbfIbHWOHY0fpbLDY+PkqkAE9T7lE4SegWbl5WWGliyV+ih
         LM1cW4bGK81GNwYL4ZzsCV8mCuWZhc/HedEOvXTYZRlQbTd9I1YBkIfhSFuBzG0I4nfN
         2P8pYGntOiji5oD0t7VDmShr3gaO4t24fAiROX7dpyOSTC1M81QjDGWX39zblAOr73NN
         VFfcEXrVspB/4cmCiCMIyJ7NGwMHJaeaWtCx7MBEmsTXbVNdlSIy5K5pHTgsdLsThAB4
         adDN9hZmD4dL8Wd0i+ZbvXjvvRPMM3eSECmkDIKxqTiNF9FlYxm9LF1BukRMwxse9V7Z
         AvRg==
X-Gm-Message-State: ANoB5pkUSbym6XGl3v8c838WTV/smfOPv+A+euXw6CQHhcELIU/inqni
        +whBKFnJuv03J/P2NkxYmQQ=
X-Google-Smtp-Source: AA0mqf41aeCMWBPw/W7bBHcNFCqsvqDvBWz2UqhC19oVJxhOzms9tp5qTIha/NA4JBOobYK3ayRaBQ==
X-Received: by 2002:a17:906:ce35:b0:7ae:215:2dd5 with SMTP id sd21-20020a170906ce3500b007ae02152dd5mr14306117ejb.208.1669020307205;
        Mon, 21 Nov 2022 00:45:07 -0800 (PST)
Received: from [192.168.1.49] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id es8-20020a056402380800b00459148fbb3csm4896199edb.86.2022.11.21.00.45.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 00:45:06 -0800 (PST)
Message-ID: <1b5a963c-2a5b-54fe-784e-fcc4d06c347e@kernel.org>
Date:   Mon, 21 Nov 2022 09:45:05 +0100
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
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
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

And can you change membase to u8 * too 8-)?

-- 
js
suse labs

