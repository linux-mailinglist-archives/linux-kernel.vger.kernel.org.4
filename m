Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139096560F7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 08:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbiLZHwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 02:52:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbiLZHwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 02:52:15 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1067B1FD;
        Sun, 25 Dec 2022 23:51:23 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4NgVN56L4qz4f3mS7;
        Mon, 26 Dec 2022 15:51:17 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP1 (Coremail) with SMTP id cCh0CgCHpzF3UqljJA0HAg--.46167S3;
        Mon, 26 Dec 2022 15:51:20 +0800 (CST)
Subject: Re: [PATCH RESEND v2 5/5] sbitmap: correct wake_batch recalculation
 to avoid potential IO hung
To:     Jan Kara <jack@suse.cz>, Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kbusch@kernel.org,
        Laibin Qiu <qiulaibin@huawei.com>,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20221222143353.598042-1-shikemeng@huaweicloud.com>
 <20221222143353.598042-6-shikemeng@huaweicloud.com>
 <20221222134146.khucy5afnxwl75px@quack3>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <d00297d7-a77a-770a-1cd7-1632f8ae77e0@huaweicloud.com>
Date:   Mon, 26 Dec 2022 15:50:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20221222134146.khucy5afnxwl75px@quack3>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgCHpzF3UqljJA0HAg--.46167S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWF4xGF13KFW8CFW3ZF1UJrb_yoW5uF47p3
        yrKFsrKw4vyrWIkrZrJw4UZF129a1DKrnxGF1SvrWrAw15Gr9I9r4FgFZ5uwn2vFs7GF45
        A343GrZ3CayjyrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UQzVbUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

ÔÚ 2022/12/22 21:41, Jan Kara Ð´µÀ:
> On Thu 22-12-22 22:33:53, Kemeng Shi wrote:
>> Commit 180dccb0dba4f ("blk-mq: fix tag_get wait task can't be awakened")
>> mentioned that in case of shared tags, there could be just one real
>> active hctx(queue) because of lazy detection of tag idle. Then driver tag
>> allocation may wait forever on this real active hctx(queue) if wake_batch
>> is > hctx_max_depth where hctx_max_depth is available tags depth for the
>> actve hctx(queue). However, the condition wake_batch > hctx_max_depth is
>> not strong enough to avoid IO hung as the sbitmap_queue_wake_up will only
>> wake up one wait queue for each wake_batch even though there is only one
>> waiter in the woken wait queue. After this, there is only one tag to free
>> and wake_batch may not be reached anymore. Commit 180dccb0dba4f ("blk-mq:
>> fix tag_get wait task can't be awakened") methioned that driver tag
>> allocation may wait forever. Actually, the inactive hctx(queue) will be
>> truely idle after at most 30 seconds and will call blk_mq_tag_wakeup_all
>> to wake one waiter per wait queue to break the hung. But IO hung for 30
>> seconds is also not acceptable. Set batch size to small enough that depth
>> of the shared hctx(queue) is enough to wake up all of the queues like
>> sbq_calc_wake_batch do to fix this potential IO hung.
>>
>> Although hctx_max_depth will be clamped to at least 4 while wake_batch
>> recalculation does not do the clamp, the wake_batch will be always
>> recalculated to 1 when hctx_max_depth <= 4.
>>
>> Fixes: 180dccb0dba4 ("blk-mq: fix tag_get wait task can't be awakened")
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> 
> So the condition in sbitmap_queue_recalculate_wake_batch() also seemed
> strange to me and the changelogs of commits 180dccb0dba4 and 10825410b95
> ("blk-mq: Fix wrong wakeup batch configuration which will cause hang")
> didn't add much confidence about the magic batch setting to 4. Let me add
> to CC original author of this code if he has any thoughts on why using
> wake batch of 4 is safe for cards with say 32 tags in case active_users is
> currently 32. Because I don't see why that is correct either.
> 

If I remember this correctly, the reason to use 4 here in the first
place is to avoid performance degradation. And for why this is safe
because 4 * 8 = 32. Someone is waiting for tag means 32 tags is all
grabbed, and wake batch of 4 will make sure at least 8 wait queues will
be awaken. It's right some waitqueue might only have one waiter, but I
don't think this will cause io hang.

Thanks,
Kuai
> 								Honza
> 
>> ---
>>   lib/sbitmap.c | 5 +----
>>   1 file changed, 1 insertion(+), 4 deletions(-)
>>
>> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
>> index b6d3bb1c3675..804fe99783e4 100644
>> --- a/lib/sbitmap.c
>> +++ b/lib/sbitmap.c
>> @@ -458,13 +458,10 @@ void sbitmap_queue_recalculate_wake_batch(struct sbitmap_queue *sbq,
>>   					    unsigned int users)
>>   {
>>   	unsigned int wake_batch;
>> -	unsigned int min_batch;
>>   	unsigned int depth = (sbq->sb.depth + users - 1) / users;
>>   
>> -	min_batch = sbq->sb.depth >= (4 * SBQ_WAIT_QUEUES) ? 4 : 1;
>> -
>>   	wake_batch = clamp_val(depth / SBQ_WAIT_QUEUES,
>> -			min_batch, SBQ_WAKE_BATCH);
>> +			1, SBQ_WAKE_BATCH);
>>   
>>   	WRITE_ONCE(sbq->wake_batch, wake_batch);
>>   }
>> -- 
>> 2.30.0
>>

