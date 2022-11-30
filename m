Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C6C63E063
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 19:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiK3S66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 13:58:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiK3S6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 13:58:51 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9738630B
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 10:58:50 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id h11so21360757wrw.13
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 10:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=87ENfYXIDebjZ9OJXAGQbQFZb77jhLjiCr56B3zGCYY=;
        b=awR/NO0ZrJmArjac1OjpJ/hysKu0BXmmhK8kas2lLXQ+lsZruBp/T+e8hBth93qQrB
         d7rk8OH4vXzbf56ZmY4FgdUQ2SHYRoh2mNK64pFP3pqZf9WZtrdKJFyeU8Ku4xTNrJ3E
         flLan7iV9TCIELgZkoDeTCLcslMoavpnvel7apsXmboEtZ/maaQMY3yPlmhrPcfPKZ8N
         a1uJ518MPpe+qGw7dfbOQD7WaRRgoNFax++FUY5/7vH4VykzKmLN/EG6T7kGN9RnuT53
         3+EYKu30lgSfSFDH238akOIpU//OgoPq3P/KWU27lenRibpXgP84HvhlT/Lhyk/e4cjW
         Nz0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=87ENfYXIDebjZ9OJXAGQbQFZb77jhLjiCr56B3zGCYY=;
        b=T+IbpA77W5K0VzZNhJzzIsliWGXrTk9sPMPUEScI3q3tKBBdIblEoFR1thzkMdzJ4B
         C0M+QbEi5/GMuqvLUq1+sP8g2rKR4qyYFASyJpER0mKw3ASX+fXresoX73FtWaLwqO4f
         pWHP9zFv2ip8azNQXfOFWJejvHwuFgvDPkr7pnUdO+ZQ979YqE/Ivav4mtWhwUfjOruS
         yRPVJjP37LoRH4juwJC2y1Y1Y8xunZ1FoHLXFyZlROq/yK7vhb4fVQjmGN7qFpwzo7Qf
         NsBlF9o/ZkshvTFhP6kJO0tFYN+FOxzCXgqnVzp3qzoPZWLIyZKPFUQHcoFz4y4nzax2
         epOQ==
X-Gm-Message-State: ANoB5pknrWg+OeLBSLYNH49A/FOgNtKUlaNVEfdmNZEQBiSzvu4Lvgkp
        vnl4bO0WO6dpOoqWFjKUECuiMlJP7jKPrlFHTljTvQ==
X-Google-Smtp-Source: AA0mqf6pNJJwFRwvQ9Nbbx/FXqmlOjbohE6MouQre6Ex1OPGnWlI+tSuTGt1dEi3R3LZe0wMGhbdS/xShyGraTWY2ls=
X-Received: by 2002:adf:e2c9:0:b0:241:db86:176d with SMTP id
 d9-20020adfe2c9000000b00241db86176dmr28759168wrj.40.1669834729092; Wed, 30
 Nov 2022 10:58:49 -0800 (PST)
MIME-Version: 1.0
References: <1668411720-3581-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1669310088-13482-1-git-send-email-renyu.zj@linux.alibaba.com> <1669310088-13482-6-git-send-email-renyu.zj@linux.alibaba.com>
In-Reply-To: <1669310088-13482-6-git-send-email-renyu.zj@linux.alibaba.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 30 Nov 2022 10:58:37 -0800
Message-ID: <CAP-5=fV0WSTK=MT6K2nqsqYT6xCTg7Pv_rXahHFeRhV0ZHCiEQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] perf vendor events arm64: Add PE utilization
 metrics for neoverse-n2
To:     Jing Zhang <renyu.zj@linux.alibaba.com>
Cc:     John Garry <john.g.garry@oracle.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Zhuo Song <zhuo.song@linux.alibaba.com>
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

On Thu, Nov 24, 2022 at 9:15 AM Jing Zhang <renyu.zj@linux.alibaba.com> wrote:
>
> Add PE utilization related metrics.
>
> Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
> ---
>  .../arch/arm64/arm/neoverse-n2/metrics.json        | 45 ++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json
> index 23c7d62..7b54819 100644
> --- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json
> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json
> @@ -189,5 +189,50 @@
>          "MetricGroup": "Branch",
>          "MetricName": "branch_miss_pred_rate",
>          "ScaleUnit": "100%"
> +    },
> +    {
> +        "MetricExpr": "instructions / CPU_CYCLES",
> +        "PublicDescription": "The average number of instructions executed for each cycle.",
> +        "BriefDescription": "Instructions per cycle",
> +        "MetricGroup": "PEutilization",
> +        "MetricName": "ipc"
> +    },

A related useful metric is percentage of peak, so if the peak IPC is 8
(usually a constant related to the number of functional units) then
you can just compute the ratio of IPC with this.

> +    {
> +        "MetricExpr": "INST_RETIRED / CPU_CYCLES",
> +        "PublicDescription": "Architecturally executed Instructions Per Cycle (IPC)",
> +        "BriefDescription": "Architecturally executed Instructions Per Cycle (IPC)",


The duplicated descriptions are unnecessary. Drop the public one for
consistency with what we do for Intel:
https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py#L299

> +        "MetricGroup": "PEutilization",
> +        "MetricName": "retired_ipc"
> +    },
> +    {
> +        "MetricExpr": "INST_SPEC / CPU_CYCLES",
> +        "PublicDescription": "Speculatively executed Instructions Per Cycle (IPC)",
> +        "BriefDescription": "Speculatively executed Instructions Per Cycle (IPC)",
> +        "MetricGroup": "PEutilization",
> +        "MetricName": "spec_ipc"
> +    },
> +    {
> +        "MetricExpr": "OP_RETIRED / OP_SPEC",
> +        "PublicDescription": "Fraction of operations retired",
> +        "BriefDescription": "Fraction of operations retired",

Would instructions be clearer than operations here?

> +        "MetricGroup": "PEutilization",
> +        "MetricName": "retired_rate",
> +        "ScaleUnit": "100%"
> +    },
> +    {
> +        "MetricExpr": "1 - OP_RETIRED / OP_SPEC",

Should OP_RETIRED be greater than OP_SPEC? In which case won't this
metric be negative?

> +        "PublicDescription": "Fraction of operations wasted",
> +        "BriefDescription": "Fraction of operations wasted",
> +        "MetricGroup": "PEutilization",
> +        "MetricName": "wasted_rate",
> +        "ScaleUnit": "100%"
> +    },
> +    {
> +        "MetricExpr": "OP_RETIRED / OP_SPEC * (1 - (STALL_SLOT - CPU_CYCLES) / (CPU_CYCLES * 5))",
> +        "PublicDescription": "Utilization of CPU",
> +        "BriefDescription": "Utilization of CPU",

Some more detail in the description would be useful.

> +        "MetricGroup": "PEutilization",
> +        "MetricName": "cpu_utilization",
> +        "ScaleUnit": "100%"
>      }
>  ]
> --
> 1.8.3.1
>
