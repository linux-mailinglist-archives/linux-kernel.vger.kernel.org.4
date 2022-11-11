Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F31625857
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 11:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233893AbiKKK2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 05:28:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233876AbiKKK1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 05:27:42 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701D917596
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 02:27:27 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 02F6C22A78;
        Fri, 11 Nov 2022 10:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1668162446; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zRnotCSwwpTe65f/KJdeiKaNSmLCv5EuT1e7hywId2U=;
        b=Hk6k65GZEtfwzi/hIlqDUlb2hm9Hxrqyh57Yn5ppiolHk5skH8sH+Z4lMY9HZ0U37DIJ5L
        5nbjZuys5QG/Hntq+WZMlYvK1ddoSmcnoUiI6tFm2PgEFPCIDLwgf1LS0OQwW7SbfZtQE3
        ppHudoLNs6UjeVOPQUmgWnx+pDBdHBI=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A9E842C142;
        Fri, 11 Nov 2022 10:27:25 +0000 (UTC)
Date:   Fri, 11 Nov 2022 11:27:25 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 39/40] printk: relieve console_lock of list
 synchronization duties
Message-ID: <Y24jjYXuNRdVoNns@alley>
References: <20221107141638.3790965-1-john.ogness@linutronix.de>
 <20221107141638.3790965-40-john.ogness@linutronix.de>
 <87r0ye916v.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r0ye916v.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-11-07 17:36:48, John Ogness wrote:
> On 2022-11-07, John Ogness <john.ogness@linutronix.de> wrote:
> > @@ -3344,7 +3340,6 @@ void register_console(struct console *newcon)
> >  	 * Put this console in the list - keep the
> >  	 * preferred driver at the head of the list.
> >  	 */
> > -	console_lock();
> >  	if (hlist_empty(&console_list)) {
> >  		/* Ensure CON_CONSDEV is always set for the head. */
> >  		newcon->flags |= CON_CONSDEV;
> > @@ -3358,7 +3353,6 @@ void register_console(struct console *newcon)
> >  	} else {
> >  		hlist_add_behind_rcu(&newcon->node, console_list.first);
> >  	}
> > -	console_unlock();
> >  
> >  	/*
> >  	 * No need to synchronize SRCU here! The caller does not rely
> 
> I just realized that because of the new @seq initialization (patch 5/40)
> that we cannot completely remove the console_lock from
> register_console(). It will still be needed for @seq synchronization
> when registering non-boot/non-printbuffer consoles. So something like
> the patch below will need to be folded into this one.

Great catch!

> I am not happy with this. If an enabled boot console is behind, the
> console_unlock() will probably catch it up and we will end up with some
> repeat messages. But maybe this is "good enough" until we implement some
> real coordination between boot console and normal console takeovers.

The same problem actually has been there even before. The new console
was added in console_list under console_lock(). console_unlock() was
called before the early consoles were unregistered.

A solution would be to call pr_flush() before. But it should be
done in a separate patch.

> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 17765166ac42..bb119001df56 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3328,12 +3328,21 @@ void register_console(struct console *newcon)
>  		 * that message instead. That boot console will be
>  		 * unregistered shortly and may be the same device.
>  		 */
> +
> +		/*
> +		 * Hold the console_lock to guarantee safe access to
> +		 * console->seq.
> +		 */
> +		console_lock();
> +
>  		for_each_console(con) {
>  			if ((con->flags & (CON_BOOT | CON_ENABLED)) == (CON_BOOT | CON_ENABLED) &&
>  			    con->seq < newcon->seq) {
>  				newcon->seq = con->seq;
>  			}
>  		}
> +
> +		console_unlock();
>  	}

This should be added already into the 5th patch that added this cycle.
We just must keep it in this patch.

Best Regards,
Petr
