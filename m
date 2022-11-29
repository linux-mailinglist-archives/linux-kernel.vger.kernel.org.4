Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029AF63C0C9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 14:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbiK2NPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 08:15:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233279AbiK2NPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 08:15:13 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E82D61B91
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 05:14:35 -0800 (PST)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NM2kr4lHtzqSmK;
        Tue, 29 Nov 2022 21:10:28 +0800 (CST)
Received: from dggpeml500005.china.huawei.com (7.185.36.59) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 29 Nov 2022 21:14:30 +0800
Received: from [10.174.178.155] (10.174.178.155) by
 dggpeml500005.china.huawei.com (7.185.36.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 29 Nov 2022 21:14:29 +0800
Subject: Re: [QUESTION] memcg page_counter seems broken in MADV_DONTNEED with
 THP enabled
To:     Yang Shi <shy828301@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        <aarcange@redhat.com>, <hughd@google.com>, <mgorman@suse.de>,
        <mhocko@suse.cz>, <cl@gentwo.org>, <n-horiguchi@ah.jp.nec.com>,
        <zokeefe@google.com>, <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>, <peterx@redhat.com>,
        "Wangkefeng (OS Kernel Lab)" <wangkefeng.wang@huawei.com>,
        "zhangxiaoxu (A)" <zhangxiaoxu5@huawei.com>,
        <kirill.shutemov@linux.intel.com>, Lu Jialin <lujialin4@huawei.com>
References: <8a2f2644-71d0-05d7-49d8-878aafa99652@huawei.com>
 <CAHbLzkr-eXk8gateN=EmMoBuW3wxoQKTCfJcTRQsQX3QxD+CmA@mail.gmail.com>
From:   Yongqiang Liu <liuyongqiang13@huawei.com>
Message-ID: <6b7142cf-386e-e1d2-a122-b923337a593e@huawei.com>
Date:   Tue, 29 Nov 2022 21:14:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CAHbLzkr-eXk8gateN=EmMoBuW3wxoQKTCfJcTRQsQX3QxD+CmA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.155]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500005.china.huawei.com (7.185.36.59)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/11/29 4:01, Yang Shi 写道:
> On Sat, Nov 26, 2022 at 5:10 AM Yongqiang Liu <liuyongqiang13@huawei.com> wrote:
>> Hi,
>>
>> We use mm_counter to how much a process physical memory used. Meanwhile,
>> page_counter of a memcg is used to count how much a cgroup physical
>> memory used.
>> If a cgroup only contains a process, they looks almost the same. But with
>> THP enabled, sometimes memory.usage_in_bytes in memcg may be twice or
>> more than rss
>> in proc/[pid]/smaps_rollup as follow:
>>
>> [root@localhost sda]# cat /sys/fs/cgroup/memory/test/memory.usage_in_bytes
>> 1080930304
>> [root@localhost sda]# cat /sys/fs/cgroup/memory/test/cgroup.procs
>> 1290
>> [root@localhost sda]# cat /proc/1290/smaps_rollup
>> 55ba80600000-ffffffffff601000 ---p 00000000 00:00 0
>> [rollup]
>> Rss:              500648 kB
>> Pss:              498337 kB
>> Shared_Clean:       2732 kB
>> Shared_Dirty:          0 kB
>> Private_Clean:       364 kB
>> Private_Dirty:    497552 kB
>> Referenced:       500648 kB
>> Anonymous:        492016 kB
>> LazyFree:              0 kB
>> AnonHugePages:    129024 kB
>> ShmemPmdMapped:        0 kB
>> Shared_Hugetlb:        0 kB
>> Private_Hugetlb:       0 kB
>> Swap:                  0 kB
>> SwapPss:               0 kB
>> Locked:                0 kB
>> THPeligible:    0
>>
>> I have found the differences was because that __split_huge_pmd decrease
>> the mm_counter but page_counter in memcg was not decreased with refcount
>> of a head page is not zero. Here are the follows:
>>
>> do_madvise
>>     madvise_dontneed_free
>>       zap_page_range
>>         unmap_single_vma
>>           zap_pud_range
>>             zap_pmd_range
>>               __split_huge_pmd
>>                 __split_huge_pmd_locked
>>                   __mod_lruvec_page_state
>>               zap_pte_range
>>                  add_mm_rss_vec
>>                     add_mm_counter                    -> decrease the
>> mm_counter
>>         tlb_finish_mmu
>>           arch_tlb_finish_mmu
>>             tlb_flush_mmu_free
>>               free_pages_and_swap_cache
>>                 release_pages
>>                   folio_put_testzero(page)            -> not zero, skip
>>                     continue;
>>                   __folio_put_large
>>                     free_transhuge_page
>>                       free_compound_page
>>                         mem_cgroup_uncharge
>>                           page_counter_uncharge        -> decrease the
>> page_counter
>>
>> node_page_stat which shows in meminfo was also decreased. the
>> __split_huge_pmd
>> seems free no physical memory unless the total THP was free.I am
>> confused which
>> one is the true physical memory used of a process.
> This should be caused by the deferred split of THP. When MADV_DONTNEED
> is called on the partial of the map, the huge PMD is split, but the
> THP itself will not be split until the memory pressure is hit (global
> or memcg limit). So the unmapped sub pages are actually not freed
> until that point. So the mm counter is decreased due to the zapping
> but the physical pages are not actually freed then uncharged from
> memcg.

Thanks!

I don't know how much memory a real workload will cost.So I just

test the max_usage_in_bytes of memcg with THP disabled and add a little bit

more for the limit_in_byte of memcg with THP enabled which trigger a oom...

(actually it costed 100M more with THP enabled). Another testcase which I

known the amout of memory will cost don't trigger a oom with suitable

memcg limit  and I see the THP split when the memory hit the limit.


I have another concern that k8s usually use (rss - files) to estimate

the memory workload but the anon_thp in the defered list charged

in memcg will make it look higher than actucal. And it seems the

container will be killed without oom...

Is it suitable to add meminfo of a deferred split list of THP?

>>
>> Kind regards,
>>
>> Yongqiang Liu
>>
>>
> .
