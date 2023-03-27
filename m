Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449F26CA274
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 13:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbjC0Lcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 07:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjC0Lcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 07:32:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44447BD;
        Mon, 27 Mar 2023 04:32:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFB05611A8;
        Mon, 27 Mar 2023 11:32:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D133DC433EF;
        Mon, 27 Mar 2023 11:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679916771;
        bh=xzeQeF7VDSQfdcn9lbYTzhWKS+0PyOIQvXJKv/d68Gk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TdX+KXEEIWmMG1tH70EnTTpYWpUdldoj4gv9jg3J7lO37Vgi6v0uVF+5/YLW+HyYS
         3QPO8+DC1AT2tvbD1QwE3lXTmmJsc4ATvx181cnz+aJj7C0TcCOU9vmu0an5oYiAxo
         SDnBIR9FrdqXoH6QO1fv2cnE1+uu/jsdwWirE3gKVUUoci+TWkL0ckJnBlN8E0CyJs
         5PDiTATBqfh2mCrtEx6sr6dZcZUBvCGbojJGOgmGYLOFHofEHUHX4lQfzR/A5C/Q8j
         OEBjW3W69854sv5W3sEX0QNtHIDqAKvnoeU1yVQJ6widVDSPKpQLv28c4L4oeMFeMe
         tP2F9loYj8cqg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5861E4052D; Mon, 27 Mar 2023 08:32:48 -0300 (-03)
Date:   Mon, 27 Mar 2023 08:32:48 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH] perf bench syscall: Add fork syscall benchmark
Message-ID: <ZCF+4NQzctwgqxhM@kernel.org>
References: <1679381821-22736-1-git-send-email-yangtiezhu@loongson.cn>
 <CAM9d7chTUDnrwrOnOS-CDBjNnuyLcSx05agDS4S7DgJ2Sj_9vw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7chTUDnrwrOnOS-CDBjNnuyLcSx05agDS4S7DgJ2Sj_9vw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Mar 24, 2023 at 09:31:25PM -0700, Namhyung Kim escreveu:
> Hello,
> 
> On Mon, Mar 20, 2023 at 11:57 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
> >
> > This is a follow up patch for the execve bench which is actually
> > fork + execve, it makes sense to add the fork syscall benchmark
> > to compare the execve part precisely.
> >
> > Some archs have no __NR_fork definition which is used only as a
> > check condition to call test_fork(), let us just define it as -1
> > to avoid build error.
> >
> > Suggested-by: Namhyung Kim <namhyung@kernel.org>
> > Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied.

- Arnaldo

 
> Thanks,
> Namhyung
> 
> 
> > ---
> >  tools/arch/x86/include/uapi/asm/unistd_32.h |  4 ++--
> >  tools/arch/x86/include/uapi/asm/unistd_64.h |  3 +++
> >  tools/perf/bench/bench.h                    |  1 +
> >  tools/perf/bench/syscall.c                  | 35 +++++++++++++++++++++++++++++
> >  tools/perf/builtin-bench.c                  |  1 +
> >  5 files changed, 42 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/arch/x86/include/uapi/asm/unistd_32.h b/tools/arch/x86/include/uapi/asm/unistd_32.h
> > index 2712d5e..b8ddfc4 100644
> > --- a/tools/arch/x86/include/uapi/asm/unistd_32.h
> > +++ b/tools/arch/x86/include/uapi/asm/unistd_32.h
> > @@ -1,6 +1,6 @@
> >  /* SPDX-License-Identifier: GPL-2.0 */
> > -#ifndef __NR_execve
> > -#define __NR_execve 11
> > +#ifndef __NR_fork
> > +#define __NR_fork 2
> >  #endif
> >  #ifndef __NR_getppid
> >  #define __NR_getppid 64
> > diff --git a/tools/arch/x86/include/uapi/asm/unistd_64.h b/tools/arch/x86/include/uapi/asm/unistd_64.h
> > index a6f7fe8..f70d2cad 100644
> > --- a/tools/arch/x86/include/uapi/asm/unistd_64.h
> > +++ b/tools/arch/x86/include/uapi/asm/unistd_64.h
> > @@ -1,4 +1,7 @@
> >  /* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef __NR_fork
> > +#define __NR_fork 57
> > +#endif
> >  #ifndef __NR_execve
> >  #define __NR_execve 59
> >  #endif
> > diff --git a/tools/perf/bench/bench.h b/tools/perf/bench/bench.h
> > index e438931..edfc257 100644
> > --- a/tools/perf/bench/bench.h
> > +++ b/tools/perf/bench/bench.h
> > @@ -23,6 +23,7 @@ int bench_sched_messaging(int argc, const char **argv);
> >  int bench_sched_pipe(int argc, const char **argv);
> >  int bench_syscall_basic(int argc, const char **argv);
> >  int bench_syscall_getpgid(int argc, const char **argv);
> > +int bench_syscall_fork(int argc, const char **argv);
> >  int bench_syscall_execve(int argc, const char **argv);
> >  int bench_mem_memcpy(int argc, const char **argv);
> >  int bench_mem_memset(int argc, const char **argv);
> > diff --git a/tools/perf/bench/syscall.c b/tools/perf/bench/syscall.c
> > index fe79f7f..ea4dfc07 100644
> > --- a/tools/perf/bench/syscall.c
> > +++ b/tools/perf/bench/syscall.c
> > @@ -18,6 +18,10 @@
> >  #include <unistd.h>
> >  #include <stdlib.h>
> >
> > +#ifndef __NR_fork
> > +#define __NR_fork -1
> > +#endif
> > +
> >  #define LOOPS_DEFAULT 10000000
> >  static int loops = LOOPS_DEFAULT;
> >
> > @@ -31,6 +35,23 @@ static const char * const bench_syscall_usage[] = {
> >         NULL
> >  };
> >
> > +static void test_fork(void)
> > +{
> > +       pid_t pid = fork();
> > +
> > +       if (pid < 0) {
> > +               fprintf(stderr, "fork failed\n");
> > +               exit(1);
> > +       } else if (pid == 0) {
> > +               exit(0);
> > +       } else {
> > +               if (waitpid(pid, NULL, 0) < 0) {
> > +                       fprintf(stderr, "waitpid failed\n");
> > +                       exit(1);
> > +               }
> > +       }
> > +}
> > +
> >  static void test_execve(void)
> >  {
> >         const char *pathname = "/bin/true";
> > @@ -71,6 +92,12 @@ static int bench_syscall_common(int argc, const char **argv, int syscall)
> >                 case __NR_getpgid:
> >                         getpgid(0);
> >                         break;
> > +               case __NR_fork:
> > +                       test_fork();
> > +                       /* Only loop 10000 times to save time */
> > +                       if (i == 10000)
> > +                               loops = 10000;
> > +                       break;
> >                 case __NR_execve:
> >                         test_execve();
> >                         /* Only loop 10000 times to save time */
> > @@ -92,6 +119,9 @@ static int bench_syscall_common(int argc, const char **argv, int syscall)
> >         case __NR_getpgid:
> >                 name = "getpgid()";
> >                 break;
> > +       case __NR_fork:
> > +               name = "fork()";
> > +               break;
> >         case __NR_execve:
> >                 name = "execve()";
> >                 break;
> > @@ -143,6 +173,11 @@ int bench_syscall_getpgid(int argc, const char **argv)
> >         return bench_syscall_common(argc, argv, __NR_getpgid);
> >  }
> >
> > +int bench_syscall_fork(int argc, const char **argv)
> > +{
> > +       return bench_syscall_common(argc, argv, __NR_fork);
> > +}
> > +
> >  int bench_syscall_execve(int argc, const char **argv)
> >  {
> >         return bench_syscall_common(argc, argv, __NR_execve);
> > diff --git a/tools/perf/builtin-bench.c b/tools/perf/builtin-bench.c
> > index 814e9af..d0fcc3c 100644
> > --- a/tools/perf/builtin-bench.c
> > +++ b/tools/perf/builtin-bench.c
> > @@ -53,6 +53,7 @@ static struct bench sched_benchmarks[] = {
> >  static struct bench syscall_benchmarks[] = {
> >         { "basic",      "Benchmark for basic getppid(2) calls",         bench_syscall_basic     },
> >         { "getpgid",    "Benchmark for getpgid(2) calls",               bench_syscall_getpgid   },
> > +       { "fork",       "Benchmark for fork(2) calls",                  bench_syscall_fork      },
> >         { "execve",     "Benchmark for execve(2) calls",                bench_syscall_execve    },
> >         { "all",        "Run all syscall benchmarks",                   NULL                    },
> >         { NULL,         NULL,                                           NULL                    },
> > --
> > 2.1.0
> >

-- 

- Arnaldo
