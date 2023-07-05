Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C59747B26
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 03:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbjGEBkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 21:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbjGEBko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 21:40:44 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD2410FB
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 18:40:39 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-401d1d967beso803371cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 18:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688521239; x=1691113239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FFdVskwaA2s8VmI/RPC7w7nv1Uulp1bbtTeicpqhFJM=;
        b=fkcItRq7IjTK/v5lKc97LIP9v4MSOKBHLxElVQfEmVAlRKkUDfPLHcrZADHn72rWPd
         FRihodv9VPZ/qGNDg6Jhw3up6rpsBG9nufjgEAldwpaZkhTIF4l2EC+If7wiCjJX9yNc
         d3XUoaTadPePEyCBzCNkdfUq8b0IpNcpivY9BDVM+QQw0DjpV9FUx6vOX7wOJAMbQDCy
         BvE+07W2DuT7sEenIn5zRtDJk7EAKk4oSb+k817RG7xvL057FvQPNJVGv9kfs7mc4Uqq
         vwpIWfnt+w6HN2mbnIiVyGImDnJMfLKJZRJjYBFnAmAUJs+Hb2XspvKf5GTFSEFstlpp
         pm4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688521239; x=1691113239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FFdVskwaA2s8VmI/RPC7w7nv1Uulp1bbtTeicpqhFJM=;
        b=GKyuD5PCRaPiqK4Gaz3UdxWTmNYOm9HPpyENiA/Ql5+cGm1EFiq/lfwYoRCrU8sr24
         MIQzd+Ixxc4eMcZXkezGZwN/ZhyKFdygEyRK0WlVfxmJHx99Qsip+2wLTyw6L2O66HVf
         /rrZmatvvWC8hRRla6w4s70jS0eT7CW+EDarWbHw7NSu6W8x+GlyOMsxb9rFDdTi2Cbg
         rjtbmNANLSWwIMvU4HZ0uPMPhBvhFZfNWGZoA0Y+OQEudEylXDoNScErmoGdHh64Q85P
         wpzA6zMnSbMeSvGiTFWsbofQvhXpbhnNxMfj9qovvdV60Pmyipfzbr2h1wsB5shSEf5n
         Gh0A==
X-Gm-Message-State: ABy/qLYELa/i0VkJM6NdXfieEL80Up3A++EZh7ddEARERTLzT1sR3nGb
        m0Pl+OOJJzgSQ38wqt3kFnYwJYLylHti419y9ZWyIQ==
X-Google-Smtp-Source: APBJJlE3EW1xa90VgWXh65s2Sg3RlV68Y4T7PFwCSdCLBD92lbzBXTv8AduSkNV4uu5oFgeFbc09CUlsHkqmf0oFQ+M=
X-Received: by 2002:a05:622a:24c:b0:403:5b16:3e8a with SMTP id
 c12-20020a05622a024c00b004035b163e8amr20208qtx.9.1688521238897; Tue, 04 Jul
 2023 18:40:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230703135330.1865927-1-ryan.roberts@arm.com>
 <20230703135330.1865927-4-ryan.roberts@arm.com> <ac6802f6-01a2-6b39-38c7-2fe3cea75dde@intel.com>
 <CAOUHufbmv0pZ1h9AxBj-SD7OqRZYudHMtXzQxcwD4ky-sFd8kg@mail.gmail.com>
 <CAOUHufbpCU_Z7g1QPJ0+HzE9sdNpSh=Mzi0EByLPu5TE4S_UcQ@mail.gmail.com>
 <6d389825-1fc0-5c16-7858-2290fd632682@arm.com> <dd9ea461-df2d-afe1-a67c-c73ac1cb96b4@arm.com>
In-Reply-To: <dd9ea461-df2d-afe1-a67c-c73ac1cb96b4@arm.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Tue, 4 Jul 2023 19:40:02 -0600
Message-ID: <CAOUHufYRBQv2WZ-RcF5qDm7Y6yLxmzoYzpfUh_CZ5dV=S5L4FA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] mm: Default implementation of arch_wants_pte_order()
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     "Yin, Fengwei" <fengwei.yin@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
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

On Tue, Jul 4, 2023 at 7:23=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com> =
wrote:
>
> On 04/07/2023 13:36, Ryan Roberts wrote:
> > On 04/07/2023 04:59, Yu Zhao wrote:
> >> On Mon, Jul 3, 2023 at 9:02=E2=80=AFPM Yu Zhao <yuzhao@google.com> wro=
te:
> >>>
> >>> On Mon, Jul 3, 2023 at 8:23=E2=80=AFPM Yin, Fengwei <fengwei.yin@inte=
l.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 7/3/2023 9:53 PM, Ryan Roberts wrote:
> >>>>> arch_wants_pte_order() can be overridden by the arch to return the
> >>>>> preferred folio order for pte-mapped memory. This is useful as some
> >>>>> architectures (e.g. arm64) can coalesce TLB entries when the physic=
al
> >>>>> memory is suitably contiguous.
> >>>>>
> >>>>> The first user for this hint will be FLEXIBLE_THP, which aims to
> >>>>> allocate large folios for anonymous memory to reduce page faults an=
d
> >>>>> other per-page operation costs.
> >>>>>
> >>>>> Here we add the default implementation of the function, used when t=
he
> >>>>> architecture does not define it, which returns the order correspond=
ing
> >>>>> to 64K.
> >>>>>
> >>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> >>>>> ---
> >>>>>  include/linux/pgtable.h | 13 +++++++++++++
> >>>>>  1 file changed, 13 insertions(+)
> >>>>>
> >>>>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> >>>>> index a661a17173fa..f7e38598f20b 100644
> >>>>> --- a/include/linux/pgtable.h
> >>>>> +++ b/include/linux/pgtable.h
> >>>>> @@ -13,6 +13,7 @@
> >>>>>  #include <linux/errno.h>
> >>>>>  #include <asm-generic/pgtable_uffd.h>
> >>>>>  #include <linux/page_table_check.h>
> >>>>> +#include <linux/sizes.h>
> >>>>>
> >>>>>  #if 5 - defined(__PAGETABLE_P4D_FOLDED) - defined(__PAGETABLE_PUD_=
FOLDED) - \
> >>>>>       defined(__PAGETABLE_PMD_FOLDED) !=3D CONFIG_PGTABLE_LEVELS
> >>>>> @@ -336,6 +337,18 @@ static inline bool arch_has_hw_pte_young(void)
> >>>>>  }
> >>>>>  #endif
> >>>>>
> >>>>> +#ifndef arch_wants_pte_order
> >>>>> +/*
> >>>>> + * Returns preferred folio order for pte-mapped memory. Must be in=
 range [0,
> >>>>> + * PMD_SHIFT-PAGE_SHIFT) and must not be order-1 since THP require=
s large folios
> >>>>> + * to be at least order-2.
> >>>>> + */
> >>>>> +static inline int arch_wants_pte_order(struct vm_area_struct *vma)
> >>>>> +{
> >>>>> +     return ilog2(SZ_64K >> PAGE_SHIFT);
> >>>> Default value which is not related with any silicon may be: PAGE_ALL=
OC_COSTLY_ORDER?
> >>>>
> >>>> Also, current pcp list support cache page with order 0...PAGE_ALLOC_=
COSTLY_ORDER, 9.
> >>>> If the pcp could cover the page, the pressure to zone lock will be r=
educed by pcp.
> >>>
> >>> The value of PAGE_ALLOC_COSTLY_ORDER is reasonable but again it's a
> >>> s/w policy not a h/w preference. Besides, I don't think we can includ=
e
> >>> mmzone.h in pgtable.h.
> >>
> >> I think we can make a compromise:
> >> 1. change the default implementation of arch_has_hw_pte_young() to ret=
urn 0, and
> >> 2. in memory.c, we can try PAGE_ALLOC_COSTLY_ORDER for archs that
> >> don't override arch_has_hw_pte_young(), or if its return value is too
> >> large to fit.
> >> This should also take care of the regression, right?
> >
> > I think you are suggesting that we use 0 as a sentinel which we then tr=
anslate
> > to PAGE_ALLOC_COSTLY_ORDER? I already have a max_anon_folio_order() fun=
ction in
> > memory.c (actually it is currently a macro defined as arch_wants_pte_or=
der()).
> >
> > So it would become (I'll talk about the vma concern separately in the t=
hread
> > where you raised it):
> >
> > static inline int max_anon_folio_order(struct vm_area_struct *vma)
> > {
> >       int order =3D arch_wants_pte_order(vma);
> >
> >       return order ? order : PAGE_ALLOC_COSTLY_ORDER;
> > }
> >
> > Correct?
>
> Actually, I'm not sure its a good idea to default to a fixed order. If ru=
nning
> on an arch with big base pages (e.g. powerpc with 64K pages?), that will =
soon
> add up to a big chunk of memory, which could be wasteful?
>
> PAGE_ALLOC_COSTLY_ORDER =3D 3 so with 64K base page, that 512K. Is that a=
 concern?
> Wouldn't it be better to define this as an absolute size? Or even the min=
 of
> PAGE_ALLOC_COSTLY_ORDER and an absolute size?

For my POV, not at all. POWER can use smaller page sizes if they
wanted to -- I don't think they do: at least the distros I use on my
POWER9 all have THP=3Dalways by default (2MB).
