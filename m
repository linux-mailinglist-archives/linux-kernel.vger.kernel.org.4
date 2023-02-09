Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04976910F3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 20:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjBITGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 14:06:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjBITGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 14:06:45 -0500
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AEFC66FAF;
        Thu,  9 Feb 2023 11:06:34 -0800 (PST)
Received: by mail-io1-f48.google.com with SMTP id bl9so1057064iob.7;
        Thu, 09 Feb 2023 11:06:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s72xfzKXaAUN+BmCVxfi11/B8MyhXteI6Ce4No4EmDQ=;
        b=6KV6FWlc3/TcU9j21TRkGZb/uAklzlNEBgMnWVyZPo1FvjK5kuUuc76N5G7oF6Wzef
         HrizTnzauP0uMinbfq7g6IxWOCQGow195Sft/mAC6CLM+1XTqZqgRdMyjkz4wPxYaUL1
         Bjwj6O7idS/Fp8LSRUeTgIMfQgxtNuENPOS98f1MavOWSywLnS4g+PcA8uI7ozFtRswR
         D4XCPAr13G2u+kZUhZ1Kv3LeRnPb5uy1gpH4Cr7VwENgXZX9srlC9AElWQJNmMTEUxRI
         +NeKjl0NHdJ3Q564L+7AvisSM6rgh4fvh7ZYbePM2BAAOGapmkUtNNU9A7JcU0U2GPu6
         KX0g==
X-Gm-Message-State: AO0yUKXqTI56XwwwAsHJ+9f4WyEIKJRWR39GcZo5bH7smgU1Aj9hnSjX
        DigHBoGn0uktRA8h8CobOymxuIj+CAB1mzE4euE=
X-Google-Smtp-Source: AK7set+zgXow6B7szYrugwKjpolvD8+2ZXlIs0h3Lja5XOnejqBH1M5oiw6+ey3YztjTcpqXfq7ChgWZG98tq3eTjIg=
X-Received: by 2002:a05:6638:4b8d:b0:3ab:d885:6e9f with SMTP id
 dj13-20020a0566384b8d00b003abd8856e9fmr7366615jab.53.1675969593617; Thu, 09
 Feb 2023 11:06:33 -0800 (PST)
MIME-Version: 1.0
References: <20230209064447.83733-1-irogers@google.com>
In-Reply-To: <20230209064447.83733-1-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 9 Feb 2023 11:06:22 -0800
Message-ID: <CAM9d7ciJpB8qAN1OW+xe-ofuzK9tgytNyrV4modEePKJicX-=w@mail.gmail.com>
Subject: Re: [PATCH v1] perf stat: Avoid merging/aggregating metric counts twice
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        James Clark <james.clark@arm.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>,
        Perry Taylor <perry.taylor@intel.com>
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

Hi Ian,

On Wed, Feb 8, 2023 at 10:45 PM Ian Rogers <irogers@google.com> wrote:
>
> The added perf_stat_merge_counters combines uncore counters. When
> metrics are enabled, the counts are merged into a metric_leader
> via the stat-shadow saved_value logic. As the leader now is
> passed an aggregated count, it leads to all counters being added
> together twice and counts appearing approximately doubled in
> metrics.
>
> This change disables the saved_value merging of counts for evsels
> that are merged. It is recommended that later changes remove the
> saved_value entirely as the two layers of aggregation in the code
> is confusing.

+1

>
> Fixes: 942c5593393d ("perf stat: Add perf_stat_merge_counters()")
> Reported-by: Perry Taylor <perry.taylor@intel.com>
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/util/stat-shadow.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
> index cadb2df23c87..4cd05d9205e3 100644
> --- a/tools/perf/util/stat-shadow.c
> +++ b/tools/perf/util/stat-shadow.c
> @@ -311,7 +311,7 @@ void perf_stat__update_shadow_stats(struct evsel *counter, u64 count,
>                 update_stats(&v->stats, count);
>                 if (counter->metric_leader)
>                         v->metric_total += count;
> -       } else if (counter->metric_leader) {
> +       } else if (counter->metric_leader && !counter->merged_stat) {
>                 v = saved_value_lookup(counter->metric_leader,
>                                        map_idx, true, STAT_NONE, 0, st, rsd.cgrp);
>                 v->metric_total += count;
> --
> 2.39.1.519.gcb327c4b5f-goog
>
