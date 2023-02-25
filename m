Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED18C6A2765
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 06:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjBYFrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 00:47:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBYFri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 00:47:38 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D5E671C0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 21:47:36 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id 6so1237659wrb.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 21:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LiST8596u5SW2OT95mO4vwyxbo+eN0yAsaEYN7M3IJc=;
        b=p1goS1GxDpHe69NI5SRLq8F4rfieQ+bExX2nozq4F4kWhGFIEqxvgFQ9gmMLOeq7Od
         Zf38tlyAYp5g3DPIE6RBTOXQf9Q/jFjI8AcsXycD7zs0kij6ZvJslExLb5lLfBwVsePr
         MbOdyfxJz65BgV557DZiHpcgDMSZgQysKIyLJ1+MFpBAeyIznQRgI+pPwKRqNw9SX3/9
         FzHixX0BXXZ2FNKGIqLE1CRGu+AMELTOrJqAZZF0M7fflx9eGDdLKaiiKc657gwqFdK4
         oEb6Is/wm4HCNHkLfV6TEnme0uFORY8idWB9xLe2soxHasGEHz1+3YJZHPYjVfxPxhbe
         PRUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LiST8596u5SW2OT95mO4vwyxbo+eN0yAsaEYN7M3IJc=;
        b=ljbam6R2jmg9iJaQ8dA93o1ovWCjHbs4eV15zE8o4lf8C1OVtVfjRjVztvVf1Rwikj
         jRZzN7Bd61NVtdH3EPVl3CAuaxJe8Qmb4Z5aJKOJ8vFPqbrFJSLKx0JqOtUhpFpMve4N
         3Q0oO6ROHWJoCBGsL0MLNehtHQrZOf7TvZeKHfn9NtYsPgInDvZsdiSk6u7zh+1tk2in
         HBvNwD0PNyFkqxZ6P8pPpZbrCalbj6JgC7nzMS8jbILPsuCIYK+j7C8HdJVEhPXghk87
         PdAVPwXELFpvWMr46zdv5wE7HtW4fMEMWSuXICEy4WB5sysg6GpLg4P8+uHCnsx/eOAe
         5/MA==
X-Gm-Message-State: AO0yUKXh7VM3QBT0qFHgUnXZfsKdb4Fhr0AFysTIkzT3uv8Xph3u8n0Q
        Yll1Y+lvD3TouHraUq7ic6HG3Olfdm3O4j5evLsZeQ==
X-Google-Smtp-Source: AK7set+a3nC9KQjdJ0kZohZ+u36oNsTS7RmKWeZajLQ2c7xaDgResXUAlsshR4qweCkPqQiFGEpAV7XuUVi2FhFLwNU=
X-Received: by 2002:a5d:6401:0:b0:2c5:fd95:c495 with SMTP id
 z1-20020a5d6401000000b002c5fd95c495mr1623328wru.4.1677304055182; Fri, 24 Feb
 2023 21:47:35 -0800 (PST)
MIME-Version: 1.0
References: <20230219092848.639226-1-irogers@google.com> <20230219092848.639226-51-irogers@google.com>
 <Y/k+p8IPY/ftl3KQ@google.com>
In-Reply-To: <Y/k+p8IPY/ftl3KQ@google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 24 Feb 2023 21:47:22 -0800
Message-ID: <CAP-5=fWtziP7HzXKZHKxZdQuQ=sTEyNVKNkPVnhYNF-BcX8eKw@mail.gmail.com>
Subject: Re: [PATCH v1 50/51] perf stat: Use counts rather than saved_value
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        James Clark <james.clark@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.g.garry@oracle.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Florian Fischer <florian.fischer@muhq.space>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Sean Christopherson <seanjc@google.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Stephane Eranian <eranian@google.com>
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

On Fri, Feb 24, 2023 at 2:48=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Sun, Feb 19, 2023 at 01:28:47AM -0800, Ian Rogers wrote:
> > Switch the hard coded metrics to use the aggregate value rather than
> > from saved_value. When computing a metric like IPC the aggregate count
> > comes from instructions then cycles is looked up and if present IPC
> > computed. Rather than lookup from the saved_value rbtree, search the
> > counter's evlist for the desired counter.
> >
> > A new helper evsel__stat_type is used to both quickly find a metric
> > function and to identify when a counter is the one being sought. So
> > that both total and miss counts can be sought, the stat_type enum is
> > expanded. The ratio functions are rewritten to share a common helper
> > with the ratios being directly passed rather than computed from an
> > enum value.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> [SNIP]
> > -static double runtime_stat_avg(enum stat_type type, int aggr_idx,
> > -                            struct runtime_stat_data *rsd)
> > +static double find_stat(const struct evsel *evsel, int aggr_idx, enum =
stat_type type)
> >  {
> > -     struct saved_value *v;
> > -
> > -     v =3D saved_value_lookup(NULL, aggr_idx, false, type, rsd->ctx, r=
sd->cgrp);
> > -     if (!v)
> > -             return 0.0;
> > -
> > -     return avg_stats(&v->stats);
> > +     const struct evsel *cur;
> > +     int evsel_ctx =3D evsel_context(evsel);
> > +
> > +     evlist__for_each_entry(evsel->evlist, cur) {
> > +             struct perf_stat_aggr *aggr;
> > +
> > +             /* Ignore the evsel that is being searched from. */
> > +             if (evsel =3D=3D cur)
> > +                     continue;
> > +
> > +             /* Ignore evsels that are part of different groups. */
> > +             if (evsel->core.leader->nr_members &&
> > +                 evsel->core.leader !=3D cur->core.leader)
>
> The evsel->nr_members is somewhat confusing in that it counts itself
> as a member.  I'm not sure it resets the nr_members to 0 for standalone
> events.  You'd better checking nr_members greater than 1 for group
> events.

Agreed. The code is correct as the nr_members is only set when the
group is closed by the call to parse_events_set_leader, standalone
events don't close a group and so have nr_members of 0, but I agree
that's confusing.

I'm actually looking at a related bug where telling metrics not to
group events breaks the topdown events that must be grouped with
slots.

One thing that bugs me is the libperf evsel idx variable. When an
evsel is added to an evlist the idx is that number of elements in the
evlist. However, we reorganize the list in parse-events and so the idx
is just a hopefully unique value in the list. In places in parse
events we use the idx for computing the length of the evlist by
subtracting the last idx from the first and adding 1. Removing the idx
isn't straightforward though as later on it is used for mmaps.

Thanks,
Ian

> Thanks,
> Namhyung
>
>
> > +                     continue;
> > +             /* Ignore evsels with mismatched modifiers. */
> > +             if (evsel_ctx !=3D evsel_context(cur))
> > +                     continue;
> > +             /* Ignore if not the cgroup we're looking for. */
> > +             if (evsel->cgrp !=3D cur->cgrp)
> > +                     continue;
> > +             /* Ignore if not the stat we're looking for. */
> > +             if (type !=3D evsel__stat_type(cur))
> > +                     continue;
> > +
> > +             aggr =3D &cur->stats->aggr[aggr_idx];
> > +             if (type =3D=3D STAT_NSECS)
> > +                     return aggr->counts.val;
> > +             return aggr->counts.val * cur->scale;
> > +     }
> > +     return 0.0;
> >  }
