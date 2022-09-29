Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4F75EF3BD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 12:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234875AbiI2K4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 06:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234320AbiI2K4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 06:56:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E47512519F
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 03:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jBAf0KE8iX8Qho8Azh49RNNh62otABcBwnWgDAQYM6w=; b=lufQ6KmTFZ00FWgUu0dcQ2B2JB
        CFoCZLX0nQlx3Tf0JnJX0OTgolxR7+3BAhHNyKnmaM/ToCOiNZAKvPZrAOOjth9j5wK0sOJ830MzU
        z3qreXoSrC5jb4fMIPwPBoX6lsD/4PGgiS3QQd92SKHgP6v2eP1VbZrTaxVlvBjyYbh5LWMdqJ1bo
        QqjSuq49zvFozPOZHNMcky7u3DgWmNvUQElCQdgkXWhqeJiwIV0SkXBpFqdLfV2KS83sZiU2iKBzY
        2FZS58G/HScxpWkg7r1Do3JFuZPxbsadP9zUx1SyjX7wy4fD2X+p+D/nPfC8CleiLqlL4StEqkgUT
        vlwnddLw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1odrD0-00DDBX-EQ; Thu, 29 Sep 2022 10:56:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 91C5C30007E;
        Thu, 29 Sep 2022 12:55:58 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 787752019CD2C; Thu, 29 Sep 2022 12:55:58 +0200 (CEST)
Date:   Thu, 29 Sep 2022 12:55:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: RCU vs NOHZ
Message-ID: <YzV5vqoLInptafJm@hirez.programming.kicks-ass.net>
References: <YyLksEr05QTNo05Q@hirez.programming.kicks-ass.net>
 <20220915160600.GA246308@paulmck-ThinkPad-P17-Gen-1>
 <YyN0BKEoDbe4hcIl@hirez.programming.kicks-ass.net>
 <20220915191427.GC246308@paulmck-ThinkPad-P17-Gen-1>
 <YyOnilnwnLKA9ghN@hirez.programming.kicks-ass.net>
 <20220916075817.GE246308@paulmck-ThinkPad-P17-Gen-1>
 <YyQ/zn54D1uoaIc1@hirez.programming.kicks-ass.net>
 <20220917142508.GF246308@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220917142508.GF246308@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 17, 2022 at 07:25:08AM -0700, Paul E. McKenney wrote:
> On Fri, Sep 16, 2022 at 11:20:14AM +0200, Peter Zijlstra wrote:
> > On Fri, Sep 16, 2022 at 12:58:17AM -0700, Paul E. McKenney wrote:
> > 
> > > To the best of my knowledge at this point in time, agreed.  Who knows
> > > what someone will come up with next week?  But for people running certain
> > > types of real-time and HPC workloads, context tracking really does handle
> > > both idle and userspace transitions.
> > 
> > Sure, but idle != nohz. Nohz is where we disable the tick, and currently
> > RCU can inhibit this -- rcu_needs_cpu().
> 
> Exactly.  For non-nohz userspace execution, the tick is still running
> anyway, so RCU of course won't be inhibiting its disabling.  And in that
> case, RCU's hook is the tick interrupt itself.  RCU's hook is passed a
> flag saying whether the interrupt came from userspace or from kernel.

I'm not sure how we ended up here; this is completely irrelevant and I'm
not disagreeing with it.

> > AFAICT there really isn't an RCU hook for this, not through context
> > tracking not through anything else.
> 
> There is a directly invoked RCU hook for any transition that enables or
> disables the tick, namely the ct_*_enter() and ct_*_exit() functions,
> that is, those functions formerly known as rcu_*_enter() and rcu_*_exit().

Context tracking doesn't know about NOHZ, therefore RCU can't either.
Context tracking knows about IDLE, but not all IDLE is NOHZ-IDLE.

Specifically we have:

	ct_{idle,irq,nmi,user,kernel}_enter()

And none of them are related to NOHZ in the slightest. So no, RCU does
not have a NOHZ callback.

I'm still thikning you're conflating NOHZ_FULL (stopping the tick when
in userspace) and regular NOHZ (stopping the tick when idle).

> And this of course means that any additional schemes to reduce RCU's
> power consumption must be compared (with real measurements on real
> hardware!) to Joel et al.'s work, whether in combination or as an
> alternative.  And either way, the power savings must of course justify
> the added code and complexity.

Well, Joel's lazy scheme has the difficulty that you can wreck things by
improperly marking the callback as lazy when there's an explicit
dependency on it. The talk even called that out.

I was hoping to construct a scheme that doesn't need the whole lazy
approach.


To recap; we want the CPU to go into deeper idle states, no?

RCU can currently inhibit this by having callbacks pending for this CPU
-- in this case RCU inhibits NOHZ-IDLE and deep power states are not
selected or less effective.

Now, deep idle states actually purge the caches, so cache locality
cannot be an argument to keep the callbacks local.

We know when we're doing deep idle we stop the tick.

So why not, when stopping the tick, move the RCU pending crud elsewhere
and let the CPU get on with going idle instead of inhibiting the
stopping of the tick and wrecking deep idle?
