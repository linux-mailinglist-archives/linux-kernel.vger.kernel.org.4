Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2950C6C1B2E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 17:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjCTQUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 12:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjCTQT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 12:19:28 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6117D93FC
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 09:10:12 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0FAB51F8A4;
        Mon, 20 Mar 2023 16:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1679328611; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oiyZ/mj/VPZcslYXdPot8Jn4u8WfDfv4RQnlcwMVnCc=;
        b=iBOLr/rDl8ZT2sHcoc2C+pVskLU3RTHLYkxY0mnE2zOTs9iPjnLw21Au9YmXd8EpceTxjZ
        bJMB5gjrQ4rgkTeXvaW9VKPxFAe/1OjPiAnXCk4tjjRDsCQsl1zdK60AFLy2i+0SHXV1vt
        m6bKMLlHKKYR445OqskY761UcpVVY8A=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A036B2C141;
        Mon, 20 Mar 2023 16:10:10 +0000 (UTC)
Date:   Mon, 20 Mar 2023 17:10:07 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v1 06/18] printk: nobkl: Add acquire/release logic
Message-ID: <ZBiFX9rHg/Gjj27Y@alley>
References: <20230302195618.156940-1-john.ogness@linutronix.de>
 <20230302195618.156940-7-john.ogness@linutronix.de>
 <ZA9KUsaYuOt8qSf4@alley>
 <87pm975svn.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pm975svn.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2023-03-17 16:02:12, John Ogness wrote:
> Hi Petr,
> 
> On oftc#printk you mentioned that I do not need to go into details
> here. But I would like to confirm your understanding and clarify some
> minor details.
> 
> On 2023-03-13, Petr Mladek <pmladek@suse.com> wrote:
> > 2. There are 4 priorities. They describe the type of the context that is
> >    either owning the console or which would like to get the owner
> >    ship.
> 
> Yes, however (and I see now the kerneldoc is not very clear about this),
> the priorities are not really about _printing_ on the console, but
> instead about _owning_ the console. This is an important distinction
> because console drivers will also acquire the console for non-printing
> activities (such as setting up their baud rate, etc.).

Makes sense. I have missed this use-case of the lock.

> >    These priorities have the following meaning:
> >
> >        + NONE: when the console is idle
> 
> "unowned" is a better term than "idle".

Makes sense. Or maybe "free" or "released".

> >        + NORMAL: the console is owned by the kthread
> 
> NORMAL really means ownership for normal usage (i.e. an owner that is
> not in an emergency or panic situation).
> 
> >        + EMERGENCY: The console is called directly from printk().
> > 	   It is used when printing some emergency messages, like
> > 	   WARN(), watchdog splat.
> 
> This priority of ownership will only be used when printing emergency
> messages. It does not mean that printk() does direct printing. The
> atomic printing occurs as a flush when releasing the ownership. This
> allows the full backtrace to go into the ringbuffer before flushing (as
> we decided at LPC2022).

I see. I have missed this as well.

> >
> > Common rule: The caller never tries to take over the lock
> >     from another owner of the same priority (?)
> 
> Correct. Although I could see there being an argument to let an
> EMERGENCY priority take over another EMERGENCY. For example, an owning
> EMERGENCY CPU could hang and another CPU triggers the NMI stall message
> (also considered emergency messages), in which case it would be helpful
> to take over ownership from the hung CPU in order to finish flushing.

I agree that it would be useful. Another motivation would be to reduce
the risk of stalling the current lock owner. I mean to have a variant
of console_trylock_spinning() also for this consoles in the EMERGENCY
priority.


> > Current owner:
> >
> >   + Must always do non-atomic operations in the "unsafe" context.
> 
> Each driver must decide for itself how it defines unsafe. But generally
> speaking it will be a block of code involving modifying multiple
> registers.
> 
> >   + Must check if they still own the lock or if there is a request
> >     to pass the lock before manipulating the console state or reading
> >     the shared buffers.
> 
> ... or continuing to touch its registers.
> 
> >   + Should pass the lock to a context with a higher priority.
> >     It must be done only in a "safe" state. But it might be in
> >     the middle of the record.
> 
> The function to check also handles the handing over. So a console
> driver, when checking, may suddenly see that it is no longer the owner
> and must either carefully back out or re-acquire ownership to finish
> what it started.

Just to be sure. The owner could finish what-it-started only when
the other owner did not do conflicting changes in the meantime.

For example, it could not finish writing of a line because the
other owner could have reused the buffer or already flushed
the line in the meantime.


(For example, for the 8250, if an owning context
> disabled interrupts and then lost ownership, it _must_ re-acquire the
> console to re-enable the interrupts.)
> 
> > Passing the owner:
> >
> >    + The current owner sets con->atomic_state[CUR] according
> >      to the info in con->atomic_state[REQ] and bails out.
> >
> >    + The notices that it became the owner by finding its
> >      requested state in con->atomic_state[CUR]
> >
> >    + The most tricky situation is when the current owner
> >      is passing the lock and the waiter is giving up
> >      because of the timeout. The current owner could pass
> >      the lock only when the waiter is still watching.
> 
> Yes, yes, and yes. Since the waiter must remove its request from
> con->atomic_state[CUR] before giving up, it guarentees the current owner
> will see that the waiter is gone because any cmpxchg will fail and the
> current owner will need to re-read con->atomic_state[CUR] (in which case
> it sees there is no waiter).
> 
> > Other:
> >
> >    + Atomic consoles ignore con->seq. Instead they store the lower
> >      32-bit part of the sequence number in the atomic_state variable
> >      at least on 64-bit systems. They use get_next_seq() to guess
> >      the higher 32-bit part of the sequence number.
> 
> Yes, because con->seq is protected by the console_lock, which nbcons do
> not use.

Yup.

> > Questions:
> >
> > How exactly do we handle the early boot before kthreads are ready,
> > please? It looks like we just wait for the kthread.
> 
> Every vprintk_emit() will call into cons_atomic_flush(), which will
> atomically flush the consoles if their threads do not exist. Looking at
> the code, I see it deserves a comment about this (inside the
> for_each_console_srcu loop in cons_atomic_flush()).

I see. I have missed this as well. I haven't checked the later
patches in delail yet.

> > Does the above summary describe the behavior, please?
> > Or does the code handle some situation another way?
> 
> Generally speaking, you have a pretty good picture. I think the only
> thing that was missing was the concept that non-printing code (in
> console drivers) will also acquire the console at times.

Thanks a lot for the info.


> >> --- a/kernel/printk/printk_nobkl.c
> >> +++ b/kernel/printk/printk_nobkl.c
> >> +/**
> >> + * cons_check_panic - Check whether a remote CPU is in panic
> >> + *
> >> + * Returns: True if a remote CPU is in panic, false otherwise.
> >> + */
> >> +static inline bool cons_check_panic(void)
> >> +{
> >> +	unsigned int pcpu = atomic_read(&panic_cpu);
> >> +
> >> +	return pcpu != PANIC_CPU_INVALID && pcpu != smp_processor_id();
> >> +}
> >
> > This does the same as abandon_console_lock_in_panic(). I would
> > give it some more meaningful name and use it everywhere.
> >
> > What about other_cpu_in_panic() or panic_on_other_cpu()?
> 
> I prefer the first because it sounds more like a query than a
> command.

Yup.

Best Regards,
Petr
