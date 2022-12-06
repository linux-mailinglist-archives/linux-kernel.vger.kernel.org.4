Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF62E643FBA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 10:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234696AbiLFJUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 04:20:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235016AbiLFJT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 04:19:56 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B16E22B37
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 01:18:06 -0800 (PST)
Received: from dggpeml500005.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NRF9Q3V0QzJp6T;
        Tue,  6 Dec 2022 17:14:34 +0800 (CST)
Received: from [10.174.178.155] (10.174.178.155) by
 dggpeml500005.china.huawei.com (7.185.36.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 6 Dec 2022 17:17:33 +0800
Subject: Re: [PATCH] dax/hmem: Fix refcount leak in dax_hmem_probe()
To:     Ira Weiny <ira.weiny@intel.com>
CC:     <linux-kernel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
        <dave.jiang@intel.com>, <akpm@linux-foundation.org>,
        <joao.m.martins@oracle.com>, <zhangxiaoxu5@huawei.com>
References: <20221203095858.612027-1-liuyongqiang13@huawei.com>
 <Y4u2TK4yPU9dfiDr@iweiny-mobl>
From:   Yongqiang Liu <liuyongqiang13@huawei.com>
Message-ID: <03a5fc74-1b16-a0ee-c0a0-b45943f76bf0@huawei.com>
Date:   Tue, 6 Dec 2022 17:17:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <Y4u2TK4yPU9dfiDr@iweiny-mobl>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.155]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500005.china.huawei.com (7.185.36.59)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2022/12/4 4:49, Ira Weiny Ð´µÀ:
> On Sat, Dec 03, 2022 at 09:58:58AM +0000, Yongqiang Liu wrote:
>> We should always call dax_region_put() whenever devm_create_dev_dax()
>> succeed or fail to avoid refcount leak of dax_region. Move the return
>> value check after dax_region_put().
> I think dax_region_put is called from dax_region_unregister() automatically on
> tear down.
Yes, Thanks for your explanation.
>> Fixes: c01044cc8191 ("ACPI: HMAT: refactor hmat_register_target_device to hmem_register_device")
> I'm also not sure how this patch is related to this fix.
>
> Ira
>
>> Signed-off-by: Yongqiang Liu <liuyongqiang13@huawei.com>
>> ---
>>   drivers/dax/hmem/hmem.c | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
>> index 1bf040dbc834..09f5cd7b6c8e 100644
>> --- a/drivers/dax/hmem/hmem.c
>> +++ b/drivers/dax/hmem/hmem.c
>> @@ -36,12 +36,11 @@ static int dax_hmem_probe(struct platform_device *pdev)
>>   		.size = region_idle ? 0 : resource_size(res),
>>   	};
>>   	dev_dax = devm_create_dev_dax(&data);
>> -	if (IS_ERR(dev_dax))
>> -		return PTR_ERR(dev_dax);
>>   
>>   	/* child dev_dax instances now own the lifetime of the dax_region */
>>   	dax_region_put(dax_region);
>> -	return 0;
>> +
>> +	return IS_ERR(dev_dax) ? PTR_ERR(dev_dax) : 0;
>>   }
>>   
>>   static int dax_hmem_remove(struct platform_device *pdev)
>> -- 
>> 2.25.1
>>
>>
> .
