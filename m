Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43C755B8652
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 12:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiINK0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 06:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiINK0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 06:26:10 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B301D47B93;
        Wed, 14 Sep 2022 03:26:07 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4MSGf51m88z6S35b;
        Wed, 14 Sep 2022 18:24:13 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP2 (Coremail) with SMTP id Syh0CgA3inM8rCFjb0JUAw--.56858S3;
        Wed, 14 Sep 2022 18:26:05 +0800 (CST)
Subject: Re: [PATCH v2 4/4] md/raid10: convert resync_lock to use seqlock
To:     Yu Kuai <yukuai1@huaweicloud.com>, song@kernel.org,
        logang@deltatee.com, guoqing.jiang@linux.dev, pmenzel@molgen.mpg.de
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20220914014914.398712-1-yukuai1@huaweicloud.com>
 <20220914014914.398712-5-yukuai1@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <de93d898-c69d-95de-95bb-3b899ca9f5b9@huaweicloud.com>
Date:   Wed, 14 Sep 2022 18:26:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20220914014914.398712-5-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgA3inM8rCFjb0JUAw--.56858S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Jw45Gr43Cw45trWrZr4fKrg_yoWxuFy3pw
        4aqr43tFWUXr9Iqrs8Ja1q9r1Fgw4kKFyUK392gan7ZFsYqryfCF1UGryFgryqvr9xJr1k
        XFWrCFZ3GwnFyFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AKxVW8JVWx
        JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUF9a9DU
        UUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

ÔÚ 2022/09/14 9:49, Yu Kuai Ð´µÀ:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Currently, wait_barrier() will hold 'resync_lock' to read 'conf->barrier',
> and io can't be dispatched until 'barrier' is dropped.
> 
> Since holding the 'barrier' is not common, convert 'resync_lock' to use
> seqlock so that holding lock can be avoided in fast path.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   drivers/md/raid10.c | 85 +++++++++++++++++++++++++++++----------------
>   drivers/md/raid10.h |  2 +-
>   2 files changed, 57 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index 377d4641bb54..6c2396fe75a0 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -79,6 +79,21 @@ static void end_reshape(struct r10conf *conf);
>   
>   #include "raid1-10.c"
>   
> +#define NULL_CMD
> +#define cmd_before(conf, cmd) \
> +	do { \
> +		write_sequnlock_irq(&(conf)->resync_lock); \
> +		cmd; \
> +	} while (0)
> +#define cmd_after(conf) write_seqlock_irq(&(conf)->resync_lock)
> +
> +#define wait_event_barrier_cmd(conf, cond, cmd) \
> +	wait_event_cmd((conf)->wait_barrier, cond, cmd_before(conf, cmd), \
> +		       cmd_after(conf))
> +
> +#define wait_event_barrier(conf, cond) \
> +	wait_event_barrier_cmd(conf, cond, NULL_CMD)
> +
>   /*
>    * for resync bio, r10bio pointer can be retrieved from the per-bio
>    * 'struct resync_pages'.
> @@ -936,30 +951,29 @@ static void flush_pending_writes(struct r10conf *conf)
>   
>   static void raise_barrier(struct r10conf *conf, int force)
>   {
> -	spin_lock_irq(&conf->resync_lock);
> +	write_seqlock_irq(&conf->resync_lock);
>   	BUG_ON(force && !conf->barrier);
>   
>   	/* Wait until no block IO is waiting (unless 'force') */
> -	wait_event_lock_irq(conf->wait_barrier, force || !conf->nr_waiting,
> -			    conf->resync_lock);
> +	wait_event_barrier(conf, force || !conf->nr_waiting);
>   
>   	/* block any new IO from starting */
> -	conf->barrier++;
> +	WRITE_ONCE(conf->barrier, conf->barrier + 1);
>   
>   	/* Now wait for all pending IO to complete */
> -	wait_event_lock_irq(conf->wait_barrier,
> -			    !atomic_read(&conf->nr_pending) && conf->barrier < RESYNC_DEPTH,
> -			    conf->resync_lock);
> +	wait_event_barrier(conf, !atomic_read(&conf->nr_pending) &&
> +				 conf->barrier < RESYNC_DEPTH);
>   
> -	spin_unlock_irq(&conf->resync_lock);
> +	write_sequnlock_irq(&conf->resync_lock);
>   }
>   
>   static void lower_barrier(struct r10conf *conf)
>   {
>   	unsigned long flags;
> -	spin_lock_irqsave(&conf->resync_lock, flags);
> -	conf->barrier--;
> -	spin_unlock_irqrestore(&conf->resync_lock, flags);
> +
> +	write_seqlock_irqsave(&conf->resync_lock, flags);
> +	WRITE_ONCE(conf->barrier, conf->barrier - 1);
> +	write_sequnlock_irqrestore(&conf->resync_lock, flags);
>   	wake_up_barrier(conf);
>   }
>   
> @@ -992,11 +1006,29 @@ static bool stop_waiting_barrier(struct r10conf *conf)
>   	return false;
>   }
>   
> +static bool wait_barrier_nolock(struct r10conf *conf)
> +{
> +	unsigned int seq = read_seqbegin(&conf->resync_lock);
> +
> +	if (READ_ONCE(conf->barrier))
> +		return false;
> +
> +	atomic_inc(&conf->nr_pending);
> +	if (!read_seqretry(&conf->resync_lock, seq))
> +		return true;
> +
> +	atomic_dec(&conf->nr_pending);

During pressure test, I found that this is problematic, raise_barrier()
can wait for nr_pending to be zero, and the increase and decrease here
will cause raise_barrier() hang if nr_pending is decreased to 0 here.

I'll send to new version to fix this.

Thanks,
Kuai
> +	return false;
> +}
> +
>   static bool wait_barrier(struct r10conf *conf, bool nowait)
>   {
>   	bool ret = true;
>   
> -	spin_lock_irq(&conf->resync_lock);
> +	if (wait_barrier_nolock(conf))
> +		return true;
> +
> +	write_seqlock_irq(&conf->resync_lock);
>   	if (conf->barrier) {
>   		/* Return false when nowait flag is set */
>   		if (nowait) {
> @@ -1004,9 +1036,7 @@ static bool wait_barrier(struct r10conf *conf, bool nowait)
>   		} else {
>   			conf->nr_waiting++;
>   			raid10_log(conf->mddev, "wait barrier");
> -			wait_event_lock_irq(conf->wait_barrier,
> -					    stop_waiting_barrier(conf),
> -					    conf->resync_lock);
> +			wait_event_barrier(conf, stop_waiting_barrier(conf));
>   			conf->nr_waiting--;
>   		}
>   		if (!conf->nr_waiting)
> @@ -1015,7 +1045,7 @@ static bool wait_barrier(struct r10conf *conf, bool nowait)
>   	/* Only increment nr_pending when we wait */
>   	if (ret)
>   		atomic_inc(&conf->nr_pending);
> -	spin_unlock_irq(&conf->resync_lock);
> +	write_sequnlock_irq(&conf->resync_lock);
>   	return ret;
>   }
>   
> @@ -1040,27 +1070,24 @@ static void freeze_array(struct r10conf *conf, int extra)
>   	 * must match the number of pending IOs (nr_pending) before
>   	 * we continue.
>   	 */
> -	spin_lock_irq(&conf->resync_lock);
> +	write_seqlock_irq(&conf->resync_lock);
>   	conf->array_freeze_pending++;
> -	conf->barrier++;
> +	WRITE_ONCE(conf->barrier, conf->barrier + 1);
>   	conf->nr_waiting++;
> -	wait_event_lock_irq_cmd(conf->wait_barrier,
> -				atomic_read(&conf->nr_pending) == conf->nr_queued+extra,
> -				conf->resync_lock,
> -				flush_pending_writes(conf));
> -
> +	wait_event_barrier_cmd(conf, atomic_read(&conf->nr_pending) ==
> +			conf->nr_queued + extra, flush_pending_writes(conf));
>   	conf->array_freeze_pending--;
> -	spin_unlock_irq(&conf->resync_lock);
> +	write_sequnlock_irq(&conf->resync_lock);
>   }
>   
>   static void unfreeze_array(struct r10conf *conf)
>   {
>   	/* reverse the effect of the freeze */
> -	spin_lock_irq(&conf->resync_lock);
> -	conf->barrier--;
> +	write_seqlock_irq(&conf->resync_lock);
> +	WRITE_ONCE(conf->barrier, conf->barrier - 1);
>   	conf->nr_waiting--;
>   	wake_up_barrier(conf);
> -	spin_unlock_irq(&conf->resync_lock);
> +	write_sequnlock_irq(&conf->resync_lock);
>   }
>   
>   static sector_t choose_data_offset(struct r10bio *r10_bio,
> @@ -4046,7 +4073,7 @@ static struct r10conf *setup_conf(struct mddev *mddev)
>   	INIT_LIST_HEAD(&conf->retry_list);
>   	INIT_LIST_HEAD(&conf->bio_end_io_list);
>   
> -	spin_lock_init(&conf->resync_lock);
> +	seqlock_init(&conf->resync_lock);
>   	init_waitqueue_head(&conf->wait_barrier);
>   	atomic_set(&conf->nr_pending, 0);
>   
> @@ -4365,7 +4392,7 @@ static void *raid10_takeover_raid0(struct mddev *mddev, sector_t size, int devs)
>   				rdev->new_raid_disk = rdev->raid_disk * 2;
>   				rdev->sectors = size;
>   			}
> -		conf->barrier = 1;
> +		WRITE_ONCE(conf->barrier, 1);
>   	}
>   
>   	return conf;
> diff --git a/drivers/md/raid10.h b/drivers/md/raid10.h
> index 5c0804d8bb1f..8c072ce0bc54 100644
> --- a/drivers/md/raid10.h
> +++ b/drivers/md/raid10.h
> @@ -76,7 +76,7 @@ struct r10conf {
>   	/* queue pending writes and submit them on unplug */
>   	struct bio_list		pending_bio_list;
>   
> -	spinlock_t		resync_lock;
> +	seqlock_t		resync_lock;
>   	atomic_t		nr_pending;
>   	int			nr_waiting;
>   	int			nr_queued;
> 

