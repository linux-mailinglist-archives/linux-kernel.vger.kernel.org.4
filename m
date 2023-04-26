Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7FF06EFD0D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 00:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239925AbjDZWHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 18:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239759AbjDZWHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 18:07:42 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489D530C2;
        Wed, 26 Apr 2023 15:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682546859; x=1714082859;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=F8xnRKcvkulOCXR731N/Cj9LCIQ/8Q2g3riEynMCITM=;
  b=CuPcslePIIkpJLMqGKmTZFaT712dtNnSbrS8b0GaGv/NiHXALJ2BK9qq
   O0zuQCLsPSpm/LcC9RMgHP+7Wr3Q0Hw9FlcwHBRpa5ayKhol/26bykzXX
   eQU5pOEDvhHoPA8DZgE+wYKnW22F3x66I8M5UK8b8jGUKZhZQEUpQwYco
   q2xBMByQ79k5sQBxlaWkhHEFiV0owAfG7wUzi3DBezJa+DocLtIn2BsZS
   khY72xgcMBZFUCAbkzXIov7pYIcEPyJi+6f/jajSeSnysK8l/diwp4GLw
   uVmbEPtE+EdyYKEb614rioFquwo6fW0JHNiLFjDwBq/i8ieV988EuHUyq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="344698743"
X-IronPort-AV: E=Sophos;i="5.99,229,1677571200"; 
   d="scan'208";a="344698743"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 15:07:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="783486249"
X-IronPort-AV: E=Sophos;i="5.99,229,1677571200"; 
   d="scan'208";a="783486249"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Apr 2023 15:07:37 -0700
Received: from [10.209.103.254] (kliang2-mobl1.ccr.corp.intel.com [10.209.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 22711580C9A;
        Wed, 26 Apr 2023 15:07:34 -0700 (PDT)
Message-ID: <44b8d51d-c4a3-3774-6b87-b853a5a7dec0@linux.intel.com>
Date:   Wed, 26 Apr 2023 18:07:32 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1 00/40] Fix perf on Intel hybrid CPUs
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>
Cc:     Ahmad Yasin <ahmad.yasin@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Weilin Wang <weilin.wang@intel.com>,
        Edward Baker <edward.baker@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Rob Herring <robh@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        Yang Jihong <yangjihong1@huawei.com>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230426070050.1315519-1-irogers@google.com>
 <ZEmTEHh0A6Uvy/k+@kernel.org> <ZEmYkDPgdKXWM+/e@kernel.org>
Content-Language: en-US
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <ZEmYkDPgdKXWM+/e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-04-26 5:33 p.m., Arnaldo Carvalho de Melo wrote:
> Em Wed, Apr 26, 2023 at 06:09:36PM -0300, Arnaldo Carvalho de Melo escreveu:
>> Em Wed, Apr 26, 2023 at 12:00:10AM -0700, Ian Rogers escreveu:
>>> TL;DR: hybrid doesn't crash, json metrics work on hybrid on both PMUs
>>> or individually, event parsing doesn't always scan all PMUs, more and
>>> new tests that also run without hybrid, less code.
>>>
>>> The first patches were previously posted to improve metrics here:
>>> "perf stat: Introduce skippable evsels"
>>> https://lore.kernel.org/all/20230414051922.3625666-1-irogers@google.com/
>>> "perf vendor events intel: Add xxx metric constraints"
>>> https://lore.kernel.org/all/20230419005423.343862-1-irogers@google.com/
>>>
>>> Next are some general test improvements.
>>
>> Kan,
>>
>> 	Have you looked at this? I'm doing a test build on it now.
> 
> And just to make clear, this is for v6.5.
>

I'm looking at the patch series, but I cannot finish all the reviews
today. I will try to finish it tomorrow.

But there is one obvious bug with this series.
The topdown events of atom are duplicated. The below is just an example.
Almost all the atom Topdown events in the examples have such issue.

> $ perf stat --cputype=atom -M TopdownL1 -a sleep 1
> 
>  Performance counter stats for 'system wide':
> 
>            645,836      cpu_atom/TOPDOWN_RETIRING.ALL/   #     26.4 %  tma_bad_speculation    
>          2,404,468      cpu_atom/TOPDOWN_FE_BOUND.ALL/   #     38.9 %  tma_frontend_bound     
>          1,455,604      cpu_atom/TOPDOWN_BE_BOUND.ALL/   #     23.6 %  tma_backend_bound      
>                                                   #     23.6 %  tma_backend_bound_aux  
>          1,235,109      cpu_atom/CPU_CLK_UNHALTED.CORE/  #     10.4 %  tma_retiring           
>            642,124      cpu_atom/TOPDOWN_RETIRING.ALL/                                        
>          2,398,892      cpu_atom/TOPDOWN_FE_BOUND.ALL/                                        
>          1,503,157      cpu_atom/TOPDOWN_BE_BOUND.ALL/                                  



Thanks,
Kan

