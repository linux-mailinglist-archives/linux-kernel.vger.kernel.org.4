Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0833B62DC5A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 14:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239750AbiKQNLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 08:11:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239689AbiKQNLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 08:11:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CBE6AEF0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 05:11:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2AC3F61E0A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 13:11:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5014DC43470;
        Thu, 17 Nov 2022 13:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668690664;
        bh=RM+UjhFLpENVu6wG/FPSZ49J2ylZfnuzSsNk6JF5Wl0=;
        h=Date:From:To:Cc:Subject:From;
        b=eiwx0+Bi/nXxhBH6FN6+osRylayv6wimxeHUU7rS9G7qRs6Ry59wewi475ZMGHc0S
         L4QAjsJtQkqETe48DX4xdT90d6de2pKMHmlIUHztsuXAG7maLUE8bz+YgsG/9i8Kgv
         m6vcUQymfhKMp6UDjZVsOxPsIdK+iGOENVz72YJPuJ3f66OhRemVM99yvLsB3uE6oP
         TW0GMFpVaxpe4L24csfiOm65EPd09b/zd6sgkh0BCjU+1NhOrm8oyDcQ/5UyA9jUFA
         QEWTYFa6+1V22v0DZe1HMgLLmJi12wP8G1WpDb/I3KQcjFGYJAJkOiAPye3N9RBu28
         DnV5qcayFgYxA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 08E264034E; Thu, 17 Nov 2022 10:11:01 -0300 (-03)
Date:   Thu, 17 Nov 2022 10:11:00 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>,
        Song Liu <songliubraving@fb.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Building perf with BUILD_BPF_SKEL=1
Message-ID: <Y3Yy5DFEoCEBv/Qi@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

	At some point we should switch to building with BPF skels by
default as there are many features that are implemented that way in
perf:

⬢[acme@toolbox perf]$ ls -la tools/perf/util/bpf_skel/
total 464
drwxr-xr-x. 1 acme acme  334 Oct 14 10:28 .
drwxr-xr-x. 1 acme acme 7380 Nov 17 09:22 ..
-rw-r--r--. 1 acme acme 5581 Oct 14 10:28 bperf_cgroup.bpf.c
-rw-r--r--. 1 acme acme 1764 Mar 14  2022 bperf_follower.bpf.c
-rw-r--r--. 1 acme acme 1438 Mar 14  2022 bperf_leader.bpf.c
-rw-r--r--. 1 acme acme  285 Mar 14  2022 bperf_u.h
-rw-r--r--. 1 acme acme 2290 Mar 14  2022 bpf_prog_profiler.bpf.c
-rw-r--r--. 1 acme acme 2164 Mar 27  2022 func_latency.bpf.c
-rw-r--r--. 1 acme acme   53 Nov  6  2021 .gitignore
-rw-r--r--. 1 acme acme 9017 Sep 27 09:29 kwork_trace.bpf.c
-rw-r--r--. 1 acme acme 3691 Oct  6 08:03 lock_contention.bpf.c
-rw-r--r--. 1 acme acme 6102 Oct  4 08:55 off_cpu.bpf.c
⬢[acme@toolbox perf]$


Since I'm finally using the Firefly ARM board the fine folks at
Librecomputer gave us at Kernel Recipes, I'm noticing issues as I go on
adding the components, for instance:

/bin/sh: 2: llvm-strip: not found
make[2]: *** [Makefile.perf:1136: /tmp/build/perf/util/bpf_skel/.tmp/bperf_follower.bpf.o] Error 127
make[2]: *** Waiting for unfinished jobs....
/bin/sh: 2: llvm-strip: not found
make[2]: *** [Makefile.perf:1136: /tmp/build/perf/util/bpf_skel/.tmp/bpf_prog_profiler.bpf.o] Error 127
/bin/sh: 2: llvm-strip: not found
make[2]: *** [Makefile.perf:1136: /tmp/build/perf/util/bpf_skel/.tmp/bperf_leader.bpf.o] Error 127
/bin/sh: 2: llvm-strip: not found
make[2]: *** [Makefile.perf:1136: /tmp/build/perf/util/bpf_skel/.tmp/func_latency.bpf.o] Error 127
/bin/sh: 2: llvm-strip: not found
make[2]: *** [Makefile.perf:1136: /tmp/build/perf/util/bpf_skel/.tmp/bperf_cgroup.bpf.o] Error 127
make[1]: *** [Makefile.perf:240: sub-make] Error 2
make: *** [Makefile:113: install-bin] Error 2
make: Leaving directory '/home/acme/git/perf/tools/perf'

So this is just me taking notes, feel free to fix it if you want ;-)

acme@roc-rk3399-pc:~/git/perf$ cat /etc/os-release
PRETTY_NAME="Ubuntu 22.04.1 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.1 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
acme@roc-rk3399-pc:~/git/perf$

perf should check for that and give per-distro hints on how to overcome
those, for instance, on ubuntu I had to:

acme@roc-rk3399-pc:~/git/perf$ dpkg -L llvm-14 | grep strip
/usr/share/man/man1/llvm-strip-14.1.gz
/usr/bin/llvm-bitcode-strip-14
/usr/bin/llvm-strip-14
/usr/lib/llvm-14/bin/llvm-bitcode-strip
/usr/lib/llvm-14/bin/llvm-strip
acme@roc-rk3399-pc:~/git/perf$ export PATH=$PATH:/usr/lib/llvm-14/bin


and now:

acme@roc-rk3399-pc:~/git/perf$ alias m
alias m='make -k BUILD_BPF_SKEL=1 CORESIGHT=1 O=/tmp/build/perf -C tools/perf install-bin && git status && perf test python'
acme@roc-rk3399-pc:~/git/perf$ m
make: Entering directory '/home/acme/git/perf/tools/perf'
  BUILD:   Doing 'make -j6' parallel build
Makefile.config:1136: No openjdk development package found, please install JDK package, e.g. openjdk-8-jdk, java-1.8.0-openjdk-devel

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
...                               get_cpuid: [ OFF ]
...                                     bpf: [ on  ]
...                                  libaio: [ on  ]
...                                 libzstd: [ on  ]

  INSTALL headers
<SNIP>
  GENSKEL /tmp/build/perf/util/bpf_skel/bpf_prog_profiler.skel.h
  GENSKEL /tmp/build/perf/util/bpf_skel/bperf_follower.skel.h
  GENSKEL /tmp/build/perf/util/bpf_skel/bperf_leader.skel.h
  GENSKEL /tmp/build/perf/util/bpf_skel/bperf_cgroup.skel.h
  GENSKEL /tmp/build/perf/util/bpf_skel/func_latency.skel.h
  CLANG   /tmp/build/perf/util/bpf_skel/.tmp/off_cpu.bpf.o
  CLANG   /tmp/build/perf/util/bpf_skel/.tmp/lock_contention.bpf.o
  CLANG   /tmp/build/perf/util/bpf_skel/.tmp/kwork_trace.bpf.o
  GEN     /tmp/build/perf/python/perf.so
  INSTALL trace_plugins
  GENSKEL /tmp/build/perf/util/bpf_skel/kwork_trace.skel.h
  GENSKEL /tmp/build/perf/util/bpf_skel/lock_contention.skel.h
  GENSKEL /tmp/build/perf/util/bpf_skel/off_cpu.skel.h
  CC      /tmp/build/perf/builtin-bench.o
<SNIP>
  CC      /tmp/build/perf/util/bpf-loader.o
  CC      /tmp/build/perf/util/bpf_map.o
  CC      /tmp/build/perf/util/bpf_counter.o
  CC      /tmp/build/perf/util/bpf_counter_cgroup.o
  CC      /tmp/build/perf/util/bpf_ftrace.o
  CC      /tmp/build/perf/util/bpf_off_cpu.o
  CC      /tmp/build/perf/util/bpf_kwork.o
  CC      /tmp/build/perf/util/bpf_lock_contention.o
  CC      /tmp/build/perf/util/bpf-prologue.o
<SNIP>
 INSTALL binaries
  INSTALL tests
  INSTALL libexec
  INSTALL bpf-examples
  INSTALL perf-archive
  INSTALL perf-iostat
  INSTALL strace/groups
  INSTALL perl-scripts
  INSTALL python-scripts
  INSTALL dlfilters
  INSTALL perf_completion-script
  INSTALL perf-tip
make: Leaving directory '/home/acme/git/perf/tools/perf'
On branch perf/core
Your branch is up to date with 'five/perf/core'.

nothing to commit, working tree clean
 19: 'import perf' in python                                         : Ok
acme@roc-rk3399-pc:~/git/perf$


Seems to work:

acme@roc-rk3399-pc:~/git/perf$ ls -la ~/bin/perf
-rwxr-xr-x 2 acme acme 21281824 Nov 17 12:45 /home/acme/bin/perf
acme@roc-rk3399-pc:~/git/perf$ strip ~/bin/perf
acme@roc-rk3399-pc:~/git/perf$ ls -la ~/bin/perf
-rwxr-xr-x 2 acme acme 4961472 Nov 17 12:47 /home/acme/bin/perf
acme@roc-rk3399-pc:~/git/perf$ ls -lah ~/bin/perf
-rwxr-xr-x 2 acme acme 4.8M Nov 17 12:47 /home/acme/bin/perf
acme@roc-rk3399-pc:~/git/perf$
root@roc-rk3399-pc:~# file ~/bin/perf
/root/bin/perf: symbolic link to /home/acme/bin/perf
root@roc-rk3399-pc:~# file /home/acme/bin/perf
/home/acme/bin/perf: ELF 64-bit LSB pie executable, ARM aarch64, version 1 (SYSV), dynamically linked, interpreter /lib/ld-linux-aarch64.so.1, BuildID[sha1]=54ecfa892a4ee52c4b57b86c11a5aeaa0603f49d, for GNU/Linux 3.7.0, stripped
root@roc-rk3399-pc:~#

Testing non-BPF skel integration on arm64 by using perf + BPF to trace
the perf_event_open, clone and kill system calls using as a workload
'perf stat' with one and then two events:

root@roc-rk3399-pc:~# perf trace -e ~acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o,perf_*,clone,kill perf stat -e cycles sleep 1
     0.000 clone(clone_flags: CHILD_CLEARTID|CHILD_SETTID|0x11) = 10801 (perf)
     2.988 perf_event_open(attr_uptr: { size: 128, sample_type: IDENTIFIER, read_format: TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING, disabled: 1, inherit: 1, enable_on_exec: 1, exclude_guest: 1 }, pid: 10801 (perf), cpu: -1, group_fd: -1, flags: FD_CLOEXEC) = 3

 Performance counter stats for 'sleep 1':

           5716210      cycles                                                                

       1.013109875 seconds time elapsed

       0.000000000 seconds user
       0.012232000 seconds sys


  1017.474 kill(pid: 10800 (perf), sig: CHLD)      = 0
root@roc-rk3399-pc:~# perf trace -e ~acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o,perf_*,clone,kill perf stat -e cycles,cache-misses sleep 1
     0.000 clone(clone_flags: CHILD_CLEARTID|CHILD_SETTID|0x11) = 10804 (perf)
     3.042 perf_event_open(attr_uptr: { size: 128, sample_type: IDENTIFIER, read_format: TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING, disabled: 1, inherit: 1, enable_on_exec: 1, exclude_guest: 1 }, pid: 10804 (perf), cpu: -1, group_fd: -1, flags: FD_CLOEXEC) = 3
     3.115 perf_event_open(attr_uptr: { size: 128, config: 0x3, sample_type: IDENTIFIER, read_format: TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING, disabled: 1, inherit: 1, enable_on_exec: 1, exclude_guest: 1 }, pid: 10804 (perf), cpu: -1, group_fd: -1, flags: FD_CLOEXEC) = 4

 Performance counter stats for 'sleep 1':

           5937955      cycles                                                                
             18037      cache-misses                                                          

       1.013214453 seconds time elapsed

       0.000000000 seconds user
       0.012167000 seconds sys


  1017.881 kill(pid: 10803 (perf), sig: CHLD)      = 0
root@roc-rk3399-pc:~#


First this was run with -e
~acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.c, and as
I have:

root@roc-rk3399-pc:~# cat ~/.perfconfig
[llvm]
	dump-obj = true
	clang-opt = -g
[trace]
	show_zeros = no
	show_duration = no
	no_inherit = yes
	args_alignment = 40
root@roc-rk3399-pc:~#

Then that 'dump-obj' ends up keeping the .o BPF bytecode saved:

root@roc-rk3399-pc:~# file ~acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o
/home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o: ELF 64-bit LSB relocatable, eBPF, version 1 (SYSV), with debug_info, not stripped
root@roc-rk3399-pc:~#

And I can reuse it to skip compiling it using clang (version 14 on this
ubuntu 22.04.1 system).

Now trying some of those bpf skels:

root@roc-rk3399-pc:~# perf ftrace latency -b -n -T dput -a sleep 1
libbpf: failed to add legacy kprobe event for 'dput+0x0': No such file or directory
libbpf: prog 'func_begin': failed to create kprobe 'dput+0x0' perf event: No such file or directory
libbpf: failed to add legacy kprobe event for 'dput+0x0': No such file or directory
libbpf: prog 'func_end': failed to create kretprobe 'dput+0x0' perf event: No such file or directory
No data found
root@roc-rk3399-pc:~#

root@roc-rk3399-pc:~# perf record sleep 12
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.018 MB perf.data (10 samples) ]


root@roc-rk3399-pc:~#
root@roc-rk3399-pc:~#
root@roc-rk3399-pc:~# perf report
root@roc-rk3399-pc:~# perf ftrace latency -b -T mas_wr_walk -a sleep 1
libbpf: failed to add legacy kprobe event for 'mas_wr_walk+0x0': No such file or directory
libbpf: prog 'func_begin': failed to create kprobe 'mas_wr_walk+0x0' perf event: No such file or directory
libbpf: failed to add legacy kprobe event for 'mas_wr_walk+0x0': No such file or directory
libbpf: prog 'func_end': failed to create kretprobe 'mas_wr_walk+0x0' perf event: No such file or directory
No data found
root@roc-rk3399-pc:~# perf report --stdio
# To display the perf.data header info, please use --header/--header-only options.
#
#
# Total Lost Samples: 0
#
# Samples: 10  of event 'cycles'
# Event count (approx.): 3110967
#
# Overhead  Command  Shared Object     Symbol
# ........  .......  ................  ...............................
#
    41.69%  sleep    [kernel.vmlinux]  [k] mas_leaf_max_gap
    41.54%  sleep    [kernel.vmlinux]  [k] mas_wr_walk
    15.61%  sleep    [kernel.vmlinux]  [k] copy_page
     1.09%  sleep    [kernel.vmlinux]  [k] shift_arg_pages
     0.06%  perf-ex  [kernel.vmlinux]  [k] _raw_spin_unlock_irqrestore
     0.00%  perf-ex  [kernel.vmlinux]  [k] perf_event_exec


#
# (Tip: Create an archive with symtabs to analyse on other machine: perf archive)
#
root@roc-rk3399-pc:~#

I'll continue this later.

- Arnaldo
