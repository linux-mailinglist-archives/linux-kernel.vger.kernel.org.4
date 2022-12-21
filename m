Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322E0652B1A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 02:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbiLUBr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 20:47:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiLUBr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 20:47:26 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F101A38B;
        Tue, 20 Dec 2022 17:47:25 -0800 (PST)
Received: from dggpemm500012.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NcGWM3ZFhzJqbJ;
        Wed, 21 Dec 2022 09:46:23 +0800 (CST)
Received: from [10.67.101.126] (10.67.101.126) by
 dggpemm500012.china.huawei.com (7.185.36.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 21 Dec 2022 09:47:23 +0800
Message-ID: <6e2f1142-c14b-0277-0c5e-fda26235794c@huawei.com>
Date:   Wed, 21 Dec 2022 09:47:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] scsi: libsas: Grab the host lock in
 sas_ata_device_link_abort()
Content-Language: en-CA
To:     John Garry <john.g.garry@oracle.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <niklas.cassel@wdc.com>,
        <damien.lemoal@opensource.wdc.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <prime.zeng@hisilicon.com>,
        <kangfenglong@huawei.com>
References: <20221220125349.45091-1-yangxingui@huawei.com>
 <4ec9dbed-1758-d6b4-dc1d-ac42e8c22731@oracle.com>
From:   yangxingui <yangxingui@huawei.com>
In-Reply-To: <4ec9dbed-1758-d6b4-dc1d-ac42e8c22731@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.101.126]
X-ClientProxiedBy: dggpemm500011.china.huawei.com (7.185.36.110) To
 dggpemm500012.china.huawei.com (7.185.36.89)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/12/20 22:59, John Garry wrote:
> On 20/12/2022 12:53, Xingui Yang wrote:
>> Grab the host lock in sas_ata_device_link_abort() before calling
> 
> This is should be the ata port lock, right? I know that the ata comments 
> say differently.
ok, I will update the commit message and use ata port lock instead.
> 
>> ata_link_abort(), as the comment in ata_link_abort() mentions.
>>
> 
> Can you please add a fixes tag?
ok, I will update and add a fix tag.

Thanks,
Xingui
> 
>> Signed-off-by: Xingui Yang <yangxingui@huawei.com>
> 
> Reviewed-by: John Garry <john.g.garry@oracle.com>
> 
>> ---
>>   drivers/scsi/libsas/sas_ata.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/scsi/libsas/sas_ata.c 
>> b/drivers/scsi/libsas/sas_ata.c
>> index f7439bf9cdc6..4f2017b21e6d 100644
>> --- a/drivers/scsi/libsas/sas_ata.c
>> +++ b/drivers/scsi/libsas/sas_ata.c
>> @@ -889,7 +889,9 @@ void sas_ata_device_link_abort(struct 
>> domain_device *device, bool force_reset)
>>   {
>>       struct ata_port *ap = device->sata_dev.ap;
>>       struct ata_link *link = &ap->link;
>> +    unsigned long flags;
>> +    spin_lock_irqsave(ap->lock, flags);
>>       device->sata_dev.fis[2] = ATA_ERR | ATA_DRDY; /* tf status */
>>       device->sata_dev.fis[3] = ATA_ABORTED; /* tf error */
>> @@ -897,6 +899,7 @@ void sas_ata_device_link_abort(struct 
>> domain_device *device, bool force_reset)
>>       if (force_reset)
>>           link->eh_info.action |= ATA_EH_RESET;
>>       ata_link_abort(link);
>> +    spin_unlock_irqrestore(ap->lock, flags);
>>   }
>>   EXPORT_SYMBOL_GPL(sas_ata_device_link_abort);
> 
> .
