Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2B260BC76
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 23:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbiJXVrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 17:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbiJXVrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 17:47:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69FC5284863;
        Mon, 24 Oct 2022 12:59:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDCB961311;
        Mon, 24 Oct 2022 16:00:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B890C433C1;
        Mon, 24 Oct 2022 16:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666627227;
        bh=EVAYfMKE9Eo6AFfRKFU6iEdQh2/305u7wefJVS+vo0k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oPB/wuYCLO3IcaGm6/aQ9LRiL9xySvaj4hheCXPJ+9ipDPokdqO83sFGhskvrMfrJ
         +93uMJKNpDu3EmTgD18bILB5e3zCfUYDIA3ADNN9y4ttksrlbvcwZu1pE8ZU80fkYX
         c9wnWDzhik6gMJJ+xq/7ho719yYLAfOgzNPQ7Wenvo6gxVTNzQWTM6g8QSD8WZfM7M
         2k/STipk9LcC5IkAngyCKy+FwmODdGZYH2VLJ3FMLz82D9awS3E/JDPZryY4xQhp8h
         bz658eJmzZS2KH1VFuNgUF1pSke48N+N3xKIFFCe5SEqOxhWN6hL7FuKJSj3BYaGb6
         8vA/V5T7hSPVQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E2FAB404BE; Mon, 24 Oct 2022 13:00:22 -0300 (-03)
Date:   Mon, 24 Oct 2022 13:00:22 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 3/8] perf test: Use a test program in perf record tests
Message-ID: <Y1a2lmO/dmjEiZb0@kernel.org>
References: <20221020172643.3458767-1-namhyung@kernel.org>
 <20221020172643.3458767-4-namhyung@kernel.org>
 <CAP-5=fWKCdyFzR8ZZSK_2v6vT_RKngxxnXGieUVb8PBATJ64eQ@mail.gmail.com>
 <Y1Z3/t4RtnB8r03t@kernel.org>
 <960317d2-1bf8-cc2a-8772-8d0f5a136b6b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <960317d2-1bf8-cc2a-8772-8d0f5a136b6b@intel.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Oct 24, 2022 at 05:00:14PM +0300, Adrian Hunter escreveu:
> On 24/10/22 14:33, Arnaldo Carvalho de Melo wrote:
> > Em Thu, Oct 20, 2022 at 04:52:14PM -0700, Ian Rogers escreveu:
> >> I wonder if these utilities should just be built into perf to avoid
> >> the cc dependency. Perhaps we can have a hidden option built into
> >> perf test.

> > Agreed, not depending on a compiler makes 'perf test' usable in more
> > systems, particularly production ones where we may want to check if perf
> > is passing all tests applicable to that system.
 
> I haven't seen anyone package anything except the perf executable, so
> I presume the only people running these tests install the source, and
> so need a compiler anyway.

Humm?

[root@quaco ~]# head -3 /etc/os-release
NAME="Fedora Linux"
VERSION="36 (Workstation Edition)"
ID=fedora
[root@quaco ~]#G

[root@quaco ~]# rpm -qi perf
Name        : perf
Version     : 5.19.4
Release     : 200.fc36
Architecture: x86_64
Install Date: Mon 24 Oct 2022 12:57:34 PM -03
Group       : Unspecified
Size        : 12663136
License     : GPLv2
Signature   : RSA/SHA256, Thu 25 Aug 2022 07:16:04 PM -03, Key ID 999f7cbf38ab71f4
Source RPM  : kernel-tools-5.19.4-200.fc36.src.rpm
Build Date  : Thu 25 Aug 2022 06:30:42 PM -03
Build Host  : bkernel02.iad2.fedoraproject.org
Packager    : Fedora Project
Vendor      : Fedora Project
URL         : http://www.kernel.org/
Bug URL     : https://bugz.fedoraproject.org/kernel-tools
Summary     : Performance monitoring for the Linux kernel
Description :
This package contains the perf tool, which enables performance monitoring
of the Linux kernel.
[root@quaco ~]#

[root@quaco ~]# rpm -ql perf
/etc/bash_completion.d/perf
/usr/bin/perf
/usr/lib/.build-id
/usr/lib/.build-id/0c
/usr/lib/.build-id/0c/54d587cab1b533b9ab777717ddd256ff84f241
/usr/lib/.build-id/15
/usr/lib/.build-id/15/6552556be0d4ca8cffb8e002d8a67add55aed5
/usr/lib/.build-id/15/c4dfaa3861f530ef60def5506385d4b0b8924f
/usr/lib/.build-id/1f
/usr/lib/.build-id/1f/799c084e326516a24a647cfd5f484cd054e0a2
/usr/lib/.build-id/23
/usr/lib/.build-id/23/311fe148dd3f3d487ca5ace54ff2faa72ea8da
/usr/lib/.build-id/37
/usr/lib/.build-id/37/c9ee70f321fae7fc1fc00fca91514c63f9f052
/usr/lib/.build-id/54
/usr/lib/.build-id/54/43b6bc332ad188b907fdde69ac02c9a69d158f
/usr/lib/.build-id/7e
/usr/lib/.build-id/7e/55e7a8e4df03137ec23b4135e205bc8eb77e05
/usr/lib/.build-id/84
/usr/lib/.build-id/84/3c3863a123d129c98fa7cb99a58d620c9e5edc
/usr/lib/.build-id/86
/usr/lib/.build-id/86/d063d2f9833a447d96504e5f9e472048d12c49
/usr/lib/.build-id/98
/usr/lib/.build-id/98/a28589fde6ce95d9f3d305f7c9853333a9415b
/usr/lib/.build-id/9e
/usr/lib/.build-id/9e/567f55ca9c2b4867eb95d4182da07d4843976d
/usr/lib/.build-id/b6
/usr/lib/.build-id/b6/f8c9a6d6e1990f8577a9fbac875f812a316a20
/usr/lib/.build-id/c0
/usr/lib/.build-id/c0/8b255f02ce8f3e90df2b6156d2d38b1221995d
/usr/lib/.build-id/d5/e964c3413f52492e6355852d25b2ab23b03e38
/usr/lib/.build-id/e8
/usr/lib/.build-id/e8/2de614bf77f501a4511cb70151b98392669c77
/usr/lib64/libperf-jvmti.so
/usr/libexec/perf-core
/usr/libexec/perf-core/dlfilters
/usr/libexec/perf-core/dlfilters/dlfilter-show-cycles.so
/usr/libexec/perf-core/dlfilters/dlfilter-test-api-v0.so
/usr/libexec/perf-core/perf-archive
/usr/libexec/perf-core/perf-iostat
/usr/libexec/perf-core/scripts
/usr/libexec/perf-core/scripts/perl
/usr/libexec/perf-core/scripts/perl/Perf-Trace-Util
/usr/libexec/perf-core/scripts/perl/Perf-Trace-Util/lib
/usr/libexec/perf-core/scripts/perl/Perf-Trace-Util/lib/Perf
/usr/libexec/perf-core/scripts/perl/Perf-Trace-Util/lib/Perf/Trace
/usr/libexec/perf-core/scripts/perl/Perf-Trace-Util/lib/Perf/Trace/Context.pm
/usr/libexec/perf-core/scripts/perl/Perf-Trace-Util/lib/Perf/Trace/Core.pm
/usr/libexec/perf-core/scripts/perl/Perf-Trace-Util/lib/Perf/Trace/Util.pm
/usr/libexec/perf-core/scripts/perl/bin
/usr/libexec/perf-core/scripts/perl/bin/check-perf-trace-record
/usr/libexec/perf-core/scripts/perl/bin/failed-syscalls-record
/usr/libexec/perf-core/scripts/perl/bin/failed-syscalls-report
/usr/libexec/perf-core/scripts/perl/bin/rw-by-file-record
/usr/libexec/perf-core/scripts/perl/bin/rw-by-file-report
/usr/libexec/perf-core/scripts/perl/bin/rw-by-pid-record
/usr/libexec/perf-core/scripts/perl/bin/rw-by-pid-report
/usr/libexec/perf-core/scripts/perl/bin/rwtop-record
/usr/libexec/perf-core/scripts/perl/bin/rwtop-report
/usr/libexec/perf-core/scripts/perl/bin/wakeup-latency-record
/usr/libexec/perf-core/scripts/perl/bin/wakeup-latency-report
/usr/libexec/perf-core/scripts/perl/check-perf-trace.pl
/usr/libexec/perf-core/scripts/perl/failed-syscalls.pl
/usr/libexec/perf-core/scripts/perl/rw-by-file.pl
/usr/libexec/perf-core/scripts/perl/rw-by-pid.pl
/usr/libexec/perf-core/scripts/perl/rwtop.pl
/usr/libexec/perf-core/scripts/perl/wakeup-latency.pl
/usr/libexec/perf-core/scripts/python
/usr/libexec/perf-core/scripts/python/Perf-Trace-Util
/usr/libexec/perf-core/scripts/python/Perf-Trace-Util/lib
/usr/libexec/perf-core/scripts/python/Perf-Trace-Util/lib/Perf
/usr/libexec/perf-core/scripts/python/Perf-Trace-Util/lib/Perf/Trace
/usr/libexec/perf-core/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Core.py
/usr/libexec/perf-core/scripts/python/Perf-Trace-Util/lib/Perf/Trace/EventClass.py
/usr/libexec/perf-core/scripts/python/Perf-Trace-Util/lib/Perf/Trace/SchedGui.py
/usr/libexec/perf-core/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Util.py
/usr/libexec/perf-core/scripts/python/arm-cs-trace-disasm.py
/usr/libexec/perf-core/scripts/python/bin
/usr/libexec/perf-core/scripts/python/bin/compaction-times-record
/usr/libexec/perf-core/scripts/python/bin/compaction-times-report
/usr/libexec/perf-core/scripts/python/bin/event_analyzing_sample-record
/usr/libexec/perf-core/scripts/python/bin/event_analyzing_sample-report
/usr/libexec/perf-core/scripts/python/bin/export-to-postgresql-record
/usr/libexec/perf-core/scripts/python/bin/export-to-postgresql-report
/usr/libexec/perf-core/scripts/python/bin/export-to-sqlite-record
/usr/libexec/perf-core/scripts/python/bin/export-to-sqlite-report
/usr/libexec/perf-core/scripts/python/bin/failed-syscalls-by-pid-record
/usr/libexec/perf-core/scripts/python/bin/failed-syscalls-by-pid-report
/usr/libexec/perf-core/scripts/python/bin/flamegraph-record
/usr/libexec/perf-core/scripts/python/bin/flamegraph-report
/usr/libexec/perf-core/scripts/python/bin/futex-contention-record
/usr/libexec/perf-core/scripts/python/bin/futex-contention-report
/usr/libexec/perf-core/scripts/python/bin/intel-pt-events-record
/usr/libexec/perf-core/scripts/python/bin/intel-pt-events-report
/usr/libexec/perf-core/scripts/python/bin/mem-phys-addr-record
/usr/libexec/perf-core/scripts/python/bin/mem-phys-addr-report
/usr/libexec/perf-core/scripts/python/bin/net_dropmonitor-record
/usr/libexec/perf-core/scripts/python/bin/net_dropmonitor-report
/usr/libexec/perf-core/scripts/python/bin/netdev-times-record
/usr/libexec/perf-core/scripts/python/bin/netdev-times-report
/usr/libexec/perf-core/scripts/python/bin/powerpc-hcalls-record
/usr/libexec/perf-core/scripts/python/bin/powerpc-hcalls-report
/usr/libexec/perf-core/scripts/python/bin/sched-migration-record
/usr/libexec/perf-core/scripts/python/bin/sched-migration-report
/usr/libexec/perf-core/scripts/python/bin/sctop-record
/usr/libexec/perf-core/scripts/python/bin/sctop-report
/usr/libexec/perf-core/scripts/python/bin/stackcollapse-record
/usr/libexec/perf-core/scripts/python/bin/stackcollapse-report
/usr/libexec/perf-core/scripts/python/bin/syscall-counts-by-pid-record
/usr/libexec/perf-core/scripts/python/bin/syscall-counts-by-pid-report
/usr/libexec/perf-core/scripts/python/bin/syscall-counts-record
/usr/libexec/perf-core/scripts/python/bin/syscall-counts-report
/usr/libexec/perf-core/scripts/python/check-perf-trace.py
/usr/libexec/perf-core/scripts/python/compaction-times.py
/usr/libexec/perf-core/scripts/python/event_analyzing_sample.py
/usr/libexec/perf-core/scripts/python/export-to-postgresql.py
/usr/libexec/perf-core/scripts/python/export-to-sqlite.py
/usr/libexec/perf-core/scripts/python/exported-sql-viewer.py
/usr/libexec/perf-core/scripts/python/failed-syscalls-by-pid.py
/usr/libexec/perf-core/scripts/python/flamegraph.py
/usr/libexec/perf-core/scripts/python/futex-contention.py
/usr/libexec/perf-core/scripts/python/intel-pt-events.py
/usr/libexec/perf-core/scripts/python/libxed.py
/usr/libexec/perf-core/scripts/python/mem-phys-addr.py
/usr/libexec/perf-core/scripts/python/net_dropmonitor.py
/usr/libexec/perf-core/scripts/python/netdev-times.py
/usr/libexec/perf-core/scripts/python/powerpc-hcalls.py
/usr/libexec/perf-core/scripts/python/sched-migration.py
/usr/libexec/perf-core/scripts/python/sctop.py
/usr/libexec/perf-core/scripts/python/stackcollapse.py
/usr/libexec/perf-core/scripts/python/stat-cpi.py
/usr/libexec/perf-core/scripts/python/syscall-counts-by-pid.py
/usr/libexec/perf-core/scripts/python/syscall-counts.py
/usr/libexec/perf-core/tests
/usr/libexec/perf-core/tests/attr
/usr/libexec/perf-core/tests/attr.py
/usr/libexec/perf-core/tests/attr/README
/usr/libexec/perf-core/tests/attr/base-record
/usr/libexec/perf-core/tests/attr/base-record-spe
/usr/libexec/perf-core/tests/attr/base-stat
/usr/libexec/perf-core/tests/attr/system-wide-dummy
/usr/libexec/perf-core/tests/attr/test-record-C0
/usr/libexec/perf-core/tests/attr/test-record-basic
/usr/libexec/perf-core/tests/attr/test-record-branch-any
/usr/libexec/perf-core/tests/attr/test-record-branch-filter-any
/usr/libexec/perf-core/tests/attr/test-record-branch-filter-any_call
/usr/libexec/perf-core/tests/attr/test-record-branch-filter-any_ret
/usr/libexec/perf-core/tests/attr/test-record-branch-filter-hv
/usr/libexec/perf-core/tests/attr/test-record-branch-filter-ind_call
/usr/libexec/perf-core/tests/attr/test-record-branch-filter-k
/usr/libexec/perf-core/tests/attr/test-record-branch-filter-u
/usr/libexec/perf-core/tests/attr/test-record-count
/usr/libexec/perf-core/tests/attr/test-record-data
/usr/libexec/perf-core/tests/attr/test-record-freq
/usr/libexec/perf-core/tests/attr/test-record-graph-default
/usr/libexec/perf-core/tests/attr/test-record-graph-default-aarch64
/usr/libexec/perf-core/tests/attr/test-record-graph-dwarf
/usr/libexec/perf-core/tests/attr/test-record-graph-fp
/usr/libexec/perf-core/tests/attr/test-record-graph-fp-aarch64
/usr/libexec/perf-core/tests/attr/test-record-group
/usr/libexec/perf-core/tests/attr/test-record-group-sampling
/usr/libexec/perf-core/tests/attr/test-record-group1
/usr/libexec/perf-core/tests/attr/test-record-group2
/usr/libexec/perf-core/tests/attr/test-record-no-buffering
/usr/libexec/perf-core/tests/attr/test-record-no-inherit
/usr/libexec/perf-core/tests/attr/test-record-no-samples
/usr/libexec/perf-core/tests/attr/test-record-period
/usr/libexec/perf-core/tests/attr/test-record-pfm-period
/usr/libexec/perf-core/tests/attr/test-record-raw
/usr/libexec/perf-core/tests/attr/test-record-spe-period
/usr/libexec/perf-core/tests/attr/test-record-spe-period-term
/usr/libexec/perf-core/tests/attr/test-record-spe-physical-address
/usr/libexec/perf-core/tests/attr/test-stat-C0
/usr/libexec/perf-core/tests/attr/test-stat-basic
/usr/libexec/perf-core/tests/attr/test-stat-default
/usr/libexec/perf-core/tests/attr/test-stat-detailed-1
/usr/libexec/perf-core/tests/attr/test-stat-detailed-2
/usr/libexec/perf-core/tests/attr/test-stat-detailed-3
/usr/libexec/perf-core/tests/attr/test-stat-group
/usr/libexec/perf-core/tests/attr/test-stat-group1
/usr/libexec/perf-core/tests/attr/test-stat-no-inherit
/usr/libexec/perf-core/tests/pe-file.exe
/usr/libexec/perf-core/tests/pe-file.exe.debug
/usr/libexec/perf-core/tests/shell
/usr/libexec/perf-core/tests/shell/buildid.sh
/usr/libexec/perf-core/tests/shell/daemon.sh
/usr/libexec/perf-core/tests/shell/lib
/usr/libexec/perf-core/tests/shell/lib/probe.sh
/usr/libexec/perf-core/tests/shell/lib/probe_vfs_getname.sh
/usr/libexec/perf-core/tests/shell/pipe_test.sh
/usr/libexec/perf-core/tests/shell/probe_vfs_getname.sh
/usr/libexec/perf-core/tests/shell/record+probe_libc_inet_pton.sh
/usr/libexec/perf-core/tests/shell/record+script_probe_vfs_getname.sh
/usr/libexec/perf-core/tests/shell/record+zstd_comp_decomp.sh
/usr/libexec/perf-core/tests/shell/record.sh
/usr/libexec/perf-core/tests/shell/record_offcpu.sh
/usr/libexec/perf-core/tests/shell/stat+csv_output.sh
/usr/libexec/perf-core/tests/shell/stat+csv_summary.sh
/usr/libexec/perf-core/tests/shell/stat+shadow_stat.sh
/usr/libexec/perf-core/tests/shell/stat.sh
/usr/libexec/perf-core/tests/shell/stat_all_metricgroups.sh
/usr/libexec/perf-core/tests/shell/stat_all_metrics.sh
/usr/libexec/perf-core/tests/shell/stat_all_pmu.sh
/usr/libexec/perf-core/tests/shell/stat_bpf_counters.sh
/usr/libexec/perf-core/tests/shell/test_arm_callgraph_fp.sh
/usr/libexec/perf-core/tests/shell/test_arm_coresight.sh
/usr/libexec/perf-core/tests/shell/test_arm_spe.sh
/usr/libexec/perf-core/tests/shell/test_arm_spe_fork.sh
/usr/libexec/perf-core/tests/shell/test_intel_pt.sh
/usr/libexec/perf-core/tests/shell/trace+probe_vfs_getname.sh
/usr/share/doc/perf
/usr/share/doc/perf-tip/tips.txt
/usr/share/doc/perf/examples.txt
/usr/share/licenses/perf
/usr/share/licenses/perf/COPYING
/usr/share/man/man1/perf-annotate.1.gz
/usr/share/man/man1/perf-archive.1.gz
/usr/share/man/man1/perf-arm-spe.1.gz
/usr/share/man/man1/perf-bench.1.gz
/usr/share/man/man1/perf-buildid-cache.1.gz
/usr/share/man/man1/perf-buildid-list.1.gz
/usr/share/man/man1/perf-c2c.1.gz
/usr/share/man/man1/perf-config.1.gz
/usr/share/man/man1/perf-daemon.1.gz
/usr/share/man/man1/perf-data.1.gz
/usr/share/man/man1/perf-diff.1.gz
/usr/share/man/man1/perf-dlfilter.1.gz
/usr/share/man/man1/perf-evlist.1.gz
/usr/share/man/man1/perf-ftrace.1.gz
/usr/share/man/man1/perf-help.1.gz
/usr/share/man/man1/perf-inject.1.gz
/usr/share/man/man1/perf-intel-pt.1.gz
/usr/share/man/man1/perf-iostat.1.gz
/usr/share/man/man1/perf-kallsyms.1.gz
/usr/share/man/man1/perf-kmem.1.gz
/usr/share/man/man1/perf-kvm.1.gz
/usr/share/man/man1/perf-list.1.gz
/usr/share/man/man1/perf-lock.1.gz
/usr/share/man/man1/perf-mem.1.gz
/usr/share/man/man1/perf-probe.1.gz
/usr/share/man/man1/perf-record.1.gz
/usr/share/man/man1/perf-report.1.gz
/usr/share/man/man1/perf-sched.1.gz
/usr/share/man/man1/perf-script-perl.1.gz
/usr/share/man/man1/perf-script-python.1.gz
/usr/share/man/man1/perf-script.1.gz
/usr/share/man/man1/perf-stat.1.gz
/usr/share/man/man1/perf-test.1.gz
/usr/share/man/man1/perf-timechart.1.gz
/usr/share/man/man1/perf-top.1.gz
/usr/share/man/man1/perf-trace.1.gz
/usr/share/man/man1/perf-version.1.gz
/usr/share/man/man1/perf.1.gz
/usr/share/perf-core
/usr/share/perf-core/strace
/usr/share/perf-core/strace/groups
/usr/share/perf-core/strace/groups/file
/usr/share/perf-core/strace/groups/string
