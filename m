Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A448F70EE74
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 08:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239548AbjEXGuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 02:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239606AbjEXGt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 02:49:26 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDEAA1FDC
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 23:47:49 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QR1nw61V0zTkpW;
        Wed, 24 May 2023 14:42:28 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 24 May 2023 14:47:26 +0800
Message-ID: <4eb83d16-58ed-9f09-4308-f0f786580257@huawei.com>
Date:   Wed, 24 May 2023 14:47:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] memblock: update numa node of memblk reserved type
Content-Language: en-US
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        <20230519105321.333-1-ssawgyw@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>, <tsahu@linux.ibm.com>,
        <ssawgyw@gmail.com>
References: <20230523115708.195597-1-wangkefeng.wang@huawei.com>
 <03cdccc3-8b8a-d972-bbad-d60966e59ca9@arm.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <03cdccc3-8b8a-d972-bbad-d60966e59ca9@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/24 12:59, Anshuman Khandual wrote:
> 
> 
> On 5/23/23 17:27, Kefeng Wang wrote:
>> The numa node of memblk reserved type is wrong, it could update
>> according to the numa node information from memblk memory type,
>> let's fix it.
> 
> Indeed it's wrong at present and can be verified from sysfs file
> (/sys/kernel/debug/memblock/reserved) accessed in user space.

Yes, both memblock_dump() and sysfs show wrong value.
> 
>>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> ---
>>   mm/memblock.c | 25 +++++++++++++++++++++++++
>>   1 file changed, 25 insertions(+)
>>
>> diff --git a/mm/memblock.c b/mm/memblock.c
>> index a50447d970ef..45a0781cda31 100644
>> --- a/mm/memblock.c
>> +++ b/mm/memblock.c
>> @@ -1922,6 +1922,28 @@ phys_addr_t __init_memblock memblock_get_current_limit(void)
>>   	return memblock.current_limit;
>>   }
>>   
>> +static void __init_memblock memblock_reserved_update_node(void)
>> +{
>> +	struct memblock_region *rgn;
>> +	phys_addr_t base, end, size;
>> +	int ret;
>> +
>> +	if (!IS_ENABLED(CONFIG_NUMA))
>> +		return;
>> +
>> +	for_each_mem_region(rgn) {
>> +		base = rgn->base;
>> +		size = rgn->size;
>> +		end = base + size - 1;
>> +
>> +		ret = memblock_set_node(base, size, &memblock.reserved,
>> +					memblock_get_region_node(rgn));
>> +		if (ret)
>> +			pr_err("memblock: Failed to update reserved [%pa-%pa] node",
>> +			       &base, &end);
>> +	}
>> +}
>> +
>>   static void __init_memblock memblock_dump(struct memblock_type *type)
>>   {
>>   	phys_addr_t base, end, size;
>> @@ -1955,6 +1977,7 @@ static void __init_memblock __memblock_dump_all(void)
>>   		&memblock.memory.total_size,
>>   		&memblock.reserved.total_size);
>>   
>> +	memblock_reserved_update_node();
> 
> __memblock_dump_all() gets called only when memblock_debug is enabled.
> This helper should be called directly inside memblock_dump_all() right
> at the beginning, regardless of memblock_debug.

This is my first though, but I found there are still many memblock_alloc 
and memblock_reserve after memblock_dump_all(), so I update it twice,

1) __memblock_dump_all()
2) memblock_debug_show()

and without the above two interface, no one care about the reserved node
info, so I put memblock_reserved_update_node into __memblock_dump_all().


>>   #ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
>> @@ -2196,6 +2219,8 @@ static int memblock_debug_show(struct seq_file *m, void *private)
>>   	unsigned int count = ARRAY_SIZE(flagname);
>>   	phys_addr_t end;
>>   
>> +	memblock_reserved_update_node();
>> +
> 

> This is redundant, should be dropped. Reserved memblock ranges need not
> be scanned, each time the sysfs file is accessed from user space.

Yes, it's better to move it into memblock_init_debugfs(),
which only called once.


