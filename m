Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F9E62CD58
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 23:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbiKPWGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 17:06:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234346AbiKPWGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 17:06:01 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4396325E2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 14:05:58 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id s206so20164071oie.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 14:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gvTQVdXY5Pl1BTRTqQoQae4SrYrJGbtZrmu0iRf9PZE=;
        b=Ma4/DARyojcjp92NypZnhY8JOG88UEZb3d2xXVbVtk73l3GNe+jvtk3ORRymgktfFg
         RvazEuLZggT9+74OgQdfd6YNg6ceVyiHQCYcXRlxQFuq4dXgDxtMWDREbLy0iAagn7r4
         0Dj+2c4nttKA6VGGORNLiBasE6G1QtDACOPHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gvTQVdXY5Pl1BTRTqQoQae4SrYrJGbtZrmu0iRf9PZE=;
        b=iL94N/0g9wobjXj3jOdHfXB7DEuO7pKWHFH/dCBG0vJZsDls3Qk9BM0qj2B/mODnLx
         dhAHCznSvwcdmw0TRKCTyCu5sdzscocOOcDNW5ZvPGofKhGpOoDEX3Ua56Mm4GSOPFpB
         uCQ1rBwF4X8Cc40lovOPY5actEQ6k181Q3SPxqp15Am8fSoTzqHnysUA3NapcwLRI5oY
         OFCyjvSMdvikHMp3ColqUL5Z5wWlJL1wGi1E/eSTMuSeGoBOACtPMJeW2jmAx75TYsSk
         kUldLGsUqEGS+dmzxu2SAqcarTRkJam3vm/DpcaE4W2UOQEgkC8G6lyQ+mA9q2g2SgsQ
         HtSw==
X-Gm-Message-State: ANoB5pktm4GyE/SRqqdeDOd1rnyUrdtEnO6eackvgAdER7ZHP6wCZ2fl
        VPk6OVeeMZvQoTzMQqZYPCYBWG4ecjqaOYJEgjc7HQ==
X-Google-Smtp-Source: AA0mqf6FuH7EPjBx57WrPiUP3SrRxCovMlvhGPjwUslyoCk12z1NFO4/LfYalYGGkAsU3VqqF6eM92ixzDrltdDbYjE=
X-Received: by 2002:a05:6808:1a09:b0:354:4a36:aa32 with SMTP id
 bk9-20020a0568081a0900b003544a36aa32mr2687133oib.15.1668636357485; Wed, 16
 Nov 2022 14:05:57 -0800 (PST)
MIME-Version: 1.0
References: <20221109024758.2644936-1-joel@joelfernandes.org>
 <Y2z3Mb3u8bFZ12wY@pc636> <CAEXW_YSq89xzgyQ9Tdt1tCqz8VAfzb7kSXVZmnxDuJ65U0UZ3w@mail.gmail.com>
 <Y20EOinwcLSZHmXg@pc638.lan> <Y22ry4Q2OY2zovco@google.com>
 <Y3Iyka86FlUh9D1P@pc636> <CAEXW_YR8ycdF0Y80p2qKXQm3Qc+XA441jQZ3uiHk=TbaXngNkQ@mail.gmail.com>
 <Y3OPI/pWZ5jf4X9y@pc636> <Y3U3zPzLMux8fpVY@pc638.lan>
In-Reply-To: <Y3U3zPzLMux8fpVY@pc638.lan>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 16 Nov 2022 22:05:46 +0000
Message-ID: <CAEXW_YTVmGnC_aBNQ49OfNiD+CX1VX0-R6c_3mNZNvvAoAw0hA@mail.gmail.com>
Subject: Re: [PATCH v2] rcu/kfree: Do not request RCU when not needed
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     paulmck@kernel.org, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 7:19 PM Uladzislau Rezki <urezki@gmail.com> wrote:
>
> Hello, Paul, Joel.
>
> > >
> > > Yes sure, I am doing a run now with my patch. However, I have a
> > > question -- why do you feel blocking in the kworker is not an issue?
> > > You are taking a snapshot before queuing the normal kwork and then
> > > reading the snapshot when the normal kwork runs. Considering it is a
> > > high priority queue, the delay between when you are taking the
> > > snapshot, and reading it is likely small so there is a bigger chance
> > > of blocking in cond_synchronize_rcu(). Did I miss something?
> > >
> > We can wait indeed in the reclaim worker. But the worker does not do any
> > nasty or extra work here. If there is a need we block and wait. After a
> > grace period, we are awoken and proceed.
> >
> > Therefore i do not see the reason in handling two cases:
> >
> > if (gp_done)
> >     queue_work();
> > else
> >     queue_rcu_work();
> >
> > it is the same if we just queue the work and check on entry. The current
> > scenario is: queue the work after a grace period. This is the difference.
> >
> > Right if the reclaimer was a high prio kthread a time would be shorter.
> >
> > In your scenario the time seems even shorter(i have not checked) because
> > you update a snapshot of krcp each time a kvfree_rcu() is invoked. So
> > basically even though you have objects whose grace period is passed you
> > do not separate it anyhow. Because you update the:
> >
> > krcp->gp_snap = get_state_synchronize_rcu();
> >
> > too often.
> >
> Once upon a time we discussed that it is worth to keep track of GP
> per-a-page in order to reduce a memory footprint. Below patch addresses
> it:

In the patch below, it appears you are tracking the GP per krwp, and
not per page. But I could be missing something - could you split it
into separate patches for easier review?

Also it still does cond_synchronize_rcu() :-(

thanks,

 - Joel


>
> <snip>
> From 76fc6a1398f22341758edcd9aa911127e0cf5129 Mon Sep 17 00:00:00 2001
> From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
> Date: Wed, 2 Nov 2022 19:26:27 +0100
> Subject: [PATCH v3 1/1] rcu: kvfree_rcu: Reduce a memory footptint by using
>  polling APIs
>
> Total time taken by all kfree'ers: 6564718459 ns, loops: 10000, batches: 1110, memory footprint: 5057MB
> Total time taken by all kfree'ers: 8431051895 ns, loops: 10000, batches: 1109, memory footprint: 2749MB
> Total time taken by all kfree'ers: 9477830789 ns, loops: 10000, batches: 1158, memory footprint: 2934MB
> Total time taken by all kfree'ers: 9950211144 ns, loops: 10000, batches: 981, memory footprint: 2704MB
>
> with a patch:
>
> Total time taken by all kfree'ers: 7712110118 ns, loops: 10000, batches: 1660, memory footprint: 91MB
> Total time taken by all kfree'ers: 7002403664 ns, loops: 10000, batches: 1482, memory footprint: 86MB
> Total time taken by all kfree'ers: 7842282319 ns, loops: 10000, batches: 1738, memory footprint: 86MB
> Total time taken by all kfree'ers: 7230161977 ns, loops: 10000, batches: 1542, memory footprint: 72MB
>
> Tested with NOCB option, all offloading CPUs:
>
> kvm.sh --memory 10G --torture rcuscale --allcpus --duration 1 \
>   --kconfig CONFIG_NR_CPUS=64 \
>   --kconfig CONFIG_RCU_NOCB_CPU=y \
>   --kconfig CONFIG_RCU_NOCB_CPU_DEFAULT_ALL=y \
>   --bootargs "rcuscale.kfree_rcu_test=1 rcuscale.kfree_nthreads=16 \
>   rcuscale.holdoff=20 rcuscale.kfree_loops=10000 torture.disable_onoff_at_boot" --trust-make
>
> According to data there is a big gain in memory footprint with a patch.
> It is because of call_rcu() and call_rcu_flush() take more effort and
> time to queue a callback and then wait for a gp.
>
> With polling API:
>   a) we do not need to queue any callback;
>   b) we might not even need wait for a GP completion.
>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  kernel/rcu/tree.c | 115 +++++++++++++++++++++++++++-------------------
>  1 file changed, 67 insertions(+), 48 deletions(-)
>
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 76973d716921..6a1f66dd5f09 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2900,13 +2900,16 @@ EXPORT_SYMBOL_GPL(call_rcu);
>
>  /**
>   * struct kvfree_rcu_bulk_data - single block to store kvfree_rcu() pointers
> + * @gp_snap: Snapshot of current GP for objects in a page
>   * @nr_records: Number of active pointers in the array
> + * @list: Page list
>   * @next: Next bulk object in the block chain
>   * @records: Array of the kvfree_rcu() pointers
>   */
>  struct kvfree_rcu_bulk_data {
> +       unsigned long gp_snap;
>         unsigned long nr_records;
> -       struct kvfree_rcu_bulk_data *next;
> +       struct list_head list;
>         void *records[];
>  };
>
> @@ -2919,24 +2922,26 @@ struct kvfree_rcu_bulk_data {
>         ((PAGE_SIZE - sizeof(struct kvfree_rcu_bulk_data)) / sizeof(void *))
>
>  /**
> + * @rcu_work: A work to reclaim a memory after a grace period
>   * struct kfree_rcu_cpu_work - single batch of kfree_rcu() requests
> - * @rcu_work: Let queue_rcu_work() invoke workqueue handler after grace period
>   * @head_free: List of kfree_rcu() objects waiting for a grace period
> - * @bkvhead_free: Bulk-List of kvfree_rcu() objects waiting for a grace period
> + * @head_free_gp_snap: Snapshot of current GP for "@head_free" objects
>   * @krcp: Pointer to @kfree_rcu_cpu structure
>   */
>
>  struct kfree_rcu_cpu_work {
> -       struct rcu_work rcu_work;
> +       struct work_struct rcu_work;
>         struct rcu_head *head_free;
> -       struct kvfree_rcu_bulk_data *bkvhead_free[FREE_N_CHANNELS];
> +       unsigned long head_free_gp_snap;
> +
> +       struct list_head page_free_head[FREE_N_CHANNELS];
>         struct kfree_rcu_cpu *krcp;
>  };
>
>  /**
>   * struct kfree_rcu_cpu - batch up kfree_rcu() requests for RCU grace period
>   * @head: List of kfree_rcu() objects not yet waiting for a grace period
> - * @bkvhead: Bulk-List of kvfree_rcu() objects not yet waiting for a grace period
> + * @page_head: Bulk-List of kvfree_rcu() objects not yet waiting for a grace period
>   * @krw_arr: Array of batches of kfree_rcu() objects waiting for a grace period
>   * @lock: Synchronize access to this structure
>   * @monitor_work: Promote @head to @head_free after KFREE_DRAIN_JIFFIES
> @@ -2960,7 +2965,7 @@ struct kfree_rcu_cpu_work {
>   */
>  struct kfree_rcu_cpu {
>         struct rcu_head *head;
> -       struct kvfree_rcu_bulk_data *bkvhead[FREE_N_CHANNELS];
> +       struct list_head page_head[FREE_N_CHANNELS];
>         struct kfree_rcu_cpu_work krw_arr[KFREE_N_BATCHES];
>         raw_spinlock_t lock;
>         struct delayed_work monitor_work;
> @@ -3060,60 +3065,62 @@ drain_page_cache(struct kfree_rcu_cpu *krcp)
>  static void kfree_rcu_work(struct work_struct *work)
>  {
>         unsigned long flags;
> -       struct kvfree_rcu_bulk_data *bkvhead[FREE_N_CHANNELS], *bnext;
> +       struct kvfree_rcu_bulk_data *page, *n;
> +       struct list_head local_page_head[FREE_N_CHANNELS];
>         struct rcu_head *head, *next;
>         struct kfree_rcu_cpu *krcp;
>         struct kfree_rcu_cpu_work *krwp;
> +       unsigned long head_free_gp_snap;
>         int i, j;
>
> -       krwp = container_of(to_rcu_work(work),
> -                           struct kfree_rcu_cpu_work, rcu_work);
> +       krwp = container_of(work,
> +               struct kfree_rcu_cpu_work, rcu_work);
>         krcp = krwp->krcp;
>
>         raw_spin_lock_irqsave(&krcp->lock, flags);
>         // Channels 1 and 2.
> -       for (i = 0; i < FREE_N_CHANNELS; i++) {
> -               bkvhead[i] = krwp->bkvhead_free[i];
> -               krwp->bkvhead_free[i] = NULL;
> -       }
> +       for (i = 0; i < FREE_N_CHANNELS; i++)
> +               // Initialized or empty it does not matter just replace.
> +               list_replace_init(&krwp->page_free_head[i], &local_page_head[i]);
>
>         // Channel 3.
>         head = krwp->head_free;
>         krwp->head_free = NULL;
> +
> +       head_free_gp_snap = krwp->head_free_gp_snap;
>         raw_spin_unlock_irqrestore(&krcp->lock, flags);
>
>         // Handle the first two channels.
>         for (i = 0; i < FREE_N_CHANNELS; i++) {
> -               for (; bkvhead[i]; bkvhead[i] = bnext) {
> -                       bnext = bkvhead[i]->next;
> -                       debug_rcu_bhead_unqueue(bkvhead[i]);
> +               // Start from the tail page, so a GP is likely passed for it.
> +               list_for_each_entry_safe_reverse(page, n, &local_page_head[i], list) {
> +                       cond_synchronize_rcu(page->gp_snap);
> +                       debug_rcu_bhead_unqueue(page);
>
>                         rcu_lock_acquire(&rcu_callback_map);
>                         if (i == 0) { // kmalloc() / kfree().
>                                 trace_rcu_invoke_kfree_bulk_callback(
> -                                       rcu_state.name, bkvhead[i]->nr_records,
> -                                       bkvhead[i]->records);
> +                                       rcu_state.name, page->nr_records,
> +                                       page->records);
>
> -                               kfree_bulk(bkvhead[i]->nr_records,
> -                                       bkvhead[i]->records);
> +                               kfree_bulk(page->nr_records, page->records);
>                         } else { // vmalloc() / vfree().
> -                               for (j = 0; j < bkvhead[i]->nr_records; j++) {
> +                               for (j = 0; j < page->nr_records; j++) {
>                                         trace_rcu_invoke_kvfree_callback(
> -                                               rcu_state.name,
> -                                               bkvhead[i]->records[j], 0);
> +                                               rcu_state.name, page->records[j], 0);
>
> -                                       vfree(bkvhead[i]->records[j]);
> +                                       vfree(page->records[j]);
>                                 }
>                         }
>                         rcu_lock_release(&rcu_callback_map);
>
>                         raw_spin_lock_irqsave(&krcp->lock, flags);
> -                       if (put_cached_bnode(krcp, bkvhead[i]))
> -                               bkvhead[i] = NULL;
> +                       if (put_cached_bnode(krcp, page))
> +                               page = NULL;
>                         raw_spin_unlock_irqrestore(&krcp->lock, flags);
>
> -                       if (bkvhead[i])
> -                               free_page((unsigned long) bkvhead[i]);
> +                       if (page)
> +                               free_page((unsigned long) page);
>
>                         cond_resched_tasks_rcu_qs();
>                 }
> @@ -3126,6 +3133,9 @@ static void kfree_rcu_work(struct work_struct *work)
>          * queued on a linked list through their rcu_head structures.
>          * This list is named "Channel 3".
>          */
> +       if (head)
> +               cond_synchronize_rcu(head_free_gp_snap);
> +
>         for (; head; head = next) {
>                 unsigned long offset = (unsigned long)head->func;
>                 void *ptr = (void *)head - offset;
> @@ -3149,7 +3159,7 @@ need_offload_krc(struct kfree_rcu_cpu *krcp)
>         int i;
>
>         for (i = 0; i < FREE_N_CHANNELS; i++)
> -               if (krcp->bkvhead[i])
> +               if (!list_empty(&krcp->page_head[i]))
>                         return true;
>
>         return !!krcp->head;
> @@ -3191,16 +3201,15 @@ static void kfree_rcu_monitor(struct work_struct *work)
>                 // a previous RCU batch is in progress, it means that
>                 // immediately to queue another one is not possible so
>                 // in that case the monitor work is rearmed.
> -               if ((krcp->bkvhead[0] && !krwp->bkvhead_free[0]) ||
> -                       (krcp->bkvhead[1] && !krwp->bkvhead_free[1]) ||
> +               if ((!list_empty(&krcp->page_head[0]) && list_empty(&krwp->page_free_head[0])) ||
> +                       (!list_empty(&krcp->page_head[1]) && list_empty(&krwp->page_free_head[1])) ||
>                                 (krcp->head && !krwp->head_free)) {
> +
>                         // Channel 1 corresponds to the SLAB-pointer bulk path.
>                         // Channel 2 corresponds to vmalloc-pointer bulk path.
>                         for (j = 0; j < FREE_N_CHANNELS; j++) {
> -                               if (!krwp->bkvhead_free[j]) {
> -                                       krwp->bkvhead_free[j] = krcp->bkvhead[j];
> -                                       krcp->bkvhead[j] = NULL;
> -                               }
> +                               if (list_empty(&krwp->page_free_head[j]))
> +                                       list_replace_init(&krcp->page_head[j], &krwp->page_free_head[j]);
>                         }
>
>                         // Channel 3 corresponds to both SLAB and vmalloc
> @@ -3208,6 +3217,11 @@ static void kfree_rcu_monitor(struct work_struct *work)
>                         if (!krwp->head_free) {
>                                 krwp->head_free = krcp->head;
>                                 krcp->head = NULL;
> +
> +                               // Take a snapshot for this krwp. Please note no more
> +                               // any objects can be added to attached head_free channel
> +                               // therefore fixate a GP for it here.
> +                               krwp->head_free_gp_snap = get_state_synchronize_rcu();
>                         }
>
>                         WRITE_ONCE(krcp->count, 0);
> @@ -3217,7 +3231,7 @@ static void kfree_rcu_monitor(struct work_struct *work)
>                         // be that the work is in the pending state when
>                         // channels have been detached following by each
>                         // other.
> -                       queue_rcu_work(system_wq, &krwp->rcu_work);
> +                       queue_work(system_wq, &krwp->rcu_work);
>                 }
>         }
>
> @@ -3312,10 +3326,11 @@ add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
>                 return false;
>
>         idx = !!is_vmalloc_addr(ptr);
> +       bnode = list_first_entry_or_null(&(*krcp)->page_head[idx],
> +               struct kvfree_rcu_bulk_data, list);
>
>         /* Check if a new block is required. */
> -       if (!(*krcp)->bkvhead[idx] ||
> -                       (*krcp)->bkvhead[idx]->nr_records == KVFREE_BULK_MAX_ENTR) {
> +       if (!bnode || bnode->nr_records == KVFREE_BULK_MAX_ENTR) {
>                 bnode = get_cached_bnode(*krcp);
>                 if (!bnode && can_alloc) {
>                         krc_this_cpu_unlock(*krcp, *flags);
> @@ -3339,18 +3354,16 @@ add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
>                 if (!bnode)
>                         return false;
>
> -               /* Initialize the new block. */
> +               /* Initialize a new block. */
>                 bnode->nr_records = 0;
> -               bnode->next = (*krcp)->bkvhead[idx];
> -
> -               /* Attach it to the head. */
> -               (*krcp)->bkvhead[idx] = bnode;
> +               list_add(&bnode->list, &(*krcp)->page_head[idx]);
>         }
>
>         /* Finally insert. */
> -       (*krcp)->bkvhead[idx]->records
> -               [(*krcp)->bkvhead[idx]->nr_records++] = ptr;
> +       bnode->records[bnode->nr_records++] = ptr;
>
> +       /* Keep updated a GP status of this page. */
> +       bnode->gp_snap = get_state_synchronize_rcu();
>         return true;
>  }
>
> @@ -4790,7 +4803,7 @@ struct workqueue_struct *rcu_gp_wq;
>  static void __init kfree_rcu_batch_init(void)
>  {
>         int cpu;
> -       int i;
> +       int i, j;
>
>         /* Clamp it to [0:100] seconds interval. */
>         if (rcu_delay_page_cache_fill_msec < 0 ||
> @@ -4808,10 +4821,16 @@ static void __init kfree_rcu_batch_init(void)
>                 struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
>
>                 for (i = 0; i < KFREE_N_BATCHES; i++) {
> -                       INIT_RCU_WORK(&krcp->krw_arr[i].rcu_work, kfree_rcu_work);
> +                       INIT_WORK(&krcp->krw_arr[i].rcu_work, kfree_rcu_work);
>                         krcp->krw_arr[i].krcp = krcp;
> +
> +                       for (j = 0; j < FREE_N_CHANNELS; j++)
> +                               INIT_LIST_HEAD(&krcp->krw_arr[i].page_free_head[j]);
>                 }
>
> +               for (i = 0; i < FREE_N_CHANNELS; i++)
> +                       INIT_LIST_HEAD(&krcp->page_head[i]);
> +
>                 INIT_DELAYED_WORK(&krcp->monitor_work, kfree_rcu_monitor);
>                 INIT_DELAYED_WORK(&krcp->page_cache_work, fill_page_cache_func);
>                 krcp->initialized = true;
> --
> 2.30.2
> <snip>
>
> it is pretty simple. It does the following:
>
> 1) A GP status is sampled per a page that drives pointers;
> 2) Reclaim is done in reverse order because an oldest page more likely passed its GP;
> 3) Returning a memory occurs faster thus it reduces a memory footprint;
> 4) Improves readability of the code.
>
> Any inputs? I will test and check on our devices with real workloads.
>
> --
> Uladzislau Rezki
