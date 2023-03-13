Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F7B6B8300
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 21:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjCMUmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 16:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjCMUmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 16:42:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC627222E7;
        Mon, 13 Mar 2023 13:41:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0AEFAB815BD;
        Mon, 13 Mar 2023 20:41:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6999DC433EF;
        Mon, 13 Mar 2023 20:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678740112;
        bh=bJXg9mYFCKPj9PiWaVA2SmE2ljg2bwrnaELxXbWxheU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cNzpsfBa2zg+Jts3NPng/BkK2iy+1PQwQBuERgWck6OQ5ozPYOnrPFGvx33hcMiCY
         qDQ5rDi9awn7Wd2BBOY/c6hBAtWmguvnDrG/3X3EVyRSdbaeGbmAFRongT6cZHSbR4
         IRflqshTeMSim7USoOHN12q81qUWeGJPyN5aTojWtO9dAItFvb5OnPc221YJJV0uFQ
         4IB55ae+XlwBQ7hlP6YqFyNu/c2QoBriWy2bcwSxYpwioErGVfNm8MZjiQ//NOjZxA
         jjxPQ6f0g3YfhRV04d6Q/SKXVZjU3Sx+Euai5Hc2+BzDMDUTSoeiZhw5pc5wkaLtoC
         QotEF8YwxZ3nA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 172E84049F; Mon, 13 Mar 2023 17:41:50 -0300 (-03)
Date:   Mon, 13 Mar 2023 17:41:50 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
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
Subject: Re: [PATCH v4 06/11] perf evsel: Add function to compute group PMU
 name
Message-ID: <ZA+KjvtPyDDb0Xb5@kernel.org>
References: <20230308225912.1960990-1-irogers@google.com>
 <20230308225912.1960990-7-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230308225912.1960990-7-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 08, 2023 at 02:59:07PM -0800, Ian Rogers escreveu:
> The computed name respects software events and aux event groups, such
> that the pmu_name is changed to be that of the aux event leader or
> group leader for software events. This is done as a later change will
> split events that are in different PMUs into different groups.

This makes 'perf test python' to fail:

⬢[acme@toolbox perf-tools-next]$ perf test -v python
Couldn't bump rlimit(MEMLOCK), failures may take place when creating BPF maps, etc
 19: 'import perf' in python                                         :
--- start ---
test child forked, pid 720242
python usage test: "echo "import sys ; sys.path.append('/tmp/build/perf-tools-next/python'); import perf" | '/usr/bin/python3' "
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
ImportError: /tmp/build/perf-tools-next/python/perf.cpython-311-x86_64-linux-gnu.so: undefined symbol: evsel__is_aux_event
test child finished with -1
---- end ----
'import perf' in python: FAILED!
⬢[acme@toolbox perf-tools-next]$

So I added the following patch, please run 'perf test' and 'make -C
tools/perf build-test' before submitting patch series.

- Arnaldo

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index ab48ffbb644805df..be336f1b2b689602 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -93,6 +93,11 @@ int perf_pmu__scan_file(struct perf_pmu *pmu, const char *name, const char *fmt,
 	return EOF;
 }
 
+bool evsel__is_aux_event(const struct evsel *evsel __maybe_unused)
+{
+	return false;
+}
+
 /*
  * Add this one here not to drag util/metricgroup.c
  */
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/evsel.c | 24 ++++++++++++++++++++++++
>  tools/perf/util/evsel.h |  1 +
>  2 files changed, 25 insertions(+)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 2dc2c24252bb..51d9650267d0 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -821,6 +821,30 @@ const char *evsel__name(struct evsel *evsel)
>  	return "unknown";
>  }
>  
> +const char *evsel__group_pmu_name(const struct evsel *evsel)
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
> index 676c499323e9..d26745ca6147 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -280,6 +280,7 @@ int arch_evsel__hw_name(struct evsel *evsel, char *bf, size_t size);
>  
>  int __evsel__hw_cache_type_op_res_name(u8 type, u8 op, u8 result, char *bf, size_t size);
>  const char *evsel__name(struct evsel *evsel);
> +const char *evsel__group_pmu_name(const struct evsel *evsel);
>  const char *evsel__metric_id(const struct evsel *evsel);
>  
>  static inline bool evsel__is_tool(const struct evsel *evsel)
> -- 
> 2.40.0.rc0.216.gc4246ad0f0-goog
> 

-- 

- Arnaldo
