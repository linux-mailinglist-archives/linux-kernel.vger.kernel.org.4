Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 835655BB8F4
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 17:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiIQPGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 11:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiIQPGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 11:06:48 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFD5303C7;
        Sat, 17 Sep 2022 08:06:45 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=liusong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VQ.Efl4_1663427202;
Received: from 30.39.244.121(mailfrom:liusong@linux.alibaba.com fp:SMTPD_---0VQ.Efl4_1663427202)
          by smtp.aliyun-inc.com;
          Sat, 17 Sep 2022 23:06:43 +0800
Message-ID: <b8f5ac5d-deaa-848d-8cd5-58f374b6b4df@linux.alibaba.com>
Date:   Sat, 17 Sep 2022 23:06:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [PATCH] sbitmap: fix permanent io blocking caused by insufficient
 wakeup times
To:     Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        "yukuai (C)" <yukuai3@huawei.com>
References: <1663381981-6413-1-git-send-email-liusong@linux.alibaba.com>
 <ab451e4c-e1ca-d7a3-6e02-c7d12a473124@huaweicloud.com>
From:   Liu Song <liusong@linux.alibaba.com>
In-Reply-To: <ab451e4c-e1ca-d7a3-6e02-c7d12a473124@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-13.4 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/9/17 18:20, Yu Kuai 写道:
> Hi,
>
> 在 2022/09/17 10:33, Liu Song 写道:
>> From: Liu Song <liusong@linux.alibaba.com>
>>
>> In "sbitmap_queue_clear_batch", a batch of completed requests may be
>> processed at once, but "wait_cnt" is only reduced once by
>> "sbitmap_queue_wake_up".
>> In our environment, if "/sys/block/nvme0n1/nr_requests" is adjusted to
>> 32, it is easily because no tag and then enter the waiting situation,
>> if continue change "nr_requests" to 1023 at this time, it will basically
>> fall into the situation of permanent blocking. Because there will be
>> "blk_freeze_queue" in "blk_mq_update_nr_requests", which will prevent
>> any new requests, but due to insufficient wake-up, there are tasks
>> waiting for wake-up, but no new wake-up opportunities will be generated
>> at this time, so this situation needs to be repaired.
>>
>
> It seems Keith already fixed this recently. Can you have a check at his
> patch?
>
Hi

It's a bit embarrassing. My code is 6.0-rc3. Yesterday, there was a 
problem with
the Tsinghua mirror station. The fetched code could not be the latest, 
so I submitted it.
According to your suggestion, I checked and it has been fixed, thank you 
for your suggestion.

Thanks

> Thanks,
> Kuai
>> Signed-off-by: Liu Song <liusong@linux.alibaba.com>
>> ---
>>   include/linux/sbitmap.h |  8 ++++++++
>>   lib/sbitmap.c           | 22 ++++++++++++++++++----
>>   2 files changed, 26 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
>> index 8f5a86e..153382e 100644
>> --- a/include/linux/sbitmap.h
>> +++ b/include/linux/sbitmap.h
>> @@ -579,6 +579,14 @@ static inline struct sbq_wait_state 
>> *sbq_wait_ptr(struct sbitmap_queue *sbq,
>>   void sbitmap_queue_wake_up(struct sbitmap_queue *sbq);
>>     /**
>> + * sbitmap_queue_wake_up_batch() - Attempt to wake up waiters in 
>> batches
>> + * on a &struct sbitmap_queue.
>> + * @sbq: Bitmap queue to wake up.
>> + * @nr: The number of attempts to wake the waiter.
>> + */
>> +void sbitmap_queue_wake_up_batch(struct sbitmap_queue *sbq, int nr);
>> +
>> +/**
>>    * sbitmap_queue_show() - Dump &struct sbitmap_queue information to 
>> a &struct
>>    * seq_file.
>>    * @sbq: Bitmap queue to show.
>> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
>> index 29eb048..f2aa1da 100644
>> --- a/lib/sbitmap.c
>> +++ b/lib/sbitmap.c
>> @@ -600,7 +600,7 @@ static struct sbq_wait_state *sbq_wake_ptr(struct 
>> sbitmap_queue *sbq)
>>       return NULL;
>>   }
>>   -static bool __sbq_wake_up(struct sbitmap_queue *sbq)
>> +static bool __sbq_wake_up(struct sbitmap_queue *sbq, int *nr)
>>   {
>>       struct sbq_wait_state *ws;
>>       unsigned int wake_batch;
>> @@ -610,6 +610,7 @@ static bool __sbq_wake_up(struct sbitmap_queue *sbq)
>>       if (!ws)
>>           return false;
>>   +again:
>>       wait_cnt = atomic_dec_return(&ws->wait_cnt);
>>       if (wait_cnt <= 0) {
>>           int ret;
>> @@ -632,10 +633,14 @@ static bool __sbq_wake_up(struct sbitmap_queue 
>> *sbq)
>>           if (ret == wait_cnt) {
>>               sbq_index_atomic_inc(&sbq->wake_index);
>>               wake_up_nr(&ws->wait, wake_batch);
>> -            return false;
>> +            if (!nr || *nr <= 0)
>> +                return false;
>>           }
>>             return true;
>> +    } else if (nr && *nr) {
>> +        (*nr)--;
>> +        goto again;
>>       }
>>         return false;
>> @@ -643,11 +648,20 @@ static bool __sbq_wake_up(struct sbitmap_queue 
>> *sbq)
>>     void sbitmap_queue_wake_up(struct sbitmap_queue *sbq)
>>   {
>> -    while (__sbq_wake_up(sbq))
>> +    while (__sbq_wake_up(sbq, NULL))
>>           ;
>>   }
>>   EXPORT_SYMBOL_GPL(sbitmap_queue_wake_up);
>>   +void sbitmap_queue_wake_up_batch(struct sbitmap_queue *sbq, int nr)
>> +{
>> +    int i = SBQ_WAIT_QUEUES;
>> +
>> +    while (__sbq_wake_up(sbq, &nr) && --i)
>> +        ;
>> +}
>> +EXPORT_SYMBOL_GPL(sbitmap_queue_wake_up_batch);
>> +
>>   static inline void sbitmap_update_cpu_hint(struct sbitmap *sb, int 
>> cpu, int tag)
>>   {
>>       if (likely(!sb->round_robin && tag < sb->depth))
>> @@ -683,7 +697,7 @@ void sbitmap_queue_clear_batch(struct 
>> sbitmap_queue *sbq, int offset,
>>           atomic_long_andnot(mask, (atomic_long_t *) addr);
>>         smp_mb__after_atomic();
>> -    sbitmap_queue_wake_up(sbq);
>> +    sbitmap_queue_wake_up_batch(sbq, nr_tags);
>>       sbitmap_update_cpu_hint(&sbq->sb, raw_smp_processor_id(),
>>                       tags[nr_tags - 1] - offset);
>>   }
>>
