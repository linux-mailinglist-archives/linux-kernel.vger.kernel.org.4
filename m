Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71A3E74193D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 22:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbjF1UFh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 28 Jun 2023 16:05:37 -0400
Received: from mail-yb1-f172.google.com ([209.85.219.172]:59665 "EHLO
        mail-yb1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbjF1UFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 16:05:30 -0400
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-bd0a359ca35so121688276.3;
        Wed, 28 Jun 2023 13:05:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687982729; x=1690574729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wTmpyVSMLrIk0QN7D+5i/fdXLo6g3GMR/467HY8B59c=;
        b=T4Hff1Fk03Bp3B0AkaOi9eYnl8ayYRfBGZKFg1Ly4lQqfCyzc/OpWg8Ebgcxzcr7j+
         lfX7ZRm0gTTHOGj5kpVhpsWYeSGcmRRNGgKilxwUV2nqcGb0BHUUWnffIVAh4+7eKP1q
         s/gPMj2dAImgVPOu1Wme21eTIGI8gW4TPSFKxy2mt+ZUNfOV9VYj50cV2iAolb9vsDFU
         UNj72J1Iw2aybP0QL0Zvp20xVGXdwV/UTzXyD2+PeBzzcxHlDpqC8SmMIoEao/V8gRFF
         wr3HEOSws1oAOHwT43sxrLk4SR5hNXQwuIZEYWLzeQelntL0UhyqBqyHz6dirHnx5TZR
         pahw==
X-Gm-Message-State: AC+VfDzzBtgNbdcyduYDB0Q5Tu8nS9SmNiNRJxeRYoZRzC6Rjp1Hecd0
        G53xrdzjPL1k4EjaJcHGIHbSA279r8A8DHkwudo=
X-Google-Smtp-Source: ACHHUZ6fxZywp+3+CMdiM7w2ojgSM3x9Sg3C3EXjRVMYsP0lSj8tSCwOXRQhKihLvaqxFyn+DYxAxK2OKmy1IH+nygE=
X-Received: by 2002:a25:cf91:0:b0:c14:3d56:bf65 with SMTP id
 f139-20020a25cf91000000b00c143d56bf65mr9889094ybg.4.1687982729154; Wed, 28
 Jun 2023 13:05:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230627182834.117565-1-irogers@google.com> <344a8de1-469d-a8f9-100e-9a67e562939b@huawei.com>
In-Reply-To: <344a8de1-469d-a8f9-100e-9a67e562939b@huawei.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 28 Jun 2023 13:05:17 -0700
Message-ID: <CAM9d7chik56jZqKSUJqdvwTG9gPRVcChPdUnTi-NcCRozrb9nQ@mail.gmail.com>
Subject: Re: [PATCH v1] perf pmus: Add placeholder core PMU
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Rob Herring <robh@kernel.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 8:01 PM Yang Jihong <yangjihong1@huawei.com> wrote:
>
> Hello,
>
> On 2023/6/28 2:28, Ian Rogers wrote:
> > If loading a core PMU fails, legacy hardware/cache events may segv due
> > to there being no PMU. Create a placeholder empty PMU for this
> > case. This was discussed in:
> > https://lore.kernel.org/lkml/20230614151625.2077-1-yangjihong1@huawei.com/
> >
> > Reported-by: Yang Jihong <yangjihong1@huawei.com>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >   tools/perf/util/pmu.c  | 25 +++++++++++++++++++++++++
> >   tools/perf/util/pmu.h  |  1 +
> >   tools/perf/util/pmus.c |  7 ++++++-
> >   3 files changed, 32 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> > index 8d5ecd4ff1a9..7f984a7f16ca 100644
> > --- a/tools/perf/util/pmu.c
> > +++ b/tools/perf/util/pmu.c
> > @@ -928,6 +928,31 @@ struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char
> >       return NULL;
> >   }
> >
> > +/* Creates the PMU when sysfs scanning fails. */
> > +struct perf_pmu *perf_pmu__create_placeholder_core_pmu(struct list_head *core_pmus)
> > +{
> > +     struct perf_pmu *pmu = zalloc(sizeof(*pmu));
> > +
> > +     if (!pmu)
> > +             return NULL;
> > +
> > +     pmu->name = strdup("cpu");
> > +     if (!pmu->name) {
> > +             free(pmu);
> > +             return NULL;
> > +     }
> > +
> > +     pmu->is_core = true;
> > +     pmu->type = PERF_TYPE_RAW;
> > +     pmu->cpus = cpu_map__online();
> > +
> > +     INIT_LIST_HEAD(&pmu->format);
> > +     INIT_LIST_HEAD(&pmu->aliases);
> > +     INIT_LIST_HEAD(&pmu->caps);
> > +     list_add_tail(&pmu->list, core_pmus);
> > +     return pmu;
> > +}
> > +
> >   void perf_pmu__warn_invalid_formats(struct perf_pmu *pmu)
> >   {
> >       struct perf_pmu_format *format;
> > diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> > index 8807a624e918..203b92860e3c 100644
> > --- a/tools/perf/util/pmu.h
> > +++ b/tools/perf/util/pmu.h
> > @@ -286,6 +286,7 @@ int perf_pmu__event_source_devices_fd(void);
> >   int perf_pmu__pathname_fd(int dirfd, const char *pmu_name, const char *filename, int flags);
> >
> >   struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char *lookup_name);
> > +struct perf_pmu *perf_pmu__create_placeholder_core_pmu(struct list_head *core_pmus);
> >   void perf_pmu__delete(struct perf_pmu *pmu);
> >
> >   #endif /* __PMU_H */
> > diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> > index 0866dee3fc62..3cd9de42139e 100644
> > --- a/tools/perf/util/pmus.c
> > +++ b/tools/perf/util/pmus.c
> > @@ -153,7 +153,12 @@ static void pmu_read_sysfs(bool core_only)
> >
> >       closedir(dir);
> >       if (core_only) {
> > -             read_sysfs_core_pmus = true;
> > +             if (!list_empty(&core_pmus))
> > +                     read_sysfs_core_pmus = true;
> > +             else {
> > +                     if (perf_pmu__create_placeholder_core_pmu(&core_pmus))
> > +                             read_sysfs_core_pmus = true;
> > +             }
> >       } else {
> >               read_sysfs_core_pmus = true;
> >               read_sysfs_all_pmus = true;
> >
> Great. This patch solves the problem, the test results are shown in [1].
>
> Tested-by: Yang Jihong <yangjihong1@huawei.com>

Applied to perf-tools-next, thanks!
