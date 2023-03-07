Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623666ADC40
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 11:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjCGKpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 05:45:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbjCGKpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 05:45:02 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27BD5F229;
        Tue,  7 Mar 2023 02:44:52 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4PWBsX2YVRz4f3l7B;
        Tue,  7 Mar 2023 18:44:48 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgCnUiChFQdkhMH6EQ--.23182S3;
        Tue, 07 Mar 2023 18:44:50 +0800 (CST)
Subject: Re: [PATCH -next RFC] block: count 'ios' and 'sectors' when io is
 done for bio-based device
To:     Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk, agk@redhat.com,
        snitzer@kernel.org, dm-devel@redhat.com, kbusch@kernel.org,
        hch@lst.de, sagi@grimberg.me, guz.fnst@cn.fujitsu.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230223091226.1135678-1-yukuai1@huaweicloud.com>
 <05bbc421-100c-c18d-4261-e5669cfdfb94@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <a4d8f6b5-cc8e-204e-1039-5f2b98042bdd@huaweicloud.com>
Date:   Tue, 7 Mar 2023 18:44:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <05bbc421-100c-c18d-4261-e5669cfdfb94@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgCnUiChFQdkhMH6EQ--.23182S3
X-Coremail-Antispam: 1UD129KBjvJXoWxKw47KF15GF1xCFWDGr4kZwb_yoW3Jr1kpF
        1kGFy5JrWUWw1vgr1UJw1DGFyrtr1Utw17Ar47JFyUAw48Jr1vqr1UXr1qgr1UArWkJFyU
        A3W8Zr9rZr47JrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
        c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
        AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
        17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
        IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Zr0_Wr1U
        MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
        VFxhVjvjDU0xZFpf9x0JUp6wZUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/02/28 9:01, Yu Kuai 写道:
> Hi,
> 
> friendly ping ...
> 
> Thanks,
> Kuai
> 
> 在 2023/02/23 17:12, Yu Kuai 写道:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> While using iostat for raid, I observed very strange 'await'
>> occasionally, and turns out it's due to that 'ios' and 'sectors' is
>> counted in bdev_start_io_acct(), while 'nsecs' is counted in
>> bdev_end_io_acct(). I'm not sure why they are ccounted like that
>> but I think this behaviour is obviously wrong because user will get
>> wrong disk stats.
>>
>> Fix the problem by counting 'ios' and 'sectors' when io is done, like
>> what rq-based device does.

Can anyone help to review this change? Or is there any reason to count
'ios' and 'sectors' when io is started?

Thanks,
Kuai
>>
>> Fixes: 394ffa503bc4 ("blk: introduce generic io stat accounting help 
>> function")
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   block/blk-core.c              | 16 ++++++----------
>>   drivers/md/dm.c               |  6 +++---
>>   drivers/nvme/host/multipath.c |  8 ++++----
>>   include/linux/blkdev.h        |  5 ++---
>>   4 files changed, 15 insertions(+), 20 deletions(-)
>>
>> diff --git a/block/blk-core.c b/block/blk-core.c
>> index 82b5b2c53f1e..fe1d320f5f07 100644
>> --- a/block/blk-core.c
>> +++ b/block/blk-core.c
>> @@ -953,16 +953,11 @@ void update_io_ticks(struct block_device *part, 
>> unsigned long now, bool end)
>>       }
>>   }
>> -unsigned long bdev_start_io_acct(struct block_device *bdev,
>> -                 unsigned int sectors, enum req_op op,
>> +unsigned long bdev_start_io_acct(struct block_device *bdev, enum 
>> req_op op,
>>                    unsigned long start_time)
>>   {
>> -    const int sgrp = op_stat_group(op);
>> -
>>       part_stat_lock();
>>       update_io_ticks(bdev, start_time, false);
>> -    part_stat_inc(bdev, ios[sgrp]);
>> -    part_stat_add(bdev, sectors[sgrp], sectors);
>>       part_stat_local_inc(bdev, in_flight[op_is_write(op)]);
>>       part_stat_unlock();
>> @@ -978,13 +973,12 @@ EXPORT_SYMBOL(bdev_start_io_acct);
>>    */
>>   unsigned long bio_start_io_acct(struct bio *bio)
>>   {
>> -    return bdev_start_io_acct(bio->bi_bdev, bio_sectors(bio),
>> -                  bio_op(bio), jiffies);
>> +    return bdev_start_io_acct(bio->bi_bdev, bio_op(bio), jiffies);
>>   }
>>   EXPORT_SYMBOL_GPL(bio_start_io_acct);
>>   void bdev_end_io_acct(struct block_device *bdev, enum req_op op,
>> -              unsigned long start_time)
>> +              unsigned int sectors, unsigned long start_time)
>>   {
>>       const int sgrp = op_stat_group(op);
>>       unsigned long now = READ_ONCE(jiffies);
>> @@ -992,6 +986,8 @@ void bdev_end_io_acct(struct block_device *bdev, 
>> enum req_op op,
>>       part_stat_lock();
>>       update_io_ticks(bdev, now, true);
>> +    part_stat_inc(bdev, ios[sgrp]);
>> +    part_stat_add(bdev, sectors[sgrp], sectors);
>>       part_stat_add(bdev, nsecs[sgrp], jiffies_to_nsecs(duration));
>>       part_stat_local_dec(bdev, in_flight[op_is_write(op)]);
>>       part_stat_unlock();
>> @@ -1001,7 +997,7 @@ EXPORT_SYMBOL(bdev_end_io_acct);
>>   void bio_end_io_acct_remapped(struct bio *bio, unsigned long 
>> start_time,
>>                     struct block_device *orig_bdev)
>>   {
>> -    bdev_end_io_acct(orig_bdev, bio_op(bio), start_time);
>> +    bdev_end_io_acct(orig_bdev, bio_op(bio), bio_sectors(bio), 
>> start_time);
>>   }
>>   EXPORT_SYMBOL_GPL(bio_end_io_acct_remapped);
>> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
>> index eace45a18d45..f5cc330bb549 100644
>> --- a/drivers/md/dm.c
>> +++ b/drivers/md/dm.c
>> @@ -512,10 +512,10 @@ static void dm_io_acct(struct dm_io *io, bool end)
>>           sectors = io->sectors;
>>       if (!end)
>> -        bdev_start_io_acct(bio->bi_bdev, sectors, bio_op(bio),
>> -                   start_time);
>> +        bdev_start_io_acct(bio->bi_bdev, bio_op(bio), start_time);
>>       else
>> -        bdev_end_io_acct(bio->bi_bdev, bio_op(bio), start_time);
>> +        bdev_end_io_acct(bio->bi_bdev, bio_op(bio), sectors,
>> +                 start_time);
>>       if (static_branch_unlikely(&stats_enabled) &&
>>           unlikely(dm_stats_used(&md->stats))) {
>> diff --git a/drivers/nvme/host/multipath.c 
>> b/drivers/nvme/host/multipath.c
>> index fc39d01e7b63..9171452e2f6d 100644
>> --- a/drivers/nvme/host/multipath.c
>> +++ b/drivers/nvme/host/multipath.c
>> @@ -123,9 +123,8 @@ void nvme_mpath_start_request(struct request *rq)
>>           return;
>>       nvme_req(rq)->flags |= NVME_MPATH_IO_STATS;
>> -    nvme_req(rq)->start_time = bdev_start_io_acct(disk->part0,
>> -                    blk_rq_bytes(rq) >> SECTOR_SHIFT,
>> -                    req_op(rq), jiffies);
>> +    nvme_req(rq)->start_time = bdev_start_io_acct(disk->part0, 
>> req_op(rq),
>> +                              jiffies);
>>   }
>>   EXPORT_SYMBOL_GPL(nvme_mpath_start_request);
>> @@ -136,7 +135,8 @@ void nvme_mpath_end_request(struct request *rq)
>>       if (!(nvme_req(rq)->flags & NVME_MPATH_IO_STATS))
>>           return;
>>       bdev_end_io_acct(ns->head->disk->part0, req_op(rq),
>> -        nvme_req(rq)->start_time);
>> +             blk_rq_bytes(rq) >> SECTOR_SHIFT,
>> +             nvme_req(rq)->start_time);
>>   }
>>   void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl)
>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>> index d1aee08f8c18..941304f17492 100644
>> --- a/include/linux/blkdev.h
>> +++ b/include/linux/blkdev.h
>> @@ -1446,11 +1446,10 @@ static inline void blk_wake_io_task(struct 
>> task_struct *waiter)
>>           wake_up_process(waiter);
>>   }
>> -unsigned long bdev_start_io_acct(struct block_device *bdev,
>> -                 unsigned int sectors, enum req_op op,
>> +unsigned long bdev_start_io_acct(struct block_device *bdev, enum 
>> req_op op,
>>                    unsigned long start_time);
>>   void bdev_end_io_acct(struct block_device *bdev, enum req_op op,
>> -        unsigned long start_time);
>> +              unsigned int sectors, unsigned long start_time);
>>   unsigned long bio_start_io_acct(struct bio *bio);
>>   void bio_end_io_acct_remapped(struct bio *bio, unsigned long 
>> start_time,
>>
> 
> .
> 

