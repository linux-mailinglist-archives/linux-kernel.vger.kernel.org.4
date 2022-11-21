Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A052E632180
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 13:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbiKUMAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 07:00:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbiKUMAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 07:00:15 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C1951309;
        Mon, 21 Nov 2022 04:00:14 -0800 (PST)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NG5Xv5FzGzmW5v;
        Mon, 21 Nov 2022 19:59:43 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 20:00:12 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 20:00:11 +0800
Subject: Re: [PATCH v4 2/2] arm64: kdump: Support crashkernel=X fall back to
 reserve region above DMA zones
To:     Baoquan He <bhe@redhat.com>
CC:     Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        <kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Chen Zhou <dingguo.cz@antgroup.com>,
        John Donnelly <John.p.donnelly@oracle.com>,
        "Dave Kleikamp" <dave.kleikamp@oracle.com>
References: <20221116121044.1690-1-thunder.leizhen@huawei.com>
 <20221116121044.1690-3-thunder.leizhen@huawei.com>
 <Y3s3ZCYj+ZbI3whB@MiWiFi-R3L-srv>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <0c3358aa-251f-cd47-e6d6-6408abacdea5@huawei.com>
Date:   Mon, 21 Nov 2022 20:00:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <Y3s3ZCYj+ZbI3whB@MiWiFi-R3L-srv>
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



On 2022/11/21 16:31, Baoquan He wrote:
> On 11/16/22 at 08:10pm, Zhen Lei wrote:
>> For crashkernel=X without '@offset', select a region within DMA zones
>> first, and fall back to reserve region above DMA zones. This allows
>> users to use the same configuration on multiple platforms.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> Acked-by: Baoquan He <bhe@redhat.com>
>> ---
>>  Documentation/admin-guide/kernel-parameters.txt |  2 +-
>>  arch/arm64/mm/init.c                            | 17 ++++++++++++++++-
>>  2 files changed, 17 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index a7b7147447b8bf8..ef6d922ed26b9dc 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -842,7 +842,7 @@
>>  			memory region [offset, offset + size] for that kernel
>>  			image. If '@offset' is omitted, then a suitable offset
>>  			is selected automatically.
>> -			[KNL, X86-64] Select a region under 4G first, and
>> +			[KNL, X86-64, ARM64] Select a region under 4G first, and
>>  			fall back to reserve region above 4G when '@offset'
>>  			hasn't been specified.
>>  			See Documentation/admin-guide/kdump/kdump.rst for further details.
>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>> index ba7227179822d10..58a0bb2c17f18cf 100644
>> --- a/arch/arm64/mm/init.c
>> +++ b/arch/arm64/mm/init.c
>> @@ -132,6 +132,7 @@ static void __init reserve_crashkernel(void)
>>  	unsigned long long crash_max = CRASH_ADDR_LOW_MAX;
>>  	char *cmdline = boot_command_line;
>>  	int ret;
>> +	bool fixed_base = false;
>>  
>>  	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
>>  		return;
>> @@ -163,12 +164,26 @@ static void __init reserve_crashkernel(void)
>>  	crash_size = PAGE_ALIGN(crash_size);
>>  
>>  	/* User specifies base address explicitly. */
>> -	if (crash_base)
>> +	if (crash_base) {
>> +		fixed_base = true;
>>  		crash_max = crash_base + crash_size;
>> +	}
>>  
>> +retry:
>>  	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
>>  					       crash_base, crash_max);
> 
> This pachset looks good to me. While we observed a unexpected case,
> where a reserved region cross the high and low meomry region. I noticed
> Catalin has pointed that out. Even with the suggested code, we could
> have the kernel parameters like: crashkernel=512M,high
> crashkernel=128M,low, we finally have [4G-126M, 4G+386M], [1G, 1G+128M]
> regions in running kernel. This looks strange.

Is high-end memory fragmented? Add boot option memblock=debug and watch?

> 
> I am wondering if we can specify explicit search_base in
> memblock_phys_alloc_range() to avoid above case. Like this,
> crashkernel,high region will only exist in high memory, crashkernel,low
> region only exists in low memory region. I made a draft patch based on
> this patchset to present what the code looks like.

Looks good to me.

> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 58a0bb2c17f1..fd9d35e17a62 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -127,7 +127,7 @@ static int __init reserve_crashkernel_low(unsigned long long low_size)
>   */
>  static void __init reserve_crashkernel(void)
>  {
> -	unsigned long long crash_base, crash_size;
> +	unsigned long long crash_base, crash_size, search_base;

search_base needs to be initialized to 0.

>  	unsigned long long crash_low_size = 0;
>  	unsigned long long crash_max = CRASH_ADDR_LOW_MAX;
>  	char *cmdline = boot_command_line;
> @@ -155,6 +155,7 @@ static void __init reserve_crashkernel(void)
>  		else if (ret)
>  			return;
>  
> +		search_base = CRASH_ADDR_LOW_MAX;
>  		crash_max = CRASH_ADDR_HIGH_MAX;
>  	} else if (ret || !crash_size) {
>  		/* The specified value is invalid */
> @@ -166,12 +167,13 @@ static void __init reserve_crashkernel(void)
>  	/* User specifies base address explicitly. */
>  	if (crash_base) {
>  		fixed_base = true;
> +		search_base = crash_base;
>  		crash_max = crash_base + crash_size;
>  	}
>  
>  retry:
>  	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
> -					       crash_base, crash_max);
> +					       search_base, crash_max);
>  	if (!crash_base) {
>  		/*
>  		 * If the first attempt was for low memory, fall back to
> @@ -180,6 +182,7 @@ static void __init reserve_crashkernel(void)
>  		 */
>  		if (!fixed_base && (crash_max == CRASH_ADDR_LOW_MAX)) {
>  			crash_max = CRASH_ADDR_HIGH_MAX;
> +			search_base = CRASH_ADDR_LOW_MAX;
>  			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
>  			goto retry;
>  		}
> @@ -189,7 +192,7 @@ static void __init reserve_crashkernel(void)
>  		return;
>  	}
>  
> -	if ((crash_base > CRASH_ADDR_LOW_MAX - crash_low_size) &&
> +	if ((crash_base > CRASH_ADDR_LOW_MAX) &&
>  	     crash_low_size && reserve_crashkernel_low(crash_low_size)) {
>  		memblock_phys_free(crash_base, crash_size);
>  		return;
> 
> .
> 

-- 
Regards,
  Zhen Lei
