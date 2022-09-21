Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63B495BF4E0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 05:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiIUDkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 23:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiIUDkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 23:40:52 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F6F476DE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 20:40:49 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=liusong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VQM7hzd_1663731646;
Received: from 30.178.80.176(mailfrom:liusong@linux.alibaba.com fp:SMTPD_---0VQM7hzd_1663731646)
          by smtp.aliyun-inc.com;
          Wed, 21 Sep 2022 11:40:47 +0800
Message-ID: <e1d773e0-8964-dded-fbc1-b9f0a39bab8c@linux.alibaba.com>
Date:   Wed, 21 Sep 2022 11:40:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [RFC PATCH] nvme: request remote is usually not involved for nvme
 devices
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     kbusch@kernel.org, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1663432858-99743-1-git-send-email-liusong@linux.alibaba.com>
 <d8e43495-0959-2b47-b0af-be46d7ad57ea@kernel.dk>
 <7b28925a-cbee-620f-fde7-d16f256836cc@linux.alibaba.com>
 <894e18a4-4504-df48-6429-a04c222ca064@kernel.dk>
 <20220919143556.GA28122@lst.de>
From:   Liu Song <liusong@linux.alibaba.com>
In-Reply-To: <20220919143556.GA28122@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.1 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/9/19 22:35, Christoph Hellwig wrote:
> On Mon, Sep 19, 2022 at 08:10:31AM -0600, Jens Axboe wrote:
>> I'm not disagreeing with any of that, my point is just that you're
>> hacking around this in the nvme driver. This is problematic whenever
>> core changes happen, because now we have to touch individual drivers.
>> While the expectation is that there are no remote IPI completions for
>> NVMe, queue starved devices do exist and those do see remote
>> completions.
>>
>> This optimization belongs in the blk-mq core, not in nvme. I do think it
>> makes sense, you just need to solve it in blk-mq rather than in the nvme
>> driver.
> I'd also really see solid numbers to justify it.
>
> And btw, having more than one core per queue is quite common in
> nvme.  Even many enterprise SSDs only have 64 queues, and some of
> the low-end consumers ones have very low number of queues that are
> not enough for the number of cores in even mid-end desktop CPUs.

Hi

Thank you for your suggestion. Here is what I think about it. NVMe 
devices that can support
one core per queue are usually high-performance, so I prefer to make 
more optimizations
for high-performance devices, while for ordinary consumption class NVMe 
devices, such
modifications will not bring special additional overhead.

Thanks

