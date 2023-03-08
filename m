Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 310A76B0BA4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 15:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjCHOmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 09:42:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbjCHOmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 09:42:02 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0A15AB51
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 06:40:07 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0256B21A52;
        Wed,  8 Mar 2023 14:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1678286406; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9Nej/Xmw3KaCypC9ifrRCpOYBycrY2TTcetRXK8NFjA=;
        b=udEwvW5YKzK+Efn7XqDsoag9gp93WC6AE0IW2BgxELZSIkl6Cb7kswhgM+T7RrHcGTNzGV
        TUkw9ZLfTzfg8LlhRqNdEZ4bsJ984jxnn26eAFn9yPlwm7KkpPa64Noon+enpu6vgWLE+M
        0uLJ4VdAhZ9iLNtKVXj0WhXGZN9Yrvg=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 950722C141;
        Wed,  8 Mar 2023 14:40:05 +0000 (UTC)
Date:   Wed, 8 Mar 2023 15:40:02 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v1 04/18] printk: Add per-console suspended state
Message-ID: <ZAieQtcs7YEuCCDa@alley>
References: <20230302195618.156940-1-john.ogness@linutronix.de>
 <20230302195618.156940-5-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302195618.156940-5-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2023-03-02 21:02:04, John Ogness wrote:
> Currently the global @console_suspended is used to determine if
> consoles are in a suspended state. Its primary purpose is to allow
> usage of the console_lock when suspended without causing console
> printing. It is synchronized by the console_lock.
> 
> Rather than relying on the console_lock to determine suspended
> state, make it an official per-console state that is set within
> console->flags. This allows the state to be queried via SRCU.
> 
> @console_suspended will continue to exist, but now only to implement
> the console_lock/console_unlock trickery and _not_ to represent
> the suspend state of a particular console.
> 
> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -153,6 +153,8 @@ static inline int con_debug_leave(void)
>   *			receiving the printk spam for obvious reasons.
>   * @CON_EXTENDED:	The console supports the extended output format of
>   *			/dev/kmesg which requires a larger output buffer.
> + * @CON_SUSPENDED:	Indicates if a console is suspended. If true, the
> + *			printing callbacks must not be called.
>   */
>  enum cons_flags {
>  	CON_PRINTBUFFER		= BIT(0),
> @@ -162,6 +164,7 @@ enum cons_flags {
>  	CON_ANYTIME		= BIT(4),
>  	CON_BRL			= BIT(5),
>  	CON_EXTENDED		= BIT(6),
> +	CON_SUSPENDED		= BIT(7),

We have to show it in /proc/consoles, see fs/proc/consoles.c.

> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2563,10 +2563,26 @@ MODULE_PARM_DESC(console_no_auto_verbose, "Disable console loglevel raise to hig
>   */
>  void suspend_console(void)
>  {
> +	struct console *con;
> +
>  	if (!console_suspend_enabled)
>  		return;
>  	pr_info("Suspending console(s) (use no_console_suspend to debug)\n");
>  	pr_flush(1000, true);
> +
> +	console_list_lock();
> +	for_each_console(con)
> +		console_srcu_write_flags(con, con->flags | CON_SUSPENDED);
> +	console_list_unlock();
> +
> +	/*
> +	 * Ensure that all SRCU list walks have completed. All printing
> +	 * contexts must be able to see that they are suspended so that it
> +	 * is guaranteed that all printing has stopped when this function
> +	 * completes.
> +	 */
> +	synchronize_srcu(&console_srcu);
> +
>  	console_lock();
>  	console_suspended = 1;
>  	up_console_sem();
> @@ -2574,11 +2590,26 @@ void suspend_console(void)
>  
>  void resume_console(void)
>  {
> +	struct console *con;
> +
>  	if (!console_suspend_enabled)
>  		return;
>  	down_console_sem();
>  	console_suspended = 0;
>  	console_unlock();
> +
> +	console_list_lock();
> +	for_each_console(con)
> +		console_srcu_write_flags(con, con->flags & ~CON_SUSPENDED);
> +	console_list_unlock();
> +
> +	/*
> +	 * Ensure that all SRCU list walks have completed. All printing
> +	 * contexts must be able to see they are no longer suspended so
> +	 * that they are guaranteed to wake up and resume printing.
> +	 */
> +	synchronize_srcu(&console_srcu);
> +

The setting of the global "console_suspended" and per-console
CON_SUSPENDED flag is not synchronized. As a result, they might
become inconsistent:

CPU0				CPU1

suspend_console()
  console_list_lock();
  # set CON_SUSPENDED
  console_list_unlock();

				console_resume()
				  down_console_sem();
				  console_suspended = 0;
				  console_unlock();

				  console_list_lock()
				  # clear CON_SUSPENDED
				  console_list_unlock();

  console_lock();
  console_suspended = 1;
  up_console_sem();

I think that we could just remove the global "console_suspended" flag.

IMHO, it used to be needed to avoid moving the global "console_seq" forward
when the consoles were suspended. But it is not needed now with the
per-console con->seq. console_flush_all() skips consoles when
console_is_usable() fails and it bails out when there is no progress.

It seems that both console_flush_all() and console_unlock() would
handle this correctly.

Hmm, it would change the behavior of console_lock() and console_trylock().
They would set "console_locked" and "console_may_schedule" even when
the consoles are suspended. But it should be OK:

   + "console_may_schedule" actually should be set according
     to the context where console_unlock() will be called.

   + "console_locked" seems to be used only in WARN_CONSOLE_UNLOCKED().
     I could imagine a corner case where, for example, "vt" code does
     not print the warning because it works as it works. But it does
     not make much sense. IMHO, such a code should get fixed. And it
     is just a warning after all.

>  	pr_flush(1000, true);
>  }
>  
> @@ -3712,14 +3745,7 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
>  		}
>  		console_srcu_read_unlock(cookie);
>  
> -		/*
> -		 * If consoles are suspended, it cannot be expected that they
> -		 * make forward progress, so timeout immediately. @diff is
> -		 * still used to return a valid flush status.
> -		 */
> -		if (console_suspended)
> -			remaining = 0;

Heh, I though that this might cause regression, e.g. non-necessary
delays during suspend.

But it actually works because "diff" is counted only for usable
consoles. It will stay "0" if there is no usable console.

I wonder if it would make sense to add a comment somewhere,
e.g. above the later check:

+		/* diff is zero also when there is no usable console. */
		if (diff == 0 || remaining == 0)
			break;

Anyway, we should update the comment above pr_flush():

-  * Return: true if all enabled printers are caught up.
+  * Return: true if all usable printers are caught up.

> -		else if (diff != last_diff && reset_on_progress)
> +		if (diff != last_diff && reset_on_progress)
>  			remaining = timeout_ms;
>  
>  		console_unlock();

Best Regards,
Petr
