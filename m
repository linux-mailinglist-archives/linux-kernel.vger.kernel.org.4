Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48A162204E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 00:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiKHX01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 18:26:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiKHX0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 18:26:16 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CF81035
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 15:26:14 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id j15so23319381wrq.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 15:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y7muNCfKPcTAIJC8+7u1fXd+PrZAhVIK0iHSzkIipCo=;
        b=Cc4hv4qE0+esdxtOp5ZtK4pxPl5JIw0sNPSlLP0dQBGb6SQqWo8ZRT6BB+6LIX0nNZ
         KmjEy2bRyQwR2YkCAcPjRbXfj8OAvFPOsx4Avh5LeAakDTkxJf1IUps8o9Nl5aUaIl3T
         RuagSiLDBU+1XlYKMiWaOQvikTiERcFos0TiKQpLnlDwYNjF1TbZ7kk9Uwr2MkuPWgUO
         WM/oOQFdo9D5qwv3AdhTBMlfDqFo9ZbPQ5CM0c3HzkA1vMWsnMrbx4W63Hi1gxmTtQJw
         Z6EwHs25yK1rmvYWnVO6rb0l3aos+Ei7i7gcHF7zFJRqCy6Dbp6LOwm6sXkt2zQbXfCj
         RI9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y7muNCfKPcTAIJC8+7u1fXd+PrZAhVIK0iHSzkIipCo=;
        b=eoL6+BYN1Tw/uYHLxn7NDNxEFvVQNyrrC5USx42wHKFXlyRgv/B4Qfz/f4UxoDO4nL
         sStp1YhzOZK+5vEcfCpRtZnw9ia2n/u+lFqGPaolb6J0NgWmQZ9s5yDeU20OloTTplDm
         qFV0D46kaqwqMSGH8i4CNPRgyQVnvKeKGcvSTdLn0OPosaXDVB1CQ0FHYpEsTPNgyDXY
         QoooMwqYeELuBvA7DryZNocR2YjuUH+gSW73pKmJv8V/Z4+MvKhqJpejo6tzoP+1F6ye
         zk3DMN73+4CXZxZS0t2Ems0yZfrRYNioklfRFNqIjznsIFDBjedg5iEKefSuiJ3JiYtA
         pl2A==
X-Gm-Message-State: ACrzQf1h/G95glWTeqnHDbt3QRfAStLWfRGkenDzdkNUaoSKuuMte+2+
        ZoM80EWhJVYJs3EEXmVsemMmvY9HchNJM0oM6SDndw==
X-Google-Smtp-Source: AMsMyM7r6FM5+I5i6GQM9g9fxvFtrFypj5/B0fsNWo/VOe5QUIJrB+E+pt2EEZg77mehW1evbVB+WAa4tZVJlCzOeeE=
X-Received: by 2002:a5d:47a6:0:b0:236:7854:246d with SMTP id
 6-20020a5d47a6000000b002367854246dmr36335160wrb.300.1667949973218; Tue, 08
 Nov 2022 15:26:13 -0800 (PST)
MIME-Version: 1.0
References: <20221104051440.220989-1-namhyung@kernel.org>
In-Reply-To: <20221104051440.220989-1-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 8 Nov 2022 15:26:01 -0800
Message-ID: <CAP-5=fXm1EkFiQMWmTgG80xkwzcPDKjwA4wCQr765AGVSG=Ucw@mail.gmail.com>
Subject: Re: [PATCH] perf lock: Allow concurrent record and report
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org
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

On Thu, Nov 3, 2022 at 10:14 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> To support live monitoring of kernel lock contention without BPF,
> it should support something like below:
>
>   # perf lock record -a -o- sleep 1 | perf lock contention -i-
>    contended   total wait     max wait     avg wait         type   caller
>
>            2     10.27 us      6.17 us      5.13 us     spinlock   load_balance+0xc03
>            1      5.29 us      5.29 us      5.29 us     rwlock:W   ep_scan_ready_list+0x54
>            1      4.12 us      4.12 us      4.12 us     spinlock   smpboot_thread_fn+0x116
>            1      3.28 us      3.28 us      3.28 us        mutex   pipe_read+0x50
>
> To do that, it needs to handle HEAD_ATTR, HEADER_EVENT_UPDATE and
> HEADER_TRACING_DATA which are generated only for the pipe mode.
> And setting event handler also should be delayed until it gets the
> event information.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-lock.c                 | 68 +++++++++++++++--------
>  tools/perf/tests/shell/lock_contention.sh | 15 ++++-
>  2 files changed, 60 insertions(+), 23 deletions(-)
>
> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index 6f79175365a8..0d280093b19a 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
> @@ -1390,6 +1390,34 @@ static int dump_info(void)
>         return rc;
>  }
>
> +static const struct evsel_str_handler lock_tracepoints[] = {
> +       { "lock:lock_acquire",   evsel__process_lock_acquire,   }, /* CONFIG_LOCKDEP */
> +       { "lock:lock_acquired",  evsel__process_lock_acquired,  }, /* CONFIG_LOCKDEP, CONFIG_LOCK_STAT */
> +       { "lock:lock_contended", evsel__process_lock_contended, }, /* CONFIG_LOCKDEP, CONFIG_LOCK_STAT */
> +       { "lock:lock_release",   evsel__process_lock_release,   }, /* CONFIG_LOCKDEP */
> +};
> +
> +static const struct evsel_str_handler contention_tracepoints[] = {
> +       { "lock:contention_begin", evsel__process_contention_begin, },
> +       { "lock:contention_end",   evsel__process_contention_end,   },
> +};
> +
> +static int process_event_update(struct perf_tool *tool,
> +                               union perf_event *event,
> +                               struct evlist **pevlist)
> +{
> +       int ret;
> +
> +       ret = perf_event__process_event_update(tool, event, pevlist);
> +       if (ret < 0)
> +               return ret;
> +
> +       /* this can return -EEXIST since we call it for each evsel */
> +       perf_session__set_tracepoints_handlers(session, lock_tracepoints);
> +       perf_session__set_tracepoints_handlers(session, contention_tracepoints);
> +       return 0;
> +}
> +
>  typedef int (*tracepoint_handler)(struct evsel *evsel,
>                                   struct perf_sample *sample);
>
> @@ -1545,28 +1573,19 @@ static void print_contention_result(struct lock_contention *con)
>         print_bad_events(bad, total);
>  }
>
> -static const struct evsel_str_handler lock_tracepoints[] = {
> -       { "lock:lock_acquire",   evsel__process_lock_acquire,   }, /* CONFIG_LOCKDEP */
> -       { "lock:lock_acquired",  evsel__process_lock_acquired,  }, /* CONFIG_LOCKDEP, CONFIG_LOCK_STAT */
> -       { "lock:lock_contended", evsel__process_lock_contended, }, /* CONFIG_LOCKDEP, CONFIG_LOCK_STAT */
> -       { "lock:lock_release",   evsel__process_lock_release,   }, /* CONFIG_LOCKDEP */
> -};
> -
> -static const struct evsel_str_handler contention_tracepoints[] = {
> -       { "lock:contention_begin", evsel__process_contention_begin, },
> -       { "lock:contention_end",   evsel__process_contention_end,   },
> -};
> -
>  static bool force;
>
>  static int __cmd_report(bool display_info)
>  {
>         int err = -EINVAL;
>         struct perf_tool eops = {
> +               .attr            = perf_event__process_attr,
> +               .event_update    = process_event_update,
>                 .sample          = process_sample_event,
>                 .comm            = perf_event__process_comm,
>                 .mmap            = perf_event__process_mmap,
>                 .namespaces      = perf_event__process_namespaces,
> +               .tracing_data    = perf_event__process_tracing_data,
>                 .ordered_events  = true,
>         };
>         struct perf_data data = {
> @@ -1585,17 +1604,19 @@ static int __cmd_report(bool display_info)
>         symbol_conf.sort_by_name = true;
>         symbol__init(&session->header.env);
>
> -       if (!perf_session__has_traces(session, "lock record"))
> -               goto out_delete;
> +       if (!data.is_pipe) {
> +               if (!perf_session__has_traces(session, "lock record"))
> +                       goto out_delete;
>
> -       if (perf_session__set_tracepoints_handlers(session, lock_tracepoints)) {
> -               pr_err("Initializing perf session tracepoint handlers failed\n");
> -               goto out_delete;
> -       }
> +               if (perf_session__set_tracepoints_handlers(session, lock_tracepoints)) {
> +                       pr_err("Initializing perf session tracepoint handlers failed\n");
> +                       goto out_delete;
> +               }
>
> -       if (perf_session__set_tracepoints_handlers(session, contention_tracepoints)) {
> -               pr_err("Initializing perf session tracepoint handlers failed\n");
> -               goto out_delete;
> +               if (perf_session__set_tracepoints_handlers(session, contention_tracepoints)) {
> +                       pr_err("Initializing perf session tracepoint handlers failed\n");
> +                       goto out_delete;
> +               }
>         }
>
>         if (setup_output_field(false, output_fields))
> @@ -1633,9 +1654,12 @@ static int __cmd_contention(int argc, const char **argv)
>  {
>         int err = -EINVAL;
>         struct perf_tool eops = {
> +               .attr            = perf_event__process_attr,
> +               .event_update    = process_event_update,
>                 .sample          = process_sample_event,
>                 .comm            = perf_event__process_comm,
>                 .mmap            = perf_event__process_mmap,
> +               .tracing_data    = perf_event__process_tracing_data,
>                 .ordered_events  = true,
>         };
>         struct perf_data data = {
> @@ -1698,7 +1722,7 @@ static int __cmd_contention(int argc, const char **argv)
>                         pr_err("lock contention BPF setup failed\n");
>                         goto out_delete;
>                 }
> -       } else {
> +       } else if (!data.is_pipe) {
>                 if (!perf_session__has_traces(session, "lock record"))
>                         goto out_delete;
>
> diff --git a/tools/perf/tests/shell/lock_contention.sh b/tools/perf/tests/shell/lock_contention.sh
> index 04bf604e3c6f..f7bd0d8eb5c3 100755
> --- a/tools/perf/tests/shell/lock_contention.sh
> +++ b/tools/perf/tests/shell/lock_contention.sh
> @@ -53,7 +53,7 @@ test_bpf()
>
>         if ! perf lock con -b true > /dev/null 2>&1 ; then
>                 echo "[Skip] No BPF support"
> -               exit
> +               return
>         fi
>
>         # the perf lock contention output goes to the stderr
> @@ -65,9 +65,22 @@ test_bpf()
>         fi
>  }
>
> +test_record_concurrent()
> +{
> +       echo "Testing perf lock record and perf lock contention at the same time"
> +       perf lock record -o- -- perf bench sched messaging 2> /dev/null | \
> +       perf lock contention -i- -E 1 -q 2> ${result}
> +       if [ $(cat "${result}" | wc -l) != "1" ]; then
> +               echo "[Fail] Recorded result count is not 1:" $(cat "${result}" | wc -l)
> +               err=1
> +               exit
> +       fi
> +}
> +
>  check
>
>  test_record
>  test_bpf
> +test_record_concurrent
>
>  exit ${err}
> --
> 2.38.1.431.g37b22c650d-goog
>
