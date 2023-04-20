Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D846E95E4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 15:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbjDTNdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 09:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjDTNdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 09:33:14 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5968046B2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 06:33:11 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0522621ADD;
        Thu, 20 Apr 2023 13:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1681997590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sfA6L+fYOCyrXYx5htfIuJg6VTq2J6OkNoSFwYKB1q8=;
        b=cRFZzy4smCwLpfF0LHkT7PVADd+EtSGZB56gPxKcbSWCihXqBxqzsuZAhXRHcH3O8up4JL
        ApP7nS4oQgCJt6E93OdtRFAZH1M4zZzzPQ0VhRdJk0T7wOn0M1EI7or2WQaOqQ/sWpA7+2
        +fWs6M69XqdMMyoM2Rmcabb2Q60d5D8=
Received: from suse.cz (pmladek.tcp.ovpn2.prg.suse.de [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 98A3B2C152;
        Thu, 20 Apr 2023 13:33:09 +0000 (UTC)
Date:   Thu, 20 Apr 2023 15:33:05 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: port lock: was: Re: [PATCH printk v1 11/18] printk: nobkl:
 Introduce printer threads
Message-ID: <ZEE_ERSc_jHaVVe9@alley>
References: <20230302195618.156940-1-john.ogness@linutronix.de>
 <20230302195618.156940-12-john.ogness@linutronix.de>
 <ZC6U/CZCNmgnTpI4@alley>
 <ZEEMJxobFe_UZ8gV@alley>
 <87zg72vo5g.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zg72vo5g.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2023-04-20 12:39:31, John Ogness wrote:
> On 2023-04-20, Petr Mladek <pmladek@suse.com> wrote:
> >> OK, let's first define what the two locks are supposed to synchronize.
> >> My understanding is that this patchset uses them the following way:
> >> 
> >>     + The new lock (atomic_state) is used to serialize emiting
> >>       messages between different write contexts. It replaces
> >>       the functionality of console_lock.
> 
> It replaces the functionality of console_lock, but operates at a finer
> level. It is serializing all access to the hardware registers involved
> in outputting. For the 8250 driver, this is the IER register.
> 
> >>       It is a per-console sleeping lock, allows voluntary and has
> >>       hand-over using priorities and spinning with a timeout.
> 
> It is not a sleeping lock. It is used as a trylock or spinning with
> timeout. It has the special feature that it can be handed over to or
> stolen by another context with a higher ownership priority.

What prevents the owner from sleeping, please?
Is the disabled preemption enforced?

I see migrate_disable() in con_kthread_func() when con->port_lock
does not exist. It means that the preemption is possible in
this case.

> >>     + The port_lock is used to synchronize various operations
> >>       of the console driver/device, like probe, init, exit,
> >>       configuration update.
> >> 
> >>       It is typically a per-console driver/device spin lock.
> >> 
> >> 
> >> I guess that we would want to keep both locks:
> 
> I agree because the port_lock has a much larger scope and is fully
> preemptive under PREEMPT_RT.

Do you really want to call the entire cons_emit_record()
in non-preemptive context on RT?

It should be enough to disable preemption in the unsafe sections.
IMHO, it might be enabled in the "safe" sections. The only
drawback would be that the emergency context might take over
the lock in the middle of the line. But emergency context should be
rare. So it should be rare.


> > I forgot to check how these two locks are supposed to be used
> > in write_atomic().
> >
> > It seems that cons_atomic_flush_con() takes only the new lock
> > (atomic_state) and ignores the port_lock(). It should be safe
> > against write_kthread(). But it is not safe against other
> > operations with the console device that are synchronized
> > only by the port_lock().
> 
> Yes, it is because the console drivers will also take the atomic_state
> lock when needed. You can see this in the POC patch I posted [0].
> 
> For example, a new function serial8250_enter_unsafe() is used by the
> serial drivers to mark the beginning of an unsafe section. To use this
> function, the port_lock must be held. This function additionally takes
> the atomic_state lock. Then the driver is allowed to touch hardware
> registers related to outputting (IER).

I see.

I have missed it because the driver is still taking port->lock
directly on many locations. It seems to be in the init code.
It makes sense because it is called before the port gets
registered as a console.

Sigh, sigh, sigh, this scares me a lot. How do we know that all
code paths are correctly serialized or that they could never
be called in parallel?

Especially, the generic serial8250 API seems to be used in many drivers
together with a lot of custom code.

For example, what about serial8250_handle_irq()? How is it serialized
against serial8250_console_write_atomic()?

> But typically the driver will use a new higher level function, for
> example serial8250_in_IER(), which will enter unsafe, read the register,
> and exit unsafe. This provides the necessary synchronization against
> write_atomic() (for the 8250 driver).

Hmm, I think that we should create an API that would take the right
locks according to the state:

     + port->lock when the console is not registered
     + port->lock + con->atomic_state lock when the console is registered

and use it everywhere intestead of taking port->lock directly.

> Please also remember that hostile takeovers of drivers in unsafe
> sections are done as a last resort in panic, after all other nbcon
> consoles have safely flushed their buffers. So we should not spend too
> many brain cycles on "what if the atomic_state lock is stolen while in
> an unsafe section" questions. The answer is: then you are in "hope and
> pray" mode.

I know. And the hostile takeover is not my concern.

My concern are races between write_atomic() in emergency context
and other driver code serialized only by the port->lock.

We need an API that will make sure that any code serialized
by port->lock is properly serialized against write->atomic()
when the console is registered. Also we need to synchronize
the registration and port->lock.

Best Regards,
Petr
