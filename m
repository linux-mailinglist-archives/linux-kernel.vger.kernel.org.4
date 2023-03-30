Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53D26D0BD1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 18:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbjC3QvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 12:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbjC3Quy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 12:50:54 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1467FCDE1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:50:22 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-3e390e23f83so529571cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680195021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p/FCVT8pjnQlaEXCyw0RIWbqk31GFiyTZmtv3Hci8Xw=;
        b=mdd3A89xFS/UXD4CEvKqBUpBNPb3hEulmratv1DXHQuP2vWGlwzaSih3DwD4MxsYS2
         t0nUfVFsxPOpt63YihPpB+KmM5Excd9HxuHNvGwVFXmEzQWIAgcbQwa1YUals8RBvFMQ
         +y8aDEioiEVrw1+OPSVovqC26tGXE6EfhYF3vJXeJ6ZB8fL8VT3ZZldxhtlyFa2JtJVA
         jde4IM8125i1twncWTjmcXv9hppjqRgCe/D+KWSuZM0qDeZ/NCZfR0SF8xUxRGnD0Mqg
         C2bsmPgZDBZVkf0JhnhNmgmS33OQr/wxzwFJMMT+V9km3t8P/lvNYSZiMtrMaqs4DMg2
         JKLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680195021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p/FCVT8pjnQlaEXCyw0RIWbqk31GFiyTZmtv3Hci8Xw=;
        b=aFcVcnko4xSE0HvsR6keMrLNXzZW2QzCcaub0U+bE4odG6sO8t8QzxamIQXESFIkRQ
         lL3RblkHN6FR7WQ5heZ9kMhl6zl33RJTQ3VjxrlXZX5PO9NrMdOOZek4+IrSPcyzXmik
         ECvp1XobgtxVle7UCAj0mxHxqK+F64d5liWTcCnHr7dC/tdsV2w4/uGTMZ8CLougbmT9
         i49qc6lPyvwyI0De8XN1q+c49ySoYF2k1v5zUty5g9q3+trV5ugB8rIDclH47QCjxhq9
         lFYtMuJ721NMP9R5Ip6fVMZ/vqT04LYiHpQXsM21PuuOgxdbyfMYdbF2Ucxmtu9heEPE
         v/4w==
X-Gm-Message-State: AAQBX9cSEj6qUtUI+anl0Cv4udaXv4gO1uXbEEnoUuCL87LTeemzTfgT
        tYvCx+W1ibCsMsU7D6EEOQ/GuHI7PX+Tv/BSXm+k1g==
X-Google-Smtp-Source: AKy350Z+q9Wp92RQdt/uj6HK23zaL0HJ06v+xuSTF6LNTwJqTPOlkoVuP0jBPQ3C8A+yEFoTqzSyTVjseBRDU/TpWyI=
X-Received: by 2002:a05:622a:1a86:b0:3bd:17d6:e04c with SMTP id
 s6-20020a05622a1a8600b003bd17d6e04cmr400268qtc.2.1680195020817; Thu, 30 Mar
 2023 09:50:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230311065753.3012826-1-irogers@google.com> <20230311065753.3012826-10-irogers@google.com>
 <f8298af8-4d29-5cbd-cb5f-d33b3fdd641c@arm.com>
In-Reply-To: <f8298af8-4d29-5cbd-cb5f-d33b3fdd641c@arm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 30 Mar 2023 09:50:06 -0700
Message-ID: <CAP-5=fV3HPjXqHm1m-HB3rJU=emV16bUby1Xt-5x4+zjdPRnsg@mail.gmail.com>
Subject: Re: [PATCH v1 09/13] perf symbol: Add abi::__cxa_demangle C++
 demangling support
To:     James Clark <james.clark@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Andres Freund <andres@anarazel.de>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Pavithra Gurushankar <gpavithrasha@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        =?UTF-8?Q?Martin_Li=C5=A1ka?= <mliska@suse.cz>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        llvm@lists.linux.dev, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
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

On Thu, Mar 30, 2023 at 7:08=E2=80=AFAM James Clark <james.clark@arm.com> w=
rote:
>
>
>
> On 11/03/2023 06:57, Ian Rogers wrote:
> > Refactor C++ demangling out of symbol-elf into its own files similar
> > to other languages. Add abi::__cxa_demangle support. As the other
> > demanglers are not shippable with distributions, this brings back C++
> > demangling in a common case. It isn't perfect as the support for
> > optionally demangling arguments and modifiers isn't present.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/Makefile.config       | 29 +++++++++---------
> >  tools/perf/util/Build            |  1 +
> >  tools/perf/util/demangle-cxx.cpp | 50 ++++++++++++++++++++++++++++++++
> >  tools/perf/util/demangle-cxx.h   | 16 ++++++++++
> >  tools/perf/util/symbol-elf.c     | 37 +++++------------------
> >  5 files changed, 88 insertions(+), 45 deletions(-)
> >  create mode 100644 tools/perf/util/demangle-cxx.cpp
> >  create mode 100644 tools/perf/util/demangle-cxx.h
> >
> > diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> > index 5756498248e0..fdeca45cf15f 100644
> > --- a/tools/perf/Makefile.config
> > +++ b/tools/perf/Makefile.config
> > @@ -906,6 +906,7 @@ ifdef BUILD_NONDISTRO
> >    endif
> >
> >    CFLAGS +=3D -DHAVE_LIBBFD_SUPPORT
> > +  CXXFLAGS +=3D -DHAVE_LIBBFD_SUPPORT
> >    ifeq ($(feature-libbfd-buildid), 1)
> >      CFLAGS +=3D -DHAVE_LIBBFD_BUILDID_SUPPORT
> >    else
> > @@ -913,26 +914,24 @@ ifdef BUILD_NONDISTRO
> >    endif
> >  endif
> >
> > -ifdef NO_DEMANGLE
> > -  CFLAGS +=3D -DNO_DEMANGLE
> > -else
> > +ifndef NO_DEMANGLE
> > +  $(call feature_check,cxa-demangle)
> > +  ifeq ($(feature-cxa-demangle), 1)
> > +    EXTLIBS +=3D -lstdc++
>
> Hi Ian,
>
> I think cross compilation for arm on x86 isn't working after this change
> (at least on Ubuntu).
>
> Even with all of the arm64 libstdc++ stuff installed, you can only link
> to it using g++, but the perf build tries to link to it using gcc. Not
> sure it's some quirk with the search paths on Ubuntu or something else:
>
>   $ aarch64-linux-gnu-gcc -lstdc++
>
>    /usr/lib/gcc-cross/aarch64-linux-gnu/12/../../../../aarch64-linux-
> gnu/bin/ld: cannot find -lstdc++: No such file or directory
>   collect2: error: ld returned 1 exit status
>
> g++ gets further:
>
>   $ aarch64-linux-gnu-g++ -lstdc++
>
>   ...
>   (.text+0x20): undefined reference to `main'
> collect2: error: ld returned 1 exit status
>
> At the end of the perf build it looks like something similar is
> happening (with all the non interesting bits deleted):
>
>    $ make ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu- -C tools/perf
> NO_BPF_SKEL=3D1 V=3D1
>
>   aarch64-linux-gnu-gcc ... -o perf
>
> /usr/lib/gcc-cross/aarch64-linux-gnu/12/../../../../aarch64-linux-gnu/bin=
/ld:
> cannot find -lstdc++: No such file or directory
>
> If I build with NO_DEMANGLE=3D1 then the build works, but I think it woul=
d
> at be best to autodetect rather than have to do this. Or maybe even link
> at the end with g++ if we're going to use libstdc++?

Hi James,

sorry for the problems you are having, I'll see if I can get a repo. I
did add a feature test with this change in the same set:
https://lore.kernel.org/lkml/20230311065753.3012826-9-irogers@google.com/
So it should be feature testing and only enabling when
HAVE_CXA_DEMANGLE_SUPPORT is present. Obviously something is up, so
I'll have a think about it.

Thanks,
Ian

> Thanks
> James
>
> > +    CFLAGS +=3D -DHAVE_CXA_DEMANGLE_SUPPORT
> > +    CXXFLAGS +=3D -DHAVE_CXA_DEMANGLE_SUPPORT
> > +  endif
> >    ifdef BUILD_NONDISTRO
> >      ifeq ($(filter -liberty,$(EXTLIBS)),)
> > -      ifdef HAVE_CPLUS_DEMANGLE_SUPPORT
> > +      $(call feature_check,cplus-demangle)
> > +      ifeq ($(feature-cplus-demangle), 1)
> >          EXTLIBS +=3D -liberty
> > -      else
> > -        $(call feature_check,cplus-demangle)
> > -        ifeq ($(feature-cplus-demangle), 1)
> > -          EXTLIBS +=3D -liberty
> > -        endif
> >        endif
> >      endif
> > -  endif
> > -
> > -  ifneq ($(filter -liberty,$(EXTLIBS)),)
> > -    CFLAGS +=3D -DHAVE_CPLUS_DEMANGLE_SUPPORT
> > -  else
> > -    CFLAGS +=3D -DNO_DEMANGLE
> > +    ifneq ($(filter -liberty,$(EXTLIBS)),)
> > +      CFLAGS +=3D -DHAVE_CPLUS_DEMANGLE_SUPPORT
> > +      CXXFLAGS +=3D -DHAVE_CPLUS_DEMANGLE_SUPPORT
> > +    endif
> >    endif
> >  endif
> >
> > diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> > index 918b501f9bd8..8607575183a9 100644
> > --- a/tools/perf/util/Build
> > +++ b/tools/perf/util/Build
> > @@ -211,6 +211,7 @@ perf-$(CONFIG_ZSTD) +=3D zstd.o
> >
> >  perf-$(CONFIG_LIBCAP) +=3D cap.o
> >
> > +perf-y +=3D demangle-cxx.o
> >  perf-y +=3D demangle-ocaml.o
> >  perf-y +=3D demangle-java.o
> >  perf-y +=3D demangle-rust.o
> > diff --git a/tools/perf/util/demangle-cxx.cpp b/tools/perf/util/demangl=
e-cxx.cpp
> > new file mode 100644
> > index 000000000000..8708bcafd370
> > --- /dev/null
> > +++ b/tools/perf/util/demangle-cxx.cpp
> > @@ -0,0 +1,50 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include "demangle-cxx.h"
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include <linux/compiler.h>
> > +
> > +#ifdef HAVE_LIBBFD_SUPPORT
> > +#define PACKAGE 'perf'
> > +#include <bfd.h>
> > +#endif
> > +
> > +#ifdef HAVE_CXA_DEMANGLE_SUPPORT
> > +#include <cxxabi.h>
> > +#endif
> > +
> > +#if defined(HAVE_LIBBFD_SUPPORT) || defined(HAVE_CPLUS_DEMANGLE_SUPPOR=
T)
> > +#ifndef DMGL_PARAMS
> > +#define DMGL_PARAMS     (1 << 0)  /* Include function args */
> > +#define DMGL_ANSI       (1 << 1)  /* Include const, volatile, etc */
> > +#endif
> > +#endif
> > +
> > +/*
> > + * Demangle C++ function signature
> > + *
> > + * Note: caller is responsible for freeing demangled string
> > + */
> > +extern "C"
> > +char *cxx_demangle_sym(const char *str, bool params __maybe_unused,
> > +                       bool modifiers __maybe_unused)
> > +{
> > +#ifdef HAVE_LIBBFD_SUPPORT
> > +        int flags =3D (params ? DMGL_PARAMS : 0) | (modifiers ? DMGL_A=
NSI : 0);
> > +
> > +        return bfd_demangle(NULL, str, flags);
> > +#elif defined(HAVE_CPLUS_DEMANGLE_SUPPORT)
> > +        int flags =3D (params ? DMGL_PARAMS : 0) | (modifiers ? DMGL_A=
NSI : 0);
> > +
> > +        return cplus_demangle(str, flags);
> > +#elif defined(HAVE_CXA_DEMANGLE_SUPPORT)
> > +        size_t len =3D strlen(str);
> > +        char *output =3D (char*)malloc(len);
> > +        int status;
> > +
> > +        output =3D abi::__cxa_demangle(str, output, &len, &status);
> > +        return output;
> > +#else
> > +        return NULL;
> > +#endif
> > +}
> > diff --git a/tools/perf/util/demangle-cxx.h b/tools/perf/util/demangle-=
cxx.h
> > new file mode 100644
> > index 000000000000..26b5b66c0b4e
> > --- /dev/null
> > +++ b/tools/perf/util/demangle-cxx.h
> > @@ -0,0 +1,16 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef __PERF_DEMANGLE_CXX
> > +#define __PERF_DEMANGLE_CXX 1
> > +
> > +#ifdef __cplusplus
> > +extern "C" {
> > +#endif
> > +
> > +char *cxx_demangle_sym(const char *str, bool params, bool modifiers);
> > +
> > +#ifdef __cplusplus
> > +}
> > +#endif
> > +
> > +
> > +#endif /* __PERF_DEMANGLE_CXX */
> > diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.=
c
> > index 41882ae8452e..c0a2de42c51b 100644
> > --- a/tools/perf/util/symbol-elf.c
> > +++ b/tools/perf/util/symbol-elf.c
> > @@ -12,6 +12,7 @@
> >  #include "maps.h"
> >  #include "symbol.h"
> >  #include "symsrc.h"
> > +#include "demangle-cxx.h"
> >  #include "demangle-ocaml.h"
> >  #include "demangle-java.h"
> >  #include "demangle-rust.h"
> > @@ -25,6 +26,11 @@
> >  #include <symbol/kallsyms.h>
> >  #include <internal/lib.h>
> >
> > +#ifdef HAVE_LIBBFD_SUPPORT
> > +#define PACKAGE 'perf'
> > +#include <bfd.h>
> > +#endif
> > +
> >  #ifndef EM_AARCH64
> >  #define EM_AARCH64   183  /* ARM 64 bit */
> >  #endif
> > @@ -45,34 +51,6 @@
> >
> >  typedef Elf64_Nhdr GElf_Nhdr;
> >
> > -#ifndef DMGL_PARAMS
> > -#define DMGL_NO_OPTS     0              /* For readability... */
> > -#define DMGL_PARAMS      (1 << 0)       /* Include function args */
> > -#define DMGL_ANSI        (1 << 1)       /* Include const, volatile, et=
c */
> > -#endif
> > -
> > -#ifdef HAVE_LIBBFD_SUPPORT
> > -#define PACKAGE 'perf'
> > -#include <bfd.h>
> > -#else
> > -#ifdef HAVE_CPLUS_DEMANGLE_SUPPORT
> > -extern char *cplus_demangle(const char *, int);
> > -
> > -static inline char *bfd_demangle(void __maybe_unused *v, const char *c=
, int i)
> > -{
> > -     return cplus_demangle(c, i);
> > -}
> > -#else
> > -#ifdef NO_DEMANGLE
> > -static inline char *bfd_demangle(void __maybe_unused *v,
> > -                              const char __maybe_unused *c,
> > -                              int __maybe_unused i)
> > -{
> > -     return NULL;
> > -}
> > -#endif
> > -#endif
> > -#endif
> >
> >  #ifndef HAVE_ELF_GETPHDRNUM_SUPPORT
> >  static int elf_getphdrnum(Elf *elf, size_t *dst)
> > @@ -295,7 +273,6 @@ static bool want_demangle(bool is_kernel_sym)
> >
> >  static char *demangle_sym(struct dso *dso, int kmodule, const char *el=
f_name)
> >  {
> > -     int demangle_flags =3D verbose > 0 ? (DMGL_PARAMS | DMGL_ANSI) : =
DMGL_NO_OPTS;
> >       char *demangled =3D NULL;
> >
> >       /*
> > @@ -306,7 +283,7 @@ static char *demangle_sym(struct dso *dso, int kmod=
ule, const char *elf_name)
> >       if (!want_demangle(dso->kernel || kmodule))
> >           return demangled;
> >
> > -     demangled =3D bfd_demangle(NULL, elf_name, demangle_flags);
> > +     demangled =3D cxx_demangle_sym(elf_name, verbose > 0, verbose > 0=
);
> >       if (demangled =3D=3D NULL) {
> >               demangled =3D ocaml_demangle_sym(elf_name);
> >               if (demangled =3D=3D NULL) {
