Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32DA6630843
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 02:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbiKSBQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 20:16:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiKSBQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 20:16:11 -0500
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8898620BE6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 16:13:39 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id p4so6265348vsa.11
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 16:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JdmpmzFhPorrlLui7TzB6H1/XRLaC1WwAIIUyyVa8yA=;
        b=cenM/AUehb33kVe/wriotJSNfoT0pUpiqq5JYeBo/QoKxqRT9/7jfQy4dU+5d0rhao
         GRpOjb7oudyp5YxrmNODpPLJv0GW7Y/50vGRlMp65Lwr/4tK6h9HY/mQXeiYz04T8w6w
         6LEIh/TvtYykowDbbraSxPq81pSP9oxMcMgqaVGNmrGEvlMtWaLT+V/nFto5hLkp14N+
         YBxr5HK6VwFM/E1Fb2KGoWBD0kIdEsVZfT1oRXWTHSfWapUOX2zXHcIEQZBSzZ74Cw7s
         w69hUA093t+SdJ/1O1lnzVbasdc0v9gniPiWkhKLTG2WgdhokXCB3HxHljaMos5Wog5P
         Fj0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JdmpmzFhPorrlLui7TzB6H1/XRLaC1WwAIIUyyVa8yA=;
        b=R54xHfqjQKVmbS+rtZNlVD8JyFr3G5Yo+Xz8FGeuxReexGiiVx1p2pMFKJUU+lLGab
         kkDXuKxKO9fSctoRduoYoxj7VY0B/uz8RyJJrQbnIg9ki4d/dUtNMo815/8lN3Wmk8/p
         0wKSn5jPuNtsKnMU4x36Tt2V6RWOGlLsUqmLA96zIGFsVAbseC5FKtaVJdjIxXnpAV8a
         wfHsoYrygtzNks15U8BgDngdTIVwAyomAmzd0itV9fY3FxIGA/yf2UiGSYmQ1cLcnt3T
         9gpl65N8+GECOC8fLUP+imjtq2x/kaPlsIa3PZXQQXI0/gYmKI3JBvx2bRrSyvLk44MV
         5C4w==
X-Gm-Message-State: ANoB5pk6JYf6veCUP6fyEE17b8OVaM77EDXSsBuWXqPis6AEmfkgzMgA
        H5Vbc29j4kzLXwbr8rhhKEWQn3Pxd3oKu4Rj9II9HQ==
X-Google-Smtp-Source: AA0mqf4ucx80ljcZJYuBW4hshwBqDPXbTimQMrLOxY/XuGAYAN+112jE9PPXrLCq6Sf4jJgrDiNgMTRfRiZHNPTCNKw=
X-Received: by 2002:a67:f8d4:0:b0:3aa:1a3a:6447 with SMTP id
 c20-20020a67f8d4000000b003aa1a3a6447mr5755961vsp.50.1668816810456; Fri, 18
 Nov 2022 16:13:30 -0800 (PST)
MIME-Version: 1.0
References: <5f52de70-975-e94f-f141-543765736181@google.com>
 <c4b8485b-1f26-1a5f-bdf-c6c22611f610@google.com> <78fa518-85b5-32c0-ee92-537fa46131f6@google.com>
In-Reply-To: <78fa518-85b5-32c0-ee92-537fa46131f6@google.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Fri, 18 Nov 2022 17:12:54 -0700
Message-ID: <CAOUHufYf9Ns6vPpDeSOnUBaQm3Th+N6WbLiT7F=191LNpsatNQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm,thp,rmap: subpages_mapcount of PTE-mapped subpages
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, Peter Xu <peterx@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Mina Almasry <almasrymina@google.com>,
        James Houghton <jthoughton@google.com>,
        "Zach O'Keefe" <zokeefe@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 2:12 AM Hugh Dickins <hughd@google.com> wrote:

...

> @@ -1308,31 +1285,29 @@ void page_add_anon_rmap(struct page *page,
>
>         if (unlikely(PageKsm(page)))
>                 lock_page_memcg(page);
> -       else
> -               VM_BUG_ON_PAGE(!PageLocked(page), page);
>
> -       if (likely(!PageCompound(page))) {
> +       if (likely(!compound /* page is mapped by PTE */)) {
>                 first = atomic_inc_and_test(&page->_mapcount);
>                 nr = first;
> +               if (first && PageCompound(page)) {
> +                       struct page *head = compound_head(page);
> +
> +                       lock_compound_mapcounts(head, &mapcounts);
> +                       mapcounts.subpages_mapcount++;
> +                       nr = !mapcounts.compound_mapcount;
> +                       unlock_compound_mapcounts(head, &mapcounts);
> +               }
> +       } else if (PageTransHuge(page)) {
> +               /* That test is redundant: it's for safety or to optimize out */
>
> -       } else if (compound && PageTransHuge(page)) {
>                 lock_compound_mapcounts(page, &mapcounts);
>                 first = !mapcounts.compound_mapcount;
>                 mapcounts.compound_mapcount++;
>                 if (first) {
> -                       nr = nr_pmdmapped = thp_nr_pages(page);
> -                       if (mapcounts.subpages_mapcount)
> -                               nr = nr_subpages_unmapped(page, nr_pmdmapped);
> +                       nr_pmdmapped = thp_nr_pages(page);
> +                       nr = nr_pmdmapped - mapcounts.subpages_mapcount;
>                 }
>                 unlock_compound_mapcounts(page, &mapcounts);
> -       } else {
> -               struct page *head = compound_head(page);
> -
> -               lock_compound_mapcounts(head, &mapcounts);
> -               mapcounts.subpages_mapcount++;
> -               first = subpage_mapcount_inc(page);
> -               nr = first && !mapcounts.compound_mapcount;
> -               unlock_compound_mapcounts(head, &mapcounts);
>         }
>
>         VM_BUG_ON_PAGE(!first && (flags & RMAP_EXCLUSIVE), page);

Hi Hugh, I got the following warning from the removed "else" branch.
Is it legit? Thanks.

mm/rmap.c:1236:13: warning: variable 'first' is used uninitialized
whenever 'if' condition is false [-Wsometimes-uninitialized]
        } else if (PageTransHuge(page)) {
                   ^~~~~~~~~~~~~~~~~~~
mm/rmap.c:1248:18: note: uninitialized use occurs here
        VM_BUG_ON_PAGE(!first && (flags & RMAP_EXCLUSIVE), page);
                        ^~~~~
