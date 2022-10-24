Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54D0E609F81
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 12:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbiJXK6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 06:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiJXK5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 06:57:31 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8AA75FDD5;
        Mon, 24 Oct 2022 03:57:21 -0700 (PDT)
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MwsRF5VVJz6HJR3;
        Mon, 24 Oct 2022 18:55:05 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 12:56:24 +0200
Received: from [10.48.145.243] (10.48.145.243) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 11:56:23 +0100
Message-ID: <99c6ca81-746d-85f4-04d3-49d7a3de611b@huawei.com>
Date:   Mon, 24 Oct 2022 11:56:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
From:   John Garry <john.garry@huawei.com>
Subject: Re: [PATCH] blk-mq: Properly init bios from
 blk_mq_alloc_request_hctx()
To:     Ming Lei <ming.lei@redhat.com>
CC:     <axboe@kernel.dk>, <linux-kernel@vger.kernel.org>,
        <linux-block@vger.kernel.org>, <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
References: <1666454846-11749-1-git-send-email-john.garry@huawei.com>
 <Y1U9zNZtZjRHQBww@T590>
In-Reply-To: <Y1U9zNZtZjRHQBww@T590>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.145.243]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/10/2022 14:12, Ming Lei wrote:
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 8070b6c10e8d..260adeb2e455 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -402,6 +402,10 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
>>   		}
>>   	}
>>   
>> +	rq->__data_len = 0;
>> +	rq->__sector = (sector_t) -1;
>> +	rq->bio = rq->biotail = NULL;
>> +
>>   	return rq;
>>   }
>>   
>> @@ -591,9 +595,6 @@ struct request *blk_mq_alloc_request(struct request_queue *q, blk_opf_t opf,
>>   		if (!rq)
>>   			goto out_queue_exit;
>>   	}
>> -	rq->__data_len = 0;
>> -	rq->__sector = (sector_t) -1;
>> -	rq->bio = rq->biotail = NULL;
> This patch looks not good, why do you switch to initialize the three fields
> twice in fast path?

Can you please show me how these are initialized twice?

If there is a real concern with this then we go with my original idea, 
which was to copy the init method of blk_mq_alloc_request() (in 
blk_mq_alloc_request_hctx())

> 
> BTW, we know blk_mq_alloc_request_hctx() has big trouble, so please
> avoid to extend it to other use cases.

Yeah, I know this, but sometimes we just need to allocate for a specific 
HW queue...

For my usecase of interest, it should not impact if the cpumask of the 
HW queue goes offline after selecting the cpu in 
blk_mq_alloc_request_hctx(), so any race is ok ... I think.

However it should be still possible to make blk_mq_alloc_request_hctx() 
more robust. How about using something like work_on_cpu_safe() to 
allocate and execute the request with blk_mq_alloc_request() on a cpu 
associated with the HW queue, such that we know the cpu is online and 
stays online until we execute it? Or also extent to 
work_on_cpumask_safe() variant, so that we don't need to try all cpus in 
the mask (to see if online)?

Thanks,
John
