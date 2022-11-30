Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7941263E29C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 22:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbiK3VVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 16:21:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiK3VVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 16:21:43 -0500
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9C28B190;
        Wed, 30 Nov 2022 13:21:42 -0800 (PST)
Received: by mail-wr1-f51.google.com with SMTP id h11so21897863wrw.13;
        Wed, 30 Nov 2022 13:21:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nfrgQJXgKs3ZfjdSChkmp4Xkqxu/YX7zkn1AJdRRuFs=;
        b=2XO34gz1mmuSzTOFjcPb5iL1nnOTDeHo+bClfo430NP+cXapyD//1wnGTYi7ulEH0/
         rhSCn7Logqh7aFqYjczCDaQXcnvitSh+cGu2OqfH7W7jodfc81hiBX79APqBDQ/+NfqL
         wso/BeNJR7pgbvsm/Wexmrd+oc/t4C7Xxkgx//P1x/fIXubbzwIZulkSeQxon9Zkx27T
         9RWzB3VUP5iZWaa2D4zLcn/uG1Ksc37NsAdb4aojTEnqYdQWH9nnhgWzHTa++zQ0n0Os
         X2sfJpCnLdDT0KMsxRieUeD5IBYGmykPSwAliv5tsfWyaPrBAxLZOV1IhB/sFT3Bj7Y3
         Q0Ew==
X-Gm-Message-State: ANoB5pn2yG26qT1HRpb1bBzJX0g/bHLZ42ZHp8rkFFU2Z4V4SEaNO1U6
        fsfjfTHBZtoAwOg5Qrck9J6WQelNjtB0AUzi3BBGDy3j
X-Google-Smtp-Source: AA0mqf6IQQ71busE+BH4Ytfjffv6UVsttt2Bga2b+quOs/gGuSFFm0YI7Tg9ePnXmHpv3bvxzyhk0otwzpSA13b1yOQ=
X-Received: by 2002:a5d:500e:0:b0:241:c599:6c94 with SMTP id
 e14-20020a5d500e000000b00241c5996c94mr35498283wrt.403.1669843301024; Wed, 30
 Nov 2022 13:21:41 -0800 (PST)
MIME-Version: 1.0
References: <20221123180208.2068936-1-namhyung@kernel.org> <20221123180208.2068936-6-namhyung@kernel.org>
 <CAP-5=fWZ27QW+XvZx0bzEMmUbyKpmmmZudB9u=SyxiLcH3CCqw@mail.gmail.com>
 <CAP-5=fXsWfOmavOAmxsUcX+g3cve2r20JmseDF7Bn1jO6tPX-Q@mail.gmail.com> <CAP-5=fUOjSM5HajU9TCD6prY39LbX4OQbkEbtKPPGRBPBN=_VQ@mail.gmail.com>
In-Reply-To: <CAP-5=fUOjSM5HajU9TCD6prY39LbX4OQbkEbtKPPGRBPBN=_VQ@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 30 Nov 2022 13:21:29 -0800
Message-ID: <CAM9d7ch3KqB2iL7rwz4M6yX_1XvJ5BMytTWdvtfvSeZBgqcAAA@mail.gmail.com>
Subject: Re: [PATCH 05/15] perf stat: Remove prefix argument in print_metric_headers()
To:     Ian Rogers <irogers@google.com>
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
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 9:13 PM Ian Rogers <irogers@google.com> wrote:
>
> On Tue, Nov 29, 2022 at 9:09 PM Ian Rogers <irogers@google.com> wrote:
> >
> > On Wed, Nov 23, 2022 at 3:23 PM Ian Rogers <irogers@google.com> wrote:
> > >
> > > On Wed, Nov 23, 2022 at 10:02 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > > >
> > > > It always passes a whitespace to the function, thus we can just add it to the
> > > > function body.  Furthermore, it's only used in the normal output mode.
> > > >
> > > > Well, actually CSV used it but it doesn't need to since we don't care about the
> > > > indentation or alignment in the CSV output.
> > > >
> > > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > >
> > > Acked-by: Ian Rogers <irogers@google.com>
> > >
> > > Thanks,
> > > Ian
> >
> > I suspect this may be responsible for a metric segv that I'm now
> > seeing in Arnaldo's tree:
> >
> > $ gdb --args perf stat -M Backend true
> > ...
> > Performance counter stats for 'true':
> >
> >         4,712,355      TOPDOWN.SLOTS                    #     17.3 %
> > tma_core_bound
> >
> > Program received signal SIGSEGV, Segmentation fault.
> > __strlen_evex () at ../sysdeps/x86_64/multiarch/strlen-evex.S:77
> > 77      ../sysdeps/x86_64/multiarch/strlen-evex.S: No such file or directory.
> > (gdb) bt
> > #0  __strlen_evex () at ../sysdeps/x86_64/multiarch/strlen-evex.S:77
> > #1  0x00007ffff74749a5 in __GI__IO_fputs (str=0x0, fp=0x7ffff75f5680
> > <_IO_2_1_stderr_>)
> >    at ./libio/iofputs.c:33
> > #2  0x0000555555779f28 in do_new_line_std (config=0x555555e077c0
> > <stat_config>, os=0x7fffffffbf10)
> >    at util/stat-display.c:356
> > #3  0x000055555577a081 in print_metric_std (config=0x555555e077c0
> > <stat_config>,
> >    ctx=0x7fffffffbf10, color=0x0, fmt=0x5555558b77b5 "%8.1f",
> >    unit=0x7fffffffbb10 "%  tma_memory_bound", val=13.165355724442199)
> > at util/stat-display.c:380
> > #4  0x00005555557768b6 in generic_metric (config=0x555555e077c0 <stat_config>,
> >    metric_expr=0x55555593d5b7 "((CYCLE_ACTIVITY.STALLS_MEM_ANY +
> > EXE_ACTIVITY.BOUND_ON_STORES) / (C
> > YCLE_ACTIVITY.STALLS_TOTAL + (EXE_ACTIVITY.1_PORTS_UTIL + tma_retiring
> > * EXE_ACTIVITY.2_PORTS_UTIL)
> > + EXE_ACTIVITY.BOUND_ON_STORES))"..., metric_events=0x555555f334e0,
> > metric_refs=0x555555ec81d0,
> >    name=0x555555f32e80 "TOPDOWN.SLOTS", metric_name=0x555555f26c80
> > "tma_memory_bound",
> >    metric_unit=0x55555593d5b1 "100%", runtime=0, map_idx=0,
> > out=0x7fffffffbd90,
> >    st=0x555555e9e620 <rt_stat>) at util/stat-shadow.c:934
> > #5  0x0000555555778cac in perf_stat__print_shadow_stats
> > (config=0x555555e077c0 <stat_config>,
> >    evsel=0x555555f289d0, avg=4712355, map_idx=0, out=0x7fffffffbd90,
> >    metric_events=0x555555e078e8 <stat_config+296>, st=0x555555e9e620 <rt_stat>)
> >    at util/stat-shadow.c:1329
> > #6  0x000055555577b6a0 in printout (config=0x555555e077c0
> > <stat_config>, os=0x7fffffffbf10,
> >    uval=4712355, run=325322, ena=325322, noise=4712355, map_idx=0) at
> > util/stat-display.c:741
> > #7  0x000055555577bc74 in print_counter_aggrdata
> > (config=0x555555e077c0 <stat_config>,
> >    counter=0x555555f289d0, s=0, os=0x7fffffffbf10) at util/stat-display.c:838
> > #8  0x000055555577c1d8 in print_counter (config=0x555555e077c0 <stat_config>,
> >    counter=0x555555f289d0, os=0x7fffffffbf10) at util/stat-display.c:957
> > #9  0x000055555577dba0 in evlist__print_counters (evlist=0x555555ec3610,
> >    config=0x555555e077c0 <stat_config>, _target=0x555555e01c80
> > <target>, ts=0x0, argc=1,
> >    argv=0x7fffffffe450) at util/stat-display.c:1413
> > #10 0x00005555555fc821 in print_counters (ts=0x0, argc=1, argv=0x7fffffffe450)
> >    at builtin-stat.c:1040
> > #11 0x000055555560091a in cmd_stat (argc=1, argv=0x7fffffffe450) at
> > builtin-stat.c:2665
> > #12 0x00005555556b1eea in run_builtin (p=0x555555e11f70
> > <commands+336>, argc=4,
> >    argv=0x7fffffffe450) at perf.c:322
> > #13 0x00005555556b2181 in handle_internal_command (argc=4,
> > argv=0x7fffffffe450) at perf.c:376
> > #14 0x00005555556b22d7 in run_argv (argcp=0x7fffffffe27c,
> > argv=0x7fffffffe270) at perf.c:420
> > #15 0x00005555556b26ef in main (argc=4, argv=0x7fffffffe450) at perf.c:550
> > (gdb)
> >
> > Thanks,
> > Ian
>
> More specifically, I think os->prefix needs testing for NULL:
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/stat-display.c?h=perf/core#n356
> so:
> fputs(os->prefix, os->fh);
> should be:
> if (os->prefix)
>   fputs(os->prefix, os->fh);

Yep, could you please send it as a formal patch?

Thanks,
Namhyung
