Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA98A6A7A13
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 04:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjCBDdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 22:33:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCBDdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 22:33:01 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60C283FD
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 19:32:58 -0800 (PST)
Received: from dggpemm500006.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PRxSS15SbzfbPn;
        Thu,  2 Mar 2023 11:30:16 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 2 Mar 2023 11:32:56 +0800
Subject: Re: [PATCH v3] arm64: kdump: simplify the reservation behaviour of
 crashkernel=,high
To:     Baoquan He <bhe@redhat.com>, <linux-kernel@vger.kernel.org>
CC:     <catalin.marinas@arm.com>, <horms@kernel.org>,
        <John.p.donnelly@oracle.com>, <will@kernel.org>,
        <kexec@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>
References: <20230223124532.128744-1-bhe@redhat.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <7971ddbe-aefb-271e-647c-59d81c5840a7@huawei.com>
Date:   Thu, 2 Mar 2023 11:32:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20230223124532.128744-1-bhe@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/2/23 20:45, Baoquan He wrote:
> On arm64, reservation for 'crashkernel=xM,high' is taken by searching for
> suitable memory region top down. If the 'xM' of crashkernel high memory
> is reserved from high memory successfully, it will try to reserve
> crashkernel low memory later accoringly. Otherwise, it will try to search
> low memory area for the 'xM' suitable region. Please see the details in
> Documentation/admin-guide/kernel-parameters.txt.
> 
> While we observed an unexpected case where a reserved region crosses the
> high and low meomry boundary. E.g on a system with 4G as low memory end,
> user added the kernel parameters like: 'crashkernel=512M,high', it could
> finally have [4G-126M, 4G+386M], [1G, 1G+128M] regions in running kernel.
> The crashkernel high region crossing low and high memory boudary will bring
> issues:
> 
> 1) For crashkernel=x,high, if getting crashkernel high region across
> low and high memory boundary, then user will see two memory regions in
> low memory, and one memory region in high memory. The two crashkernel
> low memory regions are confusing as shown in above example.
> 
> 2) If people explicityly specify "crashkernel=x,high crashkernel=y,low"
> and y <= 128M, when crashkernel high region crosses low and high memory
> boundary and the part of crashkernel high reservation below boundary is
> bigger than y, the expected crahskernel low reservation will be skipped.
> But the expected crashkernel high reservation is shrank and could not
> satisfy user space requirement.
> 
> 3) The crossing boundary behaviour of crahskernel high reservation is
> different than x86 arch. On x86_64, the low memory end is 4G fixedly,
> and the memory near 4G is reserved by system, e.g for mapping firmware,
> pci mapping, so the crashkernel reservation crossing boundary never happens.
>>From distros point of view, this brings inconsistency and confusion. Users
> need to dig into x86 and arm64 system details to find out why.
> 
> For kernel itself, the impact of issue 3) could be slight. While issue
> 1) and 2) cause actual impact because it brings obscure semantics and
> behaviour to crashkernel=,high reservation.
> 
> Here, for crashkernel=xM,high, search the high memory for the suitable
> region only in high memory. If failed, try reserving the suitable
> region only in low memory. Like this, the crashkernel high region will
> only exist in high memory, and crashkernel low region only exists in low
> memory. The reservation behaviour for crashkernel=,high is clearer and
> simpler.
> 
> Note: On arm64, the high and low memory boudary could be 1G if it's RPi4
> system, or 4G if other normal systems.

There are two minor review comments, see below. Otherwise:

Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>

> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
> v2->v3:
>  - Rephrase patch log to clarify the current crashkernel high
>    reservation could cross the high and low memory boundary, but not 
>    4G boundary only, because RPi4 of arm64 has high and low memory
>    boudary as 1G. The v3 patch log could mislead people that the RPi4
>    also use 4G as high,low memory boundary.
> v1->v2:
>  - Fold patch 2 of v1 into patch 1 for better reviewing.
>  - Update patch log to add more details.
>  arch/arm64/mm/init.c | 43 +++++++++++++++++++++++++++++++++----------
>  1 file changed, 33 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 58a0bb2c17f1..b8cb780df0cb 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -127,12 +127,13 @@ static int __init reserve_crashkernel_low(unsigned long long low_size)
>   */
>  static void __init reserve_crashkernel(void)
>  {
> -	unsigned long long crash_base, crash_size;
> -	unsigned long long crash_low_size = 0;
> +	unsigned long long crash_base, crash_size, search_base;
>  	unsigned long long crash_max = CRASH_ADDR_LOW_MAX;
> +	unsigned long long crash_low_size = 0;
>  	char *cmdline = boot_command_line;
> -	int ret;
>  	bool fixed_base = false;
> +	bool high = false;
> +	int ret;
>  
>  	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
>  		return;
> @@ -155,7 +156,9 @@ static void __init reserve_crashkernel(void)
>  		else if (ret)
>  			return;
>  
> +		search_base = CRASH_ADDR_LOW_MAX;
>  		crash_max = CRASH_ADDR_HIGH_MAX;
> +		high = true;
>  	} else if (ret || !crash_size) {
>  		/* The specified value is invalid */
>  		return;
> @@ -166,31 +169,51 @@ static void __init reserve_crashkernel(void)
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
> -		 * If the first attempt was for low memory, fall back to
> -		 * high memory, the minimum required low memory will be
> -		 * reserved later.
> +		 * For crashkernel=size[KMG]@offset[KMG], print out failure
> +		 * message if can't reserve the specified region.
>  		 */
> -		if (!fixed_base && (crash_max == CRASH_ADDR_LOW_MAX)) {
> +		if (fixed_base) {
> +			pr_info("crashkernel reservation failed - memory is in use.\n");

How about changing pr_info to pr_warn?

> +			return;
> +		}
> +
> +		/*
> +		 * For crashkernel=size[KMG], if the first attempt was for
> +		 * low memory, fall back to high memory, the minimum required
> +		 * low memory will be reserved later.
> +		 */
> +		if (!high && crash_max == CRASH_ADDR_LOW_MAX) {
>  			crash_max = CRASH_ADDR_HIGH_MAX;
> +			search_base = CRASH_ADDR_LOW_MAX;
>  			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
>  			goto retry;
>  		}
>  
> +		/*
> +		 * For crashkernel=size[KMG],high, if the first attempt was
> +		 * for high memory, fall back to low memory.
> +		 */
> +		if (high && crash_max == CRASH_ADDR_HIGH_MAX) {

Adding unlikely to indicate that it is rare would be better.

if (unlikely(high && crash_max == CRASH_ADDR_HIGH_MAX))

> +			crash_max = CRASH_ADDR_LOW_MAX;
> +			search_base = 0;
> +			goto retry;
> +		}
>  		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
>  			crash_size);
>  		return;
>  	}
>  
> -	if ((crash_base > CRASH_ADDR_LOW_MAX - crash_low_size) &&
> -	     crash_low_size && reserve_crashkernel_low(crash_low_size)) {
> +	if ((crash_base >= CRASH_ADDR_LOW_MAX) && crash_low_size &&
> +	     reserve_crashkernel_low(crash_low_size)) {
>  		memblock_phys_free(crash_base, crash_size);
>  		return;
>  	}
> 

-- 
Regards,
  Zhen Lei
