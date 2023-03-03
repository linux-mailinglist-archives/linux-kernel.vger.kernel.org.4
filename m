Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657FB6A9AED
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 16:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbjCCPom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 10:44:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbjCCPok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 10:44:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B92C13510;
        Fri,  3 Mar 2023 07:44:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B5487B8184D;
        Fri,  3 Mar 2023 15:44:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1CC2C433EF;
        Fri,  3 Mar 2023 15:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677858275;
        bh=gRQSCSeKjz+p/gTKsX4VQGXBkhVqiUPtVkOI5VJ/KkU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lIyNtfuCaVQE8kuwrCtrgL/25OM7dsH3g/myItJBu0kieB3tKEJmfcai2PNI58KgE
         uOFAWRx8LWdfT0OZBrZnIJ/3HT9XR/UgrI+rrV/qd5XzX76dqM+IT2z8eKqPEJHfuJ
         a3fSPOCunRXlaN5RpoED8+AGoaeh6w5hxMQr14Xw4tjr/V2kAbdrl7+Zmw+SzoNsfG
         /ZyKcO6Dr7tOZSzFxGNxk1+SThemVcLETPWT1s+HBD9F80GINXwkr3ZFDn5A5VTJx/
         IAh6bZD1jAulM2nmZjo71oeYBuRHzhnBqJIi6FYSnCn5R6cRN3y93i/uC4aQxWsAHf
         hV/ngW6ZnsIJg==
Date:   Fri, 3 Mar 2023 08:44:33 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Marco Elver <elver@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ubsan: Tighten UBSAN_BOUNDS on GCC
Message-ID: <20230303154433.GA3775@dev-arch.thelio-3990X>
References: <20230302225444.never.053-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302225444.never.053-kees@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2023 at 02:54:45PM -0800, Kees Cook wrote:
> The use of -fsanitize=bounds on GCC will ignore some trailing arrays,
> leaving a gap in coverage. Switch to using -fsanitize=bounds-strict to
> match Clang's stricter behavior.
> 
> Cc: Marco Elver <elver@google.com>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Nicolas Schier <nicolas@fjasle.eu>
> Cc: Tom Rix <trix@redhat.com>
> Cc: Josh Poimboeuf <jpoimboe@kernel.org>
> Cc: Miroslav Benes <mbenes@suse.cz>
> Cc: linux-kbuild@vger.kernel.org
> Cc: llvm@lists.linux.dev
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  lib/Kconfig.ubsan      | 54 +++++++++++++++++++++++-------------------
>  scripts/Makefile.ubsan |  2 +-
>  2 files changed, 30 insertions(+), 26 deletions(-)
> 
> diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
> index fd15230a703b..9d3e87a0b6d1 100644
> --- a/lib/Kconfig.ubsan
> +++ b/lib/Kconfig.ubsan
> @@ -27,16 +27,27 @@ config UBSAN_TRAP
>  	  the system. For some system builders this is an acceptable
>  	  trade-off.
>  
> -config CC_HAS_UBSAN_BOUNDS
> -	def_bool $(cc-option,-fsanitize=bounds)
> +config CC_HAS_UBSAN_BOUNDS_STRICT
> +	def_bool $(cc-option,-fsanitize=bounds-strict)
> +	help
> +	  The -fsanitize=bounds-strict option is only available on GCC,
> +	  but uses the more strict handling of arrays that includes knowledge
> +	  of flexible arrays, which is comparable to Clang's regular
> +	  -fsanitize=bounds.
>  
>  config CC_HAS_UBSAN_ARRAY_BOUNDS
>  	def_bool $(cc-option,-fsanitize=array-bounds)
> +	help
> +	  The -fsanitize=array-bounds option is only available on Clang,
> +	  and is actually composed of two more specific options,
> +	  -fsanitize=array-bounds and -fsanitize=local-bounds. However,
> +	  -fsanitize=local-bounds can only be used when trap mode is
> +	  enabled. (See also the help for CONFIG_LOCAL_BOUNDS.)

The first sentence does not read right to me, you have array-bounds
twice. I think the first one wants to be just bounds?

>  config UBSAN_BOUNDS
>  	bool "Perform array index bounds checking"
>  	default UBSAN
> -	depends on CC_HAS_UBSAN_ARRAY_BOUNDS || CC_HAS_UBSAN_BOUNDS
> +	depends on CC_HAS_UBSAN_ARRAY_BOUNDS || CC_HAS_UBSAN_BOUNDS_STRICT
>  	help
>  	  This option enables detection of directly indexed out of bounds
>  	  array accesses, where the array size is known at compile time.
> @@ -44,33 +55,26 @@ config UBSAN_BOUNDS
>  	  to the {str,mem}*cpy() family of functions (that is addressed
>  	  by CONFIG_FORTIFY_SOURCE).
>  
> -config UBSAN_ONLY_BOUNDS
> -	def_bool CC_HAS_UBSAN_BOUNDS && !CC_HAS_UBSAN_ARRAY_BOUNDS
> -	depends on UBSAN_BOUNDS
> +config UBSAN_BOUNDS_STRICT
> +	def_bool UBSAN_BOUNDS && CC_HAS_UBSAN_BOUNDS_STRICT
>  	help
> -	  This is a weird case: Clang's -fsanitize=bounds includes
> -	  -fsanitize=local-bounds, but it's trapping-only, so for
> -	  Clang, we must use -fsanitize=array-bounds when we want
> -	  traditional array bounds checking enabled. For GCC, we
> -	  want -fsanitize=bounds.
> +	  GCC's bounds sanitizer. This option is used to select the
> +	  correct options in Makefile.ubsan.
>  
>  config UBSAN_ARRAY_BOUNDS
> -	def_bool CC_HAS_UBSAN_ARRAY_BOUNDS
> -	depends on UBSAN_BOUNDS
> +	def_bool UBSAN_BOUNDS && CC_HAS_UBSAN_ARRAY_BOUNDS
> +	help
> +	  Clang's array bounds sanitizer. This option is used to select
> +	  the correct options in Makefile.ubsan.
>  
>  config UBSAN_LOCAL_BOUNDS
> -	bool "Perform array local bounds checking"
> -	depends on UBSAN_TRAP
> -	depends on $(cc-option,-fsanitize=local-bounds)
> -	help
> -	  This option enables -fsanitize=local-bounds which traps when an
> -	  exception/error is detected. Therefore, it may only be enabled
> -	  with CONFIG_UBSAN_TRAP.
> -
> -	  Enabling this option detects errors due to accesses through a
> -	  pointer that is derived from an object of a statically-known size,
> -	  where an added offset (which may not be known statically) is
> -	  out-of-bounds.
> +	def_bool UBSAN_ARRAY_BOUNDS && UBSAN_TRAP
> +	help
> +	  This option enables Clang's -fsanitize=local-bounds which traps
> +	  when an access through a pointer that is derived from an object
> +	  of a statically-known size, where an added offset (which may not
> +	  be known statically) is out-of-bounds. Since this option is
> +	  trap-only, it depends on CONFIG_UBSAN_TRAP.
>  
>  config UBSAN_SHIFT
>  	bool "Perform checking for bit-shift overflows"
> diff --git a/scripts/Makefile.ubsan b/scripts/Makefile.ubsan
> index 7099c603ff0a..4749865c1b2c 100644
> --- a/scripts/Makefile.ubsan
> +++ b/scripts/Makefile.ubsan
> @@ -2,7 +2,7 @@
>  
>  # Enable available and selected UBSAN features.
>  ubsan-cflags-$(CONFIG_UBSAN_ALIGNMENT)		+= -fsanitize=alignment
> -ubsan-cflags-$(CONFIG_UBSAN_ONLY_BOUNDS)	+= -fsanitize=bounds
> +ubsan-cflags-$(CONFIG_UBSAN_BOUNDS_STRICT)	+= -fsanitize=bounds-strict
>  ubsan-cflags-$(CONFIG_UBSAN_ARRAY_BOUNDS)	+= -fsanitize=array-bounds
>  ubsan-cflags-$(CONFIG_UBSAN_LOCAL_BOUNDS)	+= -fsanitize=local-bounds
>  ubsan-cflags-$(CONFIG_UBSAN_SHIFT)		+= -fsanitize=shift
> -- 
> 2.34.1
> 
