Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8BB6D07B8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 16:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbjC3OIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 10:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbjC3OIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 10:08:46 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ABDF59753;
        Thu, 30 Mar 2023 07:08:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B5C12F4;
        Thu, 30 Mar 2023 07:09:07 -0700 (PDT)
Received: from [192.168.1.158] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 691093F663;
        Thu, 30 Mar 2023 07:08:20 -0700 (PDT)
Message-ID: <f8298af8-4d29-5cbd-cb5f-d33b3fdd641c@arm.com>
Date:   Thu, 30 Mar 2023 15:08:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 09/13] perf symbol: Add abi::__cxa_demangle C++
 demangling support
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Stephane Eranian <eranian@google.com>,
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
        =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        llvm@lists.linux.dev, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
References: <20230311065753.3012826-1-irogers@google.com>
 <20230311065753.3012826-10-irogers@google.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20230311065753.3012826-10-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/03/2023 06:57, Ian Rogers wrote:
> Refactor C++ demangling out of symbol-elf into its own files similar
> to other languages. Add abi::__cxa_demangle support. As the other
> demanglers are not shippable with distributions, this brings back C++
> demangling in a common case. It isn't perfect as the support for
> optionally demangling arguments and modifiers isn't present.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/Makefile.config       | 29 +++++++++---------
>  tools/perf/util/Build            |  1 +
>  tools/perf/util/demangle-cxx.cpp | 50 ++++++++++++++++++++++++++++++++
>  tools/perf/util/demangle-cxx.h   | 16 ++++++++++
>  tools/perf/util/symbol-elf.c     | 37 +++++------------------
>  5 files changed, 88 insertions(+), 45 deletions(-)
>  create mode 100644 tools/perf/util/demangle-cxx.cpp
>  create mode 100644 tools/perf/util/demangle-cxx.h
> 
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 5756498248e0..fdeca45cf15f 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -906,6 +906,7 @@ ifdef BUILD_NONDISTRO
>    endif
>  
>    CFLAGS += -DHAVE_LIBBFD_SUPPORT
> +  CXXFLAGS += -DHAVE_LIBBFD_SUPPORT
>    ifeq ($(feature-libbfd-buildid), 1)
>      CFLAGS += -DHAVE_LIBBFD_BUILDID_SUPPORT
>    else
> @@ -913,26 +914,24 @@ ifdef BUILD_NONDISTRO
>    endif
>  endif
>  
> -ifdef NO_DEMANGLE
> -  CFLAGS += -DNO_DEMANGLE
> -else
> +ifndef NO_DEMANGLE
> +  $(call feature_check,cxa-demangle)
> +  ifeq ($(feature-cxa-demangle), 1)
> +    EXTLIBS += -lstdc++

Hi Ian,

I think cross compilation for arm on x86 isn't working after this change
(at least on Ubuntu).

Even with all of the arm64 libstdc++ stuff installed, you can only link
to it using g++, but the perf build tries to link to it using gcc. Not
sure it's some quirk with the search paths on Ubuntu or something else:

  $ aarch64-linux-gnu-gcc -lstdc++

   /usr/lib/gcc-cross/aarch64-linux-gnu/12/../../../../aarch64-linux-
gnu/bin/ld: cannot find -lstdc++: No such file or directory
  collect2: error: ld returned 1 exit status

g++ gets further:

  $ aarch64-linux-gnu-g++ -lstdc++

  ...
  (.text+0x20): undefined reference to `main'
collect2: error: ld returned 1 exit status

At the end of the perf build it looks like something similar is
happening (with all the non interesting bits deleted):

   $ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -C tools/perf
NO_BPF_SKEL=1 V=1

  aarch64-linux-gnu-gcc ... -o perf

/usr/lib/gcc-cross/aarch64-linux-gnu/12/../../../../aarch64-linux-gnu/bin/ld:
cannot find -lstdc++: No such file or directory

If I build with NO_DEMANGLE=1 then the build works, but I think it would
at be best to autodetect rather than have to do this. Or maybe even link
at the end with g++ if we're going to use libstdc++?

Thanks
James

> +    CFLAGS += -DHAVE_CXA_DEMANGLE_SUPPORT
> +    CXXFLAGS += -DHAVE_CXA_DEMANGLE_SUPPORT
> +  endif
>    ifdef BUILD_NONDISTRO
>      ifeq ($(filter -liberty,$(EXTLIBS)),)
> -      ifdef HAVE_CPLUS_DEMANGLE_SUPPORT
> +      $(call feature_check,cplus-demangle)
> +      ifeq ($(feature-cplus-demangle), 1)
>          EXTLIBS += -liberty
> -      else
> -        $(call feature_check,cplus-demangle)
> -        ifeq ($(feature-cplus-demangle), 1)
> -          EXTLIBS += -liberty
> -        endif
>        endif
>      endif
> -  endif
> -
> -  ifneq ($(filter -liberty,$(EXTLIBS)),)
> -    CFLAGS += -DHAVE_CPLUS_DEMANGLE_SUPPORT
> -  else
> -    CFLAGS += -DNO_DEMANGLE
> +    ifneq ($(filter -liberty,$(EXTLIBS)),)
> +      CFLAGS += -DHAVE_CPLUS_DEMANGLE_SUPPORT
> +      CXXFLAGS += -DHAVE_CPLUS_DEMANGLE_SUPPORT
> +    endif
>    endif
>  endif
>  
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index 918b501f9bd8..8607575183a9 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -211,6 +211,7 @@ perf-$(CONFIG_ZSTD) += zstd.o
>  
>  perf-$(CONFIG_LIBCAP) += cap.o
>  
> +perf-y += demangle-cxx.o
>  perf-y += demangle-ocaml.o
>  perf-y += demangle-java.o
>  perf-y += demangle-rust.o
> diff --git a/tools/perf/util/demangle-cxx.cpp b/tools/perf/util/demangle-cxx.cpp
> new file mode 100644
> index 000000000000..8708bcafd370
> --- /dev/null
> +++ b/tools/perf/util/demangle-cxx.cpp
> @@ -0,0 +1,50 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "demangle-cxx.h"
> +#include <stdlib.h>
> +#include <string.h>
> +#include <linux/compiler.h>
> +
> +#ifdef HAVE_LIBBFD_SUPPORT
> +#define PACKAGE 'perf'
> +#include <bfd.h>
> +#endif
> +
> +#ifdef HAVE_CXA_DEMANGLE_SUPPORT
> +#include <cxxabi.h>
> +#endif
> +
> +#if defined(HAVE_LIBBFD_SUPPORT) || defined(HAVE_CPLUS_DEMANGLE_SUPPORT)
> +#ifndef DMGL_PARAMS
> +#define DMGL_PARAMS     (1 << 0)  /* Include function args */
> +#define DMGL_ANSI       (1 << 1)  /* Include const, volatile, etc */
> +#endif
> +#endif
> +
> +/*
> + * Demangle C++ function signature
> + *
> + * Note: caller is responsible for freeing demangled string
> + */
> +extern "C"
> +char *cxx_demangle_sym(const char *str, bool params __maybe_unused,
> +                       bool modifiers __maybe_unused)
> +{
> +#ifdef HAVE_LIBBFD_SUPPORT
> +        int flags = (params ? DMGL_PARAMS : 0) | (modifiers ? DMGL_ANSI : 0);
> +
> +        return bfd_demangle(NULL, str, flags);
> +#elif defined(HAVE_CPLUS_DEMANGLE_SUPPORT)
> +        int flags = (params ? DMGL_PARAMS : 0) | (modifiers ? DMGL_ANSI : 0);
> +
> +        return cplus_demangle(str, flags);
> +#elif defined(HAVE_CXA_DEMANGLE_SUPPORT)
> +        size_t len = strlen(str);
> +        char *output = (char*)malloc(len);
> +        int status;
> +
> +        output = abi::__cxa_demangle(str, output, &len, &status);
> +        return output;
> +#else
> +        return NULL;
> +#endif
> +}
> diff --git a/tools/perf/util/demangle-cxx.h b/tools/perf/util/demangle-cxx.h
> new file mode 100644
> index 000000000000..26b5b66c0b4e
> --- /dev/null
> +++ b/tools/perf/util/demangle-cxx.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __PERF_DEMANGLE_CXX
> +#define __PERF_DEMANGLE_CXX 1
> +
> +#ifdef __cplusplus
> +extern "C" {
> +#endif
> +
> +char *cxx_demangle_sym(const char *str, bool params, bool modifiers);
> +
> +#ifdef __cplusplus
> +}
> +#endif
> +
> +
> +#endif /* __PERF_DEMANGLE_CXX */
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index 41882ae8452e..c0a2de42c51b 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -12,6 +12,7 @@
>  #include "maps.h"
>  #include "symbol.h"
>  #include "symsrc.h"
> +#include "demangle-cxx.h"
>  #include "demangle-ocaml.h"
>  #include "demangle-java.h"
>  #include "demangle-rust.h"
> @@ -25,6 +26,11 @@
>  #include <symbol/kallsyms.h>
>  #include <internal/lib.h>
>  
> +#ifdef HAVE_LIBBFD_SUPPORT
> +#define PACKAGE 'perf'
> +#include <bfd.h>
> +#endif
> +
>  #ifndef EM_AARCH64
>  #define EM_AARCH64	183  /* ARM 64 bit */
>  #endif
> @@ -45,34 +51,6 @@
>  
>  typedef Elf64_Nhdr GElf_Nhdr;
>  
> -#ifndef DMGL_PARAMS
> -#define DMGL_NO_OPTS     0              /* For readability... */
> -#define DMGL_PARAMS      (1 << 0)       /* Include function args */
> -#define DMGL_ANSI        (1 << 1)       /* Include const, volatile, etc */
> -#endif
> -
> -#ifdef HAVE_LIBBFD_SUPPORT
> -#define PACKAGE 'perf'
> -#include <bfd.h>
> -#else
> -#ifdef HAVE_CPLUS_DEMANGLE_SUPPORT
> -extern char *cplus_demangle(const char *, int);
> -
> -static inline char *bfd_demangle(void __maybe_unused *v, const char *c, int i)
> -{
> -	return cplus_demangle(c, i);
> -}
> -#else
> -#ifdef NO_DEMANGLE
> -static inline char *bfd_demangle(void __maybe_unused *v,
> -				 const char __maybe_unused *c,
> -				 int __maybe_unused i)
> -{
> -	return NULL;
> -}
> -#endif
> -#endif
> -#endif
>  
>  #ifndef HAVE_ELF_GETPHDRNUM_SUPPORT
>  static int elf_getphdrnum(Elf *elf, size_t *dst)
> @@ -295,7 +273,6 @@ static bool want_demangle(bool is_kernel_sym)
>  
>  static char *demangle_sym(struct dso *dso, int kmodule, const char *elf_name)
>  {
> -	int demangle_flags = verbose > 0 ? (DMGL_PARAMS | DMGL_ANSI) : DMGL_NO_OPTS;
>  	char *demangled = NULL;
>  
>  	/*
> @@ -306,7 +283,7 @@ static char *demangle_sym(struct dso *dso, int kmodule, const char *elf_name)
>  	if (!want_demangle(dso->kernel || kmodule))
>  	    return demangled;
>  
> -	demangled = bfd_demangle(NULL, elf_name, demangle_flags);
> +	demangled = cxx_demangle_sym(elf_name, verbose > 0, verbose > 0);
>  	if (demangled == NULL) {
>  		demangled = ocaml_demangle_sym(elf_name);
>  		if (demangled == NULL) {
