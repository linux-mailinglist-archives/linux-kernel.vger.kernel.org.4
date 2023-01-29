Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841FF67FC6D
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 03:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234449AbjA2Coh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 21:44:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbjA2Coe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 21:44:34 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEC3C66C
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 18:44:33 -0800 (PST)
Received: from dggpemm100009.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4P4FwB22MDz16Lx0;
        Sun, 29 Jan 2023 10:42:34 +0800 (CST)
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemm100009.china.huawei.com (7.185.36.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sun, 29 Jan 2023 10:44:31 +0800
Subject: Re: [PATCH RFC] arm64/vmalloc: use module region only for
 module_alloc() if CONFIG_RANDOMIZE_BASE is set
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
References: <20221227092634.445212-1-liushixin2@huawei.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
From:   Liu Shixin <liushixin2@huawei.com>
Message-ID: <b93ec55c-f6f0-274a-e7d6-edb419b4be8a@huawei.com>
Date:   Sun, 29 Jan 2023 10:44:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20221227092634.445212-1-liushixin2@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.24]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


This patch seems to have been lost in the corner. Recently I've meet this problem again

on v6.1, so I would like to propose this patch again.


Thanks,


On 2022/12/27 17:26, Liu Shixin wrote:
> After I add a 10GB pmem device, I got the following error message when
> insert module:
>
>  insmod: vmalloc error: size 16384, vm_struct allocation failed,
>  mode:0xcc0(GFP_KERNEL), nodemask=(null),cpuset=/,mems_allowed=0
>
> If CONFIG_RANDOMIZE_BASE is set, the module region can be located in the
> vmalloc region entirely. Although module_alloc() can fall back to a 2GB
> window if ARM64_MODULE_PLTS is set, the module region is still easily
> exhausted because the module region is located at bottom of vmalloc region
> and the vmalloc region is allocated from bottom to top.
>
> Skip module region if not calling from module_alloc().
>
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> ---
>  arch/arm64/include/asm/vmalloc.h | 26 ++++++++++++++++++++++++++
>  include/linux/vmalloc.h          |  9 +++++++++
>  mm/vmalloc.c                     |  4 ++++
>  3 files changed, 39 insertions(+)
>
> diff --git a/arch/arm64/include/asm/vmalloc.h b/arch/arm64/include/asm/vmalloc.h
> index 38fafffe699f..4feff546b11b 100644
> --- a/arch/arm64/include/asm/vmalloc.h
> +++ b/arch/arm64/include/asm/vmalloc.h
> @@ -31,4 +31,30 @@ static inline pgprot_t arch_vmap_pgprot_tagged(pgprot_t prot)
>  	return pgprot_tagged(prot);
>  }
>  
> +#ifdef CONFIG_RANDOMIZE_BASE
> +extern u64 module_alloc_base;
> +#define arch_vmap_skip_module_region arch_vmap_skip_module_region
> +static inline void arch_vmap_skip_module_region(unsigned long *addr,
> +						unsigned long vstart,
> +						unsigned long size,
> +						unsigned long align)
> +{
> +	u64 module_alloc_end = module_alloc_base + MODULES_VSIZE;
> +
> +	if (vstart == module_alloc_base)
> +		return;
> +
> +	if (IS_ENABLED(CONFIG_KASAN_GENERIC) ||
> +	    IS_ENABLED(CONFIG_KASAN_SW_TAGS))
> +		/* don't exceed the static module region - see module_alloc() */
> +		module_alloc_end = MODULES_END;
> +
> +	if ((module_alloc_base >= *addr + size) ||
> +	    (module_alloc_end <= *addr))
> +		return;
> +
> +	*addr = ALIGN(module_alloc_end, align);
> +}
> +#endif
> +
>  #endif /* _ASM_ARM64_VMALLOC_H */
> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> index 096d48aa3437..55ef97325b84 100644
> --- a/include/linux/vmalloc.h
> +++ b/include/linux/vmalloc.h
> @@ -122,6 +122,15 @@ static inline pgprot_t arch_vmap_pgprot_tagged(pgprot_t prot)
>  }
>  #endif
>  
> +#ifndef arch_vmap_skip_module_region
> +static inline void arch_vmap_skip_module_region(unsigned long *addr,
> +						unsigned long vstart,
> +						unsigned long size,
> +						unsigned long align)
> +{
> +}
> +#endif
> +
>  /*
>   *	Highlevel APIs for driver use
>   */
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index ca71de7c9d77..c840d673052e 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1236,6 +1236,8 @@ is_within_this_va(struct vmap_area *va, unsigned long size,
>  	else
>  		nva_start_addr = ALIGN(vstart, align);
>  
> +	arch_vmap_skip_module_region(&nva_start_addr, vstart, size, align);
> +
>  	/* Can be overflowed due to big size or alignment. */
>  	if (nva_start_addr + size < nva_start_addr ||
>  			nva_start_addr < vstart)
> @@ -1523,6 +1525,8 @@ __alloc_vmap_area(struct rb_root *root, struct list_head *head,
>  	else
>  		nva_start_addr = ALIGN(vstart, align);
>  
> +	arch_vmap_skip_module_region(&nva_start_addr, vstart, size, align);
> +
>  	/* Check the "vend" restriction. */
>  	if (nva_start_addr + size > vend)
>  		return vend;

