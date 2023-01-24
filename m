Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6DE3679E83
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 17:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233933AbjAXQXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 11:23:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234315AbjAXQXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 11:23:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64E711657
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 08:22:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71E6F612D8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 16:22:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBBCBC433D2;
        Tue, 24 Jan 2023 16:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674577373;
        bh=ES8KdFjesOfmcXYfcZJrLe0xXaIMzQ+tdZf5M8VYliw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=CASL0yX6rLSupHCsv5WHkPMurFzqvYlga/g0HD6vGp8/6/X4Kqcud2+FE5aAonLz9
         oxz2kHxmlUK+Zbq8FT4oAFqJnh5kUSwQo5Ep7sMHVdqI5OSJbqcv1itFQHqk5Nt8on
         dAnR1/go0oW7YqH0vnI4xHY538XNfKPufMBX1KscJRNNPB9EmsQ6FGZwwLy2cgaadl
         iSMqVYgkAkvpc+z4f6E48WeQlZm5faTi++xqG3Y6b97LGpcAkWu56Lu6PNkQGsCOpc
         GTeYk6YOgsV/ilwXOp8Y8+rtDKYSb/ej6awQOJ63Y2IN9hRu9GjUljQ9Bk10O7XMz4
         l6E7L9l4Y145w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 562055C06D0; Tue, 24 Jan 2023 08:22:53 -0800 (PST)
Date:   Tue, 24 Jan 2023 08:22:53 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc:     Andrea Parri <parri.andrea@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
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
Message-ID: <20230124162253.GL2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230120192032.GR2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8r7SBdfuZX/y1cd@rowland.harvard.edu>
 <20230120212037.GW2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y82dWEW4RwclDTGM@rowland.harvard.edu>
 <20230123201659.GA3754540@paulmck-ThinkPad-P17-Gen-1>
 <Y88/5ib7zYl67mcE@rowland.harvard.edu>
 <20230124040611.GD2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8+8fH52iqQABYs2@andrea>
 <20230124145423.GI2948950@paulmck-ThinkPad-P17-Gen-1>
 <8cc799ab-ffa1-47f7-6e1d-97488a210f14@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8cc799ab-ffa1-47f7-6e1d-97488a210f14@huaweicloud.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 04:11:14PM +0100, Jonas Oberhauser wrote:
> 
> 
> On 1/24/2023 3:54 PM, Paul E. McKenney wrote:
> > On Tue, Jan 24, 2023 at 12:09:48PM +0100, Andrea Parri wrote:
> > > > There is the one below, but I am (1) not sure that I have it right,
> > > > (2) not immediately certain that the Linux-kernel implementation would
> > > > forbid it, (3) not immediately sure that it should be forbidden.
> > > > 
> > > > In the meantime, thoughts?
> > > As it stands, P0 to completion, then P1 to completion, then P2 to
> > > completion should meet the "exists" clause; I guess we want "x=1"
> > > in the clause (or the values of the stores to "x" exchanged).
> > OK, so I still don't have it right.  ;-)
> > 
> > Make that x=1.  I think.
> > 
> 
> If it is x=1, why doesn't LKMM forbid it?
> Because T1:y=1 is read by T1 before the GP, the whole CS is before the GP,
> i.e.,
> 
> srcu_read_unlock(s, r1);  ->rcu-order synchronize_srcu(s);
> 
> The GP is furthermore po;prop;strong-fence;prop;po ordered before the
> unlock, which you can shuffle around to get
>    Wx=2  ->prop;po;rcu-order;po ;  prop;strong-fence  Wx=2
> or
>    Wx=2  ->rb  Wx=2
> which is forbidden because rb is irreflexive.
> 
> Right?

Yes according to herd7, hence the "I think".  I clearly recall some
store-based lack of ordering after a grace period from some years back,
and am thus far failing to reproduce it.

And here is another attempt that herd7 actually does allow.

So what did I mess up this time?  ;-)

							Thanx, Paul

------------------------------------------------------------------------

C C-srcu-observed-4

(*
 * Result: Sometimes
 *
 * The Linux-kernel implementation is suspected to forbid this.
 *)

{}

P0(int *x, int *y, int *z, struct srcu_struct *s)
{
	int r1;

	r1 = srcu_read_lock(s);
	WRITE_ONCE(*y, 2);
	WRITE_ONCE(*x, 1);
	srcu_read_unlock(s, r1);
}

P1(int *x, int *y, int *z, struct srcu_struct *s)
{
	int r1;

	WRITE_ONCE(*y, 1);
	synchronize_srcu(s);
	WRITE_ONCE(*z, 2);
}

P2(int *x, int *y, int *z, struct srcu_struct *s)
{
	WRITE_ONCE(*z, 1);
	smp_store_release(x, 2);
}

exists (x=1 /\ y=1 /\ z=1)
