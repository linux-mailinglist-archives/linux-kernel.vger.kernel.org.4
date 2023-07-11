Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1360074EFF2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 15:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbjGKNNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 09:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbjGKNNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 09:13:42 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3979E55;
        Tue, 11 Jul 2023 06:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689081213; x=1720617213;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=j/p/nhIRZ9ZpkuLx/tRzZlO+OaCeIIAB7XnwRxGyg1w=;
  b=oFsRI2oOOeUHp6c6QQol62UsaFCBVL6uyfgaH9tzPu5VnNyLk8+S2wPN
   lfC9UDqQDpCsjcCBX3rpnJueXuGuvyq6sL2aZkq61pqI16HNpKH+TonkL
   xrdTBbTaMbqZ0xk/thJcj8q6qiV0OBK7SbB4xtFRSS6Ei4f+conG8NxDq
   MncPVjLrRaj2CLJwWrvTOdnSX8PUaKKMi5SovdJ7kIRPZsgNTOsLLzBNk
   XSSGKnSRVRaPFhhlHGbrRbqR/4XjEjMKJopW4yZE5a6zgxsYxln2x9LLc
   UNm1z87XbbnPyj0JyXqho2CL2BoVZUfL6fUN++3JqkJa6L10jMzMhvQl+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="362077029"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="362077029"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 06:13:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="786620609"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="786620609"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.44.50])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 06:13:30 -0700
Message-ID: <206972a3-d44d-1c75-3fbc-426427614543@intel.com>
Date:   Tue, 11 Jul 2023 16:13:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH 3/5] perf record: Tracking side-band events for all CPUs
 when tracing selected CPUs
Content-Language: en-US
To:     Yang Jihong <yangjihong1@huawei.com>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, kan.liang@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20230704074217.240939-1-yangjihong1@huawei.com>
 <20230704074217.240939-4-yangjihong1@huawei.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230704074217.240939-4-yangjihong1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/07/23 10:42, Yang Jihong wrote:
> User space tasks can migrate between CPUs, we need to track side-band
> events for all CPUs.
> 
> The specific scenarios are as follows:
> 
>          CPU0                                 CPU1
>   perf record -C 0 start
>                               taskA starts to be created and executed
>                                 -> PERF_RECORD_COMM and PERF_RECORD_MMAP
>                                    events only deliver to CPU1
>                               ......
>                                 |
>                           migrate to CPU0
>                                 |
>   Running on CPU0    <----------/
>   ...
> 
>   perf record -C 0 stop
> 
> Now perf samples the PC of taskA. However, perf does not record the
> PERF_RECORD_COMM and PERF_RECORD_COMM events of taskA.
> Therefore, the comm and symbols of taskA cannot be parsed.
> 
> The sys_perf_event_open invoked is as follows:
> 
>   # perf --debug verbose=3 record -e cpu-clock -C 1 true
>   <SNIP>
>   Opening: cpu-clock
>   ------------------------------------------------------------
>   perf_event_attr:
>     type                             1
>     size                             136
>     { sample_period, sample_freq }   4000
>     sample_type                      IP|TID|TIME|ID|CPU|PERIOD
>     read_format                      ID|LOST
>     disabled                         1
>     inherit                          1
>     freq                             1
>     sample_id_all                    1
>     exclude_guest                    1
>   ------------------------------------------------------------
>   sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 = 5
>   Opening: dummy:HG
>   ------------------------------------------------------------
>   perf_event_attr:
>     type                             1
>     size                             136
>     config                           0x9
>     { sample_period, sample_freq }   4000
>     sample_type                      IP|TID|TIME|ID|CPU|PERIOD
>     read_format                      ID|LOST
>     inherit                          1
>     mmap                             1
>     comm                             1
>     freq                             1
>     task                             1
>     sample_id_all                    1
>     mmap2                            1
>     comm_exec                        1
>     ksymbol                          1
>     bpf_event                        1
>   ------------------------------------------------------------
>   sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 6
>   sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 = 7
>   sys_perf_event_open: pid -1  cpu 2  group_fd -1  flags 0x8 = 9
>   sys_perf_event_open: pid -1  cpu 3  group_fd -1  flags 0x8 = 10
>   sys_perf_event_open: pid -1  cpu 4  group_fd -1  flags 0x8 = 11
>   sys_perf_event_open: pid -1  cpu 5  group_fd -1  flags 0x8 = 12
>   sys_perf_event_open: pid -1  cpu 6  group_fd -1  flags 0x8 = 13
>   sys_perf_event_open: pid -1  cpu 7  group_fd -1  flags 0x8 = 14
>   <SNIP>
> 
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> ---
>  tools/perf/builtin-record.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 8872cd037f2c..69e0d8c75aab 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -908,6 +908,31 @@ static int record__config_off_cpu(struct record *rec)
>  	return off_cpu_prepare(rec->evlist, &rec->opts.target, &rec->opts);
>  }
>  
> +static int record__config_tracking_events(struct record *rec)
> +{
> +	struct evsel *evsel;
> +	struct evlist *evlist = rec->evlist;
> +	struct record_opts *opts = &rec->opts;
> +
> +	/*
> +	 * User space tasks can migrate between CPUs, so when tracing
> +	 * selected CPUs, sideband for all CPUs is still needed.
> +	 */
> +	if (opts->target.cpu_list) {

I am not sure if anyone minds doing this by default, but perhaps
we should say something about it on the perf record man page.

> +		evsel = evlist__findnew_tracking_event(evlist);
> +		if (!evsel)
> +			return -ENOMEM;
> +
> +		if (!evsel->core.system_wide) {
> +			evsel->core.system_wide = true;
> +			evsel__set_sample_bit(evsel, TIME);
> +			perf_evlist__propagate_maps(&evlist->core, &evsel->core);
> +		}

Perhaps better to export via internel/evsel.h

void perf_evsel__go_system_wide(struct perf_evlist *evlist, struct perf_evsel *evsel)
{
	if (!evsel->system_wide) {
		evsel->system_wide = true;
		if (evlist->needs_map_propagation)
			__perf_evlist__propagate_maps(evlist, evsel);
	}
}

As suggested in response to patch 2, perhaps deal with system_wide
inside evlist__findnew_tracking_event()

> +	}
> +
> +	return 0;
> +}
> +
>  static bool record__kcore_readable(struct machine *machine)
>  {
>  	char kcore[PATH_MAX];
> @@ -4235,6 +4260,12 @@ int cmd_record(int argc, const char **argv)
>  		goto out;
>  	}
>  
> +	err = record__config_tracking_events(rec);
> +	if (err) {
> +		pr_err("record__config_tracking_events failed, error %d\n", err);
> +		goto out;
> +	}
> +
>  	err = record__init_thread_masks(rec);
>  	if (err) {
>  		pr_err("Failed to initialize parallel data streaming masks\n");

