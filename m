Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B206ECC2E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 14:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjDXMkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 08:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjDXMkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 08:40:10 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B65330D1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 05:40:09 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id 71dfb90a1353d-4404c9d9fceso1511183e0c.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 05:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682340008; x=1684932008;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pm5YgAO5GczZ8cxOJAygGAJ/cd9lfTw7GnmC+q/KoRk=;
        b=EvhSjrdgmL0MYhC6dlsPxTuaCHE6jgUCfxYbxrv9oPGM/Ix35+mNwgCkBtECRNYivv
         Fvh1xL2KXFq95SLH3/yfnq+KvCO5n6zqGWf0yEZi/H4IAXXEmDp+Ej7Ki5rCCer7/cPu
         qUwwMl7MULUYsYMmBKo0bhRCrCDJb6F/RDT5TgAOMXR6DkDBuOPS3QSXddWPc4+q6mgu
         NRKd4gks/wZPtNaR078n+6Ue61MGfKK/9FPJ3SqCBpnfJvTKQR6xPDq+WtKS1+FVpA5H
         nlu1TbsXdVPMLnd9xGZ13Mkx9Ok4g019h3d/zDfYQHsCWzNfIQpvOf0Z0md+T/nJTqqw
         CBMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682340008; x=1684932008;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pm5YgAO5GczZ8cxOJAygGAJ/cd9lfTw7GnmC+q/KoRk=;
        b=gLnbQEeP1K5VDAVzHY8jIYjn6Oc+0ZSY/v4EfJ5ufcBQ8kForIU9l1W8mYUSfcV2p/
         +vd4oAPaym/mGAKcLeF1HPPZGwYGfVtqH2Qa3z8TxE+jRMYps00X9ggr3XZ9qULDaP7B
         e7MgQKk6kvbPfhTQoYo/miA8O+safCdDQk6jjw/uykQxWqeGjfuZA6rpclnvCFzp8Th+
         +8rBdJgiTnXGsNF5XaB5hfcnyktLsshF7e+n+TK9Nc/c7gljERFrGpBNh4wqr81T9qV5
         rm9QUIwda1UsO/Ikzrsw04PYHkNQfPXzwX/znL6sWRP0uSv/goQ4cpVO7Rs8UPF1ZNgm
         h3vQ==
X-Gm-Message-State: AAQBX9dmOqXpU2f9k9vMNtRTgmJRpKkqBr4+1SZpl9TIBpThgQkX1+aY
        bgWkuH2NO6ldlcfm/NMtEsJ9r43xlUtmzqxmJnZygCBP6xpoX8ZRVgIOxQ==
X-Google-Smtp-Source: AKy350YvS+TbOMgcCsyKEFkIgsBUoimeYJQiqwmPCS7JwMJWqucrWfHXKx8k223zZs2YdU24BGnHG/wRU1o4kkuf2D4=
X-Received: by 2002:a1f:cb02:0:b0:43f:c225:129c with SMTP id
 b2-20020a1fcb02000000b0043fc225129cmr2806380vkg.14.1682340008166; Mon, 24 Apr
 2023 05:40:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230424112313.3408363-1-glider@google.com>
In-Reply-To: <20230424112313.3408363-1-glider@google.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 24 Apr 2023 14:39:32 +0200
Message-ID: <CANpmjNNwzup9o+XNcjQcXEjFrU5QUQEc4qMP1yA07e74eyk6Dw@mail.gmail.com>
Subject: Re: [PATCH] string: use __builtin_memcpy() in strlcpy/strlcat
To:     Alexander Potapenko <glider@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, dvyukov@google.com,
        kasan-dev@googlegroups.com, andy@kernel.org,
        ndesaulniers@google.com, nathan@kernel.org
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

On Mon, 24 Apr 2023 at 13:23, Alexander Potapenko <glider@google.com> wrote:
>
> lib/string.c is built with -ffreestanding, which prevents the compiler
> from replacing certain functions with calls to their library versions.
>
> On the other hand, this also prevents Clang and GCC from instrumenting
> calls to memcpy() when building with KASAN, KCSAN or KMSAN:
>  - KASAN normally replaces memcpy() with __asan_memcpy() with the
>    additional cc-param,asan-kernel-mem-intrinsic-prefix=1;
>  - KCSAN and KMSAN replace memcpy() with __tsan_memcpy() and
>    __msan_memcpy() by default.
>
> To let the tools catch memory accesses from strlcpy/strlcat, replace
> the calls to memcpy() with __builtin_memcpy(), which KASAN, KCSAN and
> KMSAN are able to replace even in -ffreestanding mode.
>
> This preserves the behavior in normal builds (__builtin_memcpy() ends up
> being replaced with memcpy()), and does not introduce new instrumentation
> in unwanted places, as strlcpy/strlcat are already instrumented.
>
> Suggested-by: Marco Elver <elver@google.com>
> Signed-off-by: Alexander Potapenko <glider@google.com>
> Link: https://lore.kernel.org/all/20230224085942.1791837-1-elver@google.com/

Reviewed-by: Marco Elver <elver@google.com>

Looks reasonable.

> ---
>  lib/string.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/lib/string.c b/lib/string.c
> index 3d55ef8901068..be26623953d2e 100644
> --- a/lib/string.c
> +++ b/lib/string.c
> @@ -110,7 +110,7 @@ size_t strlcpy(char *dest, const char *src, size_t size)
>
>         if (size) {
>                 size_t len = (ret >= size) ? size - 1 : ret;
> -               memcpy(dest, src, len);
> +               __builtin_memcpy(dest, src, len);
>                 dest[len] = '\0';
>         }
>         return ret;
> @@ -260,7 +260,7 @@ size_t strlcat(char *dest, const char *src, size_t count)
>         count -= dsize;
>         if (len >= count)
>                 len = count-1;
> -       memcpy(dest, src, len);
> +       __builtin_memcpy(dest, src, len);
>         dest[len] = 0;
>         return res;
>  }
> --
> 2.40.0.634.g4ca3ef3211-goog
>
