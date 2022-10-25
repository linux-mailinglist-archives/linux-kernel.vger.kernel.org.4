Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED1F60C823
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 11:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbiJYJcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 05:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiJYJcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 05:32:36 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166F4EC504;
        Tue, 25 Oct 2022 02:32:33 -0700 (PDT)
Received: from frapeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MxRWy46CWz687w5;
        Tue, 25 Oct 2022 17:31:10 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 frapeml500005.china.huawei.com (7.182.85.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 11:32:31 +0200
Received: from [10.195.245.7] (10.195.245.7) by lhrpeml500003.china.huawei.com
 (7.191.162.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 25 Oct
 2022 10:32:30 +0100
Message-ID: <399a2c2d-0b56-e4e7-c309-a6b9537d8939@huawei.com>
Date:   Tue, 25 Oct 2022 10:32:28 +0100
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
 <Y1aS3vIbuQTNGWJL@T590> <360c78dc-65ce-362f-389d-075f2259ce5b@huawei.com>
 <Y1cvJ4/uwUScAQq4@T590> <3513b14c-14e0-b865-628e-a83521090de9@huawei.com>
 <CAFj5m9JnSBBVGrp5CqeH99-+VOGRuroUAi3c-3=6XKa891Sfmw@mail.gmail.com>
 <cf7f8f88-7d3e-8818-8584-e2276e7a1f30@huawei.com> <Y1epeuwonmjQhrXW@T590>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <Y1epeuwonmjQhrXW@T590>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.195.245.7]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
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

On 25/10/2022 10:16, Ming Lei wrote:
>>>> I mentioned before that if no hctx->cpumask is online then we don't need
>>>> to allocate a request. That is because if no hctx->cpumask is online,
>>>> this means that original erroneous IO must be completed due to nature of
>>>> how blk-mq cpu hotplug handler works, i.e. drained, and then we don't
>>>> actually need to abort it any longer, so ok to not get a request.
>>> No, it is really not OK, if all cpus in hctx->cpumask are offline, you
>>> can't allocate
>>> request on the specified hw queue, then the erroneous IO can't be handled,
>>> then cpu hotplug handler may hang for ever.
>> If the erroneous IO is still in-flight from blk-mq perspective, then how can
>> hctx->cpumask still be offline? I thought that we guarantee that
>> hctx->cpumask cannot go offline until drained.
> Yeah, the draining is done before the cpu is offline. But the drain is
> simply waiting for the inflight IO to be completed. If the IO is failed
> during the waiting, you can't allocate such reserved request for error
> handling, then hang ever in blk_mq_hctx_notify_offline().

Actually if final cpu in hctx->cpumask is going offline, then hctx won't 
queue any more requests, right? In this case I don't think we can queue 
on that hctx anyway. I need to think about this more.

> 
> If you just make it one driver private command, there can't be such
> issue. 

Well we're trying to use reserved requests for EH commands, which that 
goes against.

> Block layer is supposed for handling common case(normal io and pt io),
> I'd suggest to not put such special cases into block layer.

It also supports reserved commands, which I would assume would be 
suitable for EH scenarios.

Thanks,
John

