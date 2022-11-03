Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1C86183B5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 17:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbiKCQHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 12:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbiKCQGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 12:06:35 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376611BEA0
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 09:05:04 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id bk15so3424110wrb.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 09:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5bE8gvgD+2CCW16QhdR/C9Tp3/1YBHbwrBZ657evZ5Y=;
        b=F1TCMOc2gM4JBh0MBoUOVi99cQwxmFYb93bNL2AuobLpA6CQZnI2wv20FpdiIW1z4O
         ElrcKIn4T3moqZK6tIvDlU1rjn5yq3+E5rrz9U8TJ8q/Gg+dkyFclY7bMFXgyGkE4AE1
         etxECpvWXiLAeKknhmyxim+kAuHw71s6Nq+BB4Eal7iAL69tfHRtoaItQ1P0m6B1YdCg
         AwWnUzWuyEKmk9gSlLbKPHz4jtzts8Aq4Zfo2rk316da+inBaaCLHk3VW+KGqa/vpA2F
         czcqZhNstTnL5tisz3Ee1p7wJR8cjhjuZOxVmemReEXB/3mZz1XZKGZVMGzKx1teK6E4
         9eig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5bE8gvgD+2CCW16QhdR/C9Tp3/1YBHbwrBZ657evZ5Y=;
        b=7/hLdTB9oJPrBu49BzgSOwsDBPA1qMBcfCPA+KzEm5xsudkDsSLEsde71D0tYdhfMV
         T4/Gq+o1eJmydwYzmXBhquos1AhgFf5ey3al6rLXEiBhgOJEqsyZgQs0m8fUVrFL8BhK
         N9iT9cZmcBr5f49IUqZ6/5yW7s6WOOmRYwH2H6TnWG+9MgTZ9ehNXap/152uGyQgpe4+
         cfQy+XF5nNJBEVUWIblvsmHzChQHFGp8yLeS4NR/Zwd8HLxFSqwo1TzjpK7xgGG2Jk9n
         ru3unQvmJWXMx42Rwvn8TgVLMKhs8Oc9bUhJZUqv5d3aXWncf8ObdCH1vRwRSevwR6oY
         K45Q==
X-Gm-Message-State: ACrzQf0Ma/RblE8quz6ankyNKZ9zV03ay0kQZuCOur2PoEnGfvFDNnl+
        KXcbsDbiMIcnhGDDXYH1WHfQV4otw+NtsnF0OltbskQo41o=
X-Google-Smtp-Source: AMsMyM7KGjzWxsn9UIlOy5zupS8mkGqY+lpsgwhZ4+kB961c8ksKJG+519bRWFK0ps8avU81e13cyeIrXLbAv3qbc3M=
X-Received: by 2002:a05:6000:1817:b0:236:77f0:ef60 with SMTP id
 m23-20020a056000181700b0023677f0ef60mr18849090wrh.343.1667491502407; Thu, 03
 Nov 2022 09:05:02 -0700 (PDT)
MIME-Version: 1.0
References: <20221103045437.163510-1-irogers@google.com> <20221103045437.163510-7-irogers@google.com>
 <Y2PgBPeZsd9+YWB4@kernel.org> <Y2Pgz7luG77Wr+Ci@kernel.org> <Y2Pj0KVbbw9rMcPH@kernel.org>
In-Reply-To: <Y2Pj0KVbbw9rMcPH@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 3 Nov 2022 09:04:49 -0700
Message-ID: <CAP-5=fXkM52E5VvX9s2CfvF8ckQvcbSm8N_7BCfhW3dyuH7YUg@mail.gmail.com>
Subject: Re: [PATCH v1 6/7] perf trace: 5sec fix libbpf 1.0+ compatibility
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 3, 2022 at 8:52 AM Arnaldo Carvalho de Melo <acme@kernel.org> w=
rote:
>
> Em Thu, Nov 03, 2022 at 12:39:59PM -0300, Arnaldo Carvalho de Melo escrev=
eu:
> > Em Thu, Nov 03, 2022 at 12:36:36PM -0300, Arnaldo Carvalho de Melo escr=
eveu:
> > > [root@quaco ~]# perf trace -e /home/acme/git/perf/tools/perf/examples=
/bpf/5sec.c
> > > /home/acme/git/perf/tools/perf/examples/bpf/5sec.c:42:10: fatal error=
: 'bpf/bpf_helpers.h' file not found
> > > #include <bpf/bpf_helpers.h>
> > >          ^~~~~~~~~~~~~~~~~~~
> > > 1 error generated.
> > > ERROR:      unable to compile /home/acme/git/perf/tools/perf/examples=
/bpf/5sec.c
> > > Hint:       Check error message shown above.
> > > Hint:       You can also pre-compile it into .o using:
> > >                     clang -target bpf -O2 -c /home/acme/git/perf/tool=
s/perf/examples/bpf/5sec.c
> > >             with proper -I and -D options.
> > > event syntax error: '/home/acme/git/perf/tools/perf/examples/bpf/5sec=
.c'
> > >                      \___ Failed to load /home/acme/git/perf/tools/pe=
rf/examples/bpf/5sec.c from source: Error when compiling BPF scriptlet
> > >
> > > (add -v to see detail)
> > > Run 'perf list' for a list of valid events
> > >
> > >  Usage: perf trace [<options>] [<command>]
> > >     or: perf trace [<options>] -- <command> [<options>]
> > >     or: perf trace record [<options>] [<command>]
> > >     or: perf trace record [<options>] -- <command> [<options>]
> > >
> > >     -e, --event <event>   event/syscall selector. use 'perf list' to =
list available events
> > > [root@quaco ~]#
> > >
> > > It is not even finding it, in this machine I have libbpf 0.7.0, so th=
ere
> > > is a /usr/include/bpf/bpf_helpers.h, but probably that isn't in the
> > > include path set up to build the tools/perf/examples/bpf/ files, perh=
aps
> > > it should use:
> > >
> > > -Itools/lib/  so that it gets tools/lib/bpf_helpers.h?
> > >
> > > Trying to get this tested...
> >
> > Running with -v:
> >
> > llvm compiling command : /usr/lib64/ccache/clang -D__KERNEL__ -D__NR_CP=
US__=3D8 -DLINUX_VERSION_CODE=3D0x51310 -g -I/home/acme/lib/perf/include/bp=
f -nostdinc -I./arch/x86/include -I./arch/x86/include/generated  -I./includ=
e -I./arch/x86/include/uapi -I./arch/x86/include/generated/uapi -I./include=
/uapi -I./include/generated/uapi -include ./include/linux/compiler-version.=
h -include ./include/linux/kconfig.h  -Wno-unused-value -Wno-pointer-sign -=
working-directory /lib/modules/5.19.16-200.fc36.x86_64/build -c /home/acme/=
git/perf/tools/perf/examples/bpf/5sec.c -target bpf  -g -O2 -o -
> > /home/acme/git/perf/tools/perf/examples/bpf/5sec.c:42:10: fatal error: =
'bpf/bpf_helpers.h' file not found
> >
> > There is still that -I/home/acme/lib/perf/include/bpf, I'll remove it
> > from the include path and try to replace it with the libbpf path...
>
> Ok, works with the patch below, that needs some more renaming from "perf_=
" to
> "libbpf_", etc:
>
> [root@quaco ~]# perf trace -e /home/acme/git/perf/tools/perf/examples/bpf=
/5sec.c  sleep 5
>      0.000 sleep/160828 perf_bpf_probe:hrtimer_nanosleep(__probe_ip: -147=
4734416, rqtp: 5000000000)
> [root@quaco ~]#
>
> Since I have:
>
> [root@quaco ~]# cat ~/.perfconfig
> [llvm]
>         dump-obj =3D true
>         clang-opt =3D -g
> #
>
> I end up with:
>
> [root@quaco ~]# ls -la /home/acme/git/perf/tools/perf/examples/bpf/5sec.o
> -rw-r--r--. 1 root root 3696 Nov  3 12:47 /home/acme/git/perf/tools/perf/=
examples/bpf/5sec.o
> [root@quaco ~]# file /home/acme/git/perf/tools/perf/examples/bpf/5sec.o
> /home/acme/git/perf/tools/perf/examples/bpf/5sec.o: ELF 64-bit LSB reloca=
table, eBPF, version 1 (SYSV), with debug_info, not stripped
> [root@quaco ~]#
>
> and can test with the pre-built .o eBPF bytecode + capped backtrace:
>
> [root@quaco ~]# perf trace -e /home/acme/git/perf/tools/perf/examples/bpf=
/5sec.o/max-stack=3D6/  sleep 5
>      0.000 sleep/161037 perf_bpf_probe:hrtimer_nanosleep(__probe_ip: -147=
4734416, rqtp: 5000000000)
>                                        hrtimer_nanosleep ([kernel.kallsym=
s])
>                                        common_nsleep ([kernel.kallsyms])
>                                        __x64_sys_clock_nanosleep ([kernel=
.kallsyms])
>                                        do_syscall_64 ([kernel.kallsyms])
>                                        entry_SYSCALL_64_after_hwframe ([k=
ernel.kallsyms])
>                                        __GI___clock_nanosleep (/usr/lib64=
/libc.so.6)
> [root@quaco ~]#
>
> I'll test the other examples with these changes after I drive Pedro to
> school and get back to the office.

Thanks, I was somewhat coding in the dark with this as I was using a
bpf object file and clearly there's been some attention missed for a
while in these code paths. I couldn't get the hello variant to do
anything with the openat tracing it was set up for, for example, the
change puts the call on the sys_enter raw syscall. I suspect you
remember how these things should be and I'm happy to roll a v2, have
you fix it, etc.

Fwiw, two things I'd like to see further here is somehow the augmented
code to be the default (with a BPF skeleton possibly) and an ability
for perf_event_open tracing to dump the perf_event_attr. I'm unclear
on the advantages of having different augmenters. Perhaps we could
just drop support for different augmenters, use BPF skeletons for the
raw syscall version and keep the BPF logic in parse events for adding
filters - the process of doing augmentation isn't clear to me even
after having produced these changes. There is quite a bit of plumbing
necessary to remove the notion that the BPF object comes from event
parsing and I suspect to achieve this in the current code there is
some overhead that the skeleton could remove - like the empty
sys_enter functions I added.

Anyway, fixing libbpf 1.0+ and removing a header file called bpf.h
were what I was after achieving here :-)

Thanks,
Ian


> - Arnaldo
>
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index d3d3c13a9f25b55c..067a6e56eeacc9fc 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -1239,7 +1239,7 @@ includedir =3D $(abspath $(prefix)/$(includedir_rel=
ative))
>  mandir =3D share/man
>  infodir =3D share/info
>  perfexecdir =3D libexec/perf-core
> -perf_include_dir =3D lib/perf/include
> +perf_include_dir =3D /usr/include
>  perf_examples_dir =3D lib/perf/examples
>  sharedir =3D $(prefix)/share
>  template_dir =3D share/perf-core/templates
> diff --git a/tools/perf/util/llvm-utils.c b/tools/perf/util/llvm-utils.c
> index 2dc7970074196ca8..a5cac85783d8711f 100644
> --- a/tools/perf/util/llvm-utils.c
> +++ b/tools/perf/util/llvm-utils.c
> @@ -495,7 +495,7 @@ int llvm__compile_bpf(const char *path, void **p_obj_=
buf,
>
>         snprintf(linux_version_code_str, sizeof(linux_version_code_str),
>                  "0x%x", kernel_version);
> -       if (asprintf(&perf_bpf_include_opts, "-I%s/bpf", perf_include_dir=
) < 0)
> +       if (asprintf(&perf_bpf_include_opts, "-I%s/", perf_include_dir) <=
 0)
>                 goto errout;
>         force_set_env("NR_CPUS", nr_cpus_avail_str);
>         force_set_env("LINUX_VERSION_CODE", linux_version_code_str);
