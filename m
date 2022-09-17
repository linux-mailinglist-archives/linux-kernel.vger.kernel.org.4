Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3259B5BB7B7
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 12:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiIQKUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 06:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiIQKUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 06:20:39 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3928136865;
        Sat, 17 Sep 2022 03:20:34 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MV6ND4LzTzKLFV;
        Sat, 17 Sep 2022 18:18:36 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP2 (Coremail) with SMTP id Syh0CgA3inNunyVjbrzoAw--.34097S3;
        Sat, 17 Sep 2022 18:20:32 +0800 (CST)
Subject: Re: [PATCH] sbitmap: fix permanent io blocking caused by insufficient
 wakeup times
To:     Liu Song <liusong@linux.alibaba.com>, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        "yukuai (C)" <yukuai3@huawei.com>
References: <1663381981-6413-1-git-send-email-liusong@linux.alibaba.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <ab451e4c-e1ca-d7a3-6e02-c7d12a473124@huaweicloud.com>
Date:   Sat, 17 Sep 2022 18:20:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1663381981-6413-1-git-send-email-liusong@linux.alibaba.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgA3inNunyVjbrzoAw--.34097S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGFyDtw13GFy8try5tr4fXwb_yoWrXr15pF
        WDGFn3uw1rtrW2qr43JrWUA3Zagw4v9r93GrWfG34rCr4jqrnaqr10kanxZw4rJF4DGanr
        Jrs8CFs5G3yUXFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyKb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
        wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
        k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
        1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

ÔÚ 2022/09/17 10:33, Liu Song Ð´µÀ:
> From: Liu Song <liusong@linux.alibaba.com>
> 
> In "sbitmap_queue_clear_batch", a batch of completed requests may be
> processed at once, but "wait_cnt" is only reduced once by
> "sbitmap_queue_wake_up".
> In our environment, if "/sys/block/nvme0n1/nr_requests" is adjusted to
> 32, it is easily because no tag and then enter the waiting situation,
> if continue change "nr_requests" to 1023 at this time, it will basically
> fall into the situation of permanent blocking. Because there will be
> "blk_freeze_queue" in "blk_mq_update_nr_requests", which will prevent
> any new requests, but due to insufficient wake-up, there are tasks
> waiting for wake-up, but no new wake-up opportunities will be generated
> at this time, so this situation needs to be repaired.
> 

It seems Keith already fixed this recently. Can you have a check at his
patch?

Thanks,
Kuai
> Signed-off-by: Liu Song <liusong@linux.alibaba.com>
> ---
>   include/linux/sbitmap.h |  8 ++++++++
>   lib/sbitmap.c           | 22 ++++++++++++++++++----
>   2 files changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
> index 8f5a86e..153382e 100644
> --- a/include/linux/sbitmap.h
> +++ b/include/linux/sbitmap.h
> @@ -579,6 +579,14 @@ static inline struct sbq_wait_state *sbq_wait_ptr(struct sbitmap_queue *sbq,
>   void sbitmap_queue_wake_up(struct sbitmap_queue *sbq);
>   
>   /**
> + * sbitmap_queue_wake_up_batch() - Attempt to wake up waiters in batches
> + * on a &struct sbitmap_queue.
> + * @sbq: Bitmap queue to wake up.
> + * @nr: The number of attempts to wake the waiter.
> + */
> +void sbitmap_queue_wake_up_batch(struct sbitmap_queue *sbq, int nr);
> +
> +/**
>    * sbitmap_queue_show() - Dump &struct sbitmap_queue information to a &struct
>    * seq_file.
>    * @sbq: Bitmap queue to show.
> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
> index 29eb048..f2aa1da 100644
> --- a/lib/sbitmap.c
> +++ b/lib/sbitmap.c
> @@ -600,7 +600,7 @@ static struct sbq_wait_state *sbq_wake_ptr(struct sbitmap_queue *sbq)
>   	return NULL;
>   }
>   
> -static bool __sbq_wake_up(struct sbitmap_queue *sbq)
> +static bool __sbq_wake_up(struct sbitmap_queue *sbq, int *nr)
>   {
>   	struct sbq_wait_state *ws;
>   	unsigned int wake_batch;
> @@ -610,6 +610,7 @@ static bool __sbq_wake_up(struct sbitmap_queue *sbq)
>   	if (!ws)
>   		return false;
>   
> +again:
>   	wait_cnt = atomic_dec_return(&ws->wait_cnt);
>   	if (wait_cnt <= 0) {
>   		int ret;
> @@ -632,10 +633,14 @@ static bool __sbq_wake_up(struct sbitmap_queue *sbq)
>   		if (ret == wait_cnt) {
>   			sbq_index_atomic_inc(&sbq->wake_index);
>   			wake_up_nr(&ws->wait, wake_batch);
> -			return false;
> +			if (!nr || *nr <= 0)
> +				return false;
>   		}
>   
>   		return true;
> +	} else if (nr && *nr) {
> +		(*nr)--;
> +		goto again;
>   	}
>   
>   	return false;
> @@ -643,11 +648,20 @@ static bool __sbq_wake_up(struct sbitmap_queue *sbq)
>   
>   void sbitmap_queue_wake_up(struct sbitmap_queue *sbq)
>   {
> -	while (__sbq_wake_up(sbq))
> +	while (__sbq_wake_up(sbq, NULL))
>   		;
>   }
>   EXPORT_SYMBOL_GPL(sbitmap_queue_wake_up);
>   
> +void sbitmap_queue_wake_up_batch(struct sbitmap_queue *sbq, int nr)
> +{
> +	int i = SBQ_WAIT_QUEUES;
> +
> +	while (__sbq_wake_up(sbq, &nr) && --i)
> +		;
> +}
> +EXPORT_SYMBOL_GPL(sbitmap_queue_wake_up_batch);
> +
>   static inline void sbitmap_update_cpu_hint(struct sbitmap *sb, int cpu, int tag)
>   {
>   	if (likely(!sb->round_robin && tag < sb->depth))
> @@ -683,7 +697,7 @@ void sbitmap_queue_clear_batch(struct sbitmap_queue *sbq, int offset,
>   		atomic_long_andnot(mask, (atomic_long_t *) addr);
>   
>   	smp_mb__after_atomic();
> -	sbitmap_queue_wake_up(sbq);
> +	sbitmap_queue_wake_up_batch(sbq, nr_tags);
>   	sbitmap_update_cpu_hint(&sbq->sb, raw_smp_processor_id(),
>   					tags[nr_tags - 1] - offset);
>   }
> 

