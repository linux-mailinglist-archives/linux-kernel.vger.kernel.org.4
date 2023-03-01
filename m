Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D756A668C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 04:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjCADkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 22:40:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjCADkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 22:40:10 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D802637F1A;
        Tue, 28 Feb 2023 19:40:07 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PRKkB3xwYz4f3p0Z;
        Wed,  1 Mar 2023 11:40:02 +0800 (CST)
Received: from [10.174.178.159] (unknown [10.174.178.159])
        by APP4 (Coremail) with SMTP id gCh0CgBXwLMSyf5jqAsSEg--.49286S3;
        Wed, 01 Mar 2023 11:40:04 +0800 (CST)
Message-ID: <a71be678-7f40-811b-4612-81a4eeb910dd@huaweicloud.com>
Date:   Wed, 1 Mar 2023 11:40:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH-next] scsi: fix use-after-free problem in
 scsi_remove_target
To:     zhongjinghua <zhongjinghua@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yukuai3@huawei.com
References: <20230213034321.3261114-1-zhongjinghua@huaweicloud.com>
 <4585779e-f919-0439-2062-b1f30b04f176@huawei.com>
From:   zhongjinghua <zhongjinghua@huaweicloud.com>
In-Reply-To: <4585779e-f919-0439-2062-b1f30b04f176@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBXwLMSyf5jqAsSEg--.49286S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGryUKrWrXr1furyxCFWxZwb_yoWrWry8pr
        18Jry5GrWUGrWkJr1UXr1UJryUJr1UGw1DJr1xJ3W7Jw15Aryjqr1UXryqgF1UAF48Jr1U
        Jr1UJr1UZr4UJr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
        wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
        k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
        1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: x2kr0wpmlqwxtxd6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping...

Hello，

Anyone looking this？

在 2023/3/1 11:37, zhongjinghua 写道:
> ping...
>
> Hello，
>
> Anyone looking this？
>
> 在 2023/2/13 11:43, Zhong Jinghua 写道:
>> From: Zhong Jinghua <zhongjinghua@huawei.com>
>>
>> A use-after-free problem like below:
>>
>> BUG: KASAN: use-after-free in scsi_target_reap+0x6c/0x70
>>
>> Workqueue: scsi_wq_1 __iscsi_unbind_session [scsi_transport_iscsi]
>> Call trace:
>>   dump_backtrace+0x0/0x320
>>   show_stack+0x24/0x30
>>   dump_stack+0xdc/0x128
>>   print_address_description+0x68/0x278
>>   kasan_report+0x1e4/0x308
>>   __asan_report_load4_noabort+0x30/0x40
>>   scsi_target_reap+0x6c/0x70
>>   scsi_remove_target+0x430/0x640
>>   __iscsi_unbind_session+0x164/0x268 [scsi_transport_iscsi]
>>   process_one_work+0x67c/0x1350
>>   worker_thread+0x370/0xf90
>>   kthread+0x2a4/0x320
>>   ret_from_fork+0x10/0x18
>>
>> The problem is caused by a concurrency scenario:
>>
>> T0: delete target
>> // echo 1 > 
>> /sys/devices/platform/host1/session1/target1:0:0/1:0:0:1/delete
>> T1: logout
>> // iscsiadm -m node --logout
>>
>> T0                            T1
>>   sdev_store_delete
>>    scsi_remove_device
>>     device_remove_file
>>      __scsi_remove_device
>>                              __iscsi_unbind_session
>>                               scsi_remove_target
>>                           spin_lock_irqsave
>>                                list_for_each_entry
>>       scsi_target_reap // starget->reaf 1 -> 0
>> kref_get(&starget->reap_ref);
>>                           // warn use-after-free.
>>                           spin_unlock_irqrestore
>>        scsi_target_reap_ref_release
>>     scsi_target_destroy
>>     ... // delete starget
>>                           scsi_target_reap
>>                           // UAF
>>
>> When T0 reduces the reference count to 0, but has not been released,
>> T1 can still enter list_for_each_entry, and then kref_get reports UAF.
>>
>> Fix it by using kref_get_unless_zero() to check for a reference count of
>> 0.
>>
>> Signed-off-by: Zhong Jinghua <zhongjinghua@huawei.com>
>> ---
>>   drivers/scsi/scsi_sysfs.c | 12 +++++++++++-
>>   1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
>> index e7893835b99a..0ad357ff4c59 100644
>> --- a/drivers/scsi/scsi_sysfs.c
>> +++ b/drivers/scsi/scsi_sysfs.c
>> @@ -1561,7 +1561,17 @@ void scsi_remove_target(struct device *dev)
>>               starget->state == STARGET_CREATED_REMOVE)
>>               continue;
>>           if (starget->dev.parent == dev || &starget->dev == dev) {
>> -            kref_get(&starget->reap_ref);
>> +
>> +            /*
>> +             * If starget->reap_ref is reduced to 0, it means
>> +             * that other processes are releasing it and
>> +             * there is no need to delete it again
>> +             */
>> +            if (!kref_get_unless_zero(&starget->reap_ref)) {
>> +                spin_unlock_irqrestore(shost->host_lock, flags);
>> +                goto restart;
>> +            }
>> +
>>               if (starget->state == STARGET_CREATED)
>>                   starget->state = STARGET_CREATED_REMOVE;
>>               else

