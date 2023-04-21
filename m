Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6061D6EABB8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 15:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbjDUNc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 09:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbjDUNcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 09:32:25 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE015FEB;
        Fri, 21 Apr 2023 06:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682083944; x=1713619944;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NtyfpIlTv6Ni+PZyZAPunQZ3Tw6PSQnyx4LyiZxXNpw=;
  b=RpWn5CUZisYIfD6F7szy+wL1lFAMjz9Tgs29xyPNWzW476RR5ZPaZqAs
   H7FXI86iF754+PW82vwOgeFk66XrtddGXrfAJBUZmFTUoJfdR8ECkxhCd
   1VFTA4ybRjg1noUNDlH6FpeLoh0dn0BeA4nRHOEOlic1wdAbD1XoXv7q8
   TTPkQvdHbg5kj05rRQl6jp1tT1QwVHlhaQ4KizOPYBQyjo9FEDyouxVNQ
   N0hzG1AZfnhgmy0kw3PaboFY1AIpb0uByrSKC7hFk3ys2a6smBEe/w5Jo
   an+sfEFXaQHVjnmcQzWxPO5X3hjv+Dhx2uKtTTvcPJllLHACjqPMTNt9g
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="330189867"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="330189867"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 06:32:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="669725954"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="669725954"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 21 Apr 2023 06:32:23 -0700
Received: from [10.212.170.184] (kliang2-mobl1.ccr.corp.intel.com [10.212.170.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 20602580960;
        Fri, 21 Apr 2023 06:32:21 -0700 (PDT)
Message-ID: <7836c3c0-75bb-7c66-d6b1-ee6ff1201117@linux.intel.com>
Date:   Fri, 21 Apr 2023 09:32:19 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] perf stat: Introduce skippable evsels
To:     Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Yasin, Ahmad" <ahmad.yasin@intel.com>,
        "Taylor, Perry" <perry.taylor@intel.com>,
        "Alt, Samantha" <samantha.alt@intel.com>,
        "Biggers, Caleb" <caleb.biggers@intel.com>,
        "Wang, Weilin" <weilin.wang@intel.com>,
        Edward <edward.baker@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230414051922.3625666-1-irogers@google.com>
 <d1fe801a-22d0-1f9b-b127-227b21635bd5@linux.intel.com>
 <CAP-5=fXCmKAUn24r0YYHaO63mabZCXae-hAT2WCtk+YYmvS9xg@mail.gmail.com>
 <99150cb1-fe50-97cf-ad80-cceb9194eb9a@linux.intel.com>
 <CAP-5=fXZSACj=kGM5t3pBHkQ-W1i0eJayAQ77_ToEp4zXWzJnw@mail.gmail.com>
 <ea899096-0599-f2a0-04a3-d90a3aa7d45d@linux.intel.com>
 <CAP-5=fVVFjKgUGV8zVurd99BOhASQ9mMaZqOyw13PYLhZWpsOA@mail.gmail.com>
 <CAP-5=fW_JwabjEUqSLaJn+tuHXLoyRWqJVVCh_z1dhXJ6On=MQ@mail.gmail.com>
 <84b19053-2e9f-5251-6816-26d2475894c0@linux.intel.com>
 <CAP-5=fWJKmo4eLKe9+=3pKGe7g+xfA+YxOz7AOgqLfcRNzNaLw@mail.gmail.com>
 <201a2ad6-3fb4-4b2a-d8a4-34d924e680c3@linux.intel.com>
 <CAP-5=fVWN5=URg0Og7KW7f7L4LSw6D8ghOKjP7La=0c+MkXFCg@mail.gmail.com>
 <2b8768bf-de24-946f-62da-6ed171a5c324@linux.intel.com>
 <CAP-5=fU9WeBga_tQKi6QKX1-t=C1w5CoPc8Rn9myR=1CxeQuMg@mail.gmail.com>
 <46508ba1-6bd5-a28e-5ae8-bc69a679b2c5@linux.intel.com>
 <CAP-5=fWeBN0gzCzk3_gh=bd_H+q5B+1KqofG5q-JGTaFk7akog@mail.gmail.com>
Content-Language: en-US
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fWeBN0gzCzk3_gh=bd_H+q5B+1KqofG5q-JGTaFk7akog@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-04-20 8:19 p.m., Ian Rogers wrote:
>>>>                         struct evlist *metric_evlist = evlist__new();
>>>>                         struct evsel *metric_evsel;
>>>>
>>>> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
>>>> index 6b46bbb3d322..072fa56744b4 100644
>>>> --- a/tools/perf/util/stat-display.c
>>>> +++ b/tools/perf/util/stat-display.c
>>>> @@ -747,7 +747,7 @@ static void uniquify_event_name(struct evsel *counter)
>>>>         int ret = 0;
>>>>
>>>>         if (counter->uniquified_name || counter->use_config_name ||
>>>> -           !counter->pmu_name || !strncmp(counter->name, counter->pmu_name,
>>>> +           !counter->pmu_name || !counter->name ||
>>>> !strncmp(counter->name, counter->pmu_name,
>>>>                                            strlen(counter->pmu_name)))
>>>>                 return;
>>>
>>> Is this a pre-existing hybrid bug? It is a real shame hybrid shows so
>>> few common code paths. In general evsel__name should be preferred over
>>> directly accessing name.
>>
>>
>> I don't think so.
>>
>> I haven't dig into the bug yet. But from the source code I can tell that
>> the check is the same as the current 6.3-rc7.
>>
>> For the current 6.3-rc7, perf stat true works.
>> The perf stat -M TopdownL1 --metric-no-group can work as well.
>>
>> But with the current perf-tools-next branch, perf stat true gives a
>> Segmentation fault.
>>
>> The TopdownL1 doesn't work either.
>>
>> # ./perf stat -M TopdownL1 --metric-no-group
>> Error:
>> The sys_perf_event_open() syscall returned with 22 (Invalid argument)
>> for event (topdown-retiring).
>> /bin/dmesg | grep -i perf may provide additional information.
> 
> I see hybrid failing basic sanity tests both for 6.3 and in
> perf-tools-next. For metrics I see:
> 
> ```
> $ git status
> ...
> Your branch is up to date with 'linus/master'
> ...
> $ git describe
> v6.3-rc7-139-gb7bc77e2f2c7
> $ sudo perf stat -M TopdownL1 -a sleep 1

Try the --metric-no-group.


> WARNING: events in group from different hybrid PMUs!
> WARNING: grouped events cpus do not match, disabling group:
>  anon group { topdown-retiring, topdown-retiring,
> INT_MISC.UOP_DROPPING, topdown-fe-bound, topdown-fe-bound,
> CPU_CLK_UNHALTED.CORE, topdown-be-bound, topdown-be-bound,
> topdown-bad-spec, topdown-bad-spec }
> Error:
> The sys_perf_event_open() syscall returned with 22 (Invalid argument)
> for event (topdown-retiring).
> /bin/dmesg | grep -i perf may provide additional information.
> ```
> 
> It seems perf on hybrid is quite broken in 6.3, but I doubt we can fix
> 6.3 given the late stage of the release cycle. As perf-tools-next
> enables TopdownL1 metrics when no events or metric are specified and
> when the metric group is present, on hybrid this will cause the
> pre-existing bug to appear for the no events/metrics case. I suspect
> this is the cause of the crashes you see, but I'm seeing assertion
> failures and similar as I'm using a debug build.
> 
> I'm looking into fixing perf-tools-next and not 6.3. Maybe there will
> be something we can cherry-pick back to fix up 6.3. It hasn't been
> easy to find hardware to test on, and if the machine I'm remotely
> using falls over then I have no means to test, so fingers crossed.
> 

OK. So the json metric thing is buggy on both 6.3 and perf-tools-next. I
think it is even worse in the perf-tools-next.
Besides the bugs, the json metric also changes the output layout of perf
stat default. The tools, which are on top of perf, are all impacted.

The question is why we are in such a rush to move the default of perf
stat from reliable kernel metric to json metric?

Can we take a step back? Create a perf/json_metric or whatever branch,
fix all the issues thoroughly, and then merge to the mainline.

I think the default of perf stat is frequently used by not only the
newbees but also the veterans. That could have a big user-visible impact.

The 6.4 merge window is approaching. Can we at least revert the patches
for 6.4?

Arnaldo, what do you think?

Thanks,
Kan
