Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E92D06BEFC1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 18:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjCQReh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 13:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjCQRef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 13:34:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05618474E5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 10:34:30 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E733F21A80;
        Fri, 17 Mar 2023 17:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1679074468; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j0h5IAyqo87of1JtWKAwludnQJcaGxaLhpvFL2hHO74=;
        b=KBMmC6meYE/C+qIhRQyv/5oVNxTlMDipXt3e6AmKlpYnQgd4NbSMSmFOjeECHFx4+vb/4h
        aWNn/zJxtl3iN/G6oEI7SCYYxzWe/s0+j3chAQkcFRh8C4lGxZqCEFJ9JauUyq/oQuXW8W
        2i9gQirRt6l0Kl1i51dSu75iY2g5xxI=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A5C862C141;
        Fri, 17 Mar 2023 17:34:27 +0000 (UTC)
Date:   Fri, 17 Mar 2023 18:34:24 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: simplify: was: Re: [PATCH printk v1 06/18] printk: nobkl: Add
 acquire/release logic
Message-ID: <ZBSkoKCdG5uiVNPq@alley>
References: <20230302195618.156940-1-john.ogness@linutronix.de>
 <20230302195618.156940-7-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302195618.156940-7-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I send this before reading today's answers about the basic rules.

I have spent on this answer few days and I do not want to delay
it indefinitely. It documents my initial feelings about the code.
Also it describes some ideas that might or need not be useful
anyway.

Also there is a POC that slightly modifies the logic. But the basic
approach remains the same.

On Thu 2023-03-02 21:02:06, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Add per console acquire/release functionality. The console 'locked'
> state is a combination of several state fields:
> 
>   - The 'locked' bit
> 
>   - The 'cpu' field that denotes on which CPU the console is locked
> 
>   - The 'cur_prio' field that contains the severity of the printk
>     context that owns the console. This field is used for decisions
>     whether to attempt friendly handovers and also prevents takeovers
>     from a less severe context, e.g. to protect the panic CPU.
> 
> The acquire mechanism comes with several flavours:
> 
>   - Straight forward acquire when the console is not contended
> 
>   - Friendly handover mechanism based on a request/grant handshake
> 
>     The requesting context:
> 
>       1) Puts the desired handover state (CPU nr, prio) into a
>          separate handover state
> 
>       2) Sets the 'req_prio' field in the real console state
> 
>       3) Waits (with a timeout) for the owning context to handover
> 
>     The owning context:
> 
>       1) Observes the 'req_prio' field set
> 
>       2) Hands the console over to the requesting context by
>          switching the console state to the handover state that was
>          provided by the requester
> 
>   - Hostile takeover
> 
>       The new owner takes the console over without handshake
> 
>       This is required when friendly handovers are not possible,
>       i.e. the higher priority context interrupted the owning context
>       on the same CPU or the owning context is not able to make
>       progress on a remote CPU.
> 
> The release is the counterpart which either releases the console
> directly or hands it gracefully over to a requester.
> 
> All operations on console::atomic_state[CUR|REQ] are atomic
> cmpxchg based to handle concurrency.
> 
> The acquire/release functions implement only minimal policies:
> 
>   - Preference for higher priority contexts
>   - Protection of the panic CPU
> 
> All other policy decisions have to be made at the call sites.
> 
> The design allows to implement the well known:
> 
>     acquire()
>     output_one_line()
>     release()
> 
> algorithm, but also allows to avoid the per line acquire/release for
> e.g. panic situations by doing the acquire once and then relying on
> the panic CPU protection for the rest.
> 
> Co-developed-by: John Ogness <john.ogness@linutronix.de>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Signed-off-by: Thomas Gleixner (Intel) <tglx@linutronix.de>
> ---
>  include/linux/console.h      |  82 ++++++
>  kernel/printk/printk_nobkl.c | 531 +++++++++++++++++++++++++++++++++++
>  2 files changed, 613 insertions(+)
> 
> diff --git a/include/linux/console.h b/include/linux/console.h
> index b9d2ad580128..2c95fcc765e6 100644
> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -176,8 +176,20 @@ enum cons_flags {
>   * @seq:	Sequence for record tracking (64bit only)
>   * @bits:	Compound of the state bits below
>   *
> + * @locked:	Console is locked by a writer
> + * @unsafe:	Console is busy in a non takeover region
> + * @cur_prio:	The priority of the current output
> + * @req_prio:	The priority of a handover request
> + * @cpu:	The CPU on which the writer runs
> + *
>   * To be used for state read and preparation of atomic_long_cmpxchg()
>   * operations.
> + *
> + * The @req_prio field is particularly important to allow spin-waiting to
> + * timeout and give up without the risk of it being assigned the lock
> + * after giving up. The @req_prio field has a nice side-effect that it
> + * also makes it possible for a single read+cmpxchg in the common case of
> + * acquire and release.
>   */
>  struct cons_state {
>  	union {
> @@ -189,12 +201,79 @@ struct cons_state {
>  			union {
>  				u32	bits;
>  				struct {
> +					u32 locked	:  1;

Is this bit really necessary?

The console is locked when con->atomic_state[CUR] != 0.
This check gives the same information.

Motivation:

The code is quite complex by definition. It implements
a sleeping lock with spinlock-like waiting with timeout,
priorities, voluntary and hostile take-over.

The main logic is easier than the lockless printk rinbuffer.
But it was still hard for me to understand it. And I am still
not sure if it is OK.

One big problem is the manipulation of cons_state. It includes
a lot of information. And I am never sure if we compare
the right bits and if we pass the right value to cmpxchg.

Any simplification might help. And an extra bit that does not
bring an extra information looks like non-necessary complication.

> +					u32 unsafe	:  1;
> +					u32 cur_prio	:  2;
> +					u32 req_prio	:  2;
> +					u32 cpu		: 18;
>  				};
>  			};
>  		};
>  	};
>  };
>  
> +/**
> + * cons_prio - console writer priority for NOBKL consoles
> + * @CONS_PRIO_NONE:		Unused
> + * @CONS_PRIO_NORMAL:		Regular printk
> + * @CONS_PRIO_EMERGENCY:	Emergency output (WARN/OOPS...)
> + * @CONS_PRIO_PANIC:		Panic output
> + *
> + * Emergency output can carefully takeover the console even without consent
> + * of the owner, ideally only when @cons_state::unsafe is not set. Panic
> + * output can ignore the unsafe flag as a last resort. If panic output is
> + * active no takeover is possible until the panic output releases the
> + * console.
> + */
> +enum cons_prio {
> +	CONS_PRIO_NONE = 0,
> +	CONS_PRIO_NORMAL,
> +	CONS_PRIO_EMERGENCY,
> +	CONS_PRIO_PANIC,
> +};
> +
> +struct console;
> +
> +/**
> + * struct cons_context - Context for console acquire/release
> + * @console:		The associated console

There are 4 state variables below. It is really hard to
understand what information they include and when they
are updates and why we need to keep it.

I'll describe how they confused me:

> + * @state:		The state at acquire time

This sounds like it is a copy of con->atomic_state[CUR] read
before trying to acquire it.

But the code copies there some new state via
copy_full_state(ctxt->state, new);

> + * @old_state:		The old state when try_acquire() failed for analysis
> + *			by the caller

This sounds like a copy of con->atomic_state[CUR] when
cmpxchg failed. It means that @state is probably
not longer valid.

It sounds strange that we would need to have remember
both values. So, I guess that the meaning is different.

> + * @hov_state:		The handover state for spin and cleanup

It sounds like the value that we put into con->atomic_state[REQ].

> + * @req_state:		The request state for spin and cleanup

This is quite confusing. It is req_state but it seems to be yet
another cache of con->atomic_state[CUR].

Now, a better name and better explantion might help. But even better might
be to avoid/remove some of these values. I have some ideas see below.


> + * @spinwait_max_us:	Limit for spinwait acquire
> + * @prio:		Priority of the context
> + * @hostile:		Hostile takeover requested. Cleared on normal
> + *			acquire or friendly handover
> + * @spinwait:		Spinwait on acquire if possible
> + */
> +struct cons_context {
> +	struct console		*console;
> +	struct cons_state	state;
> +	struct cons_state	old_state;
> +	struct cons_state	hov_state;
> +	struct cons_state	req_state;
> +	unsigned int		spinwait_max_us;
> +	enum cons_prio		prio;
> +	unsigned int		hostile		: 1;
> +	unsigned int		spinwait	: 1;
> +};
> +
> +/**
> + * struct cons_write_context - Context handed to the write callbacks
> + * @ctxt:	The core console context
> + * @outbuf:	Pointer to the text buffer for output
> + * @len:	Length to write
> + * @unsafe:	Invoked in unsafe state due to force takeover
> + */
> +struct cons_write_context {
> +	struct cons_context	__private ctxt;
> +	char			*outbuf;
> +	unsigned int		len;
> +	bool			unsafe;
> +};
> +
>  /**
>   * struct console - The console descriptor structure
>   * @name:		The name of the console driver
> --- a/kernel/printk/printk_nobkl.c
> +++ b/kernel/printk/printk_nobkl.c
> @@ -4,6 +4,7 @@
>  
>  #include <linux/kernel.h>
>  #include <linux/console.h>
> +#include <linux/delay.h>
>  #include "internal.h"
>  /*
>   * Printk implementation for consoles that do not depend on the BKL style
> @@ -112,6 +113,536 @@ static inline bool cons_state_try_cmpxchg(struct console *con,
>  				       &old->atom, new->atom);
>  }
>  
> +/**
> + * cons_state_full_match - Check whether the full state matches
> + * @cur:	The state to check
> + * @prev:	The previous state
> + *
> + * Returns: True if matching, false otherwise.
> + *
> + * Check the full state including state::seq on 64bit. For take over
> + * detection.
> + */
> +static inline bool cons_state_full_match(struct cons_state cur,
> +					 struct cons_state prev)
> +{
> +	/*
> +	 * req_prio can be set by a concurrent writer for friendly
> +	 * handover. Ignore it in the comparison.
> +	 */
> +	cur.req_prio = prev.req_prio;
> +	return cur.atom == prev.atom;

This function seems to be used to check if the context is still the same.
Is it really important to check the entire atom, please?

The current owner should be defined by CPU number and the priority.
Anything else is an information that we want to change an atomic
way together with the owner. But they should not really be needed
to indentify the owner.

My motivation is to make it clear what we are testing.
cons_state_full_match() and cons_state_bits_match() have vague names.
They play games with cur.req_prio. The result depends on which
state we are testing against.

Also I think that it is one reason why we need the 4 cons_state variables
in struct cons_context. We need to check against a particular
full const_state variables.

I am not 100% sure but I think that checking particular fields
might make things more strightforward. I have more ideas,
see below.

> +
> +/**
> + * cons_state_bits_match - Check for matching state bits
> + * @cur:	The state to check
> + * @prev:	The previous state
> + *
> + * Returns: True if state matches, false otherwise.
> + *
> + * Contrary to cons_state_full_match this checks only the bits and ignores
> + * a sequence change on 64bits. On 32bit the two functions are identical.
> + */
> +static inline bool cons_state_bits_match(struct cons_state cur, struct cons_state prev)
> +{
> +	/*
> +	 * req_prio can be set by a concurrent writer for friendly
> +	 * handover. Ignore it in the comparison.
> +	 */
> +	cur.req_prio = prev.req_prio;
> +	return cur.bits == prev.bits;
> +}
> +
> +/**
> + * cons_check_panic - Check whether a remote CPU is in panic
> + *
> + * Returns: True if a remote CPU is in panic, false otherwise.
> + */
> +static inline bool cons_check_panic(void)
> +{
> +	unsigned int pcpu = atomic_read(&panic_cpu);
> +
> +	return pcpu != PANIC_CPU_INVALID && pcpu != smp_processor_id();
> +}
> +
> +/**
> + * cons_cleanup_handover - Cleanup a handover request
> + * @ctxt:	Pointer to acquire context
> + *
> + * @ctxt->hov_state contains the state to clean up
> + */
> +static void cons_cleanup_handover(struct cons_context *ctxt)
> +{
> +	struct console *con = ctxt->console;
> +	struct cons_state new;
> +
> +	/*
> +	 * No loop required. Either hov_state is still the same or
> +	 * not.
> +	 */
> +	new.atom = 0;
> +	cons_state_try_cmpxchg(con, CON_STATE_REQ, &ctxt->hov_state, &new);
> +}
> +
> +/**
> + * cons_setup_handover - Setup a handover request
> + * @ctxt:	Pointer to acquire context
> + *
> + * Returns: True if a handover request was setup, false otherwise.
> + *
> + * On success @ctxt->hov_state contains the requested handover state
> + *
> + * On failure this context is not allowed to request a handover from the
> + * current owner. Reasons would be priority too low or a remote CPU in panic.
> + * In both cases this context should give up trying to acquire the console.
> + */
> +static bool cons_setup_handover(struct cons_context *ctxt)
> +{
> +	unsigned int cpu = smp_processor_id();
> +	struct console *con = ctxt->console;
> +	struct cons_state old;
> +	struct cons_state hstate = {
> +		.locked		= 1,
> +		.cur_prio	= ctxt->prio,
> +		.cpu		= cpu,
> +	};
> +
> +	/*
> +	 * Try to store hstate in @con->atomic_state[REQ]. This might
> +	 * race with a higher priority waiter.
> +	 */
> +	cons_state_read(con, CON_STATE_REQ, &old);
> +	do {
> +		if (cons_check_panic())
> +			return false;
> +
> +		/* Same or higher priority waiter exists? */
> +		if (old.cur_prio >= ctxt->prio)
> +			return false;
> +
> +	} while (!cons_state_try_cmpxchg(con, CON_STATE_REQ, &old, &hstate));
> +
> +	/* Save that state for comparison in spinwait */
> +	copy_full_state(ctxt->hov_state, hstate);
> +	return true;
> +}
> +
> +/**
> + * cons_setup_request - Setup a handover request in state[CUR]
> + * @ctxt:	Pointer to acquire context
> + * @old:	The state that was used to make the decision to spin wait
> + *
> + * Returns: True if a handover request was setup in state[CUR], false
> + * otherwise.
> + *
> + * On success @ctxt->req_state contains the request state that was set in
> + * state[CUR]
> + *
> + * On failure this context encountered unexpected state values. This
> + * context should retry the full handover request setup process (the
> + * handover request setup by cons_setup_handover() is now invalidated
> + * and must be performed again).
> + */
> +static bool cons_setup_request(struct cons_context *ctxt, struct cons_state old)
> +{
> +	struct console *con = ctxt->console;
> +	struct cons_state cur;
> +	struct cons_state new;
> +
> +	/* Now set the request in state[CUR] */
> +	cons_state_read(con, CON_STATE_CUR, &cur);
> +	do {
> +		if (cons_check_panic())
> +			goto cleanup;
> +
> +		/* Bit state changed vs. the decision to spinwait? */
> +		if (!cons_state_bits_match(cur, old))
> +			goto cleanup;
> +
> +		/*
> +		 * A higher or equal priority context already setup a
> +		 * request?
> +		 */
> +		if (cur.req_prio >= ctxt->prio)
> +			goto cleanup;
> +
> +		/* Setup a request for handover. */
> +		copy_full_state(new, cur);
> +		new.req_prio = ctxt->prio;
> +	} while (!cons_state_try_cmpxchg(con, CON_STATE_CUR, &cur, &new));
> +
> +	/* Save that state for comparison in spinwait */
> +	copy_bit_state(ctxt->req_state, new);
> +	return true;
> +
> +cleanup:
> +	cons_cleanup_handover(ctxt);
> +	return false;
> +}
> +
> +/**
> + * cons_try_acquire_spin - Complete the spinwait attempt
> + * @ctxt:	Pointer to an acquire context that contains
> + *		all information about the acquire mode
> + *
> + * @ctxt->hov_state contains the handover state that was set in
> + * state[REQ]
> + * @ctxt->req_state contains the request state that was set in
> + * state[CUR]
> + *
> + * Returns: 0 if successfully locked. -EBUSY on timeout. -EAGAIN on
> + * unexpected state values.
> + *
> + * On success @ctxt->state contains the new state that was set in
> + * state[CUR]
> + *
> + * On -EBUSY failure this context timed out. This context should either
> + * give up or attempt a hostile takeover.
> + *
> + * On -EAGAIN failure this context encountered unexpected state values.
> + * This context should retry the full handover request setup process (the
> + * handover request setup by cons_setup_handover() is now invalidated and
> + * must be performed again).
> + */
> +static bool cons_try_acquire_spin(struct cons_context *ctxt)
> +{
> +	struct console *con = ctxt->console;
> +	struct cons_state cur;
> +	struct cons_state new;
> +	int err = -EAGAIN;
> +	int timeout;
> +
> +	/* Now wait for the other side to hand over */
> +	for (timeout = ctxt->spinwait_max_us; timeout >= 0; timeout--) {
> +		/* Timeout immediately if a remote panic is detected. */
> +		if (cons_check_panic())
> +			break;
> +
> +		cons_state_read(con, CON_STATE_CUR, &cur);
> +
> +		/*
> +		 * If the real state of the console matches the handover state
> +		 * that this context setup, then the handover was a success
> +		 * and this context is now the owner.
> +		 *
> +		 * Note that this might have raced with a new higher priority
> +		 * requester coming in after the lock was handed over.
> +		 * However, that requester will see that the owner changes and
> +		 * setup a new request for the current owner (this context).
> +		 */
> +		if (cons_state_bits_match(cur, ctxt->hov_state))
> +			goto success;
> +
> +		/*
> +		 * If state changed since the request was made, give up as
> +		 * it is no longer consistent. This must include
> +		 * state::req_prio since there could be a higher priority
> +		 * request available.
> +		 */
> +		if (cur.bits != ctxt->req_state.bits)

IMHO, this would fail when .unsafe flag (added later) has another
value. But it does not mean that we should stop waiting.

This is one example that comparing all bits makes things tricky.


> +			goto cleanup;
> +
> +		/*
> +		 * Finally check whether the handover state is still
> +		 * the same.
> +		 */
> +		cons_state_read(con, CON_STATE_REQ, &cur);
> +		if (cur.atom != ctxt->hov_state.atom)
> +			goto cleanup;
> +
> +		/* Account time */
> +		if (timeout > 0)
> +			udelay(1);
> +	}
> +
> +	/*
> +	 * Timeout. Cleanup the handover state and carefully try to reset
> +	 * req_prio in the real state. The reset is important to ensure
> +	 * that the owner does not hand over the lock after this context
> +	 * has given up waiting.
> +	 */
> +	cons_cleanup_handover(ctxt);
> +
> +	cons_state_read(con, CON_STATE_CUR, &cur);
> +	do {
> +		/*
> +		 * The timeout might have raced with the owner coming late
> +		 * and handing it over gracefully.
> +		 */
> +		if (cons_state_bits_match(cur, ctxt->hov_state))
> +			goto success;
> +
> +		/*
> +		 * Validate that the state matches with the state at request
> +		 * time. If this check fails, there is already a higher
> +		 * priority context waiting or the owner has changed (either
> +		 * by higher priority or by hostile takeover). In all fail
> +		 * cases this context is no longer in line for a handover to
> +		 * take place, so no reset is necessary.
> +		 */
> +		if (cur.bits != ctxt->req_state.bits)
> +			goto cleanup;

Again, this might give wrong result because of the .unsafe bit.

Also "goto cleanup" looks superfluous. cons_cleanup_handover() has
already been called above.

> +
> +		copy_full_state(new, cur);
> +		new.req_prio = 0;
> +	} while (!cons_state_try_cmpxchg(con, CON_STATE_CUR, &cur, &new));
> +	/* Reset worked. Report timeout. */
> +	return -EBUSY;
> +
> +success:
> +	/* Store the real state */
> +	copy_full_state(ctxt->state, cur);
> +	ctxt->hostile = false;
> +	err = 0;
> +
> +cleanup:
> +	cons_cleanup_handover(ctxt);
> +	return err;
> +}
> +
> +/**
> + * __cons_try_acquire - Try to acquire the console for printk output
> + * @ctxt:	Pointer to an acquire context that contains
> + *		all information about the acquire mode
> + *
> + * Returns: True if the acquire was successful. False on fail.
> + *
> + * In case of success @ctxt->state contains the acquisition
> + * state.
> + *
> + * In case of fail @ctxt->old_state contains the state
> + * that was read from @con->state for analysis by the caller.
> + */
> +static bool __cons_try_acquire(struct cons_context *ctxt)
> +{
> +	unsigned int cpu = smp_processor_id();
> +	struct console *con = ctxt->console;
> +	short flags = console_srcu_read_flags(con);
> +	struct cons_state old;
> +	struct cons_state new;
> +	int err;
> +
> +	if (WARN_ON_ONCE(!(flags & CON_NO_BKL)))
> +		return false;
> +again:
> +	cons_state_read(con, CON_STATE_CUR, &old);
> +
> +	/* Preserve it for the caller and for spinwait */
> +	copy_full_state(ctxt->old_state, old);
> +
> +	if (cons_check_panic())
> +		return false;
> +
> +	/* Set up the new state for takeover */
> +	copy_full_state(new, old);
> +	new.locked = 1;
> +	new.cur_prio = ctxt->prio;
> +	new.req_prio = CONS_PRIO_NONE;
> +	new.cpu = cpu;
> +
> +	/* Attempt to acquire it directly if unlocked */
> +	if (!old.locked) {
> +		if (!cons_state_try_cmpxchg(con, CON_STATE_CUR, &old, &new))
> +			goto again;
> +
> +		ctxt->hostile = false;
> +		copy_full_state(ctxt->state, new);
> +		goto success;
> +	}
> +cons_state_bits_match(cur, ctxt->hov_state)
> +	/*
> +	 * If the active context is on the same CPU then there is
> +	 * obviously no handshake possible.
> +	 */
> +	if (old.cpu == cpu)
> +		goto check_hostile;
> +
> +	/*
> +	 * If a handover request with same or higher priority is already
> +	 * pending then this context cannot setup a handover request.
> +	 */
> +	if (old.req_prio >= ctxt->prio)
> +		goto check_hostile;
> +
> +	/*
> +	 * If the caller did not request spin-waiting then performing a
> +	 * handover is not an option.
> +	 */
> +	if (!ctxt->spinwait)
> +		goto check_hostile;
> +
> +	/*
> +	 * Setup the request in state[REQ]. If this fails then this
> +	 * context is not allowed to setup a handover request.
> +	 */
> +	if (!cons_setup_handover(ctxt))
> +		goto check_hostile;
> +
> +	/*
> +	 * Setup the request in state[CUR]. Hand in the state that was
> +	 * used to make the decision to spinwait above, for comparison. If
> +	 * this fails then unexpected state values were encountered and the
> +	 * full request setup process is retried.
> +	 */
> +	if (!cons_setup_request(ctxt, old))
> +		goto again;
> +
> +	/*
> +	 * Spin-wait to acquire the console. If this fails then unexpected
> +	 * state values were encountered (for example, a hostile takeover by
> +	 * another context) and the full request setup process is retried.
> +	 */
> +	err = cons_try_acquire_spin(ctxt);
> +	if (err) {
> +		if (err == -EAGAIN)
> +			goto again;
> +		goto check_hostile;
> +	}
> +success:
> +	/* Common updates on success */
> +	return true;
> +
> +check_hostile:
> +	if (!ctxt->hostile)
> +		return false;
> +
> +	if (cons_check_panic())
> +		return false;
> +
> +	if (!cons_state_try_cmpxchg(con, CON_STATE_CUR, &old, &new))
> +		goto again;
> +
> +	copy_full_state(ctxt->state, new);
> +	goto success;
> +}
> +
> +/**
> + * cons_try_acquire - Try to acquire the console for printk output
> + * @ctxt:	Pointer to an acquire context that contains
> + *		all information about the acquire mode
> + *
> + * Returns: True if the acquire was successful. False on fail.
> + *
> + * In case of success @ctxt->state contains the acquisition
> + * state.
> + *
> + * In case of fail @ctxt->old_state contains the state
> + * that was read from @con->state for analysis by the caller.
> + */
> +static bool cons_try_acquire(struct cons_context *ctxt)
> +{
> +	if (__cons_try_acquire(ctxt))
> +		return true;
> +
> +	ctxt->state.atom = 0;
> +	return false;
> +}
> +
> +/**
> + * __cons_release - Release the console after output is done
> + * @ctxt:	The acquire context that contains the state
> + *		at cons_try_acquire()
> + *
> + * Returns:	True if the release was regular
> + *
> + *		False if the console is in unusable state or was handed over
> + *		with handshake or taken	over hostile without handshake.
> + *
> + * The return value tells the caller whether it needs to evaluate further
> + * printing.
> + */
> +static bool __cons_release(struct cons_context *ctxt)
> +{
> +	struct console *con = ctxt->console;
> +	short flags = console_srcu_read_flags(con);
> +	struct cons_state hstate;
> +	struct cons_state old;
> +	struct cons_state new;
> +
> +	if (WARN_ON_ONCE(!(flags & CON_NO_BKL)))
> +		return false;
> +
> +	cons_state_read(con, CON_STATE_CUR, &old);
> +again:
> +	if (!cons_state_bits_match(old, ctxt->state))
> +		return false;
> +
> +	/* Release it directly when no handover request is pending. */
> +	if (!old.req_prio)
> +		goto unlock;
> +
> +	/* Read the handover target state */
> +	cons_state_read(con, CON_STATE_REQ, &hstate);
> +
> +	/* If the waiter gave up hstate is 0 */
> +	if (!hstate.atom)
> +		goto unlock;
> +
> +	/*
> +	 * If a higher priority waiter raced against a lower priority
> +	 * waiter then unlock instead of handing over to either. The
> +	 * higher priority waiter will notice the updated state and
> +	 * retry.
> +	 */
> +	if (hstate.cur_prio != old.req_prio)
> +		goto unlock;
> +
> +	/* Switch the state and preserve the sequence on 64bit */
> +	copy_bit_state(new, hstate);
> +	copy_seq_state64(new, old);
> +	if (!cons_state_try_cmpxchg(con, CON_STATE_CUR, &old, &new))
> +		goto again;
> +
> +	return true;
> +
> +unlock:
> +	/* Clear the state and preserve the sequence on 64bit */
> +	new.atom = 0;
> +	copy_seq_state64(new, old);
> +	if (!cons_state_try_cmpxchg(con, CON_STATE_CUR, &old, &new))
> +		goto again;
> +

The entire logic is quite tricky. I checked many possible races
and everything looked fine. But then (after many what if) I found
this quite tricky problem:

CPU0				CPU1

// releasing the lock		// spinning 
__cons_release()		cons_try_acquire_spin()

// still see CPU1 spinning
cons_state_read(REQ, hstate);

				// timeout
				// clear REQ
				cons_cleanup_handover(ctxt);

				// still see CPU0 locked
				const_state_read(CUR)

// assign con to CPU1
cons_state_try_cmpxchg(con, CUR, old, hstate)

// try to get the lock again
__cons_try_acquire();

// see it locked by CPU1
cons_state_read(con);

// set CPU0 into REQ
// it has been cleared by CPU1
// => success
cons_setup_handover()

// set req_prio in CUR
// cur.req_prio is 0 because
// we did set CPU1 as the owner.
// => success
cons_setup_request()

Note: Everything looks fine at this moment.
      CPU1 is about to realize that it became the owner.
      CPU0 became the waiter.
      BUT...


				// try clear req_prio in CUR
				// fails because we became the owner
				// CUR.cpu has changed to CPU1
				while (!cmpxchg(con, CUR, old, new))

				// re-read CUR
				const_state_read(CUR)

				// it misses that it is the owner because
				// .req_prio is already set for CPU0
				cons_state_bits_match(cur, ctxt->hov_state)

				if (cur.bits != ctxt->req_state.bits)
				       goto clean up;


BANG: It goes to clean up because cur.cpu is CPU1. But the original
      req_state.cpu is CPU0. The ctxt->req_state was set at
      the beginning when CUR was owned by CPU0.

      As a result. con->atomic_state[CUR] says that the console is
      locked by CPU1. But CPU1 is not aware of this.


My opinion:

I think that the current code is more error prone that it could be.
IMHO, the main problems are:

    + the checks of the owner fails when other-unrelated bits
      are modified

    + also the hand shake between the CUR and REQ state is
      complicated on both try_ack and release sides. And
      we haven't even started talking about barriers yet.



Ideas:

I though about many approaches. And the following ideas looked
promissing:

    + Make the owner checks reliable by explicitly checking
      .prio and .cpu values.

    + The hand shake and probably also barriers might be easier
      when release() modifies only CUR value. Then all the magic
      is done on the try_acquire part.


POC:

Note: I removed seq from the cons_state for simplicity.
      Well, I think that we could actually keep it separate.

/**
 * struct cons_state - console state for NOBKL consoles
 * @atom:	Compound of the state fields for atomic operations
 * @req_prio:	Priority of request that would like to take over the lock
 * @unsafe:	Console is busy in a non takeover region
 * @prio:	The priority of the current state owner
 * @cpu:	The CPU on which the state owner runs
 *
 * Note: cur_prio and req_prio are a bit confusing in the REG state
 *       I removed the cur_ prefix. The meaning is that they own
 *       this particular const_state.
 */
struct cons_state {
	union {
		u32	atom;
		struct {
			u32 req_prio	:  2;
			u32 unsafe	:  1;
			u32 prio	:  2;
			u32 cpu	: 18;
		};
	};
};

/*
 * struct cons_context - Context for console acquire/release
 * @prio:	The priority of the current context owner
 * @cpu:	The CPU on which the context runs
 * @cur_prio:   The priority of the CUR state owner taken (cache)
 * @cur_cpu:    The CPU on which the CUR state owner runs (cache)
 * @stay_safe:  Could get the lock the hostile way only when
 *		the console driver is in a safe state.
 *
 * The cur_* cache values are taken at the beginning of
 * cons_try_acquire() when it fails to take the CUR state (lock).
 * directly. It allows to manipulate CUR state later. It is valid
 * as long as the CUR owner stays the same.
 */
struct cons_context {
	u32			prio     :2;
	u32			cpu      :18;
	u32			cur_prio :2;
	u32			cut_cpu  :18;
	bool			stay_safe;
}

/**
 * cons_context_owner_matches() - check if the owner of cons_context
 *		match cons_state owner.
 *
 * Alternative would be to put .prio .cpu into an union
 * compare both directly, something like:
 *
 *	union {
 *		u32 owner: 24;
 *		struct {
 *			u32 prio : 2;
 *			u32 cpu  : 22;
 *		};
 *	};
 *
 *  and use (state.owner == ctxt.owner) directly in the code.
 */
bool cons_state_owner_matches(struct cons_context *ctxt,
			      struct const_state *state)
{
	if (state->prio != ctxt->prio)
		return false;

	if (state->cpu != ctxt->cpu)
		return false;

	return true;
}

/**
 * cons_context_owner_matches() - check if the owner of the given
 *	still matches the owner of CUR state cached in the given
 *      context struct.
 *
 *  It allows to ignore other state changes as long as the CUR
 *  state owner stays the same.
 */
bool cur_cons_state_owner_matches(struct cons_context *ctxt,
				  struct const_state *state)
{
	if (state->prio != ctxt->cur_prio)
		return false;

	if (state->cpu != ctxt->cur_cpu)
		return false;

	return true;
}

/*
 * Release the lock but preserve the request so that the lock
 * stays blocked for the request.
 *
 * @passing: Release the only when there is still a request.
 *	Use this option when the current owner passes the lock
 *	prematurelly on request from a context with a higher
 *	priority. It prevents lossing the lock when the request
 *	timeouted in the meantime.
 */
bool __cons_release(struct cons_context *ctxt, bool passing)
{
	struct console *con = ctxt->con;
	struct cons_state cur, new_cur;
	ret = true;

	cons_read_state(con, CON_STATE_CUR, &cur);
	do {
		/* Am I still the owner? */
		if (!cons_state_owner_matches(ctxt, cur))
			return false;

		/*
		 * Avoid passing the lock when the request disappeared
		 * in the mean time.
		 */
		if (passing && !cur.req_prio)
			return false;

		/*
		 * Prepare unlocked state. But preserve .req_prio. It will
		 * keep the lock blocked for the REQ owner context.
		 */
		new_cur.atom = 0;
		new_cur.req_prio = cur.req_prio;
	} while (!cons_state_try_cmpxchg(con, CON_STATE_CUR, &cur, &new_cur));

	return true;
}

bool cons_release(struct cons_context *ctxt)
{
	return __cons_release(ctxt, false);
}

bool cons_release_pass(struct cons_context *ctxt)
{
	return __cons_release(ctxt, true);
}


bool cons_can_proceed(struct const_context *ctxt)
{
	struct console *con = ctxt->con;
	struct cons_state cur;

	cons_read_state(con, CON_STATE_CUR, &cur);

	/* Am I still the owner? */
	if (!cons_state_owner_matches(ctxt, cur))
		return false;

	/*
	 * Pass the lock when there is a request and it is safe.
	 *
	 * The current owner could still procceed when the pass
	 * failed because the request timeouted.
	 */
	if (cur.req_prio && !cur.unsafe) {
		return !cons_release_pass(ctxt);
	}

	return true;
}

/*
 * Try get owner of the CUR state whet it is and there is no pending
 * request.
 */
int cons_try_acquire_directly(struct cons_context *ctxt)
{
	struct cons_state cur;
	struct my = {
		.cpu = ctxt.cpu;
		.prio = ctxt.prio;
	};

	cur.atom = 0;
	if (cons_state_try_cmpxchg(con, CON_STATE_CUR, &cur, &my))
		return 0;

	/* Give up when the current owner has the same or higher priority */
	if (cur.prio >= my.prio)
		return -EBUSY;


	/*
	 * Give up when there is a pedning request with the same or
	 * higher priority.
	 */
	if (cur.req_prio >= my.prio)
		return -EBUSY;

	/*
	 * Cant' take it dirrectly. Store info about the current owner.
	 * The entire try_acquire() needs to get restarted or fail
	 * when it changes.
	 */
	ctxt->cur_prio = cur.prio;
	ctxt->cur_cpu = cur.cpu;
	return -EBUSY;
}


/*
/**
 * cons_try_acquire_request - Set a request to get the lock
 * @ctxt:	Pointer to acquire context
 *
 * Try to set REQ and make CUR aware this request by setting .req_prio.
 *
 * Must be called only when cons_try_acquire_direct() failed.
 *
 * Rerurn: 0 success; -EBUSY when the lock is owned or already required
 *	by a context with a higher or the same priority. -EAGAIN when
 *	the current owner has changed and the caller has to start
 *	from scratch.
 */
bool cons_try_acquire_request(struct cons_context *ctxt)
{
	struct console *con = ctxt->con;
	struct cons_state cur, orig_cur, new_cur, req;
	struct my = {
		.cpu = ctxt.cpu;
		.prio = ctxt.prio;
	};
	int ret;

	/*
	 * Nope when pr_try_acquire_direct() did not cache CUR owner.
	 * It means that CUR has already owner or requested by a context
	 * with the same or higher priority;
	 */
	if (!ctxt->cur_prio)
		return -EBUSY;

	/* First, try to get REQ. */
	cons_state_read(con, CON_STATE_REQ, &req);
	do {
		/*
		 * Give up when the current request has the same or
		 * higher priority.
		 */
		if (req.prio >= my.prio)
			return -EBUSY;
	} while (!cons_state_try_cmpxchg(con, CON_STATE_REQ, &req, &my));

	/*
	 * REQ is ours, tell CUR about our request and spin.
	 *
	 * Accept changes of other state bits as long as the owner
	 * of the console stays the same as the one that blocked
	 * direct locking.
	 */
	cons_state_read(con, CON_STATE_CUR, &cur);
	while (cons_cur_state_matches(ctxt, &cur)) {
		new_cur.atom = cur.atom;
		new_cur.req_prio = ctxt->prio;

		if (cons_state_try_cmpxchg(con, CON_STATE_CUR, &cur, &new_cur))
			return 0;
	};

	/*
	 * Bad luck. The lock owner has changed. The lock was either
	 * released or released and taken by another context or
	 * taken harsh way by a higher priority request.
	 *
	 * Drop our request if it is still there and try again from
	 * the beginning.
	 */
	 req.atom = my.atom;
	 new_req.atom = 0;
	 cons_state_try_cmpxchg(con, CON_STATE_REQ, &req, &new_req);
	 return -EAGAIN;
}

/*
 * cons_try_acquire_spinning - wait for the lock
 * @ctxt:	Pointer to acquire context
 *
 * This can be called only when the context has successfully setup
 * request in REQ and CUR has .request bit set.
 *
 * Return: 0 on success; -EBUSY when a context with a higher priority
 *	took over our request or the lock or when the current owner
 *	have not passed the lock within the timeout.
 */
int cons_try_acquire_spinning(struct cons_context *ctxt)
{
	struct console *con = ctxt->con;
	struct cons_state cur, old_cur, new_cur, req;
	struct cons_state my = {
		.cpu = ctxt->cpu;
		.prio = ctxt->prio;
	};
	bool locked = false;
	int err;

	/* Wait for the other side to hand over */
	for (timeout = ctxt->spinwait_max_us; timeout >= 0; timeout--)
	{
		/* Try to get the lock if it was released. */
		cur.atom = 0;
		cur.req_prio = ctxt->my_prio;
		if (cons_state_try_cmpxchg(con, CON_STATE_CUR, &cur, &my)) {
			locked = true;
			break;
		}

		/*
		 * Give up when another context overridden our request.
		 * It must have had a higher priority.
		 */
		cons_read_state(con, CON_STATE_REQ, &req);
		if (!is_my_cons_state(ctxt, &req))
			goto clean_ctxt_cur;

		/* Acount time. */
		udelay(1);
	}

	 if (!locked) {
		 /*
		  * Timeout passed. Have to remove .req_prio.
		  *
		  * Ignore changes in other flags as long as the owner is
		  * the same as the one that blocked direct locking.
		  * Also .req_prio must be ours.
		  */
		 cons_state_read(con, CON_STATE_CUR, &cur);
		 do {
			 /*
			  * Only a context with higher priority could override
			  * our request. It must have replaced REQ already.
			  */
			 if (cur.req_prio != ctxt.prio)
				 return -EBUSY;

			 new_cur.atom = cur.atom;
			 new_cur.req_prio = 0;
		 } while (!cons_state_try_cmpxchg(con, CON_STATE_CUR, &cur, &new_cur));
	 }

	 /*
	  * We are here either when timeouted or got the lock by spinning.
	  * REQ must be cleaned in both situations.
	  *
	  * It might fail when REQ has been taken by a context with a higher
	  * priority. It is OK.
	  */
	 req.atom = my.atom;
	 new_req.atom = 0;
	 cons_state_try_cmpxchg(con, CON_STATE_REQ, &my, &new_req);

	 return locked ? 0 : -EBUSY;
}

bool cons_try_acquire_hostile(struct cons_context *ctxt)
{
	struct cons_state my = {
		.cpu = ctxt->cpu;
		.prio = ctxt->prio;
	};

	if (ctxt.prio < CONS_PRIO_EMERGENCY)
		return -EBUSY;

	if (cons_check_panic())
		return -EBUSY;

	/*
	 * OK, be hostile and just grab it when safe.
	 * Taking the lock when it is not safe makes sense only as the
	 * last resort when seeing the log is the last wish of the to-be-die
	 * system.
	 *
	 */
	cons_state_read(con, CON_STATE_CUR, &cur)
	do {
		if (ctxt->stay_safe && cur.unsafe)
			return -EBUSY;

		/*
		 * Make sure that the lock has not been taked or requested
		 * by a context with even higher priority.
		 */
		if (cur.prio > my.prio || cur.req_prio > my.prio)
			return -EBUSY;
	} while (!cons_state_try_cmpxchg(con, CON_STATE_CUR, &cur, &my));

	return 0;
}

bool cons_try_acquire(struct cons_context *ctxt)
{
	struct console *con = ctxt->con;
	struct cons_state cur;
	struct my = {
		.cpu = ctxt.cpu;
		.prio = ctxt.prio;
	};
	int err;

try_again:
	ctxt->cur_prio = 0;

	err = cons_try_acquire_directly(ctxt);
	if (!err)
		return true;

	err = cons_try_acquire_request(ctxt);
	if (err == -EAGAIN)
		goto try_again;
	if (err ==-EBUSY)
		return false;

	err = cons_try_acquire_spinning(ctxt);
	if (!err)
		return true;

	err = cons_try_acquire_hostile(ctxt);
	if (!err)
		return true;

	return false;
}


The above POC is not even compile tested. And it is possible that
I missed something important. I rewrote it many times and this is
the best that I was able to produce.

The main principle is still the same. I do not resist on using my
variant. But some ideas might be useful. The main changes:

     + The code compares the owner (.prio + .cpu) instead of the whole
       state atom. It helps to see what is important and what we are
       really checking and ignore unrelated changes in the atomic
       state. Also we need to remember only two owners in struct
       cons_ctxt instead of the 4 cached values.

     + cons_release() just removes the owner. It keeps .req_prio
       so that the lock still stays blocked by the request.

       As a result, cons_release() and cons_can_continue() are
       easier. All the complexity is in try_acquire part.
       I am not completely sure. But it might be easier to
       follow the logic and even document the barriers.

       I mean that it should be easier to see that we set/check/clear
       the various states and bits in the right order. It might also
       make it easier to see and document barriers.


     + Removed the .cur_ prefix. I think that it does more harm
       then good. Especially, it is confusing in REQ state
       and in struct cons_context.


     + I split the code into functions a bit different way.
       It was result of trying various approaches. It is still
       hairy at some points. I am not sure if it is better or
       worse than your code. The different split is not really
       important.

     + I removed the 32-bit sequence number from the state.
       I think that it might be in a separate 32-bit
       atomic variable. It can be updated using cmpxchg when
       the current owner finishes writing a record.

       IMHO, there is no real advantage in passing seq number
       with the lock. Everything will be good when the lock is passed
       correctly. There will always be duplicate lines (part of lines)
       when the lock is passed to a higher priority context
       prematurely.

       But I might miss something. I did not really looked at
       the sequence number related races yet.


     + I also did not add other flags added by later patches. The
       intention of this POC was to play with the code. It was
       useful even when it won't be used. It helped me to understand
       your code and see various catches.


Best Regards,
Petr
