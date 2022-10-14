Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C1D5FF44A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 22:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbiJNUEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 16:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiJNUEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 16:04:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6759810BF;
        Fri, 14 Oct 2022 13:04:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C22AFB8234D;
        Fri, 14 Oct 2022 20:04:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 499A1C433C1;
        Fri, 14 Oct 2022 20:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665777881;
        bh=WgK8GBODPu1il2l6bsz7fk4bsQA1FopzCrhUOulcM70=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lfzljnxZzAC2jO/hx2kly2jM4aiqMiyneVW6H27F17PXKtYJh0BYrHkzWP11NIqEZ
         y+fq6qBvKdrp0f3eIZIZ6idKv5U7D2plbHmI5ONgld1G2EAJ1WMfoxIYyQBDcOGqte
         fHK6U58HSZW2DZsUEhroVUciKzqFj5ooKy+54tURxNGHmGIiRlBgaN3lVimzKhYZt2
         qSHdC09YLieWGSermrs+fDekE3LZVyjRo1LaDn3N1nzFdytYk9Fx5DsIXd2vx6ARqJ
         0SA9YOF+JqhevnXRhxXmAmUAtZexC6umSMDhnh+39SGXB6Lq1OsRSU0wiRPIGiCFg0
         bqqFmaFsKpwCg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9A31A4062C; Fri, 14 Oct 2022 17:04:38 -0300 (-03)
Date:   Fri, 14 Oct 2022 17:04:38 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        James Clark <james.clark@arm.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
Subject: Re: [PATCH 20/19] perf stat: Factor out evsel__count_has_error()
Message-ID: <Y0nA1jdFU6XBlZRL@kernel.org>
References: <CAM9d7ch_CV3mpno+6D23UGaXzL9zhmzmt513RzbWq8q_0DhU4A@mail.gmail.com>
 <20221014181655.771612-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221014181655.771612-1-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Oct 14, 2022 at 11:16:55AM -0700, Namhyung Kim escreveu:
> It's possible to have 0 enabled/running time for some per-task or per-cgroup
> events since it's not scheduled on any CPU.  Treating the whole event as
> failed would not work in this case.  Thinking again, the code only existed
> when any CPU-level aggregation is enabled (like per-socket, per-core, ...).
> 
> To make it clearer, factor out the condition check into the new
> evsel__count_has_error() function and add some comments.

So I should just add this one to the 19-long patchkit I already applied
locally, ok.

- Arnaldo
 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/stat.c | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> index 6ab9c58beca7..9dfa8cac6bc4 100644
> --- a/tools/perf/util/stat.c
> +++ b/tools/perf/util/stat.c
> @@ -396,6 +396,25 @@ static int check_per_pkg(struct evsel *counter, struct perf_counts_values *vals,
>  	return ret;
>  }
>  
> +static bool evsel__count_has_error(struct evsel *evsel,
> +				   struct perf_counts_values *count,
> +				   struct perf_stat_config *config)
> +{
> +	/* the evsel was failed already */
> +	if (evsel->err || evsel->counts->scaled == -1)
> +		return true;
> +
> +	/* this is meaningful for CPU aggregation modes only */
> +	if (config->aggr_mode == AGGR_GLOBAL)
> +		return false;
> +
> +	/* it's considered ok when it actually ran */
> +	if (count->ena != 0 && count->run != 0)
> +		return false;
> +
> +	return true;
> +}
> +
>  static int
>  process_counter_values(struct perf_stat_config *config, struct evsel *evsel,
>  		       int cpu_map_idx, int thread,
> @@ -450,11 +469,9 @@ process_counter_values(struct perf_stat_config *config, struct evsel *evsel,
>  
>  			/*
>  			 * When any result is bad, make them all to give consistent output
> -			 * in interval mode.  But per-task counters can have 0 enabled time
> -			 * when some tasks are idle.
> +			 * in interval mode.
>  			 */
> -			if (((count->ena == 0 || count->run == 0) && cpu.cpu != -1) ||
> -			    evsel->counts->scaled == -1) {
> +			if (evsel__count_has_error(evsel, count, config) && !ps_aggr->failed) {
>  				ps_aggr->counts.val = 0;
>  				ps_aggr->counts.ena = 0;
>  				ps_aggr->counts.run = 0;
> -- 
> 2.38.0.413.g74048e4d9e-goog

-- 

- Arnaldo
