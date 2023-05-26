Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA98712CFA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 21:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243724AbjEZTCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 15:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjEZTCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 15:02:03 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F11B135;
        Fri, 26 May 2023 12:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685127722; x=1716663722;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EQX2q4myVyRX8Tuplypnq4PBKR91Gq8qNgVy1wQnpDw=;
  b=AbzoyOs+Y1uoqO7u0GIaoRqU5s221X7PAeiiHp+CVpoGJMxzlcC1qyVJ
   gZx8CrCsOrNfz99jyWKKFUVW++HFwrRs7shFsuNds0MhWbs9ZNmIjFXGL
   meh/7O6R2JueSTOKQEWAEQcpsoqoIPP0ZW2qQWZ/2tv2OZlg7Ai/WyEyV
   Wl55cWAvV7f9fbjm4UmuJkNGkDiURydztCQG3UH97tFlf9VM+HRtbsjaY
   qfpic+k1HK9VOuxdsSin13GYO2CqC5WjBjEqcWeRSssj6MwgYA0a+Hwg/
   ar6QK4lspqUS0eU+EyQjwBJzvUXQCIWJdh7gAeyy6siEpWAvziYC+jYZ9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10722"; a="343774931"
X-IronPort-AV: E=Sophos;i="6.00,195,1681196400"; 
   d="scan'208";a="343774931"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2023 12:02:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10722"; a="738377098"
X-IronPort-AV: E=Sophos;i="6.00,195,1681196400"; 
   d="scan'208";a="738377098"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 26 May 2023 12:02:00 -0700
Received: from [10.209.100.85] (kliang2-mobl1.ccr.corp.intel.com [10.209.100.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 6FB3F580B9E;
        Fri, 26 May 2023 12:01:56 -0700 (PDT)
Message-ID: <f57394d7-c4ff-d125-d5d8-6af86ecd6bef@linux.intel.com>
Date:   Fri, 26 May 2023 15:01:54 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Subject: Re: [PATCH v3 16/35] perf pmu: Remove perf_pmu__hybrid_mounted
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ming Wang <wangming01@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        Ali Saidi <alisaidi@amazon.com>, Rob Herring <robh@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
References: <20230524221831.1741381-1-irogers@google.com>
 <20230524221831.1741381-17-irogers@google.com>
 <3d943607-645e-be8d-3a68-90e62e402c3d@linux.intel.com>
 <CAP-5=fWJXthOUF+ma1Z+MT2yfpA81did=-0hA3tREvAqNoAzww@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fWJXthOUF+ma1Z+MT2yfpA81did=-0hA3tREvAqNoAzww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-05-26 2:33 p.m., Ian Rogers wrote:
> On Fri, May 26, 2023 at 11:14 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>>
>>
>> On 2023-05-24 6:18 p.m., Ian Rogers wrote:
>>> perf_pmu__hybrid_mounted is used to detect whether cpu_core or
>>> cpu_atom is mounted with a non-empty cpus file by
>>> pmu_lookup. pmu_lookup will attempt to read the cpus file too and so
>>> the check can be folded into this.
>>>
>>> Checking hybrid_mounted in pmu_is_uncore is redundant as the next
>>> cpumask read will fail returning false.
>>>
>>> Reduce the scope of perf_pmu__find_hybrid_pmu by making it static.
>>>
>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>> ---
>>>  tools/perf/util/pmu-hybrid.c | 15 +--------------
>>>  tools/perf/util/pmu-hybrid.h |  3 ---
>>>  tools/perf/util/pmu.c        | 26 ++++++++++++++------------
>>>  3 files changed, 15 insertions(+), 29 deletions(-)
>>>
>>> diff --git a/tools/perf/util/pmu-hybrid.c b/tools/perf/util/pmu-hybrid.c
>>> index bc4cb0738c35..7fe943dd3217 100644
>>> --- a/tools/perf/util/pmu-hybrid.c
>>> +++ b/tools/perf/util/pmu-hybrid.c
>>> @@ -18,20 +18,7 @@
>>>
>>>  LIST_HEAD(perf_pmu__hybrid_pmus);
>>>
>>> -bool perf_pmu__hybrid_mounted(const char *name)
>>> -{
>>> -     int cpu;
>>> -     char pmu_name[PATH_MAX];
>>> -     struct perf_pmu pmu = {.name = pmu_name};
>>> -
>>> -     if (strncmp(name, "cpu_", 4))
>>> -             return false;
>>> -
>>> -     strlcpy(pmu_name, name, sizeof(pmu_name));
>>> -     return perf_pmu__scan_file(&pmu, "cpus", "%u", &cpu) > 0;
>>> -}
>>> -
>>> -struct perf_pmu *perf_pmu__find_hybrid_pmu(const char *name)
>>> +static struct perf_pmu *perf_pmu__find_hybrid_pmu(const char *name)
>>>  {
>>>       struct perf_pmu *pmu;
>>>
>>> diff --git a/tools/perf/util/pmu-hybrid.h b/tools/perf/util/pmu-hybrid.h
>>> index 206b94931531..8dbcae935020 100644
>>> --- a/tools/perf/util/pmu-hybrid.h
>>> +++ b/tools/perf/util/pmu-hybrid.h
>>> @@ -13,9 +13,6 @@ extern struct list_head perf_pmu__hybrid_pmus;
>>>  #define perf_pmu__for_each_hybrid_pmu(pmu)   \
>>>       list_for_each_entry(pmu, &perf_pmu__hybrid_pmus, hybrid_list)
>>>
>>> -bool perf_pmu__hybrid_mounted(const char *name);
>>> -
>>> -struct perf_pmu *perf_pmu__find_hybrid_pmu(const char *name);
>>>  bool perf_pmu__is_hybrid(const char *name);
>>>
>>>  static inline int perf_pmu__hybrid_pmu_num(void)
>>> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
>>> index cd94abe7a87a..e9f3e6a777c0 100644
>>> --- a/tools/perf/util/pmu.c
>>> +++ b/tools/perf/util/pmu.c
>>> @@ -617,9 +617,6 @@ static bool pmu_is_uncore(int dirfd, const char *name)
>>>  {
>>>       int fd;
>>>
>>> -     if (perf_pmu__hybrid_mounted(name))
>>> -             return false;
>>> -
>>>       fd = perf_pmu__pathname_fd(dirfd, name, "cpumask", O_PATH);
>>>       if (fd < 0)
>>>               return false;
>>> @@ -900,6 +897,16 @@ static int pmu_max_precise(int dirfd, struct perf_pmu *pmu)
>>>       return max_precise;
>>>  }
>>>
>>> +/**
>>> + * perf_pmu__skip_empty_cpus() - should pmu_lookup skip the named PMU if the
>>> + *      cpus or cpumask file isn't present?
>>> + * @name: Name of PMU.
>>> + */
>>> +static bool perf_pmu__skip_empty_cpus(const char *name)
>>> +{
>>> +     return !strcmp(name, "cpu_core") || !strcmp(name, "cpu_atom");
>>
>> Can we use the below to replace?
>> return !strncmp(name, "cpu_", 4);
>>
>> Otherwise, anytime a new core PMU name is introduced, I have to patch
>> the function.
> 
> I dislike this function but was carrying it forward, I think we can
> get rid of it. The point of erroring is to not have core PMUs when
> there are no online CPUs associated with it. For existing core PMUs
> this just isn't something that can happen as otherwise what CPU are
> you running on. For hybrid it can happen and we know we care because
> the PMU's type is core. 

For hybrid, I think it can only happen when there is a kernel bug, e.g.,
a new core PMU is added but forgets to set the CPU mask.

> So why not change the error to be when the cpu
> map is empty and the CPU is core?

I don't think PT has cpu map. Other PMUs, e.g., msr, don't have cpu map
either. They are not core PMU.

Actually, I'm OK with just removing the function. Maybe we can add a
test to check the CPU mask on hybrid. If it doesn't exist, it should be
a bug of perf.

Thanks,
Kan

> I'm going to assume that my logic is
> sound and change the code in v4, but please complain.
> 
> Thanks,
> Ian
> 
>> Thanks,
>> Kan
>>
>>> +}
>>> +
>>>  static struct perf_pmu *pmu_lookup(int dirfd, const char *lookup_name)
>>>  {
>>>       struct perf_pmu *pmu;
>>> @@ -907,15 +914,8 @@ static struct perf_pmu *pmu_lookup(int dirfd, const char *lookup_name)
>>>       LIST_HEAD(aliases);
>>>       __u32 type;
>>>       char *name = pmu_find_real_name(lookup_name);
>>> -     bool is_hybrid = perf_pmu__hybrid_mounted(name);
>>>       char *alias_name;
>>>
>>> -     /*
>>> -      * Check pmu name for hybrid and the pmu may be invalid in sysfs
>>> -      */
>>> -     if (!strncmp(name, "cpu_", 4) && !is_hybrid)
>>> -             return NULL;
>>> -
>>>       /*
>>>        * The pmu data we store & need consists of the pmu
>>>        * type value and format definitions. Load both right
>>> @@ -935,8 +935,10 @@ static struct perf_pmu *pmu_lookup(int dirfd, const char *lookup_name)
>>>               return NULL;
>>>
>>>       pmu->cpus = pmu_cpumask(dirfd, name);
>>> -     pmu->name = strdup(name);
>>> +     if (!pmu->cpus && perf_pmu__skip_empty_cpus(name))
>>> +             goto err;
>>>
>>> +     pmu->name = strdup(name);
>>>       if (!pmu->name)
>>>               goto err;
>>>
>>> @@ -967,7 +969,7 @@ static struct perf_pmu *pmu_lookup(int dirfd, const char *lookup_name)
>>>       list_splice(&aliases, &pmu->aliases);
>>>       list_add_tail(&pmu->list, &pmus);
>>>
>>> -     if (is_hybrid)
>>> +     if (!strcmp(name, "cpu_core") || !strcmp(name, "cpu_atom"))
>>>               list_add_tail(&pmu->hybrid_list, &perf_pmu__hybrid_pmus);
>>>       else
>>>               INIT_LIST_HEAD(&pmu->hybrid_list);
