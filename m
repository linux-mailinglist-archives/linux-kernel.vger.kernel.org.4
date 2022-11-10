Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4364A623ED8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 10:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiKJJnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 04:43:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiKJJm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 04:42:57 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813EB6A6B5;
        Thu, 10 Nov 2022 01:42:55 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4N7H215c4Pz4f3lXR;
        Thu, 10 Nov 2022 17:42:49 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgAnmdaZx2xjKConAQ--.43490S3;
        Thu, 10 Nov 2022 17:42:51 +0800 (CST)
Subject: Re: [PATCH] sbitmap: Use single per-bitmap counting to wake up queued
 tags
To:     Gabriel Krisman Bertazi <krisman@suse.de>, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Hugh Dickins <hughd@google.com>,
        Keith Busch <kbusch@kernel.org>,
        Liu Song <liusong@linux.alibaba.com>, Jan Kara <jack@suse.cz>,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20221105231055.25953-1-krisman@suse.de>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <2a445c5c-fd15-c0bf-8655-2fb5bde3fe67@huaweicloud.com>
Date:   Thu, 10 Nov 2022 17:42:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20221105231055.25953-1-krisman@suse.de>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAnmdaZx2xjKConAQ--.43490S3
X-Coremail-Antispam: 1UD129KBjvJXoWfGF18Zw45uryktFyDCw1fCrg_yoWDtw4UpF
        W3GFn7Za1ktry29r4DJr4UAa4a9w4kKr9xGr4fK34rCwsrtrnYvrn5KFZ3ZrW8Ars8Kay5
        Jr4agrsxCa47ZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
        6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUOyCJDUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

ÔÚ 2022/11/06 7:10, Gabriel Krisman Bertazi Ð´µÀ:
> sbitmap suffers from code complexity, as demonstrated by recent fixes,
> and eventual lost wake ups on nested I/O completion.  The later happens,
> from what I understand, due to the non-atomic nature of the updates to
> wait_cnt, which needs to be subtracted and eventually reset when equal
> to zero.  This two step process can eventually miss an update when a
> nested completion happens to interrupt the CPU in between the wait_cnt
> updates.  This is very hard to fix, as shown by the recent changes to
> this code.
> 
> The code complexity arises mostly from the corner cases to avoid missed
> wakes in this scenario.  In addition, the handling of wake_batch
> recalculation plus the synchronization with sbq_queue_wake_up is
> non-trivial.
> 
> This patchset implements the idea originally proposed by Jan [1], which
> removes the need for the two-step updates of wait_cnt.  This is done by
> tracking the number of completions and wakeups in always increasing,
> per-bitmap counters.  Instead of having to reset the wait_cnt when it
> reaches zero, we simply keep counting, and attempt to wake up N threads
> in a single wait queue whenever there is enough space for a batch.
> Waking up less than batch_wake shouldn't be a problem, because we
> haven't changed the conditions for wake up, and the existing batch
> calculation guarantees at least enough remaining completions to wake up
> a batch for each queue at any time.
> 
> Performance-wise, one should expect very similar performance to the
> original algorithm for the case where there is no queueing.  In both the
> old algorithm and this implementation, the first thing is to check
> ws_active, which bails out if there is no queueing to be managed. In the
> new code, we took care to avoid accounting completions and wakeups when
> there is no queueing, to not pay the cost of atomic operations
> unnecessarily, since it doesn't skew the numbers.
> 
> For more interesting cases, where there is queueing, we need to take
> into account the cross-communication of the atomic operations.  I've
> been benchmarking by running parallel fio jobs against a single hctx
> nullb in different hardware queue depth scenarios, and verifying both
> IOPS and queueing.
> 
> Each experiment was repeated 5 times on a 20-CPU box, with 20 parallel
> jobs. fio was issuing fixed-size randwrites with qd=64 against nullb,
> varying only the hardware queue length per test.
> 
> queue size 2                 4                 8                 16                 32                 64
> 6.1-rc2    1681.1K (1.6K)    2633.0K (12.7K)   6940.8K (16.3K)   8172.3K (617.5K)   8391.7K (367.1K)   8606.1K (351.2K)
> patched    1721.8K (15.1K)   3016.7K (3.8K)    7543.0K (89.4K)   8132.5K (303.4K)   8324.2K (230.6K)   8401.8K (284.7K)
> 
> The following is a similar experiment, ran against a nullb with a single
> bitmap shared by 20 hctx spread across 2 NUMA nodes. This has 40
> parallel fio jobs operating on the same device
> 
> queue size 2 	             4                 8              	16             	    32		       64
> 6.1-rc2	   1081.0K (2.3K)    957.2K (1.5K)     1699.1K (5.7K) 	6178.2K (124.6K)    12227.9K (37.7K)   13286.6K (92.9K)
> patched	   1081.8K (2.8K)    1316.5K (5.4K)    2364.4K (1.8K) 	6151.4K  (20.0K)    11893.6K (17.5K)   12385.6K (18.4K)
> 
> It has also survived blktests and a 12h-stress run against nullb. I also
> ran the code against nvme and a scsi SSD, and I didn't observe
> performance regression in those. If there are other tests you think I
> should run, please let me know and I will follow up with results.
> 
> [1] https://lore.kernel.org/all/aef9de29-e9f5-259a-f8be-12d1b734e72@google.com/
> 
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Keith Busch <kbusch@kernel.org>
> Cc: Liu Song <liusong@linux.alibaba.com>
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
> ---
>   include/linux/sbitmap.h |  16 ++++--
>   lib/sbitmap.c           | 122 +++++++++-------------------------------
>   2 files changed, 37 insertions(+), 101 deletions(-)
> 
> diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
> index 4d2d5205ab58..d662cf136021 100644
> --- a/include/linux/sbitmap.h
> +++ b/include/linux/sbitmap.h
> @@ -86,11 +86,6 @@ struct sbitmap {
>    * struct sbq_wait_state - Wait queue in a &struct sbitmap_queue.
>    */
>   struct sbq_wait_state {
> -	/**
> -	 * @wait_cnt: Number of frees remaining before we wake up.
> -	 */
> -	atomic_t wait_cnt;
> -
>   	/**
>   	 * @wait: Wait queue.
>   	 */
> @@ -138,6 +133,17 @@ struct sbitmap_queue {
>   	 * sbitmap_queue_get_shallow()
>   	 */
>   	unsigned int min_shallow_depth;
> +
> +	/**
> +	 * @completion_cnt: Number of bits cleared passed to the
> +	 * wakeup function.
> +	 */
> +	atomic_t completion_cnt;
> +
> +	/**
> +	 * @wakeup_cnt: Number of thread wake ups issued.
> +	 */
> +	atomic_t wakeup_cnt;
>   };
>   
>   /**
> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
> index 7280ae8ca88c..eca462cba398 100644
> --- a/lib/sbitmap.c
> +++ b/lib/sbitmap.c
> @@ -434,6 +434,8 @@ int sbitmap_queue_init_node(struct sbitmap_queue *sbq, unsigned int depth,
>   	sbq->wake_batch = sbq_calc_wake_batch(sbq, depth);
>   	atomic_set(&sbq->wake_index, 0);
>   	atomic_set(&sbq->ws_active, 0);
> +	atomic_set(&sbq->completion_cnt, 0);
> +	atomic_set(&sbq->wakeup_cnt, 0);
>   
>   	sbq->ws = kzalloc_node(SBQ_WAIT_QUEUES * sizeof(*sbq->ws), flags, node);
>   	if (!sbq->ws) {
> @@ -441,40 +443,21 @@ int sbitmap_queue_init_node(struct sbitmap_queue *sbq, unsigned int depth,
>   		return -ENOMEM;
>   	}
>   
> -	for (i = 0; i < SBQ_WAIT_QUEUES; i++) {
> +	for (i = 0; i < SBQ_WAIT_QUEUES; i++)
>   		init_waitqueue_head(&sbq->ws[i].wait);
> -		atomic_set(&sbq->ws[i].wait_cnt, sbq->wake_batch);
> -	}
>   
>   	return 0;
>   }
>   EXPORT_SYMBOL_GPL(sbitmap_queue_init_node);
>   
> -static inline void __sbitmap_queue_update_wake_batch(struct sbitmap_queue *sbq,
> -					    unsigned int wake_batch)
> -{
> -	int i;
> -
> -	if (sbq->wake_batch != wake_batch) {
> -		WRITE_ONCE(sbq->wake_batch, wake_batch);
> -		/*
> -		 * Pairs with the memory barrier in sbitmap_queue_wake_up()
> -		 * to ensure that the batch size is updated before the wait
> -		 * counts.
> -		 */
> -		smp_mb();
> -		for (i = 0; i < SBQ_WAIT_QUEUES; i++)
> -			atomic_set(&sbq->ws[i].wait_cnt, 1);
> -	}
> -}
> -
>   static void sbitmap_queue_update_wake_batch(struct sbitmap_queue *sbq,
>   					    unsigned int depth)
>   {
>   	unsigned int wake_batch;
>   
>   	wake_batch = sbq_calc_wake_batch(sbq, depth);
> -	__sbitmap_queue_update_wake_batch(sbq, wake_batch);
> +	if (sbq->wake_batch != wake_batch)
> +		WRITE_ONCE(sbq->wake_batch, wake_batch);
>   }
>   
>   void sbitmap_queue_recalculate_wake_batch(struct sbitmap_queue *sbq,
> @@ -488,7 +471,8 @@ void sbitmap_queue_recalculate_wake_batch(struct sbitmap_queue *sbq,
>   
>   	wake_batch = clamp_val(depth / SBQ_WAIT_QUEUES,
>   			min_batch, SBQ_WAKE_BATCH);
> -	__sbitmap_queue_update_wake_batch(sbq, wake_batch);
> +
> +	WRITE_ONCE(sbq->wake_batch, wake_batch);
>   }
>   EXPORT_SYMBOL_GPL(sbitmap_queue_recalculate_wake_batch);
>   
> @@ -587,7 +571,7 @@ static struct sbq_wait_state *sbq_wake_ptr(struct sbitmap_queue *sbq)
>   	for (i = 0; i < SBQ_WAIT_QUEUES; i++) {
>   		struct sbq_wait_state *ws = &sbq->ws[wake_index];
>   
> -		if (waitqueue_active(&ws->wait) && atomic_read(&ws->wait_cnt)) {
> +		if (waitqueue_active(&ws->wait)) {
>   			if (wake_index != atomic_read(&sbq->wake_index))
>   				atomic_set(&sbq->wake_index, wake_index);
>   			return ws;
> @@ -599,83 +583,31 @@ static struct sbq_wait_state *sbq_wake_ptr(struct sbitmap_queue *sbq)
>   	return NULL;
>   }
>   
> -static bool __sbq_wake_up(struct sbitmap_queue *sbq, int *nr)
> +void sbitmap_queue_wake_up(struct sbitmap_queue *sbq, int nr)
>   {
> -	struct sbq_wait_state *ws;
> -	unsigned int wake_batch;
> -	int wait_cnt, cur, sub;
> -	bool ret;
> +	unsigned int wake_batch = READ_ONCE(sbq->wake_batch);
> +	struct sbq_wait_state *ws = NULL;
> +	unsigned int wakeups;
>   
> -	if (*nr <= 0)
> -		return false;
> +	if (!atomic_read(&sbq->ws_active))
> +		return;
>   
> -	ws = sbq_wake_ptr(sbq);
> -	if (!ws)
> -		return false;
> +	atomic_add(nr, &sbq->completion_cnt);
> +	wakeups = atomic_read(&sbq->wakeup_cnt);
>   
> -	cur = atomic_read(&ws->wait_cnt);
>   	do {
> -		/*
> -		 * For concurrent callers of this, callers should call this
> -		 * function again to wakeup a new batch on a different 'ws'.
> -		 */
> -		if (cur == 0)
> -			return true;
> -		sub = min(*nr, cur);
> -		wait_cnt = cur - sub;
> -	} while (!atomic_try_cmpxchg(&ws->wait_cnt, &cur, wait_cnt));
> -
> -	/*
> -	 * If we decremented queue without waiters, retry to avoid lost
> -	 * wakeups.
> -	 */
> -	if (wait_cnt > 0)
> -		return !waitqueue_active(&ws->wait);
> +		if (atomic_read(&sbq->completion_cnt) - wakeups < wake_batch)
> +			return;

Should it be considered that completion_cnt overflow and becomes
negtive?

Thanks,
Kuai
>   
> -	*nr -= sub;
> -
> -	/*
> -	 * When wait_cnt == 0, we have to be particularly careful as we are
> -	 * responsible to reset wait_cnt regardless whether we've actually
> -	 * woken up anybody. But in case we didn't wakeup anybody, we still
> -	 * need to retry.
> -	 */
> -	ret = !waitqueue_active(&ws->wait);
> -	wake_batch = READ_ONCE(sbq->wake_batch);
> +		if (!ws) {
> +			ws = sbq_wake_ptr(sbq);
> +			if (!ws)
> +				return;
> +		}
> +	} while (!atomic_try_cmpxchg(&sbq->wakeup_cnt,
> +				     &wakeups, wakeups + wake_batch));
>   
> -	/*
> -	 * Wake up first in case that concurrent callers decrease wait_cnt
> -	 * while waitqueue is empty.
> -	 */
>   	wake_up_nr(&ws->wait, wake_batch);
> -
> -	/*
> -	 * Pairs with the memory barrier in sbitmap_queue_resize() to
> -	 * ensure that we see the batch size update before the wait
> -	 * count is reset.
> -	 *
> -	 * Also pairs with the implicit barrier between decrementing wait_cnt
> -	 * and checking for waitqueue_active() to make sure waitqueue_active()
> -	 * sees result of the wakeup if atomic_dec_return() has seen the result
> -	 * of atomic_set().
> -	 */
> -	smp_mb__before_atomic();
> -
> -	/*
> -	 * Increase wake_index before updating wait_cnt, otherwise concurrent
> -	 * callers can see valid wait_cnt in old waitqueue, which can cause
> -	 * invalid wakeup on the old waitqueue.
> -	 */
> -	sbq_index_atomic_inc(&sbq->wake_index);
> -	atomic_set(&ws->wait_cnt, wake_batch);
> -
> -	return ret || *nr;
> -}
> -
> -void sbitmap_queue_wake_up(struct sbitmap_queue *sbq, int nr)
> -{
> -	while (__sbq_wake_up(sbq, &nr))
> -		;
>   }
>   EXPORT_SYMBOL_GPL(sbitmap_queue_wake_up);
>   
> @@ -792,9 +724,7 @@ void sbitmap_queue_show(struct sbitmap_queue *sbq, struct seq_file *m)
>   	seq_puts(m, "ws={\n");
>   	for (i = 0; i < SBQ_WAIT_QUEUES; i++) {
>   		struct sbq_wait_state *ws = &sbq->ws[i];
> -
> -		seq_printf(m, "\t{.wait_cnt=%d, .wait=%s},\n",
> -			   atomic_read(&ws->wait_cnt),
> +		seq_printf(m, "\t{.wait=%s},\n",
>   			   waitqueue_active(&ws->wait) ? "active" : "inactive");
>   	}
>   	seq_puts(m, "}\n");
> 

