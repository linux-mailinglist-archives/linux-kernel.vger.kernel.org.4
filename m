Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB4565F2C0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 18:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234574AbjAERcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 12:32:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233998AbjAERcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 12:32:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD55BE8
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 09:32:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E49461BB8
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 17:32:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66FEFC433EF;
        Thu,  5 Jan 2023 17:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672939938;
        bh=ikDfHD7FglucoM7XGqmaXrMPOyauM71fIlQwyXQKJ14=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=i/mw5uV1dYUSn4qkM1Acoq4PHmc67+XvhYCEJeqvsETFHS3V7o9c446S3pr3jKRkY
         RM7vAvR0SCGB0cnhaU6uh+BnH5Jz/K/NgGGoMJD+S4DTvYGeK26korBAbhkEgvVXt5
         a4Q0nqO9UhOCB7+uQO4pRKagaPRRc9xj+EBRqNA3jfnEUQeKVbuD+17E5UvDW03kJy
         72gPsNkurtYol/JsaIUb7SDVQWplOCMSStLeW1NCUbDCV2vd7HD37zy/8g3CTESqrs
         bykJ/ksp1Ez40/BRFwvV78FRg+0P7ES40XvonscD3mkWmZ+nYp0fjYaeDBliOnNnOu
         FP8N0it3GygDQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 12B495C0544; Thu,  5 Jan 2023 09:32:18 -0800 (PST)
Date:   Thu, 5 Jan 2023 09:32:18 -0800
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
Message-ID: <20230105173218.GB4028633@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220921173109.GA1214281@paulmck-ThinkPad-P17-Gen-1>
 <YytfFiMT2Xsdwowf@rowland.harvard.edu>
 <YywXuzZ/922LHfjI@hirez.programming.kicks-ass.net>
 <114ECED5-FED1-4361-94F7-8D9BC02449B7>
 <Y7R6SPHGS9U/T6IC@rowland.harvard.edu>
 <ee186bc17a5e48298a5373f688496dce@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee186bc17a5e48298a5373f688496dce@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 11:13:05AM +0000, Jonas Oberhauser wrote:
> 
> 
> -----Original Message-----
> From: Alan Stern [mailto:stern@rowland.harvard.edu] 
> Sent: Tuesday, January 3, 2023 7:56 PM
> > [Added LKML to the CC: list so there will be a permanent record of this part of the discussion, and changed the Subject: to something more descriptive of the topic at hand.]
> 
> Aha, so it's the same discussion but now with 64% improved chance of immortalizing any mistakes I make.

Welcome to our world of open-source software development!  ;-)

> > > To be more explicit, in the current LKMM, mb includes some cases of po;[UL];co;[LKW];po which also relates events between threads, and this trickles up to the ppo:
> > > 
> > >   let mb = ([M] ; fencerel(Mb) ; [M]) |
> > > 	([M] ; fencerel(Before-atomic) ; [RMW] ; po? ; [M]) |
> > > 	([M] ; po? ; [RMW] ; fencerel(After-atomic) ; [M]) |
> > > 	([M] ; po? ; [LKW] ; fencerel(After-spinlock) ; [M]) |
> > > 	([M] ; po ; [UL] ; (co | po) ; [LKW] ;
> > > 		fencerel(After-unlock-lock) ; [M])
> > >   let gp = po ; [Sync-rcu | Sync-srcu] ; po?
> > >   let strong-fence = mb | gp
> > >   ...
> > >   let ppo = to-r | to-w | (... | strong-fence | ...) | 
> > > (po-unlock-lock-po & int) // expanded for readability
> > > 
> > > Because of this, not every preserved program order edge is actually a program order edge that is being preserved.
> 
> > Indeed, one can argue that neither the fence nor the (po-unlock-lock-po & int) sub-relations should be included in ppo, since they don't reflect dataflow constraints.  They could instead be added separately to the definition of hb, which is the only place that uses ppo.
> 
> One can, but one can also argue instead that fences and lock/unlock sequences preserve program order. At least for fences this is the view e.g. RISC-V takes and I prefer this view.
> 
> > > My suggestion for a fix would be to move this part out of mb and strong-fence, and instead introduce a new relation strong-sync that covers synchronization also between threads.
> > > 
> > >   let mb = ([M] ; fencerel(Mb) ; [M]) |
> > > 	([M] ; fencerel(Before-atomic) ; [RMW] ; po? ; [M]) |
> > > 	([M] ; po? ; [RMW] ; fencerel(After-atomic) ; [M]) |
> > > 	([M] ; po? ; [LKW] ; fencerel(After-spinlock) ; [M]) |
> > > - 	([M] ; po ; [UL] ; (co | po) ; [LKW] ;
> > > -		fencerel(After-unlock-lock) ; [M])
> > >   let gp = po ; [Sync-rcu | Sync-srcu] ; po?
> > >   let strong-fence = mb | gp
> > > +  let strong-sync = strong-fence | ([M] ; po ; [UL] ; (co | po) ; [LKW] ;
> > > +		fencerel(After-unlock-lock) ; [M])
> > > ...
> > >   let ppo = to-r | to-w | (... | strong-fence | ...) | 
> > > (po-unlock-lock-po & int)
> > > 
> > > and then use strong-sync instead of strong-fence everywhere else, e.g.
> > > - let pb = prop ; strong-fence ; hb* ; [Marked]
> > > + let pb = prop ; strong-sync ; hb* ; [Marked]
> > > and similarly where strong-fence is being redefined and used in various later lines.
> > > (In general I would prefer renaming also other *-fence relations into *-sync when they include edges between threads).
> > > The definition of strong-sync could also be slightly simplified to 
> > >   let strong-sync = strong-fence | ([M]; po-unlock-lock-po ; 
> > > [After-unlock-lock] ; po ; [M]) which is kind of pretty because the after-unlock-lock is now after po-unlock-lock-po.
> > > 
> > > What do you think?
> 
> > That all sounds good to me.  However, I wonder if it might be better to use "strong-order" (and similar) for the new relation name instead of "strong-sync".  The idea being that fences are about ordering, not (or not directly) about synchronization.
> 
> I think that is indeed better, thanks. I suppose *-sync might be more appropriate if it *only* included edges between threads.

There are quite a few ways to group the relations.  As long as we
don't end up oscillating back and forth with too short a frequency,
I am good.  ;-)

> I'll wait a few days for other suggestions and then prepare a patch.

Looking forward to seeing what you come up with!

							Thanx, Paul
