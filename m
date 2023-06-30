Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D15674411E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 19:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbjF3RXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 13:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233043AbjF3RWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 13:22:46 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8C84230
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 10:22:28 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-401f4408955so16201cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 10:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688145747; x=1690737747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=55VlF4SrUJuf+l1F6X+Urs6uXQ0VvjhO9X8SqfAz6ms=;
        b=oNrGkBxUE06bMnNDlNNYbGJZiI7xgYY2dlvvFI2Sut03A92LDF3IM1HnGL/hLT2uLV
         n/m76CkLFt0YAUrFglfyuau1Zm66fXvIWDA3zqZ3H7CzPXvCHWm1T4dzYfyENCJs3s0L
         jKgEFixBUFAQxqqst9CdR2rZqZzyMMUkcER3LS6x1x0fYkMKICQH7N2WHe1eAylR4D1f
         7WkfezGzAyY0Ldybs9eBMS3nhRc3sOtbzQrzKz/qzCxX5Yob3At5SdJSA7XfYNoViBZ9
         KWcQ/vNRfs2Lb7oe4BtBmf+8VTWYsfWHO2FjDDgmNxqKljYjZ7i763L7asd2ne8sryIQ
         DoIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688145747; x=1690737747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=55VlF4SrUJuf+l1F6X+Urs6uXQ0VvjhO9X8SqfAz6ms=;
        b=a89cpKx+zwHVAnIENtCEHMVP3cf0JSJ/BEgVeG6pZDsKUiwWXdpsNgjEzIN2nOcf1U
         vm4ofdi13UL726iHiQPxXcsKCxWf2ocpPFOCFoWozSgXnm4V8Wc334QbkCLb6cg3YLKh
         6T9KmlvpkNBr7xJmpIU97TYY9g+mbdZapm2hLmGseQzHSXAZb5sL+XHpY1hAUxtsjDE9
         DbGhKk+XgLYtq/6hU0n0KJ38j0dyaOG6F/7NapzvxkbAOnLcEshR2ampYaIaM62zPhLG
         RL1PKByOzklwuxxDMj3RwUf208g8wLZITXoVfbRWFN96BMORxcwMGhb413PKWkHwzpqi
         VymQ==
X-Gm-Message-State: ABy/qLZmlxX5sP74NMldGxgSNeMimRKhfogMsQ3cNdKSwzqxe3W3W/6E
        uNN/73k/Zj8wWuRZg2HMrcTzW4okTfNxO9Jub5VJAg==
X-Google-Smtp-Source: APBJJlErNqG9AH5qYKmEMFmq5x6/7lwU4bKXyMx9rshdKQFrFY5VoGbg4W/2v0957vwZftnJjy9/0CKbYTMOml8aw30=
X-Received: by 2002:a05:622a:1194:b0:3f2:1441:3c11 with SMTP id
 m20-20020a05622a119400b003f214413c11mr13001qtk.2.1688145747475; Fri, 30 Jun
 2023 10:22:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230628102949.2598096-1-john.g.garry@oracle.com> <20230628102949.2598096-2-john.g.garry@oracle.com>
In-Reply-To: <20230628102949.2598096-2-john.g.garry@oracle.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 30 Jun 2023 10:22:16 -0700
Message-ID: <CAP-5=fXNFpDGJtESvYy=JF8snPyYrUVZ0m_G3XajXqqS_XLbHg@mail.gmail.com>
Subject: Re: [PATCH RFC 1/9] perf metrics: Delete metricgroup_add_iter_data.table
To:     John Garry <john.g.garry@oracle.com>
Cc:     acme@kernel.org, namhyung@kernel.org, jolsa@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        renyu.zj@linux.alibaba.com, shangxiaojing@huawei.com,
        zhangshaokun@hisilicon.com, qiangqing.zhang@nxp.com,
        kjain@linux.ibm.com, kan.liang@linux.intel.com
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

On Wed, Jun 28, 2023 at 3:30=E2=80=AFAM John Garry <john.g.garry@oracle.com=
> wrote:
>
> Member metricgroup_add_iter_data.table is only used in
> metricgroup__add_metric_sys_event_iter() as the @table arg to the
> add_metric() call there.
>
> However we only use the @table arg in add_metric() for resolving metrics,
> which is currently not relevant to sys event metrics. As such, don't
> bother passing this @table arg and use iter table instead, which is more
> sane.
>
> Signed-off-by: John Garry <john.g.garry@oracle.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/metricgroup.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.=
c
> index a6a5ed44a679..4389ccd29fe7 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -798,7 +798,6 @@ struct metricgroup_add_iter_data {
>         bool system_wide;
>         struct metric *root_metric;
>         const struct visited_metric *visited;
> -       const struct pmu_metrics_table *table;
>  };
>
>  static bool metricgroup__find_metric(const char *pmu,
> @@ -1112,7 +1111,7 @@ static int add_metric(struct list_head *metric_list=
,
>  }
>
>  static int metricgroup__add_metric_sys_event_iter(const struct pmu_metri=
c *pm,
> -                                       const struct pmu_metrics_table *t=
able __maybe_unused,
> +                                       const struct pmu_metrics_table *t=
able,
>                                         void *data)
>  {
>         struct metricgroup_add_iter_data *d =3D data;
> @@ -1123,7 +1122,7 @@ static int metricgroup__add_metric_sys_event_iter(c=
onst struct pmu_metric *pm,
>
>         ret =3D add_metric(d->metric_list, pm, d->modifier, d->metric_no_=
group,
>                          d->metric_no_threshold, d->user_requested_cpu_li=
st,
> -                        d->system_wide, d->root_metric, d->visited, d->t=
able);
> +                        d->system_wide, d->root_metric, d->visited, tabl=
e);
>         if (ret)
>                 goto out;
>
> @@ -1275,7 +1274,6 @@ static int metricgroup__add_metric(const char *pmu,=
 const char *metric_name, con
>                                 .system_wide =3D system_wide,
>                                 .has_match =3D &has_match,
>                                 .ret =3D &ret,
> -                               .table =3D table,
>                         },
>                 };
>
> --
> 2.35.3
>
