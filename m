Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3137A64E58F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 02:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiLPBN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 20:13:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiLPBN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 20:13:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093A12CE32;
        Thu, 15 Dec 2022 17:13:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BBDB6B81CF6;
        Fri, 16 Dec 2022 01:13:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E606C433D2;
        Fri, 16 Dec 2022 01:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671153203;
        bh=sUqE3VXTWozBffwwYpaZ2epjOPCYn1HioBPYHUQ7BbE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=aTkS/l17fh4qS3syVi2jGKfy/9SUQDuuaRQ1tIYf4IKz4zgwYhX9jXOwOtxxpfon8
         8D0HuHS0SzunDLavezR3Y0FLolRVTJiS17gVYdkYEE64rFZ7BmorrdyQOGFTtje+tq
         e4GtGkC/24jinQEZqcpPrHWChAGufTrG1UNh7cGTfTNNOhMmxc23xYqBIYYgcKpB7s
         ugMOghjntqFwW548ne54EABkaNp6b4IuTUUwEr+CEFsTWmEOypeVIefasNuAZKI4t6
         6Yj3RP2eLKlWuEF3sWeZGmSOB5mnWC/e/WniMcDlY7nF6g6/mKv0tLmWrDeAJhINhv
         daNTC6sZfjczA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E9F2D5C1C5B; Thu, 15 Dec 2022 17:13:22 -0800 (PST)
Date:   Thu, 15 Dec 2022 17:13:22 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>, boqun.feng@gmail.com,
        neeraj.iitr10@gmail.com, urezki@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] srcu: Yet more detail for
 srcu_readers_active_idx_check() comments
Message-ID: <20221216011322.GY4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <EE4EC3CC-395E-475D-BEBE-545955AB97C8@joelfernandes.org>
 <07A65F0F-89CE-481B-BD6C-6D4946E70482@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <07A65F0F-89CE-481B-BD6C-6D4946E70482@joelfernandes.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022 at 05:22:21PM -0500, Joel Fernandes wrote:
> > On Dec 15, 2022, at 5:13 PM, Joel Fernandes <joel@joelfernandes.org> wrote:
> >> On Dec 15, 2022, at 3:13 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
> >> 
> >> ﻿On Thu, Dec 15, 2022 at 05:58:14PM +0000, Joel Fernandes wrote:
> >>>> On Thu, Dec 15, 2022 at 5:48 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> >>>> 
> >>>>>> On Thu, Dec 15, 2022 at 5:08 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >>>>> 
> >>>>>>> Scenario for the reader to increment the old idx once:
> >>>>>>> 
> >>>>>>> _ Assume ssp->srcu_idx is initially 0.
> >>>>>>> _ The READER reads idx that is 0
> >>>>>>> _ The updater runs and flips the idx that is now 1
> >>>>>>> _ The reader resumes with 0 as an index but on the next srcu_read_lock()
> >>>>>>> it will see the new idx which is 1
> >>>>>>> 
> >>>>>>> What could be the scenario for it to increment the old idx twice?
> >>>>>> 
> >>>>>> Unless I am missing something, the reader must reference the
> >>>>>> srcu_unlock_count[old_idx] and then do smp_mb() before it will be
> >>>>>> absolutely guaranteed of seeing the new value of ->srcu_idx.
> >>>>> 
> >>>>> I think both of you are right depending on how the flip raced with the
> >>>>> first reader's unlock in that specific task.
> >>>>> 
> >>>>> If the first read section's srcu_read_unlock() and its corresponding
> >>>>> smp_mb()  happened before the flip, then the increment of old idx
> >>>>> would happen only once. The next srcu_read_lock() will read the new
> >>>>> index. If the srcu_read_unlock() and it's corresponding smp_mb()
> >>>>> happened after the flip, the old_idx will be sampled again and can be
> >>>>> incremented twice. So it depends on how the flip races with
> >>>>> srcu_read_unlock().
> >>> 
> >>> I am sorry this is inverted, but my statement's gist stands I believe:
> >>> 
> >>> 1. Flip+smp_mb() happened before unlock's smp_mb() -- reader will not
> >>> increment old_idx the second time.
> >> 
> >> By "increment old_idx" you mean "increment ->srcu_lock_count[old_idx]",
> >> correct?
> > 
> > Yes sorry for confusing, i indeed meant lock count increment corresponding to the old index.
> >> 
> >> Again, the important ordering isn't the smp_mb(), but the accesses,
> >> in this case, the accesses to ->srcu_unlock_count[idx].
> > 
> > I was talking about ordering of the flip of index (write) with respect to both the reading of the old index  in the rcu_read_lock() and its subsequent lock count increment corresponding to that index. I believe we are talking her about how this race can effect the wrap around issues when scanning for readers in the pre flip index, and we concluded that there can be at most 2 of these on the SAME task. The third time, reader will always see the new flipped index because of the memory barriers on both sides. IOW, the same task cannot overflow the lock counter on the preflipped index and cause issues. However there can be Nt different tasks so perhaps you can have 2*Nt number of preempted
> 
> Sorry, to be more precise, I mean you have Nt preempted readers, which owing to memory barriers, if you have at least Nt CPUs, and they each ran on those CPUs, then you can have 2*Nt increments on the lock count at the old index. 
> 
> Or something.

Agreed!

And if there are more tasks than CPUs, the maximum number of increments
is Nt+Nc.

								Thanx, Paul

> Thanks.
> 
> 
> 
> 
> > readers that had sampled the old index and now will do a lock and unlock on that old index, potentially causing a lock==unlock match when there should not be a match.
> > 
> >> 
> >>> 2. unlock()'s smp_mb() happened before Flip+smp_mb() , now the reader
> >>> has no new smp_mb() that happens AFTER the flip happened. So it can
> >>> totally sample the old idx again -- that particular reader will
> >>> increment twice, but the next time, it will see the flipped one.
> >> 
> >> I will let you transliterate both.  ;-)
> > 
> > I think I see what you mean now :)
> > 
> > I believe the access I am referring to is the read of idx on one side and the write to idx on the other. However that is incomplete and I need to pair that with some of other access on both sides.
> > 
> > So perhaps this:
> > 
> > Writer does flip + smp_mb + read unlock counts [1]
> > 
> > Reader does:
> > read idx + smp_mb() + increment lock counts [2]
> > 
> > And subsequently reader does
> > Smp_mb() + increment unlock count. [3]
> > 
> > So [1] races with either [2] or [2]+[3].
> > 
> > Is that fair?
> > 
> >>> Did I get that right? Thanks.
> >> 
> >> So why am I unhappy with orderings of smp_mb()?
> >> 
> >> To see this, let's take the usual store-buffering litmus test:
> >> 
> >>   CPU 0            CPU 1
> >>   WRITE_ONCE(x, 1);    WRITE_ONCE(y, 1);
> >>   smp_mb();        smp_mb();
> >>   r0 = READ_ONCE(y);    r1 = READ_ONCE(x);
> >> 
> >> Suppose CPU 0's smp_mb() happens before that of CPU 1:
> >> 
> >>   CPU 0            CPU 1
> >>   WRITE_ONCE(x, 1);    WRITE_ONCE(y, 1);
> >>   smp_mb();
> >>               smp_mb();
> >>   r0 = READ_ONCE(y);    r1 = READ_ONCE(x);
> >> 
> >> We get r0 == r1 == 1.
> >> 
> >> Compare this to CPU 1's smp_mb() happening before that of CPU 0:
> >> 
> >>   CPU 0            CPU 1
> >>   WRITE_ONCE(x, 1);    WRITE_ONCE(y, 1);
> >>               smp_mb();
> >>   smp_mb();
> >>   r0 = READ_ONCE(y);    r1 = READ_ONCE(x);
> >> 
> >> We still get r0 == r1 == 1.  Reversing the order of the two smp_mb()
> >> calls changed nothing.
> >> 
> >> But, if we order CPU 1's write to follow CPU 0's read, then we have
> >> this:
> >> 
> >>   CPU 0            CPU 1
> >>   WRITE_ONCE(x, 1);
> >>   smp_mb();
> >>   r0 = READ_ONCE(y);
> >>               WRITE_ONCE(y, 1);
> >>               smp_mb();
> >>               r1 = READ_ONCE(x);
> >> 
> >> Here, given that r0 had the final value of zero, we know that
> >> r1 must have a final value of 1.
> >> 
> >> And suppose we reverse this:
> >> 
> >>   CPU 0            CPU 1
> >>               WRITE_ONCE(y, 1);
> >>               smp_mb();
> >>               r1 = READ_ONCE(x);
> >>   WRITE_ONCE(x, 1);
> >>   smp_mb();
> >>   r0 = READ_ONCE(y);
> >> 
> >> Now there is a software-visible difference in behavior.  The value of
> >> r0 is now 1 instead of zero and the value of r1 is now 0 instead of 1.
> >> 
> >> Does this make sense?
> > 
> > Yes I see what you mean. In first case, smp_mb() ordering didn’t matter. But in the second case it does.
> > 
> > Thanks,
> > 
> > - Joel
> > 
> > 
> >> 
> >>                           Thanx, Paul
