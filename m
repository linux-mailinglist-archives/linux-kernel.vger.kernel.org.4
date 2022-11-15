Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C8062A00C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 18:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbiKOROG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 12:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbiKOROB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 12:14:01 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF00DE8D;
        Tue, 15 Nov 2022 09:13:57 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id z1so9908965qkl.9;
        Tue, 15 Nov 2022 09:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=36kVz+TOQy7DhDBy6CrLLD6aGpSobgzvfFtjbhVF3jE=;
        b=daeYyOrtBiwAnWa2uRoH9E/idWtDydpcfjwQoyC0KfkjpgeRZt9oBBHDtzrxPPv2q/
         4wTi/bvonlHxS+dlIFzNZo2VBN5KEwgmMjXRgHtpcOUoxCVJp6rBuGy8QKHRFPyiMvhC
         Lib2jaHX+xrj/ofhQ3KTm9NcSkJVm5WZdBlvFzShCwoSSyqXi84swOmE8uvPvaxVAU7d
         gM23HRjKrT2imLL0vvH1XHUFrA1sFQ+9zYYufPvNCYEvrseQPWG8yT+njOMPaftEU9vy
         lHloM2wrmclbduQygF+NzPFfOE2RQ6rKcAZ1fxP9fkEpjtgRCrnXbxdkXpOmvB5cDIBg
         WNrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=36kVz+TOQy7DhDBy6CrLLD6aGpSobgzvfFtjbhVF3jE=;
        b=2nIqgjuuEu0lGionatiB0RUYe1490cXdm45zYeVdNgLEAuz+ZCTXNkVACGoOf9JRU4
         1hcT1f6u6RXccFP6LJkoro2bwMRSYRRqCpb7sR7vH8lFhhtf9sLMfq2UCajw48bzBJVu
         xdpluBS16oV0ljjpw1FOYQ96VE8KcG3sC3obankdfh/7C1Qaa1UqKPlJWwKxC0ymtqf/
         7FlqDObvBXu4IAUaSk87X8QUTEgFtLQKpGu5Rbl4dhX2NO78rGF3F4iLFGXkctSKq2NP
         dcdk424MoNUS6w0gbqOS9XxDTSB3WiXycLY/pZq686Ky7UTiRz2kH4mNJW5c2EgDK7EM
         we1Q==
X-Gm-Message-State: ANoB5pkKAhakFbYOT428etCbsd/f0SreqnTaezisRZGVvkCC19dtPg+A
        YraUQbyhLqmzCBFcYgTJlHyBosGhZCbJ5Q==
X-Google-Smtp-Source: AA0mqf5TAxsy6t9xXX4HdJRwLXbeHzAzbwl3wU/FhtDH4LRklYvVf592HwbeqeEEMCYXFJWRN6q5kQ==
X-Received: by 2002:a05:620a:199d:b0:6fa:e099:bc12 with SMTP id bm29-20020a05620a199d00b006fae099bc12mr16358396qkb.308.1668532436915;
        Tue, 15 Nov 2022 09:13:56 -0800 (PST)
Received: from errol.ini.cmu.edu (pool-72-77-81-136.pitbpa.fios.verizon.net. [72.77.81.136])
        by smtp.gmail.com with ESMTPSA id u16-20020a05620a0c5000b006cfc7f9eea0sm8505731qki.122.2022.11.15.09.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 09:13:56 -0800 (PST)
Date:   Tue, 15 Nov 2022 12:13:54 -0500
From:   "Gabriel L. Somlo" <gsomlo@gmail.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, kgugala@antmicro.com,
        mholenko@antmicro.com, joel@jms.id.au,
        david.abdurachmanov@gmail.com, florent@enjoy-digital.fr,
        geert@linux-m68k.org
Subject: Re: [PATCH v3 13/14] serial: liteuart: add IRQ support for the TX
 path
Message-ID: <Y3PI0gP0vnmYTmZK@errol.ini.cmu.edu>
References: <20221112212125.448824-1-gsomlo@gmail.com>
 <20221112212125.448824-14-gsomlo@gmail.com>
 <957056a1-78a5-1141-18d7-b49f87fa85f0@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <957056a1-78a5-1141-18d7-b49f87fa85f0@linux.intel.com>
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

On Tue, Nov 15, 2022 at 06:14:50PM +0200, Ilpo Järvinen wrote:
> On Sat, 12 Nov 2022, Gabriel Somlo wrote:
> 
> > Modify the TX path to operate in an IRQ-compatible way, while
> > maintaining support for polling mode via the poll timer.
> > 
> > Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
> > ---
> >  drivers/tty/serial/liteuart.c | 67 ++++++++++++++++++++++++-----------
> >  1 file changed, 47 insertions(+), 20 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
> > index e30adb30277f..307c27398e30 100644
> > --- a/drivers/tty/serial/liteuart.c
> > +++ b/drivers/tty/serial/liteuart.c
> > @@ -46,6 +46,7 @@ struct liteuart_port {
> >  	struct uart_port port;
> >  	struct timer_list timer;
> >  	u32 id;
> > +	bool poll_tx_started;
> >  };
> >  
> >  #define to_liteuart_port(port)	container_of(port, struct liteuart_port, port)
> > @@ -78,29 +79,24 @@ static void liteuart_putchar(struct uart_port *port, unsigned char ch)
> >  
> >  static void liteuart_stop_tx(struct uart_port *port)
> >  {
> > -	/* not used in LiteUART, but called unconditionally from serial_core */
> 
> Drop this comment from the earlier patch too given you remove it here. It 
> just adds useless churn in diff for no useful reason.

Right -- I already had this lined up for v4 :)
 
> > +	if (port->irq) {
> > +		u8 irq_mask = litex_read8(port->membase + OFF_EV_ENABLE);
> > +		litex_write8(port->membase + OFF_EV_ENABLE, irq_mask & ~EV_TX);
> 
> If you put irq_mask into liteuart_port you wouldn't need to read it 
> back here?

So, instead of `bool poll_tx_started` I should just keep a copy of the
irq_mask there, and take `&port->lock` whenever I need to *both* update
the mask *and* write it out to the actual device register?

> > +	} else {
> > +		struct liteuart_port *uart = to_liteuart_port(port);
> > +		uart->poll_tx_started = false;
> > +	}
> >  }
> >  
> >  static void liteuart_start_tx(struct uart_port *port)
> >  {
> > -	struct circ_buf *xmit = &port->state->xmit;
> > -	unsigned char ch;
> > -
> > -	if (unlikely(port->x_char)) {
> > -		litex_write8(port->membase + OFF_RXTX, port->x_char);
> > -		port->icount.tx++;
> > -		port->x_char = 0;
> > -	} else if (!uart_circ_empty(xmit)) {
> > -		while (xmit->head != xmit->tail) {
> > -			ch = xmit->buf[xmit->tail];
> > -			xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
> > -			port->icount.tx++;
> 
> This is not based on tty-next tree. Please rebase on top of it (you 
> might have noted it already, IIRC, somebody noted uart_xmit_advance
> conflict in some patch, perhaps it was you :-)).

Yeah, I did notice that right after I sent out v3. I've already
rebased it on top of your patch using uart_xmit_advance.

> > -			liteuart_putchar(port, ch);
> > -		}
> > +	if (port->irq) {
> > +		u8 irq_mask = litex_read8(port->membase + OFF_EV_ENABLE);
> > +		litex_write8(port->membase + OFF_EV_ENABLE, irq_mask | EV_TX);
> 
> ->irq_mask?

I'll switch to s/bool poll_tx_started/u8 irq_mask/g in v4, hopefully
it should make it all look cleaner.

> > +	} else {
> > +		struct liteuart_port *uart = to_liteuart_port(port);
> > +		uart->poll_tx_started = true;
> >  	}
> > -
> > -	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> > -		uart_write_wakeup(port);
> >  }
> >  
> >  static void liteuart_stop_rx(struct uart_port *port)
> > @@ -131,18 +127,47 @@ static void liteuart_rx_chars(struct uart_port *port)
> >  	tty_flip_buffer_push(&port->state->port);
> >  }
> >  
> > +static void liteuart_tx_chars(struct uart_port *port)
> > +{
> > +	struct circ_buf *xmit = &port->state->xmit;
> > +
> > +	if (unlikely(port->x_char)) {
> > +		litex_write8(port->membase + OFF_RXTX, port->x_char);
> > +		port->x_char = 0;
> > +		port->icount.tx++;
> > +		return;
> > +	}
> > +
> > +	while (!litex_read8(port->membase + OFF_TXFULL)) {
> > +		if (xmit->head == xmit->tail)
> 
> There exists a helper for this condition.

Is that in the released linus tree, or still only in tty-next?

> > +			break;
> > +		litex_write8(port->membase + OFF_RXTX, xmit->buf[xmit->tail]);
> > +		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
> > +		port->icount.tx++;
> 
> uart_xmit_advance()

Already lined up for v4.

> 
> > +	}
> > +
> > +	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> > +		uart_write_wakeup(port);
> > +
> > +	if (uart_circ_empty(xmit))
> > +		liteuart_stop_tx(port);
> > +}
> 
> You might want to check if you can generate this whole function with 
> Jiri's tx helpers (IIRC, they're only in tty-next tree currently).

Looks like I should switch to tty-next for this whole series, which
makes sense, since it's a tty I'm working on :)

I'll rebase on top of that before I send out v4, hopefully later this
afternoon.
 
> > +
> >  static irqreturn_t liteuart_interrupt(int irq, void *data)
> >  {
> >  	struct liteuart_port *uart = data;
> >  	struct uart_port *port = &uart->port;
> >  	u8 isr = litex_read8(port->membase + OFF_EV_PENDING);
> >  
> > -	/* for now, only rx path triggers interrupts */
> > -	isr &= EV_RX;
> > +	if (!(port->irq || uart->poll_tx_started))
> > +		isr &= ~EV_TX;	/* polling mode with tx stopped */
> >  
> >  	spin_lock(&port->lock);
> >  	if (isr & EV_RX)
> >  		liteuart_rx_chars(port);
> > +	if (isr & EV_TX) {
> > +		liteuart_tx_chars(port);
> > +	}
> 
> Extra braces.

Got it, thanks!

> >  	spin_unlock(&port->lock);
> >  
> >  	return IRQ_RETVAL(isr);
> > @@ -196,6 +221,7 @@ static int liteuart_startup(struct uart_port *port)
> >  	}
> >  
> >  	if (!port->irq) {
> > +		uart->poll_tx_started = false;
> 
> Can poll_tx_started ever be true here?

Proably not, but it shouldn't matter if I switch to using `u8 irq_mask`,
instead, which should be initialized to 0 during probe().

Thanks again for the feedback!

Best,
--Gabriel

> >  		timer_setup(&uart->timer, liteuart_timer, 0);
> >  		mod_timer(&uart->timer, jiffies + uart_poll_timeout(port));
> >  	}
> > @@ -210,6 +236,7 @@ static void liteuart_shutdown(struct uart_port *port)
> >  	struct liteuart_port *uart = to_liteuart_port(port);
> >  
> >  	litex_write8(port->membase + OFF_EV_ENABLE, 0);
> > +	uart->poll_tx_started = false;
> >  
> >  	if (port->irq)
> >  		free_irq(port->irq, port);
> > 
> 
> -- 
>  i.
> 
