Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2757063CEA0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 06:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233318AbiK3FOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 00:14:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233406AbiK3FN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 00:13:58 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226707CAA4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 21:13:24 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id bx10so13237550wrb.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 21:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w+wGZ3Sbel3UQRXBbOEy+DgtVblofGm23rCMoKJuQgI=;
        b=bbb5xXatzlxx5fS7vkdHmpPTzOkAj5PxBk2ILGWuvWh/g9F0oTS/fodG1FthzbilGd
         eOh1YRJEcntPyn9Ate2aiP+hzkhGolgTpDkPJ/1aLLCnl7jowAMSWNx8IS620y49G7CX
         Hxxazn+90gT1s0x/t0sKPkkM6fDtR8nTwv7h7CvouTmST8khUg7/CEibULlAItjHBbBx
         1NqGY2LmVP/YNN51oRcI/ifjb41zkc25/xCzn0OxNsr2Z3pCbRcapfy4IkIuVMBcVidX
         Hs7RkEL1Z4VrKV/+ptq75As7TkZChzdQYim5oce0Q5jW8cTgvMKxBKPd1R5PpxcNnw/N
         0HHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w+wGZ3Sbel3UQRXBbOEy+DgtVblofGm23rCMoKJuQgI=;
        b=q/RRaQdRAfvFgkYjM4gGmLXk6d3URQPw/lsI9JwgrHOlL1u3m8KOS43cUanaWbGiFL
         EBebo0IXn1aG2UDXQRcwp7EXr6TqrohLw5dp1nKS8X5jNGbQXflfLGMopjKk34kyXWB6
         n2YRt/LMPpn/JN9f5VRC247LvhrmP/4annCHGMUFCp9w1qNftGhchw0Cn8k8DvDQaj+t
         chfj/fQvaqxVyA3eSnyjCpax+nHnc8ytqpkR6LMtfGlkGlRzPjm59A9NPgsh4mKAxSXj
         JPt+7B/ifDnf4GBwh0R6ZOjv/shXiXO0gYRaCXscJ3m+nUWjS2jkRBTNMG8odj0hopKg
         jOzQ==
X-Gm-Message-State: ANoB5plStCB71+6RW9Wlb1xFM4+I9wGOoFGmdPfwscAremeNOvHyIxjs
        3YnyeT8xc51mbcmsRvxN6FoC1JdKzPPYhVvi8BDG8Q==
X-Google-Smtp-Source: AA0mqf4NrJbudJHMxKNsZQpYLaQB4gnadd5Qs4iPDuy9nNKv/1oNIfVoIt1Aq7L9Y0iwqf5Nu/F+VSVcCXFaxrcEuj0=
X-Received: by 2002:a5d:680c:0:b0:242:a38:d0c6 with SMTP id
 w12-20020a5d680c000000b002420a38d0c6mr13072467wru.375.1669785202445; Tue, 29
 Nov 2022 21:13:22 -0800 (PST)
MIME-Version: 1.0
References: <20221123180208.2068936-1-namhyung@kernel.org> <20221123180208.2068936-6-namhyung@kernel.org>
 <CAP-5=fWZ27QW+XvZx0bzEMmUbyKpmmmZudB9u=SyxiLcH3CCqw@mail.gmail.com> <CAP-5=fXsWfOmavOAmxsUcX+g3cve2r20JmseDF7Bn1jO6tPX-Q@mail.gmail.com>
In-Reply-To: <CAP-5=fXsWfOmavOAmxsUcX+g3cve2r20JmseDF7Bn1jO6tPX-Q@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 29 Nov 2022 21:13:11 -0800
Message-ID: <CAP-5=fUOjSM5HajU9TCD6prY39LbX4OQbkEbtKPPGRBPBN=_VQ@mail.gmail.com>
Subject: Re: [PATCH 05/15] perf stat: Remove prefix argument in print_metric_headers()
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

On Tue, Nov 29, 2022 at 9:09 PM Ian Rogers <irogers@google.com> wrote:
>
> On Wed, Nov 23, 2022 at 3:23 PM Ian Rogers <irogers@google.com> wrote:
> >
> > On Wed, Nov 23, 2022 at 10:02 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > It always passes a whitespace to the function, thus we can just add it to the
> > > function body.  Furthermore, it's only used in the normal output mode.
> > >
> > > Well, actually CSV used it but it doesn't need to since we don't care about the
> > > indentation or alignment in the CSV output.
> > >
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> >
> > Acked-by: Ian Rogers <irogers@google.com>
> >
> > Thanks,
> > Ian
>
> I suspect this may be responsible for a metric segv that I'm now
> seeing in Arnaldo's tree:
>
> $ gdb --args perf stat -M Backend true
> ...
> Performance counter stats for 'true':
>
>         4,712,355      TOPDOWN.SLOTS                    #     17.3 %
> tma_core_bound
>
> Program received signal SIGSEGV, Segmentation fault.
> __strlen_evex () at ../sysdeps/x86_64/multiarch/strlen-evex.S:77
> 77      ../sysdeps/x86_64/multiarch/strlen-evex.S: No such file or directory.
> (gdb) bt
> #0  __strlen_evex () at ../sysdeps/x86_64/multiarch/strlen-evex.S:77
> #1  0x00007ffff74749a5 in __GI__IO_fputs (str=0x0, fp=0x7ffff75f5680
> <_IO_2_1_stderr_>)
>    at ./libio/iofputs.c:33
> #2  0x0000555555779f28 in do_new_line_std (config=0x555555e077c0
> <stat_config>, os=0x7fffffffbf10)
>    at util/stat-display.c:356
> #3  0x000055555577a081 in print_metric_std (config=0x555555e077c0
> <stat_config>,
>    ctx=0x7fffffffbf10, color=0x0, fmt=0x5555558b77b5 "%8.1f",
>    unit=0x7fffffffbb10 "%  tma_memory_bound", val=13.165355724442199)
> at util/stat-display.c:380
> #4  0x00005555557768b6 in generic_metric (config=0x555555e077c0 <stat_config>,
>    metric_expr=0x55555593d5b7 "((CYCLE_ACTIVITY.STALLS_MEM_ANY +
> EXE_ACTIVITY.BOUND_ON_STORES) / (C
> YCLE_ACTIVITY.STALLS_TOTAL + (EXE_ACTIVITY.1_PORTS_UTIL + tma_retiring
> * EXE_ACTIVITY.2_PORTS_UTIL)
> + EXE_ACTIVITY.BOUND_ON_STORES))"..., metric_events=0x555555f334e0,
> metric_refs=0x555555ec81d0,
>    name=0x555555f32e80 "TOPDOWN.SLOTS", metric_name=0x555555f26c80
> "tma_memory_bound",
>    metric_unit=0x55555593d5b1 "100%", runtime=0, map_idx=0,
> out=0x7fffffffbd90,
>    st=0x555555e9e620 <rt_stat>) at util/stat-shadow.c:934
> #5  0x0000555555778cac in perf_stat__print_shadow_stats
> (config=0x555555e077c0 <stat_config>,
>    evsel=0x555555f289d0, avg=4712355, map_idx=0, out=0x7fffffffbd90,
>    metric_events=0x555555e078e8 <stat_config+296>, st=0x555555e9e620 <rt_stat>)
>    at util/stat-shadow.c:1329
> #6  0x000055555577b6a0 in printout (config=0x555555e077c0
> <stat_config>, os=0x7fffffffbf10,
>    uval=4712355, run=325322, ena=325322, noise=4712355, map_idx=0) at
> util/stat-display.c:741
> #7  0x000055555577bc74 in print_counter_aggrdata
> (config=0x555555e077c0 <stat_config>,
>    counter=0x555555f289d0, s=0, os=0x7fffffffbf10) at util/stat-display.c:838
> #8  0x000055555577c1d8 in print_counter (config=0x555555e077c0 <stat_config>,
>    counter=0x555555f289d0, os=0x7fffffffbf10) at util/stat-display.c:957
> #9  0x000055555577dba0 in evlist__print_counters (evlist=0x555555ec3610,
>    config=0x555555e077c0 <stat_config>, _target=0x555555e01c80
> <target>, ts=0x0, argc=1,
>    argv=0x7fffffffe450) at util/stat-display.c:1413
> #10 0x00005555555fc821 in print_counters (ts=0x0, argc=1, argv=0x7fffffffe450)
>    at builtin-stat.c:1040
> #11 0x000055555560091a in cmd_stat (argc=1, argv=0x7fffffffe450) at
> builtin-stat.c:2665
> #12 0x00005555556b1eea in run_builtin (p=0x555555e11f70
> <commands+336>, argc=4,
>    argv=0x7fffffffe450) at perf.c:322
> #13 0x00005555556b2181 in handle_internal_command (argc=4,
> argv=0x7fffffffe450) at perf.c:376
> #14 0x00005555556b22d7 in run_argv (argcp=0x7fffffffe27c,
> argv=0x7fffffffe270) at perf.c:420
> #15 0x00005555556b26ef in main (argc=4, argv=0x7fffffffe450) at perf.c:550
> (gdb)
>
> Thanks,
> Ian

More specifically, I think os->prefix needs testing for NULL:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/stat-display.c?h=perf/core#n356
so:
fputs(os->prefix, os->fh);
should be:
if (os->prefix)
  fputs(os->prefix, os->fh);

Thanks,
Ian

> > > ---
> > >  tools/perf/util/stat-display.c | 26 ++++++++++----------------
> > >  1 file changed, 10 insertions(+), 16 deletions(-)
> > >
> > > diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> > > index 744b7a40f59a..deed6ccf072f 100644
> > > --- a/tools/perf/util/stat-display.c
> > > +++ b/tools/perf/util/stat-display.c
> > > @@ -996,10 +996,9 @@ static void print_no_aggr_metric(struct perf_stat_config *config,
> > >  }
> > >
> > >  static void print_metric_headers_std(struct perf_stat_config *config,
> > > -                                    const char *prefix, bool no_indent)
> > > +                                    bool no_indent)
> > >  {
> > > -       if (prefix)
> > > -               fprintf(config->output, "%s", prefix);
> > > +       fputc(' ', config->output);
> > >
> > >         if (!no_indent) {
> > >                 int len = aggr_header_lens[config->aggr_mode];
> > > @@ -1012,11 +1011,8 @@ static void print_metric_headers_std(struct perf_stat_config *config,
> > >  }
> > >
> > >  static void print_metric_headers_csv(struct perf_stat_config *config,
> > > -                                    const char *prefix,
> > >                                      bool no_indent __maybe_unused)
> > >  {
> > > -       if (prefix)
> > > -               fprintf(config->output, "%s", prefix);
> > >         if (config->interval)
> > >                 fputs("time,", config->output);
> > >         if (!config->iostat_run)
> > > @@ -1024,7 +1020,6 @@ static void print_metric_headers_csv(struct perf_stat_config *config,
> > >  }
> > >
> > >  static void print_metric_headers_json(struct perf_stat_config *config,
> > > -                                     const char *prefix __maybe_unused,
> > >                                       bool no_indent __maybe_unused)
> > >  {
> > >         if (config->interval)
> > > @@ -1032,8 +1027,7 @@ static void print_metric_headers_json(struct perf_stat_config *config,
> > >  }
> > >
> > >  static void print_metric_headers(struct perf_stat_config *config,
> > > -                                struct evlist *evlist,
> > > -                                const char *prefix, bool no_indent)
> > > +                                struct evlist *evlist, bool no_indent)
> > >  {
> > >         struct evsel *counter;
> > >         struct outstate os = {
> > > @@ -1047,11 +1041,11 @@ static void print_metric_headers(struct perf_stat_config *config,
> > >         };
> > >
> > >         if (config->json_output)
> > > -               print_metric_headers_json(config, prefix, no_indent);
> > > +               print_metric_headers_json(config, no_indent);
> > >         else if (config->csv_output)
> > > -               print_metric_headers_csv(config, prefix, no_indent);
> > > +               print_metric_headers_csv(config, no_indent);
> > >         else
> > > -               print_metric_headers_std(config, prefix, no_indent);
> > > +               print_metric_headers_std(config, no_indent);
> > >
> > >         if (config->iostat_run)
> > >                 iostat_print_header_prefix(config);
> > > @@ -1132,7 +1126,7 @@ static void print_header_interval_std(struct perf_stat_config *config,
> > >         }
> > >
> > >         if (config->metric_only)
> > > -               print_metric_headers(config, evlist, " ", true);
> > > +               print_metric_headers(config, evlist, true);
> > >         else
> > >                 fprintf(output, " %*s %*s events\n",
> > >                         COUNTS_LEN, "counts", config->unit_width, "unit");
> > > @@ -1168,7 +1162,7 @@ static void print_header_std(struct perf_stat_config *config,
> > >         fprintf(output, ":\n\n");
> > >
> > >         if (config->metric_only)
> > > -               print_metric_headers(config, evlist, " ", false);
> > > +               print_metric_headers(config, evlist, false);
> > >  }
> > >
> > >  static void print_header_csv(struct perf_stat_config *config,
> > > @@ -1178,7 +1172,7 @@ static void print_header_csv(struct perf_stat_config *config,
> > >                              const char **argv __maybe_unused)
> > >  {
> > >         if (config->metric_only)
> > > -               print_metric_headers(config, evlist, " ", true);
> > > +               print_metric_headers(config, evlist, true);
> > >  }
> > >  static void print_header_json(struct perf_stat_config *config,
> > >                               struct target *_target __maybe_unused,
> > > @@ -1187,7 +1181,7 @@ static void print_header_json(struct perf_stat_config *config,
> > >                               const char **argv __maybe_unused)
> > >  {
> > >         if (config->metric_only)
> > > -               print_metric_headers(config, evlist, " ", true);
> > > +               print_metric_headers(config, evlist, true);
> > >  }
> > >
> > >  static void print_header(struct perf_stat_config *config,
> > > --
> > > 2.38.1.584.g0f3c55d4c2-goog
> > >
