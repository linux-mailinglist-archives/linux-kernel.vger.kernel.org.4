Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63A526F07FE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 17:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244155AbjD0PNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 11:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244148AbjD0PNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 11:13:14 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2F449DA
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 08:13:08 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-94f3cd32799so1645785666b.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 08:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682608387; x=1685200387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NeBk/Yk/tCKSm9zlw8XBLS3MyuzxPAzmRgBGwCvp8c8=;
        b=sexcVZfa88+7XgOsY4DtZg3NpDOi0YOBTqZE/lAAqHKwozNF+1DWWNuym2Om7Vyojp
         R1jVGP1BQJxreqE5SRU9T0wNuObDian/4lLoVQIv47juXcgFkhKUIlle7By7XRjfIo4u
         r6Kzj5maGCzrfaqZZICpAazcOUV7pye3eneTrxrefBqy4xNu64siMmTxnmNO/o7n5sWj
         8AWHTN3bhtdSMp6oyGN8PZuIRRRRwiyqPeBFMYkeHGXBgykypQz+2Zjlq7rIV3LR9f5o
         v7z47KfhC5OdjLI5qr26oga5R4jLLNJmpqz42FP19Nx2OYX1oNhOuVl3mh6SonhpPsrY
         mJqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682608387; x=1685200387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NeBk/Yk/tCKSm9zlw8XBLS3MyuzxPAzmRgBGwCvp8c8=;
        b=Y4Oxe+nW7DKASaMHCrYkMMbsszZkDnw++X0yMFcGlEzrGcWJ+8z4ut4xWW1eJNYTzH
         k8gMGgun68x9Vp1L/DTrSaA3O/MmjfDXouaXLRB1ua6Bgd8MOgLgfHZLgqNKskAh/jJL
         tCMr3aTK1lTCl0HxLGf/6NYNhi8cJl5iWsRXlYj2Iw8gJSTOpjz+L9yiYwHlZGQ+hN/k
         RKl+pyYZH3YB1IRvB04A34jWi5GhsHIXELXioOanZK2o4b7stDUUrz2h6Rx2b3rarvwf
         BTiG9/7ebzDDyOPax+e0NAuIOYI5KKjFonsJwMvFF6HdAcX25x2NEiTM0kbjYLqUJTHa
         uHmg==
X-Gm-Message-State: AC+VfDxLm4X0Ap6vMGVd6HxNQn2Fmz9A2REffM1WJaqbQL7wD+hxcvAd
        yqCjWy5HVN5jgW0QJEPrfTxz8Q==
X-Google-Smtp-Source: ACHHUZ63/NlO7m1YriYCSLQPoie926jmdL+ZNo65Jn2E8If3ralnqSvBORtWtKCIRx2jAAUJibk9Fw==
X-Received: by 2002:a17:907:7b92:b0:94f:1c90:cb70 with SMTP id ne18-20020a1709077b9200b0094f1c90cb70mr2064124ejc.66.1682608386610;
        Thu, 27 Apr 2023 08:13:06 -0700 (PDT)
Received: from leoy-huanghe ([195.167.132.10])
        by smtp.gmail.com with ESMTPSA id bc28-20020a056402205c00b00506c3c0d393sm8130857edb.78.2023.04.27.08.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 08:12:40 -0700 (PDT)
Date:   Thu, 27 Apr 2023 23:12:28 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org, coresight@lists.linaro.org,
        shy828301@gmail.com, denik@google.com,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
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
Subject: Re: [PATCH 4/7] perf: cs-etm: Validate options after applying
 themperf_pmu__format_bits
Message-ID: <20230427151228.GA152865@leoy-huanghe>
References: <20230424134748.228137-1-james.clark@arm.com>
 <20230424134748.228137-5-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424134748.228137-5-james.clark@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Mon, Apr 24, 2023 at 02:47:44PM +0100, James Clark wrote:
> Currently the cs_etm_set_option() function both validates and applies
> the config options. Because it's only called when they are added
> automatically, there are some paths where the user can apply the option
> on the command line and skip the validation. By moving it to the end it
> covers both cases.
> 
> Also, options don't need to be re-applied anyway, Perf handles parsing
> and applying the config terms automatically.
> 
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  tools/perf/arch/arm/util/cs-etm.c | 152 +++++++++++++-----------------
>  1 file changed, 68 insertions(+), 84 deletions(-)
> 
> diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
> index f9b9ebf7fffc..af0a2400c655 100644
> --- a/tools/perf/arch/arm/util/cs-etm.c
> +++ b/tools/perf/arch/arm/util/cs-etm.c
> @@ -69,21 +69,29 @@ static const char * const metadata_ete_ro[] = {
>  static bool cs_etm_is_etmv4(struct auxtrace_record *itr, int cpu);
>  static bool cs_etm_is_ete(struct auxtrace_record *itr, int cpu);
>  
> -static int cs_etm_set_context_id(struct auxtrace_record *itr,
> -				 struct evsel *evsel, int cpu)
> +static int cs_etm_validate_context_id(struct auxtrace_record *itr,
> +				      struct evsel *evsel, int cpu)
>  {
> -	struct cs_etm_recording *ptr;
> -	struct perf_pmu *cs_etm_pmu;
> +	struct cs_etm_recording *ptr =
> +		container_of(itr, struct cs_etm_recording, itr);
> +	struct perf_pmu *cs_etm_pmu = ptr->cs_etm_pmu;
>  	char path[PATH_MAX];
> -	int err = -EINVAL;
> +	int err;
>  	u32 val;
> -	u64 contextid;
> +	u64 contextid =
> +		evsel->core.attr.config &
> +		(perf_pmu__format_bits(&cs_etm_pmu->format, "contextid1") |
> +		 perf_pmu__format_bits(&cs_etm_pmu->format, "contextid2"));

Seems to me, this would break backward compability.

The old kernel (before 5.11) doesn't provide 'contextid1' and
'contextid2', so we always check the entry 'contextid' rather than
'contextid1' and 'contextid2'.

With this change, if a kernel doesn't contain 'contextid1' and
'contextid2' formats, will perf tool never trace for contexid?

Thanks,
Leo

>  
> -	ptr = container_of(itr, struct cs_etm_recording, itr);
> -	cs_etm_pmu = ptr->cs_etm_pmu;
> +	if (!contextid)
> +		return 0;
>  
> -	if (!cs_etm_is_etmv4(itr, cpu))
> -		goto out;
> +	/* Not supported in etmv3 */
> +	if (!cs_etm_is_etmv4(itr, cpu)) {
> +		pr_err("%s: contextid not supported in ETMv3, disable with %s/contextid=0/\n",
> +		       CORESIGHT_ETM_PMU_NAME, CORESIGHT_ETM_PMU_NAME);
> +		return -EINVAL;
> +	}
>  
>  	/* Get a handle on TRCIDR2 */
>  	snprintf(path, PATH_MAX, "cpu%d/%s",
> @@ -92,27 +100,13 @@ static int cs_etm_set_context_id(struct auxtrace_record *itr,
>  
>  	/* There was a problem reading the file, bailing out */
>  	if (err != 1) {
> -		pr_err("%s: can't read file %s\n",
> -		       CORESIGHT_ETM_PMU_NAME, path);
> -		goto out;
> +		pr_err("%s: can't read file %s\n", CORESIGHT_ETM_PMU_NAME,
> +		       path);
> +		return err;
>  	}
>  
> -	/* User has configured for PID tracing, respects it. */
> -	contextid = evsel->core.attr.config &
> -			(BIT(ETM_OPT_CTXTID) | BIT(ETM_OPT_CTXTID2));
> -
> -	/*
> -	 * If user doesn't configure the contextid format, parse PMU format and
> -	 * enable PID tracing according to the "contextid" format bits:
> -	 *
> -	 *   If bit ETM_OPT_CTXTID is set, trace CONTEXTIDR_EL1;
> -	 *   If bit ETM_OPT_CTXTID2 is set, trace CONTEXTIDR_EL2.
> -	 */
> -	if (!contextid)
> -		contextid = perf_pmu__format_bits(&cs_etm_pmu->format,
> -						  "contextid");
> -
> -	if (contextid & BIT(ETM_OPT_CTXTID)) {
> +	if (contextid &
> +	    perf_pmu__format_bits(&cs_etm_pmu->format, "contextid1")) {
>  		/*
>  		 * TRCIDR2.CIDSIZE, bit [9-5], indicates whether contextID
>  		 * tracing is supported:
> @@ -122,14 +116,14 @@ static int cs_etm_set_context_id(struct auxtrace_record *itr,
>  		 */
>  		val = BMVAL(val, 5, 9);
>  		if (!val || val != 0x4) {
> -			pr_err("%s: CONTEXTIDR_EL1 isn't supported\n",
> -			       CORESIGHT_ETM_PMU_NAME);
> -			err = -EINVAL;
> -			goto out;
> +			pr_err("%s: CONTEXTIDR_EL1 isn't supported, disable with %s/contextid1=0/\n",
> +			       CORESIGHT_ETM_PMU_NAME, CORESIGHT_ETM_PMU_NAME);
> +			return -EINVAL;
>  		}
>  	}
>  
> -	if (contextid & BIT(ETM_OPT_CTXTID2)) {
> +	if (contextid &
> +	    perf_pmu__format_bits(&cs_etm_pmu->format, "contextid2")) {
>  		/*
>  		 * TRCIDR2.VMIDOPT[30:29] != 0 and
>  		 * TRCIDR2.VMIDSIZE[14:10] == 0b00100 (32bit virtual contextid)
> @@ -138,35 +132,34 @@ static int cs_etm_set_context_id(struct auxtrace_record *itr,
>  		 * Any value of VMIDSIZE >= 4 (i.e, > 32bit) is fine for us.
>  		 */
>  		if (!BMVAL(val, 29, 30) || BMVAL(val, 10, 14) < 4) {
> -			pr_err("%s: CONTEXTIDR_EL2 isn't supported\n",
> -			       CORESIGHT_ETM_PMU_NAME);
> -			err = -EINVAL;
> -			goto out;
> +			pr_err("%s: CONTEXTIDR_EL2 isn't supported, disable with %s/contextid2=0/\n",
> +			       CORESIGHT_ETM_PMU_NAME, CORESIGHT_ETM_PMU_NAME);
> +			return -EINVAL;
>  		}
>  	}
>  
> -	/* All good, let the kernel know */
> -	evsel->core.attr.config |= contextid;
> -	err = 0;
> -
> -out:
> -	return err;
> +	return 0;
>  }
>  
> -static int cs_etm_set_timestamp(struct auxtrace_record *itr,
> -				struct evsel *evsel, int cpu)
> +static int cs_etm_validate_timestamp(struct auxtrace_record *itr,
> +				     struct evsel *evsel, int cpu)
>  {
> -	struct cs_etm_recording *ptr;
> -	struct perf_pmu *cs_etm_pmu;
> +	struct cs_etm_recording *ptr =
> +		container_of(itr, struct cs_etm_recording, itr);
> +	struct perf_pmu *cs_etm_pmu = ptr->cs_etm_pmu;
>  	char path[PATH_MAX];
> -	int err = -EINVAL;
> +	int err;
>  	u32 val;
>  
> -	ptr = container_of(itr, struct cs_etm_recording, itr);
> -	cs_etm_pmu = ptr->cs_etm_pmu;
> +	if (!(evsel->core.attr.config &
> +	      perf_pmu__format_bits(&cs_etm_pmu->format, "timestamp")))
> +		return 0;
>  
> -	if (!cs_etm_is_etmv4(itr, cpu))
> -		goto out;
> +	if (!cs_etm_is_etmv4(itr, cpu)) {
> +		pr_err("%s: timestamp not supported in ETMv3, disable with %s/timestamp=0/\n",
> +		       CORESIGHT_ETM_PMU_NAME, CORESIGHT_ETM_PMU_NAME);
> +		return -EINVAL;
> +	}
>  
>  	/* Get a handle on TRCIRD0 */
>  	snprintf(path, PATH_MAX, "cpu%d/%s",
> @@ -177,7 +170,7 @@ static int cs_etm_set_timestamp(struct auxtrace_record *itr,
>  	if (err != 1) {
>  		pr_err("%s: can't read file %s\n",
>  		       CORESIGHT_ETM_PMU_NAME, path);
> -		goto out;
> +		return err;
>  	}
>  
>  	/*
> @@ -189,24 +182,21 @@ static int cs_etm_set_timestamp(struct auxtrace_record *itr,
>  	 */
>  	val &= GENMASK(28, 24);
>  	if (!val) {
> -		err = -EINVAL;
> -		goto out;
> +		return -EINVAL;
>  	}
>  
> -	/* All good, let the kernel know */
> -	evsel->core.attr.config |= (1 << ETM_OPT_TS);
> -	err = 0;
> -
> -out:
> -	return err;
> +	return 0;
>  }
>  
> -#define ETM_SET_OPT_CTXTID	(1 << 0)
> -#define ETM_SET_OPT_TS		(1 << 1)
> -#define ETM_SET_OPT_MASK	(ETM_SET_OPT_CTXTID | ETM_SET_OPT_TS)
> -
> -static int cs_etm_set_option(struct auxtrace_record *itr,
> -			     struct evsel *evsel, u32 option)
> +/*
> + * Check whether the requested timestamp and contextid options should be
> + * available on all requested CPUs and if not, tell the user how to override.
> + * The kernel will silently disable any unavailable options so a warning here
> + * first is better. In theory the kernel could still disable the option for
> + * some other reason so this is best effort only.
> + */
> +static int cs_etm_validate_config(struct auxtrace_record *itr,
> +				  struct evsel *evsel)
>  {
>  	int i, err = -EINVAL;
>  	struct perf_cpu_map *event_cpus = evsel->evlist->core.user_requested_cpus;
> @@ -220,18 +210,11 @@ static int cs_etm_set_option(struct auxtrace_record *itr,
>  		    !perf_cpu_map__has(online_cpus, cpu))
>  			continue;
>  
> -		if (option & BIT(ETM_OPT_CTXTID)) {
> -			err = cs_etm_set_context_id(itr, evsel, i);
> -			if (err)
> -				goto out;
> -		}
> -		if (option & BIT(ETM_OPT_TS)) {
> -			err = cs_etm_set_timestamp(itr, evsel, i);
> -			if (err)
> -				goto out;
> -		}
> -		if (option & ~(BIT(ETM_OPT_CTXTID) | BIT(ETM_OPT_TS)))
> -			/* Nothing else is currently supported */
> +		err = cs_etm_validate_context_id(itr, evsel, i);
> +		if (err)
> +			goto out;
> +		err = cs_etm_validate_timestamp(itr, evsel, i);
> +		if (err)
>  			goto out;
>  	}
>  
> @@ -447,10 +430,10 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
>  	 * when a context switch happened.
>  	 */
>  	if (!perf_cpu_map__empty(cpus)) {
> -		err = cs_etm_set_option(itr, cs_etm_evsel,
> -					BIT(ETM_OPT_CTXTID) | BIT(ETM_OPT_TS));
> -		if (err)
> -			goto out;
> +		cs_etm_evsel->core.attr.config |=
> +			perf_pmu__format_bits(&cs_etm_pmu->format, "timestamp");
> +		cs_etm_evsel->core.attr.config |=
> +			perf_pmu__format_bits(&cs_etm_pmu->format, "contextid");
>  	}
>  
>  	/* Add dummy event to keep tracking */
> @@ -466,6 +449,7 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
>  	if (!perf_cpu_map__empty(cpus))
>  		evsel__set_sample_bit(evsel, TIME);
>  
> +	err = cs_etm_validate_config(itr, cs_etm_evsel);
>  out:
>  	return err;
>  }
> -- 
> 2.34.1
> 
