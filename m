Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15BE170BC6F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 13:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbjEVLzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 07:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233565AbjEVLzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 07:55:35 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A289A8;
        Mon, 22 May 2023 04:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684756534; x=1716292534;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ge74hN4UAWGXQucKsiYH+Kd+5tVyCczo7n6QYfTirkY=;
  b=kbPIZNPGrHbXn0Ql7LP79jBW9NJrMzLscxX7g95d9qmPfha1o22yR0uy
   iI7YjsTD8UYITlrnkEYCdh52gXKchK0/2fYeZwx9UzIpgxZSObZsD+VkB
   ULb3ge/ZaXdTdrzhd8nRjoDPiZjoVM1DD0q7J9s1WJ5diqgMTVb/KMgOd
   LJ8Qt50pDWcuO5G+ntSNXX46IYa7IF1WdmZeex2Y9MyxRkGk3jbn+m9EV
   uaPX8LoAcLx7cHa3FyghFPs/XK5nI9dG7lRGbaehSG+Pe/cvo/fCKH1ZN
   3smAfm3unuI9zcDcSyeAO+GGWigZPVzP5XgaMJoTw8Pl/70sMBzQAxtg+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="337486835"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="337486835"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 04:55:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="950047509"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="950047509"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 22 May 2023 04:55:32 -0700
Received: from [10.209.7.94] (kliang2-mobl1.ccr.corp.intel.com [10.209.7.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 19AC3580919;
        Mon, 22 May 2023 04:55:29 -0700 (PDT)
Message-ID: <642c0b26-fcd8-8063-72d2-c74466c29785@linux.intel.com>
Date:   Mon, 22 May 2023 07:55:27 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1 05/23] perf pmu: Remove perf_pmu__hybrid_mounted
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
References: <20230517145803.559429-1-irogers@google.com>
 <20230517145803.559429-6-irogers@google.com>
 <1ea342ab-d68f-26e5-0043-f05b1886009e@linux.intel.com>
 <CAP-5=fU3OYNsjaJhLq_8tJXZKFARCTqrg3CEr64-3rAm_kTx+A@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fU3OYNsjaJhLq_8tJXZKFARCTqrg3CEr64-3rAm_kTx+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-05-22 1:21 a.m., Ian Rogers wrote:
> On Sun, May 21, 2023 at 12:23 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>>
>>
>> On 2023-05-17 10:57 a.m., Ian Rogers wrote:
>>> perf_pmu__hybrid_mounted is used to detect whether cpu_core or
>>> cpu_atom
>>
>> Currently, there are only two CPU types for a hybrid machine, core and
>> atom. But there may be more CPU types added later. Please see the CPUID
>> 1AH EAX enumeration in SDM VOL2. It has several reserved encodings for
>> CPU types. It's better not using the hardcode cpu_core/cpu_atom to
>> replace the perf_pmu__hybrid_mounted().
>>
>> Thanks,
>> Kan
> 
> This is covered by later patches. Specifically patches like:
> patch 7: perf pmu: Add is_core to pmu
> patch 20: Split pmus list into core and uncore
> 
> Ultimately in pmus.h we have two scan routines, one for all PMUs and
> one for core PMUs. For everything except hybrid (and the name varies a
> bit on ARM) the core scan only scans "cpu", on hybrid it scans
> "cpu_atom" and "cpu_core". The determination of core vs uncore is
> done without using the name, so can support >2 hybrid PMUs. At this
> point in the patch series I'm trying to simplify everything so that I
> can then build the pmus interface.

But if we add a new core type "cpu_whatever" later, we have to hardcode
the new name to the perf tool, right? Users have to update the perf tool
for the new platforms, otherwise I think the new type will be treated as
an uncore PMU.

Since the hybrid is Intel only, I think it may be better move the
is_pmu_hybrid() to X86 specifc code. For the Intel only code, we already
have a naming rule for the hybrid name, "cpu_$". So we don't need to
update the tool for every new CPU type.

Thanks,
Kan

> 
> Thanks,
> Ian
> 
>>> is mounted with a non-empty cpus file by
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
>>> index 1e0be23d4dd7..729b1f166f80 100644
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
>>> @@ -898,6 +895,16 @@ static int pmu_max_precise(int dirfd, struct perf_pmu *pmu)
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
>>> +}
>>> +
>>>  static struct perf_pmu *pmu_lookup(int dirfd, const char *lookup_name)
>>>  {
>>>       struct perf_pmu *pmu;
>>> @@ -905,15 +912,8 @@ static struct perf_pmu *pmu_lookup(int dirfd, const char *lookup_name)
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
>>> @@ -933,8 +933,10 @@ static struct perf_pmu *pmu_lookup(int dirfd, const char *lookup_name)
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
>>> @@ -964,7 +966,7 @@ static struct perf_pmu *pmu_lookup(int dirfd, const char *lookup_name)
>>>       list_splice(&aliases, &pmu->aliases);
>>>       list_add_tail(&pmu->list, &pmus);
>>>
>>> -     if (is_hybrid)
>>> +     if (!strcmp(name, "cpu_core") || !strcmp(name, "cpu_atom"))
>>>               list_add_tail(&pmu->hybrid_list, &perf_pmu__hybrid_pmus);
>>>       else
>>>               INIT_LIST_HEAD(&pmu->hybrid_list);
