Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8826869C83E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 11:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbjBTKFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 05:05:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbjBTKFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 05:05:05 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A94A876B1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 02:04:38 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0335715BF;
        Mon, 20 Feb 2023 02:04:43 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.15.112])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 028983F703;
        Mon, 20 Feb 2023 02:03:58 -0800 (PST)
Date:   Mon, 20 Feb 2023 10:02:57 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Sangmoon Kim <sangmoon.kim@samsung.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: pass ESR_ELx to die() of cfi_handler
Message-ID: <Y/NFUXIuRpHScLip@FVFF77S0Q05N>
References: <CGME20230220073527epcas1p1e901bfa667b8c51551d26478013131e6@epcas1p1.samsung.com>
 <20230220073441.2753-1-sangmoon.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230220073441.2753-1-sangmoon.kim@samsung.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 04:34:41PM +0900, Sangmoon Kim wrote:
> Commit 0f2cb928a154 ("arm64: consistently pass ESR_ELx to die()") caused
> all callers to pass the ESR_ELx value to die().
> 
> For consistency, this patch also adds esr to die() call of cfi_handler.
> Also, when CFI error occurs, die handlers can use ESR_ELx value.
> 
> Signed-off-by: Sangmoon Kim <sangmoon.kim@samsung.com>

Consistently reporting the ESR value makes sense to me, so:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/kernel/traps.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index 0ccc063daccb..4a623e2e982b 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -990,7 +990,7 @@ static int cfi_handler(struct pt_regs *regs, unsigned long esr)
>  
>  	switch (report_cfi_failure(regs, regs->pc, &target, type)) {
>  	case BUG_TRAP_TYPE_BUG:
> -		die("Oops - CFI", regs, 0);
> +		die("Oops - CFI", regs, esr);
>  		break;
>  
>  	case BUG_TRAP_TYPE_WARN:
> -- 
> 2.17.1
> 
