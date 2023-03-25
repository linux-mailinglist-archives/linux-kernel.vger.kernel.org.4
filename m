Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4AE6C8A13
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 02:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbjCYB4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 21:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjCYB4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 21:56:46 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19459EFE
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 18:56:44 -0700 (PDT)
Received: from dggpemm500006.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Pk2FB6ZRYzKtMk;
        Sat, 25 Mar 2023 09:54:22 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sat, 25 Mar 2023 09:56:19 +0800
Subject: Re: [PATCH 1/3] arm64: kdump : take off the protection on crashkernel
 memory region
To:     Baoquan He <bhe@redhat.com>, <linux-kernel@vger.kernel.org>
CC:     <catalin.marinas@arm.com>, <horms@kernel.org>,
        <John.p.donnelly@oracle.com>, <will@kernel.org>,
        <kexec@lists.infradead.org>, <ardb@kernel.org>, <rppt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230324131838.409996-1-bhe@redhat.com>
 <20230324131838.409996-2-bhe@redhat.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <550d6152-492c-7f00-4680-9164db04b8fc@huawei.com>
Date:   Sat, 25 Mar 2023 09:56:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20230324131838.409996-2-bhe@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/24 21:18, Baoquan He wrote:
> Problem:
> =======
> On arm64, block and section mapping is supported to build page tables.
> However, currently it enforces to take base page mapping for the whole
> linear mapping if CONFIG_ZONE_DMA or CONFIG_ZONE_DMA32 is enabled and
> crashkernel kernel parameter is set. This will cause longer time of the
> linear mapping process during bootup and severe performance degradation
> during running time.
> 
> Root cause:
> ==========
> On arm64, crashkernel reservation relies on knowing the upper limit of
> low memory zone because it needs to reserve memory in the zone so that
> devices' DMA addressing in kdump kernel can be satisfied. However, the
> upper limit of low memory on arm64 is variant. And the upper limit can
> only be decided late till bootmem_init() is called [1].
> 
> And we need to map the crashkernel region with base page granularity when
> doing linear mapping, because kdump needs to protect the crashkernel region
> via set_memory_valid(,0) after kdump kernel loading. However, arm64 doesn't
> support well on splitting the built block or section mapping due to some
> cpu reststriction [2]. And unfortunately, the linear mapping is done before
> bootmem_init().
> 
> To resolve the above conflict on arm64, the compromise is enforcing to
> take base page mapping for the entire linear mapping if crashkernel is
> set, and CONFIG_ZONE_DMA or CONFIG_ZONE_DMA32 is enabed. Hence
> performance is sacrificed.
> 
> Solution:
> =========
> Comparing with the base page mapping for the whole linear region, it's
> better to take off the protection on crashkernel memory region for the
> time being because the anticipated stamping on crashkernel memory region
> could only happen in a chance in one million, while the base page mapping
> for the whole linear region is mitigating arm64 systems with crashkernel
> set always.
> 
> [1]
> https://lore.kernel.org/all/YrIIJkhKWSuAqkCx@arm.com/T/#u
> 
> [2]
> https://lore.kernel.org/linux-arm-kernel/20190911182546.17094-1-nsaenzjulienne@suse.de/T/
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  arch/arm64/include/asm/kexec.h    |  6 ------
>  arch/arm64/kernel/machine_kexec.c | 20 --------------------
>  2 files changed, 26 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
> index 559bfae26715..9ac9572a3bbe 100644
> --- a/arch/arm64/include/asm/kexec.h
> +++ b/arch/arm64/include/asm/kexec.h
> @@ -102,12 +102,6 @@ void cpu_soft_restart(unsigned long el2_switch, unsigned long entry,
>  
>  int machine_kexec_post_load(struct kimage *image);
>  #define machine_kexec_post_load machine_kexec_post_load
> -
> -void arch_kexec_protect_crashkres(void);
> -#define arch_kexec_protect_crashkres arch_kexec_protect_crashkres
> -
> -void arch_kexec_unprotect_crashkres(void);
> -#define arch_kexec_unprotect_crashkres arch_kexec_unprotect_crashkres
>  #endif
>  
>  #define ARCH_HAS_KIMAGE_ARCH
> diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
> index ce3d40120f72..22da7fc1ff50 100644
> --- a/arch/arm64/kernel/machine_kexec.c
> +++ b/arch/arm64/kernel/machine_kexec.c
> @@ -268,26 +268,6 @@ void machine_crash_shutdown(struct pt_regs *regs)
>  	pr_info("Starting crashdump kernel...\n");
>  }
>  
> -void arch_kexec_protect_crashkres(void)
> -{
> -	int i;
> -
> -	for (i = 0; i < kexec_crash_image->nr_segments; i++)
> -		set_memory_valid(
> -			__phys_to_virt(kexec_crash_image->segment[i].mem),
> -			kexec_crash_image->segment[i].memsz >> PAGE_SHIFT, 0);
> -}
> -
> -void arch_kexec_unprotect_crashkres(void)
> -{
> -	int i;
> -
> -	for (i = 0; i < kexec_crash_image->nr_segments; i++)
> -		set_memory_valid(
> -			__phys_to_virt(kexec_crash_image->segment[i].mem),
> -			kexec_crash_image->segment[i].memsz >> PAGE_SHIFT, 1);
> -}
> -
>  #ifdef CONFIG_HIBERNATION
>  /*
>   * To preserve the crash dump kernel image, the relevant memory segments
> 

Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>

-- 
Regards,
  Zhen Lei
