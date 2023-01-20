Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB03F675904
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 16:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbjATPrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 10:47:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbjATPrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 10:47:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B6C9754
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 07:47:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B2C5361FCE
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 15:47:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15617C4339B;
        Fri, 20 Jan 2023 15:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674229630;
        bh=dnTyS2dlLqRhnPPXKCqBAPZiNszpkGqbyjTurzV/4YY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=C6agBrlQl7DHiGSqQdlLFw0J681U/hU/Q8Fzu6BMThIeyN+i4Qk58Cd8ZH+UKre0s
         Lnr1ahjyhrju/bfcU3oMWGipQoHm894NAesmq+NQQi7ziV8RVY4ETBr6LUNdlb44vJ
         3zd8rhHllIKw7Ro74y2HcqtMPJ6VJnIL/t+MWxvhDsk1d1lsHMXd41vrTjuF0a6ovK
         s1JOs3/Ajs+8gK/Ud7MiYo58DcM1vz8BalTL9Rz9TIqSlOKOUoKvEfyyE0uiFkKmMa
         C5ZwuMT0Balpw9/TSEnzB3eVln33j/GynDCvxbPuumJMFx4a6aYdCWKoqgcNKpQWQv
         2qlDcpGicJffg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B06785C0DFC; Fri, 20 Jan 2023 07:47:09 -0800 (PST)
Date:   Fri, 20 Jan 2023 07:47:09 -0800
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
Message-ID: <20230120154709.GG2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <Y8gjUKoHxqR9+7Hx@rowland.harvard.edu>
 <3dabbcfb-858c-6aa0-6824-05b8cc8e9cdb@gmail.com>
 <20230118201918.GI2948950@paulmck-ThinkPad-P17-Gen-1>
 <a5637181-1675-7973-489c-e5d24cbd25c2@huaweicloud.com>
 <20230118211201.GL2948950@paulmck-ThinkPad-P17-Gen-1>
 <09f084d2-6128-7f83-b2a5-cbe236b1678d@huaweicloud.com>
 <20230119001147.GN2948950@paulmck-ThinkPad-P17-Gen-1>
 <0fae983b-2a7c-d44e-8881-53d5cc053f09@huaweicloud.com>
 <20230119184107.GT2948950@paulmck-ThinkPad-P17-Gen-1>
 <64b48a7b-624c-26bd-be9b-0522fc490b28@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <64b48a7b-624c-26bd-be9b-0522fc490b28@huaweicloud.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 11:13:00AM +0100, Jonas Oberhauser wrote:
> 
> 
> On 1/19/2023 7:41 PM, Paul E. McKenney wrote:
> > On Thu, Jan 19, 2023 at 02:39:01PM +0100, Jonas Oberhauser wrote:
> > > 
> > > On 1/19/2023 1:11 AM, Paul E. McKenney wrote:
> > > > On Wed, Jan 18, 2023 at 10:24:50PM +0100, Jonas Oberhauser wrote:
> > > > > What I was thinking of is more something like this:
> > > > > 
> > > > > P0{
> > > > >      idx1 = srcu_down(&ss);
> > > > >      srcu_up(&ss,idx1);
> > > > > }
> > > > > 
> > > > > P1{
> > > > >       idx2 = srcu_down(&ss);
> > > > >       srcu_up(&ss,idx2)
> > > > > }
> > > > And srcu_read_lock() and srcu_read_unlock() already do this.
> > > I think I left out too much from my example.
> > > And filling in the details led me down a bit of a rabbit hole of confusion
> > > for a while.
> > > But here's what I ended up with:
> > > 
> > > 
> > > P0{
> > >      idx1 = srcu_down(&ss);
> > >      store_rel(p1, true);
> > > 
> > > 
> > >      shared cs
> > > 
> > >      R x == ?
> > > 
> > >      while (! load_acq(p2));
> > >      R idx2 == idx1 // for some reason, we got lucky!
> > >      srcu_up(&ss,idx1);
> > Although the current Linux-kernel implementation happens to be fine with
> > this sort of abuse, I am quite happy to tell people "Don't do that!"
> > And you can do this with srcu_read_lock() and srcu_read_unlock().
> > In contrast, this actually needs srcu_down_read() and srcu_up_read():
> 
> My point/clarification request wasn't about whether you could write that
> code with read_lock() and read_unlock(), but what it would/should mean for
> the operational and axiomatic models.
> As I wrote later in the mail, for the operational model it is quite clear
> that x==1 should be allowed for lock() and unlock(), but would probably be
> forbidden for down() and up().

Agreed, the math might say something or another about doing something
with the srcu_read_lock() or srcu_down_read() return values (other than
passing them to srcu_read_unlock() or srcu_up_read(), respectively),
but such somethings are excluded by convention.

So it would be nice for LKMM to complain about such abuse, but not
at all mandatory.

> My clarification request is whether that difference in the probable
> operational model should be reflected in the axiomatic model (as I first
> suspected based on the word "semaphore" being dropped a lot), or whether
> it's just due to abuse (i.e., yes the axiomatic model and operational model
> might be different here, but you're not allowed to look).

For the moment, I am taking the door labeled "abuse".

Maybe someday someone will come up with a valid use case, but they have
to prove it first.  ;-)

> Which brings us to the next point:
> 
> > Could you please review the remainder to see what remains given the
> > usage restrictions that I called out above?
> 
> Perhaps we could say that reading an index without using it later is
> forbidden?
> 
> flag ~empty [Srcu-lock];data;rf;[~ domain(data;[Srcu-unlock])] as
> thrown-srcu-cookie-on-floor
> 
> So if there is an srcu_down() that produces a cookie that is read by some
> read R, and R doesn't then pass that value into an srcu_up(), the
> srcu-warranty is voided.

I like the general idea, but I am dazed and confused by this "flag"
statement.

> Perhaps it would also be good to add special tags for Srcu-down and Srcu-up
> to avoid collisions.

Ah, separate down/up tags could make this "flag" statement at least
somewhat less dazing and confusing.

> always have fun, jonas

Always do!  ;-)

							Thanx, Paul
