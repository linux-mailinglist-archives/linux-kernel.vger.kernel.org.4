Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C16446C8112
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 16:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbjCXPVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 11:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbjCXPVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 11:21:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FDF2132EC;
        Fri, 24 Mar 2023 08:21:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BD2FAB82498;
        Fri, 24 Mar 2023 15:21:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4A70C433A8;
        Fri, 24 Mar 2023 15:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679671279;
        bh=02GM7K6r27KRYha6EteRpwwTUBbmpkVxG9OyijKlG3g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fYn5+NeZtpXWi3nVp/4LLy8DH0H0ymzl9ykR3HGhR56lH3c2NdLc7Vq9e+nz6yGLM
         th3lEHNjAcHCBgVNwpsDAEfKQW4MaCEZmWtunHGlBnrfdjyrj6dtyckAVr4AytNWP5
         YoHlcyh9EHZLpMUfNtTxyT/IdQV32XFdbRz500HJrCQ7B2f3DEU8EIcFjArKBTNnl5
         ITOUHbY65mucoIZhCnBong68mCzbzpAFuGBESgTkskfci1G2VXWa9Q9j1pHIxiB916
         XgrZ1tXUn9nCbsGi93+pKgYS81I77gF95DX3iMV+WeX4Qo/HnMj3ISRhs917M91OiX
         +DMCYejfbkXNw==
Date:   Fri, 24 Mar 2023 15:21:13 +0000
From:   Will Deacon <will@kernel.org>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <anup@brainfault.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v8 3/4] arm64: Make use of memblock_isolate_memory for
 the linear mapping
Message-ID: <20230324152112.GD27199@willie-the-truck>
References: <20230316131711.1284451-1-alexghiti@rivosinc.com>
 <20230316131711.1284451-4-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230316131711.1284451-4-alexghiti@rivosinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 02:17:10PM +0100, Alexandre Ghiti wrote:
> In order to isolate the kernel text mapping and the crash kernel
> region, we used some sort of hack to isolate thoses ranges which consisted
> in marking them as not mappable with memblock_mark_nomap.
> 
> Simply use the newly introduced memblock_isolate_memory function which does
> exactly the same but does not uselessly mark the region as not mappable.

But that's not what this patch does -- it's also adding special-case code
for kexec and, honestly, I'm struggling to see why this is improving
anything.

Can we leave the code like it is, or is there something else going on?

Will

> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/arm64/mm/mmu.c | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 6f9d8898a025..387c2a065a09 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -548,19 +548,18 @@ static void __init map_mem(pgd_t *pgdp)
>  
>  	/*
>  	 * Take care not to create a writable alias for the
> -	 * read-only text and rodata sections of the kernel image.
> -	 * So temporarily mark them as NOMAP to skip mappings in
> -	 * the following for-loop
> +	 * read-only text and rodata sections of the kernel image so isolate
> +	 * those regions and map them after the for loop.
>  	 */
> -	memblock_mark_nomap(kernel_start, kernel_end - kernel_start);
> +	memblock_isolate_memory(kernel_start, kernel_end - kernel_start);
>  
>  #ifdef CONFIG_KEXEC_CORE
>  	if (crash_mem_map) {
>  		if (defer_reserve_crashkernel())
>  			flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
>  		else if (crashk_res.end)
> -			memblock_mark_nomap(crashk_res.start,
> -			    resource_size(&crashk_res));
> +			memblock_isolate_memory(crashk_res.start,
> +						resource_size(&crashk_res));
>  	}
>  #endif
>  
> @@ -568,6 +567,17 @@ static void __init map_mem(pgd_t *pgdp)
>  	for_each_mem_range(i, &start, &end) {
>  		if (start >= end)
>  			break;
> +
> +		if (start == kernel_start)
> +			continue;
> +
> +#ifdef CONFIG_KEXEC_CORE
> +		if (start == crashk_res.start &&
> +		    crash_mem_map && !defer_reserve_crashkernel() &&
> +		    crashk_res.end)
> +			continue;
> +#endif
> +
>  		/*
>  		 * The linear map must allow allocation tags reading/writing
>  		 * if MTE is present. Otherwise, it has the same attributes as
> @@ -589,7 +599,6 @@ static void __init map_mem(pgd_t *pgdp)
>  	 */
>  	__map_memblock(pgdp, kernel_start, kernel_end,
>  		       PAGE_KERNEL, NO_CONT_MAPPINGS);
> -	memblock_clear_nomap(kernel_start, kernel_end - kernel_start);
>  
>  	/*
>  	 * Use page-level mappings here so that we can shrink the region
> @@ -603,8 +612,6 @@ static void __init map_mem(pgd_t *pgdp)
>  				       crashk_res.end + 1,
>  				       PAGE_KERNEL,
>  				       NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS);
> -			memblock_clear_nomap(crashk_res.start,
> -					     resource_size(&crashk_res));
>  		}
>  	}
>  #endif
> -- 
> 2.37.2
> 
