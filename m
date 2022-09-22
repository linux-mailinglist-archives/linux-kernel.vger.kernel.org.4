Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBC05E598D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 05:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbiIVDWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 23:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbiIVDVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 23:21:37 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F66F7FF9D
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 20:16:57 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id ay36so5937129wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 20:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Gf5cFucll322oSi7IN8E0A7c01vWLE1t6RgRR/X3lFE=;
        b=cyu+sMCeNI7IjveApYqHRSi0+KsjKAyddUETNdMX3OV9uWjvZqlJpDJFb5zDuwNK5w
         4dgb8R0b6VP6+7pebIAi9nN7aeLPWD87KmtWg4jjzRlFVDQ4F+8HuSSlzpukzqfPmkuG
         Xk1MSiayz+Tv8A+85tsaxhwdOajLA9cJqlaNXCmZpQOPdZYMZ6DQi/spS/HQFWvOZooz
         GPatH31/kX0oZRlT8ZL/HSYfl/shQ/O/d7jA4wflde6Tj3hj6+UIr7j8aELJZOmp+bV9
         7hGdd3kOQ+aVfSwfr7XyyQn2ydCG3f7fITlFC87Bpg1fTastJE/AoiOW4W+97NgJMi9E
         P5sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Gf5cFucll322oSi7IN8E0A7c01vWLE1t6RgRR/X3lFE=;
        b=BEUXw7YPHGud0bebEtuRlgXnl8sF7tQiUiyQvWyuPbLlk/ZhA6CZrAXhKmf7Jp+Th7
         k39rq5xaBLMeTq4SmQ6tfa8+RGXHWTuwveFF7kzgoB0WbatBKl7GdIAeOiFV9oS0sKmJ
         0K3LiMlbbsCdMjWa+XzD7pzlC1wbHxgPxOj34rrStKbi7VnIfeiD6MMY6jvZCnndVrXJ
         wS4zNlsL9yeYE/kqRkf2g6SOWBgdaVkBxOKL6+MaEY3jCYeyuXHjFytwjIHejaTAjn6R
         9vz2Y63dYSO4ew4yYFMFPt5pXXYprLWMfwVpBhNznLcHaCTYDLTd9KB4Kfb2q5g25p9B
         rFCg==
X-Gm-Message-State: ACrzQf3nHteLvlaBc2FyAcUEB8IRW7Irae889CyBO/HPJXfBnCaDaR8Y
        hnHNfBcBF3XKkgzZ75qldMzbTRVOYfDilbqjrhfSRA==
X-Google-Smtp-Source: AMsMyM6OlMz7hQCdkutKhUaeJa90Iz6S8q4WliavmRN7d/qpKXh1bRqMWegNouk+R3boTk29zX8XU+AZWrgM6gwvXIA=
X-Received: by 2002:a05:600c:2181:b0:3b4:74e4:16f8 with SMTP id
 e1-20020a05600c218100b003b474e416f8mr712403wme.174.1663816615424; Wed, 21 Sep
 2022 20:16:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220922014904.3665674-1-zhengjun.xing@linux.intel.com> <20220922014904.3665674-2-zhengjun.xing@linux.intel.com>
In-Reply-To: <20220922014904.3665674-2-zhengjun.xing@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 21 Sep 2022 20:16:42 -0700
Message-ID: <CAP-5=fWhPAcbbws3H=VC7F3qnXv4hkbMd3rjk4_HtsBAQHPTTg@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf parse-events: Remove "not supported" hybrid
 cache events
To:     zhengjun.xing@linux.intel.com
Cc:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@kernel.org,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, ak@linux.intel.com,
        kan.liang@linux.intel.com
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

On Wed, Sep 21, 2022 at 6:47 PM <zhengjun.xing@linux.intel.com> wrote:
>
> From: Zhengjun Xing <zhengjun.xing@linux.intel.com>
>
> By default, we create two hybrid cache events, one is for cpu_core, and
> another is for cpu_atom. But Some hybrid hardware cache events are only
> available on one CPU PMU. For example, the 'L1-dcache-load-misses' is only
> available on cpu_core, while the 'L1-icache-loads' is only available on
> cpu_atom. We need to remove "not supported" hybrid cache events. By
> extending is_event_supported() to global API and using it to check if the
> hybrid cache events are supported before being created, we can remove the
> "not supported" hybrid cache events.
>
> Before:
>
>  # ./perf stat -e L1-dcache-load-misses,L1-icache-loads -a sleep 1
>
>  Performance counter stats for 'system wide':
>
>             52,570      cpu_core/L1-dcache-load-misses/
>    <not supported>      cpu_atom/L1-dcache-load-misses/
>    <not supported>      cpu_core/L1-icache-loads/
>          1,471,817      cpu_atom/L1-icache-loads/
>
>        1.004915229 seconds time elapsed
>
> After:
>
>  # ./perf stat -e L1-dcache-load-misses,L1-icache-loads -a sleep 1
>
>  Performance counter stats for 'system wide':
>
>             54,510      cpu_core/L1-dcache-load-misses/
>          1,441,286      cpu_atom/L1-icache-loads/
>
>        1.005114281 seconds time elapsed
>
> Fixes: 30def61f64ba ("perf parse-events: Create two hybrid cache events")
> Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  tools/perf/util/parse-events-hybrid.c | 8 +++++++-
>  tools/perf/util/print-events.c        | 2 +-
>  tools/perf/util/print-events.h        | 3 ++-
>  3 files changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/util/parse-events-hybrid.c b/tools/perf/util/parse-events-hybrid.c
> index 284f8eabd3b9..cf2e1c2e968f 100644
> --- a/tools/perf/util/parse-events-hybrid.c
> +++ b/tools/perf/util/parse-events-hybrid.c
> @@ -14,6 +14,7 @@
>  #include "pmu.h"
>  #include "pmu-hybrid.h"
>  #include "perf.h"
> +#include "print-events.h"
>
>  static void config_hybrid_attr(struct perf_event_attr *attr,
>                                int type, int pmu_type)
> @@ -48,13 +49,18 @@ static int create_event_hybrid(__u32 config_type, int *idx,
>         __u64 config = attr->config;
>
>         config_hybrid_attr(attr, config_type, pmu->type);
> +
> +       if (attr->type == PERF_TYPE_HW_CACHE
> +           && !is_event_supported(attr->type, attr->config))
> +               goto out;

A comment to explain this would be useful.

> +
>         evsel = parse_events__add_event_hybrid(list, idx, attr, name, metric_id,
>                                                pmu, config_terms);
>         if (evsel)
>                 evsel->pmu_name = strdup(pmu->name);
>         else
>                 return -ENOMEM;

For consistency should this use the "goto" pattern now? You can also
handle the ENOMEM case for strdup.

> -
> +out:
>         attr->type = type;
>         attr->config = config;
>         return 0;
> diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
> index 04050d4f6db8..fa5cc94cfcfe 100644
> --- a/tools/perf/util/print-events.c
> +++ b/tools/perf/util/print-events.c
> @@ -239,7 +239,7 @@ void print_sdt_events(const char *subsys_glob, const char *event_glob,
>         strlist__delete(sdtlist);
>  }
>
> -static bool is_event_supported(u8 type, u64 config)
> +bool is_event_supported(u8 type, u64 config)

This makes me tempted to say this function should be in parse-events.c.

Thanks,
Ian

>  {
>         bool ret = true;
>         int open_return;
> diff --git a/tools/perf/util/print-events.h b/tools/perf/util/print-events.h
> index 1da9910d83a6..ad2902fd0507 100644
> --- a/tools/perf/util/print-events.h
> +++ b/tools/perf/util/print-events.h
> @@ -1,14 +1,15 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  #ifndef __PERF_PRINT_EVENTS_H
>  #define __PERF_PRINT_EVENTS_H
> -
>  #include <stdbool.h>
> +#include <linux/types.h>
>
>  struct event_symbol;
>
>  void print_events(const char *event_glob, bool name_only, bool quiet_flag,
>                   bool long_desc, bool details_flag, bool deprecated,
>                   const char *pmu_name);
> +bool is_event_supported(u8 type, u64 config);
>  int print_hwcache_events(const char *event_glob, bool name_only);
>  void print_sdt_events(const char *subsys_glob, const char *event_glob,
>                       bool name_only);
> --
> 2.25.1
>
