Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4835E8C65
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 14:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbiIXM1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 08:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiIXM1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 08:27:39 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9506177
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 05:27:38 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MZSq14KcZz1P6sn;
        Sat, 24 Sep 2022 20:23:25 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 24 Sep 2022 20:27:35 +0800
Subject: Re: [PATCH v5 4/4] mm/hwpoison: introduce per-memory_block hwpoison
 counter counter
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
 <20220921091359.25889-5-naoya.horiguchi@linux.dev>
 <20220923082613.GB1357512@ik1-406-35019.vs.sakura.ne.jp>
 <20220923141204.GA1484969@ik1-406-35019.vs.sakura.ne.jp>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <542473d1-b687-55b8-24d1-96af715aed56@huawei.com>
Date:   Sat, 24 Sep 2022 20:27:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220923141204.GA1484969@ik1-406-35019.vs.sakura.ne.jp>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

On 2022/9/23 22:12, Naoya Horiguchi wrote:
> There seems another build error in aarch64 with MEMORY_HOTPLUG disabled.
> https://lore.kernel.org/lkml/20220923110144.GA1413812@ik1-406-35019.vs.sakura.ne.jp/
> , so let me revise this patch again to handle it.
> 
> - Naoya Horiguchi
> 
> ---
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> Date: Fri, 23 Sep 2022 22:51:20 +0900
> Subject: [PATCH v5 4/4] mm/hwpoison: introduce per-memory_block hwpoison counter
> 
> Currently PageHWPoison flag does not behave well when experiencing memory
> hotremove/hotplug.  Any data field in struct page is unreliable when the
> associated memory is offlined, and the current mechanism can't tell whether
> a memory section is onlined because a new memory devices is installed or
> because previous failed offline operations are undone.  Especially if
> there's a hwpoisoned memory, it's unclear what the best option is.
> 
> So introduce a new mechanism to make struct memory_block remember that
> a memory block has hwpoisoned memory inside it. And make any online event
> fail if the onlined memory block contains hwpoison.  struct memory_block
> is freed and reallocated over ACPI-based hotremove/hotplug, but not over
> sysfs-based hotremove/hotplug.  So it's desirable to implement hwpoison
> counter on this struct.
> 
> Note that clear_hwpoisoned_pages() is relocated to be called earlier than
> now, just before unregistering struct memory_block.  Otherwise, the
> per-memory_block hwpoison counter is freed and we fail to adjust global
> hwpoison counter properly.
> 
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> Reported-by: kernel test robot <lkp@intel.com>

LGTM with some nits below. Thanks.

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

> ---
> ChangeLog v4 -> v5:
> - add Reported-by of lkp bot,
> - check both CONFIG_MEMORY_FAILURE and CONFIG_MEMORY_HOTPLUG in introduced #ifdefs,
>   intending to fix "undefined reference" errors in aarch64.
> 
> ChangeLog v3 -> v4:
> - fix build error (https://lore.kernel.org/linux-mm/202209231134.tnhKHRfg-lkp@intel.com/)
>   by using memblk_nr_poison() to access to the member ->nr_hwpoison
> ---
>  drivers/base/memory.c  | 34 ++++++++++++++++++++++++++++++++++
>  include/linux/memory.h |  3 +++
>  include/linux/mm.h     | 24 ++++++++++++++++++++++++
>  mm/internal.h          |  8 --------
>  mm/memory-failure.c    | 31 ++++++++++---------------------
>  mm/sparse.c            |  2 --
>  6 files changed, 71 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index 9aa0da991cfb..99e0e789616c 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -183,6 +183,9 @@ static int memory_block_online(struct memory_block *mem)
>  	struct zone *zone;
>  	int ret;
>  
> +	if (memblk_nr_poison(start_pfn))
> +		return -EHWPOISON;
> +
>  	zone = zone_for_pfn_range(mem->online_type, mem->nid, mem->group,
>  				  start_pfn, nr_pages);
>  
> @@ -864,6 +867,7 @@ void remove_memory_block_devices(unsigned long start, unsigned long size)
>  		mem = find_memory_block_by_id(block_id);
>  		if (WARN_ON_ONCE(!mem))
>  			continue;
> +		clear_hwpoisoned_pages(memblk_nr_poison(start));

clear_hwpoisoned_pages seems not a proper name now? PageHWPoison info is kept now. But this should be trivial.

>  		unregister_memory_block_under_nodes(mem);
>  		remove_memory_block(mem);
>  	}
> @@ -1164,3 +1168,33 @@ int walk_dynamic_memory_groups(int nid, walk_memory_groups_func_t func,
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
> +unsigned long memblk_nr_poison(unsigned long pfn)

memblk_nr_poison() is only used inside this file. Make it static?

Thanks,
Miaohe Lin

