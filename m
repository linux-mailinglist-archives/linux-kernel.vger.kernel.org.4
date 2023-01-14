Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E02266AD13
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 18:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjANRfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 12:35:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjANRfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 12:35:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B68A5FC
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 09:35:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1E292B80A26
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 17:35:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78601C433D2;
        Sat, 14 Jan 2023 17:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673717740;
        bh=fBs/5/NDVcFubeobMWDUeAUal8/5m4Zof7EY5X0kI98=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=uFd1PMWzYbo1ePnDKwwVX2b8vi70IHmQsYAPQAXcAi2g1Yb9mqRS7WIEAsvzjcWa8
         aKyNoP9O6NL/KNCBGxE0zUu3gqz6PBII1RVv25Mey8bFZqdZywaZhgdvu//2dEygKC
         A2IHrltKzClDZsnUdSAuZCAqa7LVjLLOg7FKsmh4NMedeah15sCtrdfv0WG/c1vptn
         L6BnkmhOLPLF0Hxsu0VjF1e/YcbxSeTdGTJV/8T1qogX7ZtUjx63o54MrE3MEfFQDR
         r1NCopn7zzn633sLgGDHjoTmPeovjKkre3Ij3v1EFE8JUb7Ad9dp1lWlPMYpqVfs/y
         RcZEJNa/CPTBA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 16D2E5C0AF8; Sat, 14 Jan 2023 09:35:40 -0800 (PST)
Date:   Sat, 14 Jan 2023 09:35:40 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
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
Message-ID: <20230114173540.GC2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220921173109.GA1214281@paulmck-ThinkPad-P17-Gen-1>
 <YytfFiMT2Xsdwowf@rowland.harvard.edu>
 <YywXuzZ/922LHfjI@hirez.programming.kicks-ass.net>
 <114ECED5-FED1-4361-94F7-8D9BC02449B7>
 <Y77QbG9lVXX9/B87@rowland.harvard.edu>
 <4c1abc7733794519ad7c5153ae8b58f9@huawei.com>
 <Y8GGmstFlgg91RMp@rowland.harvard.edu>
 <20230113200706.GI4028633@paulmck-ThinkPad-P17-Gen-1>
 <Y8LedfOqSQrTPzGl@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8LedfOqSQrTPzGl@rowland.harvard.edu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 14, 2023 at 11:55:17AM -0500, Alan Stern wrote:
> On Fri, Jan 13, 2023 at 12:07:06PM -0800, Paul E. McKenney wrote:
> > What Alan said!  You could even have distinct partially overlapping
> > grace periods, as the Linux kernel actually does have courtesy of normal
> > grace periods via synchronize_rcu() and expedited grace periods via
> > synchronize_rcu_expedited().
> 
> Or just two different CPUs making overlapping calls to
> synchronize_rcu().

True, there could be two overlapping grace periods in that case.
If nothing else, one of those synchronize_rcu() calls could be preempted
for 500 milliseconds upon entry, thus overlapping many grace periods from
the viewpoint of the user.  Which is the viewpoint that LKMM should of
course take.

But because I had just been digging in the internals, I was taking
an implemntation-centric viewpoint.  From that viewpoint, there is at
most one normal grace period in flight at a time.  But even from that
viewpoint, there can also be a single independent expedited grace period
in flight at any given point in time, so partial overlap can happen even
from an implementation-centric viewpoint.

Which in no way negates or weakens your point, just letting you guys
know where I was coming from.  Because if things go as they normally do,
there will be a future discussion where my head will once again be deep
into the implementation.  ;-)

							Thanx, Paul
