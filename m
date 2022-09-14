Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF105B8628
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 12:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbiINKV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 06:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiINKVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 06:21:17 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE4E476CD;
        Wed, 14 Sep 2022 03:21:14 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MSGXm1BxwzlDWv;
        Wed, 14 Sep 2022 18:19:36 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP2 (Coremail) with SMTP id Syh0CgBH53AWqyFj1hlUAw--.28757S3;
        Wed, 14 Sep 2022 18:21:12 +0800 (CST)
Subject: Re: [PATCH v2 2/4] md/raid10: prevent unnecessary calls to wake_up()
 in fast path
To:     Yu Kuai <yukuai1@huaweicloud.com>, song@kernel.org,
        logang@deltatee.com, guoqing.jiang@linux.dev, pmenzel@molgen.mpg.de
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20220914014914.398712-1-yukuai1@huaweicloud.com>
 <20220914014914.398712-3-yukuai1@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <39f4a1f0-7f84-ad84-c9f8-e45e63346190@huaweicloud.com>
Date:   Wed, 14 Sep 2022 18:21:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20220914014914.398712-3-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgBH53AWqyFj1hlUAw--.28757S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCF15Kr4kAw4fZrykCrWktFb_yoWruF4xp3
        yaqFWYyFWUZF90qw4DJFWUu3Wjgr1ktFWIkrWvkwn2yF48tr93tF1UGryDCryqvrZ7ur17
        XFWFkrZ3Gw47tFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
        Y487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
        0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
        0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
        WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_
        Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbU
        UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ÔÚ 2022/09/14 9:49, Yu Kuai Ð´µÀ:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Currently, wake_up() is called unconditionally in fast path such as
> raid10_make_request(), which will cause lock contention under high
> concurrency:
> 
> raid10_make_request
>   wake_up
>    __wake_up_common_lock
>     spin_lock_irqsave
> 
> Improve performance by only call wake_up() if waitqueue is not empty.
> 
Hi,

I'm replacing all the wake_up() here, currently I'm not quite sure it's
OK, "conf->wait_barrier" is used for many purpose.

Perhaps should I just replace host path here? (raid10_make_request
and allow_barrier().

Thanks,
Kuai

> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   drivers/md/raid10.c | 26 ++++++++++++++++----------
>   1 file changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index 56458a53043d..0edcd98461fe 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -274,6 +274,12 @@ static void put_buf(struct r10bio *r10_bio)
>   	lower_barrier(conf);
>   }
>   
> +static void wake_up_barrier(struct r10conf *conf)
> +{
> +	if (wq_has_sleeper(&conf->wait_barrier))
> +		wake_up(&conf->wait_barrier);
> +}
> +
>   static void reschedule_retry(struct r10bio *r10_bio)
>   {
>   	unsigned long flags;
> @@ -286,7 +292,7 @@ static void reschedule_retry(struct r10bio *r10_bio)
>   	spin_unlock_irqrestore(&conf->device_lock, flags);
>   
>   	/* wake up frozen array... */
> -	wake_up(&conf->wait_barrier);
> +	wake_up_barrier(conf);
>   
>   	md_wakeup_thread(mddev->thread);
>   }
> @@ -884,7 +890,7 @@ static void flush_pending_writes(struct r10conf *conf)
>   		/* flush any pending bitmap writes to disk
>   		 * before proceeding w/ I/O */
>   		md_bitmap_unplug(conf->mddev->bitmap);
> -		wake_up(&conf->wait_barrier);
> +		wake_up_barrier(conf);
>   
>   		while (bio) { /* submit pending writes */
>   			struct bio *next = bio->bi_next;
> @@ -954,7 +960,7 @@ static void lower_barrier(struct r10conf *conf)
>   	spin_lock_irqsave(&conf->resync_lock, flags);
>   	conf->barrier--;
>   	spin_unlock_irqrestore(&conf->resync_lock, flags);
> -	wake_up(&conf->wait_barrier);
> +	wake_up_barrier(conf);
>   }
>   
>   static bool stop_waiting_barrier(struct r10conf *conf)
> @@ -1004,7 +1010,7 @@ static bool wait_barrier(struct r10conf *conf, bool nowait)
>   			conf->nr_waiting--;
>   		}
>   		if (!conf->nr_waiting)
> -			wake_up(&conf->wait_barrier);
> +			wake_up_barrier(conf);
>   	}
>   	/* Only increment nr_pending when we wait */
>   	if (ret)
> @@ -1017,7 +1023,7 @@ static void allow_barrier(struct r10conf *conf)
>   {
>   	if ((atomic_dec_and_test(&conf->nr_pending)) ||
>   			(conf->array_freeze_pending))
> -		wake_up(&conf->wait_barrier);
> +		wake_up_barrier(conf);
>   }
>   
>   static void freeze_array(struct r10conf *conf, int extra)
> @@ -1053,7 +1059,7 @@ static void unfreeze_array(struct r10conf *conf)
>   	spin_lock_irq(&conf->resync_lock);
>   	conf->barrier--;
>   	conf->nr_waiting--;
> -	wake_up(&conf->wait_barrier);
> +	wake_up_barrier(conf);
>   	spin_unlock_irq(&conf->resync_lock);
>   }
>   
> @@ -1078,7 +1084,7 @@ static void raid10_unplug(struct blk_plug_cb *cb, bool from_schedule)
>   		spin_lock_irq(&conf->device_lock);
>   		bio_list_merge(&conf->pending_bio_list, &plug->pending);
>   		spin_unlock_irq(&conf->device_lock);
> -		wake_up(&conf->wait_barrier);
> +		wake_up_barrier(conf);
>   		md_wakeup_thread(mddev->thread);
>   		kfree(plug);
>   		return;
> @@ -1087,7 +1093,7 @@ static void raid10_unplug(struct blk_plug_cb *cb, bool from_schedule)
>   	/* we aren't scheduling, so we can do the write-out directly. */
>   	bio = bio_list_get(&plug->pending);
>   	md_bitmap_unplug(mddev->bitmap);
> -	wake_up(&conf->wait_barrier);
> +	wake_up_barrier(conf);
>   
>   	while (bio) { /* submit pending writes */
>   		struct bio *next = bio->bi_next;
> @@ -1893,7 +1899,7 @@ static bool raid10_make_request(struct mddev *mddev, struct bio *bio)
>   	__make_request(mddev, bio, sectors);
>   
>   	/* In case raid10d snuck in to freeze_array */
> -	wake_up(&conf->wait_barrier);
> +	wake_up_barrier(conf);
>   	return true;
>   }
>   
> @@ -3040,7 +3046,7 @@ static void handle_write_completed(struct r10conf *conf, struct r10bio *r10_bio)
>   			 * In case freeze_array() is waiting for condition
>   			 * nr_pending == nr_queued + extra to be true.
>   			 */
> -			wake_up(&conf->wait_barrier);
> +			wake_up_barrier(conf);
>   			md_wakeup_thread(conf->mddev->thread);
>   		} else {
>   			if (test_bit(R10BIO_WriteError,
> 

