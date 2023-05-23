Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3D8970E34A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 19:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237924AbjEWREd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 13:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237922AbjEWREb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 13:04:31 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95600FA
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 10:04:27 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-33828a86ee2so1855ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 10:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684861467; x=1687453467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=muALjIcfvVCb2tAeAMgrB1kx2WpHTC3GVkLoOVcMWrs=;
        b=hPYTWkjDJ0qxhJWHGuhyTTZRm+3Lq/ZZ6L2qVorxEtDJ2W0UwUoGB1FjZI548qw1Ty
         MaDNYFql4e4vWR1A6Lb3Ctu2SPMnaoAnHh2Cgdr2x1V6IHPOBydyRqclUFrAuIPDxMCZ
         R2vzfht1bM4Y2Ny8bdBYdO/pRLDNf1Ls9mi4rwsuFYI/LtZwmBOpPFlwKPFzmEOEUPve
         G9jwB/AyYTW5EI7x993RqKRFR1EIH58caym0JR77CvtWA6OK147um1EKkJp9Sv2t87qG
         HaXaIiPzdNH2VlGOw+uyHeKaIHRvewzvryOrTLGFknKJqgpS0S40r5HTuO9KnWMTNPkA
         sKfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684861467; x=1687453467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=muALjIcfvVCb2tAeAMgrB1kx2WpHTC3GVkLoOVcMWrs=;
        b=h8E6s8SjI4DJbBGy8n7dn0ReHkI/3NSjLM8EWR4zg+RG565N4DpcoEklZTadbJSfYs
         iNH5xqg2wkNAbSSpBTsEQDfPupVadyE/RRlZNIiyEU3M8dRTYBjpG7fvEHyJmDjNDGYQ
         2bjJI3UQQkZ4JzLsTUhNIOh8lLYiL/ypEepsc2ThJl+SKXancluV0H3ZH31sL6we19mX
         9COQ8C/QuCgREkUdCwDovyqwhAp/fftAjOXw/6SPQR7ij/QDF8sM8tYW+QtDb3kf9wGe
         pYCyh6vcCnb6DPJUVzialrdg9DVek82QMMHeur58TOVNLqWgvDBFEKh34dEfPaO8DqEm
         E0LA==
X-Gm-Message-State: AC+VfDwOzNqG2N1XWawHBImn5EVyA0Yt5o1wOYz51ufXbt9Oibx8NZti
        e63AZ+zpd3N97FgS8SecZs8luzDbdw4Gz0NtC6uFqQ==
X-Google-Smtp-Source: ACHHUZ68eb454ZJ7+cyvvL1swgmhHWaWazGxR2m8pCubno25/gamawQfw4hRdQzBzt1f0a/HDJWu+8I248pEUTug6+A=
X-Received: by 2002:a05:6e02:190f:b0:335:12d6:2c7d with SMTP id
 w15-20020a056e02190f00b0033512d62c7dmr12122ilu.0.1684861466749; Tue, 23 May
 2023 10:04:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230523044446.1020769-1-irogers@google.com> <20230523044446.1020769-2-irogers@google.com>
 <0a325fc8-2945-862a-e6bd-eb7b0ac46fe5@intel.com>
In-Reply-To: <0a325fc8-2945-862a-e6bd-eb7b0ac46fe5@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 23 May 2023 10:04:15 -0700
Message-ID: <CAP-5=fUpkd+aDhhzz9aRMiJ6JErjSpHgfy82zvFeYTdnHae8kQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] perf evsel: for_each_group fixes
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        James Clark <james.clark@arm.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Changbin Du <changbin.du@huawei.com>,
        Rob Herring <robh@kernel.org>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 7:33=E2=80=AFAM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 23/05/23 07:44, Ian Rogers wrote:
> > Address/memory sanitizer was reporting issues in evsel__group_pmu_name
> > because the for_each_group_evsel loop didn't terminate when the head
> > was reached, the head would then be cast and accessed as an evsel
> > leading to invalid memory accesses. Fix for_each_group_member and
> > for_each_group_evsel to terminate at the list head. Note,
> > evsel__group_pmu_name no longer iterates the group, but the problem is
> > present regardless.
> >
> > Fixes: 717e263fc354 ("perf report: Show group description when event gr=
oup is enabled")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/evsel.h         | 24 ++++++++++++++++--------
> >  tools/perf/util/evsel_fprintf.c |  1 +
> >  2 files changed, 17 insertions(+), 8 deletions(-)
> >
> > diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> > index 820771a649b2..6a64543c7612 100644
> > --- a/tools/perf/util/evsel.h
> > +++ b/tools/perf/util/evsel.h
> > @@ -462,16 +462,24 @@ static inline int evsel__group_idx(struct evsel *=
evsel)
> >  }
> >
> >  /* Iterates group WITHOUT the leader. */
> > -#define for_each_group_member(_evsel, _leader)                        =
               \
> > -for ((_evsel) =3D list_entry((_leader)->core.node.next, struct evsel, =
core.node); \
> > -     (_evsel) && (_evsel)->core.leader =3D=3D (&_leader->core);       =
                           \
> > -     (_evsel) =3D list_entry((_evsel)->core.node.next, struct evsel, c=
ore.node))
> > +#define for_each_group_member_head(_evsel, _leader, _head)            =
               \
> > +for ((_evsel) =3D list_entry((_leader)->core.node.next, struct evsel, =
core.node);              \
> > +     (_evsel) && (&(_evsel)->core.node !=3D (_head)) &&               =
                 \
>
> Extra parentheses perhaps not needed e.g. just
>
>         &(_evsel)->core.node !=3D (_head)
>
> > +     (_evsel)->core.leader =3D=3D (&_leader->core);                   =
                   \
>
> Parentheses look odd, maybe should be:
>
>         &(_leader)->core
>
> > +     (_evsel) =3D list_entry((_evsel)->core.node.next, struct evsel, c=
ore.node))
> > +
> > +#define for_each_group_member(_evsel, _leader)                        =
       \
> > +     for_each_group_member_head(_evsel, _leader, &(_leader)->evlist->c=
ore.entries)
>
> Did you consider using (_leader)->core.nr_members so that it is not
> necessary to assume the evlist back pointer is populated.

Thanks! I'll address the other comments in v2. Wrt
nr_members/evsel->evlist, I think we can use it to avoid the whole
list scan in evsel__compute_group_pmu_name. We could use it here but
in all the non-parse_events__sort_events_and_fix_groups cases we have
the evsel->evlist and testing for the list head seems more consistent
with other list_for_each cases.

Thanks,
Ian

> >
> >  /* Iterates group WITH the leader. */
> > -#define for_each_group_evsel(_evsel, _leader)                         =
               \
> > -for ((_evsel) =3D _leader;                                            =
         \
> > -     (_evsel) && (_evsel)->core.leader =3D=3D (&_leader->core);       =
                           \
> > -     (_evsel) =3D list_entry((_evsel)->core.node.next, struct evsel, c=
ore.node))
> > +#define for_each_group_evsel_head(_evsel, _leader, _head)             =
               \
> > +for ((_evsel) =3D _leader;                                            =
                 \
> > +     (_evsel) && (&(_evsel)->core.node !=3D (_head)) &&               =
                 \
> > +     (_evsel)->core.leader =3D=3D (&_leader->core);                   =
                   \
> > +     (_evsel) =3D list_entry((_evsel)->core.node.next, struct evsel, c=
ore.node))
> > +
> > +#define for_each_group_evsel(_evsel, _leader)                         =
       \
> > +     for_each_group_evsel_head(_evsel, _leader, &(_leader)->evlist->co=
re.entries)
> >
> >  static inline bool evsel__has_branch_callstack(const struct evsel *evs=
el)
> >  {
> > diff --git a/tools/perf/util/evsel_fprintf.c b/tools/perf/util/evsel_fp=
rintf.c
> > index cc80ec554c0a..036a2171dc1c 100644
> > --- a/tools/perf/util/evsel_fprintf.c
> > +++ b/tools/perf/util/evsel_fprintf.c
> > @@ -2,6 +2,7 @@
> >  #include <inttypes.h>
> >  #include <stdio.h>
> >  #include <stdbool.h>
> > +#include "util/evlist.h"
> >  #include "evsel.h"
> >  #include "util/evsel_fprintf.h"
> >  #include "util/event.h"
>
