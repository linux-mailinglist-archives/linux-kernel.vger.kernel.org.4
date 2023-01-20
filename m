Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 260DA6758E2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 16:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbjATPjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 10:39:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbjATPj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 10:39:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7EECD230
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 07:39:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5704261FCB
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 15:39:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3426C433D2;
        Fri, 20 Jan 2023 15:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674229149;
        bh=35pOKRd8qD+HeafWSMGR6evjgCaHzeVFUQd9TUQ9uVg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Gjt/vu8h2cuy7OlfTOaVTCCzCEYx4egCAF/yQUkzi1DfRtusMJqZnewYicXqICipr
         bWLwMLFf6oXZ1/EBwewa9hufwLcSOt+PbotGyMDJD7/YGsHLkaAIZkxeQDZbj3+v6A
         2jCWT7VJO6huZSspIQbzNcA2k2E2T2k6SZo8y6654C/kahgYAoSr32e34Mtda/dWDn
         1Ah2iWnUuJrd2bB3O6erFoePPVe9T8cfoyW5jVrG9nMSkDhbC6LG9jalQOhHm85PvG
         06pKKPprlLzKs1C53FIbD6ZGG6nzNIrZ8NCZAh/15/8lUNg7MHM+As0qLy7PMkZyh4
         GjgEodxKjQATQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 469C75C0DFC; Fri, 20 Jan 2023 07:39:09 -0800 (PST)
Date:   Fri, 20 Jan 2023 07:39:09 -0800
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
Message-ID: <20230120153909.GF2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230118201918.GI2948950@paulmck-ThinkPad-P17-Gen-1>
 <a5637181-1675-7973-489c-e5d24cbd25c2@huaweicloud.com>
 <20230118211201.GL2948950@paulmck-ThinkPad-P17-Gen-1>
 <09f084d2-6128-7f83-b2a5-cbe236b1678d@huaweicloud.com>
 <20230119001147.GN2948950@paulmck-ThinkPad-P17-Gen-1>
 <0fae983b-2a7c-d44e-8881-53d5cc053f09@huaweicloud.com>
 <20230119184107.GT2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8mfWTX7V69pAwo8@rowland.harvard.edu>
 <20230119215304.GA2948950@paulmck-ThinkPad-P17-Gen-1>
 <c5902c18-e0cc-125e-c2f5-7971f0a7ce07@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5902c18-e0cc-125e-c2f5-7971f0a7ce07@huaweicloud.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 10:43:10AM +0100, Jonas Oberhauser wrote:
> 
> 
> On 1/19/2023 10:53 PM, Paul E. McKenney wrote:
> > On Thu, Jan 19, 2023 at 02:51:53PM -0500, Alan Stern wrote:
> > > On Thu, Jan 19, 2023 at 10:41:07AM -0800, Paul E. McKenney wrote:
> > > > In contrast, this actually needs srcu_down_read() and srcu_up_read():
> > > > 
> > > > ------------------------------------------------------------------------
> > > > 
> > > > C C-srcu-nest-6
> > > > 
> > > > (*
> > > >   * Result: Never
> > > >   *
> > > >   * Flag unbalanced-srcu-locking
> > > >   * This would be valid for srcu_down_read() and srcu_up_read().
> > > >   *)
> > > > 
> > > > {}
> > > > 
> > > > P0(int *x, int *y, struct srcu_struct *s1, int *idx)
> > > > {
> > > > 	int r2;
> > > > 	int r3;
> > > > 
> > > > 	r3 = srcu_down_read(s1);
> > > > 	WRITE_ONCE(*idx, r3);
> > > > 	r2 = READ_ONCE(*y);
> > > > }
> > > > 
> > > > P1(int *x, int *y, struct srcu_struct *s1, int *idx)
> > > > {
> > > > 	int r1;
> > > > 	int r3;
> > > > 
> > > > 	r1 = READ_ONCE(*x);
> > > > 	r3 = READ_ONCE(*idx);
> > > > 	srcu_up_read(s1, r3);
> > > > }
> > > > 
> > > > P2(int *x, int *y, struct srcu_struct *s1)
> > > > {
> > > > 	WRITE_ONCE(*y, 1);
> > > > 	synchronize_srcu(s1);
> > > > 	WRITE_ONCE(*x, 1);
> > > > }
> > > > 
> > > > locations [0:r1]
> > > > exists (1:r1=1 /\ 0:r2=0)
> > > I modified this litmus test by adding a flag variable with an
> > > smp_store_release in P0, an smp_load_acquire in P1, and a filter clause
> > > to ensure that P1 reads the flag and idx from P1.
> 
> This sounds like good style.
> I suppose this is already flagged as mismatched srcu_unlock(), in case you
> accidentally read from the initial write?

It might, except that a filter clause excludes this case.  Here is the
updated test:

C C-srcu-nest-6

(*
 * Result: Never
 *
 * This would be valid for srcu_down_read() and srcu_up_read().
 *)

{}

P0(int *x, int *y, struct srcu_struct *s1, int *idx, int *f)
{
	int r2;
	int r3;

	r3 = srcu_down_read(s1);
	WRITE_ONCE(*idx, r3);
	r2 = READ_ONCE(*y);
	smp_store_release(f, 1);
}

P1(int *x, int *y, struct srcu_struct *s1, int *idx, int *f)
{
	int r1;
	int r3;
	int r4;

	r4 = smp_load_acquire(f);
	r1 = READ_ONCE(*x);
	r3 = READ_ONCE(*idx);
	srcu_up_read(s1, r3);
}

P2(int *x, int *y, struct srcu_struct *s1)
{
	WRITE_ONCE(*y, 1);
	synchronize_srcu(s1);
	WRITE_ONCE(*x, 1);
}

locations [0:r1]
filter (1:r4=1)
exists (1:r1=1 /\ 0:r2=0)

> > > It turns out that the idea of removing rf edges from Srcu-unlock events
> > > doesn't work well.  The missing edges mess up herd's calculation of the
> > > fr relation and the coherence axiom.  So I've gone back to filtering
> > > those edges out of carry-dep.
> > > 
> > > Also, Boqun's suggestion for flagging ordinary accesses to SRCU
> > > structures no longer works, because the lock and unlock operations now
> > > _are_ normal accesses.  I removed that check too, but it shouldn't hurt
> > > much because I don't expect to encounter litmus tests that try to read
> > > or write srcu_structs directly.
> > Agreed.  I for one would definitely have something to say about an
> > SRCU-usage patch that directly manipulated a srcu_struct structure!  ;-)
> 
> Wouldn't the point of having it being flagged be that herd (or similar
> tools) would be having something to say long before it has to reach your
> pair of eyes?

That would of course be even better.

> I don't think Boqun's patch is hard to repair.
> Besides the issue you mention, I think it's also missing Sync-srcu, which
> seems to be linked by loc based on its first argument.
> 
> How about something like this?
> 
> let ALL-LOCKS = LKR | LKW | UL | LF | RU | Srcu-lock | Srcu-unlock |
> Sync-srcu   flag ~empty ~[ALL_LOCKS | IW] ; loc ; [ALL-LOCKS] as
> mixed-lock-accesses
> 
> If you're using something that isn't a lock or intial write on the same location as a lock, you get the flag.

Wouldn't that unconditionally complain about the first srcu_read_lock()
in a given process?  Or am I misreading those statements?

							Thanx, Paul
