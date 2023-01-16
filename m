Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA0D66B696
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 05:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbjAPEXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 23:23:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbjAPEXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 23:23:35 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06527287
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 20:23:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 38727CE0E6D
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 04:23:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40587C433F1;
        Mon, 16 Jan 2023 04:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673843010;
        bh=uBwOkwg1UCWxHI6qxy+Mb2Hb07Za0sTuWaXP/3A1mSo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=AdBGaBotY6RfxcQGTYZTYZk26vYbZcEmOtClkzBY/v5X3SltTru6ceQoUrAxs4P+t
         1Km1nH3QxAckZwmvY+OsFES4frQJ8NpaL94UcVwb/DVHfJZEH/XRu3R1optyS4GPbi
         vBwnYpcKDzFW6Q1eEjdCAzL+gFTUnrNmXkg4pKHvAb0Ylq7DZxFPgs5BN3eGwzGU66
         WF0OFm4XezJzgpjUpZDDSfHfxlOsS1IvCtBWFAJNeF2du9Oz76OCQdIAWpUgZZP/7k
         dWIcqY2zWl8EaGq2awNPP7vfQKFshuQKRJxwZDQ97/Sfb0/Gb4QLf+ul0tlGJvYsgM
         lOnh4tRmxiogA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A07615C05A0; Sun, 15 Jan 2023 20:23:29 -0800 (PST)
Date:   Sun, 15 Jan 2023 20:23:29 -0800
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
Message-ID: <20230116042329.GN2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230113200706.GI4028633@paulmck-ThinkPad-P17-Gen-1>
 <20230113203241.GA2958699@paulmck-ThinkPad-P17-Gen-1>
 <136d019d8c8049f6b737627df830e66f@huawei.com>
 <20230114175343.GF2948950@paulmck-ThinkPad-P17-Gen-1>
 <20230114181537.GA493203@paulmck-ThinkPad-P17-Gen-1>
 <Y8MOOrrHntA9TyUk@rowland.harvard.edu>
 <20230115051510.GG2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8Qog8qf7wIx2Kve@rowland.harvard.edu>
 <20230115181052.GJ2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8RmEtBnwqOzNhsK@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8RmEtBnwqOzNhsK@rowland.harvard.edu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 15, 2023 at 03:46:10PM -0500, Alan Stern wrote:
> On Sun, Jan 15, 2023 at 10:10:52AM -0800, Paul E. McKenney wrote:
> > On Sun, Jan 15, 2023 at 11:23:31AM -0500, Alan Stern wrote:
> > > On Sat, Jan 14, 2023 at 09:15:10PM -0800, Paul E. McKenney wrote:
> > > > What am I missing here?
> > > 
> > > I don't think you're missing anything.  This is a matter for Boqun or 
> > > Luc; it must have something to do with the way herd treats the 
> > > srcu_read_lock() and srcu_read_unlock() primitives.
> > 
> > It looks like we need something that tracks (data | rf)* between
> > the return value of srcu_read_lock() and the second parameter of
> > srcu_read_unlock().  The reason for rf rather than rfi is the upcoming
> > srcu_down_read() and srcu_up_read().
> 
> Or just make herd treat srcu_read_lock(s) as an annotated equivalent of 
> READ_ONCE(&s) and srcu_read_unlock(s, v) as an annotated equivalent of 
> WRITE_ONCE(s, v).  But with some special accomodation to avoid 
> interaction with the new carry-dep relation.

This is a modification to herd7 you are suggesting?  Otherwise, I am
suffering a failure of imagination on how to properly sort it from the
other READ_ONCE() and WRITE_ONCE() instances.

> > But what I will do in the meantime is to switch back to a commit that
> > simply flags nesting of same-srcu_struct SRCU read-side critical sections,
> > while blindly assuming that the return value of a given srcu_read_lock()
> > is passed in to the corresponding srcu_read_unlock():
> > 
> > ------------------------------------------------------------------------
> > 
> > (* Compute matching pairs of Srcu-lock and Srcu-unlock, but prohibit nesting *)
> > let srcu-unmatched = Srcu-lock | Srcu-unlock
> > let srcu-unmatched-po = ([srcu-unmatched] ; po ; [srcu-unmatched]) & loc
> > let srcu-unmatched-locks-to-unlock = ([Srcu-lock] ; po ; [Srcu-unlock]) & loc
> > let srcu-rscs = srcu-unmatched-locks-to-unlock \ (srcu-unmatched-po ; srcu-unmatched-po)
> > 
> > (* Validate nesting *)
> > flag ~empty Srcu-lock \ domain(srcu-rscs) as unbalanced-srcu-locking
> > flag ~empty Srcu-unlock \ range(srcu-rscs) as unbalanced-srcu-locking
> > 
> > (* Check for use of synchronize_srcu() inside an RCU critical section *)
> > flag ~empty rcu-rscs & (po ; [Sync-srcu] ; po) as invalid-sleep
> > 
> > (* Validate SRCU dynamic match *)
> > flag ~empty different-values(srcu-rscs) as srcu-bad-nesting
> > 
> > ------------------------------------------------------------------------
> > 
> > Or is there some better intermediate position that could be taken?
> 
> Do you mean go back to the current linux-kernel.bell?  The code you 
> wrote above is different, since it prohibits nesting.

Not to the current linux-kernel.bell, but, as you say, making the change
to obtain a better approximation by prohibiting nesting.

							Thanx, Paul
