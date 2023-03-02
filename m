Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5D16A8449
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 15:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjCBOjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 09:39:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjCBOjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 09:39:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B320B2A6FC;
        Thu,  2 Mar 2023 06:39:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4655E615D2;
        Thu,  2 Mar 2023 14:39:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EE8DC433D2;
        Thu,  2 Mar 2023 14:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677767959;
        bh=+6aE/Q/gEbdk0VnH+27QNOv9p1fOfMaR+j7PKnHb2Ao=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hP0Yc6MqGVGWZnrbC7ATGwlQXJ44QSEOk4XDYBAxaB6CuKfjhWy41MEGRFzXbtvXQ
         GbRSvIhL8x8ctWOTKSTC8FqfdFrD1hjmmPZfbOLjoG66qC8L2ta3H+x/Bqn7iV97yM
         S5QRScb8IpWUa/8tXNqQovOEk9zm2uPp3Y1J+zJrmR51WGFk/yUbWqeRtXDVSkF7SZ
         7u8SkTJOyksWFg+UNvvYC/1EbwT5x/JAX3EoDVSQ+GspYGM0ZG9+XR/YmjrbFYvDq4
         80s3ZsA7xFquhw1ImLwH4zHb9ZQ2oARKCTCiqlIHSDTUMQ89uHH8O3H/3Y2boJS7E8
         H4wE+uRGrXZtA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DD6844049F; Thu,  2 Mar 2023 11:39:16 -0300 (-03)
Date:   Thu, 2 Mar 2023 11:39:16 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
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
Subject: Re: [PATCH v1 07/10] perf evsel: Add function to compute pmu_name
Message-ID: <ZAC1FK0EHA4reQid@kernel.org>
References: <20230302041211.852330-1-irogers@google.com>
 <20230302041211.852330-8-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302041211.852330-8-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 01, 2023 at 08:12:08PM -0800, Ian Rogers escreveu:
> The computed pmu_name respects software events and aux event groups,
> such that the pmu_name is changed to be that of the aux event leader
> or group leader for software events. This is done as a later change
> will split events that are in different PMUs into different groups.

Adrian, can you please take a look and provide an Ack or Reviewed-by?

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/evsel.c | 24 ++++++++++++++++++++++++
>  tools/perf/util/evsel.h |  1 +
>  2 files changed, 25 insertions(+)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 2dc2c24252bb..9c6b486f8bd4 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -821,6 +821,30 @@ const char *evsel__name(struct evsel *evsel)
>  	return "unknown";
>  }
>  
> +const char *evsel__pmu_name(const struct evsel *evsel)
> +{
> +	const struct evsel *leader;
> +
> +	/* If the pmu_name is set use it. pmu_name isn't set for CPU and software events. */
> +	if (evsel->pmu_name)
> +		return evsel->pmu_name;
> +	/*
> +	 * Software events may be in a group with other uncore PMU events. Use
> +	 * the pmu_name of the group leader to avoid breaking the software event
> +	 * out of the group.
> +	 *
> +	 * Aux event leaders, like intel_pt, expect a group with events from
> +	 * other PMUs, so substitute the AUX event's PMU in this case.
> +	 */
> +	leader  = evsel__leader(evsel);
> +	if ((evsel->core.attr.type == PERF_TYPE_SOFTWARE || evsel__is_aux_event(leader)) &&
> +	    leader->pmu_name) {
> +		return leader->pmu_name;
> +	}
> +
> +	return "cpu";
> +}
> +
>  const char *evsel__metric_id(const struct evsel *evsel)
>  {
>  	if (evsel->metric_id)
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 676c499323e9..72121194d3b1 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -280,6 +280,7 @@ int arch_evsel__hw_name(struct evsel *evsel, char *bf, size_t size);
>  
>  int __evsel__hw_cache_type_op_res_name(u8 type, u8 op, u8 result, char *bf, size_t size);
>  const char *evsel__name(struct evsel *evsel);
> +const char *evsel__pmu_name(const struct evsel *evsel);
>  const char *evsel__metric_id(const struct evsel *evsel);
>  
>  static inline bool evsel__is_tool(const struct evsel *evsel)
> -- 
> 2.39.2.722.g9855ee24e9-goog
> 

-- 

- Arnaldo
