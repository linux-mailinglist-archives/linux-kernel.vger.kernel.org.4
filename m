Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A711462DC08
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 13:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234774AbiKQMyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 07:54:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234528AbiKQMxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 07:53:30 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6291C12612
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 04:53:28 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7FEBE1063;
        Thu, 17 Nov 2022 04:53:34 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.70.181])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 13FBC3F663;
        Thu, 17 Nov 2022 04:53:26 -0800 (PST)
Date:   Thu, 17 Nov 2022 12:53:24 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/mm: Drop unused restore_ttbr1
Message-ID: <Y3YuxAHeXS5FXPeG@FVFF77S0Q05N>
References: <20221117123144.403582-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117123144.403582-1-anshuman.khandual@arm.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 06:01:44PM +0530, Anshuman Khandual wrote:
> restore_ttbr1 procedure is not used anywhere, hence just drop it.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
> This applies on v6.1-rc5
> 
>  arch/arm64/include/asm/assembler.h | 11 -----------
>  1 file changed, 11 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
> index e5957a53be39..f13bc52ab347 100644
> --- a/arch/arm64/include/asm/assembler.h
> +++ b/arch/arm64/include/asm/assembler.h
> @@ -619,17 +619,6 @@ alternative_endif
>  #endif
>  	.endm
>  
> -/*
> - * Perform the reverse of offset_ttbr1.
> - * bic is used as it can cover the immediate value and, in future, won't need
> - * to be nop'ed out when dealing with 52-bit kernel VAs.
> - */
> -	.macro	restore_ttbr1, ttbr
> -#ifdef CONFIG_ARM64_VA_BITS_52
> -	bic	\ttbr, \ttbr, #TTBR1_BADDR_4852_OFFSET
> -#endif
> -	.endm
> -
>  /*
>   * Arrange a physical address in a TTBR register, taking care of 52-bit
>   * addresses.
> -- 
> 2.25.1
> 
