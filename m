Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9406EFF45
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 04:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242894AbjD0CPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 22:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242797AbjD0CO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 22:14:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5813C38
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 19:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682561609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QDBq73uOalrM4tKroB29WOkkL6N6HI1enBv2lSURmmI=;
        b=Y8+Mbm0HL9WvAQLUs5QFDTwEQJo6iBJatygUM+pVdPOVTKb6qBZI4X+6Q5Map+2UuEsC/7
        8K0rSnPTlcxvk3m9r7svG2DgnK0DbvaVuj8/b8fBzVwLCCaNDDfF7uN24MYZkLOF5Srel5
        UbarUQQE6/TAbkflc/az5riPqE4d8pE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-610-8zon_suPN4Oswz06NwHtTA-1; Wed, 26 Apr 2023 22:13:25 -0400
X-MC-Unique: 8zon_suPN4Oswz06NwHtTA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A27FD8828C2;
        Thu, 27 Apr 2023 02:13:24 +0000 (UTC)
Received: from localhost (ovpn-12-30.pek2.redhat.com [10.72.12.30])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 59462492B03;
        Thu, 27 Apr 2023 02:13:22 +0000 (UTC)
Date:   Thu, 27 Apr 2023 10:13:19 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Chen Jiahao <chenjiahao16@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        conor.dooley@microchip.com, guoren@kernel.org, heiko@sntech.de,
        bjorn@rivosinc.com, alex@ghiti.fr, akpm@linux-foundation.org,
        atishp@rivosinc.com, thunder.leizhen@huawei.com, horms@kernel.org
Subject: Re: [PATCH -next v4 1/2] riscv: kdump: Implement
 crashkernel=X,[high,low]
Message-ID: <ZEnaPzx3O9NWixIR@MiWiFi-R3L-srv>
References: <20230410130553.3226347-1-chenjiahao16@huawei.com>
 <20230410130553.3226347-2-chenjiahao16@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230410130553.3226347-2-chenjiahao16@huawei.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/23 at 09:05pm, Chen Jiahao wrote:
> On riscv, the current crash kernel allocation logic is trying to
> allocate within 32bit addressible memory region by default, if
> failed, try to allocate without 4G restriction.
> 
> In need of saving DMA zone memory while allocating a relatively large
> crash kernel region, allocating the reserved memory top down in
> high memory, without overlapping the DMA zone, is a mature solution.
> Here introduce the parameter option crashkernel=X,[high,low].
> 
> One can reserve the crash kernel from high memory above DMA zone range
> by explicitly passing "crashkernel=X,high"; or reserve a memory range
> below 4G with "crashkernel=X,low".
> 
> Signed-off-by: Chen Jiahao <chenjiahao16@huawei.com>
> Acked-by: Guo Ren <guoren@kernel.org>
> Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  arch/riscv/kernel/setup.c |  5 +++
>  arch/riscv/mm/init.c      | 71 ++++++++++++++++++++++++++++++++++++---
>  2 files changed, 71 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index 5d3184cbf518..ea84e5047c23 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -176,6 +176,11 @@ static void __init init_resources(void)
>  		if (ret < 0)
>  			goto error;
>  	}
> +	if (crashk_low_res.start != crashk_low_res.end) {
> +		ret = add_resource(&iomem_resource, &crashk_low_res);
> +		if (ret < 0)
> +			goto error;
> +	}
>  #endif
>  
>  #ifdef CONFIG_CRASH_DUMP
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 478d6763a01a..70f6cb281ed1 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -1152,6 +1152,28 @@ static inline void setup_vm_final(void)
>  }
>  #endif /* CONFIG_MMU */
>  
> +/* Reserve 128M low memory by default for swiotlb buffer */
> +#define DEFAULT_CRASH_KERNEL_LOW_SIZE	(128UL << 20)
> +
> +static int __init reserve_crashkernel_low(unsigned long long low_size)
> +{
> +	unsigned long long low_base;
> +
> +	low_base = memblock_phys_alloc_range(low_size, PMD_SIZE, 0, dma32_phys_limit);
> +	if (!low_base) {
> +		pr_err("cannot allocate crashkernel low memory (size:0x%llx).\n", low_size);
> +		return -ENOMEM;
> +	}
> +
> +	pr_info("crashkernel low memory reserved: 0x%016llx - 0x%016llx (%lld MB)\n",
> +		low_base, low_base + low_size, low_size >> 20);
> +
> +	crashk_low_res.start = low_base;
> +	crashk_low_res.end = low_base + low_size - 1;
> +
> +	return 0;
> +}
> +
>  /*
>   * reserve_crashkernel() - reserves memory for crash kernel
>   *
> @@ -1163,8 +1185,12 @@ static void __init reserve_crashkernel(void)
>  {
>  	unsigned long long crash_base = 0;
>  	unsigned long long crash_size = 0;
> +	unsigned long long crash_low_size = 0;
>  	unsigned long search_start = memblock_start_of_DRAM();
>  	unsigned long search_end = memblock_end_of_DRAM();
> +	unsigned long search_low_max = (unsigned long)dma32_phys_limit;
> +	char *cmdline = boot_command_line;
> +	bool fixed_base = false;
>  
>  	int ret = 0;
>  
> @@ -1180,14 +1206,34 @@ static void __init reserve_crashkernel(void)
>  		return;
>  	}
>  
> -	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
> +	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
>  				&crash_size, &crash_base);
> -	if (ret || !crash_size)
> +	if (ret == -ENOENT) {
> +		/* Fallback to crashkernel=X,[high,low] */
> +		ret = parse_crashkernel_high(cmdline, 0, &crash_size, &crash_base);
> +		if (ret || !crash_size)
> +			return;
> +
> +		/*
> +		 * crashkernel=Y,low is valid only when crashkernel=X,high
> +		 * is passed.
> +		 */
> +		ret = parse_crashkernel_low(cmdline, 0, &crash_low_size, &crash_base);
> +		if (ret == -ENOENT)
> +			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
> +		else if (ret)
> +			return;
> +
> +		search_start = search_low_max;
> +	} else if (ret || !crash_size) {
> +		/* Invalid argument value specified */
>  		return;
> +	}
>  
>  	crash_size = PAGE_ALIGN(crash_size);
>  
>  	if (crash_base) {
> +		fixed_base = true;
>  		search_start = crash_base;
>  		search_end = crash_base + crash_size;
>  	}
> @@ -1201,16 +1247,31 @@ static void __init reserve_crashkernel(void)
>  	 */
>  	crash_base = memblock_phys_alloc_range(crash_size, PMD_SIZE,
>  					       search_start,
> -					       min(search_end, (unsigned long) SZ_4G));
> +					       min(search_end, search_low_max));

Here, it seems not right in case crashkernel=,high is specified. In that
case, search_start == search_low_max, then the min(search_end,
search_low_max) will get search_low_max too. Then you make the fallback
in below code block to try to get crashkernel reservation above 4G. This
doesn't comply with the crashkernel=,high grammer which has been
implemented in other architectures.

For crashkernel=,high, user explicitly require memory reservation above
4G. Why does crashkernel=,high is needed? E.g on big end server with
huge memory, while the low memory under 4G is limited and precious.
Hence, user want to put the main crashkernel reservation above 4G to
contain kdump kernel/initrd and run user space program, while with few
low memory for pci device driver. E.g crashkernel=2G,high, it won't
impact much if there's huge memory above 4G and get crashkernel
reservation there. However, it impacts a lot if it reserves memory
below 4G.

I would strongly suggest that risc-v also reserve memory from above 4G
for crashkernel=,high, then fallback to below 4G. That's consistent with
crashkernel=,high grammer.

>  	if (crash_base == 0) {
> -		/* Try again without restricting region to 32bit addressible memory */
> +		if (fixed_base) {
> +			pr_warn("crashkernel: allocating failed with given size@offset\n");
> +			return;
> +		}
> +
> +		/* Try again above the region of 32bit addressible memory */
>  		crash_base = memblock_phys_alloc_range(crash_size, PMD_SIZE,
> -						search_start, search_end);
> +						       max(search_start, search_low_max),
> +						       search_end);
>  		if (crash_base == 0) {
>  			pr_warn("crashkernel: couldn't allocate %lldKB\n",
>  				crash_size >> 10);
>  			return;
>  		}
> +
> +		if (!crash_low_size)
> +			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
> +	}
> +
> +	if ((crash_base > dma32_phys_limit - crash_low_size) &&
> +	    crash_low_size && reserve_crashkernel_low(crash_low_size)) {
> +		memblock_phys_free(crash_base, crash_size);
> +		return;
>  	}
>  
>  	pr_info("crashkernel: reserved 0x%016llx - 0x%016llx (%lld MB)\n",
> -- 
> 2.31.1
> 

