Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A2C5F6DC7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 20:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbiJFS5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 14:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiJFS5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 14:57:46 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D200B56D4
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 11:57:45 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id bv10so505128wrb.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 11:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8mKJ0wEQw/uac0sVqjEXHxt5FmL3Trd1MpG0kbsz2mE=;
        b=alesL3k8GE8MyME0pCUtIHa0mTamY9Kh3kl4Dv+deBnRZtSRgyhTKgpsP4TQndwtZb
         NGpT/MA0UtqxStPE04ETlYd7RBScjRHoGRyqaV61KfK2FIYikYoPR1Uon6UMN5jqraE0
         i/jJmfiT2/5n/xqR73ZZJ7y4lcYUK/kK0tfCSVWvfkznWckUMrc0u9nNII5dpMwGT8D1
         umkI41XwXXjlctKyaXMPzOrSXY9VBdOUejig9/VUpAGc6hIbD3za++B4Mv7lZD8sxmvn
         uRTy0MhOqvdBegRq8bpx5kuNLfdpNMn4RvqDg2ktdWjGS8GNy1AvfmvTTAcwwCNU+tuV
         4hKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8mKJ0wEQw/uac0sVqjEXHxt5FmL3Trd1MpG0kbsz2mE=;
        b=L9y8QxVwLxWwo1Zi6KPacEL3rbhgEKPGR/axuHBJhP7QmJgGQkNBmHAKtklTMqx1V9
         gOawBkUu+QQJ9vj78xyhn1jZSw9+Z4qfk8J82WCVFlzBzkDuAL9F8dVv0m2ZC1nZm9mT
         4c2JpgQs6zrKEzdJ5Ax9znESqulgNmcc3/VXND4gfmA9UQHx54H1KkNfjxgaAWKIWj0l
         j7Ti+C0H/FHXD5wq3vxxhUqY+rGDBy/qNe5tDGIjGTrT2bbIVWzBJk6T+iEw5/UbKQNF
         qAzhqT8ujU1NEz2EpHARHW/CL7fqUMLu2YFFMd5x2NmwyzBq4HqKN/VR7v1t0yvqeT6l
         DLug==
X-Gm-Message-State: ACrzQf1HeooiZrXYqtnNk951KFtZy5FbqkyaF3zqHeedlKR/IQ9hERXO
        0i0e4bc66rDuHOpQpcEXk+c2zZ1PqRAulTWQ0nqlkQ==
X-Google-Smtp-Source: AMsMyM6eakhgcd+fhmDrhH09uS70axQ1IXX//ONfk77rAwhiF8YzdUTvodmSmhAZBBNoSFGQqIGWpz/8u70ykw2f3KI=
X-Received: by 2002:adf:fd50:0:b0:22e:5503:9c4c with SMTP id
 h16-20020adffd50000000b0022e55039c4cmr889249wrs.375.1665082663664; Thu, 06
 Oct 2022 11:57:43 -0700 (PDT)
MIME-Version: 1.0
References: <20221003204647.1481128-1-namhyung@kernel.org> <20221003204647.1481128-6-namhyung@kernel.org>
In-Reply-To: <20221003204647.1481128-6-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 6 Oct 2022 11:57:31 -0700
Message-ID: <CAP-5=fXPwJsCX3DsCn78aW_3S237sOxKzT3z3zs4W+1eq31JzA@mail.gmail.com>
Subject: Re: [PATCH 5/5] perf tools: Remove special handling of system-wide evsel
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 3, 2022 at 1:46 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> For system-wide evsels, the thread map should be dummy - i.e. it has a
> single entry of -1.  But the code guarantees such a thread map, so no
> need to handle it specially.
>
> No functional change intended.
>
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/lib/perf/evsel.c      |  3 ---
>  tools/perf/builtin-script.c |  3 ---
>  tools/perf/util/evsel.c     | 12 ++----------
>  tools/perf/util/stat.c      |  3 ---
>  4 files changed, 2 insertions(+), 19 deletions(-)
>
> diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
> index 8ce5bbd09666..8b51b008a81f 100644
> --- a/tools/lib/perf/evsel.c
> +++ b/tools/lib/perf/evsel.c
> @@ -515,9 +515,6 @@ int perf_evsel__alloc_id(struct perf_evsel *evsel, int ncpus, int nthreads)
>         if (ncpus == 0 || nthreads == 0)
>                 return 0;
>
> -       if (evsel->system_wide)
> -               nthreads = 1;
> -
>         evsel->sample_id = xyarray__new(ncpus, nthreads, sizeof(struct perf_sample_id));
>         if (evsel->sample_id == NULL)
>                 return -ENOMEM;
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 886f53cfa257..7fa467ed91dc 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -2243,9 +2243,6 @@ static void __process_stat(struct evsel *counter, u64 tstamp)
>         struct perf_cpu cpu;
>         static int header_printed;
>
> -       if (counter->core.system_wide)
> -               nthreads = 1;
> -
>         if (!header_printed) {
>                 printf("%3s %8s %15s %15s %15s %15s %s\n",
>                        "CPU", "THREAD", "VAL", "ENA", "RUN", "TIME", "EVENT");
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 5776bfa70f11..e319bb17d10d 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1813,7 +1813,7 @@ static struct perf_thread_map *empty_thread_map;
>  static int __evsel__prepare_open(struct evsel *evsel, struct perf_cpu_map *cpus,
>                 struct perf_thread_map *threads)
>  {
> -       int nthreads;
> +       int nthreads = perf_thread_map__nr(threads);

A general nit for something not introduced by this change. nr/nthreads
here is really the number of perf_event_open file descriptors needed
for the thread map. I wonder if a variable name of num_thread_fds
would make the code more intention revealing.

Thanks,
Ian

>
>         if ((perf_missing_features.write_backward && evsel->core.attr.write_backward) ||
>             (perf_missing_features.aux_output     && evsel->core.attr.aux_output))
> @@ -1839,11 +1839,6 @@ static int __evsel__prepare_open(struct evsel *evsel, struct perf_cpu_map *cpus,
>                 threads = empty_thread_map;
>         }
>
> -       if (evsel->core.system_wide)
> -               nthreads = 1;
> -       else
> -               nthreads = threads->nr;
> -
>         if (evsel->core.fd == NULL &&
>             perf_evsel__alloc_fd(&evsel->core, perf_cpu_map__nr(cpus), nthreads) < 0)
>                 return -ENOMEM;
> @@ -2061,10 +2056,7 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
>         if (threads == NULL)
>                 threads = empty_thread_map;
>
> -       if (evsel->core.system_wide)
> -               nthreads = 1;
> -       else
> -               nthreads = threads->nr;
> +       nthreads = perf_thread_map__nr(threads);
>
>         if (evsel->cgrp)
>                 pid = evsel->cgrp->fd;
> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> index ce5e9e372fc4..cef943377ad7 100644
> --- a/tools/perf/util/stat.c
> +++ b/tools/perf/util/stat.c
> @@ -420,9 +420,6 @@ static int process_counter_maps(struct perf_stat_config *config,
>         int ncpus = evsel__nr_cpus(counter);
>         int idx, thread;
>
> -       if (counter->core.system_wide)
> -               nthreads = 1;
> -
>         for (thread = 0; thread < nthreads; thread++) {
>                 for (idx = 0; idx < ncpus; idx++) {
>                         if (process_counter_values(config, counter, idx, thread,
> --
> 2.38.0.rc1.362.ged0d419d3c-goog
>
