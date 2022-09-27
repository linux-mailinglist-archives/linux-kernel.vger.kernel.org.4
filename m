Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419D05EC9E5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 18:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbiI0QqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 12:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233093AbiI0Qph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 12:45:37 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17E61C430
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 09:45:30 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id w2so10237067pfb.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 09:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=ghIr72d2MFWvVwzY3IxpJDMS5fyhMuvWUPUhopPN/qk=;
        b=K48GzDxdHhXcap5UllwByJj0tI7kwKfo9xjWBjGAHwE5rdcf9RcSbdsQfKAwyhHc7N
         o4P8EyCHs8tKNMTikv/JzA9qUP9dYc49/+OSdohoV4ceYj2l82iv5RLw4hxz4877Qtxi
         hZnpBGv7DyN1hlKa2RbKrC1zGiLQyOxO2pNfNh8BfexgGU/po7eZA9sZY18TSzNHNlkJ
         chr/K0WNdWeoDHzAZWRcwj5/ppCKpgZtCalznQKf7LLqa7c19cBf4wosicUeGoVcNfDJ
         GnaP5a5XS9iXSDcGeexRAa+IjyGQLWV89KCZnbZOWGWgBRQYczARFSjMOtEnvt3BS8rv
         UD/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ghIr72d2MFWvVwzY3IxpJDMS5fyhMuvWUPUhopPN/qk=;
        b=FDB5ryOeEa4/Derphi4WZj6UjCTBtPjrQHHsAr+GWP0ar4hV+a1NsgpGq4JAI8WV3V
         WIDblSCdyEjW0r4svNTYIjQ24wwxaQFGr1nOeLXuJErw3XX/1gfySP2COwFc1cQvCJlX
         PgNbJ21GAYou2JAoKNhqoaK5hM5pBPxABD0mcYiq8iqGZATbiYCGgLzgTmttnCVvBJ3e
         9exT8czz6g0wXFDrZK6xl6m3ybQJr4hSJtZ9sOtnE3Vvf/vwBnJw02MrffflXo+Oj9sr
         R5Oa61fXND9GRPqid+6b8iU3aP81XFRdNwUi4GO6n8SolIJFs0nyQQiQn/a/fgksN4eM
         r8jg==
X-Gm-Message-State: ACrzQf1EcvgsXAFdoNuc1wkyYGeyhUerWli2+QKYHDm84ffz8QV2Z343
        BLGPYiZBKZzx/bg771J8NPVN0o/v+tGAQOhKdMqOaw==
X-Google-Smtp-Source: AMsMyM43m6tgs4G5qKkkxE77ZyJQmNDRdrfNh2BPt8T8lYzbrTNppaqkTELd+catwTn4ZNL8SRmR5P3qzcrLknIA/xI=
X-Received: by 2002:a63:e709:0:b0:438:98e8:d1c with SMTP id
 b9-20020a63e709000000b0043898e80d1cmr25730430pgi.403.1664297129249; Tue, 27
 Sep 2022 09:45:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220927153125.811911-1-zengheng4@huawei.com>
In-Reply-To: <20220927153125.811911-1-zengheng4@huawei.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 27 Sep 2022 09:45:17 -0700
Message-ID: <CAKwvOdm2r_PPogCecGL4TMeYLq3qNkCbt7zqYTLmQf-PAQMGMg@mail.gmail.com>
Subject: Re: [PATCH -next] Makefile: add implicit enum-conversion check for
 compile build
To:     Zeng Heng <zengheng4@huawei.com>
Cc:     masahiroy@kernel.org, michal.lkml@markovi.net,
        akpm@linux-foundation.org, peterz@infradead.org,
        keescook@chromium.org, davidgow@google.com, nathan@kernel.org,
        jpoimboe@kernel.org, dan.j.williams@intel.com, ojeda@kernel.org,
        isabbasso@riseup.net, dmitrii.bundin.a@gmail.com, vbabka@suse.cz,
        linux@rasmusvillemoes.dk, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, liwei391@huawei.com,
        weiyongjun1@huawei.com, clang-built-linux <llvm@lists.linux.dev>,
        linux-toolchains <linux-toolchains@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Sep 27, 2022 at 8:15 AM Zeng Heng <zengheng4@huawei.com> wrote:
>
> Provide implicit enum-conversion warning option
> in general build. When it set enabled, it can
> detect implicit enum type conversion and find
> potential conversion errors like below
> (use "allmodconfig"):
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn20/display_mode_vba_20.c:=
3904:46:
> error: implicit conversion from =E2=80=98enum <anonymous>=E2=80=99 to =E2=
=80=98enum odm_combine_mode=E2=80=99 [-Werror=3Denum-conversion]
>  3904 |       locals->ODMCombineEnablePerState[i][k] =3D true;
>       |                                              ^
>
> The '-Wenum-conversion' could be regarded as
> effective check on compile runtime and
> call attention on potential mistakes.
>
> Anothor practical example could be referred to:
> https://lore.kernel.org/all/CADnq5_OE0yZvEYGu82QJHL9wvVcTFZrmeTgX7URgh7FV=
A=3DjqYg@mail.gmail.com
>
> "-Wenum-conversion" was firstly introduced from
> GNU gcc-10.

What about clang? ;)

>
> Although "-Wenum-conversion" could be enabled
> by "-Wextra" when compiling with 'W=3D1' option,
> there are many warnings generated by '-Wextra'
> that cause too much noise in a build.

With clang, I believe that -Wenum-conversion is part of -Wall or
-Wextra; so enabling this explicitly is only necessary for GCC.  I
wonder why it's not part of -Wall or -Wextra for GCC?  Perhaps worth a
bug report/feature request?

>
> Seeing the details from the following link:
> https://gcc.gnu.org/onlinedocs/gcc-11.3.0/gcc/Warning-Options.html
>
> Because there are still some concerned warnings
> exist, the patch marks the option disabled in default
> for avoiding compile failed like using "allmodconfig".
>
> Signed-off-by: Zeng Heng <zengheng4@huawei.com>
> ---
>  Makefile          | 5 +++++
>  lib/Kconfig.debug | 7 +++++++
>  2 files changed, 12 insertions(+)
>
> diff --git a/Makefile b/Makefile
> index ebd48fc956a3..1790a3624358 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -880,6 +880,11 @@ endif
>  KBUILD_CFLAGS +=3D $(call cc-disable-warning, unused-but-set-variable)
>  KBUILD_CFLAGS +=3D $(call cc-disable-warning, unused-const-variable)
>
> +# check implicit enum conversion
> +ifdef CONFIG_ENUM_CONVERSION
> +KBUILD_CFLAGS +=3D -Wenum-conversion
> +endif

Having a kconfig for this is overkill.  cc-option with a comment about
the compiler default versions is the way to go.

> +
>  # These result in bogus false positives
>  KBUILD_CFLAGS +=3D $(call cc-disable-warning, dangling-pointer)
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 4f2b81229a2f..a64e06a747d8 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -417,6 +417,13 @@ config FRAME_WARN
>           Setting this too low will cause a lot of warnings.
>           Setting it to 0 disables the warning.
>
> +config ENUM_CONVERSION
> +       bool "Warn for implicit enum conversion"
> +       depends on GCC_VERSION >=3D 100300
> +       default n
> +       help
> +         Tell gcc to warn at build time for implicit enum conversion.
> +
>  config STRIP_ASM_SYMS
>         bool "Strip assembler-generated symbols during link"
>         default n
> --
> 2.25.1
>


--=20
Thanks,
~Nick Desaulniers
