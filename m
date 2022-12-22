Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F93654415
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 16:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235378AbiLVPRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 10:17:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235410AbiLVPQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 10:16:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF5831379
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 07:16:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7F4361C31
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 15:16:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64842C433D2;
        Thu, 22 Dec 2022 15:15:59 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="je6PSVKY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1671722156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KEuGIG1+rLUERXrL6QOP8iZT1HPOGRl6L3JOJ8CsiAs=;
        b=je6PSVKYvlQfzZjbG+RVtWzyEJJ9+vXF6IjnfK/T92sNXSroKOlO3WoTo1WhA+GhGBOQNh
        IcD0XCASo4S/UFUJZpHSTIC5T5B/BRQMrGK9QOYBWvwArL9KJfNaVUpgXoBMUTvGfDuffJ
        3ejQx92Xv+wawkX+VWUF2nAGIyAbeCo=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5be17445 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 22 Dec 2022 15:15:56 +0000 (UTC)
Date:   Thu, 22 Dec 2022 16:15:52 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] string.c: test *cmp for all possible 1-character strings
Message-ID: <Y6R0qP5orygWO9vS@zx2c4.com>
References: <20221222140506.1961281-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221222140506.1961281-1-linux@rasmusvillemoes.dk>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2022 at 03:05:06PM +0100, Rasmus Villemoes wrote:
> The switch to -funsigned-char made a pre-existing bug on m68k more
> apparent. That is now fixed (by removing m68k's private strcmp(), see
> commit 7c0846125358), but we still have quite a few architectures that
> provide one or more of strcmp(), strncmp() and memcmp().
> 
> They probably all work fine for the cases where the input is all
> ASCII, and/or where the caller only wants to know about equality or
> not (i.e. only checks whether the return value is 0 or not).
> 
> Let's check that all these implementations also behave correctly for
> bytes with the high bit set, and provide the correct ordering -
> independent of us now building with -funsigned-char, the C standard
> says that these *cmp functions should consider the buffers as
> consisting of unsigned chars.
> 
> This is only intended to help find other latent bugs and can/should be
> ripped out again before v6.2, or perhaps moved to test_string.c in
> some form, but for now I think it's worth doing unconditionally.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  lib/string.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/lib/string.c b/lib/string.c
> index 4fb566ea610f..1718f96e8082 100644
> --- a/lib/string.c
> +++ b/lib/string.c
> @@ -880,3 +880,30 @@ void *memchr_inv(const void *start, int c, size_t bytes)
>  	return check_bytes8(start, value, bytes % 8);
>  }
>  EXPORT_SYMBOL(memchr_inv);
> +
> +static int sign(int x)
> +{
> +	return (x > 0) - (x < 0);
> +}
> +
> +static int test_xxxcmp(void)
> +{
> +	char a[2], b[2];
> +	int i, j;
> +
> +	a[1] = b[1] = 0;
> +	for (i = 0; i < 256; ++i) {
> +		a[0] = i;
> +		for (j = 0; j < 256; ++j) {
> +			b[0] = j;
> +			WARN_ONCE(sign(strcmp(a, b)) != sign(i - j),
> +				  "strcmp() broken for (%2ph, %2ph)\n", a, b);
> +			WARN_ONCE(sign(memcmp(a, b, 2)) != sign(i - j),
> +				  "memcmp() broken for (%2ph, %2ph)\n", a, b);
> +			WARN_ONCE(sign(strncmp(a, b, 2)) != sign(i - j),
> +				  "strncmp() broken for (%2ph, %2ph)\n", a, b);
> +		}
> +	}
> +	return 0;
> +}
> +late_initcall(test_xxxcmp);

This probably belongs in some config-gated selftest file that can be
compiled out, rather than running unconditionally on every boot, right?

Jason
