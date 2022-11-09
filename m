Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B956224C6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 08:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiKIHlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 02:41:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiKIHlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 02:41:11 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3509F1A04A;
        Tue,  8 Nov 2022 23:41:10 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4N6cMr1cSmz15MVP;
        Wed,  9 Nov 2022 15:40:56 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 9 Nov 2022 15:41:08 +0800
Subject: Re: nvme-pci: NULL pointer dereference in nvme_dev_disable() on
 linux-next
To:     Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
        Gerd Bayer <gbayer@linux.ibm.com>
CC:     Jens Axboe <axboe@fb.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        <linux-kernel@vger.kernel.org>, <linux-next@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>
References: <fad4d2d5e24eabe1a4fcab75c5d080a6229dc88b.camel@linux.ibm.com>
 <20221108074846.GA22674@lst.de>
 <65f5d26b-b0af-f9c6-e77c-e82ac969e9f9@grimberg.me>
From:   Chao Leng <lengchao@huawei.com>
Message-ID: <d6845b29-dcce-4aaf-0093-b658bf6cdf32@huawei.com>
Date:   Wed, 9 Nov 2022 15:41:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <65f5d26b-b0af-f9c6-e77c-e82ac969e9f9@grimberg.me>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The check "if (!ctrl->tagset)" is just reduce the probability.

The real reason is the race of probe and remove.
It is similar with TCP and RDMA transport.
Israel has tried to fix it.
The detail:
https://github.com/torvalds/linux/commit/ce1518139e6976cf19c133b555083354fdb629b8
Unfortunately, this patch was reverted.

If it is in the process of "probe", remove should not be called.
Maybe we can move pci_set_drvdata to the end of nvme_probe.
Of course, the removal may not take effect if it is in the process of "probe".
This is why the patch of Israel is reverted.

Perhaps the better option would be that "remove" wait for the "probe" to complete,
and then do the real remove.
This requires additional mechanism to implement this.

On 2022/11/9 10:54, Sagi Grimberg wrote:
> 
>> Below is the minimal fix.  I'll see if I sort out the mess that is
>> probe/reset failure vs ->remove a bit better, though.
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index f94b05c585cbc..577bacdcfee08 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -5160,6 +5160,8 @@ EXPORT_SYMBOL_GPL(nvme_start_freeze);
>>   void nvme_stop_queues(struct nvme_ctrl *ctrl)
>>   {
>> +    if (!ctrl->tagset)
>> +        return;
>>       if (!test_and_set_bit(NVME_CTRL_STOPPED, &ctrl->flags))
>>           blk_mq_quiesce_tagset(ctrl->tagset);
>>       else
>> @@ -5169,6 +5171,8 @@ EXPORT_SYMBOL_GPL(nvme_stop_queues);
>>   void nvme_start_queues(struct nvme_ctrl *ctrl)
>>   {
>> +    if (!ctrl->tagset)
>> +        return;
>>       if (test_and_clear_bit(NVME_CTRL_STOPPED, &ctrl->flags))
>>           blk_mq_unquiesce_tagset(ctrl->tagset);
>>   }
> 
> Can we do that in the pci driver and not here?
> 
> .
