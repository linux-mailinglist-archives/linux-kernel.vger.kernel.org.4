Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4715EC14D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 13:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbiI0L2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 07:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbiI0L1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 07:27:39 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC74137918;
        Tue, 27 Sep 2022 04:25:42 -0700 (PDT)
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4McHKd2BjGzpTyR;
        Tue, 27 Sep 2022 19:22:45 +0800 (CST)
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm500004.china.huawei.com (7.192.104.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 27 Sep 2022 19:25:39 +0800
Subject: Re: [PATCH v4 3/8] scsi: pm8001: use sas_find_attached_phy() instead
 of open coded
To:     John Garry <john.garry@huawei.com>, <martin.petersen@oracle.com>,
        <jejb@linux.ibm.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hare@suse.com>, <hch@lst.de>, <bvanassche@acm.org>,
        <jinpu.wang@cloud.ionos.com>, <damien.lemoal@opensource.wdc.com>,
        Jack Wang <jinpu.wang@ionos.com>
References: <20220927032605.78103-1-yanaijie@huawei.com>
 <20220927032605.78103-4-yanaijie@huawei.com>
 <9e9f8384-0662-73ef-ab17-8420c94762fb@huawei.com>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <cc8a0c09-03a2-c7e2-5f1a-c9b740315b70@huawei.com>
Date:   Tue, 27 Sep 2022 19:25:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <9e9f8384-0662-73ef-ab17-8420c94762fb@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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


On 2022/9/27 16:34, John Garry wrote:
> On 27/09/2022 04:26, Jason Yan wrote:
>> +++ b/drivers/scsi/pm8001/pm8001_sas.c
>> @@ -645,22 +645,16 @@ static int pm8001_dev_found_notify(struct 
>> domain_device *dev)
>>       pm8001_device->dcompletion = &completion;
>>       if (parent_dev && dev_is_expander(parent_dev->dev_type)) {
>>           int phy_id;
>> -        struct ex_phy *phy;
>> -        for (phy_id = 0; phy_id < parent_dev->ex_dev.num_phys;
>> -        phy_id++) {
>> -            phy = &parent_dev->ex_dev.ex_phy[phy_id];
>> -            if (SAS_ADDR(phy->attached_sas_addr)
>> -                == SAS_ADDR(dev->sas_addr)) {
>> -                pm8001_device->attached_phy = phy_id;
>> -                break;
>> -            }
>> -        }
>> -        if (phy_id == parent_dev->ex_dev.num_phys) {
>> +
>> +        phy_id = sas_find_attached_phy(&parent_dev->ex_dev, dev);
>> +        if (phy_id == -ENODEV) {
>>               pm8001_dbg(pm8001_ha, FAIL,
>>                      "Error: no attached dev:%016llx at ex:%016llx.\n",
>>                      SAS_ADDR(dev->sas_addr),
>>                      SAS_ADDR(parent_dev->sas_addr));
>>               res = -1;
> 
> I think that you can just pass the linux error code (-ENODEV) back here.
> 
> And for hisi_sas we change to -EINVAL for this code. I don't think it's 
> required, so I think that we can pass -ENODEV back there also. Using 
> -EINVAL seems to come from when the code was originally added in 
> abda97c2fe874 and from a quick glance libsas does not seem to have 
> special processing for -EINVAL.
> 

Yes, libsas does not have any special processing for the return value, 
so there is no difference in what value we return here. But I agree with 
you that return -ENODEV is better here because we can keep it consistent 
with the return value of sas_find_attached_phy().

Will update.

Thanks,
Jason

> Thanks,
> John
> 
>> +        } else {
>> +            pm8001_device->attached_phy = phy_id;
>>           }
>>       } else {
>>           if (dev->dev_type == SAS_SATA
> 
> .
