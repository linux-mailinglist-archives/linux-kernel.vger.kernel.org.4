Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23A86C3FB5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 02:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjCVBYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 21:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjCVBYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 21:24:40 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE084C28;
        Tue, 21 Mar 2023 18:24:37 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Ph9gX6Tp3zKsn6;
        Wed, 22 Mar 2023 09:22:16 +0800 (CST)
Received: from [10.174.178.185] (10.174.178.185) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 22 Mar 2023 09:24:33 +0800
Subject: Re: [PATCH] scsi: fix hung_task when change host from recovery to
 running via sysfs
To:     Benjamin Block <bblock@linux.ibm.com>,
        Ye Bin <yebin@huaweicloud.com>
References: <20230321084204.1860900-1-yebin@huaweicloud.com>
 <20230321142237.GC311313@t480-pf1aa2c2.fritz.box>
CC:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   "yebin (H)" <yebin10@huawei.com>
Message-ID: <641A58D0.1020205@huawei.com>
Date:   Wed, 22 Mar 2023 09:24:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <20230321142237.GC311313@t480-pf1aa2c2.fritz.box>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.185]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/21 22:22, Benjamin Block wrote:
> On Tue, Mar 21, 2023 at 04:42:04PM +0800, Ye Bin wrote:
>> From: Ye Bin <yebin10@huawei.com>
>>
>> When do follow test:
>> Step1: echo  "recovery" > /sys/class/scsi_host/host0/state
> Hmm, that make me wonder, what potential use-case this is for? Just
> testing?
Thank you for your reply.
Actually, I'm looking for a way to temporarily stop sending IO to the 
driver.
Setting the state of the host to recovery can do this, but I changed the 
state to
running and found that the process could not be woken up.
I don't know what the purpose of designing this sysfs interface was. But 
this
modification can solve the effect I want to achieve.
> For SDEVs we explicitly filter what states can be set from user-space.
> Only `SDEV_RUNNING` and `SDEV_OFFLINE` can be set in
> `store_state_field()`.
>      There is probably quite a few other bad things you can do with this
> interface by using any of the other states used for device destruction
> or EH, and then trigger I/O or said destruction/EH otherwise.
>      Not sure handling this one special case of `SHOST_RECOVERY` is quite
> enough.
>
>
>> diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
>> index ee28f73af4d4..ae6b1476b869 100644
>> --- a/drivers/scsi/scsi_sysfs.c
>> +++ b/drivers/scsi/scsi_sysfs.c
>> @@ -216,6 +216,9 @@ store_shost_state(struct device *dev, struct device_attribute *attr,
>>
>>        if (scsi_host_set_state(shost, state))
>>                return -EINVAL;
>> +     else
>> +             wake_up(&shost->host_wait);
>> +
>>        return count;
>>   }
>>
>> --
>> 2.31.1
>>

