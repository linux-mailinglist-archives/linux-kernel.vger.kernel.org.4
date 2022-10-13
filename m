Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE9875FD555
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 09:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiJMHDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 03:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJMHC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 03:02:59 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F1AF88C4;
        Thu, 13 Oct 2022 00:02:56 -0700 (PDT)
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Mp0lT53g9z1CF5W;
        Thu, 13 Oct 2022 15:00:21 +0800 (CST)
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm500004.china.huawei.com (7.192.104.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 13 Oct 2022 15:02:54 +0800
Subject: Re: [PATCH 4.19] scsi: sd: Fix 'sdkp' in sd_first_printk
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Li kunyu <kunyu@nfschina.com>
CC:     <jejb@linux.vnet.ibm.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <martin.petersen@oracle.com>
References: <0e67aa4d-f66e-f392-5950-31b1c90c287b@opensource.wdc.com>
 <20221013044927.278854-1-kunyu@nfschina.com>
 <badf255f-df60-fbc7-0f61-c69b99ebbaa6@huawei.com>
 <45f33e3e-c1a7-7183-bf04-83649af8ac04@opensource.wdc.com>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <7baa5eb6-95f7-a0cb-6aef-157cf43866e7@huawei.com>
Date:   Thu, 13 Oct 2022 15:02:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <45f33e3e-c1a7-7183-bf04-83649af8ac04@opensource.wdc.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.14]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500004.china.huawei.com (7.192.104.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/10/13 14:39, Damien Le Moal wrote:
> On 2022/10/13 15:26, Jason Yan wrote:
>>
>> On 2022/10/13 12:49, Li kunyu wrote:
>>>
>>> This is defined in the 4.19 kernel:
>>>
>>> #define sd_printk(prefix, sdsk, fmt, a...)                              \
>>>           (sdsk)->disk ?                                                  \
>>>                 sdev_prefix_printk(prefix, (sdsk)->device,                \
>>>                                    (sdsk)->disk->disk_name, fmt, ##a) :   \
>>>                 sdev_printk(prefix, (sdsk)->device, fmt, ##a)
>>>
>>> #define sd_first_printk(prefix, sdsk, fmt, a...)                        \
>>>           do {                                                            \
>>>                   if ((sdkp)->first_scan)                                 \
>>>                           sd_printk(prefix, sdsk, fmt, ##a);              \
>>>           } while (0)
>>>
>>>
>>>
>>> Most of the sdsk used in the macro definition has only one sdkp.
>>>
>>>
>>> This is defined in the v6.0-rc7 kernel:
>>>
>>> #define sd_printk(prefix, sdsk, fmt, a...)                              \
>>>           (sdsk)->disk ?                                                  \
>>>                 sdev_prefix_printk(prefix, (sdsk)->device,                \
>>>                                    (sdsk)->disk->disk_name, fmt, ##a) :   \
>>>                 sdev_printk(prefix, (sdsk)->device, fmt, ##a)
>>>
>>> #define sd_first_printk(prefix, sdsk, fmt, a...)                        \
>>>           do {                                                            \
>>>                   if ((sdsk)->first_scan)                                 \
>>>                           sd_printk(prefix, sdsk, fmt, ##a);              \
>>>           } while (0)
>>>
>>> Use sdsk in macro definition.
>>>
>>>
>>> I did report an error when compiling sd. o in the 4.19 kernel. It was modified to say that no more errors were reported in sdsk. Can I continue the 6.0-rc7 writing method here.
>>>
>>
>> You should backport the mainline patch to 4.19, not create a new one.
> 
> Yes, but since the mainline patch has a typo, better fix it and backport the fix
> too with a "Fixes" tag.
> 

What typo in the patch? I did not see it.

> My point about the proposed patch was to make the reverse change to fix the
> macro: use sdkp instead of sdsk since the former is used everywhere and clear.
> But sure, since this is not causing any issue, no strong need to fix the macro.
> It is really ugly as-is though :)
> 

I agree that there is no need to backport it.

Thanks,
Jason

>>
>> commit df46cac3f71c57e0b23f6865651629aaa54f8ca9
>> Author: Dietmar Hahn <dietmar.hahn@ts.fujitsu.com>
>> Date:   Tue Feb 5 11:10:48 2019 +0100
>>
>>       scsi: sd: Fix typo in sd_first_printk()
>>
>>       Commit b2bff6ceb61a9 ("[SCSI] sd: Quiesce mode sense error messages")
>>       added the macro sd_first_printk(). The macro takes "sdsk" as argument
>>       but dereferences "sdkp". This hasn't caused any real issues since all
>>       callers of sd_first_printk() have an sdkp. But fix the typo.
>>
>>       [mkp: Turned this into a real patch and tweaked commit description]
>>
>>       Signed-off-by: Dietmar Hahn <dietmar.hahn@ts.fujitsu.com>
>>       Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
>>
>> diff --git a/drivers/scsi/sd.h b/drivers/scsi/sd.h
>> index 1080c85d97f8..5796ace76225 100644
>> --- a/drivers/scsi/sd.h
>> +++ b/drivers/scsi/sd.h
>> @@ -132,7 +132,7 @@ static inline struct scsi_disk *scsi_disk(struct
>> gendisk *disk)
>>
>>    #define sd_first_printk(prefix, sdsk, fmt, a...)                       \
>>           do {                                                            \
>> -               if ((sdkp)->first_scan)                                 \
>> +               if ((sdsk)->first_scan)                                 \
>>                           sd_printk(prefix, sdsk, fmt, ##a);              \
>>           } while (0)
>>
>>
>>
>>>
>>> .
>>>
> 
