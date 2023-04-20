Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417C26E8CF3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 10:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234476AbjDTIjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 04:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbjDTIjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 04:39:12 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DCA94221
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 01:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681979951; x=1713515951;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=wVsnGwgAugAJ2fpRYz24Pugal7xVqOqt6LioUkpqN9k=;
  b=a3XzXK3MO8A/nAXk+bjttV/B4xXyw7GxvekH/spqjFauvsF8IGPYrmiu
   aErrqOqgWGffdT+pp1g3P/RSOVezDqvSvUM+4R4x2sE4YIKc9ZkNcfMu3
   XLmJ7iDcXn1vFFBhkInIGEF8e3Jh9OW9kFnOhhytlIXTYqx2jexWsCvG0
   7D9Pp6VKDWdEmXiqoj5NJWfdFSXGNDizXq+eoQK5EFJtnmla92awUfrZI
   iJdoODDiaiA7Cd8H8iJa9qENdmokBTj9/qICAhLfsKAj13Be+lzhDHhBj
   802NUpggac5G1ws4+N6R/R2asLOW/3dhPquXOt4egiENWdMN65lTBFvHE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="408587383"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="408587383"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 01:39:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="803270633"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="803270633"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 01:39:08 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     haoxin <xhao@linux.alibaba.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        kernel test robot <yujie.liu@intel.com>,
        Nadav Amit <namit@vmware.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Hugh Dickins <hughd@google.com>,
        "Matthew Wilcox" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] mm,unmap: avoid flushing TLB in batch if PTE is
 inaccessible
References: <20230410075224.827740-1-ying.huang@intel.com>
        <97e79078-69e8-e387-9e77-a4d741eace4e@linux.alibaba.com>
Date:   Thu, 20 Apr 2023 16:38:03 +0800
In-Reply-To: <97e79078-69e8-e387-9e77-a4d741eace4e@linux.alibaba.com>
        (haoxin's message of "Thu, 20 Apr 2023 15:44:03 +0800")
Message-ID: <878rent0d0.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

haoxin <xhao@linux.alibaba.com> writes:

> ( 2023/4/10 H3:52, Huang Ying S:
>> 0Day/LKP reported a performance regression for commit
>> 7e12beb8ca2a ("migrate_pages: batch flushing TLB"). In the commit, the
>> TLB flushing during page migration is batched.  So, in
>> try_to_migrate_one(), ptep_clear_flush() is replaced with
>> set_tlb_ubc_flush_pending().  In further investigation, it is found
>> that the TLB flushing can be avoided in ptep_clear_flush() if the PTE
>> is inaccessible.  In fact, we can optimize in similar way for the
>> batched TLB flushing too to improve the performance.
>>
>> So in this patch, we check pte_accessible() before
>> set_tlb_ubc_flush_pending() in try_to_unmap/migrate_one().  Tests show
>> that the benchmark score of the anon-cow-rand-mt test case of
>> vm-scalability test suite can improve up to 2.1% with the patch on a
>> Intel server machine.  The TLB flushing IPI can reduce up to 44.3%.
>>
>> Link: https://lore.kernel.org/oe-lkp/202303192325.ecbaf968-yujie.liu@intel.com
>> Link: https://lore.kernel.org/oe-lkp/ab92aaddf1b52ede15e2c608696c36765a2602c1.camel@intel.com/
>> Fixes: 7e12beb8ca2a ("migrate_pages: batch flushing TLB")
>> Reported-by: kernel test robot <yujie.liu@intel.com>
>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>> Cc: Nadav Amit <namit@vmware.com>
>> Cc: Mel Gorman <mgorman@techsingularity.net>
>> Cc: Hugh Dickins <hughd@google.com>
>> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
>> Cc: David Hildenbrand <david@redhat.com>
>> ---
>>   mm/rmap.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/rmap.c b/mm/rmap.c
>> index 8632e02661ac..3c7c43642d7c 100644
>> --- a/mm/rmap.c
>> +++ b/mm/rmap.c
>> @@ -1582,7 +1582,8 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>>   				 */
>>   				pteval = ptep_get_and_clear(mm, address, pvmw.pte);
>>   -				set_tlb_ubc_flush_pending(mm,
>> pte_dirty(pteval));
>> +				if (pte_accessible(mm, pteval))
>> +					set_tlb_ubc_flush_pending(mm, pte_dirty(pteval));
>>   			} else {
>>   				pteval = ptep_clear_flush(vma, address, pvmw.pte);
>>   			}
>> @@ -1963,7 +1964,8 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
>>   				 */
>>   				pteval = ptep_get_and_clear(mm, address, pvmw.pte);
>>   -				set_tlb_ubc_flush_pending(mm,
>> pte_dirty(pteval));
>> +				if (pte_accessible(mm, pteval))
>> +					set_tlb_ubc_flush_pending(mm, pte_dirty(pteval));
>
> Just a advice, can you put pte_accessible() into
> set_tlb_ubc_flush_pendin(), just like ptep_clear_flush(); so that we
> no need to add if (pte_accessible()) in per place
>
> where call set_tlb_ubc_flush_pending();

Sounds reasonable for me, will do that in the next version.  Thanks for
suggestion.

Best Regards,
Huang, Ying

>>   			} else {
>>   				pteval = ptep_clear_flush(vma, address, pvmw.pte);
>>   			}
