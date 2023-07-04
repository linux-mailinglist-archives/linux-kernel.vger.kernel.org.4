Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B7F7467C2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 05:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjGDDCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 23:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjGDDCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 23:02:46 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7758BC
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 20:02:44 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-401f4408955so497331cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 20:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688439764; x=1691031764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dktH0EaAxziz/YyKCgk9PPi6NbZ1myGav4v41/iNHYs=;
        b=oRYmjAuG5OrJ22qNqGl3VJlEGGJ32hqSIlxdafXNMFkMZSalzAP+vRQfXs4zEvBhD3
         2rCs9hp3xTlPtCMX75HWQMfN2sXyItLDrWz+eX+JkWWw6IkAqLVFlZDv7Cpluq2eAsZr
         XEOxogmdXqYFKuDuvZ8ZTLQcGIHEKm3pGgS31qamVc7pJhSeMx27kWkLjLA2MKp0G2i/
         m2miQgSGXYU+tdTZG1KhSK1x5ZjfIY7rNf+hlNBqL1IzsM1c6OjSlFHBp9qGl+2KhoRT
         +p/FyNvgrxuIQTxLRRnxoewQJ9pp0VY001sp6zVvpb69Rjtgh94gAjF1eIp9kfHKSK7J
         ifDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688439764; x=1691031764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dktH0EaAxziz/YyKCgk9PPi6NbZ1myGav4v41/iNHYs=;
        b=fnRNJxZ8egde7BXIGyalTFq6we07o2hOIq7eTn8PWZ2vSDKCJqYPsuZJnPMPfsAD+b
         qTgT2aKlZQioGyDqfSIDmtsGvF1ESMJ4ipJtRPgt0LhHqThn5AOoJA594pND7LnYXPKR
         OduqDAvHVxQG4xqNlScRkzevQLEtibQ9q2ux73g2YoMmGdSrcFctGoDMZ864ZCZFG3uf
         uDWS4RJ6z91VKTbtfQCHM6ILts8aXA1VZM1tnSa+Fs7YX0inx503PNrbm+iTeA79HjHr
         5ScGaJovcgR0cAKZRD3mgpko/UqbCFHRPjwXkUBU/5XFQZCn52ms41onYjX8BzC3l9eF
         7jxg==
X-Gm-Message-State: ABy/qLYDfIO/+kV9rhTtDd4dJN3MS6oySNoJbYsIYj9p/1XRE2ONvh+J
        VvgXoVtvjNDI3YipkOPQFYpleszb1zqZIKEIJ7F+kg==
X-Google-Smtp-Source: APBJJlF6mD0c+IGSkgOYzurfZTe7xBcPX022Wa1WzHG0Y0yEGfMJtiT+d2KUpag61alS3EkGs04urSXvDJtnwxPlRsA=
X-Received: by 2002:a05:622a:1812:b0:3f9:ab2c:88b9 with SMTP id
 t18-20020a05622a181200b003f9ab2c88b9mr20981qtc.25.1688439763908; Mon, 03 Jul
 2023 20:02:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230703135330.1865927-1-ryan.roberts@arm.com>
 <20230703135330.1865927-4-ryan.roberts@arm.com> <ac6802f6-01a2-6b39-38c7-2fe3cea75dde@intel.com>
In-Reply-To: <ac6802f6-01a2-6b39-38c7-2fe3cea75dde@intel.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Mon, 3 Jul 2023 21:02:07 -0600
Message-ID: <CAOUHufbmv0pZ1h9AxBj-SD7OqRZYudHMtXzQxcwD4ky-sFd8kg@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] mm: Default implementation of arch_wants_pte_order()
To:     "Yin, Fengwei" <fengwei.yin@intel.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>,
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

On Mon, Jul 3, 2023 at 8:23=E2=80=AFPM Yin, Fengwei <fengwei.yin@intel.com>=
 wrote:
>
>
>
> On 7/3/2023 9:53 PM, Ryan Roberts wrote:
> > arch_wants_pte_order() can be overridden by the arch to return the
> > preferred folio order for pte-mapped memory. This is useful as some
> > architectures (e.g. arm64) can coalesce TLB entries when the physical
> > memory is suitably contiguous.
> >
> > The first user for this hint will be FLEXIBLE_THP, which aims to
> > allocate large folios for anonymous memory to reduce page faults and
> > other per-page operation costs.
> >
> > Here we add the default implementation of the function, used when the
> > architecture does not define it, which returns the order corresponding
> > to 64K.
> >
> > Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> > ---
> >  include/linux/pgtable.h | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> > index a661a17173fa..f7e38598f20b 100644
> > --- a/include/linux/pgtable.h
> > +++ b/include/linux/pgtable.h
> > @@ -13,6 +13,7 @@
> >  #include <linux/errno.h>
> >  #include <asm-generic/pgtable_uffd.h>
> >  #include <linux/page_table_check.h>
> > +#include <linux/sizes.h>
> >
> >  #if 5 - defined(__PAGETABLE_P4D_FOLDED) - defined(__PAGETABLE_PUD_FOLD=
ED) - \
> >       defined(__PAGETABLE_PMD_FOLDED) !=3D CONFIG_PGTABLE_LEVELS
> > @@ -336,6 +337,18 @@ static inline bool arch_has_hw_pte_young(void)
> >  }
> >  #endif
> >
> > +#ifndef arch_wants_pte_order
> > +/*
> > + * Returns preferred folio order for pte-mapped memory. Must be in ran=
ge [0,
> > + * PMD_SHIFT-PAGE_SHIFT) and must not be order-1 since THP requires la=
rge folios
> > + * to be at least order-2.
> > + */
> > +static inline int arch_wants_pte_order(struct vm_area_struct *vma)
> > +{
> > +     return ilog2(SZ_64K >> PAGE_SHIFT);
> Default value which is not related with any silicon may be: PAGE_ALLOC_CO=
STLY_ORDER?
>
> Also, current pcp list support cache page with order 0...PAGE_ALLOC_COSTL=
Y_ORDER, 9.
> If the pcp could cover the page, the pressure to zone lock will be reduce=
d by pcp.

The value of PAGE_ALLOC_COSTLY_ORDER is reasonable but again it's a
s/w policy not a h/w preference. Besides, I don't think we can include
mmzone.h in pgtable.h.
