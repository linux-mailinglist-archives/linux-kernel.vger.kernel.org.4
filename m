Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4DA15E8BD0
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 13:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233563AbiIXLnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 07:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233501AbiIXLnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 07:43:22 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA7F115F51
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 04:43:19 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MZRqt5Rb7z1P6rB;
        Sat, 24 Sep 2022 19:39:06 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 24 Sep 2022 19:43:17 +0800
Subject: Re: [PATCH v3 1/4] mm,hwpoison,hugetlb,memory_hotplug: hotremove
 memory section with hwpoisoned hugepage
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>, <linux-mm@kvack.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Jane Chu <jane.chu@oracle.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        <linux-kernel@vger.kernel.org>
References: <20220921091359.25889-1-naoya.horiguchi@linux.dev>
 <20220921091359.25889-2-naoya.horiguchi@linux.dev>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <91a4759f-88e4-f9ac-aff5-41d2db5ecfdd@huawei.com>
Date:   Sat, 24 Sep 2022 19:43:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220921091359.25889-2-naoya.horiguchi@linux.dev>
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

On 2022/9/21 17:13, Naoya Horiguchi wrote:
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 
> HWPoisoned page is not supposed to be accessed once marked, but currently
> such accesses can happen during memory hotremove because do_migrate_range()
> can be called before dissolve_free_huge_pages() is called.
> 
> Clear HPageMigratable for hwpoisoned hugepages to prevent them from being
> migrated.  This should be done in hugetlb_lock to avoid race against
> isolate_hugetlb().
> 
> get_hwpoison_huge_page() needs to have a flag to show it's called from
> unpoison to take refcount of hwpoisoned hugepages, so add it.
> 
> Reported-by: Miaohe Lin <linmiaohe@huawei.com>
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>

Thanks for your work, Naoya. Maybe something to improve below.

> ---
> ChangeLog v2 -> v3
> - move to the approach of clearing HPageMigratable instead of shifting
>   dissolve_free_huge_pages.
> ---
>  include/linux/hugetlb.h |  4 ++--
>  mm/hugetlb.c            |  4 ++--
>  mm/memory-failure.c     | 12 ++++++++++--
>  3 files changed, 14 insertions(+), 6 deletions(-)
> 

<snip>

> @@ -7267,7 +7267,7 @@ int get_hwpoison_huge_page(struct page *page, bool *hugetlb)
>  		*hugetlb = true;
>  		if (HPageFreed(page))
>  			ret = 0;
> -		else if (HPageMigratable(page))
> +		else if (HPageMigratable(page) || unpoison)

Is unpoison_memory() expected to restore the HPageMigratable flag as well ?

>  			ret = get_page_unless_zero(page);
>  		else
>  			ret = -EBUSY;
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 145bb561ddb3..5942e1c0407e 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1244,7 +1244,7 @@ static int __get_hwpoison_page(struct page *page, unsigned long flags)
>  	int ret = 0;
>  	bool hugetlb = false;
>  
> -	ret = get_hwpoison_huge_page(head, &hugetlb);
> +	ret = get_hwpoison_huge_page(head, &hugetlb, false);
>  	if (hugetlb)
>  		return ret;
>  
> @@ -1334,7 +1334,7 @@ static int __get_unpoison_page(struct page *page)
>  	int ret = 0;
>  	bool hugetlb = false;
>  
> -	ret = get_hwpoison_huge_page(head, &hugetlb);
> +	ret = get_hwpoison_huge_page(head, &hugetlb, true);
>  	if (hugetlb)
>  		return ret;
>  
> @@ -1815,6 +1815,13 @@ int __get_huge_page_for_hwpoison(unsigned long pfn, int flags)
>  		goto out;
>  	}
>  
> +	/*
> +	 * Clearing HPageMigratable for hwpoisoned hugepages to prevent them
> +	 * from being migrated by memory hotremove.
> +	 */
> +	if (count_increased)
> +		ClearHPageMigratable(head);

I believe this can prevent hwpoisoned hugepages from being migrated though there still be some windows.

> +
>  	return ret;
>  out:
>  	if (count_increased)
> @@ -1862,6 +1869,7 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
>  
>  	if (hwpoison_filter(p)) {
>  		hugetlb_clear_page_hwpoison(head);
> +		SetHPageMigratable(head);

Would we set HPageMigratable flag for free hugetlb pages here? IIUC, they're not expected to have this flag set.

Thanks,
Miaohe Lin

>  		unlock_page(head);
>  		if (res == 1)
>  			put_page(head);
> 

