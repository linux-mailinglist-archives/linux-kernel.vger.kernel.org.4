Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE459679CA0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 15:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235136AbjAXOya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 09:54:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235126AbjAXOy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 09:54:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7726F11E9F
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 06:54:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E7281B811EF
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 14:54:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C822C433EF;
        Tue, 24 Jan 2023 14:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674572063;
        bh=Sr5meo9TgQmim3r0F5vrbF3YNLCRZeuZLIUwBZFKoEk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ucVR36Bw8davkHaqNt1Vd/jeNEnKGX3tj4ywxxM/Uxcyei26+RW/PzD2Kqa/fl2jb
         XSMTiOL/pswUb3p2kQAYBPqAlGrMRlT1k0UKWWc9OXukmjZnHgp3jmAUrGZPeMTiu8
         t09HMtJ9o6aBZX50ZDD6wUoSvczCXnc7y1mk6BtoRVmbccXHvsHHhzRBtgMHS8TZ+c
         A/d6oS7TtAiXUBrJFZTq2ayTdV9CaTrBp0Cmw9nq+8JRxviAmW2nPYhbd4kn2MAWAm
         W9pBHHHHkXMN4hG8hsaqFARnbccXroFdXDkubHETGS8xBdEBRT1YYw3pzcUK4rfikD
         IsQjpwANANv6Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3A4E25C0510; Tue, 24 Jan 2023 06:54:23 -0800 (PST)
Date:   Tue, 24 Jan 2023 06:54:23 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
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
Message-ID: <20230124145423.GI2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230120175804.GN2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8rff3HJ2o9wUyGT@rowland.harvard.edu>
 <20230120192032.GR2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8r7SBdfuZX/y1cd@rowland.harvard.edu>
 <20230120212037.GW2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y82dWEW4RwclDTGM@rowland.harvard.edu>
 <20230123201659.GA3754540@paulmck-ThinkPad-P17-Gen-1>
 <Y88/5ib7zYl67mcE@rowland.harvard.edu>
 <20230124040611.GD2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8+8fH52iqQABYs2@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8+8fH52iqQABYs2@andrea>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 12:09:48PM +0100, Andrea Parri wrote:
> > There is the one below, but I am (1) not sure that I have it right,
> > (2) not immediately certain that the Linux-kernel implementation would
> > forbid it, (3) not immediately sure that it should be forbidden.
> > 
> > In the meantime, thoughts?
> 
> As it stands, P0 to completion, then P1 to completion, then P2 to
> completion should meet the "exists" clause; I guess we want "x=1"
> in the clause (or the values of the stores to "x" exchanged).

OK, so I still don't have it right.  ;-)

Make that x=1.  I think.

							Thanx, Paul

>   Andrea
> 
> 
> > ------------------------------------------------------------------------
> > 
> > C C-srcu-observed-3
> > 
> > (*
> >  * Result: Sometimes
> >  *)
> > 
> > {}
> > 
> > P0(int *x, int *y, int *z, struct srcu_struct *s)
> > {
> > 	int r1;
> > 
> > 	r1 = srcu_read_lock(s);
> > 	WRITE_ONCE(*y, 1);
> > 	WRITE_ONCE(*x, 1);
> > 	srcu_read_unlock(s, r1);
> > }
> > 
> > P1(int *x, int *y, int *z, struct srcu_struct *s)
> > {
> > 	int r1;
> > 
> > 	r1 = READ_ONCE(*y);
> > 	synchronize_srcu(s);
> > 	WRITE_ONCE(*z, 1);
> > }
> > 
> > P2(int *x, int *y, int *z, struct srcu_struct *s)
> > {
> > 	WRITE_ONCE(*z, 2);
> > 	smp_mb();
> > 	WRITE_ONCE(*x, 2);
> > }
> > 
> > exists (1:r1=1 /\ x=2 /\ z=2)
