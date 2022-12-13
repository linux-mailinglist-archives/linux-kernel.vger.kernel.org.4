Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665FF64BDDE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 21:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237596AbiLMUWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 15:22:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236745AbiLMUVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 15:21:54 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA0C2791D
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 12:18:55 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id h16so8012627wrz.12
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 12:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DdPGwnHVcPtYyMt3MrhvxEjvQ4s6Eib4j5KCNAxoOwA=;
        b=qsFxQFry5mILcXIT4Bd2F6nDdAxJNxOjfwc1/g5uw8BwhhLINvF4j+O496cTEhrCYb
         3giv7n4Ts/ZM5rnLotQH3t82XP+wiuXZselkm516bb8hjgjfq2vbGAf1CzBORYdgpAXb
         1yb/H92D+wlK07tNzEoM8gccJRZAZpihCHH+YdDg5+6RdZpE69beQB4lEAZVbETbOc3p
         Tp62rRFZwDgvxN7XH+YUG16OGbOcj0QFtnb++haX2bBey7LJW/zxNu5OPtOA56hKDH98
         pEcL4b94h2UXjsIjd5cjcJMleqwpcS1iCpATaSc5kj734sJqRRlMjGD5zR371E0UEdOx
         viCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DdPGwnHVcPtYyMt3MrhvxEjvQ4s6Eib4j5KCNAxoOwA=;
        b=zWAQvgm414SltAzmpuOqrwlt15FSUxFnnvu8rhB/vFkhyQKZfMcIqUsre8HXl3imKU
         SXfG3ERmC4mV8Xl8YM1KTZOR5aRjC9sqqrfzREPxTf5NzJe3YNxfwPHjEgHMMJdZNvZG
         jNl0mtU5OtpWDdUrR/s7anv5pDo2RrQLmu8YbzSwH4Dye2TlytP6ez46axPEzTw6XTdD
         hDSny0O5YvXF/0pTktfuRtvRcgNSy1yCQet8TCDftfjcdwlq1KTZTcYKQ6Jm/hEBwHkA
         WbagdfEBD5gbhsxIoM3ClxAaL9NcQbL20TZte5ZEb2984ew6uQLA80x/DuC10rkiKZR3
         lGEQ==
X-Gm-Message-State: ANoB5pmOGkZY+9uk/S03mN3V5D1hg1Fz6u/1EHTNBFRow04ZtYg2W9ye
        nHFI7nz5zWawWgPUNMD0J3lZhUZ5dKWx0UGBoDFT1g==
X-Google-Smtp-Source: AA0mqf6bunHhJ+W3cdKvhJ5Fhxb3bCtPNjpRfGK1BXiz2CO/kIRDd4QnBVW6hbL4wy87qsIqKDT2FyOA/Y+n56dMMzg=
X-Received: by 2002:adf:dbd2:0:b0:236:3cf5:4528 with SMTP id
 e18-20020adfdbd2000000b002363cf54528mr59267457wrj.355.1670962733865; Tue, 13
 Dec 2022 12:18:53 -0800 (PST)
MIME-Version: 1.0
References: <20221021163703.3218176-1-jthoughton@google.com>
 <20221021163703.3218176-12-jthoughton@google.com> <Y5jTTYwzFHgmm5l6@monkey>
In-Reply-To: <Y5jTTYwzFHgmm5l6@monkey>
From:   James Houghton <jthoughton@google.com>
Date:   Tue, 13 Dec 2022 15:18:41 -0500
Message-ID: <CADrL8HVuZBiNxeanhk1UGWZRc+J=PPffuTrdBSSU6bFqMpXWWw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 11/47] hugetlb: add hugetlb_pmd_alloc and hugetlb_pte_alloc
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
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

On Tue, Dec 13, 2022 at 2:32 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 10/21/22 16:36, James Houghton wrote:
> > These functions are used to allocate new PTEs below the hstate PTE. This
> > will be used by hugetlb_walk_step, which implements stepping forwards in
> > a HugeTLB high-granularity page table walk.
> >
> > The reasons that we don't use the standard pmd_alloc/pte_alloc*
> > functions are:
> >  1) This prevents us from accidentally overwriting swap entries or
> >     attempting to use swap entries as present non-leaf PTEs (see
> >     pmd_alloc(); we assume that !pte_none means pte_present and
> >     non-leaf).
> >  2) Locking hugetlb PTEs can different than regular PTEs. (Although, as
> >     implemented right now, locking is the same.)
> >  3) We can maintain compatibility with CONFIG_HIGHPTE. That is, HugeTLB
> >     HGM won't use HIGHPTE, but the kernel can still be built with it,
> >     and other mm code will use it.
> >
> > When GENERAL_HUGETLB supports P4D-based hugepages, we will need to
> > implement hugetlb_pud_alloc to implement hugetlb_walk_step.
> >
> > Signed-off-by: James Houghton <jthoughton@google.com>
> > ---
> >  include/linux/hugetlb.h |  5 +++
> >  mm/hugetlb.c            | 94 +++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 99 insertions(+)
> >
> > diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> > index d30322108b34..003255b0e40f 100644
> > --- a/include/linux/hugetlb.h
> > +++ b/include/linux/hugetlb.h
> > @@ -119,6 +119,11 @@ void hugetlb_pte_copy(struct hugetlb_pte *dest, const struct hugetlb_pte *src)
> >
> >  bool hugetlb_pte_present_leaf(const struct hugetlb_pte *hpte, pte_t pte);
> >
> > +pmd_t *hugetlb_pmd_alloc(struct mm_struct *mm, struct hugetlb_pte *hpte,
> > +             unsigned long addr);
> > +pte_t *hugetlb_pte_alloc(struct mm_struct *mm, struct hugetlb_pte *hpte,
> > +             unsigned long addr);
> > +
> >  struct hugepage_subpool {
> >       spinlock_t lock;
> >       long count;
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index a0e46d35dabc..e3733388adee 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -341,6 +341,100 @@ static bool has_same_uncharge_info(struct file_region *rg,
> >  #endif
> >  }
> >
> > +pmd_t *hugetlb_pmd_alloc(struct mm_struct *mm, struct hugetlb_pte *hpte,
> > +             unsigned long addr)
>
> A little confused as there are no users yet ... Is hpte the 'hstate PTE'
> that we are trying to allocate ptes under?  For example, in the case of
> a hugetlb_pmd_alloc caller hpte would be a PUD or CONT_PMD size pte?

The hpte is the level above the level we're trying to allocate (not
necessarily the 'hstate PTE'). I'll make that clear in the comments
for both functions.

So consider allocating 4K PTEs for a 1G HugeTLB page:
- With the hstate 'PTE' (PUD), we make a hugetlb_pte with that PUD
(let's call it 'hpte')
- We call hugetlb_pmd_alloc(hpte) which will leave 'hpte' the same,
but the pud_t that hpte->ptep points to is no longer a leaf.
- We call hugetlb_walk_step(hpte) to step down a level to get a PMD,
changing hpte. The hpte->ptep is now pointing to a blank pmd_t.
- We call hugetlb_pte_alloc(hpte) to allocate a bunch of PTEs and
populate the pmd_t.
- We call hugetlb_walk_step(hpte) to step down again.

This is basically what hugetlb_hgm_walk does (in the next patch). We
only change 'hpte' when we do a step, and that is when we populate
'shift'. The 'sz' parameter for hugetlb_walk_step is what
architectures can use to populate hpte->shift appropriately (ignored
for x86).

For arm64, we can use 'sz' to populate hpte->shift with what the
caller wants when we are free to choose (like if all the PTEs are
none, we can do CONT_PTE_SHIFT). See [1]'s implementation of
hugetlb_walk_step for what I *think* is correct for arm64.

[1] https://github.com/48ca/linux/commit/bf3b8742e95c58c2431c80c5bed5cb5cb95885af

>
> > +{
> > +     spinlock_t *ptl = hugetlb_pte_lockptr(mm, hpte);
> > +     pmd_t *new;
> > +     pud_t *pudp;
> > +     pud_t pud;
> > +
> > +     if (hpte->level != HUGETLB_LEVEL_PUD)
> > +             return ERR_PTR(-EINVAL);
>
> Ah yes, it is PUD level.  However, I guess CONT_PMD would also be valid
> on arm64?

The level is always PGD, P4D, PUD, PMD, or PTE. CONT_PTE is on
HUGETLB_LEVEL_PTE, CONT_PMD is on HUGETLB_LEVEL_PMD.

These functions are supposed to be used for all architectures (in
their implementations of 'hugetlb_walk_step'; that's why they're not
static, actually. I'll make that clear in the commit description).

>
> > +
> > +     pudp = (pud_t *)hpte->ptep;
> > +retry:
> > +     pud = *pudp;
>
> We might want to consider a READ_ONCE here.  I am not an expert on such
> things, but recall a similar as pointed out in the now obsolete commit
> 27ceae9833843.

Agreed. Will try to change all PTE reading to use READ_ONCE, though
they can be easy to miss... :(

Thanks very much for the reviews so far, Mike!

- James

>
> --
> Mike Kravetz
>
