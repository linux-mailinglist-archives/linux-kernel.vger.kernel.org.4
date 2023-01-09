Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001AD662C87
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 18:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234555AbjAIRUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 12:20:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234812AbjAIRUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 12:20:02 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 30A77175B0
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 09:20:02 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E193FC14;
        Mon,  9 Jan 2023 09:20:43 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.37.246])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C9DC3F587;
        Mon,  9 Jan 2023 09:19:59 -0800 (PST)
Date:   Mon, 9 Jan 2023 17:19:56 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     guoren@kernel.org
Cc:     anup@brainfault.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        conor.dooley@microchip.com, heiko@sntech.de, rostedt@goodmis.org,
        mhiramat@kernel.org, jolsa@redhat.com, bp@suse.de,
        jpoimboe@kernel.org, suagrfillet@gmail.com, andy.chiu@sifive.com,
        e.shatokhin@yadro.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next V6 1/7] riscv: ftrace: Fixup panic by disabling
 preemption
Message-ID: <Y7xMvAJXjHaus0Bm@FVFF77S0Q05N>
References: <20230107133549.4192639-1-guoren@kernel.org>
 <20230107133549.4192639-2-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230107133549.4192639-2-guoren@kernel.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 07, 2023 at 08:35:43AM -0500, guoren@kernel.org wrote:
> From: Andy Chiu <andy.chiu@sifive.com>
> 
> In RISCV, we must use an AUIPC + JALR pair to encode an immediate,
> forming a jump that jumps to an address over 4K. This may cause errors
> if we want to enable kernel preemption and remove dependency from
> patching code with stop_machine(). For example, if a task was switched
> out on auipc. And, if we changed the ftrace function before it was
> switched back, then it would jump to an address that has updated 11:0
> bits mixing with previous XLEN:12 part.
> 
> p: patched area performed by dynamic ftrace
> ftrace_prologue:
> p|      REG_S   ra, -SZREG(sp)
> p|      auipc   ra, 0x? ------------> preempted
> 					...
> 				change ftrace function
> 					...
> p|      jalr    -?(ra) <------------- switched back
> p|      REG_L   ra, -SZREG(sp)
> func:
> 	xxx
> 	ret

What happens on SMP but not !PREEMPTION; can't a CPU be in the middle of this
while you're patching the sequence?

Do you have any guarantee as to the atomicity and ordering of instruction
fetches?

Thanks,
Mark.

> 
> Fixes: afc76b8b8011 ("riscv: Using PATCHABLE_FUNCTION_ENTRY instead of MCOUNT")
> Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> ---
>  arch/riscv/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index e2b656043abf..ee0d39b26794 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -138,7 +138,7 @@ config RISCV
>  	select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
>  	select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
>  	select HAVE_FUNCTION_GRAPH_TRACER
> -	select HAVE_FUNCTION_TRACER if !XIP_KERNEL
> +	select HAVE_FUNCTION_TRACER if !XIP_KERNEL && !PREEMPTION
>  
>  config ARCH_MMAP_RND_BITS_MIN
>  	default 18 if 64BIT
> -- 
> 2.36.1
> 
