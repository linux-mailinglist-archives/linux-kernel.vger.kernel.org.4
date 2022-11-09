Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C686C622F0B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 16:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbiKIP10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 10:27:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbiKIP1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 10:27:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282EBD45;
        Wed,  9 Nov 2022 07:27:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACDB861B97;
        Wed,  9 Nov 2022 15:27:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCC58C433D6;
        Wed,  9 Nov 2022 15:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668007642;
        bh=gZ0nqbFGVkumIPT57h2utnBg8r8WhhmOCZym5Ljy+ak=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u5n3ZMnu6c9Pmg+Up2/b74maQZyZY3qflbcQMymembTeSw4iBjklqjUEUYnCO76l8
         l1DPLt/R4YePbo3L+WQJJjVqNHCSZiSloNbGtaKL42DUeREYNZYtmdQ4LYYeR/BwcT
         o+OYR6fXsvlxMsHQ5e/nq7qzylzK+3oPcuZE04LmNG66XlH2q56i9DsT2A30u2eUiY
         PwNl+pBJxfdtQkPzJ/C54KbOxlSj7hHCufgLBf1PtzakQi2QYWXVw+cQJMNP9qyVxd
         HW4gausUkeMRHesdVKsxjjJ03pGQolkQ37iFfvaWiLO5p/yFKoItOdsAZTNEnCMAxg
         zW8oZqg+qkr9A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 578A64034E; Wed,  9 Nov 2022 12:27:19 -0300 (-03)
Date:   Wed, 9 Nov 2022 12:27:19 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v1 00/14] Fix perf tools/lib includes
Message-ID: <Y2vG13WVahGoib57@kernel.org>
References: <20221108073518.1154450-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221108073518.1154450-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Nov 07, 2022 at 11:35:04PM -0800, Ian Rogers escreveu:
> The previous build would add -Itools/lib and get dependencies for
> libtraceevent, libsubcmd, libsymbol, libapi and libbpf meaning that
> overriding these libraries would change the link time dependency but
> the headers would erroneously come from tools/lib. Fix the build to
> install headers and then depend on these. To reduce exposing internal
> headers/APIs some clean up is performed. tools/lib/symbol has a
> Makefile added, while tools/lib/api and tools/lib/subcmd have install
> targets added. The pattern used for the dependencies in Makefile.perf
> is modelled on libbpf.

It builds with O=, I tried it one by one, but  there are problems with
make from a detached tarball, that is how I do the container builds, see
below, I'm trying to figure this out...

⬢[acme@toolbox perf]$ make perf-tar-src-pkg
  TAR
  PERF_VERSION = 6.1.rc3.g7e5d8b7a1fbd
⬢[acme@toolbox perf]$ mv perf-6.1.0-rc3.tar /tmp
⬢[acme@toolbox perf]$ cd /tmp
⬢[acme@toolbox tmp]$ tar xf perf-6.1.0-rc3.tar
⬢[acme@toolbox tmp]$ cd perf-6.1.0-rc3/
⬢[acme@toolbox perf-6.1.0-rc3]$ make -C tools/perf
make: Entering directory '/tmp/perf-6.1.0-rc3/tools/perf'
  BUILD:   Doing 'make -j32' parallel build
  HOSTCC  fixdep.o
  HOSTLD  fixdep-in.o
  LINK    fixdep

Auto-detecting system features:
...                                   dwarf: [ on  ]
...                      dwarf_getlocations: [ on  ]
...                                   glibc: [ on  ]
...                                  libbfd: [ on  ]
...                          libbfd-buildid: [ on  ]
...                                  libcap: [ on  ]
...                                  libelf: [ on  ]
...                                 libnuma: [ on  ]
...                  numa_num_possible_cpus: [ on  ]
...                                 libperl: [ on  ]
...                               libpython: [ on  ]
...                               libcrypto: [ on  ]
...                               libunwind: [ on  ]
...                      libdw-dwarf-unwind: [ on  ]
...                                    zlib: [ on  ]
...                                    lzma: [ on  ]
...                               get_cpuid: [ on  ]
...                                     bpf: [ on  ]
...                                  libaio: [ on  ]
...                                 libzstd: [ on  ]

  GEN     common-cmds.h
  PERF_VERSION = 6.1.rc3.g7e5d8b7a1fbd
  CC      perf-read-vdso32
  GEN     perf-archive
  GEN     perf-iostat
  CC      dlfilters/dlfilter-test-api-v0.o
  CC      dlfilters/dlfilter-show-cycles.o
  CC      jvmti/libjvmti.o
make[3]: *** No rule to make target '/tmp/perf-6.1.0-rc3/tools/perf/libsymbol/libsymbol.a'.  Stop.
make[2]: *** [Makefile.perf:907: /tmp/perf-6.1.0-rc3/tools/perf/libsymbol/libsymbol.a] Error 2
make[2]: *** Waiting for unfinished jobs....
  CC      jvmti/jvmti_agent.o
  CC      jvmti/libstring.o
  CC      jvmti/libctype.o
  GEN     pmu-events/pmu-events.c
  INSTALL headers
  CC      /tmp/perf-6.1.0-rc3/tools/perf/libsubcmd/exec-cmd.o
  CC      /tmp/perf-6.1.0-rc3/tools/perf/libsubcmd/help.o
  CC      /tmp/perf-6.1.0-rc3/tools/perf/libsubcmd/pager.o
  CC      /tmp/perf-6.1.0-rc3/tools/perf/libsubcmd/parse-options.o
  CC      /tmp/perf-6.1.0-rc3/tools/perf/libsubcmd/run-command.o
  CC      /tmp/perf-6.1.0-rc3/tools/perf/libsubcmd/sigchain.o
  CC      /tmp/perf-6.1.0-rc3/tools/perf/libsubcmd/subcmd-config.o
  INSTALL headers
  CC      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent/event-parse.o
  CC      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_jbd2.o
  CC      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_hrtimer.o
  CC      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_kmem.o
  CC      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_kvm.o
  CC      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_mac80211.o
  CC      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_function.o
  CC      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_sched_switch.o
  INSTALL headers
  CC      /tmp/perf-6.1.0-rc3/tools/perf/libperf/core.o
  CC      /tmp/perf-6.1.0-rc3/tools/perf/libapi/cpu.o
  MKDIR   /tmp/perf-6.1.0-rc3/tools/perf/libapi/fd/
  MKDIR   /tmp/perf-6.1.0-rc3/tools/perf/libapi/fs/
  MKDIR   /tmp/perf-6.1.0-rc3/tools/perf/libapi/fs/
  MKDIR   /tmp/perf-6.1.0-rc3/tools/perf/libapi/fs/
  CC      /tmp/perf-6.1.0-rc3/tools/perf/libapi/fd/array.o
  CC      /tmp/perf-6.1.0-rc3/tools/perf/libapi/fs/fs.o
  GEN     /tmp/perf-6.1.0-rc3/tools/perf/libbpf/bpf_helper_defs.h
  CC      /tmp/perf-6.1.0-rc3/tools/perf/libapi/fs/tracing_path.o
  CC      /tmp/perf-6.1.0-rc3/tools/perf/libapi/fs/cgroup.o
  INSTALL /tmp/perf-6.1.0-rc3/tools/perf/libbpf/include/bpf/bpf.h
  CC      /tmp/perf-6.1.0-rc3/tools/perf/libapi/debug.o
  CC      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_futex.o
  CC      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_xen.o
  CC      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_scsi.o
  CC      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_cfg80211.o
  CC      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_tlb.o
  LD      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_jbd2-in.o
  LD      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_hrtimer-in.o
  INSTALL /tmp/perf-6.1.0-rc3/tools/perf/libbpf/include/bpf/libbpf.h
  LD      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_kmem-in.o
  INSTALL headers
  INSTALL /tmp/perf-6.1.0-rc3/tools/perf/libbpf/include/bpf/btf.h
  LD      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_mac80211-in.o
  LD      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_sched_switch-in.o
  CC      /tmp/perf-6.1.0-rc3/tools/perf/libperf/cpumap.o
  CC      /tmp/perf-6.1.0-rc3/tools/perf/libperf/threadmap.o
  CC      /tmp/perf-6.1.0-rc3/tools/perf/libapi/str_error_r.o
  INSTALL /tmp/perf-6.1.0-rc3/tools/perf/libbpf/include/bpf/libbpf_common.h
  LINK    /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_jbd2.so
  LINK    /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_hrtimer.so
  INSTALL /tmp/perf-6.1.0-rc3/tools/perf/libbpf/include/bpf/libbpf_legacy.h
  LD      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_function-in.o
  CC      /tmp/perf-6.1.0-rc3/tools/perf/libperf/evsel.o
  LD      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_kvm-in.o
  LINK    /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_kmem.so
  LINK    /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_mac80211.so
  LINK    /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_sched_switch.so
  INSTALL /tmp/perf-6.1.0-rc3/tools/perf/libbpf/include/bpf/bpf_helpers.h
  INSTALL /tmp/perf-6.1.0-rc3/tools/perf/libbpf/include/bpf/bpf_tracing.h
  CC      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent/event-plugin.o
  CC      /tmp/perf-6.1.0-rc3/tools/perf/libperf/evlist.o
  CC      /tmp/perf-6.1.0-rc3/tools/perf/libperf/mmap.o
  CC      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent/trace-seq.o
  INSTALL /tmp/perf-6.1.0-rc3/tools/perf/libbpf/include/bpf/bpf_endian.h
  INSTALL /tmp/perf-6.1.0-rc3/tools/perf/libbpf/include/bpf/bpf_core_read.h
if [ ! -d ''/tmp/perf-6.1.0-rc3/tools/perf/libapi'/include/api/fs' ]; then install -d -m 755 ''/tmp/perf-6.1.0-rc3/tools/perf/libapi'/include/api/fs'; fi; install fs/tracing_path.h -m 644 ''/tmp/perf-6.1.0-rc3/tools/perf/libapi'/include/api/fs';
  LD      /tmp/perf-6.1.0-rc3/tools/perf/libapi/fd/libapi-in.o
  CC      /tmp/perf-6.1.0-rc3/tools/perf/libperf/zalloc.o
  CC      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent/parse-filter.o
  CC      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent/parse-utils.o
  CC      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent/kbuffer-parse.o
  LD      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_xen-in.o
  INSTALL /tmp/perf-6.1.0-rc3/tools/perf/libbpf/include/bpf/skel_internal.h
  INSTALL /tmp/perf-6.1.0-rc3/tools/perf/libbpf/include/bpf/libbpf_version.h
  CC      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent/tep_strerror.o
  INSTALL /tmp/perf-6.1.0-rc3/tools/perf/libbpf/include/bpf/usdt.bpf.h
  INSTALL /tmp/perf-6.1.0-rc3/tools/perf/libbpf/include/bpf/bpf_helper_defs.h
  CC      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent/event-parse-api.o
  CC      /tmp/perf-6.1.0-rc3/tools/perf/libperf/xyarray.o
  LINK    /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_function.so
  LINK    /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_xen.so
  LD      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_futex-in.o
  CC      /tmp/perf-6.1.0-rc3/tools/perf/libperf/lib.o
  LD      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_scsi-in.o
  LD      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_cfg80211-in.o
  MKDIR   /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/
  MKDIR   /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/
  MKDIR   /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/
  MKDIR   /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/
  LINK    /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_kvm.so
  CC      /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/libbpf.o
  LINK    /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_futex.so
  LINK    /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_scsi.so
  CC      /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/bpf.o
  LD      /tmp/perf-6.1.0-rc3/tools/perf/libapi/fs/libapi-in.o
  CC      /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/nlattr.o
  CC      /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/btf.o
  MKDIR   /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/
  LD      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_tlb-in.o
  LINK    /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_cfg80211.so
  CC      /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/str_error.o
  CC      /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/netlink.o
  LD      /tmp/perf-6.1.0-rc3/tools/perf/libapi/libapi-in.o
  LD      jvmti/jvmti-in.o
  CC      /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/libbpf_errno.o
  LINK    /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/plugin_tlb.so
  CC      /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/bpf_prog_linfo.o
  AR      /tmp/perf-6.1.0-rc3/tools/perf/libapi/libapi.a
  CC      /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/libbpf_probes.o
  CC      /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/hashmap.o
  CC      /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/btf_dump.o
  CC      /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/ringbuf.o
  CC      /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/strset.o
  GEN     /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent_plugins/libtraceevent-dynamic-list
  CC      /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/linker.o
  CC      /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/gen_loader.o
  CC      /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/relo_core.o
  CC      /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/usdt.o
  LD      /tmp/perf-6.1.0-rc3/tools/perf/libsubcmd/libsubcmd-in.o
  AR      /tmp/perf-6.1.0-rc3/tools/perf/libsubcmd/libsubcmd.a
  LD      /tmp/perf-6.1.0-rc3/tools/perf/libperf/libperf-in.o
  LD      /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent/libtraceevent-in.o
  AR      /tmp/perf-6.1.0-rc3/tools/perf/libperf/libperf.a
  LINK    /tmp/perf-6.1.0-rc3/tools/perf/libtraceevent/libtraceevent.a
  CC      pmu-events/pmu-events.o
  LD      pmu-events/pmu-events-in.o
  LD      /tmp/perf-6.1.0-rc3/tools/perf/libbpf/staticobjs/libbpf-in.o
  LINK    /tmp/perf-6.1.0-rc3/tools/perf/libbpf/libbpf.a
make[1]: *** [Makefile.perf:240: sub-make] Error 2
make: *** [Makefile:70: all] Error 2
make: Leaving directory '/tmp/perf-6.1.0-rc3/tools/perf'
⬢[acme@toolbox perf-6.1.0-rc3]$


 
> The problem and solution were motivated by this issue and discussion:
> https://lore.kernel.org/lkml/CAEf4BzbbOHQZUAe6iWaehKCPQAf3VC=hq657buqe2_yRKxaK-A@mail.gmail.com/
> 
> Ian Rogers (14):
>   tools lib api: Add install target
>   tools lib subcmd: Add install target
>   perf build: Install libsubcmd locally when building
>   perf build: Install libapi locally when building
>   perf build: Install libperf locally when building
>   perf build: Install libtraceevent locally when building
>   tools lib api: Add missing install headers
>   tools lib perf: Add missing install headers
>   tool lib symbol: Add Makefile/Build
>   perf build: Install libsymbol locally when building
>   perf expr: Tidy hashmap dependency
>   perf thread_map: Reduce exposure of libperf internal API
>   perf cpumap: Tidy libperf includes
>   perf build: Use tools/lib headers from install path
> 
>  tools/lib/api/Makefile                        |  52 ++++++
>  tools/lib/perf/Makefile                       |  10 +-
>  tools/lib/subcmd/Makefile                     |  49 ++++++
>  tools/lib/symbol/Build                        |   1 +
>  tools/lib/symbol/Makefile                     | 115 +++++++++++++
>  tools/perf/.gitignore                         |   7 +-
>  tools/perf/Makefile.config                    |   2 -
>  tools/perf/Makefile.perf                      | 152 ++++++++++++------
>  tools/perf/builtin-stat.c                     |   1 +
>  tools/perf/builtin-trace.c                    |   4 +-
>  tools/perf/tests/cpumap.c                     |   2 +-
>  tools/perf/tests/expr.c                       |   1 +
>  tools/perf/tests/openat-syscall.c             |   1 +
>  tools/perf/tests/pmu-events.c                 |   1 +
>  tools/perf/tests/thread-map.c                 |   1 +
>  tools/perf/util/Build                         |   5 -
>  tools/perf/util/auxtrace.h                    |   2 +-
>  tools/perf/util/bpf-loader.c                  |   4 -
>  tools/perf/util/bpf_counter.c                 |   2 +-
>  tools/perf/util/cpumap.c                      |   1 +
>  tools/perf/util/cpumap.h                      |   2 +-
>  tools/perf/util/evsel.c                       |   5 +-
>  tools/perf/util/evsel.h                       |   2 -
>  tools/perf/util/expr.c                        |   1 +
>  tools/perf/util/expr.h                        |   7 +-
>  tools/perf/util/metricgroup.c                 |   1 +
>  tools/perf/util/python.c                      |   6 +-
>  .../scripting-engines/trace-event-python.c    |   2 +-
>  tools/perf/util/stat-shadow.c                 |   1 +
>  tools/perf/util/stat.c                        |   4 -
>  tools/perf/util/thread_map.c                  |   1 +
>  tools/perf/util/thread_map.h                  |   2 -
>  32 files changed, 361 insertions(+), 86 deletions(-)
>  create mode 100644 tools/lib/symbol/Build
>  create mode 100644 tools/lib/symbol/Makefile
> 
> -- 
> 2.38.1.431.g37b22c650d-goog

-- 

- Arnaldo
