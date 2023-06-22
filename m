Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7190A73A1D8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 15:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjFVN30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 09:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjFVN3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 09:29:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7CD0BC
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 06:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CboDw6vUaL/rlxQVo6XrrFj4vgADcvUQsYwKdrHoosM=; b=BlHS12S7F9Y72Uj6CJ2mWs1ic7
        3krfo3AnbOjBD0YunP9jgbQOgodSZAnOa9/HWuTvNla4uZEkGv/04K8Z4ffZhuNwq198Sz+ryOntd
        QIfowAoy6EkPjP6CyXDmuZJ4yRECeWrF7xTblbpMaBzpY0rBA82pIlKgMICLRiK/jj5hBArGPaH5E
        EKDukNY3iqtW95XQ0HCmgYyJTS9UHzXqAajpWY1Yn3J+r1Q3TGc1t2mYp7XZ7rwFsW+Qh/o0W/lKI
        wV+nwq9q9zoswf3nr4DL7t9ljtpi00tOeQZLs6ZATBlibJYejbqKO/cynOVgEFbWeRx9/UEKQ4TGH
        pCHYyGcg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qCKMz-00FdbL-Up; Thu, 22 Jun 2023 13:29:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3300D300274;
        Thu, 22 Jun 2023 15:29:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1BC44241BF9B6; Thu, 22 Jun 2023 15:29:04 +0200 (CEST)
Date:   Thu, 22 Jun 2023 15:29:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Brian Gerst <brgerst@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        alyssa.milburn@linux.intel.com, keescook@chromium.org,
        jpoimboe@kernel.org, joao@overdrivepizza.com,
        tim.c.chen@linux.intel.com
Subject: Re: [PATCH 2/2] x86: Rewrite ret_from_fork() in C
Message-ID: <20230622132904.GR4253@hirez.programming.kicks-ass.net>
References: <20230622120750.5549-1-brgerst@gmail.com>
 <20230622120750.5549-3-brgerst@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622120750.5549-3-brgerst@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 08:07:50AM -0400, Brian Gerst wrote:
> When kCFI is enabled, special handling is needed for the indirect call
> to the kernel thread function.  Rewrite the ret_from_fork() function in
> C so that the compiler can properly handle the indirect call.
> 
> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Brian Gerst <brgerst@gmail.com>

This is much nicer indeed. I'll take these patches into my series and
repost later today if you don't mind.

One little niggle below..

> ---

> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index f31e286c2977..5ee32e7e29e8 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -284,36 +284,21 @@ SYM_FUNC_END(__switch_to_asm)
>   * r12: kernel thread arg
>   */
>  .pushsection .text, "ax"
> +SYM_CODE_START(ret_from_fork_asm)
>  	UNWIND_HINT_END_OF_STACK
>  	ANNOTATE_NOENDBR // copy_thread
>  	CALL_DEPTH_ACCOUNT
>  
> +	/* return address for the stack unwinder */
> +	pushq	$swapgs_restore_regs_and_return_to_usermode
> +	UNWIND_HINT_FUNC
>  
> +	movq	%rax, %rdi		/* prev */
> +	movq	%rsp, %rsi		/* regs */
> +	movq	%rbx, %rdx		/* fn */
> +	movq	%r12, %rcx		/* fn_arg */
> +	jmp	ret_from_fork
> +SYM_CODE_END(ret_from_fork_asm)
>  .popsection
>  
>  .macro DEBUG_ENTRY_ASSERT_IRQS_OFF

> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index dac41a0072ea..f5dbfebac076 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -28,6 +28,7 @@
>  #include <linux/static_call.h>
>  #include <trace/events/power.h>
>  #include <linux/hw_breakpoint.h>
> +#include <linux/entry-common.h>
>  #include <asm/cpu.h>
>  #include <asm/apic.h>
>  #include <linux/uaccess.h>
> @@ -134,6 +135,25 @@ static int set_new_tls(struct task_struct *p, unsigned long tls)
>  		return do_set_thread_area_64(p, ARCH_SET_FS, tls);
>  }
>  
> +__visible noinstr void ret_from_fork(struct task_struct *prev, struct pt_regs *regs,
> +				     int (*fn)(void *), void *fn_arg)

So I had noinstr in my initial patch, but it leads to objtool
complaints. I suppose we can actually handle tracing and all the other
gunk at this point, so I've removed it.

The alternative is to use __noinstr_section(".text") if we really want
to suppress all the funnies.

> +{
> +	schedule_tail(prev);
> +
> +	/* Is this a kernel thread? */
> +	if (unlikely(fn)) {
> +		fn(fn_arg);
> +		/*
> +		 * A kernel thread is allowed to return here after successfully
> +		 * calling kernel_execve().  Exit to userspace to complete the
> +		 * execve() syscall.
> +		 */
> +		regs->ax = 0;
> +	}
> +
> +	syscall_exit_to_user_mode(regs);
> +}
