Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFB1460F8DE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 15:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236045AbiJ0NSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 09:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235984AbiJ0NS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 09:18:27 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD478E781;
        Thu, 27 Oct 2022 06:18:27 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B61C121BA3;
        Thu, 27 Oct 2022 13:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666876705; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RS4nUztMlT4sqHAFv70WY2xp371wMgrBVx/69bIOcds=;
        b=Pc8De5jHGsaMKpOgz+pwUzsiu6bIHhUw1tQKxuOOsNDG5/uS4xmTsUhEhqS/iUpdMqLcpl
        ri+Tin761jQSWHyTK16SC3/R7c+sgONlBaAzV9i6eoHm1DgqyrVdkSPyie8nuI2QwXVBeK
        xca3nLpXcWa1BrYQrfSwyXDLrpO02dw=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4D1232C141;
        Thu, 27 Oct 2022 13:18:25 +0000 (UTC)
Date:   Thu, 27 Oct 2022 15:18:21 +0200
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
Subject: Re: [PATCH printk v2 38/38] printk, xen: fbfront: create/use safe
 function for forcing preferred
Message-ID: <Y1qFHbi39SpTggPH@alley>
References: <20221019145600.1282823-1-john.ogness@linutronix.de>
 <20221019145600.1282823-39-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019145600.1282823-39-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-10-19 17:02:00, John Ogness wrote:
> With commit 9e124fe16ff2("xen: Enable console tty by default in domU
> if it's not a dummy") a hack was implemented to make sure that the
> tty console remains the console behind the /dev/console device. The
> main problem with the hack is that, after getting the console pointer
> to the tty console, it is assumed the pointer is still valid after
> releasing the console_sem. This assumption is incorrect and unsafe.
> 
> Make the hack safe by introducing a new function
> console_force_preferred() to perform the full operation under
> the console_list_lock.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  drivers/video/fbdev/xen-fbfront.c |  8 +---
>  include/linux/console.h           |  1 +
>  kernel/printk/printk.c            | 69 +++++++++++++++++++------------
>  3 files changed, 46 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/video/fbdev/xen-fbfront.c b/drivers/video/fbdev/xen-fbfront.c
> index 2552c853c6c2..aa362b25a60f 100644
> --- a/drivers/video/fbdev/xen-fbfront.c
> +++ b/drivers/video/fbdev/xen-fbfront.c
> @@ -512,12 +512,8 @@ static void xenfb_make_preferred_console(void)
>  	}
>  	console_srcu_read_unlock(cookie);
>  
> -	if (c) {
> -		unregister_console(c);
> -		c->flags |= CON_CONSDEV;
> -		c->flags &= ~CON_PRINTBUFFER; /* don't print again */
> -		register_console(c);
> -	}
> +	if (c)
> +		console_force_preferred(c);

I would prefer to fix this a clean way. The current code is a real hack.
It tries to find a console under console_srcu. Then the console
is unregistered, flags are modified, and gets registered again.
The locks are released between all these operations.

I would suggest to implement:

void console_force_preferred_locked(struct console *new_pref_con)
{
	struct console *cur_pref_con;

	assert_console_list_lock_held();

	if (hlist_unhashed(&new_pref_con->node))
		return;

	for_each_console(cur_pref_con) {
		if (cur_pref_con->flags & CON_CONSDEV)
			break;
	}

	/* Already preferred? */
	if (cur_pref_con == new_pref_con)
		return;

	hlist_del_init_rcu(&new_pref_con->node);
	/*
	 * Ensure that all SRCU list walks have completed before @con
	 * is added back as the first console
	 */
	synchronize_srcu()
	hlist_add_behind_rcu(&new_pref_con->node, console_list.first);

	cur_pref_con->flags &= ~CON_CONSDEV;
	new_pref_con->flags |= CON_CONSDEV;
}

And do:

static void xenfb_make_preferred_console(void)
{
	struct console *c;

	if (console_set_on_cmdline)
		return;

	console_list_lock();
	for_each_console(c) {
		if (!strcmp(c->name, "tty") && c->index == 0)
			break;
	}

	if (c)
		console_force_preferred_locked(c);

	console_list_unlock();
}

It is a more code. But it is race-free. Also it is much more clear
what is going on.

How does this sound, please?

Best Regards,
Petr
