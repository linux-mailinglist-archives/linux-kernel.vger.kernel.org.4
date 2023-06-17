Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E81734324
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 20:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346403AbjFQSpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 14:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234202AbjFQSpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 14:45:42 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EBB41FF6;
        Sat, 17 Jun 2023 11:45:09 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5169f614977so2736462a12.3;
        Sat, 17 Jun 2023 11:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687027506; x=1689619506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZAnFthHZjL8KszDLjcc1on4TtpcboEwPmZRXv600XOs=;
        b=qlSxYMZbH2VejBAg3fxxdWmCijwt4af/sMxHpKLuTsEZ2CzySaPUdycM+vMTSp9Rkw
         5SP7RlSnzWRCo3ql6JwUK2P0P/vp/2dnfNklJ01z7wzhQRfit48P9+trKQrksnH2Ciod
         8oHM2lLkf/9oDqyXg8aQl8FHeaSL5X67t7SMCONCAvdjhESTyYqHXs5TTYBVvoJtTr0r
         H+PfCUwya3C5FtjdPJEgdi3rq5YH8B4ZTzO8F5U05JbmyyM8gabZAXIu1Fy1I7AkI5vl
         ge9dQqQYPL31yrUpoZO/72QP6FcplJXFBbbiIFnhMfsLi8yIVI5BWoECaYOAlOvZrXs5
         JSBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687027506; x=1689619506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZAnFthHZjL8KszDLjcc1on4TtpcboEwPmZRXv600XOs=;
        b=U0X/ag5CxdTwwPAd3t2u9FTT6uAWZFfZaG3aan3+oSrDCO3Ww7F+yOUhb8y+wt2+t4
         DvZ+rKt6LhVyZkOQW5STDyqTaSD7Iay/6wtTBblNSqJ0lJ6H4tOy9NoTUN1EshKQO4XS
         hZbk32sUUfJ/J2OSMT838BCpihUW86+3pniIiFLMhFmMp3nu9s8bwBQix6uZ14xKG3IW
         +ylg8SeCazQk/glf2dzqNWFWIYiNXQIBd57juLetBdAaTDMH/OlBTbWobMAAa0pBr8HP
         tuPRQZDPpM7r7GxsDFDaXchIbHXS9nYbCQ1TCoo2I/S41AMsqd7qwQzetCRdxswpqMo2
         +J+A==
X-Gm-Message-State: AC+VfDzWMc/lOmhYALUxFDzFXe7v2Dqxl8JQtTsYCH86IUFMAmsyZuIV
        z77ofe/LzLCs1oHm9J5h1ek=
X-Google-Smtp-Source: ACHHUZ5VaJD+0bgwGCExPVPKzl3nxZ+awIA3XIsTb4l6yjSh2s/EwHOY21QcPixxHX6akhtEijHYKg==
X-Received: by 2002:a17:907:360e:b0:96a:4ea0:a1e7 with SMTP id bk14-20020a170907360e00b0096a4ea0a1e7mr5501038ejc.50.1687027505612;
        Sat, 17 Jun 2023 11:45:05 -0700 (PDT)
Received: from krava ([83.240.63.131])
        by smtp.gmail.com with ESMTPSA id sb23-20020a170906edd700b00983cb4bd8f4sm2748541ejb.119.2023.06.17.11.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jun 2023 11:45:05 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Sat, 17 Jun 2023 20:45:02 +0200
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 2/2] perf stat: Show average value on multiple runs
Message-ID: <ZI3/LphHu0tP6pib@krava>
References: <20230616073211.1057936-1-namhyung@kernel.org>
 <20230616073211.1057936-2-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616073211.1057936-2-namhyung@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 12:32:11AM -0700, Namhyung Kim wrote:
> When -r option is used, perf stat runs the command multiple times and
> update stats in the evsel->stats.res_stats for global aggregation.  But
> the value is never used and the value it prints at the end is just the
> value from the last run.  I think we should print the average number of
> multiple runs.
> 
> Add evlist__copy_res_stats() to update the aggr counter (for display)
> using the values in the evsel->stats.res_stats.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

this is the 'real' fix right? I thought this was the way it worked before

anyway works nicely now, would be nice to add some tests for this,
but not sure how bad it'd be ;-)

Acked/Tested-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> ---
>  tools/perf/builtin-stat.c |  5 ++++-
>  tools/perf/util/stat.c    | 22 ++++++++++++++++++++++
>  tools/perf/util/stat.h    |  1 +
>  3 files changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index e549862f90f0..42f84975a4d5 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -2829,8 +2829,11 @@ int cmd_stat(int argc, const char **argv)
>  		}
>  	}
>  
> -	if (!forever && status != -1 && (!interval || stat_config.summary))
> +	if (!forever && status != -1 && (!interval || stat_config.summary)) {
> +		if (stat_config.run_count > 1)
> +			evlist__copy_res_stats(&stat_config, evsel_list);
>  		print_counters(NULL, argc, argv);
> +	}
>  
>  	evlist__finalize_ctlfd(evsel_list);
>  
> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> index 0f7b8a8cdea6..967e583392c7 100644
> --- a/tools/perf/util/stat.c
> +++ b/tools/perf/util/stat.c
> @@ -264,6 +264,28 @@ void evlist__copy_prev_raw_counts(struct evlist *evlist)
>  		evsel__copy_prev_raw_counts(evsel);
>  }
>  
> +static void evsel__copy_res_stats(struct evsel *evsel)
> +{
> +	struct perf_stat_evsel *ps = evsel->stats;
> +
> +	/*
> +	 * For GLOBAL aggregation mode, it updates the counts for each run
> +	 * in the evsel->stats.res_stats.  See perf_stat_process_counter().
> +	 */
> +	*ps->aggr[0].counts.values = avg_stats(&ps->res_stats);
> +}
> +
> +void evlist__copy_res_stats(struct perf_stat_config *config, struct evlist *evlist)
> +{
> +	struct evsel *evsel;
> +
> +	if (config->aggr_mode != AGGR_GLOBAL)
> +		return;
> +
> +	evlist__for_each_entry(evlist, evsel)
> +		evsel__copy_res_stats(evsel);
> +}
> +
>  static size_t pkg_id_hash(long __key, void *ctx __maybe_unused)
>  {
>  	uint64_t *key = (uint64_t *) __key;
> diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
> index 7abff7cbb5a1..1cbc26b587ba 100644
> --- a/tools/perf/util/stat.h
> +++ b/tools/perf/util/stat.h
> @@ -182,6 +182,7 @@ void evlist__save_aggr_prev_raw_counts(struct evlist *evlist);
>  
>  int evlist__alloc_aggr_stats(struct evlist *evlist, int nr_aggr);
>  void evlist__reset_aggr_stats(struct evlist *evlist);
> +void evlist__copy_res_stats(struct perf_stat_config *config, struct evlist *evlist);
>  
>  int perf_stat_process_counter(struct perf_stat_config *config,
>  			      struct evsel *counter);
> -- 
> 2.41.0.162.gfafddb0af9-goog
> 
