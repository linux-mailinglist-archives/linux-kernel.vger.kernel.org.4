Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7136A7D1A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 09:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjCBI4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 03:56:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjCBI4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 03:56:47 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05E128216;
        Thu,  2 Mar 2023 00:56:45 -0800 (PST)
Received: from kwepemm600002.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PS4hM0wmjzrS0r;
        Thu,  2 Mar 2023 16:56:03 +0800 (CST)
Received: from [10.174.178.159] (10.174.178.159) by
 kwepemm600002.china.huawei.com (7.193.23.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 2 Mar 2023 16:56:42 +0800
Message-ID: <803eb357-3f00-5590-5549-25d798d185e7@huawei.com>
Date:   Thu, 2 Mar 2023 16:56:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH-next] scsi: fix use-after-free problem in
 scsi_remove_target
To:     <jejb@linux.ibm.com>, zhongjinghua <zhongjinghua@huaweicloud.com>,
        <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>, <yukuai3@huawei.com>
References: <20230213034321.3261114-1-zhongjinghua@huaweicloud.com>
 <4585779e-f919-0439-2062-b1f30b04f176@huawei.com>
 <a71be678-7f40-811b-4612-81a4eeb910dd@huaweicloud.com>
 <afba754afa2bd1fe7e0e72400b202db5b51ecdd8.camel@linux.ibm.com>
From:   zhongjinghua <zhongjinghua@huawei.com>
In-Reply-To: <afba754afa2bd1fe7e0e72400b202db5b51ecdd8.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.159]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600002.china.huawei.com (7.193.23.29)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/3/2 3:51, James Bottomley 写道:
> On Wed, 2023-03-01 at 11:40 +0800, zhongjinghua wrote:
>> ping...
>>
>> Hello，
>>
>> Anyone looking this？
>>
>> 在 2023/3/1 11:37, zhongjinghua 写道:
>>> ping...
>>>
>>> Hello，
>>>
>>> Anyone looking this？
>>>
>>> 在 2023/2/13 11:43, Zhong Jinghua 写道:
>>>> From: Zhong Jinghua <zhongjinghua@huawei.com>
>>>>
>>>> A use-after-free problem like below:
>>>>
>>>> BUG: KASAN: use-after-free in scsi_target_reap+0x6c/0x70
>>>>
>>>> Workqueue: scsi_wq_1 __iscsi_unbind_session
>>>> [scsi_transport_iscsi]
>>>> Call trace:
>>>>    dump_backtrace+0x0/0x320
>>>>    show_stack+0x24/0x30
>>>>    dump_stack+0xdc/0x128
>>>>    print_address_description+0x68/0x278
>>>>    kasan_report+0x1e4/0x308
>>>>    __asan_report_load4_noabort+0x30/0x40
>>>>    scsi_target_reap+0x6c/0x70
>>>>    scsi_remove_target+0x430/0x640
>>>>    __iscsi_unbind_session+0x164/0x268 [scsi_transport_iscsi]
>>>>    process_one_work+0x67c/0x1350
>>>>    worker_thread+0x370/0xf90
>>>>    kthread+0x2a4/0x320
>>>>    ret_from_fork+0x10/0x18
>>>>
>>>> The problem is caused by a concurrency scenario:
>>>>
>>>> T0: delete target
>>>> // echo 1 >
>>>> /sys/devices/platform/host1/session1/target1:0:0/1:0:0:1/delete
>>>> T1: logout
>>>> // iscsiadm -m node --logout
>>>>
>>>> T0                            T1
>>>>    sdev_store_delete
>>>>     scsi_remove_device
>>>>      device_remove_file
>>>>       __scsi_remove_device
>>>>                               __iscsi_unbind_session
>>>>                                scsi_remove_target
>>>>                            spin_lock_irqsave
>>>>                                 list_for_each_entry
>>>>        scsi_target_reap // starget->reaf 1 -> 0
>>>> kref_get(&starget->reap_ref);
>>>>                            // warn use-after-free.
>>>>                            spin_unlock_irqrestore
>>>>         scsi_target_reap_ref_release
>>>>      scsi_target_destroy
>>>>      ... // delete starget
>>>>                            scsi_target_reap
>>>>                            // UAF
>>>>
>>>> When T0 reduces the reference count to 0, but has not been
>>>> released,
>>>> T1 can still enter list_for_each_entry, and then kref_get reports
>>>> UAF.
>>>>
>>>> Fix it by using kref_get_unless_zero() to check for a reference
>>>> count of
>>>> 0.
>>>>
>>>> Signed-off-by: Zhong Jinghua <zhongjinghua@huawei.com>
>>>> ---
>>>>    drivers/scsi/scsi_sysfs.c | 12 +++++++++++-
>>>>    1 file changed, 11 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/scsi/scsi_sysfs.c
>>>> b/drivers/scsi/scsi_sysfs.c
>>>> index e7893835b99a..0ad357ff4c59 100644
>>>> --- a/drivers/scsi/scsi_sysfs.c
>>>> +++ b/drivers/scsi/scsi_sysfs.c
>>>> @@ -1561,7 +1561,17 @@ void scsi_remove_target(struct device
>>>> *dev)
>>>>                starget->state == STARGET_CREATED_REMOVE)
>>>>                continue;
>>>>            if (starget->dev.parent == dev || &starget->dev == dev)
>>>> {
>>>> -            kref_get(&starget->reap_ref);
>>>> +
>>>> +            /*
>>>> +             * If starget->reap_ref is reduced to 0, it means
>>>> +             * that other processes are releasing it and
>>>> +             * there is no need to delete it again
>>>> +             */
>>>> +            if (!kref_get_unless_zero(&starget->reap_ref)) {
>>>> +                spin_unlock_irqrestore(shost->host_lock, flags);
>>>> +                goto restart;
> This doesn't seem to be a good idea: you're asking for a live lock
> where the thread that's already reduced the refcount to 0 and will
> eventually remove the target from the list doesn't progress before you
> take the lock again in the restart and then you find the same result
> and go round again (and again ...).

I agree with this, no need to use goto restart.

> Since there should only be one match in the target list and you found
> it and know it's going away, what about break instead of unlock and
> goto restart?

Wouldn't it be better to use continue? Assuming that the device 
parameter is a session, maybe not only one is matched.

>
> James

Thanks.

Jinghua.

