Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 342E166865B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 23:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239921AbjALWIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 17:08:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232925AbjALWHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 17:07:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A260512756
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 13:57:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D8A662174
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 21:57:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 706CBC433D2;
        Thu, 12 Jan 2023 21:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673560636;
        bh=8V9Pj1440UnKiY8Xg24W9iTsMJlfHddtnRik3iT3n5w=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=qxnKF0ZW7u0WEKV4co0J7dslXuLziaoF4QE0T16XUlNvuki05OPlfrUUpMeaSIzRu
         iBiV9/PunI8fXDMbyvHcSr44Nbs6aDzVI5MnN0fEYd0FmePAKqJHfUtwSvZgJEdRBr
         fsIE/LRsH3xXbQbsqrMuIeqL7w4TFvpN1iZQKcFKNGFOQYTkZjzYNjxC5N5iMoH3Sy
         0KZ1rbvIA6fVA5MAa3KWezRZK14Bkmx74+tKy9fo89uiKKEJ38sSqm1+ppCzWN17PQ
         t3m3hY0GOrdBM+Pvz4nZhYhD1ttxArwvVISOq2wr3CJWKtBBRwgfxE5Im//5bgVGY3
         W0ykkyAMBqMdQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 1A3345C0AF8; Thu, 12 Jan 2023 13:57:16 -0800 (PST)
Date:   Thu, 12 Jan 2023 13:57:16 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Jonas Oberhauser <jonas.oberhauser@huawei.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        "parri.andrea" <parri.andrea@gmail.com>, will <will@kernel.org>,
        "boqun.feng" <boqun.feng@gmail.com>, npiggin <npiggin@gmail.com>,
        dhowells <dhowells@redhat.com>,
        "j.alglave" <j.alglave@ucl.ac.uk>,
        "luc.maranget" <luc.maranget@inria.fr>, akiyks <akiyks@gmail.com>,
        dlustig <dlustig@nvidia.com>, joel <joel@joelfernandes.org>,
        urezki <urezki@gmail.com>,
        quic_neeraju <quic_neeraju@quicinc.com>,
        frederic <frederic@kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Internal vs. external barriers (was: Re: Interesting LKMM litmus
 test)
Message-ID: <20230112215716.GS4028633@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220921173109.GA1214281@paulmck-ThinkPad-P17-Gen-1>
 <YytfFiMT2Xsdwowf@rowland.harvard.edu>
 <YywXuzZ/922LHfjI@hirez.programming.kicks-ass.net>
 <114ECED5-FED1-4361-94F7-8D9BC02449B7>
 <Y77rgeg+UgozV/oF@rowland.harvard.edu>
 <07579baee4b84532a76ea8b0b33052bb@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07579baee4b84532a76ea8b0b33052bb@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 05:24:07PM +0000, Jonas Oberhauser wrote:
> 
> 
> -----Original Message-----
> From: Alan Stern [mailto:stern@rowland.harvard.edu] 
> > What is there to try?  As far as I know, the only construct in the cat language that can be used to get the effect of counting is a recursive definition.
> > Such a lemma would have to be based on the other constructs available in the language.  The only things I can think of which even come close are the * and + operators, and they are insufficient (because they are no stronger than regular expressions, which are well known to be too weak
> -- there isn't even a regular expression for strings in which the parentheses are balanced).
> 
> Well, like I said, I don't yet understand rcu-order well enough to have any opinions :D
> You could say that the time period between me asking if you've tried other stuff and thinking that there's probably some impossibility result making that a waste of time were the one minute I used to read the comment above rcu-order and look at the recursion a little :-P, that was barely enough to understand that you're counting stuff which like you say is probably not possible with the other operators.
> 
> Anyways I'll need to take some time to read the definition carefully.

Apologies for the delay, gmail spam-foldered your email again.  :-/

I will risk sharing the intuition behind the rcu-order counting rule.

In the code, an RCU read-side critical section begins with rcu_read_lock()
and ends with the matching rcu_read_unlock().  RCU read-side critical
section may be nested, in which case RCU cares only about the outermost
of the nested set.

An RCU grace period includes at least one moment in time during which
each and every process/CPU/task/whatever is not within an RCU read-side
critical section.  Any period of time spanning a grace period is itself
a grace period.  And synchronize_rcu() waits for a grace period.

Taking the above two paragraphs together, it is forbidden for any RCU
read-side critical section to start before the beginning of a given
grace period and end after the end of that same grace period.

There is no ordering within or between RCU read-side critical sections
other than their separate relationships to any concurrent grace periods
and due to any operations within or between them that may have ordering
effects.  For example, if you have a series of three non-overlapping RCU
read-side critical sections executed by a given process in the absence of
any grace periods (for example, in the absence of any synchronize_rcu()
invocations), and where all other operations executed by that process
are READ_ONCE() and WRITE_ONCE(), without dependencies of any sort,
those memory-reference operations can be executed in any order.

So if a given RCU read-side critical section's first operation follows a
given grace period on some other process, then all of its other operations
might have been executed just after the start of that same grace period.
The start of the grace period must be epsilon before the (reordered)
end of that RCU read-side critical section.

Suppose that one of that critical section's memory references started
just before a memory reference of some other critical section on some
other process.  Then other references in this second critical section
could be reordered to precede the beginning of the grace period.

If you work the other possible examples, you will find that as long as
there are at least as many grace periods as critical sections in a given
candidate cycle, there will be sufficient ordering to prohibit that cycle.

For diagrams, please see Figures 15.14-15.16 here:

https://kernel.org/pub/linux/kernel/people/paulmck/perfbook/perfbook.2022.09.25a.pdf

On the off-chance that this helps...

							Thanx, Paul
