Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B88C5F6439
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 12:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbiJFKO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 06:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbiJFKOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 06:14:50 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 52A4BFAD7
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 03:14:49 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 57D73169C;
        Thu,  6 Oct 2022 03:14:55 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.34.149])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B705F3F792;
        Thu,  6 Oct 2022 03:14:47 -0700 (PDT)
Date:   Thu, 6 Oct 2022 11:14:42 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: jump_label: mark arguments as const to
 satisfy asm constraints
Message-ID: <Yz6qksBFFj9Wo9M8@FVFF77S0Q05N.cambridge.arm.com>
References: <20221006075542.2658-1-jszhang@kernel.org>
 <20221006075542.2658-2-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006075542.2658-2-jszhang@kernel.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 03:55:41PM +0800, Jisheng Zhang wrote:
> Inspired by x86 commit 864b435514b2("x86/jump_label: Mark arguments as
> const to satisfy asm constraints"), mark arch_static_branch()'s and
> arch_static_branch_jump()'s arguments as const to satisfy asm
> constraints. And Steven in [1] also pointed out that "The "i"
> constraint needs to be a constant."

It needs to be a *compile-time constant*, but `const` on a function argument
only ensures that the function can't modify the argument, not that it's a
constant in the caller.

I think this is a quirk of the optimizer rather than anything else.

> Tested with building a simple external kernel module with "O0".

Is building with `-O0` supported? I thought we required using `-O2` or above
for a bunch of code that requires constant propagation, etc.

I don't really have a problem with making this const, but I don't particularly
want to try to "fix" all the other code that depends on constant propagation to
assemble, and I'm worried this is the canary in the coal mine.

Thanks,
Mark.

> 
> [1]https://lore.kernel.org/all/20210212094059.5f8d05e8@gandalf.local.home/
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/arm64/include/asm/jump_label.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/jump_label.h b/arch/arm64/include/asm/jump_label.h
> index cea441b6aa5d..48ddc0f45d22 100644
> --- a/arch/arm64/include/asm/jump_label.h
> +++ b/arch/arm64/include/asm/jump_label.h
> @@ -15,8 +15,8 @@
>  
>  #define JUMP_LABEL_NOP_SIZE		AARCH64_INSN_SIZE
>  
> -static __always_inline bool arch_static_branch(struct static_key *key,
> -					       bool branch)
> +static __always_inline bool arch_static_branch(struct static_key * const key,
> +					       const bool branch)
>  {
>  	asm_volatile_goto(
>  		"1:	nop					\n\t"
> @@ -32,8 +32,8 @@ static __always_inline bool arch_static_branch(struct static_key *key,
>  	return true;
>  }
>  
> -static __always_inline bool arch_static_branch_jump(struct static_key *key,
> -						    bool branch)
> +static __always_inline bool arch_static_branch_jump(struct static_key * const key,
> +						    const bool branch)
>  {
>  	asm_volatile_goto(
>  		"1:	b		%l[l_yes]		\n\t"
> -- 
> 2.37.2
> 
