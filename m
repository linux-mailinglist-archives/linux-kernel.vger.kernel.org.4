Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4C36299F9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 14:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbiKONWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 08:22:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbiKONWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 08:22:18 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00792DEC6;
        Tue, 15 Nov 2022 05:22:17 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id AFDB21F8CD;
        Tue, 15 Nov 2022 13:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1668518536; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QmX7RJNNVBj1FU2joU/lqNhMfCU9lMkhGvr+3DdJhfg=;
        b=iRMOUOKOWNnBtw6+eGOtN4tmTznrw3/yio0CZFdwk76Npxu5xZrQMnLuPWOJZaZRJhr8bU
        OuFgBhGGQMQLaOoIJ2fF/z9dxbUcOLYu0CaEHVNetJKx8C7V4C0b5tqrI+hjNkNq+mQ5x8
        2G+HZgSGsI5B+D3aEntVGEYNZsUZGT4=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6B80D2C142;
        Tue, 15 Nov 2022 13:22:16 +0000 (UTC)
Date:   Tue, 15 Nov 2022 14:22:15 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Helge Deller <deller@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Tom Rix <trix@redhat.com>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH printk v4 31/39] printk, xen: fbfront: create/use safe
 function for forcing preferred
Message-ID: <Y3OSh8OCL/SYH9qi@alley>
References: <20221114162932.141883-1-john.ogness@linutronix.de>
 <20221114162932.141883-32-john.ogness@linutronix.de>
 <87mt8tfh6x.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mt8tfh6x.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-11-14 20:57:18, John Ogness wrote:
> Hi,
> 
> After more detailed runtime testing I discovered that I didn't re-insert
> the console to the correct place in the list. More below...
> 
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -3461,6 +3462,48 @@ int unregister_console(struct console *console)
> >  }
> >  EXPORT_SYMBOL(unregister_console);
> >  
> > +/**
> > + * console_force_preferred_locked - force a registered console preferred
> > + * @con: The registered console to force preferred.
> > + *
> > + * Must be called under console_list_lock().
> > + */
> > +void console_force_preferred_locked(struct console *con)
> > +{
> > +	struct console *cur_pref_con;
> > +
> > +	if (!console_is_registered_locked(con))
> > +		return;
> > +
> > +	cur_pref_con = console_first();
> > +
> > +	/* Already preferred? */
> > +	if (cur_pref_con == con)
> > +		return;
> > +
> > +	/*
> > +	 * Delete, but do not re-initialize the entry. This allows the console
> > +	 * to continue to appear registered (via any hlist_unhashed_lockless()
> > +	 * checks), even though it was briefly removed from the console list.
> > +	 */
> > +	hlist_del_rcu(&con->node);
> > +
> > +	/*
> > +	 * Ensure that all SRCU list walks have completed so that the console
> > +	 * can be added to the beginning of the console list and its forward
> > +	 * list pointer can be re-initialized.
> > +	 */
> > +	synchronize_srcu(&console_srcu);
> > +
> > +	con->flags |= CON_CONSDEV;
> > +	WARN_ON(!con->device);
> > +
> > +	/* Only the new head can have CON_CONSDEV set. */
> > +	console_srcu_write_flags(cur_pref_con, cur_pref_con->flags & ~CON_CONSDEV);
> > +	hlist_add_behind_rcu(&con->node, console_list.first);
> 
> This is adding the console as the 2nd item. It should be the new
> head. The patch below fixes it.
> 
> I have done careful runtime testing with this fixup. After the
> force_preferred, the console is the new head and sending data to
> /dev/console redirects to that console.

Great catch!

> It would be nice if we could fold this in. Sorry.

I have missed it as well :-/

> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 8d635467882f..4b77586cf4cb 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3494,7 +3494,7 @@ void console_force_preferred_locked(struct console *con)
>  
>  	/* Only the new head can have CON_CONSDEV set. */
>  	console_srcu_write_flags(cur_pref_con, cur_pref_con->flags & ~CON_CONSDEV);
> -	hlist_add_behind_rcu(&con->node, console_list.first);
> +	hlist_add_head_rcu(&con->node, &console_list);
>  }
>  EXPORT_SYMBOL(console_force_preferred_locked);

With this change:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
