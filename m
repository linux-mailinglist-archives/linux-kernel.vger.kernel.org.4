Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D285678F26
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 05:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbjAXEGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 23:06:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjAXEGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 23:06:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154773867A
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 20:06:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BD935B80EA4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 04:06:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60D57C433D2;
        Tue, 24 Jan 2023 04:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674533171;
        bh=0sM2zWtq17Hv0WDTUhEINYOhViTEbSwTPTvyp4y1k1I=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=qAT7LOPlKjK2isSJ3Alex6rDPPdLFlLbVYi8Yf592JOkvSKUb2cQzyLCDI0I0DCUS
         VU8TPYBlSg8eZCZAD/jnj8//Qm8bekpf4cSVnUpZG3lXMhGJcjv6q0HS/VjosdTG8D
         YAOkxdVaBE8kBrpFpSmHmPCgpzl0RhSM1jGEeOl1IBWjvp+XCWcdPrFXc71nZDjBPy
         55rqXSjcSWSA2GSRQYdhOHNXoNpR6/HdC9+h8y0+OPp+tBlSPBUAdpBJHzr13lnjGt
         QO6E4vHpinU6yQ2n3FvsUpH314JwiW5rAqZQoWq+wuNZT84Z6ooMWZfTnOXiFGW3Af
         NYxMO6hpwu/2A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 07EE55C10AF; Mon, 23 Jan 2023 20:06:11 -0800 (PST)
Date:   Mon, 23 Jan 2023 20:06:11 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Andrea Parri <parri.andrea@gmail.com>,
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
Message-ID: <20230124040611.GD2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230119000214.GM2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8q6v3BZ8dlyoTxo@rowland.harvard.edu>
 <20230120175804.GN2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8rff3HJ2o9wUyGT@rowland.harvard.edu>
 <20230120192032.GR2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8r7SBdfuZX/y1cd@rowland.harvard.edu>
 <20230120212037.GW2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y82dWEW4RwclDTGM@rowland.harvard.edu>
 <20230123201659.GA3754540@paulmck-ThinkPad-P17-Gen-1>
 <Y88/5ib7zYl67mcE@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y88/5ib7zYl67mcE@rowland.harvard.edu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 09:18:14PM -0500, Alan Stern wrote:
> On Mon, Jan 23, 2023 at 12:16:59PM -0800, Paul E. McKenney wrote:
> > One twist is that the design of both SRCU and RCU are stronger than LKMM
> > requires, as illustrated by the litmus test at the end of this email.
> > 
> > I believe that your proof outline above also covers this case, but I
> > figure that I should ask.
> 
> This test is full of typos, and I guess that one of them seriously 
> affects the meaning, because as far as I can tell the corrected test is 
> allowed.
> 
> > C C-srcu-observed-2
> > 
> > (*
> >  * Result: Sometimes
> >  *
> >  * But please note that the Linux-kernel SRCU implementation is designed
> >  * to provide Never.
> >  *)
> > 
> > {}
> > 
> > P0(int *x, int *y, int *z, struct srcu_struct *s)
> > {
> > 	int r1;
> > 	int r2;
> 
> r2 is never used.
> 
> > 
> > 	r1 = srcu_read_lock(s);
> > 	WRITE_ONCE(*y, 1);
> > 	WRITE_ONCE(*x, 1);
> > 	srcu_read_unlock(s, r3);
> 
> There is no r3; this should be r1.
> 
> > }
> > 
> > P1(int *x, int *y, int *z, struct srcu_struct *s)
> > {
> > 	int r1;
> > 	int r2;
> 
> r2 is never used.
> 
> > 
> > 	r1 = READ_ONCE(*y);
> > 	synchronize_srcu(s);
> > 	WRITE_ONCE(*z, 1);
> > }
> > 
> > P2(int *x, int *y, int *z, struct srcu_struct *s)
> > {
> > 	int r1;
> 
> r1 is never used; it should be r2.
> 
> > 
> > 	WRITE_ONCE(*z, 2);
> > 	smp_mb();
> > 	r2 = READ_ONCE(*x);
> > }
> > 
> > exists (1:r1=1 /\ 1:r2=0 /\ z=1)
> 
> 1:r2 is never used.  Apparently this should 2:r2.
> 
> Given those changes, the test can run as follows: P2 runs to completion, 
> writing z=2 and reading x=0.  Then P0 runs to completion, writing y=1 
> and x=1.  Then P1 runs to completion, reading y=1 and overwriting z=1.

All that and I also messed up by not having "z=2".  :-/

Thank you for looking it over!

But the following one is forbidden, the Result comment below
notwithstanding.  I could have sworn that there was some post-grace-period
write-to-write litmus test that LKMM allowed, but if so, this one is
not it.

------------------------------------------------------------------------

C C-srcu-observed-2

(*
 * Result: Sometimes
 *
 * But please note that the Linux-kernel SRCU implementation is designed
 * to provide Never.
 *)

{}

P0(int *x, int *y, int *z, struct srcu_struct *s)
{
	int r1;

	r1 = srcu_read_lock(s);
	WRITE_ONCE(*y, 1);
	WRITE_ONCE(*x, 1);
	srcu_read_unlock(s, r1);
}

P1(int *x, int *y, int *z, struct srcu_struct *s)
{
	int r1;

	r1 = READ_ONCE(*y);
	synchronize_srcu(s);
	WRITE_ONCE(*z, 1);
}

P2(int *x, int *y, int *z, struct srcu_struct *s)
{
	int r1;

	WRITE_ONCE(*z, 2);
	smp_mb();
	r1 = READ_ONCE(*x);
}

exists (1:r1=1 /\ 2:r1=0 /\ z=2)

------------------------------------------------------------------------

There is the one below, but I am (1) not sure that I have it right,
(2) not immediately certain that the Linux-kernel implementation would
forbid it, (3) not immediately sure that it should be forbidden.

In the meantime, thoughts?

							Thanx, Paul

------------------------------------------------------------------------

C C-srcu-observed-3

(*
 * Result: Sometimes
 *)

{}

P0(int *x, int *y, int *z, struct srcu_struct *s)
{
	int r1;

	r1 = srcu_read_lock(s);
	WRITE_ONCE(*y, 1);
	WRITE_ONCE(*x, 1);
	srcu_read_unlock(s, r1);
}

P1(int *x, int *y, int *z, struct srcu_struct *s)
{
	int r1;

	r1 = READ_ONCE(*y);
	synchronize_srcu(s);
	WRITE_ONCE(*z, 1);
}

P2(int *x, int *y, int *z, struct srcu_struct *s)
{
	WRITE_ONCE(*z, 2);
	smp_mb();
	WRITE_ONCE(*x, 2);
}

exists (1:r1=1 /\ x=2 /\ z=2)
