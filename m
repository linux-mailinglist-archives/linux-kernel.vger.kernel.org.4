Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A296DCDF0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 01:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjDJXVe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 10 Apr 2023 19:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjDJXVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 19:21:32 -0400
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D912118;
        Mon, 10 Apr 2023 16:21:09 -0700 (PDT)
Received: by mail-ua1-f49.google.com with SMTP id ba16so4410966uab.4;
        Mon, 10 Apr 2023 16:21:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681168869; x=1683760869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P4Lc7kTtUKpJq2HePJoO52rNn2Ss3QVKDL6cqFdOw4s=;
        b=MxBSz9HWyK5hgCi29CGRVBEoPh7dV+/rI4YzgRrAfh7IvMTfh24wF3BDxWQt1/I+PQ
         mEM4FUxIP1XofKXqMNYwdvNVDDx6Mx7Khitqtk+bsZ3CT8LE+Jv7It9dhFmMMiWHjxWg
         rsqaiYyHSILt/Gtbs0GxEjbYkxkDFqYsOZWQlu9T3UHJvElqu5I2tw0huiMgt6GU9bFi
         yhqKJ16yQFr2aYlk4bIIZKafjFOIoJrOaeI7Fj6nxJgFT92c9CfbXSHADBIWFjlTd1yg
         fUjZ40aOLE1TdfVgYaeXGeTyHzYeGzcQFBznaCQ0FHBzS7gpRfIZuUWII6oLyVc+3BtM
         K54Q==
X-Gm-Message-State: AAQBX9fS6ELsN+T5YMoVOuwzox9DFFb//5Kp7hm9HFtCee8cKPFJlkqY
        Jb9JslmeQi2jlMYk2Mrr0jH/lBBogCwMh2RYE3rBLSll
X-Google-Smtp-Source: AKy350bxdML3cCqmsj+BIwmFI4dCKsDMnnNSN+bSZSMYEI67lOCP3r3LuK20kJRCM5CIrokpVf0bPnMUN+/nkUAVkYk=
X-Received: by 2002:a05:6122:1691:b0:43b:ead4:669e with SMTP id
 17-20020a056122169100b0043bead4669emr3979285vkl.16.1681168868654; Mon, 10 Apr
 2023 16:21:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230410205659.3131608-1-irogers@google.com>
In-Reply-To: <20230410205659.3131608-1-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 10 Apr 2023 16:20:57 -0700
Message-ID: <CAM9d7cjuqcwcy+CwAPj8wK4hO2Pzr6xor76+jW-Do443Gr2ENQ@mail.gmail.com>
Subject: Re: [PATCH v1] perf evsel: Avoid segv if delete is called on NULL
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

On Mon, Apr 10, 2023 at 1:57 PM Ian Rogers <irogers@google.com> wrote:
>
> Seen in "perf stat --bpf-counters --for-each-cgroup test" running in a
> container:
>
> libbpf: Failed to bump RLIMIT_MEMLOCK (err = -1), you might need to do it explicitly!
> libbpf: Error in bpf_object__probe_loading():Operation not permitted(1). Couldn't load trivial BPF program. Make sure your kernel supports BPF (CONFIG_BPF_SYSCALL=y) and/or that RLIMIT_MEMLOCK is set to big enough value.
> libbpf: failed to load object 'bperf_cgroup_bpf'
> libbpf: failed to load BPF skeleton 'bperf_cgroup_bpf': -1
> Failed to load cgroup skeleton
>
>     #0 0x55f28a650981 in list_empty tools/include/linux/list.h:189
>     #1 0x55f28a6593b4 in evsel__exit util/evsel.c:1518
>     #2 0x55f28a6596af in evsel__delete util/evsel.c:1544
>     #3 0x55f28a89d166 in bperf_cgrp__destroy util/bpf_counter_cgroup.c:283
>     #4 0x55f28a899e9a in bpf_counter__destroy util/bpf_counter.c:816
>     #5 0x55f28a659455 in evsel__exit util/evsel.c:1520
>     #6 0x55f28a6596af in evsel__delete util/evsel.c:1544
>     #7 0x55f28a640d4d in evlist__purge util/evlist.c:148
>     #8 0x55f28a640ea6 in evlist__delete util/evlist.c:169
>     #9 0x55f28a4efbf2 in cmd_stat tools/perf/builtin-stat.c:2598
>     #10 0x55f28a6050c2 in run_builtin tools/perf/perf.c:330
>     #11 0x55f28a605633 in handle_internal_command tools/perf/perf.c:384
>     #12 0x55f28a6059fb in run_argv tools/perf/perf.c:428
>     #13 0x55f28a6061d3 in main tools/perf/perf.c:562
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

In addition to this, I think bperf code should clear the evsel->bpf_skel
at the end of the bpf_counter__destroy() to avoid confusion with the
bpf_filter as they share the fields in a union.

Thanks,
Namhyung


> ---
>  tools/perf/util/evsel.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index dc3faf005c3b..fe3ce765a4f3 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1541,6 +1541,9 @@ void evsel__exit(struct evsel *evsel)
>
>  void evsel__delete(struct evsel *evsel)
>  {
> +       if (!evsel)
> +               return;
> +
>         evsel__exit(evsel);
>         free(evsel);
>  }
> --
> 2.40.0.577.gac1e443424-goog
>
