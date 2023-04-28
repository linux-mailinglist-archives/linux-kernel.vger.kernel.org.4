Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B55946F19C0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 15:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346255AbjD1Nh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 09:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjD1NhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 09:37:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBD5173E;
        Fri, 28 Apr 2023 06:37:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B456643D9;
        Fri, 28 Apr 2023 13:37:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19CF9C433D2;
        Fri, 28 Apr 2023 13:37:22 +0000 (UTC)
Date:   Fri, 28 Apr 2023 09:37:19 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Hou Wenlong" <houwenlong.hwl@antgroup.com>
Cc:     linux-kernel@vger.kernel.org,
        "Thomas Garnier" <thgarnie@chromium.org>,
        "Lai Jiangshan" <jiangshan.ljs@antgroup.com>,
        "Kees Cook" <keescook@chromium.org>,
        "Masami Hiramatsu" <mhiramat@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC 21/43] x86/ftrace: Adapt assembly for PIE support
Message-ID: <20230428093719.037081e3@gandalf.local.home>
In-Reply-To: <0092ce94b325ad8eb47ff4f95e012f9af1a127de.1682673543.git.houwenlong.hwl@antgroup.com>
References: <cover.1682673542.git.houwenlong.hwl@antgroup.com>
        <0092ce94b325ad8eb47ff4f95e012f9af1a127de.1682673543.git.houwenlong.hwl@antgroup.com>
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

On Fri, 28 Apr 2023 17:51:01 +0800
"Hou Wenlong" <houwenlong.hwl@antgroup.com> wrote:

> Change the assembly code to use only relative references of symbols for
> the kernel to be PIE compatible.
> 
> Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
> Cc: Thomas Garnier <thgarnie@chromium.org>
> Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> Cc: Kees Cook <keescook@chromium.org>
> ---
>  arch/x86/kernel/ftrace_64.S | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
> index eddb4fabc16f..411fa4148e18 100644
> --- a/arch/x86/kernel/ftrace_64.S
> +++ b/arch/x86/kernel/ftrace_64.S
> @@ -315,7 +315,14 @@ STACK_FRAME_NON_STANDARD_FP(ftrace_regs_caller)
>  SYM_FUNC_START(__fentry__)
>  	CALL_DEPTH_ACCOUNT
>  
> +#ifdef CONFIG_X86_PIE
> +	pushq %r8
> +	leaq ftrace_stub(%rip), %r8
> +	cmpq %r8, ftrace_trace_function(%rip)
> +	popq %r8
> +#else
>  	cmpq $ftrace_stub, ftrace_trace_function
> +#endif
>  	jnz trace
>  	RET
>  
> @@ -329,7 +336,7 @@ trace:
>  	 * ip and parent ip are used and the list function is called when
>  	 * function tracing is enabled.
>  	 */
> -	movq ftrace_trace_function, %r8
> +	movq ftrace_trace_function(%rip), %r8
>  	CALL_NOSPEC r8
>  	restore_mcount_regs
>  

I really don't want to add more updates to !DYNAMIC_FTRACE. This code only
exists to make sure I don't break it for other architectures.

How about

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 442eccc00960..ee4d0713139d 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -37,7 +37,7 @@ config X86_64
 
 config FORCE_DYNAMIC_FTRACE
 	def_bool y
-	depends on X86_32
+	depends on X86_32 || X86_PIE
 	depends on FUNCTION_TRACER
 	select DYNAMIC_FTRACE
 	help


?

-- Steve
