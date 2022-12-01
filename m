Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910E163FC3C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 00:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbiLAXqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 18:46:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbiLAXqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 18:46:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C72BE6B0;
        Thu,  1 Dec 2022 15:46:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D27B621B9;
        Thu,  1 Dec 2022 23:46:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56CE9C433C1;
        Thu,  1 Dec 2022 23:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669938360;
        bh=+ZZDaJ2TRqfIjvZzNrIyeLfItKovFc6+CdjaaxehAkU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=bmRtcrRiqsli1nffSTig33Fg6wjlRraY09f8JVPSUAREoaURLJBdSHqu2lrV/SZ5R
         5TYFc0CEuOf/4zIwYASGcbrV4ny2llKEzr1amSwVCq9fw6fRSsEB2KuX4VoDZYHcn2
         WtyHfs3Nk/qb3tlMPcPcrldHoTriA/g0blQ2hmH8NBe7fw1vUEE0X/5F0dBiP2TCLW
         +f6wDkvUavs6NNay5wxUdRiycigZxnz90zXlvPSVBVD4FLE1LbTDEeuWD/TQVDsS0O
         2LEr/SoVc2KjiS1E+cYCIK1698Eo6ZSnNp5To0UffvoeI5rSRrAhp0s2lgcAdqgA3u
         /F4EVPeCMBveQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B9A145C05F8; Thu,  1 Dec 2022 15:45:59 -0800 (PST)
Date:   Thu, 1 Dec 2022 15:45:59 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v2 4/4] rcu/kvfree: Use a polled API to speedup a reclaim
 process
Message-ID: <20221201234559.GA1520591@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221129155822.538434-1-urezki@gmail.com>
 <20221129155822.538434-5-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129155822.538434-5-urezki@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 04:58:22PM +0100, Uladzislau Rezki (Sony) wrote:
> Currently all objects placed into a batch require a full GP
> after passing which objects in a batch are eligible to be
> freed.
> 
> The problem is that many pointers may already passed several
> GP sequences so there is no need for them in extra delay and
> such objects can be reclaimed right away without waiting.
> 
> In order to reduce a memory footprint this patch introduces
> a per-page-grace-period-controlling mechanism. It allows us
> to distinguish pointers for which a grace period is passed
> and for which not.
> 
> A reclaim thread in its turn frees a memory in a reverse
> order starting from a tail because a GP is likely passed
> for objects in a page. If a page with a GP sequence in a
> list hits a condition when a GP is not ready we bail out
> requesting one more grace period in order to complete a
> drain process for left pages.
> 
> Test example:
> 
> kvm.sh --memory 10G --torture rcuscale --allcpus --duration 1 \
>   --kconfig CONFIG_NR_CPUS=64 \
>   --kconfig CONFIG_RCU_NOCB_CPU=y \
>   --kconfig CONFIG_RCU_NOCB_CPU_DEFAULT_ALL=y \
>   --kconfig CONFIG_RCU_LAZY=n \
>   --bootargs "rcuscale.kfree_rcu_test=1 rcuscale.kfree_nthreads=16 \
>   rcuscale.holdoff=20 rcuscale.kfree_loops=10000 \
>   torture.disable_onoff_at_boot" --trust-make
> 
> Total time taken by all kfree'ers: 8535693700 ns, loops: 10000, batches: 1188, memory footprint: 2248MB
> Total time taken by all kfree'ers: 8466933582 ns, loops: 10000, batches: 1157, memory footprint: 2820MB
> Total time taken by all kfree'ers: 5375602446 ns, loops: 10000, batches: 1130, memory footprint: 6502MB
> Total time taken by all kfree'ers: 7523283832 ns, loops: 10000, batches: 1006, memory footprint: 3343MB
> Total time taken by all kfree'ers: 6459171956 ns, loops: 10000, batches: 1150, memory footprint: 6549MB
> 
> Total time taken by all kfree'ers: 8560060176 ns, loops: 10000, batches: 1787, memory footprint: 61MB
> Total time taken by all kfree'ers: 8573885501 ns, loops: 10000, batches: 1777, memory footprint: 93MB
> Total time taken by all kfree'ers: 8320000202 ns, loops: 10000, batches: 1727, memory footprint: 66MB
> Total time taken by all kfree'ers: 8552718794 ns, loops: 10000, batches: 1790, memory footprint: 75MB
> Total time taken by all kfree'ers: 8601368792 ns, loops: 10000, batches: 1724, memory footprint: 62MB
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

A couple more questions interspersed below upon further reflection.

Thoughts?

						Thanx, Paul

> ---
>  kernel/rcu/tree.c | 47 +++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 39 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index c94c17194299..44279ca488ef 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2741,11 +2741,13 @@ EXPORT_SYMBOL_GPL(call_rcu);
>  /**
>   * struct kvfree_rcu_bulk_data - single block to store kvfree_rcu() pointers
>   * @list: List node. All blocks are linked between each other
> + * @gp_snap: Snapshot of RCU state for objects placed to this bulk
>   * @nr_records: Number of active pointers in the array
>   * @records: Array of the kvfree_rcu() pointers
>   */
>  struct kvfree_rcu_bulk_data {
>  	struct list_head list;
> +	unsigned long gp_snap;
>  	unsigned long nr_records;
>  	void *records[];
>  };
> @@ -2762,13 +2764,15 @@ struct kvfree_rcu_bulk_data {
>   * struct kfree_rcu_cpu_work - single batch of kfree_rcu() requests
>   * @rcu_work: Let queue_rcu_work() invoke workqueue handler after grace period
>   * @head_free: List of kfree_rcu() objects waiting for a grace period
> + * @head_free_gp_snap: Snapshot of RCU state for objects placed to "@head_free"
>   * @bulk_head_free: Bulk-List of kvfree_rcu() objects waiting for a grace period
>   * @krcp: Pointer to @kfree_rcu_cpu structure
>   */
>  
>  struct kfree_rcu_cpu_work {
> -	struct rcu_work rcu_work;
> +	struct work_struct rcu_work;
>  	struct rcu_head *head_free;
> +	unsigned long head_free_gp_snap;
>  	struct list_head bulk_head_free[FREE_N_CHANNELS];
>  	struct kfree_rcu_cpu *krcp;
>  };
> @@ -2964,10 +2968,11 @@ static void kfree_rcu_work(struct work_struct *work)
>  	struct rcu_head *head;
>  	struct kfree_rcu_cpu *krcp;
>  	struct kfree_rcu_cpu_work *krwp;
> +	unsigned long head_free_gp_snap;
>  	int i;
>  
> -	krwp = container_of(to_rcu_work(work),
> -			    struct kfree_rcu_cpu_work, rcu_work);
> +	krwp = container_of(work,
> +		struct kfree_rcu_cpu_work, rcu_work);
>  	krcp = krwp->krcp;
>  
>  	raw_spin_lock_irqsave(&krcp->lock, flags);
> @@ -2978,12 +2983,29 @@ static void kfree_rcu_work(struct work_struct *work)
>  	// Channel 3.
>  	head = krwp->head_free;
>  	krwp->head_free = NULL;
> +	head_free_gp_snap = krwp->head_free_gp_snap;
>  	raw_spin_unlock_irqrestore(&krcp->lock, flags);
>  
>  	// Handle the first two channels.
> -	for (i = 0; i < FREE_N_CHANNELS; i++)
> +	for (i = 0; i < FREE_N_CHANNELS; i++) {
> +		// Start from the tail page, so a GP is likely passed for it.
> +		list_for_each_entry_safe_reverse(bnode, n, &bulk_head[i], list) {
> +			// Not yet ready? Bail out since we need one more GP.
> +			if (!poll_state_synchronize_rcu(bnode->gp_snap))
> +				break;
> +
> +			list_del_init(&bnode->list);
> +			kvfree_rcu_bulk(krcp, bnode, i);
> +		}
> +
> +		// Please note a request for one more extra GP can
> +		// occur only once for all objects in this batch.
> +		if (!list_empty(&bulk_head[i]))
> +			synchronize_rcu();

Does directly invoking synchronize_rcu() instead of using queue_rcu_work()
provide benefits, for example, reduced memory footprint?  If not,
it would be good to instead use queue_rcu_work() in order to avoid an
unnecessary context switch in this workqueue handler.

My concern is that an RCU CPU stall might otherwise end up tying up more
workqueue kthreads as well as more memory.

>  		list_for_each_entry_safe(bnode, n, &bulk_head[i], list)
>  			kvfree_rcu_bulk(krcp, bnode, i);
> +	}
>  
>  	/*
>  	 * This is used when the "bulk" path can not be used for the
> @@ -2992,7 +3014,10 @@ static void kfree_rcu_work(struct work_struct *work)
>  	 * queued on a linked list through their rcu_head structures.
>  	 * This list is named "Channel 3".
>  	 */
> -	kvfree_rcu_list(head);
> +	if (head) {
> +		cond_synchronize_rcu(head_free_gp_snap);

And similarly here.

> +		kvfree_rcu_list(head);
> +	}
>  }
>  
>  static bool
> @@ -3059,6 +3084,11 @@ static void kfree_rcu_monitor(struct work_struct *work)
>  			if (!krwp->head_free) {
>  				krwp->head_free = krcp->head;
>  				WRITE_ONCE(krcp->head, NULL);
> +
> +				// Take a snapshot for this krwp. Please note no more
> +				// any objects can be added to attached head_free channel
> +				// therefore fixate a GP for it here.
> +				krwp->head_free_gp_snap = get_state_synchronize_rcu();
>  			}
>  
>  			WRITE_ONCE(krcp->count, 0);
> @@ -3068,7 +3098,7 @@ static void kfree_rcu_monitor(struct work_struct *work)
>  			// be that the work is in the pending state when
>  			// channels have been detached following by each
>  			// other.
> -			queue_rcu_work(system_wq, &krwp->rcu_work);
> +			queue_work(system_wq, &krwp->rcu_work);
>  		}
>  	}
>  
> @@ -3196,8 +3226,9 @@ add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
>  		list_add(&bnode->list, &(*krcp)->bulk_head[idx]);
>  	}
>  
> -	/* Finally insert. */
> +	// Finally insert and update the GP for this page.
>  	bnode->records[bnode->nr_records++] = ptr;
> +	bnode->gp_snap = get_state_synchronize_rcu();
>  	return true;
>  }
>  
> @@ -4801,7 +4832,7 @@ static void __init kfree_rcu_batch_init(void)
>  		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
>  
>  		for (i = 0; i < KFREE_N_BATCHES; i++) {
> -			INIT_RCU_WORK(&krcp->krw_arr[i].rcu_work, kfree_rcu_work);
> +			INIT_WORK(&krcp->krw_arr[i].rcu_work, kfree_rcu_work);
>  			krcp->krw_arr[i].krcp = krcp;
>  
>  			for (j = 0; j < FREE_N_CHANNELS; j++)
> -- 
> 2.30.2
> 
