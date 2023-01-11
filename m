Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA26665EBE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 16:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239381AbjAKPGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 10:06:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239532AbjAKPG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 10:06:26 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 4CE207654
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 07:06:21 -0800 (PST)
Received: (qmail 713672 invoked by uid 1000); 11 Jan 2023 10:06:20 -0500
Date:   Wed, 11 Jan 2023 10:06:20 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Jonas Oberhauser <jonas.oberhauser@huawei.com>
Cc:     "paulmck@kernel.org" <paulmck@kernel.org>,
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
Message-ID: <Y77QbG9lVXX9/B87@rowland.harvard.edu>
References: <20220921173109.GA1214281@paulmck-ThinkPad-P17-Gen-1>
 <YytfFiMT2Xsdwowf@rowland.harvard.edu>
 <YywXuzZ/922LHfjI@hirez.programming.kicks-ass.net>
 <114ECED5-FED1-4361-94F7-8D9BC02449B7>
 <Y7R6SPHGS9U/T6IC@rowland.harvard.edu>
 <ee186bc17a5e48298a5373f688496dce@huawei.com>
 <20230105173218.GB4028633@paulmck-ThinkPad-P17-Gen-1>
 <bea712c82e6346f8973399a5711ff78a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bea712c82e6346f8973399a5711ff78a@huawei.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 11:33:33AM +0000, Jonas Oberhauser wrote:
> 
> 
> -----Original Message-----
> From: Paul E. McKenney [mailto:paulmck@kernel.org] 
> Sent: Thursday, January 5, 2023 6:32 PM
> > On Wed, Jan 04, 2023 at 11:13:05AM +0000, Jonas Oberhauser wrote:
> > > -----Original Message-----
> > > From: Alan Stern [mailto:stern@rowland.harvard.edu]
> > > Sent: Tuesday, January 3, 2023 7:56 PM
> > > > That all sounds good to me.  However, I wonder if it might be better to use "strong-order" (and similar) for the new relation name instead of "strong-sync".  The idea being that fences are about ordering, not (or not directly) about synchronization.
> > 
> > > I think that is indeed better, thanks. I suppose *-sync might be more appropriate if it *only* included edges between threads.
> 
> > There are quite a few ways to group the relations.  As long as we don't end up oscillating back and forth with too short a frequency, I am good.  ;-)
> 
> Considering how much effort it is to keep the documentation up-to-date 
> even for small changes, I'm extremely oscillation-averse. 
> Interestingly as I go through the documentation while preparing each 
> patch I often find some remarks hinting at the content of the patch, 
> e.g. "fences don't link events on different CPUs" and "rcu-fence is 
> able to link events on different CPUs.  (Perhaps this fact should lead 
> us to say that rcu-fence isn't really a fence at all!)" in the current 
> explanation.txt.
> 
> Following the instructions sent to me by Andrea earlier, right now my 
> plan is to first address the strong ordering in one patch, and then 
> address this perhaps unlucky name of the other "fences" in a second 
> patch. Let me know if this is incorrect, as there is some overlap in 
> that I'll use strong-order right away, and then rename the handful of 
> other fences-but-not-really-at-all to '-order' as well.

Minor snag: There already is an rcu-order relation in the memory model.
Maybe we need a different word from "order".  Or maybe rcu-order should 
be renamed.

Alan
