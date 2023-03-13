Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95B796B7BD1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 16:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjCMPWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 11:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbjCMPWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 11:22:11 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B4E6F4B6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 08:22:09 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-54195ef155aso69469287b3.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 08:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678720928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KIirSw/hZG6Knd8g/0d8FTYdGwbw04UvbKt8SdtEMds=;
        b=pUqoI8n2FFvSJ75U0mQW3hso4d0ccj6gO7Nm+PMEbXV7srmwpvUx/Z8mmcal49/bqu
         76xTnZFme9MJqpvgT/DJFGm945aZMkDR9h3uepcRVjC5scANlW61V3Y1oP4wJAmQ+E77
         S65SrsisT1gXNbHL/pGqAzIbmpEVykrXVvh4LxJuSdJCEGNlxisfABLzvYD6NDV/p2bN
         c95i/WTYhgNwGHBLVjXPdjuugIkVlc8uhAMQOKGaJ7XNYDxJo4PCq3C9KJdGtW11jsdS
         GIYJQegJaJ+T0pBk9F5WbD6UDQEidMVjyuP+x6Wwo48HT04J8wPFGBFG+IzBSdw6XgZo
         XUPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678720928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KIirSw/hZG6Knd8g/0d8FTYdGwbw04UvbKt8SdtEMds=;
        b=E+YrPnysg9ubRM0cvEgfJ30H7TvGu739YkT7FN6UHt8KLJvvADeJBjn1t+cBQm80/F
         +T2hr+v/1BEm0jriWy1P0hnCjwhbuo51jvpYvv8g4ZQK0hJJZHh6akrVpGMK/0gp4J2u
         bFFIURlFX0WU8oBSE//0mmz5inVBEN3gtkB1P2W1N0KtxhbBiv/q0KWKXvnPkkeK73k8
         C8hB9FfVuslcUomKHn9syZTTYug3HaJuD9W4CaG0N1kSBUXur1mPK4xSorm/YQJPykDN
         /NI009x1MLuwxWkgvUO2LFwxysb/Fjc+R4ypOCHEAOJ+3u9GquGGQUDayR9VNJ3skkZ7
         jBPQ==
X-Gm-Message-State: AO0yUKVjD/JCzoH88Fi8LovGX4z5zwxfdNm7fBOEzfSW+KAsMSOmSETj
        9y28MPPJ48cBLmy8acriXtfKcC+KvxfizgPBc8zYXJ5C258ABaE0r6TJ+A==
X-Google-Smtp-Source: AK7set88EOorTCYe0sYEPjHrkUPLEBaOHMfN+ZIo+EM4OklcrE+1pw9HL4mP61K3jpnERWaDwA9ZtIhdL9jUpT2DXME=
X-Received: by 2002:a81:af5c:0:b0:540:e6c6:31e7 with SMTP id
 x28-20020a81af5c000000b00540e6c631e7mr5873887ywj.2.1678720928477; Mon, 13 Mar
 2023 08:22:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230313080201.2440201-1-tmricht@linux.ibm.com>
In-Reply-To: <20230313080201.2440201-1-tmricht@linux.ibm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 13 Mar 2023 08:21:56 -0700
Message-ID: <CAP-5=fUN=ZVmG6Ryv3QUxcxBfUOw4HURtfcTsi+X9c73QWJPnw@mail.gmail.com>
Subject: Re: [PATCH 1/6] tools/perf/json: Add common metrics for s390
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, sumanthk@linux.ibm.com, svens@linux.ibm.com,
        gor@linux.ibm.com, hca@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 1:06=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> Add 3 metrics for s390 machines:
> - Cycles per instruction: Amount of CPU cycles used per instructions,
>   named cpi.
> - Problem state ratio: Ratio of instructions executed in problem state
>   compared to total number of instructions, named prbstate.
> - Level one instruction and data cache misses per 100 instructions,
>   named l1mp.
>
> For details about the formulas see this documentation:
> https://www.ibm.com/support/pages/system/files/inline-files/CPU%20MF%20Fo=
rmulas%20including%20z16%20-%20May%202022_1.pdf
>
> Outpuf after:
>  # ./perf stat -M cpi -- dd if=3D/dev/zero of=3D/dev/null bs=3D1M count=
=3D10K
>  10240+0 records in
>  10240+0 records out
>  10737418240 bytes (11 GB, 10 GiB) copied, 1.30151 s, 8.2 GB/s
>
> Performance counter stats for 'dd if=3D/dev/zero of=3D/dev/null .....':
>
>   6,779,778,802      CPU_CYCLES              #     1.96 cpi
>   3,461,975,090      INSTRUCTIONS
>
>   1.306873021 seconds time elapsed
>
>   0.001034000 seconds user
>   1.305677000 seconds sys
>  #
>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Acked-By: Sumanth Korikkar <sumanthk@linux.ibm.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  .../pmu-events/arch/s390/cf_z13/transaction.json  | 15 +++++++++++++++
>  .../pmu-events/arch/s390/cf_z14/transaction.json  | 15 +++++++++++++++
>  .../pmu-events/arch/s390/cf_z15/transaction.json  | 15 +++++++++++++++
>  .../pmu-events/arch/s390/cf_z16/transaction.json  | 15 +++++++++++++++
>  4 files changed, 60 insertions(+)
>
> diff --git a/tools/perf/pmu-events/arch/s390/cf_z13/transaction.json b/to=
ols/perf/pmu-events/arch/s390/cf_z13/transaction.json
> index 1a0034f79f73..86bf83b4504e 100644
> --- a/tools/perf/pmu-events/arch/s390/cf_z13/transaction.json
> +++ b/tools/perf/pmu-events/arch/s390/cf_z13/transaction.json
> @@ -3,5 +3,20 @@
>      "BriefDescription": "Transaction count",
>      "MetricName": "transaction",
>      "MetricExpr": "TX_C_TEND + TX_NC_TEND + TX_NC_TABORT + TX_C_TABORT_S=
PECIAL + TX_C_TABORT_NO_SPECIAL"
> +  },
> +  {
> +    "BriefDescription": "Cycles per Instruction",
> +    "MetricName": "cpi",
> +    "MetricExpr": "CPU_CYCLES / INSTRUCTIONS"
> +  },
> +  {
> +    "BriefDescription": "Problem State Instruction Ratio",
> +    "MetricName": "prbstate",
> +    "MetricExpr": "(PROBLEM_STATE_INSTRUCTIONS / INSTRUCTIONS) * 100"
> +  },
> +  {
> +    "BriefDescription": "Level One Miss per 100 Instructions",
> +    "MetricName": "l1mp",
> +    "MetricExpr": "((L1I_DIR_WRITES + L1D_DIR_WRITES) / INSTRUCTIONS) * =
100"
>    }
>  ]
> diff --git a/tools/perf/pmu-events/arch/s390/cf_z14/transaction.json b/to=
ols/perf/pmu-events/arch/s390/cf_z14/transaction.json
> index 1a0034f79f73..86bf83b4504e 100644
> --- a/tools/perf/pmu-events/arch/s390/cf_z14/transaction.json
> +++ b/tools/perf/pmu-events/arch/s390/cf_z14/transaction.json
> @@ -3,5 +3,20 @@
>      "BriefDescription": "Transaction count",
>      "MetricName": "transaction",
>      "MetricExpr": "TX_C_TEND + TX_NC_TEND + TX_NC_TABORT + TX_C_TABORT_S=
PECIAL + TX_C_TABORT_NO_SPECIAL"
> +  },
> +  {
> +    "BriefDescription": "Cycles per Instruction",
> +    "MetricName": "cpi",
> +    "MetricExpr": "CPU_CYCLES / INSTRUCTIONS"
> +  },
> +  {
> +    "BriefDescription": "Problem State Instruction Ratio",
> +    "MetricName": "prbstate",
> +    "MetricExpr": "(PROBLEM_STATE_INSTRUCTIONS / INSTRUCTIONS) * 100"
> +  },
> +  {
> +    "BriefDescription": "Level One Miss per 100 Instructions",
> +    "MetricName": "l1mp",
> +    "MetricExpr": "((L1I_DIR_WRITES + L1D_DIR_WRITES) / INSTRUCTIONS) * =
100"
>    }
>  ]
> diff --git a/tools/perf/pmu-events/arch/s390/cf_z15/transaction.json b/to=
ols/perf/pmu-events/arch/s390/cf_z15/transaction.json
> index 1a0034f79f73..86bf83b4504e 100644
> --- a/tools/perf/pmu-events/arch/s390/cf_z15/transaction.json
> +++ b/tools/perf/pmu-events/arch/s390/cf_z15/transaction.json
> @@ -3,5 +3,20 @@
>      "BriefDescription": "Transaction count",
>      "MetricName": "transaction",
>      "MetricExpr": "TX_C_TEND + TX_NC_TEND + TX_NC_TABORT + TX_C_TABORT_S=
PECIAL + TX_C_TABORT_NO_SPECIAL"
> +  },
> +  {
> +    "BriefDescription": "Cycles per Instruction",
> +    "MetricName": "cpi",
> +    "MetricExpr": "CPU_CYCLES / INSTRUCTIONS"
> +  },
> +  {
> +    "BriefDescription": "Problem State Instruction Ratio",
> +    "MetricName": "prbstate",
> +    "MetricExpr": "(PROBLEM_STATE_INSTRUCTIONS / INSTRUCTIONS) * 100"
> +  },
> +  {
> +    "BriefDescription": "Level One Miss per 100 Instructions",
> +    "MetricName": "l1mp",
> +    "MetricExpr": "((L1I_DIR_WRITES + L1D_DIR_WRITES) / INSTRUCTIONS) * =
100"
>    }
>  ]
> diff --git a/tools/perf/pmu-events/arch/s390/cf_z16/transaction.json b/to=
ols/perf/pmu-events/arch/s390/cf_z16/transaction.json
> index 1a0034f79f73..86bf83b4504e 100644
> --- a/tools/perf/pmu-events/arch/s390/cf_z16/transaction.json
> +++ b/tools/perf/pmu-events/arch/s390/cf_z16/transaction.json
> @@ -3,5 +3,20 @@
>      "BriefDescription": "Transaction count",
>      "MetricName": "transaction",
>      "MetricExpr": "TX_C_TEND + TX_NC_TEND + TX_NC_TABORT + TX_C_TABORT_S=
PECIAL + TX_C_TABORT_NO_SPECIAL"
> +  },
> +  {
> +    "BriefDescription": "Cycles per Instruction",
> +    "MetricName": "cpi",
> +    "MetricExpr": "CPU_CYCLES / INSTRUCTIONS"
> +  },
> +  {
> +    "BriefDescription": "Problem State Instruction Ratio",
> +    "MetricName": "prbstate",
> +    "MetricExpr": "(PROBLEM_STATE_INSTRUCTIONS / INSTRUCTIONS) * 100"
> +  },
> +  {
> +    "BriefDescription": "Level One Miss per 100 Instructions",
> +    "MetricName": "l1mp",
> +    "MetricExpr": "((L1I_DIR_WRITES + L1D_DIR_WRITES) / INSTRUCTIONS) * =
100"
>    }
>  ]
> --
> 2.39.1
>
