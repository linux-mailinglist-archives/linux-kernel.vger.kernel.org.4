Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB85667627B
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 01:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjAUAel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 19:34:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjAUAej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 19:34:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2A02115
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 16:34:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59D2A620E3
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 00:34:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5CEFC433EF;
        Sat, 21 Jan 2023 00:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674261277;
        bh=GKPF/KGxBEcGAXCcG9cNchv/GG0zLrZwptY+F/G+TAw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ix6xX/9YoKQYV8on68SZFxdIWGcHu8b69tRyxUZf6b0UcTQDbAkHYG0WO+gyaVmo7
         KIkNB1mu/PaG9/NznZETyv0/ImoqKXwvQzTGS0RbsY33mLmNAhQYY+4EBS96LYjzoI
         FcO9i/6MXjCg5TaYwaPJ23zmCLJJhI4zvjj4newdgj2d16KVKEremP4NioZUtIcLHb
         5x1tomRTX2/BXyT8Wks27VXvAod2y67s4jHbSQdcEaqZaFQ2ocaBdKh9jRFbE3e4me
         42U2zYQvbA14cH59JU22JcEJCxOnsDuAryvVttu9U8GmVVvj1bZC9dmvujt+0z8LOn
         2p578XbPkhGQg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 476F15C0543; Fri, 20 Jan 2023 16:34:37 -0800 (PST)
Date:   Fri, 20 Jan 2023 16:34:37 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>, will <will@kernel.org>,
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
Message-ID: <20230121003437.GB2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230119184107.GT2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8mfWTX7V69pAwo8@rowland.harvard.edu>
 <20230119215304.GA2948950@paulmck-ThinkPad-P17-Gen-1>
 <c5902c18-e0cc-125e-c2f5-7971f0a7ce07@huaweicloud.com>
 <20230120153909.GF2948950@paulmck-ThinkPad-P17-Gen-1>
 <cc3686b3-b234-b0ee-4d2d-15f54da4331b@huaweicloud.com>
 <20230120213727.GX2948950@paulmck-ThinkPad-P17-Gen-1>
 <44a2c301-900e-90ea-4b21-e5264102e699@huaweicloud.com>
 <20230120231952.GZ2948950@paulmck-ThinkPad-P17-Gen-1>
 <736020be-de00-3cd8-2325-c3efb87e03b6@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <736020be-de00-3cd8-2325-c3efb87e03b6@huaweicloud.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 21, 2023 at 01:03:50AM +0100, Jonas Oberhauser wrote:
> 
> 
> On 1/21/2023 12:19 AM, Paul E. McKenney wrote:
> > On Fri, Jan 20, 2023 at 11:36:15PM +0100, Jonas Oberhauser wrote:
> > > 
> > > On 1/20/2023 10:37 PM, Paul E. McKenney wrote:
> > > > Just out of curiosity, are you [set] up to run LKMM locally at your end?
> > > I don't know what exactly that means. I generally run it on wetware.
> > > But I sometimes ask Hernan to run Dat3M (on his machine) over all the litmus
> > > tests in your repo to spot any obvious problems with variations I consider.
> > > I don't think Dat3M is feature-complete with herd at the moment, just
> > > unbelievably faster. For example I think it ignores all flags in the cat
> > > files.
> > > Oh, I just remembered that I also installed herd7 recently to make sure that
> > > any patches I might send in satisfy herd7 syntax requirements (I think you
> > > called this diagnostic driven development?), but I haven't used it to really
> > > run anything.
> > > 
> > > Is it too obvious that my words usually aren't backed by cold machine logic?
> > Well, there was this in one of your messages from earlier today: "I'm not
> > going to get it right today, am I?"  And I freely confess that this led
> > me to suspect that you might not have been availing yourself of herd7's
> > opinion before posting.  ;-)
> The main reason I might usually not consult herd7's opinion is that it often
> takes a while to write a test case in a way herd7 accepts and treats as
> intended, but then even so the fact that some tests pass may just give some
> false confidence when some tricky case is being missed.
> So I find the investment/increased confidence ratio to not yet be at the
> right point to do this when communicating somewhat informally on the mailing
> list, which is already taking quite a bit of my time (but at least I'm
> learning a lot during that time about stuff like RCU/SRCU, history of LKMM,
> etc.).
> If I need to be more confident I'll use herd7 to make sure the syntax is
> correct and as a sanity check, and some paper or Coq proofs to be confident
> in the logic.
> 
> If you feel that I'm wasting the lists' time too much by making these kind
> of mistakes, let me know and I'll reconsider.

Not a goal of mine, actually.

The only thing that I will add is that I cheat horribly by creating new
litmus tests by existing ones.  ;-)

							Thanx, Paul
