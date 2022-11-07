Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB0061F810
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 16:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbiKGP6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 10:58:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbiKGP6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 10:58:20 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CDF1D0EF
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 07:58:18 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A64441F88B;
        Mon,  7 Nov 2022 15:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667836697; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HwyeGbyF6xyA3VZxkMsXJCEwAnKw5p/3+qMk4oWNRJw=;
        b=jqQuCs3t3UEBxJg7SJLoB1MaQqUsfBI3frLubFthjX5lqViOAHUNKC0l/BArO3aQuuDL/k
        aHm6e9I2S4IWuJhZYKAuGVcDEWdXtEdBjlQEqUOrdXvhjuBFpu/ULPk7GgN6S02CUis0Rw
        YL9Wv4v++iiF3TPV6T7W/Y7JZVYYOY4=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 07D7C2C141;
        Mon,  7 Nov 2022 15:58:16 +0000 (UTC)
Date:   Mon, 7 Nov 2022 16:58:16 +0100
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
        Daniel Thompson <daniel.thompson@linaro.org>,
        John Ogness <jogness@linutronix.de>
Subject: functionality: was: Re: [patch RFC 19/29] printk: Add basic
 infrastructure for non-BKL consoles
Message-ID: <Y2krGJwMQHaNoper@alley>
References: <20220910221947.171557773@linutronix.de>
 <20220910222301.479172669@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220910222301.479172669@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 2022-09-11 00:28:01, Thomas Gleixner wrote:
> The current console/printk subsystem is protected by a Big Kernel Lock,
> aka. console_lock which has has ill defined semantics and is more or less
> stateless. This puts severe limitations on the console subsystem and makes
> forced takeover and output in emergency and panic situations a fragile
> endavour which is based on try and pray.
> 
> The goal of non-BKL consoles is to break out of the console lock jail and
> to provide a new infrastructure which avoids the pitfalls and allows
> console drivers to be gradually converted over.
> 
> The proposed infrastructure aims for the following properties:
> 
>   - Lockless (SCRU protected) console list walk
>   - Per console locking instead of global locking
>   - Per console state which allows to make informed decisions
>   - Stateful handover and takeover
> 
> As a first step this adds state to struct console. The per console state is
> a atomic_long_t with a 32bit bit field and on 64bit a 32bit sequence for
> tracking the last printed ringbuffer sequence number. On 32bit the sequence
> is seperate from state for obvious reasons which requires to handle a few
> extra race conditions.
> 
> Add the initial state with the most basic 'alive' and 'enabled' bits and
> wire it up into the console register/unregister functionality and exclude
> such consoles from being handled in the console BKL mechanisms.
> 
> The decision to use a bitfield was made as using a plain u32 and mask/shift
> operations turned out to result in uncomprehensible code.
> 
> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -170,6 +172,37 @@ enum cons_flags {
>  	CON_ANYTIME		= BIT(4),
>  	CON_BRL			= BIT(5),
>  	CON_EXTENDED		= BIT(6),
> +	CON_NO_BKL		= BIT(7),
> +};
> +
> +/**
> + * struct cons_state - console state for NOBKL consoles
> + * @atom:	Compound of the state fields for atomic operations
> + * @seq:	Sequence for record tracking (64bit only)
> + * @bits:	Compound of the state bits below
> + *
> + * @alive:	Console is alive. Required for teardown

What do you exactly mean with teardown, please?

I somehow do not understand the meaning. The bit "alive" seems
to always be "1" in this patchset.

> + * @enabled:	Console is enabled. If 0, do not use
> + *
> + * To be used for state read and preparation of atomic_long_cmpxchg()
> + * operations.
> + */
> +struct cons_state {
> +	union {
> +		unsigned long	atom;
> +		struct {
> +#ifdef CONFIG_64BIT
> +			u32	seq;
> +#endif
> +			union {
> +				u32	bits;
> +				struct {
> +					u32 alive	:  1;
> +					u32 enabled	:  1;
> +				};
> +			};
> +		};
> +	};
>  };
>  
>  /**
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3079,7 +3088,10 @@ void console_stop(struct console *consol
>  	console_list_lock();
>  	console_lock();
>  	console->flags &= ~CON_ENABLED;
> +	cons_state_disable(console);
>  	console_unlock();
> +	/* Ensure that all SRCU list walks have completed */
> +	synchronize_srcu(&console_srcu);

I have few questions here:

1. Do we need separate "enabled" flags for BLK and non-blk consoles?

   Hmm, it might be problem to remove CON_ENABLED flag
   because it is exported to userspace via /proc/consoles.

   Well, what is the purpose of the "enabled" flag for atomic
   consoles? Are we going to stop them in the middle of a line?
   Does the flag has to be atomic and part of atomic_state?


2. What is the purpose of synchronize_srcu(), please?

   It probably should make sure that all consoles with CON_NO_BLK
   flag are really stopped once it returns.

   IMHO, this would work only when the "enabled" flag and the
   con->write*() callback is called under srcu_read_lock().

   I do not see it in the code. Do I miss something, please?


3. Is the ordering of console_unlock() and synchronize_srcu()
   important, please?

   IMHO, it would be important if we allowed the following code:

      srcu_read_lock(&console_srcu);
      console_lock();
      // do something
      console_unlock();
      srcu_read_unlock(&console_srcu);

   then we would always have to call synchronize_srcu() outside
   console_lock() otherwise there might be ABBA deadlock.

   I do not see this code yet. But it might make sense.
   Anyway, we should probably document the rules somewhere.


4. Is it important to call cons_state_disable(console) under
   console_lock() ?

   I guess that it isn't. But it is not clear from the code.
   The picture is even more complicated because everything is done
   under console_list_lock().

   It would make sense to explain the purpose of each lock.
   My understanding is the following:

      + console_list_lock() synchronizes manipulation of
	con->flags.

      + console_lock() makes sure that no console will
	be calling con->write() callback after console_unlock().

      + synchronize_srcu() is supposed to make sure that
	any console is calling neither con->write_kthread()
	nor con->atomic_write() after this synchronization.
	Except that it does not work from my POV.

    Anyway, I might make sense to separate the two approaches.
    Let's say:

	console_list_lock()
	if (con->flags & CON_NO_BLK) {
		noblk_console_disable(con);
	} else {
		/* cons->flags are synchronized using console_list_lock */
		console->flags &= ~CON_ENABLED;
		/*
		 * Make sure that no console calls con->write()	anymore.
		 *
		 * This ordering looks a bit ugly. But it shows how
		 * the things are serialized.
		 */
		console_lock();
		console_unlock();
	}

     , where noblk_console_disable(con) must be more complicated.
     It must be somehow synchronized with all con->write_kthread() and
     write_atomic() callers.

     I wonder if noblk_console_disable(con) might somehow use
     the hangover mechanism so that it becomes the owner of
     the console and disables the enabled flag. I mean
     to implement some sleepable cons_acquire(). But this sounds
     a bit like con->mutex that you wanted to avoid.

     It might be easier to check the flag and call con->write() under
     srcu_read_lock() so that synchronize_srcu() really waits until
     the current message gets printed.


>  	console_list_unlock();
>  }
>  EXPORT_SYMBOL(console_stop);


Best Regards,
Petr

PS: I am going to review v3 of "reduce console_lock scope" patchset
    which has arrived few hours ago.

    I just wanted to send my notes that I made last Friday
    when I continued review of this RFC.
