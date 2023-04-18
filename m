Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 135136E5D6D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 11:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbjDRJbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 05:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjDRJbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 05:31:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AA2F37686
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 02:31:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B1439168F;
        Tue, 18 Apr 2023 02:32:21 -0700 (PDT)
Received: from [10.1.27.157] (C02CF1NRLVDN.cambridge.arm.com [10.1.27.157])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 289DE3F5A1;
        Tue, 18 Apr 2023 02:31:35 -0700 (PDT)
Message-ID: <775d92fc-9195-88bf-4a1c-51b74185c07d@arm.com>
Date:   Tue, 18 Apr 2023 10:31:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH v3 34/60] arm64: head: Move early kernel mapping routines
 into C code
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Kees Cook <keescook@chromium.org>
References: <20230307140522.2311461-1-ardb@kernel.org>
 <20230307140522.2311461-35-ardb@kernel.org>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20230307140522.2311461-35-ardb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2023 14:04, Ard Biesheuvel wrote:
> The asm version of the kernel mapping code works fine for creating a
> coarse grained identity map, but for mapping the kernel down to its
> exact boundaries with the right attributes, it is not suitable. This is
> why we create a preliminary RWX kernel mapping first, and then rebuild
> it from scratch later on.
> 
> So let's reimplement this in C, in a way that will make it unnecessary
> to create the kernel page tables yet another time in paging_init().
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---

> [...]

> diff --git a/arch/arm64/kernel/pi/map_kernel.c b/arch/arm64/kernel/pi/map_kernel.c
> new file mode 100644
> index 0000000000000000..b573c964c7d88d1b
> --- /dev/null
> +++ b/arch/arm64/kernel/pi/map_kernel.c
> @@ -0,0 +1,171 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +// Copyright 2023 Google LLC
> +// Author: Ard Biesheuvel <ardb@google.com>
> +
> +#include <linux/init.h>
> +#include <linux/libfdt.h>
> +#include <linux/linkage.h>
> +#include <linux/types.h>
> +#include <linux/sizes.h>
> +#include <linux/string.h>
> +
> +#include <asm/memory.h>
> +#include <asm/pgalloc.h>
> +#include <asm/pgtable.h>
> +#include <asm/tlbflush.h>
> +
> +#include "pi.h"
> +
> +extern const u8 __eh_frame_start[], __eh_frame_end[];
> +
> +extern void idmap_cpu_replace_ttbr1(void *pgdir);
> +
> +static void map_segment(pgd_t *pg_dir, u64 *pgd, u64 va_offset,
> +			void *start, void *end, pgprot_t prot,
> +			bool may_use_cont, int root_level)
> +{
> +	map_range(pgd, ((u64)start + va_offset) & ~PAGE_OFFSET,
> +		  ((u64)end + va_offset) & ~PAGE_OFFSET, (u64)start,
> +		  prot, root_level, (pte_t *)pg_dir, may_use_cont, 0);

I don't understand what you are doing with ~PAGE_OFFSET here. Is this intended
to be page alignment with PAGE_MASK? I'm guessing not, because you would want to
forward align the end address in that case.

> +}
> +
> +static void unmap_segment(pgd_t *pg_dir, u64 va_offset, void *start,
> +			  void *end, int root_level)
> +{
> +	map_segment(pg_dir, NULL, va_offset, start, end, __pgprot(0),
> +		    false, root_level);
> +}
> +

> [...]

> diff --git a/arch/arm64/kernel/pi/map_range.c b/arch/arm64/kernel/pi/map_range.c
> new file mode 100644
> index 0000000000000000..61cbd6e82418c033
> --- /dev/null
> +++ b/arch/arm64/kernel/pi/map_range.c
> @@ -0,0 +1,87 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +// Copyright 2023 Google LLC
> +// Author: Ard Biesheuvel <ardb@google.com>
> +
> +#include <linux/types.h>
> +#include <linux/sizes.h>
> +
> +#include <asm/memory.h>
> +#include <asm/pgalloc.h>
> +#include <asm/pgtable.h>
> +
> +#include "pi.h"
> +
> +/**
> + * map_range - Map a contiguous range of physical pages into virtual memory
> + *
> + * @pte:		Address of physical pointer to array of pages to
> + *			allocate page tables from
> + * @start:		Virtual address of the start of the range
> + * @end:		Virtual address of the end of the range (exclusive)
> + * @pa:			Physical address of the start of the range
> + * @level:		Translation level for the mapping
> + * @tbl:		The level @level page table to create the mappings in
> + * @may_use_cont:	Whether the use of the contiguous attribute is allowed
> + * @va_offset:		Offset between a physical page and its current mapping
> + * 			in the VA space
> + */
> +void __init map_range(u64 *pte, u64 start, u64 end, u64 pa, pgprot_t prot,
> +		      int level, pte_t *tbl, bool may_use_cont, u64 va_offset)

va_offset is always 0 (because the memory at *pte is id-mapped). Can it be
dropped? Or perhaps you are using this function later, once the memory is no
longer id-mapped?

> +{
> +	u64 cmask = (level == 3) ? CONT_PTE_SIZE - 1 : U64_MAX;
> +	u64 protval = pgprot_val(prot) & ~PTE_TYPE_MASK;
> +	int lshift = (3 - level) * (PAGE_SHIFT - 3);
> +	u64 lmask = (PAGE_SIZE << lshift) - 1;
> +
> +	start	&= PAGE_MASK;
> +	pa	&= PAGE_MASK;
> +

