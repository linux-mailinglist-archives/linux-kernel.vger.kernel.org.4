Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE60626F61
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 13:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235267AbiKMMGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 07:06:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235242AbiKMMGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 07:06:18 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CA0E00E;
        Sun, 13 Nov 2022 04:06:17 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id d7so3522406qkk.3;
        Sun, 13 Nov 2022 04:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fAOo6SdSr5cc6dwBg2ueNRz2u+b4dLiCPJjmXU85JXY=;
        b=QD2OY85oxXJOJM7gw6JS67mJtilyu6V2LCT+TStSYeiOsGZ7YgsIi3D7tjDg1K4ldz
         wYfG3k4J4x+xqcguDHVfPbuRfoMGkH9f0Eo+kGLlasyx7z5oiFSsM1gr4W+Lox6I2X/t
         fEH7WyGgJWqqvhE3FkT3O+4wXzTZAPTyFR24LewQIqk9aOvyfQ5Z/uD2w1G7ysENw5/a
         WQ5KjMCQ4AnzisqFBcCAdqXIeACtoUaFs+l+BvPgoe6q3qy5xGRoLjAWvXS7VPQnBEI6
         1a40U8z7dEkonqXG4bWBA0Mh7AiP/fF8wwLV0V86oPK7kFzOT5KdtttZSxifjWW2MNGx
         xMwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fAOo6SdSr5cc6dwBg2ueNRz2u+b4dLiCPJjmXU85JXY=;
        b=KHvDH5Ep+0eQwp+FfFZSLGdhF8igikODw1Ba3cqHGxgtRUIkxlDRwdhSnJCmsWxZln
         9sDlSY8JqEbiZ1pgsc8DldsQ3AjBu/mtNHuhQJKTUiOl4TFHX4fHqNOE6a48I2oMBC/Z
         83tlbJdFjGEaXpUtsVQ89hSFQg83cr6GCI/SByV7VV4FE13udNL5Kpw6CTC9D1C20sDE
         nZ3upZ+ZT5T3L/mOxElOqb3VprfbVlhQoy14/xU+PBQo04za70SrYg6LnUvwkJZz8yWu
         Yiszfmoj2mRbF85YZv0FVCysYC80dQF/3Kmx79O1sKVSv9eiXJo0QGpnUGf2/nRNOy6D
         +Z4Q==
X-Gm-Message-State: ANoB5plpTKDah25qweI4E8EbzU2gx1DuGsPdPGp0e1ZP24K4Kx4KKY6M
        7mZQPXjfRehYwC6+m1ZW1NuPns9BFDIY4g==
X-Google-Smtp-Source: AA0mqf6fa3sscoJq3aEkuEI2tZc1kVisJbwP13Jkuw4tjBRID86EUiMjaQAm91r/zTFT0kZoaBTF/w==
X-Received: by 2002:a37:e308:0:b0:6fa:1745:cb2c with SMTP id y8-20020a37e308000000b006fa1745cb2cmr7466111qki.119.1668341176431;
        Sun, 13 Nov 2022 04:06:16 -0800 (PST)
Received: from errol.ini.cmu.edu (pool-72-77-81-136.pitbpa.fios.verizon.net. [72.77.81.136])
        by smtp.gmail.com with ESMTPSA id c8-20020ac853c8000000b00359961365f1sm4073976qtq.68.2022.11.13.04.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 04:06:15 -0800 (PST)
Date:   Sun, 13 Nov 2022 07:06:14 -0500
From:   "Gabriel L. Somlo" <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, kgugala@antmicro.com, mholenko@antmicro.com,
        joel@jms.id.au, david.abdurachmanov@gmail.com,
        florent@enjoy-digital.fr, geert@linux-m68k.org,
        ilpo.jarvinen@linux.intel.com
Subject: Re: [PATCH v3 13/14] serial: liteuart: add IRQ support for the TX
 path
Message-ID: <Y3DdtgIbBHTnUffV@errol.ini.cmu.edu>
References: <20221112212125.448824-1-gsomlo@gmail.com>
 <20221112212125.448824-14-gsomlo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221112212125.448824-14-gsomlo@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 12, 2022 at 04:21:24PM -0500, Gabriel Somlo wrote:
> Modify the TX path to operate in an IRQ-compatible way, while
> maintaining support for polling mode via the poll timer.
> 
> Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
> ---
>  drivers/tty/serial/liteuart.c | 67 ++++++++++++++++++++++++-----------
>  1 file changed, 47 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
> index e30adb30277f..307c27398e30 100644
> --- a/drivers/tty/serial/liteuart.c
> +++ b/drivers/tty/serial/liteuart.c
> @@ -46,6 +46,7 @@ struct liteuart_port {
>  	struct uart_port port;
>  	struct timer_list timer;
>  	u32 id;
> +	bool poll_tx_started;
>  };
>  
>  #define to_liteuart_port(port)	container_of(port, struct liteuart_port, port)
> @@ -78,29 +79,24 @@ static void liteuart_putchar(struct uart_port *port, unsigned char ch)
>  
>  static void liteuart_stop_tx(struct uart_port *port)
>  {
> -	/* not used in LiteUART, but called unconditionally from serial_core */
> +	if (port->irq) {
> +		u8 irq_mask = litex_read8(port->membase + OFF_EV_ENABLE);
> +		litex_write8(port->membase + OFF_EV_ENABLE, irq_mask & ~EV_TX);
> +	} else {
> +		struct liteuart_port *uart = to_liteuart_port(port);
> +		uart->poll_tx_started = false;
> +	}
>  }
>  
>  static void liteuart_start_tx(struct uart_port *port)
>  {
> -	struct circ_buf *xmit = &port->state->xmit;
> -	unsigned char ch;
> -
> -	if (unlikely(port->x_char)) {
> -		litex_write8(port->membase + OFF_RXTX, port->x_char);
> -		port->icount.tx++;
> -		port->x_char = 0;
> -	} else if (!uart_circ_empty(xmit)) {
> -		while (xmit->head != xmit->tail) {
> -			ch = xmit->buf[xmit->tail];

I just realized that this:

> -			xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
> -			port->icount.tx++;

... conflicts with another accepted patch (by Ilpo) that's currently
making its way to being released:
https://lore.kernel.org/all/20221019091151.6692-20-ilpo.jarvinen@linux.intel.com/

> -			liteuart_putchar(port, ch);
> -		}
> +	if (port->irq) {
> +		u8 irq_mask = litex_read8(port->membase + OFF_EV_ENABLE);
> +		litex_write8(port->membase + OFF_EV_ENABLE, irq_mask | EV_TX);
> +	} else {
> +		struct liteuart_port *uart = to_liteuart_port(port);
> +		uart->poll_tx_started = true;
>  	}
> -
> -	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> -		uart_write_wakeup(port);
>  }
>  
>  static void liteuart_stop_rx(struct uart_port *port)
> @@ -131,18 +127,47 @@ static void liteuart_rx_chars(struct uart_port *port)
>  	tty_flip_buffer_push(&port->state->port);
>  }
>  
> +static void liteuart_tx_chars(struct uart_port *port)
> +{
> +	struct circ_buf *xmit = &port->state->xmit;
> +
> +	if (unlikely(port->x_char)) {
> +		litex_write8(port->membase + OFF_RXTX, port->x_char);
> +		port->x_char = 0;
> +		port->icount.tx++;
> +		return;
> +	}
> +
> +	while (!litex_read8(port->membase + OFF_TXFULL)) {
> +		if (xmit->head == xmit->tail)
> +			break;
> +		litex_write8(port->membase + OFF_RXTX, xmit->buf[xmit->tail]);

Also, this:

> +		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
> +		port->icount.tx++;

should now be `uart_xmit_advance(port, 1);` instead.
I'm going to take that into account in v4, in addition to any extra
feedback I'll receive.

Thanks!

> +	}
> +
> +	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> +		uart_write_wakeup(port);
> +
> +	if (uart_circ_empty(xmit))
> +		liteuart_stop_tx(port);
> +}
> +
>  static irqreturn_t liteuart_interrupt(int irq, void *data)
>  {
>  	struct liteuart_port *uart = data;
>  	struct uart_port *port = &uart->port;
>  	u8 isr = litex_read8(port->membase + OFF_EV_PENDING);
>  
> -	/* for now, only rx path triggers interrupts */
> -	isr &= EV_RX;
> +	if (!(port->irq || uart->poll_tx_started))
> +		isr &= ~EV_TX;	/* polling mode with tx stopped */
>  
>  	spin_lock(&port->lock);
>  	if (isr & EV_RX)
>  		liteuart_rx_chars(port);
> +	if (isr & EV_TX) {
> +		liteuart_tx_chars(port);
> +	}
>  	spin_unlock(&port->lock);
>  
>  	return IRQ_RETVAL(isr);
> @@ -196,6 +221,7 @@ static int liteuart_startup(struct uart_port *port)
>  	}
>  
>  	if (!port->irq) {
> +		uart->poll_tx_started = false;
>  		timer_setup(&uart->timer, liteuart_timer, 0);
>  		mod_timer(&uart->timer, jiffies + uart_poll_timeout(port));
>  	}
> @@ -210,6 +236,7 @@ static void liteuart_shutdown(struct uart_port *port)
>  	struct liteuart_port *uart = to_liteuart_port(port);
>  
>  	litex_write8(port->membase + OFF_EV_ENABLE, 0);
> +	uart->poll_tx_started = false;
>  
>  	if (port->irq)
>  		free_irq(port->irq, port);
> -- 
> 2.37.3
> 
