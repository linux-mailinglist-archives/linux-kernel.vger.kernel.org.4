Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35903717953
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 09:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235074AbjEaH7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 03:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234907AbjEaH6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 03:58:53 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE2313E
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 00:58:36 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f4d6aee530so5903541e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 00:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685519914; x=1688111914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nHMZgb7ql614fjK+awMwSPS6BsriEA2nG/M+3wX+ebo=;
        b=rAWvgvynY7FQZDuKtEe8VkUPbI1utwSiRnmiQituf23HFp9h9SYV426Y7rQ5qEtS2U
         5vmqffOOYUQbnIS4BdA1H1YpRXOBe31oD0Bjjj6pklQOSt8jbGA2hAlNI1LswwpMIggl
         J3acgn7N+oBGAphseuqGwBpOGDz0DYms6pL/FuxQKQpG0qhqcEvDp+8CMNnsJGRzmk8v
         MJuIKeBfkzB5zKPBBMlTgpLLRZPnycTeBbbNkXIWSa3q+osuWGXheRaGNqcqpIzU5tl8
         aJFwlHGKQgLXpPxg1s4HGwNG+oFdWQ+TtZGCTZPXpESQgDyePumZ7C6WeMRo4hwF6lYv
         PVKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685519914; x=1688111914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nHMZgb7ql614fjK+awMwSPS6BsriEA2nG/M+3wX+ebo=;
        b=KqWzRu0cRRvRUJNy/LC0xlOF9FglJANM/NvoFCcKbhf+5bz6nugrcqOQs1w3B852AH
         Ds7Tj+W9VhQd3kRKiogOtAYBJXbu2khtHeWDsRsvepaOTTvx438l/bC1nfi6KhpSvC86
         pTbMu6yBJp+/2EiMKkDBC7qmItNNcuPyqleKI6yI8HmvzjySPg7d75SkjOVx2MTwVvt7
         VG5I05lRQYGDD2TZsqn9Uz/ZAy8mGbaQ5NkcOEuQL4BTX+o7gtWIm3oQ2hlWhecaFQUo
         EYGBtN4hxwvJngrXepoEZ1K0NlrPZqSlDjM7fGRHOnsD/m5oubLSEz4CYoUpo+WbVfpr
         9joQ==
X-Gm-Message-State: AC+VfDwJ0w2IBI0hs7Y9ABzyCFt8tetkRrNJsrQZwNBgvFIiVqoSlDst
        4n1upSq6Szxe+8nmrPJ7vFZvpJuLumgs+op/0hqjlA==
X-Google-Smtp-Source: ACHHUZ4msTYDsVRwVxD74zod2Lb7ncBEh9BDQyd221RWNR/YdKHP6jYPWV/UlShu30Tpb9hapU4Y2K4CtbDMbW5NBUM=
X-Received: by 2002:ac2:51a2:0:b0:4f4:d41b:f416 with SMTP id
 f2-20020ac251a2000000b004f4d41bf416mr2067501lfk.4.1685519914228; Wed, 31 May
 2023 00:58:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230530083911.1104336-1-glider@google.com> <168548824525.1351231.6995242566921339574.b4-ty@chromium.org>
In-Reply-To: <168548824525.1351231.6995242566921339574.b4-ty@chromium.org>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 31 May 2023 09:57:57 +0200
Message-ID: <CAG_fn=VOsPw=EqN=P3zPfDyD=ZKYtzUVZ=y42HcqrY2hznx6Ug@mail.gmail.com>
Subject: Re: [PATCH v2] string: use __builtin_memcpy() in strlcpy/strlcat
To:     Kees Cook <keescook@chromium.org>
Cc:     andy@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        nathan@kernel.org, dvyukov@google.com, elver@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com, ndesaulniers@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, May 31, 2023 at 1:10=E2=80=AFAM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Tue, 30 May 2023 10:39:11 +0200, Alexander Potapenko wrote:
> > lib/string.c is built with -ffreestanding, which prevents the compiler
> > from replacing certain functions with calls to their library versions.
> >
> > On the other hand, this also prevents Clang and GCC from instrumenting
> > calls to memcpy() when building with KASAN, KCSAN or KMSAN:
> >  - KASAN normally replaces memcpy() with __asan_memcpy() with the
> >    additional cc-param,asan-kernel-mem-intrinsic-prefix=3D1;
> >  - KCSAN and KMSAN replace memcpy() with __tsan_memcpy() and
> >    __msan_memcpy() by default.
> >
> > [...]
>
> Applied to for-next/hardening, thanks!
>
> [1/1] string: use __builtin_memcpy() in strlcpy/strlcat
>       https://git.kernel.org/kees/c/cfe93c8c9a7a

Note that Andrew also picked it to mm-unstable
