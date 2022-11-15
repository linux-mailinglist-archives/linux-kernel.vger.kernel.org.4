Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E36D629E97
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 17:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238403AbiKOQO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 11:14:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiKOQO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 11:14:57 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F261D673;
        Tue, 15 Nov 2022 08:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668528896; x=1700064896;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=75pgIdVKQNQqHUWCvgs9DIXphPFBaaKB0XR/iHS+Qbk=;
  b=YyPREz725oBax5FrOZP6xsMsABZGiLGlDA9VNTH2Z1Y6xFzsSSCRmaZE
   8fG9NczKUCSczLd8Y0Liz7ZY5U/RLrrDFANKH4OLYfUvlmjnHO0JWls7R
   H8rhIcl5JUDdfwJKoXBI7uJGtjCyn/D16zU+TStQkIi8xX30RGVHQWBJz
   DxHe3ui0jRJ58h6txcgyopoKORuVK74oJT8MOM+rCGPinn2XnjQWnYyJ/
   v4b+iIQbPc0RgAHge5X6SiQ9UtgNfMjiD+/oD65QvQdHk+kgPHV4fW3J9
   E1Ohnn/N1bfAY3SbNjssxH/Wp4Arnv68kYdgumGjqOLUu/NBEEHbdh79v
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="339091821"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="339091821"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 08:14:55 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="781393695"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="781393695"
Received: from mrosso-mobl1.ger.corp.intel.com ([10.249.45.244])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 08:14:52 -0800
Date:   Tue, 15 Nov 2022 18:14:50 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Gabriel Somlo <gsomlo@gmail.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, kgugala@antmicro.com,
        mholenko@antmicro.com, joel@jms.id.au,
        david.abdurachmanov@gmail.com, florent@enjoy-digital.fr,
        geert@linux-m68k.org
Subject: Re: [PATCH v3 13/14] serial: liteuart: add IRQ support for the TX
 path
In-Reply-To: <20221112212125.448824-14-gsomlo@gmail.com>
Message-ID: <957056a1-78a5-1141-18d7-b49f87fa85f0@linux.intel.com>
References: <20221112212125.448824-1-gsomlo@gmail.com> <20221112212125.448824-14-gsomlo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Nov 2022, Gabriel Somlo wrote:

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

Drop this comment from the earlier patch too given you remove it here. It 
just adds useless churn in diff for no useful reason.

> +	if (port->irq) {
> +		u8 irq_mask = litex_read8(port->membase + OFF_EV_ENABLE);
> +		litex_write8(port->membase + OFF_EV_ENABLE, irq_mask & ~EV_TX);

If you put irq_mask into liteuart_port you wouldn't need to read it 
back here?

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
> -			xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
> -			port->icount.tx++;

This is not based on tty-next tree. Please rebase on top of it (you 
might have noted it already, IIRC, somebody noted uart_xmit_advance
conflict in some patch, perhaps it was you :-)).

> -			liteuart_putchar(port, ch);
> -		}
> +	if (port->irq) {
> +		u8 irq_mask = litex_read8(port->membase + OFF_EV_ENABLE);
> +		litex_write8(port->membase + OFF_EV_ENABLE, irq_mask | EV_TX);

->irq_mask?

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

There exists a helper for this condition.

> +			break;
> +		litex_write8(port->membase + OFF_RXTX, xmit->buf[xmit->tail]);
> +		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
> +		port->icount.tx++;

uart_xmit_advance()

> +	}
> +
> +	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> +		uart_write_wakeup(port);
> +
> +	if (uart_circ_empty(xmit))
> +		liteuart_stop_tx(port);
> +}

You might want to check if you can generate this whole function with 
Jiri's tx helpers (IIRC, they're only in tty-next tree currently).

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

Extra braces.

>  	spin_unlock(&port->lock);
>  
>  	return IRQ_RETVAL(isr);
> @@ -196,6 +221,7 @@ static int liteuart_startup(struct uart_port *port)
>  	}
>  
>  	if (!port->irq) {
> +		uart->poll_tx_started = false;

Can poll_tx_started ever be true here?

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
> 

-- 
 i.

