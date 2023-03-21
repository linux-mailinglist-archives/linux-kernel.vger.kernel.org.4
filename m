Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 088BA6C3342
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 14:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbjCUNsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 09:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbjCUNsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 09:48:42 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66D93D927;
        Tue, 21 Mar 2023 06:48:24 -0700 (PDT)
Received: from dggpemm500012.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PgtDD73D6zKs3R;
        Tue, 21 Mar 2023 21:46:04 +0800 (CST)
Received: from [10.67.101.126] (10.67.101.126) by
 dggpemm500012.china.huawei.com (7.185.36.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 21 Mar 2023 21:48:21 +0800
Message-ID: <b1524366-0e32-adb2-e7ef-fd0de5ef473c@huawei.com>
Date:   Tue, 21 Mar 2023 21:48:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH RESEND] scsi: libsas: Add end eh callback
Content-Language: en-CA
To:     John Garry <john.g.garry@oracle.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <prime.zeng@hisilicon.com>,
        <kangfenglong@huawei.com>, <chenxiang66@hisilicon.com>
References: <20230321073959.736-1-yangxingui@huawei.com>
 <4d9606b2-374c-8a76-05c4-7bd861b3b8bc@oracle.com>
From:   yangxingui <yangxingui@huawei.com>
In-Reply-To: <4d9606b2-374c-8a76-05c4-7bd861b3b8bc@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.101.126]
X-ClientProxiedBy: dggpemm500012.china.huawei.com (7.185.36.89) To
 dggpemm500012.china.huawei.com (7.185.36.89)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On 2023/3/21 17:31, John Garry wrote:
> On 21/03/2023 07:39, Xingui Yang wrote:
>> If an error occurs while the disk is processing an NCQ command and the 
>> host
>> received the abnormal SDB FIS, let libata EH to analyze the NCQ error, 
>> and
>> it is not necessary to reset the target to recover.
>>
>> Then the hisi_sas has some special process to set dev_status to normal 
>> when
>> end the eh for NCQ error without reset the target, so add a callback and
>> fill it in for the hisi_sas driver.
> 
> What is so special about this driver such that it is the only one to get 
> this treatment? We generally don't just add callbacks for specific 
> driver usage, i.e. you need to make it generic.
Yes, I agree very much. it may be a common requirement for the lldd 
performs a specific state restoration after eh complete. such as, we set 
the device state to normal instead of doing it in the target reset 
function.
> 
> I would need to refresh my memory on the ATA EH handling to review this 
> further, which I will do when I get a chance.
Thanks
Xingui
> 
>>
>> Signed-off-by: Xingui Yang <yangxingui@huawei.com>
>> ---
>>   drivers/scsi/hisi_sas/hisi_sas_main.c  | 12 +++++++++---
>>   drivers/scsi/hisi_sas/hisi_sas_v3_hw.c |  7 +++++--
>>   drivers/scsi/libsas/sas_ata.c          |  5 +++++
>>   include/scsi/libsas.h                  |  2 ++
>>   4 files changed, 21 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c 
>> b/drivers/scsi/hisi_sas/hisi_sas_main.c
>> index 325d6d6a21c3..61686ead0027 100644
>> --- a/drivers/scsi/hisi_sas/hisi_sas_main.c
>> +++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
>> @@ -1777,9 +1777,6 @@ static int hisi_sas_I_T_nexus_reset(struct 
>> domain_device *device)
>>       struct device *dev = hisi_hba->dev;
>>       int rc;
>> -    if (sas_dev->dev_status == HISI_SAS_DEV_NCQ_ERR)
>> -        sas_dev->dev_status = HISI_SAS_DEV_NORMAL;
>> -
>>       rc = hisi_sas_internal_task_abort_dev(sas_dev, false);
>>       if (rc < 0) {
>>           dev_err(dev, "I_T nexus reset: internal abort (%d)\n", rc);
>> @@ -1967,6 +1964,14 @@ static bool 
>> hisi_sas_internal_abort_timeout(struct sas_task *task,
>>       return false;
>>   }
>> +static void hisi_sas_end_eh(struct domain_device *dev)
>> +{
>> +    struct hisi_sas_device *sas_dev = dev->lldd_dev;
>> +
>> +    if (sas_dev->dev_status == HISI_SAS_DEV_NCQ_ERR)
>> +        sas_dev->dev_status = HISI_SAS_DEV_NORMAL;
>> +}
>> +
>>   static void hisi_sas_port_formed(struct asd_sas_phy *sas_phy)
>>   {
>>       hisi_sas_port_notify_formed(sas_phy);
>> @@ -2083,6 +2088,7 @@ static struct sas_domain_function_template 
>> hisi_sas_transport_ops = {
>>       .lldd_write_gpio    = hisi_sas_write_gpio,
>>       .lldd_tmf_aborted    = hisi_sas_tmf_aborted,
>>       .lldd_abort_timeout    = hisi_sas_internal_abort_timeout,
>> +    .lldd_end_eh        = hisi_sas_end_eh,
>>   };
>>   void hisi_sas_init_mem(struct hisi_hba *hisi_hba)
>> diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c 
>> b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
>> index 66fcb340b98e..abad57de4aee 100644
>> --- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
>> +++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
>> @@ -2433,15 +2433,18 @@ static int complete_v3_hw(struct hisi_sas_cq *cq)
>>               struct hisi_sas_device *sas_dev =
>>                   &hisi_hba->devices[device_id];
>>               struct domain_device *device = sas_dev->sas_device;
>> +            bool force_reset = true;
>>               dev_err(dev, "erroneous completion disk err dev id=%d 
>> sas_addr=0x%llx CQ hdr: 0x%x 0x%x 0x%x 0x%x\n",
>>                   device_id, itct->sas_addr, dw0, dw1,
>>                   complete_hdr->act, dw3);
>> -            if (is_ncq_err_v3_hw(complete_hdr))
>> +            if (is_ncq_err_v3_hw(complete_hdr)) {
>>                   sas_dev->dev_status = HISI_SAS_DEV_NCQ_ERR;
>> +                force_reset = false;
>> +            }
>> -            sas_ata_device_link_abort(device, true);
>> +            sas_ata_device_link_abort(device, force_reset);
>>           } else if (likely(iptt < HISI_SAS_COMMAND_ENTRIES_V3_HW)) {
>>               slot = &hisi_hba->slot_info[iptt];
>>               slot->cmplt_queue_slot = rd_point;
>> diff --git a/drivers/scsi/libsas/sas_ata.c 
>> b/drivers/scsi/libsas/sas_ata.c
>> index 77714a495cbb..25a064087311 100644
>> --- a/drivers/scsi/libsas/sas_ata.c
>> +++ b/drivers/scsi/libsas/sas_ata.c
>> @@ -534,11 +534,16 @@ void sas_ata_end_eh(struct ata_port *ap)
>>   {
>>       struct domain_device *dev = ap->private_data;
>>       struct sas_ha_struct *ha = dev->port->ha;
>> +    struct sas_internal *i = dev_to_sas_internal(dev);
>>       unsigned long flags;
>>       spin_lock_irqsave(&ha->lock, flags);
>>       if (test_and_clear_bit(SAS_DEV_EH_PENDING, &dev->state))
>>           ha->eh_active--;
>> +
>> +    if (i->dft->lldd_end_eh)
>> +        i->dft->lldd_end_eh(dev);
>> +
>>       spin_unlock_irqrestore(&ha->lock, flags);
>>   }
>> diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
>> index 159823e0afbf..659395ef616e 100644
>> --- a/include/scsi/libsas.h
>> +++ b/include/scsi/libsas.h
>> @@ -683,6 +683,8 @@ struct sas_domain_function_template {
>>       int (*lldd_lu_reset)(struct domain_device *, u8 *lun);
>>       int (*lldd_query_task)(struct sas_task *);
>> +    void (*lldd_end_eh)(struct domain_device *dev);
>> +
>>       /* Special TMF callbacks */
>>       void (*lldd_tmf_exec_complete)(struct domain_device *dev);
>>       void (*lldd_tmf_aborted)(struct sas_task *task);
> 
> 
> .
