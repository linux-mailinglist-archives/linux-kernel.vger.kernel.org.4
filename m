Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD1D61834B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 16:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbiKCPw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 11:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbiKCPwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 11:52:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3801D65DD;
        Thu,  3 Nov 2022 08:52:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8CE661F3D;
        Thu,  3 Nov 2022 15:52:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 059A9C433D6;
        Thu,  3 Nov 2022 15:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667490772;
        bh=4E16EIE6fAutftaw+daIrJ0Wt1QN/Av8Zfs90PmDMK4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pOwMD/vT7LIbQ0mJw0QJULI2hdA21Be0vAMcOLfe5btDLUsA8y+FngQ118whcaZ1T
         Fz/Q17H7o5EsTIbRVYDBMYOOLJI3cA4Y/LoEJhR8mepewIOOLEO/GL2ZycClei23jf
         HumFdI4hkqbNTKYG1scNM++qeStg5y9t4gT5mIi3YC0eNOoAM/QhBZk+4i4TixSMQv
         xmDNA1j5FHvLXWm5KHbP/Ns9mmH1o+d1UBV9qZ8C62Ggza+yO4h0VMg8HgTaB4wMlc
         6TvNlGpkz+hhIVBp8bwgx/PduVJ1Bc9q3K7CNJYjZ9NQi5J4RoHm/HlnvNdcJApplq
         e23sAG+srvh+Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C0FD14034E; Thu,  3 Nov 2022 12:52:48 -0300 (-03)
Date:   Thu, 3 Nov 2022 12:52:48 -0300
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
Message-ID: <Y2Pj0KVbbw9rMcPH@kernel.org>
References: <20221103045437.163510-1-irogers@google.com>
 <20221103045437.163510-7-irogers@google.com>
 <Y2PgBPeZsd9+YWB4@kernel.org>
 <Y2Pgz7luG77Wr+Ci@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2Pgz7luG77Wr+Ci@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Nov 03, 2022 at 12:39:59PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Thu, Nov 03, 2022 at 12:36:36PM -0300, Arnaldo Carvalho de Melo escreveu:
> > [root@quaco ~]# perf trace -e /home/acme/git/perf/tools/perf/examples/bpf/5sec.c
> > /home/acme/git/perf/tools/perf/examples/bpf/5sec.c:42:10: fatal error: 'bpf/bpf_helpers.h' file not found
> > #include <bpf/bpf_helpers.h>
> >          ^~~~~~~~~~~~~~~~~~~
> > 1 error generated.
> > ERROR:	unable to compile /home/acme/git/perf/tools/perf/examples/bpf/5sec.c
> > Hint:	Check error message shown above.
> > Hint:	You can also pre-compile it into .o using:
> >      		clang -target bpf -O2 -c /home/acme/git/perf/tools/perf/examples/bpf/5sec.c
> >      	with proper -I and -D options.
> > event syntax error: '/home/acme/git/perf/tools/perf/examples/bpf/5sec.c'
> >                      \___ Failed to load /home/acme/git/perf/tools/perf/examples/bpf/5sec.c from source: Error when compiling BPF scriptlet
> > 
> > (add -v to see detail)
> > Run 'perf list' for a list of valid events
> > 
> >  Usage: perf trace [<options>] [<command>]
> >     or: perf trace [<options>] -- <command> [<options>]
> >     or: perf trace record [<options>] [<command>]
> >     or: perf trace record [<options>] -- <command> [<options>]
> > 
> >     -e, --event <event>   event/syscall selector. use 'perf list' to list available events
> > [root@quaco ~]#
> > 
> > It is not even finding it, in this machine I have libbpf 0.7.0, so there
> > is a /usr/include/bpf/bpf_helpers.h, but probably that isn't in the
> > include path set up to build the tools/perf/examples/bpf/ files, perhaps
> > it should use:
> > 
> > -Itools/lib/  so that it gets tools/lib/bpf_helpers.h?
> > 
> > Trying to get this tested...
> 
> Running with -v:
> 
> llvm compiling command : /usr/lib64/ccache/clang -D__KERNEL__ -D__NR_CPUS__=8 -DLINUX_VERSION_CODE=0x51310 -g -I/home/acme/lib/perf/include/bpf -nostdinc -I./arch/x86/include -I./arch/x86/include/generated  -I./include -I./arch/x86/include/uapi -I./arch/x86/include/generated/uapi -I./include/uapi -I./include/generated/uapi -include ./include/linux/compiler-version.h -include ./include/linux/kconfig.h  -Wno-unused-value -Wno-pointer-sign -working-directory /lib/modules/5.19.16-200.fc36.x86_64/build -c /home/acme/git/perf/tools/perf/examples/bpf/5sec.c -target bpf  -g -O2 -o -
> /home/acme/git/perf/tools/perf/examples/bpf/5sec.c:42:10: fatal error: 'bpf/bpf_helpers.h' file not found
> 
> There is still that -I/home/acme/lib/perf/include/bpf, I'll remove it
> from the include path and try to replace it with the libbpf path...

Ok, works with the patch below, that needs some more renaming from "perf_" to
"libbpf_", etc:

[root@quaco ~]# perf trace -e /home/acme/git/perf/tools/perf/examples/bpf/5sec.c  sleep 5
     0.000 sleep/160828 perf_bpf_probe:hrtimer_nanosleep(__probe_ip: -1474734416, rqtp: 5000000000)
[root@quaco ~]#

Since I have:

[root@quaco ~]# cat ~/.perfconfig
[llvm]
	dump-obj = true
	clang-opt = -g
#

I end up with:

[root@quaco ~]# ls -la /home/acme/git/perf/tools/perf/examples/bpf/5sec.o
-rw-r--r--. 1 root root 3696 Nov  3 12:47 /home/acme/git/perf/tools/perf/examples/bpf/5sec.o
[root@quaco ~]# file /home/acme/git/perf/tools/perf/examples/bpf/5sec.o
/home/acme/git/perf/tools/perf/examples/bpf/5sec.o: ELF 64-bit LSB relocatable, eBPF, version 1 (SYSV), with debug_info, not stripped
[root@quaco ~]#

and can test with the pre-built .o eBPF bytecode + capped backtrace:

[root@quaco ~]# perf trace -e /home/acme/git/perf/tools/perf/examples/bpf/5sec.o/max-stack=6/  sleep 5
     0.000 sleep/161037 perf_bpf_probe:hrtimer_nanosleep(__probe_ip: -1474734416, rqtp: 5000000000)
                                       hrtimer_nanosleep ([kernel.kallsyms])
                                       common_nsleep ([kernel.kallsyms])
                                       __x64_sys_clock_nanosleep ([kernel.kallsyms])
                                       do_syscall_64 ([kernel.kallsyms])
                                       entry_SYSCALL_64_after_hwframe ([kernel.kallsyms])
                                       __GI___clock_nanosleep (/usr/lib64/libc.so.6)
[root@quaco ~]#

I'll test the other examples with these changes after I drive Pedro to
school and get back to the office.

- Arnaldo

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index d3d3c13a9f25b55c..067a6e56eeacc9fc 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -1239,7 +1239,7 @@ includedir = $(abspath $(prefix)/$(includedir_relative))
 mandir = share/man
 infodir = share/info
 perfexecdir = libexec/perf-core
-perf_include_dir = lib/perf/include
+perf_include_dir = /usr/include
 perf_examples_dir = lib/perf/examples
 sharedir = $(prefix)/share
 template_dir = share/perf-core/templates
diff --git a/tools/perf/util/llvm-utils.c b/tools/perf/util/llvm-utils.c
index 2dc7970074196ca8..a5cac85783d8711f 100644
--- a/tools/perf/util/llvm-utils.c
+++ b/tools/perf/util/llvm-utils.c
@@ -495,7 +495,7 @@ int llvm__compile_bpf(const char *path, void **p_obj_buf,
 
 	snprintf(linux_version_code_str, sizeof(linux_version_code_str),
 		 "0x%x", kernel_version);
-	if (asprintf(&perf_bpf_include_opts, "-I%s/bpf", perf_include_dir) < 0)
+	if (asprintf(&perf_bpf_include_opts, "-I%s/", perf_include_dir) < 0)
 		goto errout;
 	force_set_env("NR_CPUS", nr_cpus_avail_str);
 	force_set_env("LINUX_VERSION_CODE", linux_version_code_str);
