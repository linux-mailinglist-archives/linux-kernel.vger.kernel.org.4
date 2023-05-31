Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0D371730E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 03:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbjEaBSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 21:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbjEaBSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 21:18:45 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB060C7
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 18:18:43 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-3f804665702so122321cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 18:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685495923; x=1688087923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t/440rAusAeUpV/6SFRM6ro/fzMxcj5z3RfTwHDSWIk=;
        b=ofrap42uHY1kcIMWlIrRBnPBJdHCBp7PZx/eDdkQkEOLQeHsO5n2lwBxiNLQonzYQP
         6csgdVPSG9iEk+1O8AiKraYon7klPTFEXHYUbJ8KdMImWsh8ij/rrp9Cjf67GhmgqrdW
         2wD5rcxfIhDM+v0v5HIdS8DiB0cnasA1OnfLtbHS9b/U90m7m/MxsdH6AHU3JEO+p8No
         UCQEYtJfQY2hRUd/VhLD2WuTq0qZprrIdEWla2Q+6BuvAJAAqht5LpzWmbJzBFzxymTj
         7b2DfLkJM0UoavYv7e7pr3Bl6mv11jqfUpYqIqOA7IuZ4FWojxNpPa6Mlfje7BTmpARP
         Pzbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685495923; x=1688087923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t/440rAusAeUpV/6SFRM6ro/fzMxcj5z3RfTwHDSWIk=;
        b=VAKAbXm/y4A6YznqM+GX2JTki0v+j9fEm7q0xx0oDmamk1cYGAfTt2OgpNnsYWqvj3
         AMgjynk1zmVfvFVN8zqw0qWdfXzOw1AqwwI3HJ8iQk3HDxPa8JsgUo4df+nSzOUYfR81
         CTswsxH5cOiDJUS9Va7UN1NU1InpGj0RScDZ81xMLRtBkw+IwoM2breGVE95/x6rWEgk
         0RIydjjBuS9PfkpzIduOtMaIw77j9KJnYRo368UWmyH2XTSjfU29bSKei7IG+hXj/bnP
         PlgXwmgWzWZaMeKDU3XDo6eiNSJwWj4ufXRYcMUkNtzmbKGMh4Pzrmjx/jowUMCJjOGq
         Ng8w==
X-Gm-Message-State: AC+VfDwAqp0nimLfYb36MbeZzSviZXdNicHZyx89OD023vl+5sjmhyhU
        3j8y70OhREB4BZXAGrxgv/lGlvZYr1RQuu+rGQUiCw==
X-Google-Smtp-Source: ACHHUZ53qL0eHvGHpgCG+aZKWKYTUXk+YE/m0LwUSL1A/Zlfrt5pD0LE2isEVsMVEmxU0ti3hK0qe45PcAMW6tulPLo=
X-Received: by 2002:a05:622a:1816:b0:3f5:49b6:f18d with SMTP id
 t22-20020a05622a181600b003f549b6f18dmr30982qtc.11.1685495922645; Tue, 30 May
 2023 18:18:42 -0700 (PDT)
MIME-Version: 1.0
References: <1685438374-33287-1-git-send-email-renyu.zj@linux.alibaba.com> <1685438374-33287-4-git-send-email-renyu.zj@linux.alibaba.com>
In-Reply-To: <1685438374-33287-4-git-send-email-renyu.zj@linux.alibaba.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 30 May 2023 18:18:31 -0700
Message-ID: <CAP-5=fVF4wD0t5Sxa56-pPevv4_NqKOYEeqqRLFYPL7a3FSffA@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] perf vendor events: Add JSON metrics for CMN
To:     Jing Zhang <renyu.zj@linux.alibaba.com>
Cc:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Robin Murphy <robin.murphy@arm.com>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 2:19=E2=80=AFAM Jing Zhang <renyu.zj@linux.alibaba.=
com> wrote:
>
> Add JSON metrics for arm CMN. Currently just add part of CMN PMU
> metrics which are general and compatible for any SoC and CMN-ANY.
>
> Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
> ---
>  .../pmu-events/arch/arm64/arm/cmn/sys/metrics.json | 74 ++++++++++++++++=
++++++
>  tools/perf/pmu-events/jevents.py                   |  1 +
>  2 files changed, 75 insertions(+)
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cmn/sys/metrics.=
json
>
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/cmn/sys/metrics.json b/=
tools/perf/pmu-events/arch/arm64/arm/cmn/sys/metrics.json
> new file mode 100644
> index 0000000..e70ac1a
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/arm/cmn/sys/metrics.json
> @@ -0,0 +1,74 @@
> +[
> +       {
> +               "MetricName": "slc_miss_rate",
> +               "BriefDescription": "The system level cache miss rate inc=
lude.",

Nit, partial sentence?

> +               "MetricGroup": "arm_cmn",
> +               "MetricExpr": "hnf_cache_miss / hnf_slc_sf_cache_access",
> +               "ScaleUnit": "100%",
> +               "Unit": "arm_cmn",
> +               "Compat": "arm_cmn600;arm_cmn650;arm_cmn700;arm_ci700"
> +       },
> +       {
> +               "MetricName": "hnf_message_retry_rate",
> +               "BriefDescription": "HN-F message retry rate indicates wh=
ether a lack of credits is causing the bottlenecks.",
> +               "MetricGroup": "arm_cmn",
> +               "MetricExpr": "hnf_pocq_retry / hnf_pocq_reqs_recvd",
> +               "ScaleUnit": "100%",
> +               "Unit": "arm_cmn",
> +               "Compat": "arm_cmn600;arm_cmn650;arm_cmn700;arm_ci700"
> +       },
> +       {
> +               "MetricName": "sf_hit_rate",
> +               "BriefDescription": "Snoop filter hit rate can be used to=
 measure the Snoop Filter efficiency.",

Nit, inconsistent capitalization?

> +               "MetricGroup": "arm_cmn",
> +               "MetricExpr": "hnf_sf_hit / hnf_slc_sf_cache_access",
> +               "ScaleUnit": "100%",
> +               "Unit": "arm_cmn",
> +               "Compat": "arm_cmn600;arm_cmn650;arm_cmn700;arm_ci700"
> +       },
> +       {
> +               "MetricName": "mc_message_retry_rate",
> +               "BriefDescription": "The memory controller request retrie=
s rate indicates whether the memory controller is the bottleneck.",
> +               "MetricGroup": "arm_cmn",
> +               "MetricExpr": "hnf_mc_retries / hnf_mc_reqs",
> +               "ScaleUnit": "100%",
> +               "Unit": "arm_cmn",
> +               "Compat": "arm_cmn600;arm_cmn650;arm_cmn700;arm_ci700"
> +       },
> +       {
> +               "MetricName": "rni_actual_read_bandwidth.all",
> +               "BriefDescription": "This event measure the actual bandwi=
dth(MB/sec) that RN-I bridge sends to the interconnect.",

Nit, the MB/sec is in the ScaleUnit so could be dropped here.

> +               "MetricGroup": "arm_cmn",
> +               "MetricExpr": "rnid_rxdat_flits * 32 / 1e6 / duration_tim=
e",
> +               "ScaleUnit": "1MB/s",
> +               "Unit": "arm_cmn",
> +               "Compat": "arm_cmn600;arm_cmn650;arm_cmn700;arm_ci700"
> +       },
> +       {
> +               "MetricName": "rni_actual_write_bandwidth.all",
> +               "BriefDescription": "This event measures the actual write=
 bandwidth(MB/sec) at RN-I bridges.",

Nit, same thing.

> +               "MetricGroup": "arm_cmn",
> +               "MetricExpr": "rnid_txdat_flits * 32 / 1e6 / duration_tim=
e",
> +               "ScaleUnit": "1MB/s",
> +               "Unit": "arm_cmn",
> +               "Compat": "arm_cmn600;arm_cmn650;arm_cmn700;arm_ci700"
> +       },
> +       {
> +               "MetricName": "rni_retry_rate",
> +               "BriefDescription": "RN-I bridge retry rate indicates whe=
ther the memory controller is the bottleneck.",
> +               "MetricGroup": "arm_cmn",
> +               "MetricExpr": "rnid_txreq_flits_retried / rnid_txreq_flit=
s_total",
> +               "ScaleUnit": "100%",
> +               "Unit": "arm_cmn",
> +               "Compat": "arm_cmn600;arm_cmn650;arm_cmn700;arm_ci700"
> +       },
> +       {
> +               "MetricName": "sbsx_actual_write_bandwidth.all",
> +               "BriefDescription": "sbsx actual write bandwidth(MB/sec).=
",

Nit, same thing.

Thanks,
Ian

> +               "MetricGroup": "arm_cmn",
> +               "MetricExpr": "sbsx_txdat_flitv * 32 / 1e6 / duration_tim=
e",
> +               "ScaleUnit": "1MB/s",
> +               "Unit": "arm_cmn",
> +               "Compat": "arm_cmn600;arm_cmn650;arm_cmn700;arm_ci700"
> +       }
> +]
> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jev=
ents.py
> index 2bcd07c..7cff2c6 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
> @@ -256,6 +256,7 @@ class JsonEvent:
>            'DFPMC': 'amd_df',
>            'cpu_core': 'cpu_core',
>            'cpu_atom': 'cpu_atom',
> +          'arm_cmn': 'arm_cmn',
>        }
>        return table[unit] if unit in table else f'uncore_{unit.lower()}'
>
> --
> 1.8.3.1
>
