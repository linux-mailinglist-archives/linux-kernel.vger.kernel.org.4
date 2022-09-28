Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6CE25ED6E9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 09:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233956AbiI1Hzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 03:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233858AbiI1HzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 03:55:00 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECEF2DFF;
        Wed, 28 Sep 2022 00:54:47 -0700 (PDT)
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Mcp3v0sPgzHqCq;
        Wed, 28 Sep 2022 15:27:39 +0800 (CST)
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm500004.china.huawei.com (7.192.104.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 28 Sep 2022 15:29:55 +0800
Subject: Re: [PATCH v6 3/8] scsi: pm8001: use sas_find_attached_phy_id()
 instead of open coded
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <martin.petersen@oracle.com>, <jejb@linux.ibm.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hare@suse.com>, <hch@lst.de>, <bvanassche@acm.org>,
        <john.garry@huawei.com>, <jinpu.wang@cloud.ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>
References: <20220928070130.3657183-1-yanaijie@huawei.com>
 <20220928070130.3657183-4-yanaijie@huawei.com>
 <e3bfbe7e-baee-9f4a-7d55-c6dc27e3eba1@opensource.wdc.com>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <9005bfd1-2812-f4c3-38e2-eb7aa5d61634@huawei.com>
Date:   Wed, 28 Sep 2022 15:29:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <e3bfbe7e-baee-9f4a-7d55-c6dc27e3eba1@opensource.wdc.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.14]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500004.china.huawei.com (7.192.104.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/9/28 15:02, Damien Le Moal wrote:
> On 9/28/22 16:01, Jason Yan wrote:
>> The attached phy id finding is open coded. Now we can replace it with
>> sas_find_attached_phy_id(). To keep consistent, the return value of
>> pm8001_dev_found_notify() is also changed to -ENODEV after calling
>> sas_find_attathed_phy_id() failed.
>>
>> Signed-off-by: Jason Yan <yanaijie@huawei.com>
>> Reviewed-by: Jack Wang <jinpu.wang@ionos.com>
>> Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> 
> Looks good.
> 
> Note for future patches: if you change a patch, it needs to be reviewed
> again. So please drop any review tag from the patch commit message to make
> that clear.

OK. Thanks again.

Jason

> 
>> ---
>>   drivers/scsi/pm8001/pm8001_sas.c | 18 ++++++------------
>>   1 file changed, 6 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
>> index 8e3f2f9ddaac..b4007c4f157d 100644
>> --- a/drivers/scsi/pm8001/pm8001_sas.c
>> +++ b/drivers/scsi/pm8001/pm8001_sas.c
>> @@ -645,22 +645,16 @@ static int pm8001_dev_found_notify(struct domain_device *dev)
>>   	pm8001_device->dcompletion = &completion;
>>   	if (parent_dev && dev_is_expander(parent_dev->dev_type)) {
>>   		int phy_id;
>> -		struct ex_phy *phy;
>> -		for (phy_id = 0; phy_id < parent_dev->ex_dev.num_phys;
>> -		phy_id++) {
>> -			phy = &parent_dev->ex_dev.ex_phy[phy_id];
>> -			if (SAS_ADDR(phy->attached_sas_addr)
>> -				== SAS_ADDR(dev->sas_addr)) {
>> -				pm8001_device->attached_phy = phy_id;
>> -				break;
>> -			}
>> -		}
>> -		if (phy_id == parent_dev->ex_dev.num_phys) {
>> +
>> +		phy_id = sas_find_attached_phy_id(&parent_dev->ex_dev, dev);
>> +		if (phy_id < 0) {
>>   			pm8001_dbg(pm8001_ha, FAIL,
>>   				   "Error: no attached dev:%016llx at ex:%016llx.\n",
>>   				   SAS_ADDR(dev->sas_addr),
>>   				   SAS_ADDR(parent_dev->sas_addr));
>> -			res = -1;
>> +			res = phy_id;
>> +		} else {
>> +			pm8001_device->attached_phy = phy_id;
>>   		}
>>   	} else {
>>   		if (dev->dev_type == SAS_SATA_DEV) {
> 
