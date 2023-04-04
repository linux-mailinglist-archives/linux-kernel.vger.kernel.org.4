Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE58D6D6564
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 16:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235259AbjDDOc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 10:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234699AbjDDOcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 10:32:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6CFEC
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 07:32:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC66163517
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 14:32:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4A28C4339E;
        Tue,  4 Apr 2023 14:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680618743;
        bh=TtZ+P9hLCf/bO8SXpTpi4CGf1vSiKLdn+atcfEv8O+I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nUEOirkWUxwUIs+y9i5hIUi/tUTwPGkcq/aiVWz5LcLC6SmVQiYq0mmg5tSEVUCmF
         5D2ydjf/SeHZrIJkmISi1uD+t7wqAAPrMTlTFrHgxnFlzn5egeF4FnYGsT4y2WQqu6
         QSTqEU7nXam+7LXsIzAhkqutCxOdVyXMspMdo2lPC9Lot+q3QD7awKXMcoBTeCSSAE
         NS7ad/RCjRulq0VfCPggUfyRKzT+g2zLLC9/G3KEn/EVFWzei0xZ5YKzkXOrwNz28b
         lOGYua1Vep0cibns+gRWN4VhVaF8v9Bjt+A5KUfVQNx0fYU+gd8atcK7CaWhhz7rpQ
         H8VDNChGtkboA==
Date:   Tue, 4 Apr 2023 16:32:20 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
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
Message-ID: <ZCw09IfpV9py2+Zk@lothringen>
References: <20230301141744.16063-1-anna-maria@linutronix.de>
 <20230301141744.16063-17-anna-maria@linutronix.de>
 <ZBmSLC6gRaNEb4/Z@lothringen>
 <d55fbe28-23f9-e3a9-92bc-1a726224ed69@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d55fbe28-23f9-e3a9-92bc-1a726224ed69@linutronix.de>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2023 at 04:05:27PM +0200, Anna-Maria Behnsen wrote:
> On Tue, 21 Mar 2023, Frederic Weisbecker wrote:
> 
> > On Wed, Mar 01, 2023 at 03:17:42PM +0100, Anna-Maria Behnsen wrote:
> > > +static u64 tmigr_handle_remote_cpu(unsigned int cpu, u64 now,
> > > +				   unsigned long jif)
> > > +{
> > > +	struct timer_events tevt;
> > > +	struct tmigr_walk data;
> > > +	struct tmigr_cpu *tmc;
> > > +	u64 next = KTIME_MAX;
> > > +	unsigned long flags;
> > > +
> > > +	tmc = per_cpu_ptr(&tmigr_cpu, cpu);
> > > +
> > > +	raw_spin_lock_irqsave(&tmc->lock, flags);
> > > +	/*
> > > +	 * Remote CPU is offline or no longer idle or other cpu handles cpu
> > > +	 * timers already or next event was already expired - return!
> > > +	 */
> > > +	if (!tmc->online || tmc->remote || tmc->cpuevt.ignore ||
> > > +	    now < tmc->cpuevt.nextevt.expires) {
> > > +		raw_spin_unlock_irqrestore(&tmc->lock, flags);
> > > +		return next;
> > > +	}
> > > +
> > > +	tmc->remote = 1;
> > > +
> > > +	/* Drop the lock to allow the remote CPU to exit idle */
> > > +	raw_spin_unlock_irqrestore(&tmc->lock, flags);
> > > +
> > > +	if (cpu != smp_processor_id())
> > > +		timer_expire_remote(cpu);
> > > +
> > > +	/* next event of cpu */
> > > +	fetch_next_timer_interrupt_remote(jif, now, &tevt, cpu);
> > 
> > If the target CPU gets an idle interrupt right after the above call and enqueues
> > a new timer (which becomes the new earliest), tmigr_cpu_deactivate() ->
> > tmigr_new_timer() is going to ignore it due to tmc->remote = 1, right?
> 
> It's worse. The newly enqueued timer is updated in the timer migration
> hierarchy when CPU goes back idle and afterwards it will be overwritten by
> the group walk propagating the old first timer in
> tmigr_handle_remote_cpu()...

Hmm then that would require the remote CPU to exit dynticks and then
re-enter dynticks, right? Yes, sounds possible too.

> 
> I will change the code after remote timer expiry:
> 
> 1. take the remote timer bases locks
> 2. take the tmc->lock
> 3. get the next timer interrupt remote
> 4. drop the remote timer bases locks
> 5. propagate new timer changes
> 6. drop the tmc->lock

Right that sounds good!

Thanks.

> 
> Thanks,
> 
> 	Anna-Maria
