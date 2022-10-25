Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3E860C7B8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 11:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbiJYJPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 05:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbiJYJPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 05:15:23 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C85E17D851;
        Tue, 25 Oct 2022 02:08:16 -0700 (PDT)
Received: from frapeml100006.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MxQzJ61yrz67bjw;
        Tue, 25 Oct 2022 17:06:20 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 frapeml100006.china.huawei.com (7.182.85.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 11:08:13 +0200
Received: from [10.195.245.7] (10.195.245.7) by lhrpeml500003.china.huawei.com
 (7.191.162.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 25 Oct
 2022 10:08:12 +0100
Message-ID: <cf7f8f88-7d3e-8818-8584-e2276e7a1f30@huawei.com>
Date:   Tue, 25 Oct 2022 10:08:10 +0100
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
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <CAFj5m9JnSBBVGrp5CqeH99-+VOGRuroUAi3c-3=6XKa891Sfmw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.195.245.7]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
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

On 25/10/2022 10:00, Ming Lei wrote:
>> My use case is in SCSI EH domain. For my HBA controller of interest, to
>> abort an erroneous IO we must send a controller proprietary abort
>> command on same HW queue as original command. So we would need to
>> allocate this abort request for a specific HW queue.
> IMO, it is one bad hw/sw interface.
> 
> First such request has to be reserved, since all inflight IOs can be in error.

Right

> 
> Second error handling needs to provide forward-progress, and it is supposed
> to not require external dependency, otherwise easy to cause deadlock, but
> here request from specific HW queue just depends on this queue's cpumask.
> 
> Also if it has to be reserved, it can be done as one device/driver private
> command, so why bother blk-mq for this special use case?

I have a series for reserved request support, which I will send later. 
Please have a look. And as I mentioned, I would prob not end up using 
blk_mq_alloc_request_hctx() anyway.

> 
>> I mentioned before that if no hctx->cpumask is online then we don't need
>> to allocate a request. That is because if no hctx->cpumask is online,
>> this means that original erroneous IO must be completed due to nature of
>> how blk-mq cpu hotplug handler works, i.e. drained, and then we don't
>> actually need to abort it any longer, so ok to not get a request.
> No, it is really not OK, if all cpus in hctx->cpumask are offline, you
> can't allocate
> request on the specified hw queue, then the erroneous IO can't be handled,
> then cpu hotplug handler may hang for ever.

If the erroneous IO is still in-flight from blk-mq perspective, then how 
can hctx->cpumask still be offline? I thought that we guarantee that 
hctx->cpumask cannot go offline until drained.

Thanks,
John

