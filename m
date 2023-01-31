Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB181683245
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 17:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbjAaQIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 11:08:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbjAaQIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 11:08:41 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A4E518F3;
        Tue, 31 Jan 2023 08:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675181320; x=1706717320;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=572IDbqyeaZwMLascE6IAqFuhe6EJuZavAD9EAtyToU=;
  b=O8DVoYnxvNZT4Qgp3Kua8KqauNTztsolGYJ1MBIgdk2LAXefsoS6a0vZ
   7HXPWyRI3iHfE+eDBrkHYeefE+M49W4UQ1J6HqLqo9QYwKsz63b1NpmmO
   wdi4606ss8Q3vU87dgW4V5lXXiT6W9MfjWvlX7XibG65TzRBp9GykCbIO
   LbKTEfGUCvLUhQI+QUQau1MhK5AyeQuK60/P28aa4h7pmqm2BllbSWkT8
   HHILEg4nZE2jgODwmla7vjiQW54QK3wj1UMD+QrDjWoyHVT4gMwvWs46n
   U30tc8YoOC1ZGIYHSI4wZJ4AWY2Qnz3yXI6wxlYjRYHmoHdXeFzILu5fR
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="390242877"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="390242877"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 08:08:32 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="788493514"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="788493514"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.47.218])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 08:08:29 -0800
Message-ID: <fdbcc5ea-1da6-2e9d-8129-407ebd726675@intel.com>
Date:   Tue, 31 Jan 2023 18:08:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: [PATCH 2/4] perf intel-pt: Do not try to queue auxtrace data on
 pipe
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Stephane Eranian <eranian@google.com>
References: <20230131023350.1903992-1-namhyung@kernel.org>
 <20230131023350.1903992-3-namhyung@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230131023350.1903992-3-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/01/23 04:33, Namhyung Kim wrote:
> When it processes AUXTRACE_INFO, it calls to auxtrace_queue_data() to
> collect AUXTRACE data first.  That won't work with pipe since it needs
> lseek() to read the scattered aux data.
> 
>   $ perf record -o- -e intel_pt// true | perf report -i- --itrace=i100
>   # To display the perf.data header info, please use --header/--header-only options.
>   #
>   0x4118 [0xa0]: failed to process type: 70
>   Error:
>   failed to process sample
> 
> For the pipe mode, it can handle the aux data as it gets.  But there's
> no guarantee it can get the aux data in time.  So the following warning
> will be shown at the beginning:
> 
>   WARNING: Intel PT with pipe mode is not recommended.
>            The output cannot relied upon.  In particular,
>            time stamps and the order of events may be incorrect.
> 
> Fixes: dbd134322e74 ("perf intel-pt: Add support for decoding AUX area samples")
> Reviewed-by: James Clark <james.clark@arm.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Minor changes to the documentation, see below, otherwise:

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>


> ---
>  tools/perf/Documentation/perf-intel-pt.txt | 30 ++++++++++++++++++++++
>  tools/perf/util/auxtrace.c                 |  3 +++
>  tools/perf/util/intel-pt.c                 |  6 +++++
>  3 files changed, 39 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf-intel-pt.txt b/tools/perf/Documentation/perf-intel-pt.txt
> index 7b6ccd2fa3bf..9d485a9cdb19 100644
> --- a/tools/perf/Documentation/perf-intel-pt.txt
> +++ b/tools/perf/Documentation/perf-intel-pt.txt
> @@ -1821,6 +1821,36 @@ a trace that encodes the payload data into TNT packets.  Here is an example
>   $
>  
>  
> +Pipe mode
> +---------
> +Pipe mode is a problem for Intel PT and possibly other auxtrace users.
> +It's not recommended to use a pipe as data output with Intel PT because
> +of the following reason.

'following reason' -> 'reason explained below'

> +
> +Essentially the auxtrace buffers do not behave like the regular perf
> +event buffers.  That is because the head and tail are updated by
> +software, but in the auxtrace case the data is written by hardware.
> +So the head and tail do not get updated as data is written.
> +
> +In the Intel PT case, the head and tail are updated only when the trace
> +is disabled by software, for example:

Needs a blank line here, otherwise all the text is merged into 1 paragraph.

> +    - full-trace, system wide : when buffer passes watermark
> +    - full-trace, not system-wide : when buffer passes watermark or
> +                                    context switches
> +    - snapshot mode : as above but also when a snapshot is made
> +    - sample mode : as above but also when a sample is made
> +
> +That means finished-round ordering doesn't work.  An auxtrace buffer
> +can turn up that has data that extends back in time, possibly to the
> +very beginning of tracing.
> +
> +For a perf.data file, that problem is solved by going through the trace
> +and queuing up the auxtrace buffers in advance.
> +
> +For pipe mode, the order of events and timestamps can presumably
> +be messed up.

'presumably be messed up' -> can be mixed up.

> +
> +
>  EXAMPLE
>  -------
>  
> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> index c2e323cd7d49..d4b04fa07a11 100644
> --- a/tools/perf/util/auxtrace.c
> +++ b/tools/perf/util/auxtrace.c
> @@ -1133,6 +1133,9 @@ int auxtrace_queue_data(struct perf_session *session, bool samples, bool events)
>  	if (auxtrace__dont_decode(session))
>  		return 0;
>  
> +	if (perf_data__is_pipe(session->data))
> +		return 0;
> +
>  	if (!session->auxtrace || !session->auxtrace->queue_data)
>  		return -EINVAL;
>  
> diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
> index 6d3921627e33..b8b29756fbf1 100644
> --- a/tools/perf/util/intel-pt.c
> +++ b/tools/perf/util/intel-pt.c
> @@ -4379,6 +4379,12 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
>  
>  	intel_pt_setup_pebs_events(pt);
>  
> +	if (perf_data__is_pipe(session->data)) {
> +		pr_warning("WARNING: Intel PT with pipe mode is not recommended.\n"
> +			   "         The output cannot relied upon.  In particular,\n"
> +			   "         timestamps and the order of events may be incorrect.\n");
> +	}
> +
>  	if (pt->sampling_mode || list_empty(&session->auxtrace_index))
>  		err = auxtrace_queue_data(session, true, true);
>  	else

