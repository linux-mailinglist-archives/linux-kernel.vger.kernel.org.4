Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B4B6B2C3C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 18:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjCIRpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 12:45:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjCIRpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 12:45:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F4D6591
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 09:45:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E12C61CA1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 17:45:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79FDBC433EF;
        Thu,  9 Mar 2023 17:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678383949;
        bh=cC1sQkltz1lx+delY80NYugxjp8Bk88aX0XBgAiU7pE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ND5QnHssxy3lSOBNQfpU94K0rV/rJM4GyOZJLycARhFzqhBuj6hJh4SxOS5Rt7nD3
         ezaWGIlgcHgqReVS2p9ahHfS3Swh8rbyqx00bz7LCLLahgSmzOvswKByFJDhu6cov5
         C1yNAv0aCP4cgU9ifh3R3S8Eo0B87J8ljqap2r6ER+q1dNe6Cw84xO99PdUOYEQJtF
         kDktgmkKLDnkrQyrgf95Fy7bM08AXqp5OVqn5dxFbc3bY3vj6kmYVToUtlkKe7r7Wu
         iE1jby1MdKPM0P1G3HQea57dG96XJEwwEQR15uI8/4ZW4U236z+g0lY0XJLLm4/inV
         Gt1gxJeGke8yw==
Date:   Thu, 9 Mar 2023 18:45:46 +0100
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
Subject: Re: [PATCH v5 11/18] timer: Split out "get next timer interrupt"
 functionality
Message-ID: <ZAobSqZvcHLEKUpl@lothringen>
References: <20230301141744.16063-1-anna-maria@linutronix.de>
 <20230301141744.16063-12-anna-maria@linutronix.de>
 <ZAoJlEwW/2hX6zlQ@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZAoJlEwW/2hX6zlQ@localhost.localdomain>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 05:30:12PM +0100, Frederic Weisbecker wrote:
> Le Wed, Mar 01, 2023 at 03:17:37PM +0100, Anna-Maria Behnsen a écrit :
> > The functionallity for getting the next timer interrupt in
> > get_next_timer_interrupt() is splitted into a separate function
> > fetch_next_timer_interrupt() to be usable by other callsides.
> > 
> > This is preparatory work for the conversion of the NOHZ timer
> > placement to a pull at expiry time model. No functional change.
> > 
> > Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> [...]
> > diff --git a/kernel/time/timer.c b/kernel/time/timer.c
> > index ff41d978cb22..dfc744545159 100644
> > --- a/kernel/time/timer.c
> > +++ b/kernel/time/timer.c
> > @@ -2040,31 +2071,9 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
> >  		if (time_before(nextevt, basej))
> >  			nextevt = basej;
> >  		tevt.local = basem + (u64)(nextevt - basej) * TICK_NSEC;
> > -		goto unlock;
> > +		tevt.global = KTIME_MAX;
> >  	}
> >  
> > -	/*
> > -	 * If the bases are marked idle, i.e. the next event on both the
> > -	 * local and the global queue are farther away than a tick,
> > -	 * evaluate both bases. No need to check whether one of the bases
> > -	 * has an already expired timer as this is caught by the !is_idle
> > -	 * condition above.
> > -	 */
> > -	if (base_local->timers_pending)
> > -		tevt.local = basem + (u64)(nextevt_local - basej) * TICK_NSEC;
> > -
> > -	/*
> > -	 * If the local queue expires first, then the global event can be
> > -	 * ignored. The CPU wakes up before that. If the global queue is
> > -	 * empty, nothing to do either.
> > -	 */
> > -	if (!local_first && base_global->timers_pending)
> > -		tevt.global = basem + (u64)(nextevt_global - basej) * TICK_NSEC;
> > -
> > -unlock:
> > -	raw_spin_unlock(&base_global->lock);
> > -	raw_spin_unlock(&base_local->lock);
> > -
> >  	tevt.local = min_t(u64, tevt.local, tevt.global);
> 
> So if you leave that last line, it means that the CPU will eventually
> and unconditionally wake up for the next global timer if it's before the
> next local timer. Am I understanding this right and, if so, is that intended?

Nevermind, that's removed on the main patch.

Sorry for the noise.
