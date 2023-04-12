Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD22D6DF096
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 11:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbjDLJin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 05:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbjDLJig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 05:38:36 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721E5272B
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 02:38:32 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 2416F1F6E6;
        Wed, 12 Apr 2023 09:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1681292311; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c0SP/x+biZJXktzqzgRHJHJg1WAHbea/GKjFs2rku1M=;
        b=QBAAvecZMfh4A6GHD47kySyWutUM6O9/qH90lLm6rDIn3AEEIT4KmhZ08vxieHjORTaxIa
        E+fv+5hy9hDRqXus05uujOc5ldMmp1KG22erCgd5Wl9BUbIyvmAo8hkGJsZpw7aJn2UOCh
        yml8XRzZcj9EREFBYzwVpeZ85tJWNQM=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C12AC2C143;
        Wed, 12 Apr 2023 09:38:30 +0000 (UTC)
Date:   Wed, 12 Apr 2023 11:38:30 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v1 12/18] printk: nobkl: Add printer thread wakeups
Message-ID: <ZDZ8FoOeyYNHYnYh@alley>
References: <20230302195618.156940-1-john.ogness@linutronix.de>
 <20230302195618.156940-13-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302195618.156940-13-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2023-03-02 21:02:12, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Add a function to wakeup the printer threads. Use the new function
> when:
> 
>   - records are added to the printk ringbuffer
>   - consoles are started
>   - consoles are resumed
> 
> The actual waking is performed via irq_work so that the wakeup can
> be triggered from any context.
>
> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -317,6 +318,7 @@ struct cons_context_data;
>   * @thread_pbufs:	Pointer to thread private buffer
>   * @kthread:		Pointer to kernel thread
>   * @rcuwait:		RCU wait for the kernel thread
> + * @irq_work:		IRQ work for thread wakeup

I would call this irq_wakeup_work, wakeup_work, or kthread_wakeup_work.

>   * @kthread_waiting:	Indicator whether the kthread is waiting to be woken
>   * @write_atomic:	Write callback for atomic context
>   * @write_thread:	Write callback for printk threaded printing
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3226,9 +3237,23 @@ EXPORT_SYMBOL(console_stop);
>  
>  void console_start(struct console *console)
>  {
> +	short flags;
> +
>  	console_list_lock();
>  	console_srcu_write_flags(console, console->flags | CON_ENABLED);
> +	flags = console->flags;
>  	console_list_unlock();
> +
> +	/*
> +	 * Ensure that all SRCU list walks have completed. The related
> +	 * printing context must be able to see it is enabled so that
> +	 * it is guaranteed to wake up and resume printing.
> +	 */
> +	synchronize_srcu(&console_srcu);

Either this is needed only when the console is CON_NO_BKL or
it was needed even before this patchset.

I not sure if we need it at all. It will help only for not-yet-started
SRCU walks. But they should see the change because the modification
was done under console_list_lock(). It should provide some
memory barrier against srcu_read_lock(). But maybe I do not understand
the srcu_read_lock() guarantees completely.

> +
> +	if (flags & CON_NO_BKL)
> +		cons_kthread_wake(console);
> +
>  	__pr_flush(console, 1000, true);
>  }
>  EXPORT_SYMBOL(console_start);
> --- a/kernel/printk/printk_nobkl.c
> +++ b/kernel/printk/printk_nobkl.c
> @@ -1368,6 +1368,37 @@ static int cons_kthread_func(void *__console)
>  	return 0;
>  }
>  
> +/**
> + * cons_irq_work - irq work to wake printk thread
> + * @irq_work:	The irq work to operate on
> + */
> +static void cons_irq_work(struct irq_work *irq_work)
> +{
> +	struct console *con = container_of(irq_work, struct console, irq_work);
> +
> +	cons_kthread_wake(con);
> +}
> +
> +/**
> + * cons_wake_threads - Wake up printing threads
> + *
> + * A printing thread is only woken if it is within the @kthread_waiting
> + * block. If it is not within the block (or enters the block later), it
> + * will see any new records and continue printing on its own.
> + */
> +void cons_wake_threads(void)
> +{
> +	struct console *con;
> +	int cookie;
> +
> +	cookie = console_srcu_read_lock();
> +	for_each_console_srcu(con) {
> +		if (con->kthread && atomic_read(&con->kthread_waiting))

I studied the code more. And I think that the custom con->kthread_waiting
is not need with this approach. IMHO, rcuwait_active() would do
the same job.

IMHO, this is supposed to do the same optimization as
wq_has_sleeper(&log_wait) in __wake_up_klogd().

That said, we need to add smp_wmb() before rcuwait_active().
It is already bundled in wq_has_sleeper() but not in
rcuwait_active().


> +			irq_work_queue(&con->irq_work);
> +	}
> +	console_srcu_read_unlock(cookie);

Note that this solution would require blocking and canceling
the irq_work before stopping the kthread, see
https://lore.kernel.org/r/ZC5+Hn0bOhMrVci6@alley


Alternative solution would be to have a global printk_kthread_waiting
atomic counter and move the SRCU read lock into the IRQ context.

I mean something like:

atomic_t printk_kthread_waiting = ATOMIC_INIT(0);

void cons_thread_wakeup_func(struct irq_work *irq_work)
{
	struct console *con;
	int cookie;

	cookie = console_srcu_read_lock();
	for_each_console_srcu(con) {
		/* The kthread is started later during boot. */
		if (!con->kthread)
			continue;

		/*
		 * Make sure that the record was written before we
		 * wake up the kthread so that
		 * cons_kthread_should_wakeup() will see it.
		 *
		 * It pairs with the implicit barrier in
		 * rcuwait_wait_event().
		smp_mb();
		if (!rcuwait_active(&con->rcuwait))
			continue;

		cons_kthread_wake(con);
	}
}

void cons_wake_threads(void)
{
	/*
	 * Make sure that the record is stored before checking
	 * printk_thread_waiting. So that the kthread will
	 * either see it when checking cons_kthread_should_wakeup().
	 * Or the check below will see the printk_thread_waiting
	 * counter incremented.
	 *
	 * The corresponding barrier is in cons_kthread_func()
	 */
	smp_mb();
	if (atomic_read(&printk_thread_waiting))
		irq_work_queue(cons_thread_wakeup_work);
}

and finally:

static int cons_kthread_func(void *__console)
{
[...]
	for (;;) {
		atomic_inc(&printk_thread_waiting);

		/*
		 * Synchronize against cons_wake_threads().
		 *
		 * Make sure that either cons_wake_threads() will see
		 * that we are going to wait. Or we will see the new
		 * record that was stored before cons_wake_threads()
		 * was called.
		 */
		smp_mb();

		/*
		 * Provides a full memory barrier against rcuwait_active()
		 * check in cons_thread_wakeup_func().
		 */
		ret = rcuwait_wait_event(&con->rcuwait,
					 cons_kthread_should_wakeup(con, ctxt),
					 TASK_INTERRUPTIBLE);

		atomic_dec(&printk_kthread_waiting);
[...]
}

Note that printk_kthread_waiting counter is need in this case because
we do not have a global wait queue. And we could not have a global one
because rcuwait provides supports only a single task. White the
classic waitqueue supports more tasks via struct wait_queue_head.

Difference between the two solutions:

    + Original solution should not need con->kthread_waiting
      in the end. But we will only need to make sure that the irq_work
      can't and is not longer be scheduled when stopping
      the kthread.

    + The alternative solution is is easier against removing
      a console because the srcu list is walked in the irq_work.
      But it would require the global printk_kthread_waiting
      counter because rcuwait supports only one task and we
      need to check if any task is waiting.

The advantage of the alternative solution might be
that srcu_read_lock() would be needed only when there is
any waiting kthread. I am not sure how important it is
to reduce the number of srcu read locked contexts.

I do not really have any preferences.

Best Regards,
Petr
