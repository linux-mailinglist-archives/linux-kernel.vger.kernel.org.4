Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05874624606
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 16:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbiKJPfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 10:35:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiKJPen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 10:34:43 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EBB76307;
        Thu, 10 Nov 2022 07:34:33 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id F11F01FB23;
        Thu, 10 Nov 2022 15:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1668094471; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bEnHdqT3DcxO4MFxMqMVX1EoQDRxqFNIevVZKsxI/LU=;
        b=oeljd555OxLi7NkR4t4QIAONG3HeiofBo3qDfkpKApXXFzPPSuFTVvdTbmHaHfD+5pvN0K
        k8yIVvOdjerAWOH9reqwqRHFL91yEnyVYozzgEqXgVyxW5DfV0oy7Mo1lpOEeNXWxzvdtS
        HGPa2+4O2MEJLyq0fZ44v+PZcohZDgc=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A89862C141;
        Thu, 10 Nov 2022 15:34:31 +0000 (UTC)
Date:   Thu, 10 Nov 2022 16:34:31 +0100
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
Subject: Re: [PATCH printk v3 33/40] printk, xen: fbfront: create/use safe
 function for forcing preferred
Message-ID: <Y20aBwNWT19YDeib@alley>
References: <20221107141638.3790965-1-john.ogness@linutronix.de>
 <20221107141638.3790965-34-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107141638.3790965-34-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-11-07 15:22:31, John Ogness wrote:
> With commit 9e124fe16ff2("xen: Enable console tty by default in domU
> if it's not a dummy") a hack was implemented to make sure that the
> tty console remains the console behind the /dev/console device. The
> main problem with the hack is that, after getting the console pointer
> to the tty console, it is assumed the pointer is still valid after
> releasing the console_sem. This assumption is incorrect and unsafe.
> 
> Make the hack safe by introducing a new function
> console_force_preferred_locked() and perform the full operation
> under the console_list_lock.
> 
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3457,6 +3458,43 @@ int unregister_console(struct console *console)
>  }
>  EXPORT_SYMBOL(unregister_console);
>  
> +/**
> + * console_force_preferred_locked - force a registered console preferred
> + * @con: The registered console to force preferred.
> + *
> + * Must be called under console_list_lock().
> + */
> +void console_force_preferred_locked(struct console *con)
> +{
> +	struct console *cur_pref_con;
> +
> +	if (!console_is_registered_locked(con))
> +		return;
> +
> +	cur_pref_con = console_first();
> +
> +	/* Already preferred? */
> +	if (cur_pref_con == con)
> +		return;
> +
> +	hlist_del_init_rcu(&con->node);

We actually should re-initialize the node only after all existing
console list walks are finished. Se we should use here:

	hlist_del_rcu(&con->node);

> +
> +	/*
> +	 * Ensure that all SRCU list walks have completed so that the console
> +	 * can be added to the beginning of the console list and its forward
> +	 * list pointer can be re-initialized.

The comment is right ;-)

> +	 */
> +	synchronize_srcu(&console_srcu);
> +
> +	con->flags |= CON_CONSDEV;
> +	WARN_ON(!con->device);
> +
> +	/* Only the new head can have CON_CONSDEV set. */
> +	WRITE_ONCE(cur_pref_con->flags, cur_pref_con->flags & ~CON_CONSDEV);

As mentioned in the reply for 7th patch, I would prefer to hide this
WRITE_ONCE into a wrapper, e.g. console_set_flag(). It might also
check that the console_list_lock is taken...


> +	hlist_add_behind_rcu(&con->node, console_list.first);
> +}
> +EXPORT_SYMBOL(console_force_preferred_locked);
> +
>  /*
>   * Initialize the console device. This is called *early*, so
>   * we can't necessarily depend on lots of kernel help here.

Best Regards,
Petr
