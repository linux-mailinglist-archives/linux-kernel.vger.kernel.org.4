Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF09462F6B9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 15:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242032AbiKROCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 09:02:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235301AbiKROB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 09:01:58 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2807673BA8;
        Fri, 18 Nov 2022 06:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668780118; x=1700316118;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=i9fDX2RekVjnvoD7vP30rRVqChwZ1BAuiy9dcDgVax0=;
  b=BMK0FHOV1yyOYJGwj2D0LEDkAKzc+4x3B+JBTklxcgS1pRzDadiJK+1u
   PPxg9VmNwL59ZuKtJUAeHon7bN6hkZUBesmG9uF1t5alkrl5Ub0Tx3AzW
   Sjec9ybgO3XnyF13kGMajSEhhcW7RgXOA3wDEMdRM7RK5zJ/Un10Jvg4w
   VipWuFlA8bfIFq8yGIF0QaRMLrwHnQx3rv0j2/n0fc3DeiMliYMmr+LBs
   C/UwtEeHOTeUOnEbOShik1sAZYg5HZvAy8Lj8pzIEGGHr++W9FwMSdzbT
   CRY5ZqeL5Lk4JjEk0rWD0hEYg/ZCEMEmEfBhueWHRJMbjQ/64WTzlHBQ/
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="399426146"
X-IronPort-AV: E=Sophos;i="5.96,174,1665471600"; 
   d="scan'208";a="399426146"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 06:01:57 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="729238337"
X-IronPort-AV: E=Sophos;i="5.96,174,1665471600"; 
   d="scan'208";a="729238337"
Received: from amulyuko-mobl1.ccr.corp.intel.com ([10.252.35.83])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 06:01:54 -0800
Date:   Fri, 18 Nov 2022 16:01:53 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Gabriel Somlo <gsomlo@gmail.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, kgugala@antmicro.com,
        mholenko@antmicro.com, joel@jms.id.au,
        david.abdurachmanov@gmail.com, florent@enjoy-digital.fr,
        geert@linux-m68k.org
Subject: Re: [PATCH v4 13/14] serial: liteuart: add IRQ support for the TX
 path
In-Reply-To: <20221116144908.234154-14-gsomlo@gmail.com>
Message-ID: <cf454524-7c38-76e3-61c9-7e2671cc2eb@linux.intel.com>
References: <20221116144908.234154-1-gsomlo@gmail.com> <20221116144908.234154-14-gsomlo@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-72002580-1668780118=:3952"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-72002580-1668780118=:3952
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Wed, 16 Nov 2022, Gabriel Somlo wrote:

> Switch the TX path to IRQ-driven operation, while maintaining support
> for polling mode via the poll timer.
> 
> Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
> ---
> 
> Changes from v3:
>   - remove superfluous curly braces from liteuart_interrupt()
>   - simplified [start|stop]_tx() by using shadow irq register from
>     patch 12/14
>   - simplified liteuart_tx_chars() by rebasing on top of tty-next tree
> 
>  drivers/tty/serial/liteuart.c | 30 +++++++++++++-----------------
>  1 file changed, 13 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
> index fad778578986..977fc4349b47 100644
> --- a/drivers/tty/serial/liteuart.c
> +++ b/drivers/tty/serial/liteuart.c
> @@ -93,27 +93,12 @@ static void liteuart_update_irq_reg(struct uart_port *port, bool set, u8 mask)
>  
>  static void liteuart_stop_tx(struct uart_port *port)
>  {
> +	liteuart_update_irq_reg(port, false, EV_TX);
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
> -			uart_xmit_advance(port, 1);
> -			liteuart_putchar(port, ch);
> -		}
> -	}
> -
> -	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> -		uart_write_wakeup(port);
> +	liteuart_update_irq_reg(port, true, EV_TX);
>  }
>  
>  static void liteuart_stop_rx(struct uart_port *port)
> @@ -144,6 +129,15 @@ static void liteuart_rx_chars(struct uart_port *port)
>  	tty_flip_buffer_push(&port->state->port);
>  }
>  
> +static void liteuart_tx_chars(struct uart_port *port)
> +{
> +	u8 ch;
> +
> +	uart_port_tx(port, ch,
> +		!litex_read8(port->membase + OFF_TXFULL),
> +		litex_write8(port->membase + OFF_RXTX, ch));
> +}
> +
>  static irqreturn_t liteuart_interrupt(int irq, void *data)
>  {
>  	struct liteuart_port *uart = data;
> @@ -154,6 +148,8 @@ static irqreturn_t liteuart_interrupt(int irq, void *data)
>  	isr = litex_read8(port->membase + OFF_EV_PENDING) & uart->irq_reg;
>  	if (isr & EV_RX)
>  		liteuart_rx_chars(port);
> +	if (isr & EV_TX)
> +		liteuart_tx_chars(port);
>  	spin_unlock(&port->lock);
>  
>  	return IRQ_RETVAL(isr);

Looks very clean now with uart_port_tx(), thanks.

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-72002580-1668780118=:3952--
