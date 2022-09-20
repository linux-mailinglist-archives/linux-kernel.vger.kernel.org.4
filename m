Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4725BE0D7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 10:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbiITI4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 04:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiITI4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 04:56:15 -0400
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AC8371AE;
        Tue, 20 Sep 2022 01:56:14 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 29so2835776edv.2;
        Tue, 20 Sep 2022 01:56:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=SVKnPW1lA80jpFlxw0hEeDC0lfsM/uK2FrwITargAU0=;
        b=o2CCWKkhUpKN5nkpSls9N+LPuhaXoELZsJpJFC6kz6tjf8hnlN6Oggok/JmcNKz6g/
         1yW6Jic+1XMrpy1NGEJS9mzsffs1YswwMNNKuFz5rP5hLTv1qV0Yhoslqwpy8SnMl4Ze
         NgVfoXSa3KA0mNUSEp2vB9fgpNCS4frljs04/Kbeteo/9EQLWF2p1L/CvTvErNHEHAqF
         uH34R/CVUqFACUuWX0ou2xvMyW2hvmPQQGGK1obgpt+l/3gJ3xlcSKCqSpkdFIc2XJvk
         D7SwYS/1pC+ToB3r5FYKbH1ZN6p5dNxvM4bWm9/yqSlkGyRY6Q8OyF/q1zVuvdBw5Bhe
         rVSw==
X-Gm-Message-State: ACrzQf0YeK8gkMKULAsRy5wR52r+jPFBzcSI2hT7xyZepfDQMIPI6K5e
        c2HgLPUjauCbCIxLCh+431s=
X-Google-Smtp-Source: AMsMyM51D5DYOdHYt9b/I4SW70I0iohaDWoxASIgxvYA6PtiynB6AyiOnXYfvUJDXG9ml01oxN9ySQ==
X-Received: by 2002:aa7:c3cd:0:b0:453:8808:c7fb with SMTP id l13-20020aa7c3cd000000b004538808c7fbmr15586910edr.426.1663664172717;
        Tue, 20 Sep 2022 01:56:12 -0700 (PDT)
Received: from [192.168.1.49] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id f3-20020a170906048300b0073dc8d0eabesm542807eja.15.2022.09.20.01.56.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 01:56:12 -0700 (PDT)
Message-ID: <9cd3b4bc-64e8-7603-f2e7-8260bdb8b019@kernel.org>
Date:   Tue, 20 Sep 2022 10:56:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v4 09/10] tty: serial: use uart_port_tx() helper
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tobias Klauser <tklauser@distanz.ch>,
        Richard Genoud <richard.genoud@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>
References: <20220920052049.20507-1-jslaby@suse.cz>
 <20220920052049.20507-10-jslaby@suse.cz>
 <87251b8a-d955-e6dd-94df-c7621e72bac@linux.intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <87251b8a-d955-e6dd-94df-c7621e72bac@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20. 09. 22, 10:54, Ilpo Järvinen wrote:
> On Tue, 20 Sep 2022, Jiri Slaby wrote:
> 
>> uart_port_tx() is a new helper to send characters to the device. Use it
>> in these drivers.
>>
>> Cc: Tobias Klauser <tklauser@distanz.ch>
>> Cc: Richard Genoud <richard.genoud@gmail.com>
>> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
>> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
>> Cc: Claudiu Beznea <claudiu.beznea@microchip.com>
>> Cc: Vladimir Zapolskiy <vz@mleia.com>
>> Cc: Liviu Dudau <liviu.dudau@arm.com>
>> Cc: Sudeep Holla <sudeep.holla@arm.com>
>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Cc: Shawn Guo <shawnguo@kernel.org>
>> Cc: Sascha Hauer <s.hauer@pengutronix.de>
>> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
>> Cc: Fabio Estevam <festevam@gmail.com>
>> Cc: NXP Linux Team <linux-imx@nxp.com>
>> Cc: "Andreas Färber" <afaerber@suse.de>
>> Cc: Manivannan Sadhasivam <mani@kernel.org>
>> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
>> ---
> 
>> diff --git a/drivers/tty/serial/mcf.c b/drivers/tty/serial/mcf.c
>> index b1cd9a76dd93..53b642ea46ba 100644
>> --- a/drivers/tty/serial/mcf.c
>> +++ b/drivers/tty/serial/mcf.c
>> @@ -327,29 +327,13 @@ static void mcf_rx_chars(struct mcf_uart *pp)
>>   static void mcf_tx_chars(struct mcf_uart *pp)
>>   {
>>   	struct uart_port *port = &pp->port;
>> -	struct circ_buf *xmit = &port->state->xmit;
>> -
>> -	if (port->x_char) {
>> -		/* Send special char - probably flow control */
>> -		writeb(port->x_char, port->membase + MCFUART_UTB);
>> -		port->x_char = 0;
>> -		port->icount.tx++;
>> -		return;
>> -	}
>> -
>> -	while (readb(port->membase + MCFUART_USR) & MCFUART_USR_TXREADY) {
>> -		if (uart_circ_empty(xmit))
>> -			break;
>> -		writeb(xmit->buf[xmit->tail], port->membase + MCFUART_UTB);
>> -		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE -1);
>> -		port->icount.tx++;
>> -	}
>> -
>> -	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
>> -		uart_write_wakeup(port);
>> +	unsigned int pending;
>> +	u8 ch;
>>   
>> -	if (uart_circ_empty(xmit)) {
>> -		mcf_stop_tx(port);
>> +	pending = uart_port_tx(port, ch,
>> +		readb(port->membase + MCFUART_USR) & MCFUART_USR_TXREADY,
>> +		writeb(ch, port->membase + MCFUART_UTB));
>> +	if (!pending) {
> 
> Why unsigned int pending here and bool pending in the other cases?

Right, I somehow omitted that pending is not used anywhere else. This 
should be bool too, of course.

> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

thanks,
-- 
js
suse labs

