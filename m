Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDF172E5AB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 16:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242447AbjFMOZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 10:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242823AbjFMOZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 10:25:36 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778A0E7A
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 07:25:33 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-3f9b7de94e7so265091cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 07:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686666332; x=1689258332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Kp301Y14WcckGMhu9gte8y4iUEAsDuS71KisBLyOyo=;
        b=XX2P1w61EPs/7lbY2zFFD6YtTJHNu6F3uoh0rVPeT/qJQFmi7BAJ3cz5AcCppArAps
         wNch8f18Jzq8hL5XTtSR7862nVCICtBHz585tlUX3ZYgT+3Yb7DPge+J9szGj+bhcJB5
         RogQGoU4UrcdRX2ZrdlpvyOXcHcEINSPgjGzo/hv4BauKFgGvTmd8jHAE1ccylABg1R5
         39mlI3k50ibGLKVARAXQtXmo+8LgopskNsqIXhhxqnXwIeVoOCvbOAymsehjvCWbESRc
         R7BtiXBKFx+w1HQ47bsZ+xP9VhFFGxlYq7OpKvvDGSu/1BjywjA+9T1bIgvebRSlieDu
         fGbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686666332; x=1689258332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Kp301Y14WcckGMhu9gte8y4iUEAsDuS71KisBLyOyo=;
        b=h/u5cdiL8ej7pUR/ylba1n8TT5onpOBOiiCqsjcekE6YmSDlqLFXG3occTW2L5tl64
         d3NEI0udCvkhggp3e5pf1lNkqNCBcxqaiUyqPqeDVyCQYxgqQYc/KnZZdJsuqVczg/cs
         1xdBT/1a8PELACcKXbmNyvyH9U9OZd0YJI3qICbV24M7OBsIkmgNJIiqAOpoH/w0zZjj
         teD+kgH/b8iyTx88ODbIlBTa1qme4WUIZYtnSnL78h2TXBiKKSRMlV/y2T4JZagqGDpl
         /VWLPPx2YZ2jGdJxS6IJPC47EgQrLFLobK8aZOJgSIRItp6eZ2MXzF1VTqAkxmn+yMjj
         tnjw==
X-Gm-Message-State: AC+VfDx2pngs9tJKXesf/cUF26cP3Edqrubv9NJhdzb826NTAmy6pBvT
        8FJY8TgFw16M6RiLTtIu9F3Uy6JuNCcoP2SPUIM3+g==
X-Google-Smtp-Source: ACHHUZ4SQOcvlT+SdJPY64niMYIKR1IHr/jcIRiZVVX8Jyh2cyh1vYngDkRqaHWMGJPLqey9N8E/PWYyFqWQQt8ECN4=
X-Received: by 2002:a05:622a:3c6:b0:3ef:4319:c6c5 with SMTP id
 k6-20020a05622a03c600b003ef4319c6c5mr97724qtx.19.1686666332467; Tue, 13 Jun
 2023 07:25:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230531154333.364167-1-irogers@google.com> <ZIdtO9xVsP6Ytb0q@kernel.org>
 <683fea7c-f5e9-fa20-f96b-f6233ed5d2a7@intel.com>
In-Reply-To: <683fea7c-f5e9-fa20-f96b-f6233ed5d2a7@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 13 Jun 2023 07:25:20 -0700
Message-ID: <CAP-5=fU-a-53EZvyoMFQQhe99q6mjStnq9KTygjqHpwy8LAwug@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] perf tests x86: Generate entire instruction struct
 in C files
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
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

On Tue, Jun 13, 2023 at 6:22=E2=80=AFAM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 12/06/23 22:08, Arnaldo Carvalho de Melo wrote:
> > Em Wed, May 31, 2023 at 08:43:32AM -0700, Ian Rogers escreveu:
> >> Generate the entire struct in the C files. Later changes will break
> >> apart the struct and so two phases of output are necessary, this isn't
> >> possible if part of the struct is declared in insn-x86.c.
> >
> > Adrian,
> >
> >       Could you please take a look at these two patches?
>
> One of the considerations when adding the generated code
> was that it wouldn't have to be changed because the instructions
> do not change.
>
> I would much prefer to move the test out of the default perf build.
>
> Here is a patch to do that:

I'm happy to add Acked-by to the patch. Some other thoughts.

We build libperf tests as standalone executables.:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/l=
ib/perf/Makefile?h=3Dperf-tools-next#n144
this causes issues as we don't run the tests.

We run jevents tests as part of the build, there is an output test log
target that is a dependency on building pmu-events.c:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/p=
erf/pmu-events/Build?h=3Dperf-tools-next#n30
This copies a pattern in other kernel build files. With tests written
in C we'd need to make sure the test was host compiled to run it.

Thanks,
Ian

> From: Adrian Hunter <adrian.hunter@intel.com>
> Date: Tue, 13 Jun 2023 15:15:58 +0300
> Subject: [PATCH] perf tests: Make x86 new instructions test optional at b=
uild
>  time
>
> The "x86 instruction decoder - new instructions" test takes up space but
> is only really useful to developers. Make it optional at build time.
>
> Add variable EXTRA_TESTS which must be defined in order to build perf
> with the test.
>
> Example:
>
>   Before:
>
>     $ make -C tools/perf clean >/dev/null
>     $ make -C tools/perf >/dev/null
>     Makefile.config:650: No libunwind found. Please install libunwind-dev=
[el] >=3D 1.1 and/or set LIBUNWIND_DIR
>     Makefile.config:1149: libpfm4 not found, disables libpfm4 support. Pl=
ease install libpfm4-dev
>       PERF_VERSION =3D 6.4.rc3.gd15b8c76c964
>     $ readelf -SW tools/perf/perf | grep '\.rela.dyn\|.rodata\|\.data.rel=
.ro'
>       [10] .rela.dyn         RELA            000000000002fcb0 02fcb0 0748=
b0 18   A  6   0  8
>       [18] .rodata           PROGBITS        00000000002eb000 2eb000 6bac=
00 00   A  0   0 32
>       [25] .data.rel.ro      PROGBITS        00000000009ea180 9e9180 04b5=
40 00  WA  0   0 32
>
>   After:
>
>     $ make -C tools/perf clean >/dev/null
>     $ make -C tools/perf >/dev/null
>     Makefile.config:650: No libunwind found. Please install libunwind-dev=
[el] >=3D 1.1 and/or set LIBUNWIND_DIR
>     Makefile.config:1154: libpfm4 not found, disables libpfm4 support. Pl=
ease install libpfm4-dev
>       PERF_VERSION =3D 6.4.rc3.g4ea9c1569ea4
>     $ readelf -SW tools/perf/perf | grep '\.rela.dyn\|.rodata\|\.data.rel=
.ro'
>       [10] .rela.dyn         RELA            000000000002f3c8 02f3c8 036d=
68 18   A  6   0  8
>       [18] .rodata           PROGBITS        00000000002ac000 2ac000 68da=
80 00   A  0   0 32
>       [25] .data.rel.ro      PROGBITS        000000000097d440 97c440 0222=
80 00  WA  0   0 32
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/Makefile.config               | 5 +++++
>  tools/perf/Makefile.perf                 | 4 ++++
>  tools/perf/arch/x86/include/arch-tests.h | 2 ++
>  tools/perf/arch/x86/tests/Build          | 5 ++++-
>  tools/perf/arch/x86/tests/arch-tests.c   | 4 ++++
>  tools/perf/tests/make                    | 1 +
>  6 files changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index a794d9eca93d..9c5aa14a44cf 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -1075,6 +1075,11 @@ ifndef NO_AUXTRACE
>    endif
>  endif
>
> +ifdef EXTRA_TESTS
> +    $(call detected,CONFIG_EXTRA_TESTS)
> +    CFLAGS +=3D -DHAVE_EXTRA_TESTS
> +endif
> +
>  ifndef NO_JVMTI
>    ifneq (,$(wildcard /usr/sbin/update-java-alternatives))
>      JDIR=3D$(shell /usr/sbin/update-java-alternatives -l | head -1 | awk=
 '{print $$3}')
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index f48794816d82..b1e62a621f92 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -128,6 +128,10 @@ include ../scripts/utilities.mak
>  #
>  # Define BUILD_NONDISTRO to enable building an linking against libbfd an=
d
>  # libiberty distribution license incompatible libraries.
> +#
> +# Define EXTRA_TESTS to enable building extra tests useful mainly to per=
f
> +# developers, such as:
> +#      x86 instruction decoder - new instructions test
>
>  # As per kernel Makefile, avoid funny character set dependencies
>  unexport LC_ALL
> diff --git a/tools/perf/arch/x86/include/arch-tests.h b/tools/perf/arch/x=
86/include/arch-tests.h
> index 33d39c1d3e64..df133020d582 100644
> --- a/tools/perf/arch/x86/include/arch-tests.h
> +++ b/tools/perf/arch/x86/include/arch-tests.h
> @@ -6,7 +6,9 @@ struct test_suite;
>
>  /* Tests */
>  int test__rdpmc(struct test_suite *test, int subtest);
> +#ifdef HAVE_EXTRA_TESTS
>  int test__insn_x86(struct test_suite *test, int subtest);
> +#endif
>  int test__intel_pt_pkt_decoder(struct test_suite *test, int subtest);
>  int test__intel_pt_hybrid_compat(struct test_suite *test, int subtest);
>  int test__bp_modify(struct test_suite *test, int subtest);
> diff --git a/tools/perf/arch/x86/tests/Build b/tools/perf/arch/x86/tests/=
Build
> index 08cc8b9c931e..394771c00dca 100644
> --- a/tools/perf/arch/x86/tests/Build
> +++ b/tools/perf/arch/x86/tests/Build
> @@ -4,5 +4,8 @@ perf-$(CONFIG_DWARF_UNWIND) +=3D dwarf-unwind.o
>  perf-y +=3D arch-tests.o
>  perf-y +=3D sample-parsing.o
>  perf-y +=3D hybrid.o
> -perf-$(CONFIG_AUXTRACE) +=3D insn-x86.o intel-pt-test.o
> +perf-$(CONFIG_AUXTRACE) +=3D intel-pt-test.o
> +ifeq ($(CONFIG_EXTRA_TESTS),y)
> +perf-$(CONFIG_AUXTRACE) +=3D insn-x86.o
> +endif
>  perf-$(CONFIG_X86_64) +=3D bp-modify.o
> diff --git a/tools/perf/arch/x86/tests/arch-tests.c b/tools/perf/arch/x86=
/tests/arch-tests.c
> index 147ad0638bbb..3f2b90c59f92 100644
> --- a/tools/perf/arch/x86/tests/arch-tests.c
> +++ b/tools/perf/arch/x86/tests/arch-tests.c
> @@ -4,7 +4,9 @@
>  #include "arch-tests.h"
>
>  #ifdef HAVE_AUXTRACE_SUPPORT
> +#ifdef HAVE_EXTRA_TESTS
>  DEFINE_SUITE("x86 instruction decoder - new instructions", insn_x86);
> +#endif
>
>  static struct test_case intel_pt_tests[] =3D {
>         TEST_CASE("Intel PT packet decoder", intel_pt_pkt_decoder),
> @@ -37,7 +39,9 @@ struct test_suite *arch_tests[] =3D {
>         &suite__dwarf_unwind,
>  #endif
>  #ifdef HAVE_AUXTRACE_SUPPORT
> +#ifdef HAVE_EXTRA_TESTS
>         &suite__insn_x86,
> +#endif
>         &suite__intel_pt,
>  #endif
>  #if defined(__x86_64__)
> diff --git a/tools/perf/tests/make b/tools/perf/tests/make
> index 8dd3f8090352..885cd321d67b 100644
> --- a/tools/perf/tests/make
> +++ b/tools/perf/tests/make
> @@ -69,6 +69,7 @@ make_clean_all      :=3D clean all
>  make_python_perf_so :=3D $(python_perf_so)
>  make_debug          :=3D DEBUG=3D1
>  make_nondistro      :=3D BUILD_NONDISTRO=3D1
> +make_extra_tests    :=3D EXTRA_TESTS=3D1
>  make_no_libperl     :=3D NO_LIBPERL=3D1
>  make_no_libpython   :=3D NO_LIBPYTHON=3D1
>  make_no_scripts     :=3D NO_LIBPYTHON=3D1 NO_LIBPERL=3D1
> --
> 2.34.1
>
>
