Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E546C8A1A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 03:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbjCYCFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 22:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjCYCFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 22:05:32 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554C35BBE
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 19:05:30 -0700 (PDT)
Received: from dggpemm500006.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Pk2RJ4mFczKtNX;
        Sat, 25 Mar 2023 10:03:08 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sat, 25 Mar 2023 10:04:34 +0800
Subject: Re: [PATCH 3/3] arm64: kdump: defer the crashkernel reservation for
 platforms with no DMA memory zones
To:     Baoquan He <bhe@redhat.com>, <linux-kernel@vger.kernel.org>
CC:     <catalin.marinas@arm.com>, <horms@kernel.org>,
        <John.p.donnelly@oracle.com>, <will@kernel.org>,
        <kexec@lists.infradead.org>, <ardb@kernel.org>, <rppt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230324131838.409996-1-bhe@redhat.com>
 <20230324131838.409996-4-bhe@redhat.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <3653555d-3302-fc40-c917-963b029fc839@huawei.com>
Date:   Sat, 25 Mar 2023 10:04:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20230324131838.409996-4-bhe@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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
> In commit 031495635b46 ("arm64: Do not defer reserve_crashkernel() for
> platforms with no DMA memory zones"), reserve_crashkernel() is called
> much earlier in arm64_memblock_init() to avoid causing base apge
> mapping on platforms with no DMA meomry zones.
> 
> With taking off protection on crashkernel memory region, no need to call
> reserve_crashkernel() specially in advance. The deferred invocation of
> reserve_crashkernel() in bootmem_init() can cover all cases.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  arch/arm64/include/asm/memory.h | 5 -----
>  arch/arm64/mm/init.c            | 6 +-----
>  2 files changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index 78e5163836a0..efcd68154a3a 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -374,11 +374,6 @@ static inline void *phys_to_virt(phys_addr_t x)
>  })
>  
>  void dump_mem_limit(void);
> -
> -static inline bool defer_reserve_crashkernel(void)
> -{
> -	return IS_ENABLED(CONFIG_ZONE_DMA) || IS_ENABLED(CONFIG_ZONE_DMA32);
> -}
>  #endif /* !ASSEMBLY */
>  
>  /*
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 58a0bb2c17f1..b888de59e0b7 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -408,9 +408,6 @@ void __init arm64_memblock_init(void)
>  
>  	early_init_fdt_scan_reserved_mem();
>  
> -	if (!defer_reserve_crashkernel())
> -		reserve_crashkernel();
> -
>  	high_memory = __va(memblock_end_of_DRAM() - 1) + 1;
>  }
>  
> @@ -457,8 +454,7 @@ void __init bootmem_init(void)
>  	 * request_standard_resources() depends on crashkernel's memory being
>  	 * reserved, so do it here.
>  	 */
> -	if (defer_reserve_crashkernel())
> -		reserve_crashkernel();
> +	reserve_crashkernel();
>  
>  	memblock_dump_all();
>  }

Some comments also need to be deleted, above the definition of arm64_dma_phys_limit
in arch/arm64/mm/init.c

> 

-- 
Regards,
  Zhen Lei
