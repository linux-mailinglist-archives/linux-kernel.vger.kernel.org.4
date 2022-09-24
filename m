Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949D15E87EB
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 05:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233101AbiIXDWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 23:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbiIXDWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 23:22:37 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD7212059A;
        Fri, 23 Sep 2022 20:22:35 -0700 (PDT)
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MZDk659q7zlWnR;
        Sat, 24 Sep 2022 11:18:22 +0800 (CST)
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm500004.china.huawei.com (7.192.104.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 24 Sep 2022 11:22:33 +0800
Subject: Re: [PATCH 6/7] scsi: pm8001: use dev_and_phy_addr_same() instead of
 open coded
To:     John Garry <john.garry@huawei.com>, <martin.petersen@oracle.com>,
        <jejb@linux.ibm.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hare@suse.com>, <hch@lst.de>, <bvanassche@acm.org>,
        <jinpu.wang@cloud.ionos.com>
References: <20220917104311.1878250-1-yanaijie@huawei.com>
 <20220917104311.1878250-7-yanaijie@huawei.com>
 <0034eff3-70a5-becb-0821-f9c36371e6d9@huawei.com>
 <3c1aa262-7e9b-cb6c-e8a1-a1a201050a10@huawei.com>
 <6c299e8f-80be-0276-c8b1-9df1946434da@huawei.com>
 <d3c7285f-6318-8254-2bfa-d836f12fcd88@huawei.com>
 <569cb47c-af63-cf70-ae1a-4c5116dd4877@huawei.com>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <d303aa1d-a397-4bb0-394d-46bd8c0db27d@huawei.com>
Date:   Sat, 24 Sep 2022 11:22:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <569cb47c-af63-cf70-ae1a-4c5116dd4877@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.14]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500004.china.huawei.com (7.192.104.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/9/23 18:30, John Garry wrote:
> On 23/09/2022 11:13, Jason Yan wrote:
>>>
>>> Please explain why.
>>>
>>> I would assume that if those helpers were only used in libsas code 
>>> (and not LLDDs) then they could be put in sas_internal.h and no need 
>>> for export
>>>
>>
>>
>> Sorry, I did not make it clear. I mean we need to export 
>> sas_find_attathed_phy() below. Not the sas address comparation helpers.
> 
> That seems fine to me.
> 
> About sas_find_attathed_phy() implementation,
> 
>  > +static inline int sas_find_attathed_phy(struct expander_device *ex_dev,
>  > +                                       struct domain_device *dev)
>  > +{
>  > +       struct ex_phy *phy;
>  > +       int phy_id;
>  > +
>  > +       for (phy_id = 0; phy_id < ex_dev->num_phys; phy_id++) {
>  > +               phy = &ex_dev->ex_phy[phy_id];
>  > +               if (SAS_ADDR(phy->attached_sas_addr)
>  > +                       == SAS_ADDR(dev->sas_addr))
>  > +                       return phy_id;
>  > +       }
>  > +
>  > +       return ex_dev->num_phys;
> 
> Returning ex_dev->num_phys would seem ok, but then the LLDD needs to 
> check that return against ex_dev->num_phys. It seems ok, but I'm still 
> not 100% comfortable with that. Maybe returning -ENODEV may be better.
> 
> Or return boolean and pass phy_id as pointer to be filled in when 
> returning true.
> 

I've been thinking about this for a while too. Thank you for the advise.

Thanks,
Jason

>  > +}
> 
> Thanks,
> John
> 
> .
