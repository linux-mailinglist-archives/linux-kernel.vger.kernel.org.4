Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA47262184A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 16:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234525AbiKHPaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 10:30:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234520AbiKHPap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 10:30:45 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F50B56557
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 07:30:36 -0800 (PST)
Date:   Tue, 8 Nov 2022 16:30:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667921434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4MVyWw7ozXcrMblhUHcrr7SNs20kmx0c9ac3Fc4GHxA=;
        b=3G5uLyxIhUKvXhygKe/BdevH06bkBHTOAVpSVPeFcVhxsUqxfu9kH4zWKy+J+M6eVspb/p
        ZrgLFbE28ixXxHkAfYipr4NFucKxv+PxkmMroKWR0i5hwKi+DQBJmOPvKNKiBGr4ghU4Bk
        DnetRL5ljxtb2zSKcOyVwaS4LYS8BtmZ7hzcuyc7ZB1kOo0EPtlD9h7Tls1jLioCM5Ajre
        hKyL2EpNW6hNnTXyBrJlHtORn39MQHrA49DqXv+1uiJN0qw5Xfage2aRTFr8ag375vmtIa
        6xg4ykT0CauWwbVYin6pvwNH4RVe0EcOiKR1A2p0AjhhMqlYN99IbGsrGLZMYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667921434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4MVyWw7ozXcrMblhUHcrr7SNs20kmx0c9ac3Fc4GHxA=;
        b=euqAlzo52o/6jrfZX8Lp+1bNRbUkZ1W8dwyxUykH/ceBVA7N2iV0R8a2CXOTia5ACyqyxN
        PwW5yOmZ5m4N7CCQ==
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
Subject: Re: [PATCH v4 09/16] timer: Split out "get next timer interrupt"
 functionality
In-Reply-To: <20221107124205.GC4588@lothringen>
Message-ID: <d1baf616-1bd7-5c1-8721-4d45ae43f9@linutronix.de>
References: <20221104145737.71236-1-anna-maria@linutronix.de> <20221104145737.71236-10-anna-maria@linutronix.de> <20221107124205.GC4588@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Nov 2022, Frederic Weisbecker wrote:

> On Fri, Nov 04, 2022 at 03:57:30PM +0100, Anna-Maria Behnsen wrote:
> > forward_and_idle_timer_bases() includes the functionality for getting the
> > next timer interrupt. To reuse it, it is splitted into an separate function
> > "get_next_timer_interrupt()".
> > 
> > This is preparatory work for the conversion of the NOHZ timer
> > placement to a pull at expiry time model. No functional change.
> > 
> > Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> > ---
> > v4: Fix typo in comment
> > ---
> >  kernel/time/timer.c | 93 +++++++++++++++++++++++++--------------------
> >  1 file changed, 51 insertions(+), 42 deletions(-)
> > 
> > diff --git a/kernel/time/timer.c b/kernel/time/timer.c
> > index 680a0760e30d..853089febf83 100644
> > --- a/kernel/time/timer.c
> > +++ b/kernel/time/timer.c
> > @@ -1704,6 +1704,46 @@ static unsigned long next_timer_interrupt(struct timer_base *base)
> >  	return base->next_expiry;
> >  }
> >  
> > +static unsigned long get_next_timer_interrupt(struct timer_base *base_local,
> 
> So perhaps forward_and_idle_timer_interrupt() could stay as
> "get_next_timer_interrupt()" and the new get_next_timer_interrupt() above could
> become fetch_next_timer_interrupt().
> 
> Just an idea.

Hmm... it's better than mine :) I know, forward_and_idle_timer_bases() is
not the best name.

Maybe, it is total irrelevant: Since local and global timer information is
required, the original get_next_timer_interrupt() does not return directly
the next timer interrupt. This was introduced already in patch "timer:
Retrieve next expiry of pinned/non-pinned timers seperately". So it's no
longer possible to write:

	next_timer = get_next_timer_interrupt()

When having a function "get_something()" I would expect the information is
returned directly. Perhaps just a thing that I would expect... the new
get_next_timer_interrupt() returns directly the next timer interrupt.

Thanks,

	Anna-Maria


