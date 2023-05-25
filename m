Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8C17105E0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 09:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233863AbjEYHAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 03:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233760AbjEYHAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 03:00:11 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1E48EE46
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 00:00:09 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EEFAF1042;
        Thu, 25 May 2023 00:00:53 -0700 (PDT)
Received: from [10.162.43.6] (unknown [10.162.43.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1DB363F762;
        Thu, 25 May 2023 00:00:06 -0700 (PDT)
Message-ID: <0b136cc3-c85e-1183-5ddc-ab99fd58c012@arm.com>
Date:   Thu, 25 May 2023 12:30:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] arm64: mm: pass original fault address to
 handle_mm_fault() in PER_VMA_LOCK block
Content-Language: en-US
To:     Jisheng Zhang <jszhang@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230524131238.2791-1-jszhang@kernel.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20230524131238.2791-1-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/24/23 18:42, Jisheng Zhang wrote:
> When reading the arm64's PER_VMA_LOCK support code, I found a bit
> difference between arm64 and other arch when calling handle_mm_fault()
> during VMA lock-based page fault handling: the fault address is masked
> before passing to handle_mm_fault(). This is also different from the
> usage in mmap_lock-based handling. I think we need to pass the
> original fault address to handle_mm_fault() as we did in
> commit 84c5e23edecd ("arm64: mm: Pass original fault address to
> handle_mm_fault()").
> 
> If we go through the code path further, we can find that the "masked"
> fault address can cause mismatched fault address between perf sw
> major/minor page fault sw event and perf page fault sw event:
> 
> do_page_fault
>   perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, ..., addr)   // orig addr
>   handle_mm_fault
>     mm_account_fault
>       perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, ...) // masked addr
> 
> Fixes: cd7f176aea5f ("arm64/mm: try VMA lock-based page fault handling first")
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

LGTM

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
>  arch/arm64/mm/fault.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index cb21ccd7940d..6045a5117ac1 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -600,8 +600,7 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
>  		vma_end_read(vma);
>  		goto lock_mmap;
>  	}
> -	fault = handle_mm_fault(vma, addr & PAGE_MASK,
> -				mm_flags | FAULT_FLAG_VMA_LOCK, regs);
> +	fault = handle_mm_fault(vma, addr, mm_flags | FAULT_FLAG_VMA_LOCK, regs);
>  	vma_end_read(vma);
>  
>  	if (!(fault & VM_FAULT_RETRY)) {
