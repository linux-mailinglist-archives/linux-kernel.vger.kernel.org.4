Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011466B7C07
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 16:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjCMPcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 11:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjCMPcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 11:32:41 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C6072B23
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 08:32:39 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id u5so3817928ybm.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 08:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678721558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IKY0bGA/67v6jhaOnNZDxQ/5VDkrDl59k+bq2DFx38s=;
        b=mZbgrf//R2baUIwXSMl/CZS8wsBxLVjkymPRHEK9RKQUKnzB5GsSmkurDRx1iD+pDm
         V4vQ3ZrA3vmUWAcrEPjkd0PAEXoqmGcj9xO5FQUUGNXHvJrYlBVZ9iREp1+OhFYwEwER
         Lqcz9yDOvX7/Wq72EE12+t39iWBCX78iedM7QtM7zMm31OXXK+IC8+5j4CvZh6nZAQXj
         HLhPwi7D+2Q0PQANNccGo74+JcjmImJ00ShS9OQie1pMcTiMM3U+oyTS+jdoU9CGiFc0
         Z8gfIqRunywvyL9v+GFYCqZXNZmaeJJFtRBVX3O4c/WeNrWxgqzPGq3YLFct5UKFtnnI
         +dGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678721558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IKY0bGA/67v6jhaOnNZDxQ/5VDkrDl59k+bq2DFx38s=;
        b=NEyA++JqQdVZVuTIl7xeedoqs4YxANAhD4W7KP3kar2yKby4MbQHtOjOYUtSUTIbOT
         VL80NL15CRMkJKxCq5uFwpmU5lUn36vXPyzERjW4GzFzjGgY5P/c6yHxKty4I373MvdY
         axea5ipXCg9mhxxtQeS9Vxx69GbEYnpnXd8YS78uV5E8yoXFp3AaVf/D1YzxIBStaOnd
         hG+N4ifBppwfBGDK0Gj8KK/lnkMeXSUEN7bRkPAnrQvLoQz4dFokam4OqJqk4vXckPVp
         BEv3klEAVVXH0plpekWjbJ9JS7n76dG3/LVYFhE6FXO4Ud23a25qvYN1J9HsdvtfJ6S/
         8byg==
X-Gm-Message-State: AO0yUKXPerK500Zd2G96N07+imO46P+07SrkASNiyaDk9dC/cjFK/81O
        LP5bzNH5Py8IplBkuXxSJKVsEKGTld8O+8qVeppXBw==
X-Google-Smtp-Source: AK7set/877PTnXYxajukP/RtIQetcIu7QHeIA1qev0g1ZIpeiM2+lTzRmypWamhW3+4wVXeLzXUlDUVItyLdI7Fof5A=
X-Received: by 2002:a05:6902:4f0:b0:ab8:1ed9:cfc1 with SMTP id
 w16-20020a05690204f000b00ab81ed9cfc1mr19330893ybs.3.1678721558454; Mon, 13
 Mar 2023 08:32:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230313080201.2440201-1-tmricht@linux.ibm.com> <20230313080201.2440201-6-tmricht@linux.ibm.com>
In-Reply-To: <20230313080201.2440201-6-tmricht@linux.ibm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 13 Mar 2023 08:32:26 -0700
Message-ID: <CAP-5=fW+9zLzDqUfvUQO7pDiTSdfFxRre6Y+b9wY0AC7Jy3jRg@mail.gmail.com>
Subject: Re: [PATCH 6/6] tools/perf/json: Add metric for tlb and cache s390
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, sumanthk@linux.ibm.com, svens@linux.ibm.com,
        gor@linux.ibm.com, hca@linux.ibm.com
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

On Mon, Mar 13, 2023 at 1:30=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> Add metrics for tlb and cache statistics:
> - finite_cpi: Cycles per Instructions from Finite cache/memory
> - est_cpi: Estimated Instruction Complexity CPI infinite Level 1
> - scpl1m: Estimated Sourcing Cycles per Level 1 Miss
> - tlb_percent: Estimated TLB CPU percentage of Total CPU
> - tlb_miss: Estimated Cycles per TLB Miss
>
> For details about the formulas see this documentation:
> https://www.ibm.com/support/pages/system/files/inline-files/CPU%20MF%20Fo=
rmulas%20including%20z16%20-%20May%202022_1.pdf
>
> Output after:
>  # ./perf stat -M tlb_miss -- dd if=3D/dev/zero of=3D/dev/null bs=3D1M co=
unt=3D10K
>  ... dd output removed
>
>  Performance counter stats for
>                         'dd if=3D/dev/zero of=3D/dev/null bs=3D1M count=
=3D10K':
>
>            667,726      DTLB2_MISSES             #   440.96 tlb_miss
>                198      ITLB2_WRITES
>        795,170,260      L1C_TLB2_MISSES
>              9,478      ITLB2_MISSES
>                820      DTLB2_WRITES
>      1,197,126,869      L1D_PENALTY_CYCLES
>          2,457,447      L1I_PENALTY_CYCLES
>
>        1.249342187 seconds time elapsed
>
>        0.001030000 seconds user
>        1.248105000 seconds sys
>
>  #
>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Acked-By: Sumanth Korikkar <sumanthk@linux.ibm.com>
> ---
>  .../arch/s390/cf_z13/transaction.json         | 30 +++++++++++++++++++
>  .../arch/s390/cf_z14/transaction.json         | 25 ++++++++++++++++
>  .../arch/s390/cf_z15/transaction.json         | 25 ++++++++++++++++
>  .../arch/s390/cf_z16/transaction.json         | 25 ++++++++++++++++
>  4 files changed, 105 insertions(+)
>
> diff --git a/tools/perf/pmu-events/arch/s390/cf_z13/transaction.json b/to=
ols/perf/pmu-events/arch/s390/cf_z13/transaction.json
> index 71e2c7fa734c..b941a7212a4d 100644
> --- a/tools/perf/pmu-events/arch/s390/cf_z13/transaction.json
> +++ b/tools/perf/pmu-events/arch/s390/cf_z13/transaction.json
> @@ -43,5 +43,35 @@
>      "BriefDescription": "Percentage sourced from memory",
>      "MetricName": "memp",
>      "MetricExpr": "((L1D_ONNODE_MEM_SOURCED_WRITES + L1D_ONDRAWER_MEM_SO=
URCED_WRITES + L1D_OFFDRAWER_MEM_SOURCED_WRITES + L1D_ONCHIP_MEM_SOURCED_WR=
ITES + L1I_ONNODE_MEM_SOURCED_WRITES + L1I_ONDRAWER_MEM_SOURCED_WRITES + L1=
I_OFFDRAWER_MEM_SOURCED_WRITES + L1I_ONCHIP_MEM_SOURCED_WRITES) / (L1I_DIR_=
WRITES + L1D_DIR_WRITES)) * 100"
> +  },
> +  {
> +    "BriefDescription": "Cycles per Instructions from Finite cache/memor=
y",
> +    "MetricName": "finite_cpi",
> +    "MetricExpr": "L1C_TLB1_MISSES / INSTRUCTIONS"
> +  },
> +  {
> +    "BriefDescription": "Estimated Instruction Complexity CPI infinite L=
evel 1",
> +    "MetricName": "est_cpi",
> +    "MetricExpr": "(CPU_CYCLES / INSTRUCTIONS) - (L1C_TLB1_MISSES / INST=
RUCTIONS)"
> +  },
> +  {
> +    "BriefDescription": "Estimated Sourcing Cycles per Level 1 Miss",
> +    "MetricName": "scpl1m",
> +    "MetricExpr": "L1C_TLB1_MISSES / (L1I_DIR_WRITES + L1D_DIR_WRITES)"
> +  },
> +  {
> +    "BriefDescription": "Estimated TLB CPU percentage of Total CPU",
> +    "MetricName": "tlb_percent",
> +    "MetricExpr": "((DTLB1_MISSES + ITLB1_MISSES) / CPU_CYCLES) * (L1C_T=
LB1_MISSES / (L1I_PENALTY_CYCLES + L1D_PENALTY_CYCLES)) * 100"

Looks good again but perhaps the ScaleUnit change. If you'd prefer to
keep as-is for consistency I'm happy to add my Acked-by.

Thanks,
Ian

> +  },
> +  {
> +    "BriefDescription": "Estimated Cycles per TLB Miss",
> +    "MetricName": "tlb_miss",
> +    "MetricExpr": "((DTLB1_MISSES + ITLB1_MISSES) / (DTLB1_WRITES + ITLB=
1_WRITES)) * (L1C_TLB1_MISSES / (L1I_PENALTY_CYCLES + L1D_PENALTY_CYCLES))"
> +  },
> +  {
> +    "BriefDescription": "Page Table Entry misses",
> +    "MetricName": "pte_miss",
> +    "MetricExpr": "(TLB2_PTE_WRITES / (DTLB1_WRITES + ITLB1_WRITES)) * 1=
00"
>    }
>  ]
> diff --git a/tools/perf/pmu-events/arch/s390/cf_z14/transaction.json b/to=
ols/perf/pmu-events/arch/s390/cf_z14/transaction.json
> index cca237bdb7ba..ce814ea93396 100644
> --- a/tools/perf/pmu-events/arch/s390/cf_z14/transaction.json
> +++ b/tools/perf/pmu-events/arch/s390/cf_z14/transaction.json
> @@ -43,5 +43,30 @@
>      "BriefDescription": "Percentage sourced from memory",
>      "MetricName": "memp",
>      "MetricExpr": "((L1D_ONCHIP_MEMORY_SOURCED_WRITES + L1D_ONCLUSTER_ME=
MORY_SOURCED_WRITES + L1D_OFFCLUSTER_MEMORY_SOURCED_WRITES + L1D_OFFDRAWER_=
MEMORY_SOURCED_WRITES + L1I_ONCHIP_MEMORY_SOURCED_WRITES + L1I_ONCLUSTER_ME=
MORY_SOURCED_WRITES + L1I_OFFCLUSTER_MEMORY_SOURCED_WRITES + L1I_OFFDRAWER_=
MEMORY_SOURCED_WRITES) / (L1I_DIR_WRITES + L1D_DIR_WRITES)) * 100"
> +  },
> +  {
> +    "BriefDescription": "Cycles per Instructions from Finite cache/memor=
y",
> +    "MetricName": "finite_cpi",
> +    "MetricExpr": "L1C_TLB2_MISSES / INSTRUCTIONS"
> +  },
> +  {
> +    "BriefDescription": "Estimated Instruction Complexity CPI infinite L=
evel 1",
> +    "MetricName": "est_cpi",
> +    "MetricExpr": "(CPU_CYCLES / INSTRUCTIONS) - (L1C_TLB2_MISSES / INST=
RUCTIONS)"
> +  },
> +  {
> +    "BriefDescription": "Estimated Sourcing Cycles per Level 1 Miss",
> +    "MetricName": "scpl1m",
> +    "MetricExpr": "L1C_TLB2_MISSES / (L1I_DIR_WRITES + L1D_DIR_WRITES)"
> +  },
> +  {
> +    "BriefDescription": "Estimated TLB CPU percentage of Total CPU",
> +    "MetricName": "tlb_percent",
> +    "MetricExpr": "((DTLB2_MISSES + ITLB2_MISSES) / CPU_CYCLES) * (L1C_T=
LB2_MISSES / (L1I_PENALTY_CYCLES + L1D_PENALTY_CYCLES)) * 100"
> +  },
> +  {
> +    "BriefDescription": "Estimated Cycles per TLB Miss",
> +    "MetricName": "tlb_miss",
> +    "MetricExpr": "((DTLB2_MISSES + ITLB2_MISSES) / (DTLB2_WRITES + ITLB=
2_WRITES)) * (L1C_TLB2_MISSES / (L1I_PENALTY_CYCLES + L1D_PENALTY_CYCLES))"
>    }
>  ]
> diff --git a/tools/perf/pmu-events/arch/s390/cf_z15/transaction.json b/to=
ols/perf/pmu-events/arch/s390/cf_z15/transaction.json
> index cca237bdb7ba..ce814ea93396 100644
> --- a/tools/perf/pmu-events/arch/s390/cf_z15/transaction.json
> +++ b/tools/perf/pmu-events/arch/s390/cf_z15/transaction.json
> @@ -43,5 +43,30 @@
>      "BriefDescription": "Percentage sourced from memory",
>      "MetricName": "memp",
>      "MetricExpr": "((L1D_ONCHIP_MEMORY_SOURCED_WRITES + L1D_ONCLUSTER_ME=
MORY_SOURCED_WRITES + L1D_OFFCLUSTER_MEMORY_SOURCED_WRITES + L1D_OFFDRAWER_=
MEMORY_SOURCED_WRITES + L1I_ONCHIP_MEMORY_SOURCED_WRITES + L1I_ONCLUSTER_ME=
MORY_SOURCED_WRITES + L1I_OFFCLUSTER_MEMORY_SOURCED_WRITES + L1I_OFFDRAWER_=
MEMORY_SOURCED_WRITES) / (L1I_DIR_WRITES + L1D_DIR_WRITES)) * 100"
> +  },
> +  {
> +    "BriefDescription": "Cycles per Instructions from Finite cache/memor=
y",
> +    "MetricName": "finite_cpi",
> +    "MetricExpr": "L1C_TLB2_MISSES / INSTRUCTIONS"
> +  },
> +  {
> +    "BriefDescription": "Estimated Instruction Complexity CPI infinite L=
evel 1",
> +    "MetricName": "est_cpi",
> +    "MetricExpr": "(CPU_CYCLES / INSTRUCTIONS) - (L1C_TLB2_MISSES / INST=
RUCTIONS)"
> +  },
> +  {
> +    "BriefDescription": "Estimated Sourcing Cycles per Level 1 Miss",
> +    "MetricName": "scpl1m",
> +    "MetricExpr": "L1C_TLB2_MISSES / (L1I_DIR_WRITES + L1D_DIR_WRITES)"
> +  },
> +  {
> +    "BriefDescription": "Estimated TLB CPU percentage of Total CPU",
> +    "MetricName": "tlb_percent",
> +    "MetricExpr": "((DTLB2_MISSES + ITLB2_MISSES) / CPU_CYCLES) * (L1C_T=
LB2_MISSES / (L1I_PENALTY_CYCLES + L1D_PENALTY_CYCLES)) * 100"
> +  },
> +  {
> +    "BriefDescription": "Estimated Cycles per TLB Miss",
> +    "MetricName": "tlb_miss",
> +    "MetricExpr": "((DTLB2_MISSES + ITLB2_MISSES) / (DTLB2_WRITES + ITLB=
2_WRITES)) * (L1C_TLB2_MISSES / (L1I_PENALTY_CYCLES + L1D_PENALTY_CYCLES))"
>    }
>  ]
> diff --git a/tools/perf/pmu-events/arch/s390/cf_z16/transaction.json b/to=
ols/perf/pmu-events/arch/s390/cf_z16/transaction.json
> index dde0735a7d22..ec2ff78e2b5f 100644
> --- a/tools/perf/pmu-events/arch/s390/cf_z16/transaction.json
> +++ b/tools/perf/pmu-events/arch/s390/cf_z16/transaction.json
> @@ -43,5 +43,30 @@
>      "BriefDescription": "Percentage sourced from memory",
>      "MetricName": "memp",
>      "MetricExpr": "((DCW_ON_CHIP_MEMORY + DCW_ON_MODULE_MEMORY + DCW_ON_=
DRAWER_MEMORY + DCW_OFF_DRAWER_MEMORY + ICW_ON_CHIP_MEMORY + ICW_ON_MODULE_=
MEMORY + ICW_ON_DRAWER_MEMORY + ICW_OFF_DRAWER_MEMORY) / (L1I_DIR_WRITES + =
L1D_DIR_WRITES)) * 100"
> +  },
> +  {
> +    "BriefDescription": "Cycles per Instructions from Finite cache/memor=
y",
> +    "MetricName": "finite_cpi",
> +    "MetricExpr": "L1C_TLB2_MISSES / INSTRUCTIONS"
> +  },
> +  {
> +    "BriefDescription": "Estimated Instruction Complexity CPI infinite L=
evel 1",
> +    "MetricName": "est_cpi",
> +    "MetricExpr": "(CPU_CYCLES / INSTRUCTIONS) - (L1C_TLB2_MISSES / INST=
RUCTIONS)"
> +  },
> +  {
> +    "BriefDescription": "Estimated Sourcing Cycles per Level 1 Miss",
> +    "MetricName": "scpl1m",
> +    "MetricExpr": "L1C_TLB2_MISSES / (L1I_DIR_WRITES + L1D_DIR_WRITES)"
> +  },
> +  {
> +    "BriefDescription": "Estimated TLB CPU percentage of Total CPU",
> +    "MetricName": "tlb_percent",
> +    "MetricExpr": "((DTLB2_MISSES + ITLB2_MISSES) / CPU_CYCLES) * (L1C_T=
LB2_MISSES / (L1I_PENALTY_CYCLES + L1D_PENALTY_CYCLES)) * 100"
> +  },
> +  {
> +    "BriefDescription": "Estimated Cycles per TLB Miss",
> +    "MetricName": "tlb_miss",
> +    "MetricExpr": "((DTLB2_MISSES + ITLB2_MISSES) / (DTLB2_WRITES + ITLB=
2_WRITES)) * (L1C_TLB2_MISSES / (L1I_PENALTY_CYCLES + L1D_PENALTY_CYCLES))"
>    }
>  ]
> --
> 2.39.1
>
