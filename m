Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 420D46DB5FB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 23:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbjDGV6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 17:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjDGV62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 17:58:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F365D5FF0;
        Fri,  7 Apr 2023 14:58:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BE1F64EED;
        Fri,  7 Apr 2023 21:58:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44E93C433D2;
        Fri,  7 Apr 2023 21:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680904706;
        bh=Kky6fJPSS3fQg9xwbpyADTyHvnHtrXZw1E7q8+0lSHY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jMq+eRhYUo8b7ZIuDm9IlmLcmcMOFybDxyvm0r68LsgBtuUS1Uw0JOWscxHCTYUPt
         y7KH6nij12EhQSWjV6Y12N+3/FUQ9Ji/5whn0hfT2mNwFeFWjWQ8EiNFxkwpkhVhiI
         l8/q1XvONiu9/20W+mger9Q6C/pwwaXuMdrYJphGW5jDqKnXqnR+F4YL4sDzF5cCPW
         XymX7VnyH8+hl/f0oejtYx3Q5IMJyxPNZ8GZUKSeGLvNGEQ9EpZY1IhC9e5fOSptzQ
         SKuN+Fk29G7uLn+e6TWEbYTSRwNRxzIgiJK5z2xfkQ2+u/udwrjegWVkEnF9JABYKE
         4pNflFR1QkWgA==
Date:   Fri, 7 Apr 2023 14:58:24 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-hardening@vger.kernel.org, Tom Rix <trix@redhat.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH] ubsan: remove cc-option test for UBSAN_TRAP
Message-ID: <20230407215824.GA1524475@dev-arch.thelio-3990X>
References: <20230407215406.768464-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230407215406.768464-1-ndesaulniers@google.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2023 at 02:54:06PM -0700, Nick Desaulniers wrote:
> -fsanitize-undefined-trap-on-error has been supported since GCC 5.1 and
> Clang 3.2.  The minimum supported version of these according to
> Documentation/process/changes.rst is 5.1 and 11.0.0 respectively. Drop
> this cc-option check.
> 
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

As an aside, we should really consider having some standard format of
comment around cc-option checks so that we can easily remove them when
they become stale...

> ---
> Masahiro, Kees: get_maintainer.pl leaves much to be desired for this
> file. Can one of you please pick this up?
> 
>  lib/Kconfig.ubsan | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
> index fd15230a703b..0e7ad0782399 100644
> --- a/lib/Kconfig.ubsan
> +++ b/lib/Kconfig.ubsan
> @@ -15,7 +15,6 @@ if UBSAN
>  config UBSAN_TRAP
>  	bool "On Sanitizer warnings, abort the running kernel code"
>  	depends on !COMPILE_TEST
> -	depends on $(cc-option, -fsanitize-undefined-trap-on-error)
>  	help
>  	  Building kernels with Sanitizer features enabled tends to grow
>  	  the kernel size by around 5%, due to adding all the debugging
> -- 
> 2.40.0.577.gac1e443424-goog
> 
