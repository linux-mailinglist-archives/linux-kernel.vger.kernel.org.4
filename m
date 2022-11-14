Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D30B6284E4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237489AbiKNQSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:18:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237418AbiKNQRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:17:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864622EF20;
        Mon, 14 Nov 2022 08:17:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 424B5B8105F;
        Mon, 14 Nov 2022 16:17:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE488C433C1;
        Mon, 14 Nov 2022 16:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668442654;
        bh=8ch4EQw2RQcU4v2aPE4PxOMAb0sV9YuUbfQfBTcLzdA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=X6dM0QmwVhUDqqtHsdmJzjwBfCCuaeP7IPhCI+KeTrJ14KKT4czxeBfE0/UhjWkF6
         +ST/X6dgtwU7bcYGpV1+Kgpx2oAbHNCmogEFLEJOMY0fHPsfymh8MsI+GssBRZsJNK
         095zixMYR7YOn+mA10EtOnzMchOY9DUM3Kekrf6OCHX69l+qKpg9lb0tMRLydrF0FZ
         BRi2VHP1u+AgaL9hURB1Gx4SqU1NTHJeNgzwNbujNacDLXFtEwunayt8Ktd7Oc/0qs
         EQoQvzSOHKOKi9tKF2KTHqgkPiQyekOrxVnd2plXLpbfzu33UqP9L1LhqE8KIh6xiA
         /jwdUMS+CkhSQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 93B635C0F9C; Mon, 14 Nov 2022 08:17:33 -0800 (PST)
Date:   Mon, 14 Nov 2022 08:17:33 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH v2] rcu/kfree: Do not request RCU when not needed
Message-ID: <20221114161733.GD4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221109024758.2644936-1-joel@joelfernandes.org>
 <Y2z3Mb3u8bFZ12wY@pc636>
 <CAEXW_YSq89xzgyQ9Tdt1tCqz8VAfzb7kSXVZmnxDuJ65U0UZ3w@mail.gmail.com>
 <Y20EOinwcLSZHmXg@pc638.lan>
 <Y22ry4Q2OY2zovco@google.com>
 <Y3Iyka86FlUh9D1P@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y3Iyka86FlUh9D1P@pc636>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 01:20:33PM +0100, Uladzislau Rezki wrote:
> > On Thu, Nov 10, 2022 at 03:01:30PM +0100, Uladzislau Rezki wrote:
> > > > Hi,
> > > > 
> > > > On Thu, Nov 10, 2022 at 8:05 AM Uladzislau Rezki <urezki@gmail.com> wrote:
> > > > 
> > > > > > On ChromeOS, using this with the increased timeout, we see that we
> > > > > almost always
> > > > > > never need to initiate a new grace period. Testing also shows this frees
> > > > > large
> > > > > > amounts of unreclaimed memory, under intense kfree_rcu() pressure.
> > > > > >
> > > > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > > > ---
> > > > > > v1->v2: Same logic but use polled grace periods instead of sampling
> > > > > gp_seq.
> > > > > >
> > > > > >  kernel/rcu/tree.c | 8 +++++++-
> > > > > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > > > index 591187b6352e..ed41243f7a49 100644
> > > > > > --- a/kernel/rcu/tree.c
> > > > > > +++ b/kernel/rcu/tree.c
> > > > > > @@ -2935,6 +2935,7 @@ struct kfree_rcu_cpu_work {
> > > > > >
> > > > > >  /**
> > > > > >   * struct kfree_rcu_cpu - batch up kfree_rcu() requests for RCU grace
> > > > > period
> > > > > > + * @gp_snap: The GP snapshot recorded at the last scheduling of monitor
> > > > > work.
> > > > > >   * @head: List of kfree_rcu() objects not yet waiting for a grace period
> > > > > >   * @bkvhead: Bulk-List of kvfree_rcu() objects not yet waiting for a
> > > > > grace period
> > > > > >   * @krw_arr: Array of batches of kfree_rcu() objects waiting for a
> > > > > grace period
> > > > > > @@ -2964,6 +2965,7 @@ struct kfree_rcu_cpu {
> > > > > >       struct kfree_rcu_cpu_work krw_arr[KFREE_N_BATCHES];
> > > > > >       raw_spinlock_t lock;
> > > > > >       struct delayed_work monitor_work;
> > > > > > +     unsigned long gp_snap;
> > > > > >       bool initialized;
> > > > > >       int count;
> > > > > >
> > > > > > @@ -3167,6 +3169,7 @@ schedule_delayed_monitor_work(struct kfree_rcu_cpu
> > > > > *krcp)
> > > > > >                       mod_delayed_work(system_wq, &krcp->monitor_work,
> > > > > delay);
> > > > > >               return;
> > > > > >       }
> > > > > > +     krcp->gp_snap = get_state_synchronize_rcu();
> > > > > >       queue_delayed_work(system_wq, &krcp->monitor_work, delay);
> > > > > >  }
> > > > > >
> > > > > How do you guarantee a full grace period for objects which proceed
> > > > > to be placed into an input stream that is not yet detached?
> > > > 
> > > > 
> > > > Just replying from phone as I’m OOO today.
> > > > 
> > > > Hmm, so you’re saying that objects can be queued after the delayed work has
> > > > been queued, but processed when the delayed work is run? I’m looking at
> > > > this code after few years so I may have missed something.
> > > > 
> > > > That’s a good point and I think I missed that. I think your version did too
> > > > but I’ll have to double check.
> > > > 
> > > > The fix then is to sample the clock for the latest object queued, not for
> > > > when the delayed work is queued.
> > > > 
> > > The patch i sent gurantee it. Just in case see v2:
> > 
> > You are right and thank you! CBs can be queued while the monitor timer is in
> > progress. So we need to sample unconditionally. I think my approach is still
> > better since I take advantage of multiple seconds (I update snapshot on every
> > CB queue monitor and sample in the monitor handler).
> > 
> > Whereas your patch is snapshotting before queuing the regular work and when
> > the work is executed (This is a much shorter duration and I bet you would be
> > blocking in cond_synchronize..() more often).
> > 
> There is a performance test that measures a taken time and memory
> footprint, so you can do a quick comparison. A "rcutorture" can be
> run with various parameters to figure out if a patch that is in question
> makes any difference.
> 
> Usually i run it as:
> 
> <snip>
> #! /usr/bin/env bash
> 
> LOOPS=10
> 
> for (( i=0; i<$LOOPS; i++ )); do
>         tools/testing/selftests/rcutorture/bin/kvm.sh --memory 10G --torture rcuscale --allcpus --duration 1 \
>         --kconfig CONFIG_NR_CPUS=64 \
>         --kconfig CONFIG_RCU_NOCB_CPU=y \
>         --kconfig CONFIG_RCU_NOCB_CPU_DEFAULT_ALL=y \
>         --kconfig CONFIG_RCU_LAZY=n \
>         --bootargs "rcuscale.kfree_rcu_test=1 rcuscale.kfree_nthreads=16 rcuscale.holdoff=20 rcuscale.kfree_loops=10000 torture.disable_onoff_at_boot" --trust-make
>         echo "Done $i"
> done
> <snip>
> 
> just run it from your linux sandbox.

Would it make sense to modify the "if test "$do_kvfree" = "yes" code
in tools/testing/selftests/rcutorture/bin/torture.sh to do something
like this instead of what it currently does?

Though if so, it would be much faster to use kvm.sh's --buildonly flag
to build the kernel, then kvm-again.sh to rerun that kernel.

						Thanx, Paul
