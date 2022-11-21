Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB71631C28
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 09:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiKUI4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 03:56:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbiKUIzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 03:55:54 -0500
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 403208CF13;
        Mon, 21 Nov 2022 00:54:38 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id ud5so26881771ejc.4;
        Mon, 21 Nov 2022 00:54:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zHnEp5FbFvmb3QyLSn3I57RXTnQLn/CFzXwFULZoeMg=;
        b=Vj0U12xbWCZoKyJot67nB0PfE8EE6tZyG1QgXJK9uveeLpLQM+geA0rF00mADEEhru
         5g5Wbn1K7SHbb9uygrRK4k53jO+9KJd2YiU1e2m4T1ralnom58q8Dk2faGbIu2ULkRuw
         HPFOI3BXwESTWjG5aqzyeQZFYQHen0CHloC9Tvsh2qFTgrrn+APs3dD2dgoKvL9E/4OE
         u7lnfD4fHwus0Aokj9UjFAzZ3oSdAZ8HCDNu3uyQtcVHZFxLXzVF91+fzSELyBQqza12
         glf2KWfVqmiDLeFY9Jf0u8rofGH4oR/ojm3UA1h4MgwByvdYorz+ofC1wbe895QE6QDL
         W3Xw==
X-Gm-Message-State: ANoB5pnhzEuGPmQ38cdVEmRrxC4/8yrfFkNNiLIW56onCAfUD08Bk4Dx
        rPGDCzGWieA2yO9mZHULmZU=
X-Google-Smtp-Source: AA0mqf6Q9Jzp3dJ3tKc3OoOGy0S+3Z9QoJDCj50IAiUbDlwuBIZrpHW6WjiqRomRSbA77fQNd9RdRw==
X-Received: by 2002:a17:906:1412:b0:7a0:3313:a775 with SMTP id p18-20020a170906141200b007a03313a775mr3833703ejc.474.1669020876784;
        Mon, 21 Nov 2022 00:54:36 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:49? ([2a0b:e7c0:0:107::aaaa:49])
        by smtp.gmail.com with ESMTPSA id f16-20020a17090631d000b0073d81b0882asm4725365ejf.7.2022.11.21.00.54.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 00:54:36 -0800 (PST)
Message-ID: <abb7d87a-46c7-fe7f-f943-4287d15a537f@kernel.org>
Date:   Mon, 21 Nov 2022 09:54:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Content-Language: en-US
To:     Gabriel Somlo <gsomlo@gmail.com>, linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        kgugala@antmicro.com, mholenko@antmicro.com, joel@jms.id.au,
        david.abdurachmanov@gmail.com, florent@enjoy-digital.fr,
        geert@linux-m68k.org, ilpo.jarvinen@linux.intel.com
References: <20221118145512.509950-1-gsomlo@gmail.com>
 <20221118145512.509950-13-gsomlo@gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v5 12/14] serial: liteuart: add IRQ support for the RX
 path
In-Reply-To: <20221118145512.509950-13-gsomlo@gmail.com>
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
> Add support for IRQ-driven RX. Support for the TX path will be added
> in a separate commit.
> 
> Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
> 
> Changes from v4:
>    - using dev_err() instead of a combo of pr_err() and pr_fmt()
>    - dropped "get irq" comment in probe()
> 
>> Changes from v3:
>>    - add shadow irq register to support polling mode and avoid reading
>>      hardware mmio irq register to learn which irq flags are enabled
>>      - this also simplifies both liteuart_interrupt() and liteuart_startup()
> 
>   drivers/tty/serial/liteuart.c | 76 +++++++++++++++++++++++++++++++----
>   1 file changed, 69 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
> index 8a6e176be08e..678c37c952cf 100644
> --- a/drivers/tty/serial/liteuart.c
> +++ b/drivers/tty/serial/liteuart.c
> @@ -7,6 +7,7 @@
>   
>   #include <linux/bits.h>
>   #include <linux/console.h>
> +#include <linux/interrupt.h>
>   #include <linux/litex.h>
>   #include <linux/module.h>
>   #include <linux/of.h>
> @@ -46,6 +47,7 @@ struct liteuart_port {
>   	struct uart_port port;
>   	struct timer_list timer;
>   	u32 id;
> +	u8 irq_reg;
>   };
>   
>   #define to_liteuart_port(port)	container_of(port, struct liteuart_port, port)
> @@ -76,6 +78,19 @@ static void liteuart_putchar(struct uart_port *port, unsigned char ch)
>   	litex_write8(port->membase + OFF_RXTX, ch);
>   }
>   
> +static void liteuart_update_irq_reg(struct uart_port *port, bool set, u8 mask)
> +{
> +	struct liteuart_port *uart = to_liteuart_port(port);
> +
> +	if (set)
> +		uart->irq_reg |= mask;
> +	else
> +		uart->irq_reg &= ~mask;
> +
> +	if (port->irq)
> +		litex_write8(port->membase + OFF_EV_ENABLE, uart->irq_reg);
> +}
> +
>   static void liteuart_stop_tx(struct uart_port *port)
>   {
>   }
> @@ -129,13 +144,27 @@ static void liteuart_rx_chars(struct uart_port *port)
>   	tty_flip_buffer_push(&port->state->port);
>   }
>   
> +static irqreturn_t liteuart_interrupt(int irq, void *data)
> +{
> +	struct liteuart_port *uart = data;
> +	struct uart_port *port = &uart->port;
> +	u8 isr;
> +
> +	spin_lock(&port->lock);
> +	isr = litex_read8(port->membase + OFF_EV_PENDING) & uart->irq_reg;
> +	if (isr & EV_RX)
> +		liteuart_rx_chars(port);
> +	spin_unlock(&port->lock);
> +
> +	return IRQ_RETVAL(isr);
> +}
> +
>   static void liteuart_timer(struct timer_list *t)
>   {
>   	struct liteuart_port *uart = from_timer(uart, t, timer);
>   	struct uart_port *port = &uart->port;
>   
> -	liteuart_rx_chars(port);
> -
> +	liteuart_interrupt(0, port);

Are you sure spin_lock() is safe from this path? I assume so, but have 
you thought about it?

>   	mod_timer(&uart->timer, jiffies + uart_poll_timeout(port));
>   }
>   
> @@ -161,19 +190,46 @@ static unsigned int liteuart_get_mctrl(struct uart_port *port)
>   static int liteuart_startup(struct uart_port *port)
>   {
>   	struct liteuart_port *uart = to_liteuart_port(port);
> +	unsigned long flags;
> +	int ret;
>   
> -	/* disable events */
> -	litex_write8(port->membase + OFF_EV_ENABLE, 0);
> +	if (port->irq) {
> +		ret = request_irq(port->irq, liteuart_interrupt, 0,
> +				  KBUILD_MODNAME, uart);

Just asking: cannot the irq be shared?

> +		if (ret) {
> +			dev_err(port->dev,
> +				"line %d irq %d failed: switch to polling\n",
> +				port->line, port->irq);

That is, it should be only dev_warn(), or?

> +			port->irq = 0;
> +		}
> +	}

thanks,
-- 
js
suse labs

