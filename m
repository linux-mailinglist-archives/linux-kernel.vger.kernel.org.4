Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A61386F15DF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 12:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233293AbjD1KlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 06:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjD1KlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 06:41:19 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 783BFFF
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 03:41:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5016FC14;
        Fri, 28 Apr 2023 03:42:01 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.21.9])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DED143F64C;
        Fri, 28 Apr 2023 03:41:15 -0700 (PDT)
Date:   Fri, 28 Apr 2023 11:41:13 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v3 02/60] arm64: mm: Take potential load offset into
 account when KASLR is off
Message-ID: <ZEuiyaINUp+bXgx2@FVFF77S0Q05N>
References: <20230307140522.2311461-1-ardb@kernel.org>
 <20230307140522.2311461-3-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307140522.2311461-3-ardb@kernel.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023 at 03:04:24PM +0100, Ard Biesheuvel wrote:
> We enable CONFIG_RELOCATABLE even when CONFIG_RANDOMIZE_BASE is
> disabled, and this permits the loader (i.e., EFI) to place the kernel
> anywhere in physical memory as long as the base address is 64k aligned.
> 
> This means that the 'KASLR' case described in the header that defines
> the size of the statically allocated page tables could take effect even
> when CONFIG_RANDMIZE_BASE=n. So check for CONFIG_RELOCATABLE instead.

Could we pleqase update the comment to describe that? As of this commit it'll
be left describing a KASLR-specific case, and it'd be good to have it mention
the case described in this commit message.

Thanks,
Mark.

> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/arm64/include/asm/kernel-pgtable.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/kernel-pgtable.h b/arch/arm64/include/asm/kernel-pgtable.h
> index fcd14197756f0619..4d13c73171e1e360 100644
> --- a/arch/arm64/include/asm/kernel-pgtable.h
> +++ b/arch/arm64/include/asm/kernel-pgtable.h
> @@ -53,7 +53,7 @@
>   * address is just pushed over a boundary and the start address isn't).
>   */
>  
> -#ifdef CONFIG_RANDOMIZE_BASE
> +#ifdef CONFIG_RELOCATABLE
>  #define EARLY_KASLR	(1)
>  #else
>  #define EARLY_KASLR	(0)
> -- 
> 2.39.2
> 
> 
