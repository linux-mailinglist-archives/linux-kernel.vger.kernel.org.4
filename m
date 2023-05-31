Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD4CD7184D7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 16:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbjEaOZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 10:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237761AbjEaOZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 10:25:40 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16A7E2
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 07:25:38 -0700 (PDT)
Received: from dggpemm500006.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QWWgd4jvFzLq8l;
        Wed, 31 May 2023 22:22:37 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 31 May 2023 22:25:36 +0800
Subject: Re: [PATCH 6/6] kexec: enable kexec_crash_size to support two crash
 kernel regions
To:     Baoquan He <bhe@redhat.com>
CC:     Eric Biederman <ebiederm@xmission.com>,
        <kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Michael Holzheu <holzheu@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230527123439.772-1-thunder.leizhen@huawei.com>
 <20230527123439.772-7-thunder.leizhen@huawei.com>
 <ZHcY/jsExa8t7hJW@MiWiFi-R3L-srv>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <955d2ba6-2cb8-7ee1-031f-e9033b32a3c8@huawei.com>
Date:   Wed, 31 May 2023 22:25:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <ZHcY/jsExa8t7hJW@MiWiFi-R3L-srv>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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



On 2023/5/31 17:53, Baoquan He wrote:
> On 05/27/23 at 08:34pm, Zhen Lei wrote:
>> The crashk_low_res should be considered by /sys/kernel/kexec_crash_size
>> to support two crash kernel regions. Since crashk_res manages the memory
>> with high address and crashk_low_res manages the memory with low address,
>> crashk_low_res is shrunken only when all crashk_res is shrunken. And
>> because when there is only one crash kernel region, crashk_res is always
>> used. Therefore, if all crashk_res is shrunken and crashk_low_res still
>> exists, swap them.
> 
> This looks good, otherwise someone else won't stop attempting to add
> support of crashk_low_res shrinking. Not sure if this will bring corner
> case issue in testing, let's see. For the patch log, I tried to
> rephrase, feel free to refer to.
> 
> =====
> The crashk_low_res should be considered by /sys/kernel/kexec_crash_size
> to support two crash kernel regions shrinking if existing.
> 
> While doing it, crashk_low_res will only be shrunk when the entire
> crashk_res is empty; and if the crashk_res is empty and crahk_low_res
> is not, change crashk_low_res to be crashk_res.
> =====
> 
> With the log updated, you can add:
> 
> Acked-by: Baoquan He <bhe@redhat.com>

OK, I will update the log and add Acked-by in v2.

> 
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  kernel/kexec_core.c | 43 ++++++++++++++++++++++++++++++++++++++-----
>>  1 file changed, 38 insertions(+), 5 deletions(-)
>>
>> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
>> index e82bc6d6634136a..c1d50f6566300d9 100644
>> --- a/kernel/kexec_core.c
>> +++ b/kernel/kexec_core.c
>> @@ -1091,6 +1091,11 @@ __bpf_kfunc void crash_kexec(struct pt_regs *regs)
>>  	}
>>  }
>>  
>> +static inline resource_size_t crash_resource_size(const struct resource *res)
>> +{
>> +	return !res->end ? 0 : resource_size(res);
>> +}
>> +
>>  ssize_t crash_get_memory_size(void)
>>  {
>>  	ssize_t size = 0;
>> @@ -1098,8 +1103,8 @@ ssize_t crash_get_memory_size(void)
>>  	if (!kexec_trylock())
>>  		return -EBUSY;
>>  
>> -	if (crashk_res.end != crashk_res.start)
>> -		size = resource_size(&crashk_res);
>> +	size += crash_resource_size(&crashk_res);
>> +	size += crash_resource_size(&crashk_low_res);
>>  
>>  	kexec_unlock();
>>  	return size;
>> @@ -1135,7 +1140,7 @@ int __crash_shrink_memory(struct resource *old_res, unsigned long new_size)
>>  int crash_shrink_memory(unsigned long new_size)
>>  {
>>  	int ret = 0;
>> -	unsigned long old_size;
>> +	unsigned long old_size, low_size;
>>  
>>  	if (!kexec_trylock())
>>  		return -EBUSY;
>> @@ -1144,14 +1149,42 @@ int crash_shrink_memory(unsigned long new_size)
>>  		ret = -ENOENT;
>>  		goto unlock;
>>  	}
>> -	old_size = !crashk_res.end ? 0 : resource_size(&crashk_res);
>> +
>> +	low_size = crash_resource_size(&crashk_low_res);
>> +	old_size = crash_resource_size(&crashk_res) + low_size;
>>  	new_size = roundup(new_size, KEXEC_CRASH_MEM_ALIGN);
>>  	if (new_size >= old_size) {
>>  		ret = (new_size == old_size) ? 0 : -EINVAL;
>>  		goto unlock;
>>  	}
>>  
>> -	ret = __crash_shrink_memory(&crashk_res, new_size);
>> +	/*
>> +	 * (low_size > new_size) implies that low_size is greater than zero.
>> +	 * This also means that if low_size is zero, the else branch is taken.
>> +	 *
>> +	 * If low_size is greater than 0, (low_size > new_size) indicates that
>> +	 * crashk_low_res also needs to be shrunken. Otherwise, only crashk_res
>> +	 * needs to be shrunken.
>> +	 */
>> +	if (low_size > new_size) {
>> +		ret = __crash_shrink_memory(&crashk_res, 0);
>> +		if (ret)
>> +			goto unlock;
>> +
>> +		ret = __crash_shrink_memory(&crashk_low_res, new_size);
>> +	} else {
>> +		ret = __crash_shrink_memory(&crashk_res, new_size - low_size);
>> +	}
>> +
>> +	/* Swap crashk_res and crashk_low_res if needed */
>> +	if (!crashk_res.end && crashk_low_res.end) {
>> +		crashk_res.start = crashk_low_res.start;
>> +		crashk_res.end   = crashk_low_res.end;
>> +		release_resource(&crashk_low_res);
>> +		crashk_low_res.start = 0;
>> +		crashk_low_res.end   = 0;
>> +		insert_resource(&iomem_resource, &crashk_res);
>> +	}
>>  
>>  unlock:
>>  	kexec_unlock();
>> -- 
>> 2.25.1
>>
> 
> .
> 

-- 
Regards,
  Zhen Lei
