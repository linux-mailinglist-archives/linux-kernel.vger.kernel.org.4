Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8041C6A8B8B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 23:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjCBWMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 17:12:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjCBWMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 17:12:50 -0500
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4028E17CFC;
        Thu,  2 Mar 2023 14:12:41 -0800 (PST)
Received: by mail-yb1-f169.google.com with SMTP id n18so334851ybm.10;
        Thu, 02 Mar 2023 14:12:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677795160;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6saCZ3E79yVnYszzUQo6SvNydCkpTtwym9Ni4bS0DrU=;
        b=zPSxTLO9lJzfC7IvUxY1Lg3QpE1gX0EZ35GE1oPm/1w5Gz90f1pUARaW/5ZoXTEYT0
         HOy0OwamIk5gE+5xTyF0+Dbj0/0MPcdNXmNcLMeSveNdpStBTsViywAjmGib5fOT1jb5
         T9o5eI8HeRVeXoOMoLhfM4u/QTrg8wHJgT3i3MjUUF+khhlabpDcYBwo2aEvaTVjFS1X
         yAyV7FBQsGe22huJalN5o5irjcDRrIO13XD/xy/NHClRc1oYwf+RQR9Kq/zKzqhFLpyK
         Ygeq84J2JGEOSnIbu7WjlzAP65NYtKFpie/ErpJ4iYkZ+m5CLlvJF9ZKIh0mYS+lyxd1
         IS+g==
X-Gm-Message-State: AO0yUKUNCjGAVYKKpkefScur9Bx5ug1/TBzUFGstgUwphcm8Gc+RHT6b
        uW4Q6wHFBpcpRfH6LJpqLOdbtlFRvqhKO5P3sx87wn00
X-Google-Smtp-Source: AK7set+fy6p2dKVVJB3IiTU3fB42sqBJ+/a+xqn0gvOcAV9xu2BE3AViUN0Kwud/ov2Fy9iVx6LeWD7SRyexs4ou/KA=
X-Received: by 2002:a05:6902:4d1:b0:ab8:1ed9:cfd2 with SMTP id
 v17-20020a05690204d100b00ab81ed9cfd2mr5554203ybs.5.1677795160369; Thu, 02 Mar
 2023 14:12:40 -0800 (PST)
MIME-Version: 1.0
References: <20230302092109.367-1-ravi.bangoria@amd.com> <20230302092109.367-3-ravi.bangoria@amd.com>
In-Reply-To: <20230302092109.367-3-ravi.bangoria@amd.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 2 Mar 2023 14:12:29 -0800
Message-ID: <CAM9d7chQA27aD_mPe=3-9jZLWP_a64ztihuK=upgNL++kMFSNw@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf test: Add selftest to test IBS invocation via
 core pmu events
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     peterz@infradead.org, eranian@google.com, acme@kernel.org,
        mark.rutland@arm.com, jolsa@kernel.org, irogers@google.com,
        bp@alien8.de, x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, sandipan.das@amd.com,
        ananth.narayan@amd.com, santosh.shukla@amd.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 2, 2023 at 1:22 AM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>
> IBS pmu can be invoked via fixed set of core pmu events. Add simple
> event open test for all these events.
>
> Without kernel fix:
>   $ sudo ./perf test -vv 76
>    76: IBS via core pmu                                                :
>   --- start ---
>   test child forked, pid 6553
>   Using CPUID AuthenticAMD-25-1-1
>   type: 0x0, config: 0x0, fd: 3  -  Pass
>   type: 0x0, config: 0x1, fd: -1  -  Pass
>   type: 0x4, config: 0x76, fd: -1  -  Fail
>   type: 0x4, config: 0xc1, fd: -1  -  Fail
>   type: 0x4, config: 0x12, fd: -1  -  Pass
>   test child finished with -1
>   ---- end ----
>   IBS via core pmu: FAILED!
>
> With kernel fix:
>   $ sudo ./perf test -vv 76
>    76: IBS via core pmu                                                :
>   --- start ---
>   test child forked, pid 7526
>   Using CPUID AuthenticAMD-25-1-1
>   type: 0x0, config: 0x0, fd: 3  -  Pass
>   type: 0x0, config: 0x1, fd: -1  -  Pass
>   type: 0x4, config: 0x76, fd: 3  -  Pass
>   type: 0x4, config: 0xc1, fd: 3  -  Pass
>   type: 0x4, config: 0x12, fd: -1  -  Pass
>   test child finished with 0
>   ---- end ----
>   IBS via core pmu: Ok
>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
>  tools/perf/tests/Build              |  1 +
>  tools/perf/tests/builtin-test.c     |  1 +
>  tools/perf/tests/ibs-via-core-pmu.c | 70 +++++++++++++++++++++++++++++
>  tools/perf/tests/tests.h            |  1 +
>  4 files changed, 73 insertions(+)
>  create mode 100644 tools/perf/tests/ibs-via-core-pmu.c
>
> diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
> index fb9ac5dc4079..1a232cf13c33 100644
> --- a/tools/perf/tests/Build
> +++ b/tools/perf/tests/Build
> @@ -69,6 +69,7 @@ perf-y += dlfilter-test.o
>  perf-y += sigtrap.o
>  perf-y += event_groups.o
>  perf-y += symbols.o
> +perf-y += ibs-via-core-pmu.o
>
>  $(OUTPUT)tests/llvm-src-base.c: tests/bpf-script-example.c tests/Build
>         $(call rule_mkdir)
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> index 35cc3807cc9e..aed887234500 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -119,6 +119,7 @@ static struct test_suite *generic_tests[] = {
>         &suite__sigtrap,
>         &suite__event_groups,
>         &suite__symbols,
> +       &suite__ibs_via_core_pmu,
>         NULL,
>  };
>
> diff --git a/tools/perf/tests/ibs-via-core-pmu.c b/tools/perf/tests/ibs-via-core-pmu.c
> new file mode 100644
> index 000000000000..6ac539509791
> --- /dev/null
> +++ b/tools/perf/tests/ibs-via-core-pmu.c
> @@ -0,0 +1,70 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "linux/perf_event.h"
> +#include "tests.h"
> +#include "pmu.h"
> +#include "pmus.h"
> +#include "../perf-sys.h"
> +#include "debug.h"
> +
> +#define NR_SUB_TESTS 5
> +
> +static struct sub_tests {
> +       int type;
> +       unsigned long config;
> +       bool valid;
> +} sub_tests[NR_SUB_TESTS] = {
> +       { PERF_TYPE_HARDWARE, PERF_COUNT_HW_CPU_CYCLES, true },
> +       { PERF_TYPE_HARDWARE, PERF_COUNT_HW_INSTRUCTIONS, false },
> +       { PERF_TYPE_RAW, 0x076, true },
> +       { PERF_TYPE_RAW, 0x0C1, true },
> +       { PERF_TYPE_RAW, 0x012, false },
> +};
> +
> +static int event_open(int type, unsigned long config)
> +{
> +       struct perf_event_attr attr;
> +
> +       memset(&attr, 0, sizeof(struct perf_event_attr));
> +       attr.type = type;
> +       attr.size = sizeof(struct perf_event_attr);
> +       attr.config = config;
> +       attr.disabled = 1;
> +       attr.precise_ip = 1;
> +       attr.sample_type = PERF_SAMPLE_IP | PERF_SAMPLE_TID;
> +       attr.sample_period = 100000;
> +
> +       return sys_perf_event_open(&attr, -1, 0, -1, 0);
> +}
> +
> +static int test__ibs_via_core_pmu(struct test_suite *text __maybe_unused,
> +                                 int subtest __maybe_unused)
> +{
> +       struct perf_pmu *ibs_pmu;
> +       int ret = TEST_OK;
> +       int fd, i;
> +
> +       if (list_empty(&pmus))
> +               perf_pmu__scan(NULL);
> +
> +       ibs_pmu = perf_pmu__find("ibs_op");
> +       if (!ibs_pmu)
> +               return TEST_SKIP;
> +
> +       for (i = 0; i < NR_SUB_TESTS; i++) {
> +               fd = event_open(sub_tests[i].type, sub_tests[i].config);
> +               pr_debug("type: 0x%x, config: 0x%lx, fd: %d  -  ", sub_tests[i].type,
> +                        sub_tests[i].config, fd);
> +               if ((sub_tests[i].valid && fd == -1) ||
> +                   (!sub_tests[i].valid && fd > 0)) {
> +                       pr_debug("Fail\n");
> +                       ret = TEST_FAIL;

You need to close(fd) when it's succeeded for invalid one.

Thanks,
Namhyung


> +               } else {
> +                       pr_debug("Pass\n");
> +                       close(fd);
> +               }
> +       }
> +
> +       return ret;
> +}
> +
> +DEFINE_SUITE("IBS via core pmu", ibs_via_core_pmu);
> diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
> index 9a0f3904e53d..36339fdf9c36 100644
> --- a/tools/perf/tests/tests.h
> +++ b/tools/perf/tests/tests.h
> @@ -149,6 +149,7 @@ DECLARE_SUITE(dlfilter);
>  DECLARE_SUITE(sigtrap);
>  DECLARE_SUITE(event_groups);
>  DECLARE_SUITE(symbols);
> +DECLARE_SUITE(ibs_via_core_pmu);
>
>  /*
>   * PowerPC and S390 do not support creation of instruction breakpoints using the
> --
> 2.39.2
>
