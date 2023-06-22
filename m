Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7251A73ABCA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 23:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjFVVtW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 22 Jun 2023 17:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjFVVtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 17:49:20 -0400
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BAC61FEF;
        Thu, 22 Jun 2023 14:49:19 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-bc40d4145feso7106322276.1;
        Thu, 22 Jun 2023 14:49:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687470559; x=1690062559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q3O7vHNH1CH0WOmympzRGlXkSOKdbKkxR1VXAbXylCc=;
        b=fIm/pUDgNKZEG+YMoJ6i/f+tHN9R/2A0/3ig7+p/PBh1cxgJF6ocy8qU+bmKWZxE8k
         OSU9YxutFq2vTTC81WSyYtYchT7o3apJAkBy/txvObS53XXO8y0Qln+1uAfaH6rM2vNO
         PRfdXt4HQb4tcVUZk1jDCjPpUEy5rzl1klaFTgNwUOfWLKf0TpxAZpmbzb6fod9IDwY2
         5/OcA6P+AIuhJTpQ8uKe4ECyRqocOti2anKnExQHMiaVIIkybzUBaiC3dtN8vLyFnwrN
         k2uiRi0vvvwQV+DD3zAxqdELdRe5ETZQ78cT2dUMhcsDKXYHLw2WQXfOQkkaksE115M/
         fXXg==
X-Gm-Message-State: AC+VfDxotFkA98IGqTVferCFMclkxbOlP6/9hzHCDzCUriSKuolUknDB
        gInbrzmI3zGcFlk7QIlEmqN2kb78jtOZ1xXZrrU=
X-Google-Smtp-Source: ACHHUZ4AzIou+U/Upi4lRxNM9TxiX8CgxmWd9MaK+LjRwNUoCPoVXK/JO1xVK+HrsxHUcUZPJxddrl0y9OOR+B91nyM=
X-Received: by 2002:a25:ab52:0:b0:ba5:ee5a:f41c with SMTP id
 u76-20020a25ab52000000b00ba5ee5af41cmr16292593ybi.1.1687470558611; Thu, 22
 Jun 2023 14:49:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230622050330.3733114-1-irogers@google.com>
In-Reply-To: <20230622050330.3733114-1-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 22 Jun 2023 14:49:06 -0700
Message-ID: <CAM9d7cjWYG4NgMPFUVC0q-u0GGekrvqpw8jU2o4KfiWqFC8x6g@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] perf pmus: Add notion of default PMU for JSON events
To:     Ian Rogers <irogers@google.com>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 10:03 PM Ian Rogers <irogers@google.com> wrote:
>
> JSON events created in pmu-events.c by jevents.py may not specify a
> PMU they are associated with, in which case it is implied that it is
> the first core PMU. Care is needed to select this for regular 'cpu',
> s390 'cpum_cf' and ARMs many names as at the point the name is first
> needed the core PMUs list hasn't been initialized. Add a helper in
> perf_pmus to create this value, in the worst case by scanning sysfs.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---

[SNIP]
> diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> index d891d72c824e..80797e1b862f 100644
> --- a/tools/perf/util/pmus.c
> +++ b/tools/perf/util/pmus.c
> @@ -524,6 +524,37 @@ bool perf_pmus__supports_extended_type(void)
>         return perf_pmus__do_support_extended_type;
>  }
>
> +char *perf_pmus__default_pmu_name(void)
> +{
> +       int fd;
> +       DIR *dir;
> +       struct dirent *dent;
> +       char *result = NULL;
> +
> +       if (!list_empty(&core_pmus))
> +               return strdup(list_first_entry(&core_pmus, struct perf_pmu, list)->name);
> +
> +       fd = perf_pmu__event_source_devices_fd();
> +       if (fd < 0)
> +               return strdup("cpu");
> +
> +       dir = fdopendir(fd);
> +       if (!dir)
> +               return strdup("cpu");

close(fd) ?

Thanks,
Namhyung


> +
> +       while ((dent = readdir(dir))) {
> +               if (!strcmp(dent->d_name, ".") || !strcmp(dent->d_name, ".."))
> +                       continue;
> +               if (is_pmu_core(dent->d_name)) {
> +                       result = strdup(dent->d_name);
> +                       break;
> +               }
> +       }
> +
> +       closedir(dir);
> +       return result ?: strdup("cpu");
> +}
> +
>  struct perf_pmu *evsel__find_pmu(const struct evsel *evsel)
>  {
>         struct perf_pmu *pmu = evsel->pmu;
> diff --git a/tools/perf/util/pmus.h b/tools/perf/util/pmus.h
> index d02ffea5d3a4..a21464432d0f 100644
> --- a/tools/perf/util/pmus.h
> +++ b/tools/perf/util/pmus.h
> @@ -20,5 +20,6 @@ void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *p
>  bool perf_pmus__have_event(const char *pname, const char *name);
>  int perf_pmus__num_core_pmus(void);
>  bool perf_pmus__supports_extended_type(void);
> +char *perf_pmus__default_pmu_name(void);
>
>  #endif /* __PMUS_H */
> --
> 2.41.0.162.gfafddb0af9-goog
>
