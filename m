Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC7360F47C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 12:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235168AbiJ0KJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 06:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234172AbiJ0KJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 06:09:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C722ADF
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 03:09:38 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C45F522657;
        Thu, 27 Oct 2022 10:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666865376; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Cjny0V2bhM80AbILmv4Tgx5BaUyybTB3WskaslFfepU=;
        b=K664hOtAxq5hbAiXZsbH6d5lkX8imu4OWzxlmBX6TuzfNFKblkOe6bP1qeDOTuS3N8ToBX
        WmPuFrEWpUne0JY5DHh580KdJgciwqjG6MiC08PhMvDWKbMhb6QqkIA6h6oUWO5pLDMGZH
        NvoZzEFymQIHqcMB3ET/YPvfDrr93Yc=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 631932C141;
        Thu, 27 Oct 2022 10:09:36 +0000 (UTC)
Date:   Thu, 27 Oct 2022 12:09:32 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH printk v2 33/38] printk: introduce console_list_lock
Message-ID: <Y1pY3I1ufABvroYj@alley>
References: <20221019145600.1282823-1-john.ogness@linutronix.de>
 <20221019145600.1282823-34-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019145600.1282823-34-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Paul into Cc so that he is aware of using a custom SRCU lockdep
check in console_list_lock().

On Wed 2022-10-19 17:01:55, John Ogness wrote:
> Currently there exist races in console_register(), where the types
> of registered consoles are checked (without holding the console_lock)
> and then after acquiring the console_lock, it is assumed that the list
> has not changed. Also, some code that performs console_unregister()
> make similar assumptions.

This sounds like that the list lock is added just to fix the races.
People might wonder why it is not done using console_lock().
My understanding is that removing this responsibility from console_lock() is
the main motivation. It would deserve a comment, e.g.

<proposal>
A solution would be to synchronize this using console_lock(). But it
would require a complex analyze of all console drivers to make sure
that console_lock() is not taken in match() and setup() callbacks.
And splitting the responsibilities of console_lock() is actually
one big motivation here.

Instead, introduce a console_list_lock...
</proposal>

> Introduce a console_list_lock to provide full synchronization for any
> console list changes.

> The console_list_lock also provides synchronization for updates
> to console->flags.

This would deserve some explanation. The synchronization of the list
manipulation is obvious, especially when the lock is called
console_list_lock. But the motivation to use this lock
for console->flags is much more complicated.

I had some problems to create a reasonable mental model about it.
I did split the flags into groups:

  1. Flags that are driver-specific and static. They do not need
     any synchronization:

       + CON_BOOT
       + CON_ANYTIME


  2. Flags that are modified only during console registration [*]:

       + CON_PRINTBUFFER
       + CON_CONSDEV
       + CON_BRL
       + CON_EXTENDED

  3. Flags that might be modified by more operations, namely: console
     registration, start, and stop [*].

       + CON_ENABLED

[*] It is actually more complicated. Some flags are modified also
    outside console registration code. But we are not going to
    synchronize these changes because they are not visible
    to others via console_drivers list.

This explained why it made sense to synchronize console->flags using
console_list_lock. Also this explained why
console_start()/console_stop() were updated in this patch.

The following description would have helped me:

<proposal>
In addition, use console_list_lock also for synchronization of
console->flags updates. All flags are either static or modified
only during the console registration. There are only few
exceptions.

The only exception is CON_ENABLED that is modified also by
console_start()/console_stop(). We need to take console_list_lock()
here as well.

Another exception is when the flags are modified by the console
driver init code before the console gets registered. These will
be ignored because they are not visible to the rest of the system
via console_drivers list.
</proposal>

> Note that one of the various responsibilities of the console_lock is
> also intended to provide this synchronization. Later changes will
> update call sites relying on the console_lock for this purpose. Once
> all call sites have been updated, the console_lock will be relieved
> of synchronizing console_list and console->flags updates.

It seems that this patch actually updates all writers. It would be
nice to mention it to define the scope of this patch.

<proposal>
Note that one of the various responsibilities of the console_lock is
also intended to provide this synchronization. Only the callers that
modify the list or flags are updated here. Later changes will
update the readers Once all call sites have been updated,
the console_lock will be relieved of synchronizing console_list
and console->flags updates.
</proposal>

> diff --git a/include/linux/console.h b/include/linux/console.h
> index 60195cd086dc..bf1e8136424a 100644
> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -159,8 +159,12 @@ struct console {
>  };
>  
>  #ifdef CONFIG_LOCKDEP
> +extern void lockdep_assert_console_list_lock_held(void);
>  extern bool console_srcu_read_lock_is_held(void);
>  #else
> +static inline void lockdep_assert_console_list_lock_held(void)
> +{
> +}
>  static inline bool console_srcu_read_lock_is_held(void)
>  {
>  	return 1;
> @@ -170,6 +174,9 @@ static inline bool console_srcu_read_lock_is_held(void)
>  extern int console_srcu_read_lock(void);
>  extern void console_srcu_read_unlock(int cookie);
>  
> +extern void console_list_lock(void) __acquires(console_mutex);
> +extern void console_list_unlock(void) __releases(console_mutex);
> +
>  extern struct hlist_head console_list;
>  
>  /**
> @@ -206,10 +213,17 @@ static inline bool console_is_enabled(const struct console *con)
>  	hlist_for_each_entry_srcu(con, &console_list, node,		\
>  				  console_srcu_read_lock_is_held())
>  
> -/*
> - * for_each_console() allows you to iterate on each console
> +/**
> + * for_each_console() - Iterator over registered consoles
> + * @con:	struct console pointer used as loop cursor
> + *
> + * The console list and all struct console fields are immutable while
> + * iterating.

s/all struct console fields/console->flags/  ?

> + *
> + * Requires console_list_lock to be held.
>   */
> -#define for_each_console(con) \
> +#define for_each_console(con)						\
> +	lockdep_assert_console_list_lock_held();			\
>  	hlist_for_each_entry(con, &console_list, node)
>  
>  extern int console_set_on_cmdline;
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 2faa6e3e2fb8..3615ee6d68fd 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -78,6 +78,9 @@ EXPORT_SYMBOL(ignore_console_lock_warning);
>  int oops_in_progress;
>  EXPORT_SYMBOL(oops_in_progress);
>  
> +/* console_mutex protects console_list and console->flags updates. */

  /*
   * console_mutex protects console_list updates and console->flags updates.
   * The flags are synchronized only for consoles that are registered,
   * accessible via the list.
   */

> +static DEFINE_MUTEX(console_mutex);
> +
>  /*
>   * console_sem protects console_list and console->flags updates, and also
>   * provides serialization for access to the entire console driver system.
> @@ -104,6 +107,11 @@ static struct lockdep_map console_lock_dep_map = {
>  	.name = "console_lock"
>  };
>  
> +void lockdep_assert_console_list_lock_held(void)
> +{
> +	lockdep_assert_held(&console_mutex);
> +}
> +
>  bool console_srcu_read_lock_is_held(void)
>  {
>  	return srcu_read_lock_held(&console_srcu);
> @@ -225,6 +233,40 @@ int devkmsg_sysctl_set_loglvl(struct ctl_table *table, int write,
>  }
>  #endif /* CONFIG_PRINTK && CONFIG_SYSCTL */
>  
> +/**
> + * console_list_lock - Lock the console list
> + *
> + * For console list or console->flags updates
> + */
> +void console_list_lock(void)
> +{
> +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> +	/*
> +	 * In unregister_console(), synchronize_srcu() is called with the
> +	 * console_list_lock held. Therefore it is not allowed that the
> +	 * console_list_lock is taken with the srcu_lock held.
> +	 *
> +	 * Whether or not this context is in the read-side critical section
> +	 * can only be detected if the appropriate debug options are enabled.
> +	 */
> +	WARN_ON_ONCE(debug_lockdep_rcu_enabled() &&
> +		     srcu_read_lock_held(&console_srcu));
> +#endif
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
>  /**
>   * console_srcu_read_lock - Register a new reader for the
>   *	SRCU-protected console list
> @@ -3304,13 +3350,15 @@ void register_console(struct console *newcon)
>  
>  		hlist_for_each_entry_safe(con, tmp, &console_list, node) {
>  			if (con->flags & CON_BOOT)
> -				unregister_console(con);
> +				unregister_console_locked(con);
>  		}
>  	}
> +unlock:
> +	console_list_unlock();
>  }
>  EXPORT_SYMBOL(register_console);
>  
> -int unregister_console(struct console *console)

We should make it clear that it must be locked by console_list_lock().
Many people would expect console_lock() ;-) I would add a comment
and assert.

/* Must be called under console_list_lock(). */

> +static int unregister_console_locked(struct console *console)
>  {

	assert_console_list_lock_held();

>  	int res;
>  

With updated comments:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
