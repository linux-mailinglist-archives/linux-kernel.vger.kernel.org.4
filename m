Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD9787458C0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 11:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjGCJsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 05:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjGCJsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 05:48:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 80F4CDD
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 02:48:32 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF4EF1FB;
        Mon,  3 Jul 2023 02:49:14 -0700 (PDT)
Received: from [10.57.76.103] (unknown [10.57.76.103])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0970A3F762;
        Mon,  3 Jul 2023 02:48:28 -0700 (PDT)
Message-ID: <b994ff89-1a1f-26ca-9479-b08c77f94be8@arm.com>
Date:   Mon, 3 Jul 2023 10:48:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v1 11/14] arm64/mm: Wire up PTE_CONT for user mappings
To:     John Hubbard <jhubbard@nvidia.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Yu Zhao <yuzhao@google.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20230622144210.2623299-1-ryan.roberts@arm.com>
 <20230622144210.2623299-12-ryan.roberts@arm.com>
 <c7bc657b-c573-032e-f76c-f5c69198b2ff@nvidia.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <c7bc657b-c573-032e-f76c-f5c69198b2ff@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/06/2023 02:54, John Hubbard wrote:
> On 6/22/23 07:42, Ryan Roberts wrote:
>> With the ptep API sufficiently refactored, we can now introduce a new
>> "contpte" API layer, which transparently manages the PTE_CONT bit for
>> user mappings. Whenever it detects a set of PTEs that meet the
>> requirements for a contiguous range, the PTEs are re-painted with the
>> PTE_CONT bit.
>>
>> This initial change provides a baseline that can be optimized in future
>> commits. That said, fold/unfold operations (which imply tlb
>> invalidation) are avoided where possible with a few tricks for
>> access/dirty bit management.
>>
>> Write-enable and write-protect modifications are likely non-optimal and
>> likely incure a regression in fork() performance. This will be addressed
>> separately.
>>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
> 
> Hi Ryan!
> 
> While trying out the full series from your gitlab features/granule_perf/all
> branch, I found it necessary to EXPORT a symbol in order to build this.

Thanks for the bug report!

> Please see below:
> 
> ...
>> +
>> +pte_t contpte_ptep_get(pte_t *ptep, pte_t orig_pte)
>> +{
>> +    /*
>> +     * Gather access/dirty bits, which may be populated in any of the ptes
>> +     * of the contig range. We are guarranteed to be holding the PTL, so any
>> +     * contiguous range cannot be unfolded or otherwise modified under our
>> +     * feet.
>> +     */
>> +
>> +    pte_t pte;
>> +    int i;
>> +
>> +    ptep = contpte_align_down(ptep);
>> +
>> +    for (i = 0; i < CONT_PTES; i++, ptep++) {
>> +        pte = __ptep_get(ptep);
>> +
>> +        /*
>> +         * Deal with the partial contpte_ptep_get_and_clear_full() case,
>> +         * where some of the ptes in the range may be cleared but others
>> +         * are still to do. See contpte_ptep_get_and_clear_full().
>> +         */
>> +        if (pte_val(pte) == 0)
>> +            continue;
>> +
>> +        if (pte_dirty(pte))
>> +            orig_pte = pte_mkdirty(orig_pte);
>> +
>> +        if (pte_young(pte))
>> +            orig_pte = pte_mkyoung(orig_pte);
>> +    }
>> +
>> +    return orig_pte;
>> +}
> 
> Here we need something like this, in order to get it to build in all
> possible configurations:
> 
> EXPORT_SYMBOL_GPL(contpte_ptep_get);
> 
> (and a corresponding "#include linux/export.h" at the top of the file).
> 
> Because, the static inline functions invoke this routine, above.


A quick grep through the drivers directory shows:

ptep_get() is used by:
  - drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c
  - drivers/misc/sgi-gru/grufault.c
  - drivers/vfio/vfio_iommu_type1.c
  - drivers/xen/privcmd.c

ptep_set_at() is used by:
  - drivers/gpu/drm/i915/i915_mm.c
  - drivers/xen/xlate_mmu.c

None of the other symbols are called, but I guess it is possible that out of
tree modules are calling others.

So on the basis that these symbols were previously pure inline, I propose to
export all the contpte_* symbols using EXPORT_SYMBOL() so that anything that was
previously calling them successfully continue to do so. Will include in v2.

Thanks,
Ryan


> 
> thanks,

