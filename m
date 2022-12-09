Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C25E4647A6B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 01:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiLIABt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 19:01:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiLIABP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 19:01:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70347B4DC
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 16:01:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 429D1620E6
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 00:01:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BEEFC433D2;
        Fri,  9 Dec 2022 00:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670544072;
        bh=Z/QP6BWp7Cfosmo6Fmzdsafw/CMT+0y23fVHf9lrhts=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=TU0y0ZpCMnzyd5OhLnDOpJQlAnEXLLPkstRqNFzH65cNY7Zycj1UF65iJDRGxqYR1
         mP9TLShn45lfC9uJ1+5/cfTDfblT2chCfHg8F0rUuTsT/410evlTE+Vy0Zxsb4u3+S
         O98/jNHmLgcF0ZywL4W9Cz1vr6LhIaJ6/L8yM5XziCU7CF85vt0b3/TNuuPWU2LxPk
         2T+lqYwSPPnM8CqiHE4YMqkdUXjwvOM0Q02YltCJOHD3ZOoDMo3WC64b0qQo0YeJD9
         p8rOcYAMuFiXwlQKPRCPk9jUmAhWz8SznbSSR/iA3C7smu2loJNEaR33Q97+TwO2Gh
         jHRYiertVznRQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 305E15C1523; Thu,  8 Dec 2022 16:01:12 -0800 (PST)
Date:   Thu, 8 Dec 2022 16:01:12 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
        "will@kernel.org" <will@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "j.alglave@ucl.ac.uk" <j.alglave@ucl.ac.uk>,
        "luc.maranget@inria.fr" <luc.maranget@inria.fr>,
        "akiyks@gmail.com" <akiyks@gmail.com>,
        "dlustig@nvidia.com" <dlustig@nvidia.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "urezki@gmail.com" <urezki@gmail.com>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tools: memory-model: Make plain accesses carry
 dependencies
Message-ID: <20221209000112.GT4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221203190226.GR4001@paulmck-ThinkPad-P17-Gen-1>
 <Y4uyzDl49Zm3TSLh@rowland.harvard.edu>
 <20221203204405.GW4001@paulmck-ThinkPad-P17-Gen-1>
 <Y4vAYzJTTQtNkXFh@rowland.harvard.edu>
 <20221203231122.GZ4001@paulmck-ThinkPad-P17-Gen-1>
 <43c7ea9ebdd14497b85633950b014240@huawei.com>
 <Y4xbQmnDEbFTvgQ/@Boquns-Mac-mini.local>
 <d86295788ad14a02874ab030ddb8a6f8@huawei.com>
 <Y4/v1bCjahxA1LVt@boqun-archlinux>
 <Y5JRzG78dHfnp0bR@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5JRzG78dHfnp0bR@boqun-archlinux>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2022 at 01:06:20PM -0800, Boqun Feng wrote:
> On Tue, Dec 06, 2022 at 05:43:49PM -0800, Boqun Feng wrote:
> > On Mon, Dec 05, 2022 at 01:42:46PM +0000, Jonas Oberhauser wrote:
> > [...]
> > > > Besides, could you also explain a little bit why only "data;rfi" can
> > > > be "carry-dep" but "ctrl;rfi" and "addr;rfi" cannot? I think it's
> > > > because there are special cases when compilers can figure out a
> > > > condition being true or an address being constant therefore break
> > > > the dependency
> > > 
> > > Oh, good question. A bit hard for me to write down the answer clearly
> > > (which some people will claim that I don't understand it well myself,
> > > but I beg to differ :) :( :) ).
> > > 
> > > In a nutshell, it's because  x ->data  [Plain]  ->rfi  y ->... z
> > > fulfils the same role as storing something in a register and then
> > > using it in a subsequent computation; x ->ctrl y ->... z (and ->addr)
> > > don't. So it's not due to smart compilers, just the fact that the
> > > other two cases seem unrelated to the problem being solved, and
> > > including them might introduce some unsoundness (not that I have
> > > checked if they do).
> > > 
> > > Mathematically I imagine the computation graph between register
> > > accesses/computations r_1,...,r_n and memory accesses m_1,...m_k that
> > > has an unlabeled edge  m_i -> r_j when m_i loads some data that is an
> > > input to the access/computation r_j, similarly it has an unlabeled
> > > edge r_i -> r_j  when the result of r_i is used as an input of r_j,
> > > and finally r_i ->data/ctrl/addr m_j when the value computed by r_j is
> > > the address/data or affects the ctrl of m_j.  So for example, if 'int
> > > a' were to declare a register, then
> > >     int a = READ_ONCE(&x);
> > >     if (a == 5) { WRITE_ONCE(&y,5); }
> > > would have something like (*) 4 events  (*= since I'm avoiding fully
> > > formalizing the graph model here I don't really define to which extent
> > > one splits up register reads, computations, etc., so I'll do it
> > > somewhat arbitrarily)
> > > m_1 = READ_ONCE(&x)
> > > r_1 = store the result of m_1 in a
> > > r_2 = compare the content of a to 5
> > > m_2 = WRITE_ONCE(&y, 5)
> > > 
> > > with the edges m_1 -> r_1 -> r_2 ->ctrl m_2
> > > 
> > > Then in the LKMM graph, we would have m_i ->ctrl m_j (or data or addr)
> > > iff there is a path m_i -> r_x1 -> ... -> r_xl ->ctrl m_j (or data or
> > > addr).
> > > So in the example above, m_1 ->ctrl m_2.
> > > 
> > > Now what we would do is look at what happens if the compiler/a
> > > tool/me/whatever interprets 'int a' as a memory location. Instead of
> > > r_1 and r_2 from above, we would have something like
> > > 
> > > m_1 = READ_ONCE(&x)
> > > r_3 = the result of m_1 (stored in a CPU register)
> > > m_3 = a := the r_3 result
> > > m_4 = load from a
> > > r_4 = the result of m_4 (stored in a CPU register)
> > > m_2 = WRITE_ONCE(&y, 5)
> > > 
> > > with m_1 -> r_3 ->data -> m_3  ->rfi  m_4 -> r_4 ->ctrl m_2
> > > and hence
> > > m_1 ->data m_3 ->rfi m_4 ->ctrl m_2
> > > 
> > > What the patch does is make sure that even under this interpretation,
> > > we still have m_1 ->ctrl m_2
> > > Note that this ->data ->rfi applies in every case where something is
> > > considered a register is turned into a memory location, because those
> > > cases always introduce a store with a fixed address (that memory
> > > location) where the data is the current content of the register, which
> > > is then read (internally) at the next time that data is picked up. A
> > > store to register never becomes a ctrl or addr edge, hence they are
> > > not included in the patch.
> > > 
> > 
> > Let me see if I can describe your approach in a more formal way (look at
> > me, pretending to know formal methods ;-))
> > 
> > Bascially, what you are saying is that for every valid litmus test with
> > dependencies (carried by local variables i.e. registers), there exists a
> > way to rewrite the litmus test by treating all (or any number of) local
> > variables as memory locations.
> > 
> > Lets say the set of the litmus tests to start with is L and the set of
> > the rewritten ones is L'is. Here is a rewrite rule I come up with:
> > 
> > 1)	for every local named <n> on processor <P>, add an extra memory
> > 	location (maybe named <n>_<P>) in the processor function, for
> > 	example
> > 
> > 		P0(int *x, int *y) {
> > 			int a ...;
> > 		}
> > 
> > 	became
> > 		P0(int *x, int *y, int *a_P0) {
> > 		}
> > 
> > 2)	for each <n> in 1), for each assignment of <n>, say:
> > 
> > 		int <n> = <expr>; // H
> > 
> > 		or 
> > 
> > 		<n> = <expr>; // H
> > 	
> > 	rewrite it to
> > 	
> > 		int computer_register_<seq> = <expr>; // A
> > 		*<n>_<P> = computer_register_<seq>; // B
> > 	
> > 	where <seq> is a self increasing counter that increases every
> > 	step or the rewrite.
> > 
> > 	This step introduces an extra edge A ->data B.
> > 
> > 3)	for each <n> in 1), for each the read of <n>, say:
> > 
> > 		Expr; // T
> > 	
> > 	rewrite it to
> > 
> > 		int computer_register_<seq> = *<n>_<P>; // C
> > 		Expr[<n>/computer_register_<seq>]; // D
> > 
> > 	where <seq> is a self increasing counter that increases every
> > 	step or the rewrite.
> > 
> > 	"M[x/y]" means changing the expression by replace all appearance
> > 	of variable x into y, e.g. (n1 = n + 1)[n/y] is n1 = y + 1.
> > 
> > 	Note that for every rewrite 3), there must exists a
> > 	corresponding rewrite 2), that C reads the value stored by the
> > 	B of the rewrite 2). This is because the litmus tests in set L
> > 	are valid, all variables must be assigned a value before used.
> > 
> > 	This step introduces an extra edge B ->rfi C, and also for every
> > 	dependency between H -> T in the old litmus test, it preserves
> > 	between C -> D in the new litmus test.
> > 
> > 4)	for each <n> and <P> in 1), for each expression in the exist
> > 	clause, say:
> > 
> > 		Expr
> > 	
> > 	rewrite it to
> > 
> > 		Expr[<P>:<n>/<n>_<P>]
> > 
> > For example, by these rules, the following litmus test:
> > 
> > 	P0(int *x, int *y) {
> > 		int r = READ_ONCE(*x);
> > 		WRITE_ONCE(*y, r);
> > 	}
> > 	exists(0:r = 1)
> > 
> > is rewritten into
> > 
> > 	P0(int *x, int *y, int *r_P0) {
> > 		int computer_register_0 = READ_ONCE(*x); // by 2)
> > 		*r_P0 = computer_register_0;             // by 2)
> > 		int computer_register_1 = *r_P0;         // by 3)
> > 		WRITE_ONCE(*y, computer_register_1);     // by 3)
> > 	}
> > 	exists(r_P0 = 1)                                 // by 4)
> > 
> > 
> > It's obvious that the rewritten litmus tests are valid, and for every
> > dependency
> > 	
> > 	H ->dep T in litmus tests of set L
> > 
> > there must exists a
> > 
> > 	A ->data ->rfi ->dep D in L'
> > 
> > ("dep" is not the same as in linux-kernel.cat).
> > 
> > And note since L' is a set of valid litmus tests, we can do another
> > whole rewrite to L' and get L'' which will contains
> > ->data->rfi->data->rfi->dep, and this covers the (data;rfi)* ;-)
> > 
> > 
> > Now the hard part, since the rewrite is only one-direction, i.e L => L',
> > or more preciselly the transverse closure of the rewrite is
> > one-direction. We can only prove that if there exists a valid litmus
> > test with dependency ->dep, we can construct a number of litmus tests
> > with (->data ->rfi)*->dep.
> > 
> > But to accept the new rules in your patch, we need the opposite
> > direction, that is, if there exists a (->data ->rfi)* ->dep, we can
> > somehow find a litmus test that preserves anything else but reduce
> > 
> > 	(->data->rfi)*->dep
> > into
> > 
> > 	->dep.
> > 
> > (I'm not sure the following is sound, since some more work is needed)
> > 
> > The first observation is that we can ignore ->data [Marked] ->rfi,
> > because if we can reduce
> > 
> > 	(->data [Plain] ->rfi)* ->data [Marked] ->rfi -> (->data [Plain] ->rfi)* ->dep
> > 
> > to
> > 	
> > 	->data [Marked] ->rfi ->dep
> > 
> > we get "hb", which already has the ordering we want.
> > 
> > Now we can focus on ->data [Plain] ->rfi ->dep, e.g.
> > 
> > 	x = READ_ONCE(..); // A
> > 	*<N> = <expr>; // B, contains x
> > 	r = Expr; // C, Expr contains *<N>
> > 	WRITE_ONCE(.., r); // D
> > 
> > We need to assume that the litmus tests are data-race free, since we
> > only care about valid litmus tests, then it's OK. The rewritten looks
> > like the following:
> > 
> > 	int computer_register_<seq>;
> > 	x = READ_ONCE(..); // A
> > 	computer_register = <expr>; // B, contains x
> > 	// ^^^ basically reverse rewrite of the 2) above	
> > 
> > 	r = Expr[*<N>/computer_register_<seq>]; // C
> > 	// ^^^ basically reverse rewrite of the 3) above	
> > 
> > 	*<N> = computer_register_<seq>; // R
> > 	// ^^^ need this to keep the global memory effect
> > 
> > 	WRITE_ONCE(.., r); // D
> > 	
> > We need the data-race free assumption to replace a memory cell into a
> > local variable.
> > 
> > By this rewrite, We reduce
> > 	A ->data B ->rfi C ->dep D
> > into
> > 	A ->dep D.
> > 
> > A few details are missing here, for example we may have multip Cs and
> > need to rewrite all of them, and we need normalization work like
> > converting litmus tests into canonical forms (e.g change the += into
> > temporary variables and assignment). Also we need to prove that no more
> > edges (or edges we care) are added. But these look obvious to me, and
> > enough formally digging for me today ;-)
> > 
> > As a result, the rewrite operation on L is proved to be isomorphic! ;-)
> > In the sense that we think reducing to (->data [Marked] ->rfi)* ->dep
> > is good enough ;-)
> > 
> > Now for every litmus test with
> > 
> > 	(->data ->rfi)* ->dep
> > 
> > we can rewrite it into another litmus test preserving all other edges
> > except replacing the above with
> > 
> > 	(->data [Marked] ->rfi)* ->dep
> > 
> > and the rewrite only contains replacing non-data-race accesses with
> > local variables and in the sense of C standards and maybe other model
> > tools these litmus tests are equivalent.
> > 
> > > Please let me know if this is convincing and clear. If so we could
> > > link to your e-mail and my response to provide context, without having
> > > to put a huge explanation into the commit message. If that's not
> > > desirable I can also think about how to compress this into a shorter
> > > explanation.
> > > 
> > 
> > My intution now is the rewrite explanation above, which is good enough
> > for me but not sure for other audience. Thank you for keep explaining
> > this to me ;-)
> > 
> > 
> > Regards,
> > Boqun
> > 
> 
> Paul, I think Jonas and I reach out to some degree of argeement on more
> details of this change, at least I learned a lot ;-)
> 
> Could you add the following lines in the commit log if you haven't send
> a PR?
> 
> 	More deep details can be found at the LKML discussion[1]
> 
> 	[1]: https://lore.kernel.org/lkml/d86295788ad14a02874ab030ddb8a6f8@huawei.com/
> 
> I think Jonas' email covers most of the details behind the change and
> can server as a "Quick Quiz" for the readers of the commit log ;-)
> 
> Thoughts?

I am not so sure that any such quiz would be quick, but life is often
like that for memory models.  ;-)

Thank you all, and unless there are further objections, I will update
this on the next rebase.

						Thanx, Paul

> Regards,
> Boqun
> 
> > > Best wishes,
> > > Jonas
> > > 
> > > PS:
> > > 
> > > > sometimes I'm just slow to understand things ;-)
> > > 
> > > Well, welcome in the club :D
