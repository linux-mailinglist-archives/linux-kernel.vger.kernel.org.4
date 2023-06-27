Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7FC573F745
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 10:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbjF0Ibo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 04:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbjF0IbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 04:31:17 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7615430D8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 01:30:00 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-4007b5bafceso153321cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 01:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687854598; x=1690446598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=42jADAOC7MZeTbDlvQImONhBTFD+TYlgsjaZgjq+r6w=;
        b=VpUHivcqvdUZrgCRoZwbsCsrDHhYaYFcsFaeAfGB+kCFckJgv9C01BvGN7jtR5nsY4
         HQcueTVDNqcIMaUYqjBVwihu6lYI6bfIM3pKFCtOYc7iaIumcdkrpQuM/LMDhLV1YoII
         sN+SrgrTedc0+L9S4RRMyWUtAZ3mBNF40ufDFY+rRoM4mNQOBfPdAXOrKLfC+DTXxl1T
         tC9pivLeFKSbhdaC0QRd6FoML3RCBD2NWh9k9jCs4Lma13vQN5ZuOaIzCrfSnQlro4qX
         MabKVbrPXuLu/C79k5WxkAoG21mlNwBJ8ocvaep3wOCVgalzbEjgVw/ubMrj6jPz4ekv
         VwYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687854598; x=1690446598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=42jADAOC7MZeTbDlvQImONhBTFD+TYlgsjaZgjq+r6w=;
        b=IcG0CnSuQUiJkHRSGnVNTqA510O1rZuxAqVZ+Rnz7o+4i7LI3v1LmbwOHA1ZtZEGNc
         t8D0wJNhqTc+BzGWe+URYXzxvoVGxSvmAG4VfIVpkpXujkGcjoLJaZO86kwq0Md7e779
         ChHqUpMHau1H+v4r9qAOVDaRCbk4F8aT48BurRDPEI4MhkKmWoSaeX6wzS+EFg9W7jXS
         dGQyOU9Ijl7kfDNGLJI15GwlfIzSCYKzC4RkUDu8YznvEEtQAQiMGCZHfqXLuCkFAt9P
         kT4QFTSO7yO7nTIFZlNZxI1WYVkDZ6ACkv8pxezaFuBMvVvHcTudj45s8oapnTAIdVR7
         dADg==
X-Gm-Message-State: AC+VfDxEA3LVFbV8sgznCZ6OM2+CKYKJsuVNGnXHoipla9ZzoqOaIk/t
        EciuALthpeArPXfTTZegGgnb9Kq64z5hYaQSfiUhVw==
X-Google-Smtp-Source: ACHHUZ7VSWNEPBv6EO/KQhU17J+bBSs3DTF1ZjREFJjlroYQvM0LGCDq5w6tGC66l2NxGKuHVUaC3aBPWro3od4ACDk=
X-Received: by 2002:ac8:5fd6:0:b0:3ef:3083:a437 with SMTP id
 k22-20020ac85fd6000000b003ef3083a437mr130383qta.18.1687854598290; Tue, 27 Jun
 2023 01:29:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230626171430.3167004-1-ryan.roberts@arm.com>
 <20230626171430.3167004-2-ryan.roberts@arm.com> <CAOUHufacvArJh7NjL_3LT-e3s1X+bazkvbgvEU+KPKGKEoW+dw@mail.gmail.com>
 <2ff8ccf6-bf36-48b2-7dc2-e6c0d962f8b7@arm.com>
In-Reply-To: <2ff8ccf6-bf36-48b2-7dc2-e6c0d962f8b7@arm.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Tue, 27 Jun 2023 02:29:22 -0600
Message-ID: <CAOUHufZoT-maN3kY5eYQmrYV48shmKAAancEvabXzfTDncDa9A@mail.gmail.com>
Subject: Re: [PATCH v1 01/10] mm: Expose clear_huge_page() unconditionally
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

On Tue, Jun 27, 2023 at 1:21=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 27/06/2023 02:55, Yu Zhao wrote:
> > On Mon, Jun 26, 2023 at 11:14=E2=80=AFAM Ryan Roberts <ryan.roberts@arm=
.com> wrote:
> >>
> >> In preparation for extending vma_alloc_zeroed_movable_folio() to
> >> allocate a arbitrary order folio, expose clear_huge_page()
> >> unconditionally, so that it can be used to zero the allocated folio in
> >> the generic implementation of vma_alloc_zeroed_movable_folio().
> >>
> >> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> >> ---
> >>  include/linux/mm.h | 3 ++-
> >>  mm/memory.c        | 2 +-
> >>  2 files changed, 3 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/include/linux/mm.h b/include/linux/mm.h
> >> index 7f1741bd870a..7e3bf45e6491 100644
> >> --- a/include/linux/mm.h
> >> +++ b/include/linux/mm.h
> >> @@ -3684,10 +3684,11 @@ enum mf_action_page_type {
> >>   */
> >>  extern const struct attribute_group memory_failure_attr_group;
> >>
> >> -#if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_HUGETLBFS)
> >>  extern void clear_huge_page(struct page *page,
> >>                             unsigned long addr_hint,
> >>                             unsigned int pages_per_huge_page);
> >> +
> >> +#if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_HUGETLBFS)
> >
> > We might not want to depend on THP eventually. Right now, we still
> > have to, unless splitting is optional, which seems to contradict
> > 06/10. (deferred_split_folio()  is a nop without THP.)
>
> Yes, I agree - for large anon folios to work, we depend on THP. But I don=
't
> think that helps us here.
>
> In the next patch, I give vma_alloc_zeroed_movable_folio() an extra `orde=
r`
> parameter. So the generic/default version of the function now needs a way=
 to
> clear a compound page.
>
> I guess I could do something like:
>
>  static inline
>  struct folio *vma_alloc_zeroed_movable_folio(struct vm_area_struct *vma,
>                                    unsigned long vaddr, gfp_t gfp, int or=
der)
>  {
>         struct folio *folio;
>
>         folio =3D vma_alloc_folio(GFP_HIGHUSER_MOVABLE | gfp,
>                                         order, vma, vaddr, false);
>         if (folio) {
> #ifdef CONFIG_LARGE_FOLIO
>                 clear_huge_page(&folio->page, vaddr, 1U << order);
> #else
>                 BUG_ON(order !=3D 0);
>                 clear_user_highpage(&folio->page, vaddr);
> #endif
>         }
>
>         return folio;
>  }
>
> But that's pretty messy and there's no reason why other users might come =
along
> that pass order !=3D 0 and will be surprised by the BUG_ON.

#ifdef CONFIG_LARGE_ANON_FOLIO // depends on CONFIG_TRANSPARENT_HUGE_PAGE
struct folio *alloc_anon_folio(struct vm_area_struct *vma, unsigned
long vaddr, int order)
{
  // how do_huge_pmd_anonymous_page() allocs and clears
  vma_alloc_folio(..., *true*);
}
#else
#define alloc_anon_folio(vma, addr, order)
vma_alloc_zeroed_movable_folio(vma, addr)
#endif
