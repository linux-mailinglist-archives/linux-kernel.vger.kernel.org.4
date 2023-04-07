Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E456DB756
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 01:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjDGXmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 19:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjDGXml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 19:42:41 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40736E18D
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 16:42:40 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-517baf1bc87so25154a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 16:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680910959; x=1683502959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jopHTn8ww2PUxgk7uQ6jiARzlAliPQkQTV3+oULvbUk=;
        b=q5Tm6khTLskVetsOOzBJgVCGpkTFxmXDrKkKSs6n4di3bLCz/LHZT+AgjcWmzrp+zl
         zZIsvfBe3w8xCtOZwdriFK4Fjn+eSSPi7zpcMwOyVImSiFV6MwDY6a3m59VT/gxdF4iJ
         L20Elp89TZrlWfeBTWe+1My/8yY+8s/d/5cSUfb+IF3oLMl10EmyE6HotvB2R/HtzxmD
         8bZtoZUSmNCz+u98MjKnQUmCN29b9qW9tTRMmwkYj3peZAoDrjvYiDLu5UG7W/zAxMsu
         tYymHWX1Lcw9KCaHlgZdFQHj2L6+ZZ0BQv1qFouk39a61Kw9cpI/YQ0ux+7TG7izEv3E
         rxZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680910959; x=1683502959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jopHTn8ww2PUxgk7uQ6jiARzlAliPQkQTV3+oULvbUk=;
        b=Y9IrXgl3KeSnhx1ZzKg3bnIro3t3cgM/E2LrVhX+Vn6u+pC7lzjfdD1f32hdIXgoSL
         +h8M/M49ARIjylumvr4vcQkakRPsYZtAocBxqKh4fI91i/UCW1cNXOqpYuL8hNYgwv6s
         /g9Rmz71ipYMYubh7+ds0xWCY5G6u/xq33VZO5Gpuo1oAQvC2ZZMdSddBIsdIhsSBnKx
         Bqh0QvlUrVW3fh0JCQZTGiJL5S3W+pFhXwXVZoFz12aJrphD0iIz04stk+i/B3T3DKit
         eZcjafDpZge59Gx66Y+gUeGZ+Cu7jpo7RKbaGY6dX/JsTV9PX+FUWviRRxDWk2OO77nu
         vGOg==
X-Gm-Message-State: AAQBX9cpcTBcAlEo46wrzgC630clYZlD1dMXM8qb8bhm4ui/KkZXnYYV
        vCFeiZC8NT+WDcPiNQCNU01OCxTKlTF1NPWqwQzMfA==
X-Google-Smtp-Source: AKy350ae8GOYODNUXSN4leByoxrd0wIpXfCmTUWaycN5fMHok3ErO2LrxTuUgoIw8rw21NZWpM9hTpD4LUrSK4l6xcs=
X-Received: by 2002:a05:6a00:2e23:b0:62a:d87a:a375 with SMTP id
 fc35-20020a056a002e2300b0062ad87aa375mr1948477pfb.4.1680910959263; Fri, 07
 Apr 2023 16:42:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230407191904.gonna.522-kees@kernel.org> <20230407192717.636137-1-keescook@chromium.org>
 <CAKwvOdk5JjB21FU85Zxubs+LV8bTY-az598V1hvewndAfhohQA@mail.gmail.com>
In-Reply-To: <CAKwvOdk5JjB21FU85Zxubs+LV8bTY-az598V1hvewndAfhohQA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 7 Apr 2023 16:42:27 -0700
Message-ID: <CAKwvOd=yZw_Ju67D52GfUz39MaAFA639hOxR5Jo2dRdp+xciyQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] kunit: tool: Enable CONFIG_FORTIFY_SOURCE under UML
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
        Alexander Lobakin <aleksander.lobakin@intel.com>,
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

On Fri, Apr 7, 2023 at 4:33=E2=80=AFPM Nick Desaulniers <ndesaulniers@googl=
e.com> wrote:
>
> On Fri, Apr 7, 2023 at 12:27=E2=80=AFPM Kees Cook <keescook@chromium.org>=
 wrote:
> >
> > Since commit ba38961a069b ("um: Enable FORTIFY_SOURCE"), it's possible
> > to run the FORTIFY tests under UML. Enable CONFIG_FORTIFY_SOURCE when
> > running with --altests to gain additional coverage, and by default unde=
r
>
> two L's in alltest?

Also, while testing this series:
```
$ LLVM=3D1 ./tools/testing/kunit/kunit.py run
...
[16:40:09] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D fortify (=
24 subtests) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[16:40:09] [PASSED] known_sizes_test
[16:40:09] [PASSED] control_flow_split_test
[16:40:09] [PASSED] alloc_size_kmalloc_const_test
[16:40:09]     # alloc_size_kmalloc_dynamic_test: EXPECTATION FAILED
at lib/fortify_kunit.c:249
[16:40:09]     Expected __builtin_dynamic_object_size(p, 1) =3D=3D expected=
, but
[16:40:09]         __builtin_dynamic_object_size(p, 1) =3D=3D -1
(0xffffffffffffffff)
[16:40:09]         expected =3D=3D 11 (0xb)
[16:40:09] __alloc_size() not working with __bdos on kmemdup("hello
there", len, gfp)
[16:40:09] [FAILED] alloc_size_kmalloc_dynamic_test
[16:40:09] [PASSED] alloc_size_vmalloc_const_test
[16:40:09] [PASSED] alloc_size_vmalloc_dynamic_test
[16:40:09] [PASSED] alloc_size_kvmalloc_const_test
[16:40:09] [PASSED] alloc_size_kvmalloc_dynamic_test
[16:40:09] [PASSED] alloc_size_devm_kmalloc_const_test
[16:40:09] [PASSED] alloc_size_devm_kmalloc_dynamic_test
[16:40:09] [PASSED] strlen_test
[16:40:09] [PASSED] strnlen_test
[16:40:09] [PASSED] strcpy_test
[16:40:09] [PASSED] strncpy_test
[16:40:09] [PASSED] strlcpy_test
[16:40:09] [PASSED] strscpy_test
[16:40:09] [PASSED] strcat_test
[16:40:09] [PASSED] strncat_test
[16:40:09] [PASSED] strlcat_test
[16:40:09] [PASSED] memscan_test
[16:40:09] [PASSED] memchr_test
[16:40:09] [PASSED] memchr_inv_test
[16:40:09] [PASSED] memcmp_test
[16:40:09] [PASSED] kmemdup_test
[16:40:09] # fortify: pass:23 fail:1 skip:0 total:24
[16:40:09] # Totals: pass:23 fail:1 skip:0 total:24
[16:40:09] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =
[FAILED] fortify =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
```
It would be cool to understand that failure in BDOS BEFORE turning on
these tests by default.

>
> > UML.
> >
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  tools/testing/kunit/configs/all_tests.config | 2 ++
> >  tools/testing/kunit/configs/arch_uml.config  | 3 +++
> >  2 files changed, 5 insertions(+)
> >
> > diff --git a/tools/testing/kunit/configs/all_tests.config b/tools/testi=
ng/kunit/configs/all_tests.config
> > index f990cbb73250..0393940c706a 100644
> > --- a/tools/testing/kunit/configs/all_tests.config
> > +++ b/tools/testing/kunit/configs/all_tests.config
> > @@ -9,6 +9,8 @@ CONFIG_KUNIT=3Dy
> >  CONFIG_KUNIT_EXAMPLE_TEST=3Dy
> >  CONFIG_KUNIT_ALL_TESTS=3Dy
> >
> > +CONFIG_FORTIFY_SOURCE=3Dy
> > +
> >  CONFIG_IIO=3Dy
> >
> >  CONFIG_EXT4_FS=3Dy
> > diff --git a/tools/testing/kunit/configs/arch_uml.config b/tools/testin=
g/kunit/configs/arch_uml.config
> > index e824ce43b05a..54ad8972681a 100644
> > --- a/tools/testing/kunit/configs/arch_uml.config
> > +++ b/tools/testing/kunit/configs/arch_uml.config
> > @@ -3,3 +3,6 @@
> >  # Enable virtio/pci, as a lot of tests require it.
> >  CONFIG_VIRTIO_UML=3Dy
> >  CONFIG_UML_PCI_OVER_VIRTIO=3Dy
> > +
> > +# Enable FORTIFY_SOURCE for wider checking.
> > +CONFIG_FORTIFY_SOURCE=3Dy
> > --
> > 2.34.1
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers



--=20
Thanks,
~Nick Desaulniers
