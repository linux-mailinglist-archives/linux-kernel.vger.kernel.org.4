Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3F174E64C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 07:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjGKFVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 01:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGKFV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 01:21:29 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9FE93
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 22:21:28 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5701eaf0d04so61607727b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 22:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689052888; x=1691644888;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4d48r8GTZbdJlOqJGQ4Vo1gCwNbXVoPPV42zrJqRnTU=;
        b=gyY0bp7wWQIfa1W/Ys3ut4yBlFS1qg1RqPy6sd0fbLNdzot/mcNhKJq0rBlM8x1Z6U
         BW3ColUcX/9/si0qaQEOoylXkoNjV9jKuYp29KqlfBSjM9nNwdUNOqNsxTcKhJ/Ddw9g
         B91uYg+rYLx58sf4via0Zt5UDG+8engIXOF3jU3Y4T4/Y4GoHNo/vWddhW+qMiwIAUA+
         PvZaoTQ29hWS2EPEUVsx/sBlZJgi6dXbq8ffMbtH5iIJBJy3bqbBkQ6gw118+wue+/0A
         Bvc4aHLaM7/WLdw6IHSbMZe7hjpzHq2Coa/5Vt49jfyH7OjN4CtzItCIs7woN2huQuIy
         SjGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689052888; x=1691644888;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4d48r8GTZbdJlOqJGQ4Vo1gCwNbXVoPPV42zrJqRnTU=;
        b=eVc2ZQZG1mK4jKGDdLvED7rLk6t65KaTg0DVtHyflus6LQp27RnDgu9KKhfkhsxsBG
         xsGS0a4aeHXDbHancJl+KJfZeyAgnuTc1iAP7Gvb22F54a5SNXF65ybWbbjrNXqYbZYZ
         Vso7WiZN9fr2mi8ryrEHdFD0Whl+SPQyUyadU/RfBvEHN56WAHRgtLMxalotMYRTIEc7
         g5ThUYM7t7uHWnQi/xQDEnMnUQZ19cGQ430XGKJN/FwvTd6QGsSK3OLWsypqzb7grJ5R
         tn0+PV5BudxTdRh7L7fVD9Vahni3KARWZc9IYu/Xz0nbAw2oBYfJD5no9uo/XbWPKhC/
         twOA==
X-Gm-Message-State: ABy/qLaESOXUlnRaZtejpeES4BngWL2y/JKlKCS7y14OR2dwzphr2AOg
        nngcLM8wfc0MjDubNB/2qWnx/w==
X-Google-Smtp-Source: APBJJlGQl0+fPagJ1ipgPbbTNzE6x+C+5FDcl+1yj4mfnsvxhoBI6O7h7iStTH97nC2bRK2Rk441dg==
X-Received: by 2002:a0d:db0f:0:b0:568:f406:cd6a with SMTP id d15-20020a0ddb0f000000b00568f406cd6amr13401170ywe.46.1689052887592;
        Mon, 10 Jul 2023 22:21:27 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id x125-20020a0dd583000000b00579df9098e3sm388116ywd.38.2023.07.10.22.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 22:21:27 -0700 (PDT)
Date:   Mon, 10 Jul 2023 22:21:16 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Zi Yan <ziy@nvidia.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Yang Shi <shy828301@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Price <steven.price@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
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
        Ryan Roberts <ryan.roberts@arm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 05/32] mm/filemap: allow pte_offset_map_lock() to
 fail
In-Reply-To: <68C1B34D-B8B7-4151-B780-5A05812F402C@nvidia.com>
Message-ID: <7df13a2d-1c95-c753-da64-4a47e8872fd9@google.com>
References: <c1c9a74a-bc5b-15ea-e5d2-8ec34bc921d@google.com> <54607cf4-ddb6-7ef3-043-1d2de1a9a71@google.com> <68C1B34D-B8B7-4151-B780-5A05812F402C@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jul 2023, Zi Yan wrote:
> On 8 Jun 2023, at 21:11, Hugh Dickins wrote:
> 
> > filemap_map_pages() allow pte_offset_map_lock() to fail; and remove the
> > pmd_devmap_trans_unstable() check from filemap_map_pmd(), which can safely
> > return to filemap_map_pages() and let pte_offset_map_lock() discover that.
> >
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> > ---
> >  mm/filemap.c | 12 +++++-------
> >  1 file changed, 5 insertions(+), 7 deletions(-)
> >
> > diff --git a/mm/filemap.c b/mm/filemap.c
> > index 28b42ee848a4..9e129ad43e0d 100644
> > --- a/mm/filemap.c
> > +++ b/mm/filemap.c
> > @@ -3408,13 +3408,6 @@ static bool filemap_map_pmd(struct vm_fault *vmf, struct folio *folio,
> >  	if (pmd_none(*vmf->pmd))
> >  		pmd_install(mm, vmf->pmd, &vmf->prealloc_pte);
> >
> > -	/* See comment in handle_pte_fault() */
> > -	if (pmd_devmap_trans_unstable(vmf->pmd)) {
> > -		folio_unlock(folio);
> > -		folio_put(folio);
> > -		return true;
> > -	}
> > -
> 
> There is a pmd_trans_huge() check at the beginning, should it be removed
> as well? Since pte_offset_map_lock() is also able to detect it.

It probably could be removed: but mostly I avoided such cleanups,
in the hope that the patches could be more easily reviewed as safe.
But I was eager to delete that obscure pmd_devmap_trans_unstable().

The whole strategy of dealing with the pmd_trans_huge()-like cases first,
and only finally arriving at the pte_offset_map_lock() when other cases
have been excluded, could be reversed in *many* places.  It had to be that
way before, because pte_offset_map_lock() could only cope with a page
table; but now we could reverse them to do the pte_offset_map_lock()
first, and only try the other cases when it fails.

That would in theory be more efficient; but whether measurably more
efficient I doubt.  And very easy to introduce errors on the way:
my enthusiasm for such cleanups is low!  But maybe there's a few
places where the rearrangement would be worthwhile.

> 
> >  	return false;
> >  }
> >
> > @@ -3501,6 +3494,11 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
> >
> >  	addr = vma->vm_start + ((start_pgoff - vma->vm_pgoff) << PAGE_SHIFT);
> >  	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, addr, &vmf->ptl);
> > +	if (!vmf->pte) {
> > +		folio_unlock(folio);
> > +		folio_put(folio);
> > +		goto out;
> > +	}
> >  	do {
> >  again:
> >  		page = folio_file_page(folio, xas.xa_index);
> > -- 
> > 2.35.3
> 
> These two changes affect the ret value. Before, pmd_devmap_trans_unstable() == true
> made ret = VM_FAULT_NPAGE, but now ret is the default 0 value. So ret should be set
> to VM_FAULT_NPAGE before goto out in the second hunk?

Qi Zheng raised a similar question on the original posting, I answered
https://lore.kernel.org/linux-mm/fb9a9d57-dbd7-6a6e-d1cb-8dcd64c829a6@google.com/

It's a rare case to fault here, then find pmd_devmap(*pmd), and it really
doesn't matter whether we return VM_FAULT_NOPAGE or 0 for it - maybe I've
left it inconsistent between THP and devmap, but it doesn't really matter.

I haven't checked Matthew's v5 "new page table range API" posted today,
but I expect this all looks different here anyway.

Thanks a lot for checking these: they are now in 6.5-rc1, so if you find
something that needs fixing, all the more important that we do fix it.

Hugh
