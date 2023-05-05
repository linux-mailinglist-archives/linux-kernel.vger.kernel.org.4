Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736D06F7F8C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 11:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbjEEJGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 05:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbjEEJG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 05:06:28 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0964D19432;
        Fri,  5 May 2023 02:06:19 -0700 (PDT)
Received: from dggpemm500012.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QCPnx2bPjz18L2Y;
        Fri,  5 May 2023 17:02:13 +0800 (CST)
Received: from [10.67.101.126] (10.67.101.126) by
 dggpemm500012.china.huawei.com (7.185.36.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 5 May 2023 17:06:17 +0800
Message-ID: <02d36ee9-cdad-454d-d822-95442d7bd67b@huawei.com>
Date:   Fri, 5 May 2023 17:06:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v2] ata: libata-scsi: Fix get identity data failed
Content-Language: en-CA
To:     Damien Le Moal <dlemoal@kernel.org>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <john.g.garry@oracle.com>,
        <damien.lemoal@opensource.wdc.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <prime.zeng@hisilicon.com>,
        <kangfenglong@huawei.com>
References: <20230505025712.19438-1-yangxingui@huawei.com>
 <291f1d97-9195-45ac-8e12-058f5c797277@kernel.org>
From:   yangxingui <yangxingui@huawei.com>
In-Reply-To: <291f1d97-9195-45ac-8e12-058f5c797277@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.101.126]
X-ClientProxiedBy: dggpemm100017.china.huawei.com (7.185.36.220) To
 dggpemm500012.china.huawei.com (7.185.36.89)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/5 16:17, Damien Le Moal wrote:
> On 2023/05/05 11:57, Xingui Yang wrote:
>> The function ata_get_identity() uses the helper ata_scsi_find_dev() to get
>> the ata_device structure of a scsi device. However, when the ata device is
>> managed by libsas, ata_scsi_find_dev() returns NULL, turning
>> ata_get_identity() into a nop and always returns -ENOMSG.
> 
> What do you do to hit the issue ? A while back for me it was the queue depth
> setting causing problems. As Garry mentioned, this led to patch 141f3d6256e5
> ("ata: libata-sata: Fix device queue depth control").
Attempt to return the correct value at ata_scsi_find_dev() instead of 
NULL, when the ata device is managed by libsas?
> 
>>
>> Fix this by checking whether ATA_FLAG_SAS_HOST is set for ap->flags in
>> ata_scsi_find_dev(), as the flag is only used in libsas. If
>> ATA_FLAG_SAS_HOST is set, use sas_to_ata_dev() to find associated ATA
>> device.
>>
>> Signed-off-by: Xingui Yang <yangxingui@huawei.com>
>> ---
>> Changes to v1
>> - Let ata_scsi_find_dev() return the correct value and don't keep replacing
>> calls to ata_scsi_find_dev().
>>
>>   drivers/ata/libata-scsi.c | 12 ++++++++++--
>>   drivers/ata/libata.h      |  2 +-
>>   2 files changed, 11 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
>> index 7bb12deab70c..aa580ea341fa 100644
>> --- a/drivers/ata/libata-scsi.c
>> +++ b/drivers/ata/libata-scsi.c
>> @@ -26,6 +26,7 @@
>>   #include <scsi/scsi_device.h>
>>   #include <scsi/scsi_tcq.h>
>>   #include <scsi/scsi_transport.h>
>> +#include <scsi/libsas.h>
>>   #include <linux/libata.h>
>>   #include <linux/hdreg.h>
>>   #include <linux/uaccess.h>
>> @@ -2745,10 +2746,17 @@ static struct ata_device *__ata_scsi_find_dev(struct ata_port *ap,
>>    *	Associated ATA device, or %NULL if not found.
>>    */
>>   struct ata_device *
>> -ata_scsi_find_dev(struct ata_port *ap, const struct scsi_device *scsidev)
> 
> Why drop the const ?
If we use sdev_to_domain_dev(), there will be a compilation warning. But 
we can replace with scsidev->sdev_target->hostdata.
> 
>> +ata_scsi_find_dev(struct ata_port *ap, struct scsi_device *scsidev)
>>   {
>> -	struct ata_device *dev = __ata_scsi_find_dev(ap, scsidev);
>> +	struct ata_device *dev;
>> +
>> +	if (ap->flags & ATA_FLAG_SAS_HOST) {
>> +		struct domain_device *ddev = sdev_to_domain_dev(scsidev);
>> +
>> +		return sas_to_ata_dev(ddev);
> 
> Do you really need the ddev variable ? Also, this really should be a libsas
> helper. I beleive this pattern is repeated in several places in libsas, so that
> would nicely clean things up.
As above, we can replace with scsidev->sdev_target->hostdata.

Thanks,
Xingui
> 
>> +	}
>>   
>> +	dev = __ata_scsi_find_dev(ap, scsidev);
>>   	if (unlikely(!dev || !ata_dev_enabled(dev)))
>>   		return NULL;
>>   
>> diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
>> index 926d0d33cd29..6d66f46da064 100644
>> --- a/drivers/ata/libata.h
>> +++ b/drivers/ata/libata.h
>> @@ -109,7 +109,7 @@ static inline void ata_acpi_bind_dev(struct ata_device *dev) {}
>>   
>>   /* libata-scsi.c */
>>   extern struct ata_device *ata_scsi_find_dev(struct ata_port *ap,
>> -					    const struct scsi_device *scsidev);
>> +					    struct scsi_device *scsidev);
>>   extern int ata_scsi_add_hosts(struct ata_host *host,
>>   			      const struct scsi_host_template *sht);
>>   extern void ata_scsi_scan_host(struct ata_port *ap, int sync);
> 
