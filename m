Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7A7631B9D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 09:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiKUIhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 03:37:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiKUIhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 03:37:16 -0500
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A8A1F2FE;
        Mon, 21 Nov 2022 00:37:15 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id bj12so26695726ejb.13;
        Mon, 21 Nov 2022 00:37:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ahq+G/QJAtYi82jQX9f+cluF1LoI7Ep3P6ooqImmzio=;
        b=7LfECugByeuj80xcnDAHP4rwoDr0y970L+DFRrFr/TV2X7d3CmdOFtzEhtb1H2tA5C
         ivnZM2c1UaGRAtMGzX52ZADBmuZnsJ59VbQ4H1a1SqcY8oeVQZ+YBbReJgJ1yD1eRNnR
         91/sx/zzq8lChSn785GeWah/KbK2xza0XCYreukCLqzc3e/cNNYa4Af+krfFEpAr2no0
         4Ed3JcOvbpjATlPLDj1TF+2KehpIGf6WmGnwMS22s0tsiG+qmqM40cCNhL1kmajGQkJk
         jgOzWbg2WQCP5wReUzekx2MwCYuo/jpWisU3uhwAbyvVcJ/p/JFUD2JB+S7bQIQp8nO5
         jlvg==
X-Gm-Message-State: ANoB5pkSUxm3w8sC1LeoLEwfIuRXYO0leDJoOWjbT9mqPYYTVSkz0ZZP
        xN9ffMRAyBN5PFDV6FS9h10=
X-Google-Smtp-Source: AA0mqf41/ue7ZZt1+gcLSpO14efqLI+hlYnYIbCKKeHwcs15FjtqWJOIsTULd/kWAjyTSzy1uKpieg==
X-Received: by 2002:a17:906:eb04:b0:7ae:77ef:d048 with SMTP id mb4-20020a170906eb0400b007ae77efd048mr14659303ejb.740.1669019833844;
        Mon, 21 Nov 2022 00:37:13 -0800 (PST)
Received: from [192.168.1.49] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id 9-20020a170906328900b0078df3b4464fsm4803199ejw.19.2022.11.21.00.37.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 00:37:13 -0800 (PST)
Message-ID: <44bf21b6-cbe4-4d73-0883-a9bcbd7d5971@kernel.org>
Date:   Mon, 21 Nov 2022 09:37:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v5 09/14] serial: liteuart: fix rx loop variable types
Content-Language: en-US
To:     Gabriel Somlo <gsomlo@gmail.com>, linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        kgugala@antmicro.com, mholenko@antmicro.com, joel@jms.id.au,
        david.abdurachmanov@gmail.com, florent@enjoy-digital.fr,
        geert@linux-m68k.org, ilpo.jarvinen@linux.intel.com
References: <20221118145512.509950-1-gsomlo@gmail.com>
 <20221118145512.509950-10-gsomlo@gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20221118145512.509950-10-gsomlo@gmail.com>
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

On 18. 11. 22, 15:55, Gabriel Somlo wrote:
> Update variable types to match the signature of uart_insert_char()
> which consumes them.
> 
> Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>   drivers/tty/serial/liteuart.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
> index 81aa7c1da73c..42ac9aee050a 100644
> --- a/drivers/tty/serial/liteuart.c
> +++ b/drivers/tty/serial/liteuart.c
> @@ -73,8 +73,7 @@ static void liteuart_timer(struct timer_list *t)
>   	struct liteuart_port *uart = from_timer(uart, t, timer);
>   	struct uart_port *port = &uart->port;
>   	unsigned char __iomem *membase = port->membase;
> -	int ch;
> -	unsigned long status;
> +	unsigned int status, ch;

These should be u8 after all, right?

Wait, status is a bool in the end:

>   	while ((status = !litex_read8(membase + OFF_RXEMPTY)) == 1) {

But why is it passed to uart_insert_char() as such? That's ugly. Maybe 
drop all of this "status" and pass LSR_RXC directly. The while's 
condition would simply look like (!litex_read8(membase + OFF_RXEMPTY)) then.

>   		ch = litex_read8(membase + OFF_RXTX);

thanks,
-- 
js
suse labs

