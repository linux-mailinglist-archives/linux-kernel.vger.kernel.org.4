Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2638467C15E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 01:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235606AbjAZALB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 19:11:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235174AbjAZAK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 19:10:58 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4D864685
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 16:10:53 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id e19-20020a05600c439300b003db1cac0c1fso2289745wmn.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 16:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=swgkYLU18wTX9WUg/6sua2FIBoQ4pd74osZm7oskNfg=;
        b=MLLVGGQOM6dbb1NxGWWPqGQremCBNhw2PL4IMm2AH/xLp7c+0phbM3tecE3VIJVfw/
         KK2uRw+Bmn+ujvPMzVca7GYYLTSj17dZ0gEvAxo5uVwcXj7Dux2GcWdxuLgTysg8pnua
         9R6Iz8/tWnRry6rdTGNR/LdJIzhwtAADXO1RUG7UL4MpJBTzDQ1t7vbGdqiE4wSnidg0
         GPevBDgY1y1L8+pDacupmUMK5ZuXOG6bdkjspEfSAM+VjVeVvBajCyDahsakjV4Pl11L
         ON1mwWlHt2KG9uiqMsgIJjJvO11yqD28u7FJDNjJhRRhitqzRZxTpgX5x4b3dgAIu6Aq
         66Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=swgkYLU18wTX9WUg/6sua2FIBoQ4pd74osZm7oskNfg=;
        b=6a8NDKha3M/nlzs9piRDOlQGwPGjGemr/N7z+eVzDcIHdbObRC3sBflSe2HLrAUOwt
         gbQERPLX9+RYGLUPO3leA67S0wqzL1MDQCOgUZB9zuVY4/JM768b4iysZBEuHip/5ktT
         rbSJoy5V1i3s1YFrF2GFACFSjGY2Y5yVxqss+Qm3O92midc6vE8+sKHzv0lCBt9+OohV
         SGJ4kGPxJPuuNgWd9rgz9Z9CEgdlMO1vnZ1fVkF1v2f3e49ew3gyGk06k1BpLT/IjNhC
         0xl+JL1Yzm45bd61kYkF/TyclBIqfU5vNXSR89XzI70zVVy9AlkDP53ZWxsZqYlxbxJG
         KHJQ==
X-Gm-Message-State: AFqh2kptnqFKe54LadiWoYoOkJWNNahrxeQdkfDejHHXnxaWNclInrSt
        s9y8pDkDby/FLZqvS08UzFRHq551wsfb0IqBJ7cbbw==
X-Google-Smtp-Source: AMrXdXsICClNLo8x1QPYuM4hD8UlHeaJyEblCizCVyxsNcPHXKpMBzfewCKT2YoGMZGcnz6Rq5PQxCNR1W+qyHMmaq0=
X-Received: by 2002:a1c:7404:0:b0:3da:b40f:c734 with SMTP id
 p4-20020a1c7404000000b003dab40fc734mr2805519wmc.115.1674691851605; Wed, 25
 Jan 2023 16:10:51 -0800 (PST)
MIME-Version: 1.0
References: <20230125192431.2929677-1-namhyung@kernel.org>
In-Reply-To: <20230125192431.2929677-1-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 25 Jan 2023 16:10:39 -0800
Message-ID: <CAP-5=fXOhOCq3TS6RFUTsEZBXnzG74T=NiLvQCf+t0QHctSrZQ@mail.gmail.com>
Subject: Re: [PATCH v2] perf stat: Hide invalid uncore event output for aggr mode
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
        Michael Petlan <mpetlan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
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

On Wed, Jan 25, 2023 at 11:24 AM Namhyung Kim <namhyung@kernel.org> wrote:
>
> The current display code for perf stat iterates given cpus and build the
> aggr map to collect the event data for the aggregation mode.
>
> But uncore events have their own cpu maps and it won't guarantee that
> it'd match to the aggr map.  For example, per-package uncore events
> would generate a single value for each socket.  When user asks per-core
> aggregation mode, the output would contain 0 values for other cores.
>
> Thus it needs to check the uncore PMU's cpumask and if it matches to the
> current aggregation id.
>
> Before:
>   $ sudo ./perf stat -a --per-core -e power/energy-pkg/ sleep 1
>
>    Performance counter stats for 'system wide':
>
>   S0-D0-C0              1               3.73 Joules power/energy-pkg/
>   S0-D0-C1              0      <not counted> Joules power/energy-pkg/
>   S0-D0-C2              0      <not counted> Joules power/energy-pkg/
>   S0-D0-C3              0      <not counted> Joules power/energy-pkg/
>
>          1.001404046 seconds time elapsed
>
>   Some events weren't counted. Try disabling the NMI watchdog:
>         echo 0 > /proc/sys/kernel/nmi_watchdog
>         perf stat ...
>         echo 1 > /proc/sys/kernel/nmi_watchdog
>
> The core 1, 2 and 3 should not be printed because the event is handled
> in a cpu in the core 0 only.  With this change, the output becomes like
> below.
>
> After:
>   $ sudo ./perf stat -a --per-core -e power/energy-pkg/ sleep 1
>
>    Performance counter stats for 'system wide':
>
>   S0-D0-C0              1               2.09 Joules power/energy-pkg/
>
> Fixes: b89761351089 ("perf stat: Update event skip condition for system-wide per-thread mode and merged uncore and hybrid events")
> Cc: Athira Jajeev <atrajeev@linux.vnet.ibm.com>
> Cc: Michael Petlan <mpetlan@redhat.com>
> Tested-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
> * rename to 'should_skip_zero_counter'
> * check pmu->cpus instead
> * add kernel-doc style comments
> * add Ian's Tested-by tag
>
>  tools/perf/util/stat-display.c | 51 ++++++++++++++++++++++++++++++----
>  1 file changed, 46 insertions(+), 5 deletions(-)
>
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index 8bd8b0142630..1b5cb20efd23 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -787,6 +787,51 @@ static void uniquify_counter(struct perf_stat_config *config, struct evsel *coun
>                 uniquify_event_name(counter);
>  }
>
> +/**
> + * should_skip_zero_count() - Check if the event should print 0 values.
> + * @config: The perf stat configuration (including aggregation mode).
> + * @counter: The evsel with its associated cpumap.
> + * @id: The aggregation id that is being queried.
> + *
> + * Due to mismatch between the event cpumap or thread-map and the
> + * aggregation mode, sometimes it'd iterate the counter with the map
> + * which does not contain any values.
> + *
> + * For example, uncore events have dedicated CPUs to manage them,
> + * result for other CPUs should be zero and skipped.
> + *
> + * Return: %true if the value should NOT be printed, %false if the value
> + * needs to be printed like "<not counted>" or "<not supported>".
> + */
> +static bool should_skip_zero_counter(struct perf_stat_config *config,
> +                                    struct evsel *counter,
> +                                    const struct aggr_cpu_id *id)
> +{
> +       struct perf_cpu cpu;
> +       int idx;
> +
> +       /*
> +        * Skip value 0 when enabling --per-thread globally,
> +        * otherwise it will have too many 0 output.
> +        */
> +       if (config->aggr_mode == AGGR_THREAD && config->system_wide)
> +               return true;
> +       /*
> +        * Skip value 0 when it's an uncore event and the given aggr id
> +        * does not belong to the PMU cpumask.
> +        */
> +       if (!counter->pmu || !counter->pmu->is_uncore)
> +               return false;
> +
> +       perf_cpu_map__for_each_cpu(cpu, idx, counter->pmu->cpus) {
> +               struct aggr_cpu_id own_id = config->aggr_get_id(config, cpu);
> +
> +               if (aggr_cpu_id__equal(id, &own_id))
> +                       return false;
> +       }
> +       return true;
> +}
> +
>  static void print_counter_aggrdata(struct perf_stat_config *config,
>                                    struct evsel *counter, int s,
>                                    struct outstate *os)
> @@ -814,11 +859,7 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
>         ena = aggr->counts.ena;
>         run = aggr->counts.run;
>
> -       /*
> -        * Skip value 0 when enabling --per-thread globally, otherwise it will
> -        * have too many 0 output.
> -        */
> -       if (val == 0 && config->aggr_mode == AGGR_THREAD && config->system_wide)
> +       if (val == 0 && should_skip_zero_counter(config, counter, &id))
>                 return;
>
>         if (!metric_only) {
> --
> 2.39.1.456.gfc5497dd1b-goog
>
