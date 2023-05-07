Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89266F96A1
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 04:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjEGC5M convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 6 May 2023 22:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjEGC5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 22:57:11 -0400
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6B0100FC;
        Sat,  6 May 2023 19:57:10 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-ba2362d4ea9so658480276.3;
        Sat, 06 May 2023 19:57:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683428229; x=1686020229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y27uBZQDxoMMmtt5dKQE+mflLBajPhR2V/YDaYqpNNc=;
        b=A90SH9+Br6HbaXDq8LUAqmiSeIlDsq262SOZN+mwQwpJKmeMHQrtByTfQpMc2nhdnC
         jfAyvJzN87Y6cfhHKuZWG+26fO6jjNJu+1497FIwuL0IKiMewIQvUYSiPiqEJwx8XK6i
         rE8vp5S3RqZ4Q2aZbnOBY9sBR2GKW37gK/q5nwoK1brYVSFiI1UvMbdJINPRjxdXw7ze
         Iesd09+Z0Dm+6erB/0uItWl6yRuqQQzrjcCq3LfYM44iJzV+CHKyLdgMUxSmQmsWRgmY
         Vfvc/4FX+a6jO5m5oyRJdU/1aXkrh98Dqm9/+XeUKFS9asrRlHJ4absiejtyFsIAD/fR
         QXNw==
X-Gm-Message-State: AC+VfDwSXVIm6nqoGl2xbQYUEXrlisoYE0nSHt0FXKPS35Qe3gsRtjhI
        A8NNh/JBRhLn+gknh7fgjA1ZbmyS+kaAQARwRoQ=
X-Google-Smtp-Source: ACHHUZ5KYd+Vp866GdYz32Yb8G1anYuwcXULbK3NRkDd6T9rO6BPZvKgFiMbj5mIdsFH380Y3SgiWsJzPH/v6x/8GkQ=
X-Received: by 2002:a25:e648:0:b0:b9e:712f:4a17 with SMTP id
 d69-20020a25e648000000b00b9e712f4a17mr6602071ybh.6.1683428229058; Sat, 06 May
 2023 19:57:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230506021450.3499232-1-irogers@google.com>
In-Reply-To: <20230506021450.3499232-1-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sat, 6 May 2023 19:56:56 -0700
Message-ID: <CAM9d7cieo+cF9uNfgQq=R1BofNN5Ae69sjz80rV8-TxXPZFasg@mail.gmail.com>
Subject: Re: [PATCH v1] perf build: Add system include paths to BPF builds
To:     Ian Rogers <irogers@google.com>
Cc:     Song Liu <songliubraving@meta.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

On Fri, May 5, 2023 at 7:15 PM Ian Rogers <irogers@google.com> wrote:
>
> There are insufficient headers in tools/include to satisfy building
> BPF programs and their header dependencies. Add the system include
> paths from the non-BPF clang compile so that these headers can be
> found.
>
> This code was taken from:
> tools/testing/selftests/bpf/Makefile
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Thanks, this fixes the BPF build failure on my machine.

Tested-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


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
>  BPFTOOL := $(SKEL_TMP_OUT)/bootstrap/bpftool
> -BPF_INCLUDE := -I$(SKEL_TMP_OUT)/.. -I$(LIBBPF_INCLUDE)
> +
> +# Get Clang's default includes on this system, as opposed to those seen by
> +# '-target bpf'. This fixes "missing" files on some architectures/distros,
> +# such as asm/byteorder.h, asm/socket.h, asm/sockios.h, sys/cdefs.h etc.
> +#
> +# Use '-idirafter': Don't interfere with include mechanics except where the
> +# build would have failed anyways.
> +define get_sys_includes
> +$(shell $(1) $(2) -v -E - </dev/null 2>&1 \
> +       | sed -n '/<...> search starts here:/,/End of search list./{ s| \(/.*\)|-idirafter \1|p }') \
> +$(shell $(1) $(2) -dM -E - </dev/null | grep '__riscv_xlen ' | awk '{printf("-D__riscv_xlen=%d -D__BITS_PER_LONG=%d", $$3, $$3)}')
> +endef
> +
> +ifneq ($(CROSS_COMPILE),)
> +CLANG_TARGET_ARCH = --target=$(notdir $(CROSS_COMPILE:%-=%))
> +endif
> +
> +CLANG_SYS_INCLUDES = $(call get_sys_includes,$(CLANG),$(CLANG_TARGET_ARCH))
> +BPF_INCLUDE := -I$(SKEL_TMP_OUT)/.. -I$(LIBBPF_INCLUDE) $(CLANG_SYS_INCLUDES)
>
>  $(BPFTOOL): | $(SKEL_TMP_OUT)
>         $(Q)CFLAGS= $(MAKE) -C ../bpf/bpftool \
> --
> 2.40.1.521.gf1e218fcd8-goog
>
