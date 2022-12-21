Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FED4652CE8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 07:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234210AbiLUGfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 01:35:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233763AbiLUGfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 01:35:16 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DADD1DF30;
        Tue, 20 Dec 2022 22:35:11 -0800 (PST)
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NcNvP30bFzJqVh;
        Wed, 21 Dec 2022 14:34:09 +0800 (CST)
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm500004.china.huawei.com (7.192.104.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 21 Dec 2022 14:35:09 +0800
Subject: Re: [PATCH] scsi: libsas: Grab the host lock in
 sas_ata_device_link_abort()
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        John Garry <john.g.garry@oracle.com>,
        Xingui Yang <yangxingui@huawei.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <niklas.cassel@wdc.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <prime.zeng@hisilicon.com>,
        <kangfenglong@huawei.com>
References: <20221220125349.45091-1-yangxingui@huawei.com>
 <4ec9dbed-1758-d6b4-dc1d-ac42e8c22731@oracle.com>
 <c8387766-2ca0-51f3-e332-71492b13e5c1@opensource.wdc.com>
 <7347d117-6e0b-dd18-90a8-25685f757689@huawei.com>
 <4ff0ca00-31f5-2867-ff59-cecb5d6d1048@opensource.wdc.com>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <755d7a9c-427e-024a-8509-449ebc5a00e6@huawei.com>
Date:   Wed, 21 Dec 2022 14:35:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <4ff0ca00-31f5-2867-ff59-cecb5d6d1048@opensource.wdc.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.14]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500004.china.huawei.com (7.192.104.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/21 11:59, Damien Le Moal wrote:
> On 2022/12/21 11:42, Jason Yan wrote:
>> On 2022/12/21 8:36, Damien Le Moal wrote:
>>> On 2022/12/20 23:59, John Garry wrote:
>>>> On 20/12/2022 12:53, Xingui Yang wrote:
>>>>> Grab the host lock in sas_ata_device_link_abort() before calling
>>>>
>>>> This is should be the ata port lock, right? I know that the ata comments
>>>> say differently.
>>>>
>>>>> ata_link_abort(), as the comment in ata_link_abort() mentions.
>>>>>
>>>>
>>>> Can you please add a fixes tag?
>>>>
>>>>> Signed-off-by: Xingui Yang <yangxingui@huawei.com>
>>>>
>>>> Reviewed-by: John Garry <john.g.garry@oracle.com>
>>>>
>>>>> ---
>>>>>     drivers/scsi/libsas/sas_ata.c | 3 +++
>>>>>     1 file changed, 3 insertions(+)
>>>>>
>>>>> diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
>>>>> index f7439bf9cdc6..4f2017b21e6d 100644
>>>>> --- a/drivers/scsi/libsas/sas_ata.c
>>>>> +++ b/drivers/scsi/libsas/sas_ata.c
>>>>> @@ -889,7 +889,9 @@ void sas_ata_device_link_abort(struct domain_device *device, bool force_reset)
>>>>>     {
>>>>>     	struct ata_port *ap = device->sata_dev.ap;
>>>>>     	struct ata_link *link = &ap->link;
>>>>> +	unsigned long flags;
>>>>>     
>>>>> +	spin_lock_irqsave(ap->lock, flags);
>>>>>     	device->sata_dev.fis[2] = ATA_ERR | ATA_DRDY; /* tf status */
>>>>>     	device->sata_dev.fis[3] = ATA_ABORTED; /* tf error */
>>>>>     
>>>>> @@ -897,6 +899,7 @@ void sas_ata_device_link_abort(struct domain_device *device, bool force_reset)
>>>>>     	if (force_reset)
>>>>>     		link->eh_info.action |= ATA_EH_RESET;
>>>>>     	ata_link_abort(link);
>>>
>>> Really need to add lockdep annotations in libata to avoid/catch such bugs...
>>> Will work on that.
>>
>> Actually in libata there are many places calling ata_link_abort() not
>> holding port lock. And some places are holding the real host
>> lock(ata_host->lock) while calling ata_link_abort(). So if you add the
>> lockdep annotations, there may be too many warnings. If these are real
>> issues, we should fix them first.
> 
> libata-EH does most of its work without the port lock held because by the time
> we get EH started, we are guaranteed to be idle with no commands in flight. That
> is why the calls you mention look like "bugs" but are not.

What about the interrupt handler such as ahci_error_intr()? I didn't see 
the callers hold the port lock too. Do they need the port lock?

