Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32AD35E8BC1
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 13:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233351AbiIXLUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 07:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiIXLUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 07:20:11 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CAB02B1B7
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 04:20:07 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MZRK567xNzlWkK;
        Sat, 24 Sep 2022 19:15:53 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 24 Sep 2022 19:20:04 +0800
Subject: Re: [PATCH v3] hugetlb: freeze allocated pages before creating
 hugetlb pages
To:     Mike Kravetz <mike.kravetz@oracle.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     Muchun Song <songmuchun@bytedance.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Vlastimil Babka <vbabka@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220921202702.106069-1-mike.kravetz@oracle.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <e3029440-bc9d-910a-81b6-39d0d725deaf@huawei.com>
Date:   Sat, 24 Sep 2022 19:20:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220921202702.106069-1-mike.kravetz@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/9/22 4:27, Mike Kravetz wrote:
> When creating hugetlb pages, the hugetlb code must first allocate
> contiguous pages from a low level allocator such as buddy, cma or
> memblock.  The pages returned from these low level allocators are
> ref counted.  This creates potential issues with other code taking
> speculative references on these pages before they can be transformed to
> a hugetlb page.  This issue has been addressed with methods and code
> such as that provided in [1].
> 
> Recent discussions about vmemmap freeing [2] have indicated that it
> would be beneficial to freeze all sub pages, including the head page
> of pages returned from low level allocators before converting to a
> hugetlb page.  This helps avoid races if we want to replace the page
> containing vmemmap for the head page.
> 
> There have been proposals to change at least the buddy allocator to
> return frozen pages as described at [3].  If such a change is made, it
> can be employed by the hugetlb code.  However, as mentioned above
> hugetlb uses several low level allocators so each would need to be
> modified to return frozen pages.  For now, we can manually freeze the
> returned pages.  This is done in two places:
> 1) alloc_buddy_huge_page, only the returned head page is ref counted.
>    We freeze the head page, retrying once in the VERY rare case where
>    there may be an inflated ref count.
> 2) prep_compound_gigantic_page, for gigantic pages the current code
>    freezes all pages except the head page.  New code will simply freeze
>    the head page as well.
> 
> In a few other places, code checks for inflated ref counts on newly
> allocated hugetlb pages.  With the modifications to freeze after
> allocating, this code can be removed.
> 
> After hugetlb pages are freshly allocated, they are often added to the
> hugetlb free lists.  Since these pages were previously ref counted, this
> was done via put_page() which would end up calling the hugetlb
> destructor: free_huge_page.  With changes to freeze pages, we simply
> call free_huge_page directly to add the pages to the free list.
> 
> In a few other places, freshly allocated hugetlb pages were immediately
> put into use, and the expectation was they were already ref counted.  In
> these cases, we must manually ref count the page.
> 
> [1] https://lore.kernel.org/linux-mm/20210622021423.154662-3-mike.kravetz@oracle.com/
> [2] https://lore.kernel.org/linux-mm/20220802180309.19340-1-joao.m.martins@oracle.com/
> [3] https://lore.kernel.org/linux-mm/20220809171854.3725722-1-willy@infradead.org/
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Thanks Mike. The code looks more simple.

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks,
Miaohe Lin

