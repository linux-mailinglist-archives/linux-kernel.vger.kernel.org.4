Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7442F67A01D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 18:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233479AbjAXR0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 12:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbjAXR0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 12:26:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E3749011
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 09:26:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 65805B81608
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 17:26:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBE82C433EF;
        Tue, 24 Jan 2023 17:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674581208;
        bh=uDj/gWJUH8gzog+9GZMB9fG7LXatsYxTB/P63pyeTdo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=FYiX1QBm2RAHsQEmKYaoFmO6bkut+//ZCWr2pvGnuakMUIVpbauBPf9VDUU5wqqWc
         IgUaJUshg3+PKJIZCeqDq39unCdy6w9LXZG2HfPptQeVTv8KqqcTSdqN17eL7Z444Z
         WUJlAMUGPg4YSdAb0hoVVYMvbopNN7tTQKtjxNGvzmZ/tEa1aE31Yw1YkFlkebLqT0
         YFsRKYQhWAnR2+vsX8xDYRSR2WdIWnKf2YTXUlTcbe4yyCRKrTn6vMHxqU3LDCKytk
         ynWclzrOIecjW5sC+JYaJYmbDTXVi+gwpZMqpdepOYIqc3Y9ZH0GmZYSkdR7lJ6oPK
         Vy7y0mO9lmxsQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 8CFF75C06D0; Tue, 24 Jan 2023 09:26:47 -0800 (PST)
Date:   Tue, 24 Jan 2023 09:26:47 -0800
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
Message-ID: <20230124172647.GN2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230120212037.GW2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y82dWEW4RwclDTGM@rowland.harvard.edu>
 <20230123201659.GA3754540@paulmck-ThinkPad-P17-Gen-1>
 <Y88/5ib7zYl67mcE@rowland.harvard.edu>
 <20230124040611.GD2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8+8fH52iqQABYs2@andrea>
 <20230124145423.GI2948950@paulmck-ThinkPad-P17-Gen-1>
 <8cc799ab-ffa1-47f7-6e1d-97488a210f14@huaweicloud.com>
 <20230124162253.GL2948950@paulmck-ThinkPad-P17-Gen-1>
 <3e5020c2-0dd3-68a6-9b98-5a7f57ed7733@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e5020c2-0dd3-68a6-9b98-5a7f57ed7733@huaweicloud.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 05:39:53PM +0100, Jonas Oberhauser wrote:
> 
> 
> On 1/24/2023 5:22 PM, Paul E. McKenney wrote:
> > I clearly recall some
> > store-based lack of ordering after a grace period from some years back,
> > and am thus far failing to reproduce it.
> > 
> > And here is another attempt that herd7 actually does allow.
> > 
> > So what did I mess up this time?  ;-)
> > 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > C C-srcu-observed-4
> > 
> > (*
> >   * Result: Sometimes
> >   *
> >   * The Linux-kernel implementation is suspected to forbid this.
> >   *)
> > 
> > {}
> > 
> > P0(int *x, int *y, int *z, struct srcu_struct *s)
> > {
> > 	int r1;
> > 
> > 	r1 = srcu_read_lock(s);
> > 	WRITE_ONCE(*y, 2);
> > 	WRITE_ONCE(*x, 1);
> > 	srcu_read_unlock(s, r1);
> > }
> > 
> > P1(int *x, int *y, int *z, struct srcu_struct *s)
> > {
> > 	int r1;
> > 
> > 	WRITE_ONCE(*y, 1);
> > 	synchronize_srcu(s);
> > 	WRITE_ONCE(*z, 2);
> > }
> > 
> > P2(int *x, int *y, int *z, struct srcu_struct *s)
> > {
> > 	WRITE_ONCE(*z, 1);
> > 	smp_store_release(x, 2);
> > }
> > 
> > exists (x=1 /\ y=1 /\ z=1)
> 
> I think even if you implement the unlock as mb() followed by some store that
> is read by the gp between mb()s, this would still be allowed.

The implementation of synchronize_srcu() has quite a few smp_mb()
invocations.

But exactly how are you modeling this?  As in what additional accesses
and memory barriers are you placing in which locations?

> I have already forgotten the specifics, but I think the power model allows
> certain stores never propagating somewhere?

PowerPC would forbid the 3.2W case, where each process used an
smp_store_release() as its sole ordering (no smp_mb() calls at all).

> If z=2,z=1,x=2 never propagate to P0, you might start by executing P0, then
> P1, and then P2 at which point the memory system decides that x=1 overwrites
> x=2, and the latter simply doesn't propagate anywhere.

This propagation is modulated by the memory barriers, though.

> (I'll let anyone who has the model at hand correct me on this, because I
> have to take a walk now).

Have a good walk!

							Thanx, Paul
