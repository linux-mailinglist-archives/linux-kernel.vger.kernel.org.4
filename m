Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 002886B7BE0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 16:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjCMPZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 11:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbjCMPZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 11:25:31 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771851BC8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 08:25:30 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id v196so4887212ybe.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 08:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678721129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bo7h73vzIvhd7SbAkzHI481mi/jorwfHFJL6Gg0+Zk4=;
        b=YpQnCvH6IT1oj7dWjXcGpWt189Xz3+YmonlcaBE503xewKuPSd+JcTgN9m9mxjeQxS
         KV4k32WazMiK1VZ8EBIEqbQz3gN/0H616pkPSAiGD6FaS1WJnJOnF38V6ph14Rk4kC9G
         hCMTn3lRwJiWGbL5wCmSAJSkdUyQ27YaB4eKB1l6CydxY3sEx8aSunKD/axWuezVbmPj
         HRrlmgmH6qUjnfFfsMhUwn0OUFgu2apnGetEBVRjx4ziKW4AgnF6i7X90BK0OWM+DlOX
         bqB9idP2kXu5qKfihh1JD8X7tP5nO0xEaMJempTxxncK+9nwW91j2WFZ3MgEQbZh/fzc
         R7mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678721129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bo7h73vzIvhd7SbAkzHI481mi/jorwfHFJL6Gg0+Zk4=;
        b=ayqGNw5J6jS3lUMmVFWnx9yKwsmfyw4kDPfg4IoBhwqfMH9v1lLRY4Ee+oBoifZNOO
         a6/mbnLa+wJjpG5XWdC8Fyqk4ELreijDfZIKbt2n7Qfr6OpV6cO1HdS8walzWNUfg8bo
         wk9Z0ZqlVQLXYmsh0ulDv2GbxiYS9qu4uiyJSzsIP33KTgm5RgvhDPerss4Z/3VRXMgJ
         Jq9Ym0Y8La+yLs2XPlb8xTauCtNk9A4FqdLEPEbzPolbPsP6TXH1FHtzM0o9pu0jgWaK
         pPQ3O35uOdfm/4rLRO34Qc6sMZi/zox9vVRsiL4qn2LiEqWWUGgW3BaftzbwfpVejo9X
         /FgA==
X-Gm-Message-State: AO0yUKVQWxiWs975lkORfo7a98apSEAUs45/j4CnGFY0mb7b1mB8eFun
        dklelO4EBdtx43BlPuPZvCfDBQ/GGQnGo4kVOTnE4g==
X-Google-Smtp-Source: AK7set/OqxR3NSJ6PJqZdEM2FmrqWfBq6tBtvtRAXIWiBp4wmljJAtJQzJlnChVP2OcvXPf4D/2vpjusTwheq9PWKNM=
X-Received: by 2002:a5b:f03:0:b0:a74:87b0:4090 with SMTP id
 x3-20020a5b0f03000000b00a7487b04090mr14325018ybr.3.1678721129488; Mon, 13 Mar
 2023 08:25:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230313080201.2440201-1-tmricht@linux.ibm.com> <20230313080201.2440201-4-tmricht@linux.ibm.com>
In-Reply-To: <20230313080201.2440201-4-tmricht@linux.ibm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 13 Mar 2023 08:25:18 -0700
Message-ID: <CAP-5=fX0b4833q0z0px=RAh7gi8zoM6VWAxh121Rd5=rr3+hVQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] tools/perf/json: Add cache metrics for s390 z14
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
> Add metrics for s390 z14
> - Percentage sourced from Level 2 cache
> - Percentage sourced from Level 3 on same chip cache
> - Percentage sourced from Level 4 Local cache on same book
> - Percentage sourced from Level 4 Remote cache on different book
> - Percentage sourced from memory
>
> For details about the formulas see this documentation:
> https://www.ibm.com/support/pages/system/files/inline-files/CPU%20MF%20Fo=
rmulas%20including%20z16%20-%20May%202022_1.pdf
>
> Outpuf after:
>  # ./perf stat -M l4rp -- find /
>  .... find output deleted
>
>  Performance counter stats for 'find /':
>
>              0      L1I_OFFDRAWER_L4_SOURCED_WRITES  #     0.01 l4rp
>             84      L1D_OFFDRAWER_L4_SOURCED_WRITES
>              0      L1I_OFFDRAWER_L3_SOURCED_WRITES
>     71,535,353      L1I_DIR_WRITES
>            219      L1D_OFFDRAWER_L3_SOURCED_WRITES
>         16,436      L1D_OFFDRAWER_L3_SOURCED_WRITES_IV
>              0      L1I_OFFDRAWER_L3_SOURCED_WRITES_IV
>     46,343,940      L1D_DIR_WRITES
>
>   10.530805537 seconds time elapsed
>
>    0.774396000 seconds user
>    1.602714000 seconds sys
>
>  #
>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Acked-By: Sumanth Korikkar <sumanthk@linux.ibm.com>
> ---
>  .../arch/s390/cf_z14/transaction.json         | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/tools/perf/pmu-events/arch/s390/cf_z14/transaction.json b/to=
ols/perf/pmu-events/arch/s390/cf_z14/transaction.json
> index 86bf83b4504e..cca237bdb7ba 100644
> --- a/tools/perf/pmu-events/arch/s390/cf_z14/transaction.json
> +++ b/tools/perf/pmu-events/arch/s390/cf_z14/transaction.json
> @@ -18,5 +18,30 @@
>      "BriefDescription": "Level One Miss per 100 Instructions",
>      "MetricName": "l1mp",
>      "MetricExpr": "((L1I_DIR_WRITES + L1D_DIR_WRITES) / INSTRUCTIONS) * =
100"
> +  },
> +  {
> +    "BriefDescription": "Percentage sourced from Level 2 cache",
> +    "MetricName": "l2p",
> +    "MetricExpr": "((L1D_L2D_SOURCED_WRITES + L1I_L2I_SOURCED_WRITES) / =
(L1I_DIR_WRITES + L1D_DIR_WRITES)) * 100"

Some comment as patch #3 wrt ScaleUnit of "100%" rather than "* 100".
I can see from the metric above this way is being consistent.

Thanks,
Ian

> +  },
> +  {
> +    "BriefDescription": "Percentage sourced from Level 3 on same chip ca=
che",
> +    "MetricName": "l3p",
> +    "MetricExpr": "((L1D_ONCHIP_L3_SOURCED_WRITES + L1D_ONCHIP_L3_SOURCE=
D_WRITES_IV + L1I_ONCHIP_L3_SOURCED_WRITES + L1I_ONCHIP_L3_SOURCED_WRITES_I=
V) / (L1I_DIR_WRITES + L1D_DIR_WRITES)) * 100"
> +  },
> +  {
> +    "BriefDescription": "Percentage sourced from Level 4 Local cache on =
same book",
> +    "MetricName": "l4lp",
> +    "MetricExpr": "((L1D_ONCLUSTER_L3_SOURCED_WRITES + L1D_ONCLUSTER_L3_=
SOURCED_WRITES_IV + L1D_ONDRAWER_L4_SOURCED_WRITES + L1I_ONCLUSTER_L3_SOURC=
ED_WRITES + L1I_ONCLUSTER_L3_SOURCED_WRITES_IV + L1I_ONDRAWER_L4_SOURCED_WR=
ITES + L1D_OFFCLUSTER_L3_SOURCED_WRITES + L1D_OFFCLUSTER_L3_SOURCED_WRITES_=
IV + L1D_ONCHIP_L3_SOURCED_WRITES_RO + L1I_OFFCLUSTER_L3_SOURCED_WRITES + L=
1I_OFFCLUSTER_L3_SOURCED_WRITES_IV) / (L1I_DIR_WRITES + L1D_DIR_WRITES)) * =
100"
> +  },
> +  {
> +    "BriefDescription": "Percentage sourced from Level 4 Remote cache on=
 different book",
> +    "MetricName": "l4rp",
> +    "MetricExpr": "((L1D_OFFDRAWER_L3_SOURCED_WRITES + L1D_OFFDRAWER_L3_=
SOURCED_WRITES_IV + L1D_OFFDRAWER_L4_SOURCED_WRITES + L1I_OFFDRAWER_L3_SOUR=
CED_WRITES + L1I_OFFDRAWER_L3_SOURCED_WRITES_IV + L1I_OFFDRAWER_L4_SOURCED_=
WRITES) / (L1I_DIR_WRITES + L1D_DIR_WRITES)) * 100"
> +  },
> +  {
> +    "BriefDescription": "Percentage sourced from memory",
> +    "MetricName": "memp",
> +    "MetricExpr": "((L1D_ONCHIP_MEMORY_SOURCED_WRITES + L1D_ONCLUSTER_ME=
MORY_SOURCED_WRITES + L1D_OFFCLUSTER_MEMORY_SOURCED_WRITES + L1D_OFFDRAWER_=
MEMORY_SOURCED_WRITES + L1I_ONCHIP_MEMORY_SOURCED_WRITES + L1I_ONCLUSTER_ME=
MORY_SOURCED_WRITES + L1I_OFFCLUSTER_MEMORY_SOURCED_WRITES + L1I_OFFDRAWER_=
MEMORY_SOURCED_WRITES) / (L1I_DIR_WRITES + L1D_DIR_WRITES)) * 100"
>    }
>  ]
> --
> 2.39.1
>
