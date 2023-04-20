Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35FF06E8B95
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 09:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233971AbjDTHoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 03:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjDTHoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 03:44:10 -0400
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FE940F5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 00:44:08 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VgY3EAD_1681976643;
Received: from 30.240.106.197(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VgY3EAD_1681976643)
          by smtp.aliyun-inc.com;
          Thu, 20 Apr 2023 15:44:05 +0800
Message-ID: <97e79078-69e8-e387-9e77-a4d741eace4e@linux.alibaba.com>
Date:   Thu, 20 Apr 2023 15:44:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH] mm,unmap: avoid flushing TLB in batch if PTE is
 inaccessible
To:     Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel test robot <yujie.liu@intel.com>,
        Nadav Amit <namit@vmware.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>
References: <20230410075224.827740-1-ying.huang@intel.com>
From:   haoxin <xhao@linux.alibaba.com>
In-Reply-To: <20230410075224.827740-1-ying.huang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-12.5 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/4/10 下午3:52, Huang Ying 写道:
> 0Day/LKP reported a performance regression for commit
> 7e12beb8ca2a ("migrate_pages: batch flushing TLB"). In the commit, the
> TLB flushing during page migration is batched.  So, in
> try_to_migrate_one(), ptep_clear_flush() is replaced with
> set_tlb_ubc_flush_pending().  In further investigation, it is found
> that the TLB flushing can be avoided in ptep_clear_flush() if the PTE
> is inaccessible.  In fact, we can optimize in similar way for the
> batched TLB flushing too to improve the performance.
>
> So in this patch, we check pte_accessible() before
> set_tlb_ubc_flush_pending() in try_to_unmap/migrate_one().  Tests show
> that the benchmark score of the anon-cow-rand-mt test case of
> vm-scalability test suite can improve up to 2.1% with the patch on a
> Intel server machine.  The TLB flushing IPI can reduce up to 44.3%.
>
> Link: https://lore.kernel.org/oe-lkp/202303192325.ecbaf968-yujie.liu@intel.com
> Link: https://lore.kernel.org/oe-lkp/ab92aaddf1b52ede15e2c608696c36765a2602c1.camel@intel.com/
> Fixes: 7e12beb8ca2a ("migrate_pages: batch flushing TLB")
> Reported-by: kernel test robot <yujie.liu@intel.com>
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Nadav Amit <namit@vmware.com>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: David Hildenbrand <david@redhat.com>
> ---
>   mm/rmap.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 8632e02661ac..3c7c43642d7c 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1582,7 +1582,8 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>   				 */
>   				pteval = ptep_get_and_clear(mm, address, pvmw.pte);
>   
> -				set_tlb_ubc_flush_pending(mm, pte_dirty(pteval));
> +				if (pte_accessible(mm, pteval))
> +					set_tlb_ubc_flush_pending(mm, pte_dirty(pteval));
>   			} else {
>   				pteval = ptep_clear_flush(vma, address, pvmw.pte);
>   			}
> @@ -1963,7 +1964,8 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
>   				 */
>   				pteval = ptep_get_and_clear(mm, address, pvmw.pte);
>   
> -				set_tlb_ubc_flush_pending(mm, pte_dirty(pteval));
> +				if (pte_accessible(mm, pteval))
> +					set_tlb_ubc_flush_pending(mm, pte_dirty(pteval));

Just a advice, can you put pte_accessible() into 
set_tlb_ubc_flush_pendin(), just like ptep_clear_flush(); so that we no 
need to add  if (pte_accessible()) in per place

where call set_tlb_ubc_flush_pending();

>   			} else {
>   				pteval = ptep_clear_flush(vma, address, pvmw.pte);
>   			}
