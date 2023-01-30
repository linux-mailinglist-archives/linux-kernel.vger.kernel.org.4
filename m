Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE76A681E75
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 23:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjA3Wym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 17:54:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjA3Wyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 17:54:41 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E442414E91
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 14:54:39 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id q10so12651127wrm.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 14:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Cq0lWgBEjX0qF3DV/2EdHUrQ2e84arme4Y1aV0e+f9c=;
        b=WtxfNEVRWpvmZKiAogLe2HHB5eku6sHTI+QZvdEHwZRt1iO8Y2KYCz5tcvDp2zkagb
         wh+hF958L0BNsEIF0xcZrMcYb/N3GKGrHQL+anyDjtAah65JTdcFMxlRJ7VeENJpjaof
         XzjvdQDWH/qkwOFxnwQ/krU4+YETJhOqzK3odnc82mcP9EXPjj1VeVp0jsDL+HIqZBBh
         wNQ1wA53VcgRu0Dr/tN2Un9dQrYjg7zmjnVaC5zUp8jrjkrIHb1XqdMNCGCclY9GQJ+f
         Ajb8IfRFnLGGjfLlabzo8+hWYqPc+JjZ9LPMT44y4mhHjEvzJLpxOLkfgjmgrneEOAbS
         14+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cq0lWgBEjX0qF3DV/2EdHUrQ2e84arme4Y1aV0e+f9c=;
        b=fzESNKx8bGecEdHKNf7awXq7xn0/VzNYK18oIQY8k/NdWQe1zBDtWFz8IkuRMarDVN
         uWVtDBZ24LpQg+2Fu2efNnej59sMCS+iDvAp3urIjoRdXD8anZuDkjJdgrIjuO5eUUws
         haUvGl9EsSZG70FpvDu3DPdmkKXyCltbGDlqCUHTfRyAUESaSWLOgDLLNL4AN6cARohF
         MKwvxKrmKAQ8WCjnGIfqXqWJCD4/99w+y33uoCet4KCpDvLTIexdwQvFha4KvzYLFx/H
         Yi/cwM+3AsRSBPzNzuJMqDOLywy0NRhDoIgoMq8Ubg3vdVW8UY9SJkU2KRaMRljxEnj7
         3N6g==
X-Gm-Message-State: AFqh2kr1MVq7TiXEZOUWO6fsYIx0ffsPx67NPpkivTu0LwZ/g8SI18RY
        siC3wnQb9DhZJZ5TJn1PGpdfenb7RtdLIBVSbNnB0g==
X-Google-Smtp-Source: AMrXdXsGMDasrzf2hGlRQ5Gyl3pCkBVqZo5KlZT5SOTC0w4hUjY2eNPbKNpS+L+cbRAP7+gSqOdwcRcWWjmg+tb1h+I=
X-Received: by 2002:a5d:6b09:0:b0:2bd:e2be:b8b with SMTP id
 v9-20020a5d6b09000000b002bde2be0b8bmr1321886wrw.22.1675119278204; Mon, 30 Jan
 2023 14:54:38 -0800 (PST)
MIME-Version: 1.0
References: <20230126233645.200509-1-irogers@google.com> <20230126233645.200509-11-irogers@google.com>
 <8f53bb96-8213-12f1-f91c-7fb311e4c9a4@oracle.com>
In-Reply-To: <8f53bb96-8213-12f1-f91c-7fb311e4c9a4@oracle.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 30 Jan 2023 14:54:26 -0800
Message-ID: <CAP-5=fUTT1gh0xd-um7NSyg=XuayjWzF90W6Dp4=DOvwyGcmNw@mail.gmail.com>
Subject: Re: [PATCH v5 10/15] perf jevents: Generate metrics and events as
 separate tables
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

On Mon, Jan 30, 2023 at 8:07 AM John Garry <john.g.garry@oracle.com> wrote:
>
> On 26/01/2023 23:36, Ian Rogers wrote:
> > @@ -660,7 +763,29 @@ const struct pmu_events_table *perf_pmu__find_events_table(struct perf_pmu *pmu)
> >
> >   const struct pmu_metrics_table *perf_pmu__find_metrics_table(struct perf_pmu *pmu)
> >   {
> > -        return (struct pmu_metrics_table *)perf_pmu__find_events_table(pmu);
> > +        const struct pmu_metrics_table *table = NULL;
> > +        char *cpuid = perf_pmu__getcpuid(pmu);
> > +        int i;
> > +
> > +        /* on some platforms which uses cpus map, cpuid can be NULL for
> > +         * PMUs other than CORE PMUs.
> > +         */
> > +        if (!cpuid)
> > +                return NULL;
> > +
> > +        i = 0;
> > +        for (;;) {
> > +                const struct pmu_events_map *map = &pmu_events_map[i++];
> > +                if (!map->arch)
> > +                        break;
> > +
> > +                if (!strcmp_cpuid_str(map->cpuid, cpuid)) {
> > +                        table = &map->metric_table;
> > +                        break;
> > +                }
> > +        }
> > +        free(cpuid);
> > +        return table;
> >   }
>
> This is almost identical to generated perf_pmu__find_events_table(),
> except we return a pmu_metrics_table * (instead of a pmu_events_table *)
> and also return the metric table member (instead of event table). But
> the definitions are:
>
> /* Struct used to make the PMU event table implementation opaque to
> callers. */
> struct pmu_events_table {
>          const struct compact_pmu_event *entries;
>          size_t length;
> };
>
> /* Struct used to make the PMU metric table implementation opaque to
> callers. */
> struct pmu_metrics_table {
>          const struct compact_pmu_event *entries;
>          size_t length;
> };
>
> Those structs are defined to be the same thing, so I am failing to see
> the point in a) separate structure types b) why so much duplication
>
> As for b), I know that they are generated and the python code may be
> simpler this way (is it?), but still...

Agreed. The point is to separate the two tables for the typing at the
API layer, internally the representation is the same. When we decode
one we get a pmu_event and the other we get a pmu_metric, so we don't
want to allow the tables to be switched - hence two types.

Thanks,
Ian

> Thanks,
> John
