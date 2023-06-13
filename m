Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3456072E696
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 17:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242943AbjFMPDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 11:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242949AbjFMPDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 11:03:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E181BE5;
        Tue, 13 Jun 2023 08:02:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5000762F82;
        Tue, 13 Jun 2023 15:02:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC28AC433D9;
        Tue, 13 Jun 2023 15:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686668576;
        bh=oECqkg2IcBB03H0bHUiPHaEqZY6ZTWGniQKHaZq/eQs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E2dDAyHHoJqmhtU8dZwegzzl+EtA/wTPhvxaWxmaa1eCqZZLoVqVe9cMrVrBpcxUT
         Y0duE+Ok/Yv3SiJFL7+7ew9Or5K1q+habLQEZh7P6vXiX37xY5squuj3jt/yvxdGtV
         IAmMmmCLQvu2Deuxg72ljxSbvQ8Dabhv79qRRgMz9t8OWhINfFC9mGn/7CUvq+Da3h
         BJt0Qdof8VpfAP1kvh2UxOP8NkfGaPv1Xh2fJko3zsAwJJ2gUBs0JQ0++nzfJFXRXi
         KQmgMC5Bb57+BKcKAuhkqDNauOLkf7D6+KN1cD2o+zjtQBtH72Z27KaawWZUfRH1JJ
         v6EB7PkLTNTZA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9B5AA40692; Tue, 13 Jun 2023 12:02:52 -0300 (-03)
Date:   Tue, 13 Jun 2023 12:02:52 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v1 1/2] perf tests x86: Generate entire instruction
 struct in C files
Message-ID: <ZIiFHJ01upokkYX3@kernel.org>
References: <20230531154333.364167-1-irogers@google.com>
 <ZIdtO9xVsP6Ytb0q@kernel.org>
 <683fea7c-f5e9-fa20-f96b-f6233ed5d2a7@intel.com>
 <CAP-5=fU-a-53EZvyoMFQQhe99q6mjStnq9KTygjqHpwy8LAwug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fU-a-53EZvyoMFQQhe99q6mjStnq9KTygjqHpwy8LAwug@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jun 13, 2023 at 07:25:20AM -0700, Ian Rogers escreveu:
> On Tue, Jun 13, 2023 at 6:22 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
> >
> > On 12/06/23 22:08, Arnaldo Carvalho de Melo wrote:
> > > Em Wed, May 31, 2023 at 08:43:32AM -0700, Ian Rogers escreveu:
> > >> Generate the entire struct in the C files. Later changes will break
> > >> apart the struct and so two phases of output are necessary, this isn't
> > >> possible if part of the struct is declared in insn-x86.c.
> > >
> > > Adrian,
> > >
> > >       Could you please take a look at these two patches?
> >
> > One of the considerations when adding the generated code
> > was that it wouldn't have to be changed because the instructions
> > do not change.
> >
> > I would much prefer to move the test out of the default perf build.
> >
> > Here is a patch to do that:
> 
> I'm happy to add Acked-by to the patch. Some other thoughts.

Thanks, applied and added Ian's Acked-by.

- Arnaldo

 
> We build libperf tests as standalone executables.:
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/lib/perf/Makefile?h=perf-tools-next#n144
> this causes issues as we don't run the tests.
> 
> We run jevents tests as part of the build, there is an output test log
> target that is a dependency on building pmu-events.c:
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/pmu-events/Build?h=perf-tools-next#n30
> This copies a pattern in other kernel build files. With tests written
> in C we'd need to make sure the test was host compiled to run it.
> 
> Thanks,
> Ian
> 
> > From: Adrian Hunter <adrian.hunter@intel.com>
> > Date: Tue, 13 Jun 2023 15:15:58 +0300
> > Subject: [PATCH] perf tests: Make x86 new instructions test optional at build
> >  time
> >
> > The "x86 instruction decoder - new instructions" test takes up space but
> > is only really useful to developers. Make it optional at build time.
> >
> > Add variable EXTRA_TESTS which must be defined in order to build perf
> > with the test.
> >
> > Example:
> >
> >   Before:
> >
> >     $ make -C tools/perf clean >/dev/null
> >     $ make -C tools/perf >/dev/null
> >     Makefile.config:650: No libunwind found. Please install libunwind-dev[el] >= 1.1 and/or set LIBUNWIND_DIR
> >     Makefile.config:1149: libpfm4 not found, disables libpfm4 support. Please install libpfm4-dev
> >       PERF_VERSION = 6.4.rc3.gd15b8c76c964
> >     $ readelf -SW tools/perf/perf | grep '\.rela.dyn\|.rodata\|\.data.rel.ro'
> >       [10] .rela.dyn         RELA            000000000002fcb0 02fcb0 0748b0 18   A  6   0  8
> >       [18] .rodata           PROGBITS        00000000002eb000 2eb000 6bac00 00   A  0   0 32
> >       [25] .data.rel.ro      PROGBITS        00000000009ea180 9e9180 04b540 00  WA  0   0 32
> >
> >   After:
> >
> >     $ make -C tools/perf clean >/dev/null
> >     $ make -C tools/perf >/dev/null
> >     Makefile.config:650: No libunwind found. Please install libunwind-dev[el] >= 1.1 and/or set LIBUNWIND_DIR
> >     Makefile.config:1154: libpfm4 not found, disables libpfm4 support. Please install libpfm4-dev
> >       PERF_VERSION = 6.4.rc3.g4ea9c1569ea4
> >     $ readelf -SW tools/perf/perf | grep '\.rela.dyn\|.rodata\|\.data.rel.ro'
> >       [10] .rela.dyn         RELA            000000000002f3c8 02f3c8 036d68 18   A  6   0  8
> >       [18] .rodata           PROGBITS        00000000002ac000 2ac000 68da80 00   A  0   0 32
> >       [25] .data.rel.ro      PROGBITS        000000000097d440 97c440 022280 00  WA  0   0 32
> >
> > Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> > ---
> >  tools/perf/Makefile.config               | 5 +++++
> >  tools/perf/Makefile.perf                 | 4 ++++
> >  tools/perf/arch/x86/include/arch-tests.h | 2 ++
> >  tools/perf/arch/x86/tests/Build          | 5 ++++-
> >  tools/perf/arch/x86/tests/arch-tests.c   | 4 ++++
> >  tools/perf/tests/make                    | 1 +
> >  6 files changed, 20 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> > index a794d9eca93d..9c5aa14a44cf 100644
> > --- a/tools/perf/Makefile.config
> > +++ b/tools/perf/Makefile.config
> > @@ -1075,6 +1075,11 @@ ifndef NO_AUXTRACE
> >    endif
> >  endif
> >
> > +ifdef EXTRA_TESTS
> > +    $(call detected,CONFIG_EXTRA_TESTS)
> > +    CFLAGS += -DHAVE_EXTRA_TESTS
> > +endif
> > +
> >  ifndef NO_JVMTI
> >    ifneq (,$(wildcard /usr/sbin/update-java-alternatives))
> >      JDIR=$(shell /usr/sbin/update-java-alternatives -l | head -1 | awk '{print $$3}')
> > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> > index f48794816d82..b1e62a621f92 100644
> > --- a/tools/perf/Makefile.perf
> > +++ b/tools/perf/Makefile.perf
> > @@ -128,6 +128,10 @@ include ../scripts/utilities.mak
> >  #
> >  # Define BUILD_NONDISTRO to enable building an linking against libbfd and
> >  # libiberty distribution license incompatible libraries.
> > +#
> > +# Define EXTRA_TESTS to enable building extra tests useful mainly to perf
> > +# developers, such as:
> > +#      x86 instruction decoder - new instructions test
> >
> >  # As per kernel Makefile, avoid funny character set dependencies
> >  unexport LC_ALL
> > diff --git a/tools/perf/arch/x86/include/arch-tests.h b/tools/perf/arch/x86/include/arch-tests.h
> > index 33d39c1d3e64..df133020d582 100644
> > --- a/tools/perf/arch/x86/include/arch-tests.h
> > +++ b/tools/perf/arch/x86/include/arch-tests.h
> > @@ -6,7 +6,9 @@ struct test_suite;
> >
> >  /* Tests */
> >  int test__rdpmc(struct test_suite *test, int subtest);
> > +#ifdef HAVE_EXTRA_TESTS
> >  int test__insn_x86(struct test_suite *test, int subtest);
> > +#endif
> >  int test__intel_pt_pkt_decoder(struct test_suite *test, int subtest);
> >  int test__intel_pt_hybrid_compat(struct test_suite *test, int subtest);
> >  int test__bp_modify(struct test_suite *test, int subtest);
> > diff --git a/tools/perf/arch/x86/tests/Build b/tools/perf/arch/x86/tests/Build
> > index 08cc8b9c931e..394771c00dca 100644
> > --- a/tools/perf/arch/x86/tests/Build
> > +++ b/tools/perf/arch/x86/tests/Build
> > @@ -4,5 +4,8 @@ perf-$(CONFIG_DWARF_UNWIND) += dwarf-unwind.o
> >  perf-y += arch-tests.o
> >  perf-y += sample-parsing.o
> >  perf-y += hybrid.o
> > -perf-$(CONFIG_AUXTRACE) += insn-x86.o intel-pt-test.o
> > +perf-$(CONFIG_AUXTRACE) += intel-pt-test.o
> > +ifeq ($(CONFIG_EXTRA_TESTS),y)
> > +perf-$(CONFIG_AUXTRACE) += insn-x86.o
> > +endif
> >  perf-$(CONFIG_X86_64) += bp-modify.o
> > diff --git a/tools/perf/arch/x86/tests/arch-tests.c b/tools/perf/arch/x86/tests/arch-tests.c
> > index 147ad0638bbb..3f2b90c59f92 100644
> > --- a/tools/perf/arch/x86/tests/arch-tests.c
> > +++ b/tools/perf/arch/x86/tests/arch-tests.c
> > @@ -4,7 +4,9 @@
> >  #include "arch-tests.h"
> >
> >  #ifdef HAVE_AUXTRACE_SUPPORT
> > +#ifdef HAVE_EXTRA_TESTS
> >  DEFINE_SUITE("x86 instruction decoder - new instructions", insn_x86);
> > +#endif
> >
> >  static struct test_case intel_pt_tests[] = {
> >         TEST_CASE("Intel PT packet decoder", intel_pt_pkt_decoder),
> > @@ -37,7 +39,9 @@ struct test_suite *arch_tests[] = {
> >         &suite__dwarf_unwind,
> >  #endif
> >  #ifdef HAVE_AUXTRACE_SUPPORT
> > +#ifdef HAVE_EXTRA_TESTS
> >         &suite__insn_x86,
> > +#endif
> >         &suite__intel_pt,
> >  #endif
> >  #if defined(__x86_64__)
> > diff --git a/tools/perf/tests/make b/tools/perf/tests/make
> > index 8dd3f8090352..885cd321d67b 100644
> > --- a/tools/perf/tests/make
> > +++ b/tools/perf/tests/make
> > @@ -69,6 +69,7 @@ make_clean_all      := clean all
> >  make_python_perf_so := $(python_perf_so)
> >  make_debug          := DEBUG=1
> >  make_nondistro      := BUILD_NONDISTRO=1
> > +make_extra_tests    := EXTRA_TESTS=1
> >  make_no_libperl     := NO_LIBPERL=1
> >  make_no_libpython   := NO_LIBPYTHON=1
> >  make_no_scripts     := NO_LIBPYTHON=1 NO_LIBPERL=1
> > --
> > 2.34.1
> >
> >

-- 

- Arnaldo
