Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD4463884A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 12:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiKYLIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 06:08:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiKYLIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 06:08:37 -0500
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA7A31FF80;
        Fri, 25 Nov 2022 03:08:35 -0800 (PST)
Received: by mail-wr1-f50.google.com with SMTP id x5so6248690wrt.7;
        Fri, 25 Nov 2022 03:08:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ko+xoqLtNUZNHhBBiO7KwAurhDJoia3rMVPFpu1qvr0=;
        b=muPcKgeNHMer7ZnVh1MUEPXZHfxurPffK48E3B+nv42zeR2j3mGauZ0dpPp23zJQ23
         LNmXbkLx/abULQTjyK927d9uwfNrN+gJHOTNCvq6I24c918CVWQmtuwDz+QRYFF+RqcR
         8WrTzc/nzF5wB/pTTiwQBPCliOCNDYQtAB+GdsBv0xEtZO0IbRQW7mehCOEIUsabnep/
         kxT1NOdwOPJRN+w9CyEj/YfhoQi9Hn+WoI/clgl/iD5Y5n4cPIrAoPo+MfPLa2tjCcsi
         YPstpKvrvl6o+mnwDh+avoiibMhel6+L4fLXSN6HVHxTj26u5cgCgE8l7Na36562JaCu
         9ykA==
X-Gm-Message-State: ANoB5pnrueJszELx+JSwrzNgKmj0wj6Y/gR5N7yarVOH3bF0xTYOFIjT
        AxSbnuJrFfUTihADuQ15Cu9w8RZP/EY=
X-Google-Smtp-Source: AA0mqf5Y38vwcONUoeAGJnBlHmzrjBtjGbaoOdsmjFJzC+kogqLTb1IaEpC5k5bBRlm00dgFAtvUpg==
X-Received: by 2002:a05:6000:235:b0:241:ebff:2db1 with SMTP id l21-20020a056000023500b00241ebff2db1mr7665863wrz.312.1669374514122;
        Fri, 25 Nov 2022 03:08:34 -0800 (PST)
Received: from [192.168.1.49] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id p13-20020a05600c358d00b003c6b9749505sm9620009wmq.30.2022.11.25.03.08.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 03:08:33 -0800 (PST)
Message-ID: <611396d6-8e08-82cc-ca9c-73a575ea8025@kernel.org>
Date:   Fri, 25 Nov 2022 12:08:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 4/6] serial: 8250: Add IIR FIFOs enabled field properly
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20221124125948.23432-1-ilpo.jarvinen@linux.intel.com>
 <20221124125948.23432-5-ilpo.jarvinen@linux.intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20221124125948.23432-5-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24. 11. 22, 13:59, Ilpo Järvinen wrote:
> Don't use magic literals & comments but define a real field instead
> for UART_IIR_FIFO_ENABLED and name also the values.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>   drivers/tty/serial/8250/8250_port.c | 17 +++++++----------
>   include/uapi/linux/serial_reg.h     |  4 ++++
>   2 files changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index e79bf2afd9be..6d343b15bc58 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -1293,22 +1293,19 @@ static void autoconfig(struct uart_8250_port *up)
>   
>   	serial_out(up, UART_FCR, UART_FCR_ENABLE_FIFO);
>   
> -	/* Assign this as it is to truncate any bits above 7.  */
> -	scratch = serial_in(up, UART_IIR);
> -
> -	switch (scratch >> 6) {
> -	case 0:
> +	switch (serial_in(up, UART_IIR) & UART_IIR_FIFO_ENABLED) {
> +	case UART_IIR_FIFO_ENABLED_8250:
>   		autoconfig_8250(up);
>   		break;
> -	case 1:
> -		port->type = PORT_UNKNOWN;
> -		break;
> -	case 2:
> +	case UART_IIR_FIFO_EAABLED_16550:

EAABLED :)?

> --- a/include/uapi/linux/serial_reg.h
> +++ b/include/uapi/linux/serial_reg.h
> @@ -44,6 +44,10 @@
>   #define UART_IIR_RX_TIMEOUT	0x0c /* OMAP RX Timeout interrupt */
>   #define UART_IIR_XOFF		0x10 /* OMAP XOFF/Special Character */
>   #define UART_IIR_CTS_RTS_DSR	0x20 /* OMAP CTS/RTS/DSR Change */
> +#define UART_IIR_FIFO_ENABLED	0xc0 /* FIFOs enabled / port type identification */
> +#define  UART_IIR_FIFO_ENABLED_8250	0x00	/* 8250: no FIFO */
> +#define  UART_IIR_FIFO_EAABLED_16550	0x80	/* 16550: (broken/unusable) FIFO */
> +#define  UART_IIR_FIFO_ENABLED_16550A	0xc0	/* 16550A: FIFO enabled */
>   
>   #define UART_FCR	2	/* Out: FIFO Control Register */
>   #define UART_FCR_ENABLE_FIFO	0x01 /* Enable the FIFO */

-- 
js
suse labs

