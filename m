Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8074C5EBF15
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 11:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbiI0J4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 05:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbiI0J4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 05:56:33 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E6260529
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 02:56:32 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E0E8C21CFD;
        Tue, 27 Sep 2022 09:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664272590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SsFlZVhnAlWJT1H2/PkcPlbNRl2sk4GBcclzoTxgr48=;
        b=dsDtG87TjPPnF+pS0LkQS82nBxvxETj/La9Ls95Y0X1+dE3FWjwAaLByxz+jFvYWV2EZnT
        zhYWD1iFxs1uts95te6m6RDiFtZhKel2XnrEX0JITr5uwAJXyPy2woaG5Kzm8SlPd9xzKA
        q9pdJTYTv3iu7EiwmluLr6mZh6Z//2U=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id DD4CD2C162;
        Tue, 27 Sep 2022 09:56:28 +0000 (UTC)
Date:   Tue, 27 Sep 2022 11:56:27 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [patch RFC 06/29] printk: Protect [un]register_console() with a
 mutex
Message-ID: <YzLIy4emYX6JpzuN@alley>
References: <20220910221947.171557773@linutronix.de>
 <20220910222300.712668210@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220910222300.712668210@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 2022-09-11 00:27:41, Thomas Gleixner wrote:
> Unprotected list walks are a brilliant idea. Especially in the context of
> hotpluggable consoles.

Yeah, it is crazy. And it is there probably since the beginning.

> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -79,10 +79,14 @@ int oops_in_progress;
>  EXPORT_SYMBOL(oops_in_progress);
>  
>  /*
> - * console_sem protects the console_drivers list, and also
> - * provides serialisation for access to the entire console
> - * driver system.
> + * console_sem protects the console_drivers list, and also provides
> + * serialization for access to the entire console driver system.
> + *
> + * console_mutex serializes register/unregister. console_sem has to be
> + * taken for any list manipulation inside the console_mutex locked
> + * section to keep the console BKL machinery happy.
>   */
> +static DEFINE_MUTEX(console_mutex);
>  static DEFINE_SEMAPHORE(console_sem);
>  struct console *console_drivers;
>  EXPORT_SYMBOL_GPL(console_drivers);
> @@ -220,6 +230,26 @@ int devkmsg_sysctl_set_loglvl(struct ctl
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
> +
>  /*
>   * Helper macros to handle lockdep when locking/unlocking console_sem. We use
>   * macros instead of functions so that _RET_IP_ contains useful information.
> @@ -3107,13 +3143,14 @@ void register_console(struct console *ne
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
