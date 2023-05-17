Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D927069C8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 15:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbjEQNZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 09:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbjEQNZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 09:25:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E205173F;
        Wed, 17 May 2023 06:25:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCF8A64752;
        Wed, 17 May 2023 13:25:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0CC0C433D2;
        Wed, 17 May 2023 13:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684329942;
        bh=43mYnJdcC5bObK0FdgvvVOZf3KnGLx1Baex8ZlTtCsA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DmyCtyLLxk0C4P8Iux5LNXOxbfJembeTNuUZiPAdzdyYICGGONeHFzSvg2d1tc8Pm
         3deeTCh5qNJd31szAVb4AdzVFu7zwRF9oOFTtyPDk2jpGHNU/nC0Ry1lvBu8G4B6ga
         45Pco06sAuC0/U56gcVZVMVBXEPBcpTp8GqGvSH18SyarYpQI8LHvWG65wMj1UjOlK
         Aih6J9hGTEfOYH3Pd9/ftGiIUciaTMB8ZwDoE98XTqWsqxRbNqXTDV/2BwDnstKZtr
         DWkubcRcKqnvpLmyUfYszWP96Yw+QyBlFTzi+wk0Zy6RUyufOdzq4riUzVyl09Rst3
         JRHtiLnvzfxyg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 76D12403B5; Wed, 17 May 2023 10:25:39 -0300 (-03)
Date:   Wed, 17 May 2023 10:25:39 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-hardening@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] perf pmu: Replace all non-returning strlcpy with strscpy
Message-ID: <ZGTV054XzxkP8Y/F@kernel.org>
References: <20230516000500.3884588-1-azeemshaikh38@gmail.com>
 <202305161114.DEC49FB91@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202305161114.DEC49FB91@keescook>
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

Em Tue, May 16, 2023 at 11:14:38AM -0700, Kees Cook escreveu:
> On Tue, May 16, 2023 at 12:05:00AM +0000, Azeem Shaikh wrote:
> > strlcpy() reads the entire source buffer first.
> > This read may exceed the destination size limit.
> > This is both inefficient and can lead to linear read
> > overflows if a source string is not NUL-terminated [1].
> > In an effort to remove strlcpy() completely [2], replace
> > strlcpy() here with strscpy().
> > No return values were used, so direct replacement is safe.
> > 
> > [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> > [2] https://github.com/KSPP/linux/issues/89
> > 
> > Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>

Not building as strscpy() doesn't seem to be available for tools/ code,
probably you'll need to first copy from the kernel too tools/lib/.

- Arnaldo

  CLANG   /tmp/build/perf-tools-next/util/bpf_skel/.tmp/sample_filter.bpf.o
jvmti/libjvmti.c: In function ‘copy_class_filename’:
jvmti/libjvmti.c:161:17: error: implicit declaration of function ‘strscpy’; did you mean ‘strlcpy’? [-Werror=implicit-function-declaration]
  161 |                 strscpy(result, file_name, max_length);
      |                 ^~~~~~~
      |                 strlcpy
cc1: all warnings being treated as errors
make[3]: *** [/var/home/acme/git/perf-tools-next/tools/build/Makefile.build:97: /tmp/build/perf-tools-next/jvmti/libjvmti.o] Error 1
make[2]: *** [Makefile.perf:818: /tmp/build/perf-tools-next/jvmti/jvmti-in.o] Error 2
make[2]: *** Waiting for unfinished jobs....
/var/home/acme/git/perf-tools-next/tools/perf/util/pmu-hybrid.c: In function ‘perf_pmu__hybrid_mounted’:
/var/home/acme/git/perf-tools-next/tools/perf/util/pmu-hybrid.c:30:9: error: implicit declaration of function ‘strscpy’; did you mean ‘strlcpy’? [-Werror=implicit-function-declaration]
   30 |         strscpy(pmu_name, name, sizeof(pmu_name));
      |         ^~~~~~~
      |         strlcpy
cc1: all warnings being treated as errors
error: command '/usr/lib64/ccache/gcc' failed with exit code 1
cp: cannot stat '/tmp/build/perf-tools-next/python_ext_build/lib/perf*.so': No such file or directory
make[2]: *** [Makefile.perf:651: /tmp/build/perf-tools-next/python/perf.cpython-311-x86_64-linux-gnu.so] Error 1

Auto-detecting system features:
...                         clang-bpf-co-re: [ on  ]
...                                    llvm: [ OFF ]
...                                  libcap: [ on  ]
...                                  libbfd: [ on  ]

  MKDIR   /tmp/build/perf-tools-next/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf
  MKDIR   /tmp/build/perf-tools-next/util/bpf_skel/.tmp/bootstrap/

  CC      /tmp/build/perf-tools-next/util/intel-pt-decoder/intel-pt-log.o
util/llvm-utils.c: In function ‘search_program’:
util/llvm-utils.c:83:33: error: implicit declaration of function ‘strscpy’; did you mean ‘strlcpy’? [-Werror=implicit-function-declaration]
   83 |                                 strscpy(output, def, PATH_MAX);
      |                                 ^~~~~~~
      |                                 strlcpy
cc1: all warnings being treated as errors
  CC      /tmp/build/perf-tools-next/util/intel-pt-decoder/intel-pt-decoder.o
make[4]: *** [/var/home/acme/git/perf-tools-next/tools/build/Makefile.build:98: /tmp/build/perf-tools-next/util/llvm-utils.o] Error 1
make[4]: *** Waiting for unfinished jobs....
  CC      /tmp/build/perf-tools-next/util/cs-etm-base.o
  CC      /tmp/build/perf-tools-next/util/parse-branch-options.o
  LD      /tmp/build/perf-tools-next/util/cs-etm-decoder/perf-in.o
  LD      /tmp/build/perf-tools-next/util/hisi-ptt-decoder/perf-in.o
  LD      /tmp/build/perf-tools-next/util/arm-spe-decoder/perf-in.o
  CC      /tmp/build/perf-tools-next/util/intel-pt-decoder/intel-pt-insn-decoder.o
  LD      /tmp/build/perf-tools-next/util/scripting-engines/perf-in.o
util/pmu-hybrid.c: In function ‘perf_pmu__hybrid_mounted’:
util/pmu-hybrid.c:30:9: error: implicit declaration of function ‘strscpy’; did you mean ‘strlcpy’? [-Werror=implicit-function-declaration]
   30 |         strscpy(pmu_name, name, sizeof(pmu_name));
      |         ^~~~~~~
      |         strlcpy
cc1: all warnings being treated as errors
make[4]: *** [/var/home/acme/git/perf-tools-next/tools/build/Makefile.build:97: /tmp/build/perf-tools-next/util/pmu-hybrid.o] Error 1
tests/symbols.c: In function ‘get_test_dso_filename’:
tests/symbols.c:48:17: error: implicit declaration of function ‘strscpy’; did you mean ‘strlcpy’? [-Werror=implicit-function-declaration]
   48 |                 strscpy(filename, dso_to_test, max_sz);
      |                 ^~~~~~~
      |                 strlcpy
cc1: all warnings being treated as errors
make[4]: *** [/var/home/acme/git/perf-tools-next/tools/build/Makefile.build:97: /tmp/build/perf-tools-next/tests/symbols.o] Error 1
make[4]: *** Waiting for unfinished jobs....
tests/dlfilter-test.c: In function ‘get_dlfilters_path’:
tests/dlfilter-test.c:237:9: error: implicit declaration of function ‘strscpy’; did you mean ‘strlcpy’? [-Werror=implicit-function-declaration]
  237 |         strscpy(buf, dirname(path), sz);
      |         ^~~~~~~
      |         strlcpy
cc1: all warnings being treated as errors
make[4]: *** [/var/home/acme/git/perf-tools-next/tools/build/Makefile.build:97: /tmp/build/perf-tools-next/tests/dlfilter-test.o] Error 1
make[3]: *** [/var/home/acme/git/perf-tools-next/tools/build/Makefile.build:140: tests] Error 2
/var/home/acme/git/perf-tools-next/tools/perf/util/pmu-hybrid.c: In function ‘perf_pmu__hybrid_mounted’:
/var/home/acme/git/perf-tools-next/tools/perf/util/pmu-hybrid.c:30:9: error: implicit declaration of function ‘strscpy’; did you mean ‘strlcpy’? [-Werror=implicit-function-declaration]
   30 |         strscpy(pmu_name, name, sizeof(pmu_name));
      |         ^~~~~~~
      |         strlcpy
cc1: all warnings being treated as errors
error: command '/usr/lib64/ccache/gcc' failed with exit code 1
cp: cannot stat '/tmp/build/perf-tools-next/python_ext_build/lib/perf*.so': No such file or directory
make[2]: *** [Makefile.perf:651: /tmp/build/perf-tools-next/python/perf.cpython-311-x86_64-linux-gnu.so] Error 1
util/svghelper.c: In function ‘cpu_model’:
util/svghelper.c:335:33: error: implicit declaration of function ‘strscpy’; did you mean ‘strlcpy’? [-Werror=implicit-function-declaration]
  335 |                                 strscpy(cpu_m, &buf[13], 255);
      |                                 ^~~~~~~
      |                                 strlcpy
cc1: all warnings being treated as errors
make[4]: *** [/var/home/acme/git/perf-tools-next/tools/build/Makefile.build:97: /tmp/build/perf-tools-next/util/svghelper.o] Error 1
util/dso.c: In function ‘filename__decompress’:
util/dso.c:354:17: error: implicit declaration of function ‘strscpy’; did you mean ‘strlcpy’? [-Werror=implicit-function-declaration]
  354 |                 strscpy(pathname, tmpbuf, len);
      |                 ^~~~~~~
      |                 strlcpy
cc1: all warnings being treated as errors
make[4]: *** [/var/home/acme/git/perf-tools-next/tools/build/Makefile.build:97: /tmp/build/perf-tools-next/util/dso.o] Error 1
util/symbol.c: In function ‘dso__load’:
util/symbol.c:1970:33: error: implicit declaration of function ‘strscpy’; did you mean ‘strlcpy’? [-Werror=implicit-function-declaration]
 1970 |                                 strscpy(name, new_name, PATH_MAX);
      |                                 ^~~~~~~
      |                                 strlcpy
cc1: all warnings being treated as errors
make[4]: *** [/var/home/acme/git/perf-tools-next/tools/build/Makefile.build:97: /tmp/build/perf-tools-next/util/symbol.o] Error 1
util/annotate.c: In function ‘dso__disassemble_filename’:
util/annotate.c:1718:33: error: implicit declaration of function ‘strscpy’; did you mean ‘strlcpy’? [-Werror=implicit-function-declaration]
 1718 |                                 strscpy(filename, new_name, filename_size);
      |                                 ^~~~~~~
      |                                 strlcpy
cc1: all warnings being treated as errors
make[4]: *** [/var/home/acme/git/perf-tools-next/tools/build/Makefile.build:97: /tmp/build/perf-tools-next/util/annotate.o] Error 1
util/synthetic-events.c: In function ‘perf_event__synthesize_event_update_unit’:
util/synthetic-events.c:1982:9: error: implicit declaration of function ‘strscpy’; did you mean ‘strlcpy’? [-Werror=implicit-function-declaration]
 1982 |         strscpy(ev->unit, evsel->unit, size + 1);
      |         ^~~~~~~
      |         strlcpy
cc1: all warnings being treated as errors
make[4]: *** [/var/home/acme/git/perf-tools-next/tools/build/Makefile.build:97: /tmp/build/perf-tools-next/util/synthetic-events.o] Error 1
util/auxtrace.c: In function ‘auxtrace_synth_guest_error’:
util/auxtrace.c:1216:9: error: implicit declaration of function ‘strscpy’; did you mean ‘strlcpy’? [-Werror=implicit-function-declaration]
 1216 |         strscpy(auxtrace_error->msg, msg, MAX_AUXTRACE_ERROR_MSG);
      |         ^~~~~~~
      |         strlcpy
cc1: all warnings being treated as errors
make[4]: *** [/var/home/acme/git/perf-tools-next/tools/build/Makefile.build:97: /tmp/build/perf-tools-next/util/auxtrace.o] Error 1
util/intel-pt-decoder/intel-pt-decoder.c: In function ‘intel_pt__strerror’:
util/intel-pt-decoder/intel-pt-decoder.c:510:9: error: implicit declaration of function ‘strscpy’; did you mean ‘strlcpy’? [-Werror=implicit-function-declaration]
  510 |         strscpy(buf, intel_pt_err_msgs[code], buflen);
      |         ^~~~~~~
      |         strlcpy
cc1: all warnings being treated as errors
make[5]: *** [/var/home/acme/git/perf-tools-next/tools/build/Makefile.build:97: /tmp/build/perf-tools-next/util/intel-pt-decoder/intel-pt-decoder.o] Error 1
make[4]: *** [/var/home/acme/git/perf-tools-next/tools/build/Makefile.build:140: intel-pt-decoder] Error 2
util/machine.c: In function ‘machine__create_extra_kernel_map’:
util/machine.c:1226:9: error: implicit declaration of function ‘strscpy’; did you mean ‘strlcpy’? [-Werror=implicit-function-declaration]
 1226 |         strscpy(kmap->name, xm->name, KMAP_NAME_LEN);
      |         ^~~~~~~
      |         strlcpy
cc1: all warnings being treated as errors
make[4]: *** [/var/home/acme/git/perf-tools-next/tools/build/Makefile.build:97: /tmp/build/perf-tools-next/util/machine.o] Error 1
make[3]: *** [/var/home/acme/git/perf-tools-next/tools/build/Makefile.build:140: util] Error 2
make[2]: *** [Makefile.perf:676: /tmp/build/perf-tools-next/perf-in.o] Error 2
  CC      /tmp/build/perf-tools-next/pmu-events/pmu-events.o
  LD      /tmp/build/perf-tools-next/pmu-events/pmu-events-in.o
make[1]: *** [Makefile.perf:236: sub-make] Error 2
make: *** [Makefile:113: install-bin] Error 2
make: Leaving directory '/var/home/acme/git/perf-tools-next/tools/perf'

 Performance counter stats for 'make -k BUILD_BPF_SKEL=1 CORESIGHT=1 O=/tmp/build/perf-tools-next -C tools/perf install-bin':

       61899912971      cycles:u                                                              
      106832920114      instructions:u                   #    1.73  insn per cycle            

       4.586621727 seconds time elapsed

      14.384368000 seconds user
       5.495604000 seconds sys


⬢[acme@toolbox perf-tools-next]$ 


