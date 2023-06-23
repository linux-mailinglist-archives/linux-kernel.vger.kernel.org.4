Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBCA073BCC9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 18:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbjFWQjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 12:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbjFWQjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 12:39:39 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FFF2D6B
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 09:39:14 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-6237faa8677so7016596d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 09:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687538354; x=1690130354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8LECLQNnPYl0y9r0xDtUgl5E87ZKIYJNhvoef1Dor0g=;
        b=dkKxv2jKnBQqAajzGXBmpV6B0eM8pL9kPs6CIVf+ThG9Iahm2kU+vQ0Fjnzn7i9vHT
         GjUC5pNMkIyqj9rtWJMxzb91fel2sBJjFqzEVLiKyVhIYA6jE5UH/dZYxxYO/A2PtIv2
         Hxp+jcSKewNrf5iuF5bOpEyTkxC3xH18HAChCnG98UD6p7dVREWfhjA/O7Ec3L8BiJDu
         vRWYe+zjzPZ0+SU/QJXJ+Lg23sFoeHdWLozBEe5gMg8s0vgYl31aoKkfmib29RE8/OL/
         9vrHrUCHluh78Smr69+sWBr0lNEnv64ao2hB5EIHKCE+asWMYAXE+cLz5VZr9CFy9CuS
         xVaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687538354; x=1690130354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8LECLQNnPYl0y9r0xDtUgl5E87ZKIYJNhvoef1Dor0g=;
        b=W8gE8NFU3FcDfvlEKBt36LjCxKOZxUJcA2ZiSKU8v8ZueA4y60Kp0VBNVSNdpmPafG
         O/mH2tjtQVZ3mUsypDyLk5IMDyEKxpjfU4XPEy0v0+5oFBWb1bXcUv9nkgOFOJE3AwLJ
         TDjitFJZdMwy7WE6SEHbLxNE4eCQr24wKrzy11mjk6PWzLVPhGloimVSgWJ1pOdv+A0u
         XPVr1Mdm7ZIpmbtmWzdMQAcDJE37OF3yRgy+Mocd/w4+UPvhUjri0Ml9S53XoPaBe6ZP
         GWPLfft6fCJ6QU6xPwGLKIKkXPiPt38z60ryIdOXGLCpH9yT4v2IDdN3/eXjnp7T7NjV
         3E9A==
X-Gm-Message-State: AC+VfDznavGfUuOwnpllYC8qyMU3WmAg/QZyKY19rm/R/BG3IViJmv2r
        Zabo2nAITqhpfhzTopAocq9ncq6g6upcLfDumuMehg==
X-Google-Smtp-Source: ACHHUZ4nTMiMdzxcp5Dyr7rUsaaeYLVLKDx8ob6RuR0oNVQa3WXS6lje+VJiQNjFDZvvFpcBUUKXRlNvWTJhRtRJ3RU=
X-Received: by 2002:ad4:5be4:0:b0:634:20f:471c with SMTP id
 k4-20020ad45be4000000b00634020f471cmr1044805qvc.14.1687538353806; Fri, 23 Jun
 2023 09:39:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230623134351.1898379-1-kernel@xen0n.name> <20230623134351.1898379-8-kernel@xen0n.name>
In-Reply-To: <20230623134351.1898379-8-kernel@xen0n.name>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 23 Jun 2023 09:39:03 -0700
Message-ID: <CAKwvOdn5e+BzhGzDPnZYEjCuanABJmu5ZZo5x2uwHj4L44m5nA@mail.gmail.com>
Subject: Re: [PATCH 7/9] LoongArch: Tweak CFLAGS for Clang compatibility
To:     WANG Xuerui <kernel@xen0n.name>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Rui <wangrui@loongson.cn>, Xi Ruoyao <xry111@xry111.site>,
        loongarch@lists.linux.dev, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        WANG Xuerui <git@xen0n.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 6:44=E2=80=AFAM WANG Xuerui <kernel@xen0n.name> wro=
te:
>
> From: WANG Xuerui <git@xen0n.name>
>
> Now the arch code is mostly ready for LLVM/Clang consumption, it is time
> to re-organize the CFLAGS a little to actually enable the LLVM build.
>
> A build with !RELOCATABLE && !MODULE is confirmed working within a QEMU
> environment; support for the two features are currently blocked by
> LLVM/Clang, and will come later.
>
> Signed-off-by: WANG Xuerui <git@xen0n.name>
> ---
>  arch/loongarch/Makefile      | 14 +++++++++++---
>  arch/loongarch/vdso/Makefile |  6 +++++-
>  2 files changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
> index a27e264bdaa5..efe9b50bd829 100644
> --- a/arch/loongarch/Makefile
> +++ b/arch/loongarch/Makefile
> @@ -46,12 +46,18 @@ ld-emul                     =3D $(64bit-emul)
>  cflags-y               +=3D -mabi=3Dlp64s
>  endif
>
> -cflags-y                       +=3D -G0 -pipe -msoft-float

This seems to drop -msoft-float for GCC. Intentional?

> -LDFLAGS_vmlinux                        +=3D -G0 -static -n -nostdlib
> +ifndef CONFIG_CC_IS_CLANG
> +cflags-y                       +=3D -G0
> +LDFLAGS_vmlinux                        +=3D -G0

Thanks for the patch!

I can understand not passing -G0 to clang if clang doesn't understand
it, but should you be using CONFIG_LD_IS_LLD for LDFLAGS?

What does -G0 do?

Is there a plan to support it in clang and lld?

If so, please file a bug in LLVM's issue tracker
https://github.com/llvm/llvm-project/issues
then link to it in a comment in this Makefile above the relevant condition.

> +endif
> +cflags-y                       +=3D -pipe
> +LDFLAGS_vmlinux                        +=3D -static -n -nostdlib
>
>  # When the assembler supports explicit relocation hint, we must use it.
>  # GCC may have -mexplicit-relocs off by default if it was built with an =
old
> -# assembler, so we force it via an option.
> +# assembler, so we force it via an option. For LLVM/Clang the desired be=
havior
> +# is the default, and the flag is not supported, so don't pass it if Cla=
ng is
> +# being used.
>  #
>  # When the assembler does not supports explicit relocation hint, we can'=
t use
>  # it.  Disable it if the compiler supports it.
> @@ -61,8 +67,10 @@ LDFLAGS_vmlinux                      +=3D -G0 -static =
-n -nostdlib
>  # combination of a "new" assembler and "old" compiler is not supported. =
 Either
>  # upgrade the compiler or downgrade the assembler.
>  ifdef CONFIG_AS_HAS_EXPLICIT_RELOCS
> +ifndef CONFIG_CC_IS_CLANG
>  cflags-y                       +=3D -mexplicit-relocs
>  KBUILD_CFLAGS_KERNEL           +=3D -mdirect-extern-access
> +endif

Why would AS_HAS_EXPLICIT_RELOCS be set if -mexplicit-relocs isn't
supported? Is the kconfig for that broken?

Does AS_HAS_EXPLICIT_RELOCS also need to test for the support for
-mdirect-extern-access or should there be a new config for that?
CC_SUPPORTS_DIRECT_EXTERN_ACCESS

>  else
>  cflags-y                       +=3D $(call cc-option,-mno-explicit-reloc=
s)
>  KBUILD_AFLAGS_KERNEL           +=3D -Wa,-mla-global-with-pcrel
> diff --git a/arch/loongarch/vdso/Makefile b/arch/loongarch/vdso/Makefile
> index 4c859a0e4754..19f6c75a1106 100644
> --- a/arch/loongarch/vdso/Makefile
> +++ b/arch/loongarch/vdso/Makefile
> @@ -25,13 +25,17 @@ endif
>  cflags-vdso :=3D $(ccflags-vdso) \
>         -isystem $(shell $(CC) -print-file-name=3Dinclude) \
>         $(filter -W%,$(filter-out -Wa$(comma)%,$(KBUILD_CFLAGS))) \
> -       -O2 -g -fno-strict-aliasing -fno-common -fno-builtin -G0 \
> +       -O2 -g -fno-strict-aliasing -fno-common -fno-builtin \
>         -fno-stack-protector -fno-jump-tables -DDISABLE_BRANCH_PROFILING =
\
>         $(call cc-option, -fno-asynchronous-unwind-tables) \
>         $(call cc-option, -fno-stack-protector)
>  aflags-vdso :=3D $(ccflags-vdso) \
>         -D__ASSEMBLY__ -Wa,-gdwarf-2
>
> +ifndef CONFIG_CC_IS_CLANG
> +cflags-vdso +=3D -G0
> +endif
> +
>  ifneq ($(c-gettimeofday-y),)
>    CFLAGS_vgettimeofday.o +=3D -include $(c-gettimeofday-y)
>  endif
> --
> 2.40.0
>
>


--=20
Thanks,
~Nick Desaulniers
