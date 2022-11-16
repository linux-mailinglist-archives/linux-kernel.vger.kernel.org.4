Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D49162C06F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 15:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbiKPOGC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 16 Nov 2022 09:06:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233499AbiKPOCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 09:02:21 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14EAE252A1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 05:58:50 -0800 (PST)
Received: from frapeml100003.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NC4Mr3XVbz6HHqk;
        Wed, 16 Nov 2022 21:56:24 +0800 (CST)
Received: from lhrpeml500004.china.huawei.com (7.191.163.9) by
 frapeml100003.china.huawei.com (7.182.85.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 14:58:48 +0100
Received: from lhrpeml500002.china.huawei.com (7.191.160.78) by
 lhrpeml500004.china.huawei.com (7.191.163.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 13:58:48 +0000
Received: from lhrpeml500002.china.huawei.com ([7.191.160.78]) by
 lhrpeml500002.china.huawei.com ([7.191.160.78]) with mapi id 15.01.2375.031;
 Wed, 16 Nov 2022 13:58:48 +0000
From:   Jonas Oberhauser <jonas.oberhauser@huawei.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>
CC:     "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
        "will@kernel.org" <will@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "j.alglave@ucl.ac.uk" <j.alglave@ucl.ac.uk>,
        "luc.maranget@inria.fr" <luc.maranget@inria.fr>,
        "akiyks@gmail.com" <akiyks@gmail.com>,
        "dlustig@nvidia.com" <dlustig@nvidia.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "urezki@gmail.com" <urezki@gmail.com>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "frederic@kernel.org" <frederic@kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] tools: memory-model: Add rmw-sequences to the LKMM
Thread-Topic: [PATCH] tools: memory-model: Add rmw-sequences to the LKMM
Thread-Index: AQHY+E4/7Sf4Z7j0EUaRPuQVW9Z9Y64/rrBwgAB7BACAANXqgIAAkYtQ
Date:   Wed, 16 Nov 2022 13:58:47 +0000
Message-ID: <a42e9cfe4fe74717be2a3462a9edd905@huawei.com>
References: <Y3J6P3jCNmrj3tue@rowland.harvard.edu>
 <1453ec4a0b7549009eff21d899053c50@huawei.com>
 <Y3O6mJz4wXJlzLh2@rowland.harvard.edu>
 <20221116045849.GJ4001@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20221116045849.GJ4001@paulmck-ThinkPad-P17-Gen-1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.81.216.25]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Paul E. McKenney [mailto:paulmck@kernel.org] 
> Sent: Wednesday, November 16, 2022 5:59 AM
> > On Tue, Nov 15, 2022 at 11:13:12AM -0500, Alan Stern wrote:
> > > On Tue, Nov 15, 2022 at 02:05:39PM +0000, Jonas Oberhauser wrote:
> > > So I would change the wording to "Viktor has pointed out a weakness 
> > > in the Linux Kernel Memory Model."
> > 
> > People will wonder who Viktor is.  I don't have his full name or email 
> > address.  In fact, shouldn't he have been CC'ed during this entire 
> > discussion?
> 
> [...] I defer to Jonas on CCing, just in case Viktor needs to be provided context on this discussion.


When I noticed Viktor wasn't in CC I asked him in person if we should add him,
but he said it's not necessary. I think he is too busy to catch up with the
complete discussion anyways.

I gave him a brief summary of our discussions so far though.

> > > +let rmw-sequence = (rf ; rmw)*
> > 
> > I would perhaps suggest to only consider external read-from in 
> > rmw-sequences, as
> > below:
> > +let rmw-sequence = (rfe ; rmw)*
> 
> We discussed the matter earlier, and I don't recall any mention of 
> this objection.

Is it possible that you did not receive some messages I sent? I mentioned it at
least twice (and I just double checked that I didn't accidentally drop you from
CC -- one of them from 9/30 including the string "C arm-behavior" if you want to
search).
Paul McKenney says some of my messages frequently land in his spam folder... :( 
 -- which doesn't say anything positive about my messaging patterns I suppose :P


> > > I don't think such a future architecture is likely since I don't 
> > > expect there to be any practical performance impact. At the same 
> > > time I also don't currently see any advantage of the stricter model.
> > > 
> > > For this reason I would slightly prefer the more relaxed model.
> > 
> > I don't see any point in worrying about hypothetical future 
> > architectures that might use a questionable design.

I usually would agree and not use as an argument absurd designs I might imagine.
Now I'm personally definitely not aware of any specific aims to implement such a
design, but the reason I brought it up was that  this kind of design is not my
invention either; as I had (perhaps incorrectly) remembered someone had told me
there was concrete interest in doing a design along these lines and hence the 
C11 definition of data races might need to be weakened.

A quick google search only turns up the following C11 proposal (+ its ancestors)
   https://www.open-std.org/jtc1/sc22/wg21/docs/papers/2018/p0982r1.html
which only considers relaxing the store part of the release sequence definition
(but keeps the RMW part like in the proposal you have given), and they don't
mention specific hardware optimizations that might necessitate such a change.

(They do mention specifically compiler optimizations that might do such a merge,
which is of no direct relevance to LKMM (since all rmw accesses are compiler
barriers, this  kind of optimization can not happen in Linux anyways).
They also raise a concern about how adding another thread creates some weird
behavior with C11 release sequences, but that concern is also not relevant to 
RMWs.)

So on third/fourth thought it's entirely possible that I just misremembered the
details, and perhaps this design was just given to me by someone trying to
explain to me why people might be concerned that this kind of definition might
needlessly restrict some design space of architects.

> > Also, given that this test is forbidden:
> > 
> > P0				P1		P2
> > -------------------------	--------------	----------------------------
> > WRITE_ONCE(*x, 1);		atomic_inc(y);	r1 = atomic_read_acquire(y);
> > atomic_set_release(y, 1);			r2 = READ_ONCE(*x);
> > exists (2:r1=2 /\ 2:r2=0)
> > 
> > shouldn't the following also be forbidden?
> > 
> > P0				P1		P2
> > -------------------------	--------------	----------------------------
> > WRITE_ONCE(*x, 1);		atomic_inc(y);	r1 = atomic_read_acquire(y);
> > atomic_set_release(y, 1);	atomic_inc(y);	r2 = READ_ONCE(*x);
> > exists (2:r1=3 /\ 2:r2=0)

I think so, and in fact I've considered before a third option where only the
first rf must be external like so
+let rmw-sequence = (rfe ; rmw ; (rf ; rmw)*)?
but it is quite ugly. Thus imho it is the least desirable option right now,
given that it combines providing an unused feature with worrying about an unused 
"optimization".

(The reason why allowing rfi after the initial cumul-fence store should be sound 
is that all subsequent rf's read from rmw operations, which after merging will
still be rmw operations (just doing two updates in a single rmw). E.g. the two
atomic_inc in the litmus test you provided might be turned into a single 
atomic_add(..., 2), but this does not affect the overall rmw sequence.)

Anyways, this is only a slight preference. In fact, given that probably no code
relies on this extra ordering it should also be easy enough to adapt to unlikely 
changes at the hardware side. Another thought I've had is that it might be 
possible to "inherit" the release ordering across such merges in such a hardware
implementation, in which case your definition should still be correct even if a
merge happened.

So if nobody else has any opinions on this, I'm ok with following your
suggestion.

> > 
> > > > +Rmw sequences have a special property in the LKMM: They can 
> > > > +extend the cumul-fence relation.  That is, if we have:
> > > > +
> > > > +	U ->cumul-fence X -> rmw-sequence Y
> > > > +
> > > > +then also U ->cumul-fence Y.  Thinking about this in terms of the 
> > > > +operational model, U ->cumul-fence X says that the store U 
> > > > +propagates to each CPU before the store X does.  Then the fact 
> > > > +that X and Y are linked by an rmw sequence means that U also 
> > > > +propagates to each CPU before Y does.
> > > > +
> > > 
> > > Here I would add that the rmw sequences also play a similar role in 
> > > the w-post-bounded relation.
> > 
> > I considered this and specifically decided against it, because the 
> > w-post-bounded relation has not yet been introduced at this point in 
> > the document.  It doesn't show up until much later.  (Also, there 
> > didn't seem to be any graceful way of mentioning this fact at the 
> > point where w-post-bounded does get introduced, and on the whole the 
> > matter didn't seem to be all that important.)
> > 
> > Instead of your suggested change, I suppose it would be okay to say, 
> > at the end of the paragraph:
> > 
> > 	(In an analogous way, rmw sequences can extend the 
> > 	w-post-bounded relation defined below in the PLAIN ACCESSES
> > 	AND DATA RACES section.)

Great point! I'm in favor of this solution.

Best wishes,
jonas
