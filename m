Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDFD7743F32
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 17:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbjF3Ptz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 11:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232816AbjF3Ptn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 11:49:43 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3547A3C06
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 08:49:41 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-401f4408955so261121cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 08:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688140180; x=1690732180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ypApT2hRzaMD7zWDLfvFjlKKtvQJ4OYbQ8ZXF60dCvY=;
        b=EDUEu7W2r/7Fb6WRCuA7Q+7DxOQvO0t/y3dQETd58nysuk5gqNeelrxH/ugdRXV04b
         tugJhKUkg/6BUOt3oTh05bjX9ThbnlARx8X2mDNn6kgDBGWuuW3574AH/C4syw2FCc8e
         vmcsntztGUM16oFvJrnWAmz3DAMzosvdi3JWeoTvaMYgvMUCLv2KrNIuimYQnwMxvd14
         psu6q9z/Dq9viB+g1fiYAeFw06xQsLGA4zFmFDgvu2QcvBq++Qdv+nIikMrZs1oy4hde
         qAr2lHXOqG64ZTDU1o5/0yIiArbU/ZGuJsDYFtj5CuQHCoUsbGl7QPw2freudY41wCX2
         X0+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688140180; x=1690732180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ypApT2hRzaMD7zWDLfvFjlKKtvQJ4OYbQ8ZXF60dCvY=;
        b=MaI/hNRoBUqLx86oJnzTAXllp0in+sths80+i7LCA9oSiO94xj4WzrN4d6A+nqOlW9
         5c6LQRiKwSm0qVhSC8jTIsg8jK69xC9O0t3fpffuLtgFmJh6xkrudv8BQSbq25tiZ7j3
         QafQ+3Im8M3CNrAiSAYEF+yZi+A71G3x3ETUymy+f6lZC2/eMkKCOD6EoasDyx6iXwLr
         7/W68XQ6LTOemhhfFs6EPrH7ccah3v5KMRPKqjshPaDxFzrsdKf9231xiREQKCKlliZ0
         eKgkToB0x4rtgMtwiAYyl2TZj2U1xPXzsD4C0gQJpVExhR3kMS91RqjFlwWAWr0B6YOo
         Q9Pw==
X-Gm-Message-State: AC+VfDwAjNeZ12TGPuVC9CyvJ++cjumBB01HNzHMPuwHZU+mL4XAjzb1
        JcS5Xze3XnrI8EUj1D4kYwTvk+ipuNWp6P/QsKTioA==
X-Google-Smtp-Source: ACHHUZ41SYhbUvQSgTzG7vzBDKRiAe4qvoligE7YxGQl/rgoZByrQQPolfBYjnEPkW89+LxYTonPVVxd+YnNym5UXFk=
X-Received: by 2002:ac8:7f0a:0:b0:3f7:ff4a:eae5 with SMTP id
 f10-20020ac87f0a000000b003f7ff4aeae5mr891493qtk.12.1688140180231; Fri, 30 Jun
 2023 08:49:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230630153840.858668-1-james.clark@arm.com>
In-Reply-To: <20230630153840.858668-1-james.clark@arm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 30 Jun 2023 08:49:28 -0700
Message-ID: <CAP-5=fWMu7g9DWbBatbACV0VmThKNLLg0=Uff-oH48XEsrpJ3g@mail.gmail.com>
Subject: Re: [PATCH] perf symbol: Fix uninitialized return value in symbols__find_by_name()
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org
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

On Fri, Jun 30, 2023 at 8:39=E2=80=AFAM James Clark <james.clark@arm.com> w=
rote:
>
> found_idx and s aren't initialized, so if no symbol is found then the
> assert at the end will index off the end of the array causing a
> segfault. The function also doesn't return NULL when the symbol isn't
> found even if the assert passes. Fix it by initializing the values and
> only setting them when something is found.
>
> Fixes the following test failure:
>
>   $ perf test 1
>   1: vmlinux symtab matches kallsyms     : FAILED!
>
> Fixes: 259dce914e93 ("perf symbol: Remove symbol_name_rb_node")
> Signed-off-by: James Clark <james.clark@arm.com>

Thanks, and thanks for the Fixes.

Acked-by: Ian Rogers <irogers@google.com>

> ---
>  tools/perf/util/symbol.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index bc79291b9f3b..f849f9ef68e6 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -495,7 +495,10 @@ static struct symbol *symbols__find_by_name(struct s=
ymbol *symbols[],
>                                             size_t *found_idx)
>  {
>         size_t i, lower =3D 0, upper =3D symbols_len;
> -       struct symbol *s;
> +       struct symbol *s =3D NULL;
> +
> +       if (found_idx)
> +               *found_idx =3D SIZE_MAX;
>
>         if (!symbols_len)
>                 return NULL;
> @@ -504,8 +507,7 @@ static struct symbol *symbols__find_by_name(struct sy=
mbol *symbols[],
>                 int cmp;
>
>                 i =3D (lower + upper) / 2;
> -               s =3D symbols[i];
> -               cmp =3D symbol__match_symbol_name(s->name, name, includes=
);
> +               cmp =3D symbol__match_symbol_name(symbols[i]->name, name,=
 includes);
>
>                 if (cmp > 0)
>                         upper =3D i;
> @@ -514,10 +516,11 @@ static struct symbol *symbols__find_by_name(struct =
symbol *symbols[],
>                 else {
>                         if (found_idx)
>                                 *found_idx =3D i;
> +                       s =3D symbols[i];
>                         break;
>                 }
>         }
> -       if (includes !=3D SYMBOL_TAG_INCLUDE__DEFAULT_ONLY) {
> +       if (s && includes !=3D SYMBOL_TAG_INCLUDE__DEFAULT_ONLY) {
>                 /* return first symbol that has same name (if any) */
>                 for (; i > 0; i--) {
>                         struct symbol *tmp =3D symbols[i - 1];
> @@ -525,13 +528,12 @@ static struct symbol *symbols__find_by_name(struct =
symbol *symbols[],
>                         if (!arch__compare_symbol_names(tmp->name, s->nam=
e)) {
>                                 if (found_idx)
>                                         *found_idx =3D i - 1;
> +                               s =3D tmp;
>                         } else
>                                 break;
> -
> -                       s =3D tmp;
>                 }
>         }
> -       assert(!found_idx || s =3D=3D symbols[*found_idx]);
> +       assert(!found_idx || !s || s =3D=3D symbols[*found_idx]);
>         return s;
>  }
>
> --
> 2.34.1
>
