Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F0F6032DC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 20:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiJRSym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 14:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiJRSyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 14:54:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9EC1A83E;
        Tue, 18 Oct 2022 11:54:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 532CAB820F6;
        Tue, 18 Oct 2022 18:54:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AFF3C433D6;
        Tue, 18 Oct 2022 18:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666119271;
        bh=v8Itd6Fz0syPe9fb8LADCktcVV+EcUlrLj8xBs6lhRI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cpGLFwnlnYKvKVhzALPqm7k/ZmHGBMRoj0YLUwmx+yTGqbFxl0pJwkFJ8AMk86ljL
         cWHpZENSnrcrFr5mrSzB5d/DHMpeq+VBb2OIO1SeRmpEEs0VnZDhvNPH1jsFa/5TT0
         /Z7OH/oaCos2/R+asp9YcFgHFuWjUr9hSuiT055mjHK/PxdNa7STZVgSzgQWHtl420
         HLnDuWTdNixqhijWCu0Z8CJ2tu0M/VAXS9yV6dDsA0WMVMmFdcnRx1MUpZk+QoKYyt
         G02dhQpVH+eKTqW1SyrwJku6saHodwD+EVp4vYXb3tanVshXnwEw1gf7SKV4wofQZz
         1zsB+vCedT7Vw==
Date:   Tue, 18 Oct 2022 11:54:28 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     David Gow <davidgow@google.com>,
        "Tobin C . Harding" <tobin@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] string: Convert strscpy() self-test to KUnit
Message-ID: <Y072ZMk/hNkfwqMv@dev-arch.thelio-3990X>
References: <20221018082824.never.845-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018082824.never.845-kees@kernel.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 01:28:59AM -0700, Kees Cook wrote:
> Convert the strscpy() self-test to a KUnit test.
> 
> Cc: David Gow <davidgow@google.com>
> Cc: Tobin C. Harding <tobin@kernel.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>

I ran the following commands and they all passed:

$ tools/testing/kunit/kunit.py run --arch arm64 --cross_compile aarch64-linux-gnu- strscpy

$ tools/testing/kunit/kunit.py run --arch arm64 --make_options LLVM=1 strscpy

$ tools/testing/kunit/kunit.py run --arch x86_64 strscpy

$ tools/testing/kunit/kunit.py run --arch x86_64 --make_options LLVM=1 strscpy

Tested-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  MAINTAINERS         |   1 +
>  lib/Kconfig.debug   |   8 ++-
>  lib/Makefile        |   2 +-
>  lib/strscpy_kunit.c | 129 +++++++++++++++++++++++++++++++++++++
>  lib/test_strscpy.c  | 150 --------------------------------------------
>  5 files changed, 136 insertions(+), 154 deletions(-)
>  create mode 100644 lib/strscpy_kunit.c
>  delete mode 100644 lib/test_strscpy.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9dd8d74c4df0..232d78340d79 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8045,6 +8045,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/har
>  F:	include/linux/fortify-string.h
>  F:	lib/fortify_kunit.c
>  F:	lib/memcpy_kunit.c
> +F:	lib/strscpy_kunit.c
>  F:	lib/test_fortify/*
>  F:	scripts/test_fortify.sh
>  K:	\b__NO_FORTIFY\b
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 3fc7abffc7aa..e0a4d52e434c 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2215,9 +2215,6 @@ config STRING_SELFTEST
>  config TEST_STRING_HELPERS
>  	tristate "Test functions located in the string_helpers module at runtime"
>  
> -config TEST_STRSCPY
> -	tristate "Test strscpy*() family of functions at runtime"
> -
>  config TEST_KSTRTOX
>  	tristate "Test kstrto*() family of functions at runtime"
>  
> @@ -2583,6 +2580,11 @@ config HW_BREAKPOINT_KUNIT_TEST
>  
>  	  If unsure, say N.
>  
> +config STRSCPY_KUNIT_TEST
> +	tristate "Test strscpy*() family of functions at runtime" if !KUNIT_ALL_TESTS
> +	depends on KUNIT
> +	default KUNIT_ALL_TESTS
> +
>  config TEST_UDELAY
>  	tristate "udelay test driver"
>  	help
> diff --git a/lib/Makefile b/lib/Makefile
> index 161d6a724ff7..1905e5c26849 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -82,7 +82,6 @@ obj-$(CONFIG_TEST_DYNAMIC_DEBUG) += test_dynamic_debug.o
>  obj-$(CONFIG_TEST_PRINTF) += test_printf.o
>  obj-$(CONFIG_TEST_SCANF) += test_scanf.o
>  obj-$(CONFIG_TEST_BITMAP) += test_bitmap.o
> -obj-$(CONFIG_TEST_STRSCPY) += test_strscpy.o
>  obj-$(CONFIG_TEST_UUID) += test_uuid.o
>  obj-$(CONFIG_TEST_XARRAY) += test_xarray.o
>  obj-$(CONFIG_TEST_PARMAN) += test_parman.o
> @@ -380,6 +379,7 @@ obj-$(CONFIG_OVERFLOW_KUNIT_TEST) += overflow_kunit.o
>  CFLAGS_stackinit_kunit.o += $(call cc-disable-warning, switch-unreachable)
>  obj-$(CONFIG_STACKINIT_KUNIT_TEST) += stackinit_kunit.o
>  obj-$(CONFIG_FORTIFY_KUNIT_TEST) += fortify_kunit.o
> +obj-$(CONFIG_STRSCPY_KUNIT_TEST) += strscpy_kunit.o
>  
>  obj-$(CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED) += devmem_is_allowed.o
>  
> diff --git a/lib/strscpy_kunit.c b/lib/strscpy_kunit.c
> new file mode 100644
> index 000000000000..98523f828d3a
> --- /dev/null
> +++ b/lib/strscpy_kunit.c
> @@ -0,0 +1,129 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Kernel module for testing 'strscpy' family of functions.
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <kunit/test.h>
> +#include <linux/string.h>
> +
> +/*
> + * tc() - Run a specific test case.
> + * @src: Source string, argument to strscpy_pad()
> + * @count: Size of destination buffer, argument to strscpy_pad()
> + * @expected: Expected return value from call to strscpy_pad()
> + * @terminator: 1 if there should be a terminating null byte 0 otherwise.
> + * @chars: Number of characters from the src string expected to be
> + *         written to the dst buffer.
> + * @pad: Number of pad characters expected (in the tail of dst buffer).
> + *       (@pad does not include the null terminator byte.)
> + *
> + * Calls strscpy_pad() and verifies the return value and state of the
> + * destination buffer after the call returns.
> + */
> +static void tc(struct kunit *test, char *src, int count, int expected,
> +	       int chars, int terminator, int pad)
> +{
> +	int nr_bytes_poison;
> +	int max_expected;
> +	int max_count;
> +	int written;
> +	char buf[6];
> +	int index, i;
> +	const char POISON = 'z';
> +
> +	KUNIT_ASSERT_TRUE_MSG(test, src != NULL,
> +			      "null source string not supported");
> +
> +	memset(buf, POISON, sizeof(buf));
> +	/* Future proofing test suite, validate args */
> +	max_count = sizeof(buf) - 2; /* Space for null and to verify overflow */
> +	max_expected = count - 1;    /* Space for the null */
> +
> +	KUNIT_ASSERT_LE_MSG(test, count, max_count,
> +		"count (%d) is too big (%d) ... aborting", count, max_count);
> +	KUNIT_EXPECT_LE_MSG(test, expected, max_expected,
> +		"expected (%d) is bigger than can possibly be returned (%d)",
> +		expected, max_expected);
> +
> +	written = strscpy_pad(buf, src, count);
> +	KUNIT_ASSERT_EQ(test, written, expected);
> +
> +	if (count && written == -E2BIG) {
> +		KUNIT_ASSERT_EQ_MSG(test, 0, strncmp(buf, src, count - 1),
> +			"buffer state invalid for -E2BIG");
> +		KUNIT_ASSERT_EQ_MSG(test, buf[count - 1], '\0',
> +			"too big string is not null terminated correctly");
> +	}
> +
> +	for (i = 0; i < chars; i++)
> +		KUNIT_ASSERT_EQ_MSG(test, buf[i], src[i],
> +			"buf[i]==%c != src[i]==%c", buf[i], src[i]);
> +
> +	if (terminator)
> +		KUNIT_ASSERT_EQ_MSG(test, buf[count - 1], '\0',
> +			"string is not null terminated correctly");
> +
> +	for (i = 0; i < pad; i++) {
> +		index = chars + terminator + i;
> +		KUNIT_ASSERT_EQ_MSG(test, buf[index], '\0',
> +			"padding missing at index: %d", i);
> +	}
> +
> +	nr_bytes_poison = sizeof(buf) - chars - terminator - pad;
> +	for (i = 0; i < nr_bytes_poison; i++) {
> +		index = sizeof(buf) - 1 - i; /* Check from the end back */
> +		KUNIT_ASSERT_EQ_MSG(test, buf[index], POISON,
> +			"poison value missing at index: %d", i);
> +	}
> +}
> +
> +static void strscpy_test(struct kunit *test)
> +{
> +	/*
> +	 * tc() uses a destination buffer of size 6 and needs at
> +	 * least 2 characters spare (one for null and one to check for
> +	 * overflow).  This means we should only call tc() with
> +	 * strings up to a maximum of 4 characters long and 'count'
> +	 * should not exceed 4.  To test with longer strings increase
> +	 * the buffer size in tc().
> +	 */
> +
> +	/* tc(test, src, count, expected, chars, terminator, pad) */
> +	tc(test, "a", 0, -E2BIG, 0, 0, 0);
> +	tc(test, "",  0, -E2BIG, 0, 0, 0);
> +
> +	tc(test, "a", 1, -E2BIG, 0, 1, 0);
> +	tc(test, "",  1, 0,	 0, 1, 0);
> +
> +	tc(test, "ab", 2, -E2BIG, 1, 1, 0);
> +	tc(test, "a",  2, 1,	  1, 1, 0);
> +	tc(test, "",   2, 0,	  0, 1, 1);
> +
> +	tc(test, "abc", 3, -E2BIG, 2, 1, 0);
> +	tc(test, "ab",  3, 2,	   2, 1, 0);
> +	tc(test, "a",   3, 1,	   1, 1, 1);
> +	tc(test, "",    3, 0,	   0, 1, 2);
> +
> +	tc(test, "abcd", 4, -E2BIG, 3, 1, 0);
> +	tc(test, "abc",  4, 3,	    3, 1, 0);
> +	tc(test, "ab",   4, 2,	    2, 1, 1);
> +	tc(test, "a",    4, 1,	    1, 1, 2);
> +	tc(test, "",     4, 0,	    0, 1, 3);
> +}
> +
> +static struct kunit_case strscpy_test_cases[] = {
> +	KUNIT_CASE(strscpy_test),
> +	{}
> +};
> +
> +static struct kunit_suite strscpy_test_suite = {
> +	.name = "strscpy",
> +	.test_cases = strscpy_test_cases,
> +};
> +
> +kunit_test_suite(strscpy_test_suite);
> +
> +MODULE_AUTHOR("Tobin C. Harding <tobin@kernel.org>");
> +MODULE_LICENSE("GPL");
> diff --git a/lib/test_strscpy.c b/lib/test_strscpy.c
> deleted file mode 100644
> index a827f94601f5..000000000000
> --- a/lib/test_strscpy.c
> +++ /dev/null
> @@ -1,150 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0+
> -
> -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> -
> -#include <linux/string.h>
> -
> -#include "../tools/testing/selftests/kselftest_module.h"
> -
> -/*
> - * Kernel module for testing 'strscpy' family of functions.
> - */
> -
> -KSTM_MODULE_GLOBALS();
> -
> -/*
> - * tc() - Run a specific test case.
> - * @src: Source string, argument to strscpy_pad()
> - * @count: Size of destination buffer, argument to strscpy_pad()
> - * @expected: Expected return value from call to strscpy_pad()
> - * @terminator: 1 if there should be a terminating null byte 0 otherwise.
> - * @chars: Number of characters from the src string expected to be
> - *         written to the dst buffer.
> - * @pad: Number of pad characters expected (in the tail of dst buffer).
> - *       (@pad does not include the null terminator byte.)
> - *
> - * Calls strscpy_pad() and verifies the return value and state of the
> - * destination buffer after the call returns.
> - */
> -static int __init tc(char *src, int count, int expected,
> -		     int chars, int terminator, int pad)
> -{
> -	int nr_bytes_poison;
> -	int max_expected;
> -	int max_count;
> -	int written;
> -	char buf[6];
> -	int index, i;
> -	const char POISON = 'z';
> -
> -	total_tests++;
> -
> -	if (!src) {
> -		pr_err("null source string not supported\n");
> -		return -1;
> -	}
> -
> -	memset(buf, POISON, sizeof(buf));
> -	/* Future proofing test suite, validate args */
> -	max_count = sizeof(buf) - 2; /* Space for null and to verify overflow */
> -	max_expected = count - 1;    /* Space for the null */
> -	if (count > max_count) {
> -		pr_err("count (%d) is too big (%d) ... aborting", count, max_count);
> -		return -1;
> -	}
> -	if (expected > max_expected) {
> -		pr_warn("expected (%d) is bigger than can possibly be returned (%d)",
> -			expected, max_expected);
> -	}
> -
> -	written = strscpy_pad(buf, src, count);
> -	if ((written) != (expected)) {
> -		pr_err("%d != %d (written, expected)\n", written, expected);
> -		goto fail;
> -	}
> -
> -	if (count && written == -E2BIG) {
> -		if (strncmp(buf, src, count - 1) != 0) {
> -			pr_err("buffer state invalid for -E2BIG\n");
> -			goto fail;
> -		}
> -		if (buf[count - 1] != '\0') {
> -			pr_err("too big string is not null terminated correctly\n");
> -			goto fail;
> -		}
> -	}
> -
> -	for (i = 0; i < chars; i++) {
> -		if (buf[i] != src[i]) {
> -			pr_err("buf[i]==%c != src[i]==%c\n", buf[i], src[i]);
> -			goto fail;
> -		}
> -	}
> -
> -	if (terminator) {
> -		if (buf[count - 1] != '\0') {
> -			pr_err("string is not null terminated correctly\n");
> -			goto fail;
> -		}
> -	}
> -
> -	for (i = 0; i < pad; i++) {
> -		index = chars + terminator + i;
> -		if (buf[index] != '\0') {
> -			pr_err("padding missing at index: %d\n", i);
> -			goto fail;
> -		}
> -	}
> -
> -	nr_bytes_poison = sizeof(buf) - chars - terminator - pad;
> -	for (i = 0; i < nr_bytes_poison; i++) {
> -		index = sizeof(buf) - 1 - i; /* Check from the end back */
> -		if (buf[index] != POISON) {
> -			pr_err("poison value missing at index: %d\n", i);
> -			goto fail;
> -		}
> -	}
> -
> -	return 0;
> -fail:
> -	failed_tests++;
> -	return -1;
> -}
> -
> -static void __init selftest(void)
> -{
> -	/*
> -	 * tc() uses a destination buffer of size 6 and needs at
> -	 * least 2 characters spare (one for null and one to check for
> -	 * overflow).  This means we should only call tc() with
> -	 * strings up to a maximum of 4 characters long and 'count'
> -	 * should not exceed 4.  To test with longer strings increase
> -	 * the buffer size in tc().
> -	 */
> -
> -	/* tc(src, count, expected, chars, terminator, pad) */
> -	KSTM_CHECK_ZERO(tc("a", 0, -E2BIG, 0, 0, 0));
> -	KSTM_CHECK_ZERO(tc("", 0, -E2BIG, 0, 0, 0));
> -
> -	KSTM_CHECK_ZERO(tc("a", 1, -E2BIG, 0, 1, 0));
> -	KSTM_CHECK_ZERO(tc("", 1, 0, 0, 1, 0));
> -
> -	KSTM_CHECK_ZERO(tc("ab", 2, -E2BIG, 1, 1, 0));
> -	KSTM_CHECK_ZERO(tc("a", 2, 1, 1, 1, 0));
> -	KSTM_CHECK_ZERO(tc("", 2, 0, 0, 1, 1));
> -
> -	KSTM_CHECK_ZERO(tc("abc", 3, -E2BIG, 2, 1, 0));
> -	KSTM_CHECK_ZERO(tc("ab", 3, 2, 2, 1, 0));
> -	KSTM_CHECK_ZERO(tc("a", 3, 1, 1, 1, 1));
> -	KSTM_CHECK_ZERO(tc("", 3, 0, 0, 1, 2));
> -
> -	KSTM_CHECK_ZERO(tc("abcd", 4, -E2BIG, 3, 1, 0));
> -	KSTM_CHECK_ZERO(tc("abc", 4, 3, 3, 1, 0));
> -	KSTM_CHECK_ZERO(tc("ab", 4, 2, 2, 1, 1));
> -	KSTM_CHECK_ZERO(tc("a", 4, 1, 1, 1, 2));
> -	KSTM_CHECK_ZERO(tc("", 4, 0, 0, 1, 3));
> -}
> -
> -KSTM_MODULE_LOADERS(test_strscpy);
> -MODULE_AUTHOR("Tobin C. Harding <tobin@kernel.org>");
> -MODULE_LICENSE("GPL");
> -- 
> 2.34.1
> 
