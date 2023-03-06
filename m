Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0F86AB849
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 09:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjCFI36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 03:29:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjCFI3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 03:29:55 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B623BDD8;
        Mon,  6 Mar 2023 00:29:53 -0800 (PST)
Received: from kwepemm600002.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PVWsv59tFzKpsP;
        Mon,  6 Mar 2023 16:27:47 +0800 (CST)
Received: from [10.174.178.159] (10.174.178.159) by
 kwepemm600002.china.huawei.com (7.193.23.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 6 Mar 2023 16:29:17 +0800
Message-ID: <02189eaa-1964-3fa6-6a06-16d248a3d80d@huawei.com>
Date:   Mon, 6 Mar 2023 16:29:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH-next] scsi: fix use-after-free problem in
 scsi_remove_target
To:     Bart Van Assche <bvanassche@acm.org>,
        Zhong Jinghua <zhongjinghua@huaweicloud.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>, <yukuai3@huawei.com>
References: <20230213034321.3261114-1-zhongjinghua@huaweicloud.com>
 <5cf19e69-b851-abe9-9496-bbba33109404@acm.org>
From:   zhongjinghua <zhongjinghua@huawei.com>
In-Reply-To: <5cf19e69-b851-abe9-9496-bbba33109404@acm.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.159]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600002.china.huawei.com (7.193.23.29)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/3/2 3:46, Bart Van Assche 写道:
> On 2/12/23 19:43, Zhong Jinghua wrote:
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
>
> What is "reaf"? Did you perhaps want to write "reap_ref"?
Yes, I will modify late.
>
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
>
> The above comment should be made more clear, e.g. as follows: "If the 
> reference count is already zero, skip this target. Calling 
> kref_get_unless_zero() if the reference count is zero is safe because 
> scsi_target_destroy() will wait until the host lock has been released 
> before freeing starget."

Agree. Thanks for your e.g.

I will send the v2 late.

>
> Otherwise this patch looks fine to me.
>
> Thanks,
>
> Bart.
>
>
Thanks,

Jinghua

