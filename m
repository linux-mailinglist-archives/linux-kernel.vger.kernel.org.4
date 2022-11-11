Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8AF262603C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 18:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234340AbiKKRQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 12:16:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234306AbiKKRQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 12:16:09 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF4620F71;
        Fri, 11 Nov 2022 09:16:04 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B3E6A22427;
        Fri, 11 Nov 2022 17:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1668186962; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FxrxM7pL3XKtifIuT+LlAb2dWxKEfCKW4HflKcsOazM=;
        b=Bx93kEFIydrek2IJhS1lyxdnzNwsqiFWcSHlAxlTXbGbLl8Lk667JwSy1+8nQrjVP4gzUK
        pk7Pxa39UFsq+onAdTpLvmGhPWQO4bmOhnEYXxKi2ONuoPJKIvtHs/cqCGFk2+29VflLLL
        YjzXL5z0HLnd9i/Kgm5/5Wa6hVfQATQ=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4937A2C145;
        Fri, 11 Nov 2022 17:16:02 +0000 (UTC)
Date:   Fri, 11 Nov 2022 18:15:58 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH printk v3 40/40] tty: serial: sh-sci: use setup()
 callback for early console
Message-ID: <Y26DTir7jozrsEST@alley>
References: <20221107141638.3790965-1-john.ogness@linutronix.de>
 <20221107141638.3790965-41-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107141638.3790965-41-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ccing Bartosz who should be familiar with the early platform code.

On Mon 2022-11-07 15:22:38, John Ogness wrote:
> When setting up the early console, the setup() callback of the
> regular console is used. It is called manually before registering
> the early console instead of providing a setup() callback for the
> early console. This is probably because the early setup needs a
> different @options during the early stage.

This last sentece makes a bit nervous ;-)

I think that I understood it in the end, see below.

> The issue here is that the setup() callback is called without the
> console_list_lock held and functions such as uart_set_options()
> expect that.
> 
> Rather than manually calling the setup() function before registering,
> provide an early console setup() callback that will use the different
> early options. This ensures that the error checking, ordering, and
> locking context when setting up the early console are correct.
> 
> Note that technically the current implementation works because it is
> only used in early boot. And since the early console setup is
> performed before registering, it cannot race with anything and thus
> does not need any locking. However, longterm maintenance is easier
> when drivers rely on the subsystem API rather than manually
> implementing steps that could cause breakage in the future.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  drivers/tty/serial/sh-sci.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index 62f773286d44..f3a1cfec757a 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -3054,15 +3054,26 @@ static struct console serial_console = {
>  };
>  
>  #ifdef CONFIG_SUPERH
> +static char early_serial_buf[32];
> +
> +static int early_serial_console_setup(struct console *co, char *options)
> +{
> +	WARN_ON(options);
> +	/*
> +	 * Use @early_serial_buf because @options will always be
> +	 * NULL at this early stage.
> +	 */

The commit message says that we use @early_serial_buf because
the early console probably needs another parameters.

It suggests that @options might be for the later stage and
we need to replace them there. Are we sure that this will always
be NULL?

Background:

The console->setup() is called in two situations:

   1. when the console is registered as the default console, see
     try_enable_default_console(). In this case, @options
     is really NULL.

   2. when the console is preferred either via the commnadline,
      or device tree, or SPCR, see try_enable_preferred_console().
      In this case, some real @options would be passed.

     From the code POV, the preferred consoles are added by calling
     add_preferred_console().


Now, it means that the WARN_ON() is correct only when this console
is always registered before the preferred consoles are defined.

I think that this is really the case. This console
is actually registered via the "earlyprintk" parameter that
is proceed by the arch-specific code before the preferred
consoles are added the standard way via the kernel commandline.

Note that "earlyprintk" and "earlycon" are two different parameters.

"earlyprintk" normally initializes "early_console" that is
called directly by early_printk(). It is used for super early
debugging. These messages even do not end in the ring buffer.

"earlycon" defines a "normal" console that is used by the standard
printk(). They are later replaced by properly initialized console
drivers that are in sysfs, ...

Note that "earlycon" calls add_preferred_console() so that
the @options are stored and passed from try_enable_preferred_console().

But "earlyprintk" does not call add_preferred_console() so
we need this hack to store and pass the console options
another way.

> +	return serial_console_setup(co, early_serial_buf);
> +}
> +

So I would do something like:

static int early_serial_console_setup(struct console *co, char *options)
{
	/*
	 * This early console is registered using earlyprintk= parameter
	 * that does not call add_preferred_console(). The @options
	 * are passed using a custom buffer.
	 */
	WARN_ON(options);

	return serial_console_setup(co, early_serial_buf);
}

Also we should explain this in the commit message.

Best Regards,
Petr
