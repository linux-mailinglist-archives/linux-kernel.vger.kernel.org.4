Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E596D5ED2EF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 04:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbiI1CRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 22:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbiI1CRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 22:17:09 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99D7D62CF;
        Tue, 27 Sep 2022 19:17:06 -0700 (PDT)
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Mcg4134bNzHtlN;
        Wed, 28 Sep 2022 10:12:17 +0800 (CST)
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm500004.china.huawei.com (7.192.104.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 28 Sep 2022 10:17:02 +0800
Subject: Re: [PATCH v5 3/8] scsi: pm8001: use sas_find_attached_phy_id()
 instead of open coded
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <martin.petersen@oracle.com>, <jejb@linux.ibm.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hare@suse.com>, <hch@lst.de>, <bvanassche@acm.org>,
        <john.garry@huawei.com>, <jinpu.wang@cloud.ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>
References: <20220927123926.953297-1-yanaijie@huawei.com>
 <20220927123926.953297-4-yanaijie@huawei.com>
 <caa8552b-3bb4-5824-aa99-82386d367479@opensource.wdc.com>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <b58846fa-5c1c-ad73-a363-68ddf99d4da5@huawei.com>
Date:   Wed, 28 Sep 2022 10:17:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <caa8552b-3bb4-5824-aa99-82386d367479@opensource.wdc.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.14]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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


On 2022/9/28 6:57, Damien Le Moal wrote:
> On 9/27/22 21:39, Jason Yan wrote:
>> The attached phy id finding is open coded. Now we can replace it with
>> sas_find_attached_phy_id(). To keep consistent, the return value of
>> pm8001_dev_found_notify() is also changed to -ENODEV after calling
>> sas_find_attathed_phy_id() failed.
>>
>> Signed-off-by: Jason Yan <yanaijie@huawei.com>
>> Reviewed-by: Jack Wang <jinpu.wang@ionos.com>
>> Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>> ---
>>   drivers/scsi/pm8001/pm8001_sas.c | 18 ++++++------------
>>   1 file changed, 6 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
>> index 8e3f2f9ddaac..042c0843de1a 100644
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
>> +		if (phy_id == -ENODEV) {
>>   			pm8001_dbg(pm8001_ha, FAIL,
>>   				   "Error: no attached dev:%016llx at ex:%016llx.\n",
>>   				   SAS_ADDR(dev->sas_addr),
>>   				   SAS_ADDR(parent_dev->sas_addr));
>> -			res = -1;
>> +			res = phy_id;
> 
> Nit:
> 
> res = -ENODEV would be a lot clearer.
> Or do:
> 
> 		if (phy_id < 0) {
> 			...
> 			ret = phy_id;
> 		} ...
> 

This boils down to personal preferences. I'd like to change to the 
latter one if no objections.

Thanks,
Jason

> No ?
> 
>> +		} else {
>> +			pm8001_device->attached_phy = phy_id;
>>   		}
>>   	} else {
>>   		if (dev->dev_type == SAS_SATA_DEV) {
> 
