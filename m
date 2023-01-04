Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAD965DADD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 17:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240004AbjADQ7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 11:59:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240041AbjADQ6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 11:58:45 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA1A233
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 08:57:57 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id co23so33685996wrb.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 08:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k91mM6eWnf0dd1LnPM3zDSuwYYfauVcjH0pWnPUqxOY=;
        b=krUebikftOdvGon0k4FeTfEWr5xVaVlv94hSAS6E8vkMpOtm3nANaAqNU4Jw/rlH0u
         efCjBWKN8uAaTXZkifpPMO3X2KpzMDUXlRENyBV2Wjp/WD/dSohmuoXpg8qHkkBMBRDU
         DacQx14Xw2HJRCaMUsSTDZe2bB1F1RVox2B2OQ0ynIpxN7AwXm6oZ2nb1CJG9qDD6tQd
         waavdHlzLHGQ8HzDpEfjbLh2iClolFubOcqlnsCzEbCUmsdFaazXVMmppjvKmaeBI9CI
         bWkPcsGpX+2nG6fJd/p8V24TuPy0Q8I+SPsRHXIh+36NKiKno9jubTqYLiy6kYfWfBDp
         0hAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k91mM6eWnf0dd1LnPM3zDSuwYYfauVcjH0pWnPUqxOY=;
        b=zMUh6RTUOLbNvB1Pjkdci7MRNoausBTKXTpcq/3+cjQApoTUJbkDgTv+dCg6PiQeSg
         iztf2eCcG745nOOPt4bGGryw14ZM8TH50ts1SADEbugPwQsREnLb9zpIH6Ofj2Qi7VbP
         vtFafIX3F/YjeYI3WD0liYOMX7fsUJBiM+6AaOnujneBxe4x8ySqyrxmdsyYIU41K6UA
         M73bL+d9LRmwC3TVx10vq9WHScpL1WuEMGAVPhpGMZgoVYHDLDsh+zEfCFfm1yXnFTil
         xVON7SJxYetChOK4r98pl6gWbWM3+IC299uAC1IvrUXrs0GpR94eoXohznWHWcYwnclu
         mIFg==
X-Gm-Message-State: AFqh2komo/BiNMqBtA0WnSMxX9cZyl04lVpUyuyUdcdv1ug5Uh0c16aN
        qHdgLQ+QgCD4iBLDwZ4Ouv+neemLq+z3dW4caa1iFg==
X-Google-Smtp-Source: AMrXdXuPu9U+xSkrBJsX8cO658/rOJiFXURF7i2HTWaNuJi1PLcxtsrdWQx/Dx5q8H1O9l0JNGd0iI5SXsjK/TjDNYw=
X-Received: by 2002:a05:6000:12cb:b0:28c:459a:d5d with SMTP id
 l11-20020a05600012cb00b0028c459a0d5dmr762582wrx.654.1672851476109; Wed, 04
 Jan 2023 08:57:56 -0800 (PST)
MIME-Version: 1.0
References: <1672745976-2800146-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1672745976-2800146-3-git-send-email-renyu.zj@linux.alibaba.com>
 <CAP-5=fVP_=FcEQChQwVpis9iyZsdb6NrVJQUo4GJA4_j=knfcA@mail.gmail.com>
 <14a2ca08-e946-f319-e2a8-f5f91e1eb8e6@linux.alibaba.com> <d90c35db-c801-02ba-d9ea-148324a1de13@linux.alibaba.com>
In-Reply-To: <d90c35db-c801-02ba-d9ea-148324a1de13@linux.alibaba.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 4 Jan 2023 08:57:44 -0800
Message-ID: <CAP-5=fUVU2+bAyzU+ZKYAdw_G5u0eMRq4Cyw_CVKd3UsG2U_Bw@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] perf vendor events arm64: Add TLB metrics for neoverse-n2
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

On Wed, Jan 4, 2023 at 12:40 AM Jing Zhang <renyu.zj@linux.alibaba.com> wro=
te:
>
>
>
> =E5=9C=A8 2023/1/4 =E4=B8=8B=E5=8D=881:21, Jing Zhang =E5=86=99=E9=81=93:
> >
> >
> > =E5=9C=A8 2023/1/4 =E4=B8=8A=E5=8D=881:14, Ian Rogers =E5=86=99=E9=81=
=93:
> >> On Tue, Jan 3, 2023 at 3:39 AM Jing Zhang <renyu.zj@linux.alibaba.com>=
 wrote:
> >>>
> >>> Add TLB related metrics.
> >>>
> >>> Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
> >>> Acked-by: Ian Rogers <irogers@google.com>
> >>> ---
> >>>  .../arch/arm64/arm/neoverse-n2/metrics.json        | 49 ++++++++++++=
++++++++++
> >>>  1 file changed, 49 insertions(+)
> >>>
> >>> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics=
.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json
> >>> index c126f1bc..8a74e07 100644
> >>> --- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json
> >>> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json
> >>> @@ -26,5 +26,54 @@
> >>>          "MetricGroup": "TopdownL1",
> >>>          "MetricName": "backend_bound",
> >>>          "ScaleUnit": "100%"
> >>> +    },
> >>> +    {
> >>> +        "MetricExpr": "L1D_TLB_REFILL / L1D_TLB",
> >>> +        "BriefDescription": "The rate of L1D TLB refill to the overa=
ll L1D TLB lookups",
> >>> +        "MetricGroup": "TLB",
> >>> +        "MetricName": "l1d_tlb_miss_rate",
> >>> +        "ScaleUnit": "100%"
> >>> +    },
> >>> +    {
> >>> +        "MetricExpr": "L1I_TLB_REFILL / L1I_TLB",
> >>> +        "BriefDescription": "The rate of L1I TLB refill to the overa=
ll L1I TLB lookups",
> >>> +        "MetricGroup": "TLB",
> >>> +        "MetricName": "l1i_tlb_miss_rate",
> >>> +        "ScaleUnit": "100%"
> >>> +    },
> >>> +    {
> >>> +        "MetricExpr": "L2D_TLB_REFILL / L2D_TLB",
> >>> +        "BriefDescription": "The rate of L2D TLB refill to the overa=
ll L2D TLB lookups",
> >>> +        "MetricGroup": "TLB",
> >>> +        "MetricName": "l2_tlb_miss_rate",
> >>> +        "ScaleUnit": "100%"
> >>> +    },
> >>> +    {
> >>> +        "MetricExpr": "DTLB_WALK / INST_RETIRED * 1000",
> >>> +        "BriefDescription": "The rate of TLB Walks per kilo instruct=
ions for data accesses",
> >>> +        "MetricGroup": "TLB",
> >>> +        "MetricName": "dtlb_mpki",
> >>> +        "ScaleUnit": "MPKI"
> >>> +    },
> >>> +    {
> >>> +        "MetricExpr": "DTLB_WALK / L1D_TLB",
> >>> +        "BriefDescription": "The rate of DTLB Walks to the overall L=
1D TLB lookups",
> >>> +        "MetricGroup": "TLB",
> >>> +        "MetricName": "dtlb_walk_rate",
> >>> +        "ScaleUnit": "100%"
> >>> +    },
> >>> +    {
> >>> +        "MetricExpr": "ITLB_WALK / INST_RETIRED * 1000",
> >>> +        "BriefDescription": "The rate of TLB Walks per kilo instruct=
ions for instruction accesses",
> >>> +        "MetricGroup": "TLB",
> >>> +        "MetricName": "itlb_mpki",
> >>> +        "ScaleUnit": "MPKI"
> >>
> >> Did you test this? IIRC if there is no number in the ScaleUnit then
> >> the scale factor becomes 0 and the metric value is always multiplied
> >> by zero. Perhaps:
> >>
> >> "MetricName": "itlb_miss_rate",
> >> "MetricExpr": "ITLB / INST_RETIRED"
> >> "ScaleUnit": "1000MPKI"
> >>
> >> Thanks,
> >> Ian
> >>
> >
> > You are absolutely right, I only tested TLB metrics. Sorry for not doub=
le checking. I will repost the corrected patches.
> >
>
> I rethought it. I want to change the ScaleUnit to "1MPKI" and keep the Me=
tricExpr multiplied by 1000,
> so that the "MetricExpr" expresses the value of per kilo instruciton, whi=
ch can be consistent with the
> description in "BriefDescription". Like:
>    {
>         "MetricExpr": "DTLB_WALK / INST_RETIRED * 1000",
>         "BriefDescription": "The rate of TLB Walks per kilo instructions =
for data accesses",
>         "MetricGroup": "TLB",
>         "MetricName": "dtlb_mpki",
>         "ScaleUnit": "1MPKI"
>     },
>
>
> In addition, I think it is more reasonable for ScaleUnit to have a defaul=
t scale factor of 1 when there
> is no number. I want to try to fix this bug.
>
> Ian, what's your opnion?

I like intention revealing, itlb_mpki is something of a soup of
characters to de-acronym-ify compared to itlb_miss_rate, but rate may
not be completely intuitive in that name. I'm happy to follow your
lead. Putting the 1000 in the ScaleUnit or the expression doesn't
matter, so again happy to follow what you think is best.

Thanks,
Ian

> >>> +    },
> >>> +    {
> >>> +        "MetricExpr": "ITLB_WALK / L1I_TLB",
> >>> +        "BriefDescription": "The rate of ITLB Walks to the overall L=
1I TLB lookups",
> >>> +        "MetricGroup": "TLB",
> >>> +        "MetricName": "itlb_walk_rate",
> >>> +        "ScaleUnit": "100%"
> >>>      }
> >>>  ]
> >>> --
> >>> 1.8.3.1
> >>>
