Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF035FB36A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 15:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbiJKN1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 09:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiJKN1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 09:27:43 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF8045985;
        Tue, 11 Oct 2022 06:27:39 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MmxP100D5zl4Vh;
        Tue, 11 Oct 2022 21:25:40 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgAHB8lHb0VjtM1tAA--.44334S3;
        Tue, 11 Oct 2022 21:27:36 +0800 (CST)
Subject: Re: [PATCH] blk-mq: fix null pointer dereference in
 blk_mq_clear_rq_mapping()
To:     John Garry <john.garry@huawei.com>,
        Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk,
        ming.lei@redhat.com, hare@suse.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20221011121051.3149442-1-yukuai1@huaweicloud.com>
 <cf3116cb-b238-56c0-c5bf-fd8fa5167f77@huawei.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <46662b49-708f-6013-0e91-f59c4105c5eb@huaweicloud.com>
Date:   Tue, 11 Oct 2022 21:27:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <cf3116cb-b238-56c0-c5bf-fd8fa5167f77@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHB8lHb0VjtM1tAA--.44334S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAry7KF4rXw45JryDJw4DCFg_yoW7JFyDpF
        48Ja1UGrWUJr1kCF4Utw1UJryUtr1UXw1DJr1rXa45Xr1UCr1jgr1UXr1jgr1UJr48Ar4U
        Jr15Jr18Zr17Jr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvj14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r4j
        6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUoO
        J5UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2022/10/11 21:24, John Garry 写道:
> On 11/10/2022 13:10, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Our syzkaller report a null pointer dereference, root cause is
>> following:
>>
>> __blk_mq_alloc_map_and_rqs
>>   set->tags[hctx_idx] = blk_mq_alloc_map_and_rqs
>>    blk_mq_alloc_map_and_rqs
>>     blk_mq_alloc_rqso
> 
> blk_mq_alloc_rqs
> 
>>      // failed due to oom
>>      alloc_pages_node
>>      // set->stags[hctx_idx] is still NULL
> 
> set->tags
> 
>>      blk_mq_free_rqs
>>       drv_tags = set->tags[hctx_idx];
>>       // null pointer dereference is triggered
>>       blk_mq_clear_rq_mapping(drv_tags, ...)
>>
>> This is because commit 63064be150e4 ("blk-mq:
>> Add blk_mq_alloc_map_and_rqs()") merged the two steps:
>>
>> 1) set->tags[hctx_idx] = blk_mq_alloc_rq_map()
>> 2) blk_mq_alloc_rqs(..., set->tags[hctx_idx])
>>
>> into one step:
>>
>> set->tags[hctx_idx] = blk_mq_alloc_map_and_rqs()
>>
>> Since tags is not initialized yet in this case, fix the problem by
>> checking if tags is NULL pointer in blk_mq_clear_rq_mapping().
>>
>> Fixes: 63064be150e4 ("blk-mq: Add blk_mq_alloc_map_and_rqs()")
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> 
> We could have something like the following to ensure the drv tags are 
> assigned before we try to allocate the rqs (and fail), but prob not 
> worth the churn since it's not nice to pass &set->tags[hctx_idx]:
> 
> --->8---
> 
> -struct blk_mq_tags *blk_mq_alloc_map_and_rqs(struct blk_mq_tag_set *set,
> +bool blk_mq_alloc_map_and_rqs(struct blk_mq_tag_set *set,
>                                               unsigned int hctx_idx,
> -                                            unsigned int depth)
> +                                            unsigned int depth,
> +                                            struct blk_mq_tags **tags)
>   {
> -       struct blk_mq_tags *tags;
>          int ret;
> 
> -       tags = blk_mq_alloc_rq_map(set, hctx_idx, depth, 
> set->reserved_tags);
> -       if (!tags)
> -               return NULL;
> +       *tags = blk_mq_alloc_rq_map(set, hctx_idx, depth, 
> set->reserved_tags);
> +       if (!*tags)
> +               return false;
> 
> -       ret = blk_mq_alloc_rqs(set, tags, hctx_idx, depth);
> +       ret = blk_mq_alloc_rqs(set, *tags, hctx_idx, depth);
>          if (ret) {
>                  blk_mq_free_rq_map(tags);
> +        *tags = NULL;
> -               return NULL;
> +               return false;
>          }
> 
> -       return tags;
> +       return true;
>   }
> 
>   static bool __blk_mq_alloc_map_and_rqs(struct blk_mq_tag_set *set,
> @@ -3632,10 +3632,9 @@ static bool __blk_mq_alloc_map_and_rqs(struct 
> blk_mq_tag_set *set,
>                  return true;
>          }
> 
> -       set->tags[hctx_idx] = blk_mq_alloc_map_and_rqs(set, hctx_idx,
> -                                                      set->queue_depth);
> -
> -       return set->tags[hctx_idx];
> +       return blk_mq_alloc_map_and_rqs(set, hctx_idx,
> +                                      set->queue_depth,
> +                                      &set->tags[hctx_idx]);
>   }
> 
> ---8<----
> 
> 
> So,
> 
> Reviewed-by: John Garry <john.garry@huawei.com>

Thanks for the review, I'll send a new verion with the spelling mistakes
fixed.

Kuai
> 
>> ---
>>   block/blk-mq.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 8070b6c10e8d..33292c01875d 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -3112,8 +3112,11 @@ static void blk_mq_clear_rq_mapping(struct 
>> blk_mq_tags *drv_tags,
>>       struct page *page;
>>       unsigned long flags;
>> -    /* There is no need to clear a driver tags own mapping */
>> -    if (drv_tags == tags)
>> +    /*
>> +     * There is no need to clear mapping if driver tags is not 
>> initialized
>> +     * or the mapping belongs to the driver tags.
>> +     */
>> +    if (!drv_tags || drv_tags == tags)
>>           return;
>>       list_for_each_entry(page, &tags->page_list, lru) {
> 
> .
> 

