Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A77A67D498
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 19:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbjAZSsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 13:48:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjAZSsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 13:48:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983A2125A5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 10:48:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3519461901
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 18:48:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DFD0C433D2;
        Thu, 26 Jan 2023 18:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674758882;
        bh=pW8ZERtpOuxKyORi9y+30yojJ3g3B+kFFCQUSi8SeeM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=bUC4JwEoBY+fryGIMnY8zknzupxPZxhhmbseco+5pG3apB6liPJi1gqrlm+JUNe7k
         QxnGO0KqcCT4FyhAB+sx0KU+62iYzpZP2uSKUurkD6ewgoi/m2rNFWDhEENoMgCrhk
         YzufhHhSGuHtpzqCgyPPPqisKPlT0cGJ1bbZEjk7A1GvkBxhp4n0/5KQDfQFNab+s0
         vrvcJu13f51xQIV83yxXs3BM5hnUSP248BWvZjFeoKER8BO2Ix9ylLWCapx63Bc/Fx
         wZHmSfFiRzLtyDzO6cOmiBbMjc5E4grJihV3UonivOMvlsB4nUUK3pRtc9KdZgWGqI
         Zboe7f0NrAJ0A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 1551F5C0510; Thu, 26 Jan 2023 10:48:02 -0800 (PST)
Date:   Thu, 26 Jan 2023 10:48:02 -0800
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
Message-ID: <20230126184802.GF2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <Y9FMEATzv3gcTUe2@rowland.harvard.edu>
 <20230125171832.GH2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9F+SyLpxHwdK0rE@rowland.harvard.edu>
 <20230125194651.GN2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9GVFkVRRRs5/rBd@rowland.harvard.edu>
 <20230125213832.GQ2948950@paulmck-ThinkPad-P17-Gen-1>
 <20230125233308.GA1552266@paulmck-ThinkPad-P17-Gen-1>
 <Y9HbSBLrNJ9O2ad6@rowland.harvard.edu>
 <20230126015330.GX2948950@paulmck-ThinkPad-P17-Gen-1>
 <0ef2e974-5c3a-6195-62d5-a4c436bd7d82@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0ef2e974-5c3a-6195-62d5-a4c436bd7d82@huaweicloud.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 01:17:49PM +0100, Jonas Oberhauser wrote:
> 
> 
> On 1/26/2023 2:53 AM, Paul E. McKenney wrote:
> > On Wed, Jan 25, 2023 at 08:45:44PM -0500, Alan Stern wrote:
> > > On Wed, Jan 25, 2023 at 03:33:08PM -0800, Paul E. McKenney wrote:
> > > > Ah, and returning to the earlier question as to whether srcu_read_unlock()
> > > > can use release semantics instead of smp_mb(), at the very least, this
> > > > portion of the synchronize_srcu() function's header comment must change:
> > > > 
> > > > 	On systems with more than one CPU, when synchronize_srcu()
> > > > 	returns, each CPU is guaranteed to have executed a full
> > > > 	memory barrier since the end of its last corresponding SRCU
> > > > 	read-side critical section whose beginning preceded the call
> > > > 	to synchronize_srcu().
> > > 
> > > Of course, there might be code relying on a guarantee that
> > > srcu_read_unlock() executes a full memory barrier.  This guarantee would
> > > certainly no longer hold.  But as I understand it, this guarantee was
> > > never promised by the SRCU subsystem.
> > That indented sentence was copied from the synchronize_srcu() function's
> > header comment, which might be interpreted by some as a promise by the
> > SRCU subsystem.
> 
> I think we understand that it is a promise of the SRCU subsystem, the
> question is just what the promise is.
> As Alan said, if the promise is interpreted as something like
> 
> "every store that propagated to the read side critical section must have
> propagated to all CPUs before the  synchronize_srcu() ends" (where the RSCS
> and synchronize_srcu() calls are those from the promise)
> 
> then that guarantee holds even if you only use a release fence to
> communicate the end of the RSCS to the GP. Note that this interpretation is
> analogous to the promise of smp_mb__after_unlock_lock(), which says that an
> UNLOCK+LOCK pair act as a full fence: here the read-side unlock+gp act as a
> full memory barrier.

Good point that the existing smp_mb__after_unlock_lock() can be used for
any use cases relying on the more literal interpretation of this promise.
We already have the work-around!  ;-)

> On the other hand, if the promise is more literally interpreted as
> 
> "there is a (possibly virtual) instruction in the reader-side execution
> stream that acts as a full memory barrier, and that instruction is executed
> before the  synchronize_srcu() ends"
> 
> then that guarantee is violated, and I suppose you might be able to write
> some absurd client that inspects every store of the reader thread and sees
> that there is no line in the reader side code that acts like a full fence.
> But it would take a lot of effort to discern this.

The usual litmus test is shown at the end of this email.  If you remove
the "//" from any of those smp_mb() calls, the test is forbidden, but
with all of them commented out, it is allowed.  Which illustrates the
utility of smp_mb__after_unlock_lock().  It also shows that LKMM does
not model this guarantee from synchronize_srcu()'s comment header.
Which might be fine, actually.

Of course, I just now wrote this litmus test, so it should be viewed
with extreme suspicion.

> Perhaps someone interpreting the promise like this might however come to the
> conclusion that because the only part of the code that is actually under
> control of srcu, and hence the only code where that full barrier could be
> hidden, would be inside the srcu_unlock(), they might expect to always find
> this full barrier there and treat srcu_unlock() in general as a full
> barrier. Considering that the wording explicitly isn't "an srcu_unlock() is
> a full barrier", I hope few people would have this unhealthy idea. But you
> never know.

Given that the more literal interpretation is not unreasonable, we should
assume that someone somewhere might have interpreted it that way.

But I agree that the odds of someone actually relying on this are low,
and any such use case can be fixed with smp_mb__before_srcu_read_unlock(),
similar to smp_mb__after_srcu_read_unlock() that you note is already in use.

It would still be good to scan SRCU use for this sort of pattern, maybe
manually, maybe via something like coccinelle.  Alternatively, I could
post on my blog (with right of first refusal to LWN and you guys as
co-authors) telling the community of our intent to change this and see
what people say.  Probably both rather than either/or.

Thoughts?

							Thanx, Paul

------------------------------------------------------------------------

C C-srcu-observed-6

(*
 * Result: Sometimes
 *
 * The result is Never if any of the smp_mb() calls is uncommented.
 *)

{}

P0(int *a, int *b, int *c, int *d, struct srcu_struct *s)
{
	int r1;
	int r2;
	int r3;
	int r4;

	r1 = srcu_read_lock(s);
	WRITE_ONCE(*b, 2);
	r2 = READ_ONCE(*a);
	// smp_mb();
	srcu_read_unlock(s, r1);
	// smp_mb();
	r3 = READ_ONCE(*c);
	// smp_mb();
	r4 = READ_ONCE(*d);
}

P1(int *a, int *b, int *c, int *d, struct srcu_struct *s)
{
	WRITE_ONCE(*b, 1);
	synchronize_srcu(s);
	WRITE_ONCE(*c, 1);
}

P2(int *a, int *b, int *c, int *d, struct srcu_struct *s)
{
	WRITE_ONCE(*d, 1);
	smp_mb();
	WRITE_ONCE(*a, 1);
}

exists (0:r2=1 /\ 0:r3=1 /\ 0:r4=0 /\ b=1)
