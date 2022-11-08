Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED93962193A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 17:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234604AbiKHQSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 11:18:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234589AbiKHQSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 11:18:37 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F0D13F2B
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 08:18:36 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D965322331;
        Tue,  8 Nov 2022 16:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667924314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q52jpOXZyIMOLYM3VzT7nOe+GQZPnYoB6CVxGy0LsBQ=;
        b=gL5N8duyJH/8+t2m6Ch+xS8f8Xlfsd6w7+2Fe/gV4gWdg21gJcLx5q5PmiOxfC3RahK7GM
        KRyB3mBpD89ybHADhOv1bEfSaNWicoojf2pR8p/BnPJ5n7CzFmnTKdDCMFwVv4iidkUtlP
        E7ckttU+egw3VPOK2o5ThUhiNOwUZvI=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 504612C141;
        Tue,  8 Nov 2022 16:18:33 +0000 (UTC)
Date:   Tue, 8 Nov 2022 17:18:29 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v3 07/40] console: introduce console_is_enabled()
 wrapper
Message-ID: <Y2qBVZQDYnxv1af0@alley>
References: <20221107141638.3790965-1-john.ogness@linutronix.de>
 <20221107141638.3790965-8-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107141638.3790965-8-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-11-07 15:22:05, John Ogness wrote:
> After switching to SRCU for console list iteration, some readers
> will begin readings console->flags as a data race. Locklessly
> reading console->flags provides a consistent value because there
> is at most one CPU modifying console->flags and that CPU is
> using only read-modify-write operations.
> 
> The primary reason for readers to access console->flags is to
> check if the console is enabled. Introduce console_is_enabled()
> to mark such access as a data race.
>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  include/linux/console.h | 27 +++++++++++++++++++++++++++
>  kernel/printk/printk.c  | 10 +++++-----
>  2 files changed, 32 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/console.h b/include/linux/console.h
> index f4f0c9523835..d9c636011364 100644
> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -172,6 +172,33 @@ extern void console_srcu_read_unlock(int cookie);
>  
>  extern struct hlist_head console_list;
>  
> +/**
> + * console_is_enabled - Locklessly check if the console is enabled
> + * @con:	struct console pointer of console to check
> + *
> + * Unless the caller is explicitly synchronizing against the console
> + * register/unregister/stop/start functions, this function should be
> + * used instead of manually readings console->flags and testing for
> + * the CON_ENABLED bit.
> + *
> + * This function provides the necessary READ_ONCE() and data_race()
> + * notation for locklessly reading the console flags. The READ_ONCE()
> + * in this function matches the WRITE_ONCE() when @flags are modified
> + * for registered consoles.
> + *
> + * Context: Any context.
> + */
> +static inline bool console_is_enabled(const struct console *con)
> +{
> +	/*
> +	 * Locklessly reading console->flags provides a consistent
> +	 * read value because there is at most one CPU modifying
> +	 * console->flags and that CPU is using only read-modify-write
> +	 * operations to do so.
> +	 */
> +	return (data_race(READ_ONCE(con->flags)) & CON_ENABLED);

This API is step into the right direction, definitely. I am just not
sure about all the related READ_WRITE() calls, see below. It is not
easy to check and maintain.

> +}
> +
>  /**
>   * for_each_console_srcu() - Iterator over registered consoles
>   * @con:	struct console pointer used as loop cursor
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 8974523f3107..79811984da34 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3021,7 +3021,7 @@ void console_stop(struct console *console)
>  {
>  	__pr_flush(console, 1000, true);
>  	console_lock();
> -	console->flags &= ~CON_ENABLED;
> +	WRITE_ONCE(console->flags, console->flags & ~CON_ENABLED);

My first reaction is that using the atomic operation only for the
store side is suspicious. It is correct because the read is serialized
by console_lock(). But it is far from obvious why we need and can do it
this way.

It would deserve a comment. But there are several other writes.
Also it is not obvious why many other con->flags modifications
do not need this.

I think about hiding this into an API. We could also add some
checks that it is used the right way. Also it might make sense
to avoid using the READ_ONCE()/WRITE_ONCE by using
set_bit()/test_bit().

I mean the following:

/**
  * console_set_flag - set the given console flag
  *
  * @con:	 A pointer to struct console
  * @flag_bit:	 Number of the bit that will be set
  *
  * Must be called under console_lock() when the console
  * is registered. Serialization for non-registered
  * console is up to the related console driver code.
  *
  * Never access console->flags directly.
  */
void console_set_flag(struct console *con, int flag_nr)
{
	WARN_ON_ONCE(console_is_registered(con) && !held_console_lock());

	if (WARN_ON_ONCE(flag_nr) >= sizeof(con->flags);
		return;

	set_bit(flag_nr, &con->flags);
}

bool console_check_flag(const struct console *con, int flag_nr)
{
	WARN_ON_ONCE(console_is_registered(con) && !held_console_lock());

	if (WARN_ON_ONCE(flag_nr) >= sizeof(con->flags);
		return;

	return test_bit(flag_nr, &con->flags);
}

We could then use it directly:

	if (console_check_flag(con, CON_ENABLED_BIT))
		...

or we could hide it into a wrapper. Safe access:

static inline bool console_is_enabled(const struct console *con)
   {
	return console_check_bit(con, CON_ENABLED_BIT);
   }


The above is for the safe access. Another wrapper would be needed
for the unsafe access.

/**
  * console_check_flag_unsafe - check console flag without
  *	synchronization
  *
  * @con:	 A pointer to struct console
  * @flag_bit:	 Number of the bit that will be set
  *
  * Must be called under console_srcu_read_lock() when the console
  * is registered. Use console_check_flag() in all other situations.
  *
  * Never access console->flags directly.
  */
bool console_check_flag_unsafe(const struct console *con, int flag_nr)
{
	WARN_ON_ONCE(console_is_registered(con) && !console_srcu_read_lock_is_held());

	if (WARN_ON_ONCE(flag_nr) >= sizeof(con->flags);
		return;

	return data_race(test_bit(flag_nr, &con->flags));
}

Most callers should use the safe variant. It will even check that it
is really used the safe way. Only the few users of _unsafe() variant
would need an extra comment why it is acceptable.

I know that it is more work. There seem to be 49 locations that would
need update at this point. Some of them are touched by the patchset
anyway. There are "only" 39 accesses at the end of the patchset.

I used the following query:

$> git grep -e "\->flags.*CON_" | grep -v "\.flags" | grep -E "(c|con|cons|console)->flags" | wc -l
39

>  	console_unlock();
>  
>  	/*

I would prefer to use the proposed API because it should make all accesses more
clear and safe. And most importantly, it would help use to catch bugs.

But I do not resist on it. The patch looks correct and we could do
this later. I could live with it if we add some comments
above the WRITE_ONCE() calls.

Best Regards,
Petr
