Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0890D6F267B
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 23:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbjD2VJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 17:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjD2VJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 17:09:49 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271D81BC9
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 14:09:48 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-32ec968434eso754025ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 14:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682802587; x=1685394587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aR18o0z0RJweJ7cJqnp99mz4GVYMm6+ZbfU+8I+PMNg=;
        b=T3juBVR4ig7GcxypLvKe40fl5intlQj3x8Ra0SFxXRvZUnxvF3CBtzjn7bOksZH6Xd
         YUD72cfa3YvopBVjQJK+Y7FAXlfSTWe0V7flQ46vAqlZ35+rIafu/SvI8XN6Hn9frul2
         96grqvRXTkbwZBQ7uzz8fozuKMOGXCPA1ZHj9XUN4hUmJQaVr0SwoDnzK+DjE45EU6XU
         i7KGCAuksV9z68Q3GU1Tenu4kcgF4cWEuVP6ZKqcYBl69DzzJKm7LZcmjCuLKmogG4a2
         g9M+Xap3T2LSI13nRRHzFjcxRlpPQTcdEdlAqSMZrlWhrha7+TrSZs8ZnftvUS0z9EIF
         uthQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682802587; x=1685394587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aR18o0z0RJweJ7cJqnp99mz4GVYMm6+ZbfU+8I+PMNg=;
        b=gJ1uHtjlpepyQxPnd7MkeprXy76bDGg+MG5NAmoLnt00QqB9WAfzwwJ4P1zF+UvJ4Y
         LtmJZev0yWeK24tUtpFKR8Fsb+aBm5wQfe0B7/76XyNzUH1lROKO2Iazdba+dLNOff7K
         J/mcB0S74bIbsUpi1WOkDFYkoZUDKgRB1asx4bpo+gniFJfEBwTMIBvG+bHfzape0z9y
         dH5Bo/IYc5lH8HlOeal7QCTK5GuVS+xPfbZmJfI7jX8LcNov00tT2e1AW1wcYbCNNeVX
         g8bU9BGcywdaTQxENbLgOnRkmoJvcwtEf/f0DQugjA2M4TqrqPVHZNMyMQw4mS+HjIFh
         IbTA==
X-Gm-Message-State: AC+VfDzypIqhTJdqWoT5MzggTTDdKRcSdMerkbLTS/6b/U+wBPqxR4F3
        vpYPXIpT+JHDonIAfBDMolajxVIJvkr2QziDrmH5jQ==
X-Google-Smtp-Source: ACHHUZ47OAzcf/6+bIFZ2cqvR2yx/WUxTifqjPJdHBHpZXCzY9IuWjgKMgIVrIxVYmbMMwRrQhCBwuh/yNNy5gXFkLM=
X-Received: by 2002:a05:6e02:16cf:b0:32f:7703:63bb with SMTP id
 15-20020a056e0216cf00b0032f770363bbmr168083ilx.19.1682802587181; Sat, 29 Apr
 2023 14:09:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230425142205.762-1-ravi.bangoria@amd.com> <20230425142205.762-4-ravi.bangoria@amd.com>
In-Reply-To: <20230425142205.762-4-ravi.bangoria@amd.com>
From:   Ian Rogers <irogers@google.com>
Date:   Sat, 29 Apr 2023 14:09:35 -0700
Message-ID: <CAP-5=fVnfNEKK_UPuRprSVuCgQG-X-hCM6Jq3AKRHYfBiqisKw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] perf test: Add selftest to test IBS invocation via
 core pmu events
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     peterz@infradead.org, namhyung@kernel.org, eranian@google.com,
        acme@kernel.org, mark.rutland@arm.com, jolsa@kernel.org,
        bp@alien8.de, kan.liang@linux.intel.com, adrian.hunter@intel.com,
        maddy@linux.ibm.com, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com,
        santosh.shukla@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 7:23=E2=80=AFAM Ravi Bangoria <ravi.bangoria@amd.co=
m> wrote:
>
> IBS pmu can be invoked via fixed set of core pmu events with 'precise_ip'
> set to 1. Add a simple event open test for all these events.
>
> Without kernel fix:
>   $ sudo ./perf test -vv 76
>    76: AMD IBS via core pmu                                      :
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
>   AMD IBS via core pmu: FAILED!
>
> With kernel fix:
>   $ sudo ./perf test -vv 76
>    76: AMD IBS via core pmu                                      :
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
>   AMD IBS via core pmu: Ok
>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>

Thanks Ravi, as the test is AMD specific I think it makes sense to place it=
 in:
tools/perf/arch/x86/tests
and then to update the test list in:
tools/perf/arch/x86/tests/arch-tests.c

Thanks,
Ian

> ---
>  tools/perf/tests/Build                  |  1 +
>  tools/perf/tests/amd-ibs-via-core-pmu.c | 72 +++++++++++++++++++++++++
>  tools/perf/tests/builtin-test.c         |  1 +
>  tools/perf/tests/tests.h                |  1 +
>  4 files changed, 75 insertions(+)
>  create mode 100644 tools/perf/tests/amd-ibs-via-core-pmu.c
>
> diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
> index fb9ac5dc4079..ff7234653503 100644
> --- a/tools/perf/tests/Build
> +++ b/tools/perf/tests/Build
> @@ -69,6 +69,7 @@ perf-y +=3D dlfilter-test.o
>  perf-y +=3D sigtrap.o
>  perf-y +=3D event_groups.o
>  perf-y +=3D symbols.o
> +perf-y +=3D amd-ibs-via-core-pmu.o
>
>  $(OUTPUT)tests/llvm-src-base.c: tests/bpf-script-example.c tests/Build
>         $(call rule_mkdir)
> diff --git a/tools/perf/tests/amd-ibs-via-core-pmu.c b/tools/perf/tests/a=
md-ibs-via-core-pmu.c
> new file mode 100644
> index 000000000000..6f6eb2d84fde
> --- /dev/null
> +++ b/tools/perf/tests/amd-ibs-via-core-pmu.c
> @@ -0,0 +1,72 @@
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
> +} sub_tests[NR_SUB_TESTS] =3D {
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
> +       attr.type =3D type;
> +       attr.size =3D sizeof(struct perf_event_attr);
> +       attr.config =3D config;
> +       attr.disabled =3D 1;
> +       attr.precise_ip =3D 1;
> +       attr.sample_type =3D PERF_SAMPLE_IP | PERF_SAMPLE_TID;
> +       attr.sample_period =3D 100000;
> +
> +       return sys_perf_event_open(&attr, -1, 0, -1, 0);
> +}
> +
> +static int test__amd_ibs_via_core_pmu(struct test_suite *text __maybe_un=
used,
> +                                     int subtest __maybe_unused)
> +{
> +       struct perf_pmu *ibs_pmu;
> +       int ret =3D TEST_OK;
> +       int fd, i;
> +
> +       if (list_empty(&pmus))
> +               perf_pmu__scan(NULL);
> +
> +       ibs_pmu =3D perf_pmu__find("ibs_op");
> +       if (!ibs_pmu)
> +               return TEST_SKIP;
> +
> +       for (i =3D 0; i < NR_SUB_TESTS; i++) {
> +               fd =3D event_open(sub_tests[i].type, sub_tests[i].config)=
;
> +               pr_debug("type: 0x%x, config: 0x%lx, fd: %d  -  ", sub_te=
sts[i].type,
> +                        sub_tests[i].config, fd);
> +               if ((sub_tests[i].valid && fd =3D=3D -1) ||
> +                   (!sub_tests[i].valid && fd > 0)) {
> +                       pr_debug("Fail\n");
> +                       ret =3D TEST_FAIL;
> +               } else {
> +                       pr_debug("Pass\n");
> +               }
> +
> +               if (fd > 0)
> +                       close(fd);
> +       }
> +
> +       return ret;
> +}
> +
> +DEFINE_SUITE("AMD IBS via core pmu", amd_ibs_via_core_pmu);
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-t=
est.c
> index 35cc3807cc9e..1805a4fae762 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -119,6 +119,7 @@ static struct test_suite *generic_tests[] =3D {
>         &suite__sigtrap,
>         &suite__event_groups,
>         &suite__symbols,
> +       &suite__amd_ibs_via_core_pmu,
>         NULL,
>  };
>
> diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
> index 9a0f3904e53d..65589d40638d 100644
> --- a/tools/perf/tests/tests.h
> +++ b/tools/perf/tests/tests.h
> @@ -149,6 +149,7 @@ DECLARE_SUITE(dlfilter);
>  DECLARE_SUITE(sigtrap);
>  DECLARE_SUITE(event_groups);
>  DECLARE_SUITE(symbols);
> +DECLARE_SUITE(amd_ibs_via_core_pmu);
>
>  /*
>   * PowerPC and S390 do not support creation of instruction breakpoints u=
sing the
> --
> 2.40.0
>
