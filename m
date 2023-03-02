Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBCC6A8517
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 16:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjCBPY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 10:24:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjCBPYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 10:24:48 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA1A1350E;
        Thu,  2 Mar 2023 07:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677770687; x=1709306687;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sHhS4es0ZL2xLflWj+T1KpsJTA6n23t6uZ98L21famI=;
  b=D+95UeL4J+pxqgWSmRvXmpgYBQ8Pw/kxwDFzXERnRoJXuJpmhVKLRyv7
   FkJdy/zJ8AWlsvFzpkb87kV5QfO56Btq2+v2xo0ag7DKzS4QFRHF6Gys7
   ieaN58WrB1pnuyAUSbCaoPAlXkhoKGvV5JXsu/Wu0dH2FnakVbU6stg8I
   SALGM3NicLF9osMREWYa2N9zwGLhCM0GRwgaanoWolbnHW7L3H2VLpH0o
   1oaRNvTb6CeewdEkkpFhj/rHhPc+FfjjkRilHW6feAzhPhHT5Cb29aVv8
   ZMDYa/F1C6EtU2jxrihEfIpLIG354053bKmZmZdh6q3xEsiVpFR4VrvwP
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="315166531"
X-IronPort-AV: E=Sophos;i="5.98,228,1673942400"; 
   d="scan'208";a="315166531"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 07:24:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="668284410"
X-IronPort-AV: E=Sophos;i="5.98,228,1673942400"; 
   d="scan'208";a="668284410"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 02 Mar 2023 07:24:46 -0800
Received: from [10.209.9.110] (kliang2-mobl1.ccr.corp.intel.com [10.209.9.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 4B4B2580689;
        Thu,  2 Mar 2023 07:24:44 -0800 (PST)
Message-ID: <b7597055-5fb3-c253-f9b7-190d3daf105e@linux.intel.com>
Date:   Thu, 2 Mar 2023 10:24:42 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 05/10] perf evsel: Limit in group test to CPUs
Content-Language: en-US
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
        Qi Liu <liuqi115@huawei.com>,
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
References: <20230302041211.852330-1-irogers@google.com>
 <20230302041211.852330-6-irogers@google.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230302041211.852330-6-irogers@google.com>
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



On 2023-03-01 11:12 p.m., Ian Rogers wrote:
> Don't just match on the event name, restict based on the PMU too.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/arch/x86/util/evsel.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/util/evsel.c
> index ea3972d785d1..580b0a172136 100644
> --- a/tools/perf/arch/x86/util/evsel.c
> +++ b/tools/perf/arch/x86/util/evsel.c
> @@ -61,6 +61,9 @@ bool arch_evsel__must_be_in_group(const struct evsel *evsel)
>  	if (!evsel__sys_has_perf_metrics(evsel))
>  		return false;
>  
> +	if (evsel->pmu_name && strncmp(evsel->pmu_name, "cpu", 3))
> +		return false;

I'm not sure why we want to check the pmu name. It seems better to move
it into evsel__sys_has_perf_metrics(), since perf_metrics is a core PMU
only feature.

I think the strncmp(evsel->pmu_name, "cpu", 3) is to check whether it is
a core PMU. It is also used in other places. I think it's better to
factor out it, e.g., arch_evsel__is_core_pmu(). It will deliver a clear
message of what we are doing here.

Thanks,
Kan
> +
>  	return evsel->name &&
>  		(strcasestr(evsel->name, "slots") ||
>  		 strcasestr(evsel->name, "topdown"));
