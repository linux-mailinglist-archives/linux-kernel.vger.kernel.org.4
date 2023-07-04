Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA0B746E47
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 12:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbjGDKKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 06:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjGDKKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 06:10:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658FDEE
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 03:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688465367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XrEJr9ZsfAMAdrOkHez38lQHpsoJcygDY9+UOO1h8OI=;
        b=UDFKYF4kJ0HMv+5iTOg+mhPxeeL0WmPvReZ7YFlNhdJ+An9HSHUjXOuqSE1pndr3yo+SkJ
        eAwLMdCSLKdaFEIAL4RIFk264codEETXzp6S7EU3JjyNTnuc0quSM/wv1I4vJhBaPvT3tR
        psniUEkxZrlbqve1AbQmMZVsON1lwAs=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-3dEmu9yzMzS48Rr9OJlPBQ-1; Tue, 04 Jul 2023 06:09:26 -0400
X-MC-Unique: 3dEmu9yzMzS48Rr9OJlPBQ-1
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-47e6b4af10fso151986e0c.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 03:09:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688465365; x=1691057365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XrEJr9ZsfAMAdrOkHez38lQHpsoJcygDY9+UOO1h8OI=;
        b=Kr5Um8ytaTCuMQuCCLpDSd+Ogo8Q24vMISx53lA8GeltJz8I+FDF+xHqRsyvaBlsP4
         Zez8OQ0IFNCwwLZZzHT1CooHjY5Pg4VXszRUlXKCPx39PTPQtxCTRSCPVQvhLSVCniI9
         yzsDK40BdG7+VYrayQPsHo8gGK0VKmMW6Kde1o4WLG1gtnxlBQf7fhgMtvreyg0eqUGd
         b0c62Jza/GCWfP8eNOxVZKpvNP9uxHFEHzTHYdqE9MdMzw+Lf3si7lz8RHti6wszM8ca
         Tmf078jGixkcb6x/iRbzcYEHJiBSGbxF5SnoZ64FoipBXfJ5D2zhExa+/KFn8MiD4mPe
         g70A==
X-Gm-Message-State: ABy/qLZOOLI5kiA1ImPw9iwlHHzab5XT8pSGDyZd9wyorZzKPz9RHY0u
        k+yR+kmqlyH7HTDWJ9Q1G1tUUY9DDQjw2vXAmKar17JNwcVN+/Lf1EahBuShQzRVkNl19solfUS
        rWHw2VibML2sOv51qSSlyG0a4pB+Z7CRMUONMubp+
X-Received: by 2002:a1f:ddc4:0:b0:47e:28ee:9d1d with SMTP id u187-20020a1fddc4000000b0047e28ee9d1dmr4214164vkg.4.1688465365680;
        Tue, 04 Jul 2023 03:09:25 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGi5N+r7J3ljDizN0UFZlVVbw9/D2WRFCNbnbD5NzAp3Xnvx1JWJuOfrHMuamyxt1y88Ld0Cvwy5+f0n4JTaEk=
X-Received: by 2002:a1f:ddc4:0:b0:47e:28ee:9d1d with SMTP id
 u187-20020a1fddc4000000b0047e28ee9d1dmr4214156vkg.4.1688465365441; Tue, 04
 Jul 2023 03:09:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230703135526.930004-1-npache@redhat.com> <c8bbc891-cd52-e34a-8ca7-76314e97cbe3@arm.com>
In-Reply-To: <c8bbc891-cd52-e34a-8ca7-76314e97cbe3@arm.com>
From:   Nico Pache <npache@redhat.com>
Date:   Tue, 4 Jul 2023 06:08:59 -0400
Message-ID: <CAA1CXcBWuMgMbBTLj9eYzW4wBxbJpa3FGZsbtiibrYODZQdg6A@mail.gmail.com>
Subject: Re: [RFC] arm64: properly define SOFT_DIRTY for arm64
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        aquini@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
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

Hi Anshuman,

Thanks for the explanation!

Is it possible to add the same DBM check I'm using
(!arch_has_hw_pte_young) in these pte helper functions to only clear
it when DBM is not present?

Cheers,
-- Nico

On Tue, Jul 4, 2023 at 6:01=E2=80=AFAM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
> Hi Nico,
>
> On 7/3/23 19:25, Nico Pache wrote:
> > ARM64 has a soft-dirty bit (software dirty) but never properly defines
> > CONFIG_ARCH_HAS_SOFT_DIRTY or its necessary functions. This patch
> > introduces the ability to set/clear the soft dirty bit in a similar
> > manner as the other arches that utilize it.
> >
> > However, we must be careful... there are cases where the DBM bit is not
> > available and the software dirty bit plays a essential role in determin=
ing
> > whether or not a page is dirty. In these cases we must not allow the
> > user to clear the software dirty bit. We can test for these cases by
> > utilizing the arch_faults_on_old_pte() function which test the availabi=
lity
> > of DBM.
>
> The current soft-dirty bit is a SW PTE bit i.e PTE_DIRTY, tracking PTE
> dirtiness in absence of HW DBM support, although both these tracking
> methods are very much intertwined. Current pte helpers like pte_dirty(),
> pte_mkdirty(), pte_mkclean(), and pte_wrrotect() etc operate both on
> HW and SW dirty tracking bits irrespective of whether DBM is supported
> or not.
>
> For soft dirty to work, we need a software PTE bit which sticks around
> on the PTE entry until user space (only) clears it and above PTE_DIRTY
> bit cannot be used for that purpose as it could be cleared in the kernel.
>
> static inline pte_t pte_mkclean(pte_t pte)
> {
>         pte =3D clear_pte_bit(pte, __pgprot(PTE_DIRTY));
>         pte =3D set_pte_bit(pte, __pgprot(PTE_RDONLY));
>
>         return pte;
> }
>
> BTW arch_faults_on_old_pte() is no longer available mainline.
>
> - Anshuman
>
> >
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
> >  arch/arm64/Kconfig               |  1 +
> >  arch/arm64/include/asm/pgtable.h | 77 +++++++++++++++++++++++++++++++-
> >  2 files changed, 76 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index 891ab530a665..4de491627f49 100644
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
> > index 0bd18de9fd97..a0a15ffa2417 100644
> > --- a/arch/arm64/include/asm/pgtable.h
> > +++ b/arch/arm64/include/asm/pgtable.h
> > @@ -121,8 +121,9 @@ static inline pteval_t __phys_to_pte_val(phys_addr_=
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
> > @@ -1096,6 +1097,78 @@ static inline bool pud_sect_supported(void)
> >       return PAGE_SIZE =3D=3D SZ_4K;
> >  }
> >
> > +#ifdef CONFIG_ARM64_HW_AFDBM
> > +/*
> > + * if we have the DBM bit we can utilize the software dirty bit as
> > + * a mechanism to introduce the soft_dirty functionality; however, wit=
hout
> > + * it this bit is crucial to determining if a entry is dirty and we ca=
nnot
> > + * clear it via software. DBM can also be disabled or broken on some e=
arly
> > + * armv8 devices, so check its availability before modifying it.
> > + */
> > +static inline pte_t pte_clear_soft_dirty(pte_t pte)
> > +{
> > +     if (arch_faults_on_old_pte())
> > +             return pte;
> > +
> > +     return clear_pte_bit(pte, __pgprot(PTE_DIRTY));
> > +}
> > +
> > +static inline pte_t pte_mksoft_dirty(pte_t pte)
> > +{
> > +     if (arch_faults_on_old_pte())
> > +             return pte;
> > +
> > +     return set_pte_bit(pte, __pgprot(PTE_DIRTY));
> > +}
> > +
> > +static inline pte_t pte_swp_clear_soft_dirty(pte_t pte)
> > +{
> > +     if (arch_faults_on_old_pte())
> > +             return pte;
> > +
> > +     return clear_pte_bit(pte, __pgprot(PTE_DIRTY));
> > +}
> > +
> > +static inline pte_t pte_swp_mksoft_dirty(pte_t pte)
> > +{
> > +     if (arch_faults_on_old_pte())
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
> > +}
> > +
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
>

