Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDD76D9853
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 15:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238130AbjDFNdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 09:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237171AbjDFNdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 09:33:00 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A768B93E4;
        Thu,  6 Apr 2023 06:32:52 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-536af432ee5so740419607b3.0;
        Thu, 06 Apr 2023 06:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680787971; x=1683379971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8GHSx+N8dU3EBkDSNQMUy0v9E7wtAUYHQ9r3K57DJLA=;
        b=DsBRi40CKlV7/aNO9KGEHjd/76bhFdgnZD576CS2G9JwrT7HVWBKl36yaGnX0nmY7L
         u3QucvZ2o5lu9YH9auRjF5RBzROO/5R9Ud/if4iNGQFmu9gQyQLGA2Pu/KtIAU4be74f
         XlIAkX0dGZGxAcB8xG4+SJ/G6oVjdqAiteSRXCAmBNrhgUegbn0j7JFiI1Vz+sr0sqwi
         U3KQaikFmutuM3wR53YxBvLou5MvcLfmLa5EmSF7MdXo9XZnfTLWq06GJgmEMDmqE0cC
         naqorm1D78n6qwHrsTfWo25bTqB3ev398e6LGtfkxCqIZODNTe3YZweklRJOnNHF+6no
         H0Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680787971; x=1683379971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8GHSx+N8dU3EBkDSNQMUy0v9E7wtAUYHQ9r3K57DJLA=;
        b=ORdwG/d/VIEaRO41yp7xh8e7ytu8yMb91gPxjFlpgM86k9R9CBWtPirBqeHe0XApX4
         d1iewYGU24aZVH+nScCGHDqEzXrR11kxw7a6jaJf8mI2itRYjNJwPWEPf7L6ai4AJ6E0
         CvCQlj2IP+7cH1j9Pf6kwx7kB2sD61K0IuIwUTZ/SJTu5XgDMdQ+EGsVRmv3rbnIFdh+
         4QZGna8DhuEF+l+x7GdE9Pp59fAQ+u2JXa5iAwqsbfwAgizxShp4HKNvg/0deVTSKjlF
         KJB0pbmUxxTYPqPM5yP2M1pYuftH+0XlQYN7MkzTv8lsDoqN6F6Ve9767raSRNJPW7UG
         LnDg==
X-Gm-Message-State: AAQBX9dS1J1MqoRR4S6tr5qhE2KBYLp9MnSNT2GzQdpBG2n8std3PQns
        hZaUIXqNHLO14MHtVBAaMk5l7BO4H8DJKyJ2eaU=
X-Google-Smtp-Source: AKy350bwE3GK78p1Z0LxwIffWANmDZ0yDm05v1Sowh2dYYe6vSHaFKpr4e0+yYM8NblaW32OK0llR0E6eN8PG4Dn8bk=
X-Received: by 2002:a81:b245:0:b0:533:8f19:4576 with SMTP id
 q66-20020a81b245000000b005338f194576mr5967901ywh.0.1680787971647; Thu, 06 Apr
 2023 06:32:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230405235832.never.487-kees@kernel.org> <20230406000212.3442647-4-keescook@chromium.org>
In-Reply-To: <20230406000212.3442647-4-keescook@chromium.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 6 Apr 2023 15:32:40 +0200
Message-ID: <CANiq72nku=HWzOXgZkbjpC7ii=_SwJj0N+GnXoa=dgcpxR=MVg@mail.gmail.com>
Subject: Re: [PATCH 4/9] fortify: Add protection for strlcat()
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-hardening@vger.kernel.org, Kees Cook <kees@outflux.net>,
        Andy Shevchenko <andy@kernel.org>,
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

On Thu, Apr 6, 2023 at 2:02=E2=80=AFAM Kees Cook <keescook@chromium.org> wr=
ote:
>
> +       size_t p_size =3D __member_size(p);
> +       size_t q_size =3D __member_size(q);

Since I noticed the patches appear to go for const-correctness even
for parameters (which is great, I support it), these could be `const`
too.

Cheers,
Miguel
