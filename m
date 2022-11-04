Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2798E618D28
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 01:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbiKDAVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 20:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiKDAVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 20:21:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514CE205F2;
        Thu,  3 Nov 2022 17:21:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E405961FCB;
        Fri,  4 Nov 2022 00:21:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA3F7C433D6;
        Fri,  4 Nov 2022 00:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667521270;
        bh=dZf7UOWFjzjgRlUGjCkHuP3jDdpPVutaFjZJBxrMiIk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g818dXngYDEKEoxAAwl9/axoXbClNQHjVJ1/gen8s0bSCsQJMaJorHEzOJmCqeLY1
         LIXTA9co8l3hFHpC+QyY1l2ea2PZ9lIIPDP4a65dpWYI+8/zo+z6zYcfBLvQVFPsBi
         4SbMN34oh7R7MrZAIwlBeiAqejXxA6eMcOYWqCs1oblmorvvQq84w8r2RfJqBUvzoN
         4wvA/4SPhTNN1PGNqYpzJQNpIe/QoDgHIXoBkLDqkttrg9kuxy+StsfdUeBoB76YI8
         Cq0BL94Cr9QH0e9WPayEFZKAId6NuSU8OEX5wGVjpGMQ6+Y5sD4Q28e0Oxj0ybeTkv
         hI/pBf2WCLFyw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BC3F14034E; Thu,  3 Nov 2022 21:21:06 -0300 (-03)
Date:   Thu, 3 Nov 2022 21:21:06 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v1 6/7] perf trace: 5sec fix libbpf 1.0+ compatibility
Message-ID: <Y2Ra8twZ/4Wqi2JN@kernel.org>
References: <20221103045437.163510-1-irogers@google.com>
 <20221103045437.163510-7-irogers@google.com>
 <Y2PgBPeZsd9+YWB4@kernel.org>
 <Y2Pgz7luG77Wr+Ci@kernel.org>
 <Y2Pj0KVbbw9rMcPH@kernel.org>
 <CAP-5=fXkM52E5VvX9s2CfvF8ckQvcbSm8N_7BCfhW3dyuH7YUg@mail.gmail.com>
 <Y2QcgdJNXE/bVZvk@kernel.org>
 <Y2Q0NSeoEqwUztFe@kernel.org>
 <CAP-5=fUcawweX-n2nmGg5+ZEo5nG7QuRN7yyVtz-FmUGctrEjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fUcawweX-n2nmGg5+ZEo5nG7QuRN7yyVtz-FmUGctrEjw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Nov 03, 2022 at 03:01:21PM -0700, Ian Rogers escreveu:
> On Thu, Nov 3, 2022 at 2:35 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >
> > With this:
> >
> > diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> > index d3d3c13a9f25b55c..067a6e56eeacc9fc 100644
> > --- a/tools/perf/Makefile.config
> > +++ b/tools/perf/Makefile.config
> > @@ -1239,7 +1239,7 @@ includedir = $(abspath $(prefix)/$(includedir_relative))
> >  mandir = share/man
> >  infodir = share/info
> >  perfexecdir = libexec/perf-core
> > -perf_include_dir = lib/perf/include
> > +perf_include_dir = /usr/include
> >  perf_examples_dir = lib/perf/examples
> >  sharedir = $(prefix)/share
> >  template_dir = share/perf-core/templates
> > diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
> > index 13c72fd602c307e4..98a2731c011339ba 100644
> > --- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
> > +++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
> > @@ -17,8 +17,9 @@
> >  #include <linux/bpf.h>
> >  #include <bpf/bpf_helpers.h>
> >  #include <linux/limits.h>
> > -#include <stdbool.h>
> > -#include <sys/socket.h>
> > +
> > +typedef char bool;
> > +typedef int pid_t;
> >
> >  /* bpf-output associated map */
> >  struct __augmented_syscalls__ {
> > @@ -94,6 +95,30 @@ struct pids_filtered {
> >         __uint(max_entries, 64);
> >  } pids_filtered SEC(".maps");
> >
> > +/*
> > + * Desired design of maximum size and alignment (see RFC2553)
> > + */
> > +#define _K_SS_MAXSIZE   128     /* Implementation specific max size */
> > +
> > +typedef unsigned short sa_family_t;
> > +
> > +/*
> > + * The definition uses anonymous union and struct in order to control the
> > + * default alignment.
> > + */
> > +struct sockaddr_storage {
> > +        union {
> > +                struct {
> > +                        sa_family_t    ss_family; /* address family */
> > +                        /* Following field(s) are implementation specific */
> > +                        char __data[_K_SS_MAXSIZE - sizeof(unsigned short)];
> > +                                /* space to achieve desired size, */
> > +                                /* _SS_MAXSIZE value minus size of ss_family */
> > +                };
> > +                void *__align; /* implementation specific desired alignment */
> > +        };
> > +};
> > +
> >  struct augmented_args_payload {
> >         struct syscall_enter_args args;
> >         union {
> > diff --git a/tools/perf/examples/bpf/empty.c b/tools/perf/examples/bpf/empty.c
> > index 3e296c0c53d7d8e2..e4872c48a484f218 100644
> > --- a/tools/perf/examples/bpf/empty.c
> > +++ b/tools/perf/examples/bpf/empty.c
> > @@ -7,6 +7,6 @@ struct syscall_enter_args;
> >  SEC("raw_syscalls:sys_enter")
> >  int sys_enter(struct syscall_enter_args *args)
> >  {
> > -       return 0;
> > +       return 1;
> >  }
> >  char _license[] SEC("license") = "GPL";
> > diff --git a/tools/perf/util/llvm-utils.c b/tools/perf/util/llvm-utils.c
> > index 2dc7970074196ca8..a5cac85783d8711f 100644
> > --- a/tools/perf/util/llvm-utils.c
> > +++ b/tools/perf/util/llvm-utils.c
> > @@ -495,7 +495,7 @@ int llvm__compile_bpf(const char *path, void **p_obj_buf,
> >
> >         snprintf(linux_version_code_str, sizeof(linux_version_code_str),
> >                  "0x%x", kernel_version);
> > -       if (asprintf(&perf_bpf_include_opts, "-I%s/bpf", perf_include_dir) < 0)
> > +       if (asprintf(&perf_bpf_include_opts, "-I%s/", perf_include_dir) < 0)
> >                 goto errout;
> >         force_set_env("NR_CPUS", nr_cpus_avail_str);
> >         force_set_env("LINUX_VERSION_CODE", linux_version_code_str);
> >
> >
> > The connect calls gets served, tomorrow, if you don't beat me I'll apply
> > the series after adding these minimal changes so that we have this
> > working with libbpf 1.0 and then we can move from there, with a switch
> > to a BPF skel, simplest things first, then deal with faults at pointer
> > payload copy, which is another avenue, AFAIK with solutions already.
> 
> So I was trying to be clean and not redefine too much. My clang
> command line was:
> 
> clang -target bpf -O2 -g -c -I/usr/include/x86_64-linux-gnu
> -D__NR_CPUS__=16 -D__x86_64__=1

Sure, I haven't even checked why that is needed, maybe its not anymore.

I just tried the first hunch about the header files, those other
variables maybe were needed long ago, maybe its just more stuff to trow
out in the direction of doing it the modern way, BPF skels.
 
> It'd be nice to just drop the need for __NR_CPUS__ and have it be
> dynamic, the skeleton approach would require this. Not sure how to
> workaround the x86 define and path :-/ Perhaps send out your changes
> for review and I can look at and test them.

Done deal, early tomorrow I'll send it and wait for your review.

- Arnaldo
