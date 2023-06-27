Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12AF73FF14
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 16:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbjF0O5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 10:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbjF0O4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 10:56:48 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655FD3AB1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 07:56:38 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-4007b5bafceso249611cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 07:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687877797; x=1690469797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3TM4gPkedTdVt/pTzlSzdwE0vEg4nlznUvwY2aNNuRs=;
        b=E7NUhfrEQyEY6Gp+Iat84COtfdjqfAeEZe8rLxHGcwYMmKQEe99gSbud8WiDKOUdRK
         2UdyYgqvLwFkj3KqOxIJ4te35Q4ebInOy8/PTdxqH8zR7iv1tBBG5h75N6kEIRK4XnVn
         +b3u5/vqQKzsCeZAIqJbb+/csC3WtC7M73V7zM051ch287+NlogIF0gr3q15bf0R4tYV
         ryvaGEyApUkDicJHEtYGh3L2qyY4EdXwodXr3I6pVEugv8pfkpLH0cGY9UlRXg/bv48M
         DFmNHBwKR1OWx8k4xOeVpdlvO2+nskfVOtSH/2uFfRITrnDyNDscYb8W1HJf0DigL7UF
         kW4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687877797; x=1690469797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3TM4gPkedTdVt/pTzlSzdwE0vEg4nlznUvwY2aNNuRs=;
        b=Xo3lt7OYmBbwAM0AZN+fBCEsX6KpJi14ko1tmqn6XdF2DzmA+Z1QP0Hxbdoxh40hpT
         xMWlcCSf1NQfHB/8JpnKB62e02BMXJAtlN5bf8A636L/HbFPPiaCoNSViMd9DsULylRG
         Cz8vesfBkIBZSL4Zlsb6BJ7D2B0X9F7i8vlHsOdTK2tEktf/LKYMgc2ggyMqI8y5k+Pt
         YJ1AE8JH3OWuQMackIl98rDF6QQDM2NU83jEj/A+CYVvMQsC02QDKULQWcIV3v9LW0fZ
         mDPmXkzC458xcYxfJAJ7f3Sc6HwyuVssMoO3DDzs+e1yMbWCvUcthWAAt6GgsnPPbIGO
         OQyg==
X-Gm-Message-State: AC+VfDxgndz2lTdK152oTOU4dynqLlQAIqOoEJ91mzgpTbTXd4ZEKMVw
        wIRHhxo1Br48Qm/v6734nM2r3kwHKzU/gJn0LB+E8w==
X-Google-Smtp-Source: ACHHUZ5IYqJLlicyX9SgpS/5Pcme0+oNNWyA1QzsxhNgChoXWNiGq6kabuTPEBWQrr65iqSv1oZWP4VA3al8WwIFSNw=
X-Received: by 2002:a05:622a:587:b0:3f8:5b2:aeed with SMTP id
 c7-20020a05622a058700b003f805b2aeedmr202037qtb.21.1687877797330; Tue, 27 Jun
 2023 07:56:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230627063257.549005-1-namhyung@kernel.org>
In-Reply-To: <20230627063257.549005-1-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 27 Jun 2023 07:56:25 -0700
Message-ID: <CAP-5=fVGjsDEFfCXzqsDEz_dnXm635qGTLD+7L9w2qhKNr5VNA@mail.gmail.com>
Subject: Re: [PATCH] perf test: Fix a compile error on pe-file-parsing.c
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
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

On Mon, Jun 26, 2023 at 11:33=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> The dso__find_symbol_by_name() should be have idx pointer argument.
> Found during the build-test.
>
>   $ make build-test
>   ...
>     CC      /tmp/tmp.6JwPK1xbWG/tests/pe-file-parsing.o
>   tests/pe-file-parsing.c: In function =E2=80=98run_dir=E2=80=99:
>   tests/pe-file-parsing.c:64:15: error: too few arguments to function =E2=
=80=98dso__find_symbol_by_name=E2=80=99
>      64 |         sym =3D dso__find_symbol_by_name(dso, "main");
>         |               ^~~~~~~~~~~~~~~~~~~~~~~~
>   In file included from tests/pe-file-parsing.c:16:
>   /usr/local/google/home/namhyung/project/linux/tools/perf/util/symbol.h:=
135:16: note: declared here
>     135 | struct symbol *dso__find_symbol_by_name(struct dso *dso, const =
char *name, size_t *idx);
>         |                ^~~~~~~~~~~~~~~~~~~~~~~~
>
> Fixes: 259dce914e93 ("perf symbol: Remove symbol_name_rb_node")
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/Makefile.config         | 13 ++++++++++---
>  tools/perf/tests/pe-file-parsing.c |  3 ++-
>  2 files changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 78411252b72a..0609c19caabd 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -315,6 +315,9 @@ FEATURE_CHECK_LDFLAGS-libpython :=3D $(PYTHON_EMBED_L=
DOPTS)
>
>  FEATURE_CHECK_LDFLAGS-libaio =3D -lrt
>
> +FEATURE_CHECK_LDFLAGS-disassembler-four-args =3D -lbfd -lopcodes -ldl
> +FEATURE_CHECK_LDFLAGS-disassembler-init-styled =3D -lbfd -lopcodes -ldl
> +
>  CORE_CFLAGS +=3D -fno-omit-frame-pointer
>  CORE_CFLAGS +=3D -ggdb3
>  CORE_CFLAGS +=3D -funwind-tables
> @@ -344,8 +347,8 @@ ifneq ($(TCMALLOC),)
>  endif
>
>  ifeq ($(FEATURES_DUMP),)
> -# We will display at the end of this Makefile.config, using $(call featu=
re_display_entries),
> -# as we may retry some feature detection here.
> +# We will display at the end of this Makefile.config, using $(call featu=
re_display_entries)
> +# As we may retry some feature detection here, see the disassembler-four=
-args case, for instance
>    FEATURE_DISPLAY_DEFERRED :=3D 1
>  include $(srctree)/tools/build/Makefile.feature
>  else
> @@ -907,9 +910,13 @@ ifdef BUILD_NONDISTRO
>
>      ifeq ($(feature-libbfd-liberty), 1)
>        EXTLIBS +=3D -lbfd -lopcodes -liberty
> +      FEATURE_CHECK_LDFLAGS-disassembler-four-args +=3D -liberty -ldl
> +      FEATURE_CHECK_LDFLAGS-disassembler-init-styled +=3D -liberty -ldl
>      else
>        ifeq ($(feature-libbfd-liberty-z), 1)
>          EXTLIBS +=3D -lbfd -lopcodes -liberty -lz
> +        FEATURE_CHECK_LDFLAGS-disassembler-four-args +=3D -liberty -lz -=
ldl
> +        FEATURE_CHECK_LDFLAGS-disassembler-init-styled +=3D -liberty -lz=
 -ldl
>        endif
>      endif
>      $(call feature_check,disassembler-four-args)
> @@ -1333,6 +1340,6 @@ endif
>
>  # re-generate FEATURE-DUMP as we may have called feature_check, found ou=
t
>  # extra libraries to add to LDFLAGS of some other test and then redo tho=
se
> -# tests.
> +# tests, see the block about libbfd, disassembler-four-args, for instanc=
e.
>  $(shell rm -f $(FEATURE_DUMP_FILENAME))
>  $(foreach feat,$(FEATURE_TESTS),$(shell echo "$(call feature_assign,$(fe=
at))" >> $(FEATURE_DUMP_FILENAME)))
> diff --git a/tools/perf/tests/pe-file-parsing.c b/tools/perf/tests/pe-fil=
e-parsing.c
> index c09a9fae1689..fff58b220c07 100644
> --- a/tools/perf/tests/pe-file-parsing.c
> +++ b/tools/perf/tests/pe-file-parsing.c
> @@ -34,6 +34,7 @@ static int run_dir(const char *d)
>         struct dso *dso;
>         struct symbol *sym;
>         int ret;
> +       size_t idx;
>
>         scnprintf(filename, PATH_MAX, "%s/pe-file.exe", d);
>         ret =3D filename__read_build_id(filename, &bid);
> @@ -61,7 +62,7 @@ static int run_dir(const char *d)
>         TEST_ASSERT_VAL("Failed to load symbols", ret =3D=3D 0);
>
>         dso__sort_by_name(dso);
> -       sym =3D dso__find_symbol_by_name(dso, "main");
> +       sym =3D dso__find_symbol_by_name(dso, "main", &idx);
>         TEST_ASSERT_VAL("Failed to find main", sym);
>         dso__delete(dso);
>
> --
> 2.41.0.162.gfafddb0af9-goog
>
