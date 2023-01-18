Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1AC67216D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 16:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjARPgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 10:36:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbjARPf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 10:35:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591AC59C2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 07:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674056107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hoPlAbl/qAJgc4OFaxSaw2xRu3cZD/WsKuUdRGUQx3I=;
        b=i0NOqZXa8DcDQUvY1qbOk39u8vck67gttZ/cHOB2/g+ocOQTGBXNOc1yI52WdBiWPkpxwq
        PJbD7FC+IiPRO6KI0f663CcELbKwgWlugYoBeqzwKoUuWxID5hRemPqY+cv6NIDmBHtkKW
        k4IXmoXLggAKu1uFQgIeCUk+3xNRPAE=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-160-vUyu0M8QO0SQAwLOgJv1aQ-1; Wed, 18 Jan 2023 10:35:06 -0500
X-MC-Unique: vUyu0M8QO0SQAwLOgJv1aQ-1
Received: by mail-vk1-f200.google.com with SMTP id l197-20020a1ffece000000b003e1cb6fe65dso320579vki.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 07:35:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hoPlAbl/qAJgc4OFaxSaw2xRu3cZD/WsKuUdRGUQx3I=;
        b=5kA+9fRH1RRq/1Q47n7cjNmWJHAhbE3j0nzlkQsNilXpK9/MEKg8u9zgv6Xw7yRK3X
         fpjj69fawhcMA7DeuO+gcRk9IwHrXj2xsHjoDRFS/pCCbrwoLGg6qcXqnzE0R5e9ry2M
         7JK0KsMcZ0Slp89jRLbwzZrpkirFReNs/FTIju+qGU3lh0p7WCUdI/aPkd7ZzjllT2Cd
         YMWzdHI9WsBO7uF/ScA/O8aG+F1Hz64yZm70uFVPyQzcGShiuuuTh5hW7OXKcLd5S1dU
         ez8ow2GDKYNhBcjmyN6fRTF8VlB2S6qC7ivN10yRANSegl6ZNbOeSGYVxTKEaJj+VCR2
         Lx5g==
X-Gm-Message-State: AFqh2kppbRS/Xit7/QNLch9zEJW0xjUHbmfCSJYPxCyjctbLbag9F5ow
        Ei0st62rW1qkrTfDPXBgIvV3ORJcCm0e6QJNOaMDi5RhF6xokXcZ4J3VmmzgWle6Bo6zfL1ytBQ
        KbSPYY+QoLZ7FJtc/RNQibaCX
X-Received: by 2002:a05:6102:32c7:b0:3d0:a805:e6af with SMTP id o7-20020a05610232c700b003d0a805e6afmr4437295vss.15.1674056105415;
        Wed, 18 Jan 2023 07:35:05 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvj5VymNnFLVyufLek0ENN9hzNGXcwbGplq0yqXcCFlzen07tlaz0xYgXlQBCwkmMPm+hv/rg==
X-Received: by 2002:a05:6102:32c7:b0:3d0:a805:e6af with SMTP id o7-20020a05610232c700b003d0a805e6afmr4437275vss.15.1674056105051;
        Wed, 18 Jan 2023 07:35:05 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id d6-20020a37b406000000b007049f19c736sm22057425qkf.7.2023.01.18.07.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 07:35:03 -0800 (PST)
Date:   Wed, 18 Jan 2023 10:35:00 -0500
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     James Houghton <jthoughton@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
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
Message-ID: <Y8gRpEonhXgqfb41@x1n>
References: <Y78+/wleTEC3gyqu@x1n>
 <CADrL8HU-prbfx2xxXCi0RPznp5DB68-NjqqmdM+4aUeUUURhiA@mail.gmail.com>
 <Y8AnROAtMngKntnq@x1n>
 <CADrL8HWFfqCqbpmvv8BSpvvzJ9aEeBEN30bMLuWGancsfMXv2w@mail.gmail.com>
 <Y8BtJzBLTpw5IR+H@x1n>
 <CADrL8HUi-j4ais45Xq8Jpb6a7DsWiXrKNeJfsqBRMi1Lier8xA@mail.gmail.com>
 <Y8B8mW2zSWDDwp7G@x1n>
 <06423461-c543-56fe-cc63-cabda6871104@redhat.com>
 <CADrL8HUdg1Fr=tLEQRkDjeTzNzzSM6EPhvDgzURxSZSBMLgjoQ@mail.gmail.com>
 <6548b3b3-30c9-8f64-7d28-8a434e0a0b80@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6548b3b3-30c9-8f64-7d28-8a434e0a0b80@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 10:43:47AM +0100, David Hildenbrand wrote:
> On 18.01.23 00:11, James Houghton wrote:
> > On Mon, Jan 16, 2023 at 2:17 AM David Hildenbrand <david@redhat.com> wrote:
> > > 
> > > On 12.01.23 22:33, Peter Xu wrote:
> > > > On Thu, Jan 12, 2023 at 04:17:52PM -0500, James Houghton wrote:
> > > > > I'll look into it, but doing it this way will use _mapcount, so we
> > > > > won't be able to use the vmemmap optimization. I think even if we do
> > > > > use Hugh's approach, refcount is still being kept on the head page, so
> > > > > there's still an overflow risk there (but maybe I am
> > > > > misunderstanding).
> > > > 
> > > > Could you remind me what's the issue if using refcount on the small pages
> > > > rather than the head (assuming vmemmap still can be disabled)?
> > > 
> > > The THP-way of doing things is refcounting on the head page. All folios
> > > use a single refcount on the head.
> > > 
> > > There has to be a pretty good reason to do it differently.
> > 
> > Peter and I have discussed this a lot offline. There are two main problems here:
> > 
> > 1. Refcount overflow
> > 
> > Refcount is always kept on the head page (before and after this
> > series). IIUC, this means that if THPs could be 1G in size, they too
> > would be susceptible to the same potential overflow. How easy is the
> > overflow? [1]
> 
> Right. You'd need 8k VMAs. With 2 MiB THP you'd need 4096k VMAs. So ~64
> processes with 64k VMAs. Not impossible to achieve if one really wants to
> break the system ...
> 
> Side note: a long long time ago, we used to have sub-page refcounts for THP.
> IIRC, that was even before we had sub-page mapcounts and was used to make
> COW decisions.
> 
> > 
> > To deal with this, the best solution we've been able to come up with
> > is to check if refcount is > INT_MAX/2 (similar to try_get_page()),
> > and if it is, stop the operation (UFFDIO_CONTINUE or a page fault)
> > from proceeding. In the UFFDIO_CONTINUE case, return ENOMEM. In the
> > page fault cause, return VM_FAULT_SIGBUS (not VM_FAULT_OOM; we don't
> > want to kill a random process).
> 
> You'd have to also make sure that fork() won't do the same. At least with
> uffd-wp, Peter also added page table copying during fork() for MAP_SHARED
> mappings, which would have to be handled.

If we want such a check to make a real difference, IIUC we may want to
consider having similar check in:

        page_ref_add
        page_ref_inc
        page_ref_inc_return
        page_ref_add_unless

But it's unfortunate that mostly all the callers to these functions
(especially the first two) do not have a retval yet at all.  Considering
the low possibility so far on having it overflow, maybe it can also be done
for later (and I think checking negative as try_get_page would suffice too).

> 
> Of course, one can just disallow fork() with any HGM right from the start
> and keep it all simpler to not open up a can of worms there.
> 
> Is it reasonable, to have more than one (or a handful) of VMAs mapping a
> huge page via a HGM? Restricting it to a single one, would make handling
> much easier.
> 
> If there is ever demand for more HGM mappings, that whole problem (and
> complexity) could be dealt with later. ... but I assume it will already be a
> requirement for VMs (e.g., under QEMU) that share memory with other
> processes (virtiofsd and friends?)

Yes, any form of multi-proc QEMU will need that for supporting HGM
postcopy.

> 
> 
> > 
> > (So David, I think this answers your question. Refcount should be
> > handled just like THPs.)
> > 
> > 2. page_mapcount() API differences
> > 
> > In this series, page_mapcount() returns the total number of page table
> > references for the compound page. For example, if you have a
> > PTE-mapped 2M page (with no other mappings), page_mapcount() for each
> > 4K page will be 512. This is not the same as a THP: page_mapcount()
> > would return 1 for each page. Because of the difference in
> > page_mapcount(), we have 4 problems:
> 
> IMHO, it would actually be great to just be able to remove the sub-page
> mapcounts for THP and make it all simpler.
> 
> Right now, the sub-page mapcount is mostly required for making COW
> decisions, but only for accounting purposes IIRC (NR_ANON_THPS,
> NR_SHMEM_PMDMAPPED, NR_FILE_PMDMAPPED) and mlock handling IIRC. See
> page_remove_rmap().
> 
> If we can avoid that complexity right from the start for hugetlb, great, ..
> 
> > 
> > i. Smaps uses page_mapcount() >= 2 to determine if hugetlb memory is
> > "private_hugetlb" or "shared_hugetlb".
> > ii. Migration with MPOL_MF_MOVE will check page_mapcount() to see if
> > the hugepage is shared or not. Pages that would otherwise be migrated
> > now require MPOL_MF_MOVE_ALL to be migrated.
> > [Really both of the above are checking how many VMAs are mapping our hugepage.]
> > iii. CoW. This isn't a problem right now because CoW is only possible
> > with MAP_PRIVATE VMAs and HGM can only be enabled for MAP_SHARED VMAs.
> > iv. The hwpoison handling code will check if it successfully unmapped
> > the poisoned page. This isn't a problem right now, as hwpoison will
> > unmap all the mappings for the hugepage, not just the 4K where the
> > poison was found.
> > 
> > Doing it this way allows HGM to remain compatible with the hugetlb
> > vmemmap optimization. None of the above problems strike me as
> > particularly major, but it's unclear to me how important it is to have
> > page_mapcount() have a consistent meaning for hugetlb vs non-hugetlb.
> 
> See below, maybe we should tackle HGM from a different direction.
> 
> > 
> > The other way page_mapcount() (let's say the "THP-like way") could be
> > done is like this: increment compound mapcount if we're mapping a
> > hugetlb page normally (e.g., 1G page with a PUD). If we're mapping at
> > high-granularity, increment the mapcount for each 4K page that is
> > getting mapped (e.g., PMD within a 1G page: increment the mapcount for
> > the 512 pages that are now mapped). This yields the same
> > page_mapcount() API we had before, but we lose the hugetlb vmemmap
> > optimization.
> > 
> > We could introduce an API like hugetlb_vma_mapcount() that would, for
> > hugetlb, give us the number of VMAs that map a hugepage, but I don't
> > think people would like this.
> > 
> > I'm curious what others think (Mike, Matthew?). I'm guessing the
> > THP-like way is probably what most people would want, though it would
> > be a real shame to lose the vmemmap optimization.
> 
> Heh, not me :) Having a single mapcount is certainly much cleaner. ... and
> if we're dealing with refcount overflows already, mapcount overflows are not
> an issue.
> 
> 
> I wonder if the following crazy idea has already been discussed: treat the
> whole mapping as a single large logical mapping. One reference and one
> mapping, no matter how the individual parts are mapped into the assigned
> page table sub-tree.
> 
> Because for hugetlb with MAP_SHARED, we know that the complete assigned
> sub-tree of page tables can only map the given hugetlb page, no fragments of
> something else. That's very different to THP in private mappings ...
> 
> So as soon as the first piece gets mapped, we increment refcount+mapcount.
> Other pieces in the same subtree don't do that.
> 
> Once the last piece is unmapped (or simpler: once the complete subtree of
> page tables is gone), we decrement refcount+mapcount. Might require some
> brain power to do this tracking, but I wouldn't call it impossible right
> from the start.
> 
> Would such a design violate other design aspects that are important?

The question is how to maintaining above information.

It needs to be per-map (so one page mapped multiple times can be accounted
differently), and per-page (so one mapping/vma can contain multiple pages).
So far I think that's exactly the pgtable.  If we can squeeze information
into the pgtable it'll work out, but definitely not trivial.  Or we can
maintain seperate allocates for such information, but that can be extra
overheads too.

So far I'd still consider going with reusing thp mapcounts, which will
mostly be what James mentioned above. The only difference is I'm not sure
whether we should allow mapping e.g. 2M ranges for 1G pages.  THP mapcount
doesn't have intermediate layer to maintain mapcount information like 2M,
so to me it's easier we start with only mapping either the hpage size or
PAGE_SIZE, not any intermediate size allowed.

Having intermediate size mapping allowed can at least be error prone to
me.  One example is if some pgtable walker found a 2M page, it may easily
fetch the PFN out of it, assuming it's a compound page and it should
satisfy PageHead(pfn)==true but it'll start to break here, because the 2M
PFN will only be a small page pfn for the 1G huge page in this case.

To me, intermediate sized mappings are good to have but not required to
resolve HGM problems, at least so far.  Said that, I'm fine with looking at
what it'll look like if James would like to keep persuing that direction.

Thanks,

-- 
Peter Xu

