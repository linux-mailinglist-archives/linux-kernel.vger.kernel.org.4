Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEBA6E9369
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 13:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234050AbjDTLwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 07:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjDTLwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 07:52:20 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F02B1BE9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 04:52:19 -0700 (PDT)
Received: from dggpemm500006.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Q2GBH2yPtzSsl9;
        Thu, 20 Apr 2023 19:48:07 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 20 Apr 2023 19:52:15 +0800
Subject: Re: [PATCH] iommu/iova: Optimize iova_magazine_alloc()
To:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <20230418062518.852-1-thunder.leizhen@huawei.com>
 <e9b912ee-6b49-f369-82ff-daff49dc7511@arm.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <b6bf601b-0466-cb94-22b2-1189724410c9@huawei.com>
Date:   Thu, 20 Apr 2023 19:52:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <e9b912ee-6b49-f369-82ff-daff49dc7511@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/20 18:38, Robin Murphy wrote:
> On 2023-04-18 07:25, Zhen Lei wrote:
>> Only the member 'size' needs to be initialized to 0. Clearing the array
>> pfns[], which is about 1 KiB in size, not only wastes time, but also
>> causes cache pollution.
> 
> Makes sense to me.
> 
> Acked-by: Robin Murphy <robin.murphy@arm.com>
> 
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>   drivers/iommu/iova.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
>> index fe452ce466429a7..c970b9a2819d7bb 100644
>> --- a/drivers/iommu/iova.c
>> +++ b/drivers/iommu/iova.c
>> @@ -647,7 +647,13 @@ struct iova_rcache {
>>     static struct iova_magazine *iova_magazine_alloc(gfp_t flags)
>>   {
>> -    return kzalloc(sizeof(struct iova_magazine), flags);
>> +    struct iova_magazine *mag;
>> +
>> +    mag = kmalloc(sizeof(struct iova_magazine), flags);
> 
> Nit: maybe sizeof(*mag) is preferable?

Yes, sizeof(*mag) is the more recommended usage, I will post v2 tomorrow.

> 
>> +    if (mag)
>> +        mag->size = 0;
>> +
>> +    return mag;
>>   }
>>     static void iova_magazine_free(struct iova_magazine *mag)
> 
> .
> 

-- 
Regards,
  Zhen Lei
