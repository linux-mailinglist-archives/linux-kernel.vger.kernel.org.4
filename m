Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3071651F7F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 12:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233239AbiLTLMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 06:12:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiLTLMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 06:12:40 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5AA03893;
        Tue, 20 Dec 2022 03:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671534759; x=1703070759;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=w1ZAhGBzzJHb3xIFdx7hwZ1j1w3juoTNvzuyuuVRmE8=;
  b=ZPu5iC0jzXp4r/AglhEi6pcVAUvE6oFBsZqTMWm5HpMEWXYAEc/bwVJH
   AziPe/sZ7leQjCgEtxUEi3YpAVTL+VUgjtOjGrewf4dhiLaw7fBjTGbia
   9emWh9hjMjMVaauuGgACk93k66IA3BXRSiQX+SVVidJtglQFDylifmIdG
   40XgVUfKJ9EpGJkJzLOf7pS3FAHGwxANV2a4FAcIM/lccjB0LC9gjFckI
   30IQ0RmrkgNDLYxxpB4o6C2LP1Q5E/xlCRmLLrPt1JaRiaGxR6TM8QLGo
   mDcS70fiBdjEz+frRTTOm8rYnZ1AgivTNp19+rWboForfLlk3zCEZZDFc
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="381810699"
X-IronPort-AV: E=Sophos;i="5.96,259,1665471600"; 
   d="scan'208";a="381810699"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2022 03:12:39 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="793261405"
X-IronPort-AV: E=Sophos;i="5.96,259,1665471600"; 
   d="scan'208";a="793261405"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.45.157])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2022 03:12:31 -0800
Message-ID: <6e24e97c-899c-53d0-5e55-a6337a555327@intel.com>
Date:   Tue, 20 Dec 2022 13:12:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH 3/3] perf probe: Check -v and -q options in the right
 place
Content-Language: en-US
To:     Yang Jihong <yangjihong1@huawei.com>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, carsten.haitzler@arm.com,
        leo.yan@linaro.org, ravi.bangoria@amd.com, martin.lau@kernel.org,
        ak@linux.intel.com, masami.hiramatsu.pt@hitachi.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221220035702.188413-1-yangjihong1@huawei.com>
 <20221220035702.188413-4-yangjihong1@huawei.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221220035702.188413-4-yangjihong1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/12/22 05:57, Yang Jihong wrote:
> Check the -q and -v options first to return earlier on error.
> 
> Before:
>   # perf probe -q -v test
>   probe-definition(0): test
>   symbol:test file:(null) line:0 offset:0 return:0 lazy:(null)
>   0 arguments
>     Error: -v and -q are exclusive.
> 
> After:
>   # perf probe -q -v test
>     Error: -v and -q are exclusive.
> 
> Fixes: 5e17b28f1e24 ("perf probe: Add --quiet option to suppress output result message")
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/perf/builtin-probe.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/perf/builtin-probe.c b/tools/perf/builtin-probe.c
> index 2ae50fc9e597..ed73d0b89ca2 100644
> --- a/tools/perf/builtin-probe.c
> +++ b/tools/perf/builtin-probe.c
> @@ -612,6 +612,15 @@ __cmd_probe(int argc, const char **argv)
>  
>  	argc = parse_options(argc, argv, options, probe_usage,
>  			     PARSE_OPT_STOP_AT_NON_OPTION);
> +
> +	if (quiet) {
> +		if (verbose != 0) {
> +			pr_err("  Error: -v and -q are exclusive.\n");
> +			return -EINVAL;
> +		}
> +		verbose = -1;
> +	}
> +
>  	if (argc > 0) {
>  		if (strcmp(argv[0], "-") == 0) {
>  			usage_with_options_msg(probe_usage, options,
> @@ -633,14 +642,6 @@ __cmd_probe(int argc, const char **argv)
>  	if (ret)
>  		return ret;
>  
> -	if (quiet) {
> -		if (verbose != 0) {
> -			pr_err("  Error: -v and -q are exclusive.\n");
> -			return -EINVAL;
> -		}
> -		verbose = -1;
> -	}
> -
>  	if (probe_conf.max_probes == 0)
>  		probe_conf.max_probes = MAX_PROBES;
>  

