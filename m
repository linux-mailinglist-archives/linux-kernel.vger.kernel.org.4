Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7566370ECA0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 06:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236017AbjEXEo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 00:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233155AbjEXEox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 00:44:53 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775E512B
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 21:44:52 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-ba878d5e75fso1078532276.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 21:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684903491; x=1687495491;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f39bjKJNzB9G9TX7qCTMm8x8VJ3ouN/VRnt5yvT027M=;
        b=JamDd4JmP2zhvbpzAN8ngliSnhtsVTDQSCSV7Hhb56MoCA7ZC/5kjp3iAYY3jTd7EP
         xZRm4swmN1onU5EY8cggSHzBhSy7GQyAgwZwiXXJR6YA7vJJ08DA9W1T33cDol1onPqA
         D2Rd5ZOGonVvRlkM/o3I8rfuT9x4XQ5YVxYLcRKOHJ8JBzXyznhKpZ7Kn98JIFVUnGyJ
         3SE2IMGhoxRZoZu0BNgNaKt1m/z8GHzXkn72+Wg/4Dy+31KCh//EwJ45MOvMh9rvXuVf
         lBqYdWuzPXQ9IJrpXeedl6J1SaUmF9r5BmI1rYL2p5IAzBxLpcuYx8okDzMNFhvyLq75
         D31A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684903491; x=1687495491;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f39bjKJNzB9G9TX7qCTMm8x8VJ3ouN/VRnt5yvT027M=;
        b=h8VV/3sA3sUlD3A4/6KhhtJnkyfmo1JzRgLMUmrYrFRzwuoKTIUlLQoth5GHX2NG+3
         BpD1BCHuwVX0dh045TfnE8tZZwFCfbKjt/I4fnMTUtJxX2EQ1VTLV6uwbX+IFf0A/ykE
         whh1V6c1utWLpESdRoQ/+lKBuzA4rQUC5lb0wEKi4KJ6HPXkhBsrbDyWVlhIpmYSiT43
         IxTl5dBgWrC97938apWi4Jp/8EhLZy0h9PrBvTzXz6LS8DqVLKfXDeNIDdPhy1w6WPJc
         qIKVY5w7AXbj77krhyxinq8vuwg34SRRc2ajZYxkHl6eaTEhLjciTAyiDQ4A/W2LmRzJ
         0oaA==
X-Gm-Message-State: AC+VfDwoqTggpcqH0kti5u0/UTPBCHF5bIP7qTJ6pwTxW+a6IwMHjxJA
        qtAkiZUmy+SWr71x+Fa3XOkR6w==
X-Google-Smtp-Source: ACHHUZ6Udji73O98VKhs/8RJOjJyNFJJ9VQVeCUmuu3F+F1oM4lZMvgR8dLHY6gzcqHMiz7EhGVRKA==
X-Received: by 2002:a25:acd4:0:b0:ba8:7158:f0ac with SMTP id x20-20020a25acd4000000b00ba87158f0acmr18104751ybd.57.1684903491047;
        Tue, 23 May 2023 21:44:51 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id d143-20020a25e695000000b00ba68a6e547esm2539120ybh.48.2023.05.23.21.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 21:44:50 -0700 (PDT)
Date:   Tue, 23 May 2023 21:44:47 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Yang Shi <shy828301@gmail.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Price <steven.price@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zack Rusin <zackr@vmware.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Song Liu <song@kernel.org>,
        Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 27/31] mm/khugepaged: allow pte_offset_map[_lock]() to
 fail
In-Reply-To: <CAHbLzkrf-Ft6geL0XKwGCY+Btn3cW=FMRjujQ48VJEnCfVki9g@mail.gmail.com>
Message-ID: <68dddbbb-bc3c-367d-798a-cbe2a69664@google.com>
References: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com> <aef43be2-f877-b0f8-b41c-37f847d3a7b4@google.com> <CAHbLzkrf-Ft6geL0XKwGCY+Btn3cW=FMRjujQ48VJEnCfVki9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463760895-655262871-1684903490=:7491"
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463760895-655262871-1684903490=:7491
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 22 May 2023, Yang Shi wrote:
> On Sun, May 21, 2023 at 10:24=E2=80=AFPM Hugh Dickins <hughd@google.com> =
wrote:
> >
> > __collapse_huge_page_swapin(): don't drop the map after every pte, it
> > only has to be dropped by do_swap_page(); give up if pte_offset_map()
> > fails; trace_mm_collapse_huge_page_swapin() at the end, with result;
> > fix comment on returned result; fix vmf.pgoff, though it's not used.
> >
> > collapse_huge_page(): use pte_offset_map_lock() on the _pmd returned
> > from clearing; allow failure, but it should be impossible there.
> > hpage_collapse_scan_pmd() and collapse_pte_mapped_thp() allow for
> > pte_offset_map_lock() failure.
> >
> > Signed-off-by: Hugh Dickins <hughd@google.com>
>=20
> Reviewed-by: Yang Shi <shy828301@gmail.com>

Thanks.

>=20
> A nit below:
>=20
> > ---
> >  mm/khugepaged.c | 72 +++++++++++++++++++++++++++++++++----------------
> >  1 file changed, 49 insertions(+), 23 deletions(-)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 732f9ac393fc..49cfa7cdfe93 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
=2E..
> > @@ -1029,24 +1040,29 @@ static int __collapse_huge_page_swapin(struct m=
m_struct *mm,
> >                  * resulting in later failure.
> >                  */
> >                 if (ret & VM_FAULT_RETRY) {
> > -                       trace_mm_collapse_huge_page_swapin(mm, swapped_=
in, referenced, 0);
> >                         /* Likely, but not guaranteed, that page lock f=
ailed */
> > -                       return SCAN_PAGE_LOCK;
> > +                       result =3D SCAN_PAGE_LOCK;
>=20
> With per-VMA lock, this may not be true anymore, at least not true
> until per-VMA lock supports swap fault. It may be better to have a
> more general failure code, for example, SCAN_FAIL. But anyway you
> don't have to change it in your patch, I can send a follow-up patch
> once this series is landed on mm-unstable.

Interesting point (I've not tried to wrap my head around what differences
per-VMA locking would make to old likelihoods here), and thank you for
deferring a change on it - appreciated.

Something to beware of, if you do choose to change it: mostly those
SCAN codes (I'm not a fan of them!) are only for a tracepoint somewhere,
but madvise_collapse() and madvise_collapse_errno() take some of them
more seriously than others - I think SCAN_PAGE_LOCK ends up as an
EAGAIN (rightly), but SCAN_FAIL as an EINVAL (depends).

But maybe there are layers in between which do not propagate the result
code, I didn't check.  All in all, not something I'd spend time on myself.

Hugh
---1463760895-655262871-1684903490=:7491--
