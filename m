Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D08686CAB10
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 18:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232609AbjC0QwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 12:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbjC0QwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 12:52:08 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D7E4EFD
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 09:51:49 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-3e392e10cc4so762851cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 09:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679935903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G96YuHfNOixQOenDOjw+vw59nqvCVp4eZ2HJnETyrKc=;
        b=cVGHWdwqfEkneKgtudrjbNGsEzADfbEvXHWqAAx79dx2qKsfAP/IyzzqWgWtGn2gBV
         ILG7Eg+8PthAMvYprdbPqpKFTFEQBCu5B17F2PQ5cSnqrV6xUe+76UjbI3FbhfNKqosW
         98dX0lM+nZ/7AXDnsjEkzSBp4MHMNhoaQ/a6Vt98XjcwYCC6EIwGxbszYQR61Hopo1wI
         AAXXTBLhz3UndEl3VL6KZyZW06hAAx4U7B2lAcgJ25ZOY6CrVYRkv1Q5hthMyKqUHrRx
         fSpy+YfwVicXOh6cGSZQjFdX9myoQ8GThtyHCaChkORSE+6WSJf7oRms6my6+6shLzM1
         L34w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679935903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G96YuHfNOixQOenDOjw+vw59nqvCVp4eZ2HJnETyrKc=;
        b=EP53JBDekYlQwdEqM5a7jYBQlQLfOCnqaZDUTyzZNDyD1RZXoJ80ns4EshZNbOk9KV
         hQqLoaqAMIEYtWyVa/ICiO8bM/oyahBkBsa4aqEZ7RLTdxr7jZ+mEFw1owFfTFeQFnZF
         5I+yqv4E0i1OC6ZFa7sbwghbS4YglcnPtAkBHlLMqSmPKka0rPk2nl3y4q5pAiZcXE9c
         7hGs+cS7q1g5vVgoDerzwkiFHI34gndgVQmiSX/UIGcOdrLfEcSO7Dg3qprX+IJwIE8F
         WwFQgLofJbriKaOPjyuAgZWwyX1j+XnVo09m9VT8aqRkPkSyGd+IoUB+R5WYSVIF6qRf
         8buQ==
X-Gm-Message-State: AAQBX9f9aFCzG8ExxUyxS1gN6XkaDqrN0bgm0aiEbzUYBOIv2kfGFOs+
        nPu9HPCeV6DEsPs3o9jl06Xi/QytNehedX+1WdTmkQ==
X-Google-Smtp-Source: AKy350YFx7+Gb2GSAOSS4DCpVaJhpKird5zpu0naUCTffltRu3HaqJtagKWVFth5kFZsFyzmtvzoQnvwdnpqHv8ys+k=
X-Received: by 2002:a05:622a:1820:b0:3d3:fd80:b06a with SMTP id
 t32-20020a05622a182000b003d3fd80b06amr518172qtc.13.1679935902975; Mon, 27 Mar
 2023 09:51:42 -0700 (PDT)
MIME-Version: 1.0
References: <1679885172-95021-1-git-send-email-renyu.zj@linux.alibaba.com>
In-Reply-To: <1679885172-95021-1-git-send-email-renyu.zj@linux.alibaba.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 27 Mar 2023 09:51:31 -0700
Message-ID: <CAP-5=fVitwxZwjkv0F98gHiYV9GBvmPq6LgcLTccQbogKmMhPA@mail.gmail.com>
Subject: Re: [PATCH RFC 0/4] Add JSON metrics for arm CMN and Yitian710 DDR
To:     Jing Zhang <renyu.zj@linux.alibaba.com>
Cc:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Zhuo Song <zhuo.song@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 26, 2023 at 7:46=E2=80=AFPM Jing Zhang <renyu.zj@linux.alibaba.=
com> wrote:
>
> Hi all,
>
> I add an identifier sysfs file for the yitian710 SoC DDR and arm CMN to
> allow userspace to identify the specific implementation of the device,
> so that the perf tool can match the corresponding uncore events and
> metrics through the identifier. Then added several general CMN700 metrics
> and yitian710 soc DDR metrics.

Thanks!

> Since the eventid of cmn700 events is different from other events, it
> can't be specified by "EventCode" or "ConfigCode", so in the cmn.json
> file of cmn700, no "EventCode" and "ConfigCode" are added for these
> events. For example, the eventid of "arm_cmn_0/hnf_sf_hit is/":
> cat /sys/bus/event_source/devices/arm_cmn_0/events/hnf_sf_hit
> type=3D0x5,eventid=3D0x6

This is done to add descriptions to the events? We can add encodings
to jevents.py and the event parsing to handle the names eventid and
type.

> In addition, both cmn700 and ddr PMU can count the information in a die,
> but the same SoC can also be configured with different numbers of dies,
> so it is dificult to design a general expression to obtain metrics in
> different dies. The current yitian710 ddr bandwidth metric describes the
> sum of all dies bandwidth. I would like to ask you, is there any general
> expression can obtain metrics for die? Add an option to specify die?

So hopefully the logic for this is getting clearer in the
perf-tools-next branch. When perf stat runs it will aggregate in a
number of different ways, if you pass -A it will remove the
aggregation, but you can also use --per-socket, per-die, .. The
metrics take the individual counter values, say instructions and
cycles and produce a metric like IPC. By default all the instruction
counts are aggregated together, the cycles are aggregated together and
then the metric produced on the two aggregated values. When -A or
--per-die are passed, the appropriate amount of aggregation should be
done then the metric computed multiple times.

Are you asking for a way in a metric to take counts from one die and
use them in the other's metric? For example, reads on one die are
writes on the other? This is possible as we have all the counts in the
tool. I've thought about this in the context of some metrics we have
for AMD, but there is no support for this in the tool currently.

Thanks,
Ian

> Thanks,
> Jing
>
> Jing Zhang (4):
>   driver/perf: Add identifier sysfs file for CMN
>   perf vendor events: Add JSON metrics for cmn700
>   driver/perf: Add identifier sysfs file for Yitian 710 DDR
>   perf vendor events: Add JSON metrics for Yitian 710 DDR
>
>  drivers/perf/alibaba_uncore_drw_pmu.c              |  27 ++
>  drivers/perf/arm-cmn.c                             |  43 +++
>  .../pmu-events/arch/arm64/arm/cmn700/sys/cmn.json  | 188 +++++++++++
>  .../arch/arm64/arm/cmn700/sys/metrics.json         |  74 ++++
>  .../arm64/freescale/yitian710/sys/ali_drw.json     | 373 +++++++++++++++=
++++++
>  .../arm64/freescale/yitian710/sys/metrics.json     |  20 ++
>  tools/perf/pmu-events/jevents.py                   |   2 +
>  7 files changed, 727 insertions(+)
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cmn700/sys/cmn.j=
son
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cmn700/sys/metri=
cs.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/yitian710/=
sys/ali_drw.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/yitian710/=
sys/metrics.json
>
> --
> 1.8.3.1
>
