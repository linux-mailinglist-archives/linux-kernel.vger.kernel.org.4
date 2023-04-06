Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C39826D97E4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 15:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238276AbjDFNUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 09:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238420AbjDFNUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 09:20:15 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0B959F9
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 06:19:51 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 51F661F895;
        Thu,  6 Apr 2023 13:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1680787190; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rkvXLNdXFxs9McDSh9bFlpIBz7m5VY5nk/ftztSaY38=;
        b=YdGpRcvIbzgISIKrb+okuPQFPrrq/h/sDe/XT5RAEQ0gc6xN3Fs5jWGBaKnV5kQLpQ4GXc
        EIdD+W2APNg3gbDY61EvFr/1qNfHxzZjp9TPMoWETly72IhcmPWKyGjGPPDtgRt5HA5SuE
        rwCYUS02RncW7n7a2aiCQk7g8U7tad0=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id CF3B92C141;
        Thu,  6 Apr 2023 13:19:49 +0000 (UTC)
Date:   Thu, 6 Apr 2023 15:19:46 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: misc: was: Re: [PATCH printk v1 11/18] printk: nobkl: Introduce
 printer threads
Message-ID: <ZC7G8godMveXSKMX@alley>
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

This deserves a more detailed description. It should describe
the expected behavior of the newly added pieces of the puzzle.

> --- a/kernel/printk/printk_nobkl.c
> +++ b/kernel/printk/printk_nobkl.c
> @@ -714,6 +717,14 @@ static bool __cons_try_acquire(struct cons_context *ctxt)
>  		goto success;
>  	}
>  
> +	/*
> +	 * A threaded printer context will never spin or perform a
> +	 * hostile takeover. The atomic writer will wake the thread
> +	 * when it is done with the important output.
> +	 */
> +	if (ctxt->thread)
> +		return false;

I suggest to remove this optimization. Or replace it with a check
of the lowest NORMAL priority.

First, it is conceptually questionable. The kthread might actually want to
take over the lock. It is the preferred context when the system
works properly.

Second, it is a bit superfluous. The kthread will give up on the next check
anyway because it is the context with the lowest NORMAL priority.

I guess that this is another relic of the first POC that allowed
to take over the lock from a context of the same priority.

I though more about passing the lock:

Passing the lock between console contexts of the same priority would
have basically the same effect as console_trylock_spinning() trick
in the legacy code. The only motivation would be to reduce
the risk of softlockups. But it would make sense only in the EMERGENCY
contexts. There should be only one NORMAL and PANIC contexts.

Also passing the lock between context of the same priority would
be more complicated with the NOBKL consoles. Some messages (parts)
might be printed many times when the lock is passed in the middle
of the record and the new owner always starts from scratch.

> +
>  	/*
>  	 * If the active context is on the same CPU then there is
>  	 * obviously no handshake possible.
> @@ -871,6 +882,9 @@ static bool __cons_release(struct cons_context *ctxt)
>  	return true;
>  }
>

> +static bool printk_threads_enabled __ro_after_init;

This might deserve a comment when exactly it gets enabled.
My understanding is that it is set during a boot phase
when it is safe to create the kthreads.

> +static bool printk_force_atomic __initdata;

I guess that this will be a kernel parameter. But it is not defined in
this patch. The logic should be introduced together with the parameter.

> +
>  /**
>   * cons_release - Release the console after output is done
>   * @ctxt:	The acquire context that contains the state
> @@ -1203,6 +1219,243 @@ static int __maybe_unused cons_emit_record(struct cons_write_context *wctxt)
>  	return cons_seq_try_update(ctxt);
>  }
>  
> +/**
> + * cons_kthread_should_wakeup - Check whether the printk thread should wakeup
> + * @con:	Console to operate on
> + * @ctxt:	The acquire context that contains the state
> + *		at console_acquire()
> + *
> + * Returns: True if the thread should shutdown or if the console is allowed to
> + * print and a record is available. False otherwise
> + *
> + * After the thread wakes up, it must first check if it should shutdown before
> + * attempting any printing.

I would move this comment right above the kthread_should_stop()
check. I think that it is a bigger chance to see it there.

> + */
> +static bool cons_kthread_should_wakeup(struct console *con, struct cons_context *ctxt)
> +{
> +	bool is_usable;
> +	short flags;
> +	int cookie;
> +
> +	if (kthread_should_stop())
> +		return true;
> +
> +	cookie = console_srcu_read_lock();
> +	flags = console_srcu_read_flags(con);
> +	is_usable = console_is_usable(con, flags);
> +	console_srcu_read_unlock(cookie);
> +
> +	if (!is_usable)
> +		return false;
> +
> +	/* This reads state and sequence on 64bit. On 32bit only state */
> +	cons_state_read(con, CON_STATE_CUR, &ctxt->state);
> +
> +	/*
> +	 * Atomic printing is running on some other CPU. The owner
> +	 * will wake the console thread on unlock if necessary.
> +	 */
> +	if (ctxt->state.locked)
> +		return false;
> +
> +	/* Bring the sequence in @ctxt up to date */
> +	cons_context_set_seq(ctxt);

This name is a bit confusing. It looks like it is setting some state.
But the primary function is to actually read the value.

Also the function sets both "oldseq" and "newseq". This looks superfluous.
The caller will need to refresh the values once again after
cons_try_acquire_lock() once again.

It should be enough to set "oldseq" here and "newseq" in cons_emit_record().

Finally, in an other mail I suggested to move:

    + ctxt.newseq -> xtxt.pmsg.seq
    + ctxt.oldseq -> ctxt.con_seq		// cache of con->seq

What about renaming the function to something like:

    + cons_context_read_con_seq()
    + cons_context_refresh_con_seq()


> +
> +	return prb_read_valid(prb, ctxt->oldseq, NULL);
> +}
> +
> +/**
> + * cons_kthread_func - The printk thread function
> + * @__console:	Console to operate on
> + */
> +static int cons_kthread_func(void *__console)
> +{
> +	struct console *con = __console;
> +	struct cons_write_context wctxt = {
> +		.ctxt.console	= con,
> +		.ctxt.prio	= CONS_PRIO_NORMAL,
> +		.ctxt.thread	= 1,
> +	};
> +	struct cons_context *ctxt = &ACCESS_PRIVATE(&wctxt, ctxt);
> +	unsigned long flags;
> +	short con_flags;
> +	bool backlog;
> +	int cookie;
> +	int ret;
> +
> +	for (;;) {
> +		atomic_inc(&con->kthread_waiting);
> +
> +		/*
> +		 * Provides a full memory barrier vs. cons_kthread_wake().
> +		 */
> +		ret = rcuwait_wait_event(&con->rcuwait,
> +					 cons_kthread_should_wakeup(con, ctxt),
> +					 TASK_INTERRUPTIBLE);
> +
> +		atomic_dec(&con->kthread_waiting);
> +
> +		if (kthread_should_stop())
> +			break;
> +
> +		/* Wait was interrupted by a spurious signal, go back to sleep */
> +		if (ret)
> +			continue;
> +
> +		for (;;) {
> +			cookie = console_srcu_read_lock();
> +
> +			/*
> +			 * Ensure this stays on the CPU to make handover and
> +			 * takeover possible.
> +			 */
> +			if (con->port_lock)
> +				con->port_lock(con, true, &flags);
> +			else
> +				migrate_disable();
> +
> +			/*
> +			 * Try to acquire the console without attempting to
> +			 * take over. If an atomic printer wants to hand
> +			 * back to the thread it simply wakes it up.
> +			 */
> +			if (!cons_try_acquire(ctxt))
> +				break;
> +
> +			con_flags = console_srcu_read_flags(con);
> +
> +			if (console_is_usable(con, con_flags)) {
> +				/*
> +				 * If the emit fails, this context is no
> +				 * longer the owner. Abort the processing and
> +				 * wait for new records to print.
> +				 */
> +				if (!cons_emit_record(&wctxt))

Please, rename the function to cons_emit_next_record() to match
the corresponding console_emit_next_record().

> +					break;
> +				backlog = ctxt->backlog;

Also please pass the 3rd possible return state via "handover" variable
to match the semantic of console_emit_next_record().

> +			} else {
> +				backlog = false;
> +			}
> +
> +			/*
> +			 * If the release fails, this context was not the
> +			 * owner. Abort the processing and wait for new
> +			 * records to print.
> +			 */
> +			if (!cons_release(ctxt))
> +				break;
> +
> +			/* Backlog done? */
> +			if (!backlog)
> +				break;
> +
> +			if (con->port_lock)
> +				con->port_lock(con, false, &flags);
> +			else
> +				migrate_enable();
> +
> +			console_srcu_read_unlock(cookie);
> +
> +			cond_resched();
> +		}
> +		if (con->port_lock)
> +			con->port_lock(con, false, &flags);
> +		else
> +			migrate_enable();
> +
> +		console_srcu_read_unlock(cookie);
> +	}
> +	return 0;
> +}
> +
> +/**
> + * cons_kthread_stop - Stop a printk thread
> + * @con:	Console to operate on
> + */
> +static void cons_kthread_stop(struct console *con)
> +{
> +	lockdep_assert_console_list_lock_held();
> +
> +	if (!con->kthread)
> +		return;

We need some tricks here to make sure that cons_kthread_wakeup()
will not longer wake it up:

	con->block_wakeup = true;
	irq_work_sync(&con->irq_work);

> +	kthread_stop(con->kthread);
> +	con->kthread = NULL;
> +
> +	kfree(con->thread_pbufs);
> +	con->thread_pbufs = NULL;
> +}
> +
> +/**
> + * cons_kthread_create - Create a printk thread
> + * @con:	Console to operate on
> + *
> + * If it fails, let the console proceed. The atomic part might
> + * be usable and useful.
> + */
> +void cons_kthread_create(struct console *con)
> +{
> +	struct task_struct *kt;
> +	struct console *c;
> +
> +	lockdep_assert_console_list_lock_held();
> +
> +	if (!(con->flags & CON_NO_BKL) || !con->write_thread)
> +		return;
> +
> +	if (!printk_threads_enabled || con->kthread)
> +		return;
> +
> +	/*
> +	 * Printer threads cannot be started as long as any boot console is
> +	 * registered because there is no way to synchronize the hardware
> +	 * registers between boot console code and regular console code.
> +	 */
> +	for_each_console(c) {
> +		if (c->flags & CON_BOOT)
> +			return;
> +	}
> +	have_boot_console = false;
> +
> +	con->thread_pbufs = kmalloc(sizeof(*con->thread_pbufs), GFP_KERNEL);
> +	if (!con->thread_pbufs) {
> +		con_printk(KERN_ERR, con, "failed to allocate printing thread buffers\n");
> +		return;
> +	}
> +
> +	kt = kthread_run(cons_kthread_func, con, "pr/%s%d", con->name, con->index);
> +	if (IS_ERR(kt)) {
> +		con_printk(KERN_ERR, con, "failed to start printing thread\n");
> +		kfree(con->thread_pbufs);
> +		con->thread_pbufs = NULL;
> +		return;

We should make sure that this console will still get flushed either
in vprintk_emit() or in console_unlock(). I think that it is not
guaranteed by this patchset.

> +	}
> +
> +	con->kthread = kt;
> +
> +	/*
> +	 * It is important that console printing threads are scheduled
> +	 * shortly after a printk call and with generous runtime budgets.
> +	 */
> +	sched_set_normal(con->kthread, -20);
> +}
> +

Best Regards,
Petr
