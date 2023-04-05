Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC806D7A44
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 12:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237859AbjDEKsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 06:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237636AbjDEKsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 06:48:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F164F5254
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 03:48:29 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A67361FD86;
        Wed,  5 Apr 2023 10:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1680691708; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i6DNxU7vd6uPdPD8dniQNPms12R+FLtjPjnp5d2co18=;
        b=Vj5KghmZObCCzp6zxDWYAMIbOvKrXdvxG5L1ScX1dZGczTbR9bT5/dFI8JA2lBAYYCjVo3
        +GNNN34eC5EOxnVI8kh1NN04JUsim7fCbH/bOaJxA/qetzatzDqcqO6BBCz4lOQe2/aJLI
        rG0gTZnIZ/SQB5mV9/vrBk8+4mAVorU=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4AD4C2C141;
        Wed,  5 Apr 2023 10:48:28 +0000 (UTC)
Date:   Wed, 5 Apr 2023 12:48:25 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: boot console: was: Re: [PATCH printk v1 11/18] printk: nobkl:
 Introduce printer threads
Message-ID: <ZC1R+fzuTNodWvfY@alley>
References: <20230302195618.156940-1-john.ogness@linutronix.de>
 <20230302195618.156940-12-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302195618.156940-12-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2023-03-02 21:02:11, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Add the infrastructure to create a printer thread per console along
> with the required thread function, which is takeover/handover aware.
> 
> --- a/kernel/printk/internal.h
> +++ b/kernel/printk/internal.h
> @@ -75,6 +77,55 @@ u64 cons_read_seq(struct console *con);
>  void cons_nobkl_cleanup(struct console *con);
>  bool cons_nobkl_init(struct console *con);
>  bool cons_alloc_percpu_data(struct console *con);
> +void cons_kthread_create(struct console *con);
> +
> +/*
> + * Check if the given console is currently capable and allowed to print
> + * records. If the caller only works with certain types of consoles, the
> + * caller is responsible for checking the console type before calling
> + * this function.
> + */
> +static inline bool console_is_usable(struct console *con, short flags)
> +{
> +	if (!(flags & CON_ENABLED))
> +		return false;
> +
> +	if ((flags & CON_SUSPENDED))
> +		return false;
> +
> +	/*
> +	 * The usability of a console varies depending on whether
> +	 * it is a NOBKL console or not.
> +	 */
> +
> +	if (flags & CON_NO_BKL) {
> +		if (have_boot_console)
> +			return false;

I am not sure if this is the right place to discuss it.
Different patches add pieces that are part of the puzzle.

Anyway, how are the NOBKL consoles supposed to work when a boot console
is still registered, please?

I see that a later patch adds:

asmlinkage int vprintk_emit(int facility, int level,
			    const struct dev_printk_info *dev_info,
			    const char *fmt, va_list args)
{
[...]
	/*
	 * Flush the non-BKL consoles. This only leads to direct atomic
	 * printing for non-BKL consoles that do not have a printer
	 * thread available. Otherwise the printer thread will perform
	 * the printing.
	 */
	cons_atomic_flush(&wctxt, true);
[...]
}

This patch adds cons_kthread_create(). And it refuses to create
the kthread as long as there is a boot console registered.

Finally, a later added cons_atomic_flush() ignores consoles where
console_is_usable() returns false:

void cons_atomic_flush(struct cons_write_context *printk_caller_wctxt, bool skip_unsafe)
{
[...]
	for_each_console_srcu(con) {
[...]
		if (!console_is_usable(con, flags))
			continue;

It looks to me that NOBKL consoles will not show anything as long as
a boot console is registered.

And the boot console might never be removed when "keep_bootcon"
parameter is used.


Sigh, this looks like a non-trivial problem. I see it as a combination
of two things:

   + NOBKL consoles are independent. And this is actually one
     big feature.

   + There is no 1:1 relation between boot and real console using
     the same output device (serial port). I mean that
     register_console() is not able to match which real console
     is replacing a particular boot console.

As a result, we could not easily synchronize boot and the related real
console against each other.

I see three possible solutions:

A) Ignore this problem. People are most likely using only one boot
   console. And the real console will get enabled "immediately"
   after this console gets removed. So that there should not be
   any gap.

   The only problem is that people use more real consoles. And
   also unrelated real consoles will not see anything.

   I guess that people might notice that they do not see anything
   on ttyX console until ttySX replaces an early serial console.
   And they might consider this as a regression.


B) Allow to match boot and real consoles using the same output device
   and properly synchronize them against each other.

   It might mean:

       + sharing the same atomic lock (atomic_state)
       + sharing the same device (port) lock
       + avoid running both at the same time by a careful
	 switch during the registration of the real console

    , where sharing the same port lock might theoretically be done
    without 1:1 matching of the related console drivers. They
    would use the same port->lock spin_lock.

    This might also fix the ugly race during console registration
    when we unregister the boot console too early or too late.
    The switch between a boot and the related real console might be
    always smooth.

    The problem is that it might be pretty complicated to achieve
    this.


C) Synchronize also NOBKL consoles using console_sem until
   all boot consoles are removed and kthreads started.

   I might actually be pretty easy. It might be enough to
   move cons_flush_all() from vprintk_emit() into
   console_flush_all() that is called under console_lock().

   I think that we need to keep cons_flush_all() in vprintk_emit()
   to emit the messages directly in EMERGENCY and PANIC modes.
   But we do not need or must not call it there when there is
   still a boot console. We would know that it will called later
   from console_unlock() in this case.


My preferences:

   + A probably is not acceptable. It would make me feel very
     uncomfortable, definitely.

   + B looks like the best solution but it might be very hard to achieve.

   + C seems to be good enough for now.

I think that C is the only realistic way to go unless there is another
reasonable solution.

Best Regards,
Petr
