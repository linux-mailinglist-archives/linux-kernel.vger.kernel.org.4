Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C55B72E7B4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 17:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240934AbjFMP6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 11:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235140AbjFMP6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 11:58:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFF6E79;
        Tue, 13 Jun 2023 08:58:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54100629A6;
        Tue, 13 Jun 2023 15:58:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 710A6C433D9;
        Tue, 13 Jun 2023 15:58:28 +0000 (UTC)
Date:   Tue, 13 Jun 2023 16:58:25 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>
Subject: Re: linux-next: build failure after merge of the mm tree
Message-ID: <ZIiSITqP1cXkR8Uz@arm.com>
References: <20230613162119.4a7a7d3c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613162119.4a7a7d3c@canb.auug.org.au>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Tue, Jun 13, 2023 at 04:21:19PM +1000, Stephen Rothwell wrote:
> After merging the mm tree, today's linux-next build (powerpc
> ppc44x_defconfig) failed like this:
> 
> In file included from arch/powerpc/include/asm/page.h:247,
>                  from arch/powerpc/include/asm/thread_info.h:13,
>                  from include/linux/thread_info.h:60,
>                  from include/asm-generic/preempt.h:5,
>                  from ./arch/powerpc/include/generated/asm/preempt.h:1,
>                  from include/linux/preempt.h:78,
>                  from include/linux/spinlock.h:56,
>                  from include/linux/ipc.h:5,
>                  from include/uapi/linux/sem.h:5,
>                  from include/linux/sem.h:5,
>                  from include/linux/compat.h:14,
>                  from arch/powerpc/kernel/asm-offsets.c:12:
> arch/powerpc/include/asm/page_32.h:16: warning: "ARCH_DMA_MINALIGN" redefined
>    16 | #define ARCH_DMA_MINALIGN       L1_CACHE_BYTES
>       | 
> In file included from include/linux/time.h:5,
>                  from include/linux/compat.h:10:
> include/linux/cache.h:104: note: this is the location of the previous definition
>   104 | #define ARCH_DMA_MINALIGN __alignof__(unsigned long long)
>       | 
> 
> (lots of theses)
> 
> Caused by commit
> 
>   cc7335787e73 ("mm/slab: decouple ARCH_KMALLOC_MINALIGN from ARCH_DMA_MINALIGN")
> 
> I have applied the following hack for today - we need something better.

I just posted this series fixing it for powerpc, microblaze and sh. I
did not add the #ifndef __powerpc64__ line since
CONFIG_NOT_COHERENT_CACHE should not be enabled for those builds.

https://lore.kernel.org/r/20230613155245.1228274-1-catalin.marinas@arm.com

> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Tue, 13 Jun 2023 16:07:16 +1000
> Subject: [PATCH] fix up for "mm/slab: decouple ARCH_KMALLOC_MINALIGN from ARCH_DMA_MINALIGN"
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  arch/powerpc/include/asm/cache.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/cache.h b/arch/powerpc/include/asm/cache.h
> index ae0a68a838e8..e9be1396dfd1 100644
> --- a/arch/powerpc/include/asm/cache.h
> +++ b/arch/powerpc/include/asm/cache.h
> @@ -142,5 +142,14 @@ static inline void iccci(void *addr)
>  }
>  
>  #endif /* !__ASSEMBLY__ */
> +
> +#ifndef __powerpc64__
> +#ifdef CONFIG_NOT_COHERENT_CACHE
> +#ifndef ARCH_DMA_MINALIGN
> +#define ARCH_DMA_MINALIGN	L1_CACHE_BYTES
> +#endif
> +#endif
> +#endif
> +
>  #endif /* __KERNEL__ */
>  #endif /* _ASM_POWERPC_CACHE_H */

I think it should also remove the ARCH_DMA_MINALIGN from asm/page.h (as
I did in my series; sorry I did not cc you, only noticed now that you
reported it as well).

-- 
Catalin
