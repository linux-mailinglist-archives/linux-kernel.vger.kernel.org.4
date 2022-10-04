Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA5925F487C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 19:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbiJDRab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 13:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiJDRaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 13:30:07 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE25C6610D;
        Tue,  4 Oct 2022 10:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664904560; x=1696440560;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cZwt9C3hI0uiDJLCxjpvciMF76PTSjjppjN+6iEqy2s=;
  b=h7A36NJ7gyiKhV6SZ1Jqy3SNT+cGIvBKuSKKcJMGvfoDvGFXN27FQwuE
   xTxi0qtyVn+1gtuu1uhzGnpUNzN8Ii8HzqBf0qYC2LYElPcKIVjUY/jbi
   SdCggJGM4J64MCTtN9ZGjkX4ODpKmgVMfujRoa8UqbmyS3C8Ethar/GGP
   wA4cA79Wh0jz6LNHxU/vogM9Jb1j7to1lk5i3CUSwHtL17kKMeDUhEvWF
   dgKYFrNLcdpb2ouJPn0zT71aNjl4TyUE8drL3itBOmLk8mems1Vl8on2t
   MIPYebQjdKHq7xWiAhtNleYWJ9dlRwZh0Kr1612eyUPeOoO+8sAov1CKI
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="282685647"
X-IronPort-AV: E=Sophos;i="5.95,158,1661842800"; 
   d="scan'208";a="282685647"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 10:28:53 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="624011508"
X-IronPort-AV: E=Sophos;i="5.95,158,1661842800"; 
   d="scan'208";a="624011508"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.241.236.94]) ([10.241.236.94])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 10:28:53 -0700
Message-ID: <677c6ec7-2e01-635b-dbfb-fbb9280e5b7c@linux.intel.com>
Date:   Tue, 4 Oct 2022 10:28:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v3 00/23] Improvements to Intel perf metrics
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>, perry.taylor@intel.com,
        caleb.biggers@intel.com, kshipra.bopardikar@intel.com,
        samantha.alt@intel.com, ahmad.yasin@intel.com,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>
References: <20221004021612.325521-1-irogers@google.com>
 <CAP-5=fXk6sLhZsEs72G4pOuZNzDJLc2Vkkvf+Jv=LXQDHPy8-w@mail.gmail.com>
From:   Andi Kleen <ak@linux.intel.com>
In-Reply-To: <CAP-5=fXk6sLhZsEs72G4pOuZNzDJLc2Vkkvf+Jv=LXQDHPy8-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[cutting down cc list]


On 10/3/2022 8:43 PM, Ian Rogers wrote:
> On Mon, Oct 3, 2022 at 7:16 PM Ian Rogers <irogers@google.com> wrote:
>> For consistency with:
>> https://github.com/intel/perfmon-metrics
>> rename of topdown TMA metrics from Frontend_Bound to tma_frontend_bound.
>>
>> Remove _SMT suffix metrics are dropped as the #SMT_On and #EBS_Mode
>> are correctly expanded in the single main metric. Fix perf expr to
>> allow a double if to be correctly processed.
>>
>> Add all 6 levels of TMA metrics. Child metrics are placed in a group
>> named after their parent allowing children of a metric to be
>> easily measured using the metric name with a _group suffix.
>>
>> Don't drop TMA metrics if they contain topdown events.
>>
>> The ## and ##? operators are correctly expanded.
>>
>> The locate-with column is added to the long description describing a
>> sampling event.
>>
>> Metrics are written in terms of other metrics to reduce the expression
>> size and increase readability.
>>
>> Following this the pmu-events/arch/x86 directories match those created
>> by the script at:
>> https://github.com/intel/event-converter-for-linux-perf/blob/master/download_and_gen.py
>> with updates at:
>> https://github.com/captain5050/event-converter-for-linux-perf
>>
>>
>> v3. Fix a parse metrics test failure due to making metrics referring
>>      to other metrics case sensitive - make the cases in the test
>>      metric match.
>> v2. Fixes commit message wrt missing mapfile.csv updates as noted by
>>      Zhengjun Xing <zhengjun.xing@linux.intel.com>. ScaleUnit is added
>>      for TMA metrics. Metrics with topdown events have have a missing
>>      slots event added if necessary. The latest metrics at:
>>      https://github.com/intel/perfmon-metrics are used, however, the
>>      event-converter-for-linux-perf scripts now prefer their own
>>      metrics in case of mismatched units when a metric is written in
>>      terms of another.  Additional testing was performed on broadwell,
>>      broadwellde, cascadelakex, haswellx, sapphirerapids and tigerlake
>>      CPUs.
> I wrote up a little example of performing a top-down analysis for the
> perf wiki here:
> https://perf.wiki.kernel.org/index.php/Top-Down_Analysis


I did some quick testing.

On Skylake the output of L1 isn't scaled to percent:

$ ./perf stat -M TopdownL1 ~/pmu/pmu-tools/workloads/BC1s

  Performance counter stats for '/home/ak/pmu/pmu-tools/workloads/BC1s':

        608,066,701      INT_MISC.RECOVERY_CYCLES         # 0.32 
Bad_Speculation          (50.02%)
      5,364,230,382      CPU_CLK_UNHALTED.THREAD          # 0.48 
Retiring                 (50.02%)
     10,194,062,626 UOPS_RETIRED.RETIRE_SLOTS (50.02%)
     14,613,100,390 UOPS_ISSUED.ANY (50.02%)
      2,928,793,077      IDQ_UOPS_NOT_DELIVERED.CORE      # 0.14 
Frontend_Bound
                                                   #     0.07 
Backend_Bound            (50.02%)
        604,850,703 INT_MISC.RECOVERY_CYCLES (50.02%)
      5,357,291,185 CPU_CLK_UNHALTED.THREAD (50.02%)
     14,618,285,580 UOPS_ISSUED.ANY (50.02%)

Then if I follow the wiki example here I would expect I need to do

$ ./perf stat -M tma_backend_bound_group ~/pmu/pmu-tools/workloads/BC1s

Cannot find metric or group `tma_backend_bound_group'

but tma_retiring_group doesn't exist. So it seems the methodology isn't 
fully consistent everywhere? Perhaps the wiki needs to document the 
supported CPUs and also what part of the hierarchy is supported.

Another problem I noticed in the example is that the sample event didn't 
specify PEBS, even though it probably should at least on Icelake+ where 
every event can be used with less over with PEBS.

Also with all these groups that need to be specified by hand some bash 
completion support for groups would be really useful)

-Andi


