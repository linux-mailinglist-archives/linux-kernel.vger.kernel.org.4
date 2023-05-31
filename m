Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E947F7172EC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 03:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233965AbjEaBQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 21:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbjEaBQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 21:16:28 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80FCF3
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 18:16:25 -0700 (PDT)
Received: from dggpemm500006.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QWB746xqwzqTYs;
        Wed, 31 May 2023 09:11:44 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 31 May 2023 09:16:23 +0800
Subject: Re: [PATCH 1/6] kexec: fix a memory leak in crash_shrink_memory()
To:     Baoquan He <bhe@redhat.com>
CC:     Eric Biederman <ebiederm@xmission.com>,
        <kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Michael Holzheu <holzheu@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230527123439.772-1-thunder.leizhen@huawei.com>
 <20230527123439.772-2-thunder.leizhen@huawei.com>
 <ZHaQ7qRYWX9FETu6@MiWiFi-R3L-srv>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <5232350c-7529-eece-c9cb-8a8bbc83a81a@huawei.com>
Date:   Wed, 31 May 2023 09:16:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <ZHaQ7qRYWX9FETu6@MiWiFi-R3L-srv>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/31 8:13, Baoquan He wrote:
> On 05/27/23 at 08:34pm, Zhen Lei wrote:
>> If the value of parameter 'new_size' is in the semi-open and semi-closed
>> interval (crashk_res.end - KEXEC_CRASH_MEM_ALIGN + 1, crashk_res.end], the
>> calculation result of ram_res is:
>> 	ram_res->start = crashk_res.end + 1
>> 	ram_res->end   = crashk_res.end
> 
> If the new_size is smaller than KEXEC_CRASH_MEM_ALIGN, does it make
> any sense except of testing purpose? Do we need to fail this kind of
> shrinking, or just shrink all the left crash memory?

We can't give a fixed value, that is, how much crash memory is reserved to
ensure that the capture kernel runs. The size of KEXEC_CRASH_MEM_ALIGN is
only one page on non-s390 platforms. So, it's better to keep the code simple,
and let the user(administrator) shrink the crash memory reasonably.

include/linux/kexec.h
#define KEXEC_CRASH_MEM_ALIGN	PAGE_SIZE

> 
>> The operation of function insert_resource() fails, and ram_res is not
>> added to iomem_resource. As a result, the memory of the control block
>> ram_res is leaked.
>>
>> In fact, on all architectures, the start address and size of crashk_res
>> are already aligned by KEXEC_CRASH_MEM_ALIGN. Therefore, we do not need to
>> round up crashk_res.start again. Instead, we should round up 'new_size'
>> in advance.
>>
>> Fixes: 6480e5a09237 ("kdump: add missing RAM resource in crash_shrink_memory()")
>> Fixes: 06a7f711246b ("kexec: premit reduction of the reserved memory size")
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  kernel/kexec_core.c | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
>> index 3d578c6fefee385..22acee18195a591 100644
>> --- a/kernel/kexec_core.c
>> +++ b/kernel/kexec_core.c
>> @@ -1122,6 +1122,7 @@ int crash_shrink_memory(unsigned long new_size)
>>  	start = crashk_res.start;
>>  	end = crashk_res.end;
>>  	old_size = (end == 0) ? 0 : end - start + 1;
>> +	new_size = roundup(new_size, KEXEC_CRASH_MEM_ALIGN);
>>  	if (new_size >= old_size) {
>>  		ret = (new_size == old_size) ? 0 : -EINVAL;
>>  		goto unlock;
>> @@ -1133,9 +1134,7 @@ int crash_shrink_memory(unsigned long new_size)
>>  		goto unlock;
>>  	}
>>  
>> -	start = roundup(start, KEXEC_CRASH_MEM_ALIGN);
>> -	end = roundup(start + new_size, KEXEC_CRASH_MEM_ALIGN);
>> -
>> +	end = start + new_size;
>>  	crash_free_reserved_phys_range(end, crashk_res.end);
>>  
>>  	if ((start == end) && (crashk_res.parent != NULL))
>> -- 
>> 2.25.1
>>
> 
> .
> 

-- 
Regards,
  Zhen Lei
