Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDC1678F93
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 06:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbjAXFEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 00:04:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbjAXFET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 00:04:19 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18AEF1351A
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 21:04:18 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id n7so12719770wrx.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 21:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MPW/FN/QNzolyTaD5K2K+xJ5GnTOu/6mtDOEh2SuJFA=;
        b=lc5SHrgVy8b4JopKaPGVlOweG512m0141P2AhiBimVIlHgoBGoND/tgQA6eUWCk2f/
         AU+HbCibaewktvWHscd6AoH6wNgdFOV1RJBYg7o3kwFtkqmk8pIYB2eu9TYQ4I5xH7GO
         8X8jqlfnb2w3VE4ePxPBcv14UNPZhNtc7v/5prVG8MlrcqhNp3zqDfifqwKl8Ic6FN6m
         JD1L8BZEygFHMntqznR5PHW3yNllLeHC0MBjTXUTrG2pyz82FF8LrAA+ptJkTaMMeptS
         tFrGGfyzdWFw36TIDPtezk6skcLh29+OxWdCjLtI9n1yu8wpO9xMehJUjBV9vgII9qha
         Y8UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MPW/FN/QNzolyTaD5K2K+xJ5GnTOu/6mtDOEh2SuJFA=;
        b=uieZYu2ZBpb8AdXOO1+erVhQNadqNnBw4QmmBoajBBxMCmDXxMg4uRKlrj/iz+5Lbn
         C+rn2jMVqLOSRzwzianZjf8gZWnRL/QPu6A9ww4vjlYFpQOsRcGqX6s1w+i1rTfWuiDd
         qntNIWC8cboFkUEnHFo5ec5w7EIUzsZOp2G33AAfROJWdHA0ATGufkJUlqUg1pyzI+Cc
         BxHmSsGaYdUqeYRghE04jlyDzX6s9MkaZwAqVJLB1dL8wKojn9zx/fbnlPxL0Tti1Im3
         j2/rVBjNspfZqnNVspA2BkH10tTJ3gd1gTaboXY2PsM0rAyHbNNDzQ43xiFzsaFEYLtS
         fW2g==
X-Gm-Message-State: AFqh2ko2x3HMO1GtWo99/zGwAqtnQPQMpjnfoYb0laobFSNdEn2sEqfC
        1Csgi17PmmacOCY7JZteyKgLfAjqwIe0lpZcNYwPVA==
X-Google-Smtp-Source: AMrXdXvxW0m43ndtyjmoynoye2l6QBRZHFCBVgN+uN25iiw7EBLcLX594j8CM6tWmBIpxBgFbhzGCa99xuzZ5EAuMNk=
X-Received: by 2002:a05:6000:5c6:b0:242:5caa:5fbf with SMTP id
 bh6-20020a05600005c600b002425caa5fbfmr593320wrb.300.1674536656472; Mon, 23
 Jan 2023 21:04:16 -0800 (PST)
MIME-Version: 1.0
References: <20221221223420.2157113-1-irogers@google.com> <791915a9-0c2b-796a-b788-f026e071859b@oracle.com>
In-Reply-To: <791915a9-0c2b-796a-b788-f026e071859b@oracle.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 23 Jan 2023 21:04:04 -0800
Message-ID: <CAP-5=fWayi710LAUDe=o6JW57BCnu=WcwCHOrDzdW3fvOPmgPg@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] jevents/pmu-events improvements
To:     John Garry <john.g.garry@oracle.com>
Cc:     Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Kang Minchul <tegongkang@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sandipan Das <sandipan.das@amd.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        linuxppc-dev@lists.ozlabs.org, Kajol Jain <kjain@linux.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>
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

On Mon, Jan 23, 2023 at 5:26 AM John Garry <john.g.garry@oracle.com> wrote:
>
> On 21/12/2022 22:34, Ian Rogers wrote:
> > Add an optimization to jevents using the metric code, rewrite metrics
> > in terms of each other in order to minimize size and improve
> > readability. For example, on Power8
> > other_stall_cpi is rewritten from:
> > "PM_CMPLU_STALL / PM_RUN_INST_CMPL - PM_CMPLU_STALL_BRU_CRU / PM_RUN_IN=
ST_CMPL - PM_CMPLU_STALL_FXU / PM_RUN_INST_CMPL - PM_CMPLU_STALL_VSU / PM_R=
UN_INST_CMPL - PM_CMPLU_STALL_LSU / PM_RUN_INST_CMPL - PM_CMPLU_STALL_NTCG_=
FLUSH / PM_RUN_INST_CMPL - PM_CMPLU_STALL_NO_NTF / PM_RUN_INST_CMPL"
> > to:
> > "stall_cpi - bru_cru_stall_cpi - fxu_stall_cpi - vsu_stall_cpi - lsu_st=
all_cpi - ntcg_flush_cpi - no_ntf_stall_cpi"
> > Which more closely matches the definition on Power9.
> >
> > A limitation of the substitutions are that they depend on strict
> > equality and the shape of the tree. This means that for "a + b + c"
> > then a substitution of "a + b" will succeed while "b + c" will fail
> > (the LHS for "+ c" is "a + b" not just "b").
> >
> > Separate out the events and metrics in the pmu-events tables saving
> > 14.8% in the table size while making it that metrics no longer need to
> > iterate over all events and vice versa. These changes remove evsel's
> > direct metric support as the pmu_event no longer has a metric to
> > populate it. This is a minor issue as the code wasn't working
> > properly, metrics for this are rare and can still be properly ran
> > using '-M'.
> >
> > Add an ability to just build certain models into the jevents generated
> > pmu-metrics.c code. This functionality is appropriate for operating
> > systems like ChromeOS, that aim to minimize binary size and know all
> > the target CPU models.
>
>  From a glance, this does not look like it would work for arm64. As I
> see in the code, we check the model in the arch folder for the test to
> see if built. For arm64, as it uses arch/implementator/model folder org,
> and not just arch/model (like x86)
>
> So on the assumption that it does not work for arm64 (or just any arch
> which uses arch/implementator/model folder org), it would be nice to
> have that feature also. Or maybe also support not just specifying model
> but also implementator.

Hmm.. this is tricky as x86 isn't following the implementor pattern. I
will tweak the comment for the ARM64 case where --model will select an
implementor.

> >
> > v2. Rebase. Modify the code that skips rewriting a metric with the
> >      same name with itself, to make the name check case insensitive.
> >
>
>
> Unfortunately you might need another rebase as this does not apply to
> acme perf/core (if that is what you want), now for me at:
>
> 5670ebf54bd2 (HEAD, origin/tmp.perf/core, origin/perf/core, perf/core)
> perf cs-etm: Ensure that Coresight timestamps don't go backwards

Will do, thanks!
Ian

> > Ian Rogers (9):
> >    perf jevents metric: Correct Function equality
> >    perf jevents metric: Add ability to rewrite metrics in terms of othe=
rs
> >    perf jevents: Rewrite metrics in the same file with each other
> >    perf pmu-events: Separate metric out of pmu_event
> >    perf stat: Remove evsel metric_name/expr
> >    perf jevents: Combine table prefix and suffix writing
> >    perf pmu-events: Introduce pmu_metrics_table
> >    perf jevents: Generate metrics and events as separate tables
> >    perf jevents: Add model list option
>
> Thanks,
> John
