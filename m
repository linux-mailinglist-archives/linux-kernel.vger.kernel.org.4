Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3B76F0063
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 07:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242803AbjD0F16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 01:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242745AbjD0F14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 01:27:56 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96982705
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 22:27:54 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-3f0a2f8216fso611851cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 22:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682573274; x=1685165274;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=23QIJrDsy807vEXvSlFJsuoFWGU4ASBz3D+3MQdJY40=;
        b=Zyn++CYE6cBSUwDBPpgqEABiOUVP8zvfiUH+57ZvMKwWOjhbng0GiC2QCvFFkMeUOL
         Nc5YNEYvAncFDSg0mSyv59rgGRnuF2LKTswphvsVVHmuHtMVQHdgAf6rCsXYdYpxj4qS
         fhWY7d2uw3z0lXXPCp1ZIQ8j/jYNM1bYgj/umCw3Cpuf3xmCG9WM8C+GPlObRYoNu9H0
         i+thJSJP9ptQ3M1lZAfAuk7gzghjifSL0RH/8xlBWJE3wNeNUcCRfjV1Nl2PpoC8W9pp
         xAnzA9qhHDia/aKpJRyrzPPd9a2vpZ9JqmlQM7A5LqsbpRlnke3uRv5NXB16fQcNJP/y
         m1mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682573274; x=1685165274;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=23QIJrDsy807vEXvSlFJsuoFWGU4ASBz3D+3MQdJY40=;
        b=gLb8w1XTxR7hUR0pxNqZH1LLwDVtGoj7ncAEcKwDqJhufd/ixHOGR3uJ/smFIg35Vy
         dXFUoxTfaw1f24khyjGHfCaNt1Rzpi1XqS9Dfisn1z9QwanZybEw/VWmJxJ9uROooLtR
         lVgqqRGjZaxXeeCphhTdQjMr6x8Ia/3itpbAgWuXwx62bQj6oxmAZIFTfJ7rGYRODUTB
         rGyi/N4vrHUw/7onFs+lM7FApW7wKAruKm3U+SR33GeltAyXEZh9PUfYz4nAZITjvz4L
         HbTHMB9FNvmVRlJA+THK6mHWlKDnUSk8enYSgzp+dlqzbdH7NPWROHWKKOBG4byn6tln
         df7g==
X-Gm-Message-State: AC+VfDwsl7KCJxB7kK/IOI1KNj24qKflCKZW6v2qG0/x48CW2S1rszcd
        7XK8FfS4gVOjvDbP68C+/5Auttp5tNEEdqkrzxACHBAJdImHxs2H9Go=
X-Google-Smtp-Source: ACHHUZ4Ls6hc+7PsjQ+5GCwX/1eTjXsTfbCrxj2NCTg8nBoSgTz82iuYlUsSxIMbNt4ltlJv36elL79FABAg8vO5F7U=
X-Received: by 2002:a05:622a:120a:b0:3f0:af20:1a37 with SMTP id
 y10-20020a05622a120a00b003f0af201a37mr92351qtx.15.1682573273743; Wed, 26 Apr
 2023 22:27:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230417192546.99923-1-irogers@google.com>
In-Reply-To: <20230417192546.99923-1-irogers@google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 26 Apr 2023 22:27:42 -0700
Message-ID: <CAP-5=fXuKqU=ZD4G3t1H=dD1SMghiVXHj5YTFhX+Jj98jAiVUg@mail.gmail.com>
Subject: Re: [PATCH v1] perf build: Don't compile demangle-cxx.cpp if not necessary
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Qi Liu <liuqi115@huawei.com>, Leo Yan <leo.yan@linaro.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Mon, Apr 17, 2023 at 12:25=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> demangle-cxx.cpp requires a C++ compiler, but feature checks may fail
> because of the absence of this. Add a CONFIG_CXX_DEMANGLE so that the
> source isn't built if not supported. Copy libbfd and cplus demangle
> variants to a weak symbol-elf.c version so they aren't dependent on
> C++. These variants are only built with the build option
> BUILD_NONDISTRO=3D1.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Testing on arm and noticed we hadn't picked this one up.

Thanks,
Ian

> ---
>  tools/perf/Makefile.config   |  1 +
>  tools/perf/util/Build        |  2 +-
>  tools/perf/util/symbol-elf.c | 27 +++++++++++++++++++++++++++
>  3 files changed, 29 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 71442c54c25f..5f0f24b56f50 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -923,6 +923,7 @@ ifndef NO_DEMANGLE
>      EXTLIBS +=3D -lstdc++
>      CFLAGS +=3D -DHAVE_CXA_DEMANGLE_SUPPORT
>      CXXFLAGS +=3D -DHAVE_CXA_DEMANGLE_SUPPORT
> +    $(call detected,CONFIG_CXX_DEMANGLE)
>    endif
>    ifdef BUILD_NONDISTRO
>      ifeq ($(filter -liberty,$(EXTLIBS)),)
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index bd18fe5f2719..f9df1df1eec0 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -214,7 +214,7 @@ perf-$(CONFIG_ZSTD) +=3D zstd.o
>
>  perf-$(CONFIG_LIBCAP) +=3D cap.o
>
> -perf-y +=3D demangle-cxx.o
> +perf-$(CONFIG_CXX_DEMANGLE) +=3D demangle-cxx.o
>  perf-y +=3D demangle-ocaml.o
>  perf-y +=3D demangle-java.o
>  perf-y +=3D demangle-rust.o
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index 35724f6a84fa..cd08bdb9824f 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -31,6 +31,13 @@
>  #include <bfd.h>
>  #endif
>
> +#if defined(HAVE_LIBBFD_SUPPORT) || defined(HAVE_CPLUS_DEMANGLE_SUPPORT)
> +#ifndef DMGL_PARAMS
> +#define DMGL_PARAMS     (1 << 0)  /* Include function args */
> +#define DMGL_ANSI       (1 << 1)  /* Include const, volatile, etc */
> +#endif
> +#endif
> +
>  #ifndef EM_AARCH64
>  #define EM_AARCH64     183  /* ARM 64 bit */
>  #endif
> @@ -271,6 +278,26 @@ static bool want_demangle(bool is_kernel_sym)
>         return is_kernel_sym ? symbol_conf.demangle_kernel : symbol_conf.=
demangle;
>  }
>
> +/*
> + * Demangle C++ function signature, typically replaced by demangle-cxx.c=
pp
> + * version.
> + */
> +__weak char *cxx_demangle_sym(const char *str __maybe_unused, bool param=
s __maybe_unused,
> +                             bool modifiers __maybe_unused)
> +{
> +#ifdef HAVE_LIBBFD_SUPPORT
> +       int flags =3D (params ? DMGL_PARAMS : 0) | (modifiers ? DMGL_ANSI=
 : 0);
> +
> +       return bfd_demangle(NULL, str, flags);
> +#elif defined(HAVE_CPLUS_DEMANGLE_SUPPORT)
> +       int flags =3D (params ? DMGL_PARAMS : 0) | (modifiers ? DMGL_ANSI=
 : 0);
> +
> +       return cplus_demangle(str, flags);
> +#else
> +       return NULL;
> +#endif
> +}
> +
>  static char *demangle_sym(struct dso *dso, int kmodule, const char *elf_=
name)
>  {
>         char *demangled =3D NULL;
> --
> 2.40.0.634.g4ca3ef3211-goog
>
