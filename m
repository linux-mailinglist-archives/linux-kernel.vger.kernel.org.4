Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D812F60C589
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 09:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbiJYHkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 03:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbiJYHko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 03:40:44 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFD2114DCF;
        Tue, 25 Oct 2022 00:40:42 -0700 (PDT)
Received: from frapeml500006.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MxP2G6sHsz6H7M1;
        Tue, 25 Oct 2022 15:38:46 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 frapeml500006.china.huawei.com (7.182.85.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 09:40:39 +0200
Received: from [10.48.157.17] (10.48.157.17) by lhrpeml500003.china.huawei.com
 (7.191.162.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 25 Oct
 2022 08:40:38 +0100
Message-ID: <3513b14c-14e0-b865-628e-a83521090de9@huawei.com>
Date:   Tue, 25 Oct 2022 08:40:38 +0100
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
 <Y1U9zNZtZjRHQBww@T590> <99c6ca81-746d-85f4-04d3-49d7a3de611b@huawei.com>
 <Y1aS3vIbuQTNGWJL@T590> <360c78dc-65ce-362f-389d-075f2259ce5b@huawei.com>
 <Y1cvJ4/uwUScAQq4@T590>
In-Reply-To: <Y1cvJ4/uwUScAQq4@T590>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.157.17]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
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

On 25/10/2022 01:34, Ming Lei wrote:
>>>> but sometimes we just need to allocate for a specific HW
>>>> queue...
>>>>
>>>> For my usecase of interest, it should not impact if the cpumask of the HW
>>>> queue goes offline after selecting the cpu in blk_mq_alloc_request_hctx(),
>>>> so any race is ok ... I think.
>>>>
>>>> However it should be still possible to make blk_mq_alloc_request_hctx() more
>>>> robust. How about using something like work_on_cpu_safe() to allocate and
>>>> execute the request with blk_mq_alloc_request() on a cpu associated with the
>>>> HW queue, such that we know the cpu is online and stays online until we
>>>> execute it? Or also extent to work_on_cpumask_safe() variant, so that we
>>>> don't need to try all cpus in the mask (to see if online)?
>>> But all cpus on this hctx->cpumask could become offline.
>> If all hctx->cpumask are offline then we should not allocate a request and
>> this is acceptable. Maybe I am missing your point.
> As you saw, this API has the above problem too, but any one of CPUs
> may become online later, maybe just during blk_mq_alloc_request_hctx(),
> and it is easy to cause inconsistence.
> 
> You didn't share your use case, but for nvme connection request, if it
> is 1:1 mapping, if any one of CPU becomes offline, the controller
> initialization could be failed, that isn't good from user viewpoint at
> all.

My use case is in SCSI EH domain. For my HBA controller of interest, to 
abort an erroneous IO we must send a controller proprietary abort 
command on same HW queue as original command. So we would need to 
allocate this abort request for a specific HW queue.

I mentioned before that if no hctx->cpumask is online then we don't need 
to allocate a request. That is because if no hctx->cpumask is online, 
this means that original erroneous IO must be completed due to nature of 
how blk-mq cpu hotplug handler works, i.e. drained, and then we don't 
actually need to abort it any longer, so ok to not get a request.

I have an RFC series for this work in which I am using 
blk_mq_alloc_request_hctx(). However, as I mentioned before, I can 
experiment with using something like work_on_cpu_safe() to alloc and 
execute the abort request to safeguard against cpu hotplug events.

Thanks,
John
