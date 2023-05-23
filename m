Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 614A670E434
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 20:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238155AbjEWSHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 14:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238132AbjEWSHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 14:07:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14EC1C5
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 11:07:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A12466198E
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 18:07:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64EB0C433EF;
        Tue, 23 May 2023 18:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684865228;
        bh=PqO2Ba0azEpR69b5p3AcZhVRdxUYPoFaydPljsZiJ08=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ff5mtWARZiVsUDm26jYK2NzJV9heOhVdPVGG+GTPzayA+f7KaErquj7YpGPB0tqnS
         8Xjw8GhtAZoYaxeEkk/AEcjmW/NpoAe2fjEVBqOy8mDia04zoW/JpOuXzj2QI743Uv
         9fg6oXsf99r8rUYjCpbg8WI8E9A4WKITgvK7QQeJO288u0zVR4YCmT4QsbIP+u5Ekj
         rJxh6oqNS4wCciLQ/4lBz+Xth8Y+V1AubibKcVUGOLYnBDsXsX7KkzpgydzrytMOz+
         zgbX2bUTcZ1MD55KVvsL5IBsmReg4CzPE64MeTLF1jtoVVGqC94QbNhjfIhxHZRk3S
         5K52MBWNo9fqA==
From:   SeongJae Park <sj@kernel.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Yang Shi <shy828301@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Price <steven.price@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zack Rusin <zackr@vmware.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Song Liu <song@kernel.org>,
        Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 09/31] mm/pagewalkers: ACTION_AGAIN if pte_offset_map_lock() fails
Date:   Tue, 23 May 2023 18:07:03 +0000
Message-Id: <20230523180703.89902-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <6265ac58-6018-a8c6-cf38-69cba698471@google.com>
References: 
MIME-Version: 1.0
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

Hello Hugh,

On Sun, 21 May 2023 22:00:15 -0700 (PDT) Hugh Dickins <hughd@google.com> wrote:

> Simple walk_page_range() users should set ACTION_AGAIN to retry when
> pte_offset_map_lock() fails.
> 
> No need to check pmd_trans_unstable(): that was precisely to avoid the
> possiblity of calling pte_offset_map() on a racily removed or inserted
> THP entry, but such cases are now safely handled inside it.  Likewise
> there is no need to check pmd_none() or pmd_bad() before calling it.
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>

For below mm/damon part,

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

> ---
>  fs/proc/task_mmu.c | 32 ++++++++++++++++----------------
>  mm/damon/vaddr.c   | 12 ++++++++----
>  mm/mempolicy.c     |  7 ++++---
>  mm/mincore.c       |  9 ++++-----
>  mm/mlock.c         |  4 ++++
>  5 files changed, 36 insertions(+), 28 deletions(-)
> 
[...]
> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index 1fec16d7263e..b8762ff15c3c 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
> @@ -318,9 +318,11 @@ static int damon_mkold_pmd_entry(pmd_t *pmd, unsigned long addr,
>  		spin_unlock(ptl);
>  	}
>  
> -	if (pmd_none(*pmd) || unlikely(pmd_bad(*pmd)))
> -		return 0;
>  	pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
> +	if (!pte) {
> +		walk->action = ACTION_AGAIN;
> +		return 0;
> +	}
>  	if (!pte_present(*pte))
>  		goto out;
>  	damon_ptep_mkold(pte, walk->mm, addr);
> @@ -464,9 +466,11 @@ static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
>  regular_page:
>  #endif	/* CONFIG_TRANSPARENT_HUGEPAGE */
>  
> -	if (pmd_none(*pmd) || unlikely(pmd_bad(*pmd)))
> -		return -EINVAL;
>  	pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
> +	if (!pte) {
> +		walk->action = ACTION_AGAIN;
> +		return 0;
> +	}
>  	if (!pte_present(*pte))
>  		goto out;
>  	folio = damon_get_folio(pte_pfn(*pte));
[...]
