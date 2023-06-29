Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97CE5741DB6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 03:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbjF2BjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 21:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjF2BjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 21:39:12 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88ACD199B;
        Wed, 28 Jun 2023 18:39:11 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5577905ef38so77571a12.0;
        Wed, 28 Jun 2023 18:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688002751; x=1690594751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ux9B0srClyCZWsFVsMJo+q/yRz7KZe7H2zTVS/BvmEY=;
        b=W6LAHQ9MU7AqXT0poOsZHvm7H0Hux1rT4jeGdWOdyyIy9x4KvcSwcpESQvub372rha
         PcS2S7s9EGLVRenNs40RPeNR1lHzNmhgCXNs2CnUL1/ve7YQqx/5URo9gmaKbjtD2Zd4
         NFG8SOwMO1U6FmYcg+G1SoUy5Iy9A6eYjnlGNUoRsSxQnVPkgo9EJO1OO97MhvnuGiaB
         T+vwP99cg5QDycEK2YsDZplyh8K1htp31VQFkb99p16T27/RjXB1LGTXJRdC0/jM38yp
         CK6HHxcyHt8RGgCC34+SjP64QMWV1A1ky3yF20JPIyzGobP1vSSv7koi6Y6N99mQcFsR
         YXGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688002751; x=1690594751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ux9B0srClyCZWsFVsMJo+q/yRz7KZe7H2zTVS/BvmEY=;
        b=NuHmZS/dsWr9eqWJ2wyLJkd0QOLCngtShI9L4Dm4Kcq16/HYD6JAQCRlMIL7tm6KgC
         INOqACF1fJRDTYNp8mPn6GStr08x3aEdvPBFP/v7li5TYWCN0a9+WwyBV9DntWwuoSwE
         t17TI3XI2L9x4av9Xw9hyE1wXhlXQPTWAJOOTFsRxcRjwQHmPgZZuam7OK3el3XSCFJ8
         A2zlDX6beSGeGU7P2YmvHJ7QsVRorPqmDqwuTvTz9c8q+hu0G07wtY9SluWjbgRRbOxD
         3sRlyEdoaZjs4SRj6EP0N2qHqkpsxolUuZpVGKah/CQHCAmCcaDU+4pRnljFMn477lHv
         xxeA==
X-Gm-Message-State: AC+VfDzDkkZSVmqa6nncUHryvCHiDWDhuo7rKrN92sBGwqZ70Op4yIjw
        Wqkik/8pimsP9tGZl91tSXhFKD+OLcKd1WRE97zAbxEg
X-Google-Smtp-Source: ACHHUZ7XV721JF+3Hut1ZfFxeuXwoMOKYJDzX2eAcfRiSgLDFWN6VL4HSkG/y2opKdMIB8ABEkCpkFIucyPLdGZCgYU=
X-Received: by 2002:a17:90a:35c:b0:263:6cb:5b95 with SMTP id
 28-20020a17090a035c00b0026306cb5b95mr6402422pjf.14.1688002750857; Wed, 28 Jun
 2023 18:39:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230626171430.3167004-1-ryan.roberts@arm.com> <20230626171430.3167004-9-ryan.roberts@arm.com>
In-Reply-To: <20230626171430.3167004-9-ryan.roberts@arm.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 28 Jun 2023 18:38:59 -0700
Message-ID: <CAHbLzkpScGq-ja2A6dRffG8qbrVuwXzkMpFvSq_Fzdqp2wUwPA@mail.gmail.com>
Subject: Re: [PATCH v1 08/10] mm: Kconfig hooks to determine max anon folio
 allocation order
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 10:15=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com=
> wrote:
>
> For variable-order anonymous folios, we need to determine the order that
> we will allocate. From a SW perspective, the higher the order we
> allocate, the less overhead we will have; fewer faults, fewer folios in
> lists, etc. But of course there will also be more memory wastage as the
> order increases.
>
> From a HW perspective, there are memory block sizes that can be
> beneficial to reducing TLB pressure. arm64, for example, has the ability
> to map "contpte" sized chunks (64K for a 4K base page, 2M for 16K and
> 64K base pages) such that one of these chunks only uses a single TLB
> entry.
>
> So we let the architecture specify the order of the maximally beneficial
> mapping unit when PTE-mapped. Furthermore, because in some cases, this
> order may be quite big (and therefore potentially wasteful of memory),
> allow the arch to specify 2 values; One is the max order for a mapping
> that _would not_ use THP if all size and alignment constraints were met,
> and the other is the max order for a mapping that _would_ use THP if all
> those constraints were met.
>
> Implement this with Kconfig by introducing some new options to allow the
> architecture to declare that it supports large anonymous folios along
> with these 2 preferred max order values. Then introduce a user-facing
> option, LARGE_ANON_FOLIO, which defaults to disabled and can only be
> enabled if the architecture has declared its support. When disabled, it
> forces the max order values, LARGE_ANON_FOLIO_NOTHP_ORDER_MAX and
> LARGE_ANON_FOLIO_THP_ORDER_MAX to 0, meaning only a single page is ever
> allocated.
>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  mm/Kconfig  | 39 +++++++++++++++++++++++++++++++++++++++
>  mm/memory.c |  8 ++++++++
>  2 files changed, 47 insertions(+)
>
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 7672a22647b4..f4ba48c37b75 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -1208,4 +1208,43 @@ config PER_VMA_LOCK
>
>  source "mm/damon/Kconfig"
>
> +config ARCH_SUPPORTS_LARGE_ANON_FOLIO
> +       def_bool n
> +       help
> +         An arch should select this symbol if wants to allow LARGE_ANON_=
FOLIO
> +         to be enabled. It must also set the following integer values:
> +         - ARCH_LARGE_ANON_FOLIO_NOTHP_ORDER_MAX
> +         - ARCH_LARGE_ANON_FOLIO_THP_ORDER_MAX
> +
> +config ARCH_LARGE_ANON_FOLIO_NOTHP_ORDER_MAX
> +       int
> +       help
> +         The maximum size of folio to allocate for an anonymous VMA PTE-=
mapping
> +         that does not have the MADV_HUGEPAGE hint set.
> +
> +config ARCH_LARGE_ANON_FOLIO_THP_ORDER_MAX
> +       int
> +       help
> +         The maximum size of folio to allocate for an anonymous VMA PTE-=
mapping
> +         that has the MADV_HUGEPAGE hint set.
> +
> +config LARGE_ANON_FOLIO
> +       bool "Allocate large folios for anonymous memory"
> +       depends on ARCH_SUPPORTS_LARGE_ANON_FOLIO
> +       default n
> +       help
> +         Use large (bigger than order-0) folios to back anonymous memory=
 where
> +         possible. This reduces the number of page faults, as well as ot=
her
> +         per-page overheads to improve performance for many workloads.
> +
> +config LARGE_ANON_FOLIO_NOTHP_ORDER_MAX
> +       int
> +       default 0 if !LARGE_ANON_FOLIO
> +       default ARCH_LARGE_ANON_FOLIO_NOTHP_ORDER_MAX
> +
> +config LARGE_ANON_FOLIO_THP_ORDER_MAX
> +       int
> +       default 0 if !LARGE_ANON_FOLIO
> +       default ARCH_LARGE_ANON_FOLIO_THP_ORDER_MAX
> +

IMHO I don't think we need all of the new kconfigs. Ideally the large
anon folios could be supported by all arches, although some of them
may not benefit from larger TLB entries due to lack of hardware
support.t

For now with a minimum implementation, I think you could define a
macro or a function that returns the hardware preferred order.

>  endmenu
> diff --git a/mm/memory.c b/mm/memory.c
> index 9165ed1b9fc2..a8f7e2b28d7a 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3153,6 +3153,14 @@ static struct folio *try_vma_alloc_movable_folio(s=
truct vm_area_struct *vma,
>         return vma_alloc_movable_folio(vma, vaddr, 0, zeroed);
>  }
>
> +static inline int max_anon_folio_order(struct vm_area_struct *vma)
> +{
> +       if (hugepage_vma_check(vma, vma->vm_flags, false, true, true))
> +               return CONFIG_LARGE_ANON_FOLIO_THP_ORDER_MAX;
> +       else
> +               return CONFIG_LARGE_ANON_FOLIO_NOTHP_ORDER_MAX;
> +}
> +
>  /*
>   * Handle write page faults for pages that can be reused in the current =
vma
>   *
> --
> 2.25.1
>
>
