Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1DC764E8EC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 10:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbiLPJxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 04:53:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbiLPJxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 04:53:22 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA2B4A59C;
        Fri, 16 Dec 2022 01:53:21 -0800 (PST)
Received: from dggpemm500012.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NYPTG4BSXzJpMx;
        Fri, 16 Dec 2022 17:49:38 +0800 (CST)
Received: from [10.67.101.126] (10.67.101.126) by
 dggpemm500012.china.huawei.com (7.185.36.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 16 Dec 2022 17:53:18 +0800
Message-ID: <ddc08902-cbf1-52c3-e7b0-8c130d4bf58c@huawei.com>
Date:   Fri, 16 Dec 2022 17:53:18 +0800
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
 <e717fe34-4448-ab78-7208-71fb1679114e@huawei.com>
From:   yangxingui <yangxingui@huawei.com>
In-Reply-To: <e717fe34-4448-ab78-7208-71fb1679114e@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.101.126]
X-ClientProxiedBy: dggpemm500008.china.huawei.com (7.185.36.136) To
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



On 2022/12/16 17:29, Jason Yan wrote:
> On 2022/12/16 11:29, Xingui Yang wrote:
>> If the ATA device fell off, call sas_ata_device_link_abort() directly and
>> mark all outstanding QCs as failed and kick-off EH Immediately. This 
>> avoids
>> having to wait for block layer timeouts.
>>
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
> 
> dev_is_sata() would be better here.

ok, Thanks for your advice.

Thanks,
Xingui
> 
> Thanks,
> Jason
> 
>> +        sas_ata_device_link_abort(dev, false);
>> +
>>       if (!test_bit(SAS_DEV_DESTROY, &dev->state) &&
>>           !list_empty(&dev->disco_list_node)) {
>>           /* this rphy never saw sas_rphy_add */
>>
> .
