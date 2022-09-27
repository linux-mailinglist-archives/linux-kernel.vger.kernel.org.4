Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A1C5EC768
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 17:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbiI0PQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 11:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbiI0PQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 11:16:46 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1588A25E8C
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 08:16:45 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C2D6221E3A;
        Tue, 27 Sep 2022 15:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664291803; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l863TnADW8A+KFXaP1zkrBX063qaTxnEnnonHXQrUr0=;
        b=IIjmz6zUA1Syp22HeQ+74uDldGXkA/PO3T+tzpudbbakMO8caD4vlPWmrLt3D2vOgD9Yff
        oUZ+EOoeOtscUFJWATxFhlo5x9Bdq9jroGXKkDHi2XqKoIPKyuw6oKntJ4RmqzRn9UZC1r
        3w+d5skYK3BruUEPtHtF372Fy8WedvM=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 7414F2C16B;
        Tue, 27 Sep 2022 15:16:43 +0000 (UTC)
Date:   Tue, 27 Sep 2022 17:16:43 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk 06/18] printk: Protect [un]register_console() with
 a mutex
Message-ID: <YzMT27FVllY3u05k@alley>
References: <20220924000454.3319186-1-john.ogness@linutronix.de>
 <20220924000454.3319186-7-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220924000454.3319186-7-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resending my review on this patch also in this patchset.
I sent the review also to the RFC patchset by mistake, see
https://lore.kernel.org/r/YzLIy4emYX6JpzuN@alley

Please, continue the discussion here where I did review of the other patches.

On Sat 2022-09-24 02:10:42, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Unprotected list walks are a brilliant idea. Especially in the context of
> hotpluggable consoles.

Yeah, it is crazy. And it is there probably since the beginning.

> The new list lock provides not only synchronization for console list
> manipulation, but also for manipulation of console->flags:
> 
>     console_list_lock();
>     console_lock();
> 
>     /* may now manipulate the console list and/or console->flags */
> 
>     console_unlock();
>     console_list_unlock();
> 
> Therefore it is safe to iterate the console list and read console->flags
> if holding either the console lock or the console list lock.
> 
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -79,10 +79,17 @@ int oops_in_progress;
>  EXPORT_SYMBOL(oops_in_progress);
>  
>  /*
> - * console_sem protects the console_drivers list, and also
> - * provides serialisation for access to the entire console
> - * driver system.
> + * console_sem protects the console_drivers list, and also provides
> + * serialization for access to the entire console driver system.
> + *
> + * console_mutex serializes register/unregister.
> + *
> + * console_sem must be taken inside a console_mutex locked section
> + * for any list manipulation in order to keep the console BKL
> + * machinery happy. This requirement also applies to manipulation
> + * of console->flags.
>   */
> +static DEFINE_MUTEX(console_mutex);
>  static DEFINE_SEMAPHORE(console_sem);
>  struct console *console_drivers;
>  EXPORT_SYMBOL_GPL(console_drivers);
> @@ -220,6 +233,28 @@ int devkmsg_sysctl_set_loglvl(struct ctl_table *table, int write,
>  }
>  #endif /* CONFIG_PRINTK && CONFIG_SYSCTL */
>  
> +/**
> + * console_list_lock - Lock the console list
> + *
> + * For non-console related list walks, e.g. procfs, sysfs...
> + */
> +void console_list_lock(void)
> +{
> +	mutex_lock(&console_mutex);
> +}
> +EXPORT_SYMBOL(console_list_lock);
> +
> +/**
> + * console_list_unlock - Unlock the console list
> + *
> + * Counterpart to console_list_lock()
> + */
> +void console_list_unlock(void)
> +{
> +	mutex_unlock(&console_mutex);
> +}
> +EXPORT_SYMBOL(console_list_unlock);
> +
>  /*
>   * Helper macros to handle lockdep when locking/unlocking console_sem. We use
>   * macros instead of functions so that _RET_IP_ contains useful information.
> @@ -3081,6 +3120,8 @@ static void try_enable_default_console(struct console *newcon)
>  	       (con->flags & CON_BOOT) ? "boot" : "",	\
>  	       con->name, con->index, ##__VA_ARGS__)
>  
> +static int console_unregister_locked(struct console *console);
> +
>  /*
>   * The console driver calls this routine during kernel initialization
>   * to register the console printing procedure with printk() and to
> @@ -3107,13 +3148,14 @@ void register_console(struct console *newcon)
>  	bool realcon_enabled = false;
>  	int err;
>  
> -	for_each_console(con) {
> +	console_list_lock();

Hmm, the new mutex is really nasty. It has very strange semantic.
It makes the locking even more complicated.

The ideal solution would be take console_lock() here. We (me and
Sergey) never did it because con->match() and con->setup()
callbacks were called in try_enable_*console(). We were afraid
that some might want to take console_lock() and it could create
a deadlock. There were too many drivers and we did not found time
to check them all. And it had low priority because nobody reported
problems.

A good enough solution might be call this under the later
added srcu_read_lock(&console_srcu) and use for_each_console_srcu().

The srcu walk would prevent seeing broken list. Obviously,
the code might see outdated list and do bad decisions:

  + try to enable the same console twice

  + enable more consoles by default in try_enable_default_console()

  + associate more consoles with /dev/console, see CON_CONSDEV in
    try_enable_preferred_console() and try_enable_default_console()

If we race then we could end up with more consoles enabled by default
and with more consoles with CON_CONSDEV flag.

IMHO, the rcu walk is an acceptable and conservative solution.
Registering the same driver twice is hard to imagine at all.
And I have never seen reports about too many default consoles
or CON_CONSDEV flags.

Anyway, I would like to avoid adding console_mutex. From my POV,
it is a hack that complicates the code. Taking console_lock()
should be enough. Using rcu walk would be good enough.

Do I miss something, please?

Or is this part of some strategy to remove console_sem later, please?

> +	for_each_registered_console(con) {
>  		if (WARN(con == newcon, "console '%s%d' already registered\n",
>  					 con->name, con->index))
> -			return;
> +			goto unlock;
>  	}
>  
> -	for_each_console(con) {
> +	for_each_registered_console(con) {
>  		if (con->flags & CON_BOOT)
>  			bootcon_enabled = true;
>  		else

Best Regards,
Petr
