Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E9A6FE34F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 19:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjEJRfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 13:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjEJRfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 13:35:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC522E7A;
        Wed, 10 May 2023 10:34:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51DFD63F65;
        Wed, 10 May 2023 17:34:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C2FDC433D2;
        Wed, 10 May 2023 17:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683740097;
        bh=NnMa4/6VIx6yW41nazHwwitKXnWorurym5zBq4Ka0XY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jRo3jRZJDb/ziEHcYjG6t77yGeolVrZqQA3zUzLWSQFI7MZweGu4GL/g4VnbdIO0L
         6e5lWTdD5ZPwxQ3FmWKtybySqvbfZdQyjsym1DpQsJGipspkcj9okAp7BL5ywvn0mB
         PFDTljAY+P1LmVcJW+pIreogI63jKwLk+AJUoj5AC9oXquwoiD1kILywh6qlhB0Dcn
         juPH3sTfFIQcHwG9Qs4M43g4df6VTtHIjGVSGvo+qxkAtjxgZhiKQZNlz2okv+Pjys
         3gW0GaHsLlibWtUnkgO6pTrHA9YrBX6v8DABsgrX/5AUVg1Ge/yQEaXELP8phjOmZE
         PLkc0LXe3/zQg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BE0DD403B5; Wed, 10 May 2023 14:34:54 -0300 (-03)
Date:   Wed, 10 May 2023 14:34:54 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Song Liu <songliubraving@meta.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v1] perf build: Add system include paths to BPF builds
Message-ID: <ZFvVvp0tYqxHWFsB@kernel.org>
References: <20230506021450.3499232-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230506021450.3499232-1-irogers@google.com>
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

Em Fri, May 05, 2023 at 07:14:50PM -0700, Ian Rogers escreveu:
> There are insufficient headers in tools/include to satisfy building
> BPF programs and their header dependencies. Add the system include
> paths from the non-BPF clang compile so that these headers can be
> found.
> 
> This code was taken from:
> tools/testing/selftests/bpf/Makefile
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/Makefile.perf | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 61c33d100b2b..37befdfa8ac8 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -1057,7 +1057,25 @@ $(SKEL_TMP_OUT) $(LIBAPI_OUTPUT) $(LIBBPF_OUTPUT) $(LIBPERF_OUTPUT) $(LIBSUBCMD_
>  
>  ifndef NO_BPF_SKEL

So this patch was done before the reverts, I adjusted it to what is
upstream and to another patch that makes the build use the headers from
the perf sources instead of the system's (linux/bpf.h and
linux/perf_event.h, from vmlinux.h), please take a look at the patch
below, I'm also trying to figure out that other problem you pointed with
linux/types.s :-\

What I have now in tmp.perf-tools:

⬢[acme@toolbox perf-tools]$ git log --oneline torvalds/master..
a2af0f6b8ef7ea40 (HEAD -> perf-tools) perf build: Add system include paths to BPF builds
5be6cecda0802f23 perf bpf skels: Make vmlinux.h use bpf.h and perf_event.h in source directory
7d161165d9072dcb perf parse-events: Do not break up AUX event group
a468085011ea8bba perf test test_intel_pt.sh: Test sample mode with event with PMU name
123361659fa405de perf evsel: Modify group pmu name for software events
34e82891d995ab89 tools arch x86: Sync the msr-index.h copy with the kernel sources
705049ca4f5b7b00 tools headers kvm: Sync uapi/{asm/linux} kvm.h headers with the kernel sources
8d6a41c8065e1120 tools include UAPI: Sync the sound/asound.h copy with the kernel sources
92b8e61e88351091 tools headers UAPI: Sync the linux/const.h with the kernel headers
e7ec3a249c38a9c9 tools headers UAPI: Sync the i915_drm.h with the kernel sources
e6232180e524e112 tools headers UAPI: Sync the drm/drm.h with the kernel sources
5d1ac59ff7445e51 tools headers UAPI: Sync the linux/in.h with the kernel sources
b0618f38e2ab8ce3 perf build: Gracefully fail the build if BUILD_BPF_SKEL=1 is specified and clang isn't available
5f0b89e632ed81b6 perf test java symbol: Remove needless debuginfod queries
327daf34554d20a6 perf parse-events: Don't reorder ungrouped events by PMU
ccc66c6092802d68 perf metric: JSON flag to not group events if gathering a metric group
1b114824106ca468 perf stat: Introduce skippable evsels
2a939c8695035b11 perf metric: Change divide by zero and !support events behavior
⬢[acme@toolbox perf-tools]$

Please help me test this,

Regards,

- Arnaldo


