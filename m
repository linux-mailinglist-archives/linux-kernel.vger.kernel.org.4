Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37BE76679DC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 16:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240595AbjALPwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 10:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237238AbjALPve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 10:51:34 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23333103D
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 07:40:23 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 99CF1402C3;
        Thu, 12 Jan 2023 15:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1673538019; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MnhE5SVciJ/SbPnM39oaaCSkXi4rJk4SInUK6g88A8I=;
        b=gdU4kPBcKFOlGDDkfqP770eiIQG6FQMGlIw9Oyx/L1ICoITOsvbS/4bp/+fghEwhzlgHrr
        rYIo28C87h7Yus+MmP5RHkuVRzIWlMIMV9jCpyQKU0ahtsQoLgOW6HKgiWxkS00YaB1TI2
        qOMeWM9kS897ZqqcSJ5NOFhTmjCmIRA=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1B84C2C141;
        Thu, 12 Jan 2023 15:40:19 +0000 (UTC)
Date:   Thu, 12 Jan 2023 16:40:16 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org
Subject: Re: [PATCH] tty: serial: kgdboc: fix mutex locking order for
 configure_kgdboc()
Message-ID: <Y8Ap4B75PNy5/lHo@alley>
References: <20230111145110.1327831-1-john.ogness@linutronix.de>
 <Y77imoYMaZZZz28x@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y77imoYMaZZZz28x@alley>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2023-01-11 17:23:55, Petr Mladek wrote:
> On Wed 2023-01-11 15:57:10, John Ogness wrote:
> > Several mutexes are taken while setting up console serial ports. In
> > particular, the tty_port->mutex and @console_mutex are taken:
> > 
> >   serial_pnp_probe
> >     serial8250_register_8250_port
> >       uart_add_one_port (locks tty_port->mutex)
> >         uart_configure_port
> >           register_console (locks @console_mutex)
> > 
> > In order to synchronize kgdb's tty_find_polling_driver() with
> > register_console(), commit 6193bc90849a ("tty: serial: kgdboc:
> > synchronize tty_find_polling_driver() and register_console()") takes
> > the @console_mutex. However, this leads to the following call chain
> > (with locking):
> > 
> >   platform_probe
> >     kgdboc_probe
> >       configure_kgdboc (locks @console_mutex)
> >         tty_find_polling_driver
> >           uart_poll_init (locks tty_port->mutex)
> >             uart_set_options
> > 
> > This is clearly deadlock potential due to the reverse lock ordering.
> 
> Great catch!
> 
> > Since uart_set_options() requires holding @console_mutex in order to
> > serialize early initialization of the serial-console lock, take the
> > @console_mutex in uart_poll_init() instead of configure_kgdboc().
> > 
> > Since configure_kgdboc() was using @console_mutex for safe traversal
> > of the console list, change it to use the SRCU iterator instead.
> > 
> > Add comments to uart_set_options() kerneldoc mentioning that it
> > requires holding @console_mutex (aka the console_list_lock).
> > 
> > Fixes: 6193bc90849a ("tty: serial: kgdboc: synchronize tty_find_polling_driver() and register_console()")
> > Signed-off-by: John Ogness <john.ogness@linutronix.de>
> 
> > --- a/drivers/tty/serial/kgdboc.c
> > +++ b/drivers/tty/serial/kgdboc.c
> > @@ -189,15 +190,6 @@ static int configure_kgdboc(void)
> >  	if (kgdboc_register_kbd(&cptr))
> >  		goto do_register;
> >  
> > -	/*
> > -	 * tty_find_polling_driver() can call uart_set_options()
> > -	 * (via poll_init) to configure the uart. Take the console_list_lock
> > -	 * in order to synchronize against register_console(), which can also
> > -	 * configure the uart via uart_set_options(). This also allows safe
> > -	 * traversal of the console list.
> > -	 */
> > -	console_list_lock();
> > -
> >  	p = tty_find_polling_driver(cptr, &tty_line);
> >  	if (!p) {
> >  		console_list_unlock();
> 
> This console_list_unlock() should be removed here as well.

This seems to be the only problem. Otherwise, the patch looks good to
me.

After removing the superfluous console_list_unlock():

Reviewed-by: Petr Mladek <pmladek@suse.com>

John, would you mind to send v2, please?

Best Regards,
Petr
