Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053E25FF7F4
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 03:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiJOB6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 21:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJOB6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 21:58:15 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D245781685
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 18:58:12 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Mq5rh0FyczVj74;
        Sat, 15 Oct 2022 09:53:40 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 15 Oct 2022 09:58:10 +0800
Subject: Re: [PATCH v6 1/4] mm,hwpoison,hugetlb,memory_hotplug: hotremove
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
References: <20221007010706.2916472-1-naoya.horiguchi@linux.dev>
 <20221007010706.2916472-2-naoya.horiguchi@linux.dev>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <b2658c5d-2ae3-e6ea-393b-56d54498a9ee@huawei.com>
Date:   Sat, 15 Oct 2022 09:58:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20221007010706.2916472-2-naoya.horiguchi@linux.dev>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/7 9:07, Naoya Horiguchi wrote:
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

Sorry for late respond. I was spending a busy week. :) And thanks for your work, Naoya.

> ---
> ChangeLog v3 -> v6:
> - introduce migratable_cleared to remember that HPageMigratable is
>   cleared in error handling.  It's needed to cancel when an error event
>   is filtered by hwpoison_filter(). (Thanks to Miaohe)
> 
> ChangeLog v2 -> v3
> - move to the approach of clearing HPageMigratable instead of shifting
>   dissolve_free_huge_pages.
> ---
>  include/linux/hugetlb.h | 10 ++++++----
>  include/linux/mm.h      |  6 ++++--
>  mm/hugetlb.c            |  9 +++++----
>  mm/memory-failure.c     | 21 +++++++++++++++++----
>  4 files changed, 32 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 32d45e96a894..19b99ff7fea0 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -183,8 +183,9 @@ bool hugetlb_reserve_pages(struct inode *inode, long from, long to,
>  long hugetlb_unreserve_pages(struct inode *inode, long start, long end,
>  						long freed);
>  int isolate_hugetlb(struct page *page, struct list_head *list);
> -int get_hwpoison_huge_page(struct page *page, bool *hugetlb);
> -int get_huge_page_for_hwpoison(unsigned long pfn, int flags);
> +int get_hwpoison_huge_page(struct page *page, bool *hugetlb, bool unpoison);
> +int get_huge_page_for_hwpoison(unsigned long pfn, int flags,
> +				bool *migratable_cleared);
>  void putback_active_hugepage(struct page *page);
>  void move_hugetlb_state(struct page *oldpage, struct page *newpage, int reason);
>  void free_huge_page(struct page *page);
> @@ -391,12 +392,13 @@ static inline int isolate_hugetlb(struct page *page, struct list_head *list)
>  	return -EBUSY;
>  }
>  
> -static inline int get_hwpoison_huge_page(struct page *page, bool *hugetlb)
> +static inline int get_hwpoison_huge_page(struct page *page, bool *hugetlb, bool unpoison)
>  {
>  	return 0;
>  }
>  
> -static inline int get_huge_page_for_hwpoison(unsigned long pfn, int flags)
> +static inline int get_huge_page_for_hwpoison(unsigned long pfn, int flags,
> +					bool *migratable_cleared)
>  {
>  	return 0;
>  }
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 8bbcccbc5565..3264bf993ad8 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3277,9 +3277,11 @@ extern void shake_page(struct page *p);
>  extern atomic_long_t num_poisoned_pages __read_mostly;
>  extern int soft_offline_page(unsigned long pfn, int flags);
>  #ifdef CONFIG_MEMORY_FAILURE
> -extern int __get_huge_page_for_hwpoison(unsigned long pfn, int flags);
> +extern int __get_huge_page_for_hwpoison(unsigned long pfn, int flags,
> +					bool *migratable_cleared);
>  #else
> -static inline int __get_huge_page_for_hwpoison(unsigned long pfn, int flags)
> +static inline int __get_huge_page_for_hwpoison(unsigned long pfn, int flags,
> +					bool *migratable_cleared)
>  {
>  	return 0;
>  }
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 63fe47a0240a..0e482dfaf92e 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -7253,7 +7253,7 @@ int isolate_hugetlb(struct page *page, struct list_head *list)
>  	return ret;
>  }
>  
> -int get_hwpoison_huge_page(struct page *page, bool *hugetlb)
> +int get_hwpoison_huge_page(struct page *page, bool *hugetlb, bool unpoison)
>  {
>  	int ret = 0;
>  
> @@ -7263,7 +7263,7 @@ int get_hwpoison_huge_page(struct page *page, bool *hugetlb)
>  		*hugetlb = true;
>  		if (HPageFreed(page))
>  			ret = 0;
> -		else if (HPageMigratable(page))
> +		else if (HPageMigratable(page) || unpoison)
>  			ret = get_page_unless_zero(page);
>  		else
>  			ret = -EBUSY;
> @@ -7272,12 +7272,13 @@ int get_hwpoison_huge_page(struct page *page, bool *hugetlb)
>  	return ret;
>  }
>  
> -int get_huge_page_for_hwpoison(unsigned long pfn, int flags)
> +int get_huge_page_for_hwpoison(unsigned long pfn, int flags,
> +				bool *migratable_cleared)
>  {
>  	int ret;
>  
>  	spin_lock_irq(&hugetlb_lock);
> -	ret = __get_huge_page_for_hwpoison(pfn, flags);
> +	ret = __get_huge_page_for_hwpoison(pfn, flags, migratable_cleared);
>  	spin_unlock_irq(&hugetlb_lock);
>  	return ret;
>  }
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 145bb561ddb3..d4fef56c0438 100644
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
> @@ -1785,7 +1785,8 @@ void hugetlb_clear_page_hwpoison(struct page *hpage)
>   *   -EBUSY        - the hugepage is busy (try to retry)
>   *   -EHWPOISON    - the hugepage is already hwpoisoned
>   */
> -int __get_huge_page_for_hwpoison(unsigned long pfn, int flags)
> +int __get_huge_page_for_hwpoison(unsigned long pfn, int flags,
> +				 bool *migratable_cleared)
>  {
>  	struct page *page = pfn_to_page(pfn);
>  	struct page *head = compound_head(page);
> @@ -1815,6 +1816,15 @@ int __get_huge_page_for_hwpoison(unsigned long pfn, int flags)
>  		goto out;
>  	}
>  
> +	/*
> +	 * Clearing HPageMigratable for hwpoisoned hugepages to prevent them
> +	 * from being migrated by memory hotremove.
> +	 */
> +	if (count_increased) {
> +		*migratable_cleared = true;
> +		ClearHPageMigratable(head);

I think I might be nitpicking... But it seems ClearHPageMigratable is not enough here.
  1. In MF_COUNT_INCREASED case, we don't know whether HPageMigratable is set.
  2. Even if HPageMigratable is set, there might be a race window before we clear HPageMigratable?
So "*migratable_cleared = TestClearHPageMigratable" might be better? But I might be wrong.

With above fixed (if it's really a problem), this patch looks good to me.

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks,
Miaohe Lin


