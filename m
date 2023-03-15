Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B59C06BBD54
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 20:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbjCOTfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 15:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjCOTfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 15:35:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B48898E4;
        Wed, 15 Mar 2023 12:35:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0B5CBB81E9C;
        Wed, 15 Mar 2023 19:35:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 661B0C433D2;
        Wed, 15 Mar 2023 19:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678908907;
        bh=lhJAoCq8jM1UuVXoin0jp+FnkJ36n7D08vcuCtEr10Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c3NRqR2aslcc1pCFI8LXpd7ECMfasVodc3p2fjUEssoXSpFdoMLqYMcYEnByLdULZ
         EfQOeIUQG8t4B3roXAWunlYgD2tC61LxjvCiIfj/GBwUkfKqZ7184WdOlAe2WXJxZp
         IzW11Sr2cMceeDf0/0zPdy+KLeBR4GEL57lBG327xzR67wEzx9SvcfQ8ueGIivdbmA
         3SJrBDJGY/ykxk5vrdybHYSu+2A4C8hrLGrEalslm1INfOr3XNARvmjd8JvBJO13VJ
         TimPcleA+9QSlgeIQ8qHcuk2Dl/4u3PAMtdG+3+2Ssfa4vH+vvGJa6BEnxvN8Ogdz7
         ziyhOKlwKSkbA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id ED8F64049F; Wed, 15 Mar 2023 16:35:04 -0300 (-03)
Date:   Wed, 15 Mar 2023 16:35:04 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        John Garry <john.g.garry@oracle.com>,
        James Clark <james.clark@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 00/16] perf kvm: Support histograms and TUI mode
Message-ID: <ZBId6CEVp4mTiFhq@kernel.org>
References: <20230315145112.186603-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230315145112.186603-1-leo.yan@linaro.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 15, 2023 at 10:50:56PM +0800, Leo Yan escreveu:
> This patch set is to enable histograms and (partially) TUI mode in perf
> kvm tool; patch set v1 [1] gives brief introduction for the change.
> 
> We can use below commands for testing this series:
> 
> In a terminal, you could launch a virtual machine with qemu command; in
> below case, I downloaded a Ubuntu (or Debian) iso file and used it as
> the file system image:
> 
>   $ qemu-system-x86_64 -M pc -enable-kvm -cpu host -m 4096 -hda ubuntu-22.04-desktop-amd64.iso
> 
> Then in another terminal, I can use below command to capture KVM trace
> data and report the result:
> 
>   # cd linux/tools/perf
>   # ./perf kvm stat record
>   # ./perf kvm stat report          => Output in TUI mode
>   # ./perf kvm stat report --stdio  => Output in stdio mode
> 
> Changes from v4:
> * Fixed building failure in patch 04; compiled successfully for every
>   patch to ensure bisection.

Trying to fix this:

⬢[acme@toolbox perf-tools-next]$ git log --oneline -1 ; time make -C tools/perf build-test
cbd137d776f05b70 (HEAD -> perf-tools-next) perf kvm: Update documentation to reflect new changes
make: Entering directory '/var/home/acme/git/perf-tools-next/tools/perf'
- tarpkg: ./tests/perf-targz-src-pkg .
                 make_static: cd . && make LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1 NO_JVMTI=1 NO_LIBTRACEEVENT=1 NO_LIBELF=1 -j32  DESTDIR=/tmp/tmp.AJidGMSQnF
cd . && make LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1 NO_JVMTI=1 NO_LIBTRACEEVENT=1 NO_LIBELF=1 -j32 DESTDIR=/tmp/tmp.AJidGMSQnF
  BUILD:   Doing 'make -j32' parallel build
  HOSTCC  fixdep.o
  HOSTLD  fixdep-in.o
  LINK    fixdep
Makefile.config:678: Disabling post unwind, no support found.
Makefile.config:746: No libcrypto.h found, disables jitted code injection, please install openssl-devel or libssl-dev
Makefile.config:758: slang not found, disables TUI support. Please install slang-devel, libslang-dev or libslang2-dev
Makefile.config:805: Missing perl devel files. Disabling perl scripting support, please install perl-ExtUtils-Embed/libperl-dev
Makefile.config:845: No 'Python.h' was found: disables Python support - please install python-devel/python-dev
Makefile.config:950: No liblzma found, disables xz kernel module decompression, please install xz-devel/liblzma-dev
Makefile.config:963: No libzstd found, disables trace compression, please install libzstd-dev[el] and/or set LIBZSTD_DIR
Makefile.config:974: No libcap found, disables capability support, please install libcap-devel/libcap-dev
Makefile.config:987: No numa.h found, disables 'perf bench numa mem' benchmark, please install numactl-devel/libnuma-devel/libnuma-dev
Makefile.config:1046: No libbabeltrace found, disables 'perf data' CTF format support, please install libbabeltrace-dev[el]/libbabeltrace-ctf-dev
Makefile.config:1137: libpfm4 not found, disables libpfm4 support. Please install libpfm4-dev

Auto-detecting system features:
...                                   dwarf: [ OFF ]
...                      dwarf_getlocations: [ OFF ]
...                                   glibc: [ on  ]
...                                  libbfd: [ OFF ]
...                          libbfd-buildid: [ OFF ]
...                                  libcap: [ OFF ]
...                                  libelf: [ OFF ]
...                                 libnuma: [ OFF ]
...                  numa_num_possible_cpus: [ OFF ]
...                                 libperl: [ OFF ]
...                               libpython: [ OFF ]
...                               libcrypto: [ OFF ]
...                               libunwind: [ OFF ]
...                      libdw-dwarf-unwind: [ OFF ]
...                                    zlib: [ OFF ]
...                                    lzma: [ OFF ]
...                               get_cpuid: [ on  ]
...                                     bpf: [ on  ]
...                                  libaio: [ on  ]
...                                 libzstd: [ OFF ]

  GEN     common-cmds.h
  CC      dlfilters/dlfilter-test-api-v0.o
  CC      dlfilters/dlfilter-show-cycles.o
  LINK    dlfilters/dlfilter-show-cycles.so
  LINK    dlfilters/dlfilter-test-api-v0.so
  INSTALL /var/home/acme/git/perf-tools-next/tools/perf/libsubcmd/include/subcmd/exec-cmd.h
  INSTALL /var/home/acme/git/perf-tools-next/tools/perf/libsubcmd/include/subcmd/help.h
  INSTALL /var/home/acme/git/perf-tools-next/tools/perf/libsubcmd/include/subcmd/pager.h
  INSTALL /var/home/acme/git/perf-tools-next/tools/perf/libsubcmd/include/subcmd/parse-options.h
  INSTALL /var/home/acme/git/perf-tools-next/tools/perf/libsubcmd/include/subcmd/run-command.h
  CC      /var/home/acme/git/perf-tools-next/tools/perf/libsubcmd/exec-cmd.o
  CC      /var/home/acme/git/perf-tools-next/tools/perf/libsubcmd/help.o
  CC      /var/home/acme/git/perf-tools-next/tools/perf/libsubcmd/pager.o
  <SNIP>
  CC      /var/home/acme/git/perf-tools-next/tools/perf/libsubcmd/parse-options.o
  CC      /var/home/acme/git/perf-tools-next/tools/perf/libsubcmd/run-command.o
  CC      util/sample-raw.o
  CC      util/s390-sample-raw.o
  CC      util/amd-sample-raw.o
  CC      util/ordered-events.o
builtin-kvm.c:512:13: error: ‘print_result’ used but never defined [-Werror]
  512 | static void print_result(struct perf_kvm_stat *kvm);
      |             ^~~~~~~~~~~~
builtin-kvm.c:591:13: error: ‘kvm_display’ defined but not used [-Werror=unused-function]
  591 | static void kvm_display(struct perf_kvm_stat *kvm)
      |             ^~~~~~~~~~~
builtin-kvm.c:506:12: error: ‘kvm_hists__reinit’ defined but not used [-Werror=unused-function]
  506 | static int kvm_hists__reinit(const char *output, const char *sort)
      |            ^~~~~~~~~~~~~~~~~
builtin-kvm.c:498:12: error: ‘kvm_hists__init’ defined but not used [-Werror=unused-function]
  498 | static int kvm_hists__init(void)
      |            ^~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[5]: *** [/var/home/acme/git/perf-tools-next/tools/build/Makefile.build:97: builtin-kvm.o] Error 1
make[5]: *** Waiting for unfinished jobs....
  CC      tests/perf-time-to-tsc.o
  CC      util/namespaces.o

