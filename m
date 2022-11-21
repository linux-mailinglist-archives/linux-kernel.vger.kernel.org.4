Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 473EF632BF5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 19:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbiKUSTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 13:19:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbiKUSTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 13:19:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F84CB9FA
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 10:19:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 205E861320
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 18:19:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CAB6C433C1;
        Mon, 21 Nov 2022 18:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669054745;
        bh=OcZAQMenLu0rqnKBbFddmTe4rP6h4SnbNgtiuE84sag=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QmGXoOQf/yvYCWS/zJOYGVzbk/6LScWFjasUiXlQ9av9cNltUVpyruwrhcLpZCcqR
         uu88TgeHiDaCs5R7PJFLdGq/zF9aUdfJPsZdAoHd50zhqQr+Bg3Qpp7bAkXn7leoon
         p37GWe6DRizTOEbZAxI60kkirkL0bgi7IPQgwL67a+NTWDS05gvDE81vwLQVN6gJFa
         L0rPNHQxQkwpaHVnCnomt4ibhxY4MAabvAt/m30erBxMSez5dCiQUtZxoDBc+XVbFa
         z2pN6HA0J/IyHDxg/fX8DYhsPQKK1RP7z92X8AI0iHBU8q5HIFPyqFBdNkZVZSCMd/
         ZvqGfvJ8d8URA==
Date:   Mon, 21 Nov 2022 18:18:59 +0000
From:   Will Deacon <will@kernel.org>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        David Hildenbrand <dhildenb@redhat.com>,
        Rafael Aquini <raquini@redhat.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] arm64/mm: fix incorrect file_map_count for invalid pmd
Message-ID: <20221121181859.GE7645@willie-the-truck>
References: <20221121073608.4183459-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121073608.4183459-1-liushixin2@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 03:36:08PM +0800, Liu Shixin wrote:
> The page table check trigger BUG_ON() unexpectedly when split hugepage:
> 
>  ------------[ cut here ]------------
>  kernel BUG at mm/page_table_check.c:119!
>  Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
>  Dumping ftrace buffer:
>     (ftrace buffer empty)
>  Modules linked in:
>  CPU: 7 PID: 210 Comm: transhuge-stres Not tainted 6.1.0-rc3+ #748
>  Hardware name: linux,dummy-virt (DT)
>  pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>  pc : page_table_check_set.isra.0+0x398/0x468
>  lr : page_table_check_set.isra.0+0x1c0/0x468
> [...]
>  Call trace:
>   page_table_check_set.isra.0+0x398/0x468
>   __page_table_check_pte_set+0x160/0x1c0
>   __split_huge_pmd_locked+0x900/0x1648
>   __split_huge_pmd+0x28c/0x3b8
>   unmap_page_range+0x428/0x858
>   unmap_single_vma+0xf4/0x1c8
>   zap_page_range+0x2b0/0x410
>   madvise_vma_behavior+0xc44/0xe78
>   do_madvise+0x280/0x698
>   __arm64_sys_madvise+0x90/0xe8
>   invoke_syscall.constprop.0+0xdc/0x1d8
>   do_el0_svc+0xf4/0x3f8
>   el0_svc+0x58/0x120
>   el0t_64_sync_handler+0xb8/0xc0
>   el0t_64_sync+0x19c/0x1a0
> [...]
> 
> On arm64, pmd_leaf() will return true even if the pmd is invalid due to
> pmd_present_invalid() check. So in pmdp_invalidate() the file_map_count
> will not only decrease once but also increase once. Then in set_pte_at(),
> the file_map_count increase again, and so trigger BUG_ON() unexpectedly.
> 
> Add !pmd_present_invalid() check in pmd_user_accessible_page() to fix the
> problem.
> 
> Fixes: 42b2547137f5 ("arm64/mm: enable ARCH_SUPPORTS_PAGE_TABLE_CHECK")
> Reported-by: Denys Vlasenko <dvlasenk@redhat.com>
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> Acked-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
> v1->v2: Update comment and optimize the code by moving p?d_valid() at
> 	first place suggested by Mark.
> v2->v3: Replace pmd_valid() with pmd_present_invalid() suggested by Will.
> 
>  arch/arm64/include/asm/pgtable.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index edf6625ce965..17afb09f386f 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -863,7 +863,7 @@ static inline bool pte_user_accessible_page(pte_t pte)
>  
>  static inline bool pmd_user_accessible_page(pmd_t pmd)
>  {
> -	return pmd_leaf(pmd) && (pmd_user(pmd) || pmd_user_exec(pmd));
> +	return pmd_leaf(pmd) && !pmd_present_invalid(pmd) && (pmd_user(pmd) || pmd_user_exec(pmd));
>  }

Acked-by: Will Deacon <will@kernel.org>

But please see my comment on v2 about pud_user_exec() for the PUD case.

Will
