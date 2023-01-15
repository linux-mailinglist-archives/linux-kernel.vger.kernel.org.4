Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C106A66B3E9
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 21:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbjAOUqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 15:46:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbjAOUqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 15:46:12 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 8ED1D13503
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 12:46:11 -0800 (PST)
Received: (qmail 106827 invoked by uid 1000); 15 Jan 2023 15:46:10 -0500
Date:   Sun, 15 Jan 2023 15:46:10 -0500
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
Message-ID: <Y8RmEtBnwqOzNhsK@rowland.harvard.edu>
References: <Y8GGmstFlgg91RMp@rowland.harvard.edu>
 <20230113200706.GI4028633@paulmck-ThinkPad-P17-Gen-1>
 <20230113203241.GA2958699@paulmck-ThinkPad-P17-Gen-1>
 <136d019d8c8049f6b737627df830e66f@huawei.com>
 <20230114175343.GF2948950@paulmck-ThinkPad-P17-Gen-1>
 <20230114181537.GA493203@paulmck-ThinkPad-P17-Gen-1>
 <Y8MOOrrHntA9TyUk@rowland.harvard.edu>
 <20230115051510.GG2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8Qog8qf7wIx2Kve@rowland.harvard.edu>
 <20230115181052.GJ2948950@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230115181052.GJ2948950@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 15, 2023 at 10:10:52AM -0800, Paul E. McKenney wrote:
> On Sun, Jan 15, 2023 at 11:23:31AM -0500, Alan Stern wrote:
> > On Sat, Jan 14, 2023 at 09:15:10PM -0800, Paul E. McKenney wrote:
> > > What am I missing here?
> > 
> > I don't think you're missing anything.  This is a matter for Boqun or 
> > Luc; it must have something to do with the way herd treats the 
> > srcu_read_lock() and srcu_read_unlock() primitives.
> 
> It looks like we need something that tracks (data | rf)* between
> the return value of srcu_read_lock() and the second parameter of
> srcu_read_unlock().  The reason for rf rather than rfi is the upcoming
> srcu_down_read() and srcu_up_read().

Or just make herd treat srcu_read_lock(s) as an annotated equivalent of 
READ_ONCE(&s) and srcu_read_unlock(s, v) as an annotated equivalent of 
WRITE_ONCE(s, v).  But with some special accomodation to avoid 
interaction with the new carry-dep relation.

> But what I will do in the meantime is to switch back to a commit that
> simply flags nesting of same-srcu_struct SRCU read-side critical sections,
> while blindly assuming that the return value of a given srcu_read_lock()
> is passed in to the corresponding srcu_read_unlock():
> 
> ------------------------------------------------------------------------
> 
> (* Compute matching pairs of Srcu-lock and Srcu-unlock, but prohibit nesting *)
> let srcu-unmatched = Srcu-lock | Srcu-unlock
> let srcu-unmatched-po = ([srcu-unmatched] ; po ; [srcu-unmatched]) & loc
> let srcu-unmatched-locks-to-unlock = ([Srcu-lock] ; po ; [Srcu-unlock]) & loc
> let srcu-rscs = srcu-unmatched-locks-to-unlock \ (srcu-unmatched-po ; srcu-unmatched-po)
> 
> (* Validate nesting *)
> flag ~empty Srcu-lock \ domain(srcu-rscs) as unbalanced-srcu-locking
> flag ~empty Srcu-unlock \ range(srcu-rscs) as unbalanced-srcu-locking
> 
> (* Check for use of synchronize_srcu() inside an RCU critical section *)
> flag ~empty rcu-rscs & (po ; [Sync-srcu] ; po) as invalid-sleep
> 
> (* Validate SRCU dynamic match *)
> flag ~empty different-values(srcu-rscs) as srcu-bad-nesting
> 
> ------------------------------------------------------------------------
> 
> Or is there some better intermediate position that could be taken?

Do you mean go back to the current linux-kernel.bell?  The code you 
wrote above is different, since it prohibits nesting.

Alan
