Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF54567A8AC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 03:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbjAYCUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 21:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjAYCUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 21:20:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED4B10AAB
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 18:20:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A962613CA
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 02:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E819CC433D2;
        Wed, 25 Jan 2023 02:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674613220;
        bh=SoCAwJmBB4a2CPMDqnQA3neIrz5nUwDQFsM8itQBG3I=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=U1Ny6h8j1qyiGrm0NyvXJbWFPJUNrV11kl8ms49ysd637ho09Ma5IK7nhuUC7jhA7
         jLn7p6JZ5QGGFWiLwsoqr6QlQcPFHWVugVkQll1ihM9FrKjelkENDzjJTrBvUT4gSG
         qmcg2L+QSA7Jcrs7hAKZv2hckc4dpXIvxOVxsoqVrobohxkM3qnPiGCBU8Csl+L7ml
         eK8KlDCbtKH548zlkuve6z9XBUdKEmB6BFkkmcJoZrQudoI6gx8oCMPGf5owTvHU/x
         QfuPou64cAH5Zrz9FuBeSbONHYwEss7hRO85mhOgZ3Bxu/WPasgcJNwds5rjLosq3m
         BThDhPRJSYT5w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 977C55C1052; Tue, 24 Jan 2023 18:20:19 -0800 (PST)
Date:   Tue, 24 Jan 2023 18:20:19 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
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
Message-ID: <20230125022019.GB2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230124145423.GI2948950@paulmck-ThinkPad-P17-Gen-1>
 <8cc799ab-ffa1-47f7-6e1d-97488a210f14@huaweicloud.com>
 <20230124162253.GL2948950@paulmck-ThinkPad-P17-Gen-1>
 <3e5020c2-0dd3-68a6-9b98-5a7f57ed7733@huaweicloud.com>
 <20230124172647.GN2948950@paulmck-ThinkPad-P17-Gen-1>
 <2788294a-972e-acbc-84ce-25d2bb4d26d6@huaweicloud.com>
 <20230124221524.GV2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9BdNVk2LQiUYABS@rowland.harvard.edu>
 <20230124225449.GY2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9CL8LBz+/mbbD00@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9CL8LBz+/mbbD00@rowland.harvard.edu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 08:54:56PM -0500, Alan Stern wrote:
> On Tue, Jan 24, 2023 at 02:54:49PM -0800, Paul E. McKenney wrote:
> > On Tue, Jan 24, 2023 at 05:35:33PM -0500, Alan Stern wrote:
> > > Can you be more explicit?  Exactly what guarantees does the kernel 
> > > implementation make that can't be expressed in LKMM?
> > 
> > I doubt that I will be able to articulate it very well, but here goes.
> > 
> > Within the Linux kernel, the rule for a given RCU "domain" is that if
> > an event follows a grace period in pretty much any sense of the word,
> > then that event sees the effects of all events in all read-side critical
> > sections that began prior to the start of that grace period.
> > 
> > Here the senses of the word "follow" include combinations of rf, fr,
> > and co, combined with the various acyclic and irreflexive relations
> > defined in LKMM.
> 
> The LKMM says pretty much the same thing.  In fact, it says the event 
> sees the effects of all events po-before the unlock of (not just inside) 
> any read-side critical section that began prior to the start of the 
> grace period.
> 
> > > And are these anything the memory model needs to worry about?
> > 
> > Given that several people, yourself included, are starting to use LKMM
> > to analyze the Linux-kernel RCU implementations, maybe it does.
> > 
> > Me, I am happy either way.
> 
> Judging from your description, I don't think we have anything to worry 
> about.

Sounds good, and let's proceed on that assumption then.  We can always
revisit later if need be.

							Thanx, Paul
