Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2971162F7D6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 15:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241577AbiKROj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 09:39:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242346AbiKROjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 09:39:01 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E2F9DBB0;
        Fri, 18 Nov 2022 06:36:19 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id x18so3499832qki.4;
        Fri, 18 Nov 2022 06:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3yNekkaM54IBN/9Il9peqkckszMXJVwQO0bvHskjSXg=;
        b=pBx0nyYS46s2eCNgZV+XuzvhqDvKHPVb0dYdTm7GNB8p2Kk7LDlWV+/zxnQutGVhdR
         UWKxD5pKTlJjeoj9mmG0xrSHM2t8izVTvGxBFYa64aUn1b00FftRdgajB6iTYfZwMF7v
         y8ssKjNERYa/Pn56fzSiav/mxTT/rSm2zNzU/DPpBDoGboeEogBltLGainINnpuK6CpB
         znrKQegbWqa1drG933n7d9sfLpAfSyECyzARPmZZK2/kmapkC8mga0dKTz7DD3YN28Gy
         KX7wm6xWSmMqqQkEzQfHgz7g7+LJ9gcnP7SyFS44WpHdD1Oo8Ct2+ocHaIymkfahgKV5
         6sIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3yNekkaM54IBN/9Il9peqkckszMXJVwQO0bvHskjSXg=;
        b=iqfpZW64qp68bxwad57/m6eVToiidysB0G0WGpH/OcTa5gmrsvDCFFEcZPhemPmtYd
         x1ORBAHAc7aGM9z6b+PuU6sr0NZtbRObbDkeQC8w13v+t+/aH+MNWnI6ygZjkqeldC+A
         UZuyir5V8yksao7xkZCcg6rybWFehjRbMcwjnsEH5mVQk6mm/KeIbZ+5BUH1P4gcXx4Q
         YEH6sma/uYXIogZsU9hF/SCrVUj6On2rQMNBR9+/hO1Yvfp+xjPA6srhkJBGgTFcPKho
         wzU+f8Olun3v+u0cGkP/qhYKeSCnYqhc49zzT8N7tcBP7GaWTf4N8P8jBjNqbkkhLWUd
         jMkw==
X-Gm-Message-State: ANoB5pldjKuT5wTHvnKmZowrQBT2Z93n4R5MViLSBRusnpg+G2/O9dP/
        eEd7BX8LpsgUyXOE2cfwYMuyI67695yvfA==
X-Google-Smtp-Source: AA0mqf7OElkmp/26mL7Aw84NQIYM21B4YcIiqkJoW4p3zmlYfnCqqHSq+Cnyb38r18TTfazyH1bK3w==
X-Received: by 2002:a05:620a:a10:b0:6fb:a7e6:96e with SMTP id i16-20020a05620a0a1000b006fba7e6096emr5809001qka.675.1668782178103;
        Fri, 18 Nov 2022 06:36:18 -0800 (PST)
Received: from errol.ini.cmu.edu (pool-72-77-81-136.pitbpa.fios.verizon.net. [72.77.81.136])
        by smtp.gmail.com with ESMTPSA id f13-20020a05620a408d00b006bb78d095c5sm2524453qko.79.2022.11.18.06.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 06:36:17 -0800 (PST)
Date:   Fri, 18 Nov 2022 09:36:15 -0500
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
Message-ID: <Y3eYX0qJkDEHhiSF@errol.ini.cmu.edu>
References: <20221116144908.234154-1-gsomlo@gmail.com>
 <20221116144908.234154-13-gsomlo@gmail.com>
 <6629539b-c5a7-4edc-7ab1-5c977f7319@linux.intel.com>
 <Y3eWJNbcGJOMl7K1@errol.ini.cmu.edu>
 <26f43d54-7ee6-d05e-5c1c-4bc37f06077@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <26f43d54-7ee6-d05e-5c1c-4bc37f06077@linux.intel.com>
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

On Fri, Nov 18, 2022 at 04:30:15PM +0200, Ilpo Järvinen wrote:
> On Fri, 18 Nov 2022, Gabriel L. Somlo wrote:
> 
> > On Fri, Nov 18, 2022 at 03:58:47PM +0200, Ilpo Järvinen wrote:
> > > On Wed, 16 Nov 2022, Gabriel Somlo wrote:
> > > 
> > > > Add support for IRQ-driven RX. Support for the TX path will be added
> > > > in a separate commit.
> > > > 
> > > > Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
> > > > ---
> > > > 
> > > > Changes from v3:
> > > >   - add shadow irq register to support polling mode and avoid reading
> > > >     hardware mmio irq register to learn which irq flags are enabled
> > > >     - this also simplifies both liteuart_interrupt() and liteuart_startup()
> > > > 
> > > >  drivers/tty/serial/liteuart.c | 76 +++++++++++++++++++++++++++++++----
> > > >  1 file changed, 69 insertions(+), 7 deletions(-)
> > > > 
> > > > diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
> > > > index 8a6e176be08e..fad778578986 100644
> > > > --- a/drivers/tty/serial/liteuart.c
> > > > +++ b/drivers/tty/serial/liteuart.c
> > > > @@ -7,6 +7,7 @@
> > > >  
> > > >  #include <linux/bits.h>
> > > >  #include <linux/console.h>
> > > > +#include <linux/interrupt.h>
> > > >  #include <linux/litex.h>
> > > >  #include <linux/module.h>
> > > >  #include <linux/of.h>
> > > > @@ -46,6 +47,7 @@ struct liteuart_port {
> > > >  	struct uart_port port;
> > > >  	struct timer_list timer;
> > > >  	u32 id;
> > > > +	u8 irq_reg;
> > > >  };
> > > >  
> > > >  #define to_liteuart_port(port)	container_of(port, struct liteuart_port, port)
> > > > @@ -76,6 +78,19 @@ static void liteuart_putchar(struct uart_port *port, unsigned char ch)
> > > >  	litex_write8(port->membase + OFF_RXTX, ch);
> > > >  }
> > > >  
> > > > +static void liteuart_update_irq_reg(struct uart_port *port, bool set, u8 mask)
> > > > +{
> > > > +	struct liteuart_port *uart = to_liteuart_port(port);
> > > > +
> > > > +	if (set)
> > > > +		uart->irq_reg |= mask;
> > > > +	else
> > > > +		uart->irq_reg &= ~mask;
> > > > +
> > > > +	if (port->irq)
> > > > +		litex_write8(port->membase + OFF_EV_ENABLE, uart->irq_reg);
> > > > +}
> > > > +
> > > >  static void liteuart_stop_tx(struct uart_port *port)
> > > >  {
> > > >  }
> > > > @@ -129,13 +144,27 @@ static void liteuart_rx_chars(struct uart_port *port)
> > > >  	tty_flip_buffer_push(&port->state->port);
> > > >  }
> > > >  
> > > > +static irqreturn_t liteuart_interrupt(int irq, void *data)
> > > > +{
> > > > +	struct liteuart_port *uart = data;
> > > > +	struct uart_port *port = &uart->port;
> > > > +	u8 isr;
> > > > +
> > > > +	spin_lock(&port->lock);
> > > > +	isr = litex_read8(port->membase + OFF_EV_PENDING) & uart->irq_reg;
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
> > > > @@ -161,19 +190,45 @@ static unsigned int liteuart_get_mctrl(struct uart_port *port)
> > > >  static int liteuart_startup(struct uart_port *port)
> > > >  {
> > > >  	struct liteuart_port *uart = to_liteuart_port(port);
> > > > +	unsigned long flags;
> > > > +	int ret;
> > > >  
> > > > -	/* disable events */
> > > > -	litex_write8(port->membase + OFF_EV_ENABLE, 0);
> > > > +	if (port->irq) {
> > > > +		ret = request_irq(port->irq, liteuart_interrupt, 0,
> > > > +				  KBUILD_MODNAME, uart);
> > > > +		if (ret) {
> > > > +			pr_err(pr_fmt("line %d irq %d failed: using polling\n"),
> > > > +				port->line, port->irq);
> > > 
> > > dev_err() seems more appropriate here.
> > 
> > Makes sense, good thing `struct uart_port` has a `dev` field :)
> > I've made the change, and lined it up for the upcoming v5 of the
> > series.
> 
> Also that pr_fmt() should be dropped (in case you didn't already). It was 
> in my mind ealier but should have stated it explicitly.

Understood. I've used dev_err() before, it just slipped my mind to
check for the availability of a `dev` field in `struct uart_port`...  :)

Thanks again for the review!

Best,
--Gabriel
