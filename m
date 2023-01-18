Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D65672540
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 18:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbjARRnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 12:43:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbjARRma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 12:42:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B97589A5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 09:41:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B9E1FB81E16
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 17:41:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EC10C433F0;
        Wed, 18 Jan 2023 17:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674063699;
        bh=U8QLPf7lyWvHcZUi3WnXi8fbXM4xhuvGnUqsEPVpr+U=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=HTwW1H2WVldVV/MJzRubBzfn1R+hvi+5wdZN+6y1TShC0IiZY1IsmiCrfDs8R7ek8
         Zq/W2DHzaZGMwIKV3tzxHgGo0pEcGHsugW3/grz8glzAAOAh1aWOQlXqDL8GhS9ZIA
         NRaSlrsYHo+Sx8kFrZ1Aq1ZTf7gPAF1vQKcosomiyyN3Ej/MndrGTGIDl01zXWKzw8
         8H69VU0rEdlVlbZfNW16fPaDOoWwZoarWbLaU2Ruqwb3q2UZO8vh554B7B/pKKejAq
         L7figMQaTH4z05diq+LAvHRCpNgDMNywlZkOYvjzFZEY7XjHtojPGHx9EA7Et8rCk7
         jLdROjT2h/MCg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id F27D55C05FB; Wed, 18 Jan 2023 09:41:38 -0800 (PST)
Date:   Wed, 18 Jan 2023 09:41:38 -0800
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
Message-ID: <20230118174138.GB2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230116190652.GZ2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8WjmTFnqbAnS1Pz@rowland.harvard.edu>
 <20230116221357.GA2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8aKlNY4Z0z2Yqs0@andrea>
 <20230117151416.GI2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8bFMgDSUZymXUsS@rowland.harvard.edu>
 <20230117174308.GK2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8dWMyBfz1iiaF8M@rowland.harvard.edu>
 <20230118051704.GX2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8gYV81O80BtMvWm@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8gYV81O80BtMvWm@rowland.harvard.edu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 11:03:35AM -0500, Alan Stern wrote:
> On Tue, Jan 17, 2023 at 09:17:04PM -0800, Paul E. McKenney wrote:
> > On Tue, Jan 17, 2023 at 09:15:15PM -0500, Alan Stern wrote:
> > > Maybe we don't.  Please test the patch below; I think it will do what 
> > > you want -- and it doesn't rule out nesting.
> > 
> > It works like a champ on manual/kernel/C-srcu*.litmus in the litmus
> > repository on github, good show and thank you!!!
> > 
> > I will make more tests, and am checking this against the rest of the
> > litmus tests in the repo, but in the meantime would you be willing to
> > have me add your Signed-off-by?
> 
> I'll email a real patch submission in the not-too-distant future, 
> assuming you don't find any problems with the new code.

Sounds good!

The current state is that last night's testing found a difference only
for C-srcu-nest-5.litmus, in which case your version gives the correct
answer and mainline is wrong.  There were a couple of broken tests, which
I fixed and a test involving spin_unlock_wait(), which is at this point
perma-broken due to the Linux kernel no longer having such a thing.
(Other than its re-introduction into i915, but they define it as a
spin_lock_irq() followed by a spin_unlock_irq(), so why worry?)
There were also a few timeouts.

I intend to run the longer tests overnight.

I have not yet come up with a good heuristic to auto-classify
automatically generated tests involving SRCU, so I cannot justify making
you wait on me to get my act together on that.

							Thanx, Paul
