Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB87860ED88
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 03:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233840AbiJ0Bm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 21:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233516AbiJ0BmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 21:42:24 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE39012A348
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 18:42:22 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MySwX42ztzVj1m;
        Thu, 27 Oct 2022 09:37:32 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 27 Oct 2022 09:42:20 +0800
Received: from [10.174.178.120] (10.174.178.120) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 27 Oct 2022 09:42:20 +0800
Message-ID: <d4f3d737-705a-91dd-0531-5326938c87cb@huawei.com>
Date:   Thu, 27 Oct 2022 09:42:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
CC:     <mawupeng1@huawei.com>, <akpm@linux-foundation.org>,
        <mike.kravetz@oracle.com>, <songmuchun@bytedance.com>,
        <mhocko@suse.com>, <osalvador@suse.de>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next 1/1] mm: hugetlb_vmemmap: Fix WARN_ON in
 vmemmap_remap_pte
Content-Language: en-US
To:     <anshuman.khandual@arm.com>, <muchun.song@linux.dev>,
        <catalin.marinas@arm.com>
References: <20221025014215.3466904-1-mawupeng1@huawei.com>
 <614E3E83-1EAB-4C39-AF9C-83C0CCF26218@linux.dev>
 <35dd51eb-c266-f221-298a-21309c17971a@arm.com>
From:   mawupeng <mawupeng1@huawei.com>
In-Reply-To: <35dd51eb-c266-f221-298a-21309c17971a@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.120]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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



On 2022/10/26 13:06, Anshuman Khandual wrote:
> 
> 
> On 10/25/22 12:06, Muchun Song wrote:
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
> 
> Tails vmemmap pages are supposed to be read-only, in practice but their
> backing pages do have pte_write() enabled. Otherwise the VM_WARN_ONCE()
> warning would not have triggered.
> 
>         VM_WARN_ONCE(pte_write(old_pte) && !pte_dirty(pte),
>                      "%s: racy dirty state clearing: 0x%016llx -> 0x%016llx",
>                      __func__, pte_val(old_pte), pte_val(pte));

So, arm64 will trigger this warn_on in this condition and this condition is not
unusual such as this scenario?

It is true that we should change the login in arm64. but how to change it to
make the code more common?

Any thoughts?

Thanks for reviewing.

> 
> Also, is not it true that the pte being remapped into a different page
> as read only, than what it had originally (which will be freed up) i.e 
> the PFN in 'old_pte' and 'pte' will be different. Hence is there still
> a possibility for a race condition even when the PFN changes ?
> 
>> pages seem feasible. But I am not sure whether it is general to use
>> set_pte here instead of set_pte_at, I didn’t see any users of set_pte
>> from the common code routines except the code from arch/xxx. And this
>> issue is specific for arm64, so I suggest fixing it in __check_racy_pte_update()
>> itself.
> 
> Right, should not change it to yet lower level platform helper set_pte()
> just to work around this warning. Instead, __check_racy_pte_update() is
> the right place where it should be fixed.
> 
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
>>
> 
