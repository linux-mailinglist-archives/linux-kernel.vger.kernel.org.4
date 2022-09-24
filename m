Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB92F5E8E9D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 18:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233830AbiIXQwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 12:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232388AbiIXQwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 12:52:22 -0400
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF78354CB5;
        Sat, 24 Sep 2022 09:52:21 -0700 (PDT)
Received: by mail-ot1-f51.google.com with SMTP id x23-20020a056830409700b00655c6dace73so1880966ott.11;
        Sat, 24 Sep 2022 09:52:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=yGczEyCEAGIiiOB46Oi9TMj+KAutVQm4+8nTiOuxYCQ=;
        b=s1UArA4Bs0cUuOofzd9TQDv4TSZhLn5s27MvqH9y9lKIdwgKgZGGyeF58tLSIZvtex
         YHHkFjypBgkRM7UC9RplZYOqG1r4yVMRPga7s00YCmEBVh6YypEMmBeRDAmFq1LacK39
         //x1QepWG1yAK801y/uFIrFejDyvhSDC0r8JwAoKR6qYBsMhcqbHfGVtfwRciNQZwHL/
         fR6qWGkJGwHLJQj2Spx1XZr9cJ0Qz9Cx2vZkv0uGYPr+DcvKjuP6eBlra9SYLvV4djri
         /dX5aBGIciz6ucxnt8N9yBX94h6LUMntQTJMeq53mFhRae+MUMeo+qZTlKJeXNBC6joA
         5HaQ==
X-Gm-Message-State: ACrzQf3oZWccjsk+ofZgZ6tlc7naZPgGrLlPUK5mR1HGYAoS3VqnJCcc
        5QOwTKchDxJ5+nvnl0t/z0uJb07BD08BiZT2sqU=
X-Google-Smtp-Source: AMsMyM6pyCa4tOFSYuJ4HuyzwfPl0Yc11k1GhGNM3g/iOpJScn01F919Rt4gj1UiCGZMaSVW/1DemLKIJTGYkxAc/YI=
X-Received: by 2002:a05:6830:1351:b0:65b:e0a8:d0e8 with SMTP id
 r17-20020a056830135100b0065be0a8d0e8mr6472601otq.190.1664038341034; Sat, 24
 Sep 2022 09:52:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220924113346.1110909-1-leo.yan@linaro.org>
In-Reply-To: <20220924113346.1110909-1-leo.yan@linaro.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sat, 24 Sep 2022 09:52:09 -0700
Message-ID: <CAM9d7ci2RJOTz08eGRgLMVpS0TmwN=q=UNA_Z3wbSHCC2pMygQ@mail.gmail.com>
Subject: Re: [PATCH] perf record: Fix segmentation fault in record__read_lost_samples()
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

On Sat, Sep 24, 2022 at 4:34 AM Leo Yan <leo.yan@linaro.org> wrote:
>
> Commit a49aa8a54e86 ("perf record: Read and inject LOST_SAMPLES events")
> causes segmentation fault when run the "perf mem record" command in
> unprivileged mode, the output log is:
>
>   $ ./perf mem record --all-user -o perf_test.data -- ./test_program
>   Error:
>   Access to performance monitoring and observability operations is limited.
>   Consider adjusting /proc/sys/kernel/perf_event_paranoid setting to open
>   access to performance monitoring and observability operations for processes
>   without CAP_PERFMON, CAP_SYS_PTRACE or CAP_SYS_ADMIN Linux capability.
>   More information can be found at 'Perf events and tool security' document:
>   https://www.kernel.org/doc/html/latest/admin-guide/perf-security.html
>   perf_event_paranoid setting is 4:
>     -1: Allow use of (almost) all events by all users
>         Ignore mlock limit after perf_event_mlock_kb without CAP_IPC_LOCK
>   >= 0: Disallow raw and ftrace function tracepoint access
>   >= 1: Disallow CPU event access
>   >= 2: Disallow kernel profiling
>   To make the adjusted perf_event_paranoid setting permanent preserve it
>   in /etc/sysctl.conf (e.g. kernel.perf_event_paranoid = <setting>)
>   perf: Segmentation fault
>   Obtained 16 stack frames.
>   ./perf(dump_stack+0x31) [0x55b7aa1e8070]
>   ./perf(sighandler_dump_stack+0x36) [0x55b7aa1e815e]
>   ./perf(+0xc9120) [0x55b7aa0a9120]
>   /lib/x86_64-linux-gnu/libc.so.6(+0x4251f) [0x7fd03ef8151f]
>   ./perf(+0xccaca) [0x55b7aa0acaca]
>   ./perf(+0xcf4ab) [0x55b7aa0af4ab]
>   ./perf(cmd_record+0xd50) [0x55b7aa0b28df]
>   ./perf(+0x112f77) [0x55b7aa0f2f77]
>   ./perf(cmd_mem+0x53b) [0x55b7aa0f406c]
>   ./perf(+0x19979c) [0x55b7aa17979c]
>   ./perf(+0x199a37) [0x55b7aa179a37]
>   ./perf(+0x199b95) [0x55b7aa179b95]
>   ./perf(main+0x2c7) [0x55b7aa179fbd]
>   /lib/x86_64-linux-gnu/libc.so.6(+0x29d8f) [0x7fd03ef68d8f]
>   /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0x7f) [0x7fd03ef68e3f]
>   ./perf(_start+0x24) [0x55b7aa089974]
>   Segmentation fault (core dumped)
>
> In the unprivileged mode perf fails to open PMU event, the function
> record__open() returns error and "session->evlist" is NULL; this leads
> to segmentation fault when iterates "session->evlist" in the function
> record__read_lost_samples().
>
> This patch checks "session->evlist" in record__read_lost_samples(), if
> "session->evlist" is NULL then the function directly bails out to avoid
> segmentation fault.
>
> Fixes: a49aa8a54e86 ("perf record: Read and inject LOST_SAMPLES events")
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

Thanks for the fix and sorry for the inconvenience.
Actually I sent the same fix a few weeks ago.

https://lore.kernel.org/r/20220909235024.278281-1-namhyung@kernel.org

Thanks,
Namhyung


> ---
>  tools/perf/builtin-record.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 02e38f50a138..012b46dd4999 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1888,6 +1888,10 @@ static void record__read_lost_samples(struct record *rec)
>         struct perf_record_lost_samples *lost;
>         struct evsel *evsel;
>
> +       /* No any event is opened, directly bail out */
> +       if (!session->evlist)
> +               return;
> +
>         lost = zalloc(PERF_SAMPLE_MAX_SIZE);
>         if (lost == NULL) {
>                 pr_debug("Memory allocation failed\n");
> --
> 2.34.1
>
