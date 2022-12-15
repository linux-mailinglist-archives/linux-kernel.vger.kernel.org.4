Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2378A64E26F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 21:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiLOUka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 15:40:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiLOUk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 15:40:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90904A58D;
        Thu, 15 Dec 2022 12:40:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 872E2B81AFA;
        Thu, 15 Dec 2022 20:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27F52C43392;
        Thu, 15 Dec 2022 20:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671136823;
        bh=/i+mcATm26kY1rRH6CMt3AAvHi/UAzmtf1orlOTLPoI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=C/J8jhhgkNYgszyjvad/nRe8Bi/AtsyF3NnXMthlbdKkrWiWfNkidG7SW80e9em2J
         mCrio+LngzBfR/8VVozzgYUctTT4ExUv+VYBHqkURzz8JGxtZF7WK5komgaCD8zJVM
         nktw+IBwQ6BKA/e8UsN6RPBOGcO3QDhkJFr29wWwAMY+pNw+XSZ7r1CO2wL2c4UmQw
         cJEQq0WgwHYb9DjQJXPJxgBQg2ioh4lzTlmnmQd0gzowy21rUByJFNdZ+kmOqDCrld
         iCZn8QQpkz02Nx+ADpoDNoGC4wdKuQWTc/86IdeYoLRGolIoybKFumyaV+dTVBxxwL
         GKyCdwlH6z8dQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C68F15C1C5B; Thu, 15 Dec 2022 12:40:22 -0800 (PST)
Date:   Thu, 15 Dec 2022 12:40:22 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 1/2] rcu/kvfree: Carefully reset number of objects in krcp
Message-ID: <20221215204022.GN4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221214120630.379527-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221214120630.379527-1-urezki@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 01:06:29PM +0100, Uladzislau Rezki (Sony) wrote:
> Problem. A schedule_delayed_monitor_work() relays on the
> number of pointers queued into krcp. Based on that number
> and threshold the work is rearmed with different delayed
> intervals, i.e. sooner or later.
> 
> There are three pipes where pointers can be placed. When
> any pipe is offloaded the krcp->count counter is set to
> zero - what is wrong. Because another pipes might not be
> empty.
> 
> Fix it by maintaining a counter individually per a pipe.
> In order to get a number of objects per a krcp introduce
> a krc_count() helper.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Queued and pushed for further review and testing, and with the usual
wordsmithing.  Much better use of workqueue handlers, thank you!!!

						Thanx, Paul

> ---
>  kernel/rcu/tree.c | 40 ++++++++++++++++++++++++++++++----------
>  1 file changed, 30 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index d155f2594317..312cb0dee117 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2785,7 +2785,8 @@ struct kfree_rcu_cpu_work {
>   * @lock: Synchronize access to this structure
>   * @monitor_work: Promote @head to @head_free after KFREE_DRAIN_JIFFIES
>   * @initialized: The @rcu_work fields have been initialized
> - * @count: Number of objects for which GP not started
> + * @head_count: Number of objects in rcu_head singular list
> + * @bulk_count: Number of objects in bulk-list
>   * @bkvcache:
>   *	A simple cache list that contains objects for reuse purpose.
>   *	In order to save some per-cpu space the list is singular.
> @@ -2803,13 +2804,19 @@ struct kfree_rcu_cpu_work {
>   * the interactions with the slab allocators.
>   */
>  struct kfree_rcu_cpu {
> +	// Objects queued on a linked list
> +	// through their rcu_head structures.
>  	struct rcu_head *head;
> +	atomic_t head_count;
> +
> +	// Objects queued on a bulk-list.
>  	struct list_head bulk_head[FREE_N_CHANNELS];
> +	atomic_t bulk_count[FREE_N_CHANNELS];
> +
>  	struct kfree_rcu_cpu_work krw_arr[KFREE_N_BATCHES];
>  	raw_spinlock_t lock;
>  	struct delayed_work monitor_work;
>  	bool initialized;
> -	int count;
>  
>  	struct delayed_work page_cache_work;
>  	atomic_t backoff_page_cache_fill;
> @@ -3032,12 +3039,23 @@ need_offload_krc(struct kfree_rcu_cpu *krcp)
>  	return !!READ_ONCE(krcp->head);
>  }
>  
> +static int krc_count(struct kfree_rcu_cpu *krcp)
> +{
> +	int sum = atomic_read(&krcp->head_count);
> +	int i;
> +
> +	for (i = 0; i < FREE_N_CHANNELS; i++)
> +		sum += atomic_read(&krcp->bulk_count[i]);
> +
> +	return sum;
> +}
> +
>  static void
>  schedule_delayed_monitor_work(struct kfree_rcu_cpu *krcp)
>  {
>  	long delay, delay_left;
>  
> -	delay = READ_ONCE(krcp->count) >= KVFREE_BULK_MAX_ENTR ? 1:KFREE_DRAIN_JIFFIES;
> +	delay = krc_count(krcp) >= KVFREE_BULK_MAX_ENTR ? 1:KFREE_DRAIN_JIFFIES;
>  	if (delayed_work_pending(&krcp->monitor_work)) {
>  		delay_left = krcp->monitor_work.timer.expires - jiffies;
>  		if (delay < delay_left)
> @@ -3075,8 +3093,10 @@ static void kfree_rcu_monitor(struct work_struct *work)
>  			// Channel 1 corresponds to the SLAB-pointer bulk path.
>  			// Channel 2 corresponds to vmalloc-pointer bulk path.
>  			for (j = 0; j < FREE_N_CHANNELS; j++) {
> -				if (list_empty(&krwp->bulk_head_free[j]))
> +				if (list_empty(&krwp->bulk_head_free[j])) {
>  					list_replace_init(&krcp->bulk_head[j], &krwp->bulk_head_free[j]);
> +					atomic_set(&krcp->bulk_count[j], 0);
> +				}
>  			}
>  
>  			// Channel 3 corresponds to both SLAB and vmalloc
> @@ -3084,6 +3104,7 @@ static void kfree_rcu_monitor(struct work_struct *work)
>  			if (!krwp->head_free) {
>  				krwp->head_free = krcp->head;
>  				WRITE_ONCE(krcp->head, NULL);
> +				atomic_set(&krcp->head_count, 0);
>  
>  				// Take a snapshot for this krwp. Please note no more
>  				// any objects can be added to attached head_free channel
> @@ -3091,8 +3112,6 @@ static void kfree_rcu_monitor(struct work_struct *work)
>  				krwp->head_free_gp_snap = get_state_synchronize_rcu();
>  			}
>  
> -			WRITE_ONCE(krcp->count, 0);
> -
>  			// One work is per one batch, so there are three
>  			// "free channels", the batch can handle. It can
>  			// be that the work is in the pending state when
> @@ -3229,6 +3248,8 @@ add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
>  	// Finally insert and update the GP for this page.
>  	bnode->records[bnode->nr_records++] = ptr;
>  	bnode->gp_snap = get_state_synchronize_rcu();
> +	atomic_inc(&(*krcp)->bulk_count[idx]);
> +
>  	return true;
>  }
>  
> @@ -3282,11 +3303,10 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
>  		head->func = ptr;
>  		head->next = krcp->head;
>  		WRITE_ONCE(krcp->head, head);
> +		atomic_inc(&krcp->head_count);
>  		success = true;
>  	}
>  
> -	WRITE_ONCE(krcp->count, krcp->count + 1);
> -
>  	// Set timer to drain after KFREE_DRAIN_JIFFIES.
>  	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING)
>  		schedule_delayed_monitor_work(krcp);
> @@ -3317,7 +3337,7 @@ kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
>  	for_each_possible_cpu(cpu) {
>  		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
>  
> -		count += READ_ONCE(krcp->count);
> +		count += krc_count(krcp);
>  		count += READ_ONCE(krcp->nr_bkv_objs);
>  		atomic_set(&krcp->backoff_page_cache_fill, 1);
>  	}
> @@ -3334,7 +3354,7 @@ kfree_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
>  		int count;
>  		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
>  
> -		count = krcp->count;
> +		count = krc_count(krcp);
>  		count += drain_page_cache(krcp);
>  		kfree_rcu_monitor(&krcp->monitor_work.work);
>  
> -- 
> 2.30.2
> 
