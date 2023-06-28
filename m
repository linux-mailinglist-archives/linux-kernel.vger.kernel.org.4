Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03AF8740AC5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 10:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233853AbjF1IKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 04:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233143AbjF1IFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:05:52 -0400
Received: from out-16.mta0.migadu.com (out-16.mta0.migadu.com [IPv6:2001:41d0:1004:224b::10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9899330C7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 01:04:36 -0700 (PDT)
Message-ID: <6d86df7f-89c7-745c-c5c9-285628ef984f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1687934643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X+4/1a9FExR3xrVfAss/wqROxapr4I8GSXOcb+z9OSk=;
        b=rRTORJCzEUMayCRlKF/guG3MGEgfdmPM+BBC7FlyLNdEMBPrDBpxY+NKzxMcFJQ7mz0aML
        GtruYFZw/OaAkpqSjl2ptucE47903RouzJNlcBd6XyU8Q0aMB7CzW/tt4/HpSH/Oc/ZX4j
        UPvAxoPyysilphSUNFN5oqcDnXPLefc=
Date:   Wed, 28 Jun 2023 14:43:58 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 1/4] blk-mq: use percpu csd to remote complete instead of
 per-rq csd
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     axboe@kernel.dk, tj@kernel.org, hch@lst.de,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
References: <20230627120854.971475-1-chengming.zhou@linux.dev>
 <20230627120854.971475-2-chengming.zhou@linux.dev>
 <ZJuY0OZu42H0oBa7@ovpn-8-21.pek2.redhat.com>
 <9c038fe8-0361-c6fb-9b4e-7b74e0591ae9@linux.dev>
 <ZJu8DQgug3/UjpUJ@ovpn-8-21.pek2.redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <ZJu8DQgug3/UjpUJ@ovpn-8-21.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/6/28 12:50, Ming Lei wrote:
> On Wed, Jun 28, 2023 at 11:28:20AM +0800, Chengming Zhou wrote:
>> On 2023/6/28 10:20, Ming Lei wrote:
>>> On Tue, Jun 27, 2023 at 08:08:51PM +0800, chengming.zhou@linux.dev wrote:
>>>> From: Chengming Zhou <zhouchengming@bytedance.com>
>>>>
>>>> If request need to be completed remotely, we insert it into percpu llist,
>>>> and smp_call_function_single_async() if llist is empty previously.
>>>>
>>>> We don't need to use per-rq csd, percpu csd is enough. And the size of
>>>> struct request is decreased by 24 bytes.
>>>>
>>>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>>>> ---
>>>>  block/blk-mq.c         | 12 ++++++++----
>>>>  include/linux/blk-mq.h |  5 +----
>>>>  2 files changed, 9 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>>> index decb6ab2d508..a36822479b94 100644
>>>> --- a/block/blk-mq.c
>>>> +++ b/block/blk-mq.c
>>>> @@ -43,6 +43,7 @@
>>>>  #include "blk-ioprio.h"
>>>>  
>>>>  static DEFINE_PER_CPU(struct llist_head, blk_cpu_done);
>>>> +static DEFINE_PER_CPU(struct __call_single_data, blk_cpu_csd);
>>>
>>> It might be better to use call_single_data, given:
>>>
>>> /* Use __aligned() to avoid to use 2 cache lines for 1 csd */
>>>   typedef struct __call_single_data call_single_data_t
>>>   	__aligned(sizeof(struct __call_single_data));
>>>
>>
>> Good, I will change to use this.
>>
>>>>  
>>>>  static void blk_mq_insert_request(struct request *rq, blk_insert_t flags);
>>>>  static void blk_mq_request_bypass_insert(struct request *rq,
>>>> @@ -1156,13 +1157,13 @@ static void blk_mq_complete_send_ipi(struct request *rq)
>>>>  {
>>>>  	struct llist_head *list;
>>>>  	unsigned int cpu;
>>>> +	struct __call_single_data *csd;
>>>>  
>>>>  	cpu = rq->mq_ctx->cpu;
>>>>  	list = &per_cpu(blk_cpu_done, cpu);
>>>> -	if (llist_add(&rq->ipi_list, list)) {
>>>> -		INIT_CSD(&rq->csd, __blk_mq_complete_request_remote, rq);
>>>> -		smp_call_function_single_async(cpu, &rq->csd);
>>>> -	}
>>>> +	csd = &per_cpu(blk_cpu_csd, cpu);
>>>> +	if (llist_add(&rq->ipi_list, list))
>>>> +		smp_call_function_single_async(cpu, csd);
>>>>  }
>>>
>>> This way is cleaner, and looks correct, given block softirq is guaranteed to be
>>> scheduled to consume the list if one new request is added to this percpu list,
>>> either smp_call_function_single_async() returns -EBUSY or 0.
>>>
>>
>> If this llist_add() see the llist is empty, the consumer function in the softirq
>> on the remote CPU must have consumed the llist, so smp_call_function_single_async()
>> won't return -EBUSY ?
> 
> block softirq can be scheduled from other code path, such as blk_mq_raise_softirq()
> for single queue's remote completion, where no percpu csd schedule is needed, so
> two smp_call_function_single_async() could be called, and the 2nd one
> may return -EBUSY.

Thanks for your very clear explanation! I understand what you mean.

Yes, the 2nd smp_call_function_single_async() will return -EBUSY, but it's ok since
the 1st will do the right thing.

> 
> Not mention csd_unlock() could be called after the callback returns, see
> __flush_smp_call_function_queue().

Ok, CSD_TYPE_SYNC will csd_unlock() after csd_do_func() returns, our CSD_TYPE_ASYNC
will csd_unlock() before csd_do_func().

> 
> But that is fine, if there is pending block softirq, the llist is
> guaranteed to be consumed because the csd callback just raises block
> softirq, and request/llist is consumed in softirq handler.
> 

Agree, it's fine even the 2nd return -EBUSY when the 1st function is raising block softirq,
our llist will be consumed in softirq handler.

Thanks!

