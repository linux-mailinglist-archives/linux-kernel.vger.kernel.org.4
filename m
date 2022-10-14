Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF7D5FF373
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 20:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbiJNSKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 14:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiJNSK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 14:10:28 -0400
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C0F402FB;
        Fri, 14 Oct 2022 11:10:26 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1326637be6eso6723100fac.13;
        Fri, 14 Oct 2022 11:10:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rzfkpk16B1bdFYhVEMVjYdQPtrAb81fMcKTxh0OhDTk=;
        b=aPxMTRfPfbAkL4g9pNzSSEsezg7ZobkfMYNeFwpSWsjdJwbZ++90U/BUPj1tQfU8EK
         7Ts6QhB+YjODAleMlqtN16049YP4fHag7qDaRTCuAiI04TleV05GVuqk5PQ0ivo0IhVX
         FhDkKPtciptmdzH64/RiPnju/3oI4DDGcgVle1K7dXPJ7eF/S5QWKa8QPcSGNZKg6QBQ
         EsAwkTycOBVsnvXqio2yxow5WsPUI+QMXJr54nvKuOw8JgkhEOTyNj3IpsFjhUlYbDe3
         hrjOtg78wW+7ZN4CyU0GEvcDVsj4PS4DQxSC6D2Yt/kw0NtzPM6a3IyeJStHi34k8RTy
         biAg==
X-Gm-Message-State: ACrzQf2pYDke90KmcbCrbQX0WpjYmKdYg40FfJq7tUduB6khhyRZ1ytR
        pCD2aRQpJVMaAaiEEqmzOjfS05RTBl9ZupovpA4=
X-Google-Smtp-Source: AMsMyM7eJfqYeu4vWre+h5nwEqQz2rgPPsbtBBe+VSosjSSvaP6iHmmSxFJ8EkclsLMMD9W4oxr55KZxma1fUWYX+eg=
X-Received: by 2002:a05:6870:4184:b0:136:5e73:b40e with SMTP id
 y4-20020a056870418400b001365e73b40emr3347363oac.209.1665771025964; Fri, 14
 Oct 2022 11:10:25 -0700 (PDT)
MIME-Version: 1.0
References: <20221014061550.463644-1-namhyung@kernel.org> <Y0kIB7hxlnlEYipZ@krava>
In-Reply-To: <Y0kIB7hxlnlEYipZ@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 14 Oct 2022 11:10:14 -0700
Message-ID: <CAM9d7ch_CV3mpno+6D23UGaXzL9zhmzmt513RzbWq8q_0DhU4A@mail.gmail.com>
Subject: Re: [PATCHSET 00/19] perf stat: Cleanup counter aggregation (v2)
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Michael Petlan <mpetlan@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        James Clark <james.clark@arm.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri and Michael,

On Thu, Oct 13, 2022 at 11:56 PM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Thu, Oct 13, 2022 at 11:15:31PM -0700, Namhyung Kim wrote:
> > Hello,
> >
> > Current perf stat code is somewhat hard to follow since it handles
> > many combinations of PMUs/events for given display and aggregation
> > options.  This is my attempt to clean it up a little. ;-)
> >
> > changes in v2)
> >  * fix a segfault in perf stat report for per-process record  (Jiri)
> >  * fix metric only display  (Jiri)
> >  * add evsel__reset_aggr_stat  (ian)
> >  * add more comments  (Ian)
> >  * add Acked-by from Ian
> >
> > My first concern is that aggregation and display routines are intermixed
> > and processed differently depends on the aggregation mode.  I'd like to
> > separate them apart and make the logic clearer.
> >
> > To do that, I added struct perf_stat_aggr to save the aggregated counter
> > values and other info.  It'll be allocated and processed according to
> > the aggr_mode and display logic will use it.
> >
> > I've tested the following combination.
> >
> >   $ cat test-matrix.sh
> >   #!/bin/sh
> >
> >   set -e
> >
> >   yes > /dev/null &
> >   TARGET=$!
> >
> >   ./perf stat true
> >   ./perf stat -a true
> >   ./perf stat -C0 true
> >   ./perf stat -p $TARGET true
> >   ./perf stat -t $TARGET true
> >
> >   ./perf stat -a -A true
> >   ./perf stat -a --per-node true
> >   ./perf stat -a --per-socket true
> >   ./perf stat -a --per-die true
> >   ./perf stat -a --per-core true
> >   ./perf stat -a --per-thread true
> >
> >   ./perf stat -a -I 500 sleep 1
> >   ./perf stat -a -I 500 --summary sleep 1
> >   ./perf stat -a -I 500 --per-socket sleep 1
> >   ./perf stat -a -I 500 --summary --per-socket sleep 1
> >
> >   ./perf stat -a --metric-only true
> >   ./perf stat -a --metric-only --per-socket true
> >   ./perf stat -a --metric-only -I 500 sleep 1
> >   ./perf stat -a --metric-only -I 500 --per-socket sleep 1
> >
> >   ./perf stat record true && ./perf stat report
> >   ./perf stat record -p $TARGET true && ./perf stat report
> >   ./perf stat record -a true && ./perf stat report
> >   ./perf stat record -a --per-core true && ./perf stat report
> >   ./perf stat record -a --per-core --metric-only true && ./perf stat report
> >   ./perf stat record -a -I 500 sleep 1 && ./perf stat report
> >   ./perf stat record -a -I 500 --per-core sleep 1 && ./perf stat report
> >   ./perf stat record -a -I 500 --per-core --metric-only sleep 1 && ./perf stat report
> >
> >   ./perf stat -a -A -e cpu/event=cpu-cycles,percore/ true
> >   ./perf stat -a -A -e cpu/event=cpu-cycles,percore/ --percore-show-thread true
> >
> >   kill $TARGET
> >
> > The code is available at 'perf/stat-aggr-v2' branch in
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
>
> Michael,
> ay chance you could run your test suite on top of this change?

I've noticed there's an issue with cgroups.  Will send a fix soon.

Thanks,
Namhyung
