Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D43A66CEBA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 19:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233968AbjAPSZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 13:25:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232411AbjAPSYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 13:24:23 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 781EB13D72
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 10:11:42 -0800 (PST)
Received: (qmail 135386 invoked by uid 1000); 16 Jan 2023 13:11:41 -0500
Date:   Mon, 16 Jan 2023 13:11:41 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "parri.andrea" <parri.andrea@gmail.com>, will <will@kernel.org>,
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
Message-ID: <Y8WTXS73qTBpUzcI@rowland.harvard.edu>
References: <20230113203241.GA2958699@paulmck-ThinkPad-P17-Gen-1>
 <136d019d8c8049f6b737627df830e66f@huawei.com>
 <20230114175343.GF2948950@paulmck-ThinkPad-P17-Gen-1>
 <20230114181537.GA493203@paulmck-ThinkPad-P17-Gen-1>
 <Y8MOOrrHntA9TyUk@rowland.harvard.edu>
 <20230115051510.GG2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8Qog8qf7wIx2Kve@rowland.harvard.edu>
 <20230115181052.GJ2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8RmEtBnwqOzNhsK@rowland.harvard.edu>
 <20230116042329.GN2948950@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230116042329.GN2948950@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 15, 2023 at 08:23:29PM -0800, Paul E. McKenney wrote:
> On Sun, Jan 15, 2023 at 03:46:10PM -0500, Alan Stern wrote:
> > On Sun, Jan 15, 2023 at 10:10:52AM -0800, Paul E. McKenney wrote:
> > > On Sun, Jan 15, 2023 at 11:23:31AM -0500, Alan Stern wrote:
> > > > On Sat, Jan 14, 2023 at 09:15:10PM -0800, Paul E. McKenney wrote:
> > > > > What am I missing here?
> > > > 
> > > > I don't think you're missing anything.  This is a matter for Boqun or 
> > > > Luc; it must have something to do with the way herd treats the 
> > > > srcu_read_lock() and srcu_read_unlock() primitives.
> > > 
> > > It looks like we need something that tracks (data | rf)* between
> > > the return value of srcu_read_lock() and the second parameter of
> > > srcu_read_unlock().  The reason for rf rather than rfi is the upcoming
> > > srcu_down_read() and srcu_up_read().
> > 
> > Or just make herd treat srcu_read_lock(s) as an annotated equivalent of 
> > READ_ONCE(&s) and srcu_read_unlock(s, v) as an annotated equivalent of 
> > WRITE_ONCE(s, v).  But with some special accomodation to avoid 
> > interaction with the new carry-dep relation.
> 
> This is a modification to herd7 you are suggesting?  Otherwise, I am
> suffering a failure of imagination on how to properly sort it from the
> other READ_ONCE() and WRITE_ONCE() instances.

srcu_read_lock and srcu_read_unlock events would be distinguished from 
other marked loads and stores by belonging to the Srcu-lock and 
Srcu-unlock sets.  But I don't know whether this result can be 
accomplished just by modifying the .def file -- it might require changes 
to herd7.  (In fact, as far as I know there is no documentation at all 
for the double-underscore operations used in linux-kernel.def.  Hint 
hint!)

As mentioned earlier, we should ask Luc or Boqun.


> > > Or is there some better intermediate position that could be taken?
> > 
> > Do you mean go back to the current linux-kernel.bell?  The code you 
> > wrote above is different, since it prohibits nesting.
> 
> Not to the current linux-kernel.bell, but, as you say, making the change
> to obtain a better approximation by prohibiting nesting.

Why do you want to prohibit nesting?  Why would that be a better 
approximation?

Alan
