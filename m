Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1034E6A46D6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 17:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjB0QQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 11:16:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjB0QQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 11:16:36 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 5955720691
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 08:16:34 -0800 (PST)
Received: (qmail 129376 invoked by uid 1000); 27 Feb 2023 11:16:33 -0500
Date:   Mon, 27 Feb 2023 11:16:33 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Jonas Oberhauser <jonas.oberhauser@huawei.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com,
        joel@joelfernandes.org, urezki@gmail.com, quic_neeraju@quicinc.com,
        frederic@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] tools/memory-model: Make ppo a subrelation of po
Message-ID: <Y/zXYXM1lgk7Msig@rowland.harvard.edu>
References: <20230224135251.24989-1-jonas.oberhauser@huaweicloud.com>
 <Y/jYm0AZfPHkIalK@rowland.harvard.edu>
 <20230224183758.GQ2948950@paulmck-ThinkPad-P17-Gen-1>
 <20230226010110.GA1576556@paulmck-ThinkPad-P17-Gen-1>
 <Y/rEH2r9i0BtfxEW@rowland.harvard.edu>
 <Y/rNUfW509AQYCYn@boqun-archlinux>
 <Y/rSQ2FNTJyj2bqR@rowland.harvard.edu>
 <a862ee59-ca12-b609-48cc-0784c7ce24af@huaweicloud.com>
 <Y/uOA3umovz06/SV@rowland.harvard.edu>
 <dd87369d-825f-e932-dd86-8e46e92d1a7e@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dd87369d-825f-e932-dd86-8e46e92d1a7e@huaweicloud.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 03:03:16PM +0100, Jonas Oberhauser wrote:
> Note that I don't want to remove the r-pre/post-bounded tests.
> What I agreed to is that the restriction to only addr for plain writes is an
> overly conservative "r-pre/post-bounded-style" test which is made redundant
> by the existence of the actual r-pre/post-bounded test.

Good, that agrees with what I've been thinking.

> > > Note there's also rw-xbstar (used with fr) which doesn't check for
> > > r-pre-bounded, but it should be ok. That's because only reads would be
> > > unordered, as a result the read (in the if (x != ..) x=..) should provide
> > > the correct value. The store would be issued as necessary, and the issued
> > > store would still be ordered correctly w.r.t the read.
> > That isn't the reason I left r-pre-bounded out from rw-xbstar.  If the
> > write gets changed to a read there's no need for rw-xbstar to check
> > r-pre-bounded, because then rw-race would be comparing a read with
> > another read (instead of with a write) and so there would be no
> > possibility of a race in any case.
> 
> That is the first part of my explanation (only reads would be unordered) but

It is?  I couldn't tell from what you wrote that this was supposed to 
imply we didn't have to worry about a data race.

> I don't think it's sufficient in general.
> Imagine a hypothetical memory model with a release fence that upgrades the
> next memory operation only (and only stores) to release (e.g., to save some
> opcode design space you do weird_release_fence;str x1 x2 instead of stlr x1
> x2).
> Then in the message passing pattern
> 
> T1 {
>    u = a;
>    release(&x, 1);
> }
> 
> T2 {
>   t = READ_ONCE(&x);
>   weird_release_fence;
>   a = 1;
> }

[That isn't the Message Passing pattern.  In the MP pattern, one thread 
does two writes and the other thread does two reads.  This is the Read 
Buffering (RB) pattern: Each thread does a read followed by a write.]

> 
> where T2 is changed by the compiler to
> 
> T2 {
>   t = READ_ONCE(&x);
>   weird_release_fence();
>   if (a!=1) a = 1;
> }
> 
> In the specific executions where t==1, there wouldn't be a data race when
> just considering the equivalent of rw-xbstar, but u==1 and t==1 would be
> possible (even though it might not seem so from the first example).

If such a fence existed in the LKMM, we would handle this case by saying 
that weird_release_fence() does not give release semantics to an 
immediately following plain store; only to an immediately following 
marked store.  The reason being that the compiler is allowed to muck 
around with the code generated for plain accesses, so there's no 
guarantee that the first machine instruction generated for "a = 1;" will 
be a store.

As a result, there would not be an rw-xbstar link from T1 to T2.

> Of course in LKMM there's no such fence, but I think to make the argument
> complete you still need to go through every case that provides the
> w-pre-bounding and make sure it still provides the necessary order in the
> compiler-generated version. (or you can try a more complicated argument of
> the form "there would be another execution of the same program that would
> have a data race", which works at least for this example, not sure in
> general)

So I don't see this as a valid argument for not using rw-xbstar in 
rw-race.  Even theoretically.

Alan
