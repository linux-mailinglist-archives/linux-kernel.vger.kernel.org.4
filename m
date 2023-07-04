Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3240D746E1D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 11:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbjGDJ7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 05:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjGDJ7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 05:59:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F9E119
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 02:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688464721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QkWg/7FR/3tJKua9El11o0Rt2pDwEJayH91NkgyElM8=;
        b=SUl0TOR9vzZMj93gfrKyJAjEte5HoNGdZPWApvtxOOKwOqb2DUBPl3zOa+7JU8vW9Fixep
        SIdJ5/CHSVEOALmNqiePcnprcoaNmcMj1wSX1qAchbcyNIMrHDSN6X+Vjog1CLqjTG+3P8
        lAyPKzpDjDZy+WS5xjhCudrMm6xh7v0=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-fDEepnKKOyGhyTM6zwAQ2Q-1; Tue, 04 Jul 2023 05:58:40 -0400
X-MC-Unique: fDEepnKKOyGhyTM6zwAQ2Q-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-402391ed8ceso63267561cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 02:58:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688464720; x=1691056720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QkWg/7FR/3tJKua9El11o0Rt2pDwEJayH91NkgyElM8=;
        b=MKaVNFztA1qU36MmPGZZ3z+20tpLnY3jBGkH6D+46wmXfTpW43y43MvAkW3cSmNp4R
         Lxaz1ZTKL7iejd0VlGaxUxC75EdaowTlK7g//UHtR4RRpjFXW2jIRm/PvFDtDrfiDPFL
         QwyJ3wxIwJ+/ACwxIqhrWzEKPdmnWQNQC0wRD9cGvgwWas3ZJ23azF/EKnmUtoYUr4QZ
         by0BUSHI1DaP1H1JO6BeOhG/j+S2AL1f77VRpMA9rlBJCRIcV8WzDV4QrBUo4x3ErTy6
         k82P7jSZEOkPz+P/QRMazaPyPz1Ck8eUP8+JdX6H4RLyEGJ+CYdX8aRC64lWvToR605y
         X0iw==
X-Gm-Message-State: AC+VfDxCOC4v51DXbexaLitodqg7UIPgIixUCi/Vxz+Lou0URsfjZak5
        4CgF6KBVdpiEDnbMUUIUgQQO4MZxEycjcTt+gRDLARyVyZ+z/wUpt5nvxXNaowxad5B+myo6KBI
        /4nfi8yN3BTaSMmyu46tzzolt4nf9cUv+Y54epMvL
X-Received: by 2002:ac8:5787:0:b0:400:2195:bc with SMTP id v7-20020ac85787000000b00400219500bcmr17542910qta.24.1688464720120;
        Tue, 04 Jul 2023 02:58:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4GSQgbaQjx2pP1UMW3jvTb4506O2MUzIHOHO26Lz3Y0xIbLnqCn4ADlSt8OsrjiZ4bMrJX4PO+Y//k2GkLux8=
X-Received: by 2002:ac8:5787:0:b0:400:2195:bc with SMTP id v7-20020ac85787000000b00400219500bcmr17542904qta.24.1688464719942;
 Tue, 04 Jul 2023 02:58:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230703135526.930004-1-npache@redhat.com>
In-Reply-To: <20230703135526.930004-1-npache@redhat.com>
From:   Nico Pache <npache@redhat.com>
Date:   Tue, 4 Jul 2023 05:58:13 -0400
Message-ID: <CAA1CXcACazBN2Hy0NLVUpMWs_UmgvPn5968aJCOyy=NPmH5Q9Q@mail.gmail.com>
Subject: Re: [RFC] arm64: properly define SOFT_DIRTY for arm64
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     aquini@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
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

Whoops I pulled but never actually rebased... commit e1fd09e3d1dd
("mm: x86, arm64: add arch_has_hw_pte_young()") changed
arch_faults_on_old_pte() into !arch_has_hw_pte_young(). Following up
with a V2 shortly.

-- Nico

On Mon, Jul 3, 2023 at 10:06=E2=80=AFAM Nico Pache <npache@redhat.com> wrot=
e:
>
> ARM64 has a soft-dirty bit (software dirty) but never properly defines
> CONFIG_ARCH_HAS_SOFT_DIRTY or its necessary functions. This patch
> introduces the ability to set/clear the soft dirty bit in a similar
> manner as the other arches that utilize it.
>
> However, we must be careful... there are cases where the DBM bit is not
> available and the software dirty bit plays a essential role in determinin=
g
> whether or not a page is dirty. In these cases we must not allow the
> user to clear the software dirty bit. We can test for these cases by
> utilizing the arch_faults_on_old_pte() function which test the availabili=
ty
> of DBM.
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
>         select HAVE_ARCH_PREL32_RELOCATIONS
>         select HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
>         select HAVE_ARCH_SECCOMP_FILTER
> +       select HAVE_ARCH_SOFT_DIRTY
>         select HAVE_ARCH_STACKLEAK
>         select HAVE_ARCH_THREAD_STRUCT_WHITELIST
>         select HAVE_ARCH_TRACEHOOK
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pg=
table.h
> index 0bd18de9fd97..a0a15ffa2417 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -121,8 +121,9 @@ static inline pteval_t __phys_to_pte_val(phys_addr_t =
phys)
>  })
>
>  #define pte_hw_dirty(pte)      (pte_write(pte) && !(pte_val(pte) & PTE_R=
DONLY))
> -#define pte_sw_dirty(pte)      (!!(pte_val(pte) & PTE_DIRTY))
> -#define pte_dirty(pte)         (pte_sw_dirty(pte) || pte_hw_dirty(pte))
> +#define pte_soft_dirty(pte)    (!!(pte_val(pte) & PTE_DIRTY))
> +#define pte_dirty(pte)         (pte_soft_dirty(pte) || pte_hw_dirty(pte)=
)
> +#define pte_swp_soft_dirty(pte)        pte_soft_dirty(pte)
>
>  #define pte_valid(pte)         (!!(pte_val(pte) & PTE_VALID))
>  /*
> @@ -1096,6 +1097,78 @@ static inline bool pud_sect_supported(void)
>         return PAGE_SIZE =3D=3D SZ_4K;
>  }
>
> +#ifdef CONFIG_ARM64_HW_AFDBM
> +/*
> + * if we have the DBM bit we can utilize the software dirty bit as
> + * a mechanism to introduce the soft_dirty functionality; however, witho=
ut
> + * it this bit is crucial to determining if a entry is dirty and we cann=
ot
> + * clear it via software. DBM can also be disabled or broken on some ear=
ly
> + * armv8 devices, so check its availability before modifying it.
> + */
> +static inline pte_t pte_clear_soft_dirty(pte_t pte)
> +{
> +       if (arch_faults_on_old_pte())
> +               return pte;
> +
> +       return clear_pte_bit(pte, __pgprot(PTE_DIRTY));
> +}
> +
> +static inline pte_t pte_mksoft_dirty(pte_t pte)
> +{
> +       if (arch_faults_on_old_pte())
> +               return pte;
> +
> +       return set_pte_bit(pte, __pgprot(PTE_DIRTY));
> +}
> +
> +static inline pte_t pte_swp_clear_soft_dirty(pte_t pte)
> +{
> +       if (arch_faults_on_old_pte())
> +               return pte;
> +
> +       return clear_pte_bit(pte, __pgprot(PTE_DIRTY));
> +}
> +
> +static inline pte_t pte_swp_mksoft_dirty(pte_t pte)
> +{
> +       if (arch_faults_on_old_pte())
> +               return pte;
> +
> +       return set_pte_bit(pte, __pgprot(PTE_DIRTY));
> +}
> +
> +static inline int pmd_soft_dirty(pmd_t pmd)
> +{
> +       return pte_soft_dirty(pmd_pte(pmd));
> +}
> +
> +static inline pmd_t pmd_clear_soft_dirty(pmd_t pmd)
> +{
> +       return pte_pmd(pte_clear_soft_dirty(pmd_pte(pmd)));
> +}
> +
> +static inline pmd_t pmd_mksoft_dirty(pmd_t pmd)
> +{
> +       return pte_pmd(pte_mksoft_dirty(pmd_pte(pmd)));
> +}
> +
> +#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
> +static inline int pmd_swp_soft_dirty(pmd_t pmd)
> +{
> +       return pmd_soft_dirty(pmd);
> +}
> +
> +static inline pmd_t pmd_swp_clear_soft_dirty(pmd_t pmd)
> +{
> +       return pmd_clear_soft_dirty(pmd);
> +}
> +
> +static inline pmd_t pmd_swp_mksoft_dirty(pmd_t pmd)
> +{
> +       return pmd_mksoft_dirty(pmd);
> +}
> +#endif /* CONFIG_ARCH_ENABLE_THP_MIGRATION */
> +#endif /* CONFIG_ARM64_HW_AFDBM */
>
>  #define __HAVE_ARCH_PTEP_MODIFY_PROT_TRANSACTION
>  #define ptep_modify_prot_start ptep_modify_prot_start
> --
> 2.41.0
>

