Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F21625B2A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 14:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233756AbiKKN3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 08:29:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbiKKN3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 08:29:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9241117420
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 05:29:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1848D61FCC
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 13:29:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D4AFC433D6;
        Fri, 11 Nov 2022 13:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668173344;
        bh=fJkVku6UihzNOl7Dkq+EJ1F1NQcd6o7T8PJpq+a6u5g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sKDywg44dWfWS34cuxFh2R+d8reKj6AAmR+3qlaY6swdV51HNKHp+6M9vHfazxesc
         VXWaNscBPQrXju75qN7wfO36mSmKfTYyfakG67pbF5XPiHRJ9luWIXKAiqdRTJ8dBv
         isWNKb+00FIIvfGZGUjNfDBrN1oD1CPNPWrovOfXpx1JcwJXc70jZyc/rceRSUmsvO
         hUG+6+VIy/fM8Jq9qvjtK5AhvMVJQi/8XIHJo6o2EYoAX4ClqChrkok2J7aif9RxVf
         TYjoD+UXI/JnK6xIy3+dUDNWE0APcH0FM00vLxDVcvfcIf+RqZt7HftsVKx4iUygc4
         cQYtGy3GWN0fg==
Date:   Fri, 11 Nov 2022 22:29:00 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: ftrace: Define ftrace_stub_graph only with
 FUNCTION_GRAPH_TRACER
Message-Id: <20221111222900.0e4a1d4768730b9784249c86@kernel.org>
In-Reply-To: <20221109192831.3057131-1-samitolvanen@google.com>
References: <20221109192831.3057131-1-samitolvanen@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  9 Nov 2022 19:28:31 +0000
Sami Tolvanen <samitolvanen@google.com> wrote:

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

This looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

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


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
