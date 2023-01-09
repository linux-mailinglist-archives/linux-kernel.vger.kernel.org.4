Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B877F662DBC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 18:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237430AbjAIRzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 12:55:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237570AbjAIRzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 12:55:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176E37D1C2
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 09:50:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A423D612A0
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 17:50:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FA00C433EF;
        Mon,  9 Jan 2023 17:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673286637;
        bh=I+3c0LOitmufPAdIZdZX0PW1cS/iMhf84exuuDa8ZnA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jv80ikviPzb9OqyuGTL1yzzoy3dH7kOufWJp0xmuhRz7AqLYNU8BSZsBbKNFosVEG
         LEifmZ8WPXvvU9BQa3hYRfmBR+xm5w5hWZCcNN402fv/VYl+E6nad9n/cfjeKvSC00
         Pl3JgNZ2gwAo/Q59MZZsfjkDKL+0BEaqiPfw9FuJOjfH2yzhnponSXfcAVnry1ZGPs
         EeceCZOPwWfDGZn8s5RjAdQ6ftdWsQD8Taxt115HRnmG27IFZcym2KHk6S0h5YAboc
         ZAb88P//C8NUyt0KImnWbKeFUzHwvdxqKIPs4fD69Bx/qe8XekGEH26lDXCXcmuOyA
         E9+EKJNSnztdQ==
Date:   Mon, 9 Jan 2023 10:50:35 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Florent Revest <revest@chromium.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] arm64: Fix build with CC=clang, CONFIG_FTRACE=y and
 CONFIG_STACK_TRACER=y
Message-ID: <Y7xT6zNmjtOlDKQX@dev-arch.thelio-3990X>
References: <20230109122744.1904852-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230109122744.1904852-1-james.clark@arm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2023 at 12:27:43PM +0000, James Clark wrote:
> commit 45bd8951806e ("arm64: Improve HAVE_DYNAMIC_FTRACE_WITH_REGS
> selection for clang") fixed the build with the above combination by
> splitting HAVE_DYNAMIC_FTRACE_WITH_REGS into separate checks for
> Clang and GCC.
> 
> commit 26299b3f6ba2 ("ftrace: arm64: move from REGS to ARGS") added the
> GCC only check "-fpatchable-function-entry=2" back in unconditionally
> which breaks the build.
> 
> Remove the unconditional check, because the conditional ones were also
> updated to _ARGS in the above commit, so they work correctly on their
> own.
> 
> Fixes: 26299b3f6ba2 ("ftrace: arm64: move from REGS to ARGS")
> Signed-off-by: James Clark <james.clark@arm.com>

Just for posterity, since I see it was already applied:

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  arch/arm64/Kconfig | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index cf6d1cd8b6dc..c5ccca26a408 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -184,8 +184,6 @@ config ARM64
>  	select HAVE_DEBUG_KMEMLEAK
>  	select HAVE_DMA_CONTIGUOUS
>  	select HAVE_DYNAMIC_FTRACE
> -	select HAVE_DYNAMIC_FTRACE_WITH_ARGS \
> -		if $(cc-option,-fpatchable-function-entry=2)
>  	select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY \
>  		if DYNAMIC_FTRACE_WITH_ARGS
>  	select HAVE_EFFICIENT_UNALIGNED_ACCESS
> 
> base-commit: 5db568e748f6fb7d0d2e1bff4c2698ad4f50b982
> -- 
> 2.25.1
> 
