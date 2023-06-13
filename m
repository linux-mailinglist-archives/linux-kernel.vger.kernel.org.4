Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18EA272EC34
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 21:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239359AbjFMTp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 15:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239310AbjFMTpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 15:45:24 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1121720
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 12:45:23 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-3f9b7de94e7so55041cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 12:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686685522; x=1689277522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hmyWnHr478kYv9A2E6MzDTgvctIiVRO7z+aWX4EXIy4=;
        b=MncMug4N0Idcw5+ZCgvfzOMK+Xx26hXaad3kmnCMgsyQKw4EkIoPOombtZ57tmOe8p
         5Jkf0GwvI59WrclSQKUQka1ReHsFgIiMa3DuRhAoTmmyh3wOl+mVyOyI3vMJkao0VFTh
         YVszYfvJS+6QQnxO4GQxyzjW9+GomF9mp5G3/Si8Bzh8N8ku3YAbkTZ+5ZZy4cDbD/0m
         dMg1/Z7oPTOIp6H85NdxW1VFqjdIeo8MdGGRjyEjkKD/yFdIJ6pmeNrzZTEDABMgr4fn
         Gsbn1UsiN8bG16Dex9sw0inifdL2eRM71c/MaGB88S/RJyN3106PlKNrKxs5hZYvLgWo
         ZxNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686685522; x=1689277522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hmyWnHr478kYv9A2E6MzDTgvctIiVRO7z+aWX4EXIy4=;
        b=HYoTKpz9AICB0hWTCSaCscHzyvArzpjFR26Md+7voFe/vgPZyGmHUIV/8FGAMHrARH
         MGXxIQCp0tLSgsZ/gtd5jJXuxl2IENorVkt+dR5wcNO44ldQMwRk5nGOoxPeZ/642RvW
         No0g+Kd3fuvBZJHN30WCRHw0YQ44hBg8graHw7IrRKT2viJoP5M2JqWtFL/EKepe/v3u
         p8tDkvI4832ZFk3xNmIuMYP1lvTLV9jx5+zT2bxmh6/f0jTmvi0A+SCVvKpDumYZQD0X
         9oHgfxc1qdpvO9+ItcnqkqSqHVFDuf0dge06I2JKplEE/ZTjCVfLeLll2TswdxXKKp/s
         1Sfw==
X-Gm-Message-State: AC+VfDxDLxG2eyyN5gSfRV75LpEtDLkCkRr4J6dqp/ewuk2YtcD0QH8n
        svC4wzLlMjaljmaN9syzZ4xE1eae3oiaKygvPT9OdQ==
X-Google-Smtp-Source: ACHHUZ5S8CxYc8LAkpxgN/jbH8hhhSouA4lfLNPZxwQ5A0oOUNWfjeDnxtwTn1h7b6vfIgZ4Td2kRBEyNz52HrD5c8U=
X-Received: by 2002:a05:622a:54b:b0:3fd:aaef:3807 with SMTP id
 m11-20020a05622a054b00b003fdaaef3807mr40916qtx.16.1686685521994; Tue, 13 Jun
 2023 12:45:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230607162700.3234712-1-kan.liang@linux.intel.com> <20230607162700.3234712-5-kan.liang@linux.intel.com>
In-Reply-To: <20230607162700.3234712-5-kan.liang@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 13 Jun 2023 12:45:10 -0700
Message-ID: <CAP-5=fXjR_yhFqob_Kzsh3+dQ5N6zXzu-FJO5b4-qgYULth=eQ@mail.gmail.com>
Subject: Re: [PATCH 4/8] perf vendor events arm64: Add default tags into
 topdown L1 metrics
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
        namhyung@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        ak@linux.intel.com, eranian@google.com, ahmad.yasin@intel.com,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        John Garry <john.g.garry@oracle.com>
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

On Wed, Jun 7, 2023 at 9:27=E2=80=AFAM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> Add the default tags for ARM as well.
>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> Cc: Jing Zhang <renyu.zj@linux.alibaba.com>
> Cc: John Garry <john.g.garry@oracle.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/pmu-events/arch/arm64/sbsa.json | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/pmu-events/arch/arm64/sbsa.json b/tools/perf/pmu-=
events/arch/arm64/sbsa.json
> index f678c37ea9c3..f90b338261ac 100644
> --- a/tools/perf/pmu-events/arch/arm64/sbsa.json
> +++ b/tools/perf/pmu-events/arch/arm64/sbsa.json
> @@ -2,28 +2,32 @@
>      {
>          "MetricExpr": "stall_slot_frontend / (#slots * cpu_cycles)",
>          "BriefDescription": "Frontend bound L1 topdown metric",
> -        "MetricGroup": "TopdownL1",
> +        "DefaultMetricgroupName": "TopdownL1",
> +        "MetricGroup": "Default;TopdownL1",
>          "MetricName": "frontend_bound",
>          "ScaleUnit": "100%"
>      },
>      {
>          "MetricExpr": "(1 - op_retired / op_spec) * (1 - stall_slot / (#=
slots * cpu_cycles))",
>          "BriefDescription": "Bad speculation L1 topdown metric",
> -        "MetricGroup": "TopdownL1",
> +        "DefaultMetricgroupName": "TopdownL1",
> +        "MetricGroup": "Default;TopdownL1",
>          "MetricName": "bad_speculation",
>          "ScaleUnit": "100%"
>      },
>      {
>          "MetricExpr": "(op_retired / op_spec) * (1 - stall_slot / (#slot=
s * cpu_cycles))",
>          "BriefDescription": "Retiring L1 topdown metric",
> -        "MetricGroup": "TopdownL1",
> +        "DefaultMetricgroupName": "TopdownL1",
> +        "MetricGroup": "Default;TopdownL1",
>          "MetricName": "retiring",
>          "ScaleUnit": "100%"
>      },
>      {
>          "MetricExpr": "stall_slot_backend / (#slots * cpu_cycles)",
>          "BriefDescription": "Backend Bound L1 topdown metric",
> -        "MetricGroup": "TopdownL1",
> +        "DefaultMetricgroupName": "TopdownL1",
> +        "MetricGroup": "Default;TopdownL1",
>          "MetricName": "backend_bound",
>          "ScaleUnit": "100%"
>      }
> --
> 2.35.1
>
