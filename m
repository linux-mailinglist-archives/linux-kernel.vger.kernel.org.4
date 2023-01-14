Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE9F66AD3F
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 19:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjANSPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 13:15:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjANSPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 13:15:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C00BBB3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 10:15:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EA413B8075F
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 18:15:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 516A0C433D2;
        Sat, 14 Jan 2023 18:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673720138;
        bh=kyAqUetqpgreKMKa6nhQXdZiaR1Ox94PbcTog2+rpAQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=st47n5FNx4DQtAAj5hzhyqeDrad/t1WgimOkBmcU4Bqw0CKAYadwcZfnPn1qKReZh
         o7ytHUbpjp86Tz4Alyhl0jr3MmrfmmN4S29LHXT0CAdTt+xeCpJfL1E+ACQ0Pl58EU
         oMajBKYww6wIvOJFoE42qADKS/R3yhnN1ujxzGDAE8nC36hKEA+egraXfQOAlyLNBp
         yI/KsKzoN5PNLoaxrJIHMcwWnt08H7MVtep7Wbu0lMKarDnf2izDJFECze1xtIJtxh
         ngBjfb1ikn13tJsw/7uhvy8dIZaioCGd69BJSElTPLut55rAf5uFAFuYkEifBOtd9K
         BTe9A99VwWeiQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D9F335C0AF8; Sat, 14 Jan 2023 10:15:37 -0800 (PST)
Date:   Sat, 14 Jan 2023 10:15:37 -0800
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
Message-ID: <20230114181537.GA493203@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <YytfFiMT2Xsdwowf@rowland.harvard.edu>
 <YywXuzZ/922LHfjI@hirez.programming.kicks-ass.net>
 <114ECED5-FED1-4361-94F7-8D9BC02449B7>
 <Y77QbG9lVXX9/B87@rowland.harvard.edu>
 <4c1abc7733794519ad7c5153ae8b58f9@huawei.com>
 <Y8GGmstFlgg91RMp@rowland.harvard.edu>
 <20230113200706.GI4028633@paulmck-ThinkPad-P17-Gen-1>
 <20230113203241.GA2958699@paulmck-ThinkPad-P17-Gen-1>
 <136d019d8c8049f6b737627df830e66f@huawei.com>
 <20230114175343.GF2948950@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230114175343.GF2948950@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 14, 2023 at 09:53:43AM -0800, Paul E. McKenney wrote:
> On Fri, Jan 13, 2023 at 08:43:42PM +0000, Jonas Oberhauser wrote:
> > 
> > 
> > -----Original Message-----
> > From: Paul E. McKenney [mailto:paulmck@kernel.org] 
> > 
> > > (* Compute matching pairs of Srcu-lock and Srcu-unlock *) let srcu-rscs = ([Srcu-lock] ; rfi ; [Srcu-unlock]) & loc
> > 
> > How does the Srcu-unlock read from the Srcu-lock? Is there something in your model or in herd that lets it understand lock and unlock should be treated as writes resp. reads from that specific location?
> > 
> > Or do you mean that value given to Srcu-unlock should be the value produced by Srcu-lock?
> 
> Yes, and in the Linux kernel one does something like this:
> 
> 	idx = srcu_read_lock(&mysrcu);
> 	// critical section
> 	srcu_read_unlock(&mysrcu, idx);
> 
> > Perhaps the closest to what you want is to express that as a data dependency if you know how to teach herd that Srcu-unlock is a read and Srcu-lock depends on its second input :D (I have no idea how to do that, hence the questions above)
> 
> Given that both you and Alan suggested it, I must try it.  ;-)

And it works as desired on these litmus tests:

manual/kernel/C-srcu-nest-*.litmus

In this repository:

https://github.com/paulmckrcu/litmus

However, this has to be dumb luck because herd7 does not yet provide
the second argument to srcu_read_unlock().  My guess is that the herd7
is noting the dependency that is being carried by the pointers to the
srcu_struct structures.  This guess stems in part from the fact that
I get "Flag unbalanced-srcu-locking" when I have one SRCU read-side
critical section following another in the same process, both using the
same srcu_struct structure.

Nevertheless, here is the resulting .bell fragment:

------------------------------------------------------------------------

(* Compute matching pairs of Srcu-lock and Srcu-unlock *)
let srcu-rscs = ([Srcu-lock] ; data ; [Srcu-unlock]) & loc

(* Validate nesting *)
flag ~empty Srcu-lock \ domain(srcu-rscs) as unbalanced-srcu-locking
flag ~empty Srcu-unlock \ range(srcu-rscs) as unbalanced-srcu-locking

(* Check for use of synchronize_srcu() inside an RCU critical section *)
flag ~empty rcu-rscs & (po ; [Sync-srcu] ; po) as invalid-sleep

(* Validate SRCU dynamic match *)
flag ~empty different-values(srcu-rscs) as srcu-bad-nesting

------------------------------------------------------------------------

I also created a C-srcu-nest-*.litmus as shown below, and LKMM does
complain about one srcu_read_lock() feeding into multiple instances of
srcu_read_unlock().  The complaint comes from the different_values()
check, which presumably complains about any duplication in the domain
or range of the specified relation.

But still working by accident!  ;-)

							Thanx, Paul

------------------------------------------------------------------------

C C-srcu-nest-3

(*
 * Result: Flag srcu-bad-nesting
 *
 * This demonstrates erroneous matching of a single srcu_read_lock()
 * with multiple srcu_read_unlock() instances.
 *)

{}

P0(int *x, int *y, struct srcu_struct *s1, struct srcu_struct *s2)
{
	int r1;
	int r2;
	int r3;
	int r4;

	r3 = srcu_read_lock(s1);
	r2 = READ_ONCE(*y);
	r4 = srcu_read_lock(s2);
	r5 = srcu_read_lock(s2);
	srcu_read_unlock(s1, r3);
	r1 = READ_ONCE(*x);
	srcu_read_unlock(s2, r4);
}

P1(int *x, int *y, struct srcu_struct *s2)
{
	WRITE_ONCE(*y, 1);
	synchronize_srcu(s2);
	WRITE_ONCE(*x, 1);
}

locations [0:r1]
exists (0:r1=1 /\ 0:r2=0)
