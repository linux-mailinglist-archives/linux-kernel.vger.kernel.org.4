Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB139629E52
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 17:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbiKOQAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 11:00:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiKOQAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 11:00:22 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A83F0;
        Tue, 15 Nov 2022 08:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668528020; x=1700064020;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=EQtU8zLO0gwSoon26zbo9hDeoJ1iuGf+W9YAIqhY6lk=;
  b=SjWvmltF35yCVVxpClKjYOY1F9RYcJFeG5cUfUE7afUVuGq7XTgJgOOd
   0NkcZnV3cBENxvDC8PooqjFg8vpZqE0A1mYNIceA0GiQu0WOlrXv7Gaxp
   GO0C8Y65Q5gcDDJLBCPxzVGepb838nWY7TBTrfsWQtUe5Kp0UABJsmma2
   nWv+ppYlwa/tlzycxBocWPx17PIkgS+jnZcAEaoXD9hYprGRrr/0X+dB5
   3e/cqac4Hmhs4im7MuQ6J40uyvym3zUGKixoh95eM0b7Qg3J4gbWQWIUI
   /5/sM5ZXSpBVKu0taAVQlJwmvb4fL2afxxF5M64xOl+R5neCPe3U5hwtC
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="291997887"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="291997887"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 08:00:17 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="707780960"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="707780960"
Received: from mrosso-mobl1.ger.corp.intel.com ([10.249.45.244])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 08:00:13 -0800
Date:   Tue, 15 Nov 2022 18:00:11 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Gabriel Somlo <gsomlo@gmail.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, kgugala@antmicro.com,
        mholenko@antmicro.com, joel@jms.id.au,
        david.abdurachmanov@gmail.com, florent@enjoy-digital.fr,
        geert@linux-m68k.org
Subject: Re: [PATCH v3 12/14] serial: liteuart: add IRQ support for the RX
 path
In-Reply-To: <20221112212125.448824-13-gsomlo@gmail.com>
Message-ID: <a914ebd3-5eb8-6c53-3f58-3371fdabf7@linux.intel.com>
References: <20221112212125.448824-1-gsomlo@gmail.com> <20221112212125.448824-13-gsomlo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Nov 2022, Gabriel Somlo wrote:

> Add support for IRQ-driven RX. Support for the TX path will be added
> in a separate commit.
> 
> Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
> ---
>  drivers/tty/serial/liteuart.c | 61 +++++++++++++++++++++++++++++++----
>  1 file changed, 54 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
> index cf1ce597b45e..e30adb30277f 100644
> --- a/drivers/tty/serial/liteuart.c
> +++ b/drivers/tty/serial/liteuart.c
> @@ -6,6 +6,7 @@
>   */
>  
>  #include <linux/console.h>
> +#include <linux/interrupt.h>
>  #include <linux/litex.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> @@ -130,13 +131,29 @@ static void liteuart_rx_chars(struct uart_port *port)
>  	tty_flip_buffer_push(&port->state->port);
>  }
>  
> +static irqreturn_t liteuart_interrupt(int irq, void *data)
> +{
> +	struct liteuart_port *uart = data;
> +	struct uart_port *port = &uart->port;
> +	u8 isr = litex_read8(port->membase + OFF_EV_PENDING);
> +
> +	/* for now, only rx path triggers interrupts */

Please don't add comment like this at all when your series removes it in a 
later patch.

> +	isr &= EV_RX;
> +
> +	spin_lock(&port->lock);
> +	if (isr & EV_RX)
> +		liteuart_rx_chars(port);
> +	spin_unlock(&port->lock);
> +
> +	return IRQ_RETVAL(isr);
> +}
> +
>  static void liteuart_timer(struct timer_list *t)
>  {
>  	struct liteuart_port *uart = from_timer(uart, t, timer);
>  	struct uart_port *port = &uart->port;
>  
> -	liteuart_rx_chars(port);
> -
> +	liteuart_interrupt(0, port);
>  	mod_timer(&uart->timer, jiffies + uart_poll_timeout(port));
>  }
>  
> @@ -162,19 +179,42 @@ static unsigned int liteuart_get_mctrl(struct uart_port *port)
>  static int liteuart_startup(struct uart_port *port)
>  {
>  	struct liteuart_port *uart = to_liteuart_port(port);
> +	int ret;
> +	u8 irq_mask = 0;
>  
> -	/* disable events */
> -	litex_write8(port->membase + OFF_EV_ENABLE, 0);
> +	if (port->irq) {
> +		ret = request_irq(port->irq, liteuart_interrupt, 0,
> +				  KBUILD_MODNAME, uart);
> +		if (ret == 0) {
> +			/* only enable rx interrupts at this time */

This comment seems pretty useless. Your code says very much the same.

-- 
 i.

> +			irq_mask = EV_RX;
> +		} else {
> +			pr_err(pr_fmt("line %d irq %d failed: using polling\n"),
> +				port->line, port->irq);
> +			port->irq = 0;
> +		}
> +	}
>  
> -	/* prepare timer for polling */
> -	timer_setup(&uart->timer, liteuart_timer, 0);
> -	mod_timer(&uart->timer, jiffies + uart_poll_timeout(port));
> +	if (!port->irq) {
> +		timer_setup(&uart->timer, liteuart_timer, 0);
> +		mod_timer(&uart->timer, jiffies + uart_poll_timeout(port));
> +	}
> +
> +	litex_write8(port->membase + OFF_EV_ENABLE, irq_mask);
>  
>  	return 0;
>  }
>  
>  static void liteuart_shutdown(struct uart_port *port)
>  {
> +	struct liteuart_port *uart = to_liteuart_port(port);
> +
> +	litex_write8(port->membase + OFF_EV_ENABLE, 0);
> +
> +	if (port->irq)
> +		free_irq(port->irq, port);
> +	else
> +		del_timer_sync(&uart->timer);
>  }
>  
>  static void liteuart_set_termios(struct uart_port *port, struct ktermios *new,
> @@ -263,6 +303,13 @@ static int liteuart_probe(struct platform_device *pdev)
>  		goto err_erase_id;
>  	}
>  
> +	/* get irq */
> +	ret = platform_get_irq_optional(pdev, 0);
> +	if (ret < 0 && ret != -ENXIO)
> +		return ret;
> +	if (ret > 0)
> +		port->irq = ret;
> +
>  	/* values not from device tree */
>  	port->dev = &pdev->dev;
>  	port->iotype = UPIO_MEM;
> 

