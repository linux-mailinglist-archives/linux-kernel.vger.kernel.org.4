Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5731962F744
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 15:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242314AbiKRO0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 09:26:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241141AbiKRO0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 09:26:49 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D59EE36;
        Fri, 18 Nov 2022 06:26:48 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id e15so3188816qts.1;
        Fri, 18 Nov 2022 06:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LLJ5hiMahBs42tRc4ZcxhTLQtIQB1cxCZHS3KM00ArA=;
        b=AcfQWQqdBaN6wkIOjLcnqVsHJ08gTPdrnkzW9Hl9+toXv0o/z01buxA0JU0afdQZA/
         d8gEV7l7L5yFj2Ux9Gh4UTlH7xTTPspIHzVt/XDNzSoD1L7xY8DwHMQNbZxR3ljDgm+Z
         2gIacWbEEJogEL04k0A2f+1g2YEYuLpUagv/7l628cGqKIgbrm1/63YMhAUZFkr83bb9
         VC4hbGEhi5GG5/eXdI/peGXxUjv/yrE+t164paMeZ6WNECgDmxLGTdOWM1Iy7j/9/0Pk
         f6iXLbthKiJ8BhZElOIHgRaDKMWGE61zvRX9Hu1QDTmqcp0ZUPResU2qoGSzvkv1KInp
         IHrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LLJ5hiMahBs42tRc4ZcxhTLQtIQB1cxCZHS3KM00ArA=;
        b=aK2DCl3ksjoqA/XXBVzx/CF/Qphn7YYIx0wZ4ePREHhQpYoZXGs655weDrKUjpBIDr
         yIhSOuyB9GFaDDzynGozKCmKMZ/u3I8L77Z9BejqcpkPGYO7TKINs/b1NR0cJSmdPgiZ
         FGuccfmTfRudioAh2+4sSn0SZ9xrHqwXEdt2JMnvNSKn+cUujNb5j6o3cSDfCuBIjpBJ
         DrhIjMrvFBQGXZwoydm8BLtl0twjdOKpmILw7IKU8LhKWqwbHNb2vbhuOVDSLG9nfUxX
         JY8AzfOv8HyDSnFIqfrB2UpjJ51RU4uAVOHbTJVn1vW7CU4Xenr5lu/nvW/IcFm2cx1Q
         /9UA==
X-Gm-Message-State: ANoB5pmr7EUDjISlvpCNPUl2kzzNOz3P9IzDD+gTZL0lYkEwo5imbLc2
        2GODHT8aEpb70hqvGHebz64=
X-Google-Smtp-Source: AA0mqf6Vmsb4ZD8xXdhak93vvFR+mVq0plYvAIJ/Lj0L/mwLmYOkUQTiWGEE3WgcRDmal7tmPQEbBQ==
X-Received: by 2002:ac8:4d06:0:b0:3a5:95cc:70e2 with SMTP id w6-20020ac84d06000000b003a595cc70e2mr6714116qtv.293.1668781607198;
        Fri, 18 Nov 2022 06:26:47 -0800 (PST)
Received: from errol.ini.cmu.edu (pool-72-77-81-136.pitbpa.fios.verizon.net. [72.77.81.136])
        by smtp.gmail.com with ESMTPSA id y28-20020a37f61c000000b006fa22f0494bsm2379695qkj.117.2022.11.18.06.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 06:26:46 -0800 (PST)
Date:   Fri, 18 Nov 2022 09:26:44 -0500
From:   "Gabriel L. Somlo" <gsomlo@gmail.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, kgugala@antmicro.com,
        mholenko@antmicro.com, joel@jms.id.au,
        david.abdurachmanov@gmail.com, florent@enjoy-digital.fr,
        geert@linux-m68k.org
Subject: Re: [PATCH v4 12/14] serial: liteuart: add IRQ support for the RX
 path
Message-ID: <Y3eWJNbcGJOMl7K1@errol.ini.cmu.edu>
References: <20221116144908.234154-1-gsomlo@gmail.com>
 <20221116144908.234154-13-gsomlo@gmail.com>
 <6629539b-c5a7-4edc-7ab1-5c977f7319@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6629539b-c5a7-4edc-7ab1-5c977f7319@linux.intel.com>
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

On Fri, Nov 18, 2022 at 03:58:47PM +0200, Ilpo Järvinen wrote:
> On Wed, 16 Nov 2022, Gabriel Somlo wrote:
> 
> > Add support for IRQ-driven RX. Support for the TX path will be added
> > in a separate commit.
> > 
> > Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
> > ---
> > 
> > Changes from v3:
> >   - add shadow irq register to support polling mode and avoid reading
> >     hardware mmio irq register to learn which irq flags are enabled
> >     - this also simplifies both liteuart_interrupt() and liteuart_startup()
> > 
> >  drivers/tty/serial/liteuart.c | 76 +++++++++++++++++++++++++++++++----
> >  1 file changed, 69 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
> > index 8a6e176be08e..fad778578986 100644
> > --- a/drivers/tty/serial/liteuart.c
> > +++ b/drivers/tty/serial/liteuart.c
> > @@ -7,6 +7,7 @@
> >  
> >  #include <linux/bits.h>
> >  #include <linux/console.h>
> > +#include <linux/interrupt.h>
> >  #include <linux/litex.h>
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> > @@ -46,6 +47,7 @@ struct liteuart_port {
> >  	struct uart_port port;
> >  	struct timer_list timer;
> >  	u32 id;
> > +	u8 irq_reg;
> >  };
> >  
> >  #define to_liteuart_port(port)	container_of(port, struct liteuart_port, port)
> > @@ -76,6 +78,19 @@ static void liteuart_putchar(struct uart_port *port, unsigned char ch)
> >  	litex_write8(port->membase + OFF_RXTX, ch);
> >  }
> >  
> > +static void liteuart_update_irq_reg(struct uart_port *port, bool set, u8 mask)
> > +{
> > +	struct liteuart_port *uart = to_liteuart_port(port);
> > +
> > +	if (set)
> > +		uart->irq_reg |= mask;
> > +	else
> > +		uart->irq_reg &= ~mask;
> > +
> > +	if (port->irq)
> > +		litex_write8(port->membase + OFF_EV_ENABLE, uart->irq_reg);
> > +}
> > +
> >  static void liteuart_stop_tx(struct uart_port *port)
> >  {
> >  }
> > @@ -129,13 +144,27 @@ static void liteuart_rx_chars(struct uart_port *port)
> >  	tty_flip_buffer_push(&port->state->port);
> >  }
> >  
> > +static irqreturn_t liteuart_interrupt(int irq, void *data)
> > +{
> > +	struct liteuart_port *uart = data;
> > +	struct uart_port *port = &uart->port;
> > +	u8 isr;
> > +
> > +	spin_lock(&port->lock);
> > +	isr = litex_read8(port->membase + OFF_EV_PENDING) & uart->irq_reg;
> > +	if (isr & EV_RX)
> > +		liteuart_rx_chars(port);
> > +	spin_unlock(&port->lock);
> > +
> > +	return IRQ_RETVAL(isr);
> > +}
> > +
> >  static void liteuart_timer(struct timer_list *t)
> >  {
> >  	struct liteuart_port *uart = from_timer(uart, t, timer);
> >  	struct uart_port *port = &uart->port;
> >  
> > -	liteuart_rx_chars(port);
> > -
> > +	liteuart_interrupt(0, port);
> >  	mod_timer(&uart->timer, jiffies + uart_poll_timeout(port));
> >  }
> >  
> > @@ -161,19 +190,45 @@ static unsigned int liteuart_get_mctrl(struct uart_port *port)
> >  static int liteuart_startup(struct uart_port *port)
> >  {
> >  	struct liteuart_port *uart = to_liteuart_port(port);
> > +	unsigned long flags;
> > +	int ret;
> >  
> > -	/* disable events */
> > -	litex_write8(port->membase + OFF_EV_ENABLE, 0);
> > +	if (port->irq) {
> > +		ret = request_irq(port->irq, liteuart_interrupt, 0,
> > +				  KBUILD_MODNAME, uart);
> > +		if (ret) {
> > +			pr_err(pr_fmt("line %d irq %d failed: using polling\n"),
> > +				port->line, port->irq);
> 
> dev_err() seems more appropriate here.

Makes sense, good thing `struct uart_port` has a `dev` field :)
I've made the change, and lined it up for the upcoming v5 of the
series.
 
> > +			port->irq = 0;
> > +		}
> > +	}
> >  
> > -	/* prepare timer for polling */
> > -	timer_setup(&uart->timer, liteuart_timer, 0);
> > -	mod_timer(&uart->timer, jiffies + uart_poll_timeout(port));
> > +	spin_lock_irqsave(&port->lock, flags);
> > +	/* only enabling rx irqs during startup */
> > +	liteuart_update_irq_reg(port, true, EV_RX);
> > +	spin_unlock_irqrestore(&port->lock, flags);
> > +
> > +	if (!port->irq) {
> > +		timer_setup(&uart->timer, liteuart_timer, 0);
> > +		mod_timer(&uart->timer, jiffies + uart_poll_timeout(port));
> > +	}
> >  
> >  	return 0;
> >  }
> >  
> >  static void liteuart_shutdown(struct uart_port *port)
> >  {
> > +	struct liteuart_port *uart = to_liteuart_port(port);
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&port->lock, flags);
> > +	liteuart_update_irq_reg(port, false, EV_RX | EV_TX);
> > +	spin_unlock_irqrestore(&port->lock, flags);
> > +
> > +	if (port->irq)
> > +		free_irq(port->irq, port);
> > +	else
> > +		del_timer_sync(&uart->timer);
> >  }
> >  
> >  static void liteuart_set_termios(struct uart_port *port, struct ktermios *new,
> > @@ -262,6 +317,13 @@ static int liteuart_probe(struct platform_device *pdev)
> >  		goto err_erase_id;
> >  	}
> >  
> > +	/* get irq */
> 
> This comment is unnecessary.

Removed in v5.

> Other than that,
> 
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Thanks much, I'll send out v5 a bit later today.

--Gabriel

> -- 
>  i.
> 
> 
> > +	ret = platform_get_irq_optional(pdev, 0);
> > +	if (ret < 0 && ret != -ENXIO)
> > +		return ret;
> > +	if (ret > 0)
> > +		port->irq = ret;
> > +
> >  	/* values not from device tree */
> >  	port->dev = &pdev->dev;
> >  	port->iotype = UPIO_MEM;
> > 

