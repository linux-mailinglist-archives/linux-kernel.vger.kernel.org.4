Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78BBE625F26
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 17:09:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233702AbiKKQJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 11:09:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbiKKQJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 11:09:40 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8A36659FE2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 08:09:39 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F5101FB;
        Fri, 11 Nov 2022 08:09:45 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.25.147])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 07DEF3F73D;
        Fri, 11 Nov 2022 08:09:37 -0800 (PST)
Date:   Fri, 11 Nov 2022 16:09:19 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: ftrace: Define ftrace_stub_graph only with
 FUNCTION_GRAPH_TRACER
Message-ID: <Y25zr1ni/wAkUQwr@FVFF77S0Q05N.cambridge.arm.com>
References: <20221109192831.3057131-1-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109192831.3057131-1-samitolvanen@google.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 07:28:31PM +0000, Sami Tolvanen wrote:
> The 0-day bot reports that arm64 builds with CONFIG_CFI_CLANG +
> CONFIG_FTRACE are broken when CONFIG_FUNCTION_GRAPH_TRACER is not
> enabled:
> 
>  ld.lld: error: undefined symbol: __kcfi_typeid_ftrace_stub_graph
>  >>> referenced by entry-ftrace.S:299 (arch/arm64/kernel/entry-ftrace.S:299)
>  >>>               arch/arm64/kernel/entry-ftrace.o:(.text+0x48) in archive vmlinux.a
> 
> This is caused by ftrace_stub_graph using SYM_TYPE_FUNC_START when
> the address of the function is not taken in any C translation unit.
> 
> Fix the build by only defining ftrace_stub_graph when it's actually
> needed, i.e. with CONFIG_FUNCTION_GRAPH_TRACER.
> 
> Link: https://lore.kernel.org/lkml/202210251659.tRMs78RH-lkp@intel.com/
> Fixes: 883bbbffa5a4 ("ftrace,kcfi: Separate ftrace_stub() and ftrace_stub_graph()")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/kernel/entry-ftrace.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/entry-ftrace.S b/arch/arm64/kernel/entry-ftrace.S
> index 795344ab4ec4..322a831f8ede 100644
> --- a/arch/arm64/kernel/entry-ftrace.S
> +++ b/arch/arm64/kernel/entry-ftrace.S
> @@ -299,11 +299,11 @@ SYM_TYPED_FUNC_START(ftrace_stub)
>  	ret
>  SYM_FUNC_END(ftrace_stub)
>  
> +#ifdef CONFIG_FUNCTION_GRAPH_TRACER
>  SYM_TYPED_FUNC_START(ftrace_stub_graph)
>  	ret
>  SYM_FUNC_END(ftrace_stub_graph)
>  
> -#ifdef CONFIG_FUNCTION_GRAPH_TRACER
>  /*
>   * void return_to_handler(void)
>   *
> 
> base-commit: f141df371335645ce29a87d9683a3f79fba7fd67
> -- 
> 2.38.1.431.g37b22c650d-goog
> 
