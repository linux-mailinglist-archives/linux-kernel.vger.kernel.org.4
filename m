Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3BA070768C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 01:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjEQXoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 19:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEQXoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 19:44:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E1849ED;
        Wed, 17 May 2023 16:44:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC35A63EAF;
        Wed, 17 May 2023 23:44:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1E14C433D2;
        Wed, 17 May 2023 23:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684367051;
        bh=0vx+j9sbSOwjNIuMmnkABfC9dJnsjhkc0ILcXufRB8Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fdm8yrzSGlQZA3SDrwgi6BBkkQG6j1pl+ywhXqOT+jEkcm8biQhBR3cN77/nLzwAM
         dLRyxPgJz743yxWr7WM76cbcJj9XoylVSikGiwFNEZnf+UzLLt7cjDBwVj43Q4YzGQ
         LTvzPaWUhq9Lo1U9UCmDFYC7wAa12FMGLM0AcPWCIfvhkclUI4HCPL0xL3dQ3BYhdl
         5oTO6Kk5ap+2fiDIBhc/k5SX9Vud52xjaXHX7T4qYBrusAZpOLEGTSFehqXJqCckBp
         4UUvzqAwziotGGZAf/g1Zzo50mkfwEROxnGG3PNXnmoklJLwptZlb+oCmiEVsOdlyI
         9MedMpsXOIk8A==
Date:   Wed, 17 May 2023 17:45:00 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, Tom Rix <trix@redhat.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] kbuild: Enable -fstrict-flex-arrays=3
Message-ID: <ZGVm/KbJj9Fnyx9W@work>
References: <20230517232801.never.262-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517232801.never.262-kees@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 04:28:04PM -0700, Kees Cook wrote:
> The -fstrict-flex-arrays=3 option is now available with the release
> of GCC 13[1] and Clang 16[2]. This feature instructs the compiler to
> treat only C99 flexible arrays as dynamically sized for the purposes of
> object size calculations. In other words, the ancient practice of using
> 1-element arrays, or the GNU extension of using 0-sized arrays, as a
> dynamically sized array is disabled. This allows CONFIG_UBSAN_BOUNDS,
> CONFIG_FORTIFY_SOURCE, and other object-size aware features to behave
> unambiguously in the face of trailing arrays: only C99 flexible arrays
> are considered to be dynamically sized.

It's happening! :'-)

> 
> Enabling this will help track down any outstanding cases of fake
> flexible arrays that need attention in kernel code.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/C-Dialect-Options.html#index-fstrict-flex-arrays
> [2] https://clang.llvm.org/docs/ClangCommandLineReference.html#cmdoption-clang-fstrict-flex-arrays
> 
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Nicolas Schier <nicolas@fjasle.eu>
> Cc: linux-kbuild@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
--
Gustavo

> ---
>  Makefile | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Makefile b/Makefile
> index f836936fb4d8..07e5aec1daf5 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1026,6 +1026,12 @@ KBUILD_CFLAGS += -Wno-pointer-sign
>  # globally built with -Wcast-function-type.
>  KBUILD_CFLAGS += $(call cc-option, -Wcast-function-type)
>  
> +# To gain proper coverage for CONFIG_UBSAN_BOUNDS and CONFIG_FORTIFY_SOURCE,
> +# the kernel uses only C99 flexible arrays for dynamically sized trailing
> +# arrays. Enforce this for everything that may examine structure sizes and
> +# perform bounds checking.
> +KBUILD_CFLAGS += $(call cc-option, -fstrict-flex-arrays=3)
> +
>  # disable stringop warnings in gcc 8+
>  KBUILD_CFLAGS += $(call cc-disable-warning, stringop-truncation)
>  
> -- 
> 2.34.1
> 
