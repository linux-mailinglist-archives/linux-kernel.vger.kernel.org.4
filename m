Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F495E79F9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 13:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbiIWLtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 07:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiIWLtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 07:49:02 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C0746135070
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 04:49:00 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42E63139F;
        Fri, 23 Sep 2022 04:49:06 -0700 (PDT)
Received: from [10.163.33.180] (unknown [10.163.33.180])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E49143F73D;
        Fri, 23 Sep 2022 04:48:57 -0700 (PDT)
Message-ID: <92e976b8-5d51-8125-d14a-ba27da6cc285@arm.com>
Date:   Fri, 23 Sep 2022 17:18:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] arm64: mm: handle ARM64_KERNEL_USES_PMD_MAPS in
 vmemmap_populate()
Content-Language: en-US
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
References: <20220920014951.196191-1-wangkefeng.wang@huawei.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20220920014951.196191-1-wangkefeng.wang@huawei.com>
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



On 9/20/22 07:19, Kefeng Wang wrote:
> Directly check ARM64_SWAPPER_USES_SECTION_MAPS to choose base page
> or PMD level huge page mapping in vmemmap_populate() to simplify
> code a bit.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
>  arch/arm64/mm/mmu.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 5810eddfb48e..784afa9c60ac 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -1180,14 +1180,6 @@ static void free_empty_tables(unsigned long addr, unsigned long end,
>  }
>  #endif
>  
> -#if !ARM64_KERNEL_USES_PMD_MAPS
> -int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
> -		struct vmem_altmap *altmap)
> -{
> -	WARN_ON((start < VMEMMAP_START) || (end > VMEMMAP_END));
> -	return vmemmap_populate_basepages(start, end, node, altmap);
> -}
> -#else	/* !ARM64_KERNEL_USES_PMD_MAPS */
>  int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
>  		struct vmem_altmap *altmap)
>  {
> @@ -1199,6 +1191,10 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
>  	pmd_t *pmdp;
>  
>  	WARN_ON((start < VMEMMAP_START) || (end > VMEMMAP_END));
> +
> +	if (!ARM64_KERNEL_USES_PMD_MAPS)
> +		return vmemmap_populate_basepages(start, end, node, altmap);
> +
>  	do {
>  		next = pmd_addr_end(addr, end);
>  
> @@ -1232,7 +1228,6 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
>  
>  	return 0;
>  }
> -#endif	/* !ARM64_KERNEL_USES_PMD_MAPS */
>  
>  #ifdef CONFIG_MEMORY_HOTPLUG
>  void vmemmap_free(unsigned long start, unsigned long end,
