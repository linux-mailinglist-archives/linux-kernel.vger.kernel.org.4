Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74184728D60
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 03:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236418AbjFIB53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 21:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjFIB51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 21:57:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7727C30C8;
        Thu,  8 Jun 2023 18:57:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0EB0A65189;
        Fri,  9 Jun 2023 01:57:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DA3EC433D2;
        Fri,  9 Jun 2023 01:57:22 +0000 (UTC)
Date:   Thu, 8 Jun 2023 21:57:19 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Donglin Peng <pengdonglin@sangfor.com.cn>
Cc:     mhiramat@kernel.org, linux@armlinux.org.uk, mark.rutland@arm.com,
        will@kernel.org, catalin.marinas@arm.com,
        rmk+kernel@armlinux.org.uk, palmer@dabbelt.com,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
        tglx@linutronix.de, dave.hansen@linux.intel.com, x86@kernel.org,
        bp@alien8.de, hpa@zytor.com, chenhuacai@kernel.org,
        zhangqing@loongson.cn, kernel@xen0n.name, mingo@redhat.com,
        peterz@infradead.org, xiehuan09@gmail.com, dinghui@sangfor.com.cn,
        huangcun@sangfor.com.cn, dolinux.peng@gmail.com,
        linux-trace-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 3/8] ARM: ftrace: Enable HAVE_FUNCTION_GRAPH_RETVAL
Message-ID: <20230608215719.7537ce38@gandalf.local.home>
In-Reply-To: <c61eb9290c3e817d4d70c429c0e987e3ec51a3c4.1680954589.git.pengdonglin@sangfor.com.cn>
References: <cover.1680954589.git.pengdonglin@sangfor.com.cn>
        <c61eb9290c3e817d4d70c429c0e987e3ec51a3c4.1680954589.git.pengdonglin@sangfor.com.cn>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  8 Apr 2023 05:42:17 -0700
Donglin Peng <pengdonglin@sangfor.com.cn> wrote:

> The previous patch ("function_graph: Support recording and printing
> the return value of function") has laid the groundwork for the for
> the funcgraph-retval, and this modification makes it available on
> the ARM platform.
> 
> We introduce a new structure called fgraph_ret_regs for the ARM platform
> to hold return registers and the frame pointer. We then fill its content
> in the return_to_handler and pass its address to the function
> ftrace_return_to_handler to record the return value.
> 
> Signed-off-by: Donglin Peng <pengdonglin@sangfor.com.cn>

I really don't want to add this without an ack from an arm maintainer.

I have the patches queued (for testing), but I may remove the ones that do
not have the appropriate acks.

-- Steve


> ---
> v10:
>  - Use CONFIG_FUNCTION_GRAPH_TRACER to control fgraph_ret_regs definition
> 
> v9:
>  - Fix stack pointer align issues
>  - Update the commit message
> 
> v8:
>  - Modify the control range of CONFIG_HAVE_FUNCTION_GRAPH_RETVAL
> ---
>  arch/arm/Kconfig               |  1 +
>  arch/arm/include/asm/ftrace.h  | 22 ++++++++++++++++++++++
>  arch/arm/kernel/asm-offsets.c  |  8 +++++++-
>  arch/arm/kernel/entry-ftrace.S | 10 ++++++----
>  4 files changed, 36 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index e24a9820e12f..73061379855a 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -98,6 +98,7 @@ config ARM
>  	select HAVE_FAST_GUP if ARM_LPAE
>  	select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
>  	select HAVE_FUNCTION_ERROR_INJECTION
> +	select HAVE_FUNCTION_GRAPH_RETVAL if HAVE_FUNCTION_GRAPH_TRACER
>  	select HAVE_FUNCTION_GRAPH_TRACER
>  	select HAVE_FUNCTION_TRACER if !XIP_KERNEL
>  	select HAVE_GCC_PLUGINS
> diff --git a/arch/arm/include/asm/ftrace.h b/arch/arm/include/asm/ftrace.h
> index 7e9251ca29fe..3c457902b355 100644
> --- a/arch/arm/include/asm/ftrace.h
> +++ b/arch/arm/include/asm/ftrace.h
> @@ -77,4 +77,26 @@ static inline bool arch_syscall_match_sym_name(const char *sym,
>  
>  #endif /* ifndef __ASSEMBLY__ */
>  
> +#ifndef __ASSEMBLY__
> +#ifdef CONFIG_FUNCTION_GRAPH_TRACER
> +struct fgraph_ret_regs {
> +	/* r0 - r3 */
> +	unsigned long regs[4];
> +
> +	unsigned long fp;
> +	unsigned long __unused;
> +};
> +
> +static inline unsigned long fgraph_ret_regs_return_value(struct fgraph_ret_regs *ret_regs)
> +{
> +	return ret_regs->regs[0];
> +}
> +
> +static inline unsigned long fgraph_ret_regs_frame_pointer(struct fgraph_ret_regs *ret_regs)
> +{
> +	return ret_regs->fp;
> +}
> +#endif /* ifdef CONFIG_FUNCTION_GRAPH_TRACER */
> +#endif
> +
>  #endif /* _ASM_ARM_FTRACE */
> diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
> index 38121c59cbc2..18bb85115b21 100644
> --- a/arch/arm/kernel/asm-offsets.c
> +++ b/arch/arm/kernel/asm-offsets.c
> @@ -23,6 +23,7 @@
>  #include <asm/suspend.h>
>  #include <asm/vdso_datapage.h>
>  #include <asm/hardware/cache-l2x0.h>
> +#include <asm/ftrace.h>
>  #include <linux/kbuild.h>
>  #include <linux/arm-smccc.h>
>  #include "signal.h"
> @@ -170,5 +171,10 @@ int main(void)
>    DEFINE(KEXEC_INDIR_PAGE,	offsetof(struct kexec_relocate_data, kexec_indirection_page));
>    DEFINE(KEXEC_MACH_TYPE,	offsetof(struct kexec_relocate_data, kexec_mach_type));
>    DEFINE(KEXEC_R2,		offsetof(struct kexec_relocate_data, kexec_r2));
> -  return 0; 
> +#ifdef CONFIG_FUNCTION_GRAPH_TRACER
> +  BLANK();
> +  DEFINE(FGRET_REGS_SIZE,	sizeof(struct fgraph_ret_regs));
> +  BLANK();
> +#endif
> +  return 0;
>  }
> diff --git a/arch/arm/kernel/entry-ftrace.S b/arch/arm/kernel/entry-ftrace.S
> index 3e7bcaca5e07..d41a1676608c 100644
> --- a/arch/arm/kernel/entry-ftrace.S
> +++ b/arch/arm/kernel/entry-ftrace.S
> @@ -257,11 +257,13 @@ ENDPROC(ftrace_graph_regs_caller)
>  
>  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
>  ENTRY(return_to_handler)
> -	stmdb	sp!, {r0-r3}
> -	add	r0, sp, #16		@ sp at exit of instrumented routine
> +	mov	ip, sp				@ sp at exit of instrumented routine
> +	stmdb	sp!, {r0-r3, ip, lr}		@ fill fgraph_ret_regs
> +	mov	r0, sp
>  	bl	ftrace_return_to_handler
> -	mov	lr, r0			@ r0 has real ret addr
> -	ldmia	sp!, {r0-r3}
> +	mov	lr, r0				@ r0 has real ret addr
> +	ldmia	sp, {r0-r3}
> +	add	sp, sp, #FGRET_REGS_SIZE	@ restore stack pointer
>  	ret	lr
>  ENDPROC(return_to_handler)
>  #endif

