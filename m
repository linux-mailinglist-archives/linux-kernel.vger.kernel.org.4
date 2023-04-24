Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD7D26ED176
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 17:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbjDXPg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 11:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjDXPg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 11:36:26 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC91187;
        Mon, 24 Apr 2023 08:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682350585; x=1713886585;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/c3+7fN4hIHgLN5YbLi2NThTNwQuocvN8Q/dAhPDBSs=;
  b=m5LfJQKouTVCU63Ee1AzvjjbE39Uw/AAyhu1dAJ8Ls2DGnRK3wrig4vm
   xDZ08U8WMmGemVYlfOi0e8TbF7vOKHMBLGjD/NBLuvvDzJS1Pia4c53jX
   T1YJ45OD+BZI1Ha8A08Ht9fGvxXKUNW90uyLz/+OUoofp+scR/3/skPLN
   CHkkaZKO/+nnbgX6xCmOrdq8N2LsvIBi3i/mFSN1CdVJdRSl1JRDdCF+4
   QxcYjUadpWKNCEHxYEK371Cm+9YxYcX1q5dpXPGlT+OitQjrO/w/qHTa3
   sV0jF+lYXm/3K/yWLexpmZDEg0TK4m1ZoZkmDIPvjK0ZIkhZfeR5LvDJm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="348393218"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="348393218"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 08:36:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="725734757"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="725734757"
Received: from hschroed-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.33.95])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 08:36:18 -0700
Message-ID: <a7940a4a-fc62-17ca-834b-73628a54cc2a@intel.com>
Date:   Mon, 24 Apr 2023 18:36:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH 2/7] perf tools: Add util function for overriding user set
 config values
To:     James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, coresight@lists.linaro.org,
        shy828301@gmail.com
Cc:     denik@google.com, Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230424134748.228137-1-james.clark@arm.com>
 <20230424134748.228137-3-james.clark@arm.com>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230424134748.228137-3-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/04/23 16:47, James Clark wrote:
> There is some duplicated code to only override config values if they
> haven't already been set by the user so make a util function for this.
> 
> Signed-off-by: James Clark <james.clark@arm.com>

One minor comment, nevertheless:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/perf/arch/arm64/util/arm-spe.c | 26 ++-----------------------
>  tools/perf/arch/x86/util/intel-pt.c  | 22 ++-------------------
>  tools/perf/util/evsel.c              | 29 ++++++++++++++++++++++++++++
>  tools/perf/util/evsel.h              |  3 +++
>  4 files changed, 36 insertions(+), 44 deletions(-)
> 
> diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
> index ef497a29e814..3b1676ff03f9 100644
> --- a/tools/perf/arch/arm64/util/arm-spe.c
> +++ b/tools/perf/arch/arm64/util/arm-spe.c
> @@ -36,29 +36,6 @@ struct arm_spe_recording {
>  	bool			*wrapped;
>  };
>  
> -static void arm_spe_set_timestamp(struct auxtrace_record *itr,
> -				  struct evsel *evsel)
> -{
> -	struct arm_spe_recording *ptr;
> -	struct perf_pmu *arm_spe_pmu;
> -	struct evsel_config_term *term = evsel__get_config_term(evsel, CFG_CHG);
> -	u64 user_bits = 0, bit;
> -
> -	ptr = container_of(itr, struct arm_spe_recording, itr);
> -	arm_spe_pmu = ptr->arm_spe_pmu;
> -
> -	if (term)
> -		user_bits = term->val.cfg_chg;
> -
> -	bit = perf_pmu__format_bits(&arm_spe_pmu->format, "ts_enable");
> -
> -	/* Skip if user has set it */
> -	if (bit & user_bits)
> -		return;
> -
> -	evsel->core.attr.config |= bit;
> -}
> -
>  static size_t
>  arm_spe_info_priv_size(struct auxtrace_record *itr __maybe_unused,
>  		       struct evlist *evlist __maybe_unused)
> @@ -238,7 +215,8 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
>  	 */
>  	if (!perf_cpu_map__empty(cpus)) {
>  		evsel__set_sample_bit(arm_spe_evsel, CPU);
> -		arm_spe_set_timestamp(itr, arm_spe_evsel);
> +		evsel__set_config_if_unset(arm_spe_pmu, arm_spe_evsel,
> +					   "ts_enable", 1);
>  	}
>  
>  	/*
> diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
> index 2cff11de9d8a..17336da08b58 100644
> --- a/tools/perf/arch/x86/util/intel-pt.c
> +++ b/tools/perf/arch/x86/util/intel-pt.c
> @@ -576,25 +576,6 @@ static int intel_pt_validate_config(struct perf_pmu *intel_pt_pmu,
>  	return err;
>  }
>  
> -static void intel_pt_config_sample_mode(struct perf_pmu *intel_pt_pmu,
> -					struct evsel *evsel)
> -{
> -	u64 user_bits = 0, bits;
> -	struct evsel_config_term *term = evsel__get_config_term(evsel, CFG_CHG);
> -
> -	if (term)
> -		user_bits = term->val.cfg_chg;
> -
> -	bits = perf_pmu__format_bits(&intel_pt_pmu->format, "psb_period");
> -
> -	/* Did user change psb_period */
> -	if (bits & user_bits)
> -		return;
> -
> -	/* Set psb_period to 0 */
> -	evsel->core.attr.config &= ~bits;
> -}
> -
>  static void intel_pt_min_max_sample_sz(struct evlist *evlist,
>  				       size_t *min_sz, size_t *max_sz)
>  {
> @@ -686,7 +667,8 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
>  		return 0;
>  
>  	if (opts->auxtrace_sample_mode)
> -		intel_pt_config_sample_mode(intel_pt_pmu, intel_pt_evsel);
> +		evsel__set_config_if_unset(intel_pt_pmu, intel_pt_evsel,
> +					   "psb_period", 0);
>  
>  	err = intel_pt_validate_config(intel_pt_pmu, intel_pt_evsel);
>  	if (err)
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index a85a987128aa..cdf1445136ad 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -3216,3 +3216,32 @@ void evsel__remove_from_group(struct evsel *evsel, struct evsel *leader)
>  		leader->core.nr_members--;
>  	}
>  }
> +
> +/*
> + * Set @config_name to @val as long as the user hasn't already set or cleared it
> + * by passing a config term on the command line.
> + *
> + * @val is the value to put into the bits specified by @config_name rather than
> + * the bit pattern. It is shifted into position by this function, so to set
> + * something to true, pass 1 for val rather than a pre shifted value.
> + */
> +#define field_prep(_mask, _val) (((_val) << (ffsll(_mask) - 1)) & (_mask))

I notice there is already tools/include/linux/bitfield.h
so may FIELD_PREP from there could be used?

> +void evsel__set_config_if_unset(struct perf_pmu *pmu, struct evsel *evsel,
> +				const char *config_name, u64 val)
> +{
> +	u64 user_bits = 0, bits;
> +	struct evsel_config_term *term = evsel__get_config_term(evsel, CFG_CHG);
> +
> +	if (term)
> +		user_bits = term->val.cfg_chg;
> +
> +	bits = perf_pmu__format_bits(&pmu->format, config_name);
> +
> +	/* Do nothing if the user changed the value */
> +	if (bits & user_bits)
> +		return;
> +
> +	/* Otherwise replace it */
> +	evsel->core.attr.config &= ~bits;
> +	evsel->core.attr.config |= field_prep(bits, val);
> +}
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 68072ec655ce..4120f5ff673d 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -529,4 +529,7 @@ bool arch_evsel__must_be_in_group(const struct evsel *evsel);
>  	((((src) >> (pos)) & ((1ull << (size)) - 1)) << (63 - ((pos) + (size) - 1)))
>  
>  u64 evsel__bitfield_swap_branch_flags(u64 value);
> +void evsel__set_config_if_unset(struct perf_pmu *pmu, struct evsel *evsel,
> +				const char *config_name, u64 val);
> +
>  #endif /* __PERF_EVSEL_H */

