Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E65C5747B8F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 04:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjGEC26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 22:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjGEC24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 22:28:56 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F7810E2;
        Tue,  4 Jul 2023 19:28:54 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Qwk9r61kJz4f3kjL;
        Wed,  5 Jul 2023 10:28:48 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgAHoZRd1aRkt_btNA--.43111S3;
        Wed, 05 Jul 2023 10:28:47 +0800 (CST)
Subject: Re: [PATCH] scsi/sg: don't grab scsi host module reference
To:     Yu Kuai <yukuai1@huaweicloud.com>,
        Marc Hartmayer <mhartmay@linux.ibm.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com, hch@lst.de,
        chaitanyak@nvidia.com, shinichiro.kawasaki@wdc.com,
        dgilbert@interlog.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, axboe@kernel.dk,
        Benjamin Block <bblock@linux.ibm.com>,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230621160111.1433521-1-yukuai1@huaweicloud.com>
 <87lefv622n.fsf@linux.ibm.com>
 <70432d91-3909-ac3c-9c36-5f7484c1fdf1@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <1efb3d4d-a05b-2eb2-a140-a76981b662a4@huaweicloud.com>
Date:   Wed, 5 Jul 2023 10:28:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <70432d91-3909-ac3c-9c36-5f7484c1fdf1@huaweicloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHoZRd1aRkt_btNA--.43111S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXF43Cr1ktFy8urWDAr13Arb_yoWruFy5pF
        WkKa9xCrW8Gr48Gw1jqr1UZFyft3yIv347JF48G3W5uF4xAryjgryDXFy0gF1UArWkWF4U
        KFn8KF9FvF1UJr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUB214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E
        7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
        C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
        04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
        kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUouWlDUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/07/05 9:43, Yu Kuai 写道:
> Hi,
> 
> 在 2023/07/05 1:04, Marc Hartmayer 写道:
>> On Thu, Jun 22, 2023 at 12:01 AM +0800, Yu Kuai 
>> <yukuai1@huaweicloud.com> wrote:
>>> From: Yu Kuai <yukuai3@huawei.com>
>>>
>>> In order to prevent request_queue to be freed before cleaning up
>>> blktrace debugfs entries, commit db59133e9279 ("scsi: sg: fix blktrace
>>> debugfs entries leakage") use scsi_device_get(), however,
>>> scsi_device_get() will also grab scsi module reference and scsi module
>>> can't be removed.
>>>
>>> It's reported that blktests can't unload scsi_debug after block/001:
>>>
>>> blktests (master) # ./check block
>>> block/001 (stress device hotplugging) [failed]
>>>       +++ /root/blktests/results/nodev/block/001.out.bad 2023-06-19
>>>        Running block/001
>>>        Stressing sd
>>>       +modprobe: FATAL: Module scsi_debug is in use.
>>>
>>> Fix this problem by grabbing request_queue reference directly, so that
>>> scsi host module can still be unloaded while request_queue will be
>>> pinged by sg device.
>>>
>>> Reported-by: Chaitanya Kulkarni <chaitanyak@nvidia.com>
>>> Link: 
>>> https://lore.kernel.org/all/1760da91-876d-fc9c-ab51-999a6f66ad50@nvidia.com/ 
>>>
>>> Fixes: db59133e9279 ("scsi: sg: fix blktrace debugfs entries leakage")
>>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>>> ---
>>>   drivers/scsi/sg.c | 6 +++---
>>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
>>> index 2433eeef042a..dcb73787c29d 100644
>>> --- a/drivers/scsi/sg.c
>>> +++ b/drivers/scsi/sg.c
>>> @@ -1497,7 +1497,7 @@ sg_add_device(struct device *cl_dev)
>>>       int error;
>>>       unsigned long iflags;
>>> -    error = scsi_device_get(scsidp);
>>> +    error = blk_get_queue(scsidp->request_queue);
>>>       if (error)
>>>           return error;
>>> @@ -1558,7 +1558,7 @@ sg_add_device(struct device *cl_dev)
>>>   out:
>>>       if (cdev)
>>>           cdev_del(cdev);
>>> -    scsi_device_put(scsidp);
>>> +    blk_put_queue(scsidp->request_queue);
>>>       return error;
>>>   }
>>> @@ -1575,7 +1575,7 @@ sg_device_destroy(struct kref *kref)
>>>        */
>>>       blk_trace_remove(q);
>>> -    scsi_device_put(sdp->device);
>>> +    blk_put_queue(q);
>>>       write_lock_irqsave(&sg_index_lock, flags);
>>>       idr_remove(&sg_index_idr, sdp->index);
>>> -- 
>>> 2.39.2
>>
>> Hi,
>>
>> This change (bisected) triggers a regression in our KVM on s390x CI. The
>> symptom is that a “scsi_debug device” does not bind to the scsi_generic
>> driver. On s390x you can reproduce the problem as follows (I have not
>> tested on x86):
>>
>> With this patch applied:
>>
>> $ sudo modprobe scsi_debug
>> $ # Get the 'scsi_host,channel,target_number,LUN' tuple for the 
>> scsi_debug device
>> $ lsscsi |grep scsi_debug |awk '{ print $1 }'
>> [0:0:0:0]
>> $ sudo stat /sys/bus/scsi/devices/0:0:0:0/scsi_generic
>> stat: cannot statx '/sys/bus/scsi/devices/0:0:0:0/scsi_generic': No 
>> such file or directory
>>
>>
>> Patch reverted:
>>
> 
> I didn't figure out the root cause, howver, have you tried to reviert
> this patch as well?
> 
> db59133e9279 ("scsi: sg: fix blktrace debugfs entries leakage"

Never mind this, root cause is that the checking of return value of
blk_get_queue() is wrong.

This shoud be fixed by following patch:

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 89fa046c7158..0d8afffd1683 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -1497,9 +1497,10 @@ sg_add_device(struct device *cl_dev)
         int error;
         unsigned long iflags;

-       error = blk_get_queue(scsidp->request_queue);
-       if (error)
-               return error;
+       if (!blk_get_queue(scsidp->request_queue)) {
+               pr_warn("%s: get scsi_device queue failed\n", __func__);
+               return -ENODEV;
+       }

         error = -ENOMEM;
         cdev = cdev_alloc();

> 
> Thanks,
> Kuai
>> $ sudo modprobe scsi_debug
>> $ lsscsi |grep scsi_debug |awk '{ print $1 }'
>> [0:0:0:0]
>> $ sudo stat /sys/bus/scsi/devices/0:0:0:0/scsi_generic
>>    File: /sys/bus/scsi/devices/0:0:0:0/scsi_generic
>>    Size: 0             Blocks: 0          IO Block: 4096   directory
>> Device: 0,20    Inode: 12155       Links: 3
>> …
>>
>> Any ideas?
>>
>>   Marc
>> .
>>
> 
> .
> 

