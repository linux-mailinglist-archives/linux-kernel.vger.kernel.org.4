Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93F95E8BEC
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 13:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233626AbiIXLxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 07:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233571AbiIXLxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 07:53:19 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0B5B600C
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 04:53:18 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MZS3c0HY3zWh2Q;
        Sat, 24 Sep 2022 19:49:16 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 24 Sep 2022 19:53:15 +0800
Subject: Re: [PATCH v3 2/4] mm/hwpoison: move definitions of
 num_poisoned_pages_* to memory-failure.c
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
 <20220921091359.25889-3-naoya.horiguchi@linux.dev>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <4b7c327a-547e-be8b-4568-745fabe74641@huawei.com>
Date:   Sat, 24 Sep 2022 19:53:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220921091359.25889-3-naoya.horiguchi@linux.dev>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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
> These interfaces will be used by drivers/base/core.c by later patch, so as a
> preparatory work move them to more common header file visible to the file.
> 
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> ---
> ChangeLog v2 -> v3:
> - added declaration of num_poisoned_pages_inc() in #ifdef CONFIG_MEMORY_FAILURE
> ---
>  arch/parisc/kernel/pdt.c |  3 +--
>  include/linux/mm.h       |  5 +++++
>  include/linux/swapops.h  | 24 ++----------------------
>  mm/memory-failure.c      | 10 ++++++++++
>  4 files changed, 18 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/parisc/kernel/pdt.c b/arch/parisc/kernel/pdt.c
> index e391b175f5ec..fdc880e2575a 100644
> --- a/arch/parisc/kernel/pdt.c
> +++ b/arch/parisc/kernel/pdt.c
> @@ -18,8 +18,7 @@
>  #include <linux/kthread.h>
>  #include <linux/initrd.h>
>  #include <linux/pgtable.h>
> -#include <linux/swap.h>

Is header file "linux/swap.h" already unneeded before the code change? It seems there's
no code change in that file.

> -#include <linux/swapops.h>
> +#include <linux/mm.h>
>  
>  #include <asm/pdc.h>
>  #include <asm/pdcpat.h>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index c2277f5aba9e..80a2d800f272 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3279,11 +3279,16 @@ extern atomic_long_t num_poisoned_pages __read_mostly;
>  extern int soft_offline_page(unsigned long pfn, int flags);
>  #ifdef CONFIG_MEMORY_FAILURE
>  extern int __get_huge_page_for_hwpoison(unsigned long pfn, int flags);
> +extern void num_poisoned_pages_inc(void);
>  #else
>  static inline int __get_huge_page_for_hwpoison(unsigned long pfn, int flags)
>  {
>  	return 0;
>  }
> +
> +static inline void num_poisoned_pages_inc(void)
> +{
> +}
>  #endif
>  
>  #ifndef arch_memory_failure
> diff --git a/include/linux/swapops.h b/include/linux/swapops.h
> index a91dd08e107b..3e58a812399a 100644
> --- a/include/linux/swapops.h
> +++ b/include/linux/swapops.h
> @@ -581,8 +581,6 @@ static inline int is_pmd_migration_entry(pmd_t pmd)
>  
>  #ifdef CONFIG_MEMORY_FAILURE
>  
> -extern atomic_long_t num_poisoned_pages __read_mostly;
> -
>  /*
>   * Support for hardware poisoned pages
>   */
> @@ -610,17 +608,7 @@ static inline struct page *hwpoison_entry_to_page(swp_entry_t entry)
>  	return p;
>  }
>  
> -static inline void num_poisoned_pages_inc(void)
> -{
> -	atomic_long_inc(&num_poisoned_pages);
> -}
> -
> -static inline void num_poisoned_pages_sub(long i)
> -{
> -	atomic_long_sub(i, &num_poisoned_pages);
> -}
> -
> -#else  /* CONFIG_MEMORY_FAILURE */
> +#else
>  
>  static inline swp_entry_t make_hwpoison_entry(struct page *page)
>  {
> @@ -636,15 +624,7 @@ static inline struct page *hwpoison_entry_to_page(swp_entry_t entry)
>  {
>  	return NULL;
>  }
> -
> -static inline void num_poisoned_pages_inc(void)
> -{
> -}
> -
> -static inline void num_poisoned_pages_sub(long i)
> -{
> -}
> -#endif  /* CONFIG_MEMORY_FAILURE */
> +#endif
>  
>  static inline int non_swap_entry(swp_entry_t entry)
>  {
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 5942e1c0407e..aa6ce685b863 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -74,6 +74,16 @@ atomic_long_t num_poisoned_pages __read_mostly = ATOMIC_LONG_INIT(0);
>  
>  static bool hw_memory_failure __read_mostly = false;
>  
> +static inline void num_poisoned_pages_inc(void)

This function is defined as "static inline" while it's "extern void num_poisoned_pages_inc(void)"
in the header file. Is this expected?

Thanks,
Miaohe Lin

> +{
> +	atomic_long_inc(&num_poisoned_pages);
> +}
> +
> +static inline void num_poisoned_pages_sub(long i)
> +{
> +	atomic_long_sub(i, &num_poisoned_pages);
> +}
> +
>  /*
>   * Return values:
>   *   1:   the page is dissolved (if needed) and taken off from buddy,
> 

