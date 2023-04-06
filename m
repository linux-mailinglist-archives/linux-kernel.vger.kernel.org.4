Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F0D6D933D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 11:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236626AbjDFJuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 05:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236863AbjDFJtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 05:49:40 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B2B8A64
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 02:48:07 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id BBA1F1FF47;
        Thu,  6 Apr 2023 09:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1680774397; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fqG6JjkwuUXzatzFc9lxAnbb0+um3nqqDYdD3e2g1dY=;
        b=WaBeNVaHJsZv/7zJexkN6Iykm8yJ60trlsMrGgIpBWyV21AhpHoa6dEMmawoOfr2YJNM1h
        Dh0HOQPqQMIBifFS2lQaboFEbC6ID/9iLRC3n2Cx31k0ZWc8J6THL/vFuutAsyKvRNvVyK
        hI/KFo912dCJ/E3dPIA3/PDScr0+uaI=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5E3702C142;
        Thu,  6 Apr 2023 09:46:37 +0000 (UTC)
Date:   Thu, 6 Apr 2023 11:46:36 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: port lock: was: Re: [PATCH printk v1 11/18] printk: nobkl: Introduce
 printer threads
Message-ID: <ZC6U/CZCNmgnTpI4@alley>
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

> --- a/kernel/printk/printk_nobkl.c
> +++ b/kernel/printk/printk_nobkl.c
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

IMHO, we should use a more generic name. This should be a lock that
provides full synchronization between con->write() and other
operations on the device used by the console.

"port_lock" is specific for the serial consoles. IMHO, other consoles
might use another lock. IMHO, tty uses "console_lock" internally for
this purpose. netconsole seems to has "target_list_lock" that might
possible have this purpose, s390 consoles are using sclp_con_lock,
sclp_vt220_lock, or get_ccwdev_lock(raw->cdev).


Honestly, I expected that we could replace these locks by
cons_acquire_lock(). I know that the new lock is special: sleeping,
timeouting, allows hand-over by priorities.

But I think that we might implement cons_acquire_lock() that would always
busy wait without any timeout. And use some "priority" that would
never handover the lock a voluntary way at least not with a voluntary
one. The only difference would be that it is sleeping. But it might
be acceptable in many cases.

Using the new lock instead of port->lock would allow to remove
the tricks with using spin_trylock() when oops_in_progress is set.

That said, I am not sure if this is possible without major changes.
For example, in case of serial consoles, it would require touching
the layer using port->lock.

Also it would requere 1:1 relation between struct console and the output
device lock. I am not sure if it is always the case. On the other
hand, adding some infrastructure for this 1:1 relationship would
help to solve smooth transition from the boot to the real console
driver.


OK, let's first define what the two locks are supposed to synchronize.
My understanding is that this patchset uses them the following way:

    + The new lock (atomic_state) is used to serialize emiting
      messages between different write contexts. It replaces
      the functionality of console_lock.

      It is a per-console sleeping lock, allows voluntary and hars
      hand-over using priorities and spinning with a timeout.


    + The port_lock is used to synchronize various operations
      of the console driver/device, like probe, init, exit,
      configuration update.

      It is typically a per-console driver/device spin lock.


I guess that we would want to keep both locks:

    + it might help to do the rework manageable

    + the sleeping lock might complicate some operations;
      raw_spin_lock might be necessary at least on
      non-RT system.


Are there better names? What about?

    + emit_lock() or ctxt_lock() for the new special lock

    + device_lock() or driver_lock() as a generic name
      for the driver/device specific lock.

Sigh, the problem with the device_lock()/driver_lock()
is that it might get confused with:

	struct tty_driver	*(*device)(struct console *co, int *index);

It would be really great to make it clear that this callback is about
the connection to the tty layer. I would rename it to:

	struct tty_driver	*(*tty_drv)(struct console *co, int *index);
or
	struct tty_driver	*(*tty_driver)(struct console *co, int *index);


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

Best Regards,
Petr
