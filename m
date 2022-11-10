Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63AA9624322
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 14:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbiKJNYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 08:24:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbiKJNYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 08:24:39 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8D5B4E;
        Thu, 10 Nov 2022 05:24:38 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 89CA41FADE;
        Thu, 10 Nov 2022 13:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1668086677; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=naQhJVICUVfgZMKK27G/LnTrwDheWqZju3P+B9fWRRY=;
        b=YPUrf8Q2PdghD/r6NdSQuVDxLuzuPxEhsCRs6KbXaLps+bE8Mpp1mAPRwPBrxo63y0igTW
        NWpQeYYp3GABdwM9w0YFJANcKEzEyYuJhjsUstSKBv2luZZX9deOCjbSzmzqMZvdm+cpjA
        zOQSpKAeqqszBsrWntBw7ZJEAuwGt+c=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 708352C141;
        Thu, 10 Nov 2022 13:24:36 +0000 (UTC)
Date:   Thu, 10 Nov 2022 14:24:36 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Tony Lindgren <tony@atomide.com>,
        Lukas Wunner <lukas@wunner.de>, linux-serial@vger.kernel.org
Subject: Re: [PATCH printk v3 23/40] serial_core: replace
 uart_console_enabled() with uart_console_registered()
Message-ID: <Y2z7lLEvQx7iLuuP@alley>
References: <20221107141638.3790965-1-john.ogness@linutronix.de>
 <20221107141638.3790965-24-john.ogness@linutronix.de>
 <CAMuHMdXuBh1PznFggpwSanBtHu9=ngJkVCRzdZVnjxWs2+cbxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXuBh1PznFggpwSanBtHu9=ngJkVCRzdZVnjxWs2+cbxw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-11-08 09:46:20, Geert Uytterhoeven wrote:
> Hi John,
> 
> On Mon, Nov 7, 2022 at 3:16 PM John Ogness <john.ogness@linutronix.de> wrote:
> > All users of uart_console_enabled() really want to know if a console
> > is registered. It is not reliable to check for CON_ENABLED in order
> > to identify if a console is registered. Use console_is_registered()
> > instead.
> >
> > A _locked() variant is provided because uart_set_options() is always
> > called with the console_list_lock held and must check if a console
> > is registered in order to synchronize with kgdboc.
> >
> > Signed-off-by: John Ogness <john.ogness@linutronix.de>
> 
> > --- a/include/linux/serial_core.h
> > +++ b/include/linux/serial_core.h
> > @@ -743,9 +743,20 @@ static const bool earlycon_acpi_spcr_enable EARLYCON_USED_OR_UNUSED;
> >  static inline int setup_earlycon(char *buf) { return 0; }
> >  #endif
> >
> > -static inline bool uart_console_enabled(struct uart_port *port)
> > +/* Variant of uart_console_registered() when the console_list_lock is held. */
> > +static inline bool uart_console_registered_locked(struct uart_port *port)
> >  {
> > -       return uart_console(port) && (port->cons->flags & CON_ENABLED);
> > +       return uart_console(port) && console_is_registered_locked(port->cons);
> > +}
> > +
> > +static inline bool uart_console_registered(struct uart_port *port)
> > +{
> > +       bool ret;
> > +
> > +       console_list_lock();
> > +       ret = uart_console_registered_locked(port);
> > +       console_list_unlock();
> > +       return ret;
> 
> Perhaps
> 
>     return uart_console(port) && console_is_registered();
> 
> to avoid locking the list when the first condition is not true?

I do not have strong opinion on this. It is true that the code
duplication is trivial but it is a code duplication. Either
way would work for me.

The reset of the code looks good. Feel free to use:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
