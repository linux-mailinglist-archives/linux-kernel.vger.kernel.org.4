Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86FAF623E93
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 10:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiKJJ2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 04:28:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiKJJ2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 04:28:17 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E73E6A6B7;
        Thu, 10 Nov 2022 01:28:15 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4N7Gj51hJjz4f3kpk;
        Thu, 10 Nov 2022 17:28:09 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgDH69gqxGxjfpcmAQ--.40494S3;
        Thu, 10 Nov 2022 17:28:12 +0800 (CST)
Subject: Re: [PATCH] block, bfq: do the all counting of pending-request if
 CONFIG_BFQ_GROUP_IOSCHED is enabled
To:     Yuwei Guan <ssawgyw@gmail.com>, paolo.valente@linaro.org,
        axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuwei.Guan@zeekrlife.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20221109132914.438777-1-Yuwei.Guan@zeekrlife.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <52ccc3f0-a628-a9bf-f604-3b86dd34b006@huaweicloud.com>
Date:   Thu, 10 Nov 2022 17:28:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20221109132914.438777-1-Yuwei.Guan@zeekrlife.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDH69gqxGxjfpcmAQ--.40494S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Gw4UJr1xXF1UCw4UWFy7GFg_yoW7Xr4kpa
        9Ig3WUCF15JrsYgry5Ja18Xr93Wrn3uF9FkFWvy34Skr47Ar9xt3ZIkr1rZryIgr95Aw47
        ZF1FgryDZw17AFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
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

ÔÚ 2022/11/09 21:29, Yuwei Guan Ð´µÀ:
> The 'bfqd->num_groups_with_pending_reqs' is used when
> CONFIG_BFQ_GROUP_IOSCHED is enabled, so let the variables and processes
> take effect when ONFIG_BFQ_GROUP_IOSCHED is enabled.
> 
> Cc: Yu Kuai <yukuai3@huawei.com>
> Signed-off-by: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
> ---
>   block/bfq-iosched.c |  5 ++++-
>   block/bfq-iosched.h |  6 ++++++
>   block/bfq-wf2q.c    | 10 ++++++----
>   3 files changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 2381cf220ba2..5a648433fd89 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -6192,8 +6192,9 @@ static void bfq_completed_request(struct bfq_queue *bfqq, struct bfq_data *bfqd)
>   		 * mechanism).
>   		 */
>   		bfqq->budget_timeout = jiffies;
> -
> +#ifdef CONFIG_BFQ_GROUP_IOSCHED
>   		bfq_del_bfqq_in_groups_with_pending_reqs(bfqq);
> +#endif
>   		bfq_weights_tree_remove(bfqq);
>   	}

Thanks for the patch, this make sense. However, I prefer to
declare a empty function if the config is disabled instead of adding
"#ifdef" everywhere the function is called.

Thanks,
Kuai
>   
> @@ -7051,7 +7052,9 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
>   	bfqd->idle_slice_timer.function = bfq_idle_slice_timer;
>   
>   	bfqd->queue_weights_tree = RB_ROOT_CACHED;
> +#ifdef CONFIG_BFQ_GROUP_IOSCHED
>   	bfqd->num_groups_with_pending_reqs = 0;
> +#endif
>   
>   	INIT_LIST_HEAD(&bfqd->active_list);
>   	INIT_LIST_HEAD(&bfqd->idle_list);
> diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
> index 9fa89577322d..d6b9fad28a3b 100644
> --- a/block/bfq-iosched.h
> +++ b/block/bfq-iosched.h
> @@ -197,8 +197,10 @@ struct bfq_entity {
>   	/* flag, set to request a weight, ioprio or ioprio_class change  */
>   	int prio_changed;
>   
> +#ifdef CONFIG_BFQ_GROUP_IOSCHED
>   	/* flag, set if the entity is counted in groups_with_pending_reqs */
>   	bool in_groups_with_pending_reqs;
> +#endif
>   
>   	/* last child queue of entity created (for non-leaf entities) */
>   	struct bfq_queue *last_bfqq_created;
> @@ -491,6 +493,7 @@ struct bfq_data {
>   	 */
>   	struct rb_root_cached queue_weights_tree;
>   
> +#ifdef CONFIG_BFQ_GROUP_IOSCHED
>   	/*
>   	 * Number of groups with at least one process that
>   	 * has at least one request waiting for completion. Note that
> @@ -538,6 +541,7 @@ struct bfq_data {
>   	 * with no request waiting for completion.
>   	 */
>   	unsigned int num_groups_with_pending_reqs;
> +#endif
>   
>   	/*
>   	 * Per-class (RT, BE, IDLE) number of bfq_queues containing
> @@ -1074,8 +1078,10 @@ void bfq_requeue_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq,
>   		      bool expiration);
>   void bfq_del_bfqq_busy(struct bfq_queue *bfqq, bool expiration);
>   void bfq_add_bfqq_busy(struct bfq_queue *bfqq);
> +#ifdef CONFIG_BFQ_GROUP_IOSCHED
>   void bfq_add_bfqq_in_groups_with_pending_reqs(struct bfq_queue *bfqq);
>   void bfq_del_bfqq_in_groups_with_pending_reqs(struct bfq_queue *bfqq);
> +#endif
>   
>   /* --------------- end of interface of B-WF2Q+ ---------------- */
>   
> diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
> index b02b53658ed4..a29187ecdc39 100644
> --- a/block/bfq-wf2q.c
> +++ b/block/bfq-wf2q.c
> @@ -1610,16 +1610,15 @@ void bfq_requeue_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq,
>   				    bfqq == bfqd->in_service_queue, expiration);
>   }
>   
> +#ifdef CONFIG_BFQ_GROUP_IOSCHED
>   void bfq_add_bfqq_in_groups_with_pending_reqs(struct bfq_queue *bfqq)
>   {
>   	struct bfq_entity *entity = &bfqq->entity;
>   
>   	if (!entity->in_groups_with_pending_reqs) {
>   		entity->in_groups_with_pending_reqs = true;
> -#ifdef CONFIG_BFQ_GROUP_IOSCHED
>   		if (!(bfqq_group(bfqq)->num_queues_with_pending_reqs++))
>   			bfqq->bfqd->num_groups_with_pending_reqs++;
> -#endif
>   	}
>   }
>   
> @@ -1629,12 +1628,11 @@ void bfq_del_bfqq_in_groups_with_pending_reqs(struct bfq_queue *bfqq)
>   
>   	if (entity->in_groups_with_pending_reqs) {
>   		entity->in_groups_with_pending_reqs = false;
> -#ifdef CONFIG_BFQ_GROUP_IOSCHED
>   		if (!(--bfqq_group(bfqq)->num_queues_with_pending_reqs))
>   			bfqq->bfqd->num_groups_with_pending_reqs--;
> -#endif
>   	}
>   }
> +#endif
>   
>   /*
>    * Called when the bfqq no longer has requests pending, remove it from
> @@ -1659,7 +1657,9 @@ void bfq_del_bfqq_busy(struct bfq_queue *bfqq, bool expiration)
>   	bfq_deactivate_bfqq(bfqd, bfqq, true, expiration);
>   
>   	if (!bfqq->dispatched) {
> +#ifdef CONFIG_BFQ_GROUP_IOSCHED
>   		bfq_del_bfqq_in_groups_with_pending_reqs(bfqq);
> +#endif
>   		/*
>   		 * Next function is invoked last, because it causes bfqq to be
>   		 * freed. DO NOT use bfqq after the next function invocation.
> @@ -1683,7 +1683,9 @@ void bfq_add_bfqq_busy(struct bfq_queue *bfqq)
>   	bfqd->busy_queues[bfqq->ioprio_class - 1]++;
>   
>   	if (!bfqq->dispatched) {
> +#ifdef CONFIG_BFQ_GROUP_IOSCHED
>   		bfq_add_bfqq_in_groups_with_pending_reqs(bfqq);
> +#endif
>   		if (bfqq->wr_coeff == 1)
>   			bfq_weights_tree_add(bfqq);
>   	}
> 

