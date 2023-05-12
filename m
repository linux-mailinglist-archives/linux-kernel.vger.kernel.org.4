Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 683C3700CA1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 18:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241853AbjELQKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 12:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbjELQKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 12:10:30 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E065FD0
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 09:10:25 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-763c3429a8cso266351739f.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 09:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683907824; x=1686499824;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M0UJ2m9D/uUbhV+yi63iViM82oPaAy45wfjsXlqa/O0=;
        b=vHsBiI9/IqcbmwFQjaWNUAoZRwlts69uO8i1/axiFNPYLeEQpPhF5hEHtQbg4sQvEY
         7qt1MtouudMrJex4/Ijk3J4jtr7RR0EAMH1tbLXfA1kY/fQCPPPGHzZT/f/aOgVAGbdW
         S6crtmROnC9UYps+GgukUGf+zMAD+1VBg+Pu20OAmzGT8ZoGwvOLBX1utJa6KdZjv70N
         m0SZ6pZ7COnOyfFAkO1+LL6PFV+oxsHhScH737o5G8qH5JWS65ZmEHE8P2dwlDC92JJP
         Inrne5nzX7SeN7vXjyU/8mOd7HH3yWT4ritb3r2BADhAP17nvfRNAgDimknPx4bW3/56
         KkyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683907824; x=1686499824;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M0UJ2m9D/uUbhV+yi63iViM82oPaAy45wfjsXlqa/O0=;
        b=HpH4uIKu1XfY0Z3jXe2mMfDdVJHDO3OpyYx2medlCOVsUjwebKQkjUbJgjE1+5n6Ks
         3dIxMALvJhLau+zyBAp9fFJWvDfmL2IQjf32Kktp9oIN/wkZ6j+0dxG7N3AUb87ktOrP
         wBKnSYcgQCDV0KgBnB8tO7GL2h0dO9Vog+FbgHomvuatabduJDs1PJQpAaOeQi0SQfGz
         FQgQzZNQURVxQGTrZxIXvqzruVoAWyiUzsiG09hThBvIDZyk8KdQSSDeZOSGy9pVBHhH
         0s81HSVshHI4SI/wHoHI7HZnfxPHFRJuxDwCNlt0Otb/QH/Di1pYxRuGgOr1Zb0BOZpJ
         yvQw==
X-Gm-Message-State: AC+VfDzsNKBbfXeTsG1GZL8bfkpEqQc7c7uQcnUG+mcsv3L8NXqtfZRa
        Plpv7wCPqD/a+ws+FO5cP8pCuNEgvcvIMUW/QyH64A==
X-Google-Smtp-Source: ACHHUZ7QKBeeac4l/20TcS5HYna4kOM+9T9PlZ8eWil5AEWmxwRWKpbI3ijvn/OeVcqw+sAM4/D2Orm5qTp0T0y/Pbg=
X-Received: by 2002:a92:3210:0:b0:32b:2884:667d with SMTP id
 z16-20020a923210000000b0032b2884667dmr19850155ile.7.1683907824530; Fri, 12
 May 2023 09:10:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1683892665.git.christophe.leroy@csgroup.eu> <d9c6afc28d0855240171a4e0ad9ffcdb9d07fceb.1683892665.git.christophe.leroy@csgroup.eu>
In-Reply-To: <d9c6afc28d0855240171a4e0ad9ffcdb9d07fceb.1683892665.git.christophe.leroy@csgroup.eu>
From:   Marco Elver <elver@google.com>
Date:   Fri, 12 May 2023 18:09:46 +0200
Message-ID: <CANpmjNMm-2Tdhp6rDzA7CYvotmmGmLUnZnA_35yLUvxHB=7s0g@mail.gmail.com>
Subject: Re: [PATCH 1/3] kcsan: Don't expect 64 bits atomic builtins from 32
 bits architectures
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kasan-dev@googlegroups.com, Rohan McLure <rmclure@linux.ibm.com>
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

On Fri, 12 May 2023 at 17:31, Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
> Activating KCSAN on a 32 bits architecture leads to the following
> link-time failure:
>
>     LD      .tmp_vmlinux.kallsyms1
>   powerpc64-linux-ld: kernel/kcsan/core.o: in function `__tsan_atomic64_load':
>   kernel/kcsan/core.c:1273: undefined reference to `__atomic_load_8'
>   powerpc64-linux-ld: kernel/kcsan/core.o: in function `__tsan_atomic64_store':
>   kernel/kcsan/core.c:1273: undefined reference to `__atomic_store_8'
>   powerpc64-linux-ld: kernel/kcsan/core.o: in function `__tsan_atomic64_exchange':
>   kernel/kcsan/core.c:1273: undefined reference to `__atomic_exchange_8'
>   powerpc64-linux-ld: kernel/kcsan/core.o: in function `__tsan_atomic64_fetch_add':
>   kernel/kcsan/core.c:1273: undefined reference to `__atomic_fetch_add_8'
>   powerpc64-linux-ld: kernel/kcsan/core.o: in function `__tsan_atomic64_fetch_sub':
>   kernel/kcsan/core.c:1273: undefined reference to `__atomic_fetch_sub_8'
>   powerpc64-linux-ld: kernel/kcsan/core.o: in function `__tsan_atomic64_fetch_and':
>   kernel/kcsan/core.c:1273: undefined reference to `__atomic_fetch_and_8'
>   powerpc64-linux-ld: kernel/kcsan/core.o: in function `__tsan_atomic64_fetch_or':
>   kernel/kcsan/core.c:1273: undefined reference to `__atomic_fetch_or_8'
>   powerpc64-linux-ld: kernel/kcsan/core.o: in function `__tsan_atomic64_fetch_xor':
>   kernel/kcsan/core.c:1273: undefined reference to `__atomic_fetch_xor_8'
>   powerpc64-linux-ld: kernel/kcsan/core.o: in function `__tsan_atomic64_fetch_nand':
>   kernel/kcsan/core.c:1273: undefined reference to `__atomic_fetch_nand_8'
>   powerpc64-linux-ld: kernel/kcsan/core.o: in function `__tsan_atomic64_compare_exchange_strong':
>   kernel/kcsan/core.c:1273: undefined reference to `__atomic_compare_exchange_8'
>   powerpc64-linux-ld: kernel/kcsan/core.o: in function `__tsan_atomic64_compare_exchange_weak':
>   kernel/kcsan/core.c:1273: undefined reference to `__atomic_compare_exchange_8'
>   powerpc64-linux-ld: kernel/kcsan/core.o: in function `__tsan_atomic64_compare_exchange_val':
>   kernel/kcsan/core.c:1273: undefined reference to `__atomic_compare_exchange_8'
>
> 32 bits architectures don't have 64 bits atomic builtins. Only
> include DEFINE_TSAN_ATOMIC_OPS(64) on 64 bits architectures.
>
> Fixes: 0f8ad5f2e934 ("kcsan: Add support for atomic builtins")
> Suggested-by: Marco Elver <elver@google.com>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Reviewed-by: Marco Elver <elver@google.com>

Do you have your own tree to take this through with the other patches?

> ---
>  kernel/kcsan/core.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
> index 5a60cc52adc0..8a7baf4e332e 100644
> --- a/kernel/kcsan/core.c
> +++ b/kernel/kcsan/core.c
> @@ -1270,7 +1270,9 @@ static __always_inline void kcsan_atomic_builtin_memorder(int memorder)
>  DEFINE_TSAN_ATOMIC_OPS(8);
>  DEFINE_TSAN_ATOMIC_OPS(16);
>  DEFINE_TSAN_ATOMIC_OPS(32);
> +#ifdef CONFIG_64BIT
>  DEFINE_TSAN_ATOMIC_OPS(64);
> +#endif
>
>  void __tsan_atomic_thread_fence(int memorder);
>  void __tsan_atomic_thread_fence(int memorder)
> --
> 2.40.1
>
