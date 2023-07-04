Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA694747681
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 18:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbjGDQ1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 12:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjGDQ1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 12:27:11 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CAF6710EC
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 09:27:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0558115A1;
        Tue,  4 Jul 2023 09:27:51 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.31.180])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA0883F73F;
        Tue,  4 Jul 2023 09:27:06 -0700 (PDT)
Date:   Tue, 4 Jul 2023 17:27:04 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Nico Pache <npache@redhat.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        aquini@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH V2] arm64: properly define SOFT_DIRTY functionality
Message-ID: <ZKRIWAyb1bdq73wG@FVFF77S0Q05N.cambridge.arm.com>
References: <20230704133633.1918147-1-npache@redhat.com>
 <ZKQnzF2sidMmZRyK@FVFF77S0Q05N.cambridge.arm.com>
 <CAA1CXcBkwr7E=UymXJs911qrXW5dLiZmyMAFpr-kJ-Tz3hoimA@mail.gmail.com>
 <ZKQ4R5x3kRAaXqqP@FVFF77S0Q05N.cambridge.arm.com>
 <CAA1CXcBt_dUpvmfG9Eub_LaXeobmp20+en1eAOArV08SX0hnmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA1CXcBt_dUpvmfG9Eub_LaXeobmp20+en1eAOArV08SX0hnmQ@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2023 at 12:15:18PM -0400, Nico Pache wrote:
> Thanks Mark, that explanation is very helpful and makes sense.
> 
> Sorry I dont normally work this close to hardware, let alone ARM
> hardware, so my understanding of all this is still growing. I mistook
> Anshuman's point as me missing a corner case, not that it was
> downright wrong.

No problem; thanks for confirming.

> One last thing, could the AF bit be used instead of the PTE_DIRTY to
> determine if a page is DIRTY & !WRITE?
> ie) pte_dirty(pte) = pte_hw_dirty(pte) || (pte_young(pte) && !pte_write(pte)

The AF tracks both reads and write accesses, and we need to be able to clear
that via pte_mkyoung() regardless of whether the page is dirty.

> or would this create cases of pages being considered dirty when they
> have only been read?

Yes -- that would happen, and would be a problem as it would significantly
amplify the set of pages we thought of as dirty (and I suspect might surprise
some code handling pages that are never mapped as writeable, since the dirty
state owuld be unexpected).

Thanks,
Mark.

> 
> Cheers,
> -- Nico
> 
> On Tue, Jul 4, 2023 at 11:18 AM Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > On Tue, Jul 04, 2023 at 10:49:06AM -0400, Nico Pache wrote:
> > > Hi Mark,
> > >
> > > On Tue, Jul 4, 2023 at 10:19 AM Mark Rutland <mark.rutland@arm.com> wrote:
> > > >
> > > > On Tue, Jul 04, 2023 at 09:36:33AM -0400, Nico Pache wrote:
> > > > > ARM64 has a soft-dirty bit (software dirty) but never properly defines
> > > > > CONFIG_ARCH_HAS_SOFT_DIRTY or its necessary functions. This patch
> > > > > introduces the ability to set/clear the soft dirty bit in a similar
> > > > > manner as the other arches that utilize it.
> > > >
> > > > Anshuman already explained that this is not correct -- to enable
> > > > CONFIG_ARCH_HAS_SOFT_DIRTY, you need *another* PTE bit. Please don't send
> > > > another version following this approach.
> > > >
> > > > Despite its name, pte_sw_dirty() has nothing to do with
> > > > CONFIG_ARCH_HAS_SOFT_DIRTY. We have pte_hw_dirty() and pte_sw_dirty() because
> > > > with Hardware Dirty bit management the HW dirty bit is *also* the write
> > > > permission bit, and to have a dirty non-writeable PTE state we have to use a SW
> > > > bit, which is what pte_sw_dirty() handles. Both pte_hw_dirty() and
> > > > pte_sw_dirty() comprise the regular dirty state.
> > > >
> > > > That's *very* different from CONFIG_ARCH_HAS_SOFT_DIRTY, which is about having
> > > > a *separate* software dirty state that can be used for longer-term dirty
> > > > tracking (whether the page was last touched since some management SW
> > > > manipulated the page).
> > > >
> > > > > However, we must be careful... there are cases where the DBM bit is not
> > > > > available and the software dirty bit plays a essential role in determining
> > > > > whether or not a page is dirty. In these cases we must not allow the
> > > > > user to clear the software dirty bit. We can check for these cases by
> > > > > utilizing the arch_has_hw_pte_young() function which tests the availability
> > > > > of DBM.
> > > >
> > > > Regardless of the above, this doesn't seem to have been thought through. why
> > > > would it be ok for this to work or not work dependent on DBM?
> > > It was from my understanding of both reading the code, and the
> > > following chart that the PTE_DIRTY bit was only used in the absence of
> > > the DBM bit to determine the dirty state of a page.
> >
> > The PTE_DIRTY bit is used regardless of DBM, for example, in the case I
> > mentioned of a dirty non-writeable page. Without PTE_DIRTY we'd have no way to
> > represent a write-protected dirty page.
> >
> > See pte_wrprotect(), which copies moves HW dirty bit into the PTE_DIRTY bit
> > when removing write permission:
> >
> > | static inline pte_t pte_wrprotect(pte_t pte)
> > | {
> > |         /*
> > |          * If hardware-dirty (PTE_WRITE/DBM bit set and PTE_RDONLY
> > |          * clear), set the PTE_DIRTY bit.
> > |          */
> > |         if (pte_hw_dirty(pte))
> > |                 pte = pte_mkdirty(pte);
> > |
> > |         pte = clear_pte_bit(pte, __pgprot(PTE_WRITE));
> > |         pte = set_pte_bit(pte, __pgprot(PTE_RDONLY));
> > |         return pte;
> > | }
> >
> > ... where pte_mkdirty() is:
> >
> > | static inline pte_t pte_mkdirty(pte_t pte)
> > | {
> > |         pte = set_pte_bit(pte, __pgprot(PTE_DIRTY));
> > |
> > |         if (pte_write(pte))
> > |                 pte = clear_pte_bit(pte, __pgprot(PTE_RDONLY));
> > |
> > |         return pte;
> > | }
> >
> > > /*
> > >  * PTE bits configuration in the presence of hardware Dirty Bit Management
> > >  * (PTE_WRITE == PTE_DBM):
> > >  *
> > >  * Dirty  Writable | PTE_RDONLY  PTE_WRITE  PTE_DIRTY (sw)
> > >  *   0      0      |   1           0          0
> > >  *   0      1      |   1           1          0
> > >  *   1      0      |   1           0          1
> > >  *   1      1      |   0           1          x
> > >  *
> > >  * When hardware DBM is not present, the sofware PTE_DIRTY bit is updated via
> > >  * the page fault mechanism. Checking the dirty status of a pte becomes:
> > >  *
> > >  *   PTE_DIRTY || (PTE_WRITE && !PTE_RDONLY)
> > >  */
> > >
> > > So from my understanding it seems that when DBM is present, it acts as
> > > the PTE_WRITE bit, and the AF bit is the HW dirty bit. This gives me
> > > the impression that the PTE_DIRTY bit is redundant; however, When DBM
> > > is not present PTE_DIRTY becomes crucial in determining the dirty
> > > state.
> >
> > As above, PTE_DIRTY is not redundant; regardless of DBM we need the PTE_DIRTY
> > bit for the regular dirty state. It distinguishes the first and third rows in
> > that table.
> >
> > Thanks,
> > Mark.
> >
> > >
> > > -- Nico
> > > >
> > > > Thanks,
> > > > Mark.
> > > >
> > > > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > > > Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> > > > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > > > Cc: David Hildenbrand <david@redhat.com>
> > > > > Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> > > > > Cc: Liu Shixin <liushixin2@huawei.com>
> > > > > Cc: Will Deacon <will@kernel.org>
> > > > > Cc: Yu Zhao <yuzhao@google.com>
> > > > > Signed-off-by: Nico Pache <npache@redhat.com>
> > > > > ---
> > > > >  arch/arm64/Kconfig               |   1 +
> > > > >  arch/arm64/include/asm/pgtable.h | 104 ++++++++++++++++++++++++++-----
> > > > >  2 files changed, 90 insertions(+), 15 deletions(-)
> > > > >
> > > > > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > > > > index 7856c3a3e35a..6ea73b8148c5 100644
> > > > > --- a/arch/arm64/Kconfig
> > > > > +++ b/arch/arm64/Kconfig
> > > > > @@ -173,6 +173,7 @@ config ARM64
> > > > >       select HAVE_ARCH_PREL32_RELOCATIONS
> > > > >       select HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
> > > > >       select HAVE_ARCH_SECCOMP_FILTER
> > > > > +     select HAVE_ARCH_SOFT_DIRTY
> > > > >       select HAVE_ARCH_STACKLEAK
> > > > >       select HAVE_ARCH_THREAD_STRUCT_WHITELIST
> > > > >       select HAVE_ARCH_TRACEHOOK
> > > > > diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> > > > > index 0bd18de9fd97..c4970c9ed114 100644
> > > > > --- a/arch/arm64/include/asm/pgtable.h
> > > > > +++ b/arch/arm64/include/asm/pgtable.h
> > > > > @@ -51,6 +51,20 @@ static inline bool arch_thp_swp_supported(void)
> > > > >  }
> > > > >  #define arch_thp_swp_supported arch_thp_swp_supported
> > > > >
> > > > > +/*
> > > > > + * On arm64 without hardware Access Flag, copying from user will fail because
> > > > > + * the pte is old and cannot be marked young. So we always end up with zeroed
> > > > > + * page after fork() + CoW for pfn mappings. We don't always have a
> > > > > + * hardware-managed access flag on arm64.
> > > > > + */
> > > > > +#define arch_has_hw_pte_young                cpu_has_hw_af
> > > > > +
> > > > > +/*
> > > > > + * Experimentally, it's cheap to set the access flag in hardware and we
> > > > > + * benefit from prefaulting mappings as 'old' to start with.
> > > > > + */
> > > > > +#define arch_wants_old_prefaulted_pte        cpu_has_hw_af
> > > > > +
> > > > >  /*
> > > > >   * Outside of a few very special situations (e.g. hibernation), we always
> > > > >   * use broadcast TLB invalidation instructions, therefore a spurious page
> > > > > @@ -121,8 +135,9 @@ static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
> > > > >  })
> > > > >
> > > > >  #define pte_hw_dirty(pte)    (pte_write(pte) && !(pte_val(pte) & PTE_RDONLY))
> > > > > -#define pte_sw_dirty(pte)    (!!(pte_val(pte) & PTE_DIRTY))
> > > > > -#define pte_dirty(pte)               (pte_sw_dirty(pte) || pte_hw_dirty(pte))
> > > > > +#define pte_soft_dirty(pte)  (!!(pte_val(pte) & PTE_DIRTY))
> > > > > +#define pte_dirty(pte)               (pte_soft_dirty(pte) || pte_hw_dirty(pte))
> > > > > +#define pte_swp_soft_dirty(pte)      pte_soft_dirty(pte)
> > > > >
> > > > >  #define pte_valid(pte)               (!!(pte_val(pte) & PTE_VALID))
> > > > >  /*
> > > > > @@ -189,7 +204,8 @@ static inline pte_t pte_mkwrite(pte_t pte)
> > > > >
> > > > >  static inline pte_t pte_mkclean(pte_t pte)
> > > > >  {
> > > > > -     pte = clear_pte_bit(pte, __pgprot(PTE_DIRTY));
> > > > > +     if (!arch_has_hw_pte_young())
> > > > > +             pte = clear_pte_bit(pte, __pgprot(PTE_DIRTY));
> > > > >       pte = set_pte_bit(pte, __pgprot(PTE_RDONLY));
> > > > >
> > > > >       return pte;
> > > > > @@ -1077,25 +1093,83 @@ static inline void update_mmu_cache(struct vm_area_struct *vma,
> > > > >  #define phys_to_ttbr(addr)   (addr)
> > > > >  #endif
> > > > >
> > > > > -/*
> > > > > - * On arm64 without hardware Access Flag, copying from user will fail because
> > > > > - * the pte is old and cannot be marked young. So we always end up with zeroed
> > > > > - * page after fork() + CoW for pfn mappings. We don't always have a
> > > > > - * hardware-managed access flag on arm64.
> > > > > - */
> > > > > -#define arch_has_hw_pte_young                cpu_has_hw_af
> > > > > +static inline bool pud_sect_supported(void)
> > > > > +{
> > > > > +     return PAGE_SIZE == SZ_4K;
> > > > > +}
> > > > >
> > > > > +#ifdef CONFIG_ARM64_HW_AFDBM
> > > > >  /*
> > > > > - * Experimentally, it's cheap to set the access flag in hardware and we
> > > > > - * benefit from prefaulting mappings as 'old' to start with.
> > > > > + * if we have the DBM bit we can utilize the software dirty bit as
> > > > > + * a mechanism to introduce the soft_dirty functionality; however, without
> > > > > + * it this bit is crucial to determining if a entry is dirty and we cannot
> > > > > + * clear it via software. DBM can also be disabled or broken on some early
> > > > > + * armv8 devices, so check its availability before modifying it.
> > > > >   */
> > > > > -#define arch_wants_old_prefaulted_pte        cpu_has_hw_af
> > > > > +static inline pte_t pte_clear_soft_dirty(pte_t pte)
> > > > > +{
> > > > > +     if (!arch_has_hw_pte_young())
> > > > > +             return pte;
> > > > >
> > > > > -static inline bool pud_sect_supported(void)
> > > > > +     return clear_pte_bit(pte, __pgprot(PTE_DIRTY));
> > > > > +}
> > > > > +
> > > > > +static inline pte_t pte_mksoft_dirty(pte_t pte)
> > > > >  {
> > > > > -     return PAGE_SIZE == SZ_4K;
> > > > > +     if (!arch_has_hw_pte_young())
> > > > > +             return pte;
> > > > > +
> > > > > +     return set_pte_bit(pte, __pgprot(PTE_DIRTY));
> > > > > +}
> > > > > +
> > > > > +static inline pte_t pte_swp_clear_soft_dirty(pte_t pte)
> > > > > +{
> > > > > +     if (!arch_has_hw_pte_young())
> > > > > +             return pte;
> > > > > +
> > > > > +     return clear_pte_bit(pte, __pgprot(PTE_DIRTY));
> > > > > +}
> > > > > +
> > > > > +static inline pte_t pte_swp_mksoft_dirty(pte_t pte)
> > > > > +{
> > > > > +     if (!arch_has_hw_pte_young())
> > > > > +             return pte;
> > > > > +
> > > > > +     return set_pte_bit(pte, __pgprot(PTE_DIRTY));
> > > > > +}
> > > > > +
> > > > > +static inline int pmd_soft_dirty(pmd_t pmd)
> > > > > +{
> > > > > +     return pte_soft_dirty(pmd_pte(pmd));
> > > > > +}
> > > > > +
> > > > > +static inline pmd_t pmd_clear_soft_dirty(pmd_t pmd)
> > > > > +{
> > > > > +     return pte_pmd(pte_clear_soft_dirty(pmd_pte(pmd)));
> > > > > +}
> > > > > +
> > > > > +static inline pmd_t pmd_mksoft_dirty(pmd_t pmd)
> > > > > +{
> > > > > +     return pte_pmd(pte_mksoft_dirty(pmd_pte(pmd)));
> > > > >  }
> > > > >
> > > > > +#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
> > > > > +static inline int pmd_swp_soft_dirty(pmd_t pmd)
> > > > > +{
> > > > > +     return pmd_soft_dirty(pmd);
> > > > > +}
> > > > > +
> > > > > +static inline pmd_t pmd_swp_clear_soft_dirty(pmd_t pmd)
> > > > > +{
> > > > > +     return pmd_clear_soft_dirty(pmd);
> > > > > +}
> > > > > +
> > > > > +static inline pmd_t pmd_swp_mksoft_dirty(pmd_t pmd)
> > > > > +{
> > > > > +     return pmd_mksoft_dirty(pmd);
> > > > > +}
> > > > > +#endif /* CONFIG_ARCH_ENABLE_THP_MIGRATION */
> > > > > +#endif /* CONFIG_ARM64_HW_AFDBM */
> > > > >
> > > > >  #define __HAVE_ARCH_PTEP_MODIFY_PROT_TRANSACTION
> > > > >  #define ptep_modify_prot_start ptep_modify_prot_start
> > > > > --
> > > > > 2.41.0
> > > > >
> > > >
> > >
> >
> 
