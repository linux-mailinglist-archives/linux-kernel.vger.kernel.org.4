Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05409740374
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 20:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbjF0SeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 14:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjF0SeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 14:34:19 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF313198C
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 11:33:46 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-401f4408955so40461cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 11:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687890825; x=1690482825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PTIY9reQDxCVjeBIGzBvbwdTkf7d3X2+E+ffOvvfOt8=;
        b=IFZFZBAdSS5WPvdUVXRmtMP6d4it0zMJf/l2GDxZXOXh1ctIJNlPkvj2sinpxjJpBe
         LSKJg/UTJqQVTKhWODYjkO1i4nmcSjjuGZmBYcplmBZiyiFW6CuoXRu+bQTCz2WCa1nH
         SdQntuzU7sGVa9Zb4/4LWl80uj4Q0BPHxEdxix7lK5L3lwfGKXDqrn1GAAYX6QuI7vNE
         z1pBKRtW9A03Pn/i46V3X9p17H8SAeO0G3yXELGKIy5uxYSjsIK7Iv6IFYtp9hQ3EnpD
         eG251UrPtZeVpaEySuJiM3LXqN8D4gZAZ/2Sukeubj3yBMBzkQ54sCd/tzIGiPBSNQ4H
         dJIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687890825; x=1690482825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PTIY9reQDxCVjeBIGzBvbwdTkf7d3X2+E+ffOvvfOt8=;
        b=hujNr027o3Y3JrZgmnqEKlMw6tG3zWPJDLntdbAftXwFaorfHYd1fYQMOivzc5/jPu
         dPP05hPuTMEMOAq+5cjj69FB2aaE8Etp5sWSPr3BgLY3WeYnpHNF1DIDOYqoMCexUW90
         20wVo9O3bHIupx6mHaEsf9z+rxpXt0OJoEB6HFJ3AY4kIdOAKY9kQ6rhh1wXFLKV79Lg
         6B69MOnjVjHR+xFAcN4vIJhEYXxQwv9n+IdR2ABt1AJPva0WJVIqNZ7DBC0dgUL41O58
         gAVeTUKu6CeQRI1lo3MsykE/dKCxb7LucoPYYHePuSbfkf03Ug91sGI2BTEPsSeZG0t8
         TFLQ==
X-Gm-Message-State: AC+VfDyE9voZRudS23V4X7cR/2cNDhWW0uBN5VELVQ3DhZ3lpJr/U/5x
        WebMo/NOB394Rt9RY49+/KaFIVUVA4Dis1ecQoi08g==
X-Google-Smtp-Source: ACHHUZ6J+FwNO1q3sZEb2eJpxaQ1yK9y93HAAT9rQ/w4kcix4s3yyUXUt2xkbkSmZhsyVHdXENGOFgl+h8r/6XgSKPU=
X-Received: by 2002:a05:622a:2d2:b0:3fd:ad1b:4e8a with SMTP id
 a18-20020a05622a02d200b003fdad1b4e8amr15807qtx.22.1687890825017; Tue, 27 Jun
 2023 11:33:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230626171430.3167004-1-ryan.roberts@arm.com>
 <20230626171430.3167004-11-ryan.roberts@arm.com> <CAOUHufarua_JmnTu5NM-W3K4Togw+24F=Pf0HU0ZOjuwbRMC0A@mail.gmail.com>
 <0c98f854-b4e4-9a71-8e0c-1556bc79468c@arm.com>
In-Reply-To: <0c98f854-b4e4-9a71-8e0c-1556bc79468c@arm.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Tue, 27 Jun 2023 12:33:09 -0600
Message-ID: <CAOUHufa21rX1ODOZ0iJxiy4pstgGqhkbfYozg8-+sRp5ZxAOjA@mail.gmail.com>
Subject: Re: [PATCH v1 10/10] mm: Allocate large folios for anonymous memory
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
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
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 3:57=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 27/06/2023 04:01, Yu Zhao wrote:
> > On Mon, Jun 26, 2023 at 11:15=E2=80=AFAM Ryan Roberts <ryan.roberts@arm=
.com> wrote:
> >>
> >> With all of the enabler patches in place, modify the anonymous memory
> >> write allocation path so that it opportunistically attempts to allocat=
e
> >> a large folio up to `max_anon_folio_order()` size (This value is
> >> ultimately configured by the architecture). This reduces the number of
> >> page faults, reduces the size of (e.g. LRU) lists, and generally
> >> improves performance by batching what were per-page operations into
> >> per-(large)-folio operations.
> >>
> >> If CONFIG_LARGE_ANON_FOLIO is not enabled (the default) then
> >> `max_anon_folio_order()` always returns 0, meaning we get the existing
> >> allocation behaviour.
> >>
> >> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> >> ---
> >>  mm/memory.c | 159 +++++++++++++++++++++++++++++++++++++++++++++++----=
-
> >>  1 file changed, 144 insertions(+), 15 deletions(-)
> >>
> >> diff --git a/mm/memory.c b/mm/memory.c
> >> index a8f7e2b28d7a..d23c44cc5092 100644
> >> --- a/mm/memory.c
> >> +++ b/mm/memory.c
> >> @@ -3161,6 +3161,90 @@ static inline int max_anon_folio_order(struct v=
m_area_struct *vma)
> >>                 return CONFIG_LARGE_ANON_FOLIO_NOTHP_ORDER_MAX;
> >>  }
> >>
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
> >
> > As suggested previously in 03/10, we can leave this for later.
>
> I disagree. This is the logic that prevents us from accidentally replacin=
g
> already set PTEs, or wandering out of the VMA bounds etc. How would you c=
atch
> all those corener cases without this?

Again, sorry for not being clear previously: we definitely need to
handle alignments & overlapps. But the fallback, i.e., "for (; order >
1; order--) {" in calc_anon_folio_order_alloc() is not necessary.

For now, we just need something like

  bool is_order_suitable() {
    // check whether it fits properly
  }

Later on, we could add

  alloc_anon_folio_best_effort()
  {
    for a list of fallback orders
      is_order_suitable()
  }
