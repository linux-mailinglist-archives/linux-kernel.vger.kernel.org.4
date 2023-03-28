Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 398236CC1AE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 16:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbjC1OFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 10:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbjC1OFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 10:05:13 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25AD3CC1C;
        Tue, 28 Mar 2023 07:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=04vP3RzMs3P/u6ra9aohOJriuOsHdgwipqyExrFrTjc=; b=mh6/AUJNqn+FdcuZzLxS1JRPCX
        9PjtU4toaTdFVFl8Oq9o4nbuQoE4aiZM9QOcGREWE4jLWY5DoSYbELFv8DeY1wFP2mTYG070hd6Wd
        Tfe7eR5++Rk8eczns5zb+jJ9Ky7ydT3o9MEOVkd+Mvo6y2Qjj49i8W/cXrM3mUJ50OxS/wVoAjwtZ
        4xrdvc55AKGF1grOslzBDBZlBkvSAxdNwdMzb7XPRz/+prNath1ct2o3sL3EpinKQF/tOKsNcQqQw
        Ig2781259z8H1OdssQ8MsAn/tTHXr6eCszj7n0Dxt3/by0YcDWPkadhEKH46s76AMvQbseCeW5+h7
        yic00bRw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51186)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1ph9uX-0006Pz-8z; Tue, 28 Mar 2023 15:02:53 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1ph9uJ-0006WX-6C; Tue, 28 Mar 2023 15:02:39 +0100
Date:   Tue, 28 Mar 2023 15:02:39 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Donglin Peng <pengdonglin@sangfor.com.cn>
Cc:     mhiramat@kernel.org, rostedt@goodmis.org, mark.rutland@arm.com,
        will@kernel.org, catalin.marinas@arm.com, palmer@dabbelt.com,
        paul.walmsley@sifive.com, tglx@linutronix.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        chenhuacai@kernel.org, zhangqing@loongson.cn, kernel@xen0n.name,
        mingo@redhat.com, peterz@infradead.org, xiehuan09@gmail.com,
        dinghui@sangfor.com.cn, huangcun@sangfor.com.cn,
        dolinux.peng@gmail.com, linux-trace-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 3/8] ARM: ftrace: Enable HAVE_FUNCTION_GRAPH_RETVAL
Message-ID: <ZCLzf6RX4U00g9Cu@shell.armlinux.org.uk>
References: <20230328134319.2185812-1-pengdonglin@sangfor.com.cn>
 <20230328134319.2185812-4-pengdonglin@sangfor.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328134319.2185812-4-pengdonglin@sangfor.com.cn>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 06:43:14AM -0700, Donglin Peng wrote:
> The commit d4815c5d1bbd ("function_graph: Support recording and printing
> the return value of function") laid the groundwork for the for the
> funcgraph-retval, and this modification makes it available on the
> ARM platform.
> 
> We introduce a new structure called fgraph_ret_regs for the ARM platform
> to hold return registers and the frame pointer. We then fill its content
> in the return_to_handler and pass its address to the function
> ftrace_return_to_handler to record the return value.
> 
> Signed-off-by: Donglin Peng <pengdonglin@sangfor.com.cn>
> ---
> v8:
>  - Modify the control range of CONFIG_HAVE_FUNCTION_GRAPH_RETVAL
> ---
>  arch/arm/Kconfig               |  1 +
>  arch/arm/include/asm/ftrace.h  | 18 ++++++++++++++++++
>  arch/arm/kernel/entry-ftrace.S |  6 +++++-
>  3 files changed, 24 insertions(+), 1 deletion(-)
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
> index 7e9251ca29fe..2ab4bee21d79 100644
> --- a/arch/arm/include/asm/ftrace.h
> +++ b/arch/arm/include/asm/ftrace.h
> @@ -77,4 +77,22 @@ static inline bool arch_syscall_match_sym_name(const char *sym,
>  
>  #endif /* ifndef __ASSEMBLY__ */
>  
> +
> +#ifndef __ASSEMBLY__
> +struct fgraph_ret_regs {
> +	unsigned long regs[4];
> +	unsigned long fp;
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
> +#endif
> +
>  #endif /* _ASM_ARM_FTRACE */
> diff --git a/arch/arm/kernel/entry-ftrace.S b/arch/arm/kernel/entry-ftrace.S
> index 3e7bcaca5e07..5f1e74555b25 100644
> --- a/arch/arm/kernel/entry-ftrace.S
> +++ b/arch/arm/kernel/entry-ftrace.S
> @@ -257,11 +257,15 @@ ENDPROC(ftrace_graph_regs_caller)
>  
>  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
>  ENTRY(return_to_handler)
> +	sub	sp, sp, #4
>  	stmdb	sp!, {r0-r3}
> -	add	r0, sp, #16		@ sp at exit of instrumented routine
> +	add	r0, sp, #20		@ sp at exit of instrumented routine
> +	str	r0, [sp, #16]
> +	mov	r0, sp

1) EABI wants the stack to be aligned to 8 bytes.
2) We can do better than this.

	mov	ip, sp
	stmdb	sp!, {r0-r3, ip, lr}
	mov	r0, sp

>  	bl	ftrace_return_to_handler
>  	mov	lr, r0			@ r0 has real ret addr
>  	ldmia	sp!, {r0-r3}

	ldmia	sp, {r0-r3}		@ since we need to manually adjust sp,

> +	add	sp, sp, #4		@ skip fp

	add	sp, sp, #4 * 6		@ restore stack pointer here

>  	ret	lr
>  ENDPROC(return_to_handler)
>  #endif
> -- 
> 2.25.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
