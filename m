Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED5860CB02
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 13:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbiJYLgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 07:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiJYLgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 07:36:15 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3046CD10;
        Tue, 25 Oct 2022 04:36:14 -0700 (PDT)
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MxVD96hy0z686Kq;
        Tue, 25 Oct 2022 19:32:41 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 13:36:12 +0200
Received: from [10.48.144.83] (10.48.144.83) by lhrpeml500003.china.huawei.com
 (7.191.162.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 25 Oct
 2022 12:36:11 +0100
Message-ID: <05ae5abd-9b96-3ffe-6bd9-e996d28a8897@huawei.com>
Date:   Tue, 25 Oct 2022 12:36:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] blk-mq: Properly init bios from
 blk_mq_alloc_request_hctx()
To:     Ming Lei <ming.lei@redhat.com>
CC:     <axboe@kernel.dk>, <linux-kernel@vger.kernel.org>,
        <linux-block@vger.kernel.org>, <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
References: <Y1U9zNZtZjRHQBww@T590>
 <99c6ca81-746d-85f4-04d3-49d7a3de611b@huawei.com> <Y1aS3vIbuQTNGWJL@T590>
 <360c78dc-65ce-362f-389d-075f2259ce5b@huawei.com> <Y1cvJ4/uwUScAQq4@T590>
 <3513b14c-14e0-b865-628e-a83521090de9@huawei.com>
 <CAFj5m9JnSBBVGrp5CqeH99-+VOGRuroUAi3c-3=6XKa891Sfmw@mail.gmail.com>
 <cf7f8f88-7d3e-8818-8584-e2276e7a1f30@huawei.com> <Y1epeuwonmjQhrXW@T590>
 <399a2c2d-0b56-e4e7-c309-a6b9537d8939@huawei.com> <Y1fGrfHqbha6l+hz@T590>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <Y1fGrfHqbha6l+hz@T590>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.144.83]
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

On 25/10/2022 12:21, Ming Lei wrote:
>> Actually if final cpu in hctx->cpumask is going offline, then hctx won't
>> queue any more requests, right? In this case I don't think we can queue on
>> that hctx anyway. I need to think about this more.
> It can be queued actually, but interrupt may not be delivered if managed
> irq is used.

Yes, I think it will be queued elsewhere. I would need to check the code 
again.

> 
>>> If you just make it one driver private command, there can't be such
>>> issue.
>> Well we're trying to use reserved requests for EH commands, which that goes
>> against.
>>
>>> Block layer is supposed for handling common case(normal io and pt io),
>>> I'd suggest to not put such special cases into block layer.
>> It also supports reserved commands, which I would assume would be suitable
>> for EH scenarios.
> Then you have to be careful, as I mentioned, EH has to provide forward
> progress, if you let blk-mq allocate & submit EH request, the implied
> dependency from blk-mq has to be payed attention.

OK, thanks, I know that this carries risk, but it seems right approach.

I have been thinking about my HW queue allocation requirement and maybe 
we can solve in low-level driver instead.

The requirement is to send this abort command on same queue as erroneous 
command to ensure that they do not race in HW submission, even though 
chance of this is really tiny. Maybe we can make low-level driver wait 
until erroneous command is really submitted to HW by checking HW 
register, etc. before issuing abort on any HW queue (and so would not 
need blk_mq_alloc_request_hctx() or similar).

BTW, I would still like to fix blk_mq_alloc_request_hctx() to properly 
init ->bio and other fields - ok?

Thanks,
John

