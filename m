Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2CB062D3B1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 07:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234702AbiKQG7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 01:59:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234430AbiKQG7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 01:59:36 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A6F6DCE9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 22:59:34 -0800 (PST)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NCW3x32SMzmVxJ;
        Thu, 17 Nov 2022 14:59:09 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 14:59:32 +0800
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemm100009.china.huawei.com (7.185.36.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 14:59:32 +0800
Subject: Re: [PATCH 1/2] arm64/mm: fix incorrect file_map_count for non-leaf
 pmd/pud
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "David Hildenbrand" <dhildenb@redhat.com>,
        Rafael Aquini <raquini@redhat.com>,
        "Pasha Tatashin" <pasha.tatashin@soleen.com>
References: <20221116083811.464678-1-liushixin2@huawei.com>
 <20221116083811.464678-2-liushixin2@huawei.com>
 <c4bf6c1c-ad05-3e72-4f60-638123ec0907@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
From:   Liu Shixin <liushixin2@huawei.com>
Message-ID: <9855d2b4-aad7-3efe-c00c-851b44a01c3e@huawei.com>
Date:   Thu, 17 Nov 2022 14:59:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <c4bf6c1c-ad05-3e72-4f60-638123ec0907@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.24]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/11/17 12:09, Anshuman Khandual wrote:
>
> On 11/16/22 14:08, Liu Shixin wrote:
>> The page table check trigger BUG_ON() unexpectedly when collapse hugepage:
>>
>>  ------------[ cut here ]------------
>>  kernel BUG at mm/page_table_check.c:82!
>>  Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
>>  Dumping ftrace buffer:
>>     (ftrace buffer empty)
>>  Modules linked in:
>>  CPU: 6 PID: 68 Comm: khugepaged Not tainted 6.1.0-rc3+ #750
>>  Hardware name: linux,dummy-virt (DT)
>>  pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>  pc : page_table_check_clear.isra.0+0x258/0x3f0
>>  lr : page_table_check_clear.isra.0+0x240/0x3f0
>> [...]
>>  Call trace:
>>   page_table_check_clear.isra.0+0x258/0x3f0
>>   __page_table_check_pmd_clear+0xbc/0x108
>>   pmdp_collapse_flush+0xb0/0x160
>>   collapse_huge_page+0xa08/0x1080
>>   hpage_collapse_scan_pmd+0xf30/0x1590
>>   khugepaged_scan_mm_slot.constprop.0+0x52c/0xac8
>>   khugepaged+0x338/0x518
>>   kthread+0x278/0x2f8
>>   ret_from_fork+0x10/0x20
>> [...]
>>
>> Since pmd_user_accessible_page() doesn't check if a pmd is leaf, it
>> decrease file_map_count for a non-leaf pmd comes from collapse_huge_page().
>> and so trigger BUG_ON() unexpectedly.
> Could you please provide the pmd_val() on the pmd entry, that triggers this
> BUG_ON() here ? Only additional thing pmd_leaf() ensures, is that the entry
> is not a table one.
>
> #define pmd_leaf(pmd)           (pmd_present(pmd) && !pmd_table(pmd))
>
> collapse_huge_page() pmd is non-leaf because it has table bit on ?
The pmd_val is 0x80000004c367003. It is indeed a table entry. collapse_huge_page()
will replace page table of page granularity with block granularity. Before this replace,
it will call pmdp_collapse_flush() to clear the table pmd. In this function, the table pmd
do the check unexpectdly and trigger the BUG_ON().

diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index 90ab721a12a8..a5c2380bac4d 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -221,6 +221,7 @@ pmd_t pmdp_collapse_flush(struct vm_area_struct *vma, unsigned long address,
 
        VM_BUG_ON(address & ~HPAGE_PMD_MASK);
        VM_BUG_ON(pmd_trans_huge(*pmdp));
+       pr_err("pmd_val is 0x%lx\n", pmd_val(*pmdp));
        pmd = pmdp_huge_get_and_clear(vma->vm_mm, address, pmdp);
 
        /* collapse entails shooting down ptes not pmd */

Thanks,
Liu Shixin
.

>
>> Fix this problem by using pmd_leaf() insteal of pmd_present() in
>> pmd_user_accessible_page(). Moreover, use pud_leaf() for
>> pud_user_accessible_page() too.
>>
>> Fixes: 42b2547137f5 ("arm64/mm: enable ARCH_SUPPORTS_PAGE_TABLE_CHECK")
>> Reported-by: Denys Vlasenko <dvlasenk@redhat.com>
>> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
>> ---
>>  arch/arm64/include/asm/pgtable.h | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>> index 71a1af42f0e8..edf6625ce965 100644
>> --- a/arch/arm64/include/asm/pgtable.h
>> +++ b/arch/arm64/include/asm/pgtable.h
>> @@ -863,12 +863,12 @@ static inline bool pte_user_accessible_page(pte_t pte)
>>  
>>  static inline bool pmd_user_accessible_page(pmd_t pmd)
>>  {
>> -	return pmd_present(pmd) && (pmd_user(pmd) || pmd_user_exec(pmd));
>> +	return pmd_leaf(pmd) && (pmd_user(pmd) || pmd_user_exec(pmd));
>>  }
>>  
>>  static inline bool pud_user_accessible_page(pud_t pud)
>>  {
>> -	return pud_present(pud) && pud_user(pud);
>> +	return pud_leaf(pud) && pud_user(pud);
>>  }
>>  #endif
>>  
> .
>

