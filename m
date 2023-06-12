Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4050A72C960
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 17:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239315AbjFLPJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 11:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238463AbjFLPJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 11:09:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B3C8F;
        Mon, 12 Jun 2023 08:09:34 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686582572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aXQIH8oNCmgfEv4lgu8d01Kz+SNn/6yEMUmZ6FI8ajg=;
        b=qFtkG4kEpETNMmN0zUn0MTf2XyKCcoOjttv8AkKnRmTSDEtZH94TkR7MMmTqpbszfQLyqv
        HuBZotDzPpDV2Zwg3HCwLTizT5ViESA9ENeKlg14BnOpCXQQNOxoDRZ7TAc4lXEdoCL8L/
        TPS8Nz+LQNxT6FgycXQARmwfJZGWu7suzuNYM6OaTUwXFhjqMaKMZF2VyuXP9RknsEMdtO
        NbO5/6bLVSDkpN5tv0lelEKlQY+lNsreUdJSgZEOR6SWpucpn1o8pOsc2NSilz+qn/8ul6
        3yWHKcpHWMEbLM84HlIzE+VUtZaDbvxLZ7R7Qs+WQjd8XlQk6sKiMfQyt6E0WQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686582572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aXQIH8oNCmgfEv4lgu8d01Kz+SNn/6yEMUmZ6FI8ajg=;
        b=JltDw6Wqffv5XMWWPyKKrpW1vaVy25YN5FolP/jU7dAkBVry5zO5oYFT688E/y0v2zW5tD
        tNp4x9hWiBlKqMBw==
To:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ingo Molnar <mingo@kernel.org>, Song Liu <song@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Subject: Re: [PATCH v2] ftrace: Allow inline functions not inlined to be traced
In-Reply-To: <20230609174422.04824a9e@gandalf.local.home>
References: <20230609174422.04824a9e@gandalf.local.home>
Date:   Mon, 12 Jun 2023 17:09:31 +0200
Message-ID: <87lego7m50.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09 2023 at 17:44, Steven Rostedt wrote:
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

I assume this passes the objtool noinstr validation. If so, if would be
helpful to document that.
>  /*
>   * gcc provides both __inline__ and __inline as alternate spellings of
> @@ -230,7 +240,7 @@ struct ftrace_likely_data {
>   *     https://gcc.gnu.org/bugzilla/show_bug.cgi?id=67368
>   * '__maybe_unused' allows us to avoid defined-but-not-used warnings.
>   */
> -# define __no_kasan_or_inline __no_sanitize_address notrace __maybe_unused
> +# define __no_kasan_or_inline __no_sanitize_address __notrace_inline __maybe_unused

I'm not convinced that this is correct

>  # define __no_sanitize_or_inline __no_kasan_or_inline
>  #else

given that the !__SANITIZE_ADDRESS__ variant is:

>  # define __no_kasan_or_inline __always_inline

which cannot be traced.

> @@ -247,7 +257,7 @@ struct ftrace_likely_data {
>   * disable all instrumentation. See Kconfig.kcsan where this is mandatory.
>   */
>  # define __no_kcsan __no_sanitize_thread __disable_sanitizer_instrumentation
> -# define __no_sanitize_or_inline __no_kcsan notrace __maybe_unused
> +# define __no_sanitize_or_inline __no_kcsan __notrace_inline  __maybe_unused

Ditto. 

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

Spaces instead of tab.

> +	 as inline (not __always_inline) that the compiler decides to

and this one has a tab.

> +	 not inline.
> +
>  config BUILDTIME_MCOUNT_SORT
>         bool
>         default y
