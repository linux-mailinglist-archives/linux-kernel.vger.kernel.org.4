Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9A270BBB6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 13:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbjEVLZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 07:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233634AbjEVLZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 07:25:20 -0400
X-Greylist: delayed 14812 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 22 May 2023 04:22:34 PDT
Received: from out-62.mta1.migadu.com (out-62.mta1.migadu.com [IPv6:2001:41d0:203:375::3e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D7C212A
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 04:22:34 -0700 (PDT)
Message-ID: <9dc72654-79db-e988-54a8-488550d235ac@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684754244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3BNPsU4rNUqUjN43wlS41FKIQSqyrj6MltULGYMl8TA=;
        b=dkzcgRbsbeMyA8WuRNLFxGPf+kefcNrXeWfOoPgOxGVvRYK/kTHZvSS2JE+w2quBdOzMr0
        e5sSlGZgGRFN8iE5U3L7qkVTBaJFJnFZf+soYncMIncoNch7colJt7oyjKHuFT/KmYxDNW
        VN5qJGHn6LMvUSikM0IlvbDC1uY4BN0=
Date:   Mon, 22 May 2023 19:17:11 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 04/31] mm/pgtable: allow pte_offset_map[_lock]() to fail
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
 <8218ffdc-8be-54e5-0a8-83f5542af283@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <8218ffdc-8be-54e5-0a8-83f5542af283@google.com>
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

Hi Hugh,

On 2023/5/22 12:53, Hugh Dickins wrote:

[...]

>   
> @@ -229,3 +231,57 @@ pmd_t pmdp_collapse_flush(struct vm_area_struct *vma, unsigned long address,
>   }
>   #endif
>   #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> +
> +pte_t *__pte_offset_map(pmd_t *pmd, unsigned long addr, pmd_t *pmdvalp)
> +{
> +	pmd_t pmdval;
> +
> +	/* rcu_read_lock() to be added later */
> +	pmdval = pmdp_get_lockless(pmd);
> +	if (pmdvalp)
> +		*pmdvalp = pmdval;
> +	if (unlikely(pmd_none(pmdval) || is_pmd_migration_entry(pmdval)))
> +		goto nomap;
> +	if (unlikely(pmd_trans_huge(pmdval) || pmd_devmap(pmdval)))
> +		goto nomap;

Will the follow-up patch deal with the above situation specially?
Otherwise, maybe it can be changed to the following check method?

	if (unlikely(pmd_none(pmdval) || pmd_leaf(pmdval)))
		goto nomap;

> +	if (unlikely(pmd_bad(pmdval))) {
> +		pmd_clear_bad(pmd);
> +		goto nomap;
> +	}
> +	return __pte_map(&pmdval, addr);
> +nomap:
> +	/* rcu_read_unlock() to be added later */
> +	return NULL;
> +}
> +
> +pte_t *pte_offset_map_nolock(struct mm_struct *mm, pmd_t *pmd,
> +			     unsigned long addr, spinlock_t **ptlp)
> +{
> +	pmd_t pmdval;
> +	pte_t *pte;
> +
> +	pte = __pte_offset_map(pmd, addr, &pmdval);
> +	if (likely(pte))
> +		*ptlp = pte_lockptr(mm, &pmdval);
> +	return pte;
> +}
> +
> +pte_t *__pte_offset_map_lock(struct mm_struct *mm, pmd_t *pmd,
> +			     unsigned long addr, spinlock_t **ptlp)
> +{
> +	spinlock_t *ptl;
> +	pmd_t pmdval;
> +	pte_t *pte;
> +again:
> +	pte = __pte_offset_map(pmd, addr, &pmdval);
> +	if (unlikely(!pte))
> +		return pte;
> +	ptl = pte_lockptr(mm, &pmdval);
> +	spin_lock(ptl);
> +	if (likely(pmd_same(pmdval, pmdp_get_lockless(pmd)))) {
> +		*ptlp = ptl;
> +		return pte;
> +	}
> +	pte_unmap_unlock(pte, ptl);
> +	goto again;
> +}

-- 
Thanks,
Qi
