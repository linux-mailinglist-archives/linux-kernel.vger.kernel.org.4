Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0486348E8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 22:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233983AbiKVVFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 16:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiKVVFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 16:05:10 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1520B7AF7C;
        Tue, 22 Nov 2022 13:05:09 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id a27so10109884qtw.10;
        Tue, 22 Nov 2022 13:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TEsBoWd98Bx8Szc4KH9G5PjRUA8sYnqA0FuOpnSyCE4=;
        b=MbzoJUg9Xw4Kaq0Thn1IUiQ5Cfiaa1GTlYPmlYvrOj4CS2MucM2OiL4ItLv3jljspa
         W51mbsmeDNe8/30KbGxMxBycIvJuCQTX+8I4OGIeri+RN4+PMxookm+lS1WVxRc037jP
         NUZ4ejkfmpDXB8OQTFnW+JP4X3EBOlqvN8jOSD6jB9z5uQyqQyOWSgyjxSeGPo3hR0Cw
         qYkkicUG3kNBJjOCyN1gcO/gp56/dTp7H0R5OKaSO70xTUOGQ16wJHOkX/64nxoYmhLN
         sjhdPgZTxbgecegbhnrPo6usbnG20HsKimk2cvzVtWsJtkp1XI2eRZdSh/rAN5TWizj7
         swQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TEsBoWd98Bx8Szc4KH9G5PjRUA8sYnqA0FuOpnSyCE4=;
        b=pFzA2hKQ+1udyc5iBfstW7T/HKMfhK4u6TuGGUibZ/IO8qav58R2P7PUj/FRW/rrcu
         H74aKHyuR7epCyw+rbZ5gkYAlNsvCXMB2QBsjEaG1HG5wjUR3DYmaJV/E43jXDwTEFLw
         Cx2KILmLflJkmfHj5CKWdN6EIiXeIZb1i5oFoAvJeyDAlY4tRd8G7AZ10sS9S4tB/vMz
         waNas9g/YdfBGRi1CQVSekAwG9tXB/6ynzo1Xp1xj0KGtuQ7x6mQslmKyItfsd2zmofC
         qz0IDcLrY9eIUKEIluBRM5n8Xd57Q4iYzA4FXpTWg+cbLPY/2AGvUq8EOuwtrht4Y5NP
         LvCg==
X-Gm-Message-State: ANoB5pkd+yp2UDd+m5xQ7m/NHx5p0QGHHh/D6BJoaSGttqjdytp8aQEj
        y50sO49jMsRKjWpgmxjRGts=
X-Google-Smtp-Source: AA0mqf6ZJfHnl+XQ4fCxKsKgnBDtvIAlDhpaf3VcBeTrU9+WiW8pOJjyVtUkv8pTS6NbuERg4gyBJA==
X-Received: by 2002:ac8:41cf:0:b0:3a5:868a:5b86 with SMTP id o15-20020ac841cf000000b003a5868a5b86mr23729271qtm.488.1669151108037;
        Tue, 22 Nov 2022 13:05:08 -0800 (PST)
Received: from errol.ini.cmu.edu (pool-72-77-81-136.pitbpa.fios.verizon.net. [72.77.81.136])
        by smtp.gmail.com with ESMTPSA id j6-20020a05620a410600b006fa2dde9db8sm10986864qko.95.2022.11.22.13.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 13:05:07 -0800 (PST)
Date:   Tue, 22 Nov 2022 16:05:05 -0500
From:   "Gabriel L. Somlo" <gsomlo@gmail.com>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        gregkh@linuxfoundation.org, kgugala@antmicro.com,
        mholenko@antmicro.com, joel@jms.id.au,
        david.abdurachmanov@gmail.com, florent@enjoy-digital.fr,
        geert@linux-m68k.org, ilpo.jarvinen@linux.intel.com
Subject: Re: [PATCH v5 09/14] serial: liteuart: fix rx loop variable types
Message-ID: <Y305gZnFSaUBtCRa@errol.ini.cmu.edu>
References: <20221118145512.509950-1-gsomlo@gmail.com>
 <20221118145512.509950-10-gsomlo@gmail.com>
 <44bf21b6-cbe4-4d73-0883-a9bcbd7d5971@kernel.org>
 <1b5a963c-2a5b-54fe-784e-fcc4d06c347e@kernel.org>
 <Y3uDZV8b+3GfQyUY@errol.ini.cmu.edu>
 <2f242291-99b6-a50f-cd52-e7dfd8c88c8f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2f242291-99b6-a50f-cd52-e7dfd8c88c8f@kernel.org>
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

On Tue, Nov 22, 2022 at 08:37:58AM +0100, Jiri Slaby wrote:
> On 21. 11. 22, 14:55, Gabriel L. Somlo wrote:
> > Hi Jiri,
> > 
> > Thanks for the feedback!
> > 
> > On Mon, Nov 21, 2022 at 09:45:05AM +0100, Jiri Slaby wrote:
> > > On 21. 11. 22, 9:37, Jiri Slaby wrote:
> > > > On 18. 11. 22, 15:55, Gabriel Somlo wrote:
> > > > > Update variable types to match the signature of uart_insert_char()
> > > > > which consumes them.
> > > > > 
> > > > > Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
> > > > > Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > > > > ---
> > > > >    drivers/tty/serial/liteuart.c | 3 +--
> > > > >    1 file changed, 1 insertion(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/tty/serial/liteuart.c
> > > > > b/drivers/tty/serial/liteuart.c
> > > > > index 81aa7c1da73c..42ac9aee050a 100644
> > > > > --- a/drivers/tty/serial/liteuart.c
> > > > > +++ b/drivers/tty/serial/liteuart.c
> > > > > @@ -73,8 +73,7 @@ static void liteuart_timer(struct timer_list *t)
> > > > >        struct liteuart_port *uart = from_timer(uart, t, timer);
> > > > >        struct uart_port *port = &uart->port;
> > > > >        unsigned char __iomem *membase = port->membase;
> > > > > -    int ch;
> > > > > -    unsigned long status;
> > > > > +    unsigned int status, ch;
> > > > 
> > > > These should be u8 after all, right?
> > 
> > OK, so:
> > 
> >    - I can hard-code `status` as `1`, like so:
> > 
> > 	while(!litex_read8(membase + OFF_RXEMPTY) {
> > 		...
> > 		if (!(uart_handle_sysrq_char(port, ch)))
> > 			uart_insert_char(port, 1, 0, ch, TTY_NORMAL);
> > 
> >      ... since `status` would always be `1` inside the loop. So I'm
> >      basically going to get rid of it altogether.
> 
> Yes, I had that in my mind. Except passing 1 to uart_insert_char() when
> overflow is hardwired to 0 makes no sense IMO :).

So, looking at what uart_insert_char() does, I could simply do this
instead:

 	while(!litex_read8(membase + OFF_RXEMPTY) {
 		...
		/* LiteUART does not provide overrun bits */
 		if (!(uart_handle_sysrq_char(port, ch) ||
 		     tty_insert_flip_char(&port->state->port, ch, TTY_NORMAL)))
 			++port->icount.buf_overrun;
 
That is, `tty_insert_flip_char() is the portion of `uart_insert_char()`
that actually gets executed if status is 1 and overrun is 0...

I'm not quite confident about whether this is an improvement in legibility
and/or code quality, but please let me know what *you* think... :)

> >    - `ch` is indeed *produced* by `litex_read8()`, which would make it
> >      `u8`. It is subsequently *consumed* by `uart_handle_sysrq_char()`
> >      and `uart_insert_char()`, which both expect `unsigned int`.
> 
> Ignore uart_handle_sysrq_char and uart_insert_char. They should be fixed one
> day. It should really be u8. All down the call chain (it magically turns
> into int in the sysrq handlers, then char is expected).
>
> >      If you think it's better to go with the type when the value is
> >      produced (as opposed to when it's consumed), I'm OK with that for
> >      the upcoming v6 of the series... :)
> 
> Yes, please. We should slowly convert _all_ of them.

OK, u8 it is, then.
 
> > > And can you change membase to u8 * too 8-)?
> > 
> > Hmmm, in `struct uart_port` (in include/linux/serial_core.h), the
> > `membase` field is declared as:
> > 
> > 	unsigned char __iomem   *membase;
> > 
> > which is why I'm thinking we should leave it as-is? Unless there are
> > plans (or a pending patch I'm unaware of) to switch the field in
> > include/linux/serial_core.h to `u8` as well? -- Please advise.
> 
> Ah, then keep it. I somehow thought it's void *. And yes, even this should
> be u8 __iomem *, eventually.

OK, it should/will get updated in bulk once that change is made across
the entire subsystem, leaving as-is for now.

Thanks again for all your help and advice!
--Gabriel
