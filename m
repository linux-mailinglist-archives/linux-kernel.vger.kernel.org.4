Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB2E6A12F7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 23:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjBWWst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 17:48:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjBWWsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 17:48:41 -0500
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D9D58B70;
        Thu, 23 Feb 2023 14:48:38 -0800 (PST)
Received: by mail-vs1-f46.google.com with SMTP id f31so18288607vsv.1;
        Thu, 23 Feb 2023 14:48:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oHMjpTxClSIg+L1M1jMF9kWQNxpNp0ehcRQMMzgVYio=;
        b=UxBiUguVba98KFpa9SFh6TO4Ev9mlp1PaI+DreA6P2eYUdnUS7H1Whyyvc2d9+II9q
         Cp5WSPmhE6yDjRFxKvzywGmSjo5DwGt5a03g3/XHYwT59/Kk1kBZC8eqEtIsfFTb8hzO
         PuWUXg4rmxjpsGlR8E+RBZntEIsa59cAuXHEF2DuUJ4pZfQiU3EGzzWFZIx2BJVEP0j7
         ZV1wqoKm12hVfaUq90ZIOFpvynScq2D7DVHvhXvrq4OgR1rCxHNz6mmcbpmyH8uKTPri
         2OfEZe0M1v2Yu2xAoHZni4BrBmGT2hUs/3PMotDlpPTLrz+F9sd849tVV4Wmj6Oh0lBi
         JjHQ==
X-Gm-Message-State: AO0yUKUGRjn7vzK1qBqtXmYR5UfTy0g18XQV6XJ88DcQgJpVUhiqIGSK
        ign1jGJpcMh5AsqCwHjRgTffLDWsq8kSB3O/u0o=
X-Google-Smtp-Source: AK7set9/9BwQxNLEoH7DgSRqN5o2EtQHS3IVRtIrSNXf5PLIBKinCKxvtc58mzbP/ZuHVKYfOaKW2vXR3FLxsP8n+Ew=
X-Received: by 2002:a67:d893:0:b0:40d:68b8:6577 with SMTP id
 f19-20020a67d893000000b0040d68b86577mr1003403vsj.2.1677192517738; Thu, 23 Feb
 2023 14:48:37 -0800 (PST)
MIME-Version: 1.0
References: <20230223075800.1795777-1-changbin.du@huawei.com> <Y/dt6QpsCj5AAUE/@kernel.org>
In-Reply-To: <Y/dt6QpsCj5AAUE/@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 23 Feb 2023 14:48:26 -0800
Message-ID: <CAM9d7cgwP1ra44oJeWO3y+XviXJyZmR4wrgdizK1UhYEw9w6jg@mail.gmail.com>
Subject: Re: [PATCH] perf: fix counting when initial delay configured
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Changbin Du <changbin.du@huawei.com>,
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

Hello,

On Thu, Feb 23, 2023 at 5:45 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Thu, Feb 23, 2023 at 03:58:00PM +0800, Changbin Du escreveu:
> > When creating counters with initial delay configured, the enable_on_exec
> > field is not set. So we need to enable the counters later. The problem
> > is, when a workload is specified the target__none() is still true. So
> > we also need to check stat_config.initial_delay.
> >
> > Before this fix the event is not counted:
> > $ ./perf stat -e instructions -D 100 sleep 2
> > Events disabled
> > Events enabled
> >
> >  Performance counter stats for 'sleep 2':
> >
> >      <not counted>      instructions
> >
> >        1.901661124 seconds time elapsed
> >
> >        0.001602000 seconds user
> >        0.000000000 seconds sys
> >
> > After fix it works:
> > $ ./perf stat -e instructions -D 100 sleep 2
> > Events disabled
> > Events enabled
> >
> >  Performance counter stats for 'sleep 2':
> >
> >            404,214      instructions
> >
> >        1.901743475 seconds time elapsed
> >
> >        0.001617000 seconds user
> >        0.000000000 seconds sys
> >
> > Fixes: c587e77e100f ("perf stat: Do not delay the workload with --delay")
>
> Yeap, even the comment states that we need to enable when initial_delay
> is set :-)

Right, but the logic that checks the initial_delay is placed
out of the function.  Just checking the initial_delay value
can be confusing as it can have a negative value.

Maybe we can add an argument (bool force?) to the
enable_counters() function.

Thanks,
Namhyung


>
> I added the additional test output below.
>
> Namhyung, can you please ack it?
>
> - Arnaldo
>
> Committer testing:
>
> Before:
>
> Lets use stress-ng so that we have lots of samples using a CPU stressor
> and also intermingle the workload output with the messages about when
> the events get enabled (i.e. later on in the workload):
>
>   $ perf stat -e instructions -D 100 stress-ng -c 32 -t 1
>   Events disabled
>   stress-ng: info:  [38361] setting to a 1 second run per stressor
>   stress-ng: info:  [38361] dispatching hogs: 32 cpu
>   Events enabled
>   stress-ng: info:  [38361] successful run completed in 1.01s
>
>    Performance counter stats for 'stress-ng -c 32 -t 1':
>
>        <not counted>      instructions:u
>
>          0.916479141 seconds time elapsed
>
>         30.868003000 seconds user
>          0.049851000 seconds sys
>
>
>   Some events weren't counted. Try disabling the NMI watchdog:
>         echo 0 > /proc/sys/kernel/nmi_watchdog
>         perf stat ...
>         echo 1 > /proc/sys/kernel/nmi_watchdog
>   $
>
> After the fix:
>
>   $ perf stat -e instructions -D 100 stress-ng -c 32 -t 1
>   Events disabled
>   stress-ng: info:  [40429] setting to a 1 second run per stressor
>   stress-ng: info:  [40429] dispatching hogs: 32 cpu
>   Events enabled
>   stress-ng: info:  [40429] successful run completed in 1.01s
>
>    Performance counter stats for 'stress-ng -c 32 -t 1':
>
>         154117865145      instructions:u
>
>          0.920827644 seconds time elapsed
>
>         30.864753000 seconds user
>          0.073862000 seconds sys
>
>
>   $
>
> > Signed-off-by: Changbin Du <changbin.du@huawei.com>
> > ---
> >  tools/perf/builtin-stat.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > index 9f3e4b257516..c71d85577de6 100644
> > --- a/tools/perf/builtin-stat.c
> > +++ b/tools/perf/builtin-stat.c
> > @@ -544,7 +544,7 @@ static int enable_counters(void)
> >        * - we don't have tracee (attaching to task or cpu)
> >        * - we have initial delay configured
> >        */
> > -     if (!target__none(&target)) {
> > +     if (!target__none(&target) || stat_config.initial_delay) {
> >               if (!all_counters_use_bpf)
> >                       evlist__enable(evsel_list);
> >       }
> > --
> > 2.25.1
> >
>
> --
>
> - Arnaldo
