Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E83A46428D6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 13:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbiLEM5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 07:57:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbiLEM5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 07:57:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853E82E9;
        Mon,  5 Dec 2022 04:57:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 82A82B810A4;
        Mon,  5 Dec 2022 12:57:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D12ECC433D6;
        Mon,  5 Dec 2022 12:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670245051;
        bh=MIDKkgmrTvGAepWKmwBt01P2v5zbCinu8Z/znrpyoP4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sfLazdBmH6ZqnnrwBxHEu+9yTrKZS70ByJX0KCDzFMS1mH+ndnP47xeCJ7EXs4NhV
         Y9MhSL7u0sLMBWxjoZxLeEtEUMzfKXYtiTsEjEU2AcAuZX5JXCCONnfFDOiGu8iCo6
         nM2+dL0PBE3UAXJOaGFhhLuOBBJCd1EjzpBYPRDSOO+siyewL0Ps1GpYX+KF2MahA7
         eeCECfUXvXPuyKtbvEHHjeHyFzveLeqf0SaBtrCg0uZSTCHnpNdFoepvReIF8w7xEV
         3MxxwfwNyQL+EoEu5Lntxs8cWYoPJ929QfmsLacwnOBf1iKxR+bqcGpJ8e8HLm0YoO
         URWFtraqXjCSQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 79E4340404; Mon,  5 Dec 2022 09:57:27 -0300 (-03)
Date:   Mon, 5 Dec 2022 09:57:27 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf build: Fixes for LIBTRACEEVENT_DYNAMIC
Message-ID: <Y43qt8YRP1M8lTvP@kernel.org>
References: <20221129192924.1580537-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221129192924.1580537-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Nov 29, 2022 at 11:29:24AM -0800, Ian Rogers escreveu:
> If LIBTRACEEVENT_DYNAMIC is enabled then avoid the install step for
> the plugins. If disabled correct DESTDIR so that the plugins are
> installed under <lib>/traceevent/plugins.
> 
> Fixes: ef019df01e20 ("perf build: Install libtraceevent locally when building")
> Reported-by: Alexander Gordeev <agordeev@linux.ibm.com>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/Makefile.perf | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index a17a6ea85e81..f4cd946fe91a 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -884,7 +884,7 @@ $(LIBTRACEEVENT_DYNAMIC_LIST): libtraceevent_plugins
>  
>  install-traceevent-plugins: libtraceevent_plugins
>  	$(Q)$(MAKE) -C $(LIBTRACEEVENT_PLUGINS_DIR) O=$(LIBTRACEEVENT_PLUGINS_OUTPUT) \
> -		DESTDIR=$(LIBTRACEEVENT_PLUGINS_DESTDIR) prefix= \
> +		DESTDIR=$(DESTDIR_SQ) prefix= \
>  		$(LIBTRACEEVENT_FLAGS) install
>  endif
>  
> @@ -1093,7 +1093,11 @@ install-tests: all install-gtk
>  		$(INSTALL) tests/shell/coresight/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/coresight'
>  	$(Q)$(MAKE) -C tests/shell/coresight install-tests
>  
> -install-bin: install-tools install-tests install-traceevent-plugins
> +install-bin: install-tools install-tests
> +
> +ifndef LIBTRACEEVENT_DYNAMIC
> +install-bin: install-traceevent-plugins
> +endif
>  
>  install: install-bin try-install-man

After applying this:

⬢[acme@toolbox perf]$ alias m
alias m='perf stat -e cycles:u,instructions:u make -k BUILD_BPF_SKEL=1 CORESIGHT=1 O=/tmp/build/perf -C tools/perf install-bin && git status && perf test python'
⬢[acme@toolbox perf]$

⬢[acme@toolbox perf]$ m
make: Entering directory '/var/home/acme/git/perf/tools/perf'
  BUILD:   Doing 'make -j32' parallel build
Warning: Kernel ABI header at 'tools/arch/x86/include/asm/msr-index.h' differs from latest version at 'arch/x86/include/asm/msr-index.h'
diff -u tools/arch/x86/include/asm/msr-index.h arch/x86/include/asm/msr-index.h
Warning: Kernel ABI header at 'tools/arch/arm64/include/uapi/asm/perf_regs.h' differs from latest version at 'arch/arm64/include/uapi/asm/perf_regs.h'
diff -u tools/arch/arm64/include/uapi/asm/perf_regs.h arch/arm64/include/uapi/asm/perf_regs.h
Warning: Kernel ABI header at 'tools/arch/arm64/include/asm/cputype.h' differs from latest version at 'arch/arm64/include/asm/cputype.h'
diff -u tools/arch/arm64/include/asm/cputype.h arch/arm64/include/asm/cputype.h
Warning: Kernel ABI header at 'tools/perf/arch/powerpc/entry/syscalls/syscall.tbl' differs from latest version at 'arch/powerpc/kernel/syscalls/syscall.tbl'
diff -u tools/perf/arch/powerpc/entry/syscalls/syscall.tbl arch/powerpc/kernel/syscalls/syscall.tbl

  INSTALL libsubcmd_headers
  INSTALL traceevent_headers
  INSTALL libapi_headers
  INSTALL libperf_headers
  INSTALL libsymbol_headers
  INSTALL libbpf_headers
  CC      /tmp/build/perf/builtin-annotate.o
  CC      /tmp/build/perf/builtin-diff.o
  CC      /tmp/build/perf/builtin-evlist.o
  CC      /tmp/build/perf/builtin-sched.o
  CC      /tmp/build/perf/builtin-buildid-list.o
  CC      /tmp/build/perf/builtin-buildid-cache.o
  CC      /tmp/build/perf/builtin-record.o
  INSTALL trace_plugins
  GEN     /tmp/build/perf/python/perf.so
  CC      /tmp/build/perf/builtin-report.o
install: cannot create directory ‘/lib64/traceevent’: Permission denied
  CC      /tmp/build/perf/builtin-stat.o
install: cannot create regular file '/lib64/traceevent/plugins': No such file or directory
install: cannot create directory ‘/lib64/traceevent’: Permission denied
  CC      /tmp/build/perf/builtin-timechart.o
install: cannot create regular file '/lib64/traceevent/plugins': No such file or directory
install: cannot create directory ‘/lib64/traceevent’: Permission denied
  CC      /tmp/build/perf/builtin-top.o
install: cannot create regular file '/lib64/traceevent/plugins': No such file or directory
install: cannot create directory ‘/lib64/traceevent’: Permission denied
  CC      /tmp/build/perf/builtin-script.o
install: cannot create regular file '/lib64/traceevent/plugins': No such file or directory
install: cannot create directory ‘/lib64/traceevent’: Permission denied
  CC      /tmp/build/perf/builtin-kmem.o
install: cannot create regular file '/lib64/traceevent/plugins': No such file or directory
  CC      /tmp/build/perf/builtin-lock.o
install: cannot create directory ‘/lib64/traceevent’: Permission denied
  CC      /tmp/build/perf/builtin-kvm.o
install: cannot create regular file '/lib64/traceevent/plugins': No such file or directory
install: cannot create directory ‘/lib64/traceevent’: Permission denied
  CC      /tmp/build/perf/builtin-inject.o
install: cannot create regular file '/lib64/traceevent/plugins': No such file or directory
  CC      /tmp/build/perf/builtin-mem.o
install: cannot create directory ‘/lib64/traceevent’: Permission denied
install: cannot create regular file '/lib64/traceevent/plugins': No such file or directory
  CC      /tmp/build/perf/builtin-c2c.o
install: cannot create directory ‘/lib64/traceevent’: Permission denied
install: cannot create regular file '/lib64/traceevent/plugins': No such file or directory
  CC      /tmp/build/perf/builtin-kwork.o
install: cannot create directory ‘/lib64/traceevent’: Permission denied
  CC      /tmp/build/perf/builtin-trace.o
install: cannot create regular file '/lib64/traceevent/plugins': No such file or directory
install: cannot create directory ‘/lib64/traceevent’: Permission denied
install: cannot create regular file '/lib64/traceevent/plugins': No such file or directory
install: cannot create directory ‘/lib64/traceevent’: Permission denied
install: cannot create regular file '/lib64/traceevent/plugins': No such file or directory
make[3]: *** [Makefile:211: install] Error 1
make[2]: *** [Makefile.perf:886: install-traceevent-plugins] Error 2
make[2]: *** Waiting for unfinished jobs....
  CC      /tmp/build/perf/scripts/perl/Perf-Trace-Util/Context.o
  CC      /tmp/build/perf/scripts/python/Perf-Trace-Util/Context.o
  CC      /tmp/build/perf/bench/synthesize.o
  CC      /tmp/build/perf/bench/inject-buildid.o
  CC      /tmp/build/perf/ui/browsers/header.o
  CC      /tmp/build/perf/tests/evsel-tp-sched.o
  CC      /tmp/build/perf/arch/x86/util/intel-pt.o
  CC      /tmp/build/perf/arch/x86/util/intel-bts.o
  LD      /tmp/build/perf/scripts/python/Perf-Trace-Util/perf-in.o
  LD      /tmp/build/perf/bench/perf-in.o
  LD      /tmp/build/perf/ui/browsers/perf-in.o
  CC      /tmp/build/perf/tests/code-reading.o
  CC      /tmp/build/perf/tests/sample-parsing.o
  LD      /tmp/build/perf/arch/x86/util/perf-in.o
  CC      /tmp/build/perf/tests/topology.o
  LD      /tmp/build/perf/ui/perf-in.o
  CC      /tmp/build/perf/util/build-id.o
  CC      /tmp/build/perf/tests/time-utils-test.o
  CC      /tmp/build/perf/util/event.o
  CC      /tmp/build/perf/tests/demangle-java-test.o
  CC      /tmp/build/perf/tests/demangle-ocaml-test.o
  LD      /tmp/build/perf/arch/x86/perf-in.o
  CC      /tmp/build/perf/util/evsel.o
  CC      /tmp/build/perf/util/evsel_fprintf.o
  LD      /tmp/build/perf/arch/perf-in.o
  LD      /tmp/build/perf/tests/perf-in.o
  CC      /tmp/build/perf/util/header.o
  CC      /tmp/build/perf/util/session.o
  CC      /tmp/build/perf/util/s390-sample-raw.o
  CC      /tmp/build/perf/util/amd-sample-raw.o
  CC      /tmp/build/perf/util/ordered-events.o
  CC      /tmp/build/perf/util/thread.o
  CC      /tmp/build/perf/util/trace-event-parse.o
  CC      /tmp/build/perf/util/trace-event-read.o
  CC      /tmp/build/perf/util/trace-event-info.o
  CC      /tmp/build/perf/util/trace-event-scripting.o
  CC      /tmp/build/perf/util/trace-event.o
  CC      /tmp/build/perf/util/sort.o
  CC      /tmp/build/perf/util/hist.o
  CC      /tmp/build/perf/util/stat.o
  CC      /tmp/build/perf/util/synthetic-events.o
  CC      /tmp/build/perf/util/auxtrace.o
  CC      /tmp/build/perf/util/intel-pt.o
  CC      /tmp/build/perf/util/intel-bts.o
  CC      /tmp/build/perf/util/arm-spe.o
  CC      /tmp/build/perf/util/hisi-ptt.o
  CC      /tmp/build/perf/util/s390-cpumsf.o
  CC      /tmp/build/perf/util/scripting-engines/trace-event-perl.o
  CC      /tmp/build/perf/util/cs-etm.o
  CC      /tmp/build/perf/util/scripting-engines/trace-event-python.o
  CC      /tmp/build/perf/util/dlfilter.o
  CC      /tmp/build/perf/util/time-utils.o
  CC      /tmp/build/perf/util/bpf_off_cpu.o
  CC      /tmp/build/perf/util/probe-file.o
  CC      /tmp/build/perf/util/probe-event.o
  LD      /tmp/build/perf/util/scripting-engines/perf-in.o
  CC      /tmp/build/perf/util/unwind-libunwind-local.o
  CC      /tmp/build/perf/util/unwind-libunwind.o
  CC      /tmp/build/perf/util/data-convert-bt.o
  CC      /tmp/build/perf/util/data-convert-json.o
  LD      /tmp/build/perf/scripts/perl/Perf-Trace-Util/perf-in.o
  CC      /tmp/build/perf/util/jitdump.o
  LD      /tmp/build/perf/scripts/perf-in.o
  CC      /tmp/build/perf/util/bpf-event.o
  LD      /tmp/build/perf/util/perf-in.o
  LD      /tmp/build/perf/perf-in.o
make[1]: *** [Makefile.perf:240: sub-make] Error 2
make: *** [Makefile:113: install-bin] Error 2
make: Leaving directory '/var/home/acme/git/perf/tools/perf'

 Performance counter stats for 'make -k BUILD_BPF_SKEL=1 CORESIGHT=1 O=/tmp/build/perf -C tools/perf install-bin':

     9,363,188,016      cycles:u
    17,153,393,661      instructions:u                   #    1.83  insn per cycle

       2.837743632 seconds time elapsed

       2.316326000 seconds user
       2.136834000 seconds sys


⬢[acme@toolbox perf]$
