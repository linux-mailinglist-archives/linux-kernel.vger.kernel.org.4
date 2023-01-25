Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F54967B563
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 16:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235666AbjAYPF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 10:05:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234367AbjAYPFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 10:05:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F43783FB
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 07:05:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 66D24B81A2A
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 15:05:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14965C433EF;
        Wed, 25 Jan 2023 15:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674659121;
        bh=GOzeWXKTRTy1MWqqESg3X52CSFNWzuN1TKRXgADAoCk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=UCrGF4JYIc/9uJIpUMC91VphZy+CFoCV67SlbNf6QnFD4Z3riO6v9S6Qdl5pDGcaT
         7+UhZFAIztLu6ewE9KA498bzk/QN/cc0maPMocQuVmhHalBKzASZ5i9firR5NT9owO
         J8/yZqMzkYfp6f85RCizDYmqnkCN+4KWYYsSNKcLbjF8djBF6LC2UQmgc1mVrtvpda
         7dyo2jAH4NYDC5u4gePUe/5VOuRbW4mMs2sMWiYxHA5Jt+Vav9g/4YVUfVEqCY+UbI
         hJvVdg6VKvBaNw4y338o3hK3APkd6MiVFpfUnIXsDpgjpmNTgk0Nl4XaXgB/B7riIQ
         6MC6+4mdLKqCw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A3D1B5C0200; Wed, 25 Jan 2023 07:05:20 -0800 (PST)
Date:   Wed, 25 Jan 2023 07:05:20 -0800
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
Message-ID: <20230125150520.GG2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230124162253.GL2948950@paulmck-ThinkPad-P17-Gen-1>
 <3e5020c2-0dd3-68a6-9b98-5a7f57ed7733@huaweicloud.com>
 <20230124172647.GN2948950@paulmck-ThinkPad-P17-Gen-1>
 <2788294a-972e-acbc-84ce-25d2bb4d26d6@huaweicloud.com>
 <20230124221524.GV2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9BdNVk2LQiUYABS@rowland.harvard.edu>
 <20230124225449.GY2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9CL8LBz+/mbbD00@rowland.harvard.edu>
 <20230125022019.GB2948950@paulmck-ThinkPad-P17-Gen-1>
 <cedf3a39-12cd-1cb1-ad5a-7c10768cee40@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cedf3a39-12cd-1cb1-ad5a-7c10768cee40@huaweicloud.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 02:10:08PM +0100, Jonas Oberhauser wrote:
> 
> 
> On 1/25/2023 3:20 AM, Paul E. McKenney wrote:
> > On Tue, Jan 24, 2023 at 08:54:56PM -0500, Alan Stern wrote:
> > > On Tue, Jan 24, 2023 at 02:54:49PM -0800, Paul E. McKenney wrote:
> > > > On Tue, Jan 24, 2023 at 05:35:33PM -0500, Alan Stern wrote:
> > > > > Can you be more explicit?  Exactly what guarantees does the kernel
> > > > > implementation make that can't be expressed in LKMM?
> > > > I doubt that I will be able to articulate it very well, but here goes.
> > > > 
> > > > Within the Linux kernel, the rule for a given RCU "domain" is that if
> > > > an event follows a grace period in pretty much any sense of the word,
> > > > then that event sees the effects of all events in all read-side critical
> > > > sections that began prior to the start of that grace period.
> > > > 
> > > > Here the senses of the word "follow" include combinations of rf, fr,
> > > > and co, combined with the various acyclic and irreflexive relations
> > > > defined in LKMM.
> > > The LKMM says pretty much the same thing.  In fact, it says the event
> > > sees the effects of all events po-before the unlock of (not just inside)
> > > any read-side critical section that began prior to the start of the
> > > grace period.
> > > 
> > > > > And are these anything the memory model needs to worry about?
> > > > Given that several people, yourself included, are starting to use LKMM
> > > > to analyze the Linux-kernel RCU implementations, maybe it does.
> > > > 
> > > > Me, I am happy either way.
> > > Judging from your description, I don't think we have anything to worry
> > > about.
> > Sounds good, and let's proceed on that assumption then.  We can always
> > revisit later if need be.
> > 
> > 							Thanx, Paul
> 
> FWIW, I currently don't see a need for either RCU nor "base" LKMM to have
> this kind of guarantee.

In the RCU case, it is because it is far easier to provide this guarantee,
even though it is based on hardware and compilers rather than LKMM,
than it would be to explain to some random person why the access that
is intuitively clearly after the grace period can somehow come before it.

> But I'm curious for why it doesn't exist in LKMM -- is it because of Alpha
> or some other issues that make it hard to guarantee (like a compiler merging
> two threads and optimizing or something?), or is it simply that it seemed
> like a complicated guarantee with no discernible upside, or something else?

Because to the best of my knowledge, no one has ever come up with a
use for 2+2W and friends that isn't better handled by some much more
straightforward pattern of accesses.  So we did not guarantee it in LKMM.

Yes, you could argue that my "ease of explanation" paragraph above is
a valid use case, but I am not sure that this is all that compelling of
an argument.  ;-)

							Thanx, Paul
