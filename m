Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248D466AD9C
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 21:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjANUTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 15:19:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjANUTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 15:19:07 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 049846597
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 12:19:06 -0800 (PST)
Received: (qmail 71784 invoked by uid 1000); 14 Jan 2023 15:19:06 -0500
Date:   Sat, 14 Jan 2023 15:19:06 -0500
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
Message-ID: <Y8MOOrrHntA9TyUk@rowland.harvard.edu>
References: <YywXuzZ/922LHfjI@hirez.programming.kicks-ass.net>
 <114ECED5-FED1-4361-94F7-8D9BC02449B7>
 <Y77QbG9lVXX9/B87@rowland.harvard.edu>
 <4c1abc7733794519ad7c5153ae8b58f9@huawei.com>
 <Y8GGmstFlgg91RMp@rowland.harvard.edu>
 <20230113200706.GI4028633@paulmck-ThinkPad-P17-Gen-1>
 <20230113203241.GA2958699@paulmck-ThinkPad-P17-Gen-1>
 <136d019d8c8049f6b737627df830e66f@huawei.com>
 <20230114175343.GF2948950@paulmck-ThinkPad-P17-Gen-1>
 <20230114181537.GA493203@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230114181537.GA493203@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 14, 2023 at 10:15:37AM -0800, Paul E. McKenney wrote:
> Nevertheless, here is the resulting .bell fragment:
> 
> ------------------------------------------------------------------------
> 
> (* Compute matching pairs of Srcu-lock and Srcu-unlock *)
> let srcu-rscs = ([Srcu-lock] ; data ; [Srcu-unlock]) & loc
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

I forgot to mention...  An appropriate check for one srcu_read_lock() 
matched to more than one srcu_read_unlock() would be something like 
this:

flag ~empty (srcu-rscs^-1 ; srcu-rscs) \ id as multiple-unlocks

Alan

PS: Do you agree that we should change the names of the first two flags 
above to unbalanced-srcu-lock and unbalanced-srcu-unlock, respectively 
(and similarly for the rcu checks)?  It might help to be a little more 
specific about how the locking is wrong when we detect an error.
