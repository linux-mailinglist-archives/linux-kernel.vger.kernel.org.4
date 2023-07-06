Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5D1749EE6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 16:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbjGFOYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 10:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbjGFOYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 10:24:20 -0400
Received: from out-60.mta1.migadu.com (out-60.mta1.migadu.com [IPv6:2001:41d0:203:375::3c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A23D19B2
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 07:24:18 -0700 (PDT)
Message-ID: <f6f52b55-a991-1179-75cb-bf8fce8f6783@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1688653455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8Y/8f2lfLrDkDpzbIdRTJODIMHeTXUm4sDd+CCLcns8=;
        b=kR2LSKOSVZBPkevElfkY3NNfjrZ4OLGqrCyp34k+Af+3dbc9oaLe4IgXU4yNN+n845r0Tz
        T2QOpwr106hAC1hVe1ghZU8n7wprM+DDW49FGftdmkuk/OjokKtttdg7sEthcLnfrAecOn
        Fhoyz+KzyVan+FQsXSWhp+mHBCaY4/Y=
Date:   Thu, 6 Jul 2023 22:23:49 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/4] blk-mq: use percpu csd to remote complete instead
 of per-rq csd
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, ming.lei@redhat.com, tj@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
References: <20230629110359.1111832-1-chengming.zhou@linux.dev>
 <20230629110359.1111832-2-chengming.zhou@linux.dev>
 <20230706130735.GA13089@lst.de>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20230706130735.GA13089@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/6 21:07, Christoph Hellwig wrote:
> On Thu, Jun 29, 2023 at 07:03:56PM +0800, chengming.zhou@linux.dev wrote:
>> From: Chengming Zhou <zhouchengming@bytedance.com>
>>
>> If request need to be completed remotely, we insert it into percpu llist,
>> and smp_call_function_single_async() if llist is empty previously.
>>
>> We don't need to use per-rq csd, percpu csd is enough. And the size of
>> struct request is decreased by 24 bytes.
>>
>> This way is cleaner, and looks correct, given block softirq is guaranteed to be
>> scheduled to consume the list if one new request is added to this percpu list,
>> either smp_call_function_single_async() returns -EBUSY or 0.
> 
> Please trim your commit logs to 73 characters per line so that they
> are readable in git log output.

Ok, will fix in the next version.

> 
>>  static void blk_mq_request_bypass_insert(struct request *rq,
>> @@ -1156,13 +1157,13 @@ static void blk_mq_complete_send_ipi(struct request *rq)
>>  {
>>  	struct llist_head *list;
>>  	unsigned int cpu;
>> +	call_single_data_t *csd;
>>  
>>  	cpu = rq->mq_ctx->cpu;
>>  	list = &per_cpu(blk_cpu_done, cpu);
>> -	if (llist_add(&rq->ipi_list, list)) {
>> -		INIT_CSD(&rq->csd, __blk_mq_complete_request_remote, rq);
>> -		smp_call_function_single_async(cpu, &rq->csd);
>> -	}
>> +	csd = &per_cpu(blk_cpu_csd, cpu);
>> +	if (llist_add(&rq->ipi_list, list))
>> +		smp_call_function_single_async(cpu, csd);
>>  }
> 
> No need for the list and csd variables here as they are only used
> once.

Yes, should I change like below? Looks like much long code. :-)

if (llist_add(&rq->ipi_list, &per_cpu(blk_cpu_done, cpu)))
	smp_call_function_single_async(cpu, &per_cpu(blk_cpu_csd, cpu));

> 
> But I think this code has a rpboem when it is preemptd between
> the llist_add and smp_call_function_single_async.  We either need a
> get_cpu/put_cpu around them, or instroduce a structure with the list
> and csd, and then you can use one pointer from per_cpu and still ensure
> the list and csd are for the same CPU.
> 

cpu = rq->mq_ctx->cpu; So it's certainly the same CPU, right?

Thanks!

