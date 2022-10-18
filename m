Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0DE603302
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 21:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbiJRTGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 15:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiJRTGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 15:06:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11AA6F572;
        Tue, 18 Oct 2022 12:06:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85869616D0;
        Tue, 18 Oct 2022 19:06:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 989C9C433C1;
        Tue, 18 Oct 2022 19:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666119998;
        bh=NKf6ZfIA4pLEmJJICUPcObAU5l1GLYEskJ/yvBdGR50=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ms8EHjTPjTlkLtf4Bd8k0opKS41Fm20TqWqf5vn23t3uH/D48UCLncrh6UkJ4/ta0
         XToJOUDYWRd5hUtHiGhV5lYIj8VJadrwNmZwlxg8o7HcqarzCeotvu1H7koR/2Z93h
         eq/6CRkWymX1P/NGUUKJBe50bqZ7hkEHjMcbS2AHl1Zd5O8nNJK2na87ZsOYyz7xTN
         AJB/aXJpnsqgM5HrEhk7kGUnkQZRC2gP5pO6BScM8+uAJkAgRo9ZXCGzc5iyGFcj/l
         zuBTveaQ28y2Btm8hLU3oB1mYCFmTsuJ2stneUlyDZoahyZUq1k+LAnaj4F/Sr+sSE
         Tvamkdl57x4aA==
Date:   Tue, 18 Oct 2022 12:06:36 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-hardening@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fortify: Short-circuit known-safe calls to strscpy()
Message-ID: <Y075PIwTnnYF3Ak7@dev-arch.thelio-3990X>
References: <20221018083051.never.939-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018083051.never.939-kees@kernel.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 01:32:51AM -0700, Kees Cook wrote:
> Replacing compile-time safe calls of strcpy()-related functions with
> strscpy() was always calling the full strscpy() logic when a builtin
> would be better. For example:
> 
> 	char buf[16];
> 	strcpy(buf, "yes");
> 
> would reduce to __builtin_memcpy(buf, "yes", 4), but not if it was:
> 
> 	strscpy(buf, yes, sizeof(buf));
> 
> Fix this by checking if all sizes are known at compile-time.
> 
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

I ran the following commands and the tests all passed:

$ tools/testing/kunit/kunit.py run --arch arm64 --cross_compile aarch64-linux-gnu- strscpy

$ tools/testing/kunit/kunit.py run --arch arm64 --make_options LLVM=1 strscpy

$ tools/testing/kunit/kunit.py run --arch x86_64 strscpy

$ tools/testing/kunit/kunit.py run --arch x86_64 --make_options LLVM=1 strscpy

$ tools/testing/kunit/kunit.py run --arch arm64 --cross_compile aarch64-linux-gnu- --kconfig_add CONFIG_FORTIFY_SOURCE=y strscpy

$ tools/testing/kunit/kunit.py run --arch arm64 --kconfig_add CONFIG_FORTIFY_SOURCE=y --make_options LLVM=1 strscpy

$ tools/testing/kunit/kunit.py run --arch x86_64 --kconfig_add CONFIG_FORTIFY_SOURCE=y strscpy

$ tools/testing/kunit/kunit.py run --arch x86_64 --kconfig_add CONFIG_FORTIFY_SOURCE=y --make_options LLVM=1 strscpy

Tested-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  include/linux/fortify-string.h | 10 ++++++++++
>  lib/strscpy_kunit.c            | 13 +++++++++++++
>  2 files changed, 23 insertions(+)
> 
> diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
> index aa1a50009632..c473adb55cf5 100644
> --- a/include/linux/fortify-string.h
> +++ b/include/linux/fortify-string.h
> @@ -321,6 +321,16 @@ __FORTIFY_INLINE ssize_t strscpy(char * const POS p, const char * const POS q, s
>  	if (__compiletime_lessthan(p_size, size))
>  		__write_overflow();
>  
> +	/* Short-circuit for compile-time known-safe lengths. */
> +	if (__compiletime_lessthan(p_size, SIZE_MAX)) {
> +		len = __compiletime_strlen(q);
> +
> +		if (len < SIZE_MAX && __compiletime_lessthan(len, size)) {
> +			__underlying_memcpy(p, q, len + 1);
> +			return len;
> +		}
> +	}
> +
>  	/*
>  	 * This call protects from read overflow, because len will default to q
>  	 * length if it smaller than size.
> diff --git a/lib/strscpy_kunit.c b/lib/strscpy_kunit.c
> index 98523f828d3a..a6b6344354ed 100644
> --- a/lib/strscpy_kunit.c
> +++ b/lib/strscpy_kunit.c
> @@ -81,6 +81,8 @@ static void tc(struct kunit *test, char *src, int count, int expected,
>  
>  static void strscpy_test(struct kunit *test)
>  {
> +	char dest[8];
> +
>  	/*
>  	 * tc() uses a destination buffer of size 6 and needs at
>  	 * least 2 characters spare (one for null and one to check for
> @@ -111,6 +113,17 @@ static void strscpy_test(struct kunit *test)
>  	tc(test, "ab",   4, 2,	    2, 1, 1);
>  	tc(test, "a",    4, 1,	    1, 1, 2);
>  	tc(test, "",     4, 0,	    0, 1, 3);
> +
> +	/* Compile-time-known source strings. */
> +	KUNIT_EXPECT_EQ(test, strscpy(dest, "", ARRAY_SIZE(dest)), 0);
> +	KUNIT_EXPECT_EQ(test, strscpy(dest, "", 3), 0);
> +	KUNIT_EXPECT_EQ(test, strscpy(dest, "", 1), 0);
> +	KUNIT_EXPECT_EQ(test, strscpy(dest, "", 0), -E2BIG);
> +	KUNIT_EXPECT_EQ(test, strscpy(dest, "Fixed", ARRAY_SIZE(dest)), 5);
> +	KUNIT_EXPECT_EQ(test, strscpy(dest, "Fixed", 3), -E2BIG);
> +	KUNIT_EXPECT_EQ(test, strscpy(dest, "Fixed", 1), -E2BIG);
> +	KUNIT_EXPECT_EQ(test, strscpy(dest, "Fixed", 0), -E2BIG);
> +	KUNIT_EXPECT_EQ(test, strscpy(dest, "This is too long", ARRAY_SIZE(dest)), -E2BIG);
>  }
>  
>  static struct kunit_case strscpy_test_cases[] = {
> -- 
> 2.34.1
> 
> 
