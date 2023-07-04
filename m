Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9564A746E2B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 12:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbjGDKBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 06:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbjGDKBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 06:01:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D7B91F1
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 03:01:07 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8FF92F4;
        Tue,  4 Jul 2023 03:01:49 -0700 (PDT)
Received: from [10.163.47.48] (unknown [10.163.47.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 853503F73F;
        Tue,  4 Jul 2023 03:01:03 -0700 (PDT)
Message-ID: <c8bbc891-cd52-e34a-8ca7-76314e97cbe3@arm.com>
Date:   Tue, 4 Jul 2023 15:31:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC] arm64: properly define SOFT_DIRTY for arm64
Content-Language: en-US
To:     Nico Pache <npache@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     aquini@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>
References: <20230703135526.930004-1-npache@redhat.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20230703135526.930004-1-npache@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nico,

On 7/3/23 19:25, Nico Pache wrote:
> ARM64 has a soft-dirty bit (software dirty) but never properly defines
> CONFIG_ARCH_HAS_SOFT_DIRTY or its necessary functions. This patch
> introduces the ability to set/clear the soft dirty bit in a similar
> manner as the other arches that utilize it.
> 
> However, we must be careful... there are cases where the DBM bit is not
> available and the software dirty bit plays a essential role in determining
> whether or not a page is dirty. In these cases we must not allow the
> user to clear the software dirty bit. We can test for these cases by
> utilizing the arch_faults_on_old_pte() function which test the availability
> of DBM.

The current soft-dirty bit is a SW PTE bit i.e PTE_DIRTY, tracking PTE
dirtiness in absence of HW DBM support, although both these tracking
methods are very much intertwined. Current pte helpers like pte_dirty(),
pte_mkdirty(), pte_mkclean(), and pte_wrrotect() etc operate both on
HW and SW dirty tracking bits irrespective of whether DBM is supported
or not.

For soft dirty to work, we need a software PTE bit which sticks around
on the PTE entry until user space (only) clears it and above PTE_DIRTY
bit cannot be used for that purpose as it could be cleared in the kernel.

static inline pte_t pte_mkclean(pte_t pte)
{
        pte = clear_pte_bit(pte, __pgprot(PTE_DIRTY));
        pte = set_pte_bit(pte, __pgprot(PTE_RDONLY));

        return pte;
}

BTW arch_faults_on_old_pte() is no longer available mainline.

- Anshuman

> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> Cc: Liu Shixin <liushixin2@huawei.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Yu Zhao <yuzhao@google.com>
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>  arch/arm64/Kconfig               |  1 +
>  arch/arm64/include/asm/pgtable.h | 77 +++++++++++++++++++++++++++++++-
>  2 files changed, 76 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 891ab530a665..4de491627f49 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -173,6 +173,7 @@ config ARM64
>  	select HAVE_ARCH_PREL32_RELOCATIONS
>  	select HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
>  	select HAVE_ARCH_SECCOMP_FILTER
> +	select HAVE_ARCH_SOFT_DIRTY
>  	select HAVE_ARCH_STACKLEAK
>  	select HAVE_ARCH_THREAD_STRUCT_WHITELIST
>  	select HAVE_ARCH_TRACEHOOK
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 0bd18de9fd97..a0a15ffa2417 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -121,8 +121,9 @@ static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
>  })
>  
>  #define pte_hw_dirty(pte)	(pte_write(pte) && !(pte_val(pte) & PTE_RDONLY))
> -#define pte_sw_dirty(pte)	(!!(pte_val(pte) & PTE_DIRTY))
> -#define pte_dirty(pte)		(pte_sw_dirty(pte) || pte_hw_dirty(pte))
> +#define pte_soft_dirty(pte)	(!!(pte_val(pte) & PTE_DIRTY))
> +#define pte_dirty(pte)		(pte_soft_dirty(pte) || pte_hw_dirty(pte))
> +#define pte_swp_soft_dirty(pte)	pte_soft_dirty(pte)
>  
>  #define pte_valid(pte)		(!!(pte_val(pte) & PTE_VALID))
>  /*
> @@ -1096,6 +1097,78 @@ static inline bool pud_sect_supported(void)
>  	return PAGE_SIZE == SZ_4K;
>  }
>  
> +#ifdef CONFIG_ARM64_HW_AFDBM
> +/*
> + * if we have the DBM bit we can utilize the software dirty bit as
> + * a mechanism to introduce the soft_dirty functionality; however, without
> + * it this bit is crucial to determining if a entry is dirty and we cannot
> + * clear it via software. DBM can also be disabled or broken on some early
> + * armv8 devices, so check its availability before modifying it.
> + */
> +static inline pte_t pte_clear_soft_dirty(pte_t pte)
> +{
> +	if (arch_faults_on_old_pte())
> +		return pte;
> +
> +	return clear_pte_bit(pte, __pgprot(PTE_DIRTY));
> +}
> +
> +static inline pte_t pte_mksoft_dirty(pte_t pte)
> +{
> +	if (arch_faults_on_old_pte())
> +		return pte;
> +
> +	return set_pte_bit(pte, __pgprot(PTE_DIRTY));
> +}
> +
> +static inline pte_t pte_swp_clear_soft_dirty(pte_t pte)
> +{
> +	if (arch_faults_on_old_pte())
> +		return pte;
> +
> +	return clear_pte_bit(pte, __pgprot(PTE_DIRTY));
> +}
> +
> +static inline pte_t pte_swp_mksoft_dirty(pte_t pte)
> +{
> +	if (arch_faults_on_old_pte())
> +		return pte;
> +
> +	return set_pte_bit(pte, __pgprot(PTE_DIRTY));
> +}
> +
> +static inline int pmd_soft_dirty(pmd_t pmd)
> +{
> +	return pte_soft_dirty(pmd_pte(pmd));
> +}
> +
> +static inline pmd_t pmd_clear_soft_dirty(pmd_t pmd)
> +{
> +	return pte_pmd(pte_clear_soft_dirty(pmd_pte(pmd)));
> +}
> +
> +static inline pmd_t pmd_mksoft_dirty(pmd_t pmd)
> +{
> +	return pte_pmd(pte_mksoft_dirty(pmd_pte(pmd)));
> +}
> +
> +#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
> +static inline int pmd_swp_soft_dirty(pmd_t pmd)
> +{
> +	return pmd_soft_dirty(pmd);
> +}
> +
> +static inline pmd_t pmd_swp_clear_soft_dirty(pmd_t pmd)
> +{
> +	return pmd_clear_soft_dirty(pmd);
> +}
> +
> +static inline pmd_t pmd_swp_mksoft_dirty(pmd_t pmd)
> +{
> +	return pmd_mksoft_dirty(pmd);
> +}
> +#endif /* CONFIG_ARCH_ENABLE_THP_MIGRATION */
> +#endif /* CONFIG_ARM64_HW_AFDBM */
>  
>  #define __HAVE_ARCH_PTEP_MODIFY_PROT_TRANSACTION
>  #define ptep_modify_prot_start ptep_modify_prot_start
