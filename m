Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCFFB6AC958
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 18:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbjCFRIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 12:08:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjCFRHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 12:07:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC185FE8E;
        Mon,  6 Mar 2023 09:07:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BE3C61044;
        Mon,  6 Mar 2023 17:06:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81A21C433D2;
        Mon,  6 Mar 2023 17:06:47 +0000 (UTC)
Date:   Mon, 6 Mar 2023 17:06:44 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-mips <linux-mips@vger.kernel.org>,
        linux-power <linuxppc-dev@lists.ozlabs.org>,
        linux-x86 <x86@kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Subject: Re: [PATCH] mm: add PTE pointer parameter to
 flush_tlb_fix_spurious_fault()
Message-ID: <ZAYdpLCxicptr4MJ@arm.com>
References: <20230306161548.661740-1-gerald.schaefer@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306161548.661740-1-gerald.schaefer@linux.ibm.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 05:15:48PM +0100, Gerald Schaefer wrote:
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index b6ba466e2e8a..0bd18de9fd97 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -57,7 +57,7 @@ static inline bool arch_thp_swp_supported(void)
>   * fault on one CPU which has been handled concurrently by another CPU
>   * does not need to perform additional invalidation.
>   */
> -#define flush_tlb_fix_spurious_fault(vma, address) do { } while (0)
> +#define flush_tlb_fix_spurious_fault(vma, address, ptep) do { } while (0)

For arm64:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

> diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
> index 2c70b4d1263d..c1f6b46ec555 100644
> --- a/arch/s390/include/asm/pgtable.h
> +++ b/arch/s390/include/asm/pgtable.h
> @@ -1239,7 +1239,8 @@ static inline int pte_allow_rdp(pte_t old, pte_t new)
>  }
>  
>  static inline void flush_tlb_fix_spurious_fault(struct vm_area_struct *vma,
> -						unsigned long address)
> +						unsigned long address,
> +						pte_t *ptep)
>  {
>  	/*
>  	 * RDP might not have propagated the PTE protection reset to all CPUs,
> @@ -1247,11 +1248,12 @@ static inline void flush_tlb_fix_spurious_fault(struct vm_area_struct *vma,
>  	 * NOTE: This will also be called when a racing pagetable update on
>  	 * another thread already installed the correct PTE. Both cases cannot
>  	 * really be distinguished.
> -	 * Therefore, only do the local TLB flush when RDP can be used, to avoid
> -	 * unnecessary overhead.
> +	 * Therefore, only do the local TLB flush when RDP can be used, and the
> +	 * PTE does not have _PAGE_PROTECT set, to avoid unnecessary overhead.
> +	 * A local RDP can be used to do the flush.
>  	 */
> -	if (MACHINE_HAS_RDP)
> -		asm volatile("ptlb" : : : "memory");
> +	if (MACHINE_HAS_RDP && !(pte_val(*ptep) & _PAGE_PROTECT))
> +		__ptep_rdp(address, ptep, 0, 0, 1);

I wonder whether passing the actual entry is somewhat quicker as it
avoids another memory access (though it might already be in the cache).

-- 
Catalin
