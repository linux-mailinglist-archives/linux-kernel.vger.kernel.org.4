Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E1170F7C0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 15:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234669AbjEXNiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 09:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbjEXNiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 09:38:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79B4A7
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 06:37:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C4616336A
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 13:37:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F45DC433EF;
        Wed, 24 May 2023 13:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684935478;
        bh=udO4xQRdc8S2NhttV8djXD6oLRQpuOmuBKmlvUUbirw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jg7VmnK33x6K7forkPCab3heYrUAkktLh0Hzw8o9GdXEteGIprM+Uiq2WzkjRypyW
         fkrEklV1WOzUTl5PSbJBAQccxC+CbE0ljv0DdJ7Xfo7I3oiGo9AHB/TevKAnglp42d
         ZZUnho6U3yWjO4YNTCTflW3jXAaU2X+MLaahtTq2JhyT32mReDYKp6FneIVXk4OqQR
         Bq3plFLeRHvmqTYUBD86yXJXdRPE5TOdTrV1LeKYvxO8IytQUME0i7aGGHCX+9d/9V
         TDuc8DUdGyKpqrBD1ZwZElTbwaz2in5piXH0waHGacLfX1E2nSE+IIH9Vo4JyPuXdj
         haLwXSGzUKeBw==
Date:   Wed, 24 May 2023 21:26:46 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: mm: pass original fault address to
 handle_mm_fault() in PER_VMA_LOCK block
Message-ID: <ZG4QlvkkaoBlyoFC@xhacker>
References: <20230524131238.2791-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230524131238.2791-1-jszhang@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 09:12:38PM +0800, Jisheng Zhang wrote:
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

OOPS, sorry please ignore this one. I pressed ctrl-c to interrupt the
git send-mail, but it's still sent out ;)

Instead, let's focus on
https://lore.kernel.org/linux-arm-kernel/20230524131305.2808-1-jszhang@kernel.org/T/#u

The two patches are the same, I just added Suren into CC list.

> 
> do_page_fault
>   perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, ..., addr)   // orig addr
>   handle_mm_fault
>     mm_account_fault
>       perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, ...) // masked addr
> 
> Fixes: cd7f176aea5f ("arm64/mm: try VMA lock-based page fault handling first")
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
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
> -- 
> 2.40.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
