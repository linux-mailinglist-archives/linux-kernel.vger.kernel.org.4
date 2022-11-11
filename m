Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18C5626001
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 18:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233750AbiKKRGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 12:06:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiKKRGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 12:06:45 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40EED729A8;
        Fri, 11 Nov 2022 09:06:44 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id lf15so3700151qvb.9;
        Fri, 11 Nov 2022 09:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sXx3A05HJYEyorjvDLtzFzGsbPsAQOKVKTmCTm5nngs=;
        b=LuoA2pzCpw3gU/2r/tNIjIqgohEuAWvxyozzM9Drqh8Mde8xAAnF0WmplIEIghqONO
         KYnfeNt6UQ31fRt5WYs8UfGHKL2s+pf5pLzoZEBQmepZidwncGU2sE+wKqv6r6U+q0Xx
         VkAGbZCEbaOP7fMixM7RfDma1p82fIgFP31FWOBO1xV1gp3ElnExn6kyQgNOdus3FHNp
         /Jj6mLyU5fpREeAAp3IhkmU2wv86iOu46hvinkuyG+C3Ugg99tM824KNzC5ylZWmK/BL
         x2jjMkpRn+TXxvxdlFa87pwtSwg3fjyvxYgfPH+FD1IWUEzCYtOIrSxsevdZb/H/mox1
         Ze1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sXx3A05HJYEyorjvDLtzFzGsbPsAQOKVKTmCTm5nngs=;
        b=6tVZ0RoPsF9ju7f1bTZiTFZGMx6ALICzFUw335hYo4d3dAUm7WgwT+xZpEY0sZo7Va
         ZcRtLbTPYV70DBX4Ub3GvxLeyHIaJIZQCzZoyV2exWluvMNf7tR6ba5bK478SyWWkiWI
         WXQ/KWGuzfAzNxk9d2HqWAjP/iBla4n06eOtls63entmGElmw/9tOBz9dlZ7okmZITwZ
         hkoMChjH6h9M80ZgEaCdswpcANeEVTJstuEkmvXwfBpkVVj7oscgbWEpBucvYzAqvOAs
         16y+MCIj0sVXsDP3tOxmgSKpzuRnxHQx9QFoMGMThNk67jEjeJ/nL+jmJf6MjTi62big
         wLzQ==
X-Gm-Message-State: ANoB5pkBvoCtQMA8k9gPB0zgjUhFmom5e/QXr6K6mruRRKaXKVQn3tTK
        NxZ7VwF06sIDxj4PHo/WDvLJ9lKc7Y/q3A==
X-Google-Smtp-Source: AA0mqf6YOtw97a/6+Em55RlLJKrxUctsXdKo0FRuP7JWgkrpNueVuon6iCUVLg6l2IDWDl6kjyCgdw==
X-Received: by 2002:a0c:ec48:0:b0:4b7:c96b:80ec with SMTP id n8-20020a0cec48000000b004b7c96b80ecmr2673227qvq.17.1668186402972;
        Fri, 11 Nov 2022 09:06:42 -0800 (PST)
Received: from errol.ini.cmu.edu (pool-72-77-81-136.pitbpa.fios.verizon.net. [72.77.81.136])
        by smtp.gmail.com with ESMTPSA id t6-20020a05622a180600b00343057845f7sm1527090qtc.20.2022.11.11.09.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 09:06:42 -0800 (PST)
Date:   Fri, 11 Nov 2022 12:06:40 -0500
From:   "Gabriel L. Somlo" <gsomlo@gmail.com>
To:     Joel Stanley <joel@jms.id.au>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        kgugala@antmicro.com, mholenko@antmicro.com,
        david.abdurachmanov@sifive.com, florent@enjoy-digital.fr
Subject: Re: [PATCH v1 2/3] serial: liteuart: separate RX loop from poll timer
Message-ID: <Y26BIPcWznDdHtEG@errol.ini.cmu.edu>
References: <20221107171500.2537938-1-gsomlo@gmail.com>
 <20221107171500.2537938-3-gsomlo@gmail.com>
 <CACPK8XdGpGUispRcfgaVyE=18Wwg8GFHH7QJ6bcQLA5XDikSiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPK8XdGpGUispRcfgaVyE=18Wwg8GFHH7QJ6bcQLA5XDikSiQ@mail.gmail.com>
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

On Thu, Nov 10, 2022 at 01:09:59AM +0000, Joel Stanley wrote:
> On Mon, 7 Nov 2022 at 17:15, Gabriel Somlo <gsomlo@gmail.com> wrote:
> >
> > Move the character-receive (RX) loop to its own dedicated function,
> > and (for now) call that from the poll timer, liteuart_timer().
> >
> > This is in preparation for adding IRQ support to the receive path.
> >
> > Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
> > ---
> >  drivers/tty/serial/liteuart.c | 25 +++++++++++++++----------
> >  1 file changed, 15 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
> > index 4b9cca249828..90a29ed79bff 100644
> > --- a/drivers/tty/serial/liteuart.c
> > +++ b/drivers/tty/serial/liteuart.c
> > @@ -69,29 +69,34 @@ static struct uart_driver liteuart_driver = {
> >  #endif
> >  };
> >
> > -static void liteuart_timer(struct timer_list *t)
> > +static void liteuart_rx_chars(struct uart_port *port)
> >  {
> > -       struct liteuart_port *uart = from_timer(uart, t, timer);
> > -       struct uart_port *port = &uart->port;
> >         unsigned char __iomem *membase = port->membase;
> > -       unsigned int flg = TTY_NORMAL;
> > -       int ch;
> > -       unsigned long status;
> > +       unsigned int status;
> > +       unsigned char ch;
> 
> u32, u8, void __iomem * would be better kernel types to use here.
> 
> You've also changed ch from a signed 32 to an unsigned 8.

uart_insert_char() expects both `status` and `ch` to be of type
`unsigned int`. Switching `ch` to 8-bit was a typo, thanks for
catching it!

I'm going to use `unsigned int status, ch` in v3, to match the
signature of `uart_insert_char()` -- hope that's OK. This will be
a separate commit preceding the "move rx loop out of poll timer"
change.
 
> >
> >         while ((status = !litex_read8(membase + OFF_RXEMPTY)) == 1) {
> >                 ch = litex_read8(membase + OFF_RXTX);
> >                 port->icount.rx++;
> >
> >                 /* necessary for RXEMPTY to refresh its value */
> > -               litex_write8(membase + OFF_EV_PENDING, EV_TX | EV_RX);
> > +               litex_write8(membase + OFF_EV_PENDING, EV_RX);
> 
> You're no longer clearing EV_TX, but don't mention why (I understand
> why with the context of the other changes, so perhaps add something to
> this commit message).

I'm adding a separate commit to document this (in v3) as well.

Thanks,
--Gabriel
 
> 
> >
> >                 /* no overflow bits in status */
> >                 if (!(uart_handle_sysrq_char(port, ch)))
> > -                       uart_insert_char(port, status, 0, ch, flg);
> > -
> > -               tty_flip_buffer_push(&port->state->port);
> > +                       uart_insert_char(port, status, 0, ch, TTY_NORMAL);
> >         }
> >
> > +       tty_flip_buffer_push(&port->state->port);
> > +}
> > +
> > +static void liteuart_timer(struct timer_list *t)
> > +{
> > +       struct liteuart_port *uart = from_timer(uart, t, timer);
> > +       struct uart_port *port = &uart->port;
> > +
> > +       liteuart_rx_chars(port);
> > +
> >         mod_timer(&uart->timer, jiffies + uart_poll_timeout(port));
> >  }
> >
> > --
> > 2.37.3
> >
