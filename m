Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFE9747A82
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 01:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbjGDXsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 19:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjGDXsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 19:48:00 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17F3B2
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 16:47:58 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-401d1d967beso790211cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 16:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688514477; x=1691106477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vzsW9V6cYwbiTk6roJohmCrKlCh8UZOL6XV8hys3VC0=;
        b=aENPbEDVN2wLWR/YyuQfA60jQp2CSZg91/i3dh1idVI6i+y04ds1g4UidyhRFB+Kua
         /Xw5RZe3VVRTKX18667MpwQ/lwxpbd6zVx8ayOGcHjLvGLCnJiHr9wG/skS2wpQUlnAH
         sOE6M3D8Tk3iT+02VU77gDZ1p4h0D3e/BlGkdn6tCdZT9hVYxOAZ6T590bXQNZ/N0O91
         6EUPRB6J74Kk4LV4+Lce6/OWC12ZkL5Xcegm3gGvF1RFt/1g93hmXv5rpPMRD+LiWUFX
         Ps2NnW2p1CVbHLpw606wMm0qCCxB7qVT2yhYrdPkOeAZbvLLdKLgkkrkeyhUklldMQ1j
         38IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688514477; x=1691106477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vzsW9V6cYwbiTk6roJohmCrKlCh8UZOL6XV8hys3VC0=;
        b=EJHcukavbErlK18M72nI3bPk9WI35WRriqwOh7LyGPUwDB+vRuzwoGFQXTbm/p9zMA
         FZ5j6vm5eHF6VpcAdvdfMIuP78l6AxLXB+eh1NHVQ4SjzRDunf4gfNUaT1wBEw4lJTcT
         sTX+5rk98CxewsAURwou0NSWuEO+V4z3q5DWSbD4bskotPsYv0z/E2EMJsqL6NdunlB+
         uE9O7hxa6Vj9ZUKPcLWMlyXQkfabErQbt8SGHXimjR80TnfdXTqKvZOdzRTV/5JG8DTT
         sL7npYT34x+9CBAPDuKhcv7IxYV8AJQx/BNN763ArB3IdJR269+KhBSQ2BdjYV7oJQ7D
         VSAg==
X-Gm-Message-State: ABy/qLb+c9Y83R4OPniiFbV6tZj1xgYyWf0KTruUsTlsuv7Ga+ov2XcZ
        vbvLssh4xmSclAX1GnPjbxwfOC4cCpASzTlB+kWd2Q==
X-Google-Smtp-Source: APBJJlFGIJpdidlpiYWYiWyVVrCdDl+ScMHCwAcJcohMT1PeBBzoe7HzBh6g2H0tnuYdXDBZ/SPgV02h9Sj1ZW3MUzs=
X-Received: by 2002:a05:622a:15ce:b0:3f0:af20:1a37 with SMTP id
 d14-20020a05622a15ce00b003f0af201a37mr10671qty.15.1688514476834; Tue, 04 Jul
 2023 16:47:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230703135330.1865927-1-ryan.roberts@arm.com>
 <20230703135330.1865927-5-ryan.roberts@arm.com> <CAOUHufaK82K8Sa35T7z3=gkm4GB0cWD3aqeZF6mYx82v7cOTeA@mail.gmail.com>
 <22b23340-5fad-01be-6bac-fa30a3724b27@arm.com>
In-Reply-To: <22b23340-5fad-01be-6bac-fa30a3724b27@arm.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Tue, 4 Jul 2023 17:47:20 -0600
Message-ID: <CAOUHufZWONm+5QTo9F-2iyKdAHC+Nz2NPkWuJ1QsE6d4QjXgrA@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] mm: FLEXIBLE_THP for improved performance
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

On Tue, Jul 4, 2023 at 8:08=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com> =
wrote:
>
> On 04/07/2023 02:35, Yu Zhao wrote:
> > On Mon, Jul 3, 2023 at 7:53=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.c=
om> wrote:
> >>
> >> Introduce FLEXIBLE_THP feature, which allows anonymous memory to be
> >> allocated in large folios of a specified order. All pages of the large
> >> folio are pte-mapped during the same page fault, significantly reducin=
g
> >> the number of page faults. The number of per-page operations (e.g. ref
> >> counting, rmap management lru list management) are also significantly
> >> reduced since those ops now become per-folio.
> >>
> >> The new behaviour is hidden behind the new FLEXIBLE_THP Kconfig, which
> >> defaults to disabled for now; there is a long list of todos to make
> >> FLEXIBLE_THP robust with existing features (e.g. compaction, mlock, so=
me
> >> madvise ops, etc). These items will be tackled in subsequent patches.
> >>
> >> When enabled, the preferred folio order is as returned by
> >> arch_wants_pte_order(), which may be overridden by the arch as it sees
> >> fit. Some architectures (e.g. arm64) can coalsece TLB entries if a
> >
> > coalesce
>
> ACK
>
> >
> >> contiguous set of ptes map physically contigious, naturally aligned
> >
> > contiguous
>
> ACK
>
> >
> >> memory, so this mechanism allows the architecture to optimize as
> >> required.
> >>
> >> If the preferred order can't be used (e.g. because the folio would
> >> breach the bounds of the vma, or because ptes in the region are alread=
y
> >> mapped) then we fall back to a suitable lower order.
> >>
> >> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> >> ---
> >>  mm/Kconfig  |  10 ++++
> >>  mm/memory.c | 168 ++++++++++++++++++++++++++++++++++++++++++++++++---=
-
> >>  2 files changed, 165 insertions(+), 13 deletions(-)
> >>
> >> diff --git a/mm/Kconfig b/mm/Kconfig
> >> index 7672a22647b4..1c06b2c0a24e 100644
> >> --- a/mm/Kconfig
> >> +++ b/mm/Kconfig
> >> @@ -822,6 +822,16 @@ config READ_ONLY_THP_FOR_FS
> >>           support of file THPs will be developed in the next few relea=
se
> >>           cycles.
> >>
> >> +config FLEXIBLE_THP
> >> +       bool "Flexible order THP"
> >> +       depends on TRANSPARENT_HUGEPAGE
> >> +       default n
> >
> > The default value is already N.
>
> Is there a coding standard for this? Personally I prefer to make it expli=
cit.
>
> >
> >> +       help
> >> +         Use large (bigger than order-0) folios to back anonymous mem=
ory where
> >> +         possible, even if the order of the folio is smaller than the=
 PMD
> >> +         order. This reduces the number of page faults, as well as ot=
her
> >> +         per-page overheads to improve performance for many workloads=
.
> >> +
> >>  endif # TRANSPARENT_HUGEPAGE
> >>
> >>  #
> >> diff --git a/mm/memory.c b/mm/memory.c
> >> index fb30f7523550..abe2ea94f3f5 100644
> >> --- a/mm/memory.c
> >> +++ b/mm/memory.c
> >> @@ -3001,6 +3001,116 @@ static vm_fault_t fault_dirty_shared_page(stru=
ct vm_fault *vmf)
> >>         return 0;
> >>  }
> >>
> >> +#ifdef CONFIG_FLEXIBLE_THP
> >> +/*
> >> + * Allocates, zeros and returns a folio of the requested order for us=
e as
> >> + * anonymous memory.
> >> + */
> >> +static struct folio *alloc_anon_folio(struct vm_area_struct *vma,
> >> +                                     unsigned long addr, int order)
> >> +{
> >> +       gfp_t gfp;
> >> +       struct folio *folio;
> >> +
> >> +       if (order =3D=3D 0)
> >> +               return vma_alloc_zeroed_movable_folio(vma, addr);
> >> +
> >> +       gfp =3D vma_thp_gfp_mask(vma);
> >> +       folio =3D vma_alloc_folio(gfp, order, vma, addr, true);
> >> +       if (folio)
> >> +               clear_huge_page(&folio->page, addr, folio_nr_pages(fol=
io));
> >> +
> >> +       return folio;
> >> +}
> >> +
> >> +/*
> >> + * Preferred folio order to allocate for anonymous memory.
> >> + */
> >> +#define max_anon_folio_order(vma)      arch_wants_pte_order(vma)
> >> +#else
> >> +#define alloc_anon_folio(vma, addr, order) \
> >> +                               vma_alloc_zeroed_movable_folio(vma, ad=
dr)
> >> +#define max_anon_folio_order(vma)      0
> >> +#endif
> >> +
> >> +/*
> >> + * Returns index of first pte that is not none, or nr if all are none=
.
> >> + */
> >> +static inline int check_ptes_none(pte_t *pte, int nr)
> >> +{
> >> +       int i;
> >> +
> >> +       for (i =3D 0; i < nr; i++) {
> >> +               if (!pte_none(ptep_get(pte++)))
> >> +                       return i;
> >> +       }
> >> +
> >> +       return nr;
> >> +}
> >> +
> >> +static int calc_anon_folio_order_alloc(struct vm_fault *vmf, int orde=
r)
> >> +{
> >> +       /*
> >> +        * The aim here is to determine what size of folio we should a=
llocate
> >> +        * for this fault. Factors include:
> >> +        * - Order must not be higher than `order` upon entry
> >> +        * - Folio must be naturally aligned within VA space
> >> +        * - Folio must be fully contained inside one pmd entry
> >> +        * - Folio must not breach boundaries of vma
> >> +        * - Folio must not overlap any non-none ptes
> >> +        *
> >> +        * Additionally, we do not allow order-1 since this breaks ass=
umptions
> >> +        * elsewhere in the mm; THP pages must be at least order-2 (si=
nce they
> >> +        * store state up to the 3rd struct page subpage), and these p=
ages must
> >> +        * be THP in order to correctly use pre-existing THP infrastru=
cture such
> >> +        * as folio_split().
> >> +        *
> >> +        * Note that the caller may or may not choose to lock the pte.=
 If
> >> +        * unlocked, the result is racy and the user must re-check any=
 overlap
> >> +        * with non-none ptes under the lock.
> >> +        */
> >> +
> >> +       struct vm_area_struct *vma =3D vmf->vma;
> >> +       int nr;
> >> +       unsigned long addr;
> >> +       pte_t *pte;
> >> +       pte_t *first_set =3D NULL;
> >> +       int ret;
> >> +
> >> +       order =3D min(order, PMD_SHIFT - PAGE_SHIFT);
> >> +
> >> +       for (; order > 1; order--) {
> >
> > I'm not sure how we can justify this policy. As an initial step, it'd
> > be a lot easier to sell if we only considered the order of
> > arch_wants_pte_order() and the order 0.
>
> My justification is in the cover letter; I see performance regression (vs=
 the
> unpatched kernel) when using the policy you suggest. This policy performs=
 much
> better in my tests. (I'll reply directly to your follow up questions in t=
he
> cover letter shortly).
>
> What are your technical concerns about this approach? It is pretty light =
weight
> (I only touch each PTE once, regardless of the number of loops). If we ha=
ve
> strong technical reasons for reverting to the less performant approach th=
en fair
> enough, but I'd like to hear the rational first.

Yes, mainly from three different angles:
1. The engineering principle: we'd want to separate the mechanical
part and the policy part when attacking something large. This way it'd
be easier to root cause any regressions if they happen. In our case,
assuming the regression is real, it might actually prove my point
here: I really don't think the two checks (if a vma range fits and if
it does, which is unlikely according to your description, if all 64
PTEs are none) caused the regression. My theory is that 64KB itself
caused the regression, but smaller sizes made an improvement. If this
is really the case, I'd say the fallback policy masked the real
problem, which is that 64KB is too large to begin with.
2. The benchmark methodology: I appreciate your effort in doing it,
but we also need to consider that the setup is an uncommon scenario.
The common scenarios are devices that have been running for weeks
without reboots, generally having higher external fragmentation. In
addition, for client devices, they are often under memory pressure,
which makes fragmentation worse. So we should take the result with a
grain of salt, and for that matter, results from after refresh
reboots.
3. The technical concern: an ideal policy would consider all three
major factors: the h/w features, userspace behaviors and the page
allocator behavior. So far we only have the first one handy. The
second one is too challenging, so let's forget about it for now. The
third one is why I really don't like this best-fit policy. By falling
back to smaller orders, we can waste a limited number of physically
contiguous pages on wrong vmas (small vmas only), leading to failures
to serve large vmas which otherwise would have a higher overall ROI.
This can only be addressed within the page allocator: we need to
enlighten it to return the highest order available, i.e., not breaking
up any higher orders.

I'm not really saying we should never try this fallback policy. I'm
just thinking we can leave it for later, probably after we've
addressed all the concerns with basic functionality.
