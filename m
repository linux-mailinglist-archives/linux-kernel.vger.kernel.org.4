Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D122D621DEF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 21:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiKHUqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 15:46:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiKHUpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 15:45:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC48412D2D;
        Tue,  8 Nov 2022 12:45:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 572B9B81C4B;
        Tue,  8 Nov 2022 20:45:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D374EC433C1;
        Tue,  8 Nov 2022 20:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667940307;
        bh=DSBCu+RydhA/a3vpSxpoFbrYgkJstV98kA8Gx6Gp9BA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lDpZyGzxNYSzQkkzWIE7u2N7EMtpoAxG8a32VQJCaw7E0HiMBhSZ46L18Jqet5y+2
         gDAZgM1gOV5nBjlygn+IFD0FF+PWswqrsC8HcSYzdO4GPPYROvj9XeoiD+Y3a2B50Y
         8BxEBLVn2wjsLkOa4oAN5bgojsuuM1c1ZDEx5tKvR76/vBq/n3xtJVdVLO+iioe6OE
         apzzoF7pPszYVHi9yngyNzfIYwdq0YYCJjAlAlWdpVElh8KUv6RvCnv4G9KjTJUFGM
         lTB1tpu2Fg35FLSGABaU4CSRTG3wniI2KEd3+VnLE4kmvLUCuelIVlOEqAULtmJopb
         Cs1kXZ42s8crg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2FE394034E; Tue,  8 Nov 2022 17:45:04 -0300 (-03)
Date:   Tue, 8 Nov 2022 17:45:04 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        James Clark <james.clark@arm.com>
Subject: Re: [PATCH 5/9] perf stat: Fix --metric-only --json output
Message-ID: <Y2q/0LNDCspN0Tm8@kernel.org>
References: <20221107213314.3239159-1-namhyung@kernel.org>
 <20221107213314.3239159-6-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107213314.3239159-6-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Nov 07, 2022 at 01:33:10PM -0800, Namhyung Kim escreveu:
> Currently it prints all metric headers for JSON output.  But actually it
> skips some metrics with valid_only_metric().  So the output looks like:
> 
>   $ perf stat --metric-only --json true
>   {"unit" : "CPUs utilized", "unit" : "/sec", "unit" : "/sec", "unit" : "/sec", "unit" : "GHz", "unit" : "insn per cycle", "unit" : "/sec", "unit" : "branch-misses of all branches"}
>   {"metric-value" : "3.861"}{"metric-value" : "0.79"}{"metric-value" : "3.04"}
> 
> As you can see there are 8 units in the header but only 3 metric-values
> are there.  It should skip the unused headers as well.  Also each unit
> should be printed as a separate object like metric values.
> 
> With this patch:
> 
>   $ perf stat --metric-only --json true
>   {"unit" : "GHz"}{"unit" : "insn per cycle"}{"unit" : "branch-misses of all branches"}
>   {"metric-value" : "4.166"}{"metric-value" : "0.73"}{"metric-value" : "2.96"}

Can we get a Fixes tag for this one?

- Arnaldo
 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/stat-display.c | 22 +++-------------------
>  1 file changed, 3 insertions(+), 19 deletions(-)
> 
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index 115477461224..515fb6db3d67 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -430,12 +430,12 @@ static void print_metric_header(struct perf_stat_config *config,
>  	    os->evsel->priv != os->evsel->evlist->selected->priv)
>  		return;
>  
> -	if (!valid_only_metric(unit) && !config->json_output)
> +	if (!valid_only_metric(unit))
>  		return;
>  	unit = fixunit(tbuf, os->evsel, unit);
>  
>  	if (config->json_output)
> -		fprintf(os->fh, "\"unit\" : \"%s\"", unit);
> +		fprintf(os->fh, "{\"unit\" : \"%s\"}", unit);
>  	else if (config->csv_output)
>  		fprintf(os->fh, "%s%s", unit, config->csv_sep);
>  	else
> @@ -847,10 +847,6 @@ static void print_metric_headers(struct perf_stat_config *config,
>  		.new_line = new_line_metric,
>  		.force_header = true,
>  	};
> -	bool first = true;
> -
> -	if (config->json_output && !config->interval)
> -		fprintf(config->output, "{");
>  
>  	if (prefix && !config->json_output)
>  		fprintf(config->output, "%s", prefix);
> @@ -871,18 +867,12 @@ static void print_metric_headers(struct perf_stat_config *config,
>  	evlist__for_each_entry(evlist, counter) {
>  		os.evsel = counter;
>  
> -		if (!first && config->json_output)
> -			fprintf(config->output, ", ");
> -		first = false;
> -
>  		perf_stat__print_shadow_stats(config, counter, 0,
>  					      0,
>  					      &out,
>  					      &config->metric_events,
>  					      &rt_stat);
>  	}
> -	if (config->json_output)
> -		fprintf(config->output, "}");
>  	fputc('\n', config->output);
>  }
>  
> @@ -954,14 +944,8 @@ static void print_interval(struct perf_stat_config *config,
>  		}
>  	}
>  
> -	if ((num_print_interval == 0 || config->interval_clear)
> -			 && metric_only && !config->json_output)
> +	if ((num_print_interval == 0 || config->interval_clear) && metric_only)
>  		print_metric_headers(config, evlist, " ", true);
> -	if ((num_print_interval == 0 || config->interval_clear)
> -			 && metric_only && config->json_output) {
> -		fprintf(output, "{");
> -		print_metric_headers(config, evlist, " ", true);
> -	}
>  	if (++num_print_interval == 25)
>  		num_print_interval = 0;
>  }
> -- 
> 2.38.1.431.g37b22c650d-goog

-- 

- Arnaldo
