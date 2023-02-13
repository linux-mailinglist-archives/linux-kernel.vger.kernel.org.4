Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA02694B26
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 16:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbjBMP2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 10:28:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbjBMP2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 10:28:14 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E7BB773
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 07:28:10 -0800 (PST)
Received: (Authenticated sender: alex@ghiti.fr)
        by mail.gandi.net (Postfix) with ESMTPSA id B0844C0004;
        Mon, 13 Feb 2023 15:28:05 +0000 (UTC)
Message-ID: <3a3457b1-60bc-a97b-0042-432790d3bbbe@ghiti.fr>
Date:   Mon, 13 Feb 2023 16:28:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/2] mm/khugepaged: Convert release_pte_pages() to use
 folios
Content-Language: en-US
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
References: <20230114001556.43795-1-vishal.moola@gmail.com>
 <20230114001556.43795-2-vishal.moola@gmail.com>
 <CGME20230213085312eucas1p2252fe07e3eadea5e2a80dfdd3aa96507@eucas1p2.samsung.com>
 <ff300770-afe9-908d-23ed-d23e0796e899@samsung.com>
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <ff300770-afe9-908d-23ed-d23e0796e899@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/13/23 09:53, Marek Szyprowski wrote:
> Hi,
>
> On 14.01.2023 01:15, Vishal Moola (Oracle) wrote:
>> Converts release_pte_pages() to use folios instead of pages.
>>
>> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> This patch has been merged some time ago to linux-next as commit
> 9bdfeea46f49 ("mm/khugepaged: convert release_pte_pages() to use
> folios"). It took me a while to bisect this (mainly because I was busy
> with other things), but I finally found that this change is responsible
> for the following kernel panic:
>
> Unable to handle kernel paging request at virtual address fffffc0000000008
> Mem abort info:
>     ESR = 0x0000000096000006
>     EC = 0x25: DABT (current EL), IL = 32 bits
>     SET = 0, FnV = 0
>     EA = 0, S1PTW = 0
>     FSC = 0x06: level 2 translation fault
> Data abort info:
>     ISV = 0, ISS = 0x00000006
>     CM = 0, WnR = 0
> swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000021efa000
> [fffffc0000000008] pgd=10000000df05a003, p4d=10000000df05a003,
> pud=10000000df059003, pmd=0000000000000000
> Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
> Modules linked in: ip_tables x_tables ipv6
> CPU: 7 PID: 61 Comm: khugepaged Not tainted 6.2.0-rc4+ #13307
> Hardware name: Samsung TM2E board (DT)
> pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : hpage_collapse_scan_pmd+0x12ec/0x1a20
> lr : hpage_collapse_scan_pmd+0x14b0/0x1a20
> sp : ffff80000be13c20
> x29: ffff80000be13c20 x28: 0000000000000001 x27: fffffc0000d3f5c0
> x26: fffffc0000d3f600 x25: 00000000000001f9 x24: 0000000000000007
> x23: ffff0000296f9dd8 x22: ffff800009e5b490 x21: 0000000000000000
> x20: 000000000000000f x19: ffff80000a9d0000 x18: ffff80000af52e58
> x17: 0000000000000028 x16: 0000000000009249 x15: ffff80000af971f8
> x14: 0000000000000000 x13: 00000000000443a0 x12: 0000000000040000
> x11: 000000000fffffff x10: ffff000024928880 x9 : ffff80000b5c6e98
> x8 : ffff000024928000 x7 : 00000000b35d04b9 x6 : 0000000000000000
> x5 : fffffc0000000000 x4 : ffff8000cbf2e000 x3 : 0000000000000000
> x2 : 0000000000000000 x1 : 0000000000000000 x0 : fffffc0000000000
> Call trace:
>    hpage_collapse_scan_pmd+0x12ec/0x1a20
>    khugepaged+0x7e0/0x8dc
>    kthread+0x118/0x11c
>    ret_from_fork+0x10/0x20
> Code: d34cbc43 cb813061 d37ae421 8b050020 (f9400404)
> ---[ end trace 0000000000000000 ]---
> Kernel panic - not syncing: Oops: Fatal exception
> SMP: stopping secondary CPUs
> Kernel Offset: disabled
> CPU features: 0x8c000,41c78100,0000421b
> Memory Limit: none
> ---[ end Kernel panic - not syncing: Oops: Fatal exception ]---
>
>
> Reverting it on top of recent linux-next fixes the issue, so it looks
> that some kind of a corner case is missing in this patch. I can
> reproduce it usually during the system shutdown, 1 of 20 times on the
> average.


I have debugging this issue since this morning too!


>
>> ---
>>    mm/khugepaged.c | 14 +++++++-------
>>    1 file changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index 4888e8688401..27d010431ece 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -509,20 +509,20 @@ static void release_pte_page(struct page *page)
>>    static void release_pte_pages(pte_t *pte, pte_t *_pte,
>>    		struct list_head *compound_pagelist)
>>    {
>> -	struct page *page, *tmp;
>> +	struct folio *folio, *tmp;
>>    
>>    	while (--_pte >= pte) {
>>    		pte_t pteval = *_pte;
>>    
>> -		page = pte_page(pteval);
>> +		folio = pfn_folio(pte_pfn(pteval));


The issue lies here: before using pteval in pfn_folio(), we should test 
it. The following patch fixes the issue for me:

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index eb38bd1b1b2f..fef3414b481b 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -514,10 +514,12 @@ static void release_pte_pages(pte_t *pte, pte_t *_pte,
         while (--_pte >= pte) {
                 pte_t pteval = *_pte;

-               folio = pfn_folio(pte_pfn(pteval));
-               if (!pte_none(pteval) && !is_zero_pfn(pte_pfn(pteval)) &&
-                               !folio_test_large(folio))
-                       release_pte_folio(folio);
+               if (!pte_none(pteval) && !is_zero_pfn(pte_pfn(pteval))) {
+                       folio = pfn_folio(pte_pfn(pteval));
+
+                       if (!folio_test_large(folio))
+                               release_pte_folio(folio);
+               }
         }

         list_for_each_entry_safe(folio, tmp, compound_pagelist, lru) {


@Marek: could you give it a try?

I can send a separate patch if needed, let me know.

Thanks,

Alex


>>    		if (!pte_none(pteval) && !is_zero_pfn(pte_pfn(pteval)) &&
>> -				!PageCompound(page))
>> -			release_pte_page(page);
>> +				!folio_test_large(folio))
>> +			release_pte_folio(folio);
>>    	}
>>    
>> -	list_for_each_entry_safe(page, tmp, compound_pagelist, lru) {
>> -		list_del(&page->lru);
>> -		release_pte_page(page);
>> +	list_for_each_entry_safe(folio, tmp, compound_pagelist, lru) {
>> +		list_del(&folio->lru);
>> +		release_pte_folio(folio);
>>    	}
>>    }
>>    
> Best regards
