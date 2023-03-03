Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF4C6A9C04
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 17:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjCCQpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 11:45:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjCCQo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 11:44:59 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7062B298
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 08:44:35 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id b16so1195206iof.11
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 08:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677861869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2/MTNE26aRXfoD1WpUTjmXV2c/L1a5as96+J8QTw+PM=;
        b=Xr/yHVwy/Zj1cBfRrs4AaSJvWVU1+6NDNq1NX3hDumSwSDzihtJc0k9dWCZp62g3n9
         XxNtPLF8Egf6OXGBX1yQ2tOXBR6sqZbr7YeNHCvh8S36eyRPLRdxBCt/wx0/Xt+kp4ks
         FlitKfdwilbk6xwu494vaaYhyhW75KE0XBUwXUIrn6NOIfA65m/Pk+uFYJBgSdwHcCSt
         hqTfaSeGy661j/pZlrwJHFYZYQZYwV0ulbemiTJyYLmHUaTsyLNI+rLhsPpwFk582lqR
         ncoUBV9qmz1EA5Vj3wIt+TXLYn5WmEuLet5KSKN08JD7XzHGnU34T7rskexdTPU7ciXz
         RYtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677861869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2/MTNE26aRXfoD1WpUTjmXV2c/L1a5as96+J8QTw+PM=;
        b=Jy1ZA9LKqvSXlG4ZrJ/FXZSNVI9oRcbu7B2CEq1AJYfcdrgB5uhWkIQ2cdlRYVJfcj
         C4+xaM4I5NIBGNBYWoLu9Uz/FsFYWFMgPnwSInmzjLhEaGQsbaMMvuYXWK+VFBpWqyzT
         +UfTMcj7iyJSrgYQ2twSeJJGVq19mFp5/e4P3uPCJJlXouaB150/8y7asCBMzrZqzNki
         YmC/nObNk4FGLJRcDsfpmuOd6zqGyd8xvbmd83kReZzjq4yXRTwGDvQefYQrpHkNxrTC
         j8kbmJ/Dt9Q85WRt7IIKsNkB1eemFIXdJkBH1WCbEzLPIKlfUQkhW4Ke3dQGEKaaWL37
         T5/A==
X-Gm-Message-State: AO0yUKWpbHGba5nztQIOWHfpRMaqfPn6ti5hGlPk2AXg31wWNrnOrBtk
        4bm8PCKvB0VIYuNjM3aA+bmHa30o56sgXkErDbQHNw==
X-Google-Smtp-Source: AK7set+4musQnbb0Y8lAnjg6jMwrEAK2db+bOLmt0zuywluYxhrIcd1g/AQv8zoHI+K7ZAW67bcPd3VNhikPOm6Nn28=
X-Received: by 2002:a02:2b04:0:b0:3c2:c1c9:8bca with SMTP id
 h4-20020a022b04000000b003c2c1c98bcamr2490077jaa.2.1677861869186; Fri, 03 Mar
 2023 08:44:29 -0800 (PST)
MIME-Version: 1.0
References: <20230302212531.1043318-1-irogers@google.com> <20230302212531.1043318-3-irogers@google.com>
 <962de75d-8e27-9b47-662e-e324b3ba5812@linux.intel.com>
In-Reply-To: <962de75d-8e27-9b47-662e-e324b3ba5812@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 3 Mar 2023 08:44:15 -0800
Message-ID: <CAP-5=fXiRtKF661e=-4dX30ooV7uKQbidjaaDhjckVRdjw7CzA@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] perf stat: Don't remove all grouped events when
 CPU maps disagree
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Sean Christopherson <seanjc@google.com>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
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

On Fri, Mar 3, 2023 at 7:50=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.co=
m> wrote:
>
>
>
> On 2023-03-02 4:25 p.m., Ian Rogers wrote:
> > If the events in an evlist's CPU map differ then the entire group is
> > removed. For example:
> >
> > ```
> > $ perf stat -e '{imc_free_running/data_read/,imc_free_running/data_writ=
e/,cs}' -a sleep 1
> > WARNING: grouped events cpus do not match, disabling group:
> >   anon group { imc_free_running/data_read/, imc_free_running/data_write=
/, cs }
> > ```
> >
> > Change the behavior so that just the events not matching the leader
> > are removed. So in the example above, just 'cs' will be removed.
> >
> > Modify the warning so that it is produced once for each group, rather
> > than once for the entire evlist. Shrink the scope and size of the
> > warning text buffer.
>
> For the uncore, we usually have to create a group for each uncore PMU.
> The number of groups may be big. For example, on ICX, we have 40 CHA
> PMUs. For SPR, there should be more CHAs. If we have something like
> {cycles,uncore_cha/event=3D0x1/}, is the warning shown 40 times on ICX?
> If so, it should be very annoying.
>
> Maybe it's better to keep the current behavior which only print a
> warning once and notify the users that perf will re-group the events.
> For the details, they can get it from the -v option.

Thanks Kan, I could imagine that but I was also worried about cases
where there are multiple groups like:

```
$ perf stat -e '{imc_free_running/data_read/,cs},{uncore_clock/clockticks/,=
cs}'
-a sleep 1
WARNING: grouped events cpus do not match.
Events with CPUs not matching the leader will be removed from the group.
 anon group { imc_free_running/data_read/, cs }
WARNING: grouped events cpus do not match.
Events with CPUs not matching the leader will be removed from the group.
 anon group { uncore_clock/clockticks/, cs }

Performance counter stats for 'system wide':

         1,255.75 MiB  imc_free_running/data_read/
            7,571      cs
    1,327,285,527      uncore_clock/clockticks/
            7,571      cs

      1.002772882 seconds time elapsed
```

Knowing that both groups were broken there feels like a value add.
Given that this is a warning, and it can be fixed by moving the event
out of the group or forcing the CPUs, I lean toward being
informative/spammy as the spam is somewhat straightforwardly fixed on
the command line.

Thanks,
Ian

> Thanks,
> Kan
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/builtin-stat.c | 24 +++++++++++++++---------
> >  1 file changed, 15 insertions(+), 9 deletions(-)
> >
> > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > index d70b1ec88594..5c12ae5efce5 100644
> > --- a/tools/perf/builtin-stat.c
> > +++ b/tools/perf/builtin-stat.c
> > @@ -181,14 +181,13 @@ static bool cpus_map_matched(struct evsel *a, str=
uct evsel *b)
> >
> >  static void evlist__check_cpu_maps(struct evlist *evlist)
> >  {
> > -     struct evsel *evsel, *pos, *leader;
> > -     char buf[1024];
> > +     struct evsel *evsel, *warned_leader =3D NULL;
> >
> >       if (evlist__has_hybrid(evlist))
> >               evlist__warn_hybrid_group(evlist);
> >
> >       evlist__for_each_entry(evlist, evsel) {
> > -             leader =3D evsel__leader(evsel);
> > +             struct evsel *leader =3D evsel__leader(evsel);
> >
> >               /* Check that leader matches cpus with each member. */
> >               if (leader =3D=3D evsel)
> > @@ -197,19 +196,26 @@ static void evlist__check_cpu_maps(struct evlist =
*evlist)
> >                       continue;
> >
> >               /* If there's mismatch disable the group and warn user. *=
/
> > -             WARN_ONCE(1, "WARNING: grouped events cpus do not match, =
disabling group:\n");
> > -             evsel__group_desc(leader, buf, sizeof(buf));
> > -             pr_warning("  %s\n", buf);
> > -
> > +             if (warned_leader !=3D leader) {
> > +                     char buf[200];
> > +
> > +                     pr_warning("WARNING: grouped events cpus do not m=
atch.\n"
> > +                             "Events with CPUs not matching the leader=
 will "
> > +                             "be removed from the group.\n");
> > +                     evsel__group_desc(leader, buf, sizeof(buf));
> > +                     pr_warning("  %s\n", buf);
> > +                     warned_leader =3D leader;
> > +             }
> >               if (verbose > 0) {
> > +                     char buf[200];
> > +
> >                       cpu_map__snprint(leader->core.cpus, buf, sizeof(b=
uf));
> >                       pr_warning("     %s: %s\n", leader->name, buf);
> >                       cpu_map__snprint(evsel->core.cpus, buf, sizeof(bu=
f));
> >                       pr_warning("     %s: %s\n", evsel->name, buf);
> >               }
> >
> > -             for_each_group_evsel(pos, leader)
> > -                     evsel__remove_from_group(pos, leader);
> > +             evsel__remove_from_group(evsel, leader);
> >       }
> >  }
> >
