Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E300B70EBB2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 05:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239249AbjEXDMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 23:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235088AbjEXDMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 23:12:10 -0400
Received: from out-52.mta0.migadu.com (out-52.mta0.migadu.com [IPv6:2001:41d0:1004:224b::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3D718C
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 20:12:08 -0700 (PDT)
Message-ID: <06996a88-4248-d909-dc06-5af1ba580ef3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684897926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KjGgDwsaWYQjGKLlgM4P0do5d+jCOeVp4sk/adTJ35M=;
        b=DGy36fVxR3ozLUoXI7o+2j4P+fBJx/CiDo7kPqpMCulWoJWa61A3MI1DcCwWSgIj0pbPos
        gqTt6zWZjG+fWWLdSMUMm80WiPHZvmVqyFa3yjoez9cyemw4dP6xHiZxiRSEVGbBiqY5zl
        Pu6DdNjiDQWNUKnwXraTKBEW6kEGSWc=
Date:   Wed, 24 May 2023 11:11:48 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 04/31] mm/pgtable: allow pte_offset_map[_lock]() to fail
Content-Language: en-US
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
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
 <9dc72654-79db-e988-54a8-488550d235ac@linux.dev>
 <1efc993b-5b41-4895-a4d-20d38eb95de5@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <1efc993b-5b41-4895-a4d-20d38eb95de5@google.com>
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



On 2023/5/24 10:22, Hugh Dickins wrote:
> On Mon, 22 May 2023, Qi Zheng wrote:
>> On 2023/5/22 12:53, Hugh Dickins wrote:
>>
>> [...]
>>
>>>    @@ -229,3 +231,57 @@ pmd_t pmdp_collapse_flush(struct vm_area_struct *vma,
>>> unsigned long address,
>>>    }
>>>    #endif
>>>    #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>>> +
>>> +pte_t *__pte_offset_map(pmd_t *pmd, unsigned long addr, pmd_t *pmdvalp)
>>> +{
>>> +	pmd_t pmdval;
>>> +
>>> +	/* rcu_read_lock() to be added later */
>>> +	pmdval = pmdp_get_lockless(pmd);
>>> +	if (pmdvalp)
>>> +		*pmdvalp = pmdval;
>>> +	if (unlikely(pmd_none(pmdval) || is_pmd_migration_entry(pmdval)))
>>> +		goto nomap;
>>> +	if (unlikely(pmd_trans_huge(pmdval) || pmd_devmap(pmdval)))
>>> +		goto nomap;
>>
>> Will the follow-up patch deal with the above situation specially?
> 
> No, the follow-up patch will only insert the rcu_read_lock() and unlock();
> and do something (something!) about the PAE mismatched halves case.
> 
>> Otherwise, maybe it can be changed to the following check method?
>>
>> 	if (unlikely(pmd_none(pmdval) || pmd_leaf(pmdval)))
>> 		goto nomap;
> 
> Maybe, but I'm not keen.  Partly just because pmd_leaf() is quite a
> (good) new invention (I came across a few instances in updating to
> the current tree), whereas here I'm just following the old examples,
> from zap_pmd_range() etc.  I'd have to spend a while getting to know
> pmd_leaf(), and its interaction with strange gotchas like pmd_present().
> 
> And partly because I do want as many corrupt cases as possible to
> reach the pmd_bad() check below, so generating a warning (and clear).
> I might be wrong, I haven't checked through the architectures and how
> pmd_leaf() is implemented in each, but my guess is that pmd_leaf()
> will tend to miss the pmd_bad() check.

IIUC, pmd_leaf() is just for checking a leaf mapped PMD, and will
not cover pmd_bad() case. Can see the examples in vmalloc_to_page()
and apply_to_pmd_range().

> 
> But if you can demonstrate a performance improvement from using
> pmd_leaf() there, I expect many people would prefer that improvement
> to badness catching: send a patch later to make that change if it's
> justified.

Probably not a lot of performance gain, just makes the check more
concise.

Thanks,
Qi

> 
> Thanks a lot for all your attention to these.
> 
> Hugh
> 
>>
>>> +	if (unlikely(pmd_bad(pmdval))) {
>>> +		pmd_clear_bad(pmd);
>>> +		goto nomap;
>>> +	}
>>> +	return __pte_map(&pmdval, addr);
>>> +nomap:
>>> +	/* rcu_read_unlock() to be added later */
>>> +	return NULL;
>>> +}

-- 
Thanks,
Qi
