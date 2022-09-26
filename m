Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBDB05EB4A1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 00:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiIZWh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 18:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiIZWhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 18:37:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF929DDBA;
        Mon, 26 Sep 2022 15:37:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0900F614AE;
        Mon, 26 Sep 2022 22:37:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EDDBC433D6;
        Mon, 26 Sep 2022 22:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664231871;
        bh=UqAGlAPgSj+vPa+1UMJOfjVNvikYlQmhZBErjn3S/Gc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=CMLS3nz4TQJGgKQdmAkMDs+Mh5Vfwz1Fu+OOCrL7iYskLe58rAVd9GtInuwUJSdym
         M5+yzOILyngzmNBMP/E73zTLnEwkM3mFEhJ0Rs0jaqTWbUj268FMbg2kPXyAv9caS5
         9a5mhrw5j10z0oZLAv1cYoVpqL4cMu8DtP075jQ8/bHCFawdUisiqhHZSJtikzEpSv
         IAkgsFg18OgD61yE0y0apiC32ZXSKYdOsn7mw7GGpZjDsue8NSwRpSkmCdynwuptCt
         PWZ9tozHd7evnTdX3kBeTcRVDGd87ZW7HRTd/7hh4DnE+/JWpo93LcEqg7hWGXAN/J
         Q/SabX5B9d6iQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 08DD75C05B1; Mon, 26 Sep 2022 15:37:51 -0700 (PDT)
Date:   Mon, 26 Sep 2022 15:37:51 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH v6 1/4] rcu: Make call_rcu() lazy to save power
Message-ID: <20220926223751.GZ4196@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220923214408.GC4196@paulmck-ThinkPad-P17-Gen-1>
 <4AE2CA06-8D91-42D7-9EE5-0C99BA7F9D13@joelfernandes.org>
 <20220924211132.GE4196@paulmck-ThinkPad-P17-Gen-1>
 <YzCQYW6yRRBWWMXk@google.com>
 <20220926174240.GO4196@paulmck-ThinkPad-P17-Gen-1>
 <YzIUgAMOPg+jBKsp@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YzIUgAMOPg+jBKsp@google.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 09:07:12PM +0000, Joel Fernandes wrote:
> Hi Paul,
> 
> On Mon, Sep 26, 2022 at 10:42:40AM -0700, Paul E. McKenney wrote:
> [..]
> > > > > >> +        WRITE_ONCE(rdp->lazy_len, 0);
> > > > > >> +    } else {
> > > > > >> +        rcu_cblist_flush_enqueue(&rcl, &rdp->nocb_bypass, rhp);
> > > > > >> +        WRITE_ONCE(rdp->lazy_len, 0);
> > > > > > 
> > > > > > This WRITE_ONCE() can be dropped out of the "if" statement, correct?
> > > > > 
> > > > > Yes will update.
> > > > 
> > > > Thank you!
> > > > 
> > > > > > If so, this could be an "if" statement with two statements in its "then"
> > > > > > clause, no "else" clause, and two statements following the "if" statement.
> > > > > 
> > > > > I don’t think we can get rid of the else part but I’ll see what it looks like.
> > > > 
> > > > In the function header, s/rhp/rhp_in/, then:
> > > > 
> > > > 	struct rcu_head *rhp = rhp_in;
> > > > 
> > > > And then:
> > > > 
> > > > 	if (lazy && rhp) {
> > > > 		rcu_cblist_enqueue(&rdp->nocb_bypass, rhp);
> > > > 		rhp = NULL;
> > > 
> > > This enqueues on to the bypass list, where as if lazy && rhp, I want to queue
> > > the new rhp on to the main cblist. So the pseudo code in my patch is:
> > > 
> > > if (lazy and rhp) then
> > > 	1. flush bypass CBs on to main list.
> > > 	2. queue new CB on to main list.
> > 
> > And the difference is here, correct?  I enqueue to the bypass list,
> > which is then flushed (in order) to the main list.  In contrast, you
> > flush the bypass list, then enqueue to the main list.  Either way,
> > the callback referenced by rhp ends up at the end of ->cblist.
> > 
> > Or am I on the wrong branch of this "if" statement?
> 
> But we have to flush first, and then queue the new one. Otherwise wouldn't
> the callbacks be invoked out of order? Or did I miss something?

I don't think so...

We want the new callback to be last, right?  One way to do that is to
flush the bypass, then queue the new callback onto ->cblist.  Another way
to do that is to enqueue the new callback onto the end of the bypass,
then flush the bypass.  Why wouldn't these result in the same order?

> > > else
> > > 	1. flush bypass CBs on to main list
> > > 	2. queue new CB on to bypass list.
> > > 
> > > > 	}
> > > > 	rcu_cblist_flush_enqueue(&rcl, &rdp->nocb_bypass, rhp);
> > > > 	WRITE_ONCE(rdp->lazy_len, 0);
> > > > 
> > > > Or did I mess something up?
> > > 
> > > So the rcu_cblist_flush_enqueue() has to happen before the
> > > rcu_cblist_enqueue() to preserve the ordering of flushing into the main list,
> > > and queuing on to the main list for the "if". Where as in your snip, the
> > > order is reversed.
> > 
> > Did I pick the correct branch of the "if" statement above?  Or were you
> > instead talking about the "else" clause?
> > 
> > I would have been more worried about getting cblist->len right.
> 
> Hmm, I think my concern was more the ordering of callbacks, and moving the
> write to length should be Ok.

OK, sounds good to me!  ;-)

> > > If I consolidate it then, it looks like the following. However, it is a bit
> > > more unreadable. I could instead just take the WRITE_ONCE out of both if/else
> > > and move it to after the if/else, that would be cleanest. Does that sound
> > > good to you? Thanks!
> > 
> > Let's first figure out whether or not we are talking past one another.  ;-)
> 
> Haha yeah :-)

So were we?  ;-)

							Thanx, Paul
