Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27F8767B608
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 16:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235352AbjAYPes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 10:34:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235306AbjAYPeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 10:34:46 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 776F25618A
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 07:34:41 -0800 (PST)
Received: (qmail 213735 invoked by uid 1000); 25 Jan 2023 10:34:40 -0500
Date:   Wed, 25 Jan 2023 10:34:40 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
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
Message-ID: <Y9FMEATzv3gcTUe2@rowland.harvard.edu>
References: <3e5020c2-0dd3-68a6-9b98-5a7f57ed7733@huaweicloud.com>
 <20230124172647.GN2948950@paulmck-ThinkPad-P17-Gen-1>
 <2788294a-972e-acbc-84ce-25d2bb4d26d6@huaweicloud.com>
 <20230124221524.GV2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9BdNVk2LQiUYABS@rowland.harvard.edu>
 <20230124225449.GY2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9CL8LBz+/mbbD00@rowland.harvard.edu>
 <20230125022019.GB2948950@paulmck-ThinkPad-P17-Gen-1>
 <cedf3a39-12cd-1cb1-ad5a-7c10768cee40@huaweicloud.com>
 <20230125150520.GG2948950@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125150520.GG2948950@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 07:05:20AM -0800, Paul E. McKenney wrote:
> On Wed, Jan 25, 2023 at 02:10:08PM +0100, Jonas Oberhauser wrote:
> > 
> > 
> > On 1/25/2023 3:20 AM, Paul E. McKenney wrote:
> > > On Tue, Jan 24, 2023 at 08:54:56PM -0500, Alan Stern wrote:
> > > > On Tue, Jan 24, 2023 at 02:54:49PM -0800, Paul E. McKenney wrote:
> > > > > 
> > > > > Within the Linux kernel, the rule for a given RCU "domain" is that if
> > > > > an event follows a grace period in pretty much any sense of the word,
> > > > > then that event sees the effects of all events in all read-side critical
> > > > > sections that began prior to the start of that grace period.
> > > > > 
> > > > > Here the senses of the word "follow" include combinations of rf, fr,
> > > > > and co, combined with the various acyclic and irreflexive relations
> > > > > defined in LKMM.
> > > > The LKMM says pretty much the same thing.  In fact, it says the event
> > > > sees the effects of all events po-before the unlock of (not just inside)
> > > > any read-side critical section that began prior to the start of the
> > > > grace period.
> > > > 
> > > > > > And are these anything the memory model needs to worry about?
> > > > > Given that several people, yourself included, are starting to use LKMM
> > > > > to analyze the Linux-kernel RCU implementations, maybe it does.
> > > > > 
> > > > > Me, I am happy either way.
> > > > Judging from your description, I don't think we have anything to worry
> > > > about.
> > > Sounds good, and let's proceed on that assumption then.  We can always
> > > revisit later if need be.
> > > 
> > > 							Thanx, Paul
> > 
> > FWIW, I currently don't see a need for either RCU nor "base" LKMM to have
> > this kind of guarantee.
> 
> In the RCU case, it is because it is far easier to provide this guarantee,
> even though it is based on hardware and compilers rather than LKMM,
> than it would be to explain to some random person why the access that
> is intuitively clearly after the grace period can somehow come before it.
> 
> > But I'm curious for why it doesn't exist in LKMM -- is it because of Alpha
> > or some other issues that make it hard to guarantee (like a compiler merging
> > two threads and optimizing or something?), or is it simply that it seemed
> > like a complicated guarantee with no discernible upside, or something else?
> 
> Because to the best of my knowledge, no one has ever come up with a
> use for 2+2W and friends that isn't better handled by some much more
> straightforward pattern of accesses.  So we did not guarantee it in LKMM.
> 
> Yes, you could argue that my "ease of explanation" paragraph above is
> a valid use case, but I am not sure that this is all that compelling of
> an argument.  ;-)

Are we all talking about the same thing?  There were two different 
guarantees mentioned above:

	The RCU guarantee about writes in a read-side critical section
	becoming visible to all CPUs before a later grace period ends;

	The guarantee about the 2+2W pattern and friends being 
	forbidden.

The LKMM includes the first of these but not the second (for the reason 
Paul stated).

Alan
