Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5836DB646
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 00:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbjDGWAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 18:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbjDGWAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 18:00:49 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057697DA9
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 15:00:48 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id ji2so1429134plb.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 15:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680904847; x=1683496847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uv3+/FcAlGbbBCIx4A9TsIAc0Dqtqlhpt96UpJ0Kojk=;
        b=CxoTg1pCdseNoKoVXH22p6uGJwz/TXY7TXMqG/bVWcA4Lc9LdHfP0CmXYfJEKGal1o
         5VD1UVmcV3YlmZCZyZ2nHY242rOOAkzrJjpmS7lB5/RQRgBf4u+xbm6HHILq+pKb0YSX
         UU66Tlc+m/WI1OeJXqm6+OM/GKTiwGhPFyTaa6o9JJftptHlYDW4c2n3BH1yWXtEDzxK
         JIccT7mIjvk2CJ1yIpHf3dKEKGbfh1om16rSCT3IhOoLN/x62/OCZdlTktfRgUyq0nrN
         UFmOMRabZemFTIh+irFo0pOZNjn5lx9X8W4/sBYNWd+LwWvtfVGQjv8kS23ZWPLJQBgx
         kHWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680904847; x=1683496847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uv3+/FcAlGbbBCIx4A9TsIAc0Dqtqlhpt96UpJ0Kojk=;
        b=VKRvGqT2XIOAkHwh/aWkA54TQRlvBqL8nQ7Np8gxv5ZNlNjebFL7reI16EOZy+M8zL
         iYDtZCL5IYxxufZrZZjEzs3HZLbuCKW6fQXHjzLHXRfS+4l7JQQQsRPz0whX5PP/An3n
         Ld+wFt6f/pkI0yBlC4NWD295Pj8pEgtqhX+brAXva/7w4tef+3xIUYqNA0+svb9shjN8
         pD+w1iIxskd1qN1iFAMcYNkD3S1M2URGqykvfdT86LHVOlvgmh0Rk0EnwbP6nAW8vTG4
         8CoLD1YgrOxEsESQe0JW+XsGLfAAyKibi0c75XoGnhIynu+ojiCum5ZjLRKQAannf8+d
         8+Zg==
X-Gm-Message-State: AAQBX9fyg5J4V2TKaRCn59ja5Pk19ejw1+ZeucMoz3jontR7ItR2QbOG
        GMccp/0ZK2L3oFLkB7uyBHGJxWzkz+TsBVoyH9uvzg==
X-Google-Smtp-Source: AKy350bHoqfSfuy42Ml7tM84z4MtgDwskIQCcyEcgsj17HCmjzQqaKZzjCii+dXKYUUzhy87mi9tkdu+Vtq/WICJdtI=
X-Received: by 2002:a17:90a:cc01:b0:244:9909:6e60 with SMTP id
 b1-20020a17090acc0100b0024499096e60mr915183pju.3.1680904847203; Fri, 07 Apr
 2023 15:00:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230405022356.gonna.338-kees@kernel.org>
In-Reply-To: <20230405022356.gonna.338-kees@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 7 Apr 2023 15:00:35 -0700
Message-ID: <CAKwvOdkeQa7xOJUZnUYu4v1wmM54z=y0yPzGKfVofr2Fh27A3A@mail.gmail.com>
Subject: Re: [PATCH v2] ubsan: Tighten UBSAN_BOUNDS on GCC
To:     Kees Cook <keescook@chromium.org>
Cc:     Marco Elver <elver@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev, Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 4, 2023 at 7:24=E2=80=AFPM Kees Cook <keescook@chromium.org> wr=
ote:
>
> The use of -fsanitize=3Dbounds on GCC will ignore some trailing arrays,
> leaving a gap in coverage. Switch to using -fsanitize=3Dbounds-strict to
> match Clang's stricter behavior.
>
> Cc: Marco Elver <elver@google.com>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Nicolas Schier <nicolas@fjasle.eu>
> Cc: Tom Rix <trix@redhat.com>
> Cc: Josh Poimboeuf <jpoimboe@kernel.org>
> Cc: Miroslav Benes <mbenes@suse.cz>
> Cc: linux-kbuild@vger.kernel.org
> Cc: llvm@lists.linux.dev
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> v2: improve help text (nathan)
> v1: https://lore.kernel.org/lkml/20230302225444.never.053-kees@kernel.org=
/
> ---
>  lib/Kconfig.ubsan      | 56 +++++++++++++++++++++++-------------------
>  scripts/Makefile.ubsan |  2 +-
>  2 files changed, 32 insertions(+), 26 deletions(-)
>
> diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
> index fd15230a703b..65d8bbcba438 100644
> --- a/lib/Kconfig.ubsan
> +++ b/lib/Kconfig.ubsan
> @@ -27,16 +27,29 @@ config UBSAN_TRAP
>           the system. For some system builders this is an acceptable
>           trade-off.
>
> -config CC_HAS_UBSAN_BOUNDS
> -       def_bool $(cc-option,-fsanitize=3Dbounds)
> +config CC_HAS_UBSAN_BOUNDS_STRICT
> +       def_bool $(cc-option,-fsanitize=3Dbounds-strict)
> +       help
> +         The -fsanitize=3Dbounds-strict option is only available on GCC,
> +         but uses the more strict handling of arrays that includes knowl=
edge
> +         of flexible arrays, which is comparable to Clang's regular
> +         -fsanitize=3Dbounds.
>
>  config CC_HAS_UBSAN_ARRAY_BOUNDS
>         def_bool $(cc-option,-fsanitize=3Darray-bounds)
> +       help
> +         Under Clang, the -fsanitize=3Dbounds option is actually compose=
d
> +         of two more specific options, -fsanitize=3Darray-bounds and

Heh, that was literally the latest blog post I was working on...2
weeks ago? WIP.

Would it make sense to use CC_IS_CLANG (as in lib/Kconfig.k{a|c}san)
and CC_IS_GCC in addition to the cc-option tests, since the help texts
make it clear there's compiler specific differences here?

I've also sent
https://lore.kernel.org/llvm/20230407215406.768464-1-ndesaulniers@google.co=
m/
while looking at this patch.  Maybe more cc-option tests are no longer
necessary at this point, but I haven't checked the rest.

> +         -fsanitize=3Dlocal-bounds. However, -fsanitize=3Dlocal-bounds c=
an
> +         only be used when trap mode is enabled. (See also the help for
> +         CONFIG_LOCAL_BOUNDS.) Explicitly check for -fsanitize=3Darray-b=
ounds
> +         so that we can build up the options needed for UBSAN_BOUNDS
> +         with or without UBSAN_TRAP.
>
>  config UBSAN_BOUNDS
>         bool "Perform array index bounds checking"
>         default UBSAN
> -       depends on CC_HAS_UBSAN_ARRAY_BOUNDS || CC_HAS_UBSAN_BOUNDS
> +       depends on CC_HAS_UBSAN_ARRAY_BOUNDS || CC_HAS_UBSAN_BOUNDS_STRIC=
T
>         help
>           This option enables detection of directly indexed out of bounds
>           array accesses, where the array size is known at compile time.
> @@ -44,33 +57,26 @@ config UBSAN_BOUNDS
>           to the {str,mem}*cpy() family of functions (that is addressed
>           by CONFIG_FORTIFY_SOURCE).
>
> -config UBSAN_ONLY_BOUNDS
> -       def_bool CC_HAS_UBSAN_BOUNDS && !CC_HAS_UBSAN_ARRAY_BOUNDS
> -       depends on UBSAN_BOUNDS
> +config UBSAN_BOUNDS_STRICT
> +       def_bool UBSAN_BOUNDS && CC_HAS_UBSAN_BOUNDS_STRICT
>         help
> -         This is a weird case: Clang's -fsanitize=3Dbounds includes
> -         -fsanitize=3Dlocal-bounds, but it's trapping-only, so for
> -         Clang, we must use -fsanitize=3Darray-bounds when we want
> -         traditional array bounds checking enabled. For GCC, we
> -         want -fsanitize=3Dbounds.
> +         GCC's bounds sanitizer. This option is used to select the
> +         correct options in Makefile.ubsan.
>
>  config UBSAN_ARRAY_BOUNDS
> -       def_bool CC_HAS_UBSAN_ARRAY_BOUNDS
> -       depends on UBSAN_BOUNDS
> +       def_bool UBSAN_BOUNDS && CC_HAS_UBSAN_ARRAY_BOUNDS
> +       help
> +         Clang's array bounds sanitizer. This option is used to select
> +         the correct options in Makefile.ubsan.
>
>  config UBSAN_LOCAL_BOUNDS
> -       bool "Perform array local bounds checking"
> -       depends on UBSAN_TRAP
> -       depends on $(cc-option,-fsanitize=3Dlocal-bounds)
> -       help
> -         This option enables -fsanitize=3Dlocal-bounds which traps when =
an
> -         exception/error is detected. Therefore, it may only be enabled
> -         with CONFIG_UBSAN_TRAP.
> -
> -         Enabling this option detects errors due to accesses through a
> -         pointer that is derived from an object of a statically-known si=
ze,
> -         where an added offset (which may not be known statically) is
> -         out-of-bounds.
> +       def_bool UBSAN_ARRAY_BOUNDS && UBSAN_TRAP
> +       help
> +         This option enables Clang's -fsanitize=3Dlocal-bounds which tra=
ps
> +         when an access through a pointer that is derived from an object
> +         of a statically-known size, where an added offset (which may no=
t
> +         be known statically) is out-of-bounds. Since this option is
> +         trap-only, it depends on CONFIG_UBSAN_TRAP.
>
>  config UBSAN_SHIFT
>         bool "Perform checking for bit-shift overflows"
> diff --git a/scripts/Makefile.ubsan b/scripts/Makefile.ubsan
> index 7099c603ff0a..4749865c1b2c 100644
> --- a/scripts/Makefile.ubsan
> +++ b/scripts/Makefile.ubsan
> @@ -2,7 +2,7 @@
>
>  # Enable available and selected UBSAN features.
>  ubsan-cflags-$(CONFIG_UBSAN_ALIGNMENT)         +=3D -fsanitize=3Dalignme=
nt
> -ubsan-cflags-$(CONFIG_UBSAN_ONLY_BOUNDS)       +=3D -fsanitize=3Dbounds
> +ubsan-cflags-$(CONFIG_UBSAN_BOUNDS_STRICT)     +=3D -fsanitize=3Dbounds-=
strict
>  ubsan-cflags-$(CONFIG_UBSAN_ARRAY_BOUNDS)      +=3D -fsanitize=3Darray-b=
ounds
>  ubsan-cflags-$(CONFIG_UBSAN_LOCAL_BOUNDS)      +=3D -fsanitize=3Dlocal-b=
ounds
>  ubsan-cflags-$(CONFIG_UBSAN_SHIFT)             +=3D -fsanitize=3Dshift
> --
> 2.34.1
>


--=20
Thanks,
~Nick Desaulniers
