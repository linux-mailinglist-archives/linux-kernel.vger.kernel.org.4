Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E48693FFB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 09:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjBMIxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 03:53:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBMIxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 03:53:17 -0500
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63138A48
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 00:53:15 -0800 (PST)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230213085313euoutp027424809335aef30b247089026befcbba~DVlFThI_80942209422euoutp02S
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 08:53:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230213085313euoutp027424809335aef30b247089026befcbba~DVlFThI_80942209422euoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1676278393;
        bh=+SqajmR+I5NIfpJRvMOToYE4VoD57qk+JqrmWZZLzHs=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=pRe7Id7jJXrS7E1dja7a6gqIvgPZdzpR4xtwnkMFCgbQzrxqvwy/OUHuFkXFgSSNG
         oEgtPC/BQnikZCS7dz4y7JVFhdc5QuFXKN2/2hhATZ51QTm13puQ9fy5peCCAkdvry
         iSVI27EbFkbX95oTnlvYOOg8dJ48m76+QRRLRs3k=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230213085313eucas1p290167779d460b3205c5094cb4090a13f~DVlEyQgP40995909959eucas1p21;
        Mon, 13 Feb 2023 08:53:12 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 3F.00.61197.87AF9E36; Mon, 13
        Feb 2023 08:53:12 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230213085312eucas1p2252fe07e3eadea5e2a80dfdd3aa96507~DVlERw9tO3157531575eucas1p2x;
        Mon, 13 Feb 2023 08:53:12 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230213085312eusmtrp12c81987db3bacf9084fcc2791227bb5f~DVlERDVFv1542615426eusmtrp1K;
        Mon, 13 Feb 2023 08:53:12 +0000 (GMT)
X-AuditID: cbfec7f5-7c5ff7000000ef0d-d4-63e9fa789cf6
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 4E.22.02722.87AF9E36; Mon, 13
        Feb 2023 08:53:12 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230213085312eusmtip2e96e0856a2cf9e94bcca3d4267f98a61~DVlD4V4Uu1939519395eusmtip2Z;
        Mon, 13 Feb 2023 08:53:12 +0000 (GMT)
Message-ID: <ff300770-afe9-908d-23ed-d23e0796e899@samsung.com>
Date:   Mon, 13 Feb 2023 09:53:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
        Gecko/20100101 Thunderbird/102.7.1
Subject: Re: [PATCH 2/2] mm/khugepaged: Convert release_pte_pages() to use
 folios
Content-Language: en-US
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20230114001556.43795-2-vishal.moola@gmail.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsWy7djPc7oVv14mG5ybY2wxZ/0aNovLu+aw
        Wdxb85/V4uP+YIv1+26wWvz+MYfNgc1j56y77B6bV2h5bPo0id3jxIzfLB4fn95i8fi8SS6A
        LYrLJiU1J7MstUjfLoErY/rbc6wFj+Qqnv25xtbAuECyi5GTQ0LAROL34qmMXYxcHEICKxgl
        mm9tZANJCAl8YZRYPZ8ZIvGZUeL+jaPsXYwcYB23dipCxJczSjTOeg5V9JFRYsLleawg3bwC
        dhL7nzcxgdgsAqoSRz9eYIaIC0qcnPmEBcQWFUiRmN45kxVkqLBAsMSsj5UgYWYBcYlbT+aD
        tYoIeEgcOXcI7DpmgdmMEv3dk9hBEmwChhJdb7vYQHo5BWwkJrxngeiVl2jeOhvsHgmBBxwS
        6x5uZYF400Vi2uIbTBC2sMSr41vYIWwZidOTe1ggGtoZJRb8vs8E4UxglGh4fosRospa4s65
        X2DbmAU0Jdbv0oeEhKNEz78aCJNP4sZbQYgb+CQmbZvODBHmlehoE4KYoSYx6/g6uK0HL1xi
        nsCoNAspUGYh+X4Wkm9mIaxdwMiyilE8tbQ4Nz212DgvtVyvODG3uDQvXS85P3cTIzD1nP53
        /OsOxhWvPuodYmTiYDzEKMHBrCTCK/z0RbIQb0piZVVqUX58UWlOavEhRmkOFiVxXm3bk8lC
        AumJJanZqakFqUUwWSYOTqkGpoWfNgicqDTbaXZ/5spvsWsL1ppMt2afZWQ/fSF/7/STK1gu
        TZXbs2ECY7ffQn2+VUpfQ25Ndmj/lzCzb+PqdfrhyUIHY+6v2CMwh3vVNNv+tQ5/uDMTl9fH
        qch1Lzt/9bv45kdH9NU9ApcoTn42v/Rd/+6l7oz/VjLJC5bVJsTsnnuucOdsB7vaPVfy9lRb
        t5j9s9y+dNoX19OSd94u9qq5XemQ0Psr5KL/rHreKzt7TqZ15D1dO7FufW5l3KKZZyQTlt+8
        f2h5S43p5mDr7bsYUk7YVmYnHlBQtfRmYnz1OjBsarDm4lc99265sFf068xcnZPzqd/Zro5j
        4i+GKU9WMQbKVSwp/tf7NvT/4vlKLMUZiYZazEXFiQBcmPSxrAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNIsWRmVeSWpSXmKPExsVy+t/xe7oVv14mG7Q+lLKYs34Nm8XlXXPY
        LO6t+c9q8XF/sMX6fTdYLX7/mMPmwOaxc9Zddo/NK7Q8Nn2axO5xYsZvFo+PT2+xeHzeJBfA
        FqVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CXMf3t
        OdaCR3IVz/5cY2tgXCDZxcjBISFgInFrp2IXIxeHkMBSRoktCw+zdDFyAsVlJE5Oa2CFsIUl
        /lzrYgOxhQTeM0o8f64PYvMK2Ensf97EBGKzCKhKHP14gRkiLihxcuYTsDmiAikSu9YdZwXZ
        JSwQLDHrYyVImFlAXOLWk/lgrSICHhJHzh1iBLmBWWA2o8SmjbuhduVKnFzeDVbEJmAo0fUW
        5AYODk4BG4kJ71kg5phJdG3tYoSw5SWat85mnsAoNAvJFbOQrJuFpGUWkpYFjCyrGEVSS4tz
        03OLDfWKE3OLS/PS9ZLzczcxAmNt27Gfm3cwznv1Ue8QIxMH4yFGCQ5mJRFe4acvkoV4UxIr
        q1KL8uOLSnNSiw8xmgKDYiKzlGhyPjDa80riDc0MTA1NzCwNTC3NjJXEeT0LOhKFBNITS1Kz
        U1MLUotg+pg4OKUamJbdms8YH2/m9cZZuJq9rnt+xK8P6TOWhv/KZJO+sOZS/Hf/K4v/hdlW
        NX2Y1Ptj76yWDZzz339yOla56M/hDzoPOQRepstaTXukHbdr90J2zXP/j5lz5Vw8mZUygfe8
        +Z20lHcLX5yYf/QE18/NbjwnD7M7+/s/9V8nNb1++pOVmf6MTfP6mefkKs9iyTivlfRV++O8
        0nvaTjqZ+SZzE5kVrvusKO/K5lU+b7ok0WmZc8u5C6dC92nzFl5hllr6XbfL2Onezz5nfitb
        f7WSBUGLnTW+Ou87cTL4clWnot8eX23305M104Q8k4onBPjlms2balWut+XB1hW/9O5JLDh3
        Yt60/R+K7Cc33PFyzVZiKc5INNRiLipOBAA20ydBPgMAAA==
X-CMS-MailID: 20230213085312eucas1p2252fe07e3eadea5e2a80dfdd3aa96507
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230213085312eucas1p2252fe07e3eadea5e2a80dfdd3aa96507
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230213085312eucas1p2252fe07e3eadea5e2a80dfdd3aa96507
References: <20230114001556.43795-1-vishal.moola@gmail.com>
        <20230114001556.43795-2-vishal.moola@gmail.com>
        <CGME20230213085312eucas1p2252fe07e3eadea5e2a80dfdd3aa96507@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 14.01.2023 01:15, Vishal Moola (Oracle) wrote:
> Converts release_pte_pages() to use folios instead of pages.
>
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

This patch has been merged some time ago to linux-next as commit 
9bdfeea46f49 ("mm/khugepaged: convert release_pte_pages() to use 
folios"). It took me a while to bisect this (mainly because I was busy 
with other things), but I finally found that this change is responsible 
for the following kernel panic:

Unable to handle kernel paging request at virtual address fffffc0000000008
Mem abort info:
   ESR = 0x0000000096000006
   EC = 0x25: DABT (current EL), IL = 32 bits
   SET = 0, FnV = 0
   EA = 0, S1PTW = 0
   FSC = 0x06: level 2 translation fault
Data abort info:
   ISV = 0, ISS = 0x00000006
   CM = 0, WnR = 0
swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000021efa000
[fffffc0000000008] pgd=10000000df05a003, p4d=10000000df05a003, 
pud=10000000df059003, pmd=0000000000000000
Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
Modules linked in: ip_tables x_tables ipv6
CPU: 7 PID: 61 Comm: khugepaged Not tainted 6.2.0-rc4+ #13307
Hardware name: Samsung TM2E board (DT)
pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : hpage_collapse_scan_pmd+0x12ec/0x1a20
lr : hpage_collapse_scan_pmd+0x14b0/0x1a20
sp : ffff80000be13c20
x29: ffff80000be13c20 x28: 0000000000000001 x27: fffffc0000d3f5c0
x26: fffffc0000d3f600 x25: 00000000000001f9 x24: 0000000000000007
x23: ffff0000296f9dd8 x22: ffff800009e5b490 x21: 0000000000000000
x20: 000000000000000f x19: ffff80000a9d0000 x18: ffff80000af52e58
x17: 0000000000000028 x16: 0000000000009249 x15: ffff80000af971f8
x14: 0000000000000000 x13: 00000000000443a0 x12: 0000000000040000
x11: 000000000fffffff x10: ffff000024928880 x9 : ffff80000b5c6e98
x8 : ffff000024928000 x7 : 00000000b35d04b9 x6 : 0000000000000000
x5 : fffffc0000000000 x4 : ffff8000cbf2e000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : fffffc0000000000
Call trace:
  hpage_collapse_scan_pmd+0x12ec/0x1a20
  khugepaged+0x7e0/0x8dc
  kthread+0x118/0x11c
  ret_from_fork+0x10/0x20
Code: d34cbc43 cb813061 d37ae421 8b050020 (f9400404)
---[ end trace 0000000000000000 ]---
Kernel panic - not syncing: Oops: Fatal exception
SMP: stopping secondary CPUs
Kernel Offset: disabled
CPU features: 0x8c000,41c78100,0000421b
Memory Limit: none
---[ end Kernel panic - not syncing: Oops: Fatal exception ]---


Reverting it on top of recent linux-next fixes the issue, so it looks 
that some kind of a corner case is missing in this patch. I can 
reproduce it usually during the system shutdown, 1 of 20 times on the 
average.


> ---
>   mm/khugepaged.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 4888e8688401..27d010431ece 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -509,20 +509,20 @@ static void release_pte_page(struct page *page)
>   static void release_pte_pages(pte_t *pte, pte_t *_pte,
>   		struct list_head *compound_pagelist)
>   {
> -	struct page *page, *tmp;
> +	struct folio *folio, *tmp;
>   
>   	while (--_pte >= pte) {
>   		pte_t pteval = *_pte;
>   
> -		page = pte_page(pteval);
> +		folio = pfn_folio(pte_pfn(pteval));
>   		if (!pte_none(pteval) && !is_zero_pfn(pte_pfn(pteval)) &&
> -				!PageCompound(page))
> -			release_pte_page(page);
> +				!folio_test_large(folio))
> +			release_pte_folio(folio);
>   	}
>   
> -	list_for_each_entry_safe(page, tmp, compound_pagelist, lru) {
> -		list_del(&page->lru);
> -		release_pte_page(page);
> +	list_for_each_entry_safe(folio, tmp, compound_pagelist, lru) {
> +		list_del(&folio->lru);
> +		release_pte_folio(folio);
>   	}
>   }
>   

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

