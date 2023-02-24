Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70FD76A170B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 08:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjBXHZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 02:25:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjBXHZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 02:25:41 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE3E1EBDF;
        Thu, 23 Feb 2023 23:25:39 -0800 (PST)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PNLvr5jszznWTZ;
        Fri, 24 Feb 2023 15:23:04 +0800 (CST)
Received: from M910t (10.110.54.157) by kwepemi500013.china.huawei.com
 (7.221.188.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Fri, 24 Feb
 2023 15:25:34 +0800
Date:   Fri, 24 Feb 2023 15:25:01 +0800
From:   Changbin Du <changbin.du@huawei.com>
To:     Namhyung Kim <namhyung@kernel.org>
CC:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Changbin Du <changbin.du@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Rogers <irogers@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Hui Wang <hw.huiwang@huawei.com>
Subject: Re: [PATCH] perf: fix counting when initial delay configured
Message-ID: <20230224072501.r6khif73pg27xe5l@M910t>
References: <20230223075800.1795777-1-changbin.du@huawei.com>
 <Y/dt6QpsCj5AAUE/@kernel.org>
 <CAM9d7cgwP1ra44oJeWO3y+XviXJyZmR4wrgdizK1UhYEw9w6jg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAM9d7cgwP1ra44oJeWO3y+XviXJyZmR4wrgdizK1UhYEw9w6jg@mail.gmail.com>
X-Originating-IP: [10.110.54.157]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 02:48:26PM -0800, Namhyung Kim wrote:
> Hello,
> 
> On Thu, Feb 23, 2023 at 5:45 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Thu, Feb 23, 2023 at 03:58:00PM +0800, Changbin Du escreveu:
> > > When creating counters with initial delay configured, the enable_on_exec
> > > field is not set. So we need to enable the counters later. The problem
> > > is, when a workload is specified the target__none() is still true. So
> > > we also need to check stat_config.initial_delay.
> > >
> > > Before this fix the event is not counted:
> > > $ ./perf stat -e instructions -D 100 sleep 2
> > > Events disabled
> > > Events enabled
> > >
> > >  Performance counter stats for 'sleep 2':
> > >
> > >      <not counted>      instructions
> > >
> > >        1.901661124 seconds time elapsed
> > >
> > >        0.001602000 seconds user
> > >        0.000000000 seconds sys
> > >
> > > After fix it works:
> > > $ ./perf stat -e instructions -D 100 sleep 2
> > > Events disabled
> > > Events enabled
> > >
> > >  Performance counter stats for 'sleep 2':
> > >
> > >            404,214      instructions
> > >
> > >        1.901743475 seconds time elapsed
> > >
> > >        0.001617000 seconds user
> > >        0.000000000 seconds sys
> > >
> > > Fixes: c587e77e100f ("perf stat: Do not delay the workload with --delay")
> >
> > Yeap, even the comment states that we need to enable when initial_delay
> > is set :-)
> 
> Right, but the logic that checks the initial_delay is placed
> out of the function.  Just checking the initial_delay value
> can be confusing as it can have a negative value.
> 
> Maybe we can add an argument (bool force?) to the
> enable_counters() function.
>
Yes, it could be done.

Maybe we can fold the 'initial_delay' into 'struct target', and provide
consistent behaviour for all subcommands. Here I add a
target__enable_counter_on_exec() to determine whether enable_on_exec should
set for all counters.

$ git diff -U1
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index c71d85577de6..e807be2214c7 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -541,8 +541,3 @@ static int enable_counters(void)

-       /*
-        * We need to enable counters only if:
-        * - we don't have tracee (attaching to task or cpu)
-        * - we have initial delay configured
-        */
-       if (!target__none(&target) || stat_config.initial_delay) {
+       if (!target__enable_counter_on_exec(&target)) {
                if (!all_counters_use_bpf)
@@ -916,3 +911,3 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)

-       if (stat_config.initial_delay) {
+       if (target.initial_delay) {
                pr_info(EVLIST_DISABLED_MSG);
@@ -928,4 +923,4 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)

-       if (stat_config.initial_delay > 0) {
-               usleep(stat_config.initial_delay * USEC_PER_MSEC);
+       if (target.initial_delay > 0) {
+               usleep(target.initial_delay * USEC_PER_MSEC);
                err = enable_counters();
@@ -1250,3 +1245,3 @@ static struct option stat_options[] = {
                     "aggregate counts per numa node", AGGR_NODE),
-       OPT_INTEGER('D', "delay", &stat_config.initial_delay,
+       OPT_INTEGER('D', "delay", &target.initial_delay,
                    "ms to wait before starting measurement after program start (-1: start with events disabled)"),
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 534d36d26fc3..40984d124db1 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -848,3 +848,3 @@ int create_perf_stat_counter(struct evsel *evsel,
                 */
-               if (target__none(target) && !config->initial_delay)
+               if (target__enable_counter_on_exec(target))
                        attr->enable_on_exec = 1;
diff --git a/tools/perf/util/target.h b/tools/perf/util/target.h
index daec6cba500d..a6721b644bfb 100644
--- a/tools/perf/util/target.h
+++ b/tools/perf/util/target.h
@@ -20,2 +20,3 @@ struct target {
        bool         hybrid;
+       int          initial_delay;
        const char   *attr_map;
@@ -74,2 +75,7 @@ static inline bool target__none(struct target *target)

+static inline bool target__enable_counter_on_exec(struct target *target)
+{
+       return target__none(target) && !target->initial_delay;
+}
+

> Thanks,
> Namhyung
> 
> 
> >
> > I added the additional test output below.
> >
> > Namhyung, can you please ack it?
> >
> > - Arnaldo
> >
> > Committer testing:
> >
> > Before:
> >
> > Lets use stress-ng so that we have lots of samples using a CPU stressor
> > and also intermingle the workload output with the messages about when
> > the events get enabled (i.e. later on in the workload):
> >
> >   $ perf stat -e instructions -D 100 stress-ng -c 32 -t 1
> >   Events disabled
> >   stress-ng: info:  [38361] setting to a 1 second run per stressor
> >   stress-ng: info:  [38361] dispatching hogs: 32 cpu
> >   Events enabled
> >   stress-ng: info:  [38361] successful run completed in 1.01s
> >
> >    Performance counter stats for 'stress-ng -c 32 -t 1':
> >
> >        <not counted>      instructions:u
> >
> >          0.916479141 seconds time elapsed
> >
> >         30.868003000 seconds user
> >          0.049851000 seconds sys
> >
> >
> >   Some events weren't counted. Try disabling the NMI watchdog:
> >         echo 0 > /proc/sys/kernel/nmi_watchdog
> >         perf stat ...
> >         echo 1 > /proc/sys/kernel/nmi_watchdog
> >   $
> >
> > After the fix:
> >
> >   $ perf stat -e instructions -D 100 stress-ng -c 32 -t 1
> >   Events disabled
> >   stress-ng: info:  [40429] setting to a 1 second run per stressor
> >   stress-ng: info:  [40429] dispatching hogs: 32 cpu
> >   Events enabled
> >   stress-ng: info:  [40429] successful run completed in 1.01s
> >
> >    Performance counter stats for 'stress-ng -c 32 -t 1':
> >
> >         154117865145      instructions:u
> >
> >          0.920827644 seconds time elapsed
> >
> >         30.864753000 seconds user
> >          0.073862000 seconds sys
> >
> >
> >   $
> >
> > > Signed-off-by: Changbin Du <changbin.du@huawei.com>
> > > ---
> > >  tools/perf/builtin-stat.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > > index 9f3e4b257516..c71d85577de6 100644
> > > --- a/tools/perf/builtin-stat.c
> > > +++ b/tools/perf/builtin-stat.c
> > > @@ -544,7 +544,7 @@ static int enable_counters(void)
> > >        * - we don't have tracee (attaching to task or cpu)
> > >        * - we have initial delay configured
> > >        */
> > > -     if (!target__none(&target)) {
> > > +     if (!target__none(&target) || stat_config.initial_delay) {
> > >               if (!all_counters_use_bpf)
> > >                       evlist__enable(evsel_list);
> > >       }
> > > --
> > > 2.25.1
> > >
> >
> > --
> >
> > - Arnaldo
> 

-- 
Cheers,
Changbin Du
