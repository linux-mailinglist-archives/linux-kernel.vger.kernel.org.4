Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2566D93D6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 12:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236863AbjDFKVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 06:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233568AbjDFKVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 06:21:30 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDF13C0B;
        Thu,  6 Apr 2023 03:21:29 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id de37so12848472qkb.7;
        Thu, 06 Apr 2023 03:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680776488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hhH1P9/Ou2ivYg8M0kXj+1/xpjcKuMD6jZ1NT+hctEA=;
        b=aTI+qPFAXepvjwEnscwxUhj5toI8/5PUr62gjcnWd4MfPami4x/hzpGI06RvrW8MQS
         Yh7WVXLnj9cvCiytNjR6nzXwTr1HqURE1/i8/ISO2Wi/X+ZJ8KBwHF14/0oRqUrkovz5
         7Iy78QJqpXopC3cxs7ArZhOdlU9ewDbaoJ0BL6mS7JVfpj7TbWq9zVB0VMs908MCINAN
         ZygqrhF649J9sVPiB56UQo2RpVNphiRTgerpP/f5UH8EO5Nl+t/DTEKdqtntJlF30ZuU
         W3SdVGtRH5OcBUykpSZqa/9GhSPDrxbsRrqFco2/N0ZHXdpdRklTScXgaQWpV0qrrE41
         0G0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680776488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hhH1P9/Ou2ivYg8M0kXj+1/xpjcKuMD6jZ1NT+hctEA=;
        b=hczM4o+5CzhOzOwMe16FwW7z/Y2JKHx1A1xs5ay3fJ7C3S+STr0ppBdyO6k7VJbsc+
         ZdMMECwB1SB85OENT2upQo6eZdV4hgctV+tEbSeHEZoSCo+qT3HJDSr2Rct0Sw6SmfWs
         /10x9BLUbqZL/aACet54jIpCPnCnA37rI0vRL/RfdRHKOaUQ5cFiDCkVOAIOwU6sXywg
         Y9mjkMtr5N/mMLTpVfBlocixDrJJUrfksE6rH+45puTP1LjlsuW5ZnrWutTk/qHtnpJs
         IAaQt/ea7Vlscl2+HT23fxY0ojMx1pL5W8TRLlZ+RgLDlNHnOjRR3yV0oJdoRP5iWOL4
         cKXw==
X-Gm-Message-State: AAQBX9eyLQheBoJJzQlWzFJ6jzACjBKBoXyXFbRVLl66qMyGHL2zzxd/
        Y5b3NqqFnWt2EBsNrb3v3ntN6Ca7MTSwE4xpw9A=
X-Google-Smtp-Source: AKy350a+6ce7qoEKrdrtHeJlw/xAk3gJ0PJeZbsSqnFX5GJ+rk4EZEYEy0iQ3pnO4reJ+DZLRlMsWvVLD3RlQvJShBQ=
X-Received: by 2002:a05:620a:170f:b0:746:af25:7e8a with SMTP id
 az15-20020a05620a170f00b00746af257e8amr2065188qkb.14.1680776488314; Thu, 06
 Apr 2023 03:21:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230405235832.never.487-kees@kernel.org> <20230406000212.3442647-6-keescook@chromium.org>
In-Reply-To: <20230406000212.3442647-6-keescook@chromium.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 6 Apr 2023 13:20:52 +0300
Message-ID: <CAHp75Vf-nG865UwbVjwFjVTtXA7mAdi4FfKCpTHDx55eFnbvAA@mail.gmail.com>
Subject: Re: [PATCH 6/9] fortify: Split reporting and avoid passing string pointer
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-hardening@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Puyou Lu <puyou.lu@gmail.com>, Mark Brown <broonie@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Yury Norov <yury.norov@gmail.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Sander Vanheule <sander@svanheule.net>,
        Eric Biggers <ebiggers@google.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Latypov <dlatypov@google.com>,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 6, 2023 at 3:02=E2=80=AFAM Kees Cook <keescook@chromium.org> wr=
ote:
>
> In preparation for KUnit testing and further improvements in fortify
> failure reporting, split out the report and encode the function and
> access failure (read or write overflow) into a single int argument. This
> mainly ends up saving some space in the data segment. For a defconfig
> with FORTIFY_SOURCE enabled:
>
> $ size gcc/vmlinux.before gcc/vmlinux.after
>    text           data     bss     dec              hex filename
> 26132309        9760658 2195460 38088427        2452eeb gcc/vmlinux.befor=
e
> 26132386        9748382 2195460 38076228        244ff44 gcc/vmlinux.after

...

> +       const char *name;
> +       const bool write =3D !!(reason & 0x1);

Perhaps define that as

FORTIFY_READ_WRITE  BIT(0)
FORTIFY_FUNC_SHIFT  1

const bool write =3D reason & FORTIFY_READ_WRITE; // and note no need for !=
! part

switch (reason >> FORTIFY_FUNC_SHIFT) {

> +       switch (reason >> 1) {
> +       case FORTIFY_FUNC_strncpy:
> +               name =3D "strncpy";
> +               break;
> +       case FORTIFY_FUNC_strnlen:
> +               name =3D "strnlen";
> +               break;
> +       case FORTIFY_FUNC_strlen:
> +               name =3D "strlen";
> +               break;
> +       case FORTIFY_FUNC_strlcpy:
> +               name =3D "strlcpy";
> +               break;
> +       case FORTIFY_FUNC_strscpy:
> +               name =3D "strscpy";
> +               break;
> +       case FORTIFY_FUNC_strlcat:
> +               name =3D "strlcat";
> +               break;
> +       case FORTIFY_FUNC_strcat:
> +               name =3D "strcat";
> +               break;
> +       case FORTIFY_FUNC_strncat:
> +               name =3D "strncat";
> +               break;
> +       case FORTIFY_FUNC_memset:
> +               name =3D "memset";
> +               break;
> +       case FORTIFY_FUNC_memcpy:
> +               name =3D "memcpy";
> +               break;
> +       case FORTIFY_FUNC_memmove:
> +               name =3D "memmove";
> +               break;
> +       case FORTIFY_FUNC_memscan:
> +               name =3D "memscan";
> +               break;
> +       case FORTIFY_FUNC_memcmp:
> +               name =3D "memcmp";
> +               break;
> +       case FORTIFY_FUNC_memchr:
> +               name =3D "memchr";
> +               break;
> +       case FORTIFY_FUNC_memchr_inv:
> +               name =3D "memchr_inv";
> +               break;
> +       case FORTIFY_FUNC_kmemdup:
> +               name =3D "kmemdup";
> +               break;
> +       case FORTIFY_FUNC_strcpy:
> +               name =3D "strcpy";
> +               break;
> +       default:
> +               name =3D "unknown";
> +       }

...

> +       WARN(1, "%s: detected buffer %s overflow\n", name, write ? "write=
" : "read");

Using str_read_write() ?

Dunno if it's already there or needs to be added. I have some patches
to move those str_*() to string_choices.h. We can also prepend yours
with those.

--=20
With Best Regards,
Andy Shevchenko
