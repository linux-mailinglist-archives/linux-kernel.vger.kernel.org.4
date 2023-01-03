Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5043365C6CE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 19:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238595AbjACS4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 13:56:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238568AbjACS4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 13:56:10 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 65AD9DF41
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 10:56:09 -0800 (PST)
Received: (qmail 443440 invoked by uid 1000); 3 Jan 2023 13:56:08 -0500
Date:   Tue, 3 Jan 2023 13:56:08 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Jonas Oberhauser <jonas.oberhauser@huawei.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
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
Subject: Internal vs. external barriers (was: Re: Interesting LKMM litmus
 test)
Message-ID: <Y7R6SPHGS9U/T6IC@rowland.harvard.edu>
References: <20220921173109.GA1214281@paulmck-ThinkPad-P17-Gen-1>
 <YytfFiMT2Xsdwowf@rowland.harvard.edu>
 <YywXuzZ/922LHfjI@hirez.programming.kicks-ass.net>
 <114ECED5-FED1-4361-94F7-8D9BC02449B7>
 <YzSAnclenTz7KQyt@rowland.harvard.edu>
 <f763bd5ff835458d8750b61da47fe316@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f763bd5ff835458d8750b61da47fe316@huawei.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Added LKML to the CC: list so there will be a permanent record of this 
part of the discussion, and changed the Subject: to something more 
descriptive of the topic at hand.]

On Tue, Jan 03, 2023 at 04:57:56PM +0000, Jonas Oberhauser wrote:
> Happy new year everyone!
> 
> I'd like to circle back to the brief discussion we had about ppo \subseteq po.
> 
> Here's some context:
> 
> > > > > the preserved program order not always being a 
> > > > > program order, lack of
> > > 
> > > > Where does the LKMM allow a ppo relation not to be in program order?
> > >
> > > When one thread releases a lock and another one takes the lock, you 
> > > can get an mb relation between the two threads
> > >
> > > https://github.com/torvalds/linux/blob/master/tools/memory-model/linux
> > > -kernel.cat#L40
> > > 
> > > this then turns into a ppo edge.
> 
> > Ah.  I suppose we should have been a little more careful about internal vs. external full barriers.  RCU barriers are also external, but the model didn't try to include them in the definition of mb; we should have done the same with unlock-lock.
> 
> To be more explicit, in the current LKMM, mb includes some cases of po;[UL];co;[LKW];po which also relates events between threads, and this trickles up to the ppo:
> 
>   let mb = ([M] ; fencerel(Mb) ; [M]) |
> 	([M] ; fencerel(Before-atomic) ; [RMW] ; po? ; [M]) |
> 	([M] ; po? ; [RMW] ; fencerel(After-atomic) ; [M]) |
> 	([M] ; po? ; [LKW] ; fencerel(After-spinlock) ; [M]) |
> 	([M] ; po ; [UL] ; (co | po) ; [LKW] ;
> 		fencerel(After-unlock-lock) ; [M])
>   let gp = po ; [Sync-rcu | Sync-srcu] ; po?
>   let strong-fence = mb | gp
>   ...
>   let ppo = to-r | to-w | (... | strong-fence | ...) | (po-unlock-lock-po & int) // expanded for readability
> 
> Because of this, not every preserved program order edge is actually a program order edge that is being preserved.

Indeed, one can argue that neither the fence nor the (po-unlock-lock-po 
& int) sub-relations should be included in ppo, since they don't reflect 
dataflow constraints.  They could instead be added separately to the 
definition of hb, which is the only place that uses ppo.

> My suggestion for a fix would be to move this part out of mb and strong-fence, and instead introduce a new relation strong-sync that covers synchronization also between threads.
> 
>   let mb = ([M] ; fencerel(Mb) ; [M]) |
> 	([M] ; fencerel(Before-atomic) ; [RMW] ; po? ; [M]) |
> 	([M] ; po? ; [RMW] ; fencerel(After-atomic) ; [M]) |
> 	([M] ; po? ; [LKW] ; fencerel(After-spinlock) ; [M]) |
> - 	([M] ; po ; [UL] ; (co | po) ; [LKW] ;
> -		fencerel(After-unlock-lock) ; [M])
>   let gp = po ; [Sync-rcu | Sync-srcu] ; po?
>   let strong-fence = mb | gp
> +  let strong-sync = strong-fence | ([M] ; po ; [UL] ; (co | po) ; [LKW] ;
> +		fencerel(After-unlock-lock) ; [M])
> ...
>   let ppo = to-r | to-w | (... | strong-fence | ...) | (po-unlock-lock-po & int)
> 
> and then use strong-sync instead of strong-fence everywhere else, e.g.
> - let pb = prop ; strong-fence ; hb* ; [Marked]
> + let pb = prop ; strong-sync ; hb* ; [Marked]
> and similarly where strong-fence is being redefined and used in various later lines.
> (In general I would prefer renaming also other *-fence relations into *-sync when they include edges between threads).
> 
> 
> Note that no ordering is changed by this move.
> Firstly, the case [M];po;[UL];po;[LKW]; fencerel(After-unlock-lock) ; [M] which is also eliminated from mb by this change  is still present in ppo through the definition ppo = ... | (po-unlock-lock-po & int).
> Secondly, for the ordering of [M];po;[UL];co;[LKW]; fencerel(After-unlock-lock) ; [M] we can focus on the case [M];po;[UL];coe;[LKW]; fencerel(After-unlock-lock) ; [M] because the other case (coi) is covered by the previous case.
> Ordering imposed by this case is also not lost, since every [M];po;[UL];coe;[LKW]; fencerel(After-unlock-lock) ; [M] edge also imposes a
>     [M];po;[UL];rfe;[LKR]; fencerel(After-unlock-lock) ; [M]
> edge which is a po-rel ; [Marked] ; rfe ; [Marked] ; acq-po edge and hence hb;hb;hb.
> Thirdly, no new ordering is imposed by this change since every place we now order by strong-sync was previously ordered by the old strong-fence which is identical to the new strong-sync, and in all other places we changed we just (potentially) removed ordering.
> 
> The definition of strong-sync could also be slightly simplified to 
>   let strong-sync = strong-fence | ([M]; po-unlock-lock-po ; [After-unlock-lock] ; po ; [M])
> which is kind of pretty because the after-unlock-lock is now after po-unlock-lock-po.
> 
> What do you think?

That all sounds good to me.  However, I wonder if it might be better to 
use "strong-order" (and similar) for the new relation name instead of 
"strong-sync".  The idea being that fences are about ordering, not (or 
not directly) about synchronization.

Alan
