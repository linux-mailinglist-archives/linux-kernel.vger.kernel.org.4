Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED5A66B70B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 06:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbjAPF7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 00:59:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbjAPF7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 00:59:35 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFB4AA
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 21:59:33 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 4-20020a05600c26c400b003dafecbf23dso367228wmv.4
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 21:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7RXg7WNe0og6jQO+ZvaAlKQhUIoBHqp8w3emhYUKE+I=;
        b=LU8x6zH8563jKv+w6kvKIXuPWuyFOIZPXo06kNvymITJWTNAyt3LH/DIr05qmIioLJ
         XBaUotyfP1kjn5sOhejlZ2g/COLZ6G3Qpd/n/ZkmwTCHCGJpIW8bZtVjuqLDecBwRbqd
         pAshhwnnudtPxJMHHLZ8jO3NoL7HoSthj2pcPHr46ufcPSUuEE64sCzh7S+5csyvr0m6
         NEo7RFtUDuUucuHyjkU4mh332K/JjXN4nMGC6c1DJO0rNwjtE3RGjvJYpU3IYAniRMbQ
         w0ktIHK2CqwrmTZWIX6PzK1ypt/EFfSryYLgCAB7M31i6F4ehNAJkQxOesWulvJue7ca
         oRqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7RXg7WNe0og6jQO+ZvaAlKQhUIoBHqp8w3emhYUKE+I=;
        b=gb7vkXk4GRvw4zJO1WfZ5SlVmWG/VRNFEv3Hp5yKRl+B1ZlRpRxCY79IE1M5rCzHT9
         XTl9PiNjgoGPIiA5LhqYi8kRG+8zHmmBT04vZnIVRsifp9CTQBTiwF4wsDQ1BprxSdfx
         87wi7axR+4iYxlROafM26o4tCRUuF/cuRKURfCyBhCBnP1PoaPMkgxwgew093xdC7aKj
         nQhyjyRUzyPYEmGCLYM3vZFWdc9J6HQ1NqedUgpmto8kktIKTsil0VC9kr3f3lJUUwZt
         /sTTJdigrWyM6sFdyQjGQohieNqt3IDMxf2Lb5vpwEqPFIfMQL8DtCHAggBszz9+29f+
         RH9g==
X-Gm-Message-State: AFqh2kqlu7rycZeLsqi8HcF4UePcgiCQQaybbQpHYPfZQ8dmg+0wZEql
        T5RhT0qwukM9pCj7fuFLEPZShaFZNBwbeNERkQ4zbA==
X-Google-Smtp-Source: AMrXdXtj10x2wUrTf78HuXWWZoELTsEUBaD/ZwvjrysKAtEMK626fVqeOkeuayVt0uJHhTPhyQgxYEuMY3nxXMqtrfQ=
X-Received: by 2002:a05:600c:cc5:b0:3da:b40f:c734 with SMTP id
 fk5-20020a05600c0cc500b003dab40fc734mr427192wmb.115.1673848772065; Sun, 15
 Jan 2023 21:59:32 -0800 (PST)
MIME-Version: 1.0
References: <1673601740-122788-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1673601740-122788-2-git-send-email-renyu.zj@linux.alibaba.com>
 <CAP-5=fWnOGD7CHYeq0Uino4eHte2WP5Pxz9t4YOtvgxrq-_muA@mail.gmail.com> <399e8b83-ee7b-1b24-bd6b-74d274fcda46@linux.alibaba.com>
In-Reply-To: <399e8b83-ee7b-1b24-bd6b-74d274fcda46@linux.alibaba.com>
From:   Ian Rogers <irogers@google.com>
Date:   Sun, 15 Jan 2023 21:59:19 -0800
Message-ID: <CAP-5=fVMA2gkXAAZ8AyhtF4asEZi-p0uxHC-zPyOjjNaEdkS7A@mail.gmail.com>
Subject: Re: [PATCH v7 1/9] perf pmu: Add #slots literal support for arm64
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 15, 2023 at 6:58 PM Jing Zhang <renyu.zj@linux.alibaba.com> wro=
te:
>
> =E5=9C=A8 2023/1/15 =E4=B8=8A=E5=8D=886:15, Ian Rogers =E5=86=99=E9=81=93=
:
> > On Fri, Jan 13, 2023 at 1:22 AM Jing Zhang <renyu.zj@linux.alibaba.com>=
 wrote:
> >>
> >> The slots in each architecture may be different, so add #slots literal
> >> to obtain the slots of different architectures, and the #slots can be
> >> applied in the metric. Currently, The #slots just support for arm64,
> >> and other architectures will return NAN.
> >>
> >> On arm64, the value of slots is from the register PMMIR_EL1.SLOT, whic=
h
> >> I can read in /sys/bus/event_source/device/armv8_pmuv3_*/caps/slots.
> >> PMMIR_EL1.SLOT might read as zero if the PMU version is lower than
> >> ID_AA64DFR0_EL1_PMUVer_V3P4 or the STALL_SLOT event is not implemented=
.
> >>
> >> Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
> >> ---
> >>  tools/perf/arch/arm64/util/pmu.c | 34 +++++++++++++++++++++++++++++++=
+--
> >>  tools/perf/util/expr.c           |  5 +++++
> >>  tools/perf/util/pmu.c            |  6 ++++++
> >>  tools/perf/util/pmu.h            |  1 +
> >>  4 files changed, 44 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/tools/perf/arch/arm64/util/pmu.c b/tools/perf/arch/arm64/=
util/pmu.c
> >> index 477e513..5f8667b 100644
> >> --- a/tools/perf/arch/arm64/util/pmu.c
> >> +++ b/tools/perf/arch/arm64/util/pmu.c
> >> @@ -3,8 +3,9 @@
> >>  #include <internal/cpumap.h>
> >>  #include "../../../util/cpumap.h"
> >>  #include "../../../util/pmu.h"
> >> +#include <api/fs/fs.h>
> >>
> >> -const struct pmu_events_table *pmu_events_table__find(void)
> >> +static struct perf_pmu *pmu_core__find_same(void)
> >
> > I'm not sure "find_same" is the best name here. I suspect it should be
> > "find_core_pmu" which would agree with is_arm_pmu_core. Unfortunately
> > "core" has become an overloaded term sometimes used interchangeably
> > with CPU, hyperthread or SMT thread, it was a model name for Intel and
> > it is used to distinguish a set of SMT threads running together from a
> > single one. Anyway, for consistency I think perf_pmu__find_core_pmu is
> > the most appropriate name (or pmu__find_core_pmu, I'm not sure why we
> > get the extra perf_ prefix sometimes, in general that indicates the
> > functionality is in libperf).
> >
>
> The reason for using "pmu_core__find_same" before is to indicate that we'=
re
> only dealing with homogeneous cores. And in the tools/perf/util/pmu.c fil=
e,
> most of the static functions have "pmu_" prefix, maybe we can use
> "pmu_find_same_core_pmu"? Ian, John, what do you think?

I wouldn't necessarily worry about hybrid given #slots is currently
ARM specific. For hybrid we'd need to know the CPU for the metric. We
do have the list of CPUs (really hyper/SMT threads) that were
requested for the metric:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/p=
erf/util/expr.h?h=3Dperf/core#n9
We use it to compute the #core_wide literal. We need the value early
before events are created, hence the string format. You could search
pmus looking for a PMU that isn't uncore and has matching CPUs, but
AMD has multiple core/hardware PMUs (hence Ravi's most recent work)
and so I suspect we'd need to extend PMU to make this work. We've
solved a similar problem to this with the source_count metric
function, that returns a number of aliased events. We could do
something like:
slots(INST_RETIRED.MACRO_FUSED)
and then from the event get the PMU, from the PMU get the CPUs, from a
CPU get the slots. In that case it may just be cleaner to pass the PMU
name to the slots function, so:
slots(cpu_core) or slots(cpu_atom)
But the parser wouldn't understand that cpu_core or cpu_atom were PMU
names and would try to handle them as events or metric references.

Again, I think ignoring the hybrid case is fine in this case. Using
"same" in the function name to imply "not hybrid" I don't think works,
so I think something like pmu__find_core_pmu is best. You could have a
comment and also a:
assert(!perf_pmu__is_hybrid(pmu->name));
Ultimately I'd like to get rid of all notions of hybrid and just pair
events with a PMU. I recently cleaned this up in builtin-list.c.

Thanks,
Ian

> Thanks,
> Jing
>
> > Aside from that, lgtm. Thanks,
> > Ian
> >
> >>  {
> >>         struct perf_pmu *pmu =3D NULL;
> >>
> >> @@ -19,8 +20,37 @@ const struct pmu_events_table *pmu_events_table__fi=
nd(void)
> >>                 if (pmu->cpus->nr !=3D cpu__max_cpu().cpu)
> >>                         return NULL;
> >>
> >> -               return perf_pmu__find_table(pmu);
> >> +               return pmu;
> >>         }
> >>
> >>         return NULL;
> >>  }
> >> +
> >> +const struct pmu_events_table *pmu_events_table__find(void)
> >> +{
> >> +       struct perf_pmu *pmu =3D pmu_core__find_same();
> >> +
> >> +       if (pmu)
> >> +               return perf_pmu__find_table(pmu);
> >> +
> >> +       return NULL;
> >> +}
> >> +
> >> +double perf_pmu__cpu_slots_per_cycle(void)
> >> +{
> >> +       char path[PATH_MAX];
> >> +       unsigned long long slots =3D 0;
> >> +       struct perf_pmu *pmu =3D pmu_core__find_same();
> >> +
> >> +       if (pmu) {
> >> +               scnprintf(path, PATH_MAX,
> >> +                       EVENT_SOURCE_DEVICE_PATH "%s/caps/slots", pmu-=
>name);
> >> +               /*
> >> +                * The value of slots is not greater than 32 bits, but=
 sysfs__read_int
> >> +                * can't read value with 0x prefix, so use sysfs__read=
_ull instead.
> >> +                */
> >> +               sysfs__read_ull(path, &slots);
> >> +       }
> >> +
> >> +       return (double)slots;
> >> +}
> >> diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
> >> index 00dcde3..9d3076a 100644
> >> --- a/tools/perf/util/expr.c
> >> +++ b/tools/perf/util/expr.c
> >> @@ -19,6 +19,7 @@
> >>  #include <linux/zalloc.h>
> >>  #include <ctype.h>
> >>  #include <math.h>
> >> +#include "pmu.h"
> >>
> >>  #ifdef PARSER_DEBUG
> >>  extern int expr_debug;
> >> @@ -448,6 +449,10 @@ double expr__get_literal(const char *literal, con=
st struct expr_scanner_ctx *ctx
> >>                 result =3D topology->core_cpus_lists;
> >>                 goto out;
> >>         }
> >> +       if (!strcmp("#slots", literal)) {
> >> +               result =3D perf_pmu__cpu_slots_per_cycle() ?: NAN;
> >> +               goto out;
> >> +       }
> >>
> >>         pr_err("Unrecognized literal '%s'", literal);
> >>  out:
> >> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> >> index 2bdeb89..cbb4fbf 100644
> >> --- a/tools/perf/util/pmu.c
> >> +++ b/tools/perf/util/pmu.c
> >> @@ -19,6 +19,7 @@
> >>  #include <regex.h>
> >>  #include <perf/cpumap.h>
> >>  #include <fnmatch.h>
> >> +#include <math.h>
> >>  #include "debug.h"
> >>  #include "evsel.h"
> >>  #include "pmu.h"
> >> @@ -1993,3 +1994,8 @@ int perf_pmu__cpus_match(struct perf_pmu *pmu, s=
truct perf_cpu_map *cpus,
> >>         *ucpus_ptr =3D unmatched_cpus;
> >>         return 0;
> >>  }
> >> +
> >> +double __weak perf_pmu__cpu_slots_per_cycle(void)
> >> +{
> >> +       return NAN;
> >> +}
> >> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> >> index 69ca000..fd414ba 100644
> >> --- a/tools/perf/util/pmu.h
> >> +++ b/tools/perf/util/pmu.h
> >> @@ -259,4 +259,5 @@ int perf_pmu__cpus_match(struct perf_pmu *pmu, str=
uct perf_cpu_map *cpus,
> >>
> >>  char *pmu_find_real_name(const char *name);
> >>  char *pmu_find_alias_name(const char *name);
> >> +double perf_pmu__cpu_slots_per_cycle(void);
> >>  #endif /* __PMU_H */
> >> --
> >> 1.8.3.1
> >>
