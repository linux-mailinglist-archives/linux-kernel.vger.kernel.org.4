Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAAF06EEBFC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 03:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239075AbjDZBlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 21:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238177AbjDZBlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 21:41:17 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87FABB21E;
        Tue, 25 Apr 2023 18:41:14 -0700 (PDT)
Received: from canpemm100004.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Q5hN40W2YzLnjb;
        Wed, 26 Apr 2023 09:38:28 +0800 (CST)
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm100004.china.huawei.com (7.192.105.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 26 Apr 2023 09:41:11 +0800
Subject: Re: [PATCH] scsi: libsas: set tf to normal in
 sas_ata_device_link_abort()
To:     yangxingui <yangxingui@huawei.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <john.g.garry@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <prime.zeng@hisilicon.com>,
        <kangfenglong@huawei.com>
References: <20230407035618.25123-1-yangxingui@huawei.com>
 <d00b38ce-99a8-208b-cdad-714bb3dbf60b@huawei.com>
 <d873df36-44d3-b98e-7e34-db6446292f32@huawei.com>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <1b39acd7-2028-a080-13be-660ed5c0bfb0@huawei.com>
Date:   Wed, 26 Apr 2023 09:41:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <d873df36-44d3-b98e-7e34-db6446292f32@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.14]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm100004.china.huawei.com (7.192.105.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/4/17 16:18, yangxingui wrote:
> Hi Jason
> 
> On 2023/4/14 15:36, Jason Yan wrote:
>> On 2023/4/7 11:56, Xingui Yang wrote:
>>> If the disk returns UNC for more than five times within a short 
>>> period, the
>>> number of retry times for other I/Os may reach scmd->allowed, and the
>>> default error "Illegal Request" is returned for other I/Os, as follows:
>>>
>>> [  273.801770] hisi_sas_v3_hw 0000:b4:02.0: erroneous completion disk 
>>> err dev id=2 sas_addr=0x5000000000000605 CQ hdr: 0x400903 0x20103 0x0 
>>> 0x80470000
>>> [  273.875286] sas: Enter sas_scsi_recover_host busy: 30 failed: 30
>>> [  273.879895] sas: trying to find task 0x00000000d9cfc893
>>> [  273.879896] sas: sas_scsi_find_task: aborting task 0x00000000d9cfc893
>>> [  273.880054] sas: sas_scsi_find_task: task 0x00000000d9cfc893 is done
>>> [  273.880055] sas: sas_eh_handle_sas_errors: task 0x00000000d9cfc893 
>>> is done
>>> [  273.880236] ata6.00: failed command: READ FPDMA QUEUED
>>> [  273.880238] ata6.00: cmd 60/08:00:59:27:00/00:00:00:00:00/40 tag 
>>> 22 ncq dma 4096 in
>>>                          res 41/04:00:20:00:00/00:00:00:00:00/00 
>>> Emask 0x1 (device error)
>>> [  273.880239] ata6.00: status: { DRDY ERR }
>>> [  273.880240] ata6.00: error: { ABRT }
>>> [  273.880241] ata6.00: failed command: READ FPDMA QUEUED
>>> [  273.880243] ata6.00: cmd 60/90:00:d1:26:00/00:00:00:00:00/40 tag 
>>> 23 ncq dma 73728 in
>>>                          res 41/40:90:10:27:00/00:00:00:00:00/00 
>>> Emask 0x409 (media error) <F>
>>> [  273.880245] ata6.00: status: { DRDY ERR }
>>> [  273.880246] ata6.00: error: { UNC }
>>> [  273.880247] ata6.00: failed command: READ FPDMA QUEUED
>>> [  273.880249] ata6.00: cmd 60/08:00:19:27:00/00:00:00:00:00/40 tag 
>>> 24 ncq dma 4096 in
>>>                          res 41/04:00:20:00:00/00:00:00:00:00/00 
>>> Emask 0x1 (device error)
>>> [  273.880250] ata6.00: status: { DRDY ERR }
>>> [  273.880251] ata6.00: error: { ABRT }
>>> [  274.199477] scmd->retries: 3, scmd->allowed: 5
>>> [  274.199478] scmd->retries: 3, scmd->allowed: 5
>>> [  274.199479] scmd->retries: 3, scmd->allowed: 5
>>> [  274.199481] scmd->retries: 3, scmd->allowed: 5
>>> [  274.199482] scmd->retries: 3, scmd->allowed: 5
>>> [  274.199483] scmd->retries: 2, scmd->allowed: 5
>>> [  274.199484] scmd->retries: 3, scmd->allowed: 5
>>> [  274.199485] scmd->retries: 3, scmd->allowed: 5
>>> [  274.199486] scmd->retries: 5, scmd->allowed: 5
>>> [  274.199487] scmd->retries: 2, scmd->allowed: 5
>>> [  274.199488] scmd->retries: 2, scmd->allowed: 5
>>> [  274.199524] sd 6:0:1:0: [sdb] tag#258 FAILED Result: 
>>> hostbyte=DID_OK driverbyte=DRIVER_SENSE
>>> [  274.199527] sd 6:0:1:0: [sdb] tag#258 Sense Key : Illegal Request 
>>> [current]
>>> [  274.199530] sd 6:0:1:0: [sdb] tag#258 Add. Sense: Unaligned write 
>>> command
>>> [  274.199532] sd 6:0:1:0: [sdb] tag#258 CDB: Read(10) 28 00 00 00 27 
>>> 59 00 00 08 00
>>> [  274.199535] print_req_error: I/O error, dev sdb, sector 10073
>>> [  274.199573] sd 6:0:1:0: [sdb] tag#259 FAILED Result: 
>>> hostbyte=DID_OK driverbyte=DRIVER_SENSE
>>> [  274.199574] sd 6:0:1:0: [sdb] tag#259 Sense Key : Medium Error 
>>> [current]
>>> [  274.199576] sd 6:0:1:0: [sdb] tag#259 Add. Sense: Unrecovered read 
>>> error - auto reallocate failed
>>> [  274.199578] sd 6:0:1:0: [sdb] tag#259 CDB: Read(10) 28 00 00 00 26 
>>> d1 00 00 90 00
>>> [  274.199579] print_req_error: I/O error, dev sdb, sector 10000
>>> [  274.199608] ata6: EH complete
>>> [  274.199615] sas: --- Exit sas_scsi_recover_host: busy: 0 failed: 
>>> 30 tries: 1
>>>
>>> As mentioned in ata_eh_qc_retry(), if qc->err_mask is zero then 
>>> increment
>>> scmd->allowed. So set tf to normal may be better.
>>
>> Hi Xingui,
>>
>> If we increase scmd->allowed every time, and the device returns UNC 
>> for too many times, will the other IO pending for too long and cause 
>> hungtask? And also the runtime check in scsi_cmd_runtime_exceeced() 
>> will not trigger since cmd->allowed is extended.
>>
> Thank you for your reply. In scenarios similar to UNC error, where a 
> disk returns an error through D2H or SDB, no error is reported for other 
> I/Os in the disk. In this case, AHCI will increase the number of retry 
> times for other I/Os, and AHCI may face similar problems you say, but 
> default failures may not be very good for users.

I think at least we cannot always retry unconditionally. Failure is 
better than hung becuase users can deal with failures. They can retry 
from the userspace. But if the process stuck in kernel, it is a disaster 
for the userspace and they can do nothing. Is there a way to limit the 
times of retry?

Thanks,
Jason

> 
> In addition, for commands with pass through type, other I/Os are 
> immediately returned with default errors and are not retried, but AHCI 
> only report one single error I/O.
> 
> Thanks,
> Xingui
> 
>> Thanks,
>> Jason
>>
>>>
>>> Signed-off-by: Xingui Yang <yangxingui@huawei.com>
>>> ---
>>>   drivers/scsi/libsas/sas_ata.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/scsi/libsas/sas_ata.c 
>>> b/drivers/scsi/libsas/sas_ata.c
>>> index 77714a495cbb..f5047e8dcb59 100644
>>> --- a/drivers/scsi/libsas/sas_ata.c
>>> +++ b/drivers/scsi/libsas/sas_ata.c
>>> @@ -949,8 +949,8 @@ void sas_ata_device_link_abort(struct 
>>> domain_device *device, bool force_reset)
>>>       unsigned long flags;
>>>       spin_lock_irqsave(ap->lock, flags);
>>> -    device->sata_dev.fis[2] = ATA_ERR | ATA_DRDY; /* tf status */
>>> -    device->sata_dev.fis[3] = ATA_ABORTED; /* tf error */
>>> +    device->sata_dev.fis[2] = ATA_DRDY; /* tf status */
>>> +    device->sata_dev.fis[3] = 0;        /* tf error */
>>>       link->eh_info.err_mask |= AC_ERR_DEV;
>>>       if (force_reset)
>>>
>> .
> .
