Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 560066B7D06
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 17:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjCMQH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 12:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjCMQHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 12:07:54 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9932164B1E
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 09:07:52 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 23B501FE0E;
        Mon, 13 Mar 2023 16:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1678723671; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b12ffi4bY2hirW6/E39bZdAv0aNvRB9+xS5n9Za1i1Y=;
        b=JFezLiJrb4tTgVgaPAaLlrUPze72RK8g3UrVHSzayaYmYuzc43MjvMMbxSHppf856iLO0c
        wBgHfJFpdip/FBTuUQD/qcTaKLRf6W4HorjqDlaDeFSBxqgdHgnA0ndu182r4frszOUpML
        HPF4Xihb1HeFavuSmq8YHAIzU1DKCR8=
Received: from suse.cz (pmladek.udp.ovpn2.prg.suse.de [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D47A42C141;
        Mon, 13 Mar 2023 16:07:49 +0000 (UTC)
Date:   Mon, 13 Mar 2023 17:07:46 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v1 06/18] printk: nobkl: Add acquire/release logic
Message-ID: <ZA9KUsaYuOt8qSf4@alley>
References: <20230302195618.156940-1-john.ogness@linutronix.de>
 <20230302195618.156940-7-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302195618.156940-7-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -189,12 +201,79 @@ struct cons_state {
>  			union {
>  				u32	bits;
>  				struct {
> +					u32 locked	:  1;
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
> + * @state:		The state at acquire time
> + * @old_state:		The old state when try_acquire() failed for analysis
> + *			by the caller
> + * @hov_state:		The handover state for spin and cleanup
> + * @req_state:		The request state for spin and cleanup
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

This looks quite complicated. I am still trying to understand the logic.

I want to be sure that we are on the same page. Let me try to
summarize my understanding and expectations:

1. The console has two state variables (atomic_state[2]):
       + CUR == state of the current owner
       + REQ == set when anyone else requests to take over the owner ship

   In addition, there are also priority bits in the state variable.
   Each state variable has cur_prio, req_prio.


2. There are 4 priorities. They describe the type of the context that is
   either owning the console or which would like to get the owner
   ship.

   These priorities have the following meaning:

       + NONE: when the console is idle

       + NORMAL: the console is owned by the kthread

       + EMERGENCY: The console is called directly from printk().
	   It is used when printing some emergency messages, like
	   WARN(), watchdog splat.

       + PANIC: when console is called directly but only from
	  the CPU that is handling panic().


3. The number of contexts:

       + The is one NORMAL context used by the kthread.

       + There might be eventually more EMERGENCY contexts running
	 in parallel. Usually there is only one but other CPUs
	 might still add more messages into the log buffer parallel.

	 The EMERGENCY context owner is responsible for flushing
	 all pending messages.

       + The might be only one PANIC context on the panic CPU.


4. The current owner sets a flag "unsafe" when it is not safe
   to take over the lock a hostile way.


Switching context:

We have a context with a well defined priority which tries
to get the ownership. There are few possibilities:

a) The console is idle and the context could get the ownership
   immediately.

   It is a simple cmpxchg of con->atomic_state[CUR].


b) The console is owned by anyone with a lower priority.
   The new caller should try to take over the lock a safe way
   when possible.

   It can be done by setting con->atomic_state[REQ] and waiting
   until the current owner makes him the owner in
   con->atomic_state[CUR].


c) The console is owned by anyone with a lower priority
   on the same CPU. Or the owner on an other CPU did not
   pass the lock withing the timeout.

   In this case, we could steal the lock. It can be done by
   writing to con->atomic_state[CUR].

   We could do this in EMERGENCY or PANIC context when the current
   owner is not in an "unsafe" context.

   We could do this at the end of panic (console_flush_in_panic())
   even when the current owner is in an "unsafe" context.


Common rule: The caller never tries to take over the lock
    from another owner of the same priority (?)


Current owner:

  + Must always do non-atomic operations in the "unsafe" context.

  + Must check if they still own the lock or if there is a request
    to pass the lock before manipulating the console state or reading
    the shared buffers.

  + Should pass the lock to a context with a higher priority.
    It must be done only in a "safe" state. But it might be in
    the middle of the record.


Passing the owner:

   + The current owner sets con->atomic_state[CUR] according
     to the info in con->atomic_state[REQ] and bails out.

   + The notices that it became the owner by finding its
     requested state in con->atomic_state[CUR]

   + The most tricky situation is when the current owner
     is passing the lock and the waiter is giving up
     because of the timeout. The current owner could pass
     the lock only when the waiter is still watching.



Other:

   + Atomic consoles ignore con->seq. Instead they store the lower
     32-bit part of the sequence number in the atomic_state variable
     at least on 64-bit systems. They use get_next_seq() to guess
     the higher 32-bit part of the sequence number.


Questions:

How exactly do we handle the early boot before kthreads are ready,
please? It looks like we just wait for the kthread. This looks
wrong to me.

Does the above summary describe the behavior, please?
Or does the code handle some situation another way?

> +	unsigned int		spinwait_max_us;
> +	enum cons_prio		prio;
> +	unsigned int		hostile		: 1;
> +	unsigned int		spinwait	: 1;
> +};
> +
> --- a/kernel/printk/printk_nobkl.c
> +++ b/kernel/printk/printk_nobkl.c
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

This does the same as abandon_console_lock_in_panic(). I would
give it some more meaningful name and use it everywhere.

What about other_cpu_in_panic() or panic_on_other_cpu()?

Best Regards,
Petr
