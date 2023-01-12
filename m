Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83AAD667368
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 14:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234629AbjALNkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 08:40:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234352AbjALNjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 08:39:37 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED4A48CE8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 05:38:15 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id k22-20020a05600c1c9600b003d1ee3a6289so15057242wms.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 05:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=znmW8joeNg1jmfKypKeLrmbUtyOkQqXYCi/lvfTsrdI=;
        b=Xp0TRmqlsjjffiwxl0b0CiwXPilusQSP/SU9BxYBpigVwWpqBMplvDmS+3MSAPF09i
         PTr+3OYQuzOIR2mg7EpxH5tn4S85J7qF4RzNWLrVnLcFc+CSEWWEY12VX5+rVcBvYRnM
         KoGadlfGXw9Z8Uk37XSlBLxEw3uq0BkmE7/ZxPkROFbpUW+tXU70hKkK4b97ajVSex+g
         LbFJdoYgaY5d5QhwBBVp1EJmT5KyRLATPVP3M0D97hKFNKdjX5p47Ky/OQncckodt17q
         egXGj09/aeLOdwwY6xKZssRm/yHPlWyWIaNoWXlHdXfTmQh/PrPr3jatx/kzw+AshjGJ
         WAwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=znmW8joeNg1jmfKypKeLrmbUtyOkQqXYCi/lvfTsrdI=;
        b=fTA0eXA7ad3LfYV+JirWb4pllN9irPdtwEyGBFgYmZYNnA8eGvL3EfJSjIapk4vl9K
         9xdpw6soToZ0UChUDaiBbXSEb6oyL448uddlCJ7I5j+GQokY68Bz6jAxm3kDjzJREx9k
         L6ureNHdiu47bboZPitWMUZOKMjvLdCjZZ4aLXDF3d5Bauh0iOEjOJp5QDthLnaoNLAk
         bZeoxXgZrVnRim8ybBdIwPQKCY+rF4abxfpjQlopragj5VMcpMIHr8xC3jqHt09oYptH
         9QC9dbCHQe5oQ2oDZt016EMtrLjx9n6kl4E02KuO42owk0rMOmUethOb+KDbIJFZZEjQ
         h+HA==
X-Gm-Message-State: AFqh2koA9GNf4/RB3d68CmpvmnRpPCJcXMiBOoi3VNqLDwXyfesfR7pZ
        269LNg4kgFC8v1ddzUGGKZ1Ue4Q0Hm3zAXrls9DzWQ==
X-Google-Smtp-Source: AMrXdXvsTW5fSCQd5wEYlEg/EKrAsjeKT1Gel7lICz1kX2DxrngJOgXMxeF4KdV/Unu34j7CRdbSeHop2BZO6p2yeL8=
X-Received: by 2002:a05:600c:1684:b0:3da:1b37:8ff5 with SMTP id
 k4-20020a05600c168400b003da1b378ff5mr76464wmn.166.1673530693828; Thu, 12 Jan
 2023 05:38:13 -0800 (PST)
MIME-Version: 1.0
References: <20230105101844.1893104-1-jthoughton@google.com>
 <20230105101844.1893104-14-jthoughton@google.com> <Y78vaNW10X6vUKjA@x1n>
In-Reply-To: <Y78vaNW10X6vUKjA@x1n>
From:   James Houghton <jthoughton@google.com>
Date:   Thu, 12 Jan 2023 08:38:02 -0500
Message-ID: <CADrL8HWJvxGej8arUtCch_=OcFy_vzo11rD0yRK8ey_Oe2BHXQ@mail.gmail.com>
Subject: Re: [PATCH 13/46] hugetlb: add hugetlb_hgm_walk and hugetlb_walk_step
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

On Wed, Jan 11, 2023 at 4:51 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Thu, Jan 05, 2023 at 10:18:11AM +0000, James Houghton wrote:
>
> [...]
>
> > +static int hugetlb_hgm_walk_uninit(struct hugetlb_pte *hpte,
>
> Nitpick on the name: the "uninit" can be misread into pairing with some
> other "init()" calls..
>
> How about just call it hugetlb_hgm_walk (since it's the higher level API
> comparing to the existing one)?  Then the existing hugetlb_hgm_walk can be
> called hugetlb_hgm_do_walk/__hugetlb_hgm_walk since it's one level down.
>
> > +                                pte_t *ptep,
> > +                                struct vm_area_struct *vma,
> > +                                unsigned long addr,
> > +                                unsigned long target_sz,
> > +                                bool alloc)
> > +{
> > +     struct hstate *h = hstate_vma(vma);
> > +
> > +     hugetlb_pte_populate(vma->vm_mm, hpte, ptep, huge_page_shift(h),
> > +                          hpage_size_to_level(huge_page_size(h)));
>
> Another nitpick on name: I remembered we used to reach a consensus of using
> hugetlb_pte_init before?  Can we still avoid the word "populate" (if "init"
> is not suitable since it can be updated during stepping, how about "setup")?

Right, we did talk about this, sorry. Ok I'll go ahead with this name change.
- hugetlb_hgm_walk => __hugetlb_hgm_walk
- hugetlb_hgm_walk_uninit => hugetlb_hgm_walk
- [__,]hugetlb_pte_populate => [__,]hugetlb_pte_init

>
> [...]
>
> > +int hugetlb_walk_step(struct mm_struct *mm, struct hugetlb_pte *hpte,
> > +                   unsigned long addr, unsigned long sz)
> > +{
> > +     pte_t *ptep;
> > +     spinlock_t *ptl;
> > +
> > +     switch (hpte->level) {
> > +     case HUGETLB_LEVEL_PUD:
> > +             ptep = (pte_t *)hugetlb_alloc_pmd(mm, hpte, addr);
> > +             if (IS_ERR(ptep))
> > +                     return PTR_ERR(ptep);
> > +             hugetlb_pte_populate(mm, hpte, ptep, PMD_SHIFT,
> > +                                  HUGETLB_LEVEL_PMD);
> > +             break;
> > +     case HUGETLB_LEVEL_PMD:
> > +             ptep = hugetlb_alloc_pte(mm, hpte, addr);
> > +             if (IS_ERR(ptep))
> > +                     return PTR_ERR(ptep);
> > +             ptl = pte_lockptr(mm, (pmd_t *)hpte->ptep);
> > +             __hugetlb_pte_populate(hpte, ptep, PAGE_SHIFT,
> > +                                    HUGETLB_LEVEL_PTE, ptl);
> > +             hpte->ptl = ptl;
>
> This line seems to be superfluous (even if benign).

Nice catch! It shouldn't be there; I accidentally left it in when I
changed how `ptl` was handled.

Thanks Peter!
