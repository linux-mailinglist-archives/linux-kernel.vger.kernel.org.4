Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 598C0718981
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 20:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbjEaSmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 14:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbjEaSmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 14:42:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34F3132
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 11:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685558493;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1FWGW2Jo813Y825xd7lmduxNsukxU+ZyyJwbLRdWmSE=;
        b=c6YEoqnZNarHAaoTAoEBOSk2HHpDMr3hMBeX4VY5g8gI9A7N8Up9waBk0vmOjmweX5NqVZ
        YTitLp7GLIvAyys6edh4L9lREjCKCwbc/0sSiyu5iM1EYq2Uw7heHCui08NS6eAy7v7d4s
        CovGpd1uc2VGCq9dWmyO5DlHq0WNQBk=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-KpWpjKuRMR6kCk5laF7pkQ-1; Wed, 31 May 2023 14:41:32 -0400
X-MC-Unique: KpWpjKuRMR6kCk5laF7pkQ-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6262552799aso156746d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 11:41:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685558492; x=1688150492;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1FWGW2Jo813Y825xd7lmduxNsukxU+ZyyJwbLRdWmSE=;
        b=Pq/lEODFwkJY0Bgz2Z1iU9hk5sLgtVCB0JVCiCO/zuHCPK62cShuZRnTWPO+ScoE/Q
         tSCV6RdJFpo6hysdEZZFfRw9mnvbibFTPwV2tg7L5Sfci4UTRJu+jWxjRN6nC6iNoZQ7
         OmfDUxpsoMny7Hi2SNqWHvHzSkScBnhdTJlq2RNPJUS/W/Hv6cBDPclZCi4zPpdh+UOL
         ntNbQjrjGeLB/VpkJmi47XmNh3YZUF1dP7F1CIe2rsnSulC2LCtbWj2wRashWq6v0Rc+
         cCS1Hax/OrBzcGhQFYwCq/kDIQ336Ad6pSw3VJKgP/GZDgiSlE4wCVd+0h0DU8eAbZNT
         WPQA==
X-Gm-Message-State: AC+VfDxXMfoyXcX1WR2oFXzkS+0AVMv5FUJKVvAgK7YT3JCP2+nUxs0c
        IACaI5c3bl80O2/meVSYUq963uixKPcCK4jfwiN+Lg2BCXfEINtd3UEbZ9fzVC5fGzqU+KaD6G1
        QUooTBsQT807XycZ2dra4b45b
X-Received: by 2002:a05:6214:2409:b0:61b:6b8e:16e0 with SMTP id fv9-20020a056214240900b0061b6b8e16e0mr4347604qvb.1.1685558491678;
        Wed, 31 May 2023 11:41:31 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6BN5MQAewbvj13QLR+tXEvy0N0Wl1vLxip9GURVxevVLwA82ca7P0eDgLONQ2wtwwgro+w8w==
X-Received: by 2002:a05:6214:2409:b0:61b:6b8e:16e0 with SMTP id fv9-20020a056214240900b0061b6b8e16e0mr4347542qvb.1.1685558491233;
        Wed, 31 May 2023 11:41:31 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca. [70.24.86.62])
        by smtp.gmail.com with ESMTPSA id ek8-20020ad45988000000b006260a1f1534sm5314470qvb.25.2023.05.31.11.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 11:41:30 -0700 (PDT)
Date:   Wed, 31 May 2023 14:41:27 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <ZHeU1ykPa0+PqIXb@x1n>
References: <35e983f5-7ed3-b310-d949-9ae8b130cdab@google.com>
 <2e9996fa-d238-e7c-1194-834a2bd1f60@google.com>
 <ZHU0m+QIChZNdOdg@x1n>
 <48c679e9-8eed-568a-1de1-c57e315c693c@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <48c679e9-8eed-568a-1de1-c57e315c693c@google.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 05:38:25PM -0700, Hugh Dickins wrote:
> Thanks for looking, Peter: I was well aware of you dropping several hints
> that you wanted to see what's intended before passing judgment on earlier
> series, and I preferred to get on with showing this series, than go into
> detail in responses to you there - thanks for your patience :)

Not a problem at all here!

> 
> On Mon, 29 May 2023, Peter Xu wrote:
> > On Sun, May 28, 2023 at 11:25:15PM -0700, Hugh Dickins wrote:
> ...
> > > @@ -1748,123 +1747,73 @@ static void khugepaged_collapse_pte_mapped_thps(struct khugepaged_mm_slot *mm_sl
> > >  	mmap_write_unlock(mm);
> > >  }
> > >  
> > > -static int retract_page_tables(struct address_space *mapping, pgoff_t pgoff,
> > > -			       struct mm_struct *target_mm,
> > > -			       unsigned long target_addr, struct page *hpage,
> > > -			       struct collapse_control *cc)
> > > +static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
> > >  {
> > >  	struct vm_area_struct *vma;
> > > -	int target_result = SCAN_FAIL;
> > >  
> > > -	i_mmap_lock_write(mapping);
> > > +	i_mmap_lock_read(mapping);
> > >  	vma_interval_tree_foreach(vma, &mapping->i_mmap, pgoff, pgoff) {
> > > -		int result = SCAN_FAIL;
> > > -		struct mm_struct *mm = NULL;
> > > -		unsigned long addr = 0;
> > > -		pmd_t *pmd;
> > > -		bool is_target = false;
> > > +		struct mm_struct *mm;
> > > +		unsigned long addr;
> > > +		pmd_t *pmd, pgt_pmd;
> > > +		spinlock_t *pml;
> > > +		spinlock_t *ptl;
> > >  
> > >  		/*
> > >  		 * Check vma->anon_vma to exclude MAP_PRIVATE mappings that
> > > -		 * got written to. These VMAs are likely not worth investing
> > > -		 * mmap_write_lock(mm) as PMD-mapping is likely to be split
> > > -		 * later.
> > > +		 * got written to. These VMAs are likely not worth removing
> > > +		 * page tables from, as PMD-mapping is likely to be split later.
> > >  		 *
> > > -		 * Note that vma->anon_vma check is racy: it can be set up after
> > > -		 * the check but before we took mmap_lock by the fault path.
> > > -		 * But page lock would prevent establishing any new ptes of the
> > > -		 * page, so we are safe.
> > > -		 *
> > > -		 * An alternative would be drop the check, but check that page
> > > -		 * table is clear before calling pmdp_collapse_flush() under
> > > -		 * ptl. It has higher chance to recover THP for the VMA, but
> > > -		 * has higher cost too. It would also probably require locking
> > > -		 * the anon_vma.
> > > +		 * Note that vma->anon_vma check is racy: it can be set after
> > > +		 * the check, but page locks (with XA_RETRY_ENTRYs in holes)
> > > +		 * prevented establishing new ptes of the page. So we are safe
> > > +		 * to remove page table below, without even checking it's empty.
> > >  		 */
> > > -		if (READ_ONCE(vma->anon_vma)) {
> > > -			result = SCAN_PAGE_ANON;
> > > -			goto next;
> > > -		}
> > > +		if (READ_ONCE(vma->anon_vma))
> > > +			continue;
> > 
> > Not directly related to current patch, but I just realized there seems to
> > have similar issue as what ab0c3f1251b4 wanted to fix.
> > 
> > IIUC any shmem vma that used to have uprobe/bp installed will have anon_vma
> > set here, then does it mean that any vma used to get debugged will never be
> > able to merge into a thp (with either madvise or khugepaged)?
> > 
> > I think it'll only make a difference when the page cache is not huge yet
> > when bp was uninstalled, but then it becomes a thp candidate somehow.  Even
> > if so, I think the anon_vma should still be there.
> > 
> > Did I miss something, or maybe that's not even a problem?
> 
> Finding vma->anon_vma set would discourage retract_page_tables() from
> doing its business with that previously uprobed area; but it does not stop
> collapse_pte_mapped_thp() (which uprobes unregister calls directly) from
> dealing with it,

This one is true to me.

> and MADV_COLLAPSE works on anon_vma'ed areas too.  It's just a heuristic
> in retract_page_tables(), when it chooses to skip the anon_vma'ed areas
> as often not worth bothering with.

This is the one I'm unsure about.

What I read (at least with current code base) is that both the khugepaged
and madvise paths will rely on SCAN_PTE_MAPPED_HUGEPAGE returned (or to be
returned) first, then only if so we will have the attempt to collapse:

  - For khugepaged, we'll add the candidate into pte_mapped_thp[] array
    only after we set "result=SCAN_PTE_MAPPED_HUGEPAGE":

		if (!is_target) {
			khugepaged_add_pte_mapped_thp(mm, addr);
			continue;
		}

  - For madvise, we fully rely on hpage_collapse_scan_file() retval to be
    SCAN_PTE_MAPPED_HUGEPAGE to trigger the collapse_pte_mapped_thp().

While the anon_vma check in retract_page_tables() is fairly early for each
vma run, assuming the simplest case of 1 vma mapping IIUC it'll just never
try to collapse such a vma?

> 
> As to vma merges: I haven't actually checked since the maple tree and other
> rewrites of vma merging, but previously one vma with anon_vma set could be
> merged with adjacent vma before or after without anon_vma set - the
> anon_vma comparison is not just equality of anon_vma, but allows NULL too -
> so the anon_vma will still be there, but extends to cover the wider extent.
> Right, I find is_mergeable_anon_vma() still following that rule.

Yes.

> 
> (And once vmas are merged, so that the whole of the huge page falls within
> a single vma, khugepaged can consider it, and do collapse_pte_mapped_thp()
> on it - before or after 11/12 I think.)
> 
> As to whether it would even be a problem: generally no, the vma is supposed
> just to be an internal representation, and so long as the code resists
> proliferating them unnecessarily, occasional failures to merge should not
> matter.  The one place that forever sticks in my mind as mattering (perhaps
> there are others I'm unaware of, but I'd call them bugs) is mremap(): which
> is sufficiently awkward and bug-prone already, that nobody ever had the
> courage to make it independent of vma boundaries; but ideally, it's
> mremap() that we should fix.
> 
> But I may have written three answers, yet still missed your point.

Thanks for writing three answers. :) For me maybe what I worried is even
simpler, please refer to above if that explains.  Again, I don't think
that's a problem specific to this series as it was there before or after,
and I still keep thinking I could have just missed something.

I'll also need to rethink too (by reading more carefully on the follow up
ones) since I think this series changed some facts above, maybe it'll be
different when whole set applied, which I'll do.

> 
> ...
> > > +
> > > +		mm = vma->vm_mm;
> > > +		if (find_pmd_or_thp_or_none(mm, addr, &pmd) != SCAN_SUCCEED)
> > > +			continue;
> > > +
> > > +		if (hpage_collapse_test_exit(mm))
> > > +			continue;
> > > +		/*
> > > +		 * When a vma is registered with uffd-wp, we cannot recycle
> > > +		 * the page table because there may be pte markers installed.
> > > +		 * Other vmas can still have the same file mapped hugely, but
> > > +		 * skip this one: it will always be mapped in small page size
> > > +		 * for uffd-wp registered ranges.
> > > +		 *
> > > +		 * What if VM_UFFD_WP is set a moment after this check?  No
> > > +		 * problem, huge page lock is still held, stopping new mappings
> > > +		 * of page which might then get replaced by pte markers: only
> > > +		 * existing markers need to be protected here.  (We could check
> > > +		 * after getting ptl below, but this comment distracting there!)
> > > +		 */
> > > +		if (userfaultfd_wp(vma))
> > > +			continue;
> > 
> > IIUC here with the new code we only hold (1) hpage lock, and (2)
> > i_mmap_lock read.  Then could it possible that right after checking this
> > and found !UFFD_WP, but then someone quickly (1) register uffd-wp on this
> > vma, then UFFDIO_WRITEPROTECT to install some pte markers, before below
> > pgtable locks taken?
> > 
> > The thing is installation of pte markers may not need either of the locks
> > iiuc..
> > 
> > Would taking mmap read lock help in this case?
> 
> Isn't my comment above it a good enough answer?  If I misunderstand the
> uffd-wp pte marker ("If"? certainly I don't understand it well enough,
> but I may or may not be too wrong about it here), and actually it can
> spring up in places where the page has not even been mapped yet, then
> I'd *much* rather just move that check down into the pte_locked area,
> than involve mmap read lock (which, though easier to acquire than its
> write lock, would I think take us back to square 1 in terms of needing
> trylock); but I did prefer not to have a big uffd-wp comment distracting
> from the code flow there.
> 
> I expect now, that if I follow up UFFDIO_WRITEPROTECT, I shall indeed
> find it inserting pte markers where the page has not even been mapped
> yet.  A "Yes" from you will save me looking, but probably I shall have
> to move that check down (oh well, the comment will be smaller there).

I think the answer is yes, as we need to be able to install markers just to
avoid knowing the fact on "what's inside the page cache" for file mems
(which IIRC originates from your suggestion even if in another format of
swap encoding, but the idea should be similar).

Moving it into the pgtable locked section looks fine here too for this
specific issue.

Thanks,

-- 
Peter Xu

