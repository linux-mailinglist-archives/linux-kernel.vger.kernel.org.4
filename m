Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40D27463A0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 22:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbjGCUDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 16:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjGCUC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 16:02:59 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92954E6E
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 13:02:50 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-401d1d967beso507561cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 13:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688414569; x=1691006569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BMuT/+syCV4c1WG89jC5mwfdKqUcMRKNlcTUW/qaIFg=;
        b=T4wMwr0XDGkMRvR6bldNgg+QHWaQPjK97wh9cIQM8GYjuDBn3iPkYyx03IuCBHGa7g
         +MB+v5A0BHSJuLGoM/CO3O3L8nKZBXcGNWkElDgrt9QcSyg3/1AOXwnWMfAl+3QF2IAH
         FXOBm24k2StmHrScGuOy15PUesZCej6CLaOIOlv9Uf0sixOu4welwkTsUbCY0MZtBgjV
         dALy5faYwPWK7poes51Sany+jq0IsmgJp72q+TZfRwf9Vfdaeesib3mg1oLQYeemou39
         Kq6GGzvJvNjFg2H+DM/CORlxemdM9UsRXsCyf1oGaaBU5QbrHE7ymtSDvtnWUj1J2/BA
         Gfqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688414569; x=1691006569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BMuT/+syCV4c1WG89jC5mwfdKqUcMRKNlcTUW/qaIFg=;
        b=K40549PzbulrnCviTRE5+6mys/ku9/VZ7W5z8Fex9Dx48EnqEpgqtvudAtFQauvLSk
         anpIR/ztyVB5L5u647DyYMjgr1xr2NiBmIb4enimeCkIkil8z3+3OGPPlDTxJG2KUBNt
         p5o8RZav3Tj4YZRTV/IQb1RKZzY68pnTJ/7lvEiELRqnVtuzM31mubTpsVA2mu0jsgXD
         vMyBB+LaRYE62AQXKyJZehHe0jXZ10C2nhJ8hOXamkR5FyjArU3EmwUwCc7MGl7vabOQ
         K16+n3knz1OheUAyovl0RpbenTC4eh0fgVUsv84wp+HzbkbYOJRSdLAmPKlC0lJFs25y
         nlIQ==
X-Gm-Message-State: ABy/qLYl6uOa1Nb4uOlP8Nq+Sl4dLx6BKWsi9YoHC+UzKPB6u7WFEhWz
        3vtXBx2B/OcwbqI7J9ExoVbOdw39w6BCc0MNLd5Eng==
X-Google-Smtp-Source: APBJJlGcGPrHB0fcUR30aX3ykUsThqZrdZrGuMC3nsN9VYDLkTa9bl1zgnL+tlVOV5ZfuXX7BCMr/IF5nuZmUE6JKQQ=
X-Received: by 2002:ac8:7f12:0:b0:3f8:5b2:aeee with SMTP id
 f18-20020ac87f12000000b003f805b2aeeemr15861qtk.22.1688414569607; Mon, 03 Jul
 2023 13:02:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230703135330.1865927-1-ryan.roberts@arm.com> <20230703135330.1865927-6-ryan.roberts@arm.com>
In-Reply-To: <20230703135330.1865927-6-ryan.roberts@arm.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Mon, 3 Jul 2023 14:02:13 -0600
Message-ID: <CAOUHufa_FkK0BNhpfMhexFetwhbugjVcKOBKpu4aT-0n8NeAxg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] arm64: mm: Override arch_wants_pte_order()
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 3, 2023 at 7:53=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com> =
wrote:
>
> Define an arch-specific override of arch_wants_pte_order() so that when
> FLEXIBLE_THP is enabled, large folios will be allocated for anonymous
> memory with an order that is compatible with arm64's contpte mappings.
>
> arch_wants_pte_order() returns an order according to the following
> policy: For the unhinted case, when THP is not requested for the vma,
> don't allow anything bigger than 64K. This means we don't waste too much
> memory. Additionally, for 4K pages this is the contpte size, and for
> 16K, this is (usually) the HPA size when the uarch feature is
> implemented. For the hinted case, when THP is requested for the vma,
> allow the contpte size for all page size configurations; 64K for 4K, 2M
> for 16K and 2M for 64K.
>
> Additionally, the THP and NOTHP order constants are defined using
> Kconfig so it is possible to override them at build time.
>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  arch/arm64/Kconfig               | 12 ++++++++++++
>  arch/arm64/include/asm/pgtable.h |  4 ++++
>  arch/arm64/mm/mmu.c              |  8 ++++++++
>  3 files changed, 24 insertions(+)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 343e1e1cae10..689c5bf13dc1 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -281,6 +281,18 @@ config ARM64_CONT_PMD_SHIFT
>         default 5 if ARM64_16K_PAGES
>         default 4
>
> +config ARM64_PTE_ORDER_NOTHP
> +       int
> +       default 0 if ARM64_64K_PAGES    # 64K (1 page)
> +       default 2 if ARM64_16K_PAGES    # 64K (4 pages; benefits from HPA=
 where HW supports it)
> +       default 4 if ARM64_4K_PAGES     # 64K (16 pages; eligible for con=
tpte-mapping)
> +
> +config ARM64_PTE_ORDER_THP
> +       int
> +       default 5 if ARM64_64K_PAGES    # 2M  (32 pages; eligible for con=
tpte-mapping)
> +       default 7 if ARM64_16K_PAGES    # 2M  (128 pages; eligible for co=
ntpte-mapping)
> +       default 4 if ARM64_4K_PAGES     # 64K (16 pages; eligible for con=
tpte-mapping)
> +
>  config ARCH_MMAP_RND_BITS_MIN
>         default 14 if ARM64_64K_PAGES
>         default 16 if ARM64_16K_PAGES
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pg=
table.h
> index 6fd012663a01..8463d5f9f307 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -1117,6 +1117,10 @@ extern pte_t ptep_modify_prot_start(struct vm_area=
_struct *vma,
>  extern void ptep_modify_prot_commit(struct vm_area_struct *vma,
>                                     unsigned long addr, pte_t *ptep,
>                                     pte_t old_pte, pte_t new_pte);
> +
> +#define arch_wants_pte_order arch_wants_pte_order
> +extern int arch_wants_pte_order(struct vm_area_struct *vma);
> +
>  #endif /* !__ASSEMBLY__ */
>
>  #endif /* __ASM_PGTABLE_H */
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index af6bc8403ee4..8556c4a9b507 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -1481,3 +1481,11 @@ void ptep_modify_prot_commit(struct vm_area_struct=
 *vma, unsigned long addr, pte
>  {
>         set_pte_at(vma->vm_mm, addr, ptep, pte);
>  }
> +
> +int arch_wants_pte_order(struct vm_area_struct *vma)
> +{
> +       if (hugepage_vma_check(vma, vma->vm_flags, false, true, true))
> +               return CONFIG_ARM64_PTE_ORDER_THP;
> +       else
> +               return CONFIG_ARM64_PTE_ORDER_NOTHP;
> +}

I don't really like this because it's a mix of h/w preference and s/w
policy -- from my POV, it's supposed to be the former only. The policy
part should be left to core MM (arch-independent).

That being said, no objection if ARM MM people think this is really
what they want.
