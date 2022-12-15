Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC9764E238
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 21:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiLOUOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 15:14:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiLOUOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 15:14:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5053C2F65F;
        Thu, 15 Dec 2022 12:13:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EFCC1B81C44;
        Thu, 15 Dec 2022 20:13:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94106C433D2;
        Thu, 15 Dec 2022 20:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671135236;
        bh=i13fFd0vVoW19qKA7a1/ZjxtdH485J2NXxuF+yBDT/A=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=A0KEf2Wqn6A8qu4NhFe73fk8nbFNYdIHJxzWPs4cnmogUvDTqp6ysYgnwy0jW2hlf
         tCw9cjL5pR+Z1cz+UtNpvauieWynZNcKEmdMwXOrqZGlrLvlSVRBsm8nIgghy8gbd2
         jO/bwTCA1ULQQyoHhB4+TiKWSLZZTpZ+3SSpgxkdwr5kbQZ6Qc6oG3kk7UCcZDuRIX
         jkyqrqoi7nSl8L6kbjtGgV2iURFu3REZkKa870gQvZrLM+i/1rkCPD9fKKU51v4rA+
         a9RxYLRuVKSpOz34wECKy4LBWhkWtjPU/kzQsobuqydp39ApyUGlFuSO++FiOh5ehv
         UvVFwemvAq7/g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 34DD15C09D0; Thu, 15 Dec 2022 12:13:56 -0800 (PST)
Date:   Thu, 15 Dec 2022 12:13:56 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>, boqun.feng@gmail.com,
        neeraj.iitr10@gmail.com, urezki@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] srcu: Yet more detail for
 srcu_readers_active_idx_check() comments
Message-ID: <20221215201356.GM4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221214191355.GA2596199@paulmck-ThinkPad-P17-Gen-1>
 <20221215165452.GA1957735@lothringen>
 <20221215170834.GH4001@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YTSW9kr3DsJm6hTQ0FfwVbVjzDa8=7H29+ysD10ZCbnHA@mail.gmail.com>
 <CAEXW_YQEZSdny005w314zNQMmS7MHMjp-WwAvV6k9hDhhzQmdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YQEZSdny005w314zNQMmS7MHMjp-WwAvV6k9hDhhzQmdA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022 at 05:58:14PM +0000, Joel Fernandes wrote:
> On Thu, Dec 15, 2022 at 5:48 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > On Thu, Dec 15, 2022 at 5:08 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > > > Scenario for the reader to increment the old idx once:
> > > >
> > > > _ Assume ssp->srcu_idx is initially 0.
> > > > _ The READER reads idx that is 0
> > > > _ The updater runs and flips the idx that is now 1
> > > > _ The reader resumes with 0 as an index but on the next srcu_read_lock()
> > > >   it will see the new idx which is 1
> > > >
> > > > What could be the scenario for it to increment the old idx twice?
> > >
> > > Unless I am missing something, the reader must reference the
> > > srcu_unlock_count[old_idx] and then do smp_mb() before it will be
> > > absolutely guaranteed of seeing the new value of ->srcu_idx.
> >
> > I think both of you are right depending on how the flip raced with the
> > first reader's unlock in that specific task.
> >
> > If the first read section's srcu_read_unlock() and its corresponding
> > smp_mb()  happened before the flip, then the increment of old idx
> > would happen only once. The next srcu_read_lock() will read the new
> > index. If the srcu_read_unlock() and it's corresponding smp_mb()
> > happened after the flip, the old_idx will be sampled again and can be
> > incremented twice. So it depends on how the flip races with
> > srcu_read_unlock().
> 
> I am sorry this is inverted, but my statement's gist stands I believe:
> 
> 1. Flip+smp_mb() happened before unlock's smp_mb() -- reader will not
> increment old_idx the second time.

By "increment old_idx" you mean "increment ->srcu_lock_count[old_idx]",
correct?

Again, the important ordering isn't the smp_mb(), but the accesses,
in this case, the accesses to ->srcu_unlock_count[idx].

> 2. unlock()'s smp_mb() happened before Flip+smp_mb() , now the reader
> has no new smp_mb() that happens AFTER the flip happened. So it can
> totally sample the old idx again -- that particular reader will
> increment twice, but the next time, it will see the flipped one.

I will let you transliterate both.  ;-)

> Did I get that right? Thanks.

So why am I unhappy with orderings of smp_mb()?

To see this, let's take the usual store-buffering litmus test:

	CPU 0			CPU 1
	WRITE_ONCE(x, 1);	WRITE_ONCE(y, 1);
	smp_mb();		smp_mb();
	r0 = READ_ONCE(y);	r1 = READ_ONCE(x);

Suppose CPU 0's smp_mb() happens before that of CPU 1:

	CPU 0			CPU 1
	WRITE_ONCE(x, 1);	WRITE_ONCE(y, 1);
	smp_mb();
				smp_mb();
	r0 = READ_ONCE(y);	r1 = READ_ONCE(x);

We get r0 == r1 == 1.

Compare this to CPU 1's smp_mb() happening before that of CPU 0:

	CPU 0			CPU 1
	WRITE_ONCE(x, 1);	WRITE_ONCE(y, 1);
				smp_mb();
	smp_mb();
	r0 = READ_ONCE(y);	r1 = READ_ONCE(x);

We still get r0 == r1 == 1.  Reversing the order of the two smp_mb()
calls changed nothing.

But, if we order CPU 1's write to follow CPU 0's read, then we have
this:

	CPU 0			CPU 1
	WRITE_ONCE(x, 1);
	smp_mb();
	r0 = READ_ONCE(y);
				WRITE_ONCE(y, 1);
				smp_mb();
				r1 = READ_ONCE(x);

Here, given that r0 had the final value of zero, we know that
r1 must have a final value of 1.

And suppose we reverse this:

	CPU 0			CPU 1
				WRITE_ONCE(y, 1);
				smp_mb();
				r1 = READ_ONCE(x);
	WRITE_ONCE(x, 1);
	smp_mb();
	r0 = READ_ONCE(y);

Now there is a software-visible difference in behavior.  The value of
r0 is now 1 instead of zero and the value of r1 is now 0 instead of 1.

Does this make sense?

							Thanx, Paul
