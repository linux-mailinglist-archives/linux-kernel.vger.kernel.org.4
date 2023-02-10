Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 374256927A2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 21:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbjBJUHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 15:07:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233555AbjBJUHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 15:07:52 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C286749AD
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 12:07:51 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-4a263c4ddbaso83365657b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 12:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=541R7X11Cy7AiuNbaDBckfxjLzUeKrAJruA5EVPMTQQ=;
        b=hOWYki28ryvOUXUZ/hFXOJd1WEjvUxxka8fJZVK7Vqhg1G8crj5f6xChzdLCRRxiNa
         I+qq35Q2lsK21Tl8k2XxE+r8x0HwlzSsRPRlZilCR6JTdwUa9cQgxYS9DBKYzzD9bb4T
         naCKm3F0c4XfJJrSHmgDqDHyCpSKFcIKNs1J5/EXT3MMFkBe/U4MJAtKhAbRUOvTCswi
         SLwcCr3q8OSSHKCKPWhjnLBdpVv5a9J7bgZvespitNTL+K5QpE1dsyEbn1gmnAi1zVaY
         VziPrLiVc7y/ZlNw0jz5fh1SmMyY//jKD6wXr6VMB+WKRbBg1GKuz9jQFAbVrGJ+1TC+
         MfyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=541R7X11Cy7AiuNbaDBckfxjLzUeKrAJruA5EVPMTQQ=;
        b=Y09OgxPXPJCj7BUZL3uqNZy7dqtZ6MzCgmQ0brWn2zlp3O+/bxyoMO+O9hBBi7rYGn
         xDkBhY+74JV+bUh/sp1UCSlOjaKJHQucDDtRAgFgSF3qsSARy2LTUPAi4HwVZT94cKfM
         vQ0pCux7PSVwLjpLG/b2+i5YMo2O3v5aywBtmo2b0mS/hirwQHzIhFcIu6urVHoaH3dK
         0iIgoGvlFX933O8OgbIyMkT70Zsf3tnwXuvawFd00bjz9TD07CX4R1vPVMZDjGPeTOa/
         ION3UtQOcJAoHVfUP/sBOpNWK+KgClMWSGv+RFdVZhvKf6NzFzeXaiwU+kxwzrZqMTx9
         XIKQ==
X-Gm-Message-State: AO0yUKVdSuaWXlw6WgsUB+tejmCmpKzpNs3Hz954SHgpv9Tn58cIbzsP
        daRXdt/j4FVNpJwVp+BJHT1oL+uReco1l1iO2rgmbQ==
X-Google-Smtp-Source: AK7set8iV8xt2HSvCwQI95K8KwUzewzFYe+DleZq6DnhxlKs9eaGXKm7jTifQcV/qN+YliFhvwT6LgHRli/KJKorl6k=
X-Received: by 2002:a81:7dc6:0:b0:52a:1bac:b96d with SMTP id
 y189-20020a817dc6000000b0052a1bacb96dmr1660623ywc.349.1676059670297; Fri, 10
 Feb 2023 12:07:50 -0800 (PST)
MIME-Version: 1.0
References: <20230208184203.2260394-1-elver@google.com> <Y+aaDP32wrsd8GZq@tucnak>
In-Reply-To: <Y+aaDP32wrsd8GZq@tucnak>
From:   Marco Elver <elver@google.com>
Date:   Fri, 10 Feb 2023 21:07:14 +0100
Message-ID: <CANpmjNO3w9h=QLQ9NRf0QZoR86S7aqJrnAEQ3i2L0L3axALzmw@mail.gmail.com>
Subject: Re: [PATCH -tip] kasan: Emit different calls for instrumentable memintrinsics
To:     Jakub Jelinek <jakub@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kbuild@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-toolchains@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Feb 2023 at 20:25, Jakub Jelinek <jakub@redhat.com> wrote:
>
> On Wed, Feb 08, 2023 at 07:42:03PM +0100, Marco Elver wrote:
> > Clang 15 will provide an option to prefix calls to memcpy/memset/memmove
> > with __asan_ in instrumented functions: https://reviews.llvm.org/D122724
> >
> > GCC does not yet have similar support.
>
> GCC has support to rename memcpy/memset etc. for years, say on
> following compiled with
> -fsanitize=kernel-address -O2 -mstringop-strategy=libcall
> (the last option just to make sure the compiler doesn't prefer to emit
> rep mov*/stos* or loop or something similar, of course kernel can keep
> whatever it uses) you'll get just __asan_memcpy/__asan_memset calls,
> no memcpy/memset, while without -fsanitize=kernel-address you get
> normally memcpy/memset.

> Or do you need the __asan_* functions only in asan instrumented functions
> and normal ones in non-instrumented functions in the same TU?

Yes, exactly that: __asan_ in instrumented, and normal ones in
no_sanitize functions; they can be mixed in the same TU. We can't
rename normal mem*() functions everywhere. In no_sanitize functions
(in particular noinstr), normal mem*() should be used. But in
instrumented code, it should be __asan_mem*(). Another longer
explanation I also just replied here:
https://lore.kernel.org/all/CANpmjNNH-O+38U6zRWJUCU-eJTfMhUosy==GWEOn1vcu=J2dcw@mail.gmail.com/

At least clang has had this behaviour for user space ASan forever:
https://godbolt.org/z/h5sWExzef - so it was easy to just add the flag
to make it behave like in user space for mem*() in the kernel. It
might also be worthwhile for GCC to emit __asan_ for user space, given
that the runtimes are shared and the user space runtime definitely has
__asan_. The kernel needs the param (asan-kernel-mem-intrinsic-prefix)
though, to not break older kernels.

Thanks,
-- Marco
