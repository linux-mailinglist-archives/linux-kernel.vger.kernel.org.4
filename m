Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C57560726D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 10:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiJUIfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 04:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbiJUIfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 04:35:45 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DDE524CC01
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 01:35:26 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C302621983;
        Fri, 21 Oct 2022 08:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666341294; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MXkOfAC8JGrtRMCkdTiV90Ss1x/DFPoIyK5qn/jcytA=;
        b=MRZ0K2Bi23HHzfBYhy8O5A1xLKjlyFe6XsOCjyBoZ8H2o2KiaBpyPw+FFWRApCFDvSPdO4
        pryWI6RKxP7idM1FXMdyqqFZR2Ve0Ap91PHO3H1lWhsWcZtX8VQBhqlKQxv2I7ueYy6ICe
        rRq21DSZ5uVI8S03JUHs3Pu9GskMbdk=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8BF742C142;
        Fri, 21 Oct 2022 08:34:54 +0000 (UTC)
Date:   Fri, 21 Oct 2022 10:34:51 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v2 03/38] printk: Prepare for SRCU console list
 protection
Message-ID: <Y1JZqyIF5rf4sal2@alley>
References: <20221019145600.1282823-1-john.ogness@linutronix.de>
 <20221019145600.1282823-4-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019145600.1282823-4-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-10-19 17:01:25, John Ogness wrote:
> Provide an NMI-safe SRCU protected variant to walk the console list.
> 
> Note that all console fields are now set before adding the console
> to the list to avoid the console becoming visible by SCRU readers
> before being fully initialized.
> 
> This is a preparatory change for a new console infrastructure which
> operates independent of the console BKL.
> 
> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -15,7 +15,7 @@
>  #define _LINUX_CONSOLE_H_ 1
>  
>  #include <linux/atomic.h>
> -#include <linux/list.h>
> +#include <linux/rculist.h>
>  #include <linux/types.h>
>  
>  struct vc_data;
> @@ -158,8 +158,34 @@ struct console {
>  	struct hlist_node node;
>  };
>  
> +#ifdef CONFIG_LOCKDEP

srcu_read_lock_held() actually depends on CONFIG_DEBUG_LOCK_ALLOC.
I suggest to avoid these problems and define:


extern struct srcu_struct console_srcu;

static inline bool console_srcu_read_lock_is_held(void)
{
	return srcu_read_lock_held(&console_srcu);
}

I guess that you wanted to keep console_srcu static to avoid
a misuse. It is true that we need to keep it NMI safe.

I do not have a strong opinion. I would personally risk it
and make it public. The CONFIG_* dependencies are hard to
maintain. We could add a comment that people need to use
the NMI safe API when manipulating the context.

> +extern bool console_srcu_read_lock_is_held(void);
> +#else
> +static inline bool console_srcu_read_lock_is_held(void)
> +{
> +	return 1;
> +}
> +#endif
> +
> +extern int console_srcu_read_lock(void);
> +extern void console_srcu_read_unlock(int cookie);
> +
>  extern struct hlist_head console_list;
>  
> +/**
> + * for_each_console_srcu() - Iterator over registered consoles
> + * @con:	struct console pointer used as loop cursor
> + *
> + * Although SRCU guarantees the console list will be consistent, the
> + * struct console fields may be updated by other CPUs while iterating.
> + *
> + * Requires console_srcu_read_lock to be held. Can be invoked from
> + * any context.
> + */
> +#define for_each_console_srcu(con)					\
> +	hlist_for_each_entry_srcu(con, &console_list, node,		\
> +				  console_srcu_read_lock_is_held())
> +
>  /*
>   * for_each_console() allows you to iterate on each console
>   */
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 867becc40021..e8a56056cd50 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2989,6 +3021,9 @@ void console_stop(struct console *console)
>  	console_lock();
>  	console->flags &= ~CON_ENABLED;
>  	console_unlock();
> +
> +	/* Ensure that all SRCU list walks have completed */
> +	synchronize_srcu(&console_srcu);

The comment is not much helpful. It describes the behavior
that is more or less obvious. The important question
is why it is needed. And it is not clear to me.

What is the motivation for this synchronization, please?

This function disables one particular console. What exact walk are
we waiting for, please?

Is it really needed?

>  }
>  EXPORT_SYMBOL(console_stop);
>  
> @@ -3179,6 +3214,17 @@ void register_console(struct console *newcon)
>  		newcon->flags &= ~CON_PRINTBUFFER;
>  	}
>  
> +	newcon->dropped = 0;
> +	if (newcon->flags & CON_PRINTBUFFER) {
> +		/* Get a consistent copy of @syslog_seq. */
> +		mutex_lock(&syslog_lock);
> +		newcon->seq = syslog_seq;
> +		mutex_unlock(&syslog_lock);
> +	} else {
> +		/* Begin with next message. */
> +		newcon->seq = prb_next_seq(prb);

Hmm, prb_next_seq() is the next-to-be written message. It does not
guarantee that all the existing messages already reached the boot console.

This used to be synchronized by console_lock(). But we broke this
by the commit a699449bb13b70b8bd10d ("printk: refactor and rework
printing logic") that removed the global console_seq.

It actually kind of worked because console_unlock() was called before
the boot consoles were removed. So that the boot console
printed the pending messages before it was removed. Except when
the console lock was passed to another printk() caller.

Ideally, we should set it to con->seq from the related boot consoles.
But we do not know which one it is.

A good enough solution would be to set it to the minimal con->seq
of all registered boot consoles. They would most likely be on
the same sequence number. Anyway, con->seq has to be read under
console_lock() at least at this stage of the patchset.


> +	}
> +
>  	/*
>  	 * Put this console in the list - keep the
>  	 * preferred driver at the head of the list.
> @@ -3187,28 +3233,20 @@ void register_console(struct console *newcon)
>  	if (hlist_empty(&console_list)) {
>  		/* Ensure CON_CONSDEV is always set for the head. */
>  		newcon->flags |= CON_CONSDEV;
> -		hlist_add_head(&newcon->node, &console_list);
> +		hlist_add_head_rcu(&newcon->node, &console_list);
>  
>  	} else if (newcon->flags & CON_CONSDEV) {
>  		/* Only the new head can have CON_CONSDEV set. */
>  		console_first()->flags &= ~CON_CONSDEV;
> -		hlist_add_head(&newcon->node, &console_list);
> +		hlist_add_head_rcu(&newcon->node, &console_list);
>  
>  	} else {
> -		hlist_add_behind(&newcon->node, console_list.first);
> -	}
> -
> -	newcon->dropped = 0;
> -	if (newcon->flags & CON_PRINTBUFFER) {
> -		/* Get a consistent copy of @syslog_seq. */
> -		mutex_lock(&syslog_lock);
> -		newcon->seq = syslog_seq;
> -		mutex_unlock(&syslog_lock);
> -	} else {
> -		/* Begin with next message. */
> -		newcon->seq = prb_next_seq(prb);
> +		hlist_add_behind_rcu(&newcon->node, console_list.first);
>  	}
>  	console_unlock();
> +
> +	/* No need to synchronize SRCU here! */

This would deserve explanation why it is not needed. At least some
hint.

I think that it is not needed here. I can't think about any function
that would depend on it.

Anyway, I do not see any difference against console_stop(). I do not
understand why the synchronization is needed there and not here.

> +
>  	console_sysfs_notify();
>  
>  	/*
> @@ -3254,7 +3292,7 @@ int unregister_console(struct console *console)
>  		goto out_unlock;
>  	}
>  
> -	hlist_del_init(&console->node);
> +	hlist_del_init_rcu(&console->node);
>  
>  	/*
>  	 * <HISTORICAL>
> @@ -3269,6 +3307,10 @@ int unregister_console(struct console *console)
>  		console_first()->flags |= CON_CONSDEV;
>  
>  	console_unlock();
> +
> +	/* Ensure that all SRCU list walks have completed */
> +	synchronize_srcu(&console_srcu);

Again, we should explain why.

I agree that it should be there. It makes sure that the driver
is not longer used for printing messages before it can be removed.

> +
>  	console_sysfs_notify();
>  
>  	if (console->exit)
> -- 
> 2.30.2

Best Regards,
Petr
