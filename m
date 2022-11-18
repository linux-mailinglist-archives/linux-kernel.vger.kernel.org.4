Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E2D62F7D4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 15:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234971AbiKROiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 09:38:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241422AbiKROiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 09:38:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E438FB13
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 06:35:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7D4E6259B
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 14:35:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 346C9C43145;
        Fri, 18 Nov 2022 14:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668782138;
        bh=5f8m4VNy9K9chtMF/fnSLQKXkNjLWmsBHHTqqHiXsKM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kpILfNqEpjA+pX3LWJfCRwKTyRbE6WuW0Aw8Z/A7BIb+1/sq6EnS3SBEUsOv+XO6Z
         1FCrlJaJ7ljxyPZ4p1ac5w6ej5g0t621os+JSFtT2324FzcWUJEc76/wBe5DF3EJwp
         mztpZtNdoY9htocRm/G5V2hu8jwddV2Cv/H4mo4Lg8SJPK752YEU8Oz3BMwXrajntO
         AdJrJxVESzyoD+aNG7dGimoC5JZiLGkxUhUNxiAtCcFinAlMxmMg86Cn2vszBM/qTJ
         DqFnaQZ5jjZnBcCQXE1soarLZkzwTLrgGkDLlxdTL/bHEBHWAzn0gieFbhg3ccYELV
         fo4YhQEtmUAtg==
Date:   Fri, 18 Nov 2022 14:35:32 +0000
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
Subject: Re: [PATCH v2 1/2] arm64/mm: fix incorrect file_map_count for
 non-leaf pmd/pud
Message-ID: <20221118143531.GH4046@willie-the-truck>
References: <20221117075602.2904324-1-liushixin2@huawei.com>
 <20221117075602.2904324-2-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117075602.2904324-2-liushixin2@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 03:56:01PM +0800, Liu Shixin wrote:
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

Acked-by: Will Deacon <will@kernel.org>

Will
