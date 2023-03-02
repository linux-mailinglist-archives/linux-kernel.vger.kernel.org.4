Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14EEC6A843B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 15:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjCBOeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 09:34:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjCBOeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 09:34:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB26672BD;
        Thu,  2 Mar 2023 06:33:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 67B68B80F52;
        Thu,  2 Mar 2023 14:33:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA2FC433D2;
        Thu,  2 Mar 2023 14:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677767626;
        bh=BhRkTFCSc2JckHWTMswJuCDs/Jls19/WFRnTcugVLRQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hKUlDY4hZDspqJ4F1+TvxQjEtZ0Ozl5npVO5rMYTTcDeiZ4CzZMWkFpVyn2VI/Ga5
         2H3UATtWHui9mWepS6QCdh2B0KyxLZ9Vz4SXR8uexMgiTHhOq08zw8HChCtsnZ4BFd
         qNDlCJY3rDRyBJUjn/O8vglhOf6Uo1H/AFLfHaYY4fhkArr6BeBjsOVOmxzNarxt3Z
         DwA6LYJScVa83fKmGRIFrhjiJClrJgN7u9h8Y592JqfegnOH0+zTiJF3KJpyc9TcFQ
         i8HI5BPrC6E2cTE79W07vwySesOQtCrwN4acjszu5s+M1AD+FHzpxwxqFnN9T3qLuy
         psi7qAjOSV66Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B4A454049F; Thu,  2 Mar 2023 11:33:43 -0300 (-03)
Date:   Thu, 2 Mar 2023 11:33:43 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Qi Liu <liuqi115@huawei.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Sean Christopherson <seanjc@google.com>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v1 02/10] perf stat: Don't remove all grouped events when
 CPU maps disagree
Message-ID: <ZACzx4FrBa0xz5L8@kernel.org>
References: <20230302041211.852330-1-irogers@google.com>
 <20230302041211.852330-3-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302041211.852330-3-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 01, 2023 at 08:12:03PM -0800, Ian Rogers escreveu:
> If the events in an evlist's CPU map differ then the entire group is
> removed. For example:
> 
> ```
> $ perf stat -e '{imc_free_running/data_read/,imc_free_running/data_write/,cs}' -a sleep 1
> WARNING: grouped events cpus do not match, disabling group:
>   anon group { imc_free_running/data_read/, imc_free_running/data_write/, cs }
> ```
> 
> Change the behavior so that just the events not matching the leader
> are removed. So in the example above, just 'cs' will be removed.

Its a change in behaviour but a good one, I think, Jiri?

- Arnaldo
 
> Modify the warning so that it is produced once for each group, rather
> than once for the entire evlist. Shrink the scope and size of the
> warning text buffer.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-stat.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index d70b1ec88594..5c12ae5efce5 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -181,14 +181,13 @@ static bool cpus_map_matched(struct evsel *a, struct evsel *b)
>  
>  static void evlist__check_cpu_maps(struct evlist *evlist)
>  {
> -	struct evsel *evsel, *pos, *leader;
> -	char buf[1024];
> +	struct evsel *evsel, *warned_leader = NULL;
>  
>  	if (evlist__has_hybrid(evlist))
>  		evlist__warn_hybrid_group(evlist);
>  
>  	evlist__for_each_entry(evlist, evsel) {
> -		leader = evsel__leader(evsel);
> +		struct evsel *leader = evsel__leader(evsel);
>  
>  		/* Check that leader matches cpus with each member. */
>  		if (leader == evsel)
> @@ -197,19 +196,26 @@ static void evlist__check_cpu_maps(struct evlist *evlist)
>  			continue;
>  
>  		/* If there's mismatch disable the group and warn user. */
> -		WARN_ONCE(1, "WARNING: grouped events cpus do not match, disabling group:\n");
> -		evsel__group_desc(leader, buf, sizeof(buf));
> -		pr_warning("  %s\n", buf);
> -
> +		if (warned_leader != leader) {
> +			char buf[200];
> +
> +			pr_warning("WARNING: grouped events cpus do not match.\n"
> +				"Events with CPUs not matching the leader will "
> +				"be removed from the group.\n");
> +			evsel__group_desc(leader, buf, sizeof(buf));
> +			pr_warning("  %s\n", buf);
> +			warned_leader = leader;
> +		}
>  		if (verbose > 0) {
> +			char buf[200];
> +
>  			cpu_map__snprint(leader->core.cpus, buf, sizeof(buf));
>  			pr_warning("     %s: %s\n", leader->name, buf);
>  			cpu_map__snprint(evsel->core.cpus, buf, sizeof(buf));
>  			pr_warning("     %s: %s\n", evsel->name, buf);
>  		}
>  
> -		for_each_group_evsel(pos, leader)
> -			evsel__remove_from_group(pos, leader);
> +		evsel__remove_from_group(evsel, leader);
>  	}
>  }
>  
> -- 
> 2.39.2.722.g9855ee24e9-goog
> 

-- 

- Arnaldo
