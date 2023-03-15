Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852686BB525
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 14:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbjCONuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 09:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjCONuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 09:50:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5521611669;
        Wed, 15 Mar 2023 06:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=g3mBlB5VPpZ+aaA/RhHEMTqxNoHNebohyy3XehgP994=; b=e4Ov7gaphgtp90s1//nLy6o1l3
        7CoEwOwzcFWI8zLbI7BWjWDkVrK69mTVmHctWfu6FMWh+G4lSiN+SmNrn5DyaXM2LuKvoeGV74s0f
        VK5W8WhRygwx9ZlDQIANn+NlMOTgAuQ51iJMCWcQgNwP9fodPavp30uVcd4DVqUTE//S1rPh49/w1
        Le6blNOKugRIkltXk6rhsN6S4RccMaihfrz7Z+9j8uIvS/7wHl4GPNdenh/pwHEWmgWGDpAl2/9c4
        5FbBXXE1G8PZh8DcTjg4HGtitNnLQLotygclBOugunPiwRwCZ8AdOX+nLoTJUfnimxM5wlR0eeKoG
        IS8ENW2A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pcRVC-00Dscm-RK; Wed, 15 Mar 2023 13:49:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0980F300293;
        Wed, 15 Mar 2023 14:49:11 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D308820FF20AB; Wed, 15 Mar 2023 14:49:11 +0100 (CET)
Date:   Wed, 15 Mar 2023 14:49:11 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Donglin Peng <pengdonglin@sangfor.com.cn>
Cc:     mhiramat@kernel.org, rostedt@goodmis.org, linux@armlinux.org.uk,
        mark.rutland@arm.com, will@kernel.org, catalin.marinas@arm.com,
        palmer@dabbelt.com, paul.walmsley@sifive.com, tglx@linutronix.de,
        dave.hansen@linux.intel.com, x86@kernel.org, mingo@redhat.com,
        xiehuan09@gmail.com, dinghui@sangfor.com.cn,
        huangcun@sangfor.com.cn, dolinux.peng@gmail.com,
        linux-trace-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] function_graph: Support recording and printing
 the return value of function
Message-ID: <20230315134911.GD2006103@hirez.programming.kicks-ass.net>
References: <20230315133911.958741-1-pengdonglin@sangfor.com.cn>
 <20230315133911.958741-2-pengdonglin@sangfor.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315133911.958741-2-pengdonglin@sangfor.com.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 06:39:10AM -0700, Donglin Peng wrote:
> diff --git a/arch/x86/kernel/ftrace_32.S b/arch/x86/kernel/ftrace_32.S
> index a0ed0e4a2c0c..44a773d9de82 100644
> --- a/arch/x86/kernel/ftrace_32.S
> +++ b/arch/x86/kernel/ftrace_32.S
> @@ -184,6 +184,10 @@ SYM_CODE_END(ftrace_graph_caller)
>  return_to_handler:
>  	pushl	%eax
>  	pushl	%edx
> +#ifdef CONFIG_FUNCTION_GRAPH_RETVAL
> +	/* Pass the function return value to ftrace_return_to_handler*/
> +	movl	%eax, %edx
> +#endif
>  	movl	$0, %eax
>  	call	ftrace_return_to_handler
>  	movl	%eax, %ecx
> diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
> index 1265ad519249..35ac9c58dc77 100644
> --- a/arch/x86/kernel/ftrace_64.S
> +++ b/arch/x86/kernel/ftrace_64.S
> @@ -348,6 +348,10 @@ SYM_CODE_START(return_to_handler)
>  	movq %rax, (%rsp)
>  	movq %rdx, 8(%rsp)
>  	movq %rbp, %rdi
> +#ifdef CONFIG_FUNCTION_GRAPH_RETVAL
> +	/* Pass the function return value to ftrace_return_to_handler */
> +	movq %rax, %rsi
> +#endif
>  
>  	call ftrace_return_to_handler

What about the case of double register return values (when the value
is returned in the A,D pair) ?
