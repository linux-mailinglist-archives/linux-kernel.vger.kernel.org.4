Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A256318D7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 04:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiKUDQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 22:16:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiKUDQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 22:16:00 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DFF317FE
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 19:15:57 -0800 (PST)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NFsrp2QnvzFqRk;
        Mon, 21 Nov 2022 11:12:42 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 11:15:50 +0800
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemm100009.china.huawei.com (7.185.36.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 11:15:49 +0800
Subject: Re: [PATCH v2 2/2] arm64/mm: fix incorrect file_map_count for invalid
 pmd/pud
To:     Will Deacon <will@kernel.org>
References: <20221117075602.2904324-1-liushixin2@huawei.com>
 <20221117075602.2904324-3-liushixin2@huawei.com>
 <20221118143414.GG4046@willie-the-truck>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Anshuman Khandual" <anshuman.khandual@arm.com>,
        David Hildenbrand <dhildenb@redhat.com>,
        Rafael Aquini <raquini@redhat.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
From:   Liu Shixin <liushixin2@huawei.com>
Message-ID: <10cecbdf-eb06-873d-6b79-bfdb3197d2ec@huawei.com>
Date:   Mon, 21 Nov 2022 11:15:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20221118143414.GG4046@willie-the-truck>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.24]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

On 2022/11/18 22:34, Will Deacon wrote:
> On Thu, Nov 17, 2022 at 03:56:02PM +0800, Liu Shixin wrote:
>> The page table check trigger BUG_ON() unexpectedly when split hugepage:
>>
>>  ------------[ cut here ]------------
>>  kernel BUG at mm/page_table_check.c:119!
>>  Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
>>  Dumping ftrace buffer:
>>     (ftrace buffer empty)
>>  Modules linked in:
>>  CPU: 7 PID: 210 Comm: transhuge-stres Not tainted 6.1.0-rc3+ #748
>>  Hardware name: linux,dummy-virt (DT)
>>  pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>  pc : page_table_check_set.isra.0+0x398/0x468
>>  lr : page_table_check_set.isra.0+0x1c0/0x468
>> [...]
>>  Call trace:
>>   page_table_check_set.isra.0+0x398/0x468
>>   __page_table_check_pte_set+0x160/0x1c0
>>   __split_huge_pmd_locked+0x900/0x1648
>>   __split_huge_pmd+0x28c/0x3b8
>>   unmap_page_range+0x428/0x858
>>   unmap_single_vma+0xf4/0x1c8
>>   zap_page_range+0x2b0/0x410
>>   madvise_vma_behavior+0xc44/0xe78
>>   do_madvise+0x280/0x698
>>   __arm64_sys_madvise+0x90/0xe8
>>   invoke_syscall.constprop.0+0xdc/0x1d8
>>   do_el0_svc+0xf4/0x3f8
>>   el0_svc+0x58/0x120
>>   el0t_64_sync_handler+0xb8/0xc0
>>   el0t_64_sync+0x19c/0x1a0
>> [...]
>>
>> On arm64, pmd_leaf() will return true even if the pmd is invalid due to
>> pmd_present_invalid() check. So in pmdp_invalidate() the file_map_count
>> will not only decrease once but also increase once. Then in set_pte_at(),
>> the file_map_count increase again, and so trigger BUG_ON() unexpectedly.
>>
>> Fix this problem by adding pmd_valid() in pmd_user_accessible_page().
>> Moreover, add pud_valid() for pud_user_accessible_page() too.
>>
>> Fixes: 42b2547137f5 ("arm64/mm: enable ARCH_SUPPORTS_PAGE_TABLE_CHECK")
>> Reported-by: Denys Vlasenko <dvlasenk@redhat.com>
>> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
>> Acked-by: Pasha Tatashin <pasha.tatashin@soleen.com>
>> ---
>>  arch/arm64/include/asm/pgtable.h | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>> index edf6625ce965..3bc64199aa2e 100644
>> --- a/arch/arm64/include/asm/pgtable.h
>> +++ b/arch/arm64/include/asm/pgtable.h
>> @@ -863,12 +863,12 @@ static inline bool pte_user_accessible_page(pte_t pte)
>>  
>>  static inline bool pmd_user_accessible_page(pmd_t pmd)
>>  {
>> -	return pmd_leaf(pmd) && (pmd_user(pmd) || pmd_user_exec(pmd));
>> +	return pmd_valid(pmd) && pmd_leaf(pmd) && (pmd_user(pmd) || pmd_user_exec(pmd));
> Hmm, doesn't this have a funny interaction with PROT_NONE where the pmd is
> invalid but present? If you don't care about PROT_NONE, then you could just
> do:
>
>   pmd_valid(pmd) && !pmd_table(pmd) && (pmd_user(pmd) || pmd_user_exec(pmd))
>
> but if you do care then you could do:
>
>   pmd_leaf(pmd) && !pmd_present_invalid(pmd) && (pmd_user(pmd) || pmd_user_exec(pmd))
I prefer the latter. I will fix and resend later.
>>  static inline bool pud_user_accessible_page(pud_t pud)
>>  {
>> -	return pud_leaf(pud) && pud_user(pud);
>> +	return pud_valid(pud) && pud_leaf(pud) && pud_user(pud);
> Not caused by this patch, but why don't we have something like a
> pud_user_exec() check here like we do for the pte and pmd levels?
As far as I know, there is no user use the user executable pud on arm64, so didn't define pud_user_exec().

Thanks,

>
> Will
> .
>

