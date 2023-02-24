Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D99B26A2520
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 00:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjBXXhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 18:37:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBXXhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 18:37:00 -0500
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F339D6F022;
        Fri, 24 Feb 2023 15:36:54 -0800 (PST)
Received: by mail-wr1-f54.google.com with SMTP id p8so816244wrt.12;
        Fri, 24 Feb 2023 15:36:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EIuvSI8dsaE1KoLsQ+0gaEIsCp7DxSM01nfe38oAIrA=;
        b=GEOnJ1itjoogkiw/FtOoLuQAFTrn+x4dr5W+JCtA3OonbML6mINZs81me6UcLbn3BK
         ucdF7aJNVlYvFr+IGItho4d0W+QwMQ5iI77gKE78mX4CSizO5t8bCxSE+5DapzalWRIu
         tXGbRjF46/U3miBulmbxOvEjih9VPPD+c43ysOGUNTn1k4ODcbpI+zoJgl0pmh72kxgP
         prwleiWwQBvjZqHh7VDIjBVFkCgXArKiM9xCdA1Zbc9PI55Btovu0NiFMX2+OWgE0oPB
         1G6xWpUjHmiqrWHT6VdeAqGSCSKRB/Ka7G4mHUFSxumakI/6dFJPJyyYtiGBY4C7wGoH
         VH4g==
X-Gm-Message-State: AO0yUKXlU4nAxTwurs8rQtOeQ7HRfg9GXXCKQOcghbXbsqWWXPLSB7kH
        7HmPEwTk0PprS364XGV7iZdXqKfp7HkHIlFf8YU=
X-Google-Smtp-Source: AK7set+w+JQOtXNbJeAxrX4lIdcMUwseYMMDw45KL1lX1fkc6LEsjdfcJ5uQSZIVIySZtjLppZZhks04ZvsOd4NyCIo=
X-Received: by 2002:a05:6000:10c1:b0:2c5:4780:d614 with SMTP id
 b1-20020a05600010c100b002c54780d614mr1570619wrx.4.1677281813131; Fri, 24 Feb
 2023 15:36:53 -0800 (PST)
MIME-Version: 1.0
References: <20230223075800.1795777-1-changbin.du@huawei.com>
 <Y/dt6QpsCj5AAUE/@kernel.org> <CAM9d7cgwP1ra44oJeWO3y+XviXJyZmR4wrgdizK1UhYEw9w6jg@mail.gmail.com>
 <20230224072501.r6khif73pg27xe5l@M910t>
In-Reply-To: <20230224072501.r6khif73pg27xe5l@M910t>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 24 Feb 2023 15:36:41 -0800
Message-ID: <CAM9d7cjmyNsn=OQr2UtH96AbcSAc-X4crr7RcR3NxY3aMM_Wow@mail.gmail.com>
Subject: Re: [PATCH] perf: fix counting when initial delay configured
To:     Changbin Du <changbin.du@huawei.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Rogers <irogers@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hui Wang <hw.huiwang@huawei.com>
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

On Thu, Feb 23, 2023 at 11:25 PM Changbin Du <changbin.du@huawei.com> wrote:
>
> On Thu, Feb 23, 2023 at 02:48:26PM -0800, Namhyung Kim wrote:
> > Hello,
> >
> > On Thu, Feb 23, 2023 at 5:45 AM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > Em Thu, Feb 23, 2023 at 03:58:00PM +0800, Changbin Du escreveu:
> > > > When creating counters with initial delay configured, the enable_on_exec
> > > > field is not set. So we need to enable the counters later. The problem
> > > > is, when a workload is specified the target__none() is still true. So
> > > > we also need to check stat_config.initial_delay.
> > > >
> > > > Before this fix the event is not counted:
> > > > $ ./perf stat -e instructions -D 100 sleep 2
> > > > Events disabled
> > > > Events enabled
> > > >
> > > >  Performance counter stats for 'sleep 2':
> > > >
> > > >      <not counted>      instructions
> > > >
> > > >        1.901661124 seconds time elapsed
> > > >
> > > >        0.001602000 seconds user
> > > >        0.000000000 seconds sys
> > > >
> > > > After fix it works:
> > > > $ ./perf stat -e instructions -D 100 sleep 2
> > > > Events disabled
> > > > Events enabled
> > > >
> > > >  Performance counter stats for 'sleep 2':
> > > >
> > > >            404,214      instructions
> > > >
> > > >        1.901743475 seconds time elapsed
> > > >
> > > >        0.001617000 seconds user
> > > >        0.000000000 seconds sys
> > > >
> > > > Fixes: c587e77e100f ("perf stat: Do not delay the workload with --delay")
> > >
> > > Yeap, even the comment states that we need to enable when initial_delay
> > > is set :-)
> >
> > Right, but the logic that checks the initial_delay is placed
> > out of the function.  Just checking the initial_delay value
> > can be confusing as it can have a negative value.
> >
> > Maybe we can add an argument (bool force?) to the
> > enable_counters() function.
> >
> Yes, it could be done.
>
> Maybe we can fold the 'initial_delay' into 'struct target', and provide
> consistent behaviour for all subcommands. Here I add a
> target__enable_counter_on_exec() to determine whether enable_on_exec should
> set for all counters.

Maybe just target__enable_on_exec() ?  Note that we have
similar logic in the perf record.  Otherwise looks good.

Thanks,
Namhyung

>
> $ git diff -U1
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index c71d85577de6..e807be2214c7 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -541,8 +541,3 @@ static int enable_counters(void)
>
> -       /*
> -        * We need to enable counters only if:
> -        * - we don't have tracee (attaching to task or cpu)
> -        * - we have initial delay configured
> -        */
> -       if (!target__none(&target) || stat_config.initial_delay) {
> +       if (!target__enable_counter_on_exec(&target)) {
>                 if (!all_counters_use_bpf)
> @@ -916,3 +911,3 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>
> -       if (stat_config.initial_delay) {
> +       if (target.initial_delay) {
>                 pr_info(EVLIST_DISABLED_MSG);
> @@ -928,4 +923,4 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>
> -       if (stat_config.initial_delay > 0) {
> -               usleep(stat_config.initial_delay * USEC_PER_MSEC);
> +       if (target.initial_delay > 0) {
> +               usleep(target.initial_delay * USEC_PER_MSEC);
>                 err = enable_counters();
> @@ -1250,3 +1245,3 @@ static struct option stat_options[] = {
>                      "aggregate counts per numa node", AGGR_NODE),
> -       OPT_INTEGER('D', "delay", &stat_config.initial_delay,
> +       OPT_INTEGER('D', "delay", &target.initial_delay,
>                     "ms to wait before starting measurement after program start (-1: start with events disabled)"),
> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> index 534d36d26fc3..40984d124db1 100644
> --- a/tools/perf/util/stat.c
> +++ b/tools/perf/util/stat.c
> @@ -848,3 +848,3 @@ int create_perf_stat_counter(struct evsel *evsel,
>                  */
> -               if (target__none(target) && !config->initial_delay)
> +               if (target__enable_counter_on_exec(target))
>                         attr->enable_on_exec = 1;
> diff --git a/tools/perf/util/target.h b/tools/perf/util/target.h
> index daec6cba500d..a6721b644bfb 100644
> --- a/tools/perf/util/target.h
> +++ b/tools/perf/util/target.h
> @@ -20,2 +20,3 @@ struct target {
>         bool         hybrid;
> +       int          initial_delay;
>         const char   *attr_map;
> @@ -74,2 +75,7 @@ static inline bool target__none(struct target *target)
>
> +static inline bool target__enable_counter_on_exec(struct target *target)
> +{
> +       return target__none(target) && !target->initial_delay;
> +}
> +
>
> > Thanks,
> > Namhyung
> >
> >
> > >
> > > I added the additional test output below.
> > >
> > > Namhyung, can you please ack it?
> > >
> > > - Arnaldo
> > >
> > > Committer testing:
> > >
> > > Before:
> > >
> > > Lets use stress-ng so that we have lots of samples using a CPU stressor
> > > and also intermingle the workload output with the messages about when
> > > the events get enabled (i.e. later on in the workload):
> > >
> > >   $ perf stat -e instructions -D 100 stress-ng -c 32 -t 1
> > >   Events disabled
> > >   stress-ng: info:  [38361] setting to a 1 second run per stressor
> > >   stress-ng: info:  [38361] dispatching hogs: 32 cpu
> > >   Events enabled
> > >   stress-ng: info:  [38361] successful run completed in 1.01s
> > >
> > >    Performance counter stats for 'stress-ng -c 32 -t 1':
> > >
> > >        <not counted>      instructions:u
> > >
> > >          0.916479141 seconds time elapsed
> > >
> > >         30.868003000 seconds user
> > >          0.049851000 seconds sys
> > >
> > >
> > >   Some events weren't counted. Try disabling the NMI watchdog:
> > >         echo 0 > /proc/sys/kernel/nmi_watchdog
> > >         perf stat ...
> > >         echo 1 > /proc/sys/kernel/nmi_watchdog
> > >   $
> > >
> > > After the fix:
> > >
> > >   $ perf stat -e instructions -D 100 stress-ng -c 32 -t 1
> > >   Events disabled
> > >   stress-ng: info:  [40429] setting to a 1 second run per stressor
> > >   stress-ng: info:  [40429] dispatching hogs: 32 cpu
> > >   Events enabled
> > >   stress-ng: info:  [40429] successful run completed in 1.01s
> > >
> > >    Performance counter stats for 'stress-ng -c 32 -t 1':
> > >
> > >         154117865145      instructions:u
> > >
> > >          0.920827644 seconds time elapsed
> > >
> > >         30.864753000 seconds user
> > >          0.073862000 seconds sys
> > >
> > >
> > >   $
> > >
> > > > Signed-off-by: Changbin Du <changbin.du@huawei.com>
> > > > ---
> > > >  tools/perf/builtin-stat.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > > > index 9f3e4b257516..c71d85577de6 100644
> > > > --- a/tools/perf/builtin-stat.c
> > > > +++ b/tools/perf/builtin-stat.c
> > > > @@ -544,7 +544,7 @@ static int enable_counters(void)
> > > >        * - we don't have tracee (attaching to task or cpu)
> > > >        * - we have initial delay configured
> > > >        */
> > > > -     if (!target__none(&target)) {
> > > > +     if (!target__none(&target) || stat_config.initial_delay) {
> > > >               if (!all_counters_use_bpf)
> > > >                       evlist__enable(evsel_list);
> > > >       }
> > > > --
> > > > 2.25.1
> > > >
> > >
> > > --
> > >
> > > - Arnaldo
> >
>
> --
> Cheers,
> Changbin Du
