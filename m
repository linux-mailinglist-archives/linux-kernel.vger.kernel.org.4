Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63D4672EBD5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 21:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239251AbjFMTXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 15:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbjFMTXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 15:23:00 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD39199B
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 12:22:59 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b3c43279c1so28855ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 12:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686684179; x=1689276179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+D4HqqatbIO3Y5m0N5oSclLaQb1DH2u/EcPqTcyMdUY=;
        b=q0muuWaNlWvcxZ9tDn4dPyU7aLwExy2pkcaRATURBAZqx4uoWjsVXmYTq6jb7n44VT
         UqCEi3DslYIJI6vE43yWA8mq2SYHY80TD7YgLu8ToS7a9sFle5Kify3B2uhdFPDkNd56
         nr/L1B0NOspgUiuAF4TlE0mUHhIg9zSV64zO6fHXCJylxuaW+wTdmFreO0jsNBOR6LPP
         gRIe2zGenyDwb3742K433vs78XjUo343CKVtEkJtZzf5Ys0ieETiIGiOnfk50L6zdrxG
         7N1CVbE0Veaz0xW/rVFYDwa3QQVnraDOT079dIoW4SDKhtPnvwpwGiC8D3bL5Fm1D6nx
         n+MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686684179; x=1689276179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+D4HqqatbIO3Y5m0N5oSclLaQb1DH2u/EcPqTcyMdUY=;
        b=cf/YDP8SWY+fkADUfC9e/Zb5cEbhnoB/Hc5l58f4PpCPJF8OkX6RSd5dBJXazYB3oE
         o60Z0OOIIlGWJcZpfNmKL8I1tXxzWLi1PUjPv2Y2aKYkNUvpqoI+5LSmWfP04/1DYuDw
         PgMMwlmQvauziKIKVyc5UuXaRQXJls9ZrRTV5vwnwuRKcfwEhExSmsjJKcFWC67edPL3
         7VXOnsK0eD1d96JjlalPw9gXbxinb14lJfGwCEFpwTfK6tnyD6MXc3V8VATC3ZPoWgm5
         XmgAivJWyN5N7gSZI1QczsNfEeaT8fBnM1W5cdRGr0L4wPomAnKYg1o6o1AOoCPx31Ev
         +dVQ==
X-Gm-Message-State: AC+VfDwFfdjZgjEkwI5xcOPIZekHfW+N3/x5hAcSwsf3cLRjGitt3+6v
        QBThlCD4PRvw5PrQ6vdOEXoUxkpiJRybk31xOW2qAg==
X-Google-Smtp-Source: ACHHUZ7IdUcspwOvM0xXqtKaD2SAV/caVjerale3K/7e+6pfL57YVGqqlwDDCVLiMR2Yr6wlC5WOGtTN4AwNWHNau68=
X-Received: by 2002:a17:902:c205:b0:1b3:b200:a3dc with SMTP id
 5-20020a170902c20500b001b3b200a3dcmr41025pll.2.1686684178700; Tue, 13 Jun
 2023 12:22:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230607162700.3234712-1-kan.liang@linux.intel.com> <20230607162700.3234712-2-kan.liang@linux.intel.com>
In-Reply-To: <20230607162700.3234712-2-kan.liang@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 13 Jun 2023 12:22:46 -0700
Message-ID: <CAP-5=fXcMobh7+12su=AvMs+3-GbRiGE4STMv9FjOYfphWzkAA@mail.gmail.com>
Subject: Re: [PATCH 1/8] perf metric: Fix no group check
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
        namhyung@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        ak@linux.intel.com, eranian@google.com, ahmad.yasin@intel.com
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
> The no group check fails if there is more than one meticgroup in the
> metricgroup_no_group.
>
> The first parameter of the match_metric() should be the string, while
> the substring should be the second parameter.
>
> Fixes: ccc66c609280 ("perf metric: JSON flag to not group events if gathe=
ring a metric group")
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/metricgroup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.=
c
> index 70ef2e23a710..74f2d8efc02d 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -1175,7 +1175,7 @@ static int metricgroup__add_metric_callback(const s=
truct pmu_metric *pm,
>
>         if (pm->metric_expr && match_pm_metric(pm, data->pmu, data->metri=
c_name)) {
>                 bool metric_no_group =3D data->metric_no_group ||
> -                       match_metric(data->metric_name, pm->metricgroup_n=
o_group);
> +                       match_metric(pm->metricgroup_no_group, data->metr=
ic_name);
>
>                 data->has_match =3D true;
>                 ret =3D add_metric(data->list, pm, data->modifier, metric=
_no_group,
> --
> 2.35.1
>
