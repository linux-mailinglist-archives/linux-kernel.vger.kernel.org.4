Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55559618917
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 20:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbiKCT4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 15:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiKCTzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 15:55:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA6021E18;
        Thu,  3 Nov 2022 12:54:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A6A661FCB;
        Thu,  3 Nov 2022 19:54:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F3F0C433D6;
        Thu,  3 Nov 2022 19:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667505284;
        bh=AbiY7cN65HPS8EYQTB+q5R1lXm23+3//zjzbsANv3f8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lol4m7Pv1BeT3bdgE6Zx3lHcIg9wQN3/cyLFT3HpHgO/De/tIDGutYi7JKSnM1CcE
         reFvOyvEzdqPEJNLNZlrnlrDZ5fTG3AhdKUhUHP1qI8+mFVuxre0JhvF6wTsArszGL
         bdYFXQhDb/vP3cAI3Bas+4gNhUnA1jqJXpI+kXvH/ENlmMbH/3g99DROKH0XoFsuFt
         QhBtaEHfGLXwC3anbUQ2P/UIrigPOokwIimS3115KsbMElroaCton0Ski226DQdLoi
         OIceV3+WXJ605t/6SxKD1nSlk2jU9qavHXNwVg7oE4lK9K0ywpmNEk+a5+wtfqbDDL
         Y/V8n7DBPwTJg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4D9214034E; Thu,  3 Nov 2022 16:54:41 -0300 (-03)
Date:   Thu, 3 Nov 2022 16:54:41 -0300
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
Message-ID: <Y2QcgdJNXE/bVZvk@kernel.org>
References: <20221103045437.163510-1-irogers@google.com>
 <20221103045437.163510-7-irogers@google.com>
 <Y2PgBPeZsd9+YWB4@kernel.org>
 <Y2Pgz7luG77Wr+Ci@kernel.org>
 <Y2Pj0KVbbw9rMcPH@kernel.org>
 <CAP-5=fXkM52E5VvX9s2CfvF8ckQvcbSm8N_7BCfhW3dyuH7YUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXkM52E5VvX9s2CfvF8ckQvcbSm8N_7BCfhW3dyuH7YUg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Nov 03, 2022 at 09:04:49AM -0700, Ian Rogers escreveu:
> On Thu, Nov 3, 2022 at 8:52 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > Em Thu, Nov 03, 2022 at 12:39:59PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Em Thu, Nov 03, 2022 at 12:36:36PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > > [root@quaco ~]# perf trace -e /home/acme/git/perf/tools/perf/examples/bpf/5sec.c
> > > > /home/acme/git/perf/tools/perf/examples/bpf/5sec.c:42:10: fatal error: 'bpf/bpf_helpers.h' file not found
> > > > #include <bpf/bpf_helpers.h>
> > > >          ^~~~~~~~~~~~~~~~~~~
> > > > 1 error generated.
> > > > ERROR:      unable to compile /home/acme/git/perf/tools/perf/examples/bpf/5sec.c
> > > > Hint:       Check error message shown above.
> > > > Hint:       You can also pre-compile it into .o using:
> > > >                     clang -target bpf -O2 -c /home/acme/git/perf/tools/perf/examples/bpf/5sec.c
> > > >             with proper -I and -D options.
> > > > event syntax error: '/home/acme/git/perf/tools/perf/examples/bpf/5sec.c'
> > > >                      \___ Failed to load /home/acme/git/perf/tools/perf/examples/bpf/5sec.c from source: Error when compiling BPF scriptlet
> > > >
> > > > (add -v to see detail)
> > > > Run 'perf list' for a list of valid events
> > > >
> > > >  Usage: perf trace [<options>] [<command>]
> > > >     or: perf trace [<options>] -- <command> [<options>]
> > > >     or: perf trace record [<options>] [<command>]
> > > >     or: perf trace record [<options>] -- <command> [<options>]
> > > >
> > > >     -e, --event <event>   event/syscall selector. use 'perf list' to list available events
> > > > [root@quaco ~]#
> > > >
> > > > It is not even finding it, in this machine I have libbpf 0.7.0, so there
> > > > is a /usr/include/bpf/bpf_helpers.h, but probably that isn't in the
> > > > include path set up to build the tools/perf/examples/bpf/ files, perhaps
> > > > it should use:
> > > >
> > > > -Itools/lib/  so that it gets tools/lib/bpf_helpers.h?
> > > >
> > > > Trying to get this tested...
> > >
> > > Running with -v:
> > >
> > > llvm compiling command : /usr/lib64/ccache/clang -D__KERNEL__ -D__NR_CPUS__=8 -DLINUX_VERSION_CODE=0x51310 -g -I/home/acme/lib/perf/include/bpf -nostdinc -I./arch/x86/include -I./arch/x86/include/generated  -I./include -I./arch/x86/include/uapi -I./arch/x86/include/generated/uapi -I./include/uapi -I./include/generated/uapi -include ./include/linux/compiler-version.h -include ./include/linux/kconfig.h  -Wno-unused-value -Wno-pointer-sign -working-directory /lib/modules/5.19.16-200.fc36.x86_64/build -c /home/acme/git/perf/tools/perf/examples/bpf/5sec.c -target bpf  -g -O2 -o -
> > > /home/acme/git/perf/tools/perf/examples/bpf/5sec.c:42:10: fatal error: 'bpf/bpf_helpers.h' file not found
> > >
> > > There is still that -I/home/acme/lib/perf/include/bpf, I'll remove it
> > > from the include path and try to replace it with the libbpf path...
> >
> > Ok, works with the patch below, that needs some more renaming from "perf_" to
> > "libbpf_", etc:
> >
> > [root@quaco ~]# perf trace -e /home/acme/git/perf/tools/perf/examples/bpf/5sec.c  sleep 5
> >      0.000 sleep/160828 perf_bpf_probe:hrtimer_nanosleep(__probe_ip: -1474734416, rqtp: 5000000000)
> > [root@quaco ~]#
> >
> > Since I have:
> >
> > [root@quaco ~]# cat ~/.perfconfig
> > [llvm]
> >         dump-obj = true
> >         clang-opt = -g
> > #

> > I end up with:

> > [root@quaco ~]# ls -la /home/acme/git/perf/tools/perf/examples/bpf/5sec.o
> > -rw-r--r--. 1 root root 3696 Nov  3 12:47 /home/acme/git/perf/tools/perf/examples/bpf/5sec.o
> > [root@quaco ~]# file /home/acme/git/perf/tools/perf/examples/bpf/5sec.o
> > /home/acme/git/perf/tools/perf/examples/bpf/5sec.o: ELF 64-bit LSB relocatable, eBPF, version 1 (SYSV), with debug_info, not stripped
> > [root@quaco ~]#

> > and can test with the pre-built .o eBPF bytecode + capped backtrace:

> > [root@quaco ~]# perf trace -e /home/acme/git/perf/tools/perf/examples/bpf/5sec.o/max-stack=6/  sleep 5
> >      0.000 sleep/161037 perf_bpf_probe:hrtimer_nanosleep(__probe_ip: -1474734416, rqtp: 5000000000)
> >                                        hrtimer_nanosleep ([kernel.kallsyms])
> >                                        common_nsleep ([kernel.kallsyms])
> >                                        __x64_sys_clock_nanosleep ([kernel.kallsyms])
> >                                        do_syscall_64 ([kernel.kallsyms])
> >                                        entry_SYSCALL_64_after_hwframe ([kernel.kallsyms])
> >                                        __GI___clock_nanosleep (/usr/lib64/libc.so.6)
> > [root@quaco ~]#

> > I'll test the other examples with these changes after I drive Pedro to
> > school and get back to the office.

> Thanks, I was somewhat coding in the dark with this as I was using a
> bpf object file and clearly there's been some attention missed for a
> while in these code paths.

Sure, the way libbpf provided its services has been changing.

> I couldn't get the hello variant to do anything with the openat
> tracing it was set up for, for example, the change puts the call on
> the sys_enter raw syscall. I suspect you remember how these things
> should be and I'm happy to roll a v2, have you fix it, etc.

So, with my change:

[root@quaco ~]# perf trace -e ~acme/git/perf/tools/perf/examples/bpf/hello.c --call-graph=dwarf sleep 0.09
BFD: DWARF error: could not find variable specification at offset 0x6ed3
BFD: DWARF error: could not find variable specification at offset 0x3ca3
BFD: DWARF error: could not find variable specification at offset 0x1b8f
BFD: DWARF error: could not find variable specification at offset 0x3853
BFD: DWARF error: could not find variable specification at offset 0x71eb
     0.000 sleep/167762 __bpf_stdout__(Hello, world)
                                       syscall_trace_enter.constprop.0 ([kernel.kallsyms])
                                       syscall_trace_enter.constprop.0 ([kernel.kallsyms])
                                       do_syscall_64 ([kernel.kallsyms])
                                       entry_SYSCALL_64_after_hwframe ([kernel.kallsyms])
                                       __brk (/usr/lib64/ld-linux-x86-64.so.2)
                                       _dl_sysdep_start (/usr/lib64/ld-linux-x86-64.so.2)
                                       _dl_start_final (inlined)
                                       _dl_start (/usr/lib64/ld-linux-x86-64.so.2)
                                       _start (/usr/lib64/ld-linux-x86-64.so.2)
BFD: DWARF error: could not find variable specification at offset 0x3e33
BFD: DWARF error: could not find variable specification at offset 0x4eef
BFD: DWARF error: could not find variable specification at offset 0x6edf
     0.021 sleep/167762 __bpf_stdout__(Hello, world)
                                       syscall_trace_enter.constprop.0 ([kernel.kallsyms])
                                       syscall_trace_enter.constprop.0 ([kernel.kallsyms])
                                       do_syscall_64 ([kernel.kallsyms])
                                       entry_SYSCALL_64_after_hwframe ([kernel.kallsyms])
                                       get_cet_status (inlined)
                                       init_cpu_features (inlined)
                                       dl_platform_init (inlined)
                                       _dl_sysdep_start (/usr/lib64/ld-linux-x86-64.so.2)
                                       _dl_start_final (inlined)
                                       _dl_start (/usr/lib64/ld-linux-x86-64.so.2)
                                       _start (/usr/lib64/ld-linux-x86-64.so.2)
     0.040 sleep/167762 __bpf_stdout__(Hello, world)
                                       syscall_trace_enter.constprop.0 ([kernel.kallsyms])
                                       syscall_trace_enter.constprop.0 ([kernel.kallsyms])
                                       do_syscall_64 ([kernel.kallsyms])
                                       entry_SYSCALL_64_after_hwframe ([kernel.kallsyms])
                                       __access (inlined)
                                       dl_main (/usr/lib64/ld-linux-x86-64.so.2)
                                       _dl_sysdep_start (/usr/lib64/ld-linux-x86-64.so.2)
                                       _dl_start_final (inlined)
                                       _dl_start (/usr/lib64/ld-linux-x86-64.so.2)
                                       _start (/usr/lib64/ld-linux-x86-64.so.2)
<SNIP>

Those BFD warnings need some investigation.
 
> Fwiw, two things I'd like to see further here is somehow the augmented
> code to be the default (with a BPF skeleton possibly)

Yeah, that was/is an experiment in getting perf and bpf together, one
that predates BPF skeletons, that is now the way of doing things for
perf+bpf (just do a 'ls tools/perf/util/bpf_skel/'), doing it with BPF
skeletons, which your patchkit paves the way to, delights me 8-)

> and an ability for perf_event_open tracing to dump the
> perf_event_attr. I'm unclear on the advantages of having different
> augmenters.

So, no advantage in having different augmenters besides the
experimentation before BPF skeletons, and as I wasn't the one working on
the BPF + perf glueing that gave birth to tools/lib/bpf/, I was just
trying to exercise what Wang Nan was doing, however, in hindsight,
brittle that initial interface was, but experimenting we went.

> Perhaps we could just drop support for different
> augmenters, use BPF skeletons for the raw syscall version and keep the
> BPF logic in parse events for adding filters - the process of doing
> augmentation isn't clear to me even after having produced these
> changes.

Basically you add extra data to existing tracepoints, with
per-tracepoint handlers in 'perf trace' consuming that extra data.

Mostly collecting pointer contents, the canonical one is for pathnames.

Then 'perf trace' tries to be smart and reuses "augmenters" (copies of
pointer contents) on all the syscalls that consume the same type.

> There is quite a bit of plumbing necessary to remove the
> notion that the BPF object comes from event parsing

No need for that, that concept may stay, I think, being able to attach
a .c file to some point in the kernel and then provide a trace_printk()
like interface (that bpf-output codebase) seems interesting.

The augmenter is something of a protocol that 'perf trace' can consume,
but then other 'perf script' can as well consume and do extra stuff we
don´t envision now with whatever BPF programs add to the perf ring
buffer (perf.data files).

> and I suspect to achieve this in the current code there is some
> overhead that the skeleton could remove - like the empty sys_enter
> functions I added.

I didn't look at those yet, unsure if they are needed/
 
> Anyway, fixing libbpf 1.0+ and removing a header file called bpf.h
> were what I was after achieving here :-)

Thanks for moving the needle here.

Providing extra test results:

[root@quaco perf]# perf trace -e tools/perf/examples/bpf/empty.c
^C[root@quaco perf]#

Perfect, if I instead change it to not unconditionally filter the thing
is being hooked: all syscalls..

[root@quaco perf]# perf trace -e tools/perf/examples/bpf/empty.c/max-stack=3/ --max-events 3
     0.000 pipewire/2290 raw_syscalls:sys_enter(args: 140270486487156)
                                       syscall_trace_enter.constprop.0 ([kernel.kallsyms])
                                       syscall_trace_enter.constprop.0 ([kernel.kallsyms])
                                       do_syscall_64 ([kernel.kallsyms])
     0.011 pipewire/2290 raw_syscalls:sys_enter(id: 16, args: 140270486487324)
                                       syscall_trace_enter.constprop.0 ([kernel.kallsyms])
                                       syscall_trace_enter.constprop.0 ([kernel.kallsyms])
                                       do_syscall_64 ([kernel.kallsyms])
     0.022 pipewire/2290 raw_syscalls:sys_enter(id: 1, args: 140270486487492)
                                       syscall_trace_enter.constprop.0 ([kernel.kallsyms])
                                       syscall_trace_enter.constprop.0 ([kernel.kallsyms])
                                       do_syscall_64 ([kernel.kallsyms])
[root@quaco perf]#

And for the most "sophisticated" of those examples, that should be made
the default mode for 'perf trace': 

[root@quaco perf]# perf trace -e /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.c,open*,connect* --max-events 5
/home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.c:20:10: fatal error: 'stdbool.h' file not found
#include <stdbool.h>
         ^~~~~~~~~~~
1 error generated.
ERROR:	unable to compile /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.c
Hint:	Check error message shown above.
Hint:	You can also pre-compile it into .o using:
     		clang -target bpf -O2 -c /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.c
     	with proper -I and -D options.
event syntax error: '/home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.c'
                     \___ Failed to load /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.c from source: Error when compiling BPF scriptlet

(add -v to see detail)
Run 'perf list' for a list of valid events

 Usage: perf trace [<options>] [<command>]
    or: perf trace [<options>] -- <command> [<options>]
    or: perf trace record [<options>] [<command>]
    or: perf trace record [<options>] -- <command> [<options>]

    -e, --event <event>   event/syscall selector. use 'perf list' to list available events
[root@quaco perf]#

Not a good start:

[root@quaco perf]# perf trace -e /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.c,string --max-events 6
     0.000 ( 0.019 ms): systemd-oomd/972 openat(dfd: CWD, filename: "/proc/meminfo", flags: RDONLY|CLOEXEC)    = 12
     0.026 ( 0.003 ms): systemd-oomd/972 newfstatat(dfd: 12, filename: "", statbuf: 0x7ffd2bc73cc0, flag: 4096) = 0
18446744073709.520 ( 0.044 ms): cgroupify/36478 openat(dfd: 4, filename: ".", flags: RDONLY|CLOEXEC|DIRECTORY|NONBLOCK) = 5
     0.015 ( 0.004 ms): cgroupify/36478 newfstatat(dfd: 5, filename: "", statbuf: 0x7fffca5b4130, flag: 4096) = 0
     0.075 ( 0.011 ms): cgroupify/36478 openat(dfd: 4, filename: "59457/cgroup.procs")                        = 5
     0.105 ( 0.009 ms): cgroupify/36478 openat(dfd: 4, filename: "37855/cgroup.procs")                        = 5
[root@quaco perf]# perf trace -e /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.c,string --max-events 10
     0.000 ( 0.065 ms): thermald/1144 openat(dfd: CWD, filename: "/sys/class/powercap/intel-rapl/intel-rapl:0/intel-rapl:0:2/energy_uj") = 13
     0.105 ( 0.008 ms): thermald/1144 openat(dfd: CWD, filename: "/sys/class/powercap/intel-rapl/intel-rapl:0/energy_uj") = 13
     0.125 ( 0.028 ms): thermald/1144 openat(dfd: CWD, filename: "/sys/class/thermal/thermal_zone3/temp")   = 13
     1.079 ( 0.022 ms): thermald/1144 openat(dfd: CWD, filename: "/sys/bus/platform/devices/INT3400:00/odvp6") = 13
     1.113 ( 0.009 ms): thermald/1144 newfstatat(dfd: CWD, filename: "/var/run/thermald/debug_mode", statbuf: 0x7f0e733fb790) = -1 ENOENT (No such file or directory)
     1.127 ( 0.007 ms): thermald/1144 openat(dfd: CWD, filename: "/sys/bus/platform/devices/INT3400:00/odvp18") = 13
     1.141 ( 0.003 ms): thermald/1144 newfstatat(dfd: CWD, filename: "/var/run/thermald/debug_mode", statbuf: 0x7f0e733fb790) = -1 ENOENT (No such file or directory)
     1.147 ( 0.006 ms): thermald/1144 openat(dfd: CWD, filename: "/sys/bus/platform/devices/INT3400:00/odvp18") = 13
     1.159 ( 0.003 ms): thermald/1144 newfstatat(dfd: CWD, filename: "/var/run/thermald/debug_mode", statbuf: 0x7f0e733fb790) = -1 ENOENT (No such file or directory)
     1.165 ( 0.024 ms): thermald/1144 openat(dfd: CWD, filename: "/sys/bus/platform/devices/INT3400:00/odvp18") = 13
[root@quaco perf]#

This after sidestepping the sockaddr and stddef cases and making
'empty.c' become 'everything.c' by making the hook on
raw_syscalls:sys_enter return 1, i.e. don't filter this out, please:

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index d3d3c13a9f25b55c..067a6e56eeacc9fc 100644
diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
index 13c72fd602c307e4..1d2894fa1083b81a 100644
--- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
@@ -17,8 +17,9 @@
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
 #include <linux/limits.h>
-#include <stdbool.h>
-#include <sys/socket.h>
+
+typedef char bool;
+typedef int pid_t;
 
 /* bpf-output associated map */
 struct __augmented_syscalls__ {
@@ -100,7 +101,7 @@ struct augmented_args_payload {
 		struct {
 			struct augmented_arg arg, arg2;
 		};
-		struct sockaddr_storage saddr;
+	//	struct sockaddr_storage saddr;
 	};
 };
 
@@ -157,6 +158,7 @@ int syscall_unaugmented(struct syscall_enter_args *args)
 	return 1;
 }
 
+#if 0
 /*
  * These will be tail_called from SEC("raw_syscalls:sys_enter"), so will find in
  * augmented_args_tmp what was read by that raw_syscalls:sys_enter and go
@@ -200,6 +202,7 @@ int sys_enter_sendto(struct syscall_enter_args *args)
 
 	return augmented__output(args, augmented_args, len + socklen);
 }
+#endif
 
 SEC("!syscalls:sys_enter_open")
 int sys_enter_open(struct syscall_enter_args *args)
diff --git a/tools/perf/examples/bpf/empty.c b/tools/perf/examples/bpf/empty.c
index 3e296c0c53d7d8e2..e4872c48a484f218 100644
--- a/tools/perf/examples/bpf/empty.c
+++ b/tools/perf/examples/bpf/empty.c
@@ -7,6 +7,6 @@ struct syscall_enter_args;
 SEC("raw_syscalls:sys_enter")
 int sys_enter(struct syscall_enter_args *args)
 {
-	return 0;
+	return 1;
 }
 char _license[] SEC("license") = "GPL";
