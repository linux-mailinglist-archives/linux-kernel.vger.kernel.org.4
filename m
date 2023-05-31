Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC1E7172B0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 02:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233399AbjEaAkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 20:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbjEaAkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 20:40:40 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8134CE40
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 17:40:05 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-565de553de1so6382677b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 17:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685493519; x=1688085519;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ciIag9ppNam6Ikfax7r++Kew/N1dQoncU50To4G8bq4=;
        b=s4psAFfQL/Xvpx6CG11TvqCPK3dBE+CtAbPvc1LP/Vp6cCIPwmqOUxi+gGLKdymwVr
         KBXGfyRCyEb33I+9q2LBQlgDePc3a05l6O33H7YqyysB9hf1XyENU9qWBuoJKw9EUYlM
         pEmFeg9cJw7sTQQkmXYP686QUBSsQmfaa7kHqU5iVgb8czbTZTSlhAs0FZ/Obh5PJtKM
         KqgNPZ3zv/vf4lueLkpjpWZJ2r9PyPbJ09lE/jw8yqBmW8+Z8g93HIyjbo+Kh8JZVRr3
         WEinxSHBsLsBK74sDXvaF9Wg6I0DN+6VHv7QBBKIYxpiJFFSywoCIJ9FPC0ocitPQl4O
         hpNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685493519; x=1688085519;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ciIag9ppNam6Ikfax7r++Kew/N1dQoncU50To4G8bq4=;
        b=bLVUBekdpXxKywEC/hMEWAgF6o7D70Z3QqgvuoWHa/C3DP/Jo6tOvD9khtHMYGbFty
         Mk48wIDvkTrI1cqk/X+s0/Wf8SlJS5L9Q9gFf47WOezhAV84wK897oOZJ8rnypVNNe1C
         6eJYEpaoEvZVFBU1C4gjiVsy3zcoEn+fCQ8pmnKbTV8xi66YBd1xsVwCvbOJfyFYayNC
         T5JaBw+4fBhwucAkiSBUfMoWG/JYBDCUb3h7rchd31jju50UPjnLqNM7PgY+JJuN6puc
         HALGTR4RFDKGRTZZBKQIElvupgxdqveWBEz5apeobh8utC18bHVZgZdpCmlDFFZGQKg9
         aLHw==
X-Gm-Message-State: AC+VfDzEWL1W1qaHIdsZjbPWoMXjoSXSrdA1TxNRKmVX7YJR6l0smhvZ
        1eCOjutUIZoAYd2Omie46ZDD7g==
X-Google-Smtp-Source: ACHHUZ6oAzWH6paUG3LosxgrJ++supK0+JI2vStYiabgmf/uhHM/SefufdWqFEJ0cjjU81mHFbbIJA==
X-Received: by 2002:a0d:f905:0:b0:568:e69a:1178 with SMTP id j5-20020a0df905000000b00568e69a1178mr1764241ywf.5.1685493519139;
        Tue, 30 May 2023 17:38:39 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id a7-20020a818a07000000b00555c30ec361sm4859512ywg.143.2023.05.30.17.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 17:38:35 -0700 (PDT)
Date:   Tue, 30 May 2023 17:38:25 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Peter Xu <peterx@redhat.com>
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
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jann Horn <jannh@google.com>,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 09/12] mm/khugepaged: retract_page_tables() without mmap
 or vma lock
In-Reply-To: <ZHU0m+QIChZNdOdg@x1n>
Message-ID: <48c679e9-8eed-568a-1de1-c57e315c693c@google.com>
References: <35e983f5-7ed3-b310-d949-9ae8b130cdab@google.com> <2e9996fa-d238-e7c-1194-834a2bd1f60@google.com> <ZHU0m+QIChZNdOdg@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

Thanks for looking, Peter: I was well aware of you dropping several hints
that you wanted to see what's intended before passing judgment on earlier
series, and I preferred to get on with showing this series, than go into
detail in responses to you there - thanks for your patience :)

On Mon, 29 May 2023, Peter Xu wrote:
> On Sun, May 28, 2023 at 11:25:15PM -0700, Hugh Dickins wrote:
...
> > @@ -1748,123 +1747,73 @@ static void khugepaged_collapse_pte_mapped_thps(struct khugepaged_mm_slot *mm_sl
> >  	mmap_write_unlock(mm);
> >  }
> >  
> > -static int retract_page_tables(struct address_space *mapping, pgoff_t pgoff,
> > -			       struct mm_struct *target_mm,
> > -			       unsigned long target_addr, struct page *hpage,
> > -			       struct collapse_control *cc)
> > +static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
> >  {
> >  	struct vm_area_struct *vma;
> > -	int target_result = SCAN_FAIL;
> >  
> > -	i_mmap_lock_write(mapping);
> > +	i_mmap_lock_read(mapping);
> >  	vma_interval_tree_foreach(vma, &mapping->i_mmap, pgoff, pgoff) {
> > -		int result = SCAN_FAIL;
> > -		struct mm_struct *mm = NULL;
> > -		unsigned long addr = 0;
> > -		pmd_t *pmd;
> > -		bool is_target = false;
> > +		struct mm_struct *mm;
> > +		unsigned long addr;
> > +		pmd_t *pmd, pgt_pmd;
> > +		spinlock_t *pml;
> > +		spinlock_t *ptl;
> >  
> >  		/*
> >  		 * Check vma->anon_vma to exclude MAP_PRIVATE mappings that
> > -		 * got written to. These VMAs are likely not worth investing
> > -		 * mmap_write_lock(mm) as PMD-mapping is likely to be split
> > -		 * later.
> > +		 * got written to. These VMAs are likely not worth removing
> > +		 * page tables from, as PMD-mapping is likely to be split later.
> >  		 *
> > -		 * Note that vma->anon_vma check is racy: it can be set up after
> > -		 * the check but before we took mmap_lock by the fault path.
> > -		 * But page lock would prevent establishing any new ptes of the
> > -		 * page, so we are safe.
> > -		 *
> > -		 * An alternative would be drop the check, but check that page
> > -		 * table is clear before calling pmdp_collapse_flush() under
> > -		 * ptl. It has higher chance to recover THP for the VMA, but
> > -		 * has higher cost too. It would also probably require locking
> > -		 * the anon_vma.
> > +		 * Note that vma->anon_vma check is racy: it can be set after
> > +		 * the check, but page locks (with XA_RETRY_ENTRYs in holes)
> > +		 * prevented establishing new ptes of the page. So we are safe
> > +		 * to remove page table below, without even checking it's empty.
> >  		 */
> > -		if (READ_ONCE(vma->anon_vma)) {
> > -			result = SCAN_PAGE_ANON;
> > -			goto next;
> > -		}
> > +		if (READ_ONCE(vma->anon_vma))
> > +			continue;
> 
> Not directly related to current patch, but I just realized there seems to
> have similar issue as what ab0c3f1251b4 wanted to fix.
> 
> IIUC any shmem vma that used to have uprobe/bp installed will have anon_vma
> set here, then does it mean that any vma used to get debugged will never be
> able to merge into a thp (with either madvise or khugepaged)?
> 
> I think it'll only make a difference when the page cache is not huge yet
> when bp was uninstalled, but then it becomes a thp candidate somehow.  Even
> if so, I think the anon_vma should still be there.
> 
> Did I miss something, or maybe that's not even a problem?

Finding vma->anon_vma set would discourage retract_page_tables() from
doing its business with that previously uprobed area; but it does not stop
collapse_pte_mapped_thp() (which uprobes unregister calls directly) from
dealing with it, and MADV_COLLAPSE works on anon_vma'ed areas too.  It's
just a heuristic in retract_page_tables(), when it chooses to skip the
anon_vma'ed areas as often not worth bothering with.

As to vma merges: I haven't actually checked since the maple tree and other
rewrites of vma merging, but previously one vma with anon_vma set could be
merged with adjacent vma before or after without anon_vma set - the
anon_vma comparison is not just equality of anon_vma, but allows NULL too -
so the anon_vma will still be there, but extends to cover the wider extent.
Right, I find is_mergeable_anon_vma() still following that rule.

(And once vmas are merged, so that the whole of the huge page falls within
a single vma, khugepaged can consider it, and do collapse_pte_mapped_thp()
on it - before or after 11/12 I think.)

As to whether it would even be a problem: generally no, the vma is supposed
just to be an internal representation, and so long as the code resists
proliferating them unnecessarily, occasional failures to merge should not
matter.  The one place that forever sticks in my mind as mattering (perhaps
there are others I'm unaware of, but I'd call them bugs) is mremap(): which
is sufficiently awkward and bug-prone already, that nobody ever had the
courage to make it independent of vma boundaries; but ideally, it's
mremap() that we should fix.

But I may have written three answers, yet still missed your point.

...
> > +
> > +		mm = vma->vm_mm;
> > +		if (find_pmd_or_thp_or_none(mm, addr, &pmd) != SCAN_SUCCEED)
> > +			continue;
> > +
> > +		if (hpage_collapse_test_exit(mm))
> > +			continue;
> > +		/*
> > +		 * When a vma is registered with uffd-wp, we cannot recycle
> > +		 * the page table because there may be pte markers installed.
> > +		 * Other vmas can still have the same file mapped hugely, but
> > +		 * skip this one: it will always be mapped in small page size
> > +		 * for uffd-wp registered ranges.
> > +		 *
> > +		 * What if VM_UFFD_WP is set a moment after this check?  No
> > +		 * problem, huge page lock is still held, stopping new mappings
> > +		 * of page which might then get replaced by pte markers: only
> > +		 * existing markers need to be protected here.  (We could check
> > +		 * after getting ptl below, but this comment distracting there!)
> > +		 */
> > +		if (userfaultfd_wp(vma))
> > +			continue;
> 
> IIUC here with the new code we only hold (1) hpage lock, and (2)
> i_mmap_lock read.  Then could it possible that right after checking this
> and found !UFFD_WP, but then someone quickly (1) register uffd-wp on this
> vma, then UFFDIO_WRITEPROTECT to install some pte markers, before below
> pgtable locks taken?
> 
> The thing is installation of pte markers may not need either of the locks
> iiuc..
> 
> Would taking mmap read lock help in this case?

Isn't my comment above it a good enough answer?  If I misunderstand the
uffd-wp pte marker ("If"? certainly I don't understand it well enough,
but I may or may not be too wrong about it here), and actually it can
spring up in places where the page has not even been mapped yet, then
I'd *much* rather just move that check down into the pte_locked area,
than involve mmap read lock (which, though easier to acquire than its
write lock, would I think take us back to square 1 in terms of needing
trylock); but I did prefer not to have a big uffd-wp comment distracting
from the code flow there.

I expect now, that if I follow up UFFDIO_WRITEPROTECT, I shall indeed
find it inserting pte markers where the page has not even been mapped
yet.  A "Yes" from you will save me looking, but probably I shall have
to move that check down (oh well, the comment will be smaller there).

Thanks,
Hugh
