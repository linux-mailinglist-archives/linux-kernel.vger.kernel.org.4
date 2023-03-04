Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030BC6AA78E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 03:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjCDCWc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 3 Mar 2023 21:22:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjCDCWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 21:22:30 -0500
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F8C1B31E;
        Fri,  3 Mar 2023 18:22:29 -0800 (PST)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5384ff97993so76499817b3.2;
        Fri, 03 Mar 2023 18:22:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677896548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qPHnjCLdtmXvj3xOnAC54fhyuMMx2Sn9DQO+LKzZiBw=;
        b=1vf0uADeLP2cy9IvxWAxXFCQdTYs1FA0pdQeHs+R8tfJPX56QcTiJg/l8xbXHgmUGT
         tOSl9m6CIXkjSMB4beE8bq4Z/LTTeZRvvo8AlCP0UC7/OxtxuA7GNX27MqE4t0IRCyWh
         gVHcRD7Dk57uXWLIN+twg6IqZsqHnG87C3qCpWC35CzdAjQjKm2ikBt0nG0nSY/Whlt/
         AhxLRBH7/kTjFX2W87WY2HOJ5pEbi683b9h7EhCA538VZfAKdDlzD3+Mxj4x2+EPj3zn
         xdPBJgc9hO8D8DshUfk/93PVKwxUivVRg4zJJnZmaMvW+gPvm6+chlIoDc1nKS4HAn64
         4/iQ==
X-Gm-Message-State: AO0yUKVbehjhp3cR9wwrB8A4gmEVlPwYyckMumjBCdhsBbqxzi8DUiVY
        Cl3H+9+0V5PPMJg3Z2I38UNTimYpLv08/BnRiu4=
X-Google-Smtp-Source: AK7set+O/rTHZZcjaoCcS0aYmy1w63tC1g9blFpNriZI/g8cwa2hY+STgZcWGaA0fbYhA9F5VWmiYLpbnE1d7OdciBg=
X-Received: by 2002:a81:ae47:0:b0:533:9ffb:cb13 with SMTP id
 g7-20020a81ae47000000b005339ffbcb13mr2185799ywk.3.1677896548461; Fri, 03 Mar
 2023 18:22:28 -0800 (PST)
MIME-Version: 1.0
References: <20230302212531.1043318-1-irogers@google.com> <20230302212531.1043318-9-irogers@google.com>
 <CAM9d7ciBSB33HDD0-vcHHsco9k=H6qZkiCH8po=adt8-jv0ayg@mail.gmail.com> <CAP-5=fWTqSuec8P-Ccztz=HiBHFLYmk7Nq1Z1eYzmi6WOuB=YA@mail.gmail.com>
In-Reply-To: <CAP-5=fWTqSuec8P-Ccztz=HiBHFLYmk7Nq1Z1eYzmi6WOuB=YA@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 3 Mar 2023 18:22:16 -0800
Message-ID: <CAM9d7chCEBvOtAQbozodjEnxqdObZXvoRcsTo8ERyn97PqPtPg@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] perf parse-events: Sort and group parsed events
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
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
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 2, 2023 at 5:39 PM Ian Rogers <irogers@google.com> wrote:
>
> On Thu, Mar 2, 2023 at 4:37 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Thu, Mar 2, 2023 at 1:26 PM Ian Rogers <irogers@google.com> wrote:
> > >
> > > This change is intended to be a no-op for most current cases, the
> > > default sort order is the order the events were parsed. Where it
> > > varies is in how groups are handled. Previously an uncore and core
> > > event that are grouped would most often cause the group to be removed:
> > >
> > > ```
> > > $ perf stat -e '{instructions,uncore_imc_free_running_0/data_total/}' -a sleep 1
> > > WARNING: grouped events cpus do not match, disabling group:
> > >   anon group { instructions, uncore_imc_free_running_0/data_total/ }
> > > ...
> > > ```
> > >
> > > However, when wildcards are used the events should be re-sorted and
> > > re-grouped in parse_events__set_leader, but this currently fails for
> > > simple examples:
> > >
> > > ```
> > > $ perf stat -e '{uncore_imc_free_running/data_read/,uncore_imc_free_running/data_write/}' -a sleep 1
> > >
> > >  Performance counter stats for 'system wide':
> > >
> > >      <not counted> MiB  uncore_imc_free_running/data_read/
> > >      <not counted> MiB  uncore_imc_free_running/data_write/
> > >
> > >        1.000996992 seconds time elapsed
> > > ```
> > >
> > > A futher failure mode, fixed in this patch, is to force topdown events
> > > into a group.
> > >
> > > This change moves sorting the evsels in the evlist after parsing. It
> > > requires parsing to set up groups. First the evsels are sorted
> > > respecting the existing groupings and parse order, but also reordering
> > > to ensure evsels of the same PMU and group appear together. So that
> > > software and aux events respect groups, their pmu_name is taken from
> > > the group leader. The sorting is done with list_sort removing a memory
> > > allocation.
> > >
> > > After sorting a pass is done to correct the group leaders and for
> > > topdown events ensuring they have a group leader.
> > >
> > > This fixes the problems seen before:
> > >
> > > ```
> > > $ perf stat -e '{uncore_imc_free_running/data_read/,uncore_imc_free_running/data_write/}' -a sleep 1
> > >
> > >  Performance counter stats for 'system wide':
> > >
> > >             727.42 MiB  uncore_imc_free_running/data_read/
> > >              81.84 MiB  uncore_imc_free_running/data_write/
> > >
> > >        1.000948615 seconds time elapsed
> > > ```
> > >
> > > As well as making groups not fail for cases like:
> > >
> > > ```
> > > $ perf stat -e '{imc_free_running_0/data_total/,imc_free_running_1/data_total/}' -a sleep 1
> > >
> > >  Performance counter stats for 'system wide':
> > >
> > >             256.47 MiB  imc_free_running_0/data_total/
> > >             256.48 MiB  imc_free_running_1/data_total/
> >
> > I didn't expect we can group events from different PMUs.
> > Not sure if it can handle multiplexing properly..
>
> You are right, this example is now working as the sorting and
> regrouping breaks the events into two groups. The rules around
> grouping are complex and Arnaldo mentioned that maybe cases like this
> should be warned about. The problem then is that wildcard and metric
> expansion may naturally produce these cases and we don't want the
> warning. It is something of a shame that the grouping information in
> the perf stat output isn't clearer.

Oh, that means the events are not in a group in this case.
Yeah.. it can be somewhat confusing.  It seems the wildcard
is a kind of exception.  Then we can warn if there's no wildcard?

Thanks,
Namhyung
