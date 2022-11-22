Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B718663388F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 10:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbiKVJdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 04:33:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbiKVJdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 04:33:33 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5404C644C
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 01:33:32 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id c15so8901670qtw.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 01:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=m0GDJhfeb/mlDuXgY9TptD7saYe6PZinj6F8K2HKaeU=;
        b=Yh5afxIF4nlJ5tGvdSmhfMKs2zILGlBSVIL6Dq8svTLaZHbiVmfrTeSTd8e+VFVvst
         3erxOjcuLZe1zhu4vW5V2FMYdoqnAyzGkmSS116EBggRl4QM2sJmFknFJXbXyQe/QgUI
         jartFLar8+ghwZmgy2UPOsDpCVGvHLnrwgpr8lTj2kDN/LztPZP9s4j5rs6eA62W3XCS
         XomsQLw4VX5GCBbdWgFTc2M88EcFeyEBemXHdHoGfHWJmV3whtY014IHkiRYExZSASq6
         RSCpprBqiuPj8HU71hKDjHKiFHtYJZuydkXMf1qj4o//thj4EMkxAiA4/tBWhPv01ekX
         Unuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m0GDJhfeb/mlDuXgY9TptD7saYe6PZinj6F8K2HKaeU=;
        b=mgW0ApnpZiz+MUR+IUAoTKJYvkDaNwlzqrt1VYcAHB35ABbvgPFX2s0sA8Rq76dYAd
         7vhPw+gHatJX7ZI8SRdvtxxSeITbsx+2vm77xK/+A0g3ELYwJApSgec4igvvOGoKaCYl
         XHBiNZ02V/AbtGvIjMslvTW2zFG4LdBelajiSyfgFFFzxm64HOhDpKDC2+JLD7o/FK1s
         YCYSfdnuUJXnkl9WF3iy4pWXxEjoomSvbQ3m5TcJXEdUsDAedIM+GEU/2Jq0ic578w8m
         yyMHeTKyStTc2EympKMyLOFlNFQCFQhuDHEuHLiywafsQ+7Dvsyv6avzVgcvHqDeBmQq
         LE0g==
X-Gm-Message-State: ANoB5plEJtepIf/Kk4vnmRYVQlpgBJlX4oFSEXcdbm+Ukyv87rQNvHZW
        OZQAKZb0TftpqbWt4qshCmT4xkIBoFtM5A==
X-Google-Smtp-Source: AA0mqf54sB+Y5VKy2px/uKlEV8Zla8rGrgID1JcbJZtAIcoGIvncgsDgYkhDbtN2sgc7G9bAfT7YEw==
X-Received: by 2002:a05:622a:4d94:b0:3a5:fb6c:d96a with SMTP id ff20-20020a05622a4d9400b003a5fb6cd96amr21306888qtb.185.1669109611343;
        Tue, 22 Nov 2022 01:33:31 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id t20-20020a05620a451400b006ceb933a9fesm10089200qkp.81.2022.11.22.01.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 01:33:30 -0800 (PST)
Date:   Tue, 22 Nov 2022 01:33:27 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
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
        Zach O'Keefe <zokeefe@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2/3] mm,thp,rmap: subpages_mapcount COMPOUND_MAPPED if
 PMD-mapped
In-Reply-To: <20221121130900.xb224cesbzfptldo@box.shutemov.name>
Message-ID: <cdf37e1a-598f-4ec0-3f3f-13acd9acc994@google.com>
References: <5f52de70-975-e94f-f141-543765736181@google.com> <c4b8485b-1f26-1a5f-bdf-c6c22611f610@google.com> <25a09a7a-81a9-e9c2-7567-c94ce18ac2@google.com> <20221121130900.xb224cesbzfptldo@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Mon, 21 Nov 2022, Kirill A. Shutemov wrote:
> On Fri, Nov 18, 2022 at 01:14:17AM -0800, Hugh Dickins wrote:
> > Can the lock_compound_mapcount() bit_spin_lock apparatus be removed now?
> > Yes.  Not by atomic64_t or cmpxchg games, those get difficult on 32-bit;
> > but if we slightly abuse subpages_mapcount by additionally demanding that
> > one bit be set there when the compound page is PMD-mapped, then a cascade
> > of two atomic ops is able to maintain the stats without bit_spin_lock.
> 
> Yay! New home for PageDoubleMap()! :P

:) You only asked for one bit for PageDoubleMap, I've been greedier;
so it's not surprising if it has worked out better now.

...

> Jokes aside, looks neat.
> 
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Thanks; but I'm very glad that Linus expressed his dissatisfaction
with the first implementation, this one does feel much better.

> 
> As always few minor nits below.
...
> > @@ -893,8 +902,12 @@ static inline int total_mapcount(struct page *page)
> >  
> >  static inline bool folio_large_is_mapped(struct folio *folio)
> >  {
> > -	return atomic_read(folio_mapcount_ptr(folio)) +
> > -		atomic_read(folio_subpages_mapcount_ptr(folio)) >= 0;
> > +	/*
> > +	 * Reading folio_mapcount_ptr() below could be omitted if hugetlb
> > +	 * participated in incrementing subpages_mapcount when compound mapped.
> > +	 */
> > +	return atomic_read(folio_mapcount_ptr(folio)) >= 0 ||
> > +		atomic_read(folio_subpages_mapcount_ptr(folio)) > 0;
> 
> Maybe check folio_subpages_mapcount_ptr() first? It would avoid
> folio_mapcount_ptr() read for everything, but hugetlb.

Okay: I'm not convinced, but don't mind switching those around: done.

> > --- a/mm/debug.c
> > +++ b/mm/debug.c
> > @@ -97,7 +97,7 @@ static void __dump_page(struct page *page)
> >  		pr_warn("head:%p order:%u compound_mapcount:%d subpages_mapcount:%d compound_pincount:%d\n",
> >  				head, compound_order(head),
> >  				head_compound_mapcount(head),
> > -				head_subpages_mapcount(head),
> > +				head_subpages_mapcount(head) & SUBPAGES_MAPPED,
> 
> Looks like applying the SUBPAGES_MAPPED mask belong to the
> head_subpages_mapcount() helper, not to the caller.

Yes, that would be more consistent, helper function doing the massage.
Done.  __dump_page() then remains unchanged, but free_tail_pages_check()
uses subpages_mapcount_ptr(head_page) to check the whole field is zero.

v2 coming up - thanks.

Hugh
