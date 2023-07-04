Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD9974682A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 05:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbjGDD7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 23:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGDD7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 23:59:48 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF74BD
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 20:59:47 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-401f4408955so503651cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 20:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688443186; x=1691035186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zm+cbLzfWv8xQzz04PlgTjHqAfLoOmxEeEXG844VmE8=;
        b=HIj+iC2rU31igXpNrnKYzp4Bk4To59lPiI9RQ+9xPO7DG8UTuVnh9X0Zo5gGvxpYvW
         E0u65h2AZ9L29tKE93Zb3lG/RucSwTtaZMttt8uzvzfMh+u5fmRKyCP9sQDv3STbtXDZ
         dVWKDUoBZTeDl/6Ah3YCWvPi4zxXuCwaN5zYS3r6JT8dMyVUi4wDFa2UgxnAbrmoVZTj
         EGpFNKzlE2lrjsJcZAc89o09vz+o5mzP96zvaQxvORvBHevnKUPWHqTEHZRIH0qcO0ds
         4KbOHl1sFjpv0NCkyw2RXVsrAjoNL88cHsQIXm2iuPk0ZXZdeLDDJw6L/a35ud882NiN
         EXxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688443186; x=1691035186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zm+cbLzfWv8xQzz04PlgTjHqAfLoOmxEeEXG844VmE8=;
        b=EFP0pFetsDPzXZR/Ij89AIug/K/coMNCqhvjHwPsW7URsRNTCSEb0vwZ9sX0dl3e5w
         wTWZCx7uJ4qd7OG/kEdTlaACzkDLuAA6nPlvKXU6Z/hn+4jEhsjLIxxW0WQ4EEQaIMzv
         Lg0k+i/ilHLnlLIsiyJO1OmDbgI7H+l4DS9bSRVsZ+18hUlEVWKT3Zera5ua80bkVmtZ
         AfP3Lr941CHs01L/oRBx8jj9L0VxWpTfTdlfYcXaNJ7qXN0eCRq1vWiNq9Vkcd0yPInh
         IgMrhUXGtaUvWrIJq65MU8nfu8OBLFwJuN8xbsVIuW9Ph42ib8BOwA5t0trwxC2R1k23
         MRkg==
X-Gm-Message-State: ABy/qLZRtltH/JRH43F/GdI3Ih1DdIH+TsWSrROndyt2tfn/CWXOSPC8
        o1NHTfRu7TM3uqcUANhzQUGCCQcmvk94ER3cs/jEBg==
X-Google-Smtp-Source: APBJJlFLbIWWh/EXTophAdzPyJXhAfvQ02fpxkoFTx3lCbvkugucdvVU9jr294theQsiHzkxWsglBzr3u6bN2xE2+VM=
X-Received: by 2002:ac8:4e4c:0:b0:3f6:97b4:1a4a with SMTP id
 e12-20020ac84e4c000000b003f697b41a4amr47873qtw.20.1688443186346; Mon, 03 Jul
 2023 20:59:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230703135330.1865927-1-ryan.roberts@arm.com>
 <20230703135330.1865927-4-ryan.roberts@arm.com> <ac6802f6-01a2-6b39-38c7-2fe3cea75dde@intel.com>
 <CAOUHufbmv0pZ1h9AxBj-SD7OqRZYudHMtXzQxcwD4ky-sFd8kg@mail.gmail.com>
In-Reply-To: <CAOUHufbmv0pZ1h9AxBj-SD7OqRZYudHMtXzQxcwD4ky-sFd8kg@mail.gmail.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Mon, 3 Jul 2023 21:59:09 -0600
Message-ID: <CAOUHufbpCU_Z7g1QPJ0+HzE9sdNpSh=Mzi0EByLPu5TE4S_UcQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] mm: Default implementation of arch_wants_pte_order()
To:     "Yin, Fengwei" <fengwei.yin@intel.com>,
        Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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

On Mon, Jul 3, 2023 at 9:02=E2=80=AFPM Yu Zhao <yuzhao@google.com> wrote:
>
> On Mon, Jul 3, 2023 at 8:23=E2=80=AFPM Yin, Fengwei <fengwei.yin@intel.co=
m> wrote:
> >
> >
> >
> > On 7/3/2023 9:53 PM, Ryan Roberts wrote:
> > > arch_wants_pte_order() can be overridden by the arch to return the
> > > preferred folio order for pte-mapped memory. This is useful as some
> > > architectures (e.g. arm64) can coalesce TLB entries when the physical
> > > memory is suitably contiguous.
> > >
> > > The first user for this hint will be FLEXIBLE_THP, which aims to
> > > allocate large folios for anonymous memory to reduce page faults and
> > > other per-page operation costs.
> > >
> > > Here we add the default implementation of the function, used when the
> > > architecture does not define it, which returns the order correspondin=
g
> > > to 64K.
> > >
> > > Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> > > ---
> > >  include/linux/pgtable.h | 13 +++++++++++++
> > >  1 file changed, 13 insertions(+)
> > >
> > > diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> > > index a661a17173fa..f7e38598f20b 100644
> > > --- a/include/linux/pgtable.h
> > > +++ b/include/linux/pgtable.h
> > > @@ -13,6 +13,7 @@
> > >  #include <linux/errno.h>
> > >  #include <asm-generic/pgtable_uffd.h>
> > >  #include <linux/page_table_check.h>
> > > +#include <linux/sizes.h>
> > >
> > >  #if 5 - defined(__PAGETABLE_P4D_FOLDED) - defined(__PAGETABLE_PUD_FO=
LDED) - \
> > >       defined(__PAGETABLE_PMD_FOLDED) !=3D CONFIG_PGTABLE_LEVELS
> > > @@ -336,6 +337,18 @@ static inline bool arch_has_hw_pte_young(void)
> > >  }
> > >  #endif
> > >
> > > +#ifndef arch_wants_pte_order
> > > +/*
> > > + * Returns preferred folio order for pte-mapped memory. Must be in r=
ange [0,
> > > + * PMD_SHIFT-PAGE_SHIFT) and must not be order-1 since THP requires =
large folios
> > > + * to be at least order-2.
> > > + */
> > > +static inline int arch_wants_pte_order(struct vm_area_struct *vma)
> > > +{
> > > +     return ilog2(SZ_64K >> PAGE_SHIFT);
> > Default value which is not related with any silicon may be: PAGE_ALLOC_=
COSTLY_ORDER?
> >
> > Also, current pcp list support cache page with order 0...PAGE_ALLOC_COS=
TLY_ORDER, 9.
> > If the pcp could cover the page, the pressure to zone lock will be redu=
ced by pcp.
>
> The value of PAGE_ALLOC_COSTLY_ORDER is reasonable but again it's a
> s/w policy not a h/w preference. Besides, I don't think we can include
> mmzone.h in pgtable.h.

I think we can make a compromise:
1. change the default implementation of arch_has_hw_pte_young() to return 0=
, and
2. in memory.c, we can try PAGE_ALLOC_COSTLY_ORDER for archs that
don't override arch_has_hw_pte_young(), or if its return value is too
large to fit.
This should also take care of the regression, right?
