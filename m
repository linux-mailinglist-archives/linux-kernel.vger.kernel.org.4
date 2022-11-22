Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2146333D5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 04:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbiKVDVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 22:21:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiKVDVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 22:21:42 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AD78F23384
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 19:21:41 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2A561FB;
        Mon, 21 Nov 2022 19:21:47 -0800 (PST)
Received: from [10.162.40.16] (unknown [10.162.40.16])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2939A3F587;
        Mon, 21 Nov 2022 19:21:37 -0800 (PST)
Message-ID: <0a961c6f-31bf-8952-7520-debe81d70b59@arm.com>
Date:   Tue, 22 Nov 2022 08:51:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 1/2] arm64/mm: fix incorrect file_map_count for
 non-leaf pmd/pud
Content-Language: en-US
To:     Liu Shixin <liushixin2@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        David Hildenbrand <dhildenb@redhat.com>,
        Rafael Aquini <raquini@redhat.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221117075602.2904324-1-liushixin2@huawei.com>
 <20221117075602.2904324-2-liushixin2@huawei.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20221117075602.2904324-2-liushixin2@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/17/22 13:26, Liu Shixin wrote:
> The page table check trigger BUG_ON() unexpectedly when collapse hugepage:
> 
>  ------------[ cut here ]------------
>  kernel BUG at mm/page_table_check.c:82!
>  Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
>  Dumping ftrace buffer:
>     (ftrace buffer empty)
>  Modules linked in:
>  CPU: 6 PID: 68 Comm: khugepaged Not tainted 6.1.0-rc3+ #750
>  Hardware name: linux,dummy-virt (DT)
>  pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>  pc : page_table_check_clear.isra.0+0x258/0x3f0
>  lr : page_table_check_clear.isra.0+0x240/0x3f0
> [...]
>  Call trace:
>   page_table_check_clear.isra.0+0x258/0x3f0
>   __page_table_check_pmd_clear+0xbc/0x108
>   pmdp_collapse_flush+0xb0/0x160
>   collapse_huge_page+0xa08/0x1080
>   hpage_collapse_scan_pmd+0xf30/0x1590
>   khugepaged_scan_mm_slot.constprop.0+0x52c/0xac8
>   khugepaged+0x338/0x518
>   kthread+0x278/0x2f8
>   ret_from_fork+0x10/0x20
> [...]
> 
> Since pmd_user_accessible_page() doesn't check if a pmd is leaf, it
> decrease file_map_count for a non-leaf pmd comes from collapse_huge_page().
> and so trigger BUG_ON() unexpectedly.
> 
> Fix this problem by using pmd_leaf() insteal of pmd_present() in
> pmd_user_accessible_page(). Moreover, use pud_leaf() for
> pud_user_accessible_page() too.
> 
> Fixes: 42b2547137f5 ("arm64/mm: enable ARCH_SUPPORTS_PAGE_TABLE_CHECK")
> Reported-by: Denys Vlasenko <dvlasenk@redhat.com>
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Acked-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

>  arch/arm64/include/asm/pgtable.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 71a1af42f0e8..edf6625ce965 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -863,12 +863,12 @@ static inline bool pte_user_accessible_page(pte_t pte)
>  
>  static inline bool pmd_user_accessible_page(pmd_t pmd)
>  {
> -	return pmd_present(pmd) && (pmd_user(pmd) || pmd_user_exec(pmd));
> +	return pmd_leaf(pmd) && (pmd_user(pmd) || pmd_user_exec(pmd));
>  }
>  
>  static inline bool pud_user_accessible_page(pud_t pud)
>  {
> -	return pud_present(pud) && pud_user(pud);
> +	return pud_leaf(pud) && pud_user(pud);
>  }
>  #endif
>  
