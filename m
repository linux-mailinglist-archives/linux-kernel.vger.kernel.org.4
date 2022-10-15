Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B8A5FF803
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 04:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiJOC2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 22:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiJOC2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 22:28:05 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927B363872
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 19:28:03 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Mq6Xb4p3VzpVw7;
        Sat, 15 Oct 2022 10:24:47 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 15 Oct 2022 10:28:01 +0800
Subject: Re: [PATCH v6 4/4] mm/hwpoison: introduce per-memory_block hwpoison
 counter
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
 <20221007010706.2916472-5-naoya.horiguchi@linux.dev>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <3a6e403d-15d1-f419-698a-b1c825f59472@huawei.com>
Date:   Sat, 15 Oct 2022 10:28:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20221007010706.2916472-5-naoya.horiguchi@linux.dev>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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
> Currently PageHWPoison flag does not behave well when experiencing memory
> hotremove/hotplug.  Any data field in struct page is unreliable when the
> associated memory is offlined, and the current mechanism can't tell whether
> a memory block is onlined because a new memory devices is installed or
> because previous failed offline operations are undone.  Especially if
> there's a hwpoisoned memory, it's unclear what the best option is.
> 
> So introduce a new mechanism to make struct memory_block remember that
> a memory block has hwpoisoned memory inside it. And make any online event
> fail if the onlining memory block contains hwpoison.  struct memory_block
> is freed and reallocated over ACPI-based hotremove/hotplug, but not over
> sysfs-based hotremove/hotplug.  So the new counter can distinguish these
> cases.
> 
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
> ChangeLog v5 -> v6:
> - fix build errors over memblk_nr_poison_inc() and memblk_nr_poison_sub(),
> - pass "struct memory_block *" to memblk_nr_poison() instead of pfn,
> - removed clear_hwpoisoned_pages() and call num_poisoned_pages_sub() directly.
> - add static keyword to the definition of memblk_nr_poison().
> - Mioahe added Reviewed-by for v5, but I have some non trivial changes in
>   v6, so let me hold to add it.
> - unpoison_memory() properly cancels per-memblk hwpoison counter.
> 
> ChangeLog v4 -> v5:
> - add Reported-by of lkp bot,
> - check both CONFIG_MEMORY_FAILURE and CONFIG_MEMORY_HOTPLUG in introduced #ifdefs,
>   intending to fix "undefined reference" errors in aarch64.
> 
> ChangeLog v3 -> v4:
> - fix build error (https://lore.kernel.org/linux-mm/202209231134.tnhKHRfg-lkp@intel.com/)
>   by using memblk_nr_poison() to access to the member ->nr_hwpoison
> ---
>  drivers/base/memory.c  | 40 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/memory.h |  3 +++
>  include/linux/mm.h     | 18 ++++++++++++++++++
>  mm/internal.h          |  8 --------
>  mm/memory-failure.c    | 36 +++++++++++-------------------------
>  mm/sparse.c            |  2 --
>  6 files changed, 72 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index 9aa0da991cfb..5d00d8a14c79 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -175,6 +175,17 @@ int memory_notify(unsigned long val, void *v)
>  	return blocking_notifier_call_chain(&memory_chain, val, v);
>  }
>  
> +#if defined(CONFIG_MEMORY_FAILURE) && defined(CONFIG_MEMORY_HOTPLUG)
> +void memblk_nr_poison_inc(unsigned long pfn);
> +void memblk_nr_poison_sub(unsigned long pfn, long i);
> +static unsigned long memblk_nr_poison(struct memory_block *mem);
> +#else
> +static inline unsigned long memblk_nr_poison(struct memory_block *mem)
> +{
> +	return 0;
> +}
> +#endif
> +
>  static int memory_block_online(struct memory_block *mem)
>  {
>  	unsigned long start_pfn = section_nr_to_pfn(mem->start_section_nr);
> @@ -183,6 +194,9 @@ static int memory_block_online(struct memory_block *mem)
>  	struct zone *zone;
>  	int ret;
>  
> +	if (memblk_nr_poison(mem))
> +		return -EHWPOISON;
> +
>  	zone = zone_for_pfn_range(mem->online_type, mem->nid, mem->group,
>  				  start_pfn, nr_pages);
>  
> @@ -864,6 +878,7 @@ void remove_memory_block_devices(unsigned long start, unsigned long size)
>  		mem = find_memory_block_by_id(block_id);
>  		if (WARN_ON_ONCE(!mem))
>  			continue;
> +		num_poisoned_pages_sub(-1UL, memblk_nr_poison(mem));
>  		unregister_memory_block_under_nodes(mem);
>  		remove_memory_block(mem);
>  	}
> @@ -1164,3 +1179,28 @@ int walk_dynamic_memory_groups(int nid, walk_memory_groups_func_t func,
>  	}
>  	return ret;
>  }
> +
> +#if defined(CONFIG_MEMORY_FAILURE) && defined(CONFIG_MEMORY_HOTPLUG)
> +void memblk_nr_poison_inc(unsigned long pfn)
> +{
> +	const unsigned long block_id = pfn_to_block_id(pfn);
> +	struct memory_block *mem = find_memory_block_by_id(block_id);
> +
> +	if (mem)
> +		atomic_long_inc(&mem->nr_hwpoison);
> +}
> +
> +void memblk_nr_poison_sub(unsigned long pfn, long i)
> +{
> +	const unsigned long block_id = pfn_to_block_id(pfn);
> +	struct memory_block *mem = find_memory_block_by_id(block_id);
> +
> +	if (mem)
> +		atomic_long_sub(i, &mem->nr_hwpoison);
> +}
> +
> +static unsigned long memblk_nr_poison(struct memory_block *mem)
> +{
> +	return atomic_long_read(&mem->nr_hwpoison);
> +}
> +#endif
> diff --git a/include/linux/memory.h b/include/linux/memory.h
> index aa619464a1df..ad8cd9bb3239 100644
> --- a/include/linux/memory.h
> +++ b/include/linux/memory.h
> @@ -85,6 +85,9 @@ struct memory_block {
>  	unsigned long nr_vmemmap_pages;
>  	struct memory_group *group;	/* group (if any) for this block */
>  	struct list_head group_next;	/* next block inside memory group */
> +#if defined(CONFIG_MEMORY_FAILURE) && defined(CONFIG_MEMORY_HOTPLUG)
> +	atomic_long_t nr_hwpoison;
> +#endif
>  };
>  
>  int arch_get_memory_phys_device(unsigned long start_pfn);
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 17119dbf8fad..f80269e90772 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3280,6 +3280,7 @@ extern int soft_offline_page(unsigned long pfn, int flags);
>  extern int __get_huge_page_for_hwpoison(unsigned long pfn, int flags,
>  					bool *migratable_cleared);
>  extern void num_poisoned_pages_inc(unsigned long pfn);
> +extern void num_poisoned_pages_sub(unsigned long pfn, long i);

The prototype of this function is: *inline* void num_poisoned_pages_sub(unsigned long pfn, long i).
The combination of inline and extern looks weird to me. Is this a common use case?

Anyway, this patch looks good to me. Thanks.
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks,
Miaohe Lin


