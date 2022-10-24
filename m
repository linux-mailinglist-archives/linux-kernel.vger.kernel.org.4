Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C1760BE7A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 01:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbiJXXXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 19:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbiJXXXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 19:23:05 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED0C1A0C21;
        Mon, 24 Oct 2022 14:44:04 -0700 (PDT)
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Mx1N208yvz67btf;
        Tue, 25 Oct 2022 00:52:50 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 18:56:18 +0200
Received: from [10.48.145.243] (10.48.145.243) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 17:56:17 +0100
Message-ID: <360c78dc-65ce-362f-389d-075f2259ce5b@huawei.com>
Date:   Mon, 24 Oct 2022 17:56:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] blk-mq: Properly init bios from
 blk_mq_alloc_request_hctx()
To:     Ming Lei <ming.lei@redhat.com>
CC:     <axboe@kernel.dk>, <linux-kernel@vger.kernel.org>,
        <linux-block@vger.kernel.org>, <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
References: <1666454846-11749-1-git-send-email-john.garry@huawei.com>
 <Y1U9zNZtZjRHQBww@T590> <99c6ca81-746d-85f4-04d3-49d7a3de611b@huawei.com>
 <Y1aS3vIbuQTNGWJL@T590>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <Y1aS3vIbuQTNGWJL@T590>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.145.243]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
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

On 24/10/2022 14:27, Ming Lei wrote:
>>>> -	rq->bio = rq->biotail = NULL;
>>> This patch looks not good, why do you switch to initialize the three fields
>>> twice in fast path?
>> Can you please show me how these are initialized twice?
> blk_mq_bio_to_request() is one which setup these fields, then you add
> another one in blk_mq_rq_ctx_init().

ok, understood.

> 
>> If there is a real concern with this then we go with my original idea, which
>> was to copy the init method of blk_mq_alloc_request() (in
>> blk_mq_alloc_request_hctx())
>>
>>> BTW, we know blk_mq_alloc_request_hctx() has big trouble, so please
>>> avoid to extend it to other use cases.
>> Yeah, I know this,
> Did you know the exact issue on nvme-tcp, nvme-rdma or nvme-fc maybe
> with blk_mq_alloc_request_hctx()?

I thought that the original issue was an OoO bounds issue, fixed in 
14dc7a18. Now there is still some issue in the following link, which is 
still unresolved as I understand:
https://lore.kernel.org/linux-block/5bd886f1-a7c6-b765-da29-777be0328bc2@grimberg.me/#t

But I think that 14dc7a18 may still leave undesirable scenario:
- all cpus in HW queue cpumask may go offline after cpu_online_mask read 
in blk_mq_alloc_request_hctx() and before we get the driver tag and set 
rq->hctx

> 
>> but sometimes we just need to allocate for a specific HW
>> queue...
>>
>> For my usecase of interest, it should not impact if the cpumask of the HW
>> queue goes offline after selecting the cpu in blk_mq_alloc_request_hctx(),
>> so any race is ok ... I think.
>>
>> However it should be still possible to make blk_mq_alloc_request_hctx() more
>> robust. How about using something like work_on_cpu_safe() to allocate and
>> execute the request with blk_mq_alloc_request() on a cpu associated with the
>> HW queue, such that we know the cpu is online and stays online until we
>> execute it? Or also extent to work_on_cpumask_safe() variant, so that we
>> don't need to try all cpus in the mask (to see if online)?
> But all cpus on this hctx->cpumask could become offline.

If all hctx->cpumask are offline then we should not allocate a request 
and this is acceptable. Maybe I am missing your point.

Thanks,
John
