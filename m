Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49E596692C6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 10:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241123AbjAMJUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 04:20:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233125AbjAMJTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 04:19:17 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BB8EA2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 01:14:02 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D131B4ECED;
        Fri, 13 Jan 2023 09:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1673601240; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=22DFHnDxPptAxbZRoG0bfrp/Xo+pGFjmLGSMAbfetfs=;
        b=OeKmqSXK6BMh1+XSb4Yht+FwtZ3vbNAUYn424dWwVqnXft2E2H2qY4xnZSv22j+3Fcid6W
        qxBw9EAKsq2DQhg2mMhVMuPEGYRmGDmvhiXWmQmur3NNywDeUBr0Dmd35RlipU3MLxMox7
        9MDbEt0p7ut324nkAcMAKEvRCh42KMQ=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 576AB2C141;
        Fri, 13 Jan 2023 09:14:00 +0000 (UTC)
Date:   Fri, 13 Jan 2023 10:13:59 +0100
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
Subject: Re: [PATCH v2] tty: serial: kgdboc: fix mutex locking order for
 configure_kgdboc()
Message-ID: <Y8Eg1wDOOkSCAh2E@alley>
References: <20230112161213.1434854-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112161213.1434854-1-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2023-01-12 17:18:13, John Ogness wrote:
> Several mutexes are taken while setting up console serial ports. In
> particular, the tty_port->mutex and @console_mutex are taken:
> 
>   serial_pnp_probe
>     serial8250_register_8250_port
>       uart_add_one_port (locks tty_port->mutex)
>         uart_configure_port
>           register_console (locks @console_mutex)
> 
> In order to synchronize kgdb's tty_find_polling_driver() with
> register_console(), commit 6193bc90849a ("tty: serial: kgdboc:
> synchronize tty_find_polling_driver() and register_console()") takes
> the @console_mutex. However, this leads to the following call chain
> (with locking):
> 
>   platform_probe
>     kgdboc_probe
>       configure_kgdboc (locks @console_mutex)
>         tty_find_polling_driver
>           uart_poll_init (locks tty_port->mutex)
>             uart_set_options
> 
> This is clearly deadlock potential due to the reverse lock ordering.
> 
> Since uart_set_options() requires holding @console_mutex in order to
> serialize early initialization of the serial-console lock, take the
> @console_mutex in uart_poll_init() instead of configure_kgdboc().
> 
> Since configure_kgdboc() was using @console_mutex for safe traversal
> of the console list, change it to use the SRCU iterator instead.
> 
> Add comments to uart_set_options() kerneldoc mentioning that it
> requires holding @console_mutex (aka the console_list_lock).
> 
> Fixes: 6193bc90849a ("tty: serial: kgdboc: synchronize tty_find_polling_driver() and register_console()")
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Reviewed-by: Petr Mladek <pmladek@suse.com>

JFYI, the patch has been committed into printk/linux.git,
branch rework/console-list-lock.

I am going to give it few days in linux-next. If there is no problem
I will send a pull request for 6.2-rc5 later the following week.

Please, let me known if you have another preference.

Best Regards,
Petr
