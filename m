Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916C66B81D5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 20:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjCMTpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 15:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjCMTpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 15:45:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57674838AC;
        Mon, 13 Mar 2023 12:45:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F03AB614A7;
        Mon, 13 Mar 2023 19:45:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D62C433D2;
        Mon, 13 Mar 2023 19:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678736715;
        bh=AvlUso4KYkp1l30VXRmyTuU2ziwo0V1J35ALSrtrQvA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=swtloOobGFfgTpVWibyC1HAPg+JDVxsi0U3xo1EzWswVs/CvqHHS5g/rtIcz/s9YS
         OoC0IKeNs8J2Q/jiNd2SY1WaFPfEHBwD63IXiRnfbzjOCsgQTZn8p7jwku7lQ1b1+t
         /e8plgzC6c4bqfpUXetsXvAtu9k1D9+P2doUNevE4XMYybJKmF4erRKZwBc14MTkiv
         dlH93ublpPmIk0OPjRn5rIzDphFy4LNmNKoq2cnHmoyhi1qAWva5cjAJ+asbbvUGdw
         /5rjo0Ve4vR4sdVGokZiB4txnC0/7fx/UZc5kPP/UvD/KPMbARLADhtGEdi6ScxXZ+
         cMWkf7U32G6dQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AC0994049F; Mon, 13 Mar 2023 16:45:12 -0300 (-03)
Date:   Mon, 13 Mar 2023 16:45:12 -0300
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
Subject: Re: [PATCH v1 04/13] perf build: Error if no libelf and NO_LIBELF
 isn't set
Message-ID: <ZA99SPGAlLUIjQoj@kernel.org>
References: <20230311065753.3012826-1-irogers@google.com>
 <20230311065753.3012826-5-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230311065753.3012826-5-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Mar 10, 2023 at 10:57:44PM -0800, Ian Rogers escreveu:
> Building without libelf support is going disable a lot of
> functionality. Require that the NO_LIBELF=1 build option is passed if
> this is intentional.


'make -C tools/perf build-test' is failing:

⬢[acme@toolbox perf-tools-next]$ git log --oneline -1 ; time make -C tools/perf build-test
ace4d44d094ce850 (HEAD -> perf-tools-next) perf build: Remove redundant NO_NEWT build option
make: Entering directory '/var/home/acme/git/perf-tools-next/tools/perf'
Warning: Kernel ABI header at 'tools/include/uapi/linux/in.h' differs from latest version at 'include/uapi/linux/in.h'
Warning: Kernel ABI header at 'tools/arch/x86/include/asm/cpufeatures.h' differs from latest version at 'arch/x86/include/asm/cpufeatures.h'
Warning: Kernel ABI header at 'tools/arch/arm64/include/uapi/asm/perf_regs.h' differs from latest version at 'arch/arm64/include/uapi/asm/perf_regs.h'
Warning: Kernel ABI header at 'tools/include/linux/coresight-pmu.h' differs from latest version at 'include/linux/coresight-pmu.h'
- tarpkg: ./tests/perf-targz-src-pkg .
                 make_static: cd . && make LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1 NO_JVMTI=1 -j32  DESTDIR=/tmp/tmp.jqGYXdF9cQ
cd . && make LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1 NO_JVMTI=1 -j32 DESTDIR=/tmp/tmp.jqGYXdF9cQ
  BUILD:   Doing 'make -j32' parallel build
  HOSTCC  fixdep.o
  HOSTLD  fixdep-in.o
  LINK    fixdep
Warning: Kernel ABI header at 'tools/include/uapi/linux/in.h' differs from latest version at 'include/uapi/linux/in.h'
diff -u tools/include/uapi/linux/in.h include/uapi/linux/in.h
Warning: Kernel ABI header at 'tools/arch/x86/include/asm/cpufeatures.h' differs from latest version at 'arch/x86/include/asm/cpufeatures.h'
diff -u tools/arch/x86/include/asm/cpufeatures.h arch/x86/include/asm/cpufeatures.h
Warning: Kernel ABI header at 'tools/arch/arm64/include/uapi/asm/perf_regs.h' differs from latest version at 'arch/arm64/include/uapi/asm/perf_regs.h'
diff -u tools/arch/arm64/include/uapi/asm/perf_regs.h arch/arm64/include/uapi/asm/perf_regs.h
Warning: Kernel ABI header at 'tools/include/linux/coresight-pmu.h' differs from latest version at 'include/linux/coresight-pmu.h'
diff -u tools/include/linux/coresight-pmu.h include/linux/coresight-pmu.h
Makefile.config:429: *** ERROR: No libelf found. Disables 'probe' tool, jvmti and BPF support. Please install libelf-dev, libelf-devel, elfutils-libelf-devel or build with NO_LIBELF=1..  Stop.
make[3]: *** [Makefile.perf:236: sub-make] Error 2
make[2]: *** [Makefile:70: all] Error 2
  test: test -x ./perf
make[1]: *** [tests/make:316: make_static] Error 1
make: *** [Makefile:103: build-test] Error 2

Same thing for the libtraceevent, I'll add NO_LIBTRACEEVENT=1 and NO_LIBELF=1 to the static build test in tools/perf/tests/make
