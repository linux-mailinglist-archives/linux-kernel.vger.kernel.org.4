Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F126917E1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 06:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbjBJFIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 00:08:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjBJFIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 00:08:20 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7035C4BC;
        Thu,  9 Feb 2023 21:08:17 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PChZj6hzVz4xwy;
        Fri, 10 Feb 2023 16:08:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1676005696;
        bh=gjOEhpmQ4QzYiJxNRSCplO6mzBIo8CgdHMudas4f4m4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=VzBHDakF5oapgbqSwyCXW4NlOxuhWIXgHT5bnjksmwxnwzB2j77QlwtNy9auFKO5k
         R5zuzvTLv5v6JR0g4zAQSDALbGO0+HtyCcaxIv+XCmtUOUNdsZXpr/60HJ8m0se9Ac
         HCqPfRmHl1K9cRm2zGL0JLt1dLbvDoohuA4JmvWcFN0J1XTPyIZXfr0n3q8zPBgbwM
         2KTETWI8PkOX6ZP5se3LmuOaFIoUbfwmRFq7s/gffXRM+ntl6Tsz8s7uIuoBncovYH
         169scsrJUZSYlGwI60JQl2lk38JbvV/eRPo8tLjsBgWQeltv5kZiHwGm5Gqurl9z/4
         hTaeq+aYRbc4A==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        x86@kernel.org, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        David Hildenbrand <david@redhat.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH mm-unstable v1 17/26] powerpc/mm: support
 __HAVE_ARCH_PTE_SWP_EXCLUSIVE on 32bit book3s
In-Reply-To: <20230113171026.582290-18-david@redhat.com>
References: <20230113171026.582290-1-david@redhat.com>
 <20230113171026.582290-18-david@redhat.com>
Date:   Fri, 10 Feb 2023 16:08:07 +1100
Message-ID: <87cz6iw1jc.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Hildenbrand <david@redhat.com> writes:
> We already implemented support for 64bit book3s in commit bff9beaa2e80
> ("powerpc/pgtable: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE for book3s")
>
> Let's support __HAVE_ARCH_PTE_SWP_EXCLUSIVE also in 32bit by reusing yet
> unused LSB 2 / MSB 29. There seems to be no real reason why that bit cannot
> be used, and reusing it avoids having to steal one bit from the swap
> offset.
>
> While at it, mask the type in __swp_entry().
>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/powerpc/include/asm/book3s/32/pgtable.h | 38 +++++++++++++++++---
>  1 file changed, 33 insertions(+), 5 deletions(-)

I gave this a quick test on a ppc32 machine, everything seems fine.

Your test_swp_exclusive.c passes, and an LTP run looks normal.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers

> diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
> index 75823f39e042..0ecb3a58f23f 100644
> --- a/arch/powerpc/include/asm/book3s/32/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
> @@ -42,6 +42,9 @@
>  #define _PMD_PRESENT_MASK (PAGE_MASK)
>  #define _PMD_BAD	(~PAGE_MASK)
>  
> +/* We borrow the _PAGE_USER bit to store the exclusive marker in swap PTEs. */
> +#define _PAGE_SWP_EXCLUSIVE	_PAGE_USER
> +
>  /* And here we include common definitions */
>  
>  #define _PAGE_KERNEL_RO		0
> @@ -363,17 +366,42 @@ static inline void __ptep_set_access_flags(struct vm_area_struct *vma,
>  #define pmd_page(pmd)		pfn_to_page(pmd_pfn(pmd))
>  
>  /*
> - * Encode and decode a swap entry.
> - * Note that the bits we use in a PTE for representing a swap entry
> - * must not include the _PAGE_PRESENT bit or the _PAGE_HASHPTE bit (if used).
> - *   -- paulus
> + * Encode/decode swap entries and swap PTEs. Swap PTEs are all PTEs that
> + * are !pte_none() && !pte_present().
> + *
> + * Format of swap PTEs (32bit PTEs):
> + *
> + *                         1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 2 2 3 3
> + *   0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
> + *   <----------------- offset --------------------> < type -> E H P
> + *
> + *   E is the exclusive marker that is not stored in swap entries.
> + *   _PAGE_PRESENT (P) and __PAGE_HASHPTE (H) must be 0.
> + *
> + * For 64bit PTEs, the offset is extended by 32bit.
>   */
>  #define __swp_type(entry)		((entry).val & 0x1f)
>  #define __swp_offset(entry)		((entry).val >> 5)
> -#define __swp_entry(type, offset)	((swp_entry_t) { (type) | ((offset) << 5) })
> +#define __swp_entry(type, offset)	((swp_entry_t) { ((type) & 0x1f) | ((offset) << 5) })
>  #define __pte_to_swp_entry(pte)		((swp_entry_t) { pte_val(pte) >> 3 })
>  #define __swp_entry_to_pte(x)		((pte_t) { (x).val << 3 })
>  
> +#define __HAVE_ARCH_PTE_SWP_EXCLUSIVE
> +static inline int pte_swp_exclusive(pte_t pte)
> +{
> +	return pte_val(pte) & _PAGE_SWP_EXCLUSIVE;
> +}
> +
> +static inline pte_t pte_swp_mkexclusive(pte_t pte)
> +{
> +	return __pte(pte_val(pte) | _PAGE_SWP_EXCLUSIVE);
> +}
> +
> +static inline pte_t pte_swp_clear_exclusive(pte_t pte)
> +{
> +	return __pte(pte_val(pte) & ~_PAGE_SWP_EXCLUSIVE);
> +}
> +
>  /* Generic accessors to PTE bits */
>  static inline int pte_write(pte_t pte)		{ return !!(pte_val(pte) & _PAGE_RW);}
>  static inline int pte_read(pte_t pte)		{ return 1; }
> -- 
> 2.39.0
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
