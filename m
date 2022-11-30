Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4E263CE85
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 06:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbiK3FB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 00:01:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiK3FBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 00:01:25 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6683F6F820
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 21:01:24 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id l39-20020a05600c1d2700b003cf93c8156dso537800wms.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 21:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kpXnCKC/rrFNFqKBvBovi7KnRoPLUD/c1A9bpn5kMac=;
        b=HkF2+Uudt//VPMDu3oIiLkoI/OCYh2PiGSUW91TabDN556pBAUCsqufwtnnf0Ym03J
         VQChJAL0oRgDqQHcBDl4GIJZISqB3oDeh+s7YMuKS5BlvJuQSihUGymHTNOTdT0RO0T6
         tbNfGRr2zHSMxIzGbde48Uc8BEx92ib0hykw+bKdeZ1rVktV+PIQrWJ+VuzSeD4tHij1
         lbyRr3/UOUEN5/RChJ8VevMTLriCrAYAJoskMvAGU+EbgXAeJeUebWTmV/1Ewhq1O/KQ
         UgvkB+lUT5UYnTA3ETpiZsMBIlwNEyuHMt2tC8Wh96T41yQfHgKpT3N4aFqAk326P4D1
         EO5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kpXnCKC/rrFNFqKBvBovi7KnRoPLUD/c1A9bpn5kMac=;
        b=zsJE13AEgm0+clDwsKGG/CLlOOoVBQ05akT+IeZs7ll9DAmjK9YmIBnjxTUGD1X21U
         c+VadFq3hhB1s5GTPXniDXEpnH4aAphRpJNJmB9beMigKL72bG2a3YruoCZOreET2ufa
         4nxMwctWBRYLO6pXHOh68tjCtgPGspsPXSRz1coxC5NnNZMBlmb/sguPSCpfJmmBBzry
         +uDJjCQ6lzoQDUFwb7l1SqWscyd0QlrP4k5/mkSpWcDLhX3Wabv4A02MWPo2Dah3IhAF
         AvDkw8NbMM/9IP88gqXFE6Bim3e9Rswu4GbX9CfpWXV1wSnubD4BWfM7xrmPAQquvtu3
         M9tA==
X-Gm-Message-State: ANoB5plXP0ICRv0EPgwq3zygbpcoVLRKJTetUROIFmHobwJQVihx7fvX
        Sr6MlS1T+zQdeDcRF2/0yWklVj1fqJwsobi4trFtXDjq9ROGVQ==
X-Google-Smtp-Source: AA0mqf7qUjX7ETFUw1llimUeGEmRatqf6MC1xyEBpmhNirxzWuT7/GMdS+rYw1wto7YfXyCnYH8+fegRD3aHlyiojxE=
X-Received: by 2002:a05:600c:4920:b0:3cf:8b23:549c with SMTP id
 f32-20020a05600c492000b003cf8b23549cmr35258619wmp.174.1669784482752; Tue, 29
 Nov 2022 21:01:22 -0800 (PST)
MIME-Version: 1.0
References: <20221123180208.2068936-1-namhyung@kernel.org> <20221123180208.2068936-15-namhyung@kernel.org>
 <CAP-5=fVJjPXk2hmWc6xqDxe06Arq-nOB51CwihAuuVFAoaKJ4g@mail.gmail.com>
 <CAM9d7ciARxBRKpwf-8eQr-x5kR8n0Wv3RmycVFdO4ikeYhDVwg@mail.gmail.com>
 <CAP-5=fWF7ScB0kHKQsqePHmg3sJf22TOfvKcNeYQdMoD0p8Tbg@mail.gmail.com> <CAM9d7cj-JeKiHUM1Eq36937q+o+yj=DKwt_pYQLD6aC5zCTN+Q@mail.gmail.com>
In-Reply-To: <CAM9d7cj-JeKiHUM1Eq36937q+o+yj=DKwt_pYQLD6aC5zCTN+Q@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 29 Nov 2022 21:01:11 -0800
Message-ID: <CAP-5=fXu-LD9fFzB4+A=xxq0St2MipfJO3XkGLovrZLqQumbFA@mail.gmail.com>
Subject: Re: [PATCH 14/15] perf stat: Rename "aggregate-number" to "cpu-count"
 in JSON
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>
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

On Tue, Nov 29, 2022 at 2:46 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> On Sat, Nov 26, 2022 at 7:14 PM Ian Rogers <irogers@google.com> wrote:
> >
> > On Thu, Nov 24, 2022 at 11:51 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > Hi Ian,
> > >
> > > On Wed, Nov 23, 2022 at 3:31 PM Ian Rogers <irogers@google.com> wrote:
> > > >
> > > > On Wed, Nov 23, 2022 at 10:02 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > >
> > > > > As the JSON output has been broken for a little while, I guess there are
> > > > > not many users.  Let's rename the field to more intuitive one. :)
> > > >
> > > > I'm not sure cpu-count is accurate. For example, an uncore counter in
> > > > a dual socket machine may have a CPU mask of "0, 36", ie one event per
> > > > socket. The aggregate-number in this case I believe is 2.
> > >
> > > You're right.  In case of uncore events, it can be confusing.  But in some
> > > sense it could be thought as cpu count as well since it aggregates the
> > > result from two cpus anyway. :)
> > >
> > > Note that the aggregate-number (or cpu-count) is only printed if users
> > > requested one of aggregation options like --per-socket or --per-core.
> > > In your example, then it could print 1 for each socket.
> > >
> > > But I think uncore events are different from core events, and hopefully
> > > they have separate instances for different sockets or something already.
> > > That means it doesn't need to use those aggregation options for them.
> > >
> > > Also the CSV output uses "cpus" for the same information.  It'd be nice
> > > we could have consistency.
> >
> > So in the original patch from Claire she'd passed the name "number"
> > through to the json from the stat code. Having an integer called
> > "number" isn't exactly intention revealing - thank you for your clean
> > up work! :-) I switched "number" to be "aggregate number" as the
> > number comes from the "data" aggregated and the code refers to it as
> > aggregate data. I think aggregate-number is more consistent with the
> > code, and cpu-count would look strange in the uncore case above where
> > the number of CPUs (really hyperthreads) is 72. Perhaps we should also
> > be outputting the aggregation mode with the number. Anyway, I think
> > for the patch series I'd prefer we skipped this one and kept the rest.
>
> Right, I think we need a more general term to include non-cpu events.
> But it seems Arnaldo already merged it.
>
> Arnaldo, do you want me to send a revert?
>
> Thanks,
> Namhyung

This is also breaking the json output test:

$ perf test -vv 89
89: perf stat JSON output linter                                    :
--- start ---
test child forked, pid 2116261
Checking json output: no args [Success]
Checking json output: system wide [Success]
Checking json output: interval [Success]
Checking json output: event [Success]
Checking json output: per thread [Success]
Checking json output: per node Test failed for input:
{"node" : "N0", "cpu-count" : 16, "counter-value" : "32.468431",
"unit" : "msec", "event" : "cpu-clo
ck", "event-runtime" : 32498339, "pcnt-running" : 100.00,
"metric-value" : 19.450525, "metric-unit"
: "CPUs utilized"}

{"node" : "N0", "cpu-count" : 16, "counter-value" : "52.000000",
"unit" : "", "event" : "context-swi
tches", "event-runtime" : 32471361, "pcnt-running" : 100.00,
"metric-value" : 1.601556, "metric-unit
" : "K/sec"}

{"node" : "N0", "cpu-count" : 16, "counter-value" : "16.000000",
"unit" : "", "event" : "cpu-migrati
ons", "event-runtime" : 32469950, "pcnt-running" : 100.00,
"metric-value" : 492.786362, "metric-unit
" : "/sec"}

{"node" : "N0", "cpu-count" : 16, "counter-value" : "57.000000",
"unit" : "", "event" : "page-faults
", "event-runtime" : 32474408, "pcnt-running" : 100.00, "metric-value"
: 1.755551, "metric-unit" : "
K/sec"}

{"node" : "N0", "cpu-count" : 16, "counter-value" : "2958499.000000",
"unit" : "", "event" : "cycles
", "event-runtime" : 32411643, "pcnt-running" : 100.00, "metric-value"
: 0.091119, "metric-unit" : "
GHz"}

{"node" : "N0", "cpu-count" : 16, "counter-value" : "3175893.000000",
"unit" : "", "event" : "instru
ctions", "event-runtime" : 32403573, "pcnt-running" : 100.00,
"metric-value" : 1.073481, "metric-uni
t" : "insn per cycle"}

{"node" : "N0", "cpu-count" : 16, "counter-value" : "688120.000000",
"unit" : "", "event" : "branche
s", "event-runtime" : 32391536, "pcnt-running" : 100.00,
"metric-value" : 21.193509, "metric-unit" :
"M/sec"}

{"node" : "N0", "cpu-count" : 16, "counter-value" : "17584.000000",
"unit" : "", "event" : "branch-m
isses", "event-runtime" : 32371972, "pcnt-running" : 100.00,
"metric-value" : 2.555368, "metric-unit
" : "of all branches"}

{"node" : "N0", "cpu-count" : 16, "counter-value" : "14377890.000000",
"unit" : "", "event" : "slots
", "event-runtime" : 32350026, "pcnt-running" : 100.00, "metric-value"
: 442.826757, "metric-unit" :
"M/sec"}

{"node" : "N0", "cpu-count" : 16, "counter-value" : "3380921.000000",
"unit" : "", "event" : "topdow
n-retiring", "event-runtime" : 32350026, "pcnt-running" : 100.00,
"metric-value" : 23.514767, "metri
c-unit" : "Retiring"}

{"node" : "N0", "cpu-count" : 16, "counter-value" : "1444174.000000",
"unit" : "", "event" : "topdow
n-bad-spec", "event-runtime" : 32350026, "pcnt-running" : 100.00,
"metric-value" : 10.044427, "metri
c-unit" : "Bad Speculation"}

{"node" : "N0", "cpu-count" : 16, "counter-value" : "5899393.000000",
"unit" : "", "event" : "topdow
n-fe-bound", "event-runtime" : 32350026, "pcnt-running" : 100.00,
"metric-value" : 41.031084, "metri
c-unit" : "Frontend Bound"}

{"node" : "N0", "cpu-count" : 16, "counter-value" : "3653375.000000",
"unit" : "", "event" : "topdow
n-be-bound", "event-runtime" : 32350026, "pcnt-running" : 100.00,
"metric-value" : 25.409722, "metri
c-unit" : "Backend Bound"}

Traceback (most recent call last):
 File "/home/irogers/kernel.org/./tools/perf/tests/shell/lib/perf_json_output_lint.py",
line 93, in
<module>
   check_json_output(expected_items)
 File "/home/irogers/kernel.org/./tools/perf/tests/shell/lib/perf_json_output_lint.py",
line 78, in
check_json_output
   raise RuntimeError(f'Unexpected key: key={key} value={value}')
RuntimeError: Unexpected key: key=cpu-count value=16
test child finished with -1
---- end ----
perf stat JSON output linter: FAILED!

Thanks,
Ian
