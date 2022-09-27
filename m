Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D645EB7E0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 04:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiI0CoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 22:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiI0CoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 22:44:23 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5E0F161D;
        Mon, 26 Sep 2022 19:44:22 -0700 (PDT)
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Mc3kZ049wzlX9t;
        Tue, 27 Sep 2022 10:40:06 +0800 (CST)
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm500004.china.huawei.com (7.192.104.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 27 Sep 2022 10:44:20 +0800
Subject: Re: [PATCH v3 1/8] scsi: libsas: introduce sas address comparation
 helpers
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <martin.petersen@oracle.com>, <jejb@linux.ibm.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hare@suse.com>, <hch@lst.de>, <bvanassche@acm.org>,
        <john.garry@huawei.com>, <jinpu.wang@cloud.ionos.com>
References: <20220927022941.4029476-1-yanaijie@huawei.com>
 <20220927022941.4029476-2-yanaijie@huawei.com>
 <4e829dd7-6db3-4dbf-1b8e-9f7bb805f723@opensource.wdc.com>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <52ccb73b-f133-25cb-2275-fc042dee3ab4@huawei.com>
Date:   Tue, 27 Sep 2022 10:44:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <4e829dd7-6db3-4dbf-1b8e-9f7bb805f723@opensource.wdc.com>
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

Hi Damien,

On 2022/9/27 10:23, Damien Le Moal wrote:
> On 9/27/22 11:29, Jason Yan wrote:
>> Sas address comparation is widely used in libsas. However they are all
> 
> s/comparation/comparison
> 
> Here and in the patch title.
> 

Thank you. I will fix the typo.

Jason

> Other than that, Looks OK to me.
> 
> Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> 
>> opencoded and to avoid the line spill over 80 columns, are mostly split
>> into multi-lines. Introduce some helpers to prepare some refactor.
>>
>> Signed-off-by: Jason Yan <yanaijie@huawei.com>
>> ---
>>   drivers/scsi/libsas/sas_internal.h | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>>
>> diff --git a/drivers/scsi/libsas/sas_internal.h b/drivers/scsi/libsas/sas_internal.h
>> index 8d0ad3abc7b5..3384429b7eb0 100644
>> --- a/drivers/scsi/libsas/sas_internal.h
>> +++ b/drivers/scsi/libsas/sas_internal.h
>> @@ -111,6 +111,23 @@ static inline void sas_smp_host_handler(struct bsg_job *job,
>>   }
>>   #endif
>>   
>> +static inline bool sas_phy_match_dev_addr(struct domain_device *dev,
>> +					 struct ex_phy *phy)
>> +{
>> +	return SAS_ADDR(dev->sas_addr) == SAS_ADDR(phy->attached_sas_addr);
>> +}
>> +
>> +static inline bool sas_phy_match_port_addr(struct asd_sas_port *port,
>> +					   struct ex_phy *phy)
>> +{
>> +	return SAS_ADDR(port->sas_addr) == SAS_ADDR(phy->attached_sas_addr);
>> +}
>> +
>> +static inline bool sas_phy_addr_match(struct ex_phy *p1, struct ex_phy *p2)
>> +{
>> +	return  SAS_ADDR(p1->attached_sas_addr) == SAS_ADDR(p2->attached_sas_addr);
>> +}
>> +
>>   static inline void sas_fail_probe(struct domain_device *dev, const char *func, int err)
>>   {
>>   	pr_warn("%s: for %s device %016llx returned %d\n",
> 
