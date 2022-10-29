Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7E4611F2F
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 03:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiJ2Bz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 21:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiJ2BzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 21:55:23 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A2110B42
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 18:55:17 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Mzj6M4llNz15MKq;
        Sat, 29 Oct 2022 09:50:19 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 29 Oct 2022 09:55:15 +0800
Received: from [10.174.178.120] (10.174.178.120) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 29 Oct 2022 09:55:15 +0800
Message-ID: <305231eb-e46a-9295-a845-73237c98855b@huawei.com>
Date:   Sat, 29 Oct 2022 09:55:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
CC:     <mawupeng1@huawei.com>, <akpm@linux-foundation.org>,
        <mike.kravetz@oracle.com>, <mhocko@suse.com>, <osalvador@suse.de>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next 1/1] mm: hugetlb_vmemmap: Fix WARN_ON in
 vmemmap_remap_pte
Content-Language: en-US
To:     <muchun.song@linux.dev>, <catalin.marinas@arm.com>,
        <songmuchun@bytedance.com>, <anshuman.khandual@arm.com>
References: <20221025014215.3466904-1-mawupeng1@huawei.com>
 <614E3E83-1EAB-4C39-AF9C-83C0CCF26218@linux.dev>
 <1b2e03b2-5e91-2e60-82d0-ea111840c81d@huawei.com>
From:   mawupeng <mawupeng1@huawei.com>
In-Reply-To: <1b2e03b2-5e91-2e60-82d0-ea111840c81d@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.120]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/10/26 11:01, mawupeng wrote:
> 
> 
> On 2022/10/25 14:36, Muchun Song wrote:
>>
>>
>>> On Oct 25, 2022, at 09:42, Wupeng Ma <mawupeng1@huawei.com> wrote:
>>>
>>> From: Ma Wupeng <mawupeng1@huawei.com>
>>>
>>> Commit f41f2ed43ca5 ("mm: hugetlb: free the vmemmap pages associated with
>>> each HugeTLB page") add vmemmap_remap_pte to remap the tail pages as
>>> read-only to catch illegal write operation to the tail page.
>>>
>>> However this will lead to WARN_ON in arm64 in __check_racy_pte_update()
>>
>> Thanks for your finding this issue.
>>
>>> since this may lead to dirty state cleaned. This check is introduced by
>>> commit 2f4b829c625e ("arm64: Add support for hardware updates of the
>>> access and dirty pte bits") and the initial check is as follow:
>>>
>>>  BUG_ON(pte_write(*ptep) && !pte_dirty(pte));
>>>
>>> Since we do need to mark this pte as read-only to catch illegal write
>>> operation to the tail pages, use set_pte  to replace set_pte_at to bypass
>>> this check.
>>
>> In theory, the waring does not affect anything since the tail vmemmap
>> pages are supposed to be read-only. So, skipping this check for vmemmap
>> pages seem feasible. But I am not sure whether it is general to use
>> set_pte here instead of set_pte_at, I didn’t see any users of set_pte
>> from the common code routines except the code from arch/xxx. And this
>> issue is specific for arm64, so I suggest fixing it in __check_racy_pte_update()
>> itself.
>>
>> Something like (Just some thoughts from mine):
>>
>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>> index b5df82aa99e6..df7716965a93 100644
>> --- a/arch/arm64/include/asm/pgtable.h
>> +++ b/arch/arm64/include/asm/pgtable.h
>> @@ -292,7 +292,8 @@ extern void __sync_icache_dcache(pte_t pteval);
>>   *   PTE_DIRTY || (PTE_WRITE && !PTE_RDONLY)
>>   */
>>
>> -static inline void __check_racy_pte_update(struct mm_struct *mm, pte_t *ptep,
>> +static inline void __check_racy_pte_update(struct mm_struct *mm,
>> +                                          unsigned long addr, pte_t *ptep,
>>                                            pte_t pte)
>>  {
>>         pte_t old_pte;
>> @@ -307,6 +308,10 @@ static inline void __check_racy_pte_update(struct mm_struct *mm, pte_t *ptep,
>>         if (mm != current->active_mm && atomic_read(&mm->mm_users) <= 1)
>>                 return;
>>
>> +       if (IS_ENABLED(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP) &&
>> +           addr >= VMEMMAP_START && addr <= VMEMMAP_END)
>> +               return;
>> +
>>         /*
>>          * Check for potential race with hardware updates of the pte
>>          * (ptep_set_access_flags safely changes valid ptes without going
>>

IMHO, arm64 or other archs do some work on the dirty bit and rdonly bit in
pte in commit 2f4b829c625e ("arm64: Add support for hardware updates of the
access and dirty pte bits").

Maybe we can use pte_wrprotect() to mark this pte read-only? It will add 
PTE_DIRTY bit for the new pte entry compare to the old one.

Here is the diff:

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index ba2a2596fb4e..24a230895316 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -244,8 +244,7 @@ static void vmemmap_remap_pte(pte_t *pte, unsigned long addr,
         * Remap the tail pages as read-only to catch illegal write operation
         * to the tail pages.
         */
-       pgprot_t pgprot = PAGE_KERNEL_RO;
-       pte_t entry = mk_pte(walk->reuse_page, pgprot);
+       pte_t entry = pte_wrprotect(mk_pte(walk->reuse_page, PAGE_KERNEL));
        struct page *page = pte_page(*pte);
 
        list_add_tail(&page->lru, walk->vmemmap_pages);

>>>
>>> The following shell command can be used to reproduce this WARN_ON in
>>> 6.1.0-rc1:
>>>
>>>  echo 1 > /proc/sys/vm/hugetlb_optimize_vmemmap
>>>  cat /proc/sys/vm/hugetlb_optimize_vmemmap
>>>
>>>  echo 1024 > /proc/sys/vm/nr_overcommit_hugepages
>>>  mkdir -p /root/hugetlb
>>>  mount none /root/hugetlb -t hugetlbfs
>>>  fallocate -l 2g /root/hugetlb/xx &
>>>
>>> Here is the detail WARN_ON log:
>>>
>>> ------------[ cut here ]------------
>>> __check_racy_pte_update: racy dirty state clearing: 0x0068000416899f03 -> 0x0060000416898f83
>>> WARNING: CPU: 3 PID: 394 at arch/arm64/include/asm/pgtable.h:318 vmemmap_remap_pte+0x118/0x120
>>> Modules linked in:
>>> CPU: 3 PID: 394 Comm: fallocate Not tainted 6.1.0-rc1 #224
>>> Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0 02/06/2015
>>> Call trace:
>>> vmemmap_remap_pte+0x118/0x120
>>> vmemmap_remap_range+0x30c/0x560
>>> hugetlb_vmemmap_optimize+0x158/0x408
>>> __prep_new_huge_page+0x24/0x150
>>> prep_new_huge_page+0x30/0x60
>>> alloc_fresh_huge_page+0x1c4/0x1e0
>>> alloc_surplus_huge_page+0xa0/0x168
>>> alloc_huge_page+0x264/0x5b8
>>> hugetlbfs_fallocate+0x294/0x680
>>> vfs_fallocate+0x12c/0x568
>>> ksys_fallocate+0x50/0xa0
>>> __arm64_sys_fallocate+0x28/0x38
>>> invoke_syscall+0x4c/0x110
>>> el0_svc_common.constprop.0+0x68/0x128
>>> do_el0_svc+0x34/0xd0
>>> el0_svc+0x48/0xb8
>>> el0t_64_sync_handler+0xb8/0xc0
>>> el0t_64_sync+0x18c/0x190
>>> ---[ end trace 0000000000000000 ]---
>>>
>>> Fixes: f41f2ed43ca5 ("mm: hugetlb: free the vmemmap pages associated with each HugeTLB page")
>>
>> Actually, this commit does not pose the issue for arm64. I think the correct commit
>> which should be fixed is 1e63ac088f20f7a4425c430c31ecd3cf167fb3f2.
>>
>> Thanks.
> 
> Thanks for pointing it out.
> 
> I have tested the commit, it sure is patch 1e63ac088f20f7a4425c430c31ecd3cf167fb3f2.
> This VM_WARN_ONCE will be produced if HUGETLB_PAGE_FREE_VMEMMAP for arm64 is enabled.
> 
> I will change my change log and fix this in next patch.
> 
>>
>>> Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
>>> ---
>>> mm/hugetlb_vmemmap.c | 2 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
>>> index ba2a2596fb4e..cb056265c31e 100644
>>> --- a/mm/hugetlb_vmemmap.c
>>> +++ b/mm/hugetlb_vmemmap.c
>>> @@ -249,7 +249,7 @@ static void vmemmap_remap_pte(pte_t *pte, unsigned long addr,
>>> struct page *page = pte_page(*pte);
>>>
>>> list_add_tail(&page->lru, walk->vmemmap_pages);
>>> - set_pte_at(&init_mm, addr, pte, entry);
>>> + set_pte(pte, entry);
>>> }
>>>
>>> /*
>>> -- 
>>> 2.25.1
>>>
>>>
>>
