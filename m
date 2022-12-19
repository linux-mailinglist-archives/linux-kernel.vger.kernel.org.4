Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD10F650E9C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 16:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbiLSP2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 10:28:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbiLSP2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 10:28:52 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C9A64E8;
        Mon, 19 Dec 2022 07:28:51 -0800 (PST)
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NbNm92fJczqSln;
        Mon, 19 Dec 2022 23:24:25 +0800 (CST)
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm500004.china.huawei.com (7.192.104.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 19 Dec 2022 23:28:47 +0800
Subject: Re: [PATCH V2] scsi: libsas: Directly kick-off EH when ATA device
 fell off
To:     John Garry <john.g.garry@oracle.com>,
        Xingui Yang <yangxingui@huawei.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>, <hare@suse.com>, <hch@lst.de>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <prime.zeng@hisilicon.com>,
        <kangfenglong@huawei.com>
References: <20221216100327.7386-1-yangxingui@huawei.com>
 <565fcf28-ec53-8d74-00a3-94be8e5b60e4@oracle.com>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <60ace19e-d029-f14d-9aac-d5cef83b5b64@huawei.com>
Date:   Mon, 19 Dec 2022 23:28:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <565fcf28-ec53-8d74-00a3-94be8e5b60e4@oracle.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.14]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500004.china.huawei.com (7.192.104.92)
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
> Firstly, I think that there is a bug in sas_ata_device_link_abort() -> 
> ata_link_abort() code in that the host lock in not grabbed, as the 
> comment in ata_port_abort() mentions. Having said that, libsas had 
> already some dodgy host locking usage - specifically dropping the lock 
> for the queuing path (that's something else to be fixed up ... I think 

Taking big locks in queuing path is not a good idea. This will bring 
down performance.


> that is due to queue command CB calling task_done() in some cases), but 
> I still think that sas_ata_device_link_abort() should be fixed (to grab 
> the host lock).

For sas_ata_device_link_abort(), it should grab ap->lock.

Thanks,
Jason
