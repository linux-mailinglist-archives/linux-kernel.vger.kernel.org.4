Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D39145EEFA8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 09:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235019AbiI2Htc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 03:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235379AbiI2Ht0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 03:49:26 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BCC13A956;
        Thu, 29 Sep 2022 00:49:20 -0700 (PDT)
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MdQVG5gGkz6HJTS;
        Thu, 29 Sep 2022 15:49:10 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 29 Sep 2022 09:49:17 +0200
Received: from [10.126.170.84] (10.126.170.84) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 29 Sep 2022 08:49:17 +0100
Message-ID: <e4aa7b2b-3fab-14f9-8af5-8b4c37afb13f@huawei.com>
Date:   Thu, 29 Sep 2022 08:49:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
From:   John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 6/6] scsi: mvsas: Use sas_task_find_rq() for tagging
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <jinpu.wang@cloud.ionos.com>, <damien.lemoal@wdc.com>
CC:     <hare@suse.de>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <ipylypiv@google.com>, <changyuanl@google.com>, <hch@lst.de>
References: <1664368034-114991-1-git-send-email-john.garry@huawei.com>
 <1664368034-114991-7-git-send-email-john.garry@huawei.com>
 <53e304b4-c025-e884-c8f5-6c2e96cc0052@opensource.wdc.com>
In-Reply-To: <53e304b4-c025-e884-c8f5-6c2e96cc0052@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.170.84]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/09/2022 03:22, Damien Le Moal wrote:
> On 9/28/22 21:27, John Garry wrote:
>> The request associated with a scsi command coming from the block layer
>> has a unique tag, so use that when possible for getting a slot.
>>
>> Unfortunately we don't support reserved commands in the SCSI midlayer yet.
>> As such, SMP tasks - as an example - will not have a request associated, so
>> in the interim continue to manage those tags for that type of sas_task
>> internally.
>>
>> We reserve an arbitrary 4 tags for these internal tags. Indeed, we already
>> decrement MVS_RSVD_SLOTS by 2 for the shost can_queue when flag
>> MVF_FLAG_SOC is set. This change was made in commit 20b09c2992fef
>> ("[PATCH] [SCSI] mvsas: add support for 94xx; layout change; bug fixes"),
>> but what those 2 slots are used for is not obvious.
>>
>> Signed-off-by: John Garry <john.garry@huawei.com>
>> ---
>>   drivers/scsi/mvsas/mv_defs.h |  1 +
>>   drivers/scsi/mvsas/mv_init.c |  4 ++--
>>   drivers/scsi/mvsas/mv_sas.c  | 22 +++++++++++++++++-----
>>   drivers/scsi/mvsas/mv_sas.h  |  1 -
>>   4 files changed, 20 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/scsi/mvsas/mv_defs.h b/drivers/scsi/mvsas/mv_defs.h
>> index 7123a2efbf58..8ef174cd4d37 100644
>> --- a/drivers/scsi/mvsas/mv_defs.h
>> +++ b/drivers/scsi/mvsas/mv_defs.h
>> @@ -40,6 +40,7 @@ enum driver_configuration {
>>   	MVS_ATA_CMD_SZ		= 96,	/* SATA command table buffer size */
>>   	MVS_OAF_SZ		= 64,	/* Open address frame buffer size */
>>   	MVS_QUEUE_SIZE		= 64,	/* Support Queue depth */
>> +	MVS_RSVD_SLOTS		= 4,
>>   	MVS_SOC_CAN_QUEUE	= MVS_SOC_SLOTS - 2,
>>   };
>>   
>> diff --git a/drivers/scsi/mvsas/mv_init.c b/drivers/scsi/mvsas/mv_init.c
>> index c85fb812ad43..d834ed9e8e4a 100644
>> --- a/drivers/scsi/mvsas/mv_init.c
>> +++ b/drivers/scsi/mvsas/mv_init.c
>> @@ -284,7 +284,7 @@ static int mvs_alloc(struct mvs_info *mvi, struct Scsi_Host *shost)
>>   			printk(KERN_DEBUG "failed to create dma pool %s.\n", pool_name);
>>   			goto err_out;
>>   	}
>> -	mvi->tags_num = slot_nr;
>> +	mvi->tags_num = MVS_RSVD_SLOTS;
> 
> Same comment as for pm8001: do you really need this field if the value
> is always MVS_RSVD_SLOTS ?

Right, I don't need this struct member. Again I can just use this macro 
directly.

> 
>>   
>>   	return 0;
>>   err_out:
>> @@ -367,7 +367,7 @@ static struct mvs_info *mvs_pci_alloc(struct pci_dev *pdev,
>>   	mvi->sas = sha;
>>   	mvi->shost = shost;
>>   
>> -	mvi->tags = kzalloc(MVS_CHIP_SLOT_SZ>>3, GFP_KERNEL);
>> +	mvi->tags = kzalloc(MVS_RSVD_SLOTS, GFP_KERNEL);
> 
> Field name ? reserved_tags ?
> Also, the alloc seems wrong. This will allocate 4 bytes, but you only
> need 4 bits. You could make this an unsigned long and not allocate
> anything. 

Well spotted. I should have questioned more why they had >>3 previously.

But I would rather keep as a bitmap, i.e. *unsigned long for simplicity.

> Same remark for pm8001 by the way.

I think it's ok as it uses bitmap_zalloc()

> 
> That would cap MVS_RSVD_SLOTS to BITS_PER_LONG maximum, but that is easy
> to check at compile time with a #if/#error.
> 

As above, I'd rather keep as a bitmap. It's a little inefficient, but is 
a one off in the driver.

Thanks,
John


