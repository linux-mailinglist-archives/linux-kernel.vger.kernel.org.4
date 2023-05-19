Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A118270A01D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 21:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjESTym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 15:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjESTyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 15:54:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8F61B5
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 12:54:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E90C66587A
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 19:54:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 689D2C433D2;
        Fri, 19 May 2023 19:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684526078;
        bh=Ns58burMT4c0EWSkncF1uaZbw4bRG/N+tROJuYPPCN0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P8KMX/ai33gl6aKSfnz60iRj7pvKbWY8KlEhg+AuilM3+bx0LTdJM8E8IDhtFAgYB
         xp4kwuVLeseRxiseh4Z+d09U4VU9Xbx3ikgnmARoV3hM+ZTjjyiW5Hie+hZWsoA/ZC
         hFoGkh+eH8c1Vy/MDAtB2AWJrXrzojr0dZJJKvfhltDuImPO57LK57qqQgQ3lALLT8
         dp6+Ea7/5Y7CNVHnZ6Tx4wmVQMPIHOCZiCMfXAPwuoCVxAeGclnGM8UDaqMy3Aur+s
         QPMGAdzWtofTat96uz60Q7fRCiqhl6wSSkgtYKNXdCeJafzPWxTJPnkHXnBq6T1PY4
         WYiDOwjNPmAuQ==
From:   SeongJae Park <sj@kernel.org>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        SeongJae Park <sj@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>, Zi Yan <ziy@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        damon@lists.linux.dev
Subject: Re: [PATCH v2 2/5] mm: damon must atomically clear young on ptes and pmds
Date:   Fri, 19 May 2023 19:54:35 +0000
Message-Id: <20230519195435.90394-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <88c125fd-2294-4650-65b1-6be56589120e@arm.com>
References: 
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 May 2023 10:02:48 +0100 Ryan Roberts <ryan.roberts@arm.com> wrote:

> On 19/05/2023 00:19, Yu Zhao wrote:
> > On Thu, May 18, 2023 at 5:07 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
> >>
> >> It is racy to non-atomically read a pte, then clear the young bit, then
> >> write it back as this could discard dirty information. Further, it is
> >> bad practice to directly set a pte entry within a table. Instead
> >> clearing young must go through the arch-provided helper,
> >> ptep_test_and_clear_young() to ensure it is modified atomically and to
> >> give the arch code visibility and allow it to check (and potentially
> >> modify) the operation.
> >>
> >> Fixes: 46c3a0accdc4 ("mm/damon/vaddr: separate commonly usable functions")
> > 
> > This should be a separate patch, since it's independent from what the
> > series tries to do.
> > 
> > And that patch should cc stable, since it fixes user data corruption.
> 
> Fair point. The first 3 patches are fixes for issues I found during the
> conversion. So if you're ok with it, I'll split into 2 series; the first 3
> patches in the first, and the conversion to ptep_deref() (or ptep_get(), as per
> your comments in the other thread) in the second. I guess the whole first series
> should go to stable.
> 
> Let me know if you disagree.
> 
> > 
> >> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> >> Reviewed-by: Zi Yan <ziy@nvidia.com>
> >> ---
> >>  mm/damon/ops-common.c | 16 ++++++----------
> >>  mm/damon/ops-common.h |  4 ++--
> >>  mm/damon/paddr.c      |  4 ++--
> >>  mm/damon/vaddr.c      |  4 ++--
> >>  4 files changed, 12 insertions(+), 16 deletions(-)
> >>
> >> diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> >> index cc63cf953636..acc264b97903 100644
> >> --- a/mm/damon/ops-common.c
> >> +++ b/mm/damon/ops-common.c
> >> @@ -37,7 +37,7 @@ struct folio *damon_get_folio(unsigned long pfn)
> >>         return folio;
> >>  }
> >>
> >> -void damon_ptep_mkold(pte_t *pte, struct mm_struct *mm, unsigned long addr)
> >> +void damon_ptep_mkold(pte_t *pte, struct vm_area_struct *vma, unsigned long addr)
> >>  {
> >>         bool referenced = false;
> >>         struct folio *folio = damon_get_folio(pte_pfn(*pte));
> >> @@ -45,13 +45,11 @@ void damon_ptep_mkold(pte_t *pte, struct mm_struct *mm, unsigned long addr)
> >>         if (!folio)
> >>                 return;
> >>
> >> -       if (pte_young(*pte)) {
> >> +       if (ptep_test_and_clear_young(vma, addr, pte))
> >>                 referenced = true;
> >> -               *pte = pte_mkold(*pte);
> >> -       }
> >>
> >>  #ifdef CONFIG_MMU_NOTIFIER
> >> -       if (mmu_notifier_clear_young(mm, addr, addr + PAGE_SIZE))
> >> +       if (mmu_notifier_clear_young(vma->vm_mm, addr, addr + PAGE_SIZE))
> >>                 referenced = true;
> >>  #endif /* CONFIG_MMU_NOTIFIER */
> > 
> > Use ptep_clear_young_notify(). Similar below.
> 
> This looks sensible but I'd like clarification from SeongJae: Are you happy for
> me to do this refactoring as part of the patch?

Yes, I would be happy for that :)  Nevertheless, because that's a refactoring
rather than a fix, I'd be happier if you could do that with a separate patch.


Thanks,
SJ

> 
> Thanks,
> Ryan
> 
