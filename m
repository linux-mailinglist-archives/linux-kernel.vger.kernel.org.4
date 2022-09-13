Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3EB5B6ED4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 16:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbiIMOF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 10:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232398AbiIMOFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 10:05:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2DA1C11A;
        Tue, 13 Sep 2022 07:05:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE363614A5;
        Tue, 13 Sep 2022 14:05:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A243C433D6;
        Tue, 13 Sep 2022 14:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663077919;
        bh=l+g8X+5c9ZV49QCN0e48clP+/b2LReYleUFUA2MJqk4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u5DQ5p36wAYtlKQPGvG+TFdcomyrLnxf2LurnnNlzmhAS/z9t/qcvL+BFugsDrKb1
         vZOKNEElLVvbp3okXuzouJ+cPuCfjYG22bMD49PrXPN04MJpsYyIO2GFMakNQU3IR9
         tU7J+Mcu49eZvyRbbLGH1KUjXopp6d5jR/2SAaLrnYrx8Le5TEhHDYUu9CNe0lOjMw
         k+doJa/ziXNaGoHJxX0VO/ofzdNEhwCJSP4CZ7RPiLX7Lvk4lByhpe6zN36w9LtbqW
         02ilV0Z6cXdkZBo+v4RSA/bGtaxsOelTNYD8IuJQzjEw46ORoJtGjXRSN166/nrrn0
         unoFDCbwbPWCg==
Date:   Tue, 13 Sep 2022 07:05:16 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        David Gow <davidgow@google.com>,
        Yury Norov <yury.norov@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Sander Vanheule <sander@svanheule.net>,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Isabella Basso <isabbasso@riseup.net>,
        Eric Dumazet <edumazet@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Eric Biggers <ebiggers@google.com>,
        Hannes Reinecke <hare@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] fortify: Add KUnit test for FORTIFY_SOURCE
 internals
Message-ID: <YyCOHOchVuE/E7vS@dev-arch.thelio-3990X>
References: <20220902204351.2521805-1-keescook@chromium.org>
 <20220902204351.2521805-3-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220902204351.2521805-3-keescook@chromium.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

On Fri, Sep 02, 2022 at 01:43:50PM -0700, Kees Cook wrote:
> Add lib/fortify_kunit.c KUnit test for checking the expected behavioral
> characteristics of FORTIFY_SOURCE internals.
> 
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Tom Rix <trix@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> Cc: David Gow <davidgow@google.com>
> Cc: Yury Norov <yury.norov@gmail.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Sander Vanheule <sander@svanheule.net>
> Cc: linux-hardening@vger.kernel.org
> Cc: llvm@lists.linux.dev
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  MAINTAINERS         |  1 +
>  lib/Kconfig.debug   |  9 ++++++
>  lib/Makefile        |  1 +
>  lib/fortify_kunit.c | 77 +++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 88 insertions(+)
>  create mode 100644 lib/fortify_kunit.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9d7f64dc0efe..640115472199 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8002,6 +8002,7 @@ L:	linux-hardening@vger.kernel.org
>  S:	Supported
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/hardening
>  F:	include/linux/fortify-string.h
> +F:	lib/fortify_kunit.c
>  F:	lib/test_fortify/*
>  F:	scripts/test_fortify.sh
>  K:	\b__NO_FORTIFY\b
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 36455953d306..1f267c0ddffd 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2542,6 +2542,15 @@ config STACKINIT_KUNIT_TEST
>  	  CONFIG_GCC_PLUGIN_STRUCTLEAK, CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF,
>  	  or CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL.
>  
> +config FORTIFY_KUNIT_TEST
> +	tristate "Test fortified str*() and mem*() function internals at runtime" if !KUNIT_ALL_TESTS
> +	depends on KUNIT && FORTIFY_SOURCE
> +	default KUNIT_ALL_TESTS
> +	help
> +	  Builds unit tests for checking internals of FORTIFY_SOURCE as used
> +	  by the str*() and mem*() family of functions. For testing runtime
> +	  traps of FORTIFY_SOURCE, see LKDTM's "FORTIFY_*" tests.
> +
>  config TEST_UDELAY
>  	tristate "udelay test driver"
>  	help
> diff --git a/lib/Makefile b/lib/Makefile
> index f545140ed9e7..4ee1ceae945a 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -381,6 +381,7 @@ obj-$(CONFIG_IS_SIGNED_TYPE_KUNIT_TEST) += is_signed_type_kunit.o
>  obj-$(CONFIG_OVERFLOW_KUNIT_TEST) += overflow_kunit.o
>  CFLAGS_stackinit_kunit.o += $(call cc-disable-warning, switch-unreachable)
>  obj-$(CONFIG_STACKINIT_KUNIT_TEST) += stackinit_kunit.o
> +obj-$(CONFIG_FORTIFY_KUNIT_TEST) += fortify_kunit.o
>  
>  obj-$(CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED) += devmem_is_allowed.o
>  
> diff --git a/lib/fortify_kunit.c b/lib/fortify_kunit.c
> new file mode 100644
> index 000000000000..4d7930b65107
> --- /dev/null
> +++ b/lib/fortify_kunit.c
> @@ -0,0 +1,77 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Runtime test cases for CONFIG_FORTIFY_SOURCE that aren't expected to
> + * Oops th kernel on success. (For those, see drivers/misc/lkdtm/fortify.c)
> + *
> + * For corner cases with UBSAN, try testing with:
> + *
> + * ./tools/testing/kunit/kunit.py run --arch=x86_64 \
> + *	--kconfig_add CONFIG_FORTIFY_SOURCE=y \
> + *	--kconfig_add CONFIG_UBSAN=y \
> + *	--kconfig_add CONFIG_UBSAN_TRAP=y \
> + *	--kconfig_add CONFIG_UBSAN_BOUNDS=y \
> + *	--kconfig_add CONFIG_UBSAN_LOCAL_BOUNDS=y \
> + *	--make_options LLVM=1 fortify
> + */
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <kunit/test.h>
> +#include <linux/string.h>
> +#include <linux/init.h>
> +
> +static const char array_of_10[] = "this is 10";
> +static const char *ptr_of_11 = "this is 11!";
> +static char array_unknown[] = "compiler thinks I might change";
> +
> +static void known_sizes_test(struct kunit *test)
> +{
> +	KUNIT_EXPECT_EQ(test, __compiletime_strlen("88888888"), 8);
> +	KUNIT_EXPECT_EQ(test, __compiletime_strlen(array_of_10), 10);
> +	KUNIT_EXPECT_EQ(test, __compiletime_strlen(ptr_of_11), 11);
> +
> +	KUNIT_EXPECT_EQ(test, __compiletime_strlen(array_unknown), SIZE_MAX);
> +	/* Externally defined and dynamically sized string pointer: */
> +	KUNIT_EXPECT_EQ(test, __compiletime_strlen(saved_command_line), SIZE_MAX);
> +}

I noticed that my allmodconfig + ThinLTO builds broke with this change:

  $ make -skj"$(nproc)" ARCH=arm64 KCONFIG_ALLCONFIG=<(printf "CONFIG_%s=n\nCONFIG_%s=n\nCONFIG_%s=y\nCONFIG_%s=n\n" GCOV_KERNEL KASAN LTO_CLANG_THIN WERROR) LLVM=1 mrproper allmodconfig all
  ...
  ERROR: modpost: "saved_command_line" [lib/fortify_kunit.ko] undefined!
  ...

saved_command_line is not exported to modules. This appears to be
related to the fact that CONFIG_KCSAN gets enabled due to the way
KCONFIG_ALLCONFIG works, as the issue does not show up in our CI, which
uses merge_config.sh.

A smaller reproducer on top of defconfig:

  $ make -skj"$(nproc)" ARCH=arm64 LLVM=1 defconfig

  $ scripts/config \
  -d LTO_NONE \
  -e EXPERT \
  -e FORTIFY_SOURCE \
  -e KCSAN \
  -e LTO_CLANG_THIN \
  -m FORTIFY_KUNIT_TEST \
  -m KUNIT

  $ make -skj"$(nproc)" ARCH=arm64 LLVM=1 olddefconfig all
  ...
  ERROR: modpost: "saved_command_line" [lib/fortify_kunit.ko] undefined!
  ...

I don't see this without LTO. Is this a compiler problem?

Small note, Marco's patch is needed to avoid a separate linking error
with ToT LLVM:

https://lore.kernel.org/20220912094541.929856-1-elver@google.com/

Cheers,
Nathan
