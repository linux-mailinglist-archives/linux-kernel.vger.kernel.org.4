Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B57D6206F7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 03:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbiKHCrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 21:47:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbiKHCrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 21:47:23 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42AA32E9FE;
        Mon,  7 Nov 2022 18:47:22 -0800 (PST)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N5svP1nkBzRp3H;
        Tue,  8 Nov 2022 10:47:13 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 10:47:20 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 10:47:19 +0800
Subject: Re: [PATCH v3 1/2] arm64: kdump: Provide default size when
 crashkernel=Y,low is not specified
To:     Catalin Marinas <catalin.marinas@arm.com>
CC:     Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, <kexec@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Chen Zhou <dingguo.cz@antgroup.com>,
        John Donnelly <John.p.donnelly@oracle.com>,
        "Dave Kleikamp" <dave.kleikamp@oracle.com>
References: <20220711090319.1604-1-thunder.leizhen@huawei.com>
 <20220711090319.1604-2-thunder.leizhen@huawei.com> <Y2k98lFhtUP2u1VM@arm.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <1dd20529-e346-cd64-d93d-54231c8b3d38@huawei.com>
Date:   Tue, 8 Nov 2022 10:47:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <Y2k98lFhtUP2u1VM@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/11/8 1:18, Catalin Marinas wrote:
> On Mon, Jul 11, 2022 at 05:03:18PM +0800, Zhen Lei wrote:
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 2522b11e593f239..65a2c3a22a4b57d 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -843,7 +843,7 @@
>>  			available.
>>  			It will be ignored if crashkernel=X is specified.
>>  	crashkernel=size[KMG],low
>> -			[KNL, X86-64] range under 4G. When crashkernel=X,high
>> +			[KNL, X86-64, ARM64] range under 4G. When crashkernel=X,high
>>  			is passed, kernel could allocate physical memory region
>>  			above 4G, that cause second kernel crash on system
>>  			that require some amount of low memory, e.g. swiotlb
>> @@ -857,12 +857,6 @@
>>  			It will be ignored when crashkernel=X,high is not used
>>  			or memory reserved is below 4G.
>>  
>> -			[KNL, ARM64] range in low memory.
>> -			This one lets the user specify a low range in the
>> -			DMA zone for the crash dump kernel.
>> -			It will be ignored when crashkernel=X,high is not used
>> -			or memory reserved is located in the DMA zones.
>> -
>>  	cryptomgr.notests
>>  			[KNL] Disable crypto self-tests
>>  
>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>> index 339ee84e5a61a0b..5390f361208ccf7 100644
>> --- a/arch/arm64/mm/init.c
>> +++ b/arch/arm64/mm/init.c
>> @@ -96,6 +96,14 @@ phys_addr_t __ro_after_init arm64_dma_phys_limit = PHYS_MASK + 1;
>>  #define CRASH_ADDR_LOW_MAX		arm64_dma_phys_limit
>>  #define CRASH_ADDR_HIGH_MAX		(PHYS_MASK + 1)
>>  
>> +/*
>> + * This is an empirical value in x86_64 and taken here directly. Please
>> + * refer to the code comment in reserve_crashkernel_low() of x86_64 for more
>> + * details.
>> + */
>> +#define DEFAULT_CRASH_KERNEL_LOW_SIZE	\
>> +	max(swiotlb_size_or_default() + (8UL << 20), 256UL << 20)
>> +
>>  static int __init reserve_crashkernel_low(unsigned long long low_size)
>>  {
>>  	unsigned long long low_base;
>> @@ -147,7 +155,9 @@ static void __init reserve_crashkernel(void)
>>  		 * is not allowed.
>>  		 */
>>  		ret = parse_crashkernel_low(cmdline, 0, &crash_low_size, &crash_base);
>> -		if (ret && (ret != -ENOENT))
>> +		if (ret == -ENOENT)
>> +			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
>> +		else if (ret)
>>  			return;
> 
> BTW, since we want a default low allocation, I think we should change
> the checking logic slightly. Currently we have:
> 
> 	if ((crash_base >= CRASH_ADDR_LOW_MAX) &&
> 	     crash_low_size && reserve_crashkernel_low(crash_low_size)) {
> 		...
> 
> If crash_base is just below CRASH_ADDR_LOW_MAX, we deem it sufficient
> but a crashkernel trying to allocate 64MB of swiotlb may fail. So maybe
> change this to crash_base >= CRASH_ADDR_LOW_MAX - crash_low_size.

The equal sign needs to be removed.

The situation should be the allocation of "crashkernel=X,high".

This possibility is too small, the high memory is unlikely to be that small.
memblock_phys_alloc_range() always search for memory block from high addresses
to low addresses. In the initial phase, high-end memory is not fragmented.

Of course, the modification can make people look more reassuring. OK, I'll
update it.

> 

-- 
Regards,
  Zhen Lei
