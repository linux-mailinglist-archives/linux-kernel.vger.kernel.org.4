Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 041ED72C696
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 15:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236502AbjFLNzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 09:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237392AbjFLNzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 09:55:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170FD1730;
        Mon, 12 Jun 2023 06:54:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 040B2615F6;
        Mon, 12 Jun 2023 13:54:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A024C433D2;
        Mon, 12 Jun 2023 13:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686578076;
        bh=UnO5F2AUHeEwb6H7h3Ylb54nZuSur/fxclUCXZ8wjQo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sKO+IHXMWBadTMedjIs4aEUTvey7/wws4t+HZFQXJJTaVEHTkRfMqcO5uIwle15KF
         UumbyyuoydFgXac9oOUHPmli691YgGPg1pK7AIWrkQa4oT3LCFlwj2gvhoVVqM86wW
         HZvu3CaG9XznPRsrw3MaNH7pEEvDOx1UrylTVfXvmIlPCpEHpXBetLcymQ0NvD/iEs
         lvi8XpLTLyM5C3VLF/ueSEMvZuTXYphZjT6dvdjubb3OkhPwFiw5ELJ1fbgjeASpzF
         /NTcQ4R8T4XkO+rof5E1NdMG8Bb/s+QjrJ0tyBYvZpMhoUi6Esx+/wK6IM/sZcz9wY
         t/MBXgG8zW9rQ==
Date:   Mon, 12 Jun 2023 22:54:32 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ingo Molnar <mingo@kernel.org>, Song Liu <song@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Subject: Re: [PATCH v2] ftrace: Allow inline functions not inlined to be
 traced
Message-Id: <20230612225432.1e89e8f50dafff9858ad3b3f@kernel.org>
In-Reply-To: <20230609174422.04824a9e@gandalf.local.home>
References: <20230609174422.04824a9e@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Jun 2023 17:44:22 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> Over 10 years ago there were many bugs that caused function tracing to
> crash because some inlined function was not inlined and should not have
> been traced. This made it hard to debug because when the developer tried
> to reproduce it, if their compiler still inlined the function, the bug
> would not trigger. The solution back then was simply to add "notrace" to
> "inline" which would make sure all functions that are marked inline are
> never traced even when the compiler decides to not inline them.
> 
> A lot has changed over the last 10 years.
> 
> 1) ftrace_test_recursion_trylock() is now used by all ftrace hooks which
>    will prevent the recursive crashes from happening that was caused by
>    inlined functions being traced.
> 
> 2) noinstr is now used to mark pretty much all functions that would also
>    cause problems if they are traced.
> 
> Today, it is no longer a problem if an inlined function is not inlined and
> is traced, at least on x86. Removing notrace from inline has been requested
> several times over the years. I believe it is now safe to do so.
> 
> Currently only x86 uses this.
> 
> Acked-by: Song Liu <song@kernel.org>
> Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> Changes since v1: https://lore.kernel.org/linux-trace-kernel/20230502164102.1a51cdb4@gandalf.local.home
> 
>  - have it opted in by architecture. Currently only x86 adds it. (Mark Rutland)
> 
>  arch/x86/Kconfig               |  1 +
>  include/linux/compiler_types.h | 16 +++++++++++++---
>  kernel/trace/Kconfig           |  7 +++++++
>  3 files changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index da5c081d64a5..1ddebf832534 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -61,6 +61,7 @@ config X86
>  	select ACPI_LEGACY_TABLES_LOOKUP	if ACPI
>  	select ACPI_SYSTEM_POWER_STATES_SUPPORT	if ACPI
>  	select ARCH_32BIT_OFF_T			if X86_32
> +	select ARCH_CAN_TRACE_INLINE
>  	select ARCH_CLOCKSOURCE_INIT
>  	select ARCH_CORRECT_STACKTRACE_ON_KRETPROBE
>  	select ARCH_ENABLE_HUGEPAGE_MIGRATION if X86_64 && HUGETLB_PAGE && MIGRATION
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index 547ea1ff806e..f827e2a98500 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -169,6 +169,16 @@ struct ftrace_likely_data {
>  #define notrace			__attribute__((__no_instrument_function__))
>  #endif
>  
> +/*
> + * If all inline code not marked as __always_inline is safe to trace,
> + * then allow the architecture to do so.
> + */
> +#ifdef CONFIG_ARCH_CAN_TRACE_INLINE
> +#define __notrace_inline
> +#else
> +#define __notrace_inline	notrace
> +#endif

I think I understand what the purpose of this patch. But I'm confusing the
above change, it looks like a literal contradiction :)
I mean, __notrace_inline functions shouldn't be notrace?

What about call it __may_notrace_inline or __maybe_notrace?

Others looks good to me.

Thank you,

> +
>  /*
>   * it doesn't make sense on ARM (currently the only user of __naked)
>   * to trace naked functions because then mcount is called without
> @@ -184,7 +194,7 @@ struct ftrace_likely_data {
>   * of extern inline functions at link time.
>   * A lot of inline functions can cause havoc with function tracing.
>   */
> -#define inline inline __gnu_inline __inline_maybe_unused notrace
> +#define inline inline __gnu_inline __inline_maybe_unused __notrace_inline
>  
>  /*
>   * gcc provides both __inline__ and __inline as alternate spellings of
> @@ -230,7 +240,7 @@ struct ftrace_likely_data {
>   *     https://gcc.gnu.org/bugzilla/show_bug.cgi?id=67368
>   * '__maybe_unused' allows us to avoid defined-but-not-used warnings.
>   */
> -# define __no_kasan_or_inline __no_sanitize_address notrace __maybe_unused
> +# define __no_kasan_or_inline __no_sanitize_address __notrace_inline __maybe_unused
>  # define __no_sanitize_or_inline __no_kasan_or_inline
>  #else
>  # define __no_kasan_or_inline __always_inline
> @@ -247,7 +257,7 @@ struct ftrace_likely_data {
>   * disable all instrumentation. See Kconfig.kcsan where this is mandatory.
>   */
>  # define __no_kcsan __no_sanitize_thread __disable_sanitizer_instrumentation
> -# define __no_sanitize_or_inline __no_kcsan notrace __maybe_unused
> +# define __no_sanitize_or_inline __no_kcsan __notrace_inline __maybe_unused
>  #else
>  # define __no_kcsan
>  #endif
> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index abe5c583bd59..b66ab0e6ce19 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -106,6 +106,13 @@ config HAVE_BUILDTIME_MCOUNT_SORT
>           An architecture selects this if it sorts the mcount_loc section
>  	 at build time.
>  
> +config ARCH_CAN_TRACE_INLINE
> +       bool
> +       help
> +         It is safe for an architecture to trace any function marked
> +	 as inline (not __always_inline) that the compiler decides to
> +	 not inline.
> +
>  config BUILDTIME_MCOUNT_SORT
>         bool
>         default y
> -- 
> 2.39.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
