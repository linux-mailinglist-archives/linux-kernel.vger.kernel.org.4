Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7B06F6991
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 13:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjEDLJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 07:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbjEDLJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 07:09:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE47448E;
        Thu,  4 May 2023 04:09:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D6396334F;
        Thu,  4 May 2023 11:09:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C3BCC433D2;
        Thu,  4 May 2023 11:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683198549;
        bh=kCDza5+2lizs2eIg2BSpKGAvN02/BzWrGa+YvQh2qJU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g9/h+ftNrYBleQOgLdxJjmL/8cRc75X1bJjzZPfcQttYfZpcH9HnNINLlUR9RUEvZ
         m0ip2f4Q6aJsX+f+POqUokWbu6UuIqRxtQUwAmGUxL1ud34i4FimRWIp0pg1eNEhMh
         4AWNlLeFFYW/PyfHeQjJegnPrmcWsV4o2OMYv2TMhMnJpIDk7rVaSY/bu8z3VGHlpq
         ZlPoOdB/+R4nQi5pVCCRwuHN1eX9ba22EiZ4t5Pk/T/m/UTiu9h72U6SsIYlhwRiP3
         HOqhxn4Ok4l4y2tjZ+0Xf77+rbD+lV6ethgsJDzB8ntNxtEAnDgswPAuooZKXL1J1b
         A4g3XV2gx8Jbw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CEDD9403B5; Thu,  4 May 2023 08:09:05 -0300 (-03)
Date:   Thu, 4 May 2023 08:09:05 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Song Liu <song@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Changbin Du <changbin.du@huawei.com>,
        Hao Luo <haoluo@google.com>, Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Roman Lozko <lozko.roma@gmail.com>,
        Stephane Eranian <eranian@google.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: BPF skels in perf .Re: [GIT PULL] perf tools changes for v6.4
Message-ID: <ZFOSUab5XEJD0kxj@kernel.org>
References: <20230503211801.897735-1-acme@kernel.org>
 <CAHk-=wjY_3cBELRSLMpqCt6Eb71Qei2agfKSNsrr5KcpdEQCaA@mail.gmail.com>
 <CAHk-=wgci+OTRacQZcvvapRcWkoiTFJ=VTe_JYtabGgZ9refmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wgci+OTRacQZcvvapRcWkoiTFJ=VTe_JYtabGgZ9refmg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, May 03, 2023 at 08:12:20PM -0700, Linus Torvalds escreveu:
> On Wed, May 3, 2023 at 8:00 PM Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > I did consider it, but the end result doesn't even build, so I unpulled again..

> > I get some libbpf error, and I'm just not interested in trying to
> > debug it. This has clearly not been tested well enough to be merged.

Its the default (opt-out) in the development branch for a while and
stayed in linux-next, but as it has been opt-in it hasn't received the
same amount of testing as the default build in the past development
cycles, even with the first feature that uses it having been introduced
back in 2020 :-\
 
> Side note: its' not even about testing.
 
> The error message makes it clear that this is garbage and should never
> be merged even if it were to compile.
 
> There is not a way in hell that it is correct that a 'perf' tool build
> should ever even look at the vmlinux binary to build.
 
> The fact that it does shows that something is seriously wrong in
> perf-tool land, and I will not be touching any pulls until that
> fundamental mistake is entirely gone.
 
> The vmlinux image that is present in my tree (ie
> /home/torvalds/v2.6/linux/vmlinux) is a test build with an insane
> config. And the fact that the perf tool even looks at it is seriously
> broken.

Humm,

Does building runqslower works for you in this same environment where
building perf failed?

I ask this because it uses the same libbpf technique (CO-RE) to allow
tools that access kernel data structures from BPF to work with multiple
kernels, even those where the layout of the accessed kernel structures
changed.

To build it:

$ make -C tools/bpf/runqslower/
make: Entering directory '/home/acme/git/perf-tools/tools/bpf/runqslower'
  MKDIR   /home/acme/git/perf-tools/tools/bpf/runqslower/.output/libbpf/
  GEN     /home/acme/git/perf-tools/tools/bpf/runqslower/.output/libbpf/bpf_helper_defs.h
  CC      /home/acme/git/perf-tools/tools/bpf/runqslower/.output/libbpf/staticobjs/libbpf.o
<SNIP>
  LINK    /home/acme/git/perf-tools/tools/bpf/runqslower/.output/libbpf/libbpf.a
  INSTALL /home/acme/git/perf-tools/tools/bpf/runqslower/.output/libbpf//include/bpf/bpf.h
  INSTALL /home/acme/git/perf-tools/tools/bpf/runqslower/.output/libbpf//include/bpf/libbpf.h
  INSTALL /home/acme/git/perf-tools/tools/bpf/runqslower/.output/libbpf//include/bpf/btf.h
 <SNIP>
  INSTALL /home/acme/git/perf-tools/tools/bpf/runqslower/.output/libbpf//include/bpf/bpf_helper_defs.h
  INSTALL libbpf_headers
  MKDIR   /home/acme/git/perf-tools/tools/bpf/runqslower/.output/bpftool/bootstrap/libbpf/include/bpf
  INSTALL /home/acme/git/perf-tools/tools/bpf/runqslower/.output/bpftool/bootstrap/libbpf/include/bpf/hashmap.h
<SNIP>
  LINK    /home/acme/git/perf-tools/tools/bpf/runqslower/.output/bpftool/bootstrap/bpftool
  GEN     /home/acme/git/perf-tools/tools/bpf/runqslower/.output//vmlinux.h
  GEN     /home/acme/git/perf-tools/tools/bpf/runqslower/.output//runqslower.bpf.o
  GEN     /home/acme/git/perf-tools/tools/bpf/runqslower/.output//runqslower.skel.h
  CC      /home/acme/git/perf-tools/tools/bpf/runqslower/.output//runqslower.o
  LINK    /home/acme/git/perf-tools/tools/bpf/runqslower/.output//runqslower
make: Leaving directory '/home/acme/git/perf-tools/tools/bpf/runqslower'
$

# strip tools/bpf/runqslower/.output/runqslower
# file tools/bpf/runqslower/.output/runqslower
tools/bpf/runqslower/.output/runqslower: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, BuildID[sha1]=ab0306ee3f6cdc671d9aac7006457a3646e1c266, for GNU/Linux 3.2.0, stripped
[root@quaco perf-tools]# tools/bpf/runqslower/.output/runqslower 100
Tracing run queue latency higher than 100 us
TIME     COMM             PID           LAT(us)
08:00:17 swapper/4        30951            1001
08:00:18 kworker/7:8      2604              101
08:00:19 ksoftirqd/2      15665             105
08:00:22 swapper/2        904400            179
08:00:22 swapper/2        1247              102
08:00:23 TaskCon~ller #7  643789            102
08:00:26 ksoftirqd/2      849302            109
08:00:26 gmain            3107              238
08:00:26 rcu_tasks_trace  152972            634
08:00:27 systemd-oomd     899470           4887
08:00:28 Timer            30951             262
08:00:28 ksoftirqd/2      15665             103
08:00:29 systemd-resolve  895022            104
08:00:29 ksoftirqd/2      15665             145
08:00:30 ksoftirqd/2      15665             117
08:00:30 ksoftirqd/2      640315            149
08:00:30 gmain            3074              122
08:00:30 goa-identity-se  3107              109
^C
#

It builds and uses the tools/bpf/bpftool tool to generate the vmlinux.h
file to build the tool:

$ strace -f -e access,open,openat make -C tools/bpf/runqslower/ |& grep vmlinux
  GEN     /home/acme/git/perf-tools/tools/bpf/runqslower/.output//vmlinux.h
[pid 902901] openat(AT_FDCWD, "/home/acme/git/perf-tools/tools/bpf/runqslower/.output//vmlinux.h", O_WRONLY|O_CREAT|O_TRUNC, 0666) = 3
[pid 902901] openat(AT_FDCWD, "/sys/kernel/btf/vmlinux", O_RDONLY) = 3
[pid 902909] openat(AT_FDCWD, "/home/acme/git/perf-tools/tools/bpf/runqslower/.output/vmlinux.h", O_RDONLY) = 4
$

But here it is using /sys/kernel/btf/vmlinux, which is way more sensible
than what you noticed.

Looking at tools/bpf/runqslower/Makefile:

# Try to detect best kernel BTF source
KERNEL_REL := $(shell uname -r)
VMLINUX_BTF_PATHS := $(if $(O),$(O)/vmlinux)            \
        $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux) \
        ../../../vmlinux /sys/kernel/btf/vmlinux        \
        /boot/vmlinux-$(KERNEL_REL)
VMLINUX_BTF_PATH := $(or $(VMLINUX_BTF),$(firstword                            \
                                          $(wildcard $(VMLINUX_BTF_PATHS))))

It tries to use vmlinux.

I'll check why it isn't using the same technique, possibly you don't
generate BTF?

In this fedora 37 kernel:

$ grep DEBUG_INFO_BTF /boot/config-6.2.9-200.fc37.x86_64
CONFIG_DEBUG_INFO_BTF=y
CONFIG_DEBUG_INFO_BTF_MODULES=y
$

Having said that probably we should go back to making build with BPF
skels a opt in feature, as it has been since the first feature using it
was introduced, in:

commit fbcdaa1908e8f61aa56c71a1db9a9deb72110a9d
Author: Song Liu <songliubraving@fb.com>
Date:   Tue Dec 29 13:42:13 2020 -0800

    perf build: Support build BPF skeletons with perf

    BPF programs are useful in perf to profile BPF programs.

    BPF skeleton is by far the easiest way to write BPF tools. Enable
    building BPF skeletons in util/bpf_skel. A dummy bpf skeleton is added.
    More bpf skeletons will be added for different use cases.

    Signed-off-by: Song Liu <songliubraving@fb.com>
    Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
    Acked-by: Jiri Olsa <jolsa@redhat.com>
    Acked-by: Namhyung Kim <namhyung@kernel.org>
    Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
    Cc: Mark Rutland <mark.rutland@arm.com>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: kernel-team@fb.com
    Link: http://lore.kernel.org/lkml/20201229214214.3413833-3-songliubraving@fb.com
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Until we sort out these build robustness issues.

- Arnaldo
