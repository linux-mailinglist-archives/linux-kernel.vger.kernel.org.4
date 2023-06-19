Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFCA734B8D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 08:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjFSGHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 02:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjFSGHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 02:07:17 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B364E76;
        Sun, 18 Jun 2023 23:07:10 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Qkzn41BBmz4f3tDl;
        Mon, 19 Jun 2023 14:07:04 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgD3mp6I8I9kV94oMA--.6599S3;
        Mon, 19 Jun 2023 14:07:06 +0800 (CST)
Subject: Re: [PATCH RFC 2/7] blk-mq: delay tag fair sharing until fail to get
 driver tag
To:     Hannes Reinecke <hare@suse.de>, Yu Kuai <yukuai1@huaweicloud.com>,
        bvanassche@acm.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230618160738.54385-1-yukuai1@huaweicloud.com>
 <20230618160738.54385-3-yukuai1@huaweicloud.com>
 <091d7daa-2782-66a0-57f4-ab62bbb82daf@suse.de>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <debe4f22-67f3-60aa-9b65-7308dfc58f6d@huaweicloud.com>
Date:   Mon, 19 Jun 2023 14:07:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <091d7daa-2782-66a0-57f4-ab62bbb82daf@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3mp6I8I9kV94oMA--.6599S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAr1kXFWktw1fuFykAr1xAFb_yoWrKryDpF
        WkJa13G34rXrn7XrW7X3y7XFyFyr4kt3WDGrnaqFy5Ar1j9r1Sgr18Zryv9r48Jr4kAr4U
        Ar1jqr9rZF1UJrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
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
        Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbU
        UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/06/19 13:55, Hannes Reinecke 写道:
> On 6/18/23 18:07, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Start tag fair sharing when a device start to issue io will waste
>> resources, same number of tags will be assigned to each disk/hctx,
>> and such tags can't be used for other disk/hctx, which means a disk/hctx
>> can't use more than assinged tags even if there are still lots of tags
>> that is assinged to other disks are unused.
>>
>> Add a new api blk_mq_driver_tag_busy(), it will be called when get
>> driver tag failed, and move tag sharing from blk_mq_tag_busy() to
>> blk_mq_driver_tag_busy().
>>
>> This approch will work well if total tags are not exhausted, and follow
>> up patches will try to refactor how tag is shared to handle this case.
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   block/blk-mq-debugfs.c |  4 ++-
>>   block/blk-mq-tag.c     | 60 ++++++++++++++++++++++++++++++++++--------
>>   block/blk-mq.c         |  4 ++-
>>   block/blk-mq.h         | 13 ++++++---
>>   include/linux/blk-mq.h |  6 +++--
>>   include/linux/blkdev.h |  1 +
>>   6 files changed, 70 insertions(+), 18 deletions(-)
>>
>> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
>> index 431aaa3eb181..de5a911b07c2 100644
>> --- a/block/blk-mq-debugfs.c
>> +++ b/block/blk-mq-debugfs.c
>> @@ -400,8 +400,10 @@ static void blk_mq_debugfs_tags_show(struct 
>> seq_file *m,
>>   {
>>       seq_printf(m, "nr_tags=%u\n", tags->nr_tags);
>>       seq_printf(m, "nr_reserved_tags=%u\n", tags->nr_reserved_tags);
>> -    seq_printf(m, "active_queues=%d\n",
>> +    seq_printf(m, "active_queues=%u\n",
>>              READ_ONCE(tags->ctl.active_queues));
>> +    seq_printf(m, "share_queues=%u\n",
>> +           READ_ONCE(tags->ctl.share_queues));
>>       seq_puts(m, "\nbitmap_tags:\n");
>>       sbitmap_queue_show(&tags->bitmap_tags, m);
>> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
>> index fe41a0d34fc0..1c2bde917195 100644
>> --- a/block/blk-mq-tag.c
>> +++ b/block/blk-mq-tag.c
>> @@ -29,6 +29,32 @@ static void blk_mq_update_wake_batch(struct 
>> blk_mq_tags *tags,
>>               users);
>>   }
>> +void __blk_mq_driver_tag_busy(struct blk_mq_hw_ctx *hctx)
>> +{
>> +    struct blk_mq_tags *tags = hctx->tags;
>> +
>> +    /*
>> +     * calling test_bit() prior to test_and_set_bit() is intentional,
>> +     * it avoids dirtying the cacheline if the queue is already active.
>> +     */
>> +    if (blk_mq_is_shared_tags(hctx->flags)) {
>> +        struct request_queue *q = hctx->queue;
>> +
>> +        if (test_bit(QUEUE_FLAG_HCTX_BUSY, &q->queue_flags) ||
>> +            test_and_set_bit(QUEUE_FLAG_HCTX_BUSY, &q->queue_flags))
>> +            return;
>> +    } else {
>> +        if (test_bit(BLK_MQ_S_DTAG_BUSY, &hctx->state) ||
>> +            test_and_set_bit(BLK_MQ_S_DTAG_BUSY, &hctx->state))
>> +            return;
>> +    }
>> +
>> +    spin_lock_irq(&tags->lock);
>> +    WRITE_ONCE(tags->ctl.share_queues, tags->ctl.active_queues);
>> +    blk_mq_update_wake_batch(tags, tags->ctl.share_queues);
>> +    spin_unlock_irq(&tags->lock);
>> +}
>> +
>>   /*
>>    * If a previously inactive queue goes active, bump the active user 
>> count.
>>    * We need to do this before try to allocate driver tag, then even 
>> if fail
>> @@ -37,7 +63,6 @@ static void blk_mq_update_wake_batch(struct 
>> blk_mq_tags *tags,
>>    */
>>   void __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
>>   {
>> -    unsigned int users;
>>       struct blk_mq_tags *tags = hctx->tags;
>>       /*
>> @@ -57,9 +82,7 @@ void __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
>>       }
>>       spin_lock_irq(&tags->lock);
>> -    users = tags->ctl.active_queues + 1;
>> -    WRITE_ONCE(tags->ctl.active_queues, users);
>> -    blk_mq_update_wake_batch(tags, users);
>> +    WRITE_ONCE(tags->ctl.active_queues, tags->ctl.active_queues + 1);
> 
> Why did you remove the call to blk_mq_update_wake_batch() here?

blk_mq_update_wake_batch() should be called when the available tags is
changed, however, active_queues is no longer used for hctx_may_queue()
to calculate available tags, share_queues is used instead and it's
updated in the new helper blk_mq_driver_tag_busy().

Thanks,
Kuai
> 
> Cheers,
> 
> Hannes

