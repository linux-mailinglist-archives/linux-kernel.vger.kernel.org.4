Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D42A5BFBA0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 11:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbiIUJtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 05:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbiIUJsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:48:52 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446BB97B38;
        Wed, 21 Sep 2022 02:46:24 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4MXYPW3fjcz6PjxM;
        Wed, 21 Sep 2022 17:43:11 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP2 (Coremail) with SMTP id Syh0CgD3SXMk3SpjoJ6tBA--.14569S3;
        Wed, 21 Sep 2022 17:45:09 +0800 (CST)
Subject: Re: [PATCH -next] blk-wbt: call rq_qos_add() after wb_normal is
 initialized
To:     Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20220913105749.3086243-1-yukuai1@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <eef13e74-9f5b-23d9-07d8-7ee8f5e30012@huaweicloud.com>
Date:   Wed, 21 Sep 2022 17:45:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20220913105749.3086243-1-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgD3SXMk3SpjoJ6tBA--.14569S3
X-Coremail-Antispam: 1UD129KBjvJXoWxuryUuryfJF47WF47Xr13urg_yoW5GF4xpa
        yIkFW3tayjgr4v93Z7Jr47ZFWfGws5tr1xury3G34YvF93Cr1j9anYkF15W3s5ArWkCF45
        JF1FyFsxCFyUC3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AKxVWUJVW8
        JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UU
        UUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/09/13 18:57, Yu Kuai 写道:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Our test found a problem that wbt inflight counter is negative, which
> will cause io hang(noted that this problem doesn't exist in mainline):
> 
> t1: device create	t2: issue io
> add_disk
>   blk_register_queue
>    wbt_enable_default
>     wbt_init
>      rq_qos_add
>      // wb_normal is still 0
> 			/*
> 			 * in mainline, disk can't be opened before
> 			 * bdev_add(), however, in old kernels, disk
> 			 * can be opened before blk_register_queue().
> 			 */
> 			blkdev_issue_flush
>                          // disk size is 0, however, it's not checked
>                           submit_bio_wait
>                            submit_bio
>                             blk_mq_submit_bio
>                              rq_qos_throttle
>                               wbt_wait
> 			      bio_to_wbt_flags
>                                 rwb_enabled
> 			       // wb_normal is 0, inflight is not increased
> 
>      wbt_queue_depth_changed(&rwb->rqos);
>       wbt_update_limits
>       // wb_normal is initialized
>                              rq_qos_track
>                               wbt_track
>                                rq->wbt_flags |= bio_to_wbt_flags(rwb, bio);
> 			      // wb_normal is not 0，wbt_flags will be set
> t3: io completion
> blk_mq_free_request
>   rq_qos_done
>    wbt_done
>     wbt_is_tracked
>     // return true
>     __wbt_done
>      wbt_rqw_done
>       atomic_dec_return(&rqw->inflight);
>       // inflight is decreased
> 
> commit 8235b5c1e8c1 ("block: call bdev_add later in device_add_disk") can
> avoid this problem, however it's better to fix this problem in wbt:
> 
> 1) Lower kernel can't backport this patch due to lots of refactor.
> 2) Root cause is that wbt call rq_qos_add() before wb_normal is
> initialized.
> 
friendly ping ...
> Fixes: e34cbd307477 ("blk-wbt: add general throttling mechanism")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   block/blk-wbt.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/block/blk-wbt.c b/block/blk-wbt.c
> index a9982000b667..246467926253 100644
> --- a/block/blk-wbt.c
> +++ b/block/blk-wbt.c
> @@ -843,6 +843,10 @@ int wbt_init(struct request_queue *q)
>   	rwb->enable_state = WBT_STATE_ON_DEFAULT;
>   	rwb->wc = 1;
>   	rwb->rq_depth.default_depth = RWB_DEF_DEPTH;
> +	rwb->min_lat_nsec = wbt_default_latency_nsec(q);
> +
> +	wbt_queue_depth_changed(&rwb->rqos);
> +	wbt_set_write_cache(q, test_bit(QUEUE_FLAG_WC, &q->queue_flags));
>   
>   	/*
>   	 * Assign rwb and add the stats callback.
> @@ -853,11 +857,6 @@ int wbt_init(struct request_queue *q)
>   
>   	blk_stat_add_callback(q, rwb->cb);
>   
> -	rwb->min_lat_nsec = wbt_default_latency_nsec(q);
> -
> -	wbt_queue_depth_changed(&rwb->rqos);
> -	wbt_set_write_cache(q, test_bit(QUEUE_FLAG_WC, &q->queue_flags));
> -
>   	return 0;
>   
>   err_free:
> 

