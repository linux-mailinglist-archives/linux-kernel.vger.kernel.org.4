Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4580A673DFF
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 16:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbjASPzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 10:55:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjASPzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 10:55:14 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659051BDC
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 07:55:13 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id i4so1671504wrs.9
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 07:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zeec2R60OWMgkGfO5JTP1xgiZX4MfMPTyQOQc0wfkps=;
        b=MgK5RYoIy6DVkBSO9USRsAn8HidfyLiuK8AKoq9b4/df9j8YHjPaIwKPS36eU3svNV
         9X9r3wRP0YelFs2GVMGLepJphBO5fd0giJmk54wCal9aaURkEX+yC2byTjy0yfEbm7Hk
         1ERuUMxpynlL6opq3MrYPgIQ0vmSZUShEH01J9UTbdy6n2rXTfv9TWBoRw6+TqFx7Mu1
         ue8DJARGftWj/TnN4p+jDTCuBr6Idw4iV5V8XIl6Juu/Z71zoGHQU1TkOZ84ZTIU+DzW
         mALHV5pwwJq518P4ZCw7tpsBCi1o3b7YI+D3bZYfos6gYh/ww9f8i+J6zn1y02KuBKcV
         CYYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zeec2R60OWMgkGfO5JTP1xgiZX4MfMPTyQOQc0wfkps=;
        b=ZQdlGCl3Ek9/+wy6cElgWXDzZGUgAgh4fT12WhXjr/jAMbxGMXQS/X+Bnp85YGa1rU
         mwdssAD9HMOlwSVXEr70e78vMVyz/Vhj7rIP+549IXw0Nxsi3G5HmDu+veGw5OIZ/5Oo
         RD59aSKGX3Z267KoSqs3vKRbvWo6p9SSt6CHi4Vzn5MqM1HO4QrXbBxia702A5wFVpWm
         CGmLsSvU8MNrgSdAxCu2kS0F8fj7h3BXjwK8Q/Bj+3qo3uN55W65Ir+6WkZ33IExD99Y
         DDR+xt7RK2kyLuWr4z2hIG7lvXbiQhtcGgLrt82WkHZFGfSdu16/DlH03a8OjeQmFn+5
         hmkQ==
X-Gm-Message-State: AFqh2kqocR4wOP1SEFixJv5w3sxwMTj7ocUPRplJKJsKVKtB3Ey4N3pV
        Ql0RmzysR90v+at1YmV3OHiTFhdLvlfCZm+tH7clwg==
X-Google-Smtp-Source: AMrXdXsUGafV67zCXToRx3KQrBKlLIWqO+ky+RTLC5WQTqRR4d4Fv0LKcAur7bnaWv5GVWDFTyMKsx/3VZFGX0Esk0o=
X-Received: by 2002:adf:f241:0:b0:2bc:7ed4:cd50 with SMTP id
 b1-20020adff241000000b002bc7ed4cd50mr540341wrp.40.1674143711585; Thu, 19 Jan
 2023 07:55:11 -0800 (PST)
MIME-Version: 1.0
References: <20221221223420.2157113-1-irogers@google.com>
In-Reply-To: <20221221223420.2157113-1-irogers@google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 19 Jan 2023 07:54:59 -0800
Message-ID: <CAP-5=fWN98+RnUw63YEbXj6ELEK1a9F+kNM73K9oOFTOUm2cgw@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] jevents/pmu-events improvements
To:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Kang Minchul <tegongkang@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sandipan Das <sandipan.das@amd.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        linuxppc-dev@lists.ozlabs.org, Kajol Jain <kjain@linux.ibm.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2022 at 2:34 PM Ian Rogers <irogers@google.com> wrote:
>
> Add an optimization to jevents using the metric code, rewrite metrics
> in terms of each other in order to minimize size and improve
> readability. For example, on Power8
> other_stall_cpi is rewritten from:
> "PM_CMPLU_STALL / PM_RUN_INST_CMPL - PM_CMPLU_STALL_BRU_CRU / PM_RUN_INST=
_CMPL - PM_CMPLU_STALL_FXU / PM_RUN_INST_CMPL - PM_CMPLU_STALL_VSU / PM_RUN=
_INST_CMPL - PM_CMPLU_STALL_LSU / PM_RUN_INST_CMPL - PM_CMPLU_STALL_NTCG_FL=
USH / PM_RUN_INST_CMPL - PM_CMPLU_STALL_NO_NTF / PM_RUN_INST_CMPL"
> to:
> "stall_cpi - bru_cru_stall_cpi - fxu_stall_cpi - vsu_stall_cpi - lsu_stal=
l_cpi - ntcg_flush_cpi - no_ntf_stall_cpi"
> Which more closely matches the definition on Power9.
>
> A limitation of the substitutions are that they depend on strict
> equality and the shape of the tree. This means that for "a + b + c"
> then a substitution of "a + b" will succeed while "b + c" will fail
> (the LHS for "+ c" is "a + b" not just "b").
>
> Separate out the events and metrics in the pmu-events tables saving
> 14.8% in the table size while making it that metrics no longer need to
> iterate over all events and vice versa. These changes remove evsel's
> direct metric support as the pmu_event no longer has a metric to
> populate it. This is a minor issue as the code wasn't working
> properly, metrics for this are rare and can still be properly ran
> using '-M'.
>
> Add an ability to just build certain models into the jevents generated
> pmu-metrics.c code. This functionality is appropriate for operating
> systems like ChromeOS, that aim to minimize binary size and know all
> the target CPU models.
>
> v2. Rebase. Modify the code that skips rewriting a metric with the
>     same name with itself, to make the name check case insensitive.
>
> Ian Rogers (9):
>   perf jevents metric: Correct Function equality
>   perf jevents metric: Add ability to rewrite metrics in terms of others
>   perf jevents: Rewrite metrics in the same file with each other
>   perf pmu-events: Separate metric out of pmu_event
>   perf stat: Remove evsel metric_name/expr
>   perf jevents: Combine table prefix and suffix writing
>   perf pmu-events: Introduce pmu_metrics_table
>   perf jevents: Generate metrics and events as separate tables
>   perf jevents: Add model list option

Ping. Looking for reviews.

Thanks,
Ian

>  tools/perf/arch/arm64/util/pmu.c         |  23 +-
>  tools/perf/arch/powerpc/util/header.c    |   4 +-
>  tools/perf/builtin-list.c                |  20 +-
>  tools/perf/builtin-stat.c                |   1 -
>  tools/perf/pmu-events/Build              |   3 +-
>  tools/perf/pmu-events/empty-pmu-events.c | 111 ++++++-
>  tools/perf/pmu-events/jevents.py         | 353 ++++++++++++++++++-----
>  tools/perf/pmu-events/metric.py          |  79 ++++-
>  tools/perf/pmu-events/metric_test.py     |  10 +
>  tools/perf/pmu-events/pmu-events.h       |  26 +-
>  tools/perf/tests/expand-cgroup.c         |   4 +-
>  tools/perf/tests/parse-metric.c          |   4 +-
>  tools/perf/tests/pmu-events.c            |  68 ++---
>  tools/perf/util/cgroup.c                 |   1 -
>  tools/perf/util/evsel.c                  |   2 -
>  tools/perf/util/evsel.h                  |   2 -
>  tools/perf/util/metricgroup.c            | 203 +++++++------
>  tools/perf/util/metricgroup.h            |   4 +-
>  tools/perf/util/parse-events.c           |   2 -
>  tools/perf/util/pmu.c                    |  44 +--
>  tools/perf/util/pmu.h                    |  10 +-
>  tools/perf/util/print-events.c           |  32 +-
>  tools/perf/util/print-events.h           |   3 +-
>  tools/perf/util/python.c                 |   7 -
>  tools/perf/util/stat-shadow.c            | 112 -------
>  tools/perf/util/stat.h                   |   1 -
>  26 files changed, 666 insertions(+), 463 deletions(-)
>
> --
> 2.39.0.314.g84b9a713c41-goog
>
