Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145B6663611
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 01:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236723AbjAJALg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 19:11:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234576AbjAJALd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 19:11:33 -0500
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE81714005;
        Mon,  9 Jan 2023 16:11:32 -0800 (PST)
Received: by mail-oo1-xc2f.google.com with SMTP id 187-20020a4a09c4000000b004d8f3cb09f5so2843303ooa.6;
        Mon, 09 Jan 2023 16:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=02bsn0yiJNUpWqqLqFldR8saSUfX8/r+gUypjApx5FM=;
        b=dPbg0lHhxnePHWXXo3mDLoQvlVa8AI0mAdMIGM61iCPZ86eDP/OuD2I4E24+XQoGdp
         UuN+kyJYdGD+Cuhy0I5vHVJZOoANKzOIWLBXG1TB3FH+idwxTOnoenrM1IXUNjB4AxvA
         cWYWtgKysJ5cuSKOI52kOwifEb9aZvTWuqIt/tsV9J3ettT+3KMcmULjT5GZyxKBovr7
         nQ/CdV0vmFCo/muH1MWluEUrN4OG5aIkph5+FFKX2BFhfDYQJVhX23nPaXNHNMngAcxx
         XDuTMvLiDIV0dCk8Uc3ypsBS+VnCqSqHbsxHGRjkATrdsmTRhwo7f8aqG33Bf4gyUEU7
         K4Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=02bsn0yiJNUpWqqLqFldR8saSUfX8/r+gUypjApx5FM=;
        b=aOt5m7cdCbguik4ujfFshWzkbL4WybNpTblKDVxmWrkFJRIs1pn3nHfridUdNxCNri
         vy9AMbTSE3elBkQRq2ys5c2SXzYGb2w4cSNWt8pVEuSzX9jsHioeC/zPXA7b6HQcR27p
         CNWDJUzksTrH/xENPcrOGeRNYY60kt5e+CCEo/Sm5johtHuRvVxQheDaOP2lbNbXwjw9
         A8+RJruQDdqrBeF0wMacEytzK1yKZEsx7m3cmufTLM+SdL+uegpIIKNSqavTRIhmR8iX
         uAe9zD8Qltz2F+NdSwNDHRWQBvwmVAL2dZxeg3Ca+STYg7jVBnMmsbQLynyh+095u8wW
         x5Ww==
X-Gm-Message-State: AFqh2krLNzE2u1Q0LXv8tNq9cVsffCHowhX5bWY98uAjeBNM+A7L8OKd
        dLy1uNpNRMiiE4sETnoCmCU=
X-Google-Smtp-Source: AMrXdXttlORN8VsN1vA3l8X+yGGBv6K4wXDrmkq1nmEsWrx5rJe6hLhXXTTzrbgOMZZwSH3enk24Jw==
X-Received: by 2002:a05:6820:823:b0:4f1:f375:c240 with SMTP id bg35-20020a056820082300b004f1f375c240mr4690785oob.6.1673309492270;
        Mon, 09 Jan 2023 16:11:32 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o78-20020a4a2c51000000b004a0b424f99dsm4928789ooo.43.2023.01.09.16.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 16:11:31 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 9 Jan 2023 16:11:30 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-hardening@vger.kernel.org, David Gow <davidgow@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Miguel Ojeda <ojeda@kernel.org>,
        Isabella Basso <isabbasso@riseup.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kunit: memcpy: Split slow memcpy tests into
 MEMCPY_SLOW_KUNIT_TEST
Message-ID: <20230110001130.GA1808090@roeck-us.net>
References: <20230107040203.never.112-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230107040203.never.112-kees@kernel.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2023 at 08:02:07PM -0800, Kees Cook wrote:
> Since the long memcpy tests may stall a system for tens of seconds
> in virtualized architecture environments, split those tests off under
> CONFIG_MEMCPY_SLOW_KUNIT_TEST so they can be separately disabled.
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Link: https://lore.kernel.org/lkml/20221226195206.GA2626419@roeck-us.net
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> Guenter, does this give you the needed flexibility to turn on the memcpy
> kunit tests again in your slower environments?

Yes, it does, and it works.

Reviewed-and-tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  lib/Kconfig.debug  |  9 +++++++++
>  lib/memcpy_kunit.c | 17 +++++++++++++----
>  2 files changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index c2c78d0e761c..b5e94807f41c 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2621,6 +2621,15 @@ config MEMCPY_KUNIT_TEST
>  
>  	  If unsure, say N.
>  
> +config MEMCPY_SLOW_KUNIT_TEST
> +	tristate "Include exhaustive memcpy tests" if !KUNIT_ALL_TESTS

As Geert noticed, bool should be sufficient here since this is not a
separate test.

Thanks,
Guenter

> +	depends on MEMCPY_KUNIT_TEST
> +	default KUNIT_ALL_TESTS
> +	help
> +	  Some memcpy tests are quite exhaustive in checking for overlaps
> +	  and bit ranges. These can be very slow, so they are split out
> +	  as a separate config.
> +
>  config IS_SIGNED_TYPE_KUNIT_TEST
>  	tristate "Test is_signed_type() macro" if !KUNIT_ALL_TESTS
>  	depends on KUNIT
> diff --git a/lib/memcpy_kunit.c b/lib/memcpy_kunit.c
> index 89128551448d..cc1f36335a9b 100644
> --- a/lib/memcpy_kunit.c
> +++ b/lib/memcpy_kunit.c
> @@ -307,8 +307,12 @@ static void set_random_nonzero(struct kunit *test, u8 *byte)
>  	}
>  }
>  
> -static void init_large(struct kunit *test)
> +static int init_large(struct kunit *test)
>  {
> +	if (!IS_ENABLED(CONFIG_MEMCPY_SLOW_KUNIT_TEST)) {
> +		kunit_skip(test, "Slow test skipped. Enable with CONFIG_MEMCPY_SLOW_KUNIT_TEST=y");
> +		return -EBUSY;
> +	}
>  
>  	/* Get many bit patterns. */
>  	get_random_bytes(large_src, ARRAY_SIZE(large_src));
> @@ -319,6 +323,8 @@ static void init_large(struct kunit *test)
>  
>  	/* Explicitly zero the entire destination. */
>  	memset(large_dst, 0, ARRAY_SIZE(large_dst));
> +
> +	return 0;
>  }
>  
>  /*
> @@ -327,7 +333,9 @@ static void init_large(struct kunit *test)
>   */
>  static void copy_large_test(struct kunit *test, bool use_memmove)
>  {
> -	init_large(test);
> +
> +	if (init_large(test))
> +		return;
>  
>  	/* Copy a growing number of non-overlapping bytes ... */
>  	for (int bytes = 1; bytes <= ARRAY_SIZE(large_src); bytes++) {
> @@ -472,7 +480,8 @@ static void memmove_overlap_test(struct kunit *test)
>  	static const int bytes_start = 1;
>  	static const int bytes_end = ARRAY_SIZE(large_src) + 1;
>  
> -	init_large(test);
> +	if (init_large(test))
> +		return;
>  
>  	/* Copy a growing number of overlapping bytes ... */
>  	for (int bytes = bytes_start; bytes < bytes_end;
> @@ -549,8 +558,8 @@ static void strtomem_test(struct kunit *test)
>  static struct kunit_case memcpy_test_cases[] = {
>  	KUNIT_CASE(memset_test),
>  	KUNIT_CASE(memcpy_test),
> -	KUNIT_CASE(memcpy_large_test),
>  	KUNIT_CASE(memmove_test),
> +	KUNIT_CASE(memcpy_large_test),
>  	KUNIT_CASE(memmove_large_test),
>  	KUNIT_CASE(memmove_overlap_test),
>  	KUNIT_CASE(strtomem_test),
> -- 
> 2.34.1
> 
