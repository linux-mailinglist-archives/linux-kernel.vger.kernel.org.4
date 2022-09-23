Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A515E8648
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 01:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232937AbiIWXWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 19:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbiIWXWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 19:22:00 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FF613C857
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 16:21:56 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id t7so2070213wrm.10
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 16:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=frdneqNgohyqfaLqmKFd2BmYARCxGSlQak12BbbYcOg=;
        b=TJPCvP7bV80TCrXRHimFuM3VCTfL6G8bUOiIyvzX+tr8CG91/5xBsfkck5PqRoCnhs
         cTajAkvCQyq5sTHCiuCULuVZwKOwtoeRxT4bRKEaEZX4kT0D/PU2cizl6FJDgK2og5kf
         PD5rZ2Yahwepjgf6L+vSsYqnSpW32ZESnM7lCvc1Zf8FIU7snegkcKgbOcOaxmoXMB4S
         lpFcMNQazfgG3lWStnXMOfbGbmSTVCuEHdzUYdiQwK/u0F4GHMknWREzUNbv6Xcs+eq1
         I7ohPvc/JgTpaiy4z1uxKaQ1Yt5skyPRUsZjQGMeeDpU85kaKtResnYMF9zuU8TCE+7r
         XalA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=frdneqNgohyqfaLqmKFd2BmYARCxGSlQak12BbbYcOg=;
        b=51v9PtkCpiRH5GlwNsjRime0balz+adTZ6TzKJCqbtOS5FhUm+NqXUv1Ed2/v+8zft
         WxVKPv9GaZeDfGEo6KK0PR1yh4W6CA7DEEpuiOYinGrPf3hlo5ad3CE/BdUqcBqEeJND
         kP6AfH5j8MrrFDQvj02/VS5GHL52Kx9D8RHT0PSdVWPvsGBwk/3GJ4Bpo6rLgUfCdV5W
         Z//78WczzxSgWzoY9txlCSqBKM0WrWheM3MogE/RIQA13yT5KHUO6f/p7iT7l8WWO1Pi
         DksAy+8G/fxLz7RzKzqLeyOw83Y2FLxsHEFTaRjSoI+p2eH13H8xuPziHCWiDypcMAXw
         y4yg==
X-Gm-Message-State: ACrzQf2KxKxaOKEPz9xLHnpMP6b4rWpfk7rc2oozfJs8P8ZNw/25cYr3
        yJwNg+JnS5CuiX4TLgyEkoECs1kcYXf8kOqohacxiQ==
X-Google-Smtp-Source: AMsMyM5g/pjLAFTsrWxFtxYuiT4NfQV+k7wHnbrGj/E75UsGHsZkI9jrfYEruVIr5A5+J1JQpsDF4437msoLxkoePg0=
X-Received: by 2002:adf:dd8f:0:b0:22a:84ab:4be3 with SMTP id
 x15-20020adfdd8f000000b0022a84ab4be3mr6526914wrl.40.1663975314553; Fri, 23
 Sep 2022 16:21:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220923173142.805896-1-namhyung@kernel.org> <20220923173142.805896-4-namhyung@kernel.org>
In-Reply-To: <20220923173142.805896-4-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 23 Sep 2022 16:21:42 -0700
Message-ID: <CAP-5=fVZhzUiauL58E7Usy4O15-WuYQkKxOwDrS4f-fy5kNVFw@mail.gmail.com>
Subject: Re: [PATCH 3/4] perf tools: Add 'addr' sort key
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
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

On Fri, Sep 23, 2022 at 10:32 AM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Sometimes users want to see actual (virtual) address of sampled instructions.
> Add a new 'addr' sort key to display the raw addresses.
>
>   $ perf record -o- true | perf report -i- -s addr
>   # To display the perf.data header info, please use --header/--header-only options.
>   #
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.000 MB - ]
>   #
>   # Total Lost Samples: 0
>   #
>   # Samples: 12  of event 'cycles:u'
>   # Event count (approx.): 252512
>   #
>   # Overhead  Address
>   # ........  ..................
>   #
>       42.96%  0x7f96f08443d7
>       29.55%  0x7f96f0859b50
>       14.76%  0x7f96f0852e02
>        8.30%  0x7f96f0855028
>        4.43%  0xffffffff8de01087
>
> Note that it just compares and displays the sample ip.  Each process can
> have a different memory layout and the ip will be different even if they run
> the same binary.  So this sort key is mostly meaningful for per-process
> profile data.
>
> Cc: Stephane Eranian <eranian@google.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/Documentation/perf-report.txt |  3 +-
>  tools/perf/util/hist.c                   |  1 +
>  tools/perf/util/hist.h                   |  1 +
>  tools/perf/util/sort.c                   | 38 ++++++++++++++++++++++++
>  tools/perf/util/sort.h                   |  1 +
>  5 files changed, 43 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
> index 24efc0583c93..4533db2ee56b 100644
> --- a/tools/perf/Documentation/perf-report.txt
> +++ b/tools/perf/Documentation/perf-report.txt
> @@ -73,7 +73,7 @@ OPTIONS
>         Sort histogram entries by given key(s) - multiple keys can be specified
>         in CSV format.  Following sort keys are available:
>         pid, comm, dso, symbol, parent, cpu, socket, srcline, weight,
> -       local_weight, cgroup_id.
> +       local_weight, cgroup_id, addr.
>
>         Each key has following meaning:
>
> @@ -114,6 +114,7 @@ OPTIONS
>         - local_ins_lat: Local instruction latency version
>         - p_stage_cyc: On powerpc, this presents the number of cycles spent in a
>           pipeline stage. And currently supported only on powerpc.
> +       - addr: (Full) virtual address of the sampled instruction
>
>         By default, comm, dso and symbol keys are used.
>         (i.e. --sort comm,dso,symbol)
> diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> index 06f5dbf213ad..17a05e943b44 100644
> --- a/tools/perf/util/hist.c
> +++ b/tools/perf/util/hist.c
> @@ -215,6 +215,7 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *h)
>         hists__new_col_len(hists, HISTC_GLOBAL_INS_LAT, 13);
>         hists__new_col_len(hists, HISTC_LOCAL_P_STAGE_CYC, 13);
>         hists__new_col_len(hists, HISTC_GLOBAL_P_STAGE_CYC, 13);
> +       hists__new_col_len(hists, HISTC_ADDR, BITS_PER_LONG / 4 + 2);
>
>         if (symbol_conf.nanosecs)
>                 hists__new_col_len(hists, HISTC_TIME, 16);
> diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
> index c7a7a3fa0b87..ebd8a8f783ee 100644
> --- a/tools/perf/util/hist.h
> +++ b/tools/perf/util/hist.h
> @@ -79,6 +79,7 @@ enum hist_column {
>         HISTC_GLOBAL_P_STAGE_CYC,
>         HISTC_ADDR_FROM,
>         HISTC_ADDR_TO,
> +       HISTC_ADDR,
>         HISTC_NR_COLS, /* Last entry */
>  };
>
> diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> index 6d5588e80935..2e7330867e2e 100644
> --- a/tools/perf/util/sort.c
> +++ b/tools/perf/util/sort.c
> @@ -1948,6 +1948,43 @@ struct sort_entry sort_dso_size = {
>         .se_width_idx   = HISTC_DSO_SIZE,
>  };
>
> +/* --sort dso_size */
> +
> +static int64_t
> +sort__addr_cmp(struct hist_entry *left, struct hist_entry *right)
> +{
> +       u64 left_ip = left->ip;
> +       u64 right_ip = right->ip;
> +       struct map *left_map = left->ms.map;
> +       struct map *right_map = right->ms.map;
> +
> +       if (left_map)
> +               left_ip = left_map->unmap_ip(left_map, left_ip);
> +       if (right_map)
> +               right_ip = right_map->unmap_ip(right_map, right_ip);
> +
> +       return _sort__addr_cmp(left_ip, right_ip);
> +}
> +
> +static int hist_entry__addr_snprintf(struct hist_entry *he, char *bf,
> +                                    size_t size, unsigned int width)
> +{
> +       u64 ip = he->ip;
> +       struct map *map = he->ms.map;
> +
> +       if (map)
> +               ip = map->unmap_ip(map, ip);
> +
> +       return repsep_snprintf(bf, size, "%-#*llx", width, ip);
> +}
> +
> +struct sort_entry sort_addr = {
> +       .se_header      = "Address",
> +       .se_cmp         = sort__addr_cmp,
> +       .se_snprintf    = hist_entry__addr_snprintf,
> +       .se_width_idx   = HISTC_ADDR,
> +};
> +
>
>  struct sort_dimension {
>         const char              *name;
> @@ -1997,6 +2034,7 @@ static struct sort_dimension common_sort_dimensions[] = {
>         DIM(SORT_GLOBAL_INS_LAT, "ins_lat", sort_global_ins_lat),
>         DIM(SORT_LOCAL_PIPELINE_STAGE_CYC, "local_p_stage_cyc", sort_local_p_stage_cyc),
>         DIM(SORT_GLOBAL_PIPELINE_STAGE_CYC, "p_stage_cyc", sort_global_p_stage_cyc),
> +       DIM(SORT_ADDR, "addr", sort_addr),
>  };
>
>  #undef DIM
> diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
> index af14eb46c2b6..04ff8b61a2a7 100644
> --- a/tools/perf/util/sort.h
> +++ b/tools/perf/util/sort.h
> @@ -236,6 +236,7 @@ enum sort_type {
>         SORT_GLOBAL_INS_LAT,
>         SORT_LOCAL_PIPELINE_STAGE_CYC,
>         SORT_GLOBAL_PIPELINE_STAGE_CYC,
> +       SORT_ADDR,
>
>         /* branch stack specific sort keys */
>         __SORT_BRANCH_STACK,
> --
> 2.37.3.998.g577e59143f-goog
>
