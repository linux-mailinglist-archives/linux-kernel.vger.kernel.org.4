Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79032628B55
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 22:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237496AbiKNV1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 16:27:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236593AbiKNV06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 16:26:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F96B18B2B;
        Mon, 14 Nov 2022 13:26:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6E2D1B81259;
        Mon, 14 Nov 2022 21:26:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1262DC433D7;
        Mon, 14 Nov 2022 21:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668461214;
        bh=FEKLdvD1x1+OX8jH4GUGuzC3nWMigkkjN+eWPw4lNCo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=nno8N5wMf6d5OiVDxkaD1QC85M3xJGKPOGZT5APc5vN2pbdcHwSqpJ3Bd5lDpXJD4
         7+yEXG07rOdy/g5qHyWJmbYMokguzwW0tqc3kfJDZLy4UIN+C/5HrLW4O8KXjslcLH
         Ac6xokunzn71NWspTh3kXbQH8TvTaXBjWAT9WO2wphxViS+HxZ5+TnL/BvUr0WKwp7
         QAIpCXRI/pZa4e/FpQta+hARhnO1Yhi9+xNYrXeeRq3O5j913euTiFUz+S6S5i4ZoK
         6w3japXDHAsCPUP8xXuR1qyrlHDFmnMfcFE01wJ3LdwULbBdovQSFpTUifoYiUD9WI
         ia71Ct46rfZlw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A8A7C5C14FC; Mon, 14 Nov 2022 13:26:53 -0800 (PST)
Date:   Mon, 14 Nov 2022 13:26:53 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org
Subject: Re: [PATCH v2] rcu/kfree: Do not request RCU when not needed
Message-ID: <20221114212653.GG4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221109024758.2644936-1-joel@joelfernandes.org>
 <Y2z3Mb3u8bFZ12wY@pc636>
 <CAEXW_YSq89xzgyQ9Tdt1tCqz8VAfzb7kSXVZmnxDuJ65U0UZ3w@mail.gmail.com>
 <Y20EOinwcLSZHmXg@pc638.lan>
 <Y22ry4Q2OY2zovco@google.com>
 <Y3Iyka86FlUh9D1P@pc636>
 <20221114161733.GD4001@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YSGmHWdFJFcYH1UoqC8NT8V0ZGPf+_NdtepCbu8O1LMnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YSGmHWdFJFcYH1UoqC8NT8V0ZGPf+_NdtepCbu8O1LMnA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 03:54:30PM -0500, Joel Fernandes wrote:
> On Mon, Nov 14, 2022 at 11:17 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Mon, Nov 14, 2022 at 01:20:33PM +0100, Uladzislau Rezki wrote:
> > > > On Thu, Nov 10, 2022 at 03:01:30PM +0100, Uladzislau Rezki wrote:
> > > > > > Hi,
> > > > > >
> > > > > > On Thu, Nov 10, 2022 at 8:05 AM Uladzislau Rezki <urezki@gmail.com> wrote:
> > > > > >
> > > > > > > > On ChromeOS, using this with the increased timeout, we see that we
> > > > > > > almost always
> > > > > > > > never need to initiate a new grace period. Testing also shows this frees
> > > > > > > large
> > > > > > > > amounts of unreclaimed memory, under intense kfree_rcu() pressure.
> > > > > > > >
> > > > > > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > > > > > ---
> > > > > > > > v1->v2: Same logic but use polled grace periods instead of sampling
> > > > > > > gp_seq.
> > > > > > > >
> > > > > > > >  kernel/rcu/tree.c | 8 +++++++-
> > > > > > > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > > > > > > >
> > > > > > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > > > > > index 591187b6352e..ed41243f7a49 100644
> > > > > > > > --- a/kernel/rcu/tree.c
> > > > > > > > +++ b/kernel/rcu/tree.c
> > > > > > > > @@ -2935,6 +2935,7 @@ struct kfree_rcu_cpu_work {
> > > > > > > >
> > > > > > > >  /**
> > > > > > > >   * struct kfree_rcu_cpu - batch up kfree_rcu() requests for RCU grace
> > > > > > > period
> > > > > > > > + * @gp_snap: The GP snapshot recorded at the last scheduling of monitor
> > > > > > > work.
> > > > > > > >   * @head: List of kfree_rcu() objects not yet waiting for a grace period
> > > > > > > >   * @bkvhead: Bulk-List of kvfree_rcu() objects not yet waiting for a
> > > > > > > grace period
> > > > > > > >   * @krw_arr: Array of batches of kfree_rcu() objects waiting for a
> > > > > > > grace period
> > > > > > > > @@ -2964,6 +2965,7 @@ struct kfree_rcu_cpu {
> > > > > > > >       struct kfree_rcu_cpu_work krw_arr[KFREE_N_BATCHES];
> > > > > > > >       raw_spinlock_t lock;
> > > > > > > >       struct delayed_work monitor_work;
> > > > > > > > +     unsigned long gp_snap;
> > > > > > > >       bool initialized;
> > > > > > > >       int count;
> > > > > > > >
> > > > > > > > @@ -3167,6 +3169,7 @@ schedule_delayed_monitor_work(struct kfree_rcu_cpu
> > > > > > > *krcp)
> > > > > > > >                       mod_delayed_work(system_wq, &krcp->monitor_work,
> > > > > > > delay);
> > > > > > > >               return;
> > > > > > > >       }
> > > > > > > > +     krcp->gp_snap = get_state_synchronize_rcu();
> > > > > > > >       queue_delayed_work(system_wq, &krcp->monitor_work, delay);
> > > > > > > >  }
> > > > > > > >
> > > > > > > How do you guarantee a full grace period for objects which proceed
> > > > > > > to be placed into an input stream that is not yet detached?
> > > > > >
> > > > > >
> > > > > > Just replying from phone as I’m OOO today.
> > > > > >
> > > > > > Hmm, so you’re saying that objects can be queued after the delayed work has
> > > > > > been queued, but processed when the delayed work is run? I’m looking at
> > > > > > this code after few years so I may have missed something.
> > > > > >
> > > > > > That’s a good point and I think I missed that. I think your version did too
> > > > > > but I’ll have to double check.
> > > > > >
> > > > > > The fix then is to sample the clock for the latest object queued, not for
> > > > > > when the delayed work is queued.
> > > > > >
> > > > > The patch i sent gurantee it. Just in case see v2:
> > > >
> > > > You are right and thank you! CBs can be queued while the monitor timer is in
> > > > progress. So we need to sample unconditionally. I think my approach is still
> > > > better since I take advantage of multiple seconds (I update snapshot on every
> > > > CB queue monitor and sample in the monitor handler).
> > > >
> > > > Whereas your patch is snapshotting before queuing the regular work and when
> > > > the work is executed (This is a much shorter duration and I bet you would be
> > > > blocking in cond_synchronize..() more often).
> > > >
> > > There is a performance test that measures a taken time and memory
> > > footprint, so you can do a quick comparison. A "rcutorture" can be
> > > run with various parameters to figure out if a patch that is in question
> > > makes any difference.
> > >
> > > Usually i run it as:
> > >
> > > <snip>
> > > #! /usr/bin/env bash
> > >
> > > LOOPS=10
> > >
> > > for (( i=0; i<$LOOPS; i++ )); do
> > >         tools/testing/selftests/rcutorture/bin/kvm.sh --memory 10G --torture rcuscale --allcpus --duration 1 \
> > >         --kconfig CONFIG_NR_CPUS=64 \
> > >         --kconfig CONFIG_RCU_NOCB_CPU=y \
> > >         --kconfig CONFIG_RCU_NOCB_CPU_DEFAULT_ALL=y \
> > >         --kconfig CONFIG_RCU_LAZY=n \
> > >         --bootargs "rcuscale.kfree_rcu_test=1 rcuscale.kfree_nthreads=16 rcuscale.holdoff=20 rcuscale.kfree_loops=10000 torture.disable_onoff_at_boot" --trust-make
> > >         echo "Done $i"
> > > done
> > > <snip>
> > >
> > > just run it from your linux sandbox.
> >
> > Would it make sense to modify the "if test "$do_kvfree" = "yes" code
> > in tools/testing/selftests/rcutorture/bin/torture.sh to do something
> > like this instead of what it currently does?
> 
> Yes I think so, Were you also thinking of adding it to
> tools/testing/selftests/rcutorture/configs with a corresponding
> ".boot" file for the kfree test's boot parameters?

No, because I run torture.sh reasonably frequently, and the style of
test makes it better to run separately in that way.  In particular,
it needs lots of memory and runs for a short duration.  This is not all
that compatible with typical rcutorture runs, where lots of scenarios run
concurrently (thus limiting each VM's memory) and for long time periods.

> If it means the bots will run it more, that would be awesome :-)

I am not quite ready to have the bots run torture.sh.  Though maybe
with --do-no-scf it would be fine?

							Thanx, Paul
