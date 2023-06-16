Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08623733B28
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 22:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjFPUtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 16:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjFPUtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 16:49:01 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D573AA4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 13:48:57 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-3f9d619103dso18391cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 13:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686948536; x=1689540536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q4C0dBOSrJZkyZRW8t45DUaZVaqbnpOww1624MFrzs8=;
        b=EP9FV+8LR4SvA45G61rVj+7KGya7Cb4aTiM/MSKyWs+58Q8gaxRkgWdzs/P9mZCtw6
         j/buhiYh76AK/TcjssYHzmTcUdsvCKmITTu6zNqpNQ6Gc5QwmRVwgUrZA51ZXFiBcM3b
         e7E+BbHXyhJ+pv/PkjbtL8P2eMLSiO3w2ogEKGgMZquKnb2gOs0C8nva/TcrdUOs9w45
         UaDfiHxbsi893A9NzvTn2a4IIiyPaJ6zXfQDtIfyhw5deHXfjBkX12FgWdysbIcW75y/
         XFOitzBUDq+ldUeJVP1cb1mujIg3pxNM732aXUxShWfqOgbSMvbu9lZTkyfEv7v9eK42
         KQ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686948536; x=1689540536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q4C0dBOSrJZkyZRW8t45DUaZVaqbnpOww1624MFrzs8=;
        b=hobJP0F0g3Fd96/ca1KlAL3JzprS6KIu+lG/StMLt6dTMXyqtjKIR0JdE3gidnJ5tV
         EtyeD47DpPf78IF2KMG70p7ZzjCOk2G7XYeSaovnabVJq0+GFQ6ywZbyeNJC4BUYJEZ2
         tHxggxHmfkHGpxPYw13BuZmkjUYKeKuaS1tc/KokhR/1PBnYO0D1xSBdYpiDI/kV2vHd
         Tbyw9iBxfXAwKaY3zG99tJkhLgdsyJNMf13hFLPseI/wpPWL6leu0+0jMkL/s2xoFttw
         3EpjLowQByKC8jVfoK2Ogf8xPLEpa2KjvlkDs2imkzQoaejy9kaakyzVUyynB90ekGa4
         3CFg==
X-Gm-Message-State: AC+VfDzwXARWdK2GPnnC4WU1xSLixcNoyeUnJHc3Q7wCYKUSSx4sBiwf
        qXwHdQNDAOflnk1X7dq3IXMlZ3wAvxQEH/LDWumwKg==
X-Google-Smtp-Source: ACHHUZ5y45Xry97ZHCIseh2oR+Lm6LPiHgKvB2MIZX5fdXagL/YMC9cPCaHSbZc8LHyxIGpN3QvZ+23ceqrGT0tiq0Q=
X-Received: by 2002:a05:622a:60d:b0:3f2:2c89:f1ef with SMTP id
 z13-20020a05622a060d00b003f22c89f1efmr673424qta.5.1686948536489; Fri, 16 Jun
 2023 13:48:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230616081437.1932003-1-tmricht@linux.ibm.com> <ZIxf7A1jPiDUUdDt@kernel.org>
In-Reply-To: <ZIxf7A1jPiDUUdDt@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 16 Jun 2023 13:48:45 -0700
Message-ID: <CAP-5=fXZFgVFMALts+r03c=Xjnv1_iKAx=jqcmRSDU4sDzxSWg@mail.gmail.com>
Subject: Re: [PATCH] perf test: fix failing test cases on linux-next for s390
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        sumanthk@linux.ibm.com, hca@linux.ibm.com, svens@linux.ibm.com,
        gor@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 6:13=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Fri, Jun 16, 2023 at 10:14:37AM +0200, Thomas Richter escreveu:
> > In linux-next tree the many test cases fail on s390x when running the
> > perf test suite, sometime the perf tool dumps core.
> >
> > Output before:
> >   6.1: Test event parsing                               : FAILED!
> >  10.3: Parsing of PMU event table metrics               : FAILED!
> >  10.4: Parsing of PMU event table metrics with fake PMUs: FAILED!
> >  17: Setup struct perf_event_attr                       : FAILED!
> >  24: Number of exit events of a simple workload         : FAILED!
> >  26: Object code reading                                : FAILED!
> >  28: Use a dummy software event to keep tracking        : FAILED!
> >  35: Track with sched_switch                            : FAILED!
> >  42.3: BPF prologue generation                          : FAILED!
> >  66: Parse and process metrics                          : FAILED!
> >  68: Event expansion for cgroups                        : FAILED!
> >  69.2: Perf time to TSC                                 : FAILED!
> >  74: build id cache operations                          : FAILED!
> >  86: Zstd perf.data compression/decompression           : FAILED!
> >  87: perf record tests                                  : FAILED!
> > 106: Test java symbol                                   : FAILED!
> >
> > The reason for all these failure is a missing PMU. On s390x
> > the PMU is named cpum_cf which is not detected as core PMU.
> > A similar patch was added before, see
> > commit 9bacbced0e32 ("perf list: Add s390 support for detailed PMU even=
t description")
> > which got lost during the recent reworks. Add it again.
> >
> > Output after:
> >  10.2: PMU event map aliases                            : FAILED!
> >  42.3: BPF prologue generation                          : FAILED!
> >
> > Most test cases now work and there is not core dump anymore.
>
> So you're not fixing 'perf test', that is just what detects the problem,
> the part being fixed is the PMU code, so I'm rewriting the patch subject
> to:
>
> [PATCH] perf pmu: Fix core PMU detection on s/390
>
> Have you bisected the problem to the first patch where this problem
> appears?

I suspect:
https://lore.kernel.org/all/20230527072210.2900565-30-irogers@google.com/
9d6a1df9b2ee ("perf pmus: Allow just core PMU scanning")

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> - Arnaldo
>
> > Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> > Cc: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/pmu.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> > index fe64ad292d36..6142e4710a2f 100644
> > --- a/tools/perf/util/pmu.c
> > +++ b/tools/perf/util/pmu.c
> > @@ -1419,7 +1419,7 @@ void perf_pmu__del_formats(struct list_head *form=
ats)
> >
> >  bool is_pmu_core(const char *name)
> >  {
> > -     return !strcmp(name, "cpu") || is_sysfs_pmu_core(name);
> > +     return !strcmp(name, "cpu") || !strcmp(name, "cpum_cf") || is_sys=
fs_pmu_core(name);
> >  }
> >
> >  bool perf_pmu__supports_legacy_cache(const struct perf_pmu *pmu)
> > --
> > 2.39.2
> >
>
> --
>
> - Arnaldo
