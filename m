Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C64286E03FC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 04:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjDMCJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 22:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjDMCJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 22:09:28 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985E44C3D;
        Wed, 12 Apr 2023 19:09:26 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Pxjgj6Xhyz4f3yb6;
        Thu, 13 Apr 2023 10:09:21 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgBnFCJRZDdkM37DGg--.36443S3;
        Thu, 13 Apr 2023 10:09:23 +0800 (CST)
Subject: Re: [PATCH 4/4] blk-iolatency: Make initialization lazy
To:     Tejun Heo <tj@kernel.org>, axboe@kernel.dk, josef@toxicpanda.com,
        hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai1@huaweicloud.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230413000649.115785-1-tj@kernel.org>
 <20230413000649.115785-5-tj@kernel.org>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <661dc6d6-2786-cbe5-e751-95947a1608cc@huaweicloud.com>
Date:   Thu, 13 Apr 2023 10:09:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230413000649.115785-5-tj@kernel.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgBnFCJRZDdkM37DGg--.36443S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAryrur1xKFWDKFy3ZFW3Awb_yoWrCr4rpr
        4rWFsxC3yfKFs7WF1xtr4xCr15Kw4kKryrGryfCrySvr129r9xtF1kuF1jqFWkZr4DAFs3
        Jr48tryDKr4Fk3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_
        Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UU
        UUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

ÔÚ 2023/04/13 8:06, Tejun Heo Ð´µÀ:
> Other rq_qos policies such as wbt and iocost are lazy-initialized when they
> are configured for the first time for the device but iolatency is
> initialized unconditionally from blkcg_init_disk() during gendisk init. Lazy
> init is beneficial because rq_qos policies add runtime overhead when
> initialized as every IO has to walk all registered rq_qos callbacks.
> 
> This patch switches iolatency to lazy initialization too so that it only
> registered its rq_qos policy when it is first configured.
> 
> Note that there is a known race condition between blkcg config file writes
> and del_gendisk() and this patch makes iolatency susceptible to it by
> exposing the init path to race against the deletion path. However, that
> problem already exists in iocost and is being worked on.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Cc: Josef Bacik <josef@toxicpanda.com>
> ---
>   block/blk-cgroup.c    |  8 --------
>   block/blk-iolatency.c | 29 ++++++++++++++++++++++++++++-
>   block/blk.h           |  6 ------
>   3 files changed, 28 insertions(+), 15 deletions(-)
> 
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index c154b08a7e92..1c1ebeb51003 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -33,7 +33,6 @@
>   #include "blk-cgroup.h"
>   #include "blk-ioprio.h"
>   #include "blk-throttle.h"
> -#include "blk-rq-qos.h"
>   
>   /*
>    * blkcg_pol_mutex protects blkcg_policy[] and policy [de]activation.
> @@ -1350,14 +1349,8 @@ int blkcg_init_disk(struct gendisk *disk)
>   	if (ret)
>   		goto err_ioprio_exit;
>   
> -	ret = blk_iolatency_init(disk);
> -	if (ret)
> -		goto err_throtl_exit;
> -
>   	return 0;
>   
> -err_throtl_exit:
> -	blk_throtl_exit(disk);
>   err_ioprio_exit:
>   	blk_ioprio_exit(disk);
>   err_destroy_all:
> @@ -1373,7 +1366,6 @@ int blkcg_init_disk(struct gendisk *disk)
>   void blkcg_exit_disk(struct gendisk *disk)
>   {
>   	blkg_destroy_all(disk);
> -	rq_qos_exit(disk->queue);
>   	blk_throtl_exit(disk);
>   }
>   
> diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
> index 2560708b9109..fd5fec989e39 100644
> --- a/block/blk-iolatency.c
> +++ b/block/blk-iolatency.c
> @@ -755,7 +755,7 @@ static void blkiolatency_enable_work_fn(struct work_struct *work)
>   	}
>   }
>   
> -int blk_iolatency_init(struct gendisk *disk)
> +static int blk_iolatency_init(struct gendisk *disk)
>   {
>   	struct blk_iolatency *blkiolat;
>   	int ret;
> @@ -824,6 +824,29 @@ static void iolatency_clear_scaling(struct blkcg_gq *blkg)
>   	}
>   }
>   
> +static int blk_iolatency_try_init(struct blkg_conf_ctx *ctx)
> +{
> +	static DEFINE_MUTEX(init_mutex);
> +	int ret;
> +
> +	ret = blkg_conf_open_bdev(ctx);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * blk_iolatency_init() may fail after rq_qos_add() succeeds which can
> +	 * confuse iolat_rq_qos() test. Make the test and init atomic.
> +	 */
> +	mutex_lock(&init_mutex);

Can we just convert the return value from -EBUSY to 0 in this case, so
that the global lock won't be needed.

Thanks,
Kuai
> +
> +	if (!iolat_rq_qos(ctx->bdev->bd_queue))
> +		ret = blk_iolatency_init(ctx->bdev->bd_disk);
> +
> +	mutex_unlock(&init_mutex);
> +
> +	return ret;
> +}
> +
>   static ssize_t iolatency_set_limit(struct kernfs_open_file *of, char *buf,
>   			     size_t nbytes, loff_t off)
>   {
> @@ -838,6 +861,10 @@ static ssize_t iolatency_set_limit(struct kernfs_open_file *of, char *buf,
>   
>   	blkg_conf_init(&ctx, buf);
>   
> +	ret = blk_iolatency_try_init(&ctx);
> +	if (ret)
> +		goto out;
> +
>   	ret = blkg_conf_prep(blkcg, &blkcg_policy_iolatency, &ctx);
>   	if (ret)
>   		goto out;
> diff --git a/block/blk.h b/block/blk.h
> index d65d96994a94..62fca868bc61 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -399,12 +399,6 @@ static inline struct bio *blk_queue_bounce(struct bio *bio,
>   	return bio;
>   }
>   
> -#ifdef CONFIG_BLK_CGROUP_IOLATENCY
> -int blk_iolatency_init(struct gendisk *disk);
> -#else
> -static inline int blk_iolatency_init(struct gendisk *disk) { return 0; };
> -#endif
> -
>   #ifdef CONFIG_BLK_DEV_ZONED
>   void disk_free_zone_bitmaps(struct gendisk *disk);
>   void disk_clear_zone_settings(struct gendisk *disk);
> 

