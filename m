Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A0F5B860C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 12:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiINKOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 06:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiINKON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 06:14:13 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D850C21267
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 03:14:11 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id j7so9937527vsr.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 03:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=aVHGh2KXaAGeDBRMRckt00P09mGtnKYfnn7Un16et9k=;
        b=fyFvrZ3JObd/xtxvG5Ow0U9li7MbmyuOhfuVYcFdexiTt688/Bd+KepOFtO6WI7k53
         uvq6Og4MS4pY4OG2UojhtIlYM5kOk6tfs6ZD6venLIjryw2tUtBXnxW1rE9n5bNATZWp
         zu9Z0bEPA98OgeHml0eR0TW5A/k2Pe+Obv1rpRGy3+nlomGS3TXFT8SHLklf7/jT7KG2
         O0leXfG15LQrviHnoZ6vOs/FiCQejxIDJXzWOauQwLxnwtRir/bcabwX2G8x6J3SgMXG
         KakGlgV+9aDtBKfYvDyPARU+oV5a3jzXVceHJB++z7dMF0TbgNuU8qmaNgT6iLIWPQjJ
         T/Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=aVHGh2KXaAGeDBRMRckt00P09mGtnKYfnn7Un16et9k=;
        b=bILoUJtrZnkT+a72fjCEJAmC1RkpH4/Hm0DCkzvibjBydeu82KXyTSq/tFJ+LLLYnl
         /I7kR2UNMETpMUtn+Wmtb4joejyFs17cvAC/2jP2zQjIfZq6h3CamNAivjoHyQoJzRHo
         7syFltkCzVWVNwu4gU0o9zQZB7AGux615um/7OLdv2+B2fQNr6l2Nj9UOTbcoCZLb78a
         dYw21FTaYXvuaK0hQusu8iYcQWvEWEBRMCN5BXa9v8jlsGSOA1Z6PpLv6kHUc5mTcWAe
         FixfVgye+RwvuwJuYJ7j4sBhb6q/9KISXmMED0pWKlxg+2KR5P2Qtd0i5Oni1DLsJ7M3
         2ZbA==
X-Gm-Message-State: ACgBeo24GGEv6FoFL4g2aroK+i2q6irYWmFlzsLdgXxblXkhMeWbakb+
        zbwmQ8GL79VWo5HXc+kqjL5uu6T9FnsUD6MnhYMjRA==
X-Google-Smtp-Source: AA6agR4bxwbfTAdlXC3065+Rj0FOZ3/0/EKkHVL8gqO4/u1CRlKPF0tDXfVxyEweZ5yqatpRrrTT+nzW/SfvGU4zcUo=
X-Received: by 2002:a67:e04d:0:b0:397:f787:7880 with SMTP id
 n13-20020a67e04d000000b00397f7877880mr12930358vsl.71.1663150450866; Wed, 14
 Sep 2022 03:14:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220913173136.1926909-1-keescook@chromium.org>
In-Reply-To: <20220913173136.1926909-1-keescook@chromium.org>
From:   David Gow <davidgow@google.com>
Date:   Wed, 14 Sep 2022 18:13:59 +0800
Message-ID: <CABVgOSnSsMxHQJNPs77rzA729wW1k6o17_ERqGvszFVkQ-hv_Q@mail.gmail.com>
Subject: Re: [PATCH] fortify: Adjust KUnit test for modular build
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-hardening@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 1:31 AM Kees Cook <keescook@chromium.org> wrote:
>
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

Ah, this is better than saved_command_line, IMO. I don't think it'd
necessarily be a _disaster_ to just introduce a new dynamically-sized
string here, which would be more explicit, but test->name is at least
obviously related to this file anyway.

Reviewed-by: David Gow <davidgow@google.com>

Cheers
-- David

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
>         KUNIT_EXPECT_EQ(test, __compiletime_strlen(array_unknown), SIZE_MAX);
>         /* Externally defined and dynamically sized string pointer: */
> -       KUNIT_EXPECT_EQ(test, __compiletime_strlen(saved_command_line), SIZE_MAX);
> +       KUNIT_EXPECT_EQ(test, __compiletime_strlen(test->name), SIZE_MAX);
>  }
>
>  /* This is volatile so the optimizer can't perform DCE below. */
> --
> 2.34.1
>
