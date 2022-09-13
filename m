Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7D55B7CDE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 00:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbiIMWF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 18:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiIMWFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 18:05:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95AE324F27;
        Tue, 13 Sep 2022 15:05:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E8D1615F7;
        Tue, 13 Sep 2022 22:05:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42E47C433C1;
        Tue, 13 Sep 2022 22:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663106712;
        bh=svJ3QhlZ+eGSIesk3Dcw3WZz5vdXV48Ff+Kt607rrhk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EwcGfadL8HcQKw0kb7zpOybsZcZYrz+7h/pCRqtcgjx2u8FdowQ0GmxYY6yTwT0TU
         oQs1N6RCdk2X/1UNNe4b5xIv6UzHeWgKQW80G3C3Qs3vp+22WMjDxwwdjjbDa9/gr5
         JE8++v+deMI7PsgPvuZJimqSdQL4XJcRzITdr9RLYLGEyfI6kSlBCwpfsJNGh0NEx7
         jrzukbyPgJ4LDe8hMi1vfp1+psW6bbV40daCjeBH8OyZaOGer08pZPpvOnMLLeWXgT
         D9iXSVxyn7GVm0qNrR1e31YkgShkCp+701nspO9iSKjnET+/2QTEEfJHboWy4pqp6n
         qgHnWbNyrnsgA==
Date:   Tue, 13 Sep 2022 15:05:10 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-hardening@vger.kernel.org, David Gow <davidgow@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fortify: Adjust KUnit test for modular build
Message-ID: <YyD+lu7Kq/Ga0N/V@dev-arch.thelio-3990X>
References: <20220913173136.1926909-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913173136.1926909-1-keescook@chromium.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022 at 10:31:36AM -0700, Kees Cook wrote:
> A much better "unknown size" string pointer is available directly from
> struct test, so use that instead of a global that isn't shared with
> modules.
> 
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Link: https://lore.kernel.org/lkml/YyCOHOchVuE/E7vS@dev-arch.thelio-3990X
> Fixes: 875bfd5276f3 ("fortify: Add KUnit test for FORTIFY_SOURCE internals")
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> Whoops! Thanks Nathan! :) This fixes it for your reproducer.

Confirmed :)

Build-tested-by: Nathan Chancellor <nathan@kernel.org>

Thanks for the quick fix!

> ---
>  lib/fortify_kunit.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/lib/fortify_kunit.c b/lib/fortify_kunit.c
> index 99bc0ea60d27..409af07f340a 100644
> --- a/lib/fortify_kunit.c
> +++ b/lib/fortify_kunit.c
> @@ -17,7 +17,6 @@
>  
>  #include <kunit/test.h>
>  #include <linux/string.h>
> -#include <linux/init.h>
>  
>  static const char array_of_10[] = "this is 10";
>  static const char *ptr_of_11 = "this is 11!";
> @@ -31,7 +30,7 @@ static void known_sizes_test(struct kunit *test)
>  
>  	KUNIT_EXPECT_EQ(test, __compiletime_strlen(array_unknown), SIZE_MAX);
>  	/* Externally defined and dynamically sized string pointer: */
> -	KUNIT_EXPECT_EQ(test, __compiletime_strlen(saved_command_line), SIZE_MAX);
> +	KUNIT_EXPECT_EQ(test, __compiletime_strlen(test->name), SIZE_MAX);
>  }
>  
>  /* This is volatile so the optimizer can't perform DCE below. */
> -- 
> 2.34.1
> 
