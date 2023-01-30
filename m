Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7F9681799
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 18:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237384AbjA3Ram (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 12:30:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233899AbjA3Ral (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 12:30:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67046EB50
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 09:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675099793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Nzvbz1NKqVKi+abl4WsC/QDWi63/0y+DCA+e8z5/qGM=;
        b=KnJEW4ghiXZVn5zGAKdWTiWJForGQO/GlQfvak/by6A5epWoXBNh8JWPIoelBkWlJlaTJB
        /3ShZkNGU64vyHu5uYQ36IDHO/GAR9AIeau4tm+P7gEkt3w+J/jru1q6SWT6/AjWg3o3Js
        KbfRY8d0HQbXHU8C3BCcqiwAbN+W0y0=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-615-zVbWx3MGPq6qPtFvECKM0A-1; Mon, 30 Jan 2023 12:29:52 -0500
X-MC-Unique: zVbWx3MGPq6qPtFvECKM0A-1
Received: by mail-qt1-f197.google.com with SMTP id s4-20020ac85284000000b003b849aa2cd6so2236735qtn.15
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 09:29:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nzvbz1NKqVKi+abl4WsC/QDWi63/0y+DCA+e8z5/qGM=;
        b=8K6q4BakrrRHUWtsPKfkl14XxsauK5sWskaHIJW4p0bwbWFh7Qeu0QyhCgybXUBivD
         RWjhXgoK2M+aI/z9jDfK5nRO88KaPdRCxW3yYXExFaRefRlzykYb/RE7/iX4Hq/aurbK
         4xUhRIn8RzbYfEbD+C5r7G3oham+RvzUV4qHNIFkWBjvm84mMZwi+AsYy/AOpqveiGn4
         hCLVGfVlsvcsrE0q4U8v0BsEGQdhIZVKDsrV83NblnNdkQIXwHqGd9VFge9jpTRED1F8
         3f6IRur7NY+1BaWPRDZxtjv8OfgrnFb3pzcYhayEcdLse6SUGGKSZ3kBIVPxXs25PepP
         S+xw==
X-Gm-Message-State: AO0yUKUiE2Ar1b4fZ6JYidMFNtBk0FQZ5R6e1mdngA8kTptgQcoEcLH/
        99+lvmx8wUvvl7zLHRVOW4X5FCLX64DRhRr0nDEWnwdJbZIrcXVDhmstlW2yHQ58LO9G2qCRhWl
        ksFjDfsuxZXiQe9XyatKsPezc
X-Received: by 2002:ac8:5bd2:0:b0:3b8:4076:1de0 with SMTP id b18-20020ac85bd2000000b003b840761de0mr13639872qtb.30.1675099791435;
        Mon, 30 Jan 2023 09:29:51 -0800 (PST)
X-Google-Smtp-Source: AK7set+2k1hXS0q2E9rprxORf4uJTTuCIK9G6nx/z6sdk9pilq7T9/w6Og994AzOiSeu29hB4FEwDA==
X-Received: by 2002:ac8:5bd2:0:b0:3b8:4076:1de0 with SMTP id b18-20020ac85bd2000000b003b840761de0mr13639829qtb.30.1675099791120;
        Mon, 30 Jan 2023 09:29:51 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id u17-20020ac83d51000000b003b82a07c4d6sm6122247qtf.84.2023.01.30.09.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 09:29:50 -0800 (PST)
Date:   Mon, 30 Jan 2023 12:29:48 -0500
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
Message-ID: <Y9f+jMLWy6ngpYuR@x1n>
References: <6548b3b3-30c9-8f64-7d28-8a434e0a0b80@redhat.com>
 <Y8gRpEonhXgqfb41@x1n>
 <CADrL8HVGMTowH4trJhS+eM_EwZKoUgu7LmfwyTGyGRnNnwL3Zg@mail.gmail.com>
 <Y8hITxr/BBMuO6WX@monkey>
 <CADrL8HUggALQET-09Zw3BhFjZdw_G9+v6CU=qtGtK=KZ_DeAsw@mail.gmail.com>
 <Y8l+f2wNp2gAjvYg@monkey>
 <CADrL8HVdL_NMdNq2mEemNCfwkYBAWnbqwyjsAYdQ2fF0iz34Hw@mail.gmail.com>
 <CADrL8HV92DaNm5bUwcOxsG8Lg4yLT6F13KWSbjkySPNAsgCfpA@mail.gmail.com>
 <Y9Li93O6Ffwcr+vn@x1n>
 <CADrL8HVJb9mA3Lbz5UKJ8EudTk9sGDY-pdRqvW3TGawD_bJB0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADrL8HVJb9mA3Lbz5UKJ8EudTk9sGDY-pdRqvW3TGawD_bJB0A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 01:02:02PM -0800, James Houghton wrote:
> On Thu, Jan 26, 2023 at 12:31 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > James,
> >
> > On Thu, Jan 26, 2023 at 08:58:51AM -0800, James Houghton wrote:
> > > It turns out that the THP-like scheme significantly slows down
> > > MADV_COLLAPSE: decrementing the mapcounts for the 4K subpages becomes
> > > the vast majority of the time spent in MADV_COLLAPSE when collapsing
> > > 1G mappings. It is doing 262k atomic decrements, so this makes sense.
> > >
> > > This is only really a problem because this is done between
> > > mmu_notifier_invalidate_range_start() and
> > > mmu_notifier_invalidate_range_end(), so KVM won't allow vCPUs to
> > > access any of the 1G page while we're doing this (and it can take like
> > > ~1 second for each 1G, at least on the x86 server I was testing on).
> >
> > Did you try to measure the time, or it's a quick observation from perf?
> 
> I put some ktime_get()s in.
> 
> >
> > IIRC I used to measure some atomic ops, it is not as drastic as I thought.
> > But maybe it depends on many things.
> >
> > I'm curious how the 1sec is provisioned between the procedures.  E.g., I
> > would expect mmu_notifier_invalidate_range_start() to also take some time
> > too as it should walk the smally mapped EPT pgtables.
> 
> Somehow this doesn't take all that long (only like 10-30ms when
> collapsing from 4K -> 1G) compared to hugetlb_collapse().

Did you populate as much the EPT pgtable when measuring this?

IIUC this number should be pretty much relevant to how many pages are
shadowed to the kvm pgtables.  If the EPT table is mostly empty it should
be super fast, but OTOH it can be much slower if when it's populated,
because tdp mmu should need to handle the pgtable leaves one by one.

E.g. it should be fully populated if you have a program busy dirtying most
of the guest pages during test migration.

Write op should be the worst here case since it'll require the atomic op
being applied; see kvm_tdp_mmu_write_spte().

> 
> >
> > Since we'll still keep the intermediate levels around - from application
> > POV, one other thing to remedy this is further shrink the size of COLLAPSE
> > so potentially for a very large page we can start with building 2M layers.
> > But then collapse will need to be run at least two rounds.
> 
> That's exactly what I thought to do. :) I realized, too, that this is
> actually how userspace *should* collapse things to avoid holding up
> vCPUs too long. I think this is a good reason to keep intermediate
> page sizes.
> 
> When collapsing 4K -> 1G, the mapcount scheme doesn't actually make a
> huge difference: the THP-like scheme is about 30% slower overall.
> 
> When collapsing 4K -> 2M -> 1G, the mapcount scheme makes a HUGE
> difference. For the THP-like scheme, collapsing 4K -> 2M requires
> decrementing and then re-incrementing subpage->_mapcount, and then
> from 2M -> 1G, we have to decrement all 262k subpages->_mapcount. For
> the head-only scheme, for each 2M in the 4K -> 2M collapse, we
> decrement the compound_mapcount 512 times (once per PTE), then
> increment it once. And then for 2M -> 1G, for each 1G, we decrement
> mapcount again by 512 (once per PMD), incrementing it once.

Did you have quantified numbers (with your ktime treak) to compare these?
If we want to go the other route, I think these will be materials to
justify any other approach on mapcount handling.

> 
> The mapcount decrements are about on par with how long it takes to do
> other things, like updating page tables. The main problem is, with the
> THP-like scheme (implemented like this [1]), there isn't a way to
> avoid the 262k decrements when collapsing 1G. So if we want
> MADV_COLLAPSE to be fast and we want a THP-like page_mapcount() API,
> then I think something more clever needs to be implemented.
> 
> [1]: https://github.com/48ca/linux/blob/hgmv2-jan24/mm/hugetlb.c#L127-L178

I believe the whole goal of HGM is trying to face the same challenge if
we'll allow 1G THP exist and being able to split for anon.

I don't remember whether we discussed below, maybe we did?  Anyway...

Another way to not use thp mapcount, nor break smaps and similar calls to
page_mapcount() on small page, is to only increase the hpage mapcount only
when hstate pXd (in case of 1G it's PUD) entry being populated (no matter
as leaf or a non-leaf), and the mapcount can be decreased when the pXd
entry is removed (for leaf, it's the same as for now; for HGM, it's when
freeing pgtable of the PUD entry).

Again, in all cases I think some solid measurements would definitely be
helpful (as commented above) to see how much overhead will there be and
whether that'll start to become a problem at least for the current
motivations of the whole HGM idea.

Thanks,

-- 
Peter Xu

