Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031696336F7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 09:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbiKVIZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 03:25:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232767AbiKVIZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 03:25:41 -0500
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD32B40461;
        Tue, 22 Nov 2022 00:25:39 -0800 (PST)
Received: by mail-ej1-f47.google.com with SMTP id f18so34082690ejz.5;
        Tue, 22 Nov 2022 00:25:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rqzJXVCIFXT+ImcuK6zLC9C+IpbEl4M5NWl8PhnWNgo=;
        b=PYm31l6uBTsU14LOqwru6wKUn8SNtjyY6PW/1OQBKgLQLAu6eulVVu+7LaCLcoheKD
         STH8PMY3llbq8+DUywI9pxQPAhL2Du05tZw67C5Kf3qNhpFVX1IKn602IEZq7FgVwvZN
         MTwAfUkR8XGYcJZuBtI7bfDKU8UVpWmdM37GZx2C+ze1dRBT8lp37qcRDfwdGnyPBYoz
         rGUEzejK3LoL2Nemw9WjmZw2JBifLRm2nmHbYxF5pyIbxamzVEcYdJai9/1YrlIIep/G
         kVi0zUmgenZlCYcirq6mIrA4PJW0VrNBaILviycqwrW+ON7vcRPHqahHRJ+uFY9FNqbu
         tfQQ==
X-Gm-Message-State: ANoB5pm7XED2g+Ysn/2T68GvSlChS9JDqLwhNNjnPl7NDPvrAIGYa2lj
        fhqFyosKwlqN7AztAE6djVc=
X-Google-Smtp-Source: AA0mqf4rqYMo51srxf/7UurVAPmcfYjv2eV6nPzemuxUog61X+TJcq5AjJ/Pon56VIFK1GDG8x3qEg==
X-Received: by 2002:a17:907:1dc6:b0:78d:8533:be13 with SMTP id og6-20020a1709071dc600b0078d8533be13mr18662937ejc.716.1669105538479;
        Tue, 22 Nov 2022 00:25:38 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:49? ([2a0b:e7c0:0:107::aaaa:49])
        by smtp.gmail.com with ESMTPSA id m17-20020a170906161100b0073dc5bb7c32sm5802902ejd.64.2022.11.22.00.25.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 00:25:38 -0800 (PST)
Message-ID: <ca8e1e8c-fe50-ca94-7cb8-9044f8cc16d0@kernel.org>
Date:   Tue, 22 Nov 2022 09:25:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v5 2/3] tty: serial: use uart_port_tx() helper
Content-Language: en-US
From:   Jiri Slaby <jirislaby@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     afaerber@suse.de, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, festevam@gmail.com,
        gregkh@linuxfoundation.org, ilpo.jarvinen@linux.intel.com,
        kernel@pengutronix.de, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        liviu.dudau@arm.com, lorenzo.pieralisi@arm.com, mani@kernel.org,
        nicolas.ferre@microchip.com, richard.genoud@gmail.com,
        s.hauer@pengutronix.de, shawnguo@kernel.org, sudeep.holla@arm.com,
        tklauser@distanz.ch, vz@mleia.com
References: <20221004104927.14361-3-jirislaby@kernel.org>
 <20221121202724.1708460-1-michael@walle.cc>
 <f95ef7b7-cc23-9fed-5d05-1aa66aaeb86a@kernel.org>
 <0ef4f1e6d92601a39fe0d1c316506c12@walle.cc>
 <325fdfbf37b155c41e2b45bcddd96e9b@walle.cc>
 <0faeb934-a2c9-fcc2-6961-d3f1bbf37fa2@kernel.org>
In-Reply-To: <0faeb934-a2c9-fcc2-6961-d3f1bbf37fa2@kernel.org>
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

On 22. 11. 22, 9:23, Jiri Slaby wrote:
> On 22. 11. 22, 9:18, Michael Walle wrote:
>> Am 2022-11-22 09:09, schrieb Michael Walle:
>>> Hi,
>>>
>>> Am 2022-11-22 08:02, schrieb Jiri Slaby:
>>>> On 21. 11. 22, 21:27, Michael Walle wrote:
>>>>> This will break serial output for the userspace on my board
>>>>> (arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt*dts). The 
>>>>> uart_port_tx()
>>>>> helper will call __port->ops->stop_tx(__port) if 
>>>>> uart_circ_chars_pending()
>>>>> returns 0. But the code above, doesn't do that. In fact, removing the
>>>>> stop_tx() call in the helper macro, will fix the console output.
>>>>>
>>>>> Any ideas how to fix that?
>>>>
>>>> Hm, so ATMEL_US_TXRDY is removed from tx_done_mask in stop_tx, but not
>>>> added back in start_tx. So the tx interrupt is never handled (the tx
>>>> tasklet is not scheduled to send the queue chars) in
>>>> atmel_handle_transmit().
>>>>
>>>> Any chance, the below fixes it?
>>>>
>>>> diff --git a/drivers/tty/serial/atmel_serial.c
>>>> b/drivers/tty/serial/atmel_serial.c
>>>> index 11bf2466390e..395370e0c77b 100644
>>>> --- a/drivers/tty/serial/atmel_serial.c
>>>> +++ b/drivers/tty/serial/atmel_serial.c
>>>> @@ -596,6 +596,8 @@ static void atmel_start_tx(struct uart_port *port)
>>>>                 /* re-enable PDC transmit */
>>>>                 atmel_uart_writel(port, ATMEL_PDC_PTCR, 
>>>> ATMEL_PDC_TXTEN);
>>>>
>>>> +       atmel_port->tx_done_mask |= ATMEL_US_TXRDY;
>>>> +
>>>>         /* Enable interrupts */
>>>>         atmel_uart_writel(port, ATMEL_US_IER, 
>>>> atmel_port->tx_done_mask);
>>>>
>>>>
>>>> thanks,
>>>
>>> Unfortunately, that doesn't help. Btw, some characters are transmitted:
>>>
>>>
>>> [    6.219356] Key type dns_resolver registered
>>> [    6.223679] Registering SWP/SWPB emulation handler
>>> [    6.247530] Loading compiled-in X.509 certificates
>>> [    6.288467] Freeing unused kernel image (initmem) memory: 1024K
>>> [    6.297789] Run /init as init process
>>> WbSOROSOSOSOSOStarting linuxptp system clock synchronization: O
>>>
>>> -michael
>>
>> But you made me look at atmel_stop_tx() and there is this:
>>
>>         /*
>>      * Disable the transmitter.
>>      * This is mandatory when DMA is used, otherwise the DMA buffer
>>      * is fully transmitted.
>>      */
>>      atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_TXDIS);
>>
>> Removing that write, will also fix the problem. Could it be, that
>> the transmit is still active (via DMA) but the driver will call
>> tx_stop() and then stop the transmission in the background?
> 
> Yes, that was exactly the next step to try. The datasheet doesn't tell 
> much what happens when TXDIS is written while the characters are 
> transmitted.

Side note: your usart doesn't use dma. It's PIO (hence all that 
uart_tx_helper()). And the attached patch doesn't touch TXDIS for 
non-DMA case. I.e. it should transmit the final character (and nothing 
more).

-- 
js

