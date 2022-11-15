Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44EC3629EFA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 17:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238636AbiKOQ0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 11:26:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238381AbiKOQ0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 11:26:10 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5457FD12D;
        Tue, 15 Nov 2022 08:26:08 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id 8so9830212qka.1;
        Tue, 15 Nov 2022 08:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a9IhxCF1cAeyewI8SYiOpvZjTk66VUbn+seWVTa9bhw=;
        b=mykMIgeniufSLJ9cmo0MZyWqwIjhiClWIOtoujOie6LEb8/+QUhRlgYgQnms1lA7+s
         VQ8XwZPFzTX4/ELERle39zxKRBeX2JXh/UwOZ8ZcGZ/hXWOEcK6+W0xu0sQ39zEYD94y
         qzALW4knzggQGfxQvbIBwpEMZJaxk+oPlmmjSRGBum4Qrl5kYyvWjz2v2W18xxkDe3Lp
         U6Oj8Yt9b+T3ymz6ZOgqF/mfBFNgclKlPJfo2ga8w6WHlCPStF8IKyIoPuuUgvi+5qB2
         bxjMFcPOxn0YP46gbCWCvjcjSRt7BbDbuGb/9rS8saJrqa6q7uU+11I5Q56T1eX8KOdp
         wS9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a9IhxCF1cAeyewI8SYiOpvZjTk66VUbn+seWVTa9bhw=;
        b=BOu7sUjzMr0NU4+U+KxZv2ZuWTK0JSthCM6JbBDqovhQ2Q8iVbgC70Mu1FD5Dw4QQP
         Kfmgv4F44QvZ0tLiLH/ClbXhDuS4vP5PzRY67y+BcEMzr7jAL2jk58dJebldYQiSW7+Q
         2H2IgWBarnDsOpQs8RM2J8A69gPpQwTVRwVzmH0iVTFG2X0OSQfedAlqh6m4ylEsd9QD
         RO1W+loLlZFoImbetQdX5uVo6sPG3fFU/Jgi7S+akL3oYuLh/fF+bJiuhpl25/kIZ5ba
         wCohxgWRY3Bw6Hk5FwCdldytKMbA5tTLA4VVaJyYq+VOscvDXYTUbAt6I2E3a2+w6HAA
         +c2Q==
X-Gm-Message-State: ANoB5pmOwqgGNGskxdwpe1J5cX0VvGzkfILRpg2Y6tsThG0qJWbJTQZm
        HLjA0TWNh7orbFWMN6l/vOM=
X-Google-Smtp-Source: AA0mqf4nG5AWGXxrB9xBsaq2mJWE00q21VzciHsLwLRgvhGMU+WTheBsbXZ+2iO5iF39OKFCzAsETA==
X-Received: by 2002:a05:620a:1d0d:b0:6f9:c2be:a89 with SMTP id dl13-20020a05620a1d0d00b006f9c2be0a89mr15912566qkb.437.1668529567455;
        Tue, 15 Nov 2022 08:26:07 -0800 (PST)
Received: from errol.ini.cmu.edu (pool-72-77-81-136.pitbpa.fios.verizon.net. [72.77.81.136])
        by smtp.gmail.com with ESMTPSA id s8-20020a05620a254800b006fa16fe93bbsm8449105qko.15.2022.11.15.08.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 08:26:07 -0800 (PST)
Date:   Tue, 15 Nov 2022 11:26:05 -0500
From:   "Gabriel L. Somlo" <gsomlo@gmail.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, kgugala@antmicro.com,
        mholenko@antmicro.com, joel@jms.id.au,
        david.abdurachmanov@gmail.com, florent@enjoy-digital.fr,
        geert@linux-m68k.org
Subject: Re: [PATCH v3 12/14] serial: liteuart: add IRQ support for the RX
 path
Message-ID: <Y3O9nfeyEXxhsmA5@errol.ini.cmu.edu>
References: <20221112212125.448824-1-gsomlo@gmail.com>
 <20221112212125.448824-13-gsomlo@gmail.com>
 <a914ebd3-5eb8-6c53-3f58-3371fdabf7@linux.intel.com>
 <Y3O7AKVuY3/n6I5K@errol.ini.cmu.edu>
 <7b5042be-8061-d4f4-43b5-75a5ad6dbcb0@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7b5042be-8061-d4f4-43b5-75a5ad6dbcb0@linux.intel.com>
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

On Tue, Nov 15, 2022 at 06:21:00PM +0200, Ilpo Järvinen wrote:
> On Tue, 15 Nov 2022, Gabriel L. Somlo wrote:
> 
> > On Tue, Nov 15, 2022 at 06:00:11PM +0200, Ilpo Järvinen wrote:
> > > On Sat, 12 Nov 2022, Gabriel Somlo wrote:
> > > 
> > > > Add support for IRQ-driven RX. Support for the TX path will be added
> > > > in a separate commit.
> > > > 
> > > > Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
> > > > ---
> > > >  drivers/tty/serial/liteuart.c | 61 +++++++++++++++++++++++++++++++----
> > > >  1 file changed, 54 insertions(+), 7 deletions(-)
> > > > 
> > > > diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
> > > > index cf1ce597b45e..e30adb30277f 100644
> > > > --- a/drivers/tty/serial/liteuart.c
> > > > +++ b/drivers/tty/serial/liteuart.c
> > > > @@ -6,6 +6,7 @@
> > > >   */
> > > >  
> > > >  #include <linux/console.h>
> > > > +#include <linux/interrupt.h>
> > > >  #include <linux/litex.h>
> > > >  #include <linux/module.h>
> > > >  #include <linux/of.h>
> > > > @@ -130,13 +131,29 @@ static void liteuart_rx_chars(struct uart_port *port)
> > > >  	tty_flip_buffer_push(&port->state->port);
> > > >  }
> > > >  
> > > > +static irqreturn_t liteuart_interrupt(int irq, void *data)
> > > > +{
> > > > +	struct liteuart_port *uart = data;
> > > > +	struct uart_port *port = &uart->port;
> > > > +	u8 isr = litex_read8(port->membase + OFF_EV_PENDING);
> > > > +
> > > > +	/* for now, only rx path triggers interrupts */
> > > 
> > > Please don't add comment like this at all when your series removes it in a 
> > > later patch.
> > 
> > OK, I will remove it in v4.
> > 
> > > > +	isr &= EV_RX;
> > > > +
> > > > +	spin_lock(&port->lock);
> > > > +	if (isr & EV_RX)
> > > > +		liteuart_rx_chars(port);
> > > > +	spin_unlock(&port->lock);
> > > > +
> > > > +	return IRQ_RETVAL(isr);
> > > > +}
> > > > +
> > > >  static void liteuart_timer(struct timer_list *t)
> > > >  {
> > > >  	struct liteuart_port *uart = from_timer(uart, t, timer);
> > > >  	struct uart_port *port = &uart->port;
> > > >  
> > > > -	liteuart_rx_chars(port);
> > > > -
> > > > +	liteuart_interrupt(0, port);
> > > >  	mod_timer(&uart->timer, jiffies + uart_poll_timeout(port));
> > > >  }
> > > >  
> > > > @@ -162,19 +179,42 @@ static unsigned int liteuart_get_mctrl(struct uart_port *port)
> > > >  static int liteuart_startup(struct uart_port *port)
> > > >  {
> > > >  	struct liteuart_port *uart = to_liteuart_port(port);
> > > > +	int ret;
> > > > +	u8 irq_mask = 0;
> > > >  
> > > > -	/* disable events */
> > > > -	litex_write8(port->membase + OFF_EV_ENABLE, 0);
> > > > +	if (port->irq) {
> > > > +		ret = request_irq(port->irq, liteuart_interrupt, 0,
> > > > +				  KBUILD_MODNAME, uart);
> > > > +		if (ret == 0) {
> > > > +			/* only enable rx interrupts at this time */
> > > 
> > > This comment seems pretty useless. Your code says very much the same.
> > 
> > The comment was meant to let the reader know that the code is doing it
> > *intentionally* (rather than forgetting to enable tx irqs by mistake).
> > But I'm OK with removing this comment in v4 as well if you think
> > that's an overly paranoid and redundant thing to do... :)
> 
> I see. Reading the other comment first caused me to misinterpret this one 
> to mean that only RX interrupts are implemented.
> 
> Maybe if you change "at this time" to "at startup" it would make it more 
> obvious.
 
OK, I'll fix the comment per your suggestion rather than get rid of it.

Thanks again,
--G

> -- 
>  i.

