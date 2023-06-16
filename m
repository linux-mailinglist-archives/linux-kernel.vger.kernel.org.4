Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A7A7326ED
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 07:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241420AbjFPF5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 01:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjFPF5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 01:57:41 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C944E2D57
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 22:57:40 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-33d928a268eso115035ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 22:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686895060; x=1689487060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gjf/Q1AKMt/rmDqEwL5TkR67v9E2T5unrUGfsNy/w4U=;
        b=hmYAMLKXJ2DA3K1l6mvzogsKKGpz89kqxn0e3TWgyvQa4/fpVb4aXlPoqi5PABl0wV
         mpU3gZc5BEESftGWx+RbZVUd1XHp1wBvZGHQTGUPA8uEtJuq4GLwbmUJjsyFzEMRAIJx
         sDH47svL3GF0Eb3K2HuWCAFZaobHcqU8TE6qHIkuG0yd/DrmMzp+hd0/hxyKiLbLrvNe
         pKzFySLUZCm2FCnU65P73jIpBLaGXjntQ8fPlT83s1ig0o0VwIxnFFaNF5A1oNl1y//o
         ijyhTyFOIAL44cB7eoIEyIKYGiGyvGH7PrXdd+EqLtVANFbspGmP0K4hd+yaL+Lb0lg9
         f6DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686895060; x=1689487060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gjf/Q1AKMt/rmDqEwL5TkR67v9E2T5unrUGfsNy/w4U=;
        b=PSlp8pHwjDGm+ZE62l0BiuR8hDsyrp0ts1C0ZKZ9dSnO5YFvG9oqgM27vw30R9zXgK
         iD1oENBgS7vOxOq7ULG4FsGR3wLYpq8rKt8n1Y+bacBDlTSTIRZgyjuOPm94US5m05ld
         ClCcezd6qtJ9YXwuaVX3ur6DIvH+XWDP/+TRkGfCVS7KUJtgkWXZeBE+H+beRdEeB6Pp
         FtYUpoKwwAXNr6MhcgapKtnHjO8JLQlFSayd1J3qGVFXzPeJdEgpDkztjW1rSYr0jR8/
         nTVb5etIBGetEIOQ7IZogEQ16/mlAgsDcefq7uapvsSt24AwVNbpRDszwzTqiFlT5DhR
         f/kA==
X-Gm-Message-State: AC+VfDxTvyxz9v7Uwn5mEw+kpIroq7XMb0Itge2rS4inWkruyEfeB2PL
        SPEhBufVeY/c2quFUopSJ59w77Gkp5qMmZC6HEDieg==
X-Google-Smtp-Source: ACHHUZ5Y+rc0/MZ5TWhNtqA4At8ZTfQhUStNiUIjF4uBVxA88uS4EsF+tlhHXBsKcPZ9TZXsIcw//YKTuR4aNhxPF1I=
X-Received: by 2002:a05:6e02:1bcc:b0:340:ccdd:5739 with SMTP id
 x12-20020a056e021bcc00b00340ccdd5739mr371453ilv.16.1686895060136; Thu, 15 Jun
 2023 22:57:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230616031420.3751973-1-kan.liang@linux.intel.com> <20230616031420.3751973-6-kan.liang@linux.intel.com>
In-Reply-To: <20230616031420.3751973-6-kan.liang@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 15 Jun 2023 22:57:29 -0700
Message-ID: <CAP-5=fUOJFkV7Dtb973qOb0QLkg1EgoGKRqVDF23zUDwJTDvbg@mail.gmail.com>
Subject: Re: [PATCH V4 5/5] perf vendor events arm64: Add default tags for
 Hisi hip08 L1 metrics
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
        namhyung@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        ak@linux.intel.com, eranian@google.com, ahmad.yasin@intel.com,
        John Garry <john.g.garry@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 8:15=E2=80=AFPM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> Add the default tags for Hisi hip08 as well.
>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> Cc: John Garry <john.g.garry@oracle.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  .../arch/arm64/hisilicon/hip08/metrics.json          | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/metrics.jso=
n b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/metrics.json
> index 6443a061e22a..6463531b9941 100644
> --- a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/metrics.json
> +++ b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/metrics.json
> @@ -3,28 +3,32 @@
>          "MetricExpr": "FETCH_BUBBLE / (4 * CPU_CYCLES)",
>          "PublicDescription": "Frontend bound L1 topdown metric",
>          "BriefDescription": "Frontend bound L1 topdown metric",
> -        "MetricGroup": "TopDownL1",
> +        "DefaultMetricgroupName": "TopDownL1",
> +        "MetricGroup": "Default;TopDownL1",
>          "MetricName": "frontend_bound"
>      },
>      {
>          "MetricExpr": "(INST_SPEC - INST_RETIRED) / (4 * CPU_CYCLES)",
>          "PublicDescription": "Bad Speculation L1 topdown metric",
>          "BriefDescription": "Bad Speculation L1 topdown metric",
> -        "MetricGroup": "TopDownL1",
> +        "DefaultMetricgroupName": "TopDownL1",
> +        "MetricGroup": "Default;TopDownL1",
>          "MetricName": "bad_speculation"
>      },
>      {
>          "MetricExpr": "INST_RETIRED / (CPU_CYCLES * 4)",
>          "PublicDescription": "Retiring L1 topdown metric",
>          "BriefDescription": "Retiring L1 topdown metric",
> -        "MetricGroup": "TopDownL1",
> +        "DefaultMetricgroupName": "TopDownL1",
> +        "MetricGroup": "Default;TopDownL1",
>          "MetricName": "retiring"
>      },
>      {
>          "MetricExpr": "1 - (frontend_bound + bad_speculation + retiring)=
",
>          "PublicDescription": "Backend Bound L1 topdown metric",
>          "BriefDescription": "Backend Bound L1 topdown metric",
> -        "MetricGroup": "TopDownL1",
> +        "DefaultMetricgroupName": "TopDownL1",
> +        "MetricGroup": "Default;TopDownL1",
>          "MetricName": "backend_bound"
>      },
>      {
> --
> 2.35.1
>
