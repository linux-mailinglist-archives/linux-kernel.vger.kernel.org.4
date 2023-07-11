Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0BC74F310
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 17:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbjGKPKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 11:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjGKPKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 11:10:47 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79CD210EF
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 08:10:28 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-4036bd4fff1so273971cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 08:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689088227; x=1691680227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FXXgBlGDAgzLkutcHZ7sASFFDrpsYXVUKvAHMEtR4rw=;
        b=N6klHx+eyuoIjfiaI0v1z47RRdpGs97orCUlDc8RWQBS8JGIZsDQR2lmYLZktkTL7N
         utNpaypyO6MgRQhLkmG+MiHyu3WQMEloe6KTLQndlWJfNqEcA6mZSjHzBQC19GAibNRp
         ddcle7Shm+PTvtuPzRKxJouBbpmz7LbYPIAptzrgyLHrSsQ2+38QF8G+bubLsmlF6B6r
         ozfVkIePgd80QubPNfkGVCxZa0ohVvNBPy1pT2Kf8YXjGTZsoUjlfc88Pb6vH1GpAHbg
         EvyzocZL3wWdUtJHwm/rZPZFrI7at3X9eBzi6AKlJZYxQKFQTKwON7ANgQIc2iWo91xz
         KiOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689088227; x=1691680227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FXXgBlGDAgzLkutcHZ7sASFFDrpsYXVUKvAHMEtR4rw=;
        b=WGsoIzXF6X66OE0mrXYapNOWzxgTkBHC8D6HWcbK7NISAaQydDixGmoNXAiYunNFoL
         cSYllowIv3UJpuQMMlCPOQ4DvuoaZIp/iKVvaUiaQIQMTR8sU6UnXCT2I0thsXR1cpe1
         D1Ww9Vt5iJKrBgSPYhF3xfZPfTTpTjRengTfwDaWPpfoysy0ksM/MAIiPoFBD3vSi6RG
         O1A+yrvgbed/eQETkiK+5jZ4X26Ac8yRxxKSGL2cPKrWYplXWuS7XcHHmuqnnYbQxavr
         YLLCR9BFffApv9OIsSBBtgQI8BZCn8sQDeGvllSIDrMOdI4z2o5gCvGbt11FgM07toPh
         UNeQ==
X-Gm-Message-State: ABy/qLaudCRs8MgyiSkXIYHvfzS6IBMCc/k9RSxO4OLhwMpt125p8Xt6
        cqGp/T4QGFJfvMcCzZ2Yup2Uba+r0RuJ4bzDsBkV1w==
X-Google-Smtp-Source: APBJJlFZZhaRI8ygieCTBZxLDpHmKmobNdZcLK+Gcqk61HWR1zTWR1ySAr85pNZwVmhZc3CTTku2gSWjKJCK+skFdZk=
X-Received: by 2002:a05:622a:315:b0:3f9:ab2c:88b9 with SMTP id
 q21-20020a05622a031500b003f9ab2c88b9mr207655qtw.25.1689088227475; Tue, 11 Jul
 2023 08:10:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230711055859.1242497-1-irogers@google.com> <182675ca-0905-0ed2-de94-0f7d4a256082@oracle.com>
In-Reply-To: <182675ca-0905-0ed2-de94-0f7d4a256082@oracle.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 11 Jul 2023 08:10:15 -0700
Message-ID: <CAP-5=fXrOvkwrbEB0GGv6Xr5JOdrW7dzjOL=MkDdxX2McfnzYA@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] perf list: Remove duplicate PMUs
To:     John Garry <john.g.garry@oracle.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 1:26=E2=80=AFAM John Garry <john.g.garry@oracle.com=
> wrote:
>
> On 11/07/2023 06:58, Ian Rogers wrote:
> > When there are multiple PMUs differing by ordered suffixes only
> > display one. This avoids repeated listing of events, in particular
> > when there are 10s of uncore PMUs. This also helps speed the all PMU
> > event tests.
> >
> > Before:
> > ```
> > $ perf list
> > ...
> >    uncore_imc_free_running_0/data_read/               [Kernel PMU event=
]
> >    uncore_imc_free_running_0/data_total/              [Kernel PMU event=
]
> >    uncore_imc_free_running_0/data_write/              [Kernel PMU event=
]
> >    uncore_imc_free_running_1/data_read/               [Kernel PMU event=
]
> >    uncore_imc_free_running_1/data_total/              [Kernel PMU event=
]
> >    uncore_imc_free_running_1/data_write/              [Kernel PMU event=
]
> > ```
> >
> > After:
> > ```
> > $ perf list
> > ...
> >    uncore_imc_free_running/data_read/                 [Kernel PMU event=
]
> >    uncore_imc_free_running/data_total/                [Kernel PMU event=
]
> >    uncore_imc_free_running/data_write/                [Kernel PMU event=
]
>
> So with this change can we run something like:
>
> perf stat -e uncore_imc_free_running/data_read/
>
> ?

It is a long standing behavior of the event parser that we match the
numeric suffixes, so:

```
$ sudo perf stat -e uncore_imc_free_running/data_read/ -a sleep 1

Performance counter stats for 'system wide':

         6,969.93 MiB  uncore_imc_free_running/data_read/

      1.001163027 seconds time elapsed
```

The "uncore_" at the beginning is also optional, I kind of wish the
"free_running" was too. The code doing this is:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/parse-events.y?h=3Dperf-tools-next#n316
adding a * after the PMU name in:
asprintf(&pattern, "%s*", $1)
Then using fnmatch here:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/pmu.c?h=3Dperf-tools-next#n1707

> If so, does that match all PMUs whose name beings with
> "uncore_imc_free_running" (and give aggregate result for those PMUs)?

Yep. As we're matching with a filename '*' glob then it will actually
potentially grab a bunch more. I think this should likely be made a
lot more precise.

The merging of the counters happens throughout the code, but it is set up h=
ere:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/stat.c?h=3Dperf-tools-next#n559

I didn't write this behavior, it has pre-existed my contributions. I'm
hoping to change the perf list behavior as we're seeing large server
systems with getting on toward 100 PMUs, the events are replicated for
each one and the perf list and testing behaviors are somewhat
exploding in size.

Thanks,
Ian

> Thanks,
> John
>
> > ```
> >
> > The PMUs are sorted by name then suffix as a part of this change.
> >
> > Ian Rogers (3):
> >    perf pmus: Sort pmus by name then suffix
> >    perf pmus: Add scan that ignores duplicates, use for perf list
> >    perf pmus: Don't print PMU suffix in list
> >
> >   tools/perf/util/pmus.c | 107 +++++++++++++++++++++++++++++++++++++++-=
-
> >   1 file changed, 102 insertions(+), 5 deletions(-)
> >
>
