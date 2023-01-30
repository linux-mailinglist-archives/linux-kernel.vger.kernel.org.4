Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F46C681982
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 19:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238298AbjA3SkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 13:40:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238373AbjA3Sjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 13:39:48 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBF02BF16
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 10:39:19 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id o36so2661025wms.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 10:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LPGS2Yo2yPpvShBA+iBIo7QSW0BY3Idei/j1IjlrSi4=;
        b=RMxQ1RxNtqjpJ146aUokuJY0Jr8rXiFoIpvSwT6QP6fINoSvqZtMpvm1hLUWWcBz1m
         1lE9Q1vru62/iHuWPzeo+o06xf4mQY5DBrJtCDhIz7VbFc7ihOdqiIyyIB0SrqkWi4KM
         mwThWB/kf7nvZWogDuxw4QAhO2BRYDBtcb6FLMcCbknHqj9bg88oEnR/1pKTTDEWQnAS
         2JlZYniJQLwffDR8mVghNHfAs6k+8EdeubkEeQ/CaQyOk+sf6B0WEiF80sCESHxkUvbg
         Q1sWDTe6VQh9pOo848bZmL/335PBUdemeuGZMHgSD4Gb6Q0J+3tyc5VrWqiWHh+OBtBQ
         Iqcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LPGS2Yo2yPpvShBA+iBIo7QSW0BY3Idei/j1IjlrSi4=;
        b=0/6P5CXeQ4Q9euwONX6c6c6sSJgJ2YTiO9bjuqA7G+vzFTlpCL3knXGX57btXEYb3E
         iPq2zFobwlVhBC7CcYjJtnq4lAdGJd/9DGuG79LNMFIPLA/oq+XX+qkJYlrB2w9SNgPC
         SYMvAsCgEWrv2a9ty6NRohxceu5JrfsmlEACxIWzL7/ULmI55V03zLz9DS0oc1a7D/DJ
         nmNzDNa+yhlBEQehtq3/hkPCqnA57V6yOR7tuDNBn+Tt2optSabm/ZuHPkhPi4LWdCE2
         sV284Kp+h9cAL+WtF3NO6o6kW1rD0+Cf5qxPG8EnBkSHPgyw00jGGh5kRTiuRrq7OF5Q
         d8kg==
X-Gm-Message-State: AFqh2kqVuB4YuISliCF7+qfcaKaUusSDjdJwGi59akSU4SO9n3DJil7M
        3RRx8qx9iNCe052ia0Ffs262KzOKD9XQcP7P/RBbNQ==
X-Google-Smtp-Source: AMrXdXvfZrTHu9fiXb6texc9gDHVRBjo2zZ1t485I6dpScbICkrtqErZWB9zrvoq7PkBDRcVScmHEg/2xicob5Spa1o=
X-Received: by 2002:a05:600c:3583:b0:3da:221b:fc1f with SMTP id
 p3-20020a05600c358300b003da221bfc1fmr3065431wmq.175.1675103957799; Mon, 30
 Jan 2023 10:39:17 -0800 (PST)
MIME-Version: 1.0
References: <6548b3b3-30c9-8f64-7d28-8a434e0a0b80@redhat.com>
 <Y8gRpEonhXgqfb41@x1n> <CADrL8HVGMTowH4trJhS+eM_EwZKoUgu7LmfwyTGyGRnNnwL3Zg@mail.gmail.com>
 <Y8hITxr/BBMuO6WX@monkey> <CADrL8HUggALQET-09Zw3BhFjZdw_G9+v6CU=qtGtK=KZ_DeAsw@mail.gmail.com>
 <Y8l+f2wNp2gAjvYg@monkey> <CADrL8HVdL_NMdNq2mEemNCfwkYBAWnbqwyjsAYdQ2fF0iz34Hw@mail.gmail.com>
 <CADrL8HV92DaNm5bUwcOxsG8Lg4yLT6F13KWSbjkySPNAsgCfpA@mail.gmail.com>
 <Y9Li93O6Ffwcr+vn@x1n> <CADrL8HVJb9mA3Lbz5UKJ8EudTk9sGDY-pdRqvW3TGawD_bJB0A@mail.gmail.com>
 <Y9f+jMLWy6ngpYuR@x1n>
In-Reply-To: <Y9f+jMLWy6ngpYuR@x1n>
From:   James Houghton <jthoughton@google.com>
Date:   Mon, 30 Jan 2023 10:38:41 -0800
Message-ID: <CADrL8HX3sf6OO3PXS1g6b2dKf8b5phQ7oyNR0dVT=sAOdTmmqw@mail.gmail.com>
Subject: Re: [PATCH 21/46] hugetlb: use struct hugetlb_pte for walk_hugetlb_range
To:     Peter Xu <peterx@redhat.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        "Zach O'Keefe" <zokeefe@google.com>,
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
Content-Type: text/plain; charset="UTF-8"
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

On Mon, Jan 30, 2023 at 9:29 AM Peter Xu <peterx@redhat.com> wrote:
>
> On Fri, Jan 27, 2023 at 01:02:02PM -0800, James Houghton wrote:
> > On Thu, Jan 26, 2023 at 12:31 PM Peter Xu <peterx@redhat.com> wrote:
> > >
> > > James,
> > >
> > > On Thu, Jan 26, 2023 at 08:58:51AM -0800, James Houghton wrote:
> > > > It turns out that the THP-like scheme significantly slows down
> > > > MADV_COLLAPSE: decrementing the mapcounts for the 4K subpages becomes
> > > > the vast majority of the time spent in MADV_COLLAPSE when collapsing
> > > > 1G mappings. It is doing 262k atomic decrements, so this makes sense.
> > > >
> > > > This is only really a problem because this is done between
> > > > mmu_notifier_invalidate_range_start() and
> > > > mmu_notifier_invalidate_range_end(), so KVM won't allow vCPUs to
> > > > access any of the 1G page while we're doing this (and it can take like
> > > > ~1 second for each 1G, at least on the x86 server I was testing on).
> > >
> > > Did you try to measure the time, or it's a quick observation from perf?
> >
> > I put some ktime_get()s in.
> >
> > >
> > > IIRC I used to measure some atomic ops, it is not as drastic as I thought.
> > > But maybe it depends on many things.
> > >
> > > I'm curious how the 1sec is provisioned between the procedures.  E.g., I
> > > would expect mmu_notifier_invalidate_range_start() to also take some time
> > > too as it should walk the smally mapped EPT pgtables.
> >
> > Somehow this doesn't take all that long (only like 10-30ms when
> > collapsing from 4K -> 1G) compared to hugetlb_collapse().
>
> Did you populate as much the EPT pgtable when measuring this?
>
> IIUC this number should be pretty much relevant to how many pages are
> shadowed to the kvm pgtables.  If the EPT table is mostly empty it should
> be super fast, but OTOH it can be much slower if when it's populated,
> because tdp mmu should need to handle the pgtable leaves one by one.
>
> E.g. it should be fully populated if you have a program busy dirtying most
> of the guest pages during test migration.

That's what I was doing. I was running a workload in the guest that
just writes 8 bytes to a page and jumps ahead a few pages on all
vCPUs, touching most of its memory.

But there is more to understand; I'll collect more results. I'm not
sure why the EPT can be unmapped/collapsed so quickly.

>
> Write op should be the worst here case since it'll require the atomic op
> being applied; see kvm_tdp_mmu_write_spte().
>
> >
> > >
> > > Since we'll still keep the intermediate levels around - from application
> > > POV, one other thing to remedy this is further shrink the size of COLLAPSE
> > > so potentially for a very large page we can start with building 2M layers.
> > > But then collapse will need to be run at least two rounds.
> >
> > That's exactly what I thought to do. :) I realized, too, that this is
> > actually how userspace *should* collapse things to avoid holding up
> > vCPUs too long. I think this is a good reason to keep intermediate
> > page sizes.
> >
> > When collapsing 4K -> 1G, the mapcount scheme doesn't actually make a
> > huge difference: the THP-like scheme is about 30% slower overall.
> >
> > When collapsing 4K -> 2M -> 1G, the mapcount scheme makes a HUGE
> > difference. For the THP-like scheme, collapsing 4K -> 2M requires
> > decrementing and then re-incrementing subpage->_mapcount, and then
> > from 2M -> 1G, we have to decrement all 262k subpages->_mapcount. For
> > the head-only scheme, for each 2M in the 4K -> 2M collapse, we
> > decrement the compound_mapcount 512 times (once per PTE), then
> > increment it once. And then for 2M -> 1G, for each 1G, we decrement
> > mapcount again by 512 (once per PMD), incrementing it once.
>
> Did you have quantified numbers (with your ktime treak) to compare these?
> If we want to go the other route, I think these will be materials to
> justify any other approach on mapcount handling.

Ok, I can do that. GIve me a couple days to collect more results and
organize them in a helpful way.

(If it's helpful at all, here are some results I collected last week:
[2]. Please ignore it if it's not helpful.)

>
> >
> > The mapcount decrements are about on par with how long it takes to do
> > other things, like updating page tables. The main problem is, with the
> > THP-like scheme (implemented like this [1]), there isn't a way to
> > avoid the 262k decrements when collapsing 1G. So if we want
> > MADV_COLLAPSE to be fast and we want a THP-like page_mapcount() API,
> > then I think something more clever needs to be implemented.
> >
> > [1]: https://github.com/48ca/linux/blob/hgmv2-jan24/mm/hugetlb.c#L127-L178
>
> I believe the whole goal of HGM is trying to face the same challenge if
> we'll allow 1G THP exist and being able to split for anon.
>
> I don't remember whether we discussed below, maybe we did?  Anyway...
>
> Another way to not use thp mapcount, nor break smaps and similar calls to
> page_mapcount() on small page, is to only increase the hpage mapcount only
> when hstate pXd (in case of 1G it's PUD) entry being populated (no matter
> as leaf or a non-leaf), and the mapcount can be decreased when the pXd
> entry is removed (for leaf, it's the same as for now; for HGM, it's when
> freeing pgtable of the PUD entry).

Right, and this is doable. Also it seems like this is pretty close to
the direction Matthew Wilcox wants to go with THPs.

Something I noticed though, from the implementation of
folio_referenced()/folio_referenced_one(), is that folio_mapcount()
ought to report the total number of PTEs that are pointing on the page
(or the number of times page_vma_mapped_walk returns true). FWIW,
folio_referenced() is never called for hugetlb folios.

>
> Again, in all cases I think some solid measurements would definitely be
> helpful (as commented above) to see how much overhead will there be and
> whether that'll start to become a problem at least for the current
> motivations of the whole HGM idea.
>
> Thanks,
>
> --
> Peter Xu
>

Thanks, Peter!

[2]: https://pastebin.com/raw/DVfNFi2m

- James
