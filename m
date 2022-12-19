Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56EFD6507ED
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 08:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbiLSHAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 02:00:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbiLSG76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 01:59:58 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A2162CA;
        Sun, 18 Dec 2022 22:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671433194; x=1702969194;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=Nxsaw3RCZ61ommUNocIgB+tNXnRqKXLXJfUHk01BRaQ=;
  b=IyaQg8iDhS03OFOacY87s3YebFN1WW2hdibsxqHaRL9xw2x9DGtbUV4s
   QlaS26b7CWUlEK9eVQ8yjiBTmvYEuuDMayzUoCPfzvikLl/6HoYAaNXrs
   velV1ddX9FhmORHU4KiKM71f26KRmYl1owzHzFaJycciXvJRP9b/LyJO1
   2BJdTtwwrT/X5zAL0LS1P7umup6o0TW1dphtCsLl9WGh+V4L2qcnVlT+Z
   XekGZAQ/tcSHzFSBUwkb/ENg/gRL5auzEyEGEMYRz9ZF/X3MPCR+qA0AH
   SDbU4UtfMEhwPdv+1+Ci20gkeMfYDviLe1ChL1tRc9tEheFfnBoGQnJDl
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="306960682"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="306960682"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2022 22:59:53 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="652594336"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="652594336"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.60.197])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2022 22:59:49 -0800
Message-ID: <194c676b-3a73-7f34-1f29-a157b5e4731f@intel.com>
Date:   Mon, 19 Dec 2022 08:59:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH] perf tool: Fix output unexpected messages in quiet mode
Content-Language: en-US
To:     Yang Jihong <yangjihong1@huawei.com>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, kan.liang@linux.intel.com,
        kim.phillips@amd.com, german.gomez@arm.com, ravi.bangoria@amd.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221219024911.62741-1-yangjihong1@huawei.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221219024911.62741-1-yangjihong1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/12/22 04:49, Yang Jihong wrote:
> When perf uses quiet mode, perf_quiet_option sets debug_peo_args to -1,

Seems like redirect_to_stderr has similar issue?

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
> Fixes: ccd26741f5e6 ("perf tool: Provide an option to print perf_event_open args and return value")
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/perf/util/debug.h | 2 +-
>  tools/perf/util/evsel.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/debug.h b/tools/perf/util/debug.h
> index f99468a7f681..f6ab84c93ec0 100644
> --- a/tools/perf/util/debug.h
> +++ b/tools/perf/util/debug.h
> @@ -41,7 +41,7 @@ extern int debug_data_convert;
>  
>  /* Special macro to print perf_event_open arguments/return value. */
>  #define pr_debug2_peo(fmt, ...) {				\
> -	if (debug_peo_args)						\
> +	if (debug_peo_args > 0)						\
>  		pr_debugN(0, pr_fmt(fmt), ##__VA_ARGS__);	\
>  	else							\
>  		pr_debugN(2, pr_fmt(fmt), ##__VA_ARGS__);	\
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 999dd1700502..45cf144c5d5d 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1775,7 +1775,7 @@ static int __open_attr__fprintf(FILE *fp, const char *name, const char *val,
>  
>  static void display_attr(struct perf_event_attr *attr)
>  {
> -	if (verbose >= 2 || debug_peo_args) {
> +	if (verbose >= 2 || debug_peo_args > 0) {
>  		fprintf(stderr, "%.60s\n", graph_dotted_line);
>  		fprintf(stderr, "perf_event_attr:\n");
>  		perf_event_attr__fprintf(stderr, attr, __open_attr__fprintf, NULL);

