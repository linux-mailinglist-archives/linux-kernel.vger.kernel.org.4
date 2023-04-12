Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCB76DF91A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 16:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjDLOyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 10:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjDLOyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 10:54:47 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578EF5FD6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 07:54:24 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6060A21983;
        Wed, 12 Apr 2023 14:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1681311237; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I1pmfZaV+/wP4vewcGipEQdsqkk0P3ww0zzXSHo8EMk=;
        b=DfmwEJD5TregiIS1il4MsxN5VSfn9m9B72RYz8sWeP9KiJU2UWQSeCUB0EeVQUz3eo09ft
        KVlCqATRMSA9YxgcG4BBsfAMYMyycC7uj/04vKbRZAl2Rzc7eTn8cLp3Op9fWpWpwTwfgS
        y3BghdUVOwSCnjfdG8y1Hhwpfg5PksA=
Received: from suse.cz (pmladek.udp.ovpn2.prg.suse.de [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id EA6552C143;
        Wed, 12 Apr 2023 14:53:56 +0000 (UTC)
Date:   Wed, 12 Apr 2023 16:53:53 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v1 14/18] printk: nobkl: Provide functions for
 atomic write enforcement
Message-ID: <ZDbGAdc0A67f9Xqg@alley>
References: <20230302195618.156940-1-john.ogness@linutronix.de>
 <20230302195618.156940-15-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302195618.156940-15-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2023-03-02 21:02:14, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Threaded printk is the preferred mechanism to tame the noisyness of
> printk, but WARN/OOPS/PANIC require printing out immediately since
> the printer threads might not be able to run.
> 
> Add per CPU state to denote the priority/urgency of the output and
> provide functions to flush the printk backlog for priority elevated
> contexts and when the printing threads are not available (such as
> early boot).
> 
> Note that when a CPU is in a priority elevated state, flushing only
> occurs when dropping back to a lower priority. This allows the full
> set of printk records (WARN/OOPS/PANIC output) to be stored in the
> ringbuffer before beginning to flush the backlog.
> 
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3943,6 +3954,12 @@ void defer_console_output(void)
>  
>  void printk_trigger_flush(void)
>  {
> +	struct cons_write_context wctxt = { };

This is weird. IMHO, this structure should be console-specific.
It should be defined on the cons_atomic_flush_con() level.

It should be doable. We do not initialize it here anyway.

Maybe it was used to pass some common information, like
prio or skip_unsafe. But it would be a messy design.
It would be hard to follow what needs to get re-initialized
and what reused on different levels of the API.

> +	preempt_disable();
> +	cons_atomic_flush(&wctxt, true);
> +	preempt_enable();
> +
>  	cons_wake_threads();
>  	defer_console_output();
>  }
> --- a/kernel/printk/printk_nobkl.c
> +++ b/kernel/printk/printk_nobkl.c
> @@ -1399,6 +1399,246 @@ void cons_wake_threads(void)
>  	console_srcu_read_unlock(cookie);
>  }
>  
> +/**
> + * struct cons_cpu_state - Per CPU printk context state
> + * @prio:	The current context priority level
> + * @nesting:	Per priority nest counter
> + */
> +struct cons_cpu_state {
> +	enum cons_prio	prio;
> +	int		nesting[CONS_PRIO_MAX];
> +};
> +
> +static DEFINE_PER_CPU(struct cons_cpu_state, cons_pcpu_state);
> +static struct cons_cpu_state early_cons_pcpu_state __initdata;
> +
> +/**
> + * cons_get_cpu_state - Get the per CPU console state pointer
> + *
> + * Returns either a pointer to the per CPU state of the current CPU or to
> + * the init data state during early boot.
> + */
> +static __ref struct cons_cpu_state *cons_get_cpu_state(void)
> +{
> +	if (!printk_percpu_data_ready())
> +		return &early_cons_pcpu_state;
> +
> +	return this_cpu_ptr(&cons_pcpu_state);
> +}
> +
> +/**
> + * cons_get_wctxt - Get the write context for atomic printing
> + * @con:	Console to operate on
> + * @prio:	Priority of the context
> + *
> + * Returns either the per CPU context or the builtin context for
> + * early boot.
> + */
> +static __ref struct cons_write_context *cons_get_wctxt(struct console *con,
> +						       enum cons_prio prio)
> +{
> +	if (!con->pcpu_data)
> +		return &early_cons_ctxt_data.wctxt[prio];
> +
> +	return &this_cpu_ptr(con->pcpu_data)->wctxt[prio];
> +}
> +
> +/**
> + * cons_atomic_try_acquire - Try to acquire the console for atomic printing
> + * @con:	The console to acquire
> + * @ctxt:	The console context instance to work on
> + * @prio:	The priority of the current context
> + */
> +static bool cons_atomic_try_acquire(struct console *con, struct cons_context *ctxt,
> +				    enum cons_prio prio, bool skip_unsafe)
> +{
> +	memset(ctxt, 0, sizeof(*ctxt));
> +	ctxt->console		= con;
> +	ctxt->spinwait_max_us	= 2000;
> +	ctxt->prio		= prio;
> +	ctxt->spinwait		= 1;
> +
> +	/* Try to acquire it directly or via a friendly handover */
> +	if (cons_try_acquire(ctxt))
> +		return true;

Do we really need another layer over cons_try_acquire()?

I would expect that all this is handled inside cons_try_acquire()
and it should be enough to call it once. It always should try to get the lock
a gentle way and it should automatically try the hostile takeover
when ctxt->allow_hostile == 1 or ctxt->skip_unsafe == 0.

I do not know. Maybe this was a way how to split the logic into
more functions. But this looks way too complicated. cons_try_acquire()
already includes the logic how to do the hostile take-over. And
it already gets information whether it can use it via ctxt->hostile
variable. But I might miss something.

> +	/* Investigate whether a hostile takeover is due */
> +	if (ctxt->old_state.cur_prio >= prio)
> +		return false;
> +
> +	if (!ctxt->old_state.unsafe || !skip_unsafe)
> +		ctxt->hostile = 1;
> +	return cons_try_acquire(ctxt);
> +}
> +
> +/**
> + * cons_atomic_flush_con - Flush one console in atomic mode
> + * @wctxt:		The write context struct to use for this context
> + * @con:		The console to flush
> + * @prio:		The priority of the current context
> + * @skip_unsafe:	True, to avoid unsafe hostile takeovers
> + */
> +static void cons_atomic_flush_con(struct cons_write_context *wctxt, struct console *con,
> +				  enum cons_prio prio, bool skip_unsafe)
> +{
> +	struct cons_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
> +	bool wake_thread = false;
> +	short flags;
> +
> +	if (!cons_atomic_try_acquire(con, ctxt, prio, skip_unsafe))
> +		return;
> +
> +	do {
> +		flags = console_srcu_read_flags(con);
> +
> +		if (!console_is_usable(con, flags))
> +			break;
> +
> +		/*
> +		 * For normal prio messages let the printer thread handle
> +		 * the printing if it is available.
> +		 */
> +		if (prio <= CONS_PRIO_NORMAL && con->kthread) {
> +			wake_thread = true;
> +			break;
> +		}
> +
> +		/*
> +		 * cons_emit_record() returns false when the console was
> +		 * handed over or taken over. In both cases the context is
> +		 * no longer valid.
> +		 */
> +		if (!cons_emit_record(wctxt))
> +			return;
> +	} while (ctxt->backlog);
> +
> +	cons_release(ctxt);
> +
> +	if (wake_thread && atomic_read(&con->kthread_waiting))
> +		irq_work_queue(&con->irq_work);
> +}
> +
> +/**
> + * cons_atomic_flush - Flush consoles in atomic mode if required
> + * @printk_caller_wctxt:	The write context struct to use for this
> + *				context (for printk() context only)
> + * @skip_unsafe:		True, to avoid unsafe hostile takeovers
> + */
> +void cons_atomic_flush(struct cons_write_context *printk_caller_wctxt, bool skip_unsafe)
> +{
> +	struct cons_write_context *wctxt;
> +	struct cons_cpu_state *cpu_state;
> +	struct console *con;
> +	short flags;
> +	int cookie;
> +
> +	cpu_state = cons_get_cpu_state();
> +
> +	/*
> +	 * When in an elevated priority, the printk() calls are not
> +	 * individually flushed. This is to allow the full output to
> +	 * be dumped to the ringbuffer before starting with printing
> +	 * the backlog.
> +	 */
> +	if (cpu_state->prio > CONS_PRIO_NORMAL && printk_caller_wctxt)
> +		return;
> +
> +	/*
> +	 * Let the outermost write of this priority print. This avoids
> +	 * nasty hackery for nested WARN() where the printing itself
> +	 * generates one.
> +	 *
> +	 * cpu_state->prio <= CONS_PRIO_NORMAL is not subject to nesting
> +	 * and can proceed in order to allow atomic printing when consoles
> +	 * do not have a printer thread.
> +	 */
> +	if (cpu_state->prio > CONS_PRIO_NORMAL &&
> +	    cpu_state->nesting[cpu_state->prio] != 1)
> +		return;
> +
> +	cookie = console_srcu_read_lock();
> +	for_each_console_srcu(con) {
> +		if (!con->write_atomic)
> +			continue;
> +
> +		flags = console_srcu_read_flags(con);
> +
> +		if (!console_is_usable(con, flags))
> +			continue;
> +
> +		if (cpu_state->prio > CONS_PRIO_NORMAL || !con->kthread) {
> +			if (printk_caller_wctxt)
> +				wctxt = printk_caller_wctxt;
> +			else
> +				wctxt = cons_get_wctxt(con, cpu_state->prio);
> +			cons_atomic_flush_con(wctxt, con, cpu_state->prio, skip_unsafe);
> +		}
> +	}
> +	console_srcu_read_unlock(cookie);
> +}
> +
> +/**
> + * cons_atomic_enter - Enter a context that enforces atomic printing
> + * @prio:	Priority of the context
> + *
> + * Returns:	The previous priority that needs to be fed into
> + *		the corresponding cons_atomic_exit()
> + */
> +enum cons_prio cons_atomic_enter(enum cons_prio prio)
> +{
> +	struct cons_cpu_state *cpu_state;
> +	enum cons_prio prev_prio;
> +
> +	migrate_disable();
> +	cpu_state = cons_get_cpu_state();
> +
> +	prev_prio = cpu_state->prio;
> +	if (prev_prio < prio)
> +		cpu_state->prio = prio;
> +
> +	/*
> +	 * Increment the nesting on @cpu_state->prio so a WARN()
> +	 * nested into a panic printout does not attempt to
> +	 * scribble state.
> +	 */
> +	cpu_state->nesting[cpu_state->prio]++;
> +
> +	return prev_prio;
> +}
> +
> +/**
> + * cons_atomic_exit - Exit a context that enforces atomic printing
> + * @prio:	Priority of the context to leave
> + * @prev_prio:	Priority of the previous context for restore
> + *
> + * @prev_prio is the priority returned by the corresponding cons_atomic_enter().
> + */
> +void cons_atomic_exit(enum cons_prio prio, enum cons_prio prev_prio)
> +{
> +	struct cons_cpu_state *cpu_state;
> +
> +	cons_atomic_flush(NULL, true);
> +
> +	cpu_state = cons_get_cpu_state();
> +
> +	if (cpu_state->prio == CONS_PRIO_PANIC)
> +		cons_atomic_flush(NULL, false);
> +
> +	/*
> +	 * Undo the nesting of cons_atomic_enter() at the CPU state
> +	 * priority.
> +	 */
> +	cpu_state->nesting[cpu_state->prio]--;
> +
> +	/*
> +	 * Restore the previous priority, which was returned by
> +	 * cons_atomic_enter().
> +	 */
> +	cpu_state->prio = prev_prio;
> +
> +	migrate_enable();
> +}
> +

All this is pretty complicated. It seems that it duplicates a lot
of information and checks that are already done in cons_try_acquire().
I wonder if it is another relic of the POC that allowed taking
over a context of the same priority.

In this version, most of the nesting/recursion problems are already
handled by cons_try_acquire(). All nested/recursion context will
never be able to get the lock when the priority stays the same.

What about the following?

It is inspired by printk_safe handling:

#define PRINTK_EMERGENCY_CTXT_MASK	0x0000ffff
#define PRINTK_PANIC_CTXT_MASK		0xffff0000
#define PRINTK_PANIC_CTXT_OFFSET	0x00010000

DEFINE_PER_CPU(int, printk_ctxt_prio);

void printk_emergency_enter(void)
{
	this_cpu_inc(printk_ctxt_prio);
}

void printk_emergency_enter(void)
{
	this_cpu_dec(printk_ctxt_prio);
}

void printk_panic_enter(void)
{
	this_cpu_add(printk_ctxt_prio, PRINTK_PANIC_CTXT_OFFSET);
}

void printk_panic_exit(void)
{
	this_cpu_sub(printk_ctxt_prio, PRINTK_PANIC_CTXT_OFFSET);
}

enum cons_prio printk_prio_to_cons_prio(void)
{
	int pr_ctxt_prio = this_cpu_read(printk_ctxt_prio);

	if (pr_ctxt_prio & PRINTK_PANIC_CTXT_MASK)
		return CONS_PRIO_PANIC;

	if (pr_ctxt_prio & PRINTK_EMERGENCY_CTXT_MASK)
		return CONS_PRIO_EMERGENCY;

	return CONS_PRIO_NORMAL;
}

void cons_context_init(struct cons_write_context *wctxt,
		       struct console *con,
		       enum cons_prio prio,
		       bool allow_hostile)
{
	struct cons_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);

	memset(wctxt, 0, sizeof(*wctxt));

	ctxt->prio = prio;
	ctxt->console = con;
	/*
	 * FIXME: This was discussed in another mail. I think that
	 * everything should be fine when every console driver has
	 * its owns buffer for each console constext priority.
	 */
	ctxt->pbufs = cons_get_ctxt_pbufs(con, prio);
	ctxt->allow_hostile = allow_hostile;

	if (prio >= CON_EMERGENCY_PRIO) {
		ctxt->spinwait_max_us	= 2000;
		ctxt->spinwait		= 1;
	}
}

/*
 * Try to flush messages on NOBKL consoles using atomic_write() callback.
 * The console context priority is defined by printk_ctxt_prio.
 *
 * It fails when it is not able to get the console atomic lock.
 * In that case the messages should be flushed by the current owner.
 *
 * It does nothing in NORMAL context when the printk thread already exists.
 * The kthread should take care of the job.
 */
void cons_try_atomic_flush_con(struct console *con, bool allow_hostile)
{
	struct cons_write_context wctxt;
	struct cons_context *ctxt = &wctxt.ctxt;
	enum cons_prio prio;

	prio = printk_prio_to_cons_prio();

	if (con->kthread && prio <= CONS_NORMAL_PRIO)
		return;

	cons_write_context_init(&wctxt, con, prio, allow_hostile);

	if (!cons_try_acquire_wtxtx(&wctxt))
		return;

	for (;;) {
		/*
		 * emit messages as long as there is any
		 * and still owning the lock
		 */
	};

	cons_release_wtxtx(&wctxt);
}

void cons_try_atomic_flush(bool allow_hostile)
{
	struct console *con;
	int cookie;

	cookie = console_srcu_read_lock();
	for_each_console_srcu(con) {
		cons_try_atomic_flush_con(con, allow_hostile);
	}
	console_srcu_read_unlock(cookie);
}

Best Regards,
Petr
