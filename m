Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814E76A8A3C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 21:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjCBU27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 15:28:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjCBU25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 15:28:57 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BC816302;
        Thu,  2 Mar 2023 12:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677788936; x=1709324936;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/35HLiyYDFX+fShhJBDjECK1Nl4glfMnbm8AmHi0kt8=;
  b=Xls+RxrjDE/j1W8nVAoa40Yv3OzVTynM8glLm5OUA/bLHHnygXzSLSlS
   MLU5ahXBnuF3wDlvPymFo6cDPWSQpTpiwJLZAKL0wprcUcuhepPsjp7lk
   RtdMLCvwkVg7wiJhg//DdzsDow3zanptc5DqDFvQq9eu8Rbx+iaEBK4ra
   8EiacVWisdeiQBozwWl46k2xJyZezPpu+JKRZBPlJPMyY6zKEPTzNK4H8
   MTzX0uxPZd0Gqr7QpRqGGhM8/9+0cfwdN5XI+8xc+1ocmGgIq6JnHfuy5
   zgG01D1/R86IQvmIWj3/N3cC+4//I5DhMrrV6jJEmeBVpbHoAoKkpe24T
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="332327514"
X-IronPort-AV: E=Sophos;i="5.98,228,1673942400"; 
   d="scan'208";a="332327514"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 12:28:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="764158004"
X-IronPort-AV: E=Sophos;i="5.98,228,1673942400"; 
   d="scan'208";a="764158004"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Mar 2023 12:28:54 -0800
Received: from [10.209.43.74] (kliang2-mobl1.ccr.corp.intel.com [10.209.43.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 12148580689;
        Thu,  2 Mar 2023 12:28:51 -0800 (PST)
Message-ID: <fe88eb57-41bb-ab17-daa1-83a8cd3985b8@linux.intel.com>
Date:   Thu, 2 Mar 2023 15:28:48 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 05/10] perf evsel: Limit in group test to CPUs
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
References: <20230302041211.852330-1-irogers@google.com>
 <20230302041211.852330-6-irogers@google.com>
 <b7597055-5fb3-c253-f9b7-190d3daf105e@linux.intel.com>
 <CAP-5=fXkCqSz32zA0GvLV7cQ4Xcp=MQAE6sb06pNTZf4gsPtdg@mail.gmail.com>
Content-Language: en-US
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fXkCqSz32zA0GvLV7cQ4Xcp=MQAE6sb06pNTZf4gsPtdg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-03-02 2:38 p.m., Ian Rogers wrote:
> On Thu, Mar 2, 2023 at 7:24 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>>
>>
>> On 2023-03-01 11:12 p.m., Ian Rogers wrote:
>>> Don't just match on the event name, restict based on the PMU too.
>>>
>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>> ---
>>>  tools/perf/arch/x86/util/evsel.c | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/util/evsel.c
>>> index ea3972d785d1..580b0a172136 100644
>>> --- a/tools/perf/arch/x86/util/evsel.c
>>> +++ b/tools/perf/arch/x86/util/evsel.c
>>> @@ -61,6 +61,9 @@ bool arch_evsel__must_be_in_group(const struct evsel *evsel)
>>>       if (!evsel__sys_has_perf_metrics(evsel))
>>>               return false;
>>>
>>> +     if (evsel->pmu_name && strncmp(evsel->pmu_name, "cpu", 3))
>>> +             return false;
>>
>> I'm not sure why we want to check the pmu name. It seems better to move
>> it into evsel__sys_has_perf_metrics(), since perf_metrics is a core PMU
>> only feature.
>>
>> I think the strncmp(evsel->pmu_name, "cpu", 3) is to check whether it is
>> a core PMU. It is also used in other places. I think it's better to
>> factor out it, e.g., arch_evsel__is_core_pmu(). It will deliver a clear
>> message of what we are doing here.
>>
>> Thanks,
>> Kan
> 
> I missed the behavior of evsel__sys_has_perf_metrics and think we can
> just drop this change.

Yes, dropping the change is also OK for me.

> We should probably rename
> evsel__sys_has_perf_metrics perhaps something like
> arch_evsel__pmu_has_topdown_events.

The topdown is a tricky feature. For the big core, to support the
topdown events, we have a dedicated perf metrics register, which has to
be grouped with the fixed counter 3. That brings all of these troubles.
Sorry for that.
For the atom, the topdown events are still supported, but with GP
counters. There is no perf metrics register at all.

The evsel__sys_has_perf_metrics() is used to check whether the perf
metrics register is supported. If so, we have to specially handle it.
It's not to check whether the topdown events are supported. So I think
it's better to keep the perf_metrics name, rather than topdown_events.

Thanks,
Kan
> 
> Thanks,
> Ian
> 
>>> +
>>>       return evsel->name &&
>>>               (strcasestr(evsel->name, "slots") ||
>>>                strcasestr(evsel->name, "topdown"));
