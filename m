Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9255D6684AF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 21:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240928AbjALU4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 15:56:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240559AbjALUxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 15:53:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6AA5FEF
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 12:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673555243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VBLCHVO82d/2W65Vpf7eo3G/0tpbBxHuwYdreuuMDDQ=;
        b=QAl5JUVRdMvzZcA7XpFAOm+5yVHK+qiyo01s2LHK7XmWUAUABXJKR6ddri/8gOXD8aUpTl
        3OVnjfAvFhloiGytl4a1t+cBwZChFHcaE6VT8lpsncgUBihFUfP33dIhF5JMas7ZDT/Y01
        l1du90JGYKHsSWwQ/m+yjv7fXQ/zrUs=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-561-i0Gg34ZfNZqixIX0ZmNA9g-1; Thu, 12 Jan 2023 15:27:22 -0500
X-MC-Unique: i0Gg34ZfNZqixIX0ZmNA9g-1
Received: by mail-qk1-f200.google.com with SMTP id br6-20020a05620a460600b007021e1a5c48so13723762qkb.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 12:27:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VBLCHVO82d/2W65Vpf7eo3G/0tpbBxHuwYdreuuMDDQ=;
        b=pgzpCRwHM+xL8/fmFtQldGd/yhUSiiv8hgnid9B4prmXkgcN/eVTvJSua/yL5onJW5
         ROFP9wNzx9EWkloz+y1JN9YF3RF2hdTLvyZRc+efyBDpx83SrxVjiswCsv4glYuvPRxR
         kcwBdZvvF0glSEfJDiOjI9vWlrwYwvhLH2oBWXUb8NIKvVkBYx8aAa91+2qvBnhl9EZH
         MSXBRMdF95tzW0XvzPajjkyMZP3RTrA953Qk/1NEw/4HAoTtUES92ESIK8aNrrD6CsOK
         geY0KRSw11KWQJUvqdXzsBSOCjYIA13GwG/AJT8APSuanOY0bl0BZGXd7BhEUW54ufUH
         3h3A==
X-Gm-Message-State: AFqh2kpQ7lpsFDKstVQGGWB7kPCSUBRt9kXT1iBlSBl0EVdkaw9MtUIB
        hHgM4gybTEAo74VMr7zKUNK4++9SvO6xwPNHLz9SiVAFqOUr9lzE/CZ3yatWQW4CxD+cRB/tXqo
        DxLcyyUxqkVL61U+abXpUaPP8
X-Received: by 2002:a05:6214:2b4c:b0:532:174b:b8b8 with SMTP id jy12-20020a0562142b4c00b00532174bb8b8mr38371318qvb.27.1673555241955;
        Thu, 12 Jan 2023 12:27:21 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvACm9pcjxuI9YFYnVkYqEKbMJCieT6cT5aOuUJxpH4TjdIH0Erz/kvo6g0eCl5ZiYClX+LfA==
X-Received: by 2002:a05:6214:2b4c:b0:532:174b:b8b8 with SMTP id jy12-20020a0562142b4c00b00532174bb8b8mr38371294qvb.27.1673555241623;
        Thu, 12 Jan 2023 12:27:21 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id y11-20020a05620a25cb00b006bbf85cad0fsm11467194qko.20.2023.01.12.12.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 12:27:21 -0800 (PST)
Date:   Thu, 12 Jan 2023 15:27:19 -0500
From:   Peter Xu <peterx@redhat.com>
To:     James Houghton <jthoughton@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Zach O'Keefe <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 21/46] hugetlb: use struct hugetlb_pte for
 walk_hugetlb_range
Message-ID: <Y8BtJzBLTpw5IR+H@x1n>
References: <20230105101844.1893104-1-jthoughton@google.com>
 <20230105101844.1893104-22-jthoughton@google.com>
 <Y78+/wleTEC3gyqu@x1n>
 <CADrL8HU-prbfx2xxXCi0RPznp5DB68-NjqqmdM+4aUeUUURhiA@mail.gmail.com>
 <Y8AnROAtMngKntnq@x1n>
 <CADrL8HWFfqCqbpmvv8BSpvvzJ9aEeBEN30bMLuWGancsfMXv2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADrL8HWFfqCqbpmvv8BSpvvzJ9aEeBEN30bMLuWGancsfMXv2w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 11:45:40AM -0500, James Houghton wrote:
> On Thu, Jan 12, 2023 at 10:29 AM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Thu, Jan 12, 2023 at 09:06:48AM -0500, James Houghton wrote:
> > > On Wed, Jan 11, 2023 at 5:58 PM Peter Xu <peterx@redhat.com> wrote:
> > > >
> > > > James,
> > > >
> > > > On Thu, Jan 05, 2023 at 10:18:19AM +0000, James Houghton wrote:
> > > > > @@ -751,9 +761,9 @@ static int smaps_hugetlb_range(pte_t *pte, unsigned long hmask,
> > > > >               int mapcount = page_mapcount(page);
> > > > >
> > > > >               if (mapcount >= 2)
> > > > > -                     mss->shared_hugetlb += huge_page_size(hstate_vma(vma));
> > > > > +                     mss->shared_hugetlb += hugetlb_pte_size(hpte);
> > > > >               else
> > > > > -                     mss->private_hugetlb += huge_page_size(hstate_vma(vma));
> > > > > +                     mss->private_hugetlb += hugetlb_pte_size(hpte);
> > > > >       }
> > > > >       return 0;
> > > >
> > > > One thing interesting I found with hgm right now is mostly everything will
> > > > be counted as "shared" here, I think it's because mapcount is accounted
> > > > always to the huge page even if mapped in smaller sizes, so page_mapcount()
> > > > to a small page should be huge too because the head page mapcount should be
> > > > huge.  I'm curious the reasons behind the mapcount decision.
> > > >
> > > > For example, would that risk overflow with head_compound_mapcount?  One 1G
> > > > page mapping all 4K takes 0.25M counts, while the limit should be 2G for
> > > > atomic_t.  Looks like it's possible.
> > >
> > > The original mapcount approach was "if the hstate-level PTE is
> > > present, increment the compound_mapcount by 1" (basically "if any of
> > > the hugepage is mapped, increment the compound_mapcount by 1"), but
> > > this was painful to implement,
> >
> > Any more info here on why it was painful?  What is the major blocker?
> 
> The original approach was implemented in RFC v1, but the
> implementation was broken: the way refcount was handled was wrong; it
> was incremented once for each new page table mapping. (How?
> find_lock_page(), called once per hugetlb_no_page/UFFDIO_CONTINUE
> would increment refcount and we wouldn't drop it, and in
> __unmap_hugepage_range(), the mmu_gather bits would decrement the
> refcount once per mapping.)

I'm not sure I fully get the point here, but perhaps it's mostly about how
hugetlb page cache is managed (in hstate size not PAGE_SIZE)?

static inline struct page *folio_file_page(struct folio *folio, pgoff_t index)
{
	/* HugeTLBfs indexes the page cache in units of hpage_size */
	if (folio_test_hugetlb(folio))
		return &folio->page;
	return folio_page(folio, index & (folio_nr_pages(folio) - 1));
}

I haven't thought through on that either.  Is it possible that we switche
the pgcache layout to be in PAGE_SIZE granule too when HGM enabled (e.g. a
simple scheme is we can fail MADV_SPLIT if hugetlb pgcache contains any
page already).

If keep using the same pgcache scheme (hpage_size stepped indexes),
find_lock_page() will also easily content on the head page lock, so we may
not be able to handle concurrent page faults on small mappings on the same
page as efficient as thp.

> 
> At the time, I figured the complexity of handling mapcount AND
> refcount correctly in the original approach would be quite complex, so
> I switched to the new one.
> 
> 1. In places that already change the mapcount, check that we're
> installing the hstate-level PTE, not a high-granularity PTE. Adjust
> mapcount AND refcount appropriately.
> 2. In the HGM walking bits, to the caller if we made the hstate-level
> PTE present. (hugetlb_[pmd,pte]_alloc is the source of truth.) Need to
> keep track of this until we figure out which page we're allocating
> PTEs for, then change mapcount/refcount appropriately.
> 3. In unmapping bits, change mmu_gather/tlb bits to drop refcount only
> once per hugepage. (This is probably the hardest of these three things
> to get right.)
> 
> >
> > > so I changed it to what it is now (each new PT mapping increments the
> > > compound_mapcount by 1). I think you're right, there is absolutely an
> > > overflow risk. :( I'm not sure what the best solution is. I could just go
> > > back to the old approach.
> >
> > No rush on that; let's discuss it thoroughly before doing anything.  We
> > have more context than when it was discussed initially in the calls, so
> > maybe a good time to revisit.
> >
> > >
> > > Regarding when things are accounted in private_hugetlb vs.
> > > shared_hugetlb, HGM shouldn't change that, because it only applies to
> > > shared mappings (right now anyway). It seems like "private_hugetlb"
> > > can include cases where the page is shared but has only one mapping,
> > > in which case HGM will change it from "private" to "shared".
> >
> > The two fields are not defined against VM_SHARED, it seems.  At least not
> > with current code base.
> >
> > Let me quote the code again just to be clear:
> >
> >                 int mapcount = page_mapcount(page);    <------------- [1]
> >
> >                 if (mapcount >= 2)
> >                         mss->shared_hugetlb += hugetlb_pte_size(hpte);
> >                 else
> >                         mss->private_hugetlb += hugetlb_pte_size(hpte);
> >
> >                 smaps_hugetlb_hgm_account(mss, hpte);
> >
> > So that information (for some reason) is only relevant to how many mapcount
> > is there.  If we have one 1G page and only two 4K mapped, with the existing
> > logic we should see 8K private_hugetlb while in fact I think it should be
> > 8K shared_hugetlb due to page_mapcount() taking account of both 4K mappings
> > (as they all goes back to the head).
> >
> > I have no idea whether violating that will be a problem or not, I suppose
> > at least it needs justification if it will be violated, or hopefully it can
> > be kept as-is.
> 
> Agreed that this is a problem. I'm not sure what should be done here.
> It seems like the current upstream implementation is incorrect (surely
> MAP_SHARED with only one mapping should still be shared_hugetlb not
> private_hugetlb); the check should really be `if (vma->vm_flags &
> VM_MAYSHARE)` instead of `mapcount >= 2`. If that change can be taken,
> we don't have a problem here.

Naoya added relevant code.  Not sure whether he'll chim in.

commit 25ee01a2fca02dfb5a3ce316e77910c468108199
Author: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Date:   Thu Nov 5 18:47:11 2015 -0800

    mm: hugetlb: proc: add hugetlb-related fields to /proc/PID/smaps

In all cases, it'll still be a slight ABI change, so worth considering the
effects to existing users.

> 
> >
> > >
> > > >
> > > > Btw, are the small page* pointers still needed in the latest HGM design?
> > > > Is there code taking care of disabling of hugetlb vmemmap optimization for
> > > > HGM?  Or maybe it's not needed anymore for the current design?
> > >
> > > The hugetlb vmemmap optimization can still be used with HGM, so there
> > > is no code to disable it. We don't need small page* pointers either,
> > > except for when we're dealing with mapping subpages, like in
> > > hugetlb_no_page. Everything else can handle the hugetlb page as a
> > > folio.
> > >
> > > I hope we can keep compatibility with the vmemmap optimization while
> > > solving the mapcount overflow risk.
> >
> > Yeh that'll be perfect if it works.  But afaiu even with your current
> > design (ignoring all the issues on either smaps accounting or overflow
> > risks), we already referenced the small pages, aren't we?  See:
> >
> > static inline int page_mapcount(struct page *page)
> > {
> >         int mapcount = atomic_read(&page->_mapcount) + 1;  <-------- here
> >
> >         if (likely(!PageCompound(page)))
> >                 return mapcount;
> >         page = compound_head(page);
> >         return head_compound_mapcount(page) + mapcount;
> > }
> >
> > Even if we assume small page->_mapcount should always be zero in this case,
> > we may need to take special care of hugetlb pages in page_mapcount() to not
> > reference it at all.  Or I think it's reading random values and some days
> > it can be non-zero.
> 
> IIUC, it's ok to read from all the hugetlb subpage structs, you just
> can't *write* to them (except the first few). The first page of page
> structs is mapped RW; all the others are mapped RO to a single
> physical page.

I'm not familiar with vmemmap work, but I saw this:

	/*
	 * Remap the vmemmap virtual address range [@vmemmap_start, @vmemmap_end)
	 * to the page which @vmemmap_reuse is mapped to, then free the pages
	 * which the range [@vmemmap_start, @vmemmap_end] is mapped to.
	 */
	if (vmemmap_remap_free(vmemmap_start, vmemmap_end, vmemmap_reuse))

It seems it'll reuse the 1st page of the huge page* rather than backing the
rest vmemmap with zero pages.  Would that be a problem (as I think some
small page* can actually points to the e.g. head page* if referenced)?

> 
> >
> > The other approach is probably using the thp approach.  After Hugh's rework
> > on the thp accounting I assumed it would be even cleaner (at least no
> > DoubleMap complexity anymore.. even though I can't say I fully digested the
> > whole history of that).  It's all about what's the major challenges of
> > using the same approach there with thp.  You may have more knowledge on
> > that aspect so I'd be willing to know.
> 
> I need to take a closer look at Hugh's approach to see if we can do it
> the same way. (I wonder if the 1G THP series has some ideas too.)

https://lore.kernel.org/all/47ad693-717-79c8-e1ba-46c3a6602e48@google.com/

It's already in the mainline.  I think it's mostly internally implemented
under the rmap code APIs.  For the HGM effort, I'd start with simply
passing around compound=false when using the rmap APIs, and see what'll
start to fail.

> 
> A really simple solution could be just to prevent userspace from doing
> MADV_SPLIT (or, if we are enabling HGM due to hwpoison, ignore the
> poison) if it could result in a mapcount overflow. For 1G pages,
> userspace would need 8192 mappings to overflow mapcount/refcount.

I'm not sure you can calculate it; consider fork()s along the way when pmd
sharing disabled, or whatever reason when the 1G pages mapped at multiple
places with more than one mmap()s.

Thanks,

-- 
Peter Xu

