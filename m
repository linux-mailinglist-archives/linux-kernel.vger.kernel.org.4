Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FED674746E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 16:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbjGDOu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 10:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjGDOu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 10:50:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8299185
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 07:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688482177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KG7VUiPepL76lIRjn35GDpDWphkvXumaAQTS4F2E7gE=;
        b=POzBdz3PaX0nJfAbdqHYqdBDhiskAOxnfosYBlRXGQ95UJTN2A0q2mqpkDPu+P96OCC5zT
        1ELRK4b/YY2JOJerrSrAdtMXL4tIpHFuPnbUhky6ZbDoGfozcfzA9pPNCYvyFKsybpf4Q4
        8+r7oD3Sja26vhEYfdxqphgKP7seijA=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-1MfHioqZNtGqokSvnXL9Xw-1; Tue, 04 Jul 2023 10:49:33 -0400
X-MC-Unique: 1MfHioqZNtGqokSvnXL9Xw-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-401e243849cso59951491cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 07:49:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688482173; x=1691074173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KG7VUiPepL76lIRjn35GDpDWphkvXumaAQTS4F2E7gE=;
        b=BVswgQDyd7jzHOrUlFlMnFzn0gaYXV6srsUKvfRGsi3ns9BN1iJ3cWzNy81OSUO2Do
         lD+qGso+ToUaPjKOQxeWqnk9CBeEMeuHN2FGH3JYxBJe0N6k3bqZ21n3KVuDqC9ijX2e
         wM8ive+OoDts2p0TH6nSlWOLBKilBPO78lvEOBPn5BYK9RJTqO8wWwWpd3HBzp6fn3mY
         KDbz6FH32j5wwTQjeFc/oUp7joNDQzfJMFmQ/BBCLts2g5KkWngI7ZvI5FTxpoxmpkhS
         4J8VcOQhQPPm7hln72a9ZOIbsDGzjpv3BdmZHWjjNmgzA4K2KSiuOW4Yt87SY02UFoZO
         a5VQ==
X-Gm-Message-State: AC+VfDxo+Yfbc0hwkkhYZO9n7jw/u33xpI49gE3dJdc9Mso2mh0LNhg/
        xDEEu6EGmcKnSacY7zQbv9XofiNaWrp3f5yMyRIM9hUeWT9IDjS6EQj8rbO7MKVGODO54xgzzyW
        PyutvO7XwhYL9vZ86O3XQFxtADKPHfPOq3rhqnKrK
X-Received: by 2002:a05:622a:492:b0:400:98e9:fd78 with SMTP id p18-20020a05622a049200b0040098e9fd78mr18741802qtx.40.1688482173316;
        Tue, 04 Jul 2023 07:49:33 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Sre9SNyDexnL2KDDeUgy2D02z/GxHecRMrIxZcfyhJMqlt9W3/aqZ9ZR2BI6Y7285Mz1jSEdCgsHl4pcvRsA=
X-Received: by 2002:a05:622a:492:b0:400:98e9:fd78 with SMTP id
 p18-20020a05622a049200b0040098e9fd78mr18741780qtx.40.1688482173063; Tue, 04
 Jul 2023 07:49:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230704133633.1918147-1-npache@redhat.com> <ZKQnzF2sidMmZRyK@FVFF77S0Q05N.cambridge.arm.com>
In-Reply-To: <ZKQnzF2sidMmZRyK@FVFF77S0Q05N.cambridge.arm.com>
From:   Nico Pache <npache@redhat.com>
Date:   Tue, 4 Jul 2023 10:49:06 -0400
Message-ID: <CAA1CXcBkwr7E=UymXJs911qrXW5dLiZmyMAFpr-kJ-Tz3hoimA@mail.gmail.com>
Subject: Re: [PATCH V2] arm64: properly define SOFT_DIRTY functionality
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        aquini@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Tue, Jul 4, 2023 at 10:19=E2=80=AFAM Mark Rutland <mark.rutland@arm.com>=
 wrote:
>
> On Tue, Jul 04, 2023 at 09:36:33AM -0400, Nico Pache wrote:
> > ARM64 has a soft-dirty bit (software dirty) but never properly defines
> > CONFIG_ARCH_HAS_SOFT_DIRTY or its necessary functions. This patch
> > introduces the ability to set/clear the soft dirty bit in a similar
> > manner as the other arches that utilize it.
>
> Anshuman already explained that this is not correct -- to enable
> CONFIG_ARCH_HAS_SOFT_DIRTY, you need *another* PTE bit. Please don't send
> another version following this approach.
>
> Despite its name, pte_sw_dirty() has nothing to do with
> CONFIG_ARCH_HAS_SOFT_DIRTY. We have pte_hw_dirty() and pte_sw_dirty() bec=
ause
> with Hardware Dirty bit management the HW dirty bit is *also* the write
> permission bit, and to have a dirty non-writeable PTE state we have to us=
e a SW
> bit, which is what pte_sw_dirty() handles. Both pte_hw_dirty() and
> pte_sw_dirty() comprise the regular dirty state.
>
> That's *very* different from CONFIG_ARCH_HAS_SOFT_DIRTY, which is about h=
aving
> a *separate* software dirty state that can be used for longer-term dirty
> tracking (whether the page was last touched since some management SW
> manipulated the page).
>
> > However, we must be careful... there are cases where the DBM bit is not
> > available and the software dirty bit plays a essential role in determin=
ing
> > whether or not a page is dirty. In these cases we must not allow the
> > user to clear the software dirty bit. We can check for these cases by
> > utilizing the arch_has_hw_pte_young() function which tests the availabi=
lity
> > of DBM.
>
> Regardless of the above, this doesn't seem to have been thought through. =
why
> would it be ok for this to work or not work dependent on DBM?
It was from my understanding of both reading the code, and the
following chart that the PTE_DIRTY bit was only used in the absence of
the DBM bit to determine the dirty state of a page.
/*
 * PTE bits configuration in the presence of hardware Dirty Bit Management
 * (PTE_WRITE =3D=3D PTE_DBM):
 *
 * Dirty  Writable | PTE_RDONLY  PTE_WRITE  PTE_DIRTY (sw)
 *   0      0      |   1           0          0
 *   0      1      |   1           1          0
 *   1      0      |   1           0          1
 *   1      1      |   0           1          x
 *
 * When hardware DBM is not present, the sofware PTE_DIRTY bit is updated v=
ia
 * the page fault mechanism. Checking the dirty status of a pte becomes:
 *
 *   PTE_DIRTY || (PTE_WRITE && !PTE_RDONLY)
 */

So from my understanding it seems that when DBM is present, it acts as
the PTE_WRITE bit, and the AF bit is the HW dirty bit. This gives me
the impression that the PTE_DIRTY bit is redundant; however, When DBM
is not present PTE_DIRTY becomes crucial in determining the dirty
state.

-- Nico
>
> Thanks,
> Mark.
>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> > Cc: Liu Shixin <liushixin2@huawei.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Yu Zhao <yuzhao@google.com>
> > Signed-off-by: Nico Pache <npache@redhat.com>
> > ---
> >  arch/arm64/Kconfig               |   1 +
> >  arch/arm64/include/asm/pgtable.h | 104 ++++++++++++++++++++++++++-----
> >  2 files changed, 90 insertions(+), 15 deletions(-)
> >
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index 7856c3a3e35a..6ea73b8148c5 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -173,6 +173,7 @@ config ARM64
> >       select HAVE_ARCH_PREL32_RELOCATIONS
> >       select HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
> >       select HAVE_ARCH_SECCOMP_FILTER
> > +     select HAVE_ARCH_SOFT_DIRTY
> >       select HAVE_ARCH_STACKLEAK
> >       select HAVE_ARCH_THREAD_STRUCT_WHITELIST
> >       select HAVE_ARCH_TRACEHOOK
> > diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/=
pgtable.h
> > index 0bd18de9fd97..c4970c9ed114 100644
> > --- a/arch/arm64/include/asm/pgtable.h
> > +++ b/arch/arm64/include/asm/pgtable.h
> > @@ -51,6 +51,20 @@ static inline bool arch_thp_swp_supported(void)
> >  }
> >  #define arch_thp_swp_supported arch_thp_swp_supported
> >
> > +/*
> > + * On arm64 without hardware Access Flag, copying from user will fail =
because
> > + * the pte is old and cannot be marked young. So we always end up with=
 zeroed
> > + * page after fork() + CoW for pfn mappings. We don't always have a
> > + * hardware-managed access flag on arm64.
> > + */
> > +#define arch_has_hw_pte_young                cpu_has_hw_af
> > +
> > +/*
> > + * Experimentally, it's cheap to set the access flag in hardware and w=
e
> > + * benefit from prefaulting mappings as 'old' to start with.
> > + */
> > +#define arch_wants_old_prefaulted_pte        cpu_has_hw_af
> > +
> >  /*
> >   * Outside of a few very special situations (e.g. hibernation), we alw=
ays
> >   * use broadcast TLB invalidation instructions, therefore a spurious p=
age
> > @@ -121,8 +135,9 @@ static inline pteval_t __phys_to_pte_val(phys_addr_=
t phys)
> >  })
> >
> >  #define pte_hw_dirty(pte)    (pte_write(pte) && !(pte_val(pte) & PTE_R=
DONLY))
> > -#define pte_sw_dirty(pte)    (!!(pte_val(pte) & PTE_DIRTY))
> > -#define pte_dirty(pte)               (pte_sw_dirty(pte) || pte_hw_dirt=
y(pte))
> > +#define pte_soft_dirty(pte)  (!!(pte_val(pte) & PTE_DIRTY))
> > +#define pte_dirty(pte)               (pte_soft_dirty(pte) || pte_hw_di=
rty(pte))
> > +#define pte_swp_soft_dirty(pte)      pte_soft_dirty(pte)
> >
> >  #define pte_valid(pte)               (!!(pte_val(pte) & PTE_VALID))
> >  /*
> > @@ -189,7 +204,8 @@ static inline pte_t pte_mkwrite(pte_t pte)
> >
> >  static inline pte_t pte_mkclean(pte_t pte)
> >  {
> > -     pte =3D clear_pte_bit(pte, __pgprot(PTE_DIRTY));
> > +     if (!arch_has_hw_pte_young())
> > +             pte =3D clear_pte_bit(pte, __pgprot(PTE_DIRTY));
> >       pte =3D set_pte_bit(pte, __pgprot(PTE_RDONLY));
> >
> >       return pte;
> > @@ -1077,25 +1093,83 @@ static inline void update_mmu_cache(struct vm_a=
rea_struct *vma,
> >  #define phys_to_ttbr(addr)   (addr)
> >  #endif
> >
> > -/*
> > - * On arm64 without hardware Access Flag, copying from user will fail =
because
> > - * the pte is old and cannot be marked young. So we always end up with=
 zeroed
> > - * page after fork() + CoW for pfn mappings. We don't always have a
> > - * hardware-managed access flag on arm64.
> > - */
> > -#define arch_has_hw_pte_young                cpu_has_hw_af
> > +static inline bool pud_sect_supported(void)
> > +{
> > +     return PAGE_SIZE =3D=3D SZ_4K;
> > +}
> >
> > +#ifdef CONFIG_ARM64_HW_AFDBM
> >  /*
> > - * Experimentally, it's cheap to set the access flag in hardware and w=
e
> > - * benefit from prefaulting mappings as 'old' to start with.
> > + * if we have the DBM bit we can utilize the software dirty bit as
> > + * a mechanism to introduce the soft_dirty functionality; however, wit=
hout
> > + * it this bit is crucial to determining if a entry is dirty and we ca=
nnot
> > + * clear it via software. DBM can also be disabled or broken on some e=
arly
> > + * armv8 devices, so check its availability before modifying it.
> >   */
> > -#define arch_wants_old_prefaulted_pte        cpu_has_hw_af
> > +static inline pte_t pte_clear_soft_dirty(pte_t pte)
> > +{
> > +     if (!arch_has_hw_pte_young())
> > +             return pte;
> >
> > -static inline bool pud_sect_supported(void)
> > +     return clear_pte_bit(pte, __pgprot(PTE_DIRTY));
> > +}
> > +
> > +static inline pte_t pte_mksoft_dirty(pte_t pte)
> >  {
> > -     return PAGE_SIZE =3D=3D SZ_4K;
> > +     if (!arch_has_hw_pte_young())
> > +             return pte;
> > +
> > +     return set_pte_bit(pte, __pgprot(PTE_DIRTY));
> > +}
> > +
> > +static inline pte_t pte_swp_clear_soft_dirty(pte_t pte)
> > +{
> > +     if (!arch_has_hw_pte_young())
> > +             return pte;
> > +
> > +     return clear_pte_bit(pte, __pgprot(PTE_DIRTY));
> > +}
> > +
> > +static inline pte_t pte_swp_mksoft_dirty(pte_t pte)
> > +{
> > +     if (!arch_has_hw_pte_young())
> > +             return pte;
> > +
> > +     return set_pte_bit(pte, __pgprot(PTE_DIRTY));
> > +}
> > +
> > +static inline int pmd_soft_dirty(pmd_t pmd)
> > +{
> > +     return pte_soft_dirty(pmd_pte(pmd));
> > +}
> > +
> > +static inline pmd_t pmd_clear_soft_dirty(pmd_t pmd)
> > +{
> > +     return pte_pmd(pte_clear_soft_dirty(pmd_pte(pmd)));
> > +}
> > +
> > +static inline pmd_t pmd_mksoft_dirty(pmd_t pmd)
> > +{
> > +     return pte_pmd(pte_mksoft_dirty(pmd_pte(pmd)));
> >  }
> >
> > +#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
> > +static inline int pmd_swp_soft_dirty(pmd_t pmd)
> > +{
> > +     return pmd_soft_dirty(pmd);
> > +}
> > +
> > +static inline pmd_t pmd_swp_clear_soft_dirty(pmd_t pmd)
> > +{
> > +     return pmd_clear_soft_dirty(pmd);
> > +}
> > +
> > +static inline pmd_t pmd_swp_mksoft_dirty(pmd_t pmd)
> > +{
> > +     return pmd_mksoft_dirty(pmd);
> > +}
> > +#endif /* CONFIG_ARCH_ENABLE_THP_MIGRATION */
> > +#endif /* CONFIG_ARM64_HW_AFDBM */
> >
> >  #define __HAVE_ARCH_PTEP_MODIFY_PROT_TRANSACTION
> >  #define ptep_modify_prot_start ptep_modify_prot_start
> > --
> > 2.41.0
> >
>

