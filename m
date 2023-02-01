Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED0C8685C9A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 02:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbjBABZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 20:25:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjBABZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 20:25:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16265410B5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 17:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675214683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GMkaYOaMy3F2SWkAT76k5oWR2ccIe8K3HXPCAqK8Lps=;
        b=FwzSs65yo7WDMoajLaJ7s/BMoJouNerP0h6rd9eT2dzVeWFTWG6KlxQv3cvY+uGEU3+Sz7
        KRdHbyBKWWmYbjDUG6rlq0yjErIJr1DfiafXBDoovd8B+wFW45EF3zGRrc/1a85qUiixxp
        aeLdCruT6jeXUgRI1tmbOCC4WnVFeTs=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-589-DFpbhd_VOs29cJIz9R1XTg-1; Tue, 31 Jan 2023 20:24:42 -0500
X-MC-Unique: DFpbhd_VOs29cJIz9R1XTg-1
Received: by mail-qv1-f69.google.com with SMTP id q17-20020a056214019100b004b1d3c9f3acso9298853qvr.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 17:24:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GMkaYOaMy3F2SWkAT76k5oWR2ccIe8K3HXPCAqK8Lps=;
        b=4BSqQ8Z3pD+PvJaJ9Mr1HruAZ9UbDWeBAUfk7hMlNfMWRzxWAMEG8gI6i6WzCyf/lx
         eEHF0ti92ko7vob0voN08Tb8cklelwauYPb8NIW/hhLcZPqgUsHco6cwMYxTuN68Q3kK
         z6lIStlj2tgjSjMN5nxNW57Mm/IOnF2e27GeILlTFZIEcZS6RgcQATjAP+fBPXBdex4f
         IrfXRLggHqRnsHBDnn2T3TG1eVp8QBSGDZSjBrrAs1rJ21vocO1OOVSlKbUsU2IkogAJ
         DUGn5aCOxGjp9LDC055Y0QImDsLnuu/LL8lOXHlr3ZkyaonX2GJyV3Io/5ryy5aH59rw
         zRkA==
X-Gm-Message-State: AO0yUKXn8EOXAzXSLJPZ/sSsiK45JDE/eFIepZCRfuRGNZh7NazrPyVe
        1DpVgOHU9z2fv6vWb5bHw5G7QzdlD1yiXfD3liN10zGipXhz9h0rTroFstSKVaNgoyF4PPoyUfD
        b2fvWh4S+ejSW7gEE6+pk63XG
X-Received: by 2002:ac8:4b79:0:b0:3b9:b801:8744 with SMTP id g25-20020ac84b79000000b003b9b8018744mr1263315qts.4.1675214681509;
        Tue, 31 Jan 2023 17:24:41 -0800 (PST)
X-Google-Smtp-Source: AK7set/ERAy4HM0cD+7JT1/Zk8sIs6f464RvbsDc2g6bRWCPUTCkOYta+ZxRAHIqo+MkrJgXDY8fLQ==
X-Received: by 2002:ac8:4b79:0:b0:3b9:b801:8744 with SMTP id g25-20020ac84b79000000b003b9b8018744mr1263278qts.4.1675214681085;
        Tue, 31 Jan 2023 17:24:41 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id s39-20020a05622a1aa700b003a7e38055c9sm10931353qtc.63.2023.01.31.17.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 17:24:40 -0800 (PST)
Date:   Tue, 31 Jan 2023 20:24:37 -0500
From:   Peter Xu <peterx@redhat.com>
To:     James Houghton <jthoughton@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
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
Message-ID: <Y9m/VVRABt0Blfjh@x1n>
References: <CADrL8HUggALQET-09Zw3BhFjZdw_G9+v6CU=qtGtK=KZ_DeAsw@mail.gmail.com>
 <Y8l+f2wNp2gAjvYg@monkey>
 <CADrL8HVdL_NMdNq2mEemNCfwkYBAWnbqwyjsAYdQ2fF0iz34Hw@mail.gmail.com>
 <CADrL8HV92DaNm5bUwcOxsG8Lg4yLT6F13KWSbjkySPNAsgCfpA@mail.gmail.com>
 <Y9Li93O6Ffwcr+vn@x1n>
 <CADrL8HVJb9mA3Lbz5UKJ8EudTk9sGDY-pdRqvW3TGawD_bJB0A@mail.gmail.com>
 <Y9f+jMLWy6ngpYuR@x1n>
 <CADrL8HX3sf6OO3PXS1g6b2dKf8b5phQ7oyNR0dVT=sAOdTmmqw@mail.gmail.com>
 <Y9gzOqwKcu7p/PEw@x1n>
 <CADrL8HXX9YDFUxmPPsm2s3Pno0XXgAyFB40fV1PdtP9eb-5D2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADrL8HXX9YDFUxmPPsm2s3Pno0XXgAyFB40fV1PdtP9eb-5D2A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 04:24:15PM -0800, James Houghton wrote:
> On Mon, Jan 30, 2023 at 1:14 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Mon, Jan 30, 2023 at 10:38:41AM -0800, James Houghton wrote:
> > > On Mon, Jan 30, 2023 at 9:29 AM Peter Xu <peterx@redhat.com> wrote:
> > > >
> > > > On Fri, Jan 27, 2023 at 01:02:02PM -0800, James Houghton wrote:
> > > > > On Thu, Jan 26, 2023 at 12:31 PM Peter Xu <peterx@redhat.com> wrote:
> > > > > >
> > > > > > James,
> > > > > >
> > > > > > On Thu, Jan 26, 2023 at 08:58:51AM -0800, James Houghton wrote:
> > > > > > > It turns out that the THP-like scheme significantly slows down
> > > > > > > MADV_COLLAPSE: decrementing the mapcounts for the 4K subpages becomes
> > > > > > > the vast majority of the time spent in MADV_COLLAPSE when collapsing
> > > > > > > 1G mappings. It is doing 262k atomic decrements, so this makes sense.
> > > > > > >
> > > > > > > This is only really a problem because this is done between
> > > > > > > mmu_notifier_invalidate_range_start() and
> > > > > > > mmu_notifier_invalidate_range_end(), so KVM won't allow vCPUs to
> > > > > > > access any of the 1G page while we're doing this (and it can take like
> > > > > > > ~1 second for each 1G, at least on the x86 server I was testing on).
> > > > > >
> > > > > > Did you try to measure the time, or it's a quick observation from perf?
> > > > >
> > > > > I put some ktime_get()s in.
> > > > >
> > > > > >
> > > > > > IIRC I used to measure some atomic ops, it is not as drastic as I thought.
> > > > > > But maybe it depends on many things.
> > > > > >
> > > > > > I'm curious how the 1sec is provisioned between the procedures.  E.g., I
> > > > > > would expect mmu_notifier_invalidate_range_start() to also take some time
> > > > > > too as it should walk the smally mapped EPT pgtables.
> > > > >
> > > > > Somehow this doesn't take all that long (only like 10-30ms when
> > > > > collapsing from 4K -> 1G) compared to hugetlb_collapse().
> > > >
> > > > Did you populate as much the EPT pgtable when measuring this?
> > > >
> > > > IIUC this number should be pretty much relevant to how many pages are
> > > > shadowed to the kvm pgtables.  If the EPT table is mostly empty it should
> > > > be super fast, but OTOH it can be much slower if when it's populated,
> > > > because tdp mmu should need to handle the pgtable leaves one by one.
> > > >
> > > > E.g. it should be fully populated if you have a program busy dirtying most
> > > > of the guest pages during test migration.
> > >
> > > That's what I was doing. I was running a workload in the guest that
> > > just writes 8 bytes to a page and jumps ahead a few pages on all
> > > vCPUs, touching most of its memory.
> > >
> > > But there is more to understand; I'll collect more results. I'm not
> > > sure why the EPT can be unmapped/collapsed so quickly.
> >
> > Maybe something smart done by the hypervisor?
> 
> Doing a little bit more digging, it looks like the
> invalidate_range_start notifier clears the sptes, and then later on
> (on the next EPT violation), the page tables are freed. I still need
> to look at how they end up being so much faster still, but I thought
> that was interesting.
> 
> >
> > >
> > > >
> > > > Write op should be the worst here case since it'll require the atomic op
> > > > being applied; see kvm_tdp_mmu_write_spte().
> > > >
> > > > >
> > > > > >
> > > > > > Since we'll still keep the intermediate levels around - from application
> > > > > > POV, one other thing to remedy this is further shrink the size of COLLAPSE
> > > > > > so potentially for a very large page we can start with building 2M layers.
> > > > > > But then collapse will need to be run at least two rounds.
> > > > >
> > > > > That's exactly what I thought to do. :) I realized, too, that this is
> > > > > actually how userspace *should* collapse things to avoid holding up
> > > > > vCPUs too long. I think this is a good reason to keep intermediate
> > > > > page sizes.
> > > > >
> > > > > When collapsing 4K -> 1G, the mapcount scheme doesn't actually make a
> > > > > huge difference: the THP-like scheme is about 30% slower overall.
> > > > >
> > > > > When collapsing 4K -> 2M -> 1G, the mapcount scheme makes a HUGE
> > > > > difference. For the THP-like scheme, collapsing 4K -> 2M requires
> > > > > decrementing and then re-incrementing subpage->_mapcount, and then
> > > > > from 2M -> 1G, we have to decrement all 262k subpages->_mapcount. For
> > > > > the head-only scheme, for each 2M in the 4K -> 2M collapse, we
> > > > > decrement the compound_mapcount 512 times (once per PTE), then
> > > > > increment it once. And then for 2M -> 1G, for each 1G, we decrement
> > > > > mapcount again by 512 (once per PMD), incrementing it once.
> > > >
> > > > Did you have quantified numbers (with your ktime treak) to compare these?
> > > > If we want to go the other route, I think these will be materials to
> > > > justify any other approach on mapcount handling.
> > >
> > > Ok, I can do that. GIve me a couple days to collect more results and
> > > organize them in a helpful way.
> > >
> > > (If it's helpful at all, here are some results I collected last week:
> > > [2]. Please ignore it if it's not helpful.)
> >
> > It's helpful already at least to me, thanks.  Yes the change is drastic.
> 
> That data only contains THP-like mapcount performance, no performance
> for the head-only way. But the head-only scheme makes the 2M -> 1G
> very good ("56" comes down to about the same everything else, instead
> of being ~100-500x bigger).

Oops, I think I misread those.  Yeah please keep sharing information if you
come up with any.

> 
> >
> > >
> > > >
> > > > >
> > > > > The mapcount decrements are about on par with how long it takes to do
> > > > > other things, like updating page tables. The main problem is, with the
> > > > > THP-like scheme (implemented like this [1]), there isn't a way to
> > > > > avoid the 262k decrements when collapsing 1G. So if we want
> > > > > MADV_COLLAPSE to be fast and we want a THP-like page_mapcount() API,
> > > > > then I think something more clever needs to be implemented.
> > > > >
> > > > > [1]: https://github.com/48ca/linux/blob/hgmv2-jan24/mm/hugetlb.c#L127-L178
> > > >
> > > > I believe the whole goal of HGM is trying to face the same challenge if
> > > > we'll allow 1G THP exist and being able to split for anon.
> > > >
> > > > I don't remember whether we discussed below, maybe we did?  Anyway...
> > > >
> > > > Another way to not use thp mapcount, nor break smaps and similar calls to
> > > > page_mapcount() on small page, is to only increase the hpage mapcount only
> > > > when hstate pXd (in case of 1G it's PUD) entry being populated (no matter
> > > > as leaf or a non-leaf), and the mapcount can be decreased when the pXd
> > > > entry is removed (for leaf, it's the same as for now; for HGM, it's when
> > > > freeing pgtable of the PUD entry).
> > >
> > > Right, and this is doable. Also it seems like this is pretty close to
> > > the direction Matthew Wilcox wants to go with THPs.
> >
> > I may not be familiar with it, do you mean this one?
> >
> > https://lore.kernel.org/all/Y9Afwds%2FJl39UjEp@casper.infradead.org/
> 
> Yep that's it.
> 
> >
> > For hugetlb I think it should be easier to maintain rather than any-sized
> > folios, because there's the pgtable non-leaf entry to track rmap
> > information and the folio size being static to hpage size.
> >
> > It'll be different to folios where it can be random sized pages chunk, so
> > it needs to be managed by batching the ptes when install/zap.
> 
> Agreed. It's probably easier for HugeTLB because they're always
> "naturally aligned" and yeah they can't change sizes.
> 
> >
> > >
> > > Something I noticed though, from the implementation of
> > > folio_referenced()/folio_referenced_one(), is that folio_mapcount()
> > > ought to report the total number of PTEs that are pointing on the page
> > > (or the number of times page_vma_mapped_walk returns true). FWIW,
> > > folio_referenced() is never called for hugetlb folios.
> >
> > FWIU folio_mapcount is the thing it needs for now to do the rmap walks -
> > it'll walk every leaf page being mapped, big or small, so IIUC that number
> > should match with what it expects to see later, more or less.
> 
> I don't fully understand what you mean here.

I meant the rmap_walk pairing with folio_referenced_one() will walk all the
leaves for the folio, big or small.  I think that will match the number
with what got returned from folio_mapcount().

> 
> >
> > But I agree the mapcount/referenced value itself is debatable to me, just
> > like what you raised in the other thread on page migration.  Meanwhile, I
> > am not certain whether the mapcount is accurate either because AFAICT the
> > mapcount can be modified if e.g. new page mapping established as long as
> > before taking the page lock later in folio_referenced().
> >
> > It's just that I don't see any severe issue either due to any of above, as
> > long as that information is only used as a hint for next steps, e.g., to
> > swap which page out.
> 
> I also don't see a big problem with folio_referenced() (and you're
> right that folio_mapcount() can be stale by the time it takes the
> folio lock). It still seems like folio_mapcount() should return the
> total number of PTEs that map the page though. Are you saying that
> breaking this would be ok?

I didn't quite follow - isn't that already doing so?

folio_mapcount() is total_compound_mapcount() here, IIUC it is an
accumulated value of all possible PTEs or PMDs being mapped as long as it's
all or part of the folio being mapped.

-- 
Peter Xu

