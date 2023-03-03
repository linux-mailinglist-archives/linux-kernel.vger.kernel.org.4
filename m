Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8A676A9B25
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 16:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbjCCPu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 10:50:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjCCPu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 10:50:26 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7611C31F;
        Fri,  3 Mar 2023 07:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677858625; x=1709394625;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zgJrm/0CHMzsxm8TFxdkZyaRoDiAB6z4BjVyd2CwAg0=;
  b=Fv3IZj7rIwbH+eTBultqLb0k8E/0CL/xd6EnsOtt01swhhBC9gKpYXJ6
   h+hhgPuDaOezrEJ8ef2yTftRzDk8Up5KrnbM1A9RR03f+cOpG+a75mSH5
   PIJjExwRJQKQ9ml8D1kfSu15n3rQIzjaV581LMOFvg7WNnR+anfAcr8ef
   l+wwbJfRRCAoVyXPIcvSQo0eW0fjdu8n0y/hTaZtC7ZoXRc6mS+5VPpyA
   FbMWfeNPaNs0cBokPj7iRr9tlRG2RVXZGWYLan1xEhj8dp/gjvbZ9BfbO
   rQc5hGwfV3s3h3FbTLJ2W6j6td2KZ89vzahENuryxxsF4SPEqoDN3D+Hl
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="333794818"
X-IronPort-AV: E=Sophos;i="5.98,231,1673942400"; 
   d="scan'208";a="333794818"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 07:50:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="921159289"
X-IronPort-AV: E=Sophos;i="5.98,231,1673942400"; 
   d="scan'208";a="921159289"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 03 Mar 2023 07:50:24 -0800
Received: from [10.212.168.11] (kliang2-mobl1.ccr.corp.intel.com [10.212.168.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id A38F1580689;
        Fri,  3 Mar 2023 07:50:18 -0800 (PST)
Message-ID: <962de75d-8e27-9b47-662e-e324b3ba5812@linux.intel.com>
Date:   Fri, 3 Mar 2023 10:50:12 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 02/10] perf stat: Don't remove all grouped events when
 CPU maps disagree
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Sean Christopherson <seanjc@google.com>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>
References: <20230302212531.1043318-1-irogers@google.com>
 <20230302212531.1043318-3-irogers@google.com>
Content-Language: en-US
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230302212531.1043318-3-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-03-02 4:25 p.m., Ian Rogers wrote:
> If the events in an evlist's CPU map differ then the entire group is
> removed. For example:
> 
> ```
> $ perf stat -e '{imc_free_running/data_read/,imc_free_running/data_write/,cs}' -a sleep 1
> WARNING: grouped events cpus do not match, disabling group:
>   anon group { imc_free_running/data_read/, imc_free_running/data_write/, cs }
> ```
> 
> Change the behavior so that just the events not matching the leader
> are removed. So in the example above, just 'cs' will be removed.
> 
> Modify the warning so that it is produced once for each group, rather
> than once for the entire evlist. Shrink the scope and size of the
> warning text buffer.

For the uncore, we usually have to create a group for each uncore PMU.
The number of groups may be big. For example, on ICX, we have 40 CHA
PMUs. For SPR, there should be more CHAs. If we have something like
{cycles,uncore_cha/event=0x1/}, is the warning shown 40 times on ICX?
If so, it should be very annoying.

Maybe it's better to keep the current behavior which only print a
warning once and notify the users that perf will re-group the events.
For the details, they can get it from the -v option.

Thanks,
Kan
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-stat.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index d70b1ec88594..5c12ae5efce5 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -181,14 +181,13 @@ static bool cpus_map_matched(struct evsel *a, struct evsel *b)
>  
>  static void evlist__check_cpu_maps(struct evlist *evlist)
>  {
> -	struct evsel *evsel, *pos, *leader;
> -	char buf[1024];
> +	struct evsel *evsel, *warned_leader = NULL;
>  
>  	if (evlist__has_hybrid(evlist))
>  		evlist__warn_hybrid_group(evlist);
>  
>  	evlist__for_each_entry(evlist, evsel) {
> -		leader = evsel__leader(evsel);
> +		struct evsel *leader = evsel__leader(evsel);
>  
>  		/* Check that leader matches cpus with each member. */
>  		if (leader == evsel)
> @@ -197,19 +196,26 @@ static void evlist__check_cpu_maps(struct evlist *evlist)
>  			continue;
>  
>  		/* If there's mismatch disable the group and warn user. */
> -		WARN_ONCE(1, "WARNING: grouped events cpus do not match, disabling group:\n");
> -		evsel__group_desc(leader, buf, sizeof(buf));
> -		pr_warning("  %s\n", buf);
> -
> +		if (warned_leader != leader) {
> +			char buf[200];
> +
> +			pr_warning("WARNING: grouped events cpus do not match.\n"
> +				"Events with CPUs not matching the leader will "
> +				"be removed from the group.\n");
> +			evsel__group_desc(leader, buf, sizeof(buf));
> +			pr_warning("  %s\n", buf);
> +			warned_leader = leader;
> +		}
>  		if (verbose > 0) {
> +			char buf[200];
> +
>  			cpu_map__snprint(leader->core.cpus, buf, sizeof(buf));
>  			pr_warning("     %s: %s\n", leader->name, buf);
>  			cpu_map__snprint(evsel->core.cpus, buf, sizeof(buf));
>  			pr_warning("     %s: %s\n", evsel->name, buf);
>  		}
>  
> -		for_each_group_evsel(pos, leader)
> -			evsel__remove_from_group(pos, leader);
> +		evsel__remove_from_group(evsel, leader);
>  	}
>  }
>  
