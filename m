Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8FE6EC8CF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 11:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbjDXJZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 05:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjDXJZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 05:25:45 -0400
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0B11FDF
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 02:25:40 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0Vgs9aTp_1682328336;
Received: from 30.240.107.177(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0Vgs9aTp_1682328336)
          by smtp.aliyun-inc.com;
          Mon, 24 Apr 2023 17:25:37 +0800
Message-ID: <d531e281-4190-3cb1-d311-035b55376489@linux.alibaba.com>
Date:   Mon, 24 Apr 2023 17:25:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH -V2] mm,unmap: avoid flushing TLB in batch if PTE is
 inaccessible
To:     Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nadav Amit <namit@vmware.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel test robot <yujie.liu@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>
References: <20230424065408.188498-1-ying.huang@intel.com>
From:   haoxin <xhao@linux.alibaba.com>
In-Reply-To: <20230424065408.188498-1-ying.huang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.1 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/4/24 下午2:54, Huang Ying 写道:
> Hi, Andrew,
>
> The version 1 of this patch was merged in mm-unstable branch.  If you
> want to move that patch into mm-stable recently, it may be better to
> update that patch with this new version firstly.  If you want to do
> that after v6.4-rc1, I will rebase this patch and resend it after
> v6.4-rc1 is released.
>
> Hi, Amit,
>
> The patch has been changed based on comments from Xin.  I keep your
> "reviewed-by" because I think the change is trivial.  But if you think
> it's inappropriate,  I will change that.
>
> Best Regards,
> Huang, Ying
>
> ------------------------------->8------------------------------------------
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
> Reviewed-by: Nadav Amit <namit@vmware.com>
> Cc: haoxin <xhao@linux.alibaba.com>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: David Hildenbrand <david@redhat.com>
> ---
>   mm/rmap.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 8632e02661ac..be19232e94f4 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -641,10 +641,14 @@ void try_to_unmap_flush_dirty(void)
>   #define TLB_FLUSH_BATCH_PENDING_LARGE			\
>   	(TLB_FLUSH_BATCH_PENDING_MASK / 2)
>   
> -static void set_tlb_ubc_flush_pending(struct mm_struct *mm, bool writable)
> +static void set_tlb_ubc_flush_pending(struct mm_struct *mm, pte_t pteval)
>   {
>   	struct tlbflush_unmap_batch *tlb_ubc = &current->tlb_ubc;
>   	int batch, nbatch;
> +	bool writable = pte_dirty(pteval);
> +
> +	if (!pte_accessible(mm, pteval))
> +		return;

LGTM

Reviewed-by: Xin Hao <xhao@linux.alibaba.com>

>   
>   	arch_tlbbatch_add_mm(&tlb_ubc->arch, mm);
>   	tlb_ubc->flush_required = true;
> @@ -731,7 +735,7 @@ void flush_tlb_batched_pending(struct mm_struct *mm)
>   	}
>   }
>   #else
> -static void set_tlb_ubc_flush_pending(struct mm_struct *mm, bool writable)
> +static void set_tlb_ubc_flush_pending(struct mm_struct *mm, pte_t pteval)
>   {
>   }
>   
> @@ -1582,7 +1586,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>   				 */
>   				pteval = ptep_get_and_clear(mm, address, pvmw.pte);
>   
> -				set_tlb_ubc_flush_pending(mm, pte_dirty(pteval));
> +				set_tlb_ubc_flush_pending(mm, pteval);
>   			} else {
>   				pteval = ptep_clear_flush(vma, address, pvmw.pte);
>   			}
> @@ -1963,7 +1967,7 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
>   				 */
>   				pteval = ptep_get_and_clear(mm, address, pvmw.pte);
>   
> -				set_tlb_ubc_flush_pending(mm, pte_dirty(pteval));
> +				set_tlb_ubc_flush_pending(mm, pteval);
>   			} else {
>   				pteval = ptep_clear_flush(vma, address, pvmw.pte);
>   			}
