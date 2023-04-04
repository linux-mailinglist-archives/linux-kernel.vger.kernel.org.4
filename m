Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3756D64A5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 16:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235579AbjDDOFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 10:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235459AbjDDOFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 10:05:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6072546BA
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 07:05:29 -0700 (PDT)
Date:   Tue, 4 Apr 2023 16:05:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1680617127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=njtuOJyvCWq+QEC/tORmFz69GfMKOxa4qO1mahWZf6Y=;
        b=CLJTLYPFXdtNbslQFIxXugFueaOwLG3FjzrBKsLF5cEmNiRtlwC6JBX+UYWy1WogRFBsmN
        AR4ib+PaOBP/wm6RoDoJtIKWsEb5fgdGCGuhIEMHgL11Xlav0NEp9VKz0sDBdiyR8RutNO
        vCBmBdhDwT6DFpJ3vNWnFOvIDt+2bev9FmsNr29lPJx9V+jVr4Poh6GvjefqW6YhwcnnDT
        RMULk1iJLc5nXsitiRGfcFZSaiUQ59hBnp3CAtker3YPbxCH7fbntPNJJBpYtXEjV97muk
        /a6dM78vK/jrWoTJw9yx6J0oFp34uSj+nIL/0siPA1qgMMdQPdnl4MYPXVQ2IA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1680617127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=njtuOJyvCWq+QEC/tORmFz69GfMKOxa4qO1mahWZf6Y=;
        b=bP86fr8TtPWbDoUIm/NtXWa5tRwP4PtB/ZoLrUUIhgteR3c+YLuZ1Jq8chcblnaU9B35MM
        GE/2FrG7L6TVj7Ag==
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
To:     Frederic Weisbecker <frederic@kernel.org>
cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH v5 16/18] timer: Implement the hierarchical pull model
In-Reply-To: <ZBmSLC6gRaNEb4/Z@lothringen>
Message-ID: <d55fbe28-23f9-e3a9-92bc-1a726224ed69@linutronix.de>
References: <20230301141744.16063-1-anna-maria@linutronix.de> <20230301141744.16063-17-anna-maria@linutronix.de> <ZBmSLC6gRaNEb4/Z@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Mar 2023, Frederic Weisbecker wrote:

> On Wed, Mar 01, 2023 at 03:17:42PM +0100, Anna-Maria Behnsen wrote:
> > +static u64 tmigr_handle_remote_cpu(unsigned int cpu, u64 now,
> > +				   unsigned long jif)
> > +{
> > +	struct timer_events tevt;
> > +	struct tmigr_walk data;
> > +	struct tmigr_cpu *tmc;
> > +	u64 next = KTIME_MAX;
> > +	unsigned long flags;
> > +
> > +	tmc = per_cpu_ptr(&tmigr_cpu, cpu);
> > +
> > +	raw_spin_lock_irqsave(&tmc->lock, flags);
> > +	/*
> > +	 * Remote CPU is offline or no longer idle or other cpu handles cpu
> > +	 * timers already or next event was already expired - return!
> > +	 */
> > +	if (!tmc->online || tmc->remote || tmc->cpuevt.ignore ||
> > +	    now < tmc->cpuevt.nextevt.expires) {
> > +		raw_spin_unlock_irqrestore(&tmc->lock, flags);
> > +		return next;
> > +	}
> > +
> > +	tmc->remote = 1;
> > +
> > +	/* Drop the lock to allow the remote CPU to exit idle */
> > +	raw_spin_unlock_irqrestore(&tmc->lock, flags);
> > +
> > +	if (cpu != smp_processor_id())
> > +		timer_expire_remote(cpu);
> > +
> > +	/* next event of cpu */
> > +	fetch_next_timer_interrupt_remote(jif, now, &tevt, cpu);
> 
> If the target CPU gets an idle interrupt right after the above call and enqueues
> a new timer (which becomes the new earliest), tmigr_cpu_deactivate() ->
> tmigr_new_timer() is going to ignore it due to tmc->remote = 1, right?

It's worse. The newly enqueued timer is updated in the timer migration
hierarchy when CPU goes back idle and afterwards it will be overwritten by
the group walk propagating the old first timer in
tmigr_handle_remote_cpu()...

I will change the code after remote timer expiry:

1. take the remote timer bases locks
2. take the tmc->lock
3. get the next timer interrupt remote
4. drop the remote timer bases locks
5. propagate new timer changes
6. drop the tmc->lock

Thanks,

	Anna-Maria
