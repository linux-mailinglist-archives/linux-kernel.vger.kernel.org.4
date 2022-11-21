Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD15632464
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 14:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbiKUNzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 08:55:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiKUNzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 08:55:53 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924DF1C906;
        Mon, 21 Nov 2022 05:55:52 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id l15so7255136qtv.4;
        Mon, 21 Nov 2022 05:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aRGycu+6A1/J6uxdeyaT0tdCj9DudJg4BttwLCOKs70=;
        b=m5kRB3J7U1yiYc+tvoflWQgm9RmUwZQh4AVS7jljuXCd4TzjzPC3CIYM0/nbT/K9mj
         R2VdvD4WCIFgpUcoT5Fh9Xf32wmEi9nx85HfMA+LaFrNvMsTX/ikkLS602z+jMfFUb8g
         dLY6nCIO0WP5RvBKShyDHeKTfbCfPQC+fR5/bBD3PxN3U7TkzR+pa0XFZ4svCam7ts/w
         iHRnXroauYcydRpA5AfQRcsaXpikJ8DeA00CRcY11A5o5z4iOjln9CO114pjrrBKEUx7
         wsdp31KvcvH2uYats03LrHq567TUTSnQEZ1AIepTzd8SazjtRn+uj+8Qh5R5ywpKzDWQ
         1t5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aRGycu+6A1/J6uxdeyaT0tdCj9DudJg4BttwLCOKs70=;
        b=SANkyYZKP710blhtjH0gJMJxtZYfCnZEw5yFbP6gBpdSrRsQbWgoV3IBh50dl1Q4j4
         Oy98UUzDnyst8U//l95EIIW7P5bQ40NLjMiU1tkimUoZk69O49Hh7Ibp+ibMcBy9AieT
         pVgo/DE0JShwatBWWiBYmx7OcPTKx6cgA9PBShG0hdBChroTMLb2TtGtzuEaBCnDwxLb
         9lMVqYdKoG2Uvk7giyMc6CXfDz6vdhA/htdNes6tuIi4K3EIxfO0L3daF2SDLlOJMrgJ
         Aohlz8TScUrRUy4CFyUpz9nnEOzwVzwtlbx6u2P8JK1/NXH/BS9O6YaopcS+7YFFTWgr
         qB2w==
X-Gm-Message-State: ANoB5pl7Hx7bby3aRgsOZc4seACiP+vsueH+hZoz4o8fUAXG6RcjvQil
        z3nS2YS+Tgc67ekCqveyRLemPbp7iWGVEA==
X-Google-Smtp-Source: AA0mqf7O9xooNAxFfAsv16EccF06n/xjrUUSFv2bpCu9FjP4ZuRsGGsuzfWBWCZQVqtGW3zO1H/5Wg==
X-Received: by 2002:ac8:743:0:b0:397:92e9:a517 with SMTP id k3-20020ac80743000000b0039792e9a517mr17100332qth.56.1669038951655;
        Mon, 21 Nov 2022 05:55:51 -0800 (PST)
Received: from errol.ini.cmu.edu (pool-72-77-81-136.pitbpa.fios.verizon.net. [72.77.81.136])
        by smtp.gmail.com with ESMTPSA id u18-20020a05620a455200b006cdd0939ffbsm8400307qkp.86.2022.11.21.05.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 05:55:51 -0800 (PST)
Date:   Mon, 21 Nov 2022 08:55:49 -0500
From:   "Gabriel L. Somlo" <gsomlo@gmail.com>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        gregkh@linuxfoundation.org, kgugala@antmicro.com,
        mholenko@antmicro.com, joel@jms.id.au,
        david.abdurachmanov@gmail.com, florent@enjoy-digital.fr,
        geert@linux-m68k.org, ilpo.jarvinen@linux.intel.com
Subject: Re: [PATCH v5 09/14] serial: liteuart: fix rx loop variable types
Message-ID: <Y3uDZV8b+3GfQyUY@errol.ini.cmu.edu>
References: <20221118145512.509950-1-gsomlo@gmail.com>
 <20221118145512.509950-10-gsomlo@gmail.com>
 <44bf21b6-cbe4-4d73-0883-a9bcbd7d5971@kernel.org>
 <1b5a963c-2a5b-54fe-784e-fcc4d06c347e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1b5a963c-2a5b-54fe-784e-fcc4d06c347e@kernel.org>
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

Hi Jiri,

Thanks for the feedback!

On Mon, Nov 21, 2022 at 09:45:05AM +0100, Jiri Slaby wrote:
> On 21. 11. 22, 9:37, Jiri Slaby wrote:
> > On 18. 11. 22, 15:55, Gabriel Somlo wrote:
> > > Update variable types to match the signature of uart_insert_char()
> > > which consumes them.
> > > 
> > > Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
> > > Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > > ---
> > >   drivers/tty/serial/liteuart.c | 3 +--
> > >   1 file changed, 1 insertion(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/tty/serial/liteuart.c
> > > b/drivers/tty/serial/liteuart.c
> > > index 81aa7c1da73c..42ac9aee050a 100644
> > > --- a/drivers/tty/serial/liteuart.c
> > > +++ b/drivers/tty/serial/liteuart.c
> > > @@ -73,8 +73,7 @@ static void liteuart_timer(struct timer_list *t)
> > >       struct liteuart_port *uart = from_timer(uart, t, timer);
> > >       struct uart_port *port = &uart->port;
> > >       unsigned char __iomem *membase = port->membase;
> > > -    int ch;
> > > -    unsigned long status;
> > > +    unsigned int status, ch;
> > 
> > These should be u8 after all, right?

OK, so:

  - I can hard-code `status` as `1`, like so:

	while(!litex_read8(membase + OFF_RXEMPTY) {
		...
		if (!(uart_handle_sysrq_char(port, ch)))
			uart_insert_char(port, 1, 0, ch, TTY_NORMAL);

    ... since `status` would always be `1` inside the loop. So I'm
    basically going to get rid of it altogether.

  - `ch` is indeed *produced* by `litex_read8()`, which would make it
    `u8`. It is subsequently *consumed* by `uart_handle_sysrq_char()`
    and `uart_insert_char()`, which both expect `unsigned int`.

    If you think it's better to go with the type when the value is
    produced (as opposed to when it's consumed), I'm OK with that for
    the upcoming v6 of the series... :)
 
> And can you change membase to u8 * too 8-)?

Hmmm, in `struct uart_port` (in include/linux/serial_core.h), the
`membase` field is declared as:

	unsigned char __iomem   *membase;

which is why I'm thinking we should leave it as-is? Unless there are
plans (or a pending patch I'm unaware of) to switch the field in
include/linux/serial_core.h to `u8` as well? -- Please advise.

Thanks again,
--Gabriel

> -- 
> js
> suse labs
> 
