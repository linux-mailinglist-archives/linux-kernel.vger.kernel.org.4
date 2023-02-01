Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57F06870BA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 22:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbjBAVwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 16:52:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjBAVwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 16:52:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B0D86BF
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 13:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675288312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9t9k8aWRK4blC4OqTHddYSdS2T+jZZbO6udhmg2isMM=;
        b=g4rInfFS+AqP2gwiEvhtBSs/JAEwF6+prFTqnNuGKVcJM5N/oQh0ETD0dCSEI7WdelMx31
        t5n6juNemLU7OSrd+G/tXS8BqKjymjneF9NgifQboF0DvyHbhw34/0miz5eRa285G0NOLZ
        /mP95k5I4mE/J2Wp9OsFYaAP3eGqNjI=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-443-zSM622yxNXK76LH0JxMogQ-1; Wed, 01 Feb 2023 16:51:51 -0500
X-MC-Unique: zSM622yxNXK76LH0JxMogQ-1
Received: by mail-qt1-f200.google.com with SMTP id cd3-20020a05622a418300b003b9bd2a2284so1177942qtb.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 13:51:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9t9k8aWRK4blC4OqTHddYSdS2T+jZZbO6udhmg2isMM=;
        b=KxS83g5wuOkoML9mgExrYGsNy20PxV99eUXm1/feHZggpP+iejf1eaY/2zB1z0VIqX
         HuKm+hKQQurujtNdIPmcqP/AfB0eWo+gVPOQo1PEjzTq86i/XOiavE0/wFGagQ+a4f5S
         Bp5PYjeihmBFSpPNmHVyWmH2uqGcgbIHzFd1DXaw6MSLemHg9KZpfaSlMsbNZxl/bU+K
         Y3KG7OamL5b5wYEER9ipsWtAQ7FI8J4w9lGwnW8hKLiMCg7AtdLtFgdOGzW7x7adU9Zs
         07uLE24Lv+7QoyLwiH3VA1qUk5vpLh/GFI4d/jT9tN1cFEwSsuS0Alb+HUbvRiCdpp5Z
         bNpA==
X-Gm-Message-State: AO0yUKVM4TijqLEneTuMzbmZJNQ+eSGYzP8R7FYrUPnhp7R/52SnEb45
        hPyGkiq1uw4Dz+IqCN3eHrmlBuK7eg3HJyOjyGrK+zl7NMyjhEyMlTvbDG7SAr736QwUGyT5u0c
        jWHuHNdnwksUxkSDGzSoYzdwx
X-Received: by 2002:a05:622a:24f:b0:3b8:689c:a8aa with SMTP id c15-20020a05622a024f00b003b8689ca8aamr8144773qtx.1.1675288310795;
        Wed, 01 Feb 2023 13:51:50 -0800 (PST)
X-Google-Smtp-Source: AK7set+OIfzWlm0+FMHVWN4+GwMyYNkF7LLX+N22hWr+F2wGHDdP5cHtmVTqzTdy6vA2l6Ex3wSUlg==
X-Received: by 2002:a05:622a:24f:b0:3b8:689c:a8aa with SMTP id c15-20020a05622a024f00b003b8689ca8aamr8144720qtx.1.1675288310446;
        Wed, 01 Feb 2023 13:51:50 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id eb10-20020a05620a480a00b0071323d3e37fsm12656413qkb.133.2023.02.01.13.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 13:51:48 -0800 (PST)
Date:   Wed, 1 Feb 2023 16:51:47 -0500
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
Message-ID: <Y9re82gctIZf08cX@x1n>
References: <Y9Li93O6Ffwcr+vn@x1n>
 <CADrL8HVJb9mA3Lbz5UKJ8EudTk9sGDY-pdRqvW3TGawD_bJB0A@mail.gmail.com>
 <Y9f+jMLWy6ngpYuR@x1n>
 <CADrL8HX3sf6OO3PXS1g6b2dKf8b5phQ7oyNR0dVT=sAOdTmmqw@mail.gmail.com>
 <Y9gzOqwKcu7p/PEw@x1n>
 <CADrL8HXX9YDFUxmPPsm2s3Pno0XXgAyFB40fV1PdtP9eb-5D2A@mail.gmail.com>
 <Y9m/VVRABt0Blfjh@x1n>
 <CADrL8HXpfTE1+eE3rNGQyOr1QRtDtG5mBp-b3xcNX22QJRvPaQ@mail.gmail.com>
 <Y9qRta3bd4JqjUHx@x1n>
 <CADrL8HU809O0cPa9hXjf3k+ob139SQqvxOvpqm6UEv=zrPjHSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADrL8HU809O0cPa9hXjf3k+ob139SQqvxOvpqm6UEv=zrPjHSg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 01:32:21PM -0800, James Houghton wrote:
> On Wed, Feb 1, 2023 at 8:22 AM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Wed, Feb 01, 2023 at 07:45:17AM -0800, James Houghton wrote:
> > > On Tue, Jan 31, 2023 at 5:24 PM Peter Xu <peterx@redhat.com> wrote:
> > > >
> > > > On Tue, Jan 31, 2023 at 04:24:15PM -0800, James Houghton wrote:
> > > > > On Mon, Jan 30, 2023 at 1:14 PM Peter Xu <peterx@redhat.com> wrote:
> > > > > >
> > > > > > On Mon, Jan 30, 2023 at 10:38:41AM -0800, James Houghton wrote:
> > > > > > > On Mon, Jan 30, 2023 at 9:29 AM Peter Xu <peterx@redhat.com> wrote:
> > > > > > > >
> > > > > > > > On Fri, Jan 27, 2023 at 01:02:02PM -0800, James Houghton wrote:
> > > [snip]
> > > > > > > > Another way to not use thp mapcount, nor break smaps and similar calls to
> > > > > > > > page_mapcount() on small page, is to only increase the hpage mapcount only
> > > > > > > > when hstate pXd (in case of 1G it's PUD) entry being populated (no matter
> > > > > > > > as leaf or a non-leaf), and the mapcount can be decreased when the pXd
> > > > > > > > entry is removed (for leaf, it's the same as for now; for HGM, it's when
> > > > > > > > freeing pgtable of the PUD entry).
> > > > > > >
> > > > > > > Right, and this is doable. Also it seems like this is pretty close to
> > > > > > > the direction Matthew Wilcox wants to go with THPs.
> > > > > >
> > > > > > I may not be familiar with it, do you mean this one?
> > > > > >
> > > > > > https://lore.kernel.org/all/Y9Afwds%2FJl39UjEp@casper.infradead.org/
> > > > >
> > > > > Yep that's it.
> > > > >
> > > > > >
> > > > > > For hugetlb I think it should be easier to maintain rather than any-sized
> > > > > > folios, because there's the pgtable non-leaf entry to track rmap
> > > > > > information and the folio size being static to hpage size.
> > > > > >
> > > > > > It'll be different to folios where it can be random sized pages chunk, so
> > > > > > it needs to be managed by batching the ptes when install/zap.
> > > > >
> > > > > Agreed. It's probably easier for HugeTLB because they're always
> > > > > "naturally aligned" and yeah they can't change sizes.
> > > > >
> > > > > >
> > > > > > >
> > > > > > > Something I noticed though, from the implementation of
> > > > > > > folio_referenced()/folio_referenced_one(), is that folio_mapcount()
> > > > > > > ought to report the total number of PTEs that are pointing on the page
> > > > > > > (or the number of times page_vma_mapped_walk returns true). FWIW,
> > > > > > > folio_referenced() is never called for hugetlb folios.
> > > > > >
> > > > > > FWIU folio_mapcount is the thing it needs for now to do the rmap walks -
> > > > > > it'll walk every leaf page being mapped, big or small, so IIUC that number
> > > > > > should match with what it expects to see later, more or less.
> > > > >
> > > > > I don't fully understand what you mean here.
> > > >
> > > > I meant the rmap_walk pairing with folio_referenced_one() will walk all the
> > > > leaves for the folio, big or small.  I think that will match the number
> > > > with what got returned from folio_mapcount().
> > >
> > > See below.
> > >
> > > >
> > > > >
> > > > > >
> > > > > > But I agree the mapcount/referenced value itself is debatable to me, just
> > > > > > like what you raised in the other thread on page migration.  Meanwhile, I
> > > > > > am not certain whether the mapcount is accurate either because AFAICT the
> > > > > > mapcount can be modified if e.g. new page mapping established as long as
> > > > > > before taking the page lock later in folio_referenced().
> > > > > >
> > > > > > It's just that I don't see any severe issue either due to any of above, as
> > > > > > long as that information is only used as a hint for next steps, e.g., to
> > > > > > swap which page out.
> > > > >
> > > > > I also don't see a big problem with folio_referenced() (and you're
> > > > > right that folio_mapcount() can be stale by the time it takes the
> > > > > folio lock). It still seems like folio_mapcount() should return the
> > > > > total number of PTEs that map the page though. Are you saying that
> > > > > breaking this would be ok?
> > > >
> > > > I didn't quite follow - isn't that already doing so?
> > > >
> > > > folio_mapcount() is total_compound_mapcount() here, IIUC it is an
> > > > accumulated value of all possible PTEs or PMDs being mapped as long as it's
> > > > all or part of the folio being mapped.
> > >
> > > We've talked about 3 ways of handling mapcount:
> > >
> > > 1. The RFC v2 way, which is head-only, and we increment the compound
> > > mapcount for each PT mapping we have. So a PTE-mapped 2M page,
> > > compound_mapcount=512, subpage->_mapcount=0 (ignoring the -1 bias).
> > > 2. The THP-like way. If we are fully mapping the hugetlb page with the
> > > hstate-level PTE, we increment the compound mapcount, otherwise we
> > > increment subpage->_mapcount.
> > > 3. The RFC v1 way (the way you have suggested above), which is
> > > head-only, and we increment the compound mapcount if the hstate-level
> > > PTE is made present.
> >
> > Oh that's where it come from!  It took quite some months going through all
> > these, I can hardly remember the details.
> >
> > >
> > > With #1 and #2, there is no concern with folio_mapcount(). But with
> > > #3, folio_mapcount() for a PTE-mapped 2M page mapped in a single VMA
> > > would yield 1 instead of 512 (right?). That's what I mean.
> > >
> > > #1 has problems wrt smaps and migration (though there were other
> > > problems with those anyway that Mike has fixed), and #2 makes
> > > MADV_COLLAPSE slow to the point of being unusable for some
> > > applications.
> >
> > Ah so you're talking about after HGM being applied..  while I was only
> > talking about THPs.
> >
> > If to apply the logic here with idea 3), the worst case is we'll need to
> > have special care of HGM hugetlb in folio_referenced_one(), so the default
> > page_vma_mapped_walk() may not apply anymore - the resource is always in
> > hstate sized, so counting small ptes do not help too - we can just walk
> > until the hstate entry and do referenced++ if it's not none, at the
> > entrance of folio_referenced_one().
> >
> > But I'm not sure whether that'll be necessary at all, as I'm not sure
> > whether that path can be triggered at all in any form (where from the top
> > it should always be shrink_page_list()).  In that sense maybe we can also
> > consider adding a WARN_ON_ONCE() in folio_referenced() where it is a
> > hugetlb page that got passed in?  Meanwhile, adding a TODO comment
> > explaining that current walk won't work easily for HGM only, so when it
> > will be applicable to hugetlb we need to rework?
> >
> > I confess that's not pretty, though.  But that'll make 3) with no major
> > defect from function-wise.
> 
> Another potential idea would be to add something like page_vmacount().
> For non-HugeTLB pages, page_vmacount() == page_mapcount(). Then for
> HugeTLB pages, we could keep a separate count (in one of the tail
> pages, I guess). And then in the places that matter (so smaps,
> migration, and maybe CoW and hwpoison), potentially change their calls
> to page_vmacount() instead of page_mapcount().
> 
> Then to implement page_vmacount(), we do the RFC v1 mapcount approach
> (but like.... correctly this time). And then for page_mapcount(), we
> do the RFC v2 mapcount approach (head-only, once per PTE).
> 
> Then we fix folio_referenced() without needing to special-case it for
> HugeTLB. :) Or we could just special-case it. *shrug*
> 
> Does that sound reasonable? We still have the problem where a series
> of partially unmaps could leave page_vmacount() incremented, but I
> don't think that's a big problem.

I'm afraid someone will stop you from introducing yet another definition of
mapcount, where others are trying to remove it. :)

Or, can we just drop folio_referenced_arg.mapcount?  We need to keep:

	if (!pra.mapcount)
		return 0;

By replacing it with folio_mapcount which is definitely something
worthwhile, but what about the rest?

If it can be dropped, afaict it'll naturally work with HGM again.

IIUC that's an optimization where we want to stop the rmap walk as long as
we found all the pages, however (1) IIUC it's not required to function, and
(2) it's not guaranteed to work as solid anyway.. As we've discussed
before: right after it reads mapcount (but before taking the page lock),
the mapcount can get decreased by 1, then it'll still need to loop over all
the vmas just to find that there's one "misterious" mapcount lost.

Personally I really have no idea on how much that optimization can help.

-- 
Peter Xu

