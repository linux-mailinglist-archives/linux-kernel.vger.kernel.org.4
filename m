Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2349C651BC3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 08:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233522AbiLTHfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 02:35:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233208AbiLTHfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 02:35:48 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F10113A;
        Mon, 19 Dec 2022 23:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671521747; x=1703057747;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=Io5/0LTamGxAQ1GAoe77xZCJBzvj1G4adgYcSaVbOu4=;
  b=MZIWh/zk1DpcFjoSc85L3NJlUe7huV6wGF4Czpthd/Jdp/jIi/XeQygR
   lF+1t+VbRjFESurCe3BTWGqLw9VHCtrkfJLL5oGDBSpXGInq0r6zdm+xP
   NE6u/nYnLVAfticGfIXqoKiS4jPwAqePlowLxf7oSGNepodJOaREppsHO
   Sv/nNQ3/jY8kJY+TKvqBjj6Rf5jknL02lmEDDvmsgwgZbtwdI+bYrwCm5
   hLxrum+3x/qmVmwln6joibLKNb/62AFeDDTykNTa75MH1I0OCTMfWjLVC
   xMbgJhfD+M5L583RF91qdXGVTsvLSxrs+giEp/9tglIKfoQlAPDZzZ0uG
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="299892100"
X-IronPort-AV: E=Sophos;i="5.96,258,1665471600"; 
   d="scan'208";a="299892100"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 23:35:46 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="628626396"
X-IronPort-AV: E=Sophos;i="5.96,258,1665471600"; 
   d="scan'208";a="628626396"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.45.157])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 23:35:39 -0800
Message-ID: <e2c01688-d27d-51df-65eb-f7bdd26c99d0@intel.com>
Date:   Tue, 20 Dec 2022 09:35:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH 1/3] perf tools: Set debug_peo_args and redirect_to_stderr
 to correct values in perf_quiet_option
Content-Language: en-US
To:     Yang Jihong <yangjihong1@huawei.com>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, carsten.haitzler@arm.com,
        leo.yan@linaro.org, ravi.bangoria@amd.com, martin.lau@kernel.org,
        ak@linux.intel.com, masami.hiramatsu.pt@hitachi.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221220035702.188413-1-yangjihong1@huawei.com>
 <20221220035702.188413-2-yangjihong1@huawei.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221220035702.188413-2-yangjihong1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/12/22 05:57, Yang Jihong wrote:
> When perf uses quiet mode, perf_quiet_option sets debug_peo_args to -1,
> and display_attr incorrectly determines the value of debug_peo_args.
> As a result, unexpected information is displayed.
> 
> Before:
>   # perf record --quiet -- ls > /dev/null
>   ------------------------------------------------------------
>   perf_event_attr:
>     size                             128
>     { sample_period, sample_freq }   4000
>     sample_type                      IP|TID|TIME|PERIOD
>     read_format                      ID|LOST
>     disabled                         1
>     inherit                          1
>     mmap                             1
>     comm                             1
>     freq                             1
>     enable_on_exec                   1
>     task                             1
>     precise_ip                       3
>     sample_id_all                    1
>     exclude_guest                    1
>     mmap2                            1
>     comm_exec                        1
>     ksymbol                          1
>     bpf_event                        1
>   ------------------------------------------------------------
>   ...
> 
> After:
>   # perf record --quiet -- ls > /dev/null
>   #
> 
> redirect_to_stderr is a similar problem.
> 
> Fixes: f78eaef0e049 ("perf tools: Allow to force redirect pr_debug to stderr.")
> Fixes: ccd26741f5e6 ("perf tool: Provide an option to print perf_event_open args and return value")
> Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/perf/util/debug.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/perf/util/debug.c b/tools/perf/util/debug.c
> index 65e6c22f38e4..190e818a0717 100644
> --- a/tools/perf/util/debug.c
> +++ b/tools/perf/util/debug.c
> @@ -241,6 +241,10 @@ int perf_quiet_option(void)
>  		opt++;
>  	}
>  
> +	/* For debug variables that are used as bool types, set to 0. */
> +	redirect_to_stderr = 0;
> +	debug_peo_args = 0;
> +
>  	return 0;
>  }
>  

