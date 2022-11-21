Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81CC632FC1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 23:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiKUWYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 17:24:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiKUWYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 17:24:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5286D178B5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 14:24:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 10FFFB816A9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 22:24:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87080C433D6;
        Mon, 21 Nov 2022 22:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669069448;
        bh=V+gaLKpyshaCkbv1WhQWvfEVZjKqakHxzq1GlH1qVKI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=booFdlr32KkvLpCHhKj1eo6PFCq1cwg7Bwslv1c3q3yp9l0IJOf1XfeTvFf8zOaJP
         TOdA88om8Rm54iM3FrsXyg3rCVakZYWMnp0+knpxs89deCZVk1mmJrPGH+nBCW4r91
         VnGxsuDY9xLqLvh9N1Rqh64y4fNe0gUoQ0PGcBqAZWYGt3Iq6iMVqebtcAvrGxDT1v
         lGd7jCwOsl0JZpWRlHGEttA1PF0FaKWeN7fTlMFs/SPEAwgatTw9MasObk30YGVRUk
         vDbSMP3jZZjjR7KVkLfxrTU13JdTG5L08Qb/S/CUYXTS9Ow809evaUrKArg8Ez3X7r
         86Qy0W/yTd1EQ==
Date:   Tue, 22 Nov 2022 07:24:04 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        KP Singh <kpsingh@kernel.org>, Chris Mason <clm@meta.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Florent Revest <revest@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] error-injection: Add prompt for function error
 injection
Message-Id: <20221122072404.c55c0c2070c6ebb5230f3813@kernel.org>
In-Reply-To: <20221121104403.1545f9b5@gandalf.local.home>
References: <20221121104403.1545f9b5@gandalf.local.home>
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

On Mon, 21 Nov 2022 10:44:03 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> The config to be able to inject error codes into any function annotated
> with ALLOW_ERROR_INJECTION() is enabled when CONFIG_FUNCTION_ERROR_INJECTION
> is enabled. But unfortunately, this is always enabled on x86 when KPROBES
> is enabled, and there's no way to turn it off.
> 
> As kprobes is useful for observability of the kernel, it is useful to have
> it enabled in production environments. But error injection should be
> avoided. Add a prompt to the config to allow it to be disabled even when
> kprobes is enabled, and get rid of the "def_bool y".
> 
> This is a kernel debug feature (it's in Kconfig.debug), and should have
> never been something enabled by default.
> 

Oops, thanks for update. Yes, it should not be enabled in the production system.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> Cc: stable@vger.kernel.org
> Fixes: 540adea3809f6 ("error-injection: Separate error-injection from kprobe")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  lib/Kconfig.debug | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index c3c0b077ade3..9ee72d8860c3 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1874,8 +1874,14 @@ config NETDEV_NOTIFIER_ERROR_INJECT
>  	  If unsure, say N.
>  
>  config FUNCTION_ERROR_INJECTION
> -	def_bool y
> +	bool "Fault-injections of functions"
>  	depends on HAVE_FUNCTION_ERROR_INJECTION && KPROBES
> +	help
> +	  Add fault injections into various functions that are annotated with
> +	  ALLOW_ERROR_INJECTION() in the kernel. BPF may also modify the return
> +	  value of theses functions. This is useful to test error paths of code.
> +
> +	  If unsure, say N
>  
>  config FAULT_INJECTION
>  	bool "Fault-injection framework"
> -- 
> 2.35.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
