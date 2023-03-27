Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08006CA96F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 17:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbjC0Pp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 11:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjC0Pp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 11:45:27 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB840F3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 08:45:24 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4A80D1FE05;
        Mon, 27 Mar 2023 15:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1679931923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XGf01dqgyirFXpNbWVldpWZLyL1zn43wA9Sw06pvXlE=;
        b=lybFvEmTeYcumpdohchrO+hbQJhd8oXGkRatgIBVBjfmOPsbg6kwT3og+L/aXAt90/JdFn
        UThLCiFeso+hUk8w9QOKU1/JvtFx8VulgvTCPc0aBVUMrUH7JijPVarL0JiEIAGUlvPa40
        uhB/lYsStxWzMm8GnIJEdLc3GLCF42w=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id DEEAB2C141;
        Mon, 27 Mar 2023 15:45:22 +0000 (UTC)
Date:   Mon, 27 Mar 2023 17:45:20 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v1 08/18] printk: nobkl: Add sequence handling
Message-ID: <ZCG6EN4T6d8qleI9@alley>
References: <20230302195618.156940-1-john.ogness@linutronix.de>
 <20230302195618.156940-9-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302195618.156940-9-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2023-03-02 21:02:08, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> On 64bit systems the sequence tracking is embedded into the atomic
> console state, on 32bit it has to be stored in a separate atomic
> member. The latter needs to handle the non-atomicity in hostile
> takeover cases, while 64bit can completely rely on the state
> atomicity.

IMHO, the race on 32-bit is not a big problem. The message might be
printed twice even on 64-bit. And it does not matter which writer
updates the sequence number. The only important thing is that
the sequence number does not go backward. And it is quaranteed
by the cmpxchg.

By other words, IMHO, bundling the lower part of the sequence number
into the atomic state value does not bring any significant advantage.

On the contrary, using the same approach on both 32-bit and 64-bit
simplifies:

    + seq handling by removing one arch-specific variant
    + handling of the atomic state on 64-bit arch

> The ringbuffer sequence number is 64bit, but having a 32bit
> representation in the console is sufficient. If a console ever gets
> more than 2^31 records behind the ringbuffer then this is the least
> of the problems.

Nice trick.

> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -259,6 +261,8 @@ struct cons_context {
>  	struct cons_state	old_state;
>  	struct cons_state	hov_state;
>  	struct cons_state	req_state;
> +	u64			oldseq;
> +	u64			newseq;

I would use old_seq, new_seq. I mean using the same naming scheme as
for req_cpu, req_prio.

>  	unsigned int		spinwait_max_us;
>  	enum cons_prio		prio;
>  	struct printk_buffers	*pbufs;
> @@ -328,6 +333,9 @@ struct console {
>  
>  	/* NOBKL console specific members */
>  	atomic_long_t		__private atomic_state[2];
> +#ifndef CONFIG_64BIT
> +	atomic_t		__private atomic_seq;

I would call it nbcon_seq;

> +#endif
>  	struct printk_buffers	*thread_pbufs;
>  	struct cons_context_data	__percpu *pcpu_data;
>  };
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -511,7 +511,7 @@ _DEFINE_PRINTKRB(printk_rb_static, CONFIG_LOG_BUF_SHIFT - PRB_AVGBITS,
>  
>  static struct printk_ringbuffer printk_rb_dynamic;
>  
> -static struct printk_ringbuffer *prb = &printk_rb_static;
> +struct printk_ringbuffer *prb = &printk_rb_static;
>  
>  /*
>   * We cannot access per-CPU data (e.g. per-CPU flush irq_work) before
> @@ -2728,30 +2728,39 @@ static bool abandon_console_lock_in_panic(void)
>  
>  /*
>   * Check if the given console is currently capable and allowed to print
> - * records.
> - *
> - * Requires the console_srcu_read_lock.
> + * records. If the caller only works with certain types of consoles, the
> + * caller is responsible for checking the console type before calling
> + * this function.
>   */
> -static inline bool console_is_usable(struct console *con)
> +static inline bool console_is_usable(struct console *con, short flags)
>  {
> -	short flags = console_srcu_read_flags(con);
> -
>  	if (!(flags & CON_ENABLED))
>  		return false;
>  
>  	if ((flags & CON_SUSPENDED))
>  		return false;
>  
> -	if (!con->write)
> -		return false;
> -
>  	/*
> -	 * Console drivers may assume that per-cpu resources have been
> -	 * allocated. So unless they're explicitly marked as being able to
> -	 * cope (CON_ANYTIME) don't call them until this CPU is officially up.
> +	 * The usability of a console varies depending on whether
> +	 * it is a NOBKL console or not.
>  	 */
> -	if (!cpu_online(raw_smp_processor_id()) && !(flags & CON_ANYTIME))
> -		return false;
> +
> +	if (flags & CON_NO_BKL) {
> +		if (have_boot_console)
> +			return false;
> +
> +	} else {
> +		if (!con->write)
> +			return false;

It is weird that we check whether con->write exists for the legacy consoles.
But we do not have similar check for CON_NO_BKL consoles.

The ttynull console might actually be a good candidate for a NOBKL console.

> +		/*
> +		 * Console drivers may assume that per-cpu resources have
> +		 * been allocated. So unless they're explicitly marked as
> +		 * being able to cope (CON_ANYTIME) don't call them until
> +		 * this CPU is officially up.
> +		 */
> +		if (!cpu_online(raw_smp_processor_id()) && !(flags & CON_ANYTIME))
> +			return false;

Anyway, I would prefer to put the console_is_usable() change into a
separate patch. It is too hidden here. And it is not really important
for the sequence number handling.

> +	}
>  
>  	return true;
>  }
> @@ -3001,9 +3010,14 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
>  
>  		cookie = console_srcu_read_lock();
>  		for_each_console_srcu(con) {
> +			short flags = console_srcu_read_flags(con);
>  			bool progress;
>  
> -			if (!console_is_usable(con))
> +			/* console_flush_all() is only for legacy consoles. */
> +			if (flags & CON_NO_BKL)
> +				continue;

Same here. This should be in a separate patch that would explain how
con_is_usable() and __flush__ is being changed for NOBKL consoles.

> +
> +			if (!console_is_usable(con, flags))
>  				continue;
>  			any_usable = true;
>  
> @@ -3775,10 +3789,23 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
>  
>  		cookie = console_srcu_read_lock();
>  		for_each_console_srcu(c) {
> +			short flags;
> +
>  			if (con && con != c)
>  				continue;
> -			if (!console_is_usable(c))
> +
> +			flags = console_srcu_read_flags(c);
> +
> +			if (!console_is_usable(c, flags))
>  				continue;

Same here. Separate patch ...

> +			/*
> +			 * Since the console is locked, use this opportunity
> +			 * to update console->seq for NOBKL consoles.
> +			 */
> +			if (flags & CON_NO_BKL)
> +				c->seq = cons_read_seq(c);

This is controversial. c->seq will be out-of-date most of the time.
It might create more harm than good.

I would personally keep this value 0 or -1 for NOBKL consoles.

Note: I thought about putting it into union with the 32-bit atomic_seq.
  But it might cause confusion as well. People might read misleading
  values via con->seq variable. So, I would really keep them separate.


> +
>  			printk_seq = c->seq;
>  			if (printk_seq < seq)
>  				diff += seq - printk_seq;
> diff --git a/kernel/printk/printk_nobkl.c b/kernel/printk/printk_nobkl.c
> index 7db56ffd263a..7184a93a5b0d 100644
> --- a/kernel/printk/printk_nobkl.c
> +++ b/kernel/printk/printk_nobkl.c
> @@ -207,6 +208,227 @@ static __ref void cons_context_set_pbufs(struct cons_context *ctxt)
>  		ctxt->pbufs = &(this_cpu_ptr(con->pcpu_data)->pbufs);
>  }
>  
> +/**
> + * cons_seq_init - Helper function to initialize the console sequence
> + * @con:	Console to work on
> + *
> + * Set @con->atomic_seq to the starting record, or if that record no
> + * longer exists, the oldest available record. For init only. Do not
> + * use for runtime updates.
> + */
> +static void cons_seq_init(struct console *con)
> +{
> +	u32 seq = (u32)max_t(u64, con->seq, prb_first_valid_seq(prb));
> +#ifdef CONFIG_64BIT
> +	struct cons_state state;
> +
> +	cons_state_read(con, CON_STATE_CUR, &state);
> +	state.seq = seq;
> +	cons_state_set(con, CON_STATE_CUR, &state);
> +#else
> +	atomic_set(&ACCESS_PRIVATE(con, atomic_seq), seq);
> +#endif
> +}
> +
> +static inline u64 cons_expand_seq(u64 seq)

I would use "__" prefix to make it clear that it should be used
carefully. And I would add comment that it gives correct result
only when expanding an up-to-date (recently enough read) atomic_seq
values.

> +{
> +	u64 rbseq;
> +
> +	/*
> +	 * The provided sequence is only the lower 32bits of the ringbuffer
> +	 * sequence. It needs to be expanded to 64bit. Get the next sequence
> +	 * number from the ringbuffer and fold it.
> +	 */
> +	rbseq = prb_next_seq(prb);
> +	seq = rbseq - ((u32)rbseq - (u32)seq);
> +
> +	return seq;
> +}
> +
> +static bool cons_release(struct cons_context *ctxt);
> +static bool __maybe_unused cons_seq_try_update(struct cons_context *ctxt)
> +{
> +	struct console *con = ctxt->console;
> +	struct cons_state state;
> +	int pcpu;
> +	u32 old;
> +	u32 new;
> +
> +	/*
> +	 * There is a corner case that needs to be considered here:
> +	 *
> +	 * CPU0			CPU1
> +	 * printk()
> +	 *  acquire()		-> emergency
> +	 *  write()		   acquire()
> +	 *  update_seq()
> +	 *    state == OK
> +	 * --> NMI
> +	 *			   takeover()
> +	 * <---			     write()
> +	 *  cmpxchg() succeeds	     update_seq()
> +	 *			     cmpxchg() fails
> +	 *

Nice explanation. It perfectly explains what might happen.
Anyway, the main "issue" is that the same message is printed twice.
And it can't be fixed even when the seq number is bundled with
the state value.

Crazy idea:  The double output might be avoided if the bundle
   the index of the used buffer and printed character into the atomic
   state variable. Then the other writer might continue where the
   interrupted writer ended.

   But I am not sure if it is worth it. I would keep it easy and live
   with the duplicated lines. We could always make it more complicated
   later.

> +	 * There is nothing that can be done about this other than having
> +	 * yet another state bit that needs to be tracked and analyzed,
> +	 * but fails to cover the problem completely.
> +	 *
> +	 * No other scenarios expose such a problem. On same CPU takeovers
> +	 * the cmpxchg() always fails on the interrupted context after the
> +	 * interrupting context finished printing, but that's fine as it
> +	 * does not own the console anymore. The state check after the
> +	 * failed cmpxchg prevents that.
> +	 */
> +	cons_state_read(con, CON_STATE_CUR, &state);
> +	/* Make sure this context is still the owner. */
> +	if (!cons_state_bits_match(state, ctxt->state))
> +		return false;
> +
> +	/*
> +	 * Get the original sequence number that was retrieved
> +	 * from @con->atomic_seq. @con->atomic_seq should be still
> +	 * the same. 32bit truncates. See cons_context_set_seq().
> +	 */
> +	old = (u32)ctxt->oldseq;
> +	new = (u32)ctxt->newseq;
> +	if (atomic_try_cmpxchg(&ACCESS_PRIVATE(con, atomic_seq), &old, new)) {
> +		ctxt->oldseq = ctxt->newseq;
> +		return true;
> +	}
> +
> +	/*
> +	 * Reread the state. If this context does not own the console anymore
> +	 * then it cannot touch the sequence again.
> +	 */
> +	cons_state_read(con, CON_STATE_CUR, &state);
> +	if (!cons_state_bits_match(state, ctxt->state))
> +		return false;
> +
> +	pcpu = atomic_read(&panic_cpu);
> +	if (pcpu == smp_processor_id()) {
> +		/*
> +		 * This is the panic CPU. Emitting a warning here does not
> +		 * help at all. The callchain is clear and the priority is
> +		 * to get the messages out. In the worst case duplicated
> +		 * ones. That's a job for postprocessing.
> +		 */
> +		atomic_set(&ACCESS_PRIVATE(con, atomic_seq), new);

This is problematic. We are here when the above cmpxchg()
failed. IMHO, there might be two reasons:

     + someone else pushed the line or more lines in the meantime
     + someone did reset the sequence number to re-play the log again

In both cases, we should keep the value as it is. Do not update it.


On the contrary, this function always returns "true" when the above cmpxchg
succeeded. But the current context might have already lost the
lock. Like in the example in the comment. Which is a bit inconsistent
behavior.


I would personally split the function into two:

   1st function that will only try to update the atomic_seq using
      cmpxchg(). The semantic is simple. The caller emitted the entire
      record. Let's update the atomic_seq. Do not worry when it fails.
      It means that we probably lost the lock. But the caller need to
      recheck the lock anyway.

   2nd function will check is we are still the owner. cons_can_proceed()
      already does the job. It needs to be called anyway before doing
      more changes on the console.


> +		ctxt->oldseq = ctxt->newseq;
> +		return true;
> +	}
> +
> +	/*
> +	 * Only emit a warning when this happens outside of a panic
> +	 * situation as on panic it's neither useful nor helping to let the
> +	 * panic CPU get the important stuff out.
> +	 */
> +	WARN_ON_ONCE(pcpu == PANIC_CPU_INVALID);
> +
> +	cons_release(ctxt);
> +	return false;
> +}
> +#endif

Best Regards,
Petr
