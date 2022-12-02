Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE09640E3E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 20:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234238AbiLBTOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 14:14:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233795AbiLBTO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 14:14:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A74E61D6;
        Fri,  2 Dec 2022 11:14:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1000E61DA9;
        Fri,  2 Dec 2022 19:14:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E2FFC433D6;
        Fri,  2 Dec 2022 19:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670008466;
        bh=nMVaZXf2zjz7P/UugPtutwfj+IJrkfUuflCmbecab4s=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=t8Y/ouhVtTw4BRr2Kb0CYn3C0zJICYxbf9Udd/BMXn0dpoBeSvaAy0JAjP7cE+V/z
         NSMwR6X8ZLgGCHUsDFhlV5mcAos/9dsLX8R5H+bfL5Pq4l82nUO3UEhJCE/nJ2TWpP
         UeJ/yp+mm9m9zYffkcKZnFOH6sIxITqD7IeZsYANRs2QkAe/8Z8wy/6hjeXzaNEeeA
         gFUfmxYfz0Gz0AgzsdJbUf+nBvC7jr3flMCSstqwMb8Bkdw1hlzQsHpoKv8M7mx0q8
         xYaXbTE/i++hgyampe1ZkUuh3cXW58k0EZAB/5KKfF3fACX2sTcDfqv4W+A6f+EX/n
         Tz2bHnU/TywJg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 03D625C095D; Fri,  2 Dec 2022 11:14:26 -0800 (PST)
Date:   Fri, 2 Dec 2022 11:14:25 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v2 4/4] rcu/kvfree: Use a polled API to speedup a reclaim
 process
Message-ID: <20221202191425.GU4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221129155822.538434-1-urezki@gmail.com>
 <20221129155822.538434-5-urezki@gmail.com>
 <20221201234559.GA1520591@paulmck-ThinkPad-P17-Gen-1>
 <Y4n1eWpLMkaEGxtP@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4n1eWpLMkaEGxtP@pc636>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 01:54:17PM +0100, Uladzislau Rezki wrote:
> > 
> > A couple more questions interspersed below upon further reflection.
> > 
> > Thoughts?
> > 
> See below my thoughts:
> 
> > 						Thanx, Paul
> > 
> > > ---
> > >  kernel/rcu/tree.c | 47 +++++++++++++++++++++++++++++++++++++++--------
> > >  1 file changed, 39 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index c94c17194299..44279ca488ef 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -2741,11 +2741,13 @@ EXPORT_SYMBOL_GPL(call_rcu);
> > >  /**
> > >   * struct kvfree_rcu_bulk_data - single block to store kvfree_rcu() pointers
> > >   * @list: List node. All blocks are linked between each other
> > > + * @gp_snap: Snapshot of RCU state for objects placed to this bulk
> > >   * @nr_records: Number of active pointers in the array
> > >   * @records: Array of the kvfree_rcu() pointers
> > >   */
> > >  struct kvfree_rcu_bulk_data {
> > >  	struct list_head list;
> > > +	unsigned long gp_snap;
> > >  	unsigned long nr_records;
> > >  	void *records[];
> > >  };
> > > @@ -2762,13 +2764,15 @@ struct kvfree_rcu_bulk_data {
> > >   * struct kfree_rcu_cpu_work - single batch of kfree_rcu() requests
> > >   * @rcu_work: Let queue_rcu_work() invoke workqueue handler after grace period
> > >   * @head_free: List of kfree_rcu() objects waiting for a grace period
> > > + * @head_free_gp_snap: Snapshot of RCU state for objects placed to "@head_free"
> > >   * @bulk_head_free: Bulk-List of kvfree_rcu() objects waiting for a grace period
> > >   * @krcp: Pointer to @kfree_rcu_cpu structure
> > >   */
> > >  
> > >  struct kfree_rcu_cpu_work {
> > > -	struct rcu_work rcu_work;
> > > +	struct work_struct rcu_work;
> > >  	struct rcu_head *head_free;
> > > +	unsigned long head_free_gp_snap;
> > >  	struct list_head bulk_head_free[FREE_N_CHANNELS];
> > >  	struct kfree_rcu_cpu *krcp;
> > >  };
> > > @@ -2964,10 +2968,11 @@ static void kfree_rcu_work(struct work_struct *work)
> > >  	struct rcu_head *head;
> > >  	struct kfree_rcu_cpu *krcp;
> > >  	struct kfree_rcu_cpu_work *krwp;
> > > +	unsigned long head_free_gp_snap;
> > >  	int i;
> > >  
> > > -	krwp = container_of(to_rcu_work(work),
> > > -			    struct kfree_rcu_cpu_work, rcu_work);
> > > +	krwp = container_of(work,
> > > +		struct kfree_rcu_cpu_work, rcu_work);
> > >  	krcp = krwp->krcp;
> > >  
> > >  	raw_spin_lock_irqsave(&krcp->lock, flags);
> > > @@ -2978,12 +2983,29 @@ static void kfree_rcu_work(struct work_struct *work)
> > >  	// Channel 3.
> > >  	head = krwp->head_free;
> > >  	krwp->head_free = NULL;
> > > +	head_free_gp_snap = krwp->head_free_gp_snap;
> > >  	raw_spin_unlock_irqrestore(&krcp->lock, flags);
> > >  
> > >  	// Handle the first two channels.
> > > -	for (i = 0; i < FREE_N_CHANNELS; i++)
> > > +	for (i = 0; i < FREE_N_CHANNELS; i++) {
> > > +		// Start from the tail page, so a GP is likely passed for it.
> > > +		list_for_each_entry_safe_reverse(bnode, n, &bulk_head[i], list) {
> > > +			// Not yet ready? Bail out since we need one more GP.
> > > +			if (!poll_state_synchronize_rcu(bnode->gp_snap))
> > > +				break;
> > > +
> > > +			list_del_init(&bnode->list);
> > > +			kvfree_rcu_bulk(krcp, bnode, i);
> > > +		}
> > > +
> > > +		// Please note a request for one more extra GP can
> > > +		// occur only once for all objects in this batch.
> > > +		if (!list_empty(&bulk_head[i]))
> > > +			synchronize_rcu();
> > 
> > Does directly invoking synchronize_rcu() instead of using queue_rcu_work()
> > provide benefits, for example, reduced memory footprint?
> >
> queue_rcu_work() will delay freeing of all objects in a batch. We can
> make use of it but it should be only for the ones which still require
> a grace period. A memory footprint and a time depends on when our
> callback is invoked by the RCU-core to queue the reclaim work.
> 
> Such time can be long, because it depends on many factors:
> 
> - scheduling delays in waking gp;
> - scheduling delays in kicking nocb;
> - delays in waiting in a "cblist":
>     - dequeuing and invoking f(rhp);
> - delay in waking our final reclaim work and giving it a CPU time.
> 
> This patch combines a possibility to reclaim asap for objects which
> passed a grace period and requesting one more GP for the ones which
> have not passed it yet.

Understood.  It would be necessary to split the list in order to
immediately reclaim those whose grace periods have completed.
Then the remaining objects (only those whose grace periods have
not completed) would be passed to queue_rcu_work().

> > If not, it would be good to instead use queue_rcu_work() in order
> > to avoid an unnecessary context switch in this workqueue handler.
> >
> I went by the most easiest way from code perspective since i do not
> see problems with a current approach from testing and personal point
> of views.

I am worried about corner cases where memory is low and RCU grace periods
are being delayed and workqueues is running short of ktheads.

> If we are about to do that i need to add extra logic to split ready
> and not ready pointers for direct reclaim and the rest over the
> queu_rcu_work().

Agreed.

> I can check how it goes.

Please!

> > My concern is that an RCU CPU stall might otherwise end up tying up more
> > workqueue kthreads as well as more memory.
> > 
> There is a limit. We have two batches, one work for each. Suppose the
> reclaim kthread is stuck in synchronize_rcu() so it does not do any
> progress. In this case same work can be only in pending state and
> nothing more no matter how many times the queue_work() is invoked:
> 
> 2 * num_possible_cpus();
> 
> If we end up in RCU stall we will not be able to reclaim anyway.

Understood.

The goal is not to make progress because as you say, we cannot make any
progress until the RCU grace period completes.  The goal is instead to
avoid tying up workqueue kthreads while in that sad state.

							Thanx, Paul
