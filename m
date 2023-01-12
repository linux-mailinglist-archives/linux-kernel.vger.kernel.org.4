Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADA26671E3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 13:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235484AbjALMQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 07:16:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232622AbjALMQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 07:16:14 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AEB8FDF26
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 04:16:07 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C6541063;
        Thu, 12 Jan 2023 04:16:49 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.43.206])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 09C7D3F67D;
        Thu, 12 Jan 2023 04:16:04 -0800 (PST)
Date:   Thu, 12 Jan 2023 12:16:02 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     guoren@kernel.org
Cc:     anup@brainfault.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        conor.dooley@microchip.com, heiko@sntech.de, rostedt@goodmis.org,
        mhiramat@kernel.org, jolsa@redhat.com, bp@suse.de,
        jpoimboe@kernel.org, suagrfillet@gmail.com, andy.chiu@sifive.com,
        e.shatokhin@yadro.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next V7 1/7] riscv: ftrace: Fixup panic by disabling
 preemption
Message-ID: <Y7/6AtX5X0+5qF6Y@FVFF77S0Q05N>
References: <20230112090603.1295340-1-guoren@kernel.org>
 <20230112090603.1295340-2-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112090603.1295340-2-guoren@kernel.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guo,

On Thu, Jan 12, 2023 at 04:05:57AM -0500, guoren@kernel.org wrote:
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

As mentioned on the last posting, I don't think this is sufficient to fix the
issue. I've replied with more detail there:

  https://lore.kernel.org/lkml/Y7%2F3hoFjS49yy52W@FVFF77S0Q05N/

Even in a non-preemptible SMP kernel, if one CPU can be in the middle of
executing the ftrace_prologue while another CPU is patching the
ftrace_prologue, you have the exact same issue.

For example, if CPU X is in the prologue fetches the old AUIPC and the new
JALR (because it races with CPU Y modifying those), CPU X will branch to the
wrong address. The race window is much smaller in the absence of preemption,
but it's still there (and will be exacerbated in virtual machines since the
hypervisor can preempt a vCPU at any time).

Note that the above is even assuming that instruction fetches are atomic, which
I'm not sure is the case; for example arm64 has special CMODX / "Concurrent
MODification and eXecutuion of instructions" rules which mean only certain
instructions can be patched atomically.

Either I'm missing something that provides mutual exclusion between the
patching and execution of the ftrace_prologue, or this patch is not sufficient.

Thanks,
Mark.

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
