Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 676FE60E721
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 20:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234111AbiJZS0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 14:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234093AbiJZS0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 14:26:53 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6916237CE
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 11:26:51 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id k1so174903vsc.13
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 11:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v3TrCD3rKy7ECmCNklfjzMUU1ItZed04yLxmZz8iGiA=;
        b=c7Pv0diJ7cfnwwoP1PvT1EctizPOp1wxiFORNv0ZoJu9OyyXRkjxZzfuEbyJonQnbF
         xn9gU9nG/RsQGqW/3OxFcW1k6IvPzYHoTzW4xnLPu0l7Vvwivo+kliOcBtaD4MGySTdt
         KO0JVKm8QHCR6H3LKQnLDOpscClbmkuYSUILznjaxZYYjTSI3Tde7enfvPqGRykvim93
         /5gMpRWRf25qGdOOGsYygP35kZJt9VgvpT6hgQLJiuwVL3YyKYHO2exkk28DzJQAKQOL
         /7Wse0mTLnkDgvpr1s2Q2aF4vED+SvIyYxLO+xmA1PIUjDQ2fHYrWIqInH3ZLGj8BsWL
         t8KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v3TrCD3rKy7ECmCNklfjzMUU1ItZed04yLxmZz8iGiA=;
        b=TVGBV2dE9twM/Ex5E1fRLmwpUKLqFdhrhq4vCZM/c+5Ns+DGutXALAxryBLkQEpkCR
         bcthsjm3pOjRTohGHLpVyuoHmoTNtFSInxFZlS3u6MllBKAH7qa2uJ1o32YzDy5Fv2su
         mrpC06tfXSsIn/bq4J5gmvDG0eVnVrScha6vp2hHtSIf9OmEF20fDDa2VsWV0nWic0b3
         WM0FucHUiUwfPQ7i/7qoh2p0goH4flnhFsMp4c2ABrHAelvR8719yAmniHKJ8gV2f02O
         BAU9SohOUHA4nDWQ1qM2OTF5YN3vvWg1SMCZ3qGThKYHPTB5Xxj/+tn3ISeLFE6+3xD7
         NxHw==
X-Gm-Message-State: ACrzQf2URM1SWT+eoh6IvrXVyIYwC8I/5NL/VPe8uIXr5ZbJNho3pWpy
        YNNEi2W22nuHZpTTXr3tkoMdTKICPSehRU0vwueowOtVJ1FqMw==
X-Google-Smtp-Source: AMsMyM6IdRphRBbG3V6yzZv6ryLQEqD8f/xfny37uZa7Nfjs/0O81S+227ql8F1ywU15jYLCGwCgluMf4ZTkJxzCw1c=
X-Received: by 2002:a17:902:b218:b0:184:710c:8c52 with SMTP id
 t24-20020a170902b21800b00184710c8c52mr45212107plr.95.1666808799104; Wed, 26
 Oct 2022 11:26:39 -0700 (PDT)
MIME-Version: 1.0
References: <20221025231627.never.000-kees@kernel.org>
In-Reply-To: <20221025231627.never.000-kees@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 26 Oct 2022 11:26:27 -0700
Message-ID: <CAKwvOdkDaSQZ_e0hX0ggNqsWn+=0xyqMdbf6J+YW0-iZ=ewViQ@mail.gmail.com>
Subject: Re: [PATCH] fortify: Do not cast to "unsigned char"
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-hardening@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 4:17 PM Kees Cook <keescook@chromium.org> wrote:
>
> Do not cast to "unsigned char", as this needlessly creates type problems
> when attempting builds without -Wno-pointer-sign[1]. The intent of the
> cast is to drop possible "const" types.
>
> [1] https://lore.kernel.org/lkml/CAHk-=wgz3Uba8w7kdXhsqR1qvfemYL+OFQdefJnkeqXG8qZ_pA@mail.gmail.com/
>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Fixes: 3009f891bb9f ("fortify: Allow strlen() and strnlen() to pass compile-time known lengths")
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/linux/fortify-string.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
> index f3dd5d1a6a25..09a032f6ce6b 100644
> --- a/include/linux/fortify-string.h
> +++ b/include/linux/fortify-string.h
> @@ -18,7 +18,7 @@ void __write_overflow_field(size_t avail, size_t wanted) __compiletime_warning("
>
>  #define __compiletime_strlen(p)                                        \
>  ({                                                             \
> -       unsigned char *__p = (unsigned char *)(p);              \
> +       char *__p = (char *)(p);                                \

If the intent of __p is to avoid repeated application of side effects
from the evaluation of the macro parameter p, this could also be:

__auto_type __p = (p);

I think this is nice because it doesn't strip potential const
qualifiers from the macro parameter.

>         size_t __ret = SIZE_MAX;                                \
>         size_t __p_size = __member_size(p);                     \
>         if (__p_size != SIZE_MAX &&                             \
> --
> 2.34.1
>


-- 
Thanks,
~Nick Desaulniers
