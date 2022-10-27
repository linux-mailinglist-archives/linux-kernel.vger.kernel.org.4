Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC0A60F424
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 11:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234367AbiJ0J5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 05:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235157AbiJ0J4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 05:56:41 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17324E22F9;
        Thu, 27 Oct 2022 02:56:10 -0700 (PDT)
Received: from frapeml500008.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Mygy925qrz67M1h;
        Thu, 27 Oct 2022 17:54:41 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 27 Oct 2022 11:56:08 +0200
Received: from [10.195.32.169] (10.195.32.169) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 27 Oct 2022 10:56:07 +0100
Message-ID: <83d9dc82-ea37-4a3c-7e67-1c097f777767@huawei.com>
Date:   Thu, 27 Oct 2022 10:56:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH RFC v3 2/7] ata: libata-scsi: Add
 ata_internal_queuecommand()
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>, <hare@suse.de>,
        <bvanassche@acm.org>, <hch@lst.de>, <ming.lei@redhat.com>,
        <niklas.cassel@wdc.com>
CC:     <axboe@kernel.dk>, <jinpu.wang@cloud.ionos.com>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-ide@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linuxarm@huawei.com>
References: <1666693976-181094-1-git-send-email-john.garry@huawei.com>
 <1666693976-181094-3-git-send-email-john.garry@huawei.com>
 <08fdb698-0df3-7bc8-e6af-7d13cc96acfa@opensource.wdc.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <08fdb698-0df3-7bc8-e6af-7d13cc96acfa@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.195.32.169]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/10/2022 02:45, Damien Le Moal wrote:
> On 10/25/22 19:32, John Garry wrote:
>> Add callback to queue reserved commands - call it "internal" as this is
>> what libata uses.
>>
>> Also add it to the base ATA SHT.
>>
>> Signed-off-by: John Garry <john.garry@huawei.com>
>> ---
>>   drivers/ata/libata-scsi.c | 14 ++++++++++++++
>>   include/linux/libata.h    |  5 ++++-
>>   2 files changed, 18 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
>> index 30d7c90b0c35..0d6f37d80137 100644
>> --- a/drivers/ata/libata-scsi.c
>> +++ b/drivers/ata/libata-scsi.c
>> @@ -1118,6 +1118,20 @@ int ata_scsi_dev_config(struct scsi_device *sdev, struct ata_device *dev)
>>   	return 0;
>>   }
>>   
>> +int ata_internal_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *scmd)
>> +{
>> +	struct ata_port *ap;
>> +	int res;
>> +
>> +	ap = ata_shost_to_port(shost);
> 
> You can have this initialization together with the ap declaration.
> 
>> +	spin_lock_irq(ap->lock);
>> +	res = ata_sas_queuecmd(scmd, ap);
>> +	spin_unlock_irq(ap->lock);
>> +
>> +	return res;
>> +}
>> +EXPORT_SYMBOL_GPL(ata_internal_queuecommand);
> 
> I am officially lost here. Do not see why this function is needed...

The general idea in this series is to send ATA internal commands as 
requests. And this function is used as the SCSI midlayer to queue 
reserved commands. See how it is plugged into __ATA_BASE_SHT, below.

So we have this overall flow:

ata_exec_internal_sg():
  -> alloc request
  -> blk_execute_rq_nowait()
      ... -> scsi_queue_rq()
		-> sht->reserved_queuecommd()
			-> ata_internal_queuecommand()

And then we have ata_internal_queuecommand() -> ata_sas_queuecmd() -> 
ata_scsi_queue_internal() -> ata_qc_issue().

Hope it makes sense.

Thanks,
John

> 
>> +
>>   /**
>>    *	ata_scsi_slave_config - Set SCSI device attributes
>>    *	@sdev: SCSI device to examine
>> diff --git a/include/linux/libata.h b/include/linux/libata.h
>> index 8938b584520f..f09c5dca16ce 100644
>> --- a/include/linux/libata.h
>> +++ b/include/linux/libata.h
>> @@ -1141,6 +1141,8 @@ extern int ata_std_bios_param(struct scsi_device *sdev,
>>   			      sector_t capacity, int geom[]);
>>   extern void ata_scsi_unlock_native_capacity(struct scsi_device *sdev);
>>   extern int ata_scsi_slave_config(struct scsi_device *sdev);
>> +extern int ata_internal_queuecommand(struct Scsi_Host *shost,
>> +				struct scsi_cmnd *scmd);
>>   extern void ata_scsi_slave_destroy(struct scsi_device *sdev);
>>   extern int ata_scsi_change_queue_depth(struct scsi_device *sdev,
>>   				       int queue_depth);
>> @@ -1391,7 +1393,8 @@ extern const struct attribute_group *ata_common_sdev_groups[];
>>   	.slave_destroy		= ata_scsi_slave_destroy,	\
>>   	.bios_param		= ata_std_bios_param,		\
>>   	.unlock_native_capacity	= ata_scsi_unlock_native_capacity,\
>> -	.max_sectors		= ATA_MAX_SECTORS_LBA48
>> +	.max_sectors		= ATA_MAX_SECTORS_LBA48,\
>> +	.reserved_queuecommand = ata_internal_queuecommand
>>   
>>   #define ATA_SUBBASE_SHT(drv_name)				\
>>   	__ATA_BASE_SHT(drv_name),				\
> 

