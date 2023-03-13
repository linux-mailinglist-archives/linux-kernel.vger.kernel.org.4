Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67116B82D0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 21:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjCMUeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 16:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjCMUeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 16:34:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333AB1B558;
        Mon, 13 Mar 2023 13:34:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 755B3B8149C;
        Mon, 13 Mar 2023 20:34:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4CCEC433D2;
        Mon, 13 Mar 2023 20:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678739649;
        bh=0xc3ZaUBE/K782v+uA3TiHh1aai7um3n2iloGvroOcY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DI4RSnKxtXZ6D99Aa8p91rplzBYrKIng+h8OGLrZyhcVhPAuhofdpUepymJgkMwi3
         4obdDtCPudeeyde6eJbgivPYJV8/kT7xAD9dRJeL+Z//Dvlzkk81/3nbmDJxdT7tcY
         hbZAgKue20shGpsl6XaWdKS/+CVQb2DAZHw9/LfuwiC4eeeYJvjAjlX6n+jMlYdRSF
         2UfULsKzoUuRYRjfXIRunbMJD1aV9Seb+Bnvn15sUnK2RkiGjf3IqxfbxnSzK1LQDQ
         KpTrrc74lK9U4PiNKtSLZgtn7efd4GiPlQn35N3l6l23u9vwtTxMib4w/p1T3vg52u
         N/+NReNSAPloA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 530C54049F; Mon, 13 Mar 2023 17:34:06 -0300 (-03)
Date:   Mon, 13 Mar 2023 17:34:06 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Andres Freund <andres@anarazel.de>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Pavithra Gurushankar <gpavithrasha@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        llvm@lists.linux.dev, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v1 02/13] perf build: Make BUILD_BPF_SKEL default, rename
 to NO_BPF_SKEL
Message-ID: <ZA+IvqVb6Gos+NOe@kernel.org>
References: <20230311065753.3012826-1-irogers@google.com>
 <20230311065753.3012826-3-irogers@google.com>
 <ZA+FOpzJswZx8os+@kernel.org>
 <CAP-5=fUG1CbzevoS=+Jj_pBO4umNj6ekaMeEuSHGC4kAZgVJJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUG1CbzevoS=+Jj_pBO4umNj6ekaMeEuSHGC4kAZgVJJg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 13, 2023 at 01:27:21PM -0700, Ian Rogers escreveu:
> On Mon, Mar 13, 2023 at 1:19 PM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Fri, Mar 10, 2023 at 10:57:42PM -0800, Ian Rogers escreveu:
> > > BPF skeleton support is now key to a number of perf features. Rather
> > > than making it so that BPF support must be enabled for the build, make
> > > this the default and error if the build lacks a clang and libbpf that
> > > are sufficient. To avoid the error and build without BPF skeletons the
> > > NO_BPF_SKEL=1 flag can be used. Add a build-options flag to 'perf
> > > version' to enable detection of the BPF skeleton support and use this
> > > in the offcpu shell test.
> >
> > Checking this:
> >
> > cd . && make LIBBPF_DYNAMIC=1 FEATURES_DUMP=/var/home/acme/git/perf-tools-next/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.Rr5xDuXo13 DESTDIR=/tmp/tmp.cYdDvy09eY
> >   BUILD:   Doing 'make -j32' parallel build
> >   HOSTCC  /tmp/tmp.Rr5xDuXo13/fixdep.o
> >   HOSTLD  /tmp/tmp.Rr5xDuXo13/fixdep-in.o
> >   LINK    /tmp/tmp.Rr5xDuXo13/fixdep
> > Warning: Kernel ABI header at 'tools/include/uapi/linux/in.h' differs from latest version at 'include/uapi/linux/in.h'
> > diff -u tools/include/uapi/linux/in.h include/uapi/linux/in.h
> > Warning: Kernel ABI header at 'tools/arch/x86/include/asm/cpufeatures.h' differs from latest version at 'arch/x86/include/asm/cpufeatures.h'
> > diff -u tools/arch/x86/include/asm/cpufeatures.h arch/x86/include/asm/cpufeatures.h
> > Warning: Kernel ABI header at 'tools/arch/arm64/include/uapi/asm/perf_regs.h' differs from latest version at 'arch/arm64/include/uapi/asm/perf_regs.h'
> > diff -u tools/arch/arm64/include/uapi/asm/perf_regs.h arch/arm64/include/uapi/asm/perf_regs.h
> > Warning: Kernel ABI header at 'tools/include/linux/coresight-pmu.h' differs from latest version at 'include/linux/coresight-pmu.h'
> > diff -u tools/include/linux/coresight-pmu.h include/linux/coresight-pmu.h
> > Makefile.config:1130: No openjdk development package found, please install JDK package, e.g. openjdk-8-jdk, java-1.8.0-openjdk-devel
> >
> >   GEN     /tmp/tmp.Rr5xDuXo13/common-cmds.h
> >   CC      /tmp/tmp.Rr5xDuXo13/dlfilters/dlfilter-test-api-v0.o
> >   CC      /tmp/tmp.Rr5xDuXo13/dlfilters/dlfilter-show-cycles.o
> >   LINK    /tmp/tmp.Rr5xDuXo13/dlfilters/dlfilter-test-api-v0.so
> >   LINK    /tmp/tmp.Rr5xDuXo13/dlfilters/dlfilter-show-cycles.so
> >   INSTALL /tmp/tmp.Rr5xDuXo13/libsubcmd/include/subcmd/exec-cmd.h
> >   INSTALL /tmp/tmp.Rr5xDuXo13/libsubcmd/include/subcmd/help.h
> >   INSTALL /tmp/tmp.Rr5xDuXo13/libsubcmd/include/subcmd/pager.h
> >   INSTALL /tmp/tmp.Rr5xDuXo13/libsubcmd/include/subcmd/parse-options.h
> >   INSTALL /tmp/tmp.Rr5xDuXo13/libsubcmd/include/subcmd/run-command.h
> >   CC      /tmp/tmp.Rr5xDuXo13/libsubcmd/exec-cmd.o
> >   CC      /tmp/tmp.Rr5xDuXo13/libsubcmd/help.o
> >   CC      /tmp/tmp.Rr5xDuXo13/libsubcmd/pager.o
> >   CC      /tmp/tmp.Rr5xDuXo13/libsubcmd/parse-options.o
> >   CC      /tmp/tmp.Rr5xDuXo13/libsubcmd/run-command.o
> >   CC      /tmp/tmp.Rr5xDuXo13/libsubcmd/sigchain.o
> >   CC      /tmp/tmp.Rr5xDuXo13/libsubcmd/subcmd-config.o
> >   MKDIR   /tmp/tmp.Rr5xDuXo13/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf
> >   MKDIR   /tmp/tmp.Rr5xDuXo13/util/bpf_skel/.tmp/bootstrap/
> >   MKDIR   /tmp/tmp.Rr5xDuXo13/util/bpf_skel/.tmp/bootstrap/libbpf/
> >   INSTALL libsubcmd_headers
> >   INSTALL /tmp/tmp.Rr5xDuXo13/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/hashmap.h
> >   INSTALL /tmp/tmp.Rr5xDuXo13/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/relo_core.h
> >   INSTALL /tmp/tmp.Rr5xDuXo13/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/libbpf_internal.h
> >   PERF_VERSION = 6.3.rc1.g0b82b38b7b56
> >   INSTALL /tmp/tmp.Rr5xDuXo13/libperf/include/perf/bpf_perf.h
> >   INSTALL /tmp/tmp.Rr5xDuXo13/libperf/include/perf/core.h
> >   INSTALL /tmp/tmp.Rr5xDuXo13/libperf/include/perf/cpumap.h
> >   INSTALL /tmp/tmp.Rr5xDuXo13/libperf/include/perf/threadmap.h
> >   INSTALL /tmp/tmp.Rr5xDuXo13/libsymbol/include/symbol/kallsyms.h
> >   INSTALL /tmp/tmp.Rr5xDuXo13/libapi/include/api/cpu.h
> >   INSTALL /tmp/tmp.Rr5xDuXo13/libperf/include/perf/evlist.h
> >   INSTALL /tmp/tmp.Rr5xDuXo13/libapi/include/api/debug.h
> >   INSTALL /tmp/tmp.Rr5xDuXo13/libperf/include/perf/evsel.h
> >   INSTALL /tmp/tmp.Rr5xDuXo13/libapi/include/api/io.h
> >   GEN     perf-archive
> >   INSTALL /tmp/tmp.Rr5xDuXo13/libperf/include/perf/event.h
> >   INSTALL /tmp/tmp.Rr5xDuXo13/libapi/include/api/fd/array.h
> >   GEN     perf-iostat
> >   INSTALL /tmp/tmp.Rr5xDuXo13/libperf/include/perf/mmap.h
> >   CC      /tmp/tmp.Rr5xDuXo13/libperf/core.o
> >   CC      /tmp/tmp.Rr5xDuXo13/libsymbol/kallsyms.o
> >   CC      /tmp/tmp.Rr5xDuXo13/libapi/cpu.o
> >   INSTALL /tmp/tmp.Rr5xDuXo13/libperf/include/internal/cpumap.h
> >   INSTALL /tmp/tmp.Rr5xDuXo13/libapi/include/api/fs/fs.h
> >   INSTALL /tmp/tmp.Rr5xDuXo13/libapi/include/api/fs/tracing_path.h
> >   MKDIR   /tmp/tmp.Rr5xDuXo13/libapi/fd/
> >   CC      /tmp/tmp.Rr5xDuXo13/libapi/debug.o
> >   CC      /tmp/tmp.Rr5xDuXo13/libapi/str_error_r.o
> >   CC      /tmp/tmp.Rr5xDuXo13/libperf/cpumap.o
> >   INSTALL libsymbol_headers
> >   INSTALL /tmp/tmp.Rr5xDuXo13/libperf/include/internal/evlist.h
> >   CC      /tmp/tmp.Rr5xDuXo13/libperf/threadmap.o
> >   INSTALL /tmp/tmp.Rr5xDuXo13/libperf/include/internal/evsel.h
> >   CC      /tmp/tmp.Rr5xDuXo13/libperf/evsel.o
> >   INSTALL /tmp/tmp.Rr5xDuXo13/libperf/include/internal/lib.h
> >   CC      /tmp/tmp.Rr5xDuXo13/libperf/evlist.o
> >   INSTALL /tmp/tmp.Rr5xDuXo13/libperf/include/internal/mmap.h
> >   MKDIR   /tmp/tmp.Rr5xDuXo13/libapi/fs/
> >   INSTALL /tmp/tmp.Rr5xDuXo13/libperf/include/internal/threadmap.h
> >   CC      /tmp/tmp.Rr5xDuXo13/libapi/fd/array.o
> >   MKDIR   /tmp/tmp.Rr5xDuXo13/libapi/fs/
> >   CC      /tmp/tmp.Rr5xDuXo13/libperf/mmap.o
> >   INSTALL /tmp/tmp.Rr5xDuXo13/libperf/include/internal/xyarray.h
> >   CC      /tmp/tmp.Rr5xDuXo13/libapi/fs/fs.o
> >   CC      /tmp/tmp.Rr5xDuXo13/libperf/zalloc.o
> >   CC      /tmp/tmp.Rr5xDuXo13/libperf/xyarray.o
> >   CC      /tmp/tmp.Rr5xDuXo13/libapi/fs/cgroup.o
> >   CC      /tmp/tmp.Rr5xDuXo13/libperf/lib.o
> >   INSTALL libapi_headers
> >   CC      /tmp/tmp.Rr5xDuXo13/libapi/fs/tracing_path.o
> >   INSTALL libperf_headers
> >   GEN     /tmp/tmp.Rr5xDuXo13/util/bpf_skel/.tmp/bootstrap/libbpf/bpf_helper_defs.h
> >   INSTALL /tmp/tmp.Rr5xDuXo13/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/bpf.h
> >   INSTALL /tmp/tmp.Rr5xDuXo13/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/libbpf.h
> >   INSTALL /tmp/tmp.Rr5xDuXo13/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/btf.h
> >   INSTALL /tmp/tmp.Rr5xDuXo13/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/libbpf_common.h
> >   INSTALL /tmp/tmp.Rr5xDuXo13/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/libbpf_legacy.h
> >   INSTALL /tmp/tmp.Rr5xDuXo13/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/bpf_helpers.h
> >   INSTALL /tmp/tmp.Rr5xDuXo13/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/bpf_tracing.h
> >   INSTALL /tmp/tmp.Rr5xDuXo13/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/bpf_endian.h
> >   INSTALL /tmp/tmp.Rr5xDuXo13/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/bpf_core_read.h
> >   INSTALL /tmp/tmp.Rr5xDuXo13/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/skel_internal.h
> >   INSTALL /tmp/tmp.Rr5xDuXo13/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/libbpf_version.h
> >   INSTALL /tmp/tmp.Rr5xDuXo13/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/usdt.bpf.h
> >   LD      /tmp/tmp.Rr5xDuXo13/libapi/fd/libapi-in.o
> >   LD      /tmp/tmp.Rr5xDuXo13/libsymbol/libsymbol-in.o
> >   AR      /tmp/tmp.Rr5xDuXo13/libsymbol/libsymbol.a
> >   LD      /tmp/tmp.Rr5xDuXo13/libapi/fs/libapi-in.o
> >   INSTALL /tmp/tmp.Rr5xDuXo13/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/bpf_helper_defs.h
> >   MKDIR   /tmp/tmp.Rr5xDuXo13/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/
> >   MKDIR   /tmp/tmp.Rr5xDuXo13/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/
> >   INSTALL libbpf_headers
> >   MKDIR   /tmp/tmp.Rr5xDuXo13/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/
> >   MKDIR   /tmp/tmp.Rr5xDuXo13/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/
> >   MKDIR   /tmp/tmp.Rr5xDuXo13/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/
> >   MKDIR   /tmp/tmp.Rr5xDuXo13/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/
> >   MKDIR   /tmp/tmp.Rr5xDuXo13/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/
> >   LD      /tmp/tmp.Rr5xDuXo13/libapi/libapi-in.o
> >   MKDIR   /tmp/tmp.Rr5xDuXo13/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/
> >   CC      /tmp/tmp.Rr5xDuXo13/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/libbpf.o
> >   CC      /tmp/tmp.Rr5xDuXo13/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/bpf.o
> >   CC      /tmp/tmp.Rr5xDuXo13/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/libbpf_probes.o
> >   CC      /tmp/tmp.Rr5xDuXo13/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/hashmap.o
> >   CC      /tmp/tmp.Rr5xDuXo13/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/nlattr.o
> >   CC      /tmp/tmp.Rr5xDuXo13/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/btf_dump.o
> >   CC      /tmp/tmp.Rr5xDuXo13/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/btf.o
> >   CC      /tmp/tmp.Rr5xDuXo13/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/libbpf_errno.o
> >   CC      /tmp/tmp.Rr5xDuXo13/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/str_error.o
> >   CC      /tmp/tmp.Rr5xDuXo13/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/netlink.o
> >   CC      /tmp/tmp.Rr5xDuXo13/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/ringbuf.o
> >   CC      /tmp/tmp.Rr5xDuXo13/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/bpf_prog_linfo.o
> >   LD      /tmp/tmp.Rr5xDuXo13/libperf/libperf-in.o
> >   CC      /tmp/tmp.Rr5xDuXo13/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/strset.o
> >   CC      /tmp/tmp.Rr5xDuXo13/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/linker.o
> >   CC      /tmp/tmp.Rr5xDuXo13/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/gen_loader.o
> >   CC      /tmp/tmp.Rr5xDuXo13/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/relo_core.o
> >   AR      /tmp/tmp.Rr5xDuXo13/libapi/libapi.a
> >   CC      /tmp/tmp.Rr5xDuXo13/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/usdt.o
> >   AR      /tmp/tmp.Rr5xDuXo13/libperf/libperf.a
> >   LD      /tmp/tmp.Rr5xDuXo13/libsubcmd/libsubcmd-in.o
> >   AR      /tmp/tmp.Rr5xDuXo13/libsubcmd/libsubcmd.a
> >   GEN     /tmp/tmp.Rr5xDuXo13/python/perf.cpython-311-x86_64-linux-gnu.so
> >   LD      /tmp/tmp.Rr5xDuXo13/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/libbpf-in.o
> >   LINK    /tmp/tmp.Rr5xDuXo13/util/bpf_skel/.tmp/bootstrap/libbpf/libbpf.a
> >   CC      /tmp/tmp.Rr5xDuXo13/util/bpf_skel/.tmp/bootstrap/main.o
> >   CC      /tmp/tmp.Rr5xDuXo13/util/bpf_skel/.tmp/bootstrap/common.o
> >   CC      /tmp/tmp.Rr5xDuXo13/util/bpf_skel/.tmp/bootstrap/json_writer.o
> >   CC      /tmp/tmp.Rr5xDuXo13/util/bpf_skel/.tmp/bootstrap/gen.o
> >   CC      /tmp/tmp.Rr5xDuXo13/util/bpf_skel/.tmp/bootstrap/btf.o
> >   CC      /tmp/tmp.Rr5xDuXo13/util/bpf_skel/.tmp/bootstrap/xlated_dumper.o
> >   CC      /tmp/tmp.Rr5xDuXo13/util/bpf_skel/.tmp/bootstrap/btf_dumper.o
> >   CC      /tmp/tmp.Rr5xDuXo13/util/bpf_skel/.tmp/bootstrap/disasm.o
> >   LINK    /tmp/tmp.Rr5xDuXo13/util/bpf_skel/.tmp/bootstrap/bpftool
> >   GEN     /tmp/tmp.Rr5xDuXo13/util/bpf_skel/vmlinux.h
> >   CLANG   /tmp/tmp.Rr5xDuXo13/util/bpf_skel/.tmp/bpf_prog_profiler.bpf.o
> >   CLANG   /tmp/tmp.Rr5xDuXo13/util/bpf_skel/.tmp/bperf_leader.bpf.o
> >   CLANG   /tmp/tmp.Rr5xDuXo13/util/bpf_skel/.tmp/bperf_follower.bpf.o
> >   CLANG   /tmp/tmp.Rr5xDuXo13/util/bpf_skel/.tmp/bperf_cgroup.bpf.o
> >   CLANG   /tmp/tmp.Rr5xDuXo13/util/bpf_skel/.tmp/func_latency.bpf.o
> >   CLANG   /tmp/tmp.Rr5xDuXo13/util/bpf_skel/.tmp/off_cpu.bpf.o
> >   CLANG   /tmp/tmp.Rr5xDuXo13/util/bpf_skel/.tmp/lock_contention.bpf.o
> >   CLANG   /tmp/tmp.Rr5xDuXo13/util/bpf_skel/.tmp/kwork_trace.bpf.o
> > util/bpf_skel/lock_contention.bpf.c:192:7: error: call to undeclared function 'bpf_core_type_matches'; ISO C99 and later do not support implicit function declarations [-Werror,-Wimplicit-function-declaration]
> >                 if (bpf_core_type_matches(struct rw_semaphore___old)) {
> >                     ^
> > util/bpf_skel/lock_contention.bpf.c:192:29: error: expected expression
> >                 if (bpf_core_type_matches(struct rw_semaphore___old)) {
> >                                           ^
> > util/bpf_skel/lock_contention.bpf.c:195:36: error: expected expression
> >                 } else if (bpf_core_type_matches(struct rw_semaphore___new)) {
> >                                                  ^
> > 3 errors generated.
> > /usr/bin/ld: bpf architecture of input file `/tmp/bperf_follower-74fba5.o' is incompatible with i386:x86-64 output
> > /usr/bin/ld: bpf architecture of input file `/tmp/bperf_leader-b2ec61.o' is incompatible with i386:x86-64 output
> > /usr/bin/ld: /usr/lib/gcc/x86_64-redhat-linux/12/../../../../lib64/crt1.o: in function `_start':
> > (.text+0x1b): undefined reference to `main'
> > /usr/bin/ld: final link failed: file in wrong format
> > /usr/bin/ld: /usr/lib/gcc/x86_64-redhat-linux/12/../../../../lib64/crt1.o: in function `_start':
> > (.text+0x1b): undefined reference to `main'
> > /usr/bin/ld: final link failed: file in wrong format
> > collect2: error: ld returned 1 exit status
> > collect2: error: ld returned 1 exit status
> > clang-15: error: linker (via gcc) command failed with exit code 1 (use -v to see invocation)
> > clang-15: error: linker (via gcc) command failed with exit code 1 (use -v to see invocation)
> > /usr/bin/ld: bpf architecture of input file `/tmp/func_latency-70b7d4.o' is incompatible with i386:x86-64 output
> > make[4]: *** [Makefile.perf:1081: /tmp/tmp.Rr5xDuXo13/util/bpf_skel/.tmp/lock_contention.bpf.o] Error 1
> > make[4]: *** Waiting for unfinished jobs....
> > make[4]: *** [Makefile.perf:1081: /tmp/tmp.Rr5xDuXo13/util/bpf_skel/.tmp/bperf_follower.bpf.o] Error 1
> > make[4]: *** [Makefile.perf:1081: /tmp/tmp.Rr5xDuXo13/util/bpf_skel/.tmp/bperf_leader.bpf.o] Error 1
> > /usr/bin/ld: /usr/lib/gcc/x86_64-redhat-linux/12/../../../../lib64/crt1.o: in function `_start':
> > (.text+0x1b): undefined reference to `main'
> > /usr/bin/ld: final link failed: file in wrong format
> > collect2: error: ld returned 1 exit status
> > clang-15: error: linker (via gcc) command failed with exit code 1 (use -v to see invocation)
> > make[4]: *** [Makefile.perf:1081: /tmp/tmp.Rr5xDuXo13/util/bpf_skel/.tmp/func_latency.bpf.o] Error 1
> > /usr/bin/ld: bpf architecture of input file `/tmp/bpf_prog_profiler-6e9720.o' is incompatible with i386:x86-64 output
> > /usr/bin/ld: /usr/lib/gcc/x86_64-redhat-linux/12/../../../../lib64/crt1.o: in function `_start':
> > (.text+0x1b): undefined reference to `main'
> > /usr/bin/ld: final link failed: file in wrong format
> > collect2: error: ld returned 1 exit status
> > clang-15: error: linker (via gcc) command failed with exit code 1 (use -v to see invocation)
> > make[4]: *** [Makefile.perf:1081: /tmp/tmp.Rr5xDuXo13/util/bpf_skel/.tmp/bpf_prog_profiler.bpf.o] Error 1
> > /usr/bin/ld: bpf architecture of input file `/tmp/kwork_trace-8d5b4e.o' is incompatible with i386:x86-64 output
> > /usr/bin/ld: /usr/lib/gcc/x86_64-redhat-linux/12/../../../../lib64/crt1.o: in function `_start':
> > (.text+0x1b): undefined reference to `main'
> > /usr/bin/ld: final link failed: file in wrong format
> > collect2: error: ld returned 1 exit status
> > clang-15: error: linker (via gcc) command failed with exit code 1 (use -v to see invocation)
> > make[4]: *** [Makefile.perf:1081: /tmp/tmp.Rr5xDuXo13/util/bpf_skel/.tmp/kwork_trace.bpf.o] Error 1
> > /usr/bin/ld: bpf architecture of input file `/tmp/off_cpu-1cb75d.o' is incompatible with i386:x86-64 output
> > /usr/bin/ld: /usr/lib/gcc/x86_64-redhat-linux/12/../../../../lib64/crt1.o: in function `_start':
> > (.text+0x1b): undefined reference to `main'
> > /usr/bin/ld: final link failed: file in wrong format
> > collect2: error: ld returned 1 exit status
> > clang-15: error: linker (via gcc) command failed with exit code 1 (use -v to see invocation)
> > make[4]: *** [Makefile.perf:1081: /tmp/tmp.Rr5xDuXo13/util/bpf_skel/.tmp/off_cpu.bpf.o] Error 1
> > /usr/bin/ld: bpf architecture of input file `/tmp/bperf_cgroup-45eb44.o' is incompatible with i386:x86-64 output
> > /usr/bin/ld: /usr/lib/gcc/x86_64-redhat-linux/12/../../../../lib64/crt1.o: in function `_start':
> > (.text+0x1b): undefined reference to `main'
> > /usr/bin/ld: final link failed: file in wrong format
> > collect2: error: ld returned 1 exit status
> > clang-15: error: linker (via gcc) command failed with exit code 1 (use -v to see invocation)
> > make[4]: *** [Makefile.perf:1081: /tmp/tmp.Rr5xDuXo13/util/bpf_skel/.tmp/bperf_cgroup.bpf.o] Error 1
> > make[3]: *** [Makefile.perf:236: sub-make] Error 2
> > make[2]: *** [Makefile:70: all] Error 2
> > make[1]: *** [tests/make:326: make_libbpf_dynamic_O] Error 1
> > make: *** [Makefile:103: build-test] Error 2
> > make: Leaving directory '/var/home/acme/git/perf-tools-next/tools/perf'
> >
> > real    5m55.192s
> > user    62m31.596s
> > sys     14m30.828s
> > ⬢[acme@toolbox perf-tools-next]$
> 
> Sorry, I was testing this on top of:
> https://lore.kernel.org/lkml/20230116010115.490713-1-irogers@google.com/
> The issue being that we're trying to use an old libbpf that the has
> meant disabling things but:
>   NO_BPF_SKEL := 1
> hadn't been set as part of this. I can address in v2, but with the
> "assume libbpf 1.0+" patch I hadn't been worrying about this as we'd
> error out for this case  - rather than build error. The erroring out
> can be worked around by just not having libbpf be dynamic (ie static
> or not at all by adding NO_LIBBPF=1).

I'll try adding that 3-patch series before this one.

- Arnaldo
