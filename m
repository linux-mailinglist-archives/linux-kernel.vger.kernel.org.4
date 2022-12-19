Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 664B0650C48
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 13:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbiLSM7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 07:59:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbiLSM7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 07:59:09 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C7FF59C;
        Mon, 19 Dec 2022 04:59:08 -0800 (PST)
Received: from dggpemm500012.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NbKWD4YLvzmWZC;
        Mon, 19 Dec 2022 20:58:00 +0800 (CST)
Received: from [10.67.101.126] (10.67.101.126) by
 dggpemm500012.china.huawei.com (7.185.36.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 19 Dec 2022 20:59:06 +0800
Message-ID: <f15c142c-669d-6bc7-f9b9-c05cc3df1542@huawei.com>
Date:   Mon, 19 Dec 2022 20:59:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH V2] scsi: libsas: Directly kick-off EH when ATA device
 fell off
Content-Language: en-CA
To:     John Garry <john.g.garry@oracle.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>, <hare@suse.com>, <hch@lst.de>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <prime.zeng@hisilicon.com>,
        <kangfenglong@huawei.com>
References: <20221216100327.7386-1-yangxingui@huawei.com>
 <565fcf28-ec53-8d74-00a3-94be8e5b60e4@oracle.com>
From:   yangxingui <yangxingui@huawei.com>
In-Reply-To: <565fcf28-ec53-8d74-00a3-94be8e5b60e4@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.101.126]
X-ClientProxiedBy: dggpemm500008.china.huawei.com (7.185.36.136) To
 dggpemm500012.china.huawei.com (7.185.36.89)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/12/19 17:23, John Garry wrote:
> On 16/12/2022 10:03, Xingui Yang wrote:
>> If the ATA device fell off, call sas_ata_device_link_abort() directly and
>> mark all outstanding QCs as failed and kick-off EH Immediately. This 
>> avoids
>> having to wait for block layer timeouts.
>>
>> Signed-off-by: Xingui Yang <yangxingui@huawei.com>
>> ---
>> Changes to v1:
>> - Use dev_is_sata() to check ATA device type
>>   drivers/scsi/libsas/sas_discover.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/scsi/libsas/sas_discover.c 
>> b/drivers/scsi/libsas/sas_discover.c
>> index d5bc1314c341..a12b65eb4a2a 100644
>> --- a/drivers/scsi/libsas/sas_discover.c
>> +++ b/drivers/scsi/libsas/sas_discover.c
>> @@ -362,6 +362,9 @@ static void sas_destruct_ports(struct asd_sas_port 
>> *port)
>>   void sas_unregister_dev(struct asd_sas_port *port, struct 
>> domain_device *dev)
>>   {
>> +    if (test_bit(SAS_DEV_GONE, &dev->state) && dev_is_sata(dev))
>> +        sas_ata_device_link_abort(dev, false);
> 
Hi, John
> Firstly, I think that there is a bug in sas_ata_device_link_abort() -> 
> ata_link_abort() code in that the host lock in not grabbed, as the 
> comment in ata_port_abort() mentions. Having said that, libsas had 
> already some dodgy host locking usage - specifically dropping the lock 
> for the queuing path (that's something else to be fixed up ... I think 
> that is due to queue command CB calling task_done() in some cases), but 
> I still think that sas_ata_device_link_abort() should be fixed (to grab 
> the host lock).
ok, I agree with you very much for this, I had doubts about whether we 
needed to grab lock before.
> 
> Secondly, this just seems like a half solution to the age-old problem - 
> that is, EH eventually kicking in only after 30 seconds when a disk is 
> removed with active IO. I say half solution as SAS disks still have this 
> issue for libsas. Can we instead push to try to solve both of them now?

Jason said you must have such an opinion "a half solution". As libsas 
does not have any interface to mark all outstanding commands as failed 
for SAS disk currently and SAS disk support I/O resumable transmission 
after intermittent disconnections, so I want to optimize sata disk first.
If we want to achieve a complete solution, perhaps we need to define 
such an interface in libsas and implement it by lldd. My current idea is 
to call sas_abort_task() for all outstanding commands in lldd. I wonder 
if you approve of this?

Thanks,
Xingui
> 
> There was a broad previous discussion on this:
> https://urldefense.com/v3/__https://lore.kernel.org/linux-scsi/Ykqg0kr0F*2Fyzk2XW@infradead.org/__;JQ!!ACWV5N9M2RV99hQ!MwAZFXXIwuP0lv-kuUIJ0ekUiGBWlTBhU3oQjyOf_yuP1rHDJb8UKMzJjndXNQ-W1PQGJXzgc0bQUsHh4NGh21EOc50$ 
> 
> 
>  From that discussion, Hannes was doing some related prep work series, 
> but I don't think it got completed.
> 
> Thanks,
> John
> 
>> +
>>       if (!test_bit(SAS_DEV_DESTROY, &dev->state) &&
>>           !list_empty(&dev->disco_list_node)) {
>>           /* this rphy never saw sas_rphy_add */
> 
> .
