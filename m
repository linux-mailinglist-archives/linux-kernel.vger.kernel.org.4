Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB8867EB8D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 17:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233476AbjA0QvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 11:51:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjA0QvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 11:51:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E07B7BE76
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 08:51:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F07E61D19
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 16:51:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFA81C4339B;
        Fri, 27 Jan 2023 16:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674838260;
        bh=y9nk2iJEkaZrKqmP6NCJwp21crY3EzZu1exBJV93rAU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=KmAUW7IEFCSj1FcHMNu7MiacPkQTEbw9G9N6CjYcFrLJrFAPy1Dt1WIT46He/pzKj
         gAt3did9hVTQGYay8XHx0pMT3Z2Q3duSPqfCmstOcI9mouu2Sg/T65sH+WeGd/q0eb
         gO0ombliRk9ljqIRcZrt6JQjPDoN/bVZKQGi+k6wOReUcmfQJQno1mGbAXNleSvl5G
         VhFF+XWxVZ4BeTpiQ0VdF2imceRhonDOzyZ+JC7hvMYtNR1vofpAz0Gx5Mqd+WMQPU
         T7wM65CHbccSaYuM0Q7uG0xhFGxjoFZakQQDA0/Nq/xb2Wgp9y9VlalJ4Kabd7WGwr
         I23bOVryxnt2Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 8686A5C0510; Fri, 27 Jan 2023 08:50:59 -0800 (PST)
Date:   Fri, 27 Jan 2023 08:50:59 -0800
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
Message-ID: <20230127165059.GV2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <Y9F+SyLpxHwdK0rE@rowland.harvard.edu>
 <20230125194651.GN2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9GVFkVRRRs5/rBd@rowland.harvard.edu>
 <20230125213832.GQ2948950@paulmck-ThinkPad-P17-Gen-1>
 <20230125233308.GA1552266@paulmck-ThinkPad-P17-Gen-1>
 <Y9HbSBLrNJ9O2ad6@rowland.harvard.edu>
 <20230126015330.GX2948950@paulmck-ThinkPad-P17-Gen-1>
 <0ef2e974-5c3a-6195-62d5-a4c436bd7d82@huaweicloud.com>
 <20230126184802.GF2948950@paulmck-ThinkPad-P17-Gen-1>
 <c94ad1d4-c7ac-4570-6f33-85656b041090@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c94ad1d4-c7ac-4570-6f33-85656b041090@huaweicloud.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 04:03:16PM +0100, Jonas Oberhauser wrote:
> 
> 
> On 1/26/2023 7:48 PM, Paul E. McKenney wrote:
> > On Thu, Jan 26, 2023 at 01:17:49PM +0100, Jonas Oberhauser wrote:
> > > [...]
> > > Note that this interpretation is analogous to the promise of smp_mb__after_unlock_lock(), which says that an
> > > UNLOCK+LOCK pair act as a full fence: here the read-side unlock+gp act as a
> > > full memory barrier.
> > Good point that the existing smp_mb__after_unlock_lock() can be used for
> > any use cases relying on the more literal interpretation of this promise.
> > We already have the work-around!  ;-)
> 
> Can it? I meant that the less-literal form is similar to the one given by
> smp_mb__after_unlock_lock().
> 
> > > [...] I suppose you might be able to write
> > > some absurd client that inspects every store of the reader thread and sees
> > > that there is no line in the reader side code that acts like a full fence.
> > > But it would take a lot of effort to discern this.
> > The usual litmus test is shown at the end of this email [...]
> > > [...] I hope few people would have this unhealthy idea. But you
> > > never know.
> > Given that the more literal interpretation is not unreasonable, we should
> > assume that someone somewhere might have interpreted it that way.
> > 
> > But I agree that the odds of someone actually relying on this are low,
> > and any such use case can be fixed with smp_mb__before_srcu_read_unlock(),
> > similar to smp_mb__after_srcu_read_unlock() that you note is already in use.
> > 
> > It would still be good to scan SRCU use for this sort of pattern, maybe
> > manually, maybe via something like coccinelle.  Alternatively, I could
> > post on my blog (with right of first refusal to LWN and you guys as
> > co-authors) telling the community of our intent to change this and see
> > what people say.  Probably both rather than either/or.
> > 
> > Thoughts?
> 
> My first thought is "there is a 'usual' litmus test for this?" :D
> But yes, the test you have given has at least the same structure as what I
> would expect.

Exactly!  ;-)

> Communicating this with the community sounds very reasonable.
> 
> For some automated combing, I'm really not sure what pattern to look for.
> I'm afraid someone with a lot of time might have to look (semi-)manually.

Please continue giving it some thought.  The number of srcu_read_unlock()
calls in v6.1 is about 250, which is within the realm of manual
inspection, but it is all too easy to miss something.

							Thanx, Paul

> Best wishes, jonas
> 
> 
> > 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > C C-srcu-observed-6
> > 
> > (*
> >   * Result: Sometimes
> >   *
> >   * The result is Never if any of the smp_mb() calls is uncommented.
> >   *)
> > 
> > {}
> > 
> > P0(int *a, int *b, int *c, int *d, struct srcu_struct *s)
> > {
> > 	int r1;
> > 	int r2;
> > 	int r3;
> > 	int r4;
> > 
> > 	r1 = srcu_read_lock(s);
> > 	WRITE_ONCE(*b, 2);
> > 	r2 = READ_ONCE(*a);
> > 	// smp_mb();
> > 	srcu_read_unlock(s, r1);
> > 	// smp_mb();
> > 	r3 = READ_ONCE(*c);
> > 	// smp_mb();
> > 	r4 = READ_ONCE(*d);
> > }
> > 
> > P1(int *a, int *b, int *c, int *d, struct srcu_struct *s)
> > {
> > 	WRITE_ONCE(*b, 1);
> > 	synchronize_srcu(s);
> > 	WRITE_ONCE(*c, 1);
> > }
> > 
> > P2(int *a, int *b, int *c, int *d, struct srcu_struct *s)
> > {
> > 	WRITE_ONCE(*d, 1);
> > 	smp_mb();
> > 	WRITE_ONCE(*a, 1);
> > }
> > 
> > exists (0:r2=1 /\ 0:r3=1 /\ 0:r4=0 /\ b=1)
> 
