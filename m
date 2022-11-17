Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B54A62D057
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 02:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238019AbiKQBAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 20:00:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238592AbiKQBAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 20:00:21 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2636F6A763
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 17:00:20 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id b131so149811yba.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 17:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C3URPOAvHtsPTjypQ/DqLBNZqOx50A4QEjRlhOOIhSg=;
        b=RITNO7Jc+hcF+RtMcmbs4vZSopP5WQfGrZor3dI2fXb07fA9DxGzSdrrggG8dRSVpg
         Nm+OE2pYYfnzjGhDM7ubOiF1iRrE9uiPmXaCBaoM59g1NglTvISfPJa0ThTDUxHL9jHv
         4jyRJLxFGjg+YwN5RA1s72ieJp3NYq7KlYLQlGtbTiChr00lYQ+3sne2SVxuK2pBXzao
         UCdJes2xm6/ice4oGbPgrWrqkDWd7b/tnLVvIVPAS9LscInlFHVdannfeirMQ3KZ4HLp
         MPuw9EWvAE/+8nZpbokFdCn8WhzNa1TgKuzfY9UTXuSRr8hnj/IdG8MjBIDXt87fXsRB
         PljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C3URPOAvHtsPTjypQ/DqLBNZqOx50A4QEjRlhOOIhSg=;
        b=RjDvBdt0FEXjwG6wcBg+S71gIsee7+e60GECv6ZjKYGksfsEq+L6DgxNLMJoWiiL6o
         Qz/2ceqhYmU7Rv33AHRb8z3NCluS37q7SS3WZ7EkivJ3GpWeqMV+2JF7htkjWX0G2uij
         wAMG4iRq9k0vM6M+qA2kN0eW7m20XdUVoVunDNk3s59isYPvY115asekTviCjjylcB0o
         40WSGJ8KlboDFfJeYN+zi3VIVngRDeWV7W7aFpdh5ZAjHF8p5iV4p4YK0IJ4Z0/fnsaX
         Uztv3RceHhn5MwtrxJcKkTky6mDf+48XATBdEORx15iwc8lvne+KXnytmVq+RMNlVmUj
         GsyQ==
X-Gm-Message-State: ANoB5pmMKEkzNEdjLNZmEHlclbNzIKROQFmIwmwInHrijK8T6WLQ0+Ar
        /QgwcL6g13/dDsYoEXyd8InZUtpChYcu/RFY2uGTgA==
X-Google-Smtp-Source: AA0mqf4PRbHhRy9BmGOMPBU7ZfK4XvohC9KRioTBz2t8jUra01nwI94HevlFrhRv1zZhfjy8hNABVnkQ9r0ik8xQx5w=
X-Received: by 2002:a5b:505:0:b0:6cf:e605:7707 with SMTP id
 o5-20020a5b0505000000b006cfe6057707mr164264ybp.638.1668646819164; Wed, 16 Nov
 2022 17:00:19 -0800 (PST)
MIME-Version: 1.0
References: <20221021163703.3218176-1-jthoughton@google.com>
 <20221021163703.3218176-11-jthoughton@google.com> <Y3Vhl6jzTLP0AggE@x1n>
In-Reply-To: <Y3Vhl6jzTLP0AggE@x1n>
From:   James Houghton <jthoughton@google.com>
Date:   Wed, 16 Nov 2022 17:00:08 -0800
Message-ID: <CADrL8HUZRAT1ViYniBEL=SQaFsmwSpMUmR6tSWy11LdbdhePnQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 10/47] hugetlb: add hugetlb_pte to track HugeTLB
 page table entries
To:     Peter Xu <peterx@redhat.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
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

On Wed, Nov 16, 2022 at 2:18 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Fri, Oct 21, 2022 at 04:36:26PM +0000, James Houghton wrote:
> > +struct hugetlb_pte {
> > +     pte_t *ptep;
> > +     unsigned int shift;
> > +     enum hugetlb_level level;
> > +     spinlock_t *ptl;
> > +};
>
> Do we need both shift + level?  Maybe it's only meaningful for ARM where
> the shift may not be directly calculcated from level?
>
> I'm wondering whether we can just maintain "shift" then we calculate
> "level" realtime.  It just reads a bit weird to have these two fields, also
> a burden to most of the call sites where shift and level exactly match..

My main concern is interaction with folded levels. For example, if
PUD_SIZE and PMD_SIZE are the same, we want to do something like this:

pud = pud_offset(p4d, addr)
pmd = pmd_offset(pud, addr) /* this is just pmd = (pmd_t *) pud */
pte = pte_offset(pmd, addr)

and I think we should avoid quietly skipping the folded level, which
could happen:

pud = pud_offset(p4d, addr)
/* Each time, we go back to pte_t *, so if we stored PUD_SHIFT here,
it is impossible to know that `pud` came from `pud_offset` and not
`pmd_offset`. We must assume the deeper level so that we don't get
stuck in a loop. */
pte = pte_offset(pud, addr) /* pud is cast from (pud_t * -> pte_t * ->
pmd_t *) */

Quietly dropping p*d_offset for folded levels is safe; it's just a
cast that we're doing anyway. If you think this is fine, then I can
remove `level`. It might also be that this is a non-issue and that
there will never be a folded level underneath a hugepage level.

We could also change `ptep` to a union eventually (to clean up
"hugetlb casts everything to pte_t *" messiness), and having an
explicit `level` as a tag for the union would be nice help. In the
same way: I like having `level` explicitly so that we know for sure
where `ptep` came from.

I can try to reduce the burden at the callsite while keeping `level`:
hpage_size_to_level() is really annoying to have everywhere.

>
> > +
> > +static inline
> > +void hugetlb_pte_populate(struct hugetlb_pte *hpte, pte_t *ptep,
> > +                       unsigned int shift, enum hugetlb_level level)
>
> I'd think it's nicer to replace "populate" with something else, as populate
> is definitely a meaningful word in vm world for "making something appear if
> it wasn't".  Maybe hugetlb_pte_setup()?
>
> Even one step back, on the naming of hugetlb_pte..  Sorry to comment on
> namings especially on this one, I really don't like to do that normally..
> but here hugetlb_pte only walks the sub-page level of pgtables, meanwhile
> it's not really a pte but an iterator.  How about hugetlb_hgm_iter?  "hgm"
> tells that it only walks sub-level, and "iter" tells that it is an
> iterator, being updated for each stepping downwards.
>
> Then hugetlb_pte_populate() can be hugetlb_hgm_iter_init().
>
> Take these comments with a grain of salt, and it never hurts to wait for a
> 2nd opinion before anything.

I think this is a great idea. :) Thank you! I'll make this change for
v1 unless someone has a better suggestion.

>
> > +{
> > +     WARN_ON_ONCE(!ptep);
> > +     hpte->ptep = ptep;
> > +     hpte->shift = shift;
> > +     hpte->level = level;
> > +     hpte->ptl = NULL;
> > +}
> > +
> > +static inline
> > +unsigned long hugetlb_pte_size(const struct hugetlb_pte *hpte)
> > +{
> > +     WARN_ON_ONCE(!hpte->ptep);
> > +     return 1UL << hpte->shift;
> > +}
> > +
> > +static inline
> > +unsigned long hugetlb_pte_mask(const struct hugetlb_pte *hpte)
> > +{
> > +     WARN_ON_ONCE(!hpte->ptep);
> > +     return ~(hugetlb_pte_size(hpte) - 1);
> > +}
> > +
> > +static inline
> > +unsigned int hugetlb_pte_shift(const struct hugetlb_pte *hpte)
> > +{
> > +     WARN_ON_ONCE(!hpte->ptep);
> > +     return hpte->shift;
> > +}
> > +
> > +static inline
> > +enum hugetlb_level hugetlb_pte_level(const struct hugetlb_pte *hpte)
> > +{
> > +     WARN_ON_ONCE(!hpte->ptep);
>
> There're definitely a bunch of hpte->ptep WARN_ON_ONCE()s..  AFAIK the
> hugetlb_pte* will be setup once with valid ptep and then it should always
> be.  I rem someone commented on these helpers look not useful, which I must
> confess I had the same feeling.  But besides that, I'd rather drop all
> these WARN_ON_ONCE()s but only check it when init() the iterator/pte.

The idea with these WARN_ON_ONCE()s is that it WARNs for the case that
`hpte` was never populated/initialized, but I realize that we can't
even rely on hpte->ptep == NULL. I'll remove the WARN_ON_ONCE()s, and
I'll drop hugetlb_pte_shift and hugetlb_pte_level entirely.

I'll keep the hugetlb_pte_{size,mask,copy,present_leaf} helpers as
they are legitimately helpful.

>
> > +     return hpte->level;
> > +}
> > +
> > +static inline
> > +void hugetlb_pte_copy(struct hugetlb_pte *dest, const struct hugetlb_pte *src)
> > +{
> > +     dest->ptep = src->ptep;
> > +     dest->shift = src->shift;
> > +     dest->level = src->level;
> > +     dest->ptl = src->ptl;
> > +}
> > +
> > +bool hugetlb_pte_present_leaf(const struct hugetlb_pte *hpte, pte_t pte);
> > +
> >  struct hugepage_subpool {
> >       spinlock_t lock;
> >       long count;
> > @@ -1210,6 +1279,25 @@ static inline spinlock_t *huge_pte_lock(struct hstate *h,
> >       return ptl;
> >  }
> >
> > +static inline
> > +spinlock_t *hugetlb_pte_lockptr(struct mm_struct *mm, struct hugetlb_pte *hpte)
> > +{
> > +
> > +     BUG_ON(!hpte->ptep);
>
> Another BUG_ON(); better be dropped too.

Can do.

>
> > +     if (hpte->ptl)
> > +             return hpte->ptl;
> > +     return huge_pte_lockptr(hugetlb_pte_shift(hpte), mm, hpte->ptep);
>
> I'm curious whether we can always have hpte->ptl set for a valid
> hugetlb_pte.  I think that means we'll need to also init the ptl in the
> init() fn of the iterator.  Then it'll be clear on which lock to take for
> each valid hugetlb_pte.

I can work on this for v1. Right now it's not very good: for 4K PTEs,
we manually set ->ptl while walking. I'll make it so that ->ptl is
always populated so the code is easier to read.

- James

>
> > +}

>
> --
> Peter Xu
>
