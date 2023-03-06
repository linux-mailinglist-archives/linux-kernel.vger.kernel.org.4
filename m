Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E0E6AD28C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 00:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjCFXMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 18:12:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjCFXMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 18:12:01 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276CD3B842;
        Mon,  6 Mar 2023 15:11:59 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PVvV227K5z4wgq;
        Tue,  7 Mar 2023 10:11:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1678144317;
        bh=Y3ZQe1v9yNGZGVZM7F5FvSpbccPl60HdWh6Jlu25Uj4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=G+Sab/KI7GAdy0Diebk6cQ/coHwcVMTqNmdTfQxYLnOVvsIndv9rl72OPozMBlYMe
         Va4LySAlFrcJ4TuVE14hxLaQ9JYQIiR9AN3z5EmgKmEhqBM84PEO4ZbGo1ccID9Ebm
         olatYOdWLf41Dqaq+qy1i05gpFdoTdeJAOtcfeC306+ClAa8E4O8DK+nUSlu+njFEP
         3auPTqQhaABfq8gsiySo+KUowhvu4Lg+vCfJuZixOxHqq5aDNDftd1HYeHD4cJAMK3
         cCAJXBNKuC0w0B7clhHf+fYnXLGSBv3I9wXVnnec+nGJu+XSzbMXBLpNjTD7lQWVdh
         VlwMZSuOylJmw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
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
In-Reply-To: <20230306161548.661740-1-gerald.schaefer@linux.ibm.com>
References: <20230306161548.661740-1-gerald.schaefer@linux.ibm.com>
Date:   Tue, 07 Mar 2023 10:11:53 +1100
Message-ID: <87mt4p1nly.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gerald Schaefer <gerald.schaefer@linux.ibm.com> writes:
> s390 can do more fine-grained handling of spurious TLB protection faults,
> when there also is the PTE pointer available.
>
> Therefore, pass on the PTE pointer to flush_tlb_fix_spurious_fault() as
> an additional parameter.
>
> This will add no functional change to other architectures, but those with
> private flush_tlb_fix_spurious_fault() implementations need to be made
> aware of the new parameter.
>
> Reviewed-by: Alexander Gordeev <agordeev@linux.ibm.com>
> Signed-off-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> ---
>  arch/arm64/include/asm/pgtable.h              |  2 +-
>  arch/mips/include/asm/pgtable.h               |  3 ++-
>  arch/powerpc/include/asm/book3s/64/tlbflush.h |  3 ++-
>  arch/s390/include/asm/pgtable.h               | 12 +++++++-----
>  arch/x86/include/asm/pgtable.h                |  2 +-
>  include/linux/pgtable.h                       |  2 +-
>  mm/memory.c                                   |  3 ++-
>  mm/pgtable-generic.c                          |  2 +-
>  8 files changed, 17 insertions(+), 12 deletions(-)
...
> diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush.h b/arch/powerpc/include/asm/book3s/64/tlbflush.h
> index 2bbc0fcce04a..ff7f0ee179e5 100644
> --- a/arch/powerpc/include/asm/book3s/64/tlbflush.h
> +++ b/arch/powerpc/include/asm/book3s/64/tlbflush.h
> @@ -121,7 +121,8 @@ static inline void flush_tlb_page(struct vm_area_struct *vma,
>  
>  #define flush_tlb_fix_spurious_fault flush_tlb_fix_spurious_fault
>  static inline void flush_tlb_fix_spurious_fault(struct vm_area_struct *vma,
> -						unsigned long address)
> +						unsigned long address,
> +						pte_t *ptep)
>  {
>  	/*
>  	 * Book3S 64 does not require spurious fault flushes because the PTE

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
