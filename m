Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 194B8676982
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 22:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjAUVDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 16:03:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjAUVDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 16:03:42 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id AE5061F5EA
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 13:03:39 -0800 (PST)
Received: (qmail 77227 invoked by uid 1000); 21 Jan 2023 16:03:38 -0500
Date:   Sat, 21 Jan 2023 16:03:38 -0500
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
Message-ID: <Y8xTKkgaLHg3Yifk@rowland.harvard.edu>
References: <20230119001147.GN2948950@paulmck-ThinkPad-P17-Gen-1>
 <0fae983b-2a7c-d44e-8881-53d5cc053f09@huaweicloud.com>
 <20230119184107.GT2948950@paulmck-ThinkPad-P17-Gen-1>
 <64b48a7b-624c-26bd-be9b-0522fc490b28@huaweicloud.com>
 <Y8q+u09ynxnvjVi5@rowland.harvard.edu>
 <ea37d3d9-4ed3-872a-aed9-f34c4553f6f1@huaweicloud.com>
 <Y8wimpMpajLudrYb@rowland.harvard.edu>
 <20230121184032.GF2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8xDieO/iYOk9Ty1@rowland.harvard.edu>
 <20230121201026.GH2948950@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230121201026.GH2948950@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 21, 2023 at 12:10:26PM -0800, Paul E. McKenney wrote:
> On Sat, Jan 21, 2023 at 02:56:57PM -0500, Alan Stern wrote:
> > > > Anyway, the operational model says the litmus test can succeed as 
> > > > follows:
> > > > 
> > > > P0                    P1                     P2
> > > > --------------------- ---------------------- -------------------------
> > > >                       Widx2=srcu_down_read()
> > > >                       Wrel p2=1
> > > >                       Ry=0
> > > >                                              Wy=1
> > > >                                              synchronize_srcu() starts
> > > > 	... idx2, p2, and y propagate to all CPUs ...
> > > >                                              Time t1
> > > > Widx1=srcu_down_read()
> > > > Wrel p1=1
> > > > 	,,, idx1 and p1 propagate to all CPUs ...
> > > >                       Racq p1=1
> > > >                       srcu_up_read(idx2)
> > > >                                              synchronize_srcu() ends
> > > >                                              Wx=1
> > > > Rx=1
> > > > Racq p2=1
> > > > Ridx2=idx1
> > > > srcu_up_read(idx1)
> > > > 
> > > > (The final equality in P0 is allowed because idx1 and idx2 are both 
> > > > random numbers, so they might be equal.)
> > > 
> > > This all makes sense to me.
> > > 
> > > > Incidentally, it's worth pointing out that the algorithm Paul described 
> > > > will forbid this litmus test even if you remove the while loop and the 
> > > > read of idx2 from P0.

> > Sorry, what I said may not have been clear.  I meant that even if you 
> > remove the while loop and read of idx2 from P0, your algorithm will 
> > still not allow idx1 = idx2 provided everything else is as written.
> 
> If synchronize_srcu() has flipped ->srcu_idx by the time that P0's
> srcu_down_read() executes, agreed.  Otherwise, Widx1 and Widx2 might
> well be equal.

But idx1 and idx2 are equal, we can't have both P0 reads x=1 and P1 
reads y=0 -- not even if P0 doesn't wait until it reads p2=1.  If you 
don't see why, I'll send an explanation.

Alan
