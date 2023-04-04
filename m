Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 956D56D6FE8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 00:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236588AbjDDWIq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 4 Apr 2023 18:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236064AbjDDWIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 18:08:44 -0400
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4EE3AB5;
        Tue,  4 Apr 2023 15:08:43 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id d20so4300151ioe.4;
        Tue, 04 Apr 2023 15:08:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680646123; x=1683238123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=054HY85hcXUQ0vW1Dd9l+klk6M1F7TJ4aI6jE4CGzQ8=;
        b=XAgLzDmuy4aaUhBhAvN1lMzfPuFHW2+FUfKJwvU+FhvPsTGyRGJE92C8xdDW8uj9Ne
         W3IpN06dT8eREdIKpba5zqdIJRisIH6IJ8vZtC2wOy6Vzy8h3fUsYJt7GX2tQxZt9u6/
         raF/OKpL4GUHYCVHtSwg9jY2PK5X76YyQLgjjZ7B4QBp7HA8MzlLQ+GY6gBmi+fS448H
         /KgMugh7GlqXNFvGJ55GSKwP11QHyqlsMsZ8jDm22gnw8ZRioosEvuSRiEa17OscOMBb
         Lj4KSDyQiv1n0U0Vz+S2My0QgZ8AmoPMJAuZHudXnoEXCtfVtoHsIt93KxXyyh71MHLT
         liJA==
X-Gm-Message-State: AAQBX9eh2Iu3v0wSdrHf3H09nHi37w0NIB8nD7UVFO0N1PFjoVsXlty7
        Q2DNqQhOkdpPACx6/gr3c5KQeWedp3UgH6kb4+M=
X-Google-Smtp-Source: AKy350aikxDNcHZAuFTL7MJqBNQpDyfSTfuNGiUfxuRXqz6ynkguCnTvYDdDm20xAo299u4lfrrjQnipOf/pYRmLgPY=
X-Received: by 2002:a5d:9719:0:b0:75a:e94e:151e with SMTP id
 h25-20020a5d9719000000b0075ae94e151emr3223239iol.15.1680646122887; Tue, 04
 Apr 2023 15:08:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230331202949.810326-1-namhyung@kernel.org> <20230331202949.810326-2-namhyung@kernel.org>
 <ZCtMLkNL80EkPvB1@kernel.org> <ZCwv4z5Dh/dHUMG6@kernel.org>
In-Reply-To: <ZCwv4z5Dh/dHUMG6@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 4 Apr 2023 15:08:31 -0700
Message-ID: <CAM9d7cgdioP9-yiCmvaDz6Nf1iN5qZZJ0rwBT0HYKsrDa=ubKQ@mail.gmail.com>
Subject: Re: [PATCH 1/9] perf list: Use relative path for tracepoint scan
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Tue, Apr 4, 2023 at 7:10 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> Em Mon, Apr 03, 2023 at 06:59:10PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Fri, Mar 31, 2023 at 01:29:41PM -0700, Namhyung Kim escreveu:
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > ---
> > >  tools/perf/util/print-events.c | 26 ++++++++++++++++++++------
> > >  1 file changed, 20 insertions(+), 6 deletions(-)
> >
> > Add to add this to fix on Alma Linux 8, and scandirat isn't being found
> > on musl libc (Alpine Linux), probably we'll need some scaffolding...
>
> About scandirat I'm adding the feature test below and this patch to the
> patch that starts using scandirat():

Thanks for doing this!

>
> diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
> index 28aa0b9300253d0a..386b1ab0b60e1d93 100644
> --- a/tools/perf/util/print-events.c
> +++ b/tools/perf/util/print-events.c
> @@ -58,11 +58,9 @@ static const struct event_symbol event_symbols_tool[PERF_TOOL_MAX] = {
>  /*
>   * Print the events from <debugfs_mount_point>/tracing/events
>   */
> -void print_tracepoint_events(const struct print_callbacks *print_cb, void *print_state)
> +void print_tracepoint_events(const struct print_callbacks *print_cb __maybe_unused, void *print_state __maybe_unused)
>  {
> -       struct dirent **sys_namelist = NULL;
>         char *events_path = get_tracing_file("events");
> -       int sys_items = tracing_events__scandir_alphasort(&sys_namelist);
>         int events_fd = open(events_path, O_PATH);
>
>         put_tracing_file(events_path);
> @@ -71,6 +69,11 @@ void print_tracepoint_events(const struct print_callbacks *print_cb, void *print
>                 return;
>         }
>
> +#ifdef HAVE_SCANDIRAT_SUPPORT
> +{
> +       struct dirent **sys_namelist = NULL;
> +       int sys_items = tracing_events__scandir_alphasort(&sys_namelist);
> +
>         for (int i = 0; i < sys_items; i++) {
>                 struct dirent *sys_dirent = sys_namelist[i];
>                 struct dirent **evt_namelist = NULL;
> @@ -120,7 +123,13 @@ void print_tracepoint_events(const struct print_callbacks *print_cb, void *print
>                 close(dir_fd);
>                 free(evt_namelist);
>         }
> +
>         free(sys_namelist);
> +}
> +#else
> +       printf("\nWARNING: Your libc doesn't have the scandir function, please ask its maintainers to implement it.\n"
> +              "         As a rough fallback, please do 'ls %s' to see the available tracepoint events.\n", events_path);
> +#endif
>         close(events_fd);
>  }
>
>
> From b25f9de2f944a550b063322b7210f4392e622a5e Mon Sep 17 00:00:00 2001
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date: Tue, 4 Apr 2023 11:05:57 -0300
> Subject: [PATCH 1/1] tools build: Add a feature test for scandirat(), that is
>  not implemented so far in musl and uclibc
>
> We use it just when listing tracepoint events, and for root, so just
> emit a warning about it to get users to ask the library maintainers to
> implement it, as suggested in this systemd ticket:
>
>  https://github.com/systemd/casync/issues/129
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/build/Makefile.feature   | 1 +
>  tools/build/feature/Makefile   | 4 ++++
>  tools/build/feature/test-all.c | 5 +++++
>  tools/perf/Makefile.config     | 4 ++++

Maybe you forgot to add the tools/build/feature/test-scandirat.c :)

Thanks,
Namhyung


>  4 files changed, 14 insertions(+)
>
> diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
> index 214622d7537cc56b..934e2777a2dbcd90 100644
> --- a/tools/build/Makefile.feature
> +++ b/tools/build/Makefile.feature
> @@ -64,6 +64,7 @@ FEATURE_TESTS_BASIC :=                  \
>          lzma                            \
>          get_cpuid                       \
>          bpf                             \
> +        scandirat                      \
>          sched_getcpu                   \
>          sdt                            \
>          setns                          \
> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> index 0a3b9281f8b08000..0f0aa9b7d7b5e43c 100644
> --- a/tools/build/feature/Makefile
> +++ b/tools/build/feature/Makefile
> @@ -65,6 +65,7 @@ FILES=                                          \
>           test-gettid.bin                       \
>           test-jvmti.bin                                \
>           test-jvmti-cmlr.bin                   \
> +         test-scandirat.bin                    \
>           test-sched_getcpu.bin                 \
>           test-setns.bin                                \
>           test-libopencsd.bin                   \
> @@ -129,6 +130,9 @@ $(OUTPUT)test-get_current_dir_name.bin:
>  $(OUTPUT)test-glibc.bin:
>         $(BUILD)
>
> +$(OUTPUT)test-scandirat.bin:
> +       $(BUILD)
> +
>  $(OUTPUT)test-sched_getcpu.bin:
>         $(BUILD)
>
> diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
> index 957c02c7b163b579..6f4bf386a3b5c4b0 100644
> --- a/tools/build/feature/test-all.c
> +++ b/tools/build/feature/test-all.c
> @@ -114,6 +114,10 @@
>  # include "test-pthread-barrier.c"
>  #undef main
>
> +#define main main_test_scandirat
> +# include "test-scandirat.c"
> +#undef main
> +
>  #define main main_test_sched_getcpu
>  # include "test-sched_getcpu.c"
>  #undef main
> @@ -206,6 +210,7 @@ int main(int argc, char *argv[])
>         main_test_get_cpuid();
>         main_test_bpf();
>         main_test_libcrypto();
> +       main_test_scandirat();
>         main_test_sched_getcpu();
>         main_test_sdt();
>         main_test_setns();
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index dd203f0a2b7e64e1..16bea51f0bcd95ea 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -478,6 +478,10 @@ ifdef NO_DWARF
>    NO_LIBDW_DWARF_UNWIND := 1
>  endif
>
> +ifeq ($(feature-scandirat), 1)
> +  CFLAGS += -DHAVE_SCANDIRAT_SUPPORT
> +endif
> +
>  ifeq ($(feature-sched_getcpu), 1)
>    CFLAGS += -DHAVE_SCHED_GETCPU_SUPPORT
>  endif
> --
> 2.39.2
>
