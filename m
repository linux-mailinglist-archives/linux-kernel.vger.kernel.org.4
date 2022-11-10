Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B75B6243C8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 15:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbiKJOBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 09:01:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiKJOBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 09:01:37 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9821DF24;
        Thu, 10 Nov 2022 06:01:34 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id a67so3174981edf.12;
        Thu, 10 Nov 2022 06:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lpETae63QxzxVvnA0A2Di32LB9M0/Q32ZxpQ3mgqJbA=;
        b=Uj8qm5QN57HBe2lM2chgrKVPDbKZpDs/37BtHlj+jS5HupIZ92lLRsjIDcE42t2wl4
         dSoKP3jQQw/l//pX6VVMP8WGCULxb04ZgkYnGYdYq4JrCM3fqA+aAU5y/QtbDbGhJmHN
         Z9dhaX7tLfAh160TZmi6wtP5fyCmCEWX7e5HrPL2U+mKeg0O9BNARdWuhSqLW/GrmM1y
         mkytoAFJP4Os2uKr2D5HLT7iblnFuOtx4tiobctsow2+AimW5ZrSQRmyvkQmTJ7el4iB
         l+yrTKUdC4zXq9tA8NQCVGJbTSaicI0YI39Z3UhU0qtcYyImwYn8t1axOoRoY05JmzNE
         OJKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lpETae63QxzxVvnA0A2Di32LB9M0/Q32ZxpQ3mgqJbA=;
        b=RyOIa1bAVtZ9DPAKQqNiTlvasyZDJZrVYtBYJBl/M8Vf9ccPx0HHlJgPcAlFauDDqo
         E4OKLsxxT4OJAjy4eHMXo3N7q9CAGVrKM/fg91xvFynjdL25u7e4nM/4f7L2Hd0+eqaW
         izMonGf4c93lzbGZwucKD3EvIxuVbWrQgg7PVyU5UDz4OGhTONjGlwBMf7Le5L+1LA/K
         yWbBYe+kTbpLn4uG6eCxc2vtclMtl+iEcyZu5ZJQ7tc9Z+i1GMB76FQa1T4xIczBZV/f
         7TPAKUMshZ0MTI1JTooTxrTTFOkplVcUxiVipeSp9IDtnBqLtdBKyStiyS/67fh6haE0
         8ziA==
X-Gm-Message-State: ACrzQf3bdiB0klB9KM2KEg+gxaocFLt+n/X6VG9W2icQa3PT0HYHPmU2
        dXFZD99nZdJXSb1XXLH1P6q8bQPuTwM=
X-Google-Smtp-Source: AMsMyM51Pt72kKmfLgoq7H7jhnlmOHCLQ3KSHFH6AfdDq3Pz2LEx81TLg4Rd5gR+r+oTHVgt45lyQA==
X-Received: by 2002:a05:6402:414d:b0:451:73f0:e113 with SMTP id x13-20020a056402414d00b0045173f0e113mr63009067eda.207.1668088893096;
        Thu, 10 Nov 2022 06:01:33 -0800 (PST)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id bl3-20020a170906c24300b0078ca30ee18bsm7333241ejb.95.2022.11.10.06.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 06:01:32 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Thu, 10 Nov 2022 15:01:30 +0100
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, linux-kernel@vger.kernel.org,
        paulmck@kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH v2] rcu/kfree: Do not request RCU when not needed
Message-ID: <Y20EOinwcLSZHmXg@pc638.lan>
References: <20221109024758.2644936-1-joel@joelfernandes.org>
 <Y2z3Mb3u8bFZ12wY@pc636>
 <CAEXW_YSq89xzgyQ9Tdt1tCqz8VAfzb7kSXVZmnxDuJ65U0UZ3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YSq89xzgyQ9Tdt1tCqz8VAfzb7kSXVZmnxDuJ65U0UZ3w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi,
> 
> On Thu, Nov 10, 2022 at 8:05 AM Uladzislau Rezki <urezki@gmail.com> wrote:
> 
> > > On ChromeOS, using this with the increased timeout, we see that we
> > almost always
> > > never need to initiate a new grace period. Testing also shows this frees
> > large
> > > amounts of unreclaimed memory, under intense kfree_rcu() pressure.
> > >
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > ---
> > > v1->v2: Same logic but use polled grace periods instead of sampling
> > gp_seq.
> > >
> > >  kernel/rcu/tree.c | 8 +++++++-
> > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index 591187b6352e..ed41243f7a49 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -2935,6 +2935,7 @@ struct kfree_rcu_cpu_work {
> > >
> > >  /**
> > >   * struct kfree_rcu_cpu - batch up kfree_rcu() requests for RCU grace
> > period
> > > + * @gp_snap: The GP snapshot recorded at the last scheduling of monitor
> > work.
> > >   * @head: List of kfree_rcu() objects not yet waiting for a grace period
> > >   * @bkvhead: Bulk-List of kvfree_rcu() objects not yet waiting for a
> > grace period
> > >   * @krw_arr: Array of batches of kfree_rcu() objects waiting for a
> > grace period
> > > @@ -2964,6 +2965,7 @@ struct kfree_rcu_cpu {
> > >       struct kfree_rcu_cpu_work krw_arr[KFREE_N_BATCHES];
> > >       raw_spinlock_t lock;
> > >       struct delayed_work monitor_work;
> > > +     unsigned long gp_snap;
> > >       bool initialized;
> > >       int count;
> > >
> > > @@ -3167,6 +3169,7 @@ schedule_delayed_monitor_work(struct kfree_rcu_cpu
> > *krcp)
> > >                       mod_delayed_work(system_wq, &krcp->monitor_work,
> > delay);
> > >               return;
> > >       }
> > > +     krcp->gp_snap = get_state_synchronize_rcu();
> > >       queue_delayed_work(system_wq, &krcp->monitor_work, delay);
> > >  }
> > >
> > How do you guarantee a full grace period for objects which proceed
> > to be placed into an input stream that is not yet detached?
> 
> 
> Just replying from phone as I’m OOO today.
> 
> Hmm, so you’re saying that objects can be queued after the delayed work has
> been queued, but processed when the delayed work is run? I’m looking at
> this code after few years so I may have missed something.
> 
> That’s a good point and I think I missed that. I think your version did too
> but I’ll have to double check.
> 
> The fix then is to sample the clock for the latest object queued, not for
> when the delayed work is queued.
> 
The patch i sent gurantee it. Just in case see v2:

From 7ff4038d5dac8d2044b240adeee630ad7944ab8d Mon Sep 17 00:00:00 2001
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Date: Wed, 2 Nov 2022 19:26:27 +0100
Subject: [PATCH] rcu: kvfree_rcu: Reduce a memory footptint by using polling
 APIs

Total time taken by all kfree'ers: 6564718459 ns, loops: 10000, batches: 1110, memory footprint: 5057MB
Total time taken by all kfree'ers: 8431051895 ns, loops: 10000, batches: 1109, memory footprint: 2749MB
Total time taken by all kfree'ers: 9477830789 ns, loops: 10000, batches: 1158, memory footprint: 2934MB
Total time taken by all kfree'ers: 9950211144 ns, loops: 10000, batches: 981, memory footprint: 2704MB

with a patch:

Total time taken by all kfree'ers: 7712110118 ns, loops: 10000, batches: 1660, memory footprint: 91MB
Total time taken by all kfree'ers: 7002403664 ns, loops: 10000, batches: 1482, memory footprint: 86MB
Total time taken by all kfree'ers: 7842282319 ns, loops: 10000, batches: 1738, memory footprint: 86MB
Total time taken by all kfree'ers: 7230161977 ns, loops: 10000, batches: 1542, memory footprint: 72MB

Tested with NOCB option, all offloading CPUs:

kvm.sh --memory 10G --torture rcuscale --allcpus --duration 1 \
  --kconfig CONFIG_NR_CPUS=64 \
  --kconfig CONFIG_RCU_NOCB_CPU=y \
  --kconfig CONFIG_RCU_NOCB_CPU_DEFAULT_ALL=y \
  --bootargs "rcuscale.kfree_rcu_test=1 rcuscale.kfree_nthreads=16 \
  rcuscale.holdoff=20 rcuscale.kfree_loops=10000 torture.disable_onoff_at_boot" --trust-make

According to data there is a big gain in memory footprint with a patch.
It is because of call_rcu() and call_rcu_flush() take more effort and
time to queue a callback and then wait for a gp.

With polling API:
  a) we do not need to queue any callback;
  b) we might not even need wait for a GP completion.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 76973d716921..2be4f80867f2 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2919,18 +2919,20 @@ struct kvfree_rcu_bulk_data {
 	((PAGE_SIZE - sizeof(struct kvfree_rcu_bulk_data)) / sizeof(void *))
 
 /**
+ * @rcu_work: A work to reclaim a memory after a grace period
  * struct kfree_rcu_cpu_work - single batch of kfree_rcu() requests
- * @rcu_work: Let queue_rcu_work() invoke workqueue handler after grace period
  * @head_free: List of kfree_rcu() objects waiting for a grace period
  * @bkvhead_free: Bulk-List of kvfree_rcu() objects waiting for a grace period
  * @krcp: Pointer to @kfree_rcu_cpu structure
+ * @gp_snap: A snapshot of current grace period
  */
 
 struct kfree_rcu_cpu_work {
-	struct rcu_work rcu_work;
+	struct work_struct rcu_work;
 	struct rcu_head *head_free;
 	struct kvfree_rcu_bulk_data *bkvhead_free[FREE_N_CHANNELS];
 	struct kfree_rcu_cpu *krcp;
+	unsigned long gp_snap;
 };
 
 /**
@@ -3064,10 +3066,11 @@ static void kfree_rcu_work(struct work_struct *work)
 	struct rcu_head *head, *next;
 	struct kfree_rcu_cpu *krcp;
 	struct kfree_rcu_cpu_work *krwp;
+	unsigned long this_krwp_gp_snap;
 	int i, j;
 
-	krwp = container_of(to_rcu_work(work),
-			    struct kfree_rcu_cpu_work, rcu_work);
+	krwp = container_of(work,
+		struct kfree_rcu_cpu_work, rcu_work);
 	krcp = krwp->krcp;
 
 	raw_spin_lock_irqsave(&krcp->lock, flags);
@@ -3080,8 +3083,15 @@ static void kfree_rcu_work(struct work_struct *work)
 	// Channel 3.
 	head = krwp->head_free;
 	krwp->head_free = NULL;
+
+	// Get the latest saved state of grace period
+	// associated with this "krwp" and objects there.
+	this_krwp_gp_snap = krwp->gp_snap;
 	raw_spin_unlock_irqrestore(&krcp->lock, flags);
 
+	// Check the state.
+	cond_synchronize_rcu(this_krwp_gp_snap);
+
 	// Handle the first two channels.
 	for (i = 0; i < FREE_N_CHANNELS; i++) {
 		for (; bkvhead[i]; bkvhead[i] = bnext) {
@@ -3212,12 +3222,22 @@ static void kfree_rcu_monitor(struct work_struct *work)
 
 			WRITE_ONCE(krcp->count, 0);
 
+			// 1. Take a snapshot for this krwp. Please note no
+			// more any objects can be added to channels which
+			// have already been attached.
+			//
+			// 2. Since a "krwp" has several free channels a GP
+			// status of latest attached one is recorded, i.e.
+			// it allows us to maintain a GP status for last in
+			// objects among all channels.
+			krwp->gp_snap = get_state_synchronize_rcu();
+
 			// One work is per one batch, so there are three
 			// "free channels", the batch can handle. It can
 			// be that the work is in the pending state when
 			// channels have been detached following by each
 			// other.
-			queue_rcu_work(system_wq, &krwp->rcu_work);
+			queue_work(system_wq, &krwp->rcu_work);
 		}
 	}
 
@@ -4808,7 +4828,7 @@ static void __init kfree_rcu_batch_init(void)
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
 
 		for (i = 0; i < KFREE_N_BATCHES; i++) {
-			INIT_RCU_WORK(&krcp->krw_arr[i].rcu_work, kfree_rcu_work);
+			INIT_WORK(&krcp->krw_arr[i].rcu_work, kfree_rcu_work);
 			krcp->krw_arr[i].krcp = krcp;
 		}
 
> > > @@ -3217,7 +3220,10 @@ static void kfree_rcu_monitor(struct work_struct
> > *work)
> > >                       // be that the work is in the pending state when
> > >                       // channels have been detached following by each
> > >                       // other.
> > > -                     queue_rcu_work(system_wq, &krwp->rcu_work);
> > > +                     if (poll_state_synchronize_rcu(krcp->gp_snap))
> > > +                             queue_work(system_wq, &krwp->rcu_work.work
> > );
> > > +                     else
> > > +                             queue_rcu_work(system_wq, &krwp->rcu_work);
> > >               }
> > >
> > Why do you want to queue a work over RCU-core?
> >
> > 1.
> > call_rcu()
> >    -> queue_work();
> >       -> do reclaim
> >
> > if it can be improved and simplified as:
> >
> > 2.
> > queue_work();
> >     -> cond_synchronize_rcu(), do reclaim
> 
> 
> The second one blocks, the first doesn’t. So I’m not sure how that’s an
> improvement? I think we don’t want to block in kworker due to possible
> scheduling issues and hurting other kwork during critical operations, if
> possible.
> 
Does the first wait for a full grace period so our kworker is not even run?

--
Uladzislau Rezki
