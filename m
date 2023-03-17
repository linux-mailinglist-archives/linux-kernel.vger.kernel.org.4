Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE7B6BEBF7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 15:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjCQO5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 10:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjCQO5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 10:57:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DC110CC
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 07:57:47 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679065065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J5juTLzyST5c9beVMUMs7YrIby9HV4sg40jukid0g6A=;
        b=d/OhFqRdg6pjmq5NBdloF8WywaciNHaPbmm4S8fP9J20l/P0/3OyKPBKs45o5GCoPNtjPr
        wbz3YPu3VOD019MWRNt2Cz3NzhmtogmX6Zt2zMlEQ3fzi06ctVStAhaWx4il0zBbNkZL5a
        JfC5Yh+nTnVxO1EiqKuFW8csuNYRar2Olybi8deRkZ4x3VxxAMwYKCfYzHvfcLTlPY1jNl
        tIxqdoC12SmbImcWc2PTpmAd5B6tv+g1soodBBztq/wdefwIVnEzlUOR+gYtaeSvo+yCRH
        NTLmhmrJXvATs21k8mnyTmqWjISkY861EG9zITMfTMhPlhRNeX8X20DaJsxstg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679065065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J5juTLzyST5c9beVMUMs7YrIby9HV4sg40jukid0g6A=;
        b=ZnPp/BZ/m3ErRFrnzbk6nQD7XiO956kpOdF+kOHhI1rc9A1YanlziI2TjE83llnPzabuvA
        9QZBEIGXwCW9zFDQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v1 06/18] printk: nobkl: Add acquire/release logic
In-Reply-To: <ZA9KUsaYuOt8qSf4@alley>
References: <20230302195618.156940-1-john.ogness@linutronix.de>
 <20230302195618.156940-7-john.ogness@linutronix.de>
 <ZA9KUsaYuOt8qSf4@alley>
Date:   Fri, 17 Mar 2023 16:02:12 +0106
Message-ID: <87pm975svn.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr,

On oftc#printk you mentioned that I do not need to go into details
here. But I would like to confirm your understanding and clarify some
minor details.

On 2023-03-13, Petr Mladek <pmladek@suse.com> wrote:
>> --- a/include/linux/console.h
>> +++ b/include/linux/console.h
>> @@ -189,12 +201,79 @@ struct cons_state {
>>  			union {
>>  				u32	bits;
>>  				struct {
>> +					u32 locked	:  1;
>> +					u32 unsafe	:  1;
>> +					u32 cur_prio	:  2;
>> +					u32 req_prio	:  2;
>> +					u32 cpu		: 18;
>>  				};
>>  			};
>>  		};
>>  	};
>>  };
>>  
>> +/**
>> + * cons_prio - console writer priority for NOBKL consoles
>> + * @CONS_PRIO_NONE:		Unused
>> + * @CONS_PRIO_NORMAL:		Regular printk
>> + * @CONS_PRIO_EMERGENCY:	Emergency output (WARN/OOPS...)
>> + * @CONS_PRIO_PANIC:		Panic output
>> + *
>> + * Emergency output can carefully takeover the console even without consent
>> + * of the owner, ideally only when @cons_state::unsafe is not set. Panic
>> + * output can ignore the unsafe flag as a last resort. If panic output is
>> + * active no takeover is possible until the panic output releases the
>> + * console.
>> + */
>> +enum cons_prio {
>> +	CONS_PRIO_NONE = 0,
>> +	CONS_PRIO_NORMAL,
>> +	CONS_PRIO_EMERGENCY,
>> +	CONS_PRIO_PANIC,
>> +};
>> +
>> +struct console;
>> +
>> +/**
>> + * struct cons_context - Context for console acquire/release
>> + * @console:		The associated console
>> + * @state:		The state at acquire time
>> + * @old_state:		The old state when try_acquire() failed for analysis
>> + *			by the caller
>> + * @hov_state:		The handover state for spin and cleanup
>> + * @req_state:		The request state for spin and cleanup
>> + * @spinwait_max_us:	Limit for spinwait acquire
>> + * @prio:		Priority of the context
>> + * @hostile:		Hostile takeover requested. Cleared on normal
>> + *			acquire or friendly handover
>> + * @spinwait:		Spinwait on acquire if possible
>> + */
>> +struct cons_context {
>> +	struct console		*console;
>> +	struct cons_state	state;
>> +	struct cons_state	old_state;
>> +	struct cons_state	hov_state;
>> +	struct cons_state	req_state;
>
> This looks quite complicated. I am still trying to understand the logic.
>
> I want to be sure that we are on the same page. Let me try to
> summarize my understanding and expectations:
>
> 1. The console has two state variables (atomic_state[2]):
>        + CUR == state of the current owner
>        + REQ == set when anyone else requests to take over the owner ship
>
>    In addition, there are also priority bits in the state variable.
>    Each state variable has cur_prio, req_prio.

Correct.

> 2. There are 4 priorities. They describe the type of the context that is
>    either owning the console or which would like to get the owner
>    ship.

Yes, however (and I see now the kerneldoc is not very clear about this),
the priorities are not really about _printing_ on the console, but
instead about _owning_ the console. This is an important distinction
because console drivers will also acquire the console for non-printing
activities (such as setting up their baud rate, etc.).

>    These priorities have the following meaning:
>
>        + NONE: when the console is idle

"unowned" is a better term than "idle".

>        + NORMAL: the console is owned by the kthread

NORMAL really means ownership for normal usage (i.e. an owner that is
not in an emergency or panic situation).

>        + EMERGENCY: The console is called directly from printk().
> 	   It is used when printing some emergency messages, like
> 	   WARN(), watchdog splat.

This priority of ownership will only be used when printing emergency
messages. It does not mean that printk() does direct printing. The
atomic printing occurs as a flush when releasing the ownership. This
allows the full backtrace to go into the ringbuffer before flushing (as
we decided at LPC2022).

>        + PANIC: when console is called directly but only from
> 	  the CPU that is handling panic().

This priority really has the same function as EMERGENCY, but is a higher
priority so that console ownership can always be taken (hostile if
necessary) in a panic situation. This priority of ownership will only be
used on the panic CPU.

> 3. The number of contexts:
>
>        + The is one NORMAL context used by the kthread.

NORMAL defines the priority of the ownership. So it is _all_ owning
contexts (not just printing contexts) that are not EMERGENCY or PANIC.

>        + There might be eventually more EMERGENCY contexts running
> 	 in parallel. Usually there is only one but other CPUs
> 	 might still add more messages into the log buffer parallel.
>
> 	 The EMERGENCY context owner is responsible for flushing
> 	 all pending messages.

Yes, but you need to be careful how you view this. There might be more
contexts with emergency messages, but only one owner with the EMERGENCY
priority. The other contexts will fail to acquire the console and only
dump their messages into the ringbuffer. The one EMERGENCY owner will
flush all messages when ownership is released.

>        + The might be only one PANIC context on the panic CPU.

There is only one PANIC owner. (There is only ever at most one owner.)
But also there should only be one CPU with panic messages. @panic_cpu
should take care of that.

> 4. The current owner sets a flag "unsafe" when it is not safe
>    to take over the lock a hostile way.

Yes. These owners will be console drivers that are touching registers
that affect their write_thread() and write_atomic() callback
code. Theoretically the drivers could also use EMERGENCY or PANIC
priorities to make sure those situations do not steal the console from
them. But for now drivers should only use NORMAL.

> Switching context:
>
> We have a context with a well defined priority which tries
> to get the ownership. There are few possibilities:
>
> a) The console is idle and the context could get the ownership
>    immediately.
>
>    It is a simple cmpxchg of con->atomic_state[CUR].

Yes, although "unowned" is a better term than "idle". The console might
be un-idle (playing with registers), but those registers do not affect
its write_thread() and write_atomic() callbacks.

> b) The console is owned by anyone with a lower priority.
>    The new caller should try to take over the lock a safe way
>    when possible.
>
>    It can be done by setting con->atomic_state[REQ] and waiting
>    until the current owner makes him the owner in
>    con->atomic_state[CUR].

Correct. And the requester can set a timeout how long it will maximally
wait.

> c) The console is owned by anyone with a lower priority
>    on the same CPU. Or the owner on an other CPU did not
>    pass the lock withing the timeout.

(...and the owner on the other CPU is also a lower priority)

>    In this case, we could steal the lock. It can be done by
>    writing to con->atomic_state[CUR].
>
>    We could do this in EMERGENCY or PANIC context when the current
>    owner is not in an "unsafe" context.

(...and the current owner has a lower priority)

>    We could do this at the end of panic (console_flush_in_panic())
>    even when the current owner is in an "unsafe" context.
>
> Common rule: The caller never tries to take over the lock
>     from another owner of the same priority (?)

Correct. Although I could see there being an argument to let an
EMERGENCY priority take over another EMERGENCY. For example, an owning
EMERGENCY CPU could hang and another CPU triggers the NMI stall message
(also considered emergency messages), in which case it would be helpful
to take over ownership from the hung CPU in order to finish flushing.

> Current owner:
>
>   + Must always do non-atomic operations in the "unsafe" context.

Each driver must decide for itself how it defines unsafe. But generally
speaking it will be a block of code involving modifying multiple
registers.

>   + Must check if they still own the lock or if there is a request
>     to pass the lock before manipulating the console state or reading
>     the shared buffers.

... or continuing to touch its registers.

>   + Should pass the lock to a context with a higher priority.
>     It must be done only in a "safe" state. But it might be in
>     the middle of the record.

The function to check also handles the handing over. So a console
driver, when checking, may suddenly see that it is no longer the owner
and must either carefully back out or re-acquire ownership to finish
what it started. (For example, for the 8250, if an owning context
disabled interrupts and then lost ownership, it _must_ re-acquire the
console to re-enable the interrupts.)

> Passing the owner:
>
>    + The current owner sets con->atomic_state[CUR] according
>      to the info in con->atomic_state[REQ] and bails out.
>
>    + The notices that it became the owner by finding its
>      requested state in con->atomic_state[CUR]
>
>    + The most tricky situation is when the current owner
>      is passing the lock and the waiter is giving up
>      because of the timeout. The current owner could pass
>      the lock only when the waiter is still watching.

Yes, yes, and yes. Since the waiter must remove its request from
con->atomic_state[CUR] before giving up, it guarentees the current owner
will see that the waiter is gone because any cmpxchg will fail and the
current owner will need to re-read con->atomic_state[CUR] (in which case
it sees there is no waiter).

> Other:
>
>    + Atomic consoles ignore con->seq. Instead they store the lower
>      32-bit part of the sequence number in the atomic_state variable
>      at least on 64-bit systems. They use get_next_seq() to guess
>      the higher 32-bit part of the sequence number.

Yes, because con->seq is protected by the console_lock, which nbcons do
not use. Note that pr_flush() relies on the console_lock, so it also
takes that opporunity to sync con->seq with con->atomic_state[CUR].seq,
thus allowing pr_flush() to only care about con->seq. pr_flush() is the
only function that cares about the sequence number for both legacy and
nbcon consoles during runtime.

> Questions:
>
> How exactly do we handle the early boot before kthreads are ready,
> please? It looks like we just wait for the kthread.

Every vprintk_emit() will call into cons_atomic_flush(), which will
atomically flush the consoles if their threads do not exist. Looking at
the code, I see it deserves a comment about this (inside the
for_each_console_srcu loop in cons_atomic_flush()).

> Does the above summary describe the behavior, please?
> Or does the code handle some situation another way?

Generally speaking, you have a pretty good picture. I think the only
thing that was missing was the concept that non-printing code (in
console drivers) will also acquire the console at times.

>> --- a/kernel/printk/printk_nobkl.c
>> +++ b/kernel/printk/printk_nobkl.c
>> +/**
>> + * cons_check_panic - Check whether a remote CPU is in panic
>> + *
>> + * Returns: True if a remote CPU is in panic, false otherwise.
>> + */
>> +static inline bool cons_check_panic(void)
>> +{
>> +	unsigned int pcpu = atomic_read(&panic_cpu);
>> +
>> +	return pcpu != PANIC_CPU_INVALID && pcpu != smp_processor_id();
>> +}
>
> This does the same as abandon_console_lock_in_panic(). I would
> give it some more meaningful name and use it everywhere.
>
> What about other_cpu_in_panic() or panic_on_other_cpu()?

I prefer the first because it sounds more like a query than a
command.

John
