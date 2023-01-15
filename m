Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3245166B362
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 19:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjAOSLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 13:11:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbjAOSK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 13:10:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09643559B
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 10:10:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7E421B80B74
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 18:10:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA56AC433D2;
        Sun, 15 Jan 2023 18:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673806253;
        bh=WDzAhlRdkI4eyrDuAUBRPEGhbdQxWLcxJHpob12gE18=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=U0QXKmGH8ZCynyPU9PpRatBL372gjbUs6xb9fMBGVCf7+bwfoIUm2dY7RJb5CyVNy
         y5vwYzqVc7m8aYNpVAT4fd9CEPqxkp4dc8eojH2GxRyU8YHKbSywcW6LdxhK5oJgF6
         YgXRyh2ZKt1jxc4CrVzyI+Nq+atQ1KVSIxtV0OwM+SkFefLlR4Jh4WW8Zptkhipe5Q
         +7OAotCzXE2WYGuhQq2mKAsFjkJo7mmXqv9NQEc8/a86ebu89M7CYE1ivPn5NUaJOs
         kYub4By5Z0PwYtaT0c5Vr9CNdkTMk14WA7IT580U/jVcCIm+kQ4nVTgl8taLD23Q2F
         ZWJeweqUYKIAA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 8173F5C0687; Sun, 15 Jan 2023 10:10:52 -0800 (PST)
Date:   Sun, 15 Jan 2023 10:10:52 -0800
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
Message-ID: <20230115181052.GJ2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <4c1abc7733794519ad7c5153ae8b58f9@huawei.com>
 <Y8GGmstFlgg91RMp@rowland.harvard.edu>
 <20230113200706.GI4028633@paulmck-ThinkPad-P17-Gen-1>
 <20230113203241.GA2958699@paulmck-ThinkPad-P17-Gen-1>
 <136d019d8c8049f6b737627df830e66f@huawei.com>
 <20230114175343.GF2948950@paulmck-ThinkPad-P17-Gen-1>
 <20230114181537.GA493203@paulmck-ThinkPad-P17-Gen-1>
 <Y8MOOrrHntA9TyUk@rowland.harvard.edu>
 <20230115051510.GG2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8Qog8qf7wIx2Kve@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8Qog8qf7wIx2Kve@rowland.harvard.edu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 15, 2023 at 11:23:31AM -0500, Alan Stern wrote:
> On Sat, Jan 14, 2023 at 09:15:10PM -0800, Paul E. McKenney wrote:
> > On Sat, Jan 14, 2023 at 03:19:06PM -0500, Alan Stern wrote:
> > > On Sat, Jan 14, 2023 at 10:15:37AM -0800, Paul E. McKenney wrote:
> > > > Nevertheless, here is the resulting .bell fragment:
> > > > 
> > > > ------------------------------------------------------------------------
> > > > 
> > > > (* Compute matching pairs of Srcu-lock and Srcu-unlock *)
> > > > let srcu-rscs = ([Srcu-lock] ; data ; [Srcu-unlock]) & loc
> > > > 
> > > > (* Validate nesting *)
> > > > flag ~empty Srcu-lock \ domain(srcu-rscs) as unbalanced-srcu-locking
> > > > flag ~empty Srcu-unlock \ range(srcu-rscs) as unbalanced-srcu-locking
> > > > 
> > > > (* Check for use of synchronize_srcu() inside an RCU critical section *)
> > > > flag ~empty rcu-rscs & (po ; [Sync-srcu] ; po) as invalid-sleep
> > > > 
> > > > (* Validate SRCU dynamic match *)
> > > > flag ~empty different-values(srcu-rscs) as srcu-bad-nesting
> > > 
> > > I forgot to mention...  An appropriate check for one srcu_read_lock() 
> > > matched to more than one srcu_read_unlock() would be something like 
> > > this:
> > > 
> > > flag ~empty (srcu-rscs^-1 ; srcu-rscs) \ id as multiple-unlocks
> > 
> > I have added this, thank you!
> > 
> > > Alan
> > > 
> > > PS: Do you agree that we should change the names of the first two flags 
> > > above to unbalanced-srcu-lock and unbalanced-srcu-unlock, respectively 
> > > (and similarly for the rcu checks)?  It might help to be a little more 
> > > specific about how the locking is wrong when we detect an error.
> > 
> > I have made this change, again, thank you!
> > 
> > But I also added this:
> > 
> > flag empty srcu-rscs as no-srcu-readers
> > 
> > And it is always flagged.  So far, I have not found any sort of relation
> > that connects Srcu-lock to Srcu-unlock other than po.  I tried data,
> > ctrl, addr, rf, rfi, and combinations thereof.
> > 
> > What am I missing here?
> 
> I don't think you're missing anything.  This is a matter for Boqun or 
> Luc; it must have something to do with the way herd treats the 
> srcu_read_lock() and srcu_read_unlock() primitives.

It looks like we need something that tracks (data | rf)* between
the return value of srcu_read_lock() and the second parameter of
srcu_read_unlock().  The reason for rf rather than rfi is the upcoming
srcu_down_read() and srcu_up_read().

But what I will do in the meantime is to switch back to a commit that
simply flags nesting of same-srcu_struct SRCU read-side critical sections,
while blindly assuming that the return value of a given srcu_read_lock()
is passed in to the corresponding srcu_read_unlock():

------------------------------------------------------------------------

(* Compute matching pairs of Srcu-lock and Srcu-unlock, but prohibit nesting *)
let srcu-unmatched = Srcu-lock | Srcu-unlock
let srcu-unmatched-po = ([srcu-unmatched] ; po ; [srcu-unmatched]) & loc
let srcu-unmatched-locks-to-unlock = ([Srcu-lock] ; po ; [Srcu-unlock]) & loc
let srcu-rscs = srcu-unmatched-locks-to-unlock \ (srcu-unmatched-po ; srcu-unmatched-po)

(* Validate nesting *)
flag ~empty Srcu-lock \ domain(srcu-rscs) as unbalanced-srcu-locking
flag ~empty Srcu-unlock \ range(srcu-rscs) as unbalanced-srcu-locking

(* Check for use of synchronize_srcu() inside an RCU critical section *)
flag ~empty rcu-rscs & (po ; [Sync-srcu] ; po) as invalid-sleep

(* Validate SRCU dynamic match *)
flag ~empty different-values(srcu-rscs) as srcu-bad-nesting

------------------------------------------------------------------------

Or is there some better intermediate position that could be taken?

						Thanx, Paul
