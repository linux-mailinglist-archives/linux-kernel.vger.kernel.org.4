Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2CC76B834A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 22:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjCMVAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 17:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjCMVAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 17:00:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70272716;
        Mon, 13 Mar 2023 13:59:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6F297B815BD;
        Mon, 13 Mar 2023 20:59:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF1E9C433D2;
        Mon, 13 Mar 2023 20:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678741178;
        bh=X59VM+mVnGs6nAi19xoVBZJyc3qLMsw52qxHRGax6HE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GKmvjqPabBQiL6LDwcUdN5JPGmUglT3G7lE8LVQwCppdXOGT2yLqPMLoTMuUO6Cpa
         Z8fXyS00DxZFsq44lUDRKm05BDccjfp2ztyS9KoEKLyQ/eUdW9nB1SwOawiXJ4Bs+y
         rvxU+7OgR4G29fLH2kZdAA/b4lmFIpz+OcNPvVZ/3C/zhWLJZAIYQkXKY4dMjrE8x2
         k/f6vnBOLfFbFX9CdKN3MZa65yEXJz75KFzreuNqdiDNTOYiK0NYRa0DYULd7AvM5f
         w/dclrBPnf6CqT+JrSmzRlqpfSaR2BBQZubBPNSwFESti2GC1wdTH+eT84r0nTqa+U
         6Iz7RvNIDEoZQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 73B4F4049F; Mon, 13 Mar 2023 17:59:35 -0300 (-03)
Date:   Mon, 13 Mar 2023 17:59:35 -0300
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
Message-ID: <ZA+Ot0dnX0MNZKmn@kernel.org>
References: <20230311065753.3012826-1-irogers@google.com>
 <20230311065753.3012826-3-irogers@google.com>
 <ZA+FOpzJswZx8os+@kernel.org>
 <CAP-5=fUG1CbzevoS=+Jj_pBO4umNj6ekaMeEuSHGC4kAZgVJJg@mail.gmail.com>
 <ZA+IvqVb6Gos+NOe@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZA+IvqVb6Gos+NOe@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 13, 2023 at 05:34:06PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Mar 13, 2023 at 01:27:21PM -0700, Ian Rogers escreveu:
> > On Mon, Mar 13, 2023 at 1:19 PM Arnaldo Carvalho de Melo
> > > (.text+0x1b): undefined reference to `main'
> > > /usr/bin/ld: final link failed: file in wrong format
> > > collect2: error: ld returned 1 exit status
> > > clang-15: error: linker (via gcc) command failed with exit code 1 (use -v to see invocation)
> > > make[4]: *** [Makefile.perf:1081: /tmp/tmp.Rr5xDuXo13/util/bpf_skel/.tmp/bperf_cgroup.bpf.o] Error 1
> > > make[3]: *** [Makefile.perf:236: sub-make] Error 2
> > > make[2]: *** [Makefile:70: all] Error 2
> > > make[1]: *** [tests/make:326: make_libbpf_dynamic_O] Error 1
> > > make: *** [Makefile:103: build-test] Error 2
> > > make: Leaving directory '/var/home/acme/git/perf-tools-next/tools/perf'
> > >
> > > real    5m55.192s
> > > user    62m31.596s
> > > sys     14m30.828s
> > > ⬢[acme@toolbox perf-tools-next]$
> > 
> > Sorry, I was testing this on top of:
> > https://lore.kernel.org/lkml/20230116010115.490713-1-irogers@google.com/
> > The issue being that we're trying to use an old libbpf that the has
> > meant disabling things but:
> >   NO_BPF_SKEL := 1
> > hadn't been set as part of this. I can address in v2, but with the
> > "assume libbpf 1.0+" patch I hadn't been worrying about this as we'd
> > error out for this case  - rather than build error. The erroring out
> > can be worked around by just not having libbpf be dynamic (ie static
> > or not at all by adding NO_LIBBPF=1).
> 
> I'll try adding that 3-patch series before this one.

⬢[acme@toolbox perf-tools-next]$ git log --oneline -16
76c8a07f51703787 (HEAD -> perf-tools-next) perf build: Error if no libelf and NO_LIBELF isn't set
030a6c72b38e334d perf build: Remove redundant NO_NEWT build option
5d1360fc84cd2e3b perf build: If libtraceevent isn't present error the build
e25e0db4700aa39a perf build: Switch libpfm4 to opt-out rather than opt-in
39f53202a8961d3d perf symbol: Add abi::__cxa_demangle C++ demangling support
d857f258f3d1214a tools build: Add feature test for abi::__cxa_demangle
7aae0d8341c9c373 perf build: Make binutil libraries opt in
dc4890e772aba1e9 perf build: Error if jevents won't work and NO_JEVENTS=1 isn't set
334e64172816623d perf util: Remove weak sched_getcpu
e44d7e7c60fc4ded perf build: Remove unused HAVE_GLIBC_SUPPORT
14ea53be45758450 perf build: Make BUILD_BPF_SKEL default, rename to NO_BPF_SKEL
eb03903c5c119254 perf build: Support python/perf.so testing
f8b579c1996ba4a9 perf bpf: Remove pre libbpf 1.0 conditional logic
2cce43c63d4d0abc perf build: Remove libbpf pre-1.0 feature tests
a24ebff6cce14a34 tools build: Pass libbpf feature only if libbpf 1.0+
17535a33a9c1e4fb perf lock contention: Fix compiler builtin detection
⬢[acme@toolbox perf-tools-next]$

       make_libbpf_dynamic_O: cd . && make LIBBPF_DYNAMIC=1 FEATURES_DUMP=/var/home/acme/git/perf-tools-next/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.cO9WpgtAvo DESTDIR=/tmp/tmp.jjguTPlLWt
ldd: /tmp/tmp.cO9WpgtAvo/perf: No such file or directory
cd . && make LIBBPF_DYNAMIC=1 FEATURES_DUMP=/var/home/acme/git/perf-tools-next/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.cO9WpgtAvo DESTDIR=/tmp/tmp.jjguTPlLWt
  BUILD:   Doing 'make -j32' parallel build
  HOSTCC  /tmp/tmp.cO9WpgtAvo/fixdep.o
  HOSTLD  /tmp/tmp.cO9WpgtAvo/fixdep-in.o
  LINK    /tmp/tmp.cO9WpgtAvo/fixdep
Warning: Kernel ABI header at 'tools/include/uapi/linux/in.h' differs from latest version at 'include/uapi/linux/in.h'
diff -u tools/include/uapi/linux/in.h include/uapi/linux/in.h
Warning: Kernel ABI header at 'tools/arch/x86/include/asm/cpufeatures.h' differs from latest version at 'arch/x86/include/asm/cpufeatures.h'
diff -u tools/arch/x86/include/asm/cpufeatures.h arch/x86/include/asm/cpufeatures.h
Warning: Kernel ABI header at 'tools/arch/arm64/include/uapi/asm/perf_regs.h' differs from latest version at 'arch/arm64/include/uapi/asm/perf_regs.h'
diff -u tools/arch/arm64/include/uapi/asm/perf_regs.h arch/arm64/include/uapi/asm/perf_regs.h
Warning: Kernel ABI header at 'tools/include/linux/coresight-pmu.h' differs from latest version at 'include/linux/coresight-pmu.h'
diff -u tools/include/linux/coresight-pmu.h include/linux/coresight-pmu.h
Makefile.config:563: *** Error: No libbpf devel library found, please install libbpf-devel.  Stop.
make[3]: *** [Makefile.perf:236: sub-make] Error 2
make[2]: *** [Makefile:70: all] Error 2
make[1]: *** [tests/make:326: make_libbpf_dynamic_O] Error 1


But:

⬢[acme@toolbox perf-tools-next]$ rpm -qa | grep libbpf
libbpf-0.8.0-2.fc37.x86_64
libbpf-devel-0.8.0-2.fc37.x86_64
⬢[acme@toolbox perf-tools-next]$

⬢[acme@toolbox perf-tools-next]$ cat /etc/os-release
NAME="Fedora Linux"
VERSION="37 (Container Image)"


I'll see if this is just a matter of tweaking the error message to
something like "libbpf-devel not found or older than 1.0.0, please install/update"

- Arnaldo
