Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 016C464115F
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 00:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234705AbiLBXRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 18:17:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233931AbiLBXRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 18:17:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75992F7A17
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 15:17:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EB8F1B8226A
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 23:17:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8456CC433D6;
        Fri,  2 Dec 2022 23:17:26 +0000 (UTC)
Date:   Fri, 2 Dec 2022 18:17:24 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chris Mason <clm@meta.com>, Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        KP Singh <kpsingh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florent Revest <revest@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] error-injection: Add prompt for function error
 injection
Message-ID: <20221202181724.4ec93cf0@gandalf.local.home>
In-Reply-To: <20221202212711.5ot66apmazm4yz6y@macbook-pro-6.dhcp.thefacebook.com>
References: <CAADnVQLJFnu6gARdZ7ckgxeGaSv70jHBiQo+W=zDKO0-ELFGcQ@mail.gmail.com>
        <Y3ymzAYRyH5IWEe/@zn.tnic>
        <3fa8ec60-dd96-c41f-ea46-8856bf855949@meta.com>
        <20221122132905.12a8d5ad@gandalf.local.home>
        <a53e8c6d-b0e5-72bf-1aba-07609c9cf1bf@meta.com>
        <20221130143719.07e36277d1471b83e9a1b627@linux-foundation.org>
        <CAADnVQ+KLXPhowdBZq0PvGOq5tv4ovNtNCvGBXHQBkVbz4UVkg@mail.gmail.com>
        <CAHk-=wjeq1m=9mU17WzfRQ1W6N0SgKHY-e2J35SpppWwUUBFbQ@mail.gmail.com>
        <20221202014129.n5lmvzsy436ebo4b@macbook-pro-6.dhcp.thefacebook.com>
        <Y4ogRH7zWLpmVXzJ@mit.edu>
        <20221202212711.5ot66apmazm4yz6y@macbook-pro-6.dhcp.thefacebook.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Dec 2022 13:27:11 -0800
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1874,8 +1874,12 @@ config NETDEV_NOTIFIER_ERROR_INJECT
>  	  If unsure, say N.
>  
>  config FUNCTION_ERROR_INJECTION

Why not just call this "ERROR_INJECTION" having this be FUNCTION and the
one for functions be FUNC is confusing.

> +        bool
> +
> +config FUNC_ERROR_INJECTION
>  	bool "Fault-injections of functions"
>  	depends on HAVE_FUNCTION_ERROR_INJECTION && KPROBES
> +	select FUNCTION_ERROR_INJECTION
>  	help
>  	  Add fault injections into various functions that are annotated with
>  	  ALLOW_ERROR_INJECTION() in the kernel. BPF may also modify the return
> @@ -1883,6 +1887,17 @@ config FUNCTION_ERROR_INJECTION
>  
>  	  If unsure, say N
>  
> +config SYSCALL_ERROR_INJECTION
> +	bool "Error injections in syscalls"
> +	depends on HAVE_FUNCTION_ERROR_INJECTION && KPROBES
> +	select FUNCTION_ERROR_INJECTION
> +	default y

IIUC, Linus prefers everything to be "default n" unless there's a really
good reason for it. Like only making other options available, but not doing
anything to the kernel. I do have DYNAMIC_FTRACE as "default y" but that's
only because it depends on CONFIG_FUNCTION_TRACER and nobody that enables
that should have DYNAMIC_FTRACE off (except for academia).

> +	help
> +	  Allows error injection framework to return errors from syscalls.
> +	  BPF may modify return values of syscalls as well.

And here's the thing. If BPF returns anything *but* an error, then this is
a misnomer and incorrect. Name it something else like "HIJACK_SYSCALLS".

> +
> +	  If unsure, say Y

And I'm curious, why Y if unsure?

-- Steve

> +
>  config FAULT_INJECTION
>  	bool "Fault-injection framework"
>  	depends on DEBUG_KERNEL
> diff --git a/lib/error-inject.c b/lib/error-inject.c
> index 1afca1b1cdea..9ba868eb8c43 100644
> --- a/lib/error-inject.c
> +++ b/lib/error-inject.c
> @@ -71,6 +71,10 @@ static void populate_error_injection_list(struct error_injection_entry *start,
>  
>  	mutex_lock(&ei_mutex);
>  	for (iter = start; iter < end; iter++) {
> +		if (iter->etype != EI_ETYPE_SYSCALL &&
> +		    !IS_ENABLED(CONFIG_FUNC_ERROR_INJECTION))
> +			continue;
> +
>  		entry = (unsigned long)dereference_symbol_descriptor((void *)iter->addr);
>  
>  		if (!kernel_text_address(entry) ||
> @@ -189,6 +193,8 @@ static const char *error_type_string(int etype)
>  		return "ERRNO_NULL";
>  	case EI_ETYPE_TRUE:
>  		return "TRUE";
> +	case EI_ETYPE_SYSCALL:
> +		return "SYSCALL";
>  	default:
>  		return "(unknown)";
>  	}

