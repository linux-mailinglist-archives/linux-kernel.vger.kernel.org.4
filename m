Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59870686B74
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 17:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbjBAQXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 11:23:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjBAQXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 11:23:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E0F6E438
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 08:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675268538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=swqZAd72U/oyplCJ36aVj+pQFkcXE/1iOSAniu5rpx8=;
        b=Dg7IJXtekGk8VM7/ySA9I+H2WYU3yzcdjRSbNyOlD/aVDqHsH9OPqJtHlQz0bqcn75X77u
        uWuUUW79JALLaRZeFb/GHjLjz6W2YsCQhGtBkc3LgZ7duQpaTJkRt0sxYs5xWrGFlwknNl
        IjyJQSOcXVsvxKDz2YOLiThKto75ECg=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-191-uWAvejsgMReo1wSAqSk4Mg-1; Wed, 01 Feb 2023 11:22:17 -0500
X-MC-Unique: uWAvejsgMReo1wSAqSk4Mg-1
Received: by mail-qv1-f72.google.com with SMTP id k15-20020a0cd68f000000b00535261af1b1so10451622qvi.13
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 08:22:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=swqZAd72U/oyplCJ36aVj+pQFkcXE/1iOSAniu5rpx8=;
        b=a3SobTjY+YIv9SPkCF5mJi8ItZ9hiF894H2L0oginNRnkxF6kJ9/yFS1dA0nGLd24i
         EFNuJwdeTWhHf7auB3uc9lHQVZAEfFKtkwlqm58y+8seFyGlcXTk2vpbvFOA6cqXCB3N
         EZ5MGxTZqT5xi1VFdTeUBAZ0jVCL6iZU828wvPYtrVZ1CVzhVoswYQgqJS+10e3b0n9W
         2XfJ4l/zGtbnaCA5xgJ4W8CQ5BRADxy5xbuPgSQ+/z/8+nRx6jzGMy1Re/PriMa57wuo
         uEs+IwgFDZ3Q2bRkQuS9JGPmzHH6dDpxvuT0rn9Qw0P+pxuAR5iofYqVwD5ryjNMNLuh
         Dijg==
X-Gm-Message-State: AO0yUKWjYSeJZUZKEsBjuNON1ug49leWiDa0WgKruC9sMdupWAYQlMYk
        aYP52lswTJfBrsJ1SAQSDHHTKFjhcSVHPfYzX5NBoAvEb/4dxSFUM73Djp1S9iefj6bcmusIjId
        pvL6DtXVCuBaUlRJGZuNCH5ce
X-Received: by 2002:ac8:7108:0:b0:3b8:6d5a:3457 with SMTP id z8-20020ac87108000000b003b86d5a3457mr4492499qto.6.1675268536179;
        Wed, 01 Feb 2023 08:22:16 -0800 (PST)
X-Google-Smtp-Source: AK7set/1xXftjAmat/Molw8aH5XW/0TWq7ykpoC05ETkysGbpnD1Ogh5/9TPafcnJv6vCSKsDOkd0g==
X-Received: by 2002:ac8:7108:0:b0:3b8:6d5a:3457 with SMTP id z8-20020ac87108000000b003b86d5a3457mr4492470qto.6.1675268535845;
        Wed, 01 Feb 2023 08:22:15 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id j20-20020ac85514000000b003b86a6449b8sm6158770qtq.85.2023.02.01.08.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 08:22:15 -0800 (PST)
Date:   Wed, 1 Feb 2023 11:22:13 -0500
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
Message-ID: <Y9qRta3bd4JqjUHx@x1n>
References: <CADrL8HVdL_NMdNq2mEemNCfwkYBAWnbqwyjsAYdQ2fF0iz34Hw@mail.gmail.com>
 <CADrL8HV92DaNm5bUwcOxsG8Lg4yLT6F13KWSbjkySPNAsgCfpA@mail.gmail.com>
 <Y9Li93O6Ffwcr+vn@x1n>
 <CADrL8HVJb9mA3Lbz5UKJ8EudTk9sGDY-pdRqvW3TGawD_bJB0A@mail.gmail.com>
 <Y9f+jMLWy6ngpYuR@x1n>
 <CADrL8HX3sf6OO3PXS1g6b2dKf8b5phQ7oyNR0dVT=sAOdTmmqw@mail.gmail.com>
 <Y9gzOqwKcu7p/PEw@x1n>
 <CADrL8HXX9YDFUxmPPsm2s3Pno0XXgAyFB40fV1PdtP9eb-5D2A@mail.gmail.com>
 <Y9m/VVRABt0Blfjh@x1n>
 <CADrL8HXpfTE1+eE3rNGQyOr1QRtDtG5mBp-b3xcNX22QJRvPaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADrL8HXpfTE1+eE3rNGQyOr1QRtDtG5mBp-b3xcNX22QJRvPaQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 07:45:17AM -0800, James Houghton wrote:
> On Tue, Jan 31, 2023 at 5:24 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Tue, Jan 31, 2023 at 04:24:15PM -0800, James Houghton wrote:
> > > On Mon, Jan 30, 2023 at 1:14 PM Peter Xu <peterx@redhat.com> wrote:
> > > >
> > > > On Mon, Jan 30, 2023 at 10:38:41AM -0800, James Houghton wrote:
> > > > > On Mon, Jan 30, 2023 at 9:29 AM Peter Xu <peterx@redhat.com> wrote:
> > > > > >
> > > > > > On Fri, Jan 27, 2023 at 01:02:02PM -0800, James Houghton wrote:
> [snip]
> > > > > > Another way to not use thp mapcount, nor break smaps and similar calls to
> > > > > > page_mapcount() on small page, is to only increase the hpage mapcount only
> > > > > > when hstate pXd (in case of 1G it's PUD) entry being populated (no matter
> > > > > > as leaf or a non-leaf), and the mapcount can be decreased when the pXd
> > > > > > entry is removed (for leaf, it's the same as for now; for HGM, it's when
> > > > > > freeing pgtable of the PUD entry).
> > > > >
> > > > > Right, and this is doable. Also it seems like this is pretty close to
> > > > > the direction Matthew Wilcox wants to go with THPs.
> > > >
> > > > I may not be familiar with it, do you mean this one?
> > > >
> > > > https://lore.kernel.org/all/Y9Afwds%2FJl39UjEp@casper.infradead.org/
> > >
> > > Yep that's it.
> > >
> > > >
> > > > For hugetlb I think it should be easier to maintain rather than any-sized
> > > > folios, because there's the pgtable non-leaf entry to track rmap
> > > > information and the folio size being static to hpage size.
> > > >
> > > > It'll be different to folios where it can be random sized pages chunk, so
> > > > it needs to be managed by batching the ptes when install/zap.
> > >
> > > Agreed. It's probably easier for HugeTLB because they're always
> > > "naturally aligned" and yeah they can't change sizes.
> > >
> > > >
> > > > >
> > > > > Something I noticed though, from the implementation of
> > > > > folio_referenced()/folio_referenced_one(), is that folio_mapcount()
> > > > > ought to report the total number of PTEs that are pointing on the page
> > > > > (or the number of times page_vma_mapped_walk returns true). FWIW,
> > > > > folio_referenced() is never called for hugetlb folios.
> > > >
> > > > FWIU folio_mapcount is the thing it needs for now to do the rmap walks -
> > > > it'll walk every leaf page being mapped, big or small, so IIUC that number
> > > > should match with what it expects to see later, more or less.
> > >
> > > I don't fully understand what you mean here.
> >
> > I meant the rmap_walk pairing with folio_referenced_one() will walk all the
> > leaves for the folio, big or small.  I think that will match the number
> > with what got returned from folio_mapcount().
> 
> See below.
> 
> >
> > >
> > > >
> > > > But I agree the mapcount/referenced value itself is debatable to me, just
> > > > like what you raised in the other thread on page migration.  Meanwhile, I
> > > > am not certain whether the mapcount is accurate either because AFAICT the
> > > > mapcount can be modified if e.g. new page mapping established as long as
> > > > before taking the page lock later in folio_referenced().
> > > >
> > > > It's just that I don't see any severe issue either due to any of above, as
> > > > long as that information is only used as a hint for next steps, e.g., to
> > > > swap which page out.
> > >
> > > I also don't see a big problem with folio_referenced() (and you're
> > > right that folio_mapcount() can be stale by the time it takes the
> > > folio lock). It still seems like folio_mapcount() should return the
> > > total number of PTEs that map the page though. Are you saying that
> > > breaking this would be ok?
> >
> > I didn't quite follow - isn't that already doing so?
> >
> > folio_mapcount() is total_compound_mapcount() here, IIUC it is an
> > accumulated value of all possible PTEs or PMDs being mapped as long as it's
> > all or part of the folio being mapped.
> 
> We've talked about 3 ways of handling mapcount:
> 
> 1. The RFC v2 way, which is head-only, and we increment the compound
> mapcount for each PT mapping we have. So a PTE-mapped 2M page,
> compound_mapcount=512, subpage->_mapcount=0 (ignoring the -1 bias).
> 2. The THP-like way. If we are fully mapping the hugetlb page with the
> hstate-level PTE, we increment the compound mapcount, otherwise we
> increment subpage->_mapcount.
> 3. The RFC v1 way (the way you have suggested above), which is
> head-only, and we increment the compound mapcount if the hstate-level
> PTE is made present.

Oh that's where it come from!  It took quite some months going through all
these, I can hardly remember the details.

> 
> With #1 and #2, there is no concern with folio_mapcount(). But with
> #3, folio_mapcount() for a PTE-mapped 2M page mapped in a single VMA
> would yield 1 instead of 512 (right?). That's what I mean.
> 
> #1 has problems wrt smaps and migration (though there were other
> problems with those anyway that Mike has fixed), and #2 makes
> MADV_COLLAPSE slow to the point of being unusable for some
> applications.

Ah so you're talking about after HGM being applied..  while I was only
talking about THPs.

If to apply the logic here with idea 3), the worst case is we'll need to
have special care of HGM hugetlb in folio_referenced_one(), so the default
page_vma_mapped_walk() may not apply anymore - the resource is always in
hstate sized, so counting small ptes do not help too - we can just walk
until the hstate entry and do referenced++ if it's not none, at the
entrance of folio_referenced_one().

But I'm not sure whether that'll be necessary at all, as I'm not sure
whether that path can be triggered at all in any form (where from the top
it should always be shrink_page_list()).  In that sense maybe we can also
consider adding a WARN_ON_ONCE() in folio_referenced() where it is a
hugetlb page that got passed in?  Meanwhile, adding a TODO comment
explaining that current walk won't work easily for HGM only, so when it
will be applicable to hugetlb we need to rework?

I confess that's not pretty, though.  But that'll make 3) with no major
defect from function-wise.

Side note: did we finish folio conversion on hugetlb at all?  I think at
least we need some helper like folio_test_huge().  It seems still missing.
Maybe it's another clue that hugetlb is not important to folio_referenced()
because it's already fully converted?

> 
> It seems like the least bad option is #1, but maybe we should have a
> face-to-face discussion about it? I'm still collecting some more
> performance numbers.

Let's see how it goes..

Thanks,

-- 
Peter Xu

