Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8203762F6B3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 14:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242010AbiKRN65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 08:58:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241523AbiKRN6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 08:58:54 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27196261;
        Fri, 18 Nov 2022 05:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668779933; x=1700315933;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=nShZpoZFoRHWgmSg5gh/suMCBijJSZAQGCwKIphVewU=;
  b=ZzXyt/H28ZUXAx50wKeRUJFhbhAHANkj3EjrEUvrwcxHG/G+gkd8OvH9
   Jnv8SV+Uv0sbMgM1xEnuL62fQ/hCziI/WFZsNuCeJQWQ6iNgRoUrS8uaR
   GLfXCDSWbhwAZ0BjQIQsA3H6CdeScSFFV28odmT1rB5kfXqExTPjfRtJL
   RgbCJfryb1hpCnf2Dd4V+HWi/nZicVSCZ5W1piHRPPGVX2pGzGDzFWZ7I
   c+w3894D1ZXeprU6KN3J2dsYm+KoeTlXXn6Rplz7vEBolP00KRofHkRxy
   zuiqUM+dhU9f3nPhTsNAEG9PwPxQ88FS7pk54yoVy0PxfqG1OdPS6pZ7d
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="375271128"
X-IronPort-AV: E=Sophos;i="5.96,174,1665471600"; 
   d="scan'208";a="375271128"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 05:58:52 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="640217830"
X-IronPort-AV: E=Sophos;i="5.96,174,1665471600"; 
   d="scan'208";a="640217830"
Received: from amulyuko-mobl1.ccr.corp.intel.com ([10.252.35.83])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 05:58:49 -0800
Date:   Fri, 18 Nov 2022 15:58:47 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Gabriel Somlo <gsomlo@gmail.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, kgugala@antmicro.com,
        mholenko@antmicro.com, joel@jms.id.au,
        david.abdurachmanov@gmail.com, florent@enjoy-digital.fr,
        geert@linux-m68k.org
Subject: Re: [PATCH v4 12/14] serial: liteuart: add IRQ support for the RX
 path
In-Reply-To: <20221116144908.234154-13-gsomlo@gmail.com>
Message-ID: <6629539b-c5a7-4edc-7ab1-5c977f7319@linux.intel.com>
References: <20221116144908.234154-1-gsomlo@gmail.com> <20221116144908.234154-13-gsomlo@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-651772109-1668779933=:3952"
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

--8323329-651772109-1668779933=:3952
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Wed, 16 Nov 2022, Gabriel Somlo wrote:

> Add support for IRQ-driven RX. Support for the TX path will be added
> in a separate commit.
> 
> Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
> ---
> 
> Changes from v3:
>   - add shadow irq register to support polling mode and avoid reading
>     hardware mmio irq register to learn which irq flags are enabled
>     - this also simplifies both liteuart_interrupt() and liteuart_startup()
> 
>  drivers/tty/serial/liteuart.c | 76 +++++++++++++++++++++++++++++++----
>  1 file changed, 69 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
> index 8a6e176be08e..fad778578986 100644
> --- a/drivers/tty/serial/liteuart.c
> +++ b/drivers/tty/serial/liteuart.c
> @@ -7,6 +7,7 @@
>  
>  #include <linux/bits.h>
>  #include <linux/console.h>
> +#include <linux/interrupt.h>
>  #include <linux/litex.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> @@ -46,6 +47,7 @@ struct liteuart_port {
>  	struct uart_port port;
>  	struct timer_list timer;
>  	u32 id;
> +	u8 irq_reg;
>  };
>  
>  #define to_liteuart_port(port)	container_of(port, struct liteuart_port, port)
> @@ -76,6 +78,19 @@ static void liteuart_putchar(struct uart_port *port, unsigned char ch)
>  	litex_write8(port->membase + OFF_RXTX, ch);
>  }
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
>  static void liteuart_stop_tx(struct uart_port *port)
>  {
>  }
> @@ -129,13 +144,27 @@ static void liteuart_rx_chars(struct uart_port *port)
>  	tty_flip_buffer_push(&port->state->port);
>  }
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
> @@ -161,19 +190,45 @@ static unsigned int liteuart_get_mctrl(struct uart_port *port)
>  static int liteuart_startup(struct uart_port *port)
>  {
>  	struct liteuart_port *uart = to_liteuart_port(port);
> +	unsigned long flags;
> +	int ret;
>  
> -	/* disable events */
> -	litex_write8(port->membase + OFF_EV_ENABLE, 0);
> +	if (port->irq) {
> +		ret = request_irq(port->irq, liteuart_interrupt, 0,
> +				  KBUILD_MODNAME, uart);
> +		if (ret) {
> +			pr_err(pr_fmt("line %d irq %d failed: using polling\n"),
> +				port->line, port->irq);

dev_err() seems more appropriate here.

> +			port->irq = 0;
> +		}
> +	}
>  
> -	/* prepare timer for polling */
> -	timer_setup(&uart->timer, liteuart_timer, 0);
> -	mod_timer(&uart->timer, jiffies + uart_poll_timeout(port));
> +	spin_lock_irqsave(&port->lock, flags);
> +	/* only enabling rx irqs during startup */
> +	liteuart_update_irq_reg(port, true, EV_RX);
> +	spin_unlock_irqrestore(&port->lock, flags);
> +
> +	if (!port->irq) {
> +		timer_setup(&uart->timer, liteuart_timer, 0);
> +		mod_timer(&uart->timer, jiffies + uart_poll_timeout(port));
> +	}
>  
>  	return 0;
>  }
>  
>  static void liteuart_shutdown(struct uart_port *port)
>  {
> +	struct liteuart_port *uart = to_liteuart_port(port);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&port->lock, flags);
> +	liteuart_update_irq_reg(port, false, EV_RX | EV_TX);
> +	spin_unlock_irqrestore(&port->lock, flags);
> +
> +	if (port->irq)
> +		free_irq(port->irq, port);
> +	else
> +		del_timer_sync(&uart->timer);
>  }
>  
>  static void liteuart_set_termios(struct uart_port *port, struct ktermios *new,
> @@ -262,6 +317,13 @@ static int liteuart_probe(struct platform_device *pdev)
>  		goto err_erase_id;
>  	}
>  
> +	/* get irq */

This comment is unnecessary.

Other than that,

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.


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

--8323329-651772109-1668779933=:3952--
