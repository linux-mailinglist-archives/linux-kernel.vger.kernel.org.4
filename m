Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBBF05FA7A8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 00:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbiJJWdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 18:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiJJWdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 18:33:04 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD35C5D0C6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 15:33:03 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id i64-20020a1c3b43000000b003c6bf423c71so52993wma.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 15:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b84Mp8WPmv+V8VPNOsJnOQtQBtwAIaKOf1r81e26uMM=;
        b=le0/qN6D/NvMLVGXOGx+db9ejU8GmDnAm7b1PdYDPDJGdBqHu1EWO4xndC/AH2bEPZ
         igWJkSO6HgUHymQR7NKvbE8XXp7LDBysWgYZQFstX4bWRcgh8LFbTL/fXfQ8sIjDzgyx
         ZaiT0v/1TxPDGZLNyq6c8G2r8aj8Um4TlP6ORRSsYCXdVRxBGiN0QIga2MFFzV70545p
         1mUHwJijJYeoYMcbN0qBBC7s/k9lzcNJbQ04rKnSD7QgwVAy5X6Z2LEkBiyEhmz1k0SP
         5K6LvOq/0rhhGrmuEr3lf3zr1wRVCI/LsO3h5Isvua/HRBo04rzeuM5tWAMpNa4jxG7Y
         RLfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b84Mp8WPmv+V8VPNOsJnOQtQBtwAIaKOf1r81e26uMM=;
        b=45JWZI7tQseG/tKpZeYgsvua6BW/98ksXc8LVhwSmWU1wWTt8Fd48KCkJJX2bmm7rZ
         Ve2wAXt8yj6uqpYfPcURXiyTDYCwc8kYY89xReCvJ+Fjo+W1k832caJ9zjtAONZJ7DxZ
         6+5MYTFaTd2kUKHmLCywx5gMTFMfIAbcwZ2KHCFKLeerEL7FYTLjyQmCUACuP1qtX5Rj
         ExyoWF9HI7Yt7mXaQ0sKNtLFEW8p+j7+XuHZ2y7+PjZLRjYqs7dDTezzOj45o6DVJ2GX
         HHKGdty6aJahPLz8Ncl/fYozK4fbVMdnyNhPkWYmv0kmKYHQRcRwR2Qsh/peuIBD9X5E
         RrBA==
X-Gm-Message-State: ACrzQf21mSuHz64DLoswotvEl6HuFcolDLw6kb+ApvEsakbUb4DaGigY
        lBtv/5kcXVPScbsEJ8/rEpDDLN0TPnAZRsmw3douvA==
X-Google-Smtp-Source: AMsMyM6twfkEC4RDL89F4fZ9Hv1Hy6451EfvtruUSif3ZBySTujPli59Rfxtlg7DMl79f7Vb0tuimQUh9kO3tRftkf4=
X-Received: by 2002:a05:600c:88a:b0:3c5:c9e3:15cc with SMTP id
 l10-20020a05600c088a00b003c5c9e315ccmr6968017wmp.67.1665441182223; Mon, 10
 Oct 2022 15:33:02 -0700 (PDT)
MIME-Version: 1.0
References: <20221010053600.272854-1-namhyung@kernel.org> <20221010053600.272854-4-namhyung@kernel.org>
In-Reply-To: <20221010053600.272854-4-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 10 Oct 2022 15:32:50 -0700
Message-ID: <CAP-5=fW_z9z+46AKwh4GqM=2skXyLXkCMEOO4kxT0kShEp9k2Q@mail.gmail.com>
Subject: Re: [PATCH 03/19] perf stat: Use evsel__is_hybrid() more
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        James Clark <james.clark@arm.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
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

On Sun, Oct 9, 2022 at 10:36 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> In the stat-display code, it needs to check if the current evsel is
> hybrid but it uses perf_pmu__has_hybrid() which can return true for
> non-hybrid event too.  I think it's better to use evsel__is_hybrid().
>
> Also remove a NULL check for the 'config' parameter in the
> hybrid_merge() since it's called after config->no_merge check.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/stat-display.c | 20 ++++----------------
>  1 file changed, 4 insertions(+), 16 deletions(-)
>
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index 5c47ee9963a7..4113aa86772f 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -704,7 +704,7 @@ static void uniquify_event_name(struct evsel *counter)
>                         counter->name = new_name;
>                 }
>         } else {
> -               if (perf_pmu__has_hybrid()) {
> +               if (evsel__is_hybrid(counter)) {
>                         ret = asprintf(&new_name, "%s/%s/",
>                                        counter->pmu_name, counter->name);
>                 } else {
> @@ -744,26 +744,14 @@ static void collect_all_aliases(struct perf_stat_config *config, struct evsel *c
>         }
>  }
>
> -static bool is_uncore(struct evsel *evsel)
> -{
> -       struct perf_pmu *pmu = evsel__find_pmu(evsel);
> -
> -       return pmu && pmu->is_uncore;
> -}
> -
> -static bool hybrid_uniquify(struct evsel *evsel)
> -{
> -       return perf_pmu__has_hybrid() && !is_uncore(evsel);
> -}
> -
>  static bool hybrid_merge(struct evsel *counter, struct perf_stat_config *config,
>                          bool check)
>  {
> -       if (hybrid_uniquify(counter)) {
> +       if (evsel__is_hybrid(counter)) {
>                 if (check)
> -                       return config && config->hybrid_merge;
> +                       return config->hybrid_merge;
>                 else
> -                       return config && !config->hybrid_merge;
> +                       return !config->hybrid_merge;
>         }
>
>         return false;
> --
> 2.38.0.rc1.362.ged0d419d3c-goog
>
