Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32FC5624070
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 11:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbiKJKyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 05:54:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiKJKyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 05:54:37 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DBC0663E8;
        Thu, 10 Nov 2022 02:54:36 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so4357831pjs.4;
        Thu, 10 Nov 2022 02:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wSlAzuVnCNGSUlXQbzZGzIWM/iy3zKLuKxIrZxarYYk=;
        b=avnF6/j7/eEtMnUiXI98jhufKz9qLU7W9lvwe0XqKZgJGkOBudUedMEg+OAMMlzuVt
         Uro3uCD/3iUuFqzmSy3e8q9L2UgrSWEihshC+uvyMBb/hIM5WIsf+FQvwm0dn/GuOKIf
         YkzjkyM5fhP0GwQmcnB0Xj1ew93bB6kYGCDNXZpxbQ0MAF1uet6l0EX+0ND6hEJVa4V2
         /FsvYJ/WHpY8NOHx4fRRJCDRcuhW13rQJJhyB+FvTTZSn5xkEKGcPfqZSwhV+hBIKPLh
         wkQueoCq087hTeEuswm+551VwWWKT7tnbnGJPVd3pakNo5hTpvYIGv6Tkc05qTTt4QCM
         9sBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wSlAzuVnCNGSUlXQbzZGzIWM/iy3zKLuKxIrZxarYYk=;
        b=7USV3UHUzTnA6dM9EBi7OD555dJ36FStGxC0WRV08LATfcdKtWTHeSSazJtsNPf3TX
         XdHamcULVOLIHsxHih8eWfI+LlvPns1XvOJJw2t9ZtNCBlorDKremSwyruUrnUyf/cf/
         tQOBZOVE84bs3GysV6K+joRc7zQCm/PW5YiuCXu3Q5bpdilT+IFL+Vqy62MNm7OxWZat
         DFSqHju1t/G3mpnQkIgXPiTHfR/tAYtNYYttU2D9ipGDtRtkYCzZD67S//kCDiTh2Kq8
         SnUCxFhKhWL2C8V88P0bEtvHXWp5ymjKx12Fx9lkIUiVtRk6gUIQzPuN6vClvMHb45E9
         PpnA==
X-Gm-Message-State: ACrzQf0AbIxXxySotWwte4XiwWqFN1p8iFsDLFqWFEvEm2PUa29FODQw
        csSCGYXqqv5aXQ5FL/BS9/A=
X-Google-Smtp-Source: AMsMyM7NW8xr9yRJcNLF/VvLlayFPt5C2CTqFmYGreAZiPi+07GLrTnbj7sQkmrWFEjQi01RzssmTg==
X-Received: by 2002:a17:902:ebce:b0:186:9905:11bf with SMTP id p14-20020a170902ebce00b00186990511bfmr65533540plg.110.1668077675784;
        Thu, 10 Nov 2022 02:54:35 -0800 (PST)
Received: from [10.114.96.67] ([129.227.152.6])
        by smtp.gmail.com with ESMTPSA id iw17-20020a170903045100b00186ae20e8dcsm10798520plb.271.2022.11.10.02.54.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 02:54:35 -0800 (PST)
Message-ID: <39aef23b-877d-e49c-78ad-4b028aefc8cf@gmail.com>
Date:   Thu, 10 Nov 2022 18:54:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] block, bfq: do the all counting of pending-request if
 CONFIG_BFQ_GROUP_IOSCHED is enabled
To:     Yu Kuai <yukuai1@huaweicloud.com>, paolo.valente@linaro.org,
        axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuwei.Guan@zeekrlife.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20221109132914.438777-1-Yuwei.Guan@zeekrlife.com>
 <52ccc3f0-a628-a9bf-f604-3b86dd34b006@huaweicloud.com>
From:   Yuwei Guan <ssawgyw@gmail.com>
In-Reply-To: <52ccc3f0-a628-a9bf-f604-3b86dd34b006@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/11/10 17:28, Yu Kuai wrote:
> Hi,
>
> 在 2022/11/09 21:29, Yuwei Guan 写道:
>> The 'bfqd->num_groups_with_pending_reqs' is used when
>> CONFIG_BFQ_GROUP_IOSCHED is enabled, so let the variables and processes
>> take effect when ONFIG_BFQ_GROUP_IOSCHED is enabled.
>>
>> Cc: Yu Kuai <yukuai3@huawei.com>
>> Signed-off-by: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
>> ---
>>   block/bfq-iosched.c |  5 ++++-
>>   block/bfq-iosched.h |  6 ++++++
>>   block/bfq-wf2q.c    | 10 ++++++----
>>   3 files changed, 16 insertions(+), 5 deletions(-)
>>
>> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
>> index 2381cf220ba2..5a648433fd89 100644
>> --- a/block/bfq-iosched.c
>> +++ b/block/bfq-iosched.c
>> @@ -6192,8 +6192,9 @@ static void bfq_completed_request(struct 
>> bfq_queue *bfqq, struct bfq_data *bfqd)
>>            * mechanism).
>>            */
>>           bfqq->budget_timeout = jiffies;
>> -
>> +#ifdef CONFIG_BFQ_GROUP_IOSCHED
>>           bfq_del_bfqq_in_groups_with_pending_reqs(bfqq);
>> +#endif
>>           bfq_weights_tree_remove(bfqq);
>>       }
>
> Thanks for the patch, this make sense. However, I prefer to
> declare a empty function if the config is disabled instead of adding
> "#ifdef" everywhere the function is called.

Thanks a lot for reviewing. Get it, I will send v1 soon.

>
> Thanks,
> Kuai
>>   @@ -7051,7 +7052,9 @@ static int bfq_init_queue(struct 
>> request_queue *q, struct elevator_type *e)
>>       bfqd->idle_slice_timer.function = bfq_idle_slice_timer;
>>         bfqd->queue_weights_tree = RB_ROOT_CACHED;
>> +#ifdef CONFIG_BFQ_GROUP_IOSCHED
>>       bfqd->num_groups_with_pending_reqs = 0;
>> +#endif
>>         INIT_LIST_HEAD(&bfqd->active_list);
>>       INIT_LIST_HEAD(&bfqd->idle_list);
>> diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
>> index 9fa89577322d..d6b9fad28a3b 100644
>> --- a/block/bfq-iosched.h
>> +++ b/block/bfq-iosched.h
>> @@ -197,8 +197,10 @@ struct bfq_entity {
>>       /* flag, set to request a weight, ioprio or ioprio_class 
>> change  */
>>       int prio_changed;
>>   +#ifdef CONFIG_BFQ_GROUP_IOSCHED
>>       /* flag, set if the entity is counted in 
>> groups_with_pending_reqs */
>>       bool in_groups_with_pending_reqs;
>> +#endif
>>         /* last child queue of entity created (for non-leaf entities) */
>>       struct bfq_queue *last_bfqq_created;
>> @@ -491,6 +493,7 @@ struct bfq_data {
>>        */
>>       struct rb_root_cached queue_weights_tree;
>>   +#ifdef CONFIG_BFQ_GROUP_IOSCHED
>>       /*
>>        * Number of groups with at least one process that
>>        * has at least one request waiting for completion. Note that
>> @@ -538,6 +541,7 @@ struct bfq_data {
>>        * with no request waiting for completion.
>>        */
>>       unsigned int num_groups_with_pending_reqs;
>> +#endif
>>         /*
>>        * Per-class (RT, BE, IDLE) number of bfq_queues containing
>> @@ -1074,8 +1078,10 @@ void bfq_requeue_bfqq(struct bfq_data *bfqd, 
>> struct bfq_queue *bfqq,
>>                 bool expiration);
>>   void bfq_del_bfqq_busy(struct bfq_queue *bfqq, bool expiration);
>>   void bfq_add_bfqq_busy(struct bfq_queue *bfqq);
>> +#ifdef CONFIG_BFQ_GROUP_IOSCHED
>>   void bfq_add_bfqq_in_groups_with_pending_reqs(struct bfq_queue *bfqq);
>>   void bfq_del_bfqq_in_groups_with_pending_reqs(struct bfq_queue *bfqq);
>> +#endif
>>     /* --------------- end of interface of B-WF2Q+ ---------------- */
>>   diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
>> index b02b53658ed4..a29187ecdc39 100644
>> --- a/block/bfq-wf2q.c
>> +++ b/block/bfq-wf2q.c
>> @@ -1610,16 +1610,15 @@ void bfq_requeue_bfqq(struct bfq_data *bfqd, 
>> struct bfq_queue *bfqq,
>>                       bfqq == bfqd->in_service_queue, expiration);
>>   }
>>   +#ifdef CONFIG_BFQ_GROUP_IOSCHED
>>   void bfq_add_bfqq_in_groups_with_pending_reqs(struct bfq_queue *bfqq)
>>   {
>>       struct bfq_entity *entity = &bfqq->entity;
>>         if (!entity->in_groups_with_pending_reqs) {
>>           entity->in_groups_with_pending_reqs = true;
>> -#ifdef CONFIG_BFQ_GROUP_IOSCHED
>>           if (!(bfqq_group(bfqq)->num_queues_with_pending_reqs++))
>>               bfqq->bfqd->num_groups_with_pending_reqs++;
>> -#endif
>>       }
>>   }
>>   @@ -1629,12 +1628,11 @@ void 
>> bfq_del_bfqq_in_groups_with_pending_reqs(struct bfq_queue *bfqq)
>>         if (entity->in_groups_with_pending_reqs) {
>>           entity->in_groups_with_pending_reqs = false;
>> -#ifdef CONFIG_BFQ_GROUP_IOSCHED
>>           if (!(--bfqq_group(bfqq)->num_queues_with_pending_reqs))
>>               bfqq->bfqd->num_groups_with_pending_reqs--;
>> -#endif
>>       }
>>   }
>> +#endif
>>     /*
>>    * Called when the bfqq no longer has requests pending, remove it from
>> @@ -1659,7 +1657,9 @@ void bfq_del_bfqq_busy(struct bfq_queue *bfqq, 
>> bool expiration)
>>       bfq_deactivate_bfqq(bfqd, bfqq, true, expiration);
>>         if (!bfqq->dispatched) {
>> +#ifdef CONFIG_BFQ_GROUP_IOSCHED
>>           bfq_del_bfqq_in_groups_with_pending_reqs(bfqq);
>> +#endif
>>           /*
>>            * Next function is invoked last, because it causes bfqq to be
>>            * freed. DO NOT use bfqq after the next function invocation.
>> @@ -1683,7 +1683,9 @@ void bfq_add_bfqq_busy(struct bfq_queue *bfqq)
>>       bfqd->busy_queues[bfqq->ioprio_class - 1]++;
>>         if (!bfqq->dispatched) {
>> +#ifdef CONFIG_BFQ_GROUP_IOSCHED
>>           bfq_add_bfqq_in_groups_with_pending_reqs(bfqq);
>> +#endif
>>           if (bfqq->wr_coeff == 1)
>>               bfq_weights_tree_add(bfqq);
>>       }
>>
>
