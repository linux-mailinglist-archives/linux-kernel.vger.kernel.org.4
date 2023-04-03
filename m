Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F79A6D3C90
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 06:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbjDCEvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 00:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjDCEvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 00:51:10 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F61CB775;
        Sun,  2 Apr 2023 21:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680497468; x=1712033468;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wktO4jGj6Olw+xf9VLolWIuo0fOfy/aVqpJj2kX8sZA=;
  b=nvJ35yr3A9LdL2JwI90nqf5NiD2tY68Eofi83kmNXqC/VePhkyeJOioh
   vsG2XpKv6dbjkK9YEVly7GV778k15Jd3t/QrdtPneRY/vl7zKpoQKJd4m
   mQrrfhhZn38+F9I9BzVS7PXnq8fjF2Cs6TjLinhZMpq4X15bjZocoTEED
   wvPSYVlUPIM/m90ayxAsIIHB+jIsBE48WvdFGuSCDxraGVKrF9KSDm7On
   XbZ17NRGVvTPsoYRvUN96bXHQ4Q9r3BzQmO//6iapqReAdzncEAxvOa3Q
   yBDIE4i2cZYZfaZkw5Ld5flJ/vBvkB3lI30EDdId78r8Z9w9O8Zdnenov
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10668"; a="343499588"
X-IronPort-AV: E=Sophos;i="5.98,314,1673942400"; 
   d="scan'208";a="343499588"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2023 21:51:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10668"; a="688368267"
X-IronPort-AV: E=Sophos;i="5.98,314,1673942400"; 
   d="scan'208";a="688368267"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.40.243])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2023 21:51:04 -0700
Message-ID: <eb1c058c-f84f-ae94-ced6-92f22b6d9b69@intel.com>
Date:   Mon, 3 Apr 2023 07:51:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.1
Subject: Re: [PATCH 9/9] perf intel-pt: Use perf_pmu__scan_file_at() if
 possible
To:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>
References: <20230331202949.810326-1-namhyung@kernel.org>
 <20230331202949.810326-10-namhyung@kernel.org>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230331202949.810326-10-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/03/23 23:29, Namhyung Kim wrote:
> Intel-PT calls perf_pmu__scan_file() a lot, let's use relative address
> when it accesses multiple files at one place.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/perf/arch/x86/util/intel-pt.c | 52 ++++++++++++++++++-----------
>  1 file changed, 32 insertions(+), 20 deletions(-)
> 
> diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
> index 1e39a034cee9..2cff11de9d8a 100644
> --- a/tools/perf/arch/x86/util/intel-pt.c
> +++ b/tools/perf/arch/x86/util/intel-pt.c
> @@ -194,16 +194,19 @@ static u64 intel_pt_default_config(struct perf_pmu *intel_pt_pmu)
>  	int pos = 0;
>  	u64 config;
>  	char c;
> +	int dirfd;
> +
> +	dirfd = perf_pmu__event_source_devices_fd();
>  
>  	pos += scnprintf(buf + pos, sizeof(buf) - pos, "tsc");
>  
> -	if (perf_pmu__scan_file(intel_pt_pmu, "caps/mtc", "%d",
> -				&mtc) != 1)
> +	if (perf_pmu__scan_file_at(intel_pt_pmu, dirfd, "caps/mtc", "%d",
> +				   &mtc) != 1)
>  		mtc = 1;
>  
>  	if (mtc) {
> -		if (perf_pmu__scan_file(intel_pt_pmu, "caps/mtc_periods", "%x",
> -					&mtc_periods) != 1)
> +		if (perf_pmu__scan_file_at(intel_pt_pmu, dirfd, "caps/mtc_periods", "%x",
> +					   &mtc_periods) != 1)
>  			mtc_periods = 0;
>  		if (mtc_periods) {
>  			mtc_period = intel_pt_pick_bit(mtc_periods, 3);
> @@ -212,13 +215,13 @@ static u64 intel_pt_default_config(struct perf_pmu *intel_pt_pmu)
>  		}
>  	}
>  
> -	if (perf_pmu__scan_file(intel_pt_pmu, "caps/psb_cyc", "%d",
> -				&psb_cyc) != 1)
> +	if (perf_pmu__scan_file_at(intel_pt_pmu, dirfd, "caps/psb_cyc", "%d",
> +				   &psb_cyc) != 1)
>  		psb_cyc = 1;
>  
>  	if (psb_cyc && mtc_periods) {
> -		if (perf_pmu__scan_file(intel_pt_pmu, "caps/psb_periods", "%x",
> -					&psb_periods) != 1)
> +		if (perf_pmu__scan_file_at(intel_pt_pmu, dirfd, "caps/psb_periods", "%x",
> +					   &psb_periods) != 1)
>  			psb_periods = 0;
>  		if (psb_periods) {
>  			psb_period = intel_pt_pick_bit(psb_periods, 3);
> @@ -227,8 +230,8 @@ static u64 intel_pt_default_config(struct perf_pmu *intel_pt_pmu)
>  		}
>  	}
>  
> -	if (perf_pmu__scan_file(intel_pt_pmu, "format/pt", "%c", &c) == 1 &&
> -	    perf_pmu__scan_file(intel_pt_pmu, "format/branch", "%c", &c) == 1)
> +	if (perf_pmu__scan_file_at(intel_pt_pmu, dirfd, "format/pt", "%c", &c) == 1 &&
> +	    perf_pmu__scan_file_at(intel_pt_pmu, dirfd, "format/branch", "%c", &c) == 1)
>  		pos += scnprintf(buf + pos, sizeof(buf) - pos, ",pt,branch");
>  
>  	pr_debug2("%s default config: %s\n", intel_pt_pmu->name, buf);
> @@ -236,6 +239,7 @@ static u64 intel_pt_default_config(struct perf_pmu *intel_pt_pmu)
>  	intel_pt_parse_terms(intel_pt_pmu->name, &intel_pt_pmu->format, buf,
>  			     &config);
>  
> +	close(dirfd);
>  	return config;
>  }
>  
> @@ -488,7 +492,7 @@ static void intel_pt_valid_str(char *str, size_t len, u64 valid)
>  	}
>  }
>  
> -static int intel_pt_val_config_term(struct perf_pmu *intel_pt_pmu,
> +static int intel_pt_val_config_term(struct perf_pmu *intel_pt_pmu, int dirfd,
>  				    const char *caps, const char *name,
>  				    const char *supported, u64 config)
>  {
> @@ -498,11 +502,11 @@ static int intel_pt_val_config_term(struct perf_pmu *intel_pt_pmu,
>  	u64 bits;
>  	int ok;
>  
> -	if (perf_pmu__scan_file(intel_pt_pmu, caps, "%llx", &valid) != 1)
> +	if (perf_pmu__scan_file_at(intel_pt_pmu, dirfd, caps, "%llx", &valid) != 1)
>  		valid = 0;
>  
>  	if (supported &&
> -	    perf_pmu__scan_file(intel_pt_pmu, supported, "%d", &ok) == 1 && !ok)
> +	    perf_pmu__scan_file_at(intel_pt_pmu, dirfd, supported, "%d", &ok) == 1 && !ok)
>  		valid = 0;
>  
>  	valid |= 1;
> @@ -531,37 +535,45 @@ static int intel_pt_val_config_term(struct perf_pmu *intel_pt_pmu,
>  static int intel_pt_validate_config(struct perf_pmu *intel_pt_pmu,
>  				    struct evsel *evsel)
>  {
> -	int err;
> +	int err, dirfd;
>  	char c;
>  
>  	if (!evsel)
>  		return 0;
>  
> +	dirfd = perf_pmu__event_source_devices_fd();
> +	if (dirfd < 0)
> +		return dirfd;
> +
>  	/*
>  	 * If supported, force pass-through config term (pt=1) even if user
>  	 * sets pt=0, which avoids senseless kernel errors.
>  	 */
> -	if (perf_pmu__scan_file(intel_pt_pmu, "format/pt", "%c", &c) == 1 &&
> +	if (perf_pmu__scan_file_at(intel_pt_pmu, dirfd, "format/pt", "%c", &c) == 1 &&
>  	    !(evsel->core.attr.config & 1)) {
>  		pr_warning("pt=0 doesn't make sense, forcing pt=1\n");
>  		evsel->core.attr.config |= 1;
>  	}
>  
> -	err = intel_pt_val_config_term(intel_pt_pmu, "caps/cycle_thresholds",
> +	err = intel_pt_val_config_term(intel_pt_pmu, dirfd, "caps/cycle_thresholds",
>  				       "cyc_thresh", "caps/psb_cyc",
>  				       evsel->core.attr.config);
>  	if (err)
> -		return err;
> +		goto out;
>  
> -	err = intel_pt_val_config_term(intel_pt_pmu, "caps/mtc_periods",
> +	err = intel_pt_val_config_term(intel_pt_pmu, dirfd, "caps/mtc_periods",
>  				       "mtc_period", "caps/mtc",
>  				       evsel->core.attr.config);
>  	if (err)
> -		return err;
> +		goto out;
>  
> -	return intel_pt_val_config_term(intel_pt_pmu, "caps/psb_periods",
> +	err = intel_pt_val_config_term(intel_pt_pmu, dirfd, "caps/psb_periods",
>  					"psb_period", "caps/psb_cyc",
>  					evsel->core.attr.config);
> +
> +out:
> +	close(dirfd);
> +	return err;
>  }
>  
>  static void intel_pt_config_sample_mode(struct perf_pmu *intel_pt_pmu,

