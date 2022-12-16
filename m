Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33EF164E7F5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 08:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiLPHzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 02:55:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiLPHzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 02:55:31 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A5F220E8;
        Thu, 15 Dec 2022 23:55:30 -0800 (PST)
Received: from dggpemm500012.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NYLwS1fhdzJqYT;
        Fri, 16 Dec 2022 15:54:32 +0800 (CST)
Received: from [10.67.101.126] (10.67.101.126) by
 dggpemm500012.china.huawei.com (7.185.36.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 16 Dec 2022 15:55:28 +0800
Message-ID: <0f87f968-eb63-6b32-cfe7-b5d399a7d541@huawei.com>
Date:   Fri, 16 Dec 2022 15:55:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] scsi: libsas: Directly kick-off EH when ATA device fell
 off
Content-Language: en-CA
To:     Jason Yan <yanaijie@huawei.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <john.g.garry@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <prime.zeng@hisilicon.com>,
        <kangfenglong@huawei.com>
References: <20221216032936.17841-1-yangxingui@huawei.com>
 <5dd4740a-0301-d195-a368-462010da7927@huawei.com>
From:   yangxingui <yangxingui@huawei.com>
In-Reply-To: <5dd4740a-0301-d195-a368-462010da7927@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.101.126]
X-ClientProxiedBy: dggpemm500023.china.huawei.com (7.185.36.83) To
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



On 2022/12/16 11:53, Jason Yan wrote:
> Hi Xingui,
> 
> On 2022/12/16 11:29, Xingui Yang wrote:
>> If the ATA device fell off, call sas_ata_device_link_abort() directly and
>> mark all outstanding QCs as failed and kick-off EH Immediately. This 
>> avoids
>> having to wait for block layer timeouts.
>>
> 
> Why does ATA device need this special operation? SAS device does not 
> have to wait for block layer timeouts?
Hi Jason,
Applications that depend on I/O return may be blocked for 30 seconds, 
and this can be optimized for SATA disks.

Different from SATA disks, I/Os on SAS disks can still be returned if 
they are quickly plugged in after the SAS disks fall off. So I'm not 
sure if this is appropriate for a sas disk.
BTW, I wish the sas disk did the same.

Thanks,
Xingui
> 
> Thanks,
> Jason
> 
>> Signed-off-by: Xingui Yang <yangxingui@huawei.com>
>> ---
>>   drivers/scsi/libsas/sas_discover.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/scsi/libsas/sas_discover.c 
>> b/drivers/scsi/libsas/sas_discover.c
>> index d5bc1314c341..bd22741daa99 100644
>> --- a/drivers/scsi/libsas/sas_discover.c
>> +++ b/drivers/scsi/libsas/sas_discover.c
>> @@ -362,6 +362,11 @@ static void sas_destruct_ports(struct 
>> asd_sas_port *port)
>>   void sas_unregister_dev(struct asd_sas_port *port, struct 
>> domain_device *dev)
>>   {
>> +    if (test_bit(SAS_DEV_GONE, &dev->state) &&
>> +        (dev->dev_type == SAS_SATA_DEV ||
>> +        (dev->tproto & SAS_PROTOCOL_STP)))
>> +        sas_ata_device_link_abort(dev, false);
>> +
>>       if (!test_bit(SAS_DEV_DESTROY, &dev->state) &&
>>           !list_empty(&dev->disco_list_node)) {
>>           /* this rphy never saw sas_rphy_add */
>>
> .
