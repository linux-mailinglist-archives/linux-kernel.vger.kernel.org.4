Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7CD6A2D29
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 03:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjBZC3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 21:29:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjBZC3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 21:29:54 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id C50EBE3A5
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 18:29:52 -0800 (PST)
Received: (qmail 82207 invoked by uid 1000); 25 Feb 2023 21:29:51 -0500
Date:   Sat, 25 Feb 2023 21:29:51 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        dlustig@nvidia.com, joel@joelfernandes.org, urezki@gmail.com,
        quic_neeraju@quicinc.com, frederic@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] tools/memory-model: Make ppo a subrelation of po
Message-ID: <Y/rEH2r9i0BtfxEW@rowland.harvard.edu>
References: <20230224135251.24989-1-jonas.oberhauser@huaweicloud.com>
 <Y/jYm0AZfPHkIalK@rowland.harvard.edu>
 <20230224183758.GQ2948950@paulmck-ThinkPad-P17-Gen-1>
 <20230226010110.GA1576556@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230226010110.GA1576556@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 25, 2023 at 05:01:10PM -0800, Paul E. McKenney wrote:
> A few other oddities:
> 
> litmus/auto/C-LB-Lww+R-OC.litmus
> 
> 	Both versions flag a data race, which I am not seeing.	It appears
> 	to me that P1's store to u0 cannot happen unless P0's store
> 	has completed.  So what am I missing here?

The LKMM doesn't believe that a control or data dependency orders a 
plain write after a marked read.  Hence in this test it thinks that P1's 
store to u0 can happen before the load of x1.  I don't remember why we 
did it this way -- probably we just wanted to minimize the restrictions 
on when plain accesses can execute.  (I do remember the reason for 
making address dependencies induce order; it was so RCU would work.)

The patch below will change what the LKMM believes.  It eliminates the 
positive outcome of the litmus test and the data race.  Should it be 
adopted into the memory model?

> litmus/auto/C-LB-Lrw+R-OC.litmus
> litmus/auto/C-LB-Lww+R-Oc.litmus
> litmus/auto/C-LB-Lrw+R-Oc.litmus
> litmus/auto/C-LB-Lrw+R-A+R-Oc.litmus
> litmus/auto/C-LB-Lww+R-A+R-OC.litmus
> 
> 	Ditto.  (There are likely more.)

I haven't looked at these but they're probably similar.

Alan



--- usb-devel.orig/tools/memory-model/linux-kernel.cat
+++ usb-devel/tools/memory-model/linux-kernel.cat
@@ -172,7 +172,7 @@ let vis = cumul-fence* ; rfe? ; [Marked]
 	((strong-fence ; [Marked] ; xbstar) | (xbstar & int))
 
 (* Boundaries for lifetimes of plain accesses *)
-let w-pre-bounded = [Marked] ; (addr | fence)?
+let w-pre-bounded = [Marked] ; (rwdep | fence)?
 let r-pre-bounded = [Marked] ; (addr | nonrw-fence |
 	([R4rmb] ; fencerel(Rmb) ; [~Noreturn]))?
 let w-post-bounded = fence? ; [Marked] ; rmw-sequence
