Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB4A712C65
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 20:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242299AbjEZS1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 14:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjEZS07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 14:26:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A87BC;
        Fri, 26 May 2023 11:26:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3170065242;
        Fri, 26 May 2023 18:26:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EDE3C433EF;
        Fri, 26 May 2023 18:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685125617;
        bh=Oja/HpwcowuZ4xGEUw808hComU3CB3F0uGr7JPCiE/0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jFV1N5qA2aH5iKoBckU0DoREQuy2HLI48ewrmBuBTQGE/hZAA9fOZHS9S3dpSCJr1
         /JSZBUuMUBZS/7U4KiMsBCOZh3XnSjuiym7oCC55h8sfDRC+LZO/rmgcIh0pMtlwNI
         bQmzCpRy+4ogflm8nHB4ekOPoZb+u7vNQeGG6ct280oiAgiGzXW/nj1AbAn0Vvcak0
         V6/rKye+R/GcIuNDZm3NBnwmuwOkYcVHvGXwAHETQ0VjxiiStc3hXHN0jUDnG1WTJU
         1S8Nr7DhNRFp9kVRT9mJ/gEKORzamPV/Y/RgqVvNU0Bv8tFXGQVYMnLubFvS6/aQJ+
         iZS0lpQ2JNGeQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3CDD3403B5; Fri, 26 May 2023 15:26:55 -0300 (-03)
Date:   Fri, 26 May 2023 15:26:55 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Qi Liu <liuqi115@huawei.com>, Leo Yan <leo.yan@linaro.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf build: Don't compile demangle-cxx.cpp if not
 necessary
Message-ID: <ZHD57wlaQnY9dqEB@kernel.org>
References: <20230417192546.99923-1-irogers@google.com>
 <CAP-5=fXuKqU=ZD4G3t1H=dD1SMghiVXHj5YTFhX+Jj98jAiVUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXuKqU=ZD4G3t1H=dD1SMghiVXHj5YTFhX+Jj98jAiVUg@mail.gmail.com>
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

Em Wed, Apr 26, 2023 at 10:27:42PM -0700, Ian Rogers escreveu:
> On Mon, Apr 17, 2023 at 12:25 PM Ian Rogers <irogers@google.com> wrote:
> >
> > demangle-cxx.cpp requires a C++ compiler, but feature checks may fail
> > because of the absence of this. Add a CONFIG_CXX_DEMANGLE so that the
> > source isn't built if not supported. Copy libbfd and cplus demangle
> > variants to a weak symbol-elf.c version so they aren't dependent on
> > C++. These variants are only built with the build option
> > BUILD_NONDISTRO=1.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Testing on arm and noticed we hadn't picked this one up.

Thanks, applied.

- Arnaldo

 
> Thanks,
> Ian
> 
> > ---
> >  tools/perf/Makefile.config   |  1 +
> >  tools/perf/util/Build        |  2 +-
> >  tools/perf/util/symbol-elf.c | 27 +++++++++++++++++++++++++++
> >  3 files changed, 29 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> > index 71442c54c25f..5f0f24b56f50 100644
> > --- a/tools/perf/Makefile.config
> > +++ b/tools/perf/Makefile.config
> > @@ -923,6 +923,7 @@ ifndef NO_DEMANGLE
> >      EXTLIBS += -lstdc++
> >      CFLAGS += -DHAVE_CXA_DEMANGLE_SUPPORT
> >      CXXFLAGS += -DHAVE_CXA_DEMANGLE_SUPPORT
> > +    $(call detected,CONFIG_CXX_DEMANGLE)
> >    endif
> >    ifdef BUILD_NONDISTRO
> >      ifeq ($(filter -liberty,$(EXTLIBS)),)
> > diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> > index bd18fe5f2719..f9df1df1eec0 100644
> > --- a/tools/perf/util/Build
> > +++ b/tools/perf/util/Build
> > @@ -214,7 +214,7 @@ perf-$(CONFIG_ZSTD) += zstd.o
> >
> >  perf-$(CONFIG_LIBCAP) += cap.o
> >
> > -perf-y += demangle-cxx.o
> > +perf-$(CONFIG_CXX_DEMANGLE) += demangle-cxx.o
> >  perf-y += demangle-ocaml.o
> >  perf-y += demangle-java.o
> >  perf-y += demangle-rust.o
> > diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> > index 35724f6a84fa..cd08bdb9824f 100644
> > --- a/tools/perf/util/symbol-elf.c
> > +++ b/tools/perf/util/symbol-elf.c
> > @@ -31,6 +31,13 @@
> >  #include <bfd.h>
> >  #endif
> >
> > +#if defined(HAVE_LIBBFD_SUPPORT) || defined(HAVE_CPLUS_DEMANGLE_SUPPORT)
> > +#ifndef DMGL_PARAMS
> > +#define DMGL_PARAMS     (1 << 0)  /* Include function args */
> > +#define DMGL_ANSI       (1 << 1)  /* Include const, volatile, etc */
> > +#endif
> > +#endif
> > +
> >  #ifndef EM_AARCH64
> >  #define EM_AARCH64     183  /* ARM 64 bit */
> >  #endif
> > @@ -271,6 +278,26 @@ static bool want_demangle(bool is_kernel_sym)
> >         return is_kernel_sym ? symbol_conf.demangle_kernel : symbol_conf.demangle;
> >  }
> >
> > +/*
> > + * Demangle C++ function signature, typically replaced by demangle-cxx.cpp
> > + * version.
> > + */
> > +__weak char *cxx_demangle_sym(const char *str __maybe_unused, bool params __maybe_unused,
> > +                             bool modifiers __maybe_unused)
> > +{
> > +#ifdef HAVE_LIBBFD_SUPPORT
> > +       int flags = (params ? DMGL_PARAMS : 0) | (modifiers ? DMGL_ANSI : 0);
> > +
> > +       return bfd_demangle(NULL, str, flags);
> > +#elif defined(HAVE_CPLUS_DEMANGLE_SUPPORT)
> > +       int flags = (params ? DMGL_PARAMS : 0) | (modifiers ? DMGL_ANSI : 0);
> > +
> > +       return cplus_demangle(str, flags);
> > +#else
> > +       return NULL;
> > +#endif
> > +}
> > +
> >  static char *demangle_sym(struct dso *dso, int kmodule, const char *elf_name)
> >  {
> >         char *demangled = NULL;
> > --
> > 2.40.0.634.g4ca3ef3211-goog
> >

-- 

- Arnaldo
