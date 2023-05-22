Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E52870BC09
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 13:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233327AbjEVLlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 07:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjEVLlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 07:41:51 -0400
Received: from out-20.mta0.migadu.com (out-20.mta0.migadu.com [IPv6:2001:41d0:1004:224b::14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338B0A0
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 04:41:50 -0700 (PDT)
Message-ID: <10e58e7e-a52e-751d-f693-cd4e05ac10ca@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684755708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s9cmspJubmVALzr9R4FiGgADvWy/zsxX0daTT9ez0U8=;
        b=h991mvuT0dKHypdxWkkXlCCOJMdEV93/HXLbiuDCCAYWfZAEW+iIZmx2CFWeYnusaxXwiw
        bZgajcN3QcfG1zDR6ctnIODlf73lQXniPNoiUh5+JPuawnwzifrfYHdRSFTTAwvRID93vG
        a7yzyDbsTRUR7J842zzLmZCTH+r/yVk=
Date:   Mon, 22 May 2023 19:41:35 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 08/31] mm/page_vma_mapped: pte_offset_map_nolock() not
 pte_lockptr()
Content-Language: en-US
To:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
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
References: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com>
 <8fa3fb6e-2e39-cbea-c529-ee9e64c7d2d0@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <8fa3fb6e-2e39-cbea-c529-ee9e64c7d2d0@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/22 12:58, Hugh Dickins wrote:
> map_pte() use pte_offset_map_nolock(), to make sure of the ptl belonging
> to pte, even if pmd entry is then changed racily: page_vma_mapped_walk()
> use that instead of getting pte_lockptr() later, or restart if map_pte()
> found no page table.
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
>   mm/page_vma_mapped.c | 28 ++++++++++++++++++++++------
>   1 file changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> index 947dc7491815..2af734274073 100644
> --- a/mm/page_vma_mapped.c
> +++ b/mm/page_vma_mapped.c
> @@ -13,16 +13,28 @@ static inline bool not_found(struct page_vma_mapped_walk *pvmw)
>   	return false;
>   }
>   
> -static bool map_pte(struct page_vma_mapped_walk *pvmw)
> +static bool map_pte(struct page_vma_mapped_walk *pvmw, spinlock_t **ptlp)
>   {
>   	if (pvmw->flags & PVMW_SYNC) {
>   		/* Use the stricter lookup */
>   		pvmw->pte = pte_offset_map_lock(pvmw->vma->vm_mm, pvmw->pmd,
>   						pvmw->address, &pvmw->ptl);
> -		return true;
> +		*ptlp = pvmw->ptl;
> +		return !!pvmw->pte;
>   	}
>   
> -	pvmw->pte = pte_offset_map(pvmw->pmd, pvmw->address);
> +	/*
> +	 * It is important to return the ptl corresponding to pte,
> +	 * in case *pvmw->pmd changes underneath us; so we need to
> +	 * return it even when choosing not to lock, in case caller
> +	 * proceeds to loop over next ptes, and finds a match later.
> +	 * Though, in most cases, page lock already protects this.
> +	 */
> +	pvmw->pte = pte_offset_map_nolock(pvmw->vma->vm_mm, pvmw->pmd,
> +					  pvmw->address, ptlp);
> +	if (!pvmw->pte)
> +		return false;
> +
>   	if (pvmw->flags & PVMW_MIGRATION) {
>   		if (!is_swap_pte(*pvmw->pte))
>   			return false;
> @@ -51,7 +63,7 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw)
>   	} else if (!pte_present(*pvmw->pte)) {
>   		return false;
>   	}
> -	pvmw->ptl = pte_lockptr(pvmw->vma->vm_mm, pvmw->pmd);
> +	pvmw->ptl = *ptlp;
>   	spin_lock(pvmw->ptl);
>   	return true;
>   }
> @@ -156,6 +168,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>   	struct vm_area_struct *vma = pvmw->vma;
>   	struct mm_struct *mm = vma->vm_mm;
>   	unsigned long end;
> +	spinlock_t *ptl;
>   	pgd_t *pgd;
>   	p4d_t *p4d;
>   	pud_t *pud;
> @@ -257,8 +270,11 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>   			step_forward(pvmw, PMD_SIZE);
>   			continue;
>   		}
> -		if (!map_pte(pvmw))
> +		if (!map_pte(pvmw, &ptl)) {
> +			if (!pvmw->pte)
> +				goto restart;

Could pvmw->pmd be changed? Otherwise, how about just jumping to the
retry label below?

@@ -205,6 +205,8 @@ bool page_vma_mapped_walk(struct 
page_vma_mapped_walk *pvmw)
                 }

                 pvmw->pmd = pmd_offset(pud, pvmw->address);
+
+retry:
                 /*
                  * Make sure the pmd value isn't cached in a register 
by the
                  * compiler and used as a stale value after we've 
observed a

>   			goto next_pte;
> +		}
>   this_pte:
>   		if (check_pte(pvmw))
>   			return true;
> @@ -281,7 +297,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>   		} while (pte_none(*pvmw->pte));
>   
>   		if (!pvmw->ptl) {
> -			pvmw->ptl = pte_lockptr(mm, pvmw->pmd);
> +			pvmw->ptl = ptl;
>   			spin_lock(pvmw->ptl);
>   		}
>   		goto this_pte;

-- 
Thanks,
Qi
